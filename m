Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C76C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 23:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfS8r-000430-Tg; Tue, 04 Feb 2025 18:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfS8l-00042m-8t; Tue, 04 Feb 2025 18:15:35 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfS8f-0001XI-K2; Tue, 04 Feb 2025 18:15:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso42415455e9.2; 
 Tue, 04 Feb 2025 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738710923; x=1739315723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gY2ZsjXbnReXt4sDNXUEFtp902QtoaizmLGoBHKmq0g=;
 b=NH16JiktPSp4QhdKWn8jJnWmHqonXQ1XlXt5JjL4W26H/Cq3bCY7kymT45jbXNt97i
 Nog1ely4LC1RnLLrHUHkXaNc8wilw5BWRPRm0YxNIYehyV/nagjxirVemPSvyaJWtzJd
 LvVoTtqHTyEladxcUb0JgBP6Nkr7pp3wiGLWlr+2/yHmsdBKigAYiRRS8ohk9scJmcfO
 CigC7wwAIxnQPuN8VFPoY7FrIlEXMZbVD72FWXPM9ojKVSkGEjO0FAurIcCVkb69BBR4
 6VjVsm8mEDk4jxmuhnMRx0sauHhXz42UDdj07/PW/ZLd9aQg/nTcIZlF8lwnSgWC9m/D
 LCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738710923; x=1739315723;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gY2ZsjXbnReXt4sDNXUEFtp902QtoaizmLGoBHKmq0g=;
 b=aJdPAqQVHhEPEpjiTclKTBJ8/Ir15wuaBPlRuagt5WzbXSMaiTdEfFCe6b38TkX+5g
 8hhoGemEGFKxvAhy4TNqRRYe6df/4NwpzDiKasrIf1tNhzVBpdfuaueVzmPgj/KyJxGe
 AU6TM+PPbKLKsYX3CVjgB48IeZk+H7HcRshixqkAeKdPrYun4oW6lYb+bbipb1HUIV8m
 kGpv/hb3OuTgEOGO644yWeiFBru6EPVQ0Y2/tS9MXp4yOId4aKspvGFVI6bczmiFl0wi
 HJPw0PmoM84BbGxYmhnUYMztt/LOK2asvPJfYe+J1jaWCbUx9r12fr4UWJuER4JHQ7oT
 R8Tw==
X-Gm-Message-State: AOJu0YxyXh4YMxpmFgKcC4s7JAjkmFNaNnsUr0X7Q5/t+L2Sdj7Gbl8k
 r7pVZfONCD+arruvPIkgfLJUVoGl/Atyq1DR0Y1PWDUc22pDEJ2UjsQjLA==
X-Gm-Gg: ASbGncuv3BdIKORT/WIuW7K4g+Ypq69B0lj+Yk13/GzgfUHcZhWqyxb1+K0J89eYh/D
 T+/RfyuP6dolcF5Wa78heN1Vnc4N89hEKHV/PgMpNWz8KgjWusXMgOyQFMpW1NLh0J9So/cNsMZ
 3298xYr9yrYnHvIUs+4XmIT79isgL52MEa1IP8rgsjIjlIlvdb6+SV0Wi4cgyHfbjrXO/gHsBZm
 5l0pvoEnJNke8JfI9NW1FsPJriDVUwIYYZK2b7Dl7gtVLzcSwPthOJ8Ui1UaZBVa8J4YWFFw8Aq
 Sw26QTny9cMTlhieRaBbLGpIcOTnFzJ5zK8j2VNpp9+khYokC9DmeqgGGyYoKtvRrjLKUyI27bA
 =
X-Google-Smtp-Source: AGHT+IFEyStvjLBJnGMkvwqQI/XoajJkZYnpwZS+149Kmb/aEQVOkxAa2wqE9qRTHDRWJzM2Lpj+2A==
X-Received: by 2002:a05:600c:1393:b0:434:fd01:2e5f with SMTP id
 5b1f17b1804b1-4390d56f60amr2784955e9.29.1738710923033; 
 Tue, 04 Feb 2025 15:15:23 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf004300f426c70552435424.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:f426:c705:5243:5424])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dadca52e6sm2753806f8f.0.2025.02.04.15.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 15:15:22 -0800 (PST)
Date: Tue, 04 Feb 2025 23:15:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/18] hw/arm/fsl-imx8mp: Implement clock tree
In-Reply-To: <20250204092112.26957-6-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-6-shentey@gmail.com>
Message-ID: <2BAFED29-A2FE-4B6B-BF47-114D2578D02D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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



Am 4=2E Februar 2025 09:20:59 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>Fixes quite a few stack traces during the Linux boot process=2E Also prov=
ides the
>clocks for devices added later, e=2Eg=2E enet1=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>---
> MAINTAINERS                     |   2 +
> docs/system/arm/imx8mp-evk=2Erst  |   1 +
> include/hw/arm/fsl-imx8mp=2Eh     |   4 +
> include/hw/misc/imx8mp_analog=2Eh |  81 +++++++++++++++
> include/hw/misc/imx8mp_ccm=2Eh    |  30 ++++++
> hw/arm/fsl-imx8mp=2Ec             |  20 ++++
> hw/misc/imx8mp_analog=2Ec         | 160 +++++++++++++++++++++++++++++
> hw/misc/imx8mp_ccm=2Ec            | 175 ++++++++++++++++++++++++++++++++
> hw/arm/Kconfig                  |   2 +
> hw/misc/Kconfig                 |   6 ++
> hw/misc/meson=2Ebuild             |   2 +
> 11 files changed, 483 insertions(+)
> create mode 100644 include/hw/misc/imx8mp_analog=2Eh
> create mode 100644 include/hw/misc/imx8mp_ccm=2Eh
> create mode 100644 hw/misc/imx8mp_analog=2Ec
> create mode 100644 hw/misc/imx8mp_ccm=2Ec
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 8db59114bc=2E=2E5b5b0d0bed 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -826,7 +826,9 @@ L: qemu-arm@nongnu=2Eorg
> S: Maintained
> F: hw/arm/imx8mp-evk=2Ec
> F: hw/arm/fsl-imx8mp=2Ec
>+F: hw/misc/imx8mp_*=2Ec
> F: include/hw/arm/fsl-imx8mp=2Eh
>+F: include/hw/misc/imx8mp_*=2Eh
> F: docs/system/arm/imx8mp-evk=2Erst
>=20
> MPS2 / MPS3
>diff --git a/docs/system/arm/imx8mp-evk=2Erst b/docs/system/arm/imx8mp-ev=
k=2Erst
>index a9c1fab390=2E=2Ee5039fc8c4 100644
>--- a/docs/system/arm/imx8mp-evk=2Erst
>+++ b/docs/system/arm/imx8mp-evk=2Erst
>@@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following dev=
ices:
>  * Up to 4 Cortex-A53 Cores
>  * Generic Interrupt Controller (GICv3)
>  * 4 UARTs
>+ * Clock Tree
>=20
> Boot options
> ------------
>diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=2E=
h
>index 57e23d1b69=2E=2Ece5188e7f2 100644
>--- a/include/hw/arm/fsl-imx8mp=2Eh
>+++ b/include/hw/arm/fsl-imx8mp=2Eh
>@@ -12,6 +12,8 @@
> #include "cpu=2Eh"
> #include "hw/char/imx_serial=2Eh"
> #include "hw/intc/arm_gicv3_common=2Eh"
>+#include "hw/misc/imx8mp_analog=2Eh"
>+#include "hw/misc/imx8mp_ccm=2Eh"
> #include "qom/object=2Eh"
> #include "qemu/units=2Eh"
>=20
>@@ -32,6 +34,8 @@ struct FslImx8mpState {
>=20
>     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
>     GICv3State         gic;
>+    IMX8MPCCMState     ccm;
>+    IMX8MPAnalogState  analog;
>     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
> };
>=20
>diff --git a/include/hw/misc/imx8mp_analog=2Eh b/include/hw/misc/imx8mp_a=
nalog=2Eh
>new file mode 100644
>index 0000000000=2E=2E955f03215a
>--- /dev/null
>+++ b/include/hw/misc/imx8mp_analog=2Eh
>@@ -0,0 +1,81 @@
>+/*
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * i=2EMX8MP ANALOG IP block emulation code
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#ifndef IMX8MP_ANALOG_H
>+#define IMX8MP_ANALOG_H
>+
>+#include "qom/object=2Eh"
>+#include "hw/sysbus=2Eh"
>+
>+enum IMX8MPAnalogRegisters {
>+    ANALOG_AUDIO_PLL1_GEN_CTRL =3D 0x000 / 4,
>+    ANALOG_AUDIO_PLL1_FDIV_CTL0 =3D 0x004 / 4,
>+    ANALOG_AUDIO_PLL1_FDIV_CTL1 =3D 0x008 / 4,
>+    ANALOG_AUDIO_PLL1_SSCG_CTRL =3D 0x00c / 4,
>+    ANALOG_AUDIO_PLL1_MNIT_CTRL =3D 0x010 / 4,
>+    ANALOG_AUDIO_PLL2_GEN_CTRL =3D 0x014 / 4,
>+    ANALOG_AUDIO_PLL2_FDIV_CTL0 =3D 0x018 / 4,
>+    ANALOG_AUDIO_PLL2_FDIV_CTL1 =3D 0x01c / 4,
>+    ANALOG_AUDIO_PLL2_SSCG_CTRL =3D 0x020 / 4,
>+    ANALOG_AUDIO_PLL2_MNIT_CTRL =3D 0x024 / 4,
>+    ANALOG_VIDEO_PLL1_GEN_CTRL =3D 0x028 / 4,
>+    ANALOG_VIDEO_PLL1_FDIV_CTL0 =3D 0x02c / 4,
>+    ANALOG_VIDEO_PLL1_FDIV_CTL1 =3D 0x030 / 4,
>+    ANALOG_VIDEO_PLL1_SSCG_CTRL =3D 0x034 / 4,
>+    ANALOG_VIDEO_PLL1_MNIT_CTRL =3D 0x038 / 4,
>+    ANALOG_DRAM_PLL_GEN_CTRL =3D 0x050 / 4,
>+    ANALOG_DRAM_PLL_FDIV_CTL0 =3D 0x054 / 4,
>+    ANALOG_DRAM_PLL_FDIV_CTL1 =3D 0x058 / 4,
>+    ANALOG_DRAM_PLL_SSCG_CTRL =3D 0x05c / 4,
>+    ANALOG_DRAM_PLL_MNIT_CTRL =3D 0x060 / 4,
>+    ANALOG_GPU_PLL_GEN_CTRL =3D 0x064 / 4,
>+    ANALOG_GPU_PLL_FDIV_CTL0 =3D 0x068 / 4,
>+    ANALOG_GPU_PLL_LOCKD_CTRL =3D 0x06c / 4,
>+    ANALOG_GPU_PLL_MNIT_CTRL =3D 0x070 / 4,
>+    ANALOG_VPU_PLL_GEN_CTRL =3D 0x074 / 4,
>+    ANALOG_VPU_PLL_FDIV_CTL0 =3D 0x078 / 4,
>+    ANALOG_VPU_PLL_LOCKD_CTRL =3D 0x07c / 4,
>+    ANALOG_VPU_PLL_MNIT_CTRL =3D 0x080 / 4,
>+    ANALOG_ARM_PLL_GEN_CTRL =3D 0x084 / 4,
>+    ANALOG_ARM_PLL_FDIV_CTL0 =3D 0x088 / 4,
>+    ANALOG_ARM_PLL_LOCKD_CTRL =3D 0x08c / 4,
>+    ANALOG_ARM_PLL_MNIT_CTRL =3D 0x090 / 4,
>+    ANALOG_SYS_PLL1_GEN_CTRL =3D 0x094 / 4,
>+    ANALOG_SYS_PLL1_FDIV_CTL0 =3D 0x098 / 4,
>+    ANALOG_SYS_PLL1_LOCKD_CTRL =3D 0x09c / 4,
>+    ANALOG_SYS_PLL1_MNIT_CTRL =3D 0x100 / 4,
>+    ANALOG_SYS_PLL2_GEN_CTRL =3D 0x104 / 4,
>+    ANALOG_SYS_PLL2_FDIV_CTL0 =3D 0x108 / 4,
>+    ANALOG_SYS_PLL2_LOCKD_CTRL =3D 0x10c / 4,
>+    ANALOG_SYS_PLL2_MNIT_CTRL =3D 0x110 / 4,
>+    ANALOG_SYS_PLL3_GEN_CTRL =3D 0x114 / 4,
>+    ANALOG_SYS_PLL3_FDIV_CTL0 =3D 0x118 / 4,
>+    ANALOG_SYS_PLL3_LOCKD_CTRL =3D 0x11c / 4,
>+    ANALOG_SYS_PLL3_MNIT_CTRL =3D 0x120 / 4,
>+    ANALOG_OSC_MISC_CFG =3D 0x124 / 4,
>+    ANALOG_ANAMIX_PLL_MNIT_CTL =3D 0x128 / 4,
>+
>+    ANALOG_DIGPROG =3D 0x800 / 4,
>+    ANALOG_MAX,
>+};
>+
>+#define TYPE_IMX8MP_ANALOG "imx8mp=2Eanalog"
>+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPAnalogState, IMX8MP_ANALOG)
>+
>+struct IMX8MPAnalogState {
>+    SysBusDevice parent_obj;
>+
>+    struct {
>+        MemoryRegion container;
>+        MemoryRegion analog;
>+    } mmio;
>+
>+    uint32_t analog[ANALOG_MAX];
>+};
>+
>+#endif /* IMX8MP_ANALOG_H */
>diff --git a/include/hw/misc/imx8mp_ccm=2Eh b/include/hw/misc/imx8mp_ccm=
=2Eh
>new file mode 100644
>index 0000000000=2E=2E685c8582ff
>--- /dev/null
>+++ b/include/hw/misc/imx8mp_ccm=2Eh
>@@ -0,0 +1,30 @@
>+/*
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * i=2EMX 8M Plus CCM IP block emulation code
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#ifndef IMX8MP_CCM_H
>+#define IMX8MP_CCM_H
>+
>+#include "hw/misc/imx_ccm=2Eh"
>+#include "qom/object=2Eh"
>+
>+enum IMX8MPCCMRegisters {
>+    CCM_MAX =3D 0xc6fc / sizeof(uint32_t) + 1,
>+};
>+
>+#define TYPE_IMX8MP_CCM "imx8mp=2Eccm"
>+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPCCMState, IMX8MP_CCM)
>+
>+struct IMX8MPCCMState {
>+    IMXCCMState parent_obj;
>+
>+    MemoryRegion iomem;
>+
>+    uint32_t ccm[CCM_MAX];
>+};
>+
>+#endif /* IMX8MP_CCM_H */
>diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>index 0836d82ca0=2E=2Ea1a8843b3b 100644
>--- a/hw/arm/fsl-imx8mp=2Ec
>+++ b/hw/arm/fsl-imx8mp=2Ec
>@@ -200,6 +200,10 @@ static void fsl_imx8mp_init(Object *obj)
>=20
>     object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
>=20
>+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
>+
>+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALO=
G);
>+
>     for (i =3D 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
>         snprintf(name, NAME_SIZE, "uart%d", i + 1);
>         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL)=
;
>@@ -308,6 +312,20 @@ static void fsl_imx8mp_realize(DeviceState *dev, Err=
or **errp)
>         }
>     }
>=20
>+    /* CCM */
>+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
>+        return;
>+    }
>+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
>+                    fsl_imx8mp_memmap[FSL_IMX8MP_CCM]=2Eaddr);
>+
>+    /* Analog */
>+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
>+        return;
>+    }
>+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
>+                    fsl_imx8mp_memmap[FSL_IMX8MP_ANA_PLL]=2Eaddr);
>+
>     /* UARTs */
>     for (i =3D 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
>         static const struct {
>@@ -333,6 +351,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
r **errp)
>     /* Unimplemented devices */
>     for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
>         switch (i) {
>+        case FSL_IMX8MP_ANA_PLL:
>+        case FSL_IMX8MP_CCM:
>         case FSL_IMX8MP_GIC_DIST:
>         case FSL_IMX8MP_GIC_REDIST:
>         case FSL_IMX8MP_RAM:
>diff --git a/hw/misc/imx8mp_analog=2Ec b/hw/misc/imx8mp_analog=2Ec
>new file mode 100644
>index 0000000000=2E=2E71333b3e9e
>--- /dev/null
>+++ b/hw/misc/imx8mp_analog=2Ec
>@@ -0,0 +1,160 @@
>+/*
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * i=2EMX 8M Plus ANALOG IP block emulation code
>+ *
>+ * Based on hw/misc/imx7_ccm=2Ec
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "qemu/log=2Eh"
>+
>+#include "hw/misc/imx8mp_analog=2Eh"
>+#include "migration/vmstate=2Eh"
>+
>+#define ANALOG_PLL_LOCK BIT(31)
>+
>+static void imx8mp_analog_reset(DeviceState *dev)
>+{
>+    IMX8MPAnalogState *s =3D IMX8MP_ANALOG(dev);
>+
>+    memset(s->analog, 0, sizeof(s->analog));
>+
>+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] =3D 0x00002010;
>+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL0] =3D 0x00145032;
>+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL1] =3D 0x00000000;
>+    s->analog[ANALOG_AUDIO_PLL1_SSCG_CTRL] =3D 0x00000000;
>+    s->analog[ANALOG_AUDIO_PLL1_MNIT_CTRL] =3D 0x00100103;
>+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] =3D 0x00002010;
>+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL0] =3D 0x00145032;
>+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL1] =3D 0x00000000;
>+    s->analog[ANALOG_AUDIO_PLL2_SSCG_CTRL] =3D 0x00000000;
>+    s->analog[ANALOG_AUDIO_PLL2_MNIT_CTRL] =3D 0x00100103;
>+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] =3D 0x00002010;
>+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL0] =3D 0x00145032;
>+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL1] =3D 0x00000000;
>+    s->analog[ANALOG_VIDEO_PLL1_SSCG_CTRL] =3D 0x00000000;
>+    s->analog[ANALOG_VIDEO_PLL1_MNIT_CTRL] =3D 0x00100103;
>+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] =3D 0x00002010;
>+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL0] =3D 0x0012c032;
>+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL1] =3D 0x00000000;
>+    s->analog[ANALOG_DRAM_PLL_SSCG_CTRL] =3D 0x00000000;
>+    s->analog[ANALOG_DRAM_PLL_MNIT_CTRL] =3D 0x00100103;
>+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] =3D 0x00000810;
>+    s->analog[ANALOG_GPU_PLL_FDIV_CTL0] =3D 0x000c8031;
>+    s->analog[ANALOG_GPU_PLL_LOCKD_CTRL] =3D 0x0010003f;
>+    s->analog[ANALOG_GPU_PLL_MNIT_CTRL] =3D 0x00280081;
>+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] =3D 0x00000810;
>+    s->analog[ANALOG_VPU_PLL_FDIV_CTL0] =3D 0x0012c032;
>+    s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] =3D 0x0010003f;
>+    s->analog[ANALOG_VPU_PLL_MNIT_CTRL] =3D 0x00280081;
>+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] =3D 0x00000810;
>+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] =3D 0x000fa031;
>+    s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] =3D 0x0010003f;
>+    s->analog[ANALOG_ARM_PLL_MNIT_CTRL] =3D 0x00280081;
>+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] =3D 0x0aaaa810;
>+    s->analog[ANALOG_SYS_PLL1_FDIV_CTL0] =3D 0x00190032;
>+    s->analog[ANALOG_SYS_PLL1_LOCKD_CTRL] =3D 0x0010003f;
>+    s->analog[ANALOG_SYS_PLL1_MNIT_CTRL] =3D 0x00280081;
>+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] =3D 0x0aaaa810;
>+    s->analog[ANALOG_SYS_PLL2_FDIV_CTL0] =3D 0x000fa031;
>+    s->analog[ANALOG_SYS_PLL2_LOCKD_CTRL] =3D 0x0010003f;
>+    s->analog[ANALOG_SYS_PLL2_MNIT_CTRL] =3D 0x00280081;
>+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] =3D 0x00000810;
>+    s->analog[ANALOG_SYS_PLL3_FDIV_CTL0] =3D 0x000fa031;
>+    s->analog[ANALOG_SYS_PLL3_LOCKD_CTRL] =3D 0x0010003f;
>+    s->analog[ANALOG_SYS_PLL3_MNIT_CTRL] =3D 0x00280081;
>+    s->analog[ANALOG_OSC_MISC_CFG] =3D 0x00000000;
>+    s->analog[ANALOG_ANAMIX_PLL_MNIT_CTL] =3D 0x00000000;
>+    s->analog[ANALOG_DIGPROG] =3D 0x00824010;
>+
>+    /* all PLLs need to be locked */
>+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
>+}
>+
>+static uint64_t imx8mp_analog_read(void *opaque, hwaddr offset, unsigned=
 size)
>+{
>+    IMX8MPAnalogState *s =3D opaque;
>+
>+    return s->analog[offset >> 2];
>+}
>+
>+static void imx8mp_analog_write(void *opaque, hwaddr offset,
>+                                uint64_t value, unsigned size)
>+{
>+    IMX8MPAnalogState *s =3D opaque;
>+
>+    if (offset >> 2 =3D=3D ANALOG_DIGPROG) {
>+        qemu_log_mask(LOG_GUEST_ERROR,
>+                      "Guest write to read-only ANALOG_DIGPROG register\=
n");
>+    } else {
>+        s->analog[offset >> 2] =3D value;
>+    }
>+}
>+
>+static const struct MemoryRegionOps imx8mp_analog_ops =3D {
>+    =2Eread =3D imx8mp_analog_read,
>+    =2Ewrite =3D imx8mp_analog_write,
>+    =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
>+    =2Eimpl =3D {
>+        =2Emin_access_size =3D 4,
>+        =2Emax_access_size =3D 4,
>+        =2Eunaligned =3D false,
>+    },
>+};
>+
>+static void imx8mp_analog_init(Object *obj)
>+{
>+    IMX8MPAnalogState *s =3D IMX8MP_ANALOG(obj);
>+    SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);
>+
>+    memory_region_init(&s->mmio=2Econtainer, obj, TYPE_IMX8MP_ANALOG, 0x=
10000);
>+
>+    memory_region_init_io(&s->mmio=2Eanalog, obj, &imx8mp_analog_ops, s,
>+                          TYPE_IMX8MP_ANALOG, sizeof(s->analog));
>+    memory_region_add_subregion(&s->mmio=2Econtainer, 0, &s->mmio=2Eanal=
og);
>+
>+    sysbus_init_mmio(sd, &s->mmio=2Econtainer);
>+}
>+
>+static const VMStateDescription vmstate_imx8mp_analog =3D {
>+    =2Ename =3D TYPE_IMX8MP_ANALOG,
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>+    =2Efields =3D (const VMStateField[]) {
>+        VMSTATE_UINT32_ARRAY(analog, IMX8MPAnalogState, ANALOG_MAX),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
>+static void imx8mp_analog_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+
>+    device_class_set_legacy_reset(dc, imx8mp_analog_reset);
>+    dc->vmsd  =3D &vmstate_imx8mp_analog;
>+    dc->desc  =3D "i=2EMX 8M Plus Analog Module";
>+}
>+
>+static const TypeInfo imx8mp_ccm_types[] =3D {
>+    {
>+        =2Ename          =3D TYPE_IMX8MP_ANALOG,
>+        =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>+        =2Einstance_size =3D sizeof(IMX8MPAnalogState),
>+        =2Einstance_init =3D imx8mp_analog_init,
>+        =2Eclass_init    =3D imx8mp_analog_class_init,
>+    }
>+};
>+
>+DEFINE_TYPES(imx8mp_ccm_types);

s/imx8mp_ccm_types/imx8mp_analog_types/ will be fixed in next iteration

>diff --git a/hw/misc/imx8mp_ccm=2Ec b/hw/misc/imx8mp_ccm=2Ec
>new file mode 100644
>index 0000000000=2E=2E7c869ff86b
>--- /dev/null
>+++ b/hw/misc/imx8mp_ccm=2Ec
>@@ -0,0 +1,175 @@
>+/*
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * i=2EMX 8M Plus CCM IP block emulation code
>+ *
>+ * Based on hw/misc/imx7_ccm=2Ec
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "qemu/log=2Eh"
>+
>+#include "hw/misc/imx8mp_ccm=2Eh"
>+#include "migration/vmstate=2Eh"
>+
>+#include "trace=2Eh"
>+
>+#define CKIH_FREQ 16000000 /* 16MHz crystal input */
>+
>+static void imx8mp_ccm_reset(DeviceState *dev)
>+{
>+    IMX8MPCCMState *s =3D IMX8MP_CCM(dev);
>+
>+    memset(s->ccm, 0, sizeof(s->ccm));
>+}
>+
>+#define CCM_INDEX(offset)   (((offset) & ~(hwaddr)0xF) / sizeof(uint32_t=
))
>+#define CCM_BITOP(offset)   ((offset) & (hwaddr)0xF)
>+
>+enum {
>+    CCM_BITOP_NONE =3D 0x00,
>+    CCM_BITOP_SET  =3D 0x04,
>+    CCM_BITOP_CLR  =3D 0x08,
>+    CCM_BITOP_TOG  =3D 0x0C,
>+};
>+
>+static uint64_t imx8mp_set_clr_tog_read(void *opaque, hwaddr offset,
>+                                        unsigned size)
>+{
>+    const uint32_t *mmio =3D opaque;
>+
>+    return mmio[CCM_INDEX(offset)];
>+}
>+
>+static void imx8mp_set_clr_tog_write(void *opaque, hwaddr offset,
>+                                     uint64_t value, unsigned size)
>+{
>+    const uint8_t  bitop =3D CCM_BITOP(offset);
>+    const uint32_t index =3D CCM_INDEX(offset);
>+    uint32_t *mmio =3D opaque;
>+
>+    switch (bitop) {
>+    case CCM_BITOP_NONE:
>+        mmio[index]  =3D value;
>+        break;
>+    case CCM_BITOP_SET:
>+        mmio[index] |=3D value;
>+        break;
>+    case CCM_BITOP_CLR:
>+        mmio[index] &=3D ~value;
>+        break;
>+    case CCM_BITOP_TOG:
>+        mmio[index] ^=3D value;
>+        break;
>+    };
>+}
>+
>+static const struct MemoryRegionOps imx8mp_set_clr_tog_ops =3D {
>+    =2Eread =3D imx8mp_set_clr_tog_read,
>+    =2Ewrite =3D imx8mp_set_clr_tog_write,
>+    =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
>+    =2Eimpl =3D {
>+        /*
>+         * Our device would not work correctly if the guest was doing
>+         * unaligned access=2E This might not be a limitation on the rea=
l
>+         * device but in practice there is no reason for a guest to acce=
ss
>+         * this device unaligned=2E
>+         */
>+        =2Emin_access_size =3D 4,
>+        =2Emax_access_size =3D 4,
>+        =2Eunaligned =3D false,
>+    },
>+};
>+
>+static void imx8mp_ccm_init(Object *obj)
>+{
>+    SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);
>+    IMX8MPCCMState *s =3D IMX8MP_CCM(obj);
>+
>+    memory_region_init_io(&s->iomem,
>+                          obj,
>+                          &imx8mp_set_clr_tog_ops,
>+                          s->ccm,
>+                          TYPE_IMX8MP_CCM "=2Eccm",
>+                          sizeof(s->ccm));
>+
>+    sysbus_init_mmio(sd, &s->iomem);
>+}
>+
>+static const VMStateDescription vmstate_imx8mp_ccm =3D {
>+    =2Ename =3D TYPE_IMX8MP_CCM,
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>+    =2Efields =3D (const VMStateField[]) {
>+        VMSTATE_UINT32_ARRAY(ccm, IMX8MPCCMState, CCM_MAX),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
>+static uint32_t imx8mp_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk =
clock)
>+{
>+    /*
>+     * This function is "consumed" by GPT emulation code=2E Some clocks
>+     * have fixed frequencies and we can provide requested frequency
>+     * easily=2E However for CCM provided clocks (like IPG) each GPT
>+     * timer can have its own clock root=2E
>+     * This means we need additional information when calling this
>+     * function to know the requester's identity=2E
>+     */
>+    uint32_t freq =3D 0;
>+
>+    switch (clock) {
>+    case CLK_NONE:
>+        break;
>+    case CLK_32k:
>+        freq =3D CKIL_FREQ;
>+        break;
>+    case CLK_HIGH:
>+        freq =3D CKIH_FREQ;
>+        break;
>+    case CLK_IPG:
>+    case CLK_IPG_HIGH:
>+        /*
>+         * For now we don't have a way to figure out the device this
>+         * function is called for=2E Until then the IPG derived clocks
>+         * are left unimplemented=2E
>+         */
>+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Clock %d Not implemented=
\n",
>+                      TYPE_IMX8MP_CCM, __func__, clock);
>+        break;
>+    default:
>+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: unsupported clock %d\n",
>+                      TYPE_IMX8MP_CCM, __func__, clock);
>+        break;
>+    }
>+
>+    trace_ccm_clock_freq(clock, freq);
>+
>+    return freq;
>+}
>+
>+static void imx8mp_ccm_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    IMXCCMClass *ccm =3D IMX_CCM_CLASS(klass);
>+
>+    device_class_set_legacy_reset(dc, imx8mp_ccm_reset);
>+    dc->vmsd  =3D &vmstate_imx8mp_ccm;
>+    dc->desc  =3D "i=2EMX 8M Plus Clock Control Module";
>+
>+    ccm->get_clock_frequency =3D imx8mp_ccm_get_clock_frequency;
>+}
>+
>+static const TypeInfo imx8mp_ccm_types[] =3D {
>+    {
>+        =2Ename          =3D TYPE_IMX8MP_CCM,
>+        =2Eparent        =3D TYPE_IMX_CCM,
>+        =2Einstance_size =3D sizeof(IMX8MPCCMState),
>+        =2Einstance_init =3D imx8mp_ccm_init,
>+        =2Eclass_init    =3D imx8mp_ccm_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(imx8mp_ccm_types);
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index e22916df57=2E=2E0079c51734 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -580,6 +580,8 @@ config FSL_IMX7
> config FSL_IMX8MP
>     bool
>     select ARM_GIC
>+    select FSL_IMX8MP_ANALOG
>+    select FSL_IMX8MP_CCM
>     select IMX
>     select UNIMP
>=20
>diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>index 4271e2f4ac=2E=2E82bd68b4bb 100644
>--- a/hw/misc/Kconfig
>+++ b/hw/misc/Kconfig
>@@ -78,6 +78,12 @@ config IMX
>     select SSI
>     select USB_EHCI_SYSBUS
>=20
>+config FSL_IMX8MP_ANALOG
>+    bool
>+
>+config FSL_IMX8MP_CCM
>+    bool
>+
> config STM32_RCC
>     bool
>=20
>diff --git a/hw/misc/meson=2Ebuild b/hw/misc/meson=2Ebuild
>index 55f493521b=2E=2Ef9285cf2f1 100644
>--- a/hw/misc/meson=2Ebuild
>+++ b/hw/misc/meson=2Ebuild
>@@ -55,6 +55,8 @@ system_ss=2Eadd(when: 'CONFIG_AXP2XX_PMU', if_true: fil=
es('axp2xx=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl=2Ec'=
))
> system_ss=2Eadd(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl=2Ec'=
))
> system_ss=2Eadd(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu=
=2Ec', 'exynos4210_clk=2Ec', 'exynos4210_rng=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp=
_analog=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_cc=
m=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_IMX', if_true: files(
>   'imx25_ccm=2Ec',
>   'imx31_ccm=2Ec',

