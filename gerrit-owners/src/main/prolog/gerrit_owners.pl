:- package gerrit_owners.
'$init'.

:- public add_owner_approval/2.
:- public add_owner_approval/3.

add_owner_approval(In, Out) :-
  owner_path(Path),
  \+ owner_approved(Path),
  Out = [label('Owner-Approval', need(_)) | In],
  !.

add_owner_approval(In, Out) :- In = Out.

add_owner_approval(Users, In, Out) :-
  owner_path(Path),
  \+ owner_approved(Users, Path),
  Out = [label('Owner-Approval', need(_)) | In],
  !.

add_owner_approval(_, In, Out) :- In = Out.

owner_approved(Path) :-
  owner(Path, User),
  gerrit:commit_label(label('Code-Review', 2), User),
  !.

owner_approved(Users, Path) :-
  owner(Path, User),
  member(User, Users),
  !.

member(X, [X|_]).
member(X, [_|L]) :- member(X, L).
