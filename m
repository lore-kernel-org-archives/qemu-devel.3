Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC695EE3682
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 13:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqWV3-0002kI-CN; Thu, 12 Feb 2026 08:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vqWV1-0002jy-AU
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 08:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vqWUy-0008DF-7s
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 08:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770901966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3/x4HeV3V4+VJ6vSXiWggX8CFJDxxvTzNqFXsMKZkY=;
 b=HmWb15ARgxTPcN0i1EWTp1LX54nN1Cy+qZptBKYdHxVqg0nXYMDdvHR9CB17ar2CALGfBo
 SXxSYIzJgTXEfJhFFtSby0aYOEvJtHdPBySqIjRvxVNa7IBgvjLcrtJdo1+IUst9FAgP1Q
 sD+/DQ+H5ifc9LbzUyh0xNRiWcr2MQE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-_vxvytjiNXmbm6UxyxLhGQ-1; Thu,
 12 Feb 2026 08:12:44 -0500
X-MC-Unique: _vxvytjiNXmbm6UxyxLhGQ-1
X-Mimecast-MFC-AGG-ID: _vxvytjiNXmbm6UxyxLhGQ_1770901963
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 782071955D8B
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 13:12:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEC4330001B9
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 13:12:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5966821E692D; Thu, 12 Feb 2026 14:12:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] json-parser: replace with a push parser
In-Reply-To: <a31dca74-1ae8-428c-9ed8-315594afecbf@redhat.com> (Paolo
 Bonzini's message of "Mon, 9 Feb 2026 11:53:53 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-3-pbonzini@redhat.com>
 <87sebab6mr.fsf@pond.sub.org>
 <a31dca74-1ae8-428c-9ed8-315594afecbf@redhat.com>
Date: Thu, 12 Feb 2026 14:12:40 +0100
Message-ID: <87wm0iumuv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/9/26 10:36, Markus Armbruster wrote:
>>> +typedef struct JSONParserContext {
>>> +    Error *err;
>>> +    GQueue *stack;
>>=20
>> This tells us we have a stack of something, but not what the something
>> is.  Further down, we'll see what the something is.
>>=20
>> The commit message explains what the stack means.
>>=20
>> Worth a comment here?
>
> Yes, makes sense.
>
>> We know the stack is at most 1024 deep (MAX_NESTING).  Have you
>> considered using an array instead of GQueue?
>
> It'd be only 8K, but I preferred to keep MAX_NESTING hidden within=20
> json-streamer.c.  Not having bounds checking makes me a bit nervous=20
> about having fixed-size arrays.

Looks mostly harmless to me: there's exactly one spot where we push
something onto the stack, one where we pop, and one where we pop
everything.  We only ever look at the top of the stack.

> See more below about responsibility split between parser and streamer.
>
>>> +    va_list *ap;
>>> +} JSONParserContext;
>>> +
>>=20
>> Having to move struct definitions to headers is always a bit sad.  Could
>> this go into json-parser-int.h instead?
>
> No because it's embedded in JSONMessageParser, just like JSONLexer.  It=20
> was previously hidden only because the parser was created and destroyed=20
> after parentheses were balanced, but not doing that is kind of the whole=
=20
> story here. :)

I see.

To avoid putting private parser state in json-parser.h, we'd need to let
json_message_parser_init() allocate it dynamically.  Reasonable option,
but let's stay on target here.  We can always do it later.

[...]

>>> +typedef enum JSONParserState {
>>> +    AFTER_LCURLY,
>>> +    AFTER_LSQUARE,
>>> +    BEFORE_KEY,
>>> +    BEFORE_VALUE,
>>> +    END_OF_KEY,
>>> +    END_OF_VALUE,
>>> +} JSONParserState;
>>> +
>>> +typedef struct JSONParserStackEntry {
>>> +    /* A QString with the last parsed key, or a QList/QDict for the cu=
rrent container.  */
>>> +    QObject *partial;
>>> +
>>> +    /* Needed to distinguish whether the parser is waiting for a colon=
 or comma.  */
>>> +    JSONParserState state;
>> If the comment was 100% accurate, a bool would do.
>
> Hmm when I wrote I did think that a bool + the type of the top QObject wo=
uld do.  But really there are three cases that the top QObject does not dis=
tinguish:
>
> - "after opening bracket, closed parenthesis or next element accepted",
>
> - "after comma, next element required"
>
> - "after element, closed parenthesis or comma accepted"
>
> So, a bool would not be enough.  Will fix.
>
>>> +/* Note that entry->partial does *not* lose its reference count even i=
f value =3D=3D NULL.  */
>>> +static JSONParserStackEntry *pop_entry(JSONParserContext *ctxt, QObjec=
t **value)
>>> +{
>>> +    JSONParserStackEntry *entry =3D g_queue_pop_tail(ctxt->stack);
>>> +    if (value) {
>>> +        *value =3D entry->partial;
>>> +    }
>>> +    g_free(entry);
>>> +    return current_entry(ctxt);
>>> +}
>>=20
>> This is a rather peculiar function.  If you disagree, try writing a
>> contract for it :)
>
> Hmm... yes, better pull the "value =3D entry->partial" to the callers eve=
n=20
> if there are several of them.  The code is overall simpler.

That's what I figured.

>> The parser's interesting part follows.  The parser is a pushdown
>> automaton.  The pushdown automaton is coded in C.  On the one hand,
>> d'oh!  Of course it is.  On the other hand, it's hard to see the actual
>> automaton in C.  May I have a comment explaining state and state
>> transitions?  Perhaps we better start with an informal description,
>> discuss it, then distill the discussion into a comment.
>
> That was the purpose of the mysterious comment above.  If a mix between=20
> BNF and automaton is okay for you, it could be something like
>
> input :=3D value        -> END_OF_VALUE
>           END_OF_INPUT -> check stack is empty, return parsed value
>
> // entered on BEFORE_VALUE; after any of these rules are processed, the
> // parser has completed a QObject and is in the END_OF_VALUE state.

What do you mean by "after any of these rules are processed, ..."?

> //
> // When the parser reaches the END_OF_VALUE state, it examines the
> // top of the stack to see if it's coming from "input" (stack empty),
> // "array_items" (TOS is a QList) or "dict_pairs" (TOS is a QString; the
> // item below will be a QDict).  It then proceeds with the corresponding
> // actions, which will be one of:
> // - return parsed value
> // - add value to QList
> // - pop QString with the key, add key/value to the QDict

Forward references to array_items and dict_pairs.  Suggest to add a
suitable "below", or indicate the forward reference some other way.

>
> value :=3D literal       -> END_OF_VALUE
>        | '['            -> push empty QList -> AFTER_LSQUARE
>           after_lsquare -> END_OF_VALUE
>        | '{'            -> push empty QDict -> AFTER_LCURLY
>           after_lcurly  -> END_OF_VALUE
>
> // non-recursive values, entered on BEFORE_VALUE
> literal :=3D INTEGER   -> END_OF_VALUE
>       | FLOAT         -> END_OF_VALUE
>       | KEYWORD       -> END_OF_VALUE
>       | STRING        -> END_OF_VALUE
>       | INTERP        -> END_OF_VALUE
>
> // entered on AFTER_LSQUARE
> after_lsquare :=3D ']' -> pop completed QList -> END_OF_VALUE
>         | =CF=B5           -> BEFORE_VALUE
>           array_items -> END_OF_VALUE
>
> // entered on BEFORE_VALUE, with TOS being a QList
> array_items :=3D value   -> add value to QList -> END_OF_VALUE
>         (']'            -> pop completed QList -> END_OF_VALUE
>          | ','          -> BEFORE_VALUE
>            array_items) -> END_OF_VALUE
>
> // entered on AFTER_LCURLY
> after_lcurly :=3D '}'  -> pop completed QDict -> END_OF_VALUE
>         | =CF=B5           -> BEFORE_KEY
>           dict_pairs  -> END_OF_VALUE
>
> // entered on BEFORE_KEY, with TOS being a QDict
> dict_pairs :=3D STRING  -> push QString -> END_OF_KEY
>         ':'            -> BEFORE_VALUE
>         value          -> pop QString + add pair to QDict -> END_OF_VALUE
>         ('}'           -> pop completed QDict -> END_OF_VALUE
>          | ','         -> BEFORE_KEY
>            dict_pairs) -> END_OF_VALUE

The BNF part is everything but the -> ...  Easy enough.  However, I'm
not quite certain how to interpret the --> ...

The "// entered on STATE ..." I can read as assertion.

The text after "->" seems to be one ore more state / stack transitions.
Let me describe them in my own words to make sure I understand you.
Note that I had to also look at the source code to produce my
description.

-> STATE

   Set top stack entry's state to STATE.

-> push OBJ -> STATE

   Push (STATE, OBJ) onto the stack.

-> pop completed OBJ -> END_OF_VALUE

   Pop (_, OBJ) from the stack, set new top stack entry's state to
   END_OF_VALUE.  OBJ is the result of parsing non-terminal @value.

-> add value to QList -> END_OF_VALUE

   Append the result of parsing non-terminal @value to the top stack
   entry's QList.  Set the top stack entry's state to END_OF_VALUE.

-> pop QString + add pair to QDict -> END_OF_VALUE

   Pop (_, QString) from the stack, it's the key.  Its value is the
   result of parsing non-terminal value.  Store this key: value pair in
   the top stack entry's QDict.  Set the top stack entry's state to
   END_OF_VALUE.

Unsaid, but reasonably obvious: the result of parsing non-terminal
@value when it's not an array or object.

The structure of the stack isn't explicitly explained, but can be
extracted from the above.

Stack entry members @partial from bottom to top:

* a QList element for an unclosed '[',

* a QDict and a QString element for an unclosed '{', except the
  innermost one need not have a QString.  This is because the QString is
  on the stack only while we're parsing ':' value.

So, stack contents invariant:

    ( QList | QDict QString )* QDict?

I found the QString business somewhat confusing, probably because I
expected one stack entry per nesting level, and tossing that invalid
assumption took mental effort.

I figure we could have one stack entry per: add a const char *key member
to JSONParserStackEntry, non-null exactly when we have a QString sitting
on a QDict now.  We'd trade representable invalid state "QString
directly above non-QDict in the stack" for "QList stack entry has member
@key set".  Would be slightly more local.  Matter of taste, I guess.

More representable invalid state, as far as I can tell (observation, not
objection):

* a QList stack entry can only have state AFTER_LSQUARE, BEFORE_VALUE,
  END_OF_VALUE, never AFTER_LCURLY, BEFORE_KEY, END_OF_KEY

* a QDict stack entry can only have state AFTER_LCURLY, BEFORE_KEY,
  END_OF_VALUE, never AFTER_LSQUARE, BEFORE_VALUE, END_OF_KEY

* a QString stack entry can only have state BEFORE_VALUE and END_OF_KEY,
  never AFTER_LCURLY, AFTER_LSQUARE, BEFORE_VALUE, END_OF_VALUE.

Stack entries by @state instead of by @partial:

* AFTER_LCURLY: @partial is QDict

* AFTER_LSQUARE: @partial is QList

* BEFORE_KEY: @partial is QDict

* BEFORE_VALUE: @partial is QList or QString

* END_OF_KEY: @partial is QString

* END_OF_VALUE: @partial is QList or QString

Invariants worth documenting, I think.

Here's my attempt at explaining the automaton and how states and stack
fit together: annotated JSON syntax diagrams.  The diagrams are from
www.json.org with whitespace nonterminal omitted for brevity.

Semantic actions are connected with dashed lines.  State names are
abbreviated to ALC, ALS, BK, BV, EOK, EOV.  (STATE, QTYPE) describes the
top stack entry.  "assert (STATE, QTYPE)" asserts the top stack entry's
@state is STATE, and its @partial is of QTYPE.  "set STATE" means the
top stack entry's state is set to STATE.

                                set EOV
                           result is QObject
          value                    =E2=94=86
          >=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=95=AE=E2=94=80=E2=94=80=E2=94=80 string =E2=94=80=E2=94=80=E2=
=95=AD=E2=94=80=E2=94=80=E2=94=80>
          =E2=94=86        =E2=94=82             =E2=94=82
  assert (BV, _)   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 number =E2=94=80=E2=
=94=80=E2=95=AF
                   =E2=94=82             =E2=94=82
                   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 object =E2=94=80=E2=
=94=80=E2=95=AF
                   =E2=94=82             =E2=94=82
                   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 array =E2=94=80=E2=
=94=80=E2=94=80=E2=95=AF
                   =E2=94=82             =E2=94=82
                   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 true =E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=95=AF
                   =E2=94=82             =E2=94=82
                   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 false =E2=94=80=E2=
=94=80=E2=94=80=E2=95=AF
                   =E2=94=82             =E2=94=82
                   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 null =E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=95=AF


              push (ALS, QList)   pop (ALS, QList)
                     =E2=94=86             assert (BV, _)
                     =E2=94=86               set EOV
                     =E2=94=86          result is popped QList
          array      =E2=94=86                  =E2=94=86
          >=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 =
[ =E2=94=80=E2=95=AE=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AD=E2=94=80 ] =
=E2=94=80=E2=94=80>
          =E2=94=86           =E2=94=82            =E2=94=82=20
  assert (BV, _)      =E2=94=82 =E2=94=84 set BV   =E2=94=82
                      =E2=94=82            =E2=94=82
              set BV  =E2=94=82            =E2=94=82
                  =E2=94=86   =E2=94=82            =E2=94=82
             =E2=95=AD=E2=94=80 , =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=95=B0=E2=94=80=E2=94=80 value =E2=94=80=E2=94=80=E2=95=AE=E2=95=AF
             =E2=94=82                    =E2=94=82 =E2=94=84 assert (EOV, =
QList)
             =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF   put value=
 into QList



              push (ALC, QDict)                  pop (ALC, QDict)
                     =E2=94=86                            assert (BV, _)
                     =E2=94=86                              set EOV
                     =E2=94=86                         result is popped QDi=
ct
          object     =E2=94=86                                 =E2=94=86
          >=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 =
{ =E2=94=80=E2=95=AE=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AD=E2=94=80 } =E2=94=80=E2=94=
=80>
          =E2=94=86           =E2=94=82                           =E2=94=82
  assert (BV, _)      =E2=94=82 =E2=94=84 set BK                  =E2=94=82
                      =E2=94=82                           =E2=94=82
              set BK  =E2=94=82  push (EOK, QString)      =E2=94=82
                  =E2=94=86   =E2=94=82         =E2=94=86                 =
=E2=94=82
             =E2=95=AD=E2=94=80 , =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=95=B0=E2=94=80 string =E2=94=80=E2=94=80=E2=94=80 : =E2=94=80=E2=94=80=E2=
=94=80 value =E2=94=80=E2=95=AE=E2=95=AF
             =E2=94=82                        =E2=94=86          =E2=94=82 =
  pop (BV, QString)
             =E2=94=82                     set BV        =E2=94=82 =E2=94=
=84 assert (EOV, QDict)
             =E2=94=82                                   =E2=94=82   put st=
ring: value
             =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF      into QDict

Might be your turn to be confused ;)

>>> +static QObject *json_parser_parse_token(JSONParserContext *ctxt, const=
 JSONToken *token)
>>=20
>> Rename to parse_token()?  Or inline into json_parser_feed()?
>
> Renaming is good.
>
>>> +            if (!key) {
>>> +                return NULL;
>>> +            }
>>=20
>> Key to understand the switch is the meaning of "break" and "return
>> NULL".
>>=20
>> We do the latter when we're done for this token.
>>=20
>> We do the former when this token completed a (sub-)value.  @value holds
>> it.  If the stack is empty, @value is the result of the parse, and the
>> code after the switch returns it.  Else, @value is a sub-value, and the
>> code after the switch stores it in the object being constructed.
>
> Correct.  Want me to include it somehow or is the grammar above fine?

Whether the grammar makes the meaning of "break" and "return NULL"
obvious enough is hard to tell now: I know too much.  Should fix itself
within a few days ;)

>>> +
>>> +            /* Store key in a special entry on the stack */
>>> +            push_entry(ctxt, QOBJECT(key), END_OF_KEY);
>>> +        } else {
>>> +            parse_error(ctxt, token, "expecting key");
>>=20
>> What's the state machine's parse error recovery story?
>
> As simple as it can be:
>
>      assert(!ctxt->err);
>
> because a push parser can actually refuse to deal with tokens after an=20
> error, and make recovery someone else's problem.
>
> In other words a push parser can actually be the pure theoretical thing=20
> from your compilers and automata book, and all the engineering sits on=20
> top.  IMO this (at least for a JSON parser that you won't touch that=20
> often) balances the complexity of the state machine.
>
> So, error recovery is handled entirely in json-streamer.c.  As of this=20
> patch, json-streamer.c has gathered all tokens up to the next balanced=20
> parentheses, and that's implicitly the place where the error recovery is=
=20
> complete.

This became clear to me once I had processed the remainder of the
series.

Peeling error recovery off the pushdown automaton that way indeed
simplifies the automaton.  Neat!  Possible because JSON's simple syntax
lets us get away with simple parenthesis counting error recovery.

>>> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *to=
ken, Error **errp)
>>=20
>> The return value isn't immediately obvious.  A brief function contract
>> could help the reader.
>
> Ok, will add.
>
>> Before the patch: flush the queue when both counts are zero or at least
>> one is negative.
>>=20
>> After the patch: additionally flush it on end of input.
>>=20
>> I figure the two hunks together make the parser see a JSON_END_OF_INPUT
>> token at the end of input.  Correct?
>
> Yes, see the commit message.  This is the only change I have made here=20
> to the parser/streamer split, because it makes sense to have the=20
> unbalanced parentheses error happen in the parser.  Otherwise you're not=
=20
> really implementing the whole grammar.

Yes.

At the end of the series, the only error checks in json-streamer.c are
about limits.  These aren't part of the syntax.  Everything that is part
of the syntax is checked in json-parser.c, except for lexical errors,
which are diagnosed in json-lexer.c, and reported in json-parser.c.
Perfectly sensible.

[...]


