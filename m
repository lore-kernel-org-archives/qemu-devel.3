Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E60C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDdNn-0003zQ-M2; Sat, 10 May 2025 02:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDdNk-0003uB-Lr
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDdNc-0006uv-Jr
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746857290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGU0S0Ns6ALcVlmeEWOIZTkTyU/QcH+0PP9FqpiJmUM=;
 b=RWfJF7lqmTXBCBNngMu5v/qYnPYis3+3j3fjrbJ29OXESRWvcd25XqPYZNFQRQntZ9/j+B
 1puyA6DHyV8u3aSsrGH/vRZVVhYG5xy8XamBCZ8p/LY3BkcplIMvHWI2MhpicDrHa9JMex
 kT7Rtwf40tVy8fGwbDLiqHNmUKuh2IY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-MqoOGSiGNtK85nH6F98TLA-1; Sat,
 10 May 2025 02:08:06 -0400
X-MC-Unique: MqoOGSiGNtK85nH6F98TLA-1
X-Mimecast-MFC-AGG-ID: MqoOGSiGNtK85nH6F98TLA_1746857285
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA2F8180045B; Sat, 10 May 2025 06:08:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EACC53000221; Sat, 10 May 2025 06:08:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7313B21E6768; Sat, 10 May 2025 08:08:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Da?=
 =?utf-8?Q?ud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from
 the schema
In-Reply-To: <aB4JiDnVE8XrVfax@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 9 May 2025 14:56:24 +0100")
References: <20250508135816.673087-1-berrange@redhat.com>
 <c7623b1c-01c1-46c0-bfa6-dc34aa4e722d@linaro.org>
 <aB3EpKu0iafLtgVT@redhat.com> <874ixt6gsd.fsf@pond.sub.org>
 <aB4JiDnVE8XrVfax@redhat.com>
Date: Sat, 10 May 2025 08:08:02 +0200
Message-ID: <874ixt2e2l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

> On Fri, May 09, 2025 at 03:43:30PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > I think we have to distinguish between what made sense in the context
>> > of our original design, from what makes sense for our future design(s)
>> > and plans.
>>=20
>> No argument.
>>=20
>> The original design idea is simple: #ifdef CONFIG_FOO for QAPI schema,
>> to not generate dead code, and to not have silly stubs.  Even if you
>> don't care about wasting disk and address space, you probably care about
>> wasting developer time on writing silly stubs and waiting for dead code
>> to compile.
>>=20
>> Initially, target-specific macros did not work in conditions.  That was
>> easy enough to fix, so we did.
>
> Ah, yes, forgot that bit of history.
>
>> > I can understand why we took the direction we did historically, but I
>> > think we have unwittingly created problems for ourselves that are
>> > looking increasingly worse than the problems we considered solved.
>> >
>> >
>> > In the other thread I pointed out my dislike for QAPI schema not being
>> > fully self-describing when we have conditionals present, even today,
>> > but there are other aspects that trouble me more wrt conditionals.
>>=20
>> I'm not sure I have all this present in my mind...  Can you summarize
>> what troubles you?  Or point me to the message(s)?
>
> Oppps, sorry, should have cross-linked to:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01947.html

Hadn't gotten to that thread...  Thanks!

>> > Since the schema is currently target specific, a mgmt app has to probe
>> > for QEMU capabilities once for every target binary. QEMU has ~30 system
>> > binaries, and if querying capabilities takes 250 milliseconds, then
>> > querying all binaries is ~ 7 seconds of work. Libvirt mitigates this
>> > overhead by caching the results of capabilities probes. We periodically
>> > suffer delays when we must invalidate our cache though, typically on
>> > software upgrades, and this is unpleasant for users who think we've
>> > got stuck or just have bad slow code.
>>=20
>> How does cache invalidation work?  Timestamp of binary?
>
> ctime of libvirt itself and ctime of QEMU binary are the two
> primary factors.
>
> We had to throw in other factors on top for various edge cases
> over time. So we also check the mtime of the directory containing
> QEMU loadable modules, as features reported can vary if the user
> installs new device/backend modules. Also check kernel version,
> microcode version, CPUID signature, because that can affect
> availability of some features.
>
> NB, this is caching more than just the QMP schema - we issue
> many 'query-xxxx' commands when probing QEMU.
>
> https://gitlab.com/libvirt/libvirt/-/blame/master/src/qemu/qemu_capabilit=
ies.c#L5406
>
>> > Even if we had a QAPI schema that didn't vary per target, this is
>> > repeated probing is tricky to avoid when we have completely independant
>> > binaries. We would need QEMU to have some internal "build id", so that
>> > we could detect that all binaries came from the same build, to let us
>> > avoid re-probing each binary.
>>=20
>> Back when I created QAPI/QMP introspection, I floated the idea to put
>> something into the QMP greeting to enable safe caching.  Libvirt
>> developers told me they didn't need that.  I don't remember the details,
>> but I guess the cache invalidation they already had was deemed good
>> enough.
>
> I don't recall that discussion, but I would think the problem is
> that we probe much more than just QMP schema. Actually thinking
> about it, the fact that we probe more than just QMP schema means
> my idea of probing once and getting the answer for all targets
> may not be practical. Some of the query-xxx  commands we run will
> likely need to know the target.

Yes.

We could split the cache along validity conditions.  Possibly worth the
extra complexity if expensive probes then live longer in their cache.

I'd love to have a list of probes libvirt runs and why.


