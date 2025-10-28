Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B649FCCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd8B-0000J4-EU; Tue, 28 Oct 2025 02:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd89-0000Fh-Kw; Tue, 28 Oct 2025 02:24:29 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd86-0000d4-Vr; Tue, 28 Oct 2025 02:24:29 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Oct
 2025 14:23:13 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Oct 2025 14:23:13 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 12/16] hw/arm/aspeed: Split Catalina machine into a
 separate source file for maintainability
Date: Tue, 28 Oct 2025 14:22:56 +0800
Message-ID: <20251028062307.2410346-13-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028062307.2410346-1-jamin_lin@aspeedtech.com>
References: <20251028062307.2410346-1-jamin_lin@aspeedtech.com>
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

This commit moves the Facebook Catalina BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_catalina.c.

This refactor continues the ongoing modularization of Aspeed platform
support, organizing each board’s logic into its own dedicated source file.
It improves maintainability, readability, and simplifies future
development of new BMC platforms without cluttering aspeed.c.

Key updates include:
- Removed CATALINA_BMC_HW_STRAP1 and CATALINA_BMC_HW_STRAP2 macro definitions.
- Moved catalina_bmc_i2c_init() and all Catalina-specific I2C device setup
  into the new aspeed_ast2600_catalina.c file.
- Moved aspeed_machine_catalina_class_init() and type registration logic
  out of aspeed.c.
- Cleaned up all Catalina-specific code and macros from aspeed.c.
- Added aspeed_ast2600_catalina.c to the Meson build system (meson.build).

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                  | 211 -----------------------------
 hw/arm/aspeed_ast2600_catalina.c | 223 +++++++++++++++++++++++++++++++
 hw/arm/meson.build               |   1 +
 3 files changed, 224 insertions(+), 211 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_catalina.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index dbe4f57145..81099e56b5 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -15,11 +15,9 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/block/flash.h"
-#include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9554.h"
-#include "hw/nvram/eeprom_at24c.h"
 #include "hw/sensor/tmp105.h"
 #include "hw/misc/led.h"
 #include "hw/qdev-properties.h"
@@ -34,13 +32,6 @@ static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
 };
 
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
-#else
-#define ASPEED_RAM_SIZE(sz) (sz)
-#endif
-
 /* AST2600 evb hardware value */
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
@@ -301,184 +292,6 @@ I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
                             TYPE_PCA9554, addr);
 }
 
-#define TYPE_LM75 TYPE_TMP105
-#define TYPE_TMP75 TYPE_TMP105
-#define TYPE_TMP421 "tmp421"
-#define TYPE_DS1338 "ds1338"
-
-/* Catalina hardware value */
-#define CATALINA_BMC_HW_STRAP1 0x00002002
-#define CATALINA_BMC_HW_STRAP2 0x00000800
-
-#define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
-
-static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
-
-    AspeedSoCState *soc = bmc->soc;
-    I2CBus *i2c[16] = {};
-    I2CSlave *i2c_mux;
-
-    /* busses 0-15 are all used. */
-    for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
-        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
-    }
-
-    /* &i2c0 */
-    /* i2c-mux@71 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
-
-    /* i2c-mux@72 (PCA9546) on i2c0 */
-    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
-
-    /* i2c0mux1ch1 */
-    /* io_expander7 - pca9535@20 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
-                            TYPE_PCA9552, 0x20);
-    /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
-
-    /* i2c-mux@73 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
-
-    /* i2c-mux@75 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
-
-    /* i2c-mux@76 (PCA9546) on i2c0 */
-    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
-
-    /* i2c0mux4ch1 */
-    /* io_expander8 - pca9535@21 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
-                            TYPE_PCA9552, 0x21);
-    /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
-
-    /* i2c-mux@77 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);
-
-
-    /* &i2c1 */
-    /* i2c-mux@70 (PCA9548) on i2c1 */
-    i2c_mux = i2c_slave_create_simple(i2c[1], TYPE_PCA9548, 0x70);
-    /* i2c1mux0ch0 */
-    /* ina238@41 - no model */
-    /* ina238@42 - no model */
-    /* ina238@44 - no model */
-    /* i2c1mux0ch1 */
-    /* ina238@41 - no model */
-    /* ina238@43 - no model */
-    /* i2c1mux0ch4 */
-    /* ltc4287@42 - no model */
-    /* ltc4287@43 - no model */
-
-    /* i2c1mux0ch5 */
-    /* eeprom@54 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB);
-    /* tpm75@4f */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
-
-    /* i2c1mux0ch6 */
-    /* io_expander5 - pca9554@27 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
-                            TYPE_PCA9554, 0x27);
-    /* io_expander6 - pca9555@25 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
-                            TYPE_PCA9552, 0x25);
-    /* eeprom@51 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB);
-
-    /* i2c1mux0ch7 */
-    /* eeprom@53 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB);
-    /* temperature-sensor@4b - tmp75 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
-
-    /* &i2c2 */
-    /* io_expander0 - pca9555@20 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
-    /* io_expander0 - pca9555@21 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
-    /* io_expander0 - pca9555@27 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
-    /* eeprom@50 */
-    at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
-    /* eeprom@51 */
-    at24c_eeprom_init(i2c[2], 0x51, 8 * KiB);
-
-    /* &i2c5 */
-    /* i2c-mux@70 (PCA9548) on i2c5 */
-    i2c_mux = i2c_slave_create_simple(i2c[5], TYPE_PCA9548, 0x70);
-    /* i2c5mux0ch6 */
-    /* eeprom@52 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB);
-    /* i2c5mux0ch7 */
-    /* ina230@40 - no model */
-    /* ina230@41 - no model */
-    /* ina230@44 - no model */
-    /* ina230@45 - no model */
-
-    /* &i2c6 */
-    /* io_expander3 - pca9555@21 */
-    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
-    /* rtc@6f - nct3018y */
-    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
-
-    /* &i2c9 */
-    /* io_expander4 - pca9555@4f */
-    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
-    /* temperature-sensor@4b - tpm75 */
-    i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
-    /* eeprom@50 */
-    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
-    /* eeprom@56 */
-    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
-
-    /* &i2c10 */
-    /* temperature-sensor@1f - tpm421 */
-    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
-    /* eeprom@50 */
-    at24c_eeprom_init(i2c[10], 0x50, 8 * KiB);
-
-    /* &i2c11 */
-    /* ssif-bmc@10 - no model */
-
-    /* &i2c12 */
-    /* eeprom@50 */
-    at24c_eeprom_init(i2c[12], 0x50, 8 * KiB);
-
-    /* &i2c13 */
-    /* eeprom@50 */
-    at24c_eeprom_init(i2c[13], 0x50, 8 * KiB);
-    /* eeprom@54 */
-    at24c_eeprom_init(i2c[13], 0x54, 256);
-    /* eeprom@55 */
-    at24c_eeprom_init(i2c[13], 0x55, 256);
-    /* eeprom@57 */
-    at24c_eeprom_init(i2c[13], 0x57, 256);
-
-    /* &i2c14 */
-    /* io_expander9 - pca9555@10 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
-    /* io_expander10 - pca9555@11 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
-    /* io_expander11 - pca9555@12 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
-    /* io_expander12 - pca9555@13 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
-    /* io_expander13 - pca9555@14 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
-    /* io_expander14 - pca9555@15 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
-
-    /* &i2c15 */
-    /* temperature-sensor@1f - tmp421 */
-    i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
-    /* eeprom@52 */
-    at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
-}
-
 static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
 {
     return ASPEED_MACHINE(obj)->mmio_exec;
@@ -657,26 +470,6 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
     aspeed_machine_ast2600_class_emmc_init(oc);
 };
 
-static void aspeed_machine_catalina_class_init(ObjectClass *oc,
-                                               const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Facebook Catalina BMC (Cortex-A7)";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = CATALINA_BMC_HW_STRAP1;
-    amc->hw_strap2 = CATALINA_BMC_HW_STRAP2;
-    amc->fmc_model = "w25q01jvq";
-    amc->spi_model = NULL;
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC2_ON;
-    amc->i2c_init  = catalina_bmc_i2c_init;
-    mc->default_ram_size = CATALINA_BMC_RAM_SIZE;
-    aspeed_machine_class_init_cpus_defaults(mc);
-    aspeed_machine_ast2600_class_emmc_init(oc);
-}
-
 #define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
 /* Main SYSCLK frequency in Hz (200MHz) */
 #define SYSCLK_FRQ 200000000ULL
@@ -816,10 +609,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("catalina-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_catalina_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
new file mode 100644
index 0000000000..30427ea148
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -0,0 +1,223 @@
+/*
+ * Facebook Catalina
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/gpio/pca9552.h"
+#include "hw/gpio/pca9554.h"
+#include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/tmp105.h"
+
+/* Catalina hardware value */
+#define CATALINA_BMC_HW_STRAP1 0x00002002
+#define CATALINA_BMC_HW_STRAP2 0x00000800
+
+#define TYPE_TMP75 TYPE_TMP105
+#define TYPE_TMP421 "tmp421"
+#define TYPE_DS1338 "ds1338"
+
+static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
+
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16] = {};
+    I2CSlave *i2c_mux;
+
+    /* busses 0-15 are all used. */
+    for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* &i2c0 */
+    /* i2c-mux@71 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
+
+    /* i2c-mux@72 (PCA9546) on i2c0 */
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
+
+    /* i2c0mux1ch1 */
+    /* io_expander7 - pca9535@20 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+                            TYPE_PCA9552, 0x20);
+    /* eeprom@50 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+
+    /* i2c-mux@73 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
+
+    /* i2c-mux@75 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
+
+    /* i2c-mux@76 (PCA9546) on i2c0 */
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
+
+    /* i2c0mux4ch1 */
+    /* io_expander8 - pca9535@21 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+                            TYPE_PCA9552, 0x21);
+    /* eeprom@50 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+
+    /* i2c-mux@77 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);
+
+
+    /* &i2c1 */
+    /* i2c-mux@70 (PCA9548) on i2c1 */
+    i2c_mux = i2c_slave_create_simple(i2c[1], TYPE_PCA9548, 0x70);
+    /* i2c1mux0ch0 */
+    /* ina238@41 - no model */
+    /* ina238@42 - no model */
+    /* ina238@44 - no model */
+    /* i2c1mux0ch1 */
+    /* ina238@41 - no model */
+    /* ina238@43 - no model */
+    /* i2c1mux0ch4 */
+    /* ltc4287@42 - no model */
+    /* ltc4287@43 - no model */
+
+    /* i2c1mux0ch5 */
+    /* eeprom@54 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB);
+    /* tpm75@4f */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
+
+    /* i2c1mux0ch6 */
+    /* io_expander5 - pca9554@27 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
+                            TYPE_PCA9554, 0x27);
+    /* io_expander6 - pca9555@25 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
+                            TYPE_PCA9552, 0x25);
+    /* eeprom@51 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB);
+
+    /* i2c1mux0ch7 */
+    /* eeprom@53 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB);
+    /* temperature-sensor@4b - tmp75 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
+
+    /* &i2c2 */
+    /* io_expander0 - pca9555@20 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
+    /* io_expander0 - pca9555@21 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
+    /* io_expander0 - pca9555@27 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
+    /* eeprom@51 */
+    at24c_eeprom_init(i2c[2], 0x51, 8 * KiB);
+
+    /* &i2c5 */
+    /* i2c-mux@70 (PCA9548) on i2c5 */
+    i2c_mux = i2c_slave_create_simple(i2c[5], TYPE_PCA9548, 0x70);
+    /* i2c5mux0ch6 */
+    /* eeprom@52 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB);
+    /* i2c5mux0ch7 */
+    /* ina230@40 - no model */
+    /* ina230@41 - no model */
+    /* ina230@44 - no model */
+    /* ina230@45 - no model */
+
+    /* &i2c6 */
+    /* io_expander3 - pca9555@21 */
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
+    /* rtc@6f - nct3018y */
+    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
+
+    /* &i2c9 */
+    /* io_expander4 - pca9555@4f */
+    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
+    /* temperature-sensor@4b - tpm75 */
+    i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
+    /* eeprom@56 */
+    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
+
+    /* &i2c10 */
+    /* temperature-sensor@1f - tpm421 */
+    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[10], 0x50, 8 * KiB);
+
+    /* &i2c11 */
+    /* ssif-bmc@10 - no model */
+
+    /* &i2c12 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[12], 0x50, 8 * KiB);
+
+    /* &i2c13 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[13], 0x50, 8 * KiB);
+    /* eeprom@54 */
+    at24c_eeprom_init(i2c[13], 0x54, 256);
+    /* eeprom@55 */
+    at24c_eeprom_init(i2c[13], 0x55, 256);
+    /* eeprom@57 */
+    at24c_eeprom_init(i2c[13], 0x57, 256);
+
+    /* &i2c14 */
+    /* io_expander9 - pca9555@10 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
+    /* io_expander10 - pca9555@11 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
+    /* io_expander11 - pca9555@12 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
+    /* io_expander12 - pca9555@13 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
+    /* io_expander13 - pca9555@14 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
+    /* io_expander14 - pca9555@15 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
+
+    /* &i2c15 */
+    /* temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
+    /* eeprom@52 */
+    at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
+}
+
+static void aspeed_machine_catalina_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook Catalina BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = CATALINA_BMC_HW_STRAP1;
+    amc->hw_strap2 = CATALINA_BMC_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = NULL;
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC2_ON;
+    amc->i2c_init  = catalina_bmc_i2c_init;
+    mc->default_ram_size = 2 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast2600_class_emmc_init(oc);
+}
+
+static const TypeInfo aspeed_ast2600_catalina_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("catalina-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_catalina_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_ast2600_catalina_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index e81dad1ac4..75d25626d1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -58,6 +58,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_yosemitev2.c',
   'aspeed_ast2600.c',
   'aspeed_ast2600_bletchley.c',
+  'aspeed_ast2600_catalina.c',
   'aspeed_ast2600_fby35.c',
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
-- 
2.43.0


