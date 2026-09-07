Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F047C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WlE-0003ei-5r; Mon, 07 Sep 2026 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x3WlC-0003eS-Lb
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:39:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x3WlA-0004uu-V3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:39:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so28554075e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788777571; x=1789382371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TseOwv8MYTj638uNtPLWiTwmY4br7d8HoZr7qfEC6WU=;
 b=EmWuvSKlYIKatjZ4jfpTca+YM+gw/iLzdU4oNv3MF5qeYezH7aW0emKA9XChYGG+ae
 lqbXiJOAToDvE8Cr7OX37LY12lJ4XocGi1bMn/CM7oRqTutzs6MGhWPShbt2EWcXD9Bl
 x76Est3eq07SU2lkm4O3XVamUhy7JCz7ejTOBqTObXiiKn6+2Rlos1qwgUtazwBA7c1Z
 fbAfPjZh7DTqIOVjZm8BfEOwIJ2TZLKB/LjFYZg4Y0Ls661fOttMkpxS4vFZS/J0zRNO
 soE/dZIYT4/R47ZvLIBk8wfjsP1xYSC6nVKPYiN9S/Y9PbEW+N9ifCr9mpDglO/D4xnm
 iFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788777571; x=1789382371;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TseOwv8MYTj638uNtPLWiTwmY4br7d8HoZr7qfEC6WU=;
 b=Ur3DmJYhF859nD4AXf2wIBwiZNp4JFzClRWFvaPJhQRl5YUPwxbiUgYHNw9gf7ccpj
 NHJ3K9AE8Kb2uCYwI6W2fbAPHFNTAAkVmpcCwYl8apV/LCBVmqjj7oNNXQxe0Nps0AFx
 kk4nBZlufVsvD7f7Bfo3G7DszNSDbZQOA0ugayQjg6QJEOcMEk0hg8Gtu7ulrwLpmbxj
 sYCrHQSbSFk0GuUnEtaemOtBQVCRImd3JmR9W4xnH9D0ClDUdv2ZwEk5Vxu7P+LSYR4j
 HsH4helSkUIhtqh2lkeTzYXACLE9cY+kMr7KoOWivMpmhFlNU3I/briILuzVMF60NaDu
 V2vA==
X-Gm-Message-State: AFuF++m1gMTVOV7KshmU5WjFqlcxbFQKK8wdpVTVUHQZ20iNGATW7aJU
 72cebJrpfehOdfRwn9eMxpewNcJK8GFXQbNSj3ezhvPqVe8x3CDam6OSsMiGLw==
X-Gm-Gg: AYBFou2rQDFh+/kKyJxxTLF64XQvoab4Qj3DOADr9o1ZLOC3hZjKg4VFWyZf74He50A
 WLhXI6b8xehWIFqgtpodlBtaObt+lAVbt9qZCJuy5yP9L29MLMg2rc9M1kG7t9avK53Q+7MB3tq
 jiUiSHzC0wMMT8TkK9nsYZmmxQMsAGxgATdJM8LmNS0qVrqKrSA189M2utZkYCAUXI6mZrnaqFP
 P/DQ1z4xbeLavnAfQ1DnKA4oD3Apmenz4+IXNbOpwndSLmZq+88EiJvo91wIp/eQutY1UCuApX9
 pr9SqWSF97h81UCudvGEinyTvAVhAERMtHqJ+OZ8TI1C9qQfxgXowYdB7Jplta4wwK21qeXxBVU
 Yz6VoGRcw+7rGwXLjg0i3d0609ZpahnNchLI6aiQGmNwSJZHPjBjtOceZ8Xu7SRsHw1AcbZRlu2
 Fc/B5E5KazJ3ONPHtwxTlclyP/8rPehcFdhbtSMr8RsDsIUUgGqUoAMlmgQ+3Qbix2SQ==
X-Received: by 2002:a05:600c:620d:b0:49c:fc6e:a3d6 with SMTP id
 5b1f17b1804b1-49cfc6ea731mr183526395e9.21.1788777570925; 
 Mon, 07 Sep 2026 03:39:30 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbe5b252sm257651545e9.3.2026.09.07.03.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 03:39:30 -0700 (PDT)
Date: Mon, 07 Sep 2026 10:39:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv2_5/7=5D_hw/misc=3A_Extend_i=2EM?=
 =?US-ASCII?Q?X8MP_CCM_with_Cortex-M7_clock_outputs?=
In-Reply-To: <20260706162859.3361063-6-gaurav.sharma_7@nxp.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <20260706162859.3361063-6-gaurav.sharma_7@nxp.com>
Message-ID: <D5DF3DD1-C868-449F-B75A-0EA54DBC4716@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 6=2E Juli 2026 16:28:57 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@nx=
p=2Ecom>:
>Add cm7_cpuclk (24 MHz) and cm7_refclk (32=2E768 kHz) clock outputs
>to the i=2EMX8MP CCM=2E These are required by the ARMv7M model to boot
>the Cortex-M7 core in an AMP configuration=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/misc/imx8mp_ccm=2Ec         | 9 +++++++++
> include/hw/misc/imx8mp_ccm=2Eh | 3 +++
> 2 files changed, 12 insertions(+)
>
>diff --git a/hw/misc/imx8mp_ccm=2Ec b/hw/misc/imx8mp_ccm=2Ec
>index 911911ed86=2E=2E5530c924b5 100644
>--- a/hw/misc/imx8mp_ccm=2Ec
>+++ b/hw/misc/imx8mp_ccm=2Ec
>@@ -12,17 +12,24 @@
> #include "qemu/log=2Eh"
>=20
> #include "hw/misc/imx8mp_ccm=2Eh"
>+#include "hw/core/qdev-clock=2Eh"
> #include "migration/vmstate=2Eh"
>=20
> #include "trace=2Eh"
>=20
> #define CKIH_FREQ 16000000 /* 16MHz crystal input */
>=20
>+#define IMX8MP_CM7_CPUCLK_HZ 24000000ULL   /* osc_24m */
>+#define IMX8MP_CM7_REFCLK_HZ 32768ULL      /* osc_32k */
>+
> static void imx8mp_ccm_reset(DeviceState *dev)
> {
>     IMX8MPCCMState *s =3D IMX8MP_CCM(dev);
>=20
>     memset(s->ccm, 0, sizeof(s->ccm));
>+
>+    clock_set_hz(s->cm7_cpuclk, IMX8MP_CM7_CPUCLK_HZ);
>+    clock_set_hz(s->cm7_refclk, IMX8MP_CM7_REFCLK_HZ);
> }
>=20
> #define CCM_INDEX(offset)   (((offset) & ~(hwaddr)0xF) / sizeof(uint32_t=
))
>@@ -88,6 +95,8 @@ static void imx8mp_ccm_init(Object *obj)
>     SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);
>     IMX8MPCCMState *s =3D IMX8MP_CCM(obj);
>=20
>+    s->cm7_cpuclk =3D qdev_init_clock_out(DEVICE(obj), "cm7_cpuclk");
>+    s->cm7_refclk =3D qdev_init_clock_out(DEVICE(obj), "cm7_refclk");
>     memory_region_init_io(&s->iomem,
>                           obj,
>                           &imx8mp_set_clr_tog_ops,
>diff --git a/include/hw/misc/imx8mp_ccm=2Eh b/include/hw/misc/imx8mp_ccm=
=2Eh
>index 685c8582ff=2E=2Ec6ede6928c 100644
>--- a/include/hw/misc/imx8mp_ccm=2Eh
>+++ b/include/hw/misc/imx8mp_ccm=2Eh
>@@ -9,6 +9,7 @@
> #ifndef IMX8MP_CCM_H
> #define IMX8MP_CCM_H
>=20
>+#include "hw/core/clock=2Eh"
> #include "hw/misc/imx_ccm=2Eh"
> #include "qom/object=2Eh"
>=20
>@@ -25,6 +26,8 @@ struct IMX8MPCCMState {
>     MemoryRegion iomem;
>=20
>     uint32_t ccm[CCM_MAX];
>+    Clock *cm7_cpuclk;
>+    Clock *cm7_refclk;
> };
>=20
> #endif /* IMX8MP_CCM_H */

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


