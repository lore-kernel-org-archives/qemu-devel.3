Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BBEC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskwP-000164-GE; Thu, 13 Mar 2025 11:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tskwN-00015R-Rd
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tskwL-0007Vq-Sn
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741881463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlIg4zirSIiEmOXchb6QjT/I2WDkuFb2PW1vHYvBfRM=;
 b=MSWoW2eh8+JY0A0vEuhBNqZnJyXHQmJwUs0xdIKsBW5fzNThi6ObSfAoKrosICY92x2c5J
 e9LZCpvd9YnQxVS+3uz1U6qoRHOSqKdCCxkuDAN4T9N/SkaZVrQOVzFChRdyLqbAmI8c9v
 eTCoQZVHBk0VXrYX9fIF1qahYdVonis=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-344qb4IMMgu3u91HOdZByg-1; Thu,
 13 Mar 2025 11:57:40 -0400
X-MC-Unique: 344qb4IMMgu3u91HOdZByg-1
X-Mimecast-MFC-AGG-ID: 344qb4IMMgu3u91HOdZByg_1741881459
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5415C1801A1A; Thu, 13 Mar 2025 15:57:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E48B1801758; Thu, 13 Mar 2025 15:57:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C629A21E675E; Thu, 13 Mar 2025 16:57:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
In-Reply-To: <CAFn=p-b8xsWJw4kROKFUDbBNuJU32_oyktUMB+F5gsE=M9S72w@mail.gmail.com>
 (John Snow's message of "Thu, 13 Mar 2025 11:10:33 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
 <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
 <87ikod56zf.fsf@pond.sub.org>
 <CAFn=p-b8xsWJw4kROKFUDbBNuJU32_oyktUMB+F5gsE=M9S72w@mail.gmail.com>
Date: Thu, 13 Mar 2025 16:57:32 +0100
Message-ID: <87o6y43our.fsf@pond.sub.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > This patch does three things:
>> >> >
>> >> > 1. Record the current namespace context in pending_xrefs so it can =
be
>> >> >    used for link resolution later,
>> >> > 2. Pass that recorded namespace context to find_obj() when resolvin=
g a
>> >> >    reference, and
>> >> > 3. Wildly and completely rewrite find_obj().
>> >> >
>> >> > cross-reference support is expanded to tolerate the presence or abs=
ence
>> >> > of either namespace or module, and to cope with the presence or abs=
ence
>> >> > of contextual information for either.
>> >> >
>> >> > References now work like this:
>> >> >
>> >> > 1. If the explicit reference target is recorded in the domain's obj=
ect
>> >> >    registry, we link to that target and stop looking. We do this lo=
okup
>> >> >    regardless of how fully qualified the target is, which allows di=
rect
>> >> >    references to modules (which don't have a module component to th=
eir
>> >> >    names) or direct references to definitions that may or may not b=
elong
>> >> >    to a namespace or module.
>> >> >
>> >> > 2. If contextual information is available from qapi:namespace or
>> >> >    qapi:module directives, try using those components to find a dir=
ect
>> >> >    match to the implied target name.
>> >> >
>> >> > 3. If both prior lookups fail, generate a series of regular express=
ions
>> >> >    looking for wildcard matches in order from most to least
>> >> >    specific. Any explicitly provided components (namespace, module)
>> >> >    *must* match exactly, but both contextual and entirely omitted
>> >> >    components are allowed to differ from the search result. Note th=
at if
>> >> >    more than one result is found, Sphinx will emit a warning (a bui=
ld
>> >> >    error for QEMU) and list all of the candidate references.
>> >> >
>> >> > The practical upshot is that in the large majority of cases, namesp=
ace
>> >> > and module information is not required when creating simple `refere=
nces`
>> >> > to definitions from within the same context -- even when identical
>> >> > definitions exist in other contexts.
>> >>
>> >> Can you illustrate this this examples?
>> >>
>> >
>> > do wha?
>>
>> Sorry, I went into the curve too fast.
>>
>> The stuff under "References now work like this" confuses me.  I guess it
>> describes a series of lookups to try one after the other.
>>
>> I understand a cross-reference consists of namespace (optional), module
>> (optional), name, and role.
>>
>> Let's assume role is "any" for simplicity's sake.
>>
>> Regarding "1. If the explicit ...":
>>
>>     What is a reference's "explicit reference target"?  Examples might
>>     help me understand.
>>
>
> explicit lookup: `QMP:block-core:block-dirty-bitmap-add`
>
> If that explicit target matches an object in the object database
> *directly*, we match immediately and don't consider other potential
> targets. This also applies to things like modules, e.g. `QMP:block-core`
> even though the "module" is absent (it IS the module)
>
> We always search for the explicit target no matter how un/fully qualified
> it is.
>
>
>>
>>     What is "recorded in the domain's object registry"?
>>
>
> domain.objects{} - essentially a record of every ObjectDefinition's
> "fullname" - the return value from QAPIDefinition._get_fqn().
>
>
>>
>>     Can you show me a reference where this lookup succeeds?
>>
>
> `QMP:block-core`
> `QMP:block-core.block-dirty-bitmap-add`

So, for this lookup to work, the reference must either be of the form
NAMESPACE:MODULE and resolve to that module in that namespace, or of the
form NAMESPACE:MODULE:DEFN and resolve to that definition in that module
in that namespace.  Correct?

These a "fully qualified names (FQN)" in your parlance, right?

Note that the first form is syntactically indistinguishable from
NAMESPACE:DEFN, i.e. a reference to a definition that specifies the
namespace, but not the module.

If the NAMESPACE:MODULE interpretation resolves, we never try the
NAMESPACE:DEFN interpretation, because that happens in later steps.
Correct?

The first form is fully qualified only if it resolves as FQN.  So,
whether such a reference is fully qualified is not syntactically
decidable.  Hmm.

>> Regarding "2. If contextual information ...":
>>
>>     I guess "contextual information" is the context established by
>>     qapi:namespace and qapi:module directives, i.e. the current
>>     namespace and module, if any.
>>
>
> Yep!
>
>
>>
>>     If the cross reference lacks a namespace, we substitute the current
>>     namespace.  Same for module.
>>
>>     We then use that "to find a direct match to the implied target
>>     name".  Sounds greek to me.  Example(s) might help.
>>
>
> If namespace or module is missing from the link target, we try to fill in
> the blanks with the contextual information if present.
>
> Example, we are in the block-core section of the QEMU QMP reference manual
> document and we reference `block-dirty-bitmap-add`. With context, we are
> able to assemble a fully qualified name:
> "QMP:block-core.block-dirty-bitmap-add`. This matches an item in the
> registry directly, so it matches and no further search is performed.

We try this lookup only when the reference lacks a namespace and we are
"in" a namespace, or when it lacks a module and we are "in" a module.
Correct?

We then subsitute current namespace / module for the lacking one(s), and
try the same lookup as in 1.  Correct?

If we have a reference of the form MYSTERY, it could either be a
reference to module MYSTERY in the current namespace, or to definition
MYSTERY in the current namespace and module.  How do we decide?

>> Regarding "3. If both prior lookups fail ...":
>>
>>     I guess we get here when namespace or module are absent, and
>>     substituting the current namespace or module doesn't resolve.  We
>>     then substitute a wildcard, so to speak, i.e. look in all namespaces
>>     / modules, and succeed if we find exactly one resolution.  Fair?
>>
>
> More or less, though the mechanics are quite a bit more complex than your
> overview (and what I wrote in qapi-domain.rst.) We can get here for a few
> reasons:
>
> (1) We didn't provide a fully qualified target, and we don't have full
> context to construct one. For example, we are not "in" a namespace and/or
> not "in" a module. This is quite likely to happen when writing simple
> references to a definition name from outside of the transmogfrified QAPI
> documentation, e.g. from qapi-domain.rst itself, or dirty-bitmaps.rst, et=
c.
>
> (2) We didn't provide a fully qualified target, and we are referencing
> something from outside of the local context. For example, we are "in" a
> module but we are trying to link to a different module's definition. e.g.
> we are in QMP:transaction and we reference `block-dirty-bitmap-add`. The
> implied FQN will be QMP:transaction.block-dirty-bitmap.add, which will not
> resolve.
>
> The fuzzy search portion has an order of precedence for how it searches -
> and not all searches are tried universally, they are conditional to what
> was provided in the reference target and what context is available.
>
> 1. match against the explicitly provided namespace (module was not
> explicitly provided)

Look for the name in all of the namespace's modules?

> 2. match against the explicitly provided module (namespace was not
> explicitly provided)

Look for the name in all modules so named in all namespaces?

> 3. match against the implied namespace (neither namespace/module was
> explicitly provided)

?

> 4. match against the implied module (neither namespace/module was
> explicitly provided)

?

> 5. match against the definition name only, from anywhere (neither
> namespace/module was explicitly provided)

Look for the name anywhere?

I need examples :)

> The searches are performed in order: if a search returns zero results, the
> next search is tried. If any search returns one or more results, those
> results are returned and we stop searching down the list. The priority
> order ensures that any explicitly provided information is *always* used to
> find a match, but contextually provided information is merely a "hint" and
> can be ignored for the sake of a match.
>
> If find_obj() as a whole returns zero results, Sphinx emits a warning for=
 a
> dangling reference. if find_obj() as a whole returns multiple results,
> Sphinx emits a warning for the ambiguous cross-reference.
>
> QEMU errors out on any such warnings under our normal build settings.
>
> Clear as mud?

Clearer, but not quite mud, yet.

> --js
>
>
>> [...]
>>
>>


