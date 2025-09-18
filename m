Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18FDCAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzCvt-0006DS-4v; Thu, 18 Sep 2025 07:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzCvp-0006Ca-VW
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzCvj-0002fX-5o
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758195361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QU/YoucVmSowqcykjnJ5727vx7xnZB1OmebcU1I5b/E=;
 b=fJhfzj6SugD5EiH2qbvkuOb5LfMUZ4abiEdW5w8xOrkIxh9UrS9tXZHGi7njqSsIdEPbgv
 ZGB4pKnst4/IO/So8PwBeinIOsBysRqC08yhuqLr6daOM5pnWk3O/UUtEBQLKApN7AsRpz
 YlYACifzZ9rLNNhPAOfS8ceAk4bqhL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-3F3hnGVyNmSVr9gsznrvNg-1; Thu,
 18 Sep 2025 07:36:00 -0400
X-MC-Unique: 3F3hnGVyNmSVr9gsznrvNg-1
X-Mimecast-MFC-AGG-ID: 3F3hnGVyNmSVr9gsznrvNg_1758195359
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39D96180057C; Thu, 18 Sep 2025 11:35:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 931351800452; Thu, 18 Sep 2025 11:35:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A83F21E6A27; Thu, 18 Sep 2025 13:35:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH <RFC> 00/15] Encode object type security status in code
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 9 Sep 2025 17:57:11
 +0100")
References: <20250909165726.3814465-1-berrange@redhat.com>
Date: Thu, 18 Sep 2025 13:35:56 +0200
Message-ID: <87jz1wat7n.fsf@pond.sub.org>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Our docs/system/security.rst file loosely classifies code into that
> applicable for 'virtualization' vs 'non-virtualization' use cases.
> Only code relevant to the former group is eligible for security
> bug handling. Peter's recent proposal pointed out that we are
> increasingly hitting the limits of such a crude classification:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01520.html

Yes, we do.

> Michael suggested that with the increased complexity, docs are not
> going to be an effective way to convey the information, and we
> need to re-consider embedding this info in code:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01566.html
>
> This also allows users to validate a configuration's security status
> when starting a guest, or modifying a running guest. This series is
> an attempt to start the embedding process.

I like the idea.

We have a long list of configuration choices that might / are known to
punch holes into security boundaries.  Documenting them is entirely
inadequate; telling users who got p0wned it's their own fault for having
missed this particlar drop in the sea of QEMU documentation reminds me
of Douglas Adams' =E2=80=9CBeware of The Leopard=E2=80=9C.

And we don't have even that!  Just handwavy talk about a "virtualization
use case".

We can and should do better.

> It starts with QOM, adding "bool secure" and "bool insecure"
> properties to the TypeInfo struct, which get turned into flags
> on the Type struct. This enables querying any ObjectClass to
> ask whether or not it is declared secure or insecure.

We should clearly document what "declared secure" actually means.
Here's my attempt at it: supported for use cases that require certain
security boundaries.

> By default no statement will be made about whether a class is
> secure or insecure, reflecting our historical defaults. Over
> time we should annotate as many classes as possible with an
> explicit statement.
>
> The "-machine" argument gains two new parameters
>
>   * prohibit-insecure=3Dyes|no  - a weak security boundary, only
>     excluding stuff that is explicitly declared insecure,
>     permiting stuff that is secure & anything without a stetement

This isn't what users need.

>   * require-secure=3Dyes|no - a strong security boundary, only
>     permitting stuff that is explicitly declared secure,
>     excluding insecure stuff & anything without a statement

This would be, if it covered everything accessible at the security
boundaries.  It doesn't for now: only QOM.

It might still be better than nothing.

However, it may well be unusable until enough of QOM is declared secure.

What would our advice to users be?  I'm afraid something complicated and
impermanent like "try require-secure=3Dyes, and if you can't make it work
because parts of QOM you can't do without are still undeclared, fall
back to prohibit-insecure=3Dyes, and be aware this avoids only some, but
not all security boundary death traps in either case."

This is an awful user interface.  But it's also a step towards the user
interface we want: a single, unchanging switch that ensures you're
running something that's fully supported for use cases that require
certain security boundaries.

A next step could be getting enough of QOM declared so we can move to a
single switch, with the (hopefully temporary) caveat about "only QOM".

We should clearly and prominently document the limitations at each step.

> As illustration, I have added explicit annotations for many machine
> types, some accelerators, all NICs (all insecure except xen,
> e1000(e) and virtio), and all PCI virtio devices (all secure).
>
> Example: TCG is explicitly insecure, KVM is explicitly secure,
>          qtest has no statement:
>
>   $ qemu-system-x86_64 -display none -machine pc,prohibit-insecure=3Dyes =
-accel tcg
>   qemu-system-x86_64: Type 'tcg-accel' is declared as insecure

[...]

> Some questions....
>
>   * Is using '-machine' the right place to express the policy ?

Not sure.  The guest boundary is just one of several security boundaries
listed in docs/system/security.rst.  Some of them aren't really about
the guest / the machine.

Maybe -compat?  It lets you exclude unstable or deprecated bits from the
user interface.  Feels similar to excluding insecure bits.

>   * Can we change '-accel help' to report 'secure' / 'insecure'
>     as we did for '-machine help' and '-device help'.

No idea, guess it's at worst a matter of shaving the yak?

>   * Should we have 'query-devices' for QMP to allow the 'secure'
>     or 'insecure' status to be queried for every device.
>
>   * Should we have 'query-accel' for QMP to allow the 'secure'
>     or 'insecure' status to be queried for every accelerator.

I recommend qom-list-types.  Covers all of QOM, not just devices and
accelerators.

>   * Should we enforce checks for -object & object_add too ?
>     Easy to add code for this, but do we need the ability to
>     exclude some object backends of dubious code quality ?
>
>   * Likewise for -chardev / -netdev / etc which are
>     conceptual specializations of -object

I lean towards all of QOM, no ifs, no buts.

>   * BlockDriver structs don't use QOM, so we can't mark
>     'vvfat' block backend as insecure

I think this is the biggest gap.

> The first one about '-machine' is probably the main blocker
> from a design POV. Other things are just potential future
> incremental work.
>
> This series has had only 1/2 a day's work / thought put into
> it, hence RFC status. It has been compiled and minimally tested
> with the examples shown above. I have not pushed this through
> CI nor considered tests yet. Still it gives a good illustration
> of what's involved in recording security info in code.

Thanks for that!


