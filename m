Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E4AEFCD9F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztnv-0003SW-Mh; Tue, 10 Mar 2026 05:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vztna-0003FT-5W
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vztnW-0003j3-KD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773136479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Hb08Ms/KXPIT8Y0ejQz94Bme99JBtRbFImSXHsoMIQ=;
 b=Oa09/qZHzH6K806Z2oRQ4cbi6WprC02mPG9NJOWsU6uQEDIDxgJoSxxGsI8SSoEPNdY/bM
 3sVuCM1vaIW20znlIcFHfHq6LSlHOOYRwxFALHk9NZ067a//sBWJFyVWj35jaOpc4KRdNh
 uOSRRJ3WjyEqQYJ0bfrm9dyPU1pB8oU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-FTCqkxgSNDG5L8GpInmM3Q-1; Tue,
 10 Mar 2026 05:54:36 -0400
X-MC-Unique: FTCqkxgSNDG5L8GpInmM3Q-1
X-Mimecast-MFC-AGG-ID: FTCqkxgSNDG5L8GpInmM3Q_1773136475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 187BF19560B4; Tue, 10 Mar 2026 09:54:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C930B19560A6; Tue, 10 Mar 2026 09:54:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6014921E681B; Tue, 10 Mar 2026 10:54:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org,  qemu-arm@nongnu.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Gaurav Sharma
 <gaurav.sharma_7@nxp.com>
Subject: Re: [PATCH 2/5] hw/arm/fsl-imx8mp: Fix parent of ocram memory region
In-Reply-To: <20260308203516.160103-3-shentey@gmail.com> (Bernhard Beschow's
 message of "Sun, 8 Mar 2026 21:35:13 +0100")
References: <20260308203516.160103-1-shentey@gmail.com>
 <20260308203516.160103-3-shentey@gmail.com>
Date: Tue, 10 Mar 2026 10:54:29 +0100
Message-ID: <871phsm2lm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Bernhard Beschow <shentey@gmail.com> writes:

> Rather than having a NULL parent, let the containing SoC object be the
> parent. This cleans up the QOM composition tree a bit.
>
> Fixes: 1aaf3478684f ("hw/arm/fsl-imx8mp: Add on-chip RAM")
> cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/fsl-imx8mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 0119a18416..839c925e4a 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -671,7 +671,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>                      fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
>  
>      /* On-Chip RAM */
> -    if (!memory_region_init_ram(&s->ocram, NULL, "imx8mp.ocram",
> +    if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram",
>                                  fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
>                                  errp)) {
>          return;

This moves /machine/unattached/imx8mp.ocram[0] to
/machine/soc/imx8mp.ocram[0], as expected.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Aside: not sure why [0].  Might just be something memory regions do.


