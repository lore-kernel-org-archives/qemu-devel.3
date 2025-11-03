Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3595CCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqwk-0007jI-3p; Mon, 03 Nov 2025 04:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqvH-0006AP-C8; Mon, 03 Nov 2025 04:32:28 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqvC-0002z3-3b; Mon, 03 Nov 2025 04:32:22 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 17:28:23 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 17:28:23 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 30/30] hw/arm/aspeed: Split AST1030 EVB machine into a
 separate source file for maintainability
Date: Mon, 3 Nov 2025 17:27:41 +0800
Message-ID: <20251103092801.1282602-31-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
References: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit moves the Aspeed AST1030 MiniBMC machine
implementation out of aspeed.c into a new standalone file
aspeed_ast10x0_evb.c.

This refactor continues the modularization effort for Aspeed platform
support, placing each board’s logic and initialization sequence in its
own dedicated source file. It improves maintainability, readability, and
makes it easier to extend support for additional AST10x0-based variants.

Key updates include:
- Moved aspeed_minibmc_machine_init() and
  aspeed_minibmc_machine_ast1030_evb_class_init() from aspeed.c to
  aspeed_ast10x0_evb.c.
- Moved ast1030_evb_i2c_init() and associated I2C setup code.
- Removed AST1030 EVB machine type registration from aspeed.c.
- Added aspeed_ast10x0_evb.c to the Meson build system (meson.build).

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c             |  89 -----------------------------
 hw/arm/aspeed_ast10x0_evb.c | 109 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   1 +
 3 files changed, 110 insertions(+), 89 deletions(-)
 create mode 100644 hw/arm/aspeed_ast10x0_evb.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 7e9cd532d1..3a5071a384 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -16,14 +16,9 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
-#include "hw/i2c/smbus_eeprom.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9554.h"
-#include "hw/sensor/tmp105.h"
-#include "hw/misc/led.h"
-#include "hw/qdev-properties.h"
 #include "system/block-backend.h"
-#include "system/reset.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "hw/qdev-clock.h"
@@ -424,92 +419,8 @@ static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_props_init(oc);
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
-    aspeed_connect_serial_hds_to_uarts(bmc);
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
 static const TypeInfo aspeed_machine_types[] = {
     {
-        .name           = MACHINE_TYPE_NAME("ast1030-evb"),
-        .parent         = TYPE_ASPEED_MACHINE,
-        .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
-    }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
         .instance_size = sizeof(AspeedMachineState),
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
new file mode 100644
index 0000000000..f8519d4528
--- /dev/null
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -0,0 +1,109 @@
+/*
+ * ASPEED AST10x0 EVB
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/qdev-clock.h"
+#include "system/system.h"
+#include "hw/i2c/smbus_eeprom.h"
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
+    aspeed_connect_serial_hds_to_uarts(bmc);
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
+static const TypeInfo aspeed_ast10x0_evb_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("ast1030-evb"),
+        .parent         = TYPE_ASPEED_MACHINE,
+        .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
+        .interfaces     = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast10x0_evb_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 1467a2034c..aeaf654790 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -67,6 +67,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_qcom-firework.c',
   'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
+  'aspeed_ast10x0_evb.c',
   'fby35.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast27x0.c',
-- 
2.43.0


