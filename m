Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53024E63F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 07:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsFgA-0006mh-Ck; Tue, 17 Feb 2026 02:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsFg9-0006mQ-2Q
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 02:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsFg4-0000b1-Ma
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 02:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771313961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mA/5Dw3X6BiebAkvYJH/6JE9OBI0NVnZGT3BkoJ8ImA=;
 b=ZbyaBMxN4oqYu7NzpEFe01ffRCXbA15sXIt+RL4TSE0Oli/yYQrfQNw5403ojzP12bHNMV
 k/gqcMgMYgXJrsWEdmw0ylq3ZSt+2o7x9rBNrYl4dVH/A1xyXvb/To7sj9VSQFGR88w9P+
 zRcP8RDECcModQnExxmTEK/Ybon/6FE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-aoR16LHhMrSUDeV-5cVuFA-1; Tue,
 17 Feb 2026 02:39:19 -0500
X-MC-Unique: aoR16LHhMrSUDeV-5cVuFA-1
X-Mimecast-MFC-AGG-ID: aoR16LHhMrSUDeV-5cVuFA_1771313959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B6D218003FC
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90DE41800361
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D2DD21E692D; Tue, 17 Feb 2026 08:39:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] json-parser: replace with a push parser
In-Reply-To: <682de27d-4ebf-4c08-ad0c-45626a5a9dea@redhat.com> (Paolo
 Bonzini's message of "Mon, 16 Feb 2026 17:41:18 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-3-pbonzini@redhat.com>
 <87sebab6mr.fsf@pond.sub.org>
 <a31dca74-1ae8-428c-9ed8-315594afecbf@redhat.com>
 <87wm0iumuv.fsf@pond.sub.org>
 <682de27d-4ebf-4c08-ad0c-45626a5a9dea@redhat.com>
Date: Tue, 17 Feb 2026 08:39:16 +0100
Message-ID: <875x7vrf8b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 2/12/26 14:12, Markus Armbruster wrote:
>>>> We know the stack is at most 1024 deep (MAX_NESTING).  Have you
>>>> considered using an array instead of GQueue?
>>>
>>> It'd be only 8K, but I preferred to keep MAX_NESTING hidden within
>>> json-streamer.c.  Not having bounds checking makes me a bit nervous
>>> about having fixed-size arrays.
>>=20
>> Looks mostly harmless to me: there's exactly one spot where we push
>> something onto the stack, one where we pop, and one where we pop
>> everything.  We only ever look at the top of the stack.
>
> Yes, code-wise it's not hard.  But it's ugly/brittle to have two pieces=20
> of code that have to sync on MAX_NESTING.
>
>>>> The parser's interesting part follows.  The parser is a pushdown
>>>> automaton.  The pushdown automaton is coded in C.  On the one hand,
>>>> d'oh!  Of course it is.  On the other hand, it's hard to see the actual
>>>> automaton in C.  May I have a comment explaining state and state
>>>> transitions?  Perhaps we better start with an informal description,
>>>> discuss it, then distill the discussion into a comment.
>>>
>>> That was the purpose of the mysterious comment above.  If a mix between
>>> BNF and automaton is okay for you, it could be something like
>>>
>>> input :=3D value        -> END_OF_VALUE
>>>            END_OF_INPUT -> check stack is empty, return parsed value
>>>
>>> // entered on BEFORE_VALUE; after any of these rules are processed, the
>>> // parser has completed a QObject and is in the END_OF_VALUE state.
>>=20
>> What do you mean by "after any of these rules are processed, ..."?
>
> That "literal", "'[' after_lsquare" and "'{' after_lcurly" both end up=20
> with the state machine in the END_OF_VALUE state.

So this is a "how to read the annotated BNF" comment?=20=20

>>> //
>>> // When the parser reaches the END_OF_VALUE state, it examines the
>>> // top of the stack to see if it's coming from "input" (stack empty),
>>> // "array_items" (TOS is a QList) or "dict_pairs" (TOS is a QString; the
>>> // item below will be a QDict).  It then proceeds with the corresponding
>>> // actions, which will be one of:
>>> // - return parsed value
>>> // - add value to QList
>>> // - pop QString with the key, add key/value to the QDict
>>=20
>> Forward references to array_items and dict_pairs.  Suggest to add a
>> suitable "below", or indicate the forward reference some other way.
>
> I can put instead after_lsquare and after_lcurly.

BNF usually reads easiest when written top down, i.e. start symbol
production first, other non-terminals' productions after their use.

I don't mind the forward references in the comment here, it just took me
a second to recognize them.  No real problem, but perhaps adding "above"
/ "below" could help the reader.

>>> value :=3D literal       -> END_OF_VALUE
>>>         | '['            -> push empty QList -> AFTER_LSQUARE
>>>            after_lsquare -> END_OF_VALUE
>>>         | '{'            -> push empty QDict -> AFTER_LCURLY
>>>            after_lcurly  -> END_OF_VALUE
>>>
>>> // non-recursive values, entered on BEFORE_VALUE
>>> literal :=3D INTEGER   -> END_OF_VALUE
>>>        | FLOAT         -> END_OF_VALUE
>>>        | KEYWORD       -> END_OF_VALUE
>>>        | STRING        -> END_OF_VALUE
>>>        | INTERP        -> END_OF_VALUE
>>>
>>> // entered on AFTER_LSQUARE
>>> after_lsquare :=3D ']' -> pop completed QList -> END_OF_VALUE
>>>          | =CF=B5           -> BEFORE_VALUE
>>>            array_items -> END_OF_VALUE
>>>
>>> // entered on BEFORE_VALUE, with TOS being a QList
>>> array_items :=3D value   -> add value to QList -> END_OF_VALUE
>>>          (']'            -> pop completed QList -> END_OF_VALUE
>>>           | ','          -> BEFORE_VALUE
>>>             array_items) -> END_OF_VALUE
>>>
>>> // entered on AFTER_LCURLY
>>> after_lcurly :=3D '}'  -> pop completed QDict -> END_OF_VALUE
>>>          | =CF=B5           -> BEFORE_KEY
>>>            dict_pairs  -> END_OF_VALUE
>>>
>>> // entered on BEFORE_KEY, with TOS being a QDict
>>> dict_pairs :=3D STRING  -> push QString -> END_OF_KEY
>>>          ':'            -> BEFORE_VALUE
>>>          value          -> pop QString + add pair to QDict -> END_OF_VA=
LUE
>>>          ('}'           -> pop completed QDict -> END_OF_VALUE
>>>           | ','         -> BEFORE_KEY
>>>             dict_pairs) -> END_OF_VALUE
>>=20
>> The BNF part is everything but the -> ...  Easy enough.  However, I'm
>> not quite certain how to interpret the --> ...
>>=20
>> The "// entered on STATE ..." I can read as assertion.
>
> Yes, that's a comment (with C++ syntax to have something familiar).
>
>> The text after "->" seems to be one ore more state / stack transitions.
>> Let me describe them in my own words to make sure I understand you.
>> Note that I had to also look at the source code to produce my
>> description.
>>=20
>> -> STATE
>>=20
>>     Set top stack entry's state to STATE.
>>=20
>> -> push OBJ -> STATE
>>=20
>>     Push (STATE, OBJ) onto the stack.
>
> Intended more like push (OBJ, undefined), set top stack entry state to=20
> STATE, but yes.
>
>> -> pop completed OBJ -> END_OF_VALUE
>>=20
>>     Pop (_, OBJ) from the stack, set new top stack entry's state to
>>     END_OF_VALUE.  OBJ is the result of parsing non-terminal @value.
>>=20
>> -> add value to QList -> END_OF_VALUE
>>=20
>>     Append the result of parsing non-terminal @value to the top stack
>>     entry's QList.  Set the top stack entry's state to END_OF_VALUE.
>>=20
>> -> pop QString + add pair to QDict -> END_OF_VALUE
>>=20
>>     Pop (_, QString) from the stack, it's the key.  Its value is the
>>     result of parsing non-terminal value.  Store this key: value pair in
>>     the top stack entry's QDict.  Set the top stack entry's state to
>>     END_OF_VALUE.
>
> Correct. "-> STATE" generally means "go to state STATE", where teh state=
=20
> is stored in the top stack entry.

So I was able to work out how to read the annotations.  How can we make
that easier for the next guy?  Could well be me in six months...

>> Stack entry members @partial from bottom to top:
>>=20
>> * a QList element for an unclosed '[',
>>=20
>> * a QDict and a QString element for an unclosed '{', except the
>>    innermost one need not have a QString.  This is because the QString is
>>    on the stack only while we're parsing ':' value.
>>=20
>> So, stack contents invariant:
>>=20
>>      ( QList | QDict QString )* QDict?
>
> Makes sense.

Let's write it down where we describe the structure of the stack.

>> I found the QString business somewhat confusing, probably because I
>> expected one stack entry per nesting level, and tossing that invalid
>> assumption took mental effort.
>
> ... while I wrote the parser as one per pending nonterminal.  Coming=20
> from the recursive descent probably suggested that approach, somewhat=20
> subconsciously.
>
>> I figure we could have one stack entry per: add a const char *key member
>> to JSONParserStackEntry, non-null exactly when we have a QString sitting
>> on a QDict now.  We'd trade representable invalid state "QString
>> directly above non-QDict in the stack" for "QList stack entry has member
>> @key set".  Would be slightly more local.  Matter of taste, I guess.
>
> I can check what the code looks like, sure.
>
>> More representable invalid state, as far as I can tell (observation, not
>> objection):
>>=20
>> * a QList stack entry can only have state AFTER_LSQUARE, BEFORE_VALUE,
>>    END_OF_VALUE, never AFTER_LCURLY, BEFORE_KEY, END_OF_KEY
>>=20
>> * a QDict stack entry can only have state AFTER_LCURLY, BEFORE_KEY,
>>    END_OF_VALUE, never AFTER_LSQUARE, BEFORE_VALUE, END_OF_KEY
>>=20
>> * a QString stack entry can only have state BEFORE_VALUE and END_OF_KEY,
>>    never AFTER_LCURLY, AFTER_LSQUARE, BEFORE_VALUE, END_OF_VALUE.
>>=20
>> Stack entries by @state instead of by @partial:
>>
>> * AFTER_LCURLY: @partial is QDict
>>
>> * AFTER_LSQUARE: @partial is QList
>>
>> * BEFORE_KEY: @partial is QDict
>>
>> * BEFORE_VALUE: @partial is QList or QString
>
> ... or empty:
>
>      state =3D entry ? entry->state : BEFORE_VALUE;

Yes, forgot that one.

>> * END_OF_KEY: @partial is QString
>>
>> * END_OF_VALUE: @partial is QList or QString
>>
>> Invariants worth documenting, I think.
>
> Ok---as assertions in the code?

Making invalid states unrepresentable is best, but that's often not
practical in C.

I generally prefer assertions to comments as long as the assertions are
easy enough to read.

>> Here's my attempt at explaining the automaton and how states and stack
>> fit together: annotated JSON syntax diagrams.  The diagrams are from
>> www.json.org with whitespace nonterminal omitted for brevity.
>>=20
>> Semantic actions are connected with dashed lines.  State names are
>> abbreviated to ALC, ALS, BK, BV, EOK, EOV.  (STATE, QTYPE) describes the
>> top stack entry.  "assert (STATE, QTYPE)" asserts the top stack entry's
>> @state is STATE, and its @partial is of QTYPE.  "set STATE" means the
>> top stack entry's state is set to STATE.
>>=20
>>                                 set EOV
>>                            result is QObject
>>           value                    =E2=94=86
>>           >=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=95=AE=E2=94=80=E2=94=80=E2=94=80 string =E2=94=80=E2=94=80=
=E2=95=AD=E2=94=80=E2=94=80=E2=94=80>
>>           =E2=94=86        =E2=94=82             =E2=94=82
>>   assert (BV, _)   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 number =E2=94=80=
=E2=94=80=E2=95=AF
>>                    =E2=94=82             =E2=94=82
>>                    =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 object =E2=94=80=
=E2=94=80=E2=95=AF
>>                    =E2=94=82             =E2=94=82
>>                    =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 array =E2=94=80=
=E2=94=80=E2=94=80=E2=95=AF
>>                    =E2=94=82             =E2=94=82
>>                    =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 true =E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=95=AF
>>                    =E2=94=82             =E2=94=82
>>                    =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 false =E2=94=80=
=E2=94=80=E2=94=80=E2=95=AF
>>                    =E2=94=82             =E2=94=82
>>                    =E2=95=B0=E2=94=80=E2=94=80=E2=94=80 null =E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=95=AF
>>=20
>>=20
>>               push (ALS, QList)   pop (ALS, QList)
>>                      =E2=94=86             assert (BV, _)
>>                      =E2=94=86               set EOV
>>                      =E2=94=86          result is popped QList
>>           array      =E2=94=86                  =E2=94=86
>>           >=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80 [ =E2=94=80=E2=95=AE=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AD=E2=94=80=
 ] =E2=94=80=E2=94=80>
>>           =E2=94=86           =E2=94=82            =E2=94=82=20
>>   assert (BV, _)      =E2=94=82 =E2=94=84 set BV   =E2=94=82
>>                       =E2=94=82            =E2=94=82
>>               set BV  =E2=94=82            =E2=94=82
>>                   =E2=94=86   =E2=94=82            =E2=94=82
>>              =E2=95=AD=E2=94=80 , =E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=95=B0=E2=94=80=E2=94=80 value =E2=94=80=E2=94=80=E2=95=AE=E2=95=AF
>>              =E2=94=82                    =E2=94=82 =E2=94=84 assert (EO=
V, QList)
>>              =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF   put va=
lue into QList
>>=20
>>=20
>>=20
>>               push (ALC, QDict)                  pop (ALC, QDict)
>>                      =E2=94=86                            assert (BV, _)
>>                      =E2=94=86                              set EOV
>>                      =E2=94=86                         result is popped =
QDict
>>           object     =E2=94=86                                 =E2=94=86
>>           >=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80 { =E2=94=80=E2=95=AE=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AD=E2=94=80 } =E2=94=80=E2=
=94=80>
>>           =E2=94=86           =E2=94=82                           =E2=94=
=82
>>   assert (BV, _)      =E2=94=82 =E2=94=84 set BK                  =E2=94=
=82
>>                       =E2=94=82                           =E2=94=82
>>               set BK  =E2=94=82  push (EOK, QString)      =E2=94=82
>>                   =E2=94=86   =E2=94=82         =E2=94=86               =
  =E2=94=82
>>              =E2=95=AD=E2=94=80 , =E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=95=B0=E2=94=80 string =E2=94=80=E2=94=80=E2=94=80 : =E2=94=80=E2=94=80=
=E2=94=80 value =E2=94=80=E2=95=AE=E2=95=AF
>>              =E2=94=82                        =E2=94=86          =E2=94=
=82   pop (BV, QString)
>>              =E2=94=82                     set BV        =E2=94=82 =E2=
=94=84 assert (EOV, QDict)
>>              =E2=94=82                                   =E2=94=82   put=
 string: value
>>              =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF      into QDict
>>=20
>> Might be your turn to be confused ;)
>
> I'm not confused but maybe it is a bit too detailed.

We can elide detail.  For instance, if we document the stack structure
elsewhere, assertions on stack contents are low value here.

>>>>> +static QObject *json_parser_parse_token(JSONParserContext *ctxt, con=
st JSONToken *token)
>>>>
>>>> Rename to parse_token()?  Or inline into json_parser_feed()?
>>>
>>> Renaming is good.
>>>
>>>>> +            if (!key) {
>>>>> +                return NULL;
>>>>> +            }
>>>>
>>>> Key to understand the switch is the meaning of "break" and "return
>>>> NULL".
>>>>
>>>> We do the latter when we're done for this token.
>>>>
>>>> We do the former when this token completed a (sub-)value.  @value holds
>>>> it.  If the stack is empty, @value is the result of the parse, and the
>>>> code after the switch returns it.  Else, @value is a sub-value, and the
>>>> code after the switch stores it in the object being constructed.
>>>
>>> Correct.  Want me to include it somehow or is the grammar above fine?
>>=20
>> Whether the grammar makes the meaning of "break" and "return NULL"
>> obvious enough is hard to tell now: I know too much.  Should fix itself
>> within a few days ;)
>
> Probably not. :)  I'll see if I can move the post-pr

I can offer a pair of fresher eyes on v2.


