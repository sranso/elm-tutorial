import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import String exposing (..)
import Regex exposing (..)


main =
  App.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
  }


model : Model
model =
  Model "" "" "" ""


-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      { model | age = age }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type' "age", placeholder "Age", onInput Age ] []
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let

  -- CHECK IF AGE IS AN INT
    (ageColor, ageMessage) =
      if True then
        ("green", model.age)
      else
        ("red", model.age)

    (color, message) =

   -- PASSWORDS HAVE UPPER CASE, LOWER CASE, AND NUMERIC CHARACTERS
   -- if contains (regex "\\W+") model.password then
      if Regex.contains (regex "[A-Z]+") model.password then
   --  if Regex.contains (regex "[a-z]+") model.password then
   --  if Regex.contains (regex "[0-9]+") model.password then
        ("green", "OK")
      else
        ("red", "Password not interesting enough")

   -- PASSWORD LENGTH
   -- (color, message) =
   --   if length model.password > 8 then
   --     ("green", "OK")
   --   else
   --     ("red", "Password too short")

   -- PASSWORDS MATCH
   -- (color, message) =
   --   if model.password == model.passwordAgain then
   --     ("green", "OK")
   --   else
   --     ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message, text ageMessage ]
