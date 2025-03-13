Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0843C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnKj-0003kx-Ti; Thu, 13 Mar 2025 14:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsnKR-0003eO-A1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsnKN-0001gA-Bi
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741890641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/HqS8xcxSKL7mW75Ei2M3BTDIgl+TkNj+PgGrTsGqQ=;
 b=glts8p0eYKYjq5xVSNvAWNuZl3RdSLRUnx1ehhVQWVAib9KbmiQGfDOZ3fd6Xl3X+NmbHy
 dvS56ZSRaz8qWjaqhEFr4AcG/XoeGZKiO3S2j81MHBmEskcONfVUK4IqXdQfOFawdHXxs+
 veGSPALzMwCJ19Rttli2wfkgeWNOq+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-KUz3ffqhOaa9-b9UXl-oLA-1; Thu,
 13 Mar 2025 14:30:37 -0400
X-MC-Unique: KUz3ffqhOaa9-b9UXl-oLA-1
X-Mimecast-MFC-AGG-ID: KUz3ffqhOaa9-b9UXl-oLA_1741890636
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54E711800260; Thu, 13 Mar 2025 18:30:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C6FA1801747; Thu, 13 Mar 2025 18:30:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E24FC21E675E; Thu, 13 Mar 2025 19:30:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,  Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
In-Reply-To: <CAFn=p-a90ujkHX5abhrW9SoGLp08vPt2W_EE3M3=4c6mTZJVJg@mail.gmail.com>
 (John Snow's message of "Thu, 13 Mar 2025 12:57:01 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
 <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
 <87ikod56zf.fsf@pond.sub.org>
 <CAFn=p-b8xsWJw4kROKFUDbBNuJU32_oyktUMB+F5gsE=M9S72w@mail.gmail.com>
 <87o6y43our.fsf@pond.sub.org>
 <CAFn=p-a90ujkHX5abhrW9SoGLp08vPt2W_EE3M3=4c6mTZJVJg@mail.gmail.com>
Date: Thu, 13 Mar 2025 19:30:30 +0100
Message-ID: <87sengzsu1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Mar 13, 2025, 11:57=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com>
>> > wrote:
>> >
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster <armbru@r=
edhat.com> wrote:
>> >> >
>> >> >> John Snow <jsnow@redhat.com> writes:
>> >> >>
>> >> >> > This patch does three things:
>> >> >> >
>> >> >> > 1. Record the current namespace context in pending_xrefs so it c=
an be
>> >> >> >    used for link resolution later,
>> >> >> > 2. Pass that recorded namespace context to find_obj() when resol=
ving a
>> >> >> >    reference, and
>> >> >> > 3. Wildly and completely rewrite find_obj().
>> >> >> >
>> >> >> > cross-reference support is expanded to tolerate the presence or =
absence
>> >> >> > of either namespace or module, and to cope with the presence or =
absence
>> >> >> > of contextual information for either.
>> >> >> >
>> >> >> > References now work like this:
>> >> >> >
>> >> >> > 1. If the explicit reference target is recorded in the domain's =
object
>> >> >> >    registry, we link to that target and stop looking. We do this=
 lookup
>> >> >> >    regardless of how fully qualified the target is, which allows=
 direct
>> >> >> >    references to modules (which don't have a module component to=
 their
>> >> >> >    names) or direct references to definitions that may or may no=
t belong
>> >> >> >    to a namespace or module.
>> >> >> >
>> >> >> > 2. If contextual information is available from qapi:namespace or
>> >> >> >    qapi:module directives, try using those components to find a =
direct
>> >> >> >    match to the implied target name.
>> >> >> >
>> >> >> > 3. If both prior lookups fail, generate a series of regular expr=
essions
>> >> >> >    looking for wildcard matches in order from most to least
>> >> >> >    specific. Any explicitly provided components (namespace, modu=
le)
>> >> >> >    *must* match exactly, but both contextual and entirely omitted
>> >> >> >    components are allowed to differ from the search result. Note=
 that if
>> >> >> >    more than one result is found, Sphinx will emit a warning (a =
build
>> >> >> >    error for QEMU) and list all of the candidate references.
>> >> >> >
>> >> >> > The practical upshot is that in the large majority of cases, nam=
espace
>> >> >> > and module information is not required when creating simple `ref=
erences`
>> >> >> > to definitions from within the same context -- even when identic=
al
>> >> >> > definitions exist in other contexts.
>> >> >>
>> >> >> Can you illustrate this this examples?
>> >> >>
>> >> >
>> >> > do wha?
>> >>
>> >> Sorry, I went into the curve too fast.
>> >>
>> >> The stuff under "References now work like this" confuses me.  I guess=
 it
>> >> describes a series of lookups to try one after the other.
>> >>
>> >> I understand a cross-reference consists of namespace (optional), modu=
le
>> >> (optional), name, and role.
>> >>
>> >> Let's assume role is "any" for simplicity's sake.
>> >>
>> >> Regarding "1. If the explicit ...":
>> >>
>> >>     What is a reference's "explicit reference target"?  Examples might
>> >>     help me understand.
>> >>
>> >
>> > explicit lookup: `QMP:block-core:block-dirty-bitmap-add`
>> >
>> > If that explicit target matches an object in the object database
>> > *directly*, we match immediately and don't consider other potential
>> > targets. This also applies to things like modules, e.g. `QMP:block-cor=
e`
>> > even though the "module" is absent (it IS the module)
>> >
>> > We always search for the explicit target no matter how un/fully qualif=
ied
>> > it is.
>> >
>> >
>> >>
>> >>     What is "recorded in the domain's object registry"?
>> >>
>> >
>> > domain.objects{} - essentially a record of every ObjectDefinition's
>> > "fullname" - the return value from QAPIDefinition._get_fqn().
>> >
>> >
>> >>
>> >>     Can you show me a reference where this lookup succeeds?
>> >>
>> >
>> > `QMP:block-core`
>> > `QMP:block-core.block-dirty-bitmap-add`
>>
>> So, for this lookup to work, the reference must either be of the form
>> NAMESPACE:MODULE and resolve to that module in that namespace, or of the
>> form NAMESPACE:MODULE:DEFN and resolve to that definition in that module
>> in that namespace.  Correct?
>>
>
> Yes.
>
>
>> These a "fully qualified names (FQN)" in your parlance, right?
>>
>
> More or less, though as you found below...
>
>
>> Note that the first form is syntactically indistinguishable from
>> NAMESPACE:DEFN, i.e. a reference to a definition that specifies the
>> namespace, but not the module.
>>
>> If the NAMESPACE:MODULE interpretation resolves, we never try the
>> NAMESPACE:DEFN interpretation, because that happens in later steps.
>> Correct?
>>
>> The first form is fully qualified only if it resolves as FQN.  So,
>> whether such a reference is fully qualified is not syntactically
>> decidable.  Hmm.
>>
>
> You're right. There is a weirdness here. I might need to do some more
> thinking to make sure it isn't theoretically a problem, but in practice,
> right now, it isn't.

Not a blocker, but please do your thinking :)

> Stay tuned, I guess.
>
>
>> >> Regarding "2. If contextual information ...":
>> >>
>> >>     I guess "contextual information" is the context established by
>> >>     qapi:namespace and qapi:module directives, i.e. the current
>> >>     namespace and module, if any.
>> >>
>> >
>> > Yep!
>> >
>> >
>> >>
>> >>     If the cross reference lacks a namespace, we substitute the curre=
nt
>> >>     namespace.  Same for module.
>> >>
>> >>     We then use that "to find a direct match to the implied target
>> >>     name".  Sounds greek to me.  Example(s) might help.
>> >>
>> >
>> > If namespace or module is missing from the link target, we try to fill=
 in
>> > the blanks with the contextual information if present.
>> >
>> > Example, we are in the block-core section of the QEMU QMP reference ma=
nual
>> > document and we reference `block-dirty-bitmap-add`. With context, we a=
re
>> > able to assemble a fully qualified name:
>> > "QMP:block-core.block-dirty-bitmap-add`. This matches an item in the
>> > registry directly, so it matches and no further search is performed.
>>
>> We try this lookup only when the reference lacks a namespace and we are
>> "in" a namespace, or when it lacks a module and we are "in" a module.
>> Correct?
>>
>
> or both: if we provided only a name but the context has both a namespace
> and module.

So my or is inclusive :)

> essentially the algorithm splits the explicit target into (ns, mod, name)
> and for any that are blank, we try to fill in those blanks with context
> info where available. Sometimes you have neither explicit nor contextual
> info for a component.
>
> Then we do a lookup for an exact match, in order;
>
> 1. explicit target name, whatever it was

Fully qualified name.

If lookup succeeds, we're done.

If lookup fails, we're also done.

*Except* for the ambiguous form NAMESPACE:MYSTERY.  If lookup fails for
that, the name is not fully qualified after all.  Probably.  Maybe.  We
assume it's missing a module, and proceed to 2.

I'm mostly ignoring this exception from now on to keep things simple.

> 2. FQN using contextual info

Partially qualified name, but context can fill the gaps.

If lookup succeeds, we're done.

Else, we proceed to 3.

> and we stop after the first hit - no chance for multiple results here, ju=
st
> zero-or-one each step.
>
> i.e. any explicitly provided information is never "overwritten" with
> context, context only fills in the blanks where that info was not provide=
d.
>
> If neither of these work, we move on to fuzzy searching.
>
>
>> We then subsitute current namespace / module for the lacking one(s), and
>> try the same lookup as in 1.  Correct?
>>
>
> Yes!
>
>
>> If we have a reference of the form MYSTERY, it could either be a
>> reference to module MYSTERY in the current namespace, or to definition
>> MYSTERY in the current namespace and module.  How do we decide?
>>
>
> fqn a: NS:MYSTERY
> fqn b: NS:MOD:MYSTERY
>
> Given we have a current ns/mod context, it's going to pick the second one.
>
> Hm. Maybe it ought to be ambiguous in this case... I'll have to revise
> this. (question is: how soon do we need it?)

While we should try to put this on a more solid foundation, it is not a
blocker.

>> >> Regarding "3. If both prior lookups fail ...":
>> >>
>> >>     I guess we get here when namespace or module are absent, and
>> >>     substituting the current namespace or module doesn't resolve.  We
>> >>     then substitute a wildcard, so to speak, i.e. look in all namespa=
ces
>> >>     / modules, and succeed if we find exactly one resolution.  Fair?
>> >>
>> >
>> > More or less, though the mechanics are quite a bit more complex than y=
our
>> > overview (and what I wrote in qapi-domain.rst.) We can get here for a =
few
>> > reasons:
>> >
>> > (1) We didn't provide a fully qualified target, and we don't have full
>> > context to construct one.

We skipped 1. because not fully qualified, and we skipped 2. because
context can't fill the gaps.

>> >                           For example, we are not "in" a namespace and=
/or
>> > not "in" a module. This is quite likely to happen when writing simple
>> > references to a definition name from outside of the transmogfrified QA=
PI
>> > documentation, e.g. from qapi-domain.rst itself, or dirty-bitmaps.rst,=
 etc.

Yes.

>> > (2) We didn't provide a fully qualified target, and we are referencing
>> > something from outside of the local context. For example, we are "in" a
>> > module but we are trying to link to a different module's definition. e=
.g.
>> > we are in QMP:transaction and we reference `block-dirty-bitmap-add`. T=
he
>> > implied FQN will be QMP:transaction.block-dirty-bitmap.add, which will=
 not
>> > resolve.

We skipped 1. because not fully qualified, and we failed 2. because
context filled the gaps, but lookup failed.

>> >
>> > The fuzzy search portion has an order of precedence for how it searche=
s -
>> > and not all searches are tried universally, they are conditional to wh=
at
>> > was provided in the reference target and what context is available.
>> >
>> > 1. match against the explicitly provided namespace (module was not
>> > explicitly provided)
>>
>> Look for the name in all of the namespace's modules?
>>
>
> Yeah. search for "ns:*.name" and "ns:name" basically.

Got it.

>> > 2. match against the explicitly provided module (namespace was not
>> > explicitly provided)
>>
>> Look for the name in all modules so named in all namespaces?
>>
>
> Yes.

Got it.

>> > 3. match against the implied namespace (neither namespace/module was
>> > explicitly provided)
>>
>> ?
>>
>
> User gave `foo`, but we have a namespace from context, so we look for
> ns:*.foo or ns:foo.

Got it.

Detail I had not considered until now: a namespace contains modules that
contain definitions, but it also contains definitions directly.

I can't recall offhand how schema.py represents this.  I'll figure it
out and report back.

>> > 4. match against the implied module (neither namespace/module was
>> > explicitly provided)
>>
>> ?
>>
>
> User gave `foo`, but we have a module from context, so we search for
> *:mod.foo and mod.foo

Got it.

>> > 5. match against the definition name only, from anywhere (neither
>> > namespace/module was explicitly provided)
>>
>> Look for the name anywhere?
>>
>> I need examples :)
>>
>
> user gave `foo`. search for any qapi definition in all modules and
> namespaces for anything with the name "foo". The broadest possible search.
>
> Doesn't search for stuff outside of the QAPI domain directly, but be aware
> when using `references` that all domains are consulted, so it may in fact
> match something else from somewhere else, though not by any doing of the
> qapi domain.
>
> i.e. :qapi:any:`foo` will definitely only search using the rules laid out
> in this patch/thread, but `foo` will consult all domains (and whine if mo=
re
> than one result between all domains is identified.)

Got it, I think.

>> > The searches are performed in order: if a search returns zero results,=
 the
>> > next search is tried. If any search returns one or more results, those
>> > results are returned and we stop searching down the list. The priority
>> > order ensures that any explicitly provided information is *always* use=
d to
>> > find a match, but contextually provided information is merely a "hint"=
 and
>> > can be ignored for the sake of a match.
>> >
>> > If find_obj() as a whole returns zero results, Sphinx emits a warning =
for a
>> > dangling reference. if find_obj() as a whole returns multiple results,
>> > Sphinx emits a warning for the ambiguous cross-reference.
>> >
>> > QEMU errors out on any such warnings under our normal build settings.
>> >
>> > Clear as mud?
>>
>> Clearer, but not quite mud, yet.
>>
>
> Ultimately, Search in this order and stop at any point any of these
> searches return at least one result:
>
> 1. Explicitly provided name, whatever it is
> 2. FQN using contextual info
> 3. Explicitly provided NS; any module
> 4. Explicitly provided module; any NS
> 5. Contextual NS; any module
> 6. Contextual module; any NS
> 7. any NS/module.
>
> with searches 3-7 being conditional only when the criteria are met:
>
> 3. Must have explicit NS (and no explicit module)
> 4. Must have explicit module (and no explicit NS)
> 5. Must have contextual NS (must not have explicit NS nor module)
> 6. Must have contextual module (must not have explicit NS nor module)
> 7. Must have neither explicit NS nor module.
>
> In summary:
>
> * Anything explicitly provided *must* match. This information is *never*
> ignored.
> * Anything implicitly provided through context will never overwrite
> anything explicitly provided. This is used as a *hint* in the event
> multiple candidates are found, but results are allowed to deviate when
> stronger matches are not located.
>
> i.e. contextual information is used to *prefer* a result from that contex=
t,
> but is not used to *limit* you to that context.
>
> by contrast, explicit info is used to directly filter and restrict search.

Makes sense.

> (With maybe a bug or two for trying to find module names in some
> circumstances. Will have to check that over...)

Thank you!


