Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A234C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 19:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc8CL-0004Qa-TQ; Wed, 16 Jul 2025 15:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uc8CF-0004OT-8K; Wed, 16 Jul 2025 15:53:43 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uc8CD-00076t-6H; Wed, 16 Jul 2025 15:53:43 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae9c2754a00so36347366b.2; 
 Wed, 16 Jul 2025 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752695618; x=1753300418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=EpcnJSl3lxpbh2/i58SbVVgDVACLQgiYDkz9zW3X47w=;
 b=eNaDffKukWNqAkogPtLdzijBjE4FvQYYj7j0Y6ykyOqbuq/0VEzYUpdPjqbYyZqopH
 yDSO8bp92BcP9fXuckwkGZgHeVp+e16kyI3KCtFGi0ARtNlZkesupezYIgrE4zOA/48u
 jgNiOZNum7q6Hdcj2lOBODkbR/06Y9RCutz8VG6bXm55FnxRWl/miPXe2Cs9Ockh0bp5
 Db14h+ljlcSS60kSwwPqLomQjpTasMyzXFFMDQJ6L5h7bz/hjFLomOAiZpE44sIUr+UX
 EPFpuIUeyo8b5ZLkxWABptvjT6fIZ1jxGBH1m4AQl3GergHDXimd7SCxfeqHzzNkc9j6
 914Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752695618; x=1753300418;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpcnJSl3lxpbh2/i58SbVVgDVACLQgiYDkz9zW3X47w=;
 b=TgV9yM0EssRdyVO1InPT5RwMwJvWYsw44Tw935hKO14x3D+L82VK0UMxFPXuDiCavU
 INua6oUUoYTEqLWRZU/+FumG42FQPTa0YZQnntkiBPrtGUI39Tm7t3ytHKiyyMyTzWeg
 QfF5rNtCcWVqFSAy1NlPTtazSG7xekmlzcFzzg4vF6Sgckw/uIyLZNynAAD5jhDQcUSx
 J+Frz9L5USEuTtkMzG3k9hFCd9SBke7ui/59/j0S6iSu6OSgkVRMd0gE/k/NVlQWuZfL
 W22RFqjWo5dhwr+z5SPLvVO9RZm7xYeYWK2gwS5V6bqGy1x/QR6UgF6u5alqopzG4FV4
 zKiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFJMokfcSUDmS8dqQVO6DOrYObIleAw9ud6timoEcvsK2ebk5XcV6V4U71kIxv43/A2g9Mu+aahQ==@nongnu.org
X-Gm-Message-State: AOJu0YxMsGdsomHxSjT+TCkEI1zp5Df7Mfnh2C/3kttpUmHqNJx7Y0pV
 R5IJ1WHWjNtcrh3TWeLmbJQw0O53vyWQ8g7krQ20/riKWGTj/2sJZDGi0R0SJA==
X-Gm-Gg: ASbGncuspUEue1/MyTjPBLvmnCsvGdiOfT5c9ZHxFkYPeEyCEdkPpNUMtIUEyYoNSMB
 1hlwzZpJMN4SKnHeu3Ae68qoxXaF3ybnV7FlhvcFts+zjhuRAnCywiLu1UxGobGiSKa4LWL7qnK
 iX6bg4eUvVYtywF/qD4naONLb1LZRAomqG98/papsNC5QLEEX8z/YNqo1deoAIhwxQopadQrhmR
 pPiV+7obLp6E3euWfUuN6BiXn/MOW7Fy7zPG9+f6qd10WSt62VIG9haBhRkemJfsAREn1iCydO1
 BGjO5Br3w18ifbG2tommcBHxFqAJv9I28/E0rL+ntAe6B4E9orulPsYseBFJrodrMfWT2HXf6SL
 n+JUltl5JYf0jDWRlWDP38yYUkEhuzrvfb1XxDJqRsYM1LRgf21BbTzxCOJ7EcBqOsvtElr2hcT
 on1sTWFZ9kdCjIhjqlY7Zqe7BhX8xNAA==
X-Google-Smtp-Source: AGHT+IHcMGtuzOp2u/skIaH40mSQ+Xv9Km6EJSfl311JODYAxQioVScm2UMt8+AkVOIgFWuEYdf4wA==
X-Received: by 2002:a17:907:1b02:b0:ae0:1fdf:ea65 with SMTP id
 a640c23a62f3a-aec4fa9542fmr26736766b.17.1752695618086; 
 Wed, 16 Jul 2025 12:53:38 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-189e-df00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:189e:df00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82df56esm1241389366b.156.2025.07.16.12.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 12:53:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:53:10 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, zhangzhijie <zhangzhijie@bosc.ac.cn>,
 zhangzhijie@bosc.ac.cn, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
 peter.maydell@linaro.org, andrew.smirnov@gmail.com, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_PCIE-Host_Support_64?=
 =?US-ASCII?Q?Bit_resource_for_DesignwarePCIEHost?=
In-Reply-To: <20250715064400.2289152-1-zhangzhijie@bosc.ac.cn>
References: <20250715064400.2289152-1-zhangzhijie@bosc.ac.cn>
Message-ID: <631BA6B2-268F-4DDC-9DA6-77697373A5DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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



Am 15=2E Juli 2025 06:44:00 UTC schrieb zhangzhijie <zhangzhijie@bosc=2Eac=
=2Ecn>:
>0=2E DW pcie support 64bit resource
>1=2E DW version type using Linux kernel

Which machines in QEMU require this change?

>
>Signed-off-by: zhangzhijie <zhangzhijie@bosc=2Eac=2Ecn>
>---
> hw/pci-host/designware=2Ec         | 12 +++++++++---
> include/hw/pci-host/designware=2Eh |  2 +-
> 2 files changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/hw/pci-host/designware=2Ec b/hw/pci-host/designware=2Ec
>index f6e49ce9b8=2E=2E99d791c0a7 100644
>--- a/hw/pci-host/designware=2Ec
>+++ b/hw/pci-host/designware=2Ec
>@@ -41,6 +41,8 @@
> #define DESIGNWARE_PCIE_MSI_INTR0_ENABLE           0x828
> #define DESIGNWARE_PCIE_MSI_INTR0_MASK             0x82C
> #define DESIGNWARE_PCIE_MSI_INTR0_STATUS           0x830
>+#define PCIE_VERSION_NUMBER                        0x8F8
>+#define PCIE_VERSION_TYPE                          0x8FC
> #define DESIGNWARE_PCIE_ATU_VIEWPORT               0x900
> #define DESIGNWARE_PCIE_ATU_REGION_INBOUND         BIT(31)
> #define DESIGNWARE_PCIE_ATU_CR1                    0x904
>@@ -144,6 +146,10 @@ designware_pcie_root_config_read(PCIDevice *d, uint3=
2_t address, int len)
>     uint32_t val;
>=20
>     switch (address) {
>+    case PCIE_VERSION_NUMBER:
>+    case PCIE_VERSION_TYPE:
>+        val =3D 0x3534302a;
>+        break;
>     case DESIGNWARE_PCIE_PORT_LINK_CONTROL:
>         /*
>          * Linux guest uses this register only to configure number of
>@@ -427,7 +433,7 @@ static void designware_pcie_root_realize(PCIDevice *d=
ev, Error **errp)
>         viewport->inbound =3D true;
>         viewport->base    =3D 0x0000000000000000ULL;
>         viewport->target  =3D 0x0000000000000000ULL;
>-        viewport->limit   =3D UINT32_MAX;
>+        viewport->limit   =3D UINT64_MAX;
>         viewport->cr[0]   =3D DESIGNWARE_PCIE_ATU_TYPE_MEM;
>=20
>         source      =3D &host->pci=2Eaddress_space_root;
>@@ -451,7 +457,7 @@ static void designware_pcie_root_realize(PCIDevice *d=
ev, Error **errp)
>         viewport->inbound =3D false;
>         viewport->base    =3D 0x0000000000000000ULL;
>         viewport->target  =3D 0x0000000000000000ULL;
>-        viewport->limit   =3D UINT32_MAX;
>+        viewport->limit   =3D UINT64_MAX;
>         viewport->cr[0]   =3D DESIGNWARE_PCIE_ATU_TYPE_MEM;
>=20
>         destination =3D &host->pci=2Ememory;
>@@ -558,7 +564,7 @@ static const VMStateDescription vmstate_designware_pc=
ie_viewport =3D {
>     =2Efields =3D (const VMStateField[]) {
>         VMSTATE_UINT64(base, DesignwarePCIEViewport),
>         VMSTATE_UINT64(target, DesignwarePCIEViewport),
>-        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
>+        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
>         VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
>         VMSTATE_END_OF_LIST()
>     }
>diff --git a/include/hw/pci-host/designware=2Eh b/include/hw/pci-host/des=
ignware=2Eh
>index a35a3bd06c=2E=2E6e06f54801 100644
>--- a/include/hw/pci-host/designware=2Eh
>+++ b/include/hw/pci-host/designware=2Eh
>@@ -46,7 +46,7 @@ typedef struct DesignwarePCIEViewport {
>=20
>     uint64_t base;
>     uint64_t target;
>-    uint32_t limit;
>+    uint64_t limit;
>     uint32_t cr[2];
>=20
>     bool inbound;

