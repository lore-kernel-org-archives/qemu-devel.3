Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEA0C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASM-0008VC-9j; Sun, 23 Feb 2025 06:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASK-0008TU-Sp; Sun, 23 Feb 2025 06:47:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASI-0005wG-1q; Sun, 23 Feb 2025 06:47:32 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e050b1491eso8002619a12.0; 
 Sun, 23 Feb 2025 03:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311247; x=1740916047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VUCJNBaRnb9GAPb0B1KrauqR8rtMaDpZSNOf+ddt30=;
 b=mXw4PM/aNYA1KgbWvysIp26KNXEd58EMANE4wSAqUE3N9OBDkTAaUbH5wjZV+G3cIK
 VqN0jvV4Zd4QmbSwMQzzVLZu/i9okaQn1ZINlDaevoh60ElyGzrugCXZ5vclpykhvcJH
 sj2iiOhPXigY02o5L16FbwrKX2yW7DNUa5//p35mr/Uc8xy/U0jVJ8sM2Lvrrxft6t6t
 73q0CAzjWT8+NfXKIOf/jVUNQlMz6YG5CYRlnG7jkqId2Y+E27mZGUSz/6W0pbtQMh1A
 COO+6+59vu5q0h+mOvBBGkyBjZbPLuFcp6r3ydHOIBPK/uxX28rJULrO6fYHyoP+hsKb
 QIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311247; x=1740916047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VUCJNBaRnb9GAPb0B1KrauqR8rtMaDpZSNOf+ddt30=;
 b=LVshyuCIxqyWqaZqaQOx7IXKGBBCOL/sosdC/j+r9ayWWJnNd2+pB6YHMUl4kZGn30
 jrpmD3bskIxKvXUkOSs3au9PZWyGQKvq7LNMlESV5HSeouaTO6cbGdiH8NgZFx27cU36
 emfp6v4ejPAGlALWRzq6KC5wtFy22HL70+CPkZywp8VVjgsu7vLug30ZJQBbh15/vsWt
 6nWb0tkmzQmqirreGqCrICPhBwA+8WMjkpe3O0c+ubLkivdvEHPMgIWsBDmKZfw3l8TS
 u4f2x2+6PzuK5SUBl983P95bFYBznF7wqRKIy4OdMEdI+KQ0eWENqXvDt7nsWCbU3G6X
 /75A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvnVhQti1f8oZQjmSKPocP0IPBYBbcSX6/ZwNqWKhhHAo3y2d0h1Z3CeNG7zcrvsNDQxkwNzKpDg==@nongnu.org
X-Gm-Message-State: AOJu0YzcGZhMNl1KqRLEEDByB8umkaYXh4dkckDnkaGvIrTOhRqSe4LX
 w8rpmJ0F1WGE+AWKg2ytmoyBq1Zt9u9rk5Ykgaq4/BQWTyYvTXObDJUzvw==
X-Gm-Gg: ASbGnct7QDwV8uMNYwjwVFAmgD/GYF31LWDkq89Hs4BUn1ZW6yAZmP1qrAF19v5d0MZ
 aPBSc9W8NNPDNdjJw+V5ar033M39tB3CaYChaG8/BjhFKcJ9r6/wE9/XEL62kA+UvbtpYd4BT2f
 MQ4palWg77peiOxgXS41GOFNPtfoT8ZfhirKJtuKAuQreZNOtrlsWabmk6MtHTLdYgl8kuPVpP6
 Ces90zJXRuRjhUkL07t6UmxD1TXB8R/b3UaqGpcsb6RBqV9VyXNrV+xlBCdF9WrqVl7GXPExcAR
 dUZ4ibtUCKJ+vfki1QS+CdBl8sfR+ZK2t8BOmipbo5bAg5l+ymtInynxeIZRzHloU9+odHge8Y7
 5clFnm4XB9ZWc
X-Google-Smtp-Source: AGHT+IFy+D3vYpeVr1aQFC5zMg37chkMY+ttWjmRNdlpzLejxYyRnKuU/MItepR7OnyY4+AO8mySiQ==
X-Received: by 2002:a17:907:3e0b:b0:aba:620a:acf7 with SMTP id
 a640c23a62f3a-abc0ae5728bmr965986966b.10.1740311246973; 
 Sun, 23 Feb 2025 03:47:26 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:25 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/18] hw/arm/fsl-imx8mp: Implement clock tree
Date: Sun, 23 Feb 2025 12:46:55 +0100
Message-ID: <20250223114708.1780-6-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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

Fixes quite a few stack traces during the Linux boot process. Also provides the
clocks for devices added later, e.g. enet1.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                     |   2 +
 docs/system/arm/imx8mp-evk.rst  |   1 +
 include/hw/arm/fsl-imx8mp.h     |   4 +
 include/hw/misc/imx8mp_analog.h |  81 +++++++++++++++
 include/hw/misc/imx8mp_ccm.h    |  30 ++++++
 hw/arm/fsl-imx8mp.c             |  20 ++++
 hw/misc/imx8mp_analog.c         | 160 +++++++++++++++++++++++++++++
 hw/misc/imx8mp_ccm.c            | 175 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |   2 +
 hw/misc/Kconfig                 |   6 ++
 hw/misc/meson.build             |   2 +
 11 files changed, 483 insertions(+)
 create mode 100644 include/hw/misc/imx8mp_analog.h
 create mode 100644 include/hw/misc/imx8mp_ccm.h
 create mode 100644 hw/misc/imx8mp_analog.c
 create mode 100644 hw/misc/imx8mp_ccm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 374fe98724..8ea7fb4c7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -826,7 +826,9 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/imx8mp-evk.c
 F: hw/arm/fsl-imx8mp.c
+F: hw/misc/imx8mp_*.c
 F: include/hw/arm/fsl-imx8mp.h
+F: include/hw/misc/imx8mp_*.h
 F: docs/system/arm/imx8mp-evk.rst
 
 MPS2 / MPS3
diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index b23fdcc743..f0df346113 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Clock Tree
 
 Boot options
 ------------
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 57e23d1b69..ce5188e7f2 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,8 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx8mp_analog.h"
+#include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -32,6 +34,8 @@ struct FslImx8mpState {
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
+    IMX8MPCCMState     ccm;
+    IMX8MPAnalogState  analog;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
 };
 
diff --git a/include/hw/misc/imx8mp_analog.h b/include/hw/misc/imx8mp_analog.h
new file mode 100644
index 0000000000..955f03215a
--- /dev/null
+++ b/include/hw/misc/imx8mp_analog.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * i.MX8MP ANALOG IP block emulation code
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IMX8MP_ANALOG_H
+#define IMX8MP_ANALOG_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+enum IMX8MPAnalogRegisters {
+    ANALOG_AUDIO_PLL1_GEN_CTRL = 0x000 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL0 = 0x004 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL1 = 0x008 / 4,
+    ANALOG_AUDIO_PLL1_SSCG_CTRL = 0x00c / 4,
+    ANALOG_AUDIO_PLL1_MNIT_CTRL = 0x010 / 4,
+    ANALOG_AUDIO_PLL2_GEN_CTRL = 0x014 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL0 = 0x018 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL1 = 0x01c / 4,
+    ANALOG_AUDIO_PLL2_SSCG_CTRL = 0x020 / 4,
+    ANALOG_AUDIO_PLL2_MNIT_CTRL = 0x024 / 4,
+    ANALOG_VIDEO_PLL1_GEN_CTRL = 0x028 / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL0 = 0x02c / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL1 = 0x030 / 4,
+    ANALOG_VIDEO_PLL1_SSCG_CTRL = 0x034 / 4,
+    ANALOG_VIDEO_PLL1_MNIT_CTRL = 0x038 / 4,
+    ANALOG_DRAM_PLL_GEN_CTRL = 0x050 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL0 = 0x054 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL1 = 0x058 / 4,
+    ANALOG_DRAM_PLL_SSCG_CTRL = 0x05c / 4,
+    ANALOG_DRAM_PLL_MNIT_CTRL = 0x060 / 4,
+    ANALOG_GPU_PLL_GEN_CTRL = 0x064 / 4,
+    ANALOG_GPU_PLL_FDIV_CTL0 = 0x068 / 4,
+    ANALOG_GPU_PLL_LOCKD_CTRL = 0x06c / 4,
+    ANALOG_GPU_PLL_MNIT_CTRL = 0x070 / 4,
+    ANALOG_VPU_PLL_GEN_CTRL = 0x074 / 4,
+    ANALOG_VPU_PLL_FDIV_CTL0 = 0x078 / 4,
+    ANALOG_VPU_PLL_LOCKD_CTRL = 0x07c / 4,
+    ANALOG_VPU_PLL_MNIT_CTRL = 0x080 / 4,
+    ANALOG_ARM_PLL_GEN_CTRL = 0x084 / 4,
+    ANALOG_ARM_PLL_FDIV_CTL0 = 0x088 / 4,
+    ANALOG_ARM_PLL_LOCKD_CTRL = 0x08c / 4,
+    ANALOG_ARM_PLL_MNIT_CTRL = 0x090 / 4,
+    ANALOG_SYS_PLL1_GEN_CTRL = 0x094 / 4,
+    ANALOG_SYS_PLL1_FDIV_CTL0 = 0x098 / 4,
+    ANALOG_SYS_PLL1_LOCKD_CTRL = 0x09c / 4,
+    ANALOG_SYS_PLL1_MNIT_CTRL = 0x100 / 4,
+    ANALOG_SYS_PLL2_GEN_CTRL = 0x104 / 4,
+    ANALOG_SYS_PLL2_FDIV_CTL0 = 0x108 / 4,
+    ANALOG_SYS_PLL2_LOCKD_CTRL = 0x10c / 4,
+    ANALOG_SYS_PLL2_MNIT_CTRL = 0x110 / 4,
+    ANALOG_SYS_PLL3_GEN_CTRL = 0x114 / 4,
+    ANALOG_SYS_PLL3_FDIV_CTL0 = 0x118 / 4,
+    ANALOG_SYS_PLL3_LOCKD_CTRL = 0x11c / 4,
+    ANALOG_SYS_PLL3_MNIT_CTRL = 0x120 / 4,
+    ANALOG_OSC_MISC_CFG = 0x124 / 4,
+    ANALOG_ANAMIX_PLL_MNIT_CTL = 0x128 / 4,
+
+    ANALOG_DIGPROG = 0x800 / 4,
+    ANALOG_MAX,
+};
+
+#define TYPE_IMX8MP_ANALOG "imx8mp.analog"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPAnalogState, IMX8MP_ANALOG)
+
+struct IMX8MPAnalogState {
+    SysBusDevice parent_obj;
+
+    struct {
+        MemoryRegion container;
+        MemoryRegion analog;
+    } mmio;
+
+    uint32_t analog[ANALOG_MAX];
+};
+
+#endif /* IMX8MP_ANALOG_H */
diff --git a/include/hw/misc/imx8mp_ccm.h b/include/hw/misc/imx8mp_ccm.h
new file mode 100644
index 0000000000..685c8582ff
--- /dev/null
+++ b/include/hw/misc/imx8mp_ccm.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * i.MX 8M Plus CCM IP block emulation code
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IMX8MP_CCM_H
+#define IMX8MP_CCM_H
+
+#include "hw/misc/imx_ccm.h"
+#include "qom/object.h"
+
+enum IMX8MPCCMRegisters {
+    CCM_MAX = 0xc6fc / sizeof(uint32_t) + 1,
+};
+
+#define TYPE_IMX8MP_CCM "imx8mp.ccm"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPCCMState, IMX8MP_CCM)
+
+struct IMX8MPCCMState {
+    IMXCCMState parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t ccm[CCM_MAX];
+};
+
+#endif /* IMX8MP_CCM_H */
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 484b45c0d8..2b86de45a0 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -197,6 +197,10 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
 
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
+
+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -304,6 +308,20 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* CCM */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_CCM].addr);
+
+    /* Analog */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_ANA_PLL].addr);
+
     /* UARTs */
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         static const struct {
@@ -329,6 +347,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
+        case FSL_IMX8MP_ANA_PLL:
+        case FSL_IMX8MP_CCM:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_RAM:
diff --git a/hw/misc/imx8mp_analog.c b/hw/misc/imx8mp_analog.c
new file mode 100644
index 0000000000..f7e7c83cc4
--- /dev/null
+++ b/hw/misc/imx8mp_analog.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * i.MX 8M Plus ANALOG IP block emulation code
+ *
+ * Based on hw/misc/imx7_ccm.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mp_analog.h"
+#include "migration/vmstate.h"
+
+#define ANALOG_PLL_LOCK BIT(31)
+
+static void imx8mp_analog_reset(DeviceState *dev)
+{
+    IMX8MPAnalogState *s = IMX8MP_ANALOG(dev);
+
+    memset(s->analog, 0, sizeof(s->analog));
+
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL0] = 0x0012c032;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_GPU_PLL_FDIV_CTL0] = 0x000c8031;
+    s->analog[ANALOG_GPU_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_GPU_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_VPU_PLL_FDIV_CTL0] = 0x0012c032;
+    s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_VPU_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_ARM_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] = 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL1_FDIV_CTL0] = 0x00190032;
+    s->analog[ANALOG_SYS_PLL1_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL1_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] = 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL2_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_SYS_PLL2_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL2_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_SYS_PLL3_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_SYS_PLL3_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL3_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_OSC_MISC_CFG] = 0x00000000;
+    s->analog[ANALOG_ANAMIX_PLL_MNIT_CTL] = 0x00000000;
+    s->analog[ANALOG_DIGPROG] = 0x00824010;
+
+    /* all PLLs need to be locked */
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] |= ANALOG_PLL_LOCK;
+}
+
+static uint64_t imx8mp_analog_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX8MPAnalogState *s = opaque;
+
+    return s->analog[offset >> 2];
+}
+
+static void imx8mp_analog_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    IMX8MPAnalogState *s = opaque;
+
+    if (offset >> 2 == ANALOG_DIGPROG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Guest write to read-only ANALOG_DIGPROG register\n");
+    } else {
+        s->analog[offset >> 2] = value;
+    }
+}
+
+static const struct MemoryRegionOps imx8mp_analog_ops = {
+    .read = imx8mp_analog_read,
+    .write = imx8mp_analog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx8mp_analog_init(Object *obj)
+{
+    IMX8MPAnalogState *s = IMX8MP_ANALOG(obj);
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init(&s->mmio.container, obj, TYPE_IMX8MP_ANALOG, 0x10000);
+
+    memory_region_init_io(&s->mmio.analog, obj, &imx8mp_analog_ops, s,
+                          TYPE_IMX8MP_ANALOG, sizeof(s->analog));
+    memory_region_add_subregion(&s->mmio.container, 0, &s->mmio.analog);
+
+    sysbus_init_mmio(sd, &s->mmio.container);
+}
+
+static const VMStateDescription imx8mp_analog_vmstate = {
+    .name = TYPE_IMX8MP_ANALOG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(analog, IMX8MPAnalogState, ANALOG_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx8mp_analog_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mp_analog_reset);
+    dc->vmsd  = &imx8mp_analog_vmstate;
+    dc->desc  = "i.MX 8M Plus Analog Module";
+}
+
+static const TypeInfo imx8mp_analog_types[] = {
+    {
+        .name          = TYPE_IMX8MP_ANALOG,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(IMX8MPAnalogState),
+        .instance_init = imx8mp_analog_init,
+        .class_init    = imx8mp_analog_class_init,
+    }
+};
+
+DEFINE_TYPES(imx8mp_analog_types);
diff --git a/hw/misc/imx8mp_ccm.c b/hw/misc/imx8mp_ccm.c
new file mode 100644
index 0000000000..1a1c932427
--- /dev/null
+++ b/hw/misc/imx8mp_ccm.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * i.MX 8M Plus CCM IP block emulation code
+ *
+ * Based on hw/misc/imx7_ccm.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mp_ccm.h"
+#include "migration/vmstate.h"
+
+#include "trace.h"
+
+#define CKIH_FREQ 16000000 /* 16MHz crystal input */
+
+static void imx8mp_ccm_reset(DeviceState *dev)
+{
+    IMX8MPCCMState *s = IMX8MP_CCM(dev);
+
+    memset(s->ccm, 0, sizeof(s->ccm));
+}
+
+#define CCM_INDEX(offset)   (((offset) & ~(hwaddr)0xF) / sizeof(uint32_t))
+#define CCM_BITOP(offset)   ((offset) & (hwaddr)0xF)
+
+enum {
+    CCM_BITOP_NONE = 0x00,
+    CCM_BITOP_SET  = 0x04,
+    CCM_BITOP_CLR  = 0x08,
+    CCM_BITOP_TOG  = 0x0C,
+};
+
+static uint64_t imx8mp_set_clr_tog_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    const uint32_t *mmio = opaque;
+
+    return mmio[CCM_INDEX(offset)];
+}
+
+static void imx8mp_set_clr_tog_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    const uint8_t  bitop = CCM_BITOP(offset);
+    const uint32_t index = CCM_INDEX(offset);
+    uint32_t *mmio = opaque;
+
+    switch (bitop) {
+    case CCM_BITOP_NONE:
+        mmio[index]  = value;
+        break;
+    case CCM_BITOP_SET:
+        mmio[index] |= value;
+        break;
+    case CCM_BITOP_CLR:
+        mmio[index] &= ~value;
+        break;
+    case CCM_BITOP_TOG:
+        mmio[index] ^= value;
+        break;
+    };
+}
+
+static const struct MemoryRegionOps imx8mp_set_clr_tog_ops = {
+    .read = imx8mp_set_clr_tog_read,
+    .write = imx8mp_set_clr_tog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx8mp_ccm_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX8MPCCMState *s = IMX8MP_CCM(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx8mp_set_clr_tog_ops,
+                          s->ccm,
+                          TYPE_IMX8MP_CCM ".ccm",
+                          sizeof(s->ccm));
+
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription imx8mp_ccm_vmstate = {
+    .name = TYPE_IMX8MP_CCM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ccm, IMX8MPCCMState, CCM_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static uint32_t imx8mp_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
+{
+    /*
+     * This function is "consumed" by GPT emulation code. Some clocks
+     * have fixed frequencies and we can provide requested frequency
+     * easily. However for CCM provided clocks (like IPG) each GPT
+     * timer can have its own clock root.
+     * This means we need additional information when calling this
+     * function to know the requester's identity.
+     */
+    uint32_t freq = 0;
+
+    switch (clock) {
+    case CLK_NONE:
+        break;
+    case CLK_32k:
+        freq = CKIL_FREQ;
+        break;
+    case CLK_HIGH:
+        freq = CKIH_FREQ;
+        break;
+    case CLK_IPG:
+    case CLK_IPG_HIGH:
+        /*
+         * For now we don't have a way to figure out the device this
+         * function is called for. Until then the IPG derived clocks
+         * are left unimplemented.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Clock %d Not implemented\n",
+                      TYPE_IMX8MP_CCM, __func__, clock);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: unsupported clock %d\n",
+                      TYPE_IMX8MP_CCM, __func__, clock);
+        break;
+    }
+
+    trace_ccm_clock_freq(clock, freq);
+
+    return freq;
+}
+
+static void imx8mp_ccm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mp_ccm_reset);
+    dc->vmsd  = &imx8mp_ccm_vmstate;
+    dc->desc  = "i.MX 8M Plus Clock Control Module";
+
+    ccm->get_clock_frequency = imx8mp_ccm_get_clock_frequency;
+}
+
+static const TypeInfo imx8mp_ccm_types[] = {
+    {
+        .name          = TYPE_IMX8MP_CCM,
+        .parent        = TYPE_IMX_CCM,
+        .instance_size = sizeof(IMX8MPCCMState),
+        .instance_init = imx8mp_ccm_init,
+        .class_init    = imx8mp_ccm_class_init,
+    },
+};
+
+DEFINE_TYPES(imx8mp_ccm_types);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0a7de40861..f77c451ba3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -596,6 +596,8 @@ config FSL_IMX7
 config FSL_IMX8MP
     bool
     select ARM_GIC
+    select FSL_IMX8MP_ANALOG
+    select FSL_IMX8MP_CCM
     select IMX
     select UNIMP
 
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4271e2f4ac..82bd68b4bb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -78,6 +78,12 @@ config IMX
     select SSI
     select USB_EHCI_SYSBUS
 
+config FSL_IMX8MP_ANALOG
+    bool
+
+config FSL_IMX8MP_CCM
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index edd36a334d..0b5187a2f7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -55,6 +55,8 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
-- 
2.48.1


