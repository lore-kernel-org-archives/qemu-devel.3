Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B599BE7716E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 07:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJpO1-0003Te-1Q; Sat, 07 Dec 2024 02:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJpNx-0003TA-1a
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 02:37:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJpNu-00080G-6P
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 02:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733557068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkqWGGvQMYf5SV1P336be1tdotvclbtIHy6S4ozD7Eg=;
 b=OnjxQFje+hWKwTfAoS3Gw2FyKFHmPfzWwZ35klETSym+dT1qnSt5gKPy8/mh6g5wVdrp9v
 bDrqe3XKmRYL49ZF/gOCNSdVGCwOAwerc5nco2e4dHt6h5Phr4jEi04jt3YteLtbY3+CQ9
 yIBIehp7RWhfGKhYwullFfFyzbmzFaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-7efhf08ZM-uw_DwqUzB_EQ-1; Sat,
 07 Dec 2024 02:37:42 -0500
X-MC-Unique: 7efhf08ZM-uw_DwqUzB_EQ-1
X-Mimecast-MFC-AGG-ID: 7efhf08ZM-uw_DwqUzB_EQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA30E19541BA; Sat,  7 Dec 2024 07:37:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 417D01955F3F; Sat,  7 Dec 2024 07:37:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E113321E681F; Sat,  7 Dec 2024 08:37:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/9] Require error handling for dynamically created
 objects
In-Reply-To: <Z1LYp963Vbbd-LJC@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 6 Dec 2024 10:57:43 +0000")
References: <20241115172521.504102-1-berrange@redhat.com>
 <87a5dbln8x.fsf@pond.sub.org> <Z1HPF8wQG4ZqZIhF@redhat.com>
 <87r06l6wvh.fsf@pond.sub.org> <Z1LYp963Vbbd-LJC@redhat.com>
Date: Sat, 07 Dec 2024 08:37:37 +0100
Message-ID: <87ldwsose6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Cc: Phil, because we're now discusing qemu-system-any.

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Dec 06, 2024 at 09:25:54AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Wed, Dec 04, 2024 at 12:07:58PM +0100, Markus Armbruster wrote:
>> >> To be fair, object_new() was not designed for use with user-provided
>> >> type names.  When it chokes on type names not provided by the user, i=
t's
>> >> clearly a programming error, and assert() is a perfectly fine way to
>> >> catch programming errors.  Same for qdev_new().
>> >>=20
>> >> However, we do in fact use these functions with user-provided type
>> >> names, if rarely.  When we do, we need to validate the type name befo=
re
>> >> we pass it to them.
>> >>=20
>> >> Trouble is the validation code is a bit involved, and reimplementing =
it
>> >> everywhere it's needed is asking for bugs.
>> >>
>> >> Creating and using more interfaces that are more convenient for this
>> >> purpose would avoid that.
>> >
>> > Yep, I don't have confidence in an API that will assert if the caller
>> > forgot to validate the pre-conditions that can be triggered by user
>> > input (or potentially other unexpected scenarios like something being
>> > switched over to a module).
>>=20
>> Modules broke object_new(), but I'd rather not call object_new()'s
>> design bad for not accomodating a feature tacked on half-baked almost a
>> decade later.  But let's discuss modules further down.
>>=20
>> Asserting preconditions isn't the problem; this is how preconditions
>> *should* be checked.  The problem is error-prone preconditions.
>
> Yep, pre-conditions need to be something developers can be reasonably
> expected to accurately comply with.
>
>> Using string type names is in theory error-prone: the compiler cannot
>> check the type name is valid.  It could be invalid because of a typo, or
>> because it names a type that's not linked into this binary.
>
>
>> The compiler could check with an enumeration, but then the header
>> defining needed to be included basically everywhere QOM is used, and
>> changed all the time.
>>=20
>> So QOM went with strings.  I can't remember "invalid type name" bugs
>> surviving even basic testing in more than a decade of QOM use.
>
> Yep, at least for static object creation using since we're using the
> pattern "object_new(TYPE_BLAH)" - even if TYPE_BLAH contains a typo,
> it'll be the same typo passed in the .name =3D TYPE_BLAH of  TypeInfo,
> so all will work fine if following normal code patterns.

There's no shortage of qdev_new("mumble"), and even there typos haven't
been a problem.

>> Except for *user-supplied* type names.  These need to be validated, we
>> failed to factor out common validation code, and ended up with bugs in
>> some of the copies.
>
> Yep
>
>
>> >> Three cases:
>> >>=20
>> >> 1. Type name is literal string.  No change.  This is the most common
>> >>    case.
>> >>=20
>> >> 2. It's not.
>> >>=20
>> >> 2a. Type name is user-provided.  This is rare.  We replace
>> >>=20
>> >>         if (... guard ...) {
>> >>             ... return failure ...
>> >>         }
>> >>         obj =3D object_new(...);
>> >>=20
>> >>     by
>> >>=20
>> >>         obj =3D object_new_dynamic(..., errp);
>> >>         if (!obj) {
>> >>             ... return failure ...
>> >>         }
>> >>=20
>> >>     This is an improvement.
>> >>=20
>> >> 2b. It's not.  We should replace
>> >>=20
>> >>         obj =3D object_new(...);
>> >>=20
>> >>     by
>> >>=20
>> >>         obj =3D object_new_dynamic(..., &error_abort);
>> >>=20
>> >>     Exact same behavior, just wordier, to placate the compiler.
>> >>     Tolerable as long as it's relatively rare.
>> >>=20
>> >>     But I'm not sure it's worthwhile.  All it really does is helping
>> >>     some towards not getting case 2a wrong.  But 2a is rare.
>> >
>> > Yes, 2a is fairly rare, but this is amplified by the consequences
>> > of getting it wrong, which are an assert killing your running VM.
>> > My goal was to make it much harder to screw up and trigger an
>> > assert, even if that makes some valid uses more verbose.
>>=20
>> Has this been a problem in practice?  We have thirteen years of
>> experience...
>
> No, but this series came out of Peter's proposal to introduce the
> idea of Singleton classes, which would cause object_new to assert
> in fun new scenarios. Effectively adding a new pre-condition and
> would thus require all places which pass a dynamic type name to
> object_new(), to be updated with a "if singleton..." check. I
> wasn't happy with the idea of adding that precondition without a
> way to enforce that we've not missed checks somewhere in the code.
>
> Of course this pre-condition applies to static object_new calls
> too, but those are less risky as the developer (probably) has the
> mental context that the static object_new call is for a singleton.
>
>> > I don't have a good answer for how to extend compile time validation
>> > to cover non-user specified types that might be modules, without
>> > changnig 'object_new' itself to add "Error **errp" and convert as
>> > many callers as possible to propagate errors. That's a huge pile
>> > of tedious work and in many cases would deteriorate  to &error_abort
>> > since some key common use scenarios lack a "Error *errp" to propagate
>> > into.
>>=20
>> I can offer two ideas.
>>=20
>> I'll start with devices for reasons that will become apparent in a
>> minute.
>>=20
>> The first idea is straighforward in conception: since the problem is
>> modules breaking existing design assumptions, unbreak them.
>>=20
>> Device creation cannot fail, only realize can.  Could we delay the
>> problematic failure modes introduced by modules from creation to
>> realize?
>>=20
>> When creating the real thing fails, create a dummy instead.  Of course,
>> the dummy needs to be sufficiently functional to provide for the things
>> we do with devices before realize, such as introspection.
>>
>> Note that we already link information on modules into the binary, so
>> that the binary knows which modules provide a certain object.  To enable
>> sufficiently functional dummies, we'd have to link more.
>>=20
>> The difficulty is "the things we do with devices before realize": do we
>> even know?
>
> Yeah, the idea of a dummy stub until realize is called fills me with
> worry. It feels like something where it would be really easy to make
> a mistake and have code that crashes interacting with an unrealized
> object that doesn't have the struct fields you expect it to have, or
> has the struct fields, but not initialized since no 'init' method
> was run.
>
> A slight refinement of your idea would be to break anything modular
> into 2 distinct objects classes. MyDeviceFacade and MyDeviceImpl.
> Creators of the device always call object_new(TYPE_MY_DEVICE_FACADE),
> and the realize() method would load the module and make thje call
> to object_new(TYPE_MY_DEVICE_IMPL).
>
> Making something currently built-in, into a module, would involve
> a bunch of tedious refactoring work, so I don't much like the
> thought of choosing this as a design approach.
>
>> The other difficulty is that objects don't have realize.  User-creatable
>> objects have complete, which is kind of similar.  See also "Problem 5:
>> QOM lacks a clear life cycle" in my memo "Dynamic & heterogeneous
>> machines, initial configuration: problems"[*].
>
> It would be nice to have a unified model between object and devices
> for the complete/realize approach, but that's a slight tangent.

Yes, and yes.

>> The second idea is a variation of your idea to provide two interfaces
>> for object creation, where using the wrong one won't compile: a common
>> one that cannot fail, i.e. object_new(), and an uncommon one that can.
>> Let's call that one object_try_new() for now.
>>=20
>> Your proposed "string literal" as a useful approximation of "cannot
>> fail".  Modules defeat that.
>>=20
>> What if we switch from strings to something more expressive?
>>=20
>> Step one: replace string type names by symbols
>>=20
>> Change
>>=20
>>     #define TYPE_FOO "foo"
>>=20
>>     Object *object_new(const char *typename);
>>=20
>> to something like
>>=20
>>     extern const TypeInfoSafe foo_info;
>>     #define TYPE_FOO &foo_info
>>=20
>>     Object *object_new(const TypeInfoSafe *type_info);
>>=20
>> Step two: different symbols for safe and unsafe types
>>=20
>>     extern const TypeInfoUnsafe bar_info;
>>     #define TYPE_BAR &bar_info
>>=20=20=20=20=20
>>     Object *object_try_new(const TypeInfoUnsafe *type_info);
>>=20
>> Now you cannot pass bar_info to object_new().
>>=20
>> For a module-enabled TYPE_BAR, we already have something like
>>=20
>>     module_obj(TYPE_BAR)
>>=20
>> Make macro module_obj() require its argument to be TypeInfoUnsafe.
>>=20
>> Voil=C3=A0, the compiler enforces use of object_try_new() for objects
>> provided by loadable modules.
>>=20
>> There will be some fallout around computed type names such as
>> ACCEL_OPS_NAME().  Fairly rare, I think.
>>=20
>> More fallout around passing TYPE_ macros to functions that accept both
>> safe and unsafe types.  How common is that?
>
> Perhaps more common than we care to admit. eg most block device drivers
> are safe, except for a few we modularized which are unsafe. Most ui
> frontends would be safe, except for a few we modularized. This pattern
> of "except for a few we modularized" has been repeated all over, and
> conceptually that's not a bad thing, as we wanted to make it easy to
> modularize things incrementally.

It's only a problem if we have functions other than object_new() &
wrappers that now take type name strings.  Since their string argument
can't become both TypeInfoSafe and TypeInfoUnsafe, we'd have to split
them into a safe and an unsafe variant just like object_new(), or splice
in a suitable conversion.  Do such functions exist?  Helpers within qom/
don't really count.

> Looking at our current /usr/bin/qemu-system-XXX binaries, they range in
> size from 6 MB to 30 MB, stripped, ignoring linked libraries. Considering
> work on the qemu-system-any binary that is intended to unify all targets,
> I wouldn't be surprised if it came out at over 100 MB with all devices
> from all targets included.
>
> Is qemu-system-any pushing us to a place where our approach to modules
> is in fact wrong ?
>
> Modularizing piecemeal let us cull the big offenders that pulled in
> huge external libraries.
>
> People still complain QEMU is "too big" and binaries linked to too
> many legacy devices.
>
> With my distro hat on, if we had 'qemu-system-any' would I really
> want to have it as monolithic binary ?

No, and I don't think that's Phil's plan.

> I think I would want to have loadable TCG backends for each target,
> and I would want all the devices for each target to be loadable too.
> eg, so I could have a 'qemu-system-any' RPM with just the core, and
> 'qemu-system-modules-arm', 'qemu-system-modules-x86_64', etc, or
> even more fine grained than that.
>
> IOW, everything is a module by default. Not necccessarily
> 1 object =3D=3D 1 module, more  "N objects =3D=3D 1 module", but certainly
> with very few objects built-in.

I doubt one module per QOM type makes sense.  That's a huuuuge amount
modules, a thicket of dependencies, and way too much dynamic loading and
linking.

My qemu-system-x86_64 links with ~200 shared objects according to ldd.

It sports ~800 QOM types according to qom-list-types.

Pulling in shared objects in the low hundreds is already a dubious idea.
Pushing their number into the thousands feels... unadvisable.

Quite a few QOM types live together with relatives in the same .c.  But
even one module per .c instead of one module per QOM type will still
result in an excessive number of modules.  Evidence: I count >1700 .c
under hw, and I suspect most of them would become modules.

How can we do better?

Clearly, each target requires a certain set of QOM types.  Same for each
machine type.  We could simply have one module per target plus one
module per machine type.  A homogeneous guest would need one of each.

Since some types are used by more than one target / machine type, we'd
end up with them duplicated in different target / machine type modules.
To avoid that, we'd have to factor them out into common modules the
target / machine type modules can statically require.

Sounds like work, but it should produce a lot fewer modules.

> In such a world, IMHO, it doesn't make sense to have TypeInfoSafe
> and TypeInfoUnsafe, with different object_new/object_try_new
> methods. I think we would have to accept that object_new must
> get an "Error **errp", and possibly even the 'init" method too.
> It would force us to make sure we can propagage into errp in
> all the key places we can't do so today wrt object lifecycles.

With less fine-grained modularization, such as the one I sketched above,
many (most?) instances of object_new() remain safe, because they create
instances of types provided by the same module, or a statically required
module.  Remember, shared objects don't load unless their dependencies
also load, which means a successfully loaded module will have all it
statically requires.

> Overall I've talked myself into believing my series here is not
> worthwhile, as it doesn't solve a big enough problem, and it
> needs somethign more ambituous.

Yes, but what exactly is not yet clear to me.

>> >> Maybe module_object_new() and object_new_dynamic() could be fused int=
o a
>> >> single function with a better name.
>> >>=20
>> >> > With this series, my objections to Peter Xu's singleton series[1]
>> >> > would be largely nullified.
>> >> >
>> >> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg055=
24.html
>>=20
>> [*] Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
>> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
>
> With regards,
> Daniel


