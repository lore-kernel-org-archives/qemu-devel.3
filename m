Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbsJ-00005r-PB; Wed, 07 Aug 2024 04:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbbsG-0008VB-CE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbbsE-0006uj-BJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723018700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vttY/uaJ+UH3LHs5eQ3aDkplMRCzoK0Ppj7VJj5eU1A=;
 b=iAS2LT6wHICNrBFtdfqCU4w6iPdxck7TWU6Alzi49x5dDyrPBMR0lRHPHPXhskfaU1vcus
 RPbnM3pBmV8Tkb8PZQD5oo9z/XfbvgrGmam/mMw2nskJqv4l8FJOe0TUjyfI+zpt219ADH
 8TvHkF8hetnFKWRtHoATRPtbXegyi5M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-8op4HBrsOEeD4B79ovYmvA-1; Wed,
 07 Aug 2024 04:18:17 -0400
X-MC-Unique: 8op4HBrsOEeD4B79ovYmvA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CD651955F33; Wed,  7 Aug 2024 08:18:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1C011953BB7; Wed,  7 Aug 2024 08:18:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7CFB521E668F; Wed,  7 Aug 2024 10:18:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
In-Reply-To: <20240806141940.22095-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 6 Aug 2024 16:19:40
 +0200")
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-3-philmd@linaro.org>
Date: Wed, 07 Aug 2024 10:18:12 +0200
Message-ID: <87o764yce3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> When configuring QEMU with --without-default-devices and
> not including machines using a GIC, the GIC model is not
> built in but the 'query-gic-capabilities' command still
> returns false hopes about GIC:
>
>   {"execute": "query-gic-capabilities"}
>   {"return": [{"emulated": true, "version": 3, "kernel": false}, {"emulat=
ed": true, "version": 2, "kernel": false}]}
>
> Restrict the command to when the GIC is available. If it
> isn't we'll get:
>
>   { "execute": "query-gic-capabilities" }
>   {"error": {"class": "CommandNotFound", "desc": "The command query-gic-c=
apabilities has not been found"}}
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2484
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  qapi/misc-target.json | 4 ++--
>  hw/intc/arm_gic_qmp.c | 2 ++
>  hw/intc/meson.build   | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 8d70bd24d8..b857e44c2e 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -316,7 +316,7 @@
>    'data': { 'version': 'int',
>              'emulated': 'bool',
>              'kernel': 'bool' },
> -  'if': 'TARGET_ARM' }
> +  'if': 'CONFIG_ARM_GIC' }
>=20=20
>  ##
>  # @query-gic-capabilities:
> @@ -335,7 +335,7 @@
>  #                     { "version": 3, "emulated": false, "kernel": true =
} ] }
>  ##
>  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
> -  'if': 'TARGET_ARM' }
> +  'if': 'CONFIG_ARM_GIC' }
>=20=20
>  ##
>  # @SGXEPCSection:
> diff --git a/hw/intc/arm_gic_qmp.c b/hw/intc/arm_gic_qmp.c
> index 71056a0c10..1fc79c775b 100644
> --- a/hw/intc/arm_gic_qmp.c
> +++ b/hw/intc/arm_gic_qmp.c
> @@ -6,6 +6,8 @@
>=20=20
>  #include "qemu/osdep.h"
>  #include "qapi/util.h"
> +
> +#include CONFIG_DEVICES

Uh, why do we need this now?

>  #include "qapi/qapi-commands-misc-target.h"
>  #include "kvm_arm.h"
>=20=20
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index 45d3503d49..b9550967e2 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -39,7 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
>  endif
>=20=20
>  specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_comm=
on.c'))
> -specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
> +specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gic_qmp.c'))
>  specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_=
common.c'))
>  specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_=
cpuif.c'))
>  specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.=
c'))


