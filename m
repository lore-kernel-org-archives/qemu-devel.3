Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3B4C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexau-00013X-IT; Tue, 27 Feb 2024 08:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaW-0000nh-5g
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaP-0002ub-2O
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:39 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so3022306f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040812; x=1709645612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QNvLoArRpYe6FOh3Nx+eEEIbesoQAZTPkpdQB+34Ov4=;
 b=l/O7EUV6KWDNA4lcA+MA3X9SOAPINsfk/2ocoaSh5R3TX3aoIbTSsJ/tmGxceqfZU9
 o4sScWlBAAJcWkSveHAqoGQumByDcuC+U8N9kBBqXO91w3JAZKoxOyQszPeU+9Umxcwi
 UUyY0dfnWJ086knXZaE1BIoBQQTn72hn034uOQKn5Bl/LQMkbevZtHnbZt3JEIR9T9KG
 +b+AK5wc0QkwvodIdE/CEtoGEcSbiPlCfX1CAFTdnf+afSkN71VafaIfD0ftb+4fkaI9
 RaYZAf+FgGZcbUVhIVMXeGE3pdJSsfj0JJC5+23tEppx7zaGfSHlJ8sqOYjBsZGi+ENz
 pg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040812; x=1709645612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNvLoArRpYe6FOh3Nx+eEEIbesoQAZTPkpdQB+34Ov4=;
 b=RuBi1jV7FWFgmLhYms3yuOcBoueLjJDuqETxYltf8wJNOKWJYfPIcyhGu8kf5KNFLa
 h+my6sms0YnxgRGQFLRCwLAcq9qz9r3Vhnqs0i8KzPQR6Fr/SLwXHc8LdIvx25pQCXnj
 SfkNDm4cQSIlfsQlAb/7fgfMxcaYd3tQY1MT3uE06DzqWqQUVJcdLhAETD7ouiTb3m2v
 oNvrC3yMY7bhHOSR12cufC1jdkO5PtCxi87LVsIi5jq6DkUqRqvC+uIX1TfirFpTqVH+
 Kqhjs35asxdYKJans1szms9VJxJkOqp5rXZw/k7f7KSrwdH3tsa8FAWSY6okuAL/Ten0
 Nt+g==
X-Gm-Message-State: AOJu0YydOep1LpMK7KzSavQLnSqdelABuuhlhHXc0cCSBf/7t8DmxVY3
 97QMeWr0bAEhtcTg7LPfXFeb/WJ8eXu/aaVrx9bEPgx+CPBkJb9PE5RRhHdW9K0Nd3jtBWL+gtg
 P
X-Google-Smtp-Source: AGHT+IGk5KBCL1nEfmp7JZrdC4cLfBKk9yl8y/Zql+uUOQ0Dir2DwJYVC7gWbEli2Pcqc4bIRL8pXg==
X-Received: by 2002:a5d:6502:0:b0:33d:e74b:e41 with SMTP id
 x2-20020a5d6502000000b0033de74b0e41mr1649465wru.66.1709040811800; 
 Tue, 27 Feb 2024 05:33:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/45] hw/arm/raspi4b: Temporarily disable unimplemented rpi4b
 devices
Date: Tue, 27 Feb 2024 13:33:00 +0000
Message-Id: <20240227133314.1721857-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

This commit adds RPi4B device tree modifications:
- disable pcie, rng200, thermal sensor and genet devices
  (they're going to be re-enabled in the following commits)
- create additional memory region in device tree
  if RAM amount exceeds VC base address.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240226000259.2752893-12-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/raspi_platform.h |  4 +++
 hw/arm/raspi.c                  |  5 +--
 hw/arm/raspi4b.c                | 62 +++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 45003e24258..0db146e5920 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -31,6 +31,9 @@
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 
+/* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
+#define MACH_TYPE_BCM2708   3138
+
 #define TYPE_RASPI_BASE_MACHINE MACHINE_TYPE_NAME("raspi-base")
 OBJECT_DECLARE_TYPE(RaspiBaseMachineState, RaspiBaseMachineClass,
                     RASPI_BASE_MACHINE)
@@ -59,6 +62,7 @@ void raspi_base_machine_init(MachineState *machine,
 
 void raspi_machine_class_common_init(MachineClass *mc,
                                      uint32_t board_rev);
+uint64_t board_ram_size(uint32_t board_rev);
 
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 8b1a046912c..a7a662f40db 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -37,9 +37,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
 #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
 #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
 
-/* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
-#define MACH_TYPE_BCM2708   3138
-
 struct RaspiMachineState {
     /*< private >*/
     RaspiBaseMachineState parent_obj;
@@ -75,7 +72,7 @@ static const struct {
     [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
-static uint64_t board_ram_size(uint32_t board_rev)
+uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
     return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index f1e91f7c98f..cb1b1f2f147 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -21,6 +21,7 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 #include "hw/arm/bcm2838.h"
+#include <libfdt.h>
 
 #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
 OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
@@ -30,6 +31,66 @@ struct Raspi4bMachineState {
     BCM2838State soc;
 };
 
+/*
+ * Add second memory region if board RAM amount exceeds VC base address
+ * (see https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
+ * 1.2 Address Map)
+ */
+static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
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
+        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
+    }
+}
+
 static void raspi4b_machine_init(MachineState *machine)
 {
     Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
@@ -37,6 +98,7 @@ static void raspi4b_machine_init(MachineState *machine)
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     BCM2838State *soc = &s->soc;
 
+    s_base->binfo.modify_dtb = raspi4_modify_dtb;
     s_base->binfo.board_id = mc->board_rev;
 
     object_initialize_child(OBJECT(machine), "soc", soc,
-- 
2.34.1


