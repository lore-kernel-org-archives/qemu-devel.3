Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C0AC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17AZ-0008Kl-B5; Mon, 31 Aug 2026 14:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x17AR-0008Jm-BV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:55:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x17AP-0007oo-Ix
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:55:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so30319625e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788202536; x=1788807336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gC+tpT2+VzMPxGxnD6QtX8E9t2iaBaNxWx6QU72GY/U=;
 b=Lzu20gxrZHGfTYKeqkJluK/I+9yZ+zNU5N5UIlxxVEmcDZjOsw+dC7F8xp7T+kUhwr
 ruMnFzdFghLRdNOo3vhEUpcl5cnwVQK7avrdsGCuJX57uqBeQ0AktxArwyL3qRl9QyPJ
 +aIJCQSbQ7+TXKVgluebct+LHeGV1NA8VTw2+IS9c1PeR+r5ernv75jOOFBSdWDVuFOZ
 /S/lFzHRrUNZuN5ALtdt6ASUIJywHHjUAnVfVaL44Y+8DoK1ygdfWUaFKTu5pTo6NGSD
 5lU02+YkPnfWb6En3uNsVqGhgkudvz3ZqGX0SDZ/fQpa6XAqwJpjk8C5p/wKuyd2vsB6
 EteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202536; x=1788807336;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gC+tpT2+VzMPxGxnD6QtX8E9t2iaBaNxWx6QU72GY/U=;
 b=nUCvjc9CuzpYpYdtPWQ6g3wtVIKd1Xt8TLYxcs/ATlaSF66nrF7EEOB/Ii+r1vP075
 G7KyKDJ4htN6/g8rVRFG/JOWVlOstdrJNxz5VCfgGfxnVIdUbW2NgRjPgjNvn7FnKVs9
 4sTCdyYcwGI+xSyPPXt3E3bVemTSSVZafhiBoZuAaiWr0U4rVWVcSgaoSRDsag/9Kcou
 xXtkBZuOw3C/lWyPA4DhLWgx4PQEYL3XBCMzmurQ0NVGD/KnHm/mIv00Ch75GRmiTOue
 1SztedUGRCPldVxm9fTXbbLHsDYIR3FCtUQUwd2lswLUvW2vXmKEULVwfqBMQS7qH9zD
 /UTA==
X-Gm-Message-State: AFuF++lgsVjbIALSqD1+zJdIG+BrQLL9Wg4+K1KGCtGH9PmBqal4CfUj
 wPRqojM+pjdXiK8lFRj4Y0f9UyqsjBeqrH+/sSrLiwJgioymgokU85xh7LMmhw==
X-Gm-Gg: AR+sD11Ny8nmWzBCiM9gesYAD3cb67p3UDhcjLtzj2CDffjF4V+li4ObCIY1I1YOYkn
 AsWL6vkVNWLLZPyUctUlIb1OfePqdbIhbXFBod4/O/8f/4TH3DfYcfFt7acmqFxJeEHlKUiAJkY
 5aNMQmYCbDczVGFV15+MUooNLJ8jy5O+y5RKo6OrmAUYCJ13FSbZqqcb35VuyDeuyfQyo6PNBsB
 JY1bKE/mOxdz9RpyTjSYDEJzlrFuz1U/Y/s/i/ql2RkAjBE9cawPnLg93h/RzAU7CT65D7iYY78
 V/g/fFyaO3XWA/R/kCXZYt6RwZZAkmSgP8hby+UUFS9ArdFXaxjwXXGXbAfHINPqcYJNgNJqSk/
 +ZgGVvAdF3EMkHv4mfDKF9rA8tUlR7azcBcbYTGQRAvuuPuKYYy6Ifw+T+0LVa0a5jA8NdOkhWw
 Rxjzb5JqEOkNn3TKxn7YRr8iaAn8WDbWhT/1kqS281XIdssWOK0h0E7/U2meL1hXIf9VuMs9F6Q
 qusG9JUF0aVWgAuvN0baoxkmaT+2xMg0tf422m4sCX7HkDrXLNJbPow0rnVIxNWvIWVkOhH/V/0
 HV0OA9LXYw==
X-Received: by 2002:a05:600c:8581:b0:499:a760:722f with SMTP id
 5b1f17b1804b1-49b91c47bf8mr362424605e9.13.1788202535694; 
 Mon, 31 Aug 2026 11:55:35 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-290d-6700-d99b-d42d-2461-dbe0.310.pool.telefonica.de.
 [2a02:3100:290d:6700:d99b:d42d:2461:dbe0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce10153sm13250175e9.4.2026.08.31.11.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:55:35 -0700 (PDT)
Date: Mon, 31 Aug 2026 17:55:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv2_7/7=5D_tests/functional=3A_Enable_C?=
 =?US-ASCII?Q?ortex-M7_boot_in_i=2EMX8MP_EVK_functional_test?=
In-Reply-To: <20260706162859.3361063-8-gaurav.sharma_7@nxp.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <20260706162859.3361063-8-gaurav.sharma_7@nxp.com>
Message-ID: <5F842A4E-B642-41BB-BC19-8685F281D5F9@gmail.com>
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



Am 6=2E Juli 2026 16:28:59 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@nx=
p=2Ecom>:
>Update the i=2EMX8MP EVK functional test to enable the Cortex-M7 core
>by setting maxcpus=3D5 and enabling the fsl-imx8mp=2Eenable-cm7 property
>The i=2EMX8MP SoC model makes the Cortex-M7 optional and disabled by defa=
ult=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> MAINTAINERS                                 | 13 ++++---------
> tests/functional/aarch64/test_imx8mp_evk=2Epy |  1 -
> 2 files changed, 4 insertions(+), 10 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 97dcc78ded=2E=2Efe921a28de 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -921,29 +921,24 @@ F: hw/pci-host/designware=2Ec
> F: include/hw/pci-host/designware=2Eh
> F: docs/system/arm/mcimx7d-sabre=2Erst
>=20
>-MCIMX8MM-EVK / iMX8MM
>+MCIMX8MP-EVK / MCIMX8MM-EVK
>+M: Bernhard Beschow <shentey@gmail=2Ecom>
> M: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
> L: qemu-arm@nongnu=2Eorg
> S: Maintained
> F: hw/arm/fsl-imx8mm=2Ec
> F: hw/arm/imx8mm-evk=2Ec
>-F: include/hw/arm/fsl-imx8mm=2Eh
>-F: docs/system/arm/imx8m=2Erst
>-F: tests/functional/aarch64/test_imx8mm_evk=2Epy
>-
>-MCIMX8MP-EVK / i=2EMX8MP
>-M: Bernhard Beschow <shentey@gmail=2Ecom>
>-L: qemu-arm@nongnu=2Eorg
>-S: Maintained
> F: hw/arm/imx8mp-evk=2Ec
> F: hw/arm/fsl-imx8mp=2Ec
> F: hw/misc/imx8mp_*=2Ec
> F: hw/pci-host/fsl_imx8m_phy=2Ec
> F: hw/rtc/rs5c372=2Ec
>+F: include/hw/arm/fsl-imx8mm=2Eh
> F: include/hw/arm/fsl-imx8mp=2Eh
> F: include/hw/misc/imx8mp_*=2Eh
> F: include/hw/pci-host/fsl_imx8m_phy=2Eh
> F: docs/system/arm/imx8m=2Erst
>+F: tests/functional/aarch64/test_imx8mm_evk=2Epy
> F: tests/functional/aarch64/test_imx8mp_evk=2Epy
> F: tests/qtest/rs5c372-test=2Ec
>=20

This part LGTM, though the commit message should match=2E

>diff --git a/tests/functional/aarch64/test_imx8mp_evk=2Epy b/tests/functi=
onal/aarch64/test_imx8mp_evk=2Epy
>index 99ddcdef83=2E=2E6046c573d5 100755
>--- a/tests/functional/aarch64/test_imx8mp_evk=2Epy
>+++ b/tests/functional/aarch64/test_imx8mp_evk=2Epy
>@@ -53,7 +53,6 @@ def test_aarch64_imx8mp_evk_usdhc(self):
>         self=2Eset_machine('imx8mp-evk')
>         self=2Evm=2Eset_console(console_index=3D1)
>         self=2Evm=2Eadd_args('-m', '2G',
>-                         '-smp', '4',
>                          '-kernel', self=2Ekernel_path,
>                          '-initrd', self=2Einitrd_path,
>                          '-dtb', self=2Edtb_path,

This hunk should go into the new patch which fixes the SMP configuration=
=2E

Best regards,
Bernhard

