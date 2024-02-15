Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0997C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raffA-0001Ty-QV; Thu, 15 Feb 2024 12:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeR-000855-O4
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:00 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeL-00041W-V9
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:59 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3394b892691so815098f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018552; x=1708623352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xhnNSoF30qfo2zl+0DNnS2U5diUzwHQyoomTsMJHDR4=;
 b=LY4cVa764DIFWtRGfdIb9pNPKJLbEtOWX9nGoB57f2U7oCg6gb4uhMUs1gFa28MpYZ
 aOxgBEayc8GVX9M59jLa+Fv4kiIJM0k6g4T8sxYYMIEuFQbRTdnuulaZlHK4iEkFeTAm
 W/sBBUuxjvxj4plgoiiaFngzjybFrkFK6ltyfMxhPLiHduHlwRdvkygVdB9LgnOKRxcy
 XxS6kjXSPiUWYrw8WD3mZriGoN6tI9yMEEmxh6teg4xNZBKFWlEwQagLk7qKMBJhPVXq
 v6VfrTkeEzRxETzZTT/Tum/1SFl2Q8cE+KSWndi2GRNS684JGCKYldoYGAiQ/iz5SBN8
 GZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018552; x=1708623352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhnNSoF30qfo2zl+0DNnS2U5diUzwHQyoomTsMJHDR4=;
 b=PcBepV3roWEfRLXEs7ZGwHpkzlh7JJG8473LvEoyX5RNbVK1Qv0CKhHecAXbu76or0
 c8MtQjmBOvbcJlj5A2Ps35phJOKmep0LPNZLJQsYIK1GnOQOxM3thtcxrni1TTJxkfGN
 mhhP+vI0ydns24t91Jlhcsewpl43h3kYaLAn78RKDteDmEUZNrHl8aX/0KtgPsv9ItwY
 mO6mbjh9ktoAXUWfm6HKa8N7cFnjh7eNj2qhJCsmaZUKun+TntiyeUN2hilJ0lRYbbcI
 m8f7V5HqBdKlkF3tq0r15+SXKH5pSwGHWrvGIw95IxONSdyxn41PfPfJ+pJB3SS0OUM+
 OoxQ==
X-Gm-Message-State: AOJu0YzPWlnlXF8XVifBV3mSzUri34tYcnVAv3nCFKOmjEYYt/SYGM2I
 u4ssHg+jqHQELA3jsXjHONvV5VL1hvtWx/42GbOwjEmmf3Kec8zGOOg5sDz+z+6M0UFfAs1vIlk
 r
X-Google-Smtp-Source: AGHT+IHJ+45RbGSC0jLueCWE6KrHg45+sm2Mm0CdsYG5Mq15pAWE93cozwvYIbKgzkdrAxHoQp9/LA==
X-Received: by 2002:adf:fd0b:0:b0:33d:119e:2ca1 with SMTP id
 e11-20020adffd0b000000b0033d119e2ca1mr1084762wrr.5.1708018552595; 
 Thu, 15 Feb 2024 09:35:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/35] hw/arm/mps3r: Initial skeleton for mps3-an536 board
Date: Thu, 15 Feb 2024 17:35:33 +0000
Message-Id: <20240215173538.2430599-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The AN536 is another FPGA image for the MPS3 development board. Unlike
the existing FPGA images we already model, this board uses a Cortex-R
family CPU, and it does not use any equivalent to the M-profile
"Subsystem for Embedded" SoC-equivalent that we model in hw/arm/armsse.c.
It's therefore more convenient for us to model it as a completely
separate C file.

This commit adds the basic skeleton of the board model, and the
code to create all the RAM and ROM. We assume that we're probably
going to want to add more images in future, so use the same
base class/subclass setup that mps2-tz.c uses, even though at
the moment there's only a single subclass.

Following commits will add the CPUs and the peripherals.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240206132931.38376-9-peter.maydell@linaro.org
---
 MAINTAINERS                             |   3 +-
 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/mps3r.c                          | 239 ++++++++++++++++++++++++
 hw/arm/Kconfig                          |   5 +
 hw/arm/meson.build                      |   1 +
 5 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/mps3r.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6b..48be2ffe893 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -819,12 +819,13 @@ F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 
-MPS2
+MPS2 / MPS3
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/mps2.c
 F: hw/arm/mps2-tz.c
+F: hw/arm/mps3r.c
 F: hw/misc/mps2-*.c
 F: include/hw/misc/mps2-*.h
 F: hw/arm/armsse.c
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 023faa2f750..6ee31bc1ab9 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -13,6 +13,7 @@ CONFIG_ARM_VIRT=y
 # CONFIG_INTEGRATOR=n
 # CONFIG_FSL_IMX31=n
 # CONFIG_MUSICPAL=n
+# CONFIG_MPS3R=n
 # CONFIG_MUSCA=n
 # CONFIG_CHEETAH=n
 # CONFIG_SX1=n
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
new file mode 100644
index 00000000000..888a846d23c
--- /dev/null
+++ b/hw/arm/mps3r.c
@@ -0,0 +1,239 @@
+/*
+ * Arm MPS3 board emulation for Cortex-R-based FPGA images.
+ * (For M-profile images see mps2.c and mps2tz.c.)
+ *
+ * Copyright (c) 2017 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/*
+ * The MPS3 is an FPGA based dev board. This file handles FPGA images
+ * which use the Cortex-R CPUs. We model these separately from the
+ * M-profile images, because on M-profile the FPGA image is based on
+ * a "Subsystem for Embedded" which is similar to an SoC, whereas
+ * the R-profile FPGA images don't have that abstraction layer.
+ *
+ * We model the following FPGA images here:
+ *  "mps3-an536" -- dual Cortex-R52 as documented in Arm Application Note AN536
+ *
+ * Application Note AN536:
+ * https://developer.arm.com/documentation/dai0536/latest/
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "cpu.h"
+#include "hw/boards.h"
+#include "hw/arm/boot.h"
+
+/* Define the layout of RAM and ROM in a board */
+typedef struct RAMInfo {
+    const char *name;
+    hwaddr base;
+    hwaddr size;
+    int mrindex; /* index into rams[]; -1 for the system RAM block */
+    int flags;
+} RAMInfo;
+
+/*
+ * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
+ * emulation of that much guest RAM, so artificially make it smaller.
+ */
+#if HOST_LONG_BITS == 32
+#define MPS3_DDR_SIZE (1 * GiB)
+#else
+#define MPS3_DDR_SIZE (3 * GiB)
+#endif
+
+/*
+ * Flag values:
+ * IS_MAIN: this is the main machine RAM
+ * IS_ROM: this area is read-only
+ */
+#define IS_MAIN 1
+#define IS_ROM 2
+
+#define MPS3R_RAM_MAX 9
+
+typedef enum MPS3RFPGAType {
+    FPGA_AN536,
+} MPS3RFPGAType;
+
+struct MPS3RMachineClass {
+    MachineClass parent;
+    MPS3RFPGAType fpga_type;
+    const RAMInfo *raminfo;
+};
+
+struct MPS3RMachineState {
+    MachineState parent;
+    MemoryRegion ram[MPS3R_RAM_MAX];
+};
+
+#define TYPE_MPS3R_MACHINE "mps3r"
+#define TYPE_MPS3R_AN536_MACHINE MACHINE_TYPE_NAME("mps3-an536")
+
+OBJECT_DECLARE_TYPE(MPS3RMachineState, MPS3RMachineClass, MPS3R_MACHINE)
+
+static const RAMInfo an536_raminfo[] = {
+    {
+        .name = "ATCM",
+        .base = 0x00000000,
+        .size = 0x00008000,
+        .mrindex = 0,
+    }, {
+        /* We model the QSPI flash as simple ROM for now */
+        .name = "QSPI",
+        .base = 0x08000000,
+        .size = 0x00800000,
+        .flags = IS_ROM,
+        .mrindex = 1,
+    }, {
+        .name = "BRAM",
+        .base = 0x10000000,
+        .size = 0x00080000,
+        .mrindex = 2,
+    }, {
+        .name = "DDR",
+        .base = 0x20000000,
+        .size = MPS3_DDR_SIZE,
+        .mrindex = -1,
+    }, {
+        .name = "ATCM0",
+        .base = 0xee000000,
+        .size = 0x00008000,
+        .mrindex = 3,
+    }, {
+        .name = "BTCM0",
+        .base = 0xee100000,
+        .size = 0x00008000,
+        .mrindex = 4,
+    }, {
+        .name = "CTCM0",
+        .base = 0xee200000,
+        .size = 0x00008000,
+        .mrindex = 5,
+    }, {
+        .name = "ATCM1",
+        .base = 0xee400000,
+        .size = 0x00008000,
+        .mrindex = 6,
+    }, {
+        .name = "BTCM1",
+        .base = 0xee500000,
+        .size = 0x00008000,
+        .mrindex = 7,
+    }, {
+        .name = "CTCM1",
+        .base = 0xee600000,
+        .size = 0x00008000,
+        .mrindex = 8,
+    }, {
+        .name = NULL,
+    }
+};
+
+static MemoryRegion *mr_for_raminfo(MPS3RMachineState *mms,
+                                    const RAMInfo *raminfo)
+{
+    /* Return an initialized MemoryRegion for the RAMInfo. */
+    MemoryRegion *ram;
+
+    if (raminfo->mrindex < 0) {
+        /* Means this RAMInfo is for QEMU's "system memory" */
+        MachineState *machine = MACHINE(mms);
+        assert(!(raminfo->flags & IS_ROM));
+        return machine->ram;
+    }
+
+    assert(raminfo->mrindex < MPS3R_RAM_MAX);
+    ram = &mms->ram[raminfo->mrindex];
+
+    memory_region_init_ram(ram, NULL, raminfo->name,
+                           raminfo->size, &error_fatal);
+    if (raminfo->flags & IS_ROM) {
+        memory_region_set_readonly(ram, true);
+    }
+    return ram;
+}
+
+static void mps3r_common_init(MachineState *machine)
+{
+    MPS3RMachineState *mms = MPS3R_MACHINE(machine);
+    MPS3RMachineClass *mmc = MPS3R_MACHINE_GET_CLASS(mms);
+    MemoryRegion *sysmem = get_system_memory();
+
+    for (const RAMInfo *ri = mmc->raminfo; ri->name; ri++) {
+        MemoryRegion *mr = mr_for_raminfo(mms, ri);
+        memory_region_add_subregion(sysmem, ri->base, mr);
+    }
+}
+
+static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
+{
+    /*
+     * Set mc->default_ram_size and default_ram_id from the
+     * information in mmc->raminfo.
+     */
+    MachineClass *mc = MACHINE_CLASS(mmc);
+    const RAMInfo *p;
+
+    for (p = mmc->raminfo; p->name; p++) {
+        if (p->mrindex < 0) {
+            /* Found the entry for "system memory" */
+            mc->default_ram_size = p->size;
+            mc->default_ram_id = p->name;
+            return;
+        }
+    }
+    g_assert_not_reached();
+}
+
+static void mps3r_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = mps3r_common_init;
+}
+
+static void mps3r_an536_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MPS3RMachineClass *mmc = MPS3R_MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-r52"),
+        NULL
+    };
+
+    mc->desc = "ARM MPS3 with AN536 FPGA image for Cortex-R52";
+    mc->default_cpus = 2;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-r52");
+    mc->valid_cpu_types = valid_cpu_types;
+    mmc->raminfo = an536_raminfo;
+    mps3r_set_default_ram_info(mmc);
+}
+
+static const TypeInfo mps3r_machine_types[] = {
+    {
+        .name = TYPE_MPS3R_MACHINE,
+        .parent = TYPE_MACHINE,
+        .abstract = true,
+        .instance_size = sizeof(MPS3RMachineState),
+        .class_size = sizeof(MPS3RMachineClass),
+        .class_init = mps3r_class_init,
+    }, {
+        .name = TYPE_MPS3R_AN536_MACHINE,
+        .parent = TYPE_MPS3R_MACHINE,
+        .class_init = mps3r_an536_class_init,
+    },
+};
+
+DEFINE_TYPES(mps3r_machine_types);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 980b14d58dc..29abe1da29c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -106,6 +106,11 @@ config MAINSTONE
     select PFLASH_CFI01
     select SMC91C111
 
+config MPS3R
+    bool
+    default y
+    depends on TCG && ARM
+
 config MUSCA
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index c4017790670..a16d3479055 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -8,6 +8,7 @@ arm_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
 arm_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mainstone.c'))
 arm_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
+arm_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
 arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
 arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
-- 
2.34.1


