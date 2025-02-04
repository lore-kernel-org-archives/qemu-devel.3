Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6F2C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6iU-0008OJ-Q6; Mon, 03 Feb 2025 19:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iR-0008N7-FC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:22:59 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iP-00071h-7l
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:22:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38da88e6db0so41899f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628575; x=1739233375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsIKyI+e9av35VOR6IuoP5pHXQj36xoMmsdPAwqdbVY=;
 b=H8jZvMNT0ko3RG4E9Q7lcZqziviBxuNGG64jYnMhdNi0/VVx7pQE3RfzNn3f4qDq0V
 AjzioaoVhPY7Wb5wYCyDX6OWDojFAp5yV0VeFjwN9HwgAy3EhewfiEexQu1zNr0uw7pp
 UdYq6+MRVKQtklq9o5NER+5C7HFZJHIFpanzuXXJv+kNxqOI4KcbPnlKasmP1tsAyGqn
 dUdsmTvB+ZL9TXJPxYmKYBk80l8bgvcam2Iu8BMq9tis22thrbBmJG2A1Kw38rokYwsR
 mot4yHN21YhZaHoo6Tv1eoKtOqezLDwdQaHkIbXFots/i0TQZKYN9hIi/422TqFSv7EA
 kniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628575; x=1739233375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsIKyI+e9av35VOR6IuoP5pHXQj36xoMmsdPAwqdbVY=;
 b=PYXzdaalB/xn9O453EAokWeaBycJTWgbb5yC3dJD0RYeAh4g9yAcX4V9lWWLBzluqf
 pxbqHuROXVW37QD9yj/wegPcwuc2CJgrtCSEQjKJK8c8AVYbr/9t61uokTmRAgKE0Ulg
 3drXWZZsgrDOnqfwA5A8hsAUDHQCKzNOMKIaLwfABDr6hzM3iHug6fguG7NsK1ely4gL
 2uli/FovSQmewQv8Czb91LiP8YOMhCfGws/a7I90CgbP3Cjz7XGVEO9znXiEBTMoz4Sg
 W7Tx7rNdbu20fNbhi6vbYkf/Gu9lRnbBNiom3Abe38Ku9oxPYPwgIGKFcblFsroHtYDt
 HyWg==
X-Gm-Message-State: AOJu0YyPQ/j+gwKaLwKQKdtQx0o+I0I42tMG4wb7kStpHeOOWRX/No4P
 o95DuEYB2qknW1uiV9k9r1LEc7KhwwvcJdbzj/wWLJuAXab2ZcIath73rwKyYcvqWGMzxXCHRGn
 sLeY=
X-Gm-Gg: ASbGnctTdO8FIU6G509qxgjGjECZP2iIHe3pcp5PW/2zwXlSndgAygD6MJcpQ2n3gT2
 PySUqScE+EyMNP+cACKUgKoPAmqdPDR6EsoqxjJqyQddZfGqUhC+VdxQmxREtrX5zwfnryQXOHy
 /roZghWPc/fVsqQ5bykYpeBPt9uuwMD+HB9SwqPhceN+GRm9EAZB2RjSt6FaQfl/71zAt1P7whj
 gaGfIvgRV1V+ooQ16A2Q0k5lH1VQtM1ue9cEFDsiFOh077gGLNFYblt1lT5jHaGVs2WiMyNa04p
 h23UC78HLShZrrhh//M5LbREXxZtT6g3d14hCGN0ga3BqY8wsaZq1Kf8Qmjs5fu+3Q==
X-Google-Smtp-Source: AGHT+IHjNmmsTMwFvgzRhtIJozEro1HlPr24eqil0s/FSv2CSBrheY5n6kgxKDAO4uVJteUcr+rZ4g==
X-Received: by 2002:a05:6000:1942:b0:386:1cd3:8a0e with SMTP id
 ffacd0b85a97d-38c520b96f8mr16092847f8f.48.1738628575462; 
 Mon, 03 Feb 2025 16:22:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42d4sm176306255e9.6.2025.02.03.16.22.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:22:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 02/12] hw/arm/raspi: Merge model 4B with other models
Date: Tue,  4 Feb 2025 01:22:30 +0100
Message-ID: <20250204002240.97830-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Except we alter the device tree blob, the 4B
is just another raspi model.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c     | 114 ++++++++++++++++++++++++++++++++++++-
 hw/arm/raspi4b.c   | 136 ---------------------------------------------
 hw/arm/meson.build |   2 +-
 3 files changed, 114 insertions(+), 138 deletions(-)
 delete mode 100644 hw/arm/raspi4b.c

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 508f90479e2..3fa382d62ce 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -8,6 +8,10 @@
  * Raspberry Pi 3 emulation Copyright (c) 2018 Zoltán Baldaszti
  * Upstream code cleanup (c) 2018 Pekka Enberg
  *
+ * Raspberry Pi 4 emulation Copyright (C) 2022 Ovchinnikov Vitalii
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
@@ -16,20 +20,27 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/bcm2838.h"
 #include "hw/arm/raspi_platform.h"
+#include "hw/display/bcm2835_fb.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
 #include "qom/object.h"
+#include "system/device_tree.h"
+#include <libfdt.h>
 
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
 OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
 
+#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
+OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
+
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS */
 #define MVBAR_ADDR      0x400 /* secure vectors */
 #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
@@ -44,6 +55,11 @@ struct RaspiMachineState {
     BCM283XState soc;
 };
 
+struct Raspi4bMachineState {
+    RaspiBaseMachineState parent_obj;
+    BCM2838State soc;
+};
+
 /*
  * Board revision codes:
  * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/
@@ -301,6 +317,83 @@ void raspi_base_machine_init(MachineState *machine,
                boot_ram_size);
 }
 
+#ifdef TARGET_AARCH64
+/*
+ * Add second memory region if board RAM amount exceeds VC base address
+ * (see https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
+ * 1.2 Address Map)
+ */
+static int raspi4_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
+{
+    int ret;
+    uint32_t acells, scells;
+    char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
+                                   NULL, &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
+                                   NULL, &error_fatal);
+    if (acells == 0 || scells == 0) {
+        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
+        ret = -1;
+    } else {
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                           acells, mem_base,
+                                           scells, mem_len);
+    }
+
+    g_free(nodename);
+    return ret;
+}
+
+static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+    uint64_t ram_size;
+
+    /* Temporarily disable following devices until they are implemented */
+    const char *nodes_to_remove[] = {
+        "brcm,bcm2711-pcie",
+        "brcm,bcm2711-rng200",
+        "brcm,bcm2711-thermal",
+        "brcm,bcm2711-genet-v5",
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
+        const char *dev_str = nodes_to_remove[i];
+
+        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        if (offset >= 0) {
+            if (!fdt_nop_node(fdt, offset)) {
+                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
+            }
+        }
+    }
+
+    ram_size = board_ram_size(info->board_id);
+
+    if (info->ram_size > UPPER_RAM_BASE) {
+        raspi4_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
+    }
+}
+
+static void raspi4b_machine_init(MachineState *machine)
+{
+    Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
+    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
+    BCM2838State *soc = &s->soc;
+
+    s_base->binfo.modify_dtb = raspi4_modify_dtb;
+    s_base->binfo.board_id = mc->board_rev;
+
+    object_initialize_child(OBJECT(machine), "soc", soc,
+                            board_soc_type(mc->board_rev));
+    raspi_base_machine_init(machine, BCM283X_BASE(soc));
+}
+#endif /* TARGET_AARCH64 */
+
 void raspi_machine_init(MachineState *machine)
 {
     RaspiMachineState *s = RASPI_MACHINE(machine);
@@ -382,6 +475,20 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
+
+static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+#if HOST_LONG_BITS == 32
+    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
+#else
+    rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
+#endif
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+    mc->init = raspi4b_machine_init;
+}
 #endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
@@ -406,7 +513,12 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-#endif
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4"),
+        .parent         = TYPE_RASPI_BASE_MACHINE,
+        .instance_size  = sizeof(Raspi4bMachineState),
+        .class_init     = raspi4b_machine_class_init,
+#endif /* TARGET_AARCH64 */
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
deleted file mode 100644
index 9b08a598f39..00000000000
--- a/hw/arm/raspi4b.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * Raspberry Pi 4B emulation
- *
- * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "qemu/cutils.h"
-#include "qapi/error.h"
-#include "qapi/visitor.h"
-#include "hw/arm/raspi_platform.h"
-#include "hw/display/bcm2835_fb.h"
-#include "hw/registerfields.h"
-#include "qemu/error-report.h"
-#include "system/device_tree.h"
-#include "hw/boards.h"
-#include "hw/loader.h"
-#include "hw/arm/boot.h"
-#include "qom/object.h"
-#include "hw/arm/bcm2838.h"
-#include <libfdt.h>
-
-#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
-OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
-
-struct Raspi4bMachineState {
-    RaspiBaseMachineState parent_obj;
-    BCM2838State soc;
-};
-
-/*
- * Add second memory region if board RAM amount exceeds VC base address
- * (see https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
- * 1.2 Address Map)
- */
-static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
-{
-    int ret;
-    uint32_t acells, scells;
-    char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
-
-    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
-                                   NULL, &error_fatal);
-    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
-                                   NULL, &error_fatal);
-    if (acells == 0 || scells == 0) {
-        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
-        ret = -1;
-    } else {
-        qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
-                                           acells, mem_base,
-                                           scells, mem_len);
-    }
-
-    g_free(nodename);
-    return ret;
-}
-
-static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
-{
-    uint64_t ram_size;
-
-    /* Temporarily disable following devices until they are implemented */
-    const char *nodes_to_remove[] = {
-        "brcm,bcm2711-pcie",
-        "brcm,bcm2711-rng200",
-        "brcm,bcm2711-thermal",
-        "brcm,bcm2711-genet-v5",
-    };
-
-    for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
-        const char *dev_str = nodes_to_remove[i];
-
-        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
-        if (offset >= 0) {
-            if (!fdt_nop_node(fdt, offset)) {
-                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
-            }
-        }
-    }
-
-    ram_size = board_ram_size(info->board_id);
-
-    if (info->ram_size > UPPER_RAM_BASE) {
-        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
-    }
-}
-
-static void raspi4b_machine_init(MachineState *machine)
-{
-    Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
-    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
-    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
-    BCM2838State *soc = &s->soc;
-
-    s_base->binfo.modify_dtb = raspi4_modify_dtb;
-    s_base->binfo.board_id = mc->board_rev;
-
-    object_initialize_child(OBJECT(machine), "soc", soc,
-                            board_soc_type(mc->board_rev));
-
-    raspi_base_machine_init(machine, BCM283X_BASE(soc));
-}
-
-static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
-
-#if HOST_LONG_BITS == 32
-    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
-#else
-    rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
-#endif
-    raspi_machine_class_common_init(mc, rmc->board_rev);
-    mc->init = raspi4b_machine_init;
-}
-
-static const TypeInfo raspi4b_machine_type = {
-    .name           = TYPE_RASPI4B_MACHINE,
-    .parent         = TYPE_RASPI_BASE_MACHINE,
-    .instance_size  = sizeof(Raspi4bMachineState),
-    .class_init     = raspi4b_machine_class_init,
-};
-
-static void raspi4b_machine_register_type(void)
-{
-    type_register_static(&raspi4b_machine_type);
-}
-
-type_init(raspi4b_machine_register_type)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 490234b3b84..5177260d42b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -27,7 +27,7 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
-- 
2.47.1


