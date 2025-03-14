Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AF8C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 07:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tszAQ-0001Jj-1J; Fri, 14 Mar 2025 03:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tszAO-0001Il-0A
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tszAL-0003LT-Oe
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741936147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oj2m631mOpZ0Fz8F/BznGk1ID2d0g63EY/kkj9iRmps=;
 b=KzybG1ESUTTQlGZYdArxOkbIQUGAfgKtsMdawffLJH50vShN2pl51Ss81WEW8NAH5OD/SB
 +RqUY2nzpgS67KHPi32b+9iu/0bVQAf9GcbjkzZr7qY9o8IUkCjD6Z3x4FrXAe5fcQ9P0J
 rYK6rPL6eizfLCZRVaFJ/2mEvP0wNQ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-pDkEtd1vPpayfGpGhl-UOQ-1; Fri,
 14 Mar 2025 03:09:05 -0400
X-MC-Unique: pDkEtd1vPpayfGpGhl-UOQ-1
X-Mimecast-MFC-AGG-ID: pDkEtd1vPpayfGpGhl-UOQ_1741936144
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D06419560AF; Fri, 14 Mar 2025 07:09:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4916218001F6; Fri, 14 Mar 2025 07:09:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E0AC21E675E; Fri, 14 Mar 2025 08:08:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  Michael
 Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
In-Reply-To: <CAFn=p-YSuD1wso3WFyY02zVowcPccMZy7abePdqZcN7CZBOF7g@mail.gmail.com>
 (John Snow's message of "Thu, 13 Mar 2025 14:59:44 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
 <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
 <87ikod56zf.fsf@pond.sub.org>
 <CAFn=p-b8xsWJw4kROKFUDbBNuJU32_oyktUMB+F5gsE=M9S72w@mail.gmail.com>
 <87o6y43our.fsf@pond.sub.org>
 <CAFn=p-a90ujkHX5abhrW9SoGLp08vPt2W_EE3M3=4c6mTZJVJg@mail.gmail.com>
 <87sengzsu1.fsf@pond.sub.org>
 <CAFn=p-YSuD1wso3WFyY02zVowcPccMZy7abePdqZcN7CZBOF7g@mail.gmail.com>
Date: Fri, 14 Mar 2025 08:08:59 +0100
Message-ID: <87msdoum0k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> On Thu, Mar 13, 2025 at 2:30=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Thu, Mar 13, 2025, 11:57=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
>> >
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster <armbru@=
redhat.com wrote:

[...]

>> >> >> Regarding "2. If contextual information ...":
>> >> >>
>> >> >>     I guess "contextual information" is the context established by
>> >> >>     qapi:namespace and qapi:module directives, i.e. the current
>> >> >>     namespace and module, if any.
>> >> >>
>> >> >
>> >> > Yep!
>> >> >
>> >> >
>> >> >>
>> >> >>     If the cross reference lacks a namespace, we substitute the cu=
rrent
>> >> >>     namespace.  Same for module.
>> >> >>
>> >> >>     We then use that "to find a direct match to the implied target
>> >> >>     name".  Sounds greek to me.  Example(s) might help.
>> >> >>
>> >> >
>> >> > If namespace or module is missing from the link target, we try to f=
ill in
>> >> > the blanks with the contextual information if present.
>> >> >
>> >> > Example, we are in the block-core section of the QEMU QMP reference=
 manual
>> >> > document and we reference `block-dirty-bitmap-add`. With context, w=
e are
>> >> > able to assemble a fully qualified name:
>> >> > "QMP:block-core.block-dirty-bitmap-add`. This matches an item in the
>> >> > registry directly, so it matches and no further search is performed.
>> >>
>> >> We try this lookup only when the reference lacks a namespace and we a=
re
>> >> "in" a namespace, or when it lacks a module and we are "in" a module.
>> >> Correct?
>> >>
>> >
>> > or both: if we provided only a name but the context has both a namespa=
ce
>> > and module.
>>
>> So my or is inclusive :)
>>
>> > essentially the algorithm splits the explicit target into (ns, mod, na=
me)
>> > and for any that are blank, we try to fill in those blanks with context
>> > info where available. Sometimes you have neither explicit nor contextu=
al
>> > info for a component.
>> >
>> > Then we do a lookup for an exact match, in order;
>> >
>> > 1. explicit target name, whatever it was
>>
>> Fully qualified name.
>>
>
> Yes, for lookup to succeed it should be fully qualified, though if the
> target text is "ns:module", that's actually going to succeed here, too.
>
>
>>
>> If lookup succeeds, we're done.
>>
>> If lookup fails, we're also done.
>>
>
> If lookup fails, we actually continue on to #2, but whether or not this
> does anything useful depends on whether or not the original target text w=
as
> fully qualified or not. If it was, #2 searches with the exact same text a=
nd
> will fail again and proceed to #3, where because we had a fully qualified
> name, none of the search conditions apply and we then just exit.
>
> (It just lacks an early return, but abstractly, if lookup on #1 fails with
> a fully qualified name, we are indeed done.)
>
> If lookup fails because it wasn't actually fully qualified, then #2 has
> some gaps to try to fill.

So, instead of

    if ref is fully qualified:
        try to look up ref
    else
        proceed to 2.

you do

    look up ref
    if found:
        ref must be fully qualified
    else
        proceed to 2.

Since "proceed to 2. won't do anything useful when ref is fully
qualified", the two should produce the same result.

>> *Except* for the ambiguous form NAMESPACE:MYSTERY.  If lookup fails for
>> that, the name is not fully qualified after all.  Probably.  Maybe.  We
>> assume it's missing a module, and proceed to 2.
>>
>> I'm mostly ignoring this exception from now on to keep things simple.
>>
>> > 2. FQN using contextual info
>>
>> Partially qualified name, but context can fill the gaps.
>>
>> If lookup succeeds, we're done.
>>
>> Else, we proceed to 3.
>>
>
> That's right.
>
>
>>
>> > and we stop after the first hit - no chance for multiple results here,=
 just
>> > zero-or-one each step.
>> >
>> > i.e. any explicitly provided information is never "overwritten" with
>> > context, context only fills in the blanks where that info was not prov=
ided.
>> >
>> > If neither of these work, we move on to fuzzy searching.
>> >
>> >
>> >> We then subsitute current namespace / module for the lacking one(s), =
and
>> >> try the same lookup as in 1.  Correct?
>> >>
>> >
>> > Yes!
>> >
>> >
>> >> If we have a reference of the form MYSTERY, it could either be a
>> >> reference to module MYSTERY in the current namespace, or to definition
>> >> MYSTERY in the current namespace and module.  How do we decide?
>> >>
>> >
>> > fqn a: NS:MYSTERY
>> > fqn b: NS:MOD:MYSTERY
>> >
>> > Given we have a current ns/mod context, it's going to pick the second =
one.
>> >
>> > Hm. Maybe it ought to be ambiguous in this case... I'll have to revise
>> > this. (question is: how soon do we need it?)
>>
>> While we should try to put this on a more solid foundation, it is not a
>> blocker.
>>
>> >> >> Regarding "3. If both prior lookups fail ...":
>> >> >>
>> >> >>     I guess we get here when namespace or module are absent, and
>> >> >>     substituting the current namespace or module doesn't resolve. =
 We
>> >> >>     then substitute a wildcard, so to speak, i.e. look in all name=
spaces
>> >> >>     / modules, and succeed if we find exactly one resolution.  Fai=
r?
>> >> >>
>> >> >
>> >> > More or less, though the mechanics are quite a bit more complex tha=
n your
>> >> > overview (and what I wrote in qapi-domain.rst.) We can get here for=
 a few
>> >> > reasons:
>> >> >
>> >> > (1) We didn't provide a fully qualified target, and we don't have f=
ull
>> >> > context to construct one.
>>
>> We skipped 1. because not fully qualified, and we skipped 2. because
>> context can't fill the gaps.
>>
>
> we tried #1 and failed, then we tried #2 and failed again.

I think we're describing the same behavior with different words

Behavior:

    try to fill the gaps from context
    if all filled:
        look up
        if found:
            done

When you say "tried #2 and failed", you're referring to the entire
thing.

When I say "skipped 2.", I'm referring to the lookup.

>> >> >                           For example, we are not "in" a namespace =
and/or
>> >> > not "in" a module. This is quite likely to happen when writing simp=
le
>> >> > references to a definition name from outside of the transmogfrified=
 QAPI
>> >> > documentation, e.g. from qapi-domain.rst itself, or dirty-bitmaps.r=
st, etc.
>>
>> Yes.
>>
>> >> > (2) We didn't provide a fully qualified target, and we are referenc=
ing
>> >> > something from outside of the local context. For example, we are "i=
n" a
>> >> > module but we are trying to link to a different module's definition=
. e.g.
>> >> > we are in QMP:transaction and we reference `block-dirty-bitmap-add`=
. The
>> >> > implied FQN will be QMP:transaction.block-dirty-bitmap.add, which w=
ill not
>> >> > resolve.
>>
>> We skipped 1. because not fully qualified, and we failed 2. because
>> context filled the gaps, but lookup failed.
>>
>
> Failed #1 and Failed #2.
>
>
>>
>> >> >
>> >> > The fuzzy search portion has an order of precedence for how it sear=
ches -
>> >> > and not all searches are tried universally, they are conditional to=
 what
>> >> > was provided in the reference target and what context is available.
>> >> >
>> >> > 1. match against the explicitly provided namespace (module was not
>> >> > explicitly provided)
>> >>
>> >> Look for the name in all of the namespace's modules?
>> >>
>> >
>> > Yeah. search for "ns:*.name" and "ns:name" basically.
>>
>> Got it.
>>
>> >> > 2. match against the explicitly provided module (namespace was not
>> >> > explicitly provided)
>> >>
>> >> Look for the name in all modules so named in all namespaces?
>> >>
>> >
>> > Yes.
>>
>> Got it.
>>
>> >> > 3. match against the implied namespace (neither namespace/module was
>> >> > explicitly provided)
>> >>
>> >> ?
>> >>
>> >
>> > User gave `foo`, but we have a namespace from context, so we look for
>> > ns:*.foo or ns:foo.
>>
>> Got it.
>>
>> Detail I had not considered until now: a namespace contains modules that
>> contain definitions, but it also contains definitions directly.
>>
>> I can't recall offhand how schema.py represents this.  I'll figure it
>> out and report back.
>>
>
> I think it gets charged to a module named "qapi-schema". Silly, but it
> doesn't really break anything.

Alright, here's how it works.

A QAPI schema consists of the main schema file and optionally included
files.

Each file's definitions go into a module named like the file.  The
builtin definitions go into a special module './builtin'.

A definition is *always* in a module.  Even when the schema is
monolithic, i.e. includes nothing.

Why do you need to support definitions directly in the namespace?

[...]


