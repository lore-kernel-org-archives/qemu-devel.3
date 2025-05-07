Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE497C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCcq8-0007uc-9x; Wed, 07 May 2025 07:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCcq4-0007td-BU
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCcq1-0004Vw-Td
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746616878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39S5StMxW/sRTNRLhf4UoNZSfoHob9K44wGhE9i1LTQ=;
 b=MsqDtVYfSLTr4oikTKs3ghADBGUIrn1JJhWdTd/tPLa9dD1Jz4/oUUW6AgnHMvMPgJBs/Z
 N2cyrP/kXQAt0onIDeUlYynCfU7HnF4nwz5WPjuPtlgvjjp/aE+tYDdL9K7YGG0r0CX6SQ
 S2p1NNSbB/yhHrIIMlekd9RFzBKWZgo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-gQkQrzeUN0Gdb3YAW3n9MA-1; Wed,
 07 May 2025 07:21:15 -0400
X-MC-Unique: gQkQrzeUN0Gdb3YAW3n9MA-1
X-Mimecast-MFC-AGG-ID: gQkQrzeUN0Gdb3YAW3n9MA_1746616873
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D0431955DC5; Wed,  7 May 2025 11:21:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B687D1953B80; Wed,  7 May 2025 11:21:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C2E921E66C9; Wed, 07 May 2025 13:21:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  stefanha@redhat.com,  Michael Roth
 <michael.roth@amd.com>,  pbonzini@redhat.com,  peter.maydell@linaro.org,
 thuth@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  devel@lists.libvirt.org,  Victor Toso
 <victortoso@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
In-Reply-To: <aBCPrqggooxF6Z1w@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 29 Apr 2025 09:37:02 +0100")
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org> <aBCPrqggooxF6Z1w@redhat.com>
Date: Wed, 07 May 2025 13:21:10 +0200
Message-ID: <87ikmcis49.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Apr 29, 2025 at 09:43:24AM +0200, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>> > After looking at the introspection code, I don't see any major blocker.
>> > We need to keep some of existing "if", as they are based on config-hos=
t,=20
>> > and should apply.
>> > We can introduce a new "available_if" (or any other name), which=20
>> > generates a runtime check when building the schema, or when serializin=
g=20
>> > a struct.
>> >
>> > This way, by modifying the .json with:
>> > - if: 'TARGET_I386'
>> > + available_if: 'target_i386()'
>> >
>> > This way, we keep the possibility to have ifdef, and we can expose at=
=20
>> > runtime based on available_if. So we can keep the exact same schema we=
=20
>> > have today per target.
>>=20
>> The name is ugly.  Naming is hard.  No need to worry about it right now.
>>=20
>> Semantics of having both 'if' and 'available_if'?  To work out an
>> answer, let's consider how to convert conditionals:
>>=20
>> * 'if': STRING
>>=20
>>   If STRING is a target-specific macro, replace by 'available_if': PRED,
>>   where PRED is the equivalent run-time predicate.
>>=20
>>   Else, no change.
>>=20
>> * 'if': { 'all': [COND, ...] }
>>=20
>>   If COND contains only target-specific macros, replace by
>>   'available_if': { 'all': [PRED, ...] }, where the PRED are the
>>   equivalent run-time predicates.
>>=20
>>   If COND contains no target-specific macros, no change.
>>=20
>>   What if it contains both?
>>=20
>>   - If each COND contains either only target-specific macros, or no
>>     target-specific macros, we could split the target-specific ones off
>>     into an additional 'available_if'.  This requires defining the
>>     semantics of having both 'if' and 'available_if' as "both conditions
>>     must be satisfied".
>>=20
>>   - What if this isn't the case?
>>=20
>> * 'if' { 'any': [COND, ...] }
>>=20
>>   Similar, but to be able to split the COND we need "either condition
>>   must be satisfied."
>>=20
>> Even if we can make this work somehow, it would likely be a royal mess
>> to explain in qapi-code-gen.rst.
>>=20
>> We currently don't have "mixed" conditionals.  So we could sidestep the
>> problem: you can have either 'if' or 'available_if', but not both.
>> Feels like a cop out to me.
>>=20
>> What if we move the "is dynamic" bit from the root of the conditional to
>> its leaves?  So far, the leaves are macro names.  What if we
>> additionally permit a function name?
>>=20
>> Function name, not C expression, to not complicate generating code in
>> languages other than C too much.
>>=20
>> Ignore the question of syntax for now, i.e. how to decide whether a leaf
>> is a macro or a function name.
>
> I wonder if any of this is worth the pain in practice.....

Fair!

Pierrick's stated goal is "no noticable differences".  We've explored
what this means.  We can also explore changes that would help us reach
the goal more easily, and maybe even consider setting a less ambitious
goal.

> Looking at the QAPI schema, we apply TARGET_xxxx conditions either to
> commands, or to structs/enums that are used in args/return of commands.
> We don't conditionalize individual fields, etc.

With one exception noted by Pierrick.

> I tried to query our schema with 'jq' (incidentally rather tedious
> because of our JSON-but-not-JSON language[1]). If I select only
> commands we get:
>
> query-cpu-definitions          =3D> currently many arches
> query-cpu-model-expansion      =3D> currently many arches
> query-cpu-model-baseline       =3D> currently s390x only
> query-cpu-model-comparison     =3D> currently s390x only
> query-s390x-cpu-polarization   =3D> inherently s390x only
> query-gic-capabilities         =3D> inherently arm only
> query-sev                      =3D> inherently x86 only
> query-sev-attestation-report   =3D> inherently x86 only
> query-sev-capabilities         =3D> inherently x86 only
> query-sev-launch-measure       =3D> inherently x86 only
> query-sgx                      =3D> inherently x86 only
> query-sgx-capabilities         =3D> inherently x86 only
> rtc-reset-reinjection          =3D> inherently x86 only
> set-cpu-topology               =3D> inherently s390x only
> sev-inject-launch-secret       =3D> inherently x86 only
> xen-event-inject               =3D> currently x86 only
> xen-event-list                 =3D> currently x86 only
>
> The two Xen commands are currently limited to x86, but if we ever extended
> Xen to arm, possibly they would make sense. IOW, conceptually a target
> conditional might be useful in future.
>
> The CPU model commands are the ones where having the target conditions
> visible in schema appears to add value, in that they'll allow a mgmt
> app to detect when we extend any of them to cover new architectures.
>
>
> Libvirt (and other mgmt apps) want to query the schema to see if commands
> exist in the QEMU they're using, before trying to invoke them. To some
> degree this is just a "nice to have" that improves error reporting/detect=
ion.

Schema introspection is more robust, and often simpler, especially for
more complicated questions.

> For the commands that are inherently arch specific, the mgmt app should
> conceptually already know what architectures these commands apply to.
> These target conditionals provide little (no) value when probing commands
> in the schema.

Fair.  Management applications are quite unlikely to ask "does this
target support SEV?"  If they know anything about SEV, they know it's
x86.  They may still want to ask "does this QEMU provide SEV stuff?"
This remains possible even with the conditionals deleted.

Nice to have: "inherently specific to <target>" is blatantly obvious.
Target conditionals do that only approximately: they don't tell whether
the condition is inherent or just a "currently".  If we drop the
conditions, we should consider other means, such as clearer doc
comments, or reorganizing the section structure.

> IOW, if we (for example) have a single binary for x86 and s390, it should
> be harmless if we report that 'query-sev' exists regardless of arch, as
> the mgmt app should none the less already know to only use it with x86.
>
> I don't know if libvirt correctly filters based on architecture in the
> case of SEV/SGX/GIC/RTC when probing & using these features, but if it
> does not, then I'd consider that a pre-existing bug that should be fixed.

While we QEMU developers gratefully appreciate an "I don't know whether
our management application does <unadvisable-thing>, but if you break
it, we'll fix our management application" attitude, we nevertheless try
quite hard not to break management applications :)

> Libvirt doesn't use the Xen commands.
>
> For query-cpu-model-comparison/baseline, libvirt already filters its
> usage of these based on s390 arch, so even if x86 reported them I
> believe it won't break libvirt today. If these commands are extended
> to other archs in future, libvirt might want a way to detect this.
> On the flipside it might not be the end of the world if we just expose
> them on all arches and simply have them return an error at runtime
> where non-applicable.=20

query-cpu-definitions can't currently, fail, but the other query-cpu-FOO
all have multiple failure modes, which can complicate things if you need
to distinguish "failed because non-applicable / not implemented" from
other failures.  Avoiding such complications is largely why
introspection exists.

The ideal solution is to implement the query-cpu-FOO for all targets.

> IOW, while the target conditions could theoretically provide value at
> some point in future, it does not look like they do anything /today/
> for libvirt.
>
> Given that I wonder if we shouldn't just ignore the problem, and
> blindly remove all TARGET_nnn conditions from QAPI schema today. Let
> our future selves worry about it should this prove insufficient later.

Again, exploring this makes sense.

> With regards,
> Daniel
>
> [1] To use QAPI JSON with 'jq' you must convert ' to " and
>     strip comments. eg
>=20=20=20=20=20
>       cat *.json | sed -e "s/'/\"/g" -e 's/#.*//' | jq ...expression...


