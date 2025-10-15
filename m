Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA4ECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 08:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wcr-0004ZT-BN; Wed, 15 Oct 2025 04:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8wcp-0004Tg-IC; Wed, 15 Oct 2025 04:12:47 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8wcj-0007Ru-CF; Wed, 15 Oct 2025 04:12:47 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Oct
 2025 16:12:20 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Oct 2025 16:12:20 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/1] hw/arm/aspeed: Move AST1030 machine to a separate file
Date: Wed, 15 Oct 2025 16:12:18 +0800
Message-ID: <20251015081219.2766143-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015081219.2766143-1-jamin_lin@aspeedtech.com>
References: <20251015081219.2766143-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This change moves the AST1030 (MiniBMC) machine definition out of
aspeed.c into a new dedicated file, aspeed_ast10x0_boards.c.

The aspeed.c file has grown considerably over time and now contains
definitions for more than 25 machines and 5 SoC families. To improve
maintainability and consistency with other Aspeed SoC files
(aspeed_ast2400.c, aspeed_ast2600.c, aspeed_ast27x0.c, etc.), this patch
separates the AST1030 machine into its own source file.

This is part of an ongoing effort discussed with Cédric to refactor
and organize Aspeed machine models by SoC revision, following
the same "aspeed_ast<rev>_*.c" naming pattern.

No functional change intended.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed.h        |  18 ++++++
 hw/arm/aspeed.c                | 106 ++------------------------------
 hw/arm/aspeed_ast10x0_boards.c | 107 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build             |   1 +
 4 files changed, 130 insertions(+), 102 deletions(-)
 create mode 100644 hw/arm/aspeed_ast10x0_boards.c

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 6c36455656..1e907a7448 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -11,6 +11,7 @@
 
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "hw/arm/aspeed_soc.h"
 
 typedef struct AspeedMachineState AspeedMachineState;
 
@@ -24,6 +25,19 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
 #define ASPEED_MAC2_ON   (1 << 2)
 #define ASPEED_MAC3_ON   (1 << 3)
 
+struct AspeedMachineState {
+    /* Private */
+    MachineState parent_obj;
+    /* Public */
+
+    AspeedSoCState *soc;
+    MemoryRegion boot_rom;
+    bool mmio_exec;
+    uint32_t uart_chosen;
+    char *fmc_model;
+    char *spi_model;
+    uint32_t hw_strap1;
+};
 
 struct AspeedMachineClass {
     MachineClass parent_obj;
@@ -45,5 +59,9 @@ struct AspeedMachineClass {
     bool vbootrom;
 };
 
+void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
+void connect_serial_hds_to_uarts(AspeedMachineState *bmc);
+void aspeed_machine_class_init(ObjectClass *oc, const void *data);
+void aspeed_machine_instance_init(Object *obj);
 
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 21ee62f750..7dce4afa7b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -35,20 +35,6 @@ static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
 };
 
-struct AspeedMachineState {
-    /* Private */
-    MachineState parent_obj;
-    /* Public */
-
-    AspeedSoCState *soc;
-    MemoryRegion boot_rom;
-    bool mmio_exec;
-    uint32_t uart_chosen;
-    char *fmc_model;
-    char *spi_model;
-    uint32_t hw_strap1;
-};
-
 /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
 #if HOST_LONG_BITS == 32
 #define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
@@ -292,7 +278,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
                                &error_fatal);
 }
 
-static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
+void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
 {
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
     AspeedSoCState *s = bmc->soc;
@@ -1261,7 +1247,7 @@ static void aspeed_set_mmio_exec(Object *obj, bool value, Error **errp)
     ASPEED_MACHINE(obj)->mmio_exec = value;
 }
 
-static void aspeed_machine_instance_init(Object *obj)
+void aspeed_machine_instance_init(Object *obj)
 {
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(obj);
 
@@ -1352,7 +1338,7 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
                                           "Change the SPI Flash model");
 }
 
-static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
+void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
 {
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(mc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
@@ -1391,7 +1377,7 @@ static void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
                                           "Set or unset boot from EMMC");
 }
 
-static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
+void aspeed_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
@@ -1788,86 +1774,6 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-#define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
-/* Main SYSCLK frequency in Hz (200MHz) */
-#define SYSCLK_FRQ 200000000ULL
-
-static void aspeed_minibmc_machine_init(MachineState *machine)
-{
-    AspeedMachineState *bmc = ASPEED_MACHINE(machine);
-    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
-    Clock *sysclk;
-
-    sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, SYSCLK_FRQ);
-
-    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
-    object_unref(OBJECT(bmc->soc));
-    qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);
-
-    object_property_set_link(OBJECT(bmc->soc), "memory",
-                             OBJECT(get_system_memory()), &error_abort);
-    connect_serial_hds_to_uarts(bmc);
-    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
-
-    if (defaults_enabled()) {
-        aspeed_board_init_flashes(&bmc->soc->fmc,
-                            bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
-                            amc->num_cs,
-                            0);
-
-        aspeed_board_init_flashes(&bmc->soc->spi[0],
-                            bmc->spi_model ? bmc->spi_model : amc->spi_model,
-                            amc->num_cs, amc->num_cs);
-
-        aspeed_board_init_flashes(&bmc->soc->spi[1],
-                            bmc->spi_model ? bmc->spi_model : amc->spi_model,
-                            amc->num_cs, (amc->num_cs * 2));
-    }
-
-    if (amc->i2c_init) {
-        amc->i2c_init(bmc);
-    }
-
-    armv7m_load_kernel(ARM_CPU(first_cpu),
-                       machine->kernel_filename,
-                       0,
-                       AST1030_INTERNAL_FLASH_SIZE);
-}
-
-static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    /* U10 24C08 connects to SDA/SCL Group 1 by default */
-    uint8_t *eeprom_buf = g_malloc0(32 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
-
-    /* U11 LM75 connects to SDA/SCL Group 2 by default */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
-}
-
-static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
-                                                          const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc = "Aspeed AST1030 MiniBMC (Cortex-M4)";
-    amc->soc_name = "ast1030-a1";
-    amc->hw_strap1 = 0;
-    amc->hw_strap2 = 0;
-    mc->init = aspeed_minibmc_machine_init;
-    amc->i2c_init = ast1030_evb_i2c_init;
-    mc->default_ram_size = 0;
-    amc->fmc_model = "w25q80bl";
-    amc->spi_model = "w25q256";
-    amc->num_cs = 2;
-    amc->macs_mask = 0;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 #ifdef TARGET_AARCH64
 static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
 {
@@ -2047,10 +1953,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
-    }, {
-        .name           = MACHINE_TYPE_NAME("ast1030-evb"),
-        .parent         = TYPE_ASPEED_MACHINE,
-        .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
 #ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
diff --git a/hw/arm/aspeed_ast10x0_boards.c b/hw/arm/aspeed_ast10x0_boards.c
new file mode 100644
index 0000000000..d07f4f154b
--- /dev/null
+++ b/hw/arm/aspeed_ast10x0_boards.c
@@ -0,0 +1,107 @@
+/*
+ * ASPEED Ast10x0 Boards
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/boot.h"
+#include "hw/qdev-clock.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/i2c/smbus_eeprom.h"
+#include "system/system.h"
+
+#define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
+/* Main SYSCLK frequency in Hz (200MHz) */
+#define SYSCLK_FRQ 200000000ULL
+
+static void aspeed_minibmc_machine_init(MachineState *machine)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(machine);
+    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
+    Clock *sysclk;
+
+    sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+
+    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
+    object_unref(OBJECT(bmc->soc));
+    qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);
+
+    object_property_set_link(OBJECT(bmc->soc), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
+    connect_serial_hds_to_uarts(bmc);
+    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
+
+    if (defaults_enabled()) {
+        aspeed_board_init_flashes(&bmc->soc->fmc,
+                            bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
+                            amc->num_cs,
+                            0);
+
+        aspeed_board_init_flashes(&bmc->soc->spi[0],
+                            bmc->spi_model ? bmc->spi_model : amc->spi_model,
+                            amc->num_cs, amc->num_cs);
+
+        aspeed_board_init_flashes(&bmc->soc->spi[1],
+                            bmc->spi_model ? bmc->spi_model : amc->spi_model,
+                            amc->num_cs, (amc->num_cs * 2));
+    }
+
+    if (amc->i2c_init) {
+        amc->i2c_init(bmc);
+    }
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0,
+                       AST1030_INTERNAL_FLASH_SIZE);
+}
+
+static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    /* U10 24C08 connects to SDA/SCL Group 1 by default */
+    uint8_t *eeprom_buf = g_malloc0(32 * 1024);
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
+
+    /* U11 LM75 connects to SDA/SCL Group 2 by default */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
+}
+
+static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
+                                                          const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc = "Aspeed AST1030 MiniBMC (Cortex-M4)";
+    amc->soc_name = "ast1030-a1";
+    amc->hw_strap1 = 0;
+    amc->hw_strap2 = 0;
+    mc->init = aspeed_minibmc_machine_init;
+    amc->i2c_init = ast1030_evb_i2c_init;
+    mc->default_ram_size = 0;
+    amc->fmc_model = "w25q80bl";
+    amc->spi_model = "w25q256";
+    amc->num_cs = 2;
+    amc->macs_mask = 0;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast10x0_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("ast1030-evb"),
+        .parent         = TYPE_ASPEED_MACHINE,
+        .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast10x0_machine_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b88b5b06d7..8f20f8ed3d 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -46,6 +46,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
+  'aspeed_ast10x0_boards.c',
   'aspeed_eeprom.c',
   'fby35.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
-- 
2.43.0


