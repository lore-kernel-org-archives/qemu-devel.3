Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5779DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTfC-0003gP-OC; Fri, 06 Dec 2024 03:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJTfB-0003g2-76
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJTf6-0005oA-Rv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733473565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnfdNMtlr+Jdmrr+VrzBgsyBIR8ebwMawmyfQXhm2X4=;
 b=JrS0eBHtGgYzw0z89eL8csIE7o4yDLUjnaw+N5oC0XE5AiNDQ9dptos1Qbw82/stgER//R
 tgYXEvWCU+U+SzG2jvrMBZYsrwbKhaGRygEjHhoz8y2uJY/9ofutmjbT51OKviEsr5sSB+
 e8AFXz9t+gOm7YKrVvWOlsuNlPvVWzI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-lFfr5hMtPT2aGld4g0rqCQ-1; Fri,
 06 Dec 2024 03:25:58 -0500
X-MC-Unique: lFfr5hMtPT2aGld4g0rqCQ-1
X-Mimecast-MFC-AGG-ID: lFfr5hMtPT2aGld4g0rqCQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45E321955F42
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2024 08:25:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C527119560A2
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2024 08:25:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9362F21E66D2; Fri,  6 Dec 2024 09:25:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v3 0/9] Require error handling for dynamically created
 objects
In-Reply-To: <Z1HPF8wQG4ZqZIhF@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 5 Dec 2024 16:04:39 +0000")
References: <20241115172521.504102-1-berrange@redhat.com>
 <87a5dbln8x.fsf@pond.sub.org> <Z1HPF8wQG4ZqZIhF@redhat.com>
Date: Fri, 06 Dec 2024 09:25:54 +0100
Message-ID: <87r06l6wvh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Dec 04, 2024 at 12:07:58PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > NB, this series is targetting 10.0, NOT for 9.2 freeze.
>> >
>> > With code like
>> >
>> >     Object *obj =3D object_new(TYPE_BLAH)
>> >
>> > the caller can be pretty confident that they will successfully create
>> > an object instance of TYPE_BLAH. They know exactly what type has been
>> > requested, so it passing an abstract type for example, it is a clear
>> > programmer error that they'll get an assertion failure.
>> >
>> > Conversely with code like
>> >
>> >    void somefunc(const char *typename) {
>> >       Object * obj =3D object_new(typename)
>> >       ...
>> >    }
>> >
>> > all bets are off, because the call of object_new() knows nothing
>> > about what 'typename' resolves to.
>>=20
>> We know nothing *locally*.
>>=20
>> Commonly, a non-local argument can demonstrate safety.  Only when the
>> type name comes from the user, we truly know nothing.
>
> ...except for the failures introduced by modules not being installed,
> then all bets are off for all types unless you happen to recall
> which have been modularized so far.

True.  I was pretending modules don't exist until later in the message.

>> >                                    It could easily be an abstract
>> > type.
>>=20
>> It could also be no type at all.
>>=20
>> >       As a result, many code paths have added a manual check ahead
>> > of time
>> >
>> >    if (object_class_is_abstract(typename)) {
>> >       error_setg(errp, ....)
>> >    }
>>=20
>> Actually, object_class_is_abstract() takes an ObjectClass, not a type
>> name string.
>>=20
>> The actual guards we use are variations of
>>=20
>>     klass =3D object_class_by_name(typename);
>>     if (!klass) {
>>         error_setg(errp, "invalid object type: %s", typename);
>>         return NULL;
>>     }
>>=20
>>     if (object_class_is_abstract(klass)) {
>>         error_setg(errp, "object type '%s' is abstract", typename);
>>         return NULL;
>>     }
>>=20
>> which covers "no type at all", too.
>>=20
>> Sometimes, we use module_object_class_by_name() instead, which I believe
>> additionally loads the module providing the type, if any.  Which of the
>> two should be used where is a mystery to me, and I suspect we're getting
>> it wrong in places.  But this is turning into a digression.  To
>> hopefully maintain focus, I'm pretending modules don't exist until later
>> in this message.
>
> Yeah, I'm not a fan of having the separate module_object_class_by_name,
> because it requires us to remember whether something has been modularized
> or not.
>
>> Sometimes, we throw in an object_class_dynamic_cast(klass, T) to check
>> @typename resolves to a subtype of some T.
>>=20
>> > ...except for where we forget to do this, such as qdev_new().
>>=20
>> We did not forget it there!  It's by design a thin wrapper around
>> object_new(), with preconditions just like object_new().
>
> Yes, I think what I meant to write here, was "...except for where
> we forgot todo this in *callers* of qdev_new that take user input"

Correct.

>> > Overall 'object_new' is a bad design because it is inherantly
>> > unsafe to call with unvalidated typenames.
>>=20
>> To be fair, object_new() was not designed for use with user-provided
>> type names.  When it chokes on type names not provided by the user, it's
>> clearly a programming error, and assert() is a perfectly fine way to
>> catch programming errors.  Same for qdev_new().
>>=20
>> However, we do in fact use these functions with user-provided type
>> names, if rarely.  When we do, we need to validate the type name before
>> we pass it to them.
>>=20
>> Trouble is the validation code is a bit involved, and reimplementing it
>> everywhere it's needed is asking for bugs.
>>
>> Creating and using more interfaces that are more convenient for this
>> purpose would avoid that.
>
> Yep, I don't have confidence in an API that will assert if the caller
> forgot to validate the pre-conditions that can be triggered by user
> input (or potentially other unexpected scenarios like something being
> switched over to a module).

Modules broke object_new(), but I'd rather not call object_new()'s
design bad for not accomodating a feature tacked on half-baked almost a
decade later.  But let's discuss modules further down.

Asserting preconditions isn't the problem; this is how preconditions
*should* be checked.  The problem is error-prone preconditions.

Using string type names is in theory error-prone: the compiler cannot
check the type name is valid.  It could be invalid because of a typo, or
because it names a type that's not linked into this binary.

The compiler could check with an enumeration, but then the header
defining needed to be included basically everywhere QOM is used, and
changed all the time.

So QOM went with strings.  I can't remember "invalid type name" bugs
surviving even basic testing in more than a decade of QOM use.

Except for *user-supplied* type names.  These need to be validated, we
failed to factor out common validation code, and ended up with bugs in
some of the copies.

>> > This problem is made worse by the proposal to introduce the idea
>> > of 'singleton' classes[1].
>> >
>> > Thus, this series suggests a way to improve safety at build
>> > time. The core idea is to allow 'object_new' to continue to be
>> > used *if-and-only-if* given a static, const string, because that
>> > scenario indicates the caller is aware of what type they are
>> > creating at build time.
>> >
>> > A new 'object_new_dynamic' method is proposed for cases where
>> > the typename is dynamically chosen at runtime. This method has
>> > an "Error **errp" parameter, which can report when an abstract
>> > type is created, leaving the assert()s only for scenarios which
>> > are unambiguous programmer errors.
>> >
>> > With a little macro magic, we guarantee a compile error is
>> > generated if 'object_new' is called with a dynamic type, forcing
>> > all potentially unsafe code over to object_new_dynamic.
>>=20
>> Three cases:
>>=20
>> 1. Type name is literal string.  No change.  This is the most common
>>    case.
>>=20
>> 2. It's not.
>>=20
>> 2a. Type name is user-provided.  This is rare.  We replace
>>=20
>>         if (... guard ...) {
>>             ... return failure ...
>>         }
>>         obj =3D object_new(...);
>>=20
>>     by
>>=20
>>         obj =3D object_new_dynamic(..., errp);
>>         if (!obj) {
>>             ... return failure ...
>>         }
>>=20
>>     This is an improvement.
>>=20
>> 2b. It's not.  We should replace
>>=20
>>         obj =3D object_new(...);
>>=20
>>     by
>>=20
>>         obj =3D object_new_dynamic(..., &error_abort);
>>=20
>>     Exact same behavior, just wordier, to placate the compiler.
>>     Tolerable as long as it's relatively rare.
>>=20
>>     But I'm not sure it's worthwhile.  All it really does is helping
>>     some towards not getting case 2a wrong.  But 2a is rare.
>
> Yes, 2a is fairly rare, but this is amplified by the consequences
> of getting it wrong, which are an assert killing your running VM.
> My goal was to make it much harder to screw up and trigger an
> assert, even if that makes some valid uses more verbose.

Has this been a problem in practice?  We have thirteen years of
experience...

>> > This is more tractable than adding 'Error **errp' to 'object_new'
>> > as only a handful of places use a dynamic type name.
>>=20
>> True!
>>=20
>> Alright, enter modules.
>>=20
>> Modules break a fundamental design assumption: object_new() on a
>> compiled-in type name is safe, i.e. the failure modes are all
>> programming errors.
>>=20
>> Modules add new failure modes that are *not* programming errors:
>>=20
>> * The module providing the type was not deployed correctly.
>>=20
>> * It was, but the host system lacks the resources to load it.
>
> Hmm, yes, I hadn't considered the 2nd problem. That's more
> unpleasant, as libvirt may well have queried QEMU earlier to
> detect the missing module, and assume all is safe if it is
> present.

The first problem could perhaps be hand-waved away: must deploy all
modules or else.  But that partly defeats the purpose of modules, namely
keeping unwanted dependencies off the host.

The second problem cannot: assertion failure on otherwise survivable
resource shortage is unequivocally wrong.

For more on module trouble, see "Problem 3: Loadable modules" in my memo
"Dynamic & heterogeneous machines, initial configuration: problems"[*]

>> Before modules, object_new(T) was safe unless T was user-provided.
>> Which implies it's safe when T is a literal string.
>>=20
>> Since modules, object_new(T) is safe unless T is user-provided or the
>> type named by it is compiled as module.  This does *not* imply it's safe
>> when T is a literal string.
>
> Agreed.=20
>
>> When looking at a use of object_new(), whether the argument names a type
>> that could be compiled as module cannot be known locally.  Therefore, we
>> cannot know locally whether we need to handle failure, either with a
>> suitable guard or by switching to a new function like
>> object_new_dynamic().  This is bad.
>>
>> Breaking fundamental design assumptions tends to have ugly and expensive
>> consequences.  Consequences like having to rework every single call of
>> object_new() & friends.
>>=20
>> Can we reduce the damage?  Maybe.  What if we create a
>> module_object_new() that takes an Error **, and make object_new() crash
>> & burn when the @typename argument resolves to a type provided by a
>> module?
>
> I'm doubtful about a design where maintainers have to choose the
> right API, based on mental knowledge of what is a module or not.
> The place where object_new is called is typically distinct from
> the module impl, so the knowledge is separated. This opens the
> door to forgetting to change code from object_new to module_object_new.
> This is what motivated my attempt to try to force compile time errors
> scenarios which had a high chance of being user specified types.

We'd have to rely on the test suite here, as we've done for "type name
is valid".

> I don't have a good answer for how to extend compile time validation
> to cover non-user specified types that might be modules, without
> changnig 'object_new' itself to add "Error **errp" and convert as
> many callers as possible to propagate errors. That's a huge pile
> of tedious work and in many cases would deteriorate  to &error_abort
> since some key common use scenarios lack a "Error *errp" to propagate
> into.

I can offer two ideas.

I'll start with devices for reasons that will become apparent in a
minute.

The first idea is straighforward in conception: since the problem is
modules breaking existing design assumptions, unbreak them.

Device creation cannot fail, only realize can.  Could we delay the
problematic failure modes introduced by modules from creation to
realize?

When creating the real thing fails, create a dummy instead.  Of course,
the dummy needs to be sufficiently functional to provide for the things
we do with devices before realize, such as introspection.

Note that we already link information on modules into the binary, so
that the binary knows which modules provide a certain object.  To enable
sufficiently functional dummies, we'd have to link more.

The difficulty is "the things we do with devices before realize": do we
even know?

The other difficulty is that objects don't have realize.  User-creatable
objects have complete, which is kind of similar.  See also "Problem 5:
QOM lacks a clear life cycle" in my memo "Dynamic & heterogeneous
machines, initial configuration: problems"[*].

The second idea is a variation of your idea to provide two interfaces
for object creation, where using the wrong one won't compile: a common
one that cannot fail, i.e. object_new(), and an uncommon one that can.
Let's call that one object_try_new() for now.

Your proposed "string literal" as a useful approximation of "cannot
fail".  Modules defeat that.

What if we switch from strings to something more expressive?

Step one: replace string type names by symbols

Change

    #define TYPE_FOO "foo"

    Object *object_new(const char *typename);

to something like

    extern const TypeInfoSafe foo_info;
    #define TYPE_FOO &foo_info

    Object *object_new(const TypeInfoSafe *type_info);

Step two: different symbols for safe and unsafe types

    extern const TypeInfoUnsafe bar_info;
    #define TYPE_BAR &bar_info
=20=20=20=20
    Object *object_try_new(const TypeInfoUnsafe *type_info);

Now you cannot pass bar_info to object_new().

For a module-enabled TYPE_BAR, we already have something like

    module_obj(TYPE_BAR)

Make macro module_obj() require its argument to be TypeInfoUnsafe.

Voil=C3=A0, the compiler enforces use of object_try_new() for objects
provided by loadable modules.

There will be some fallout around computed type names such as
ACCEL_OPS_NAME().  Fairly rare, I think.

More fallout around passing TYPE_ macros to functions that accept both
safe and unsafe types.  How common is that?

Worth exploring?

>> Maybe module_object_new() and object_new_dynamic() could be fused into a
>> single function with a better name.
>>=20
>> > With this series, my objections to Peter Xu's singleton series[1]
>> > would be largely nullified.
>> >
>> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05524.=
html
>>=20
>
> With regards,
> Daniel


[*] Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/


