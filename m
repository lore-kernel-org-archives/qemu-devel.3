Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBA7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 03:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG7V3-0002ct-9P; Mon, 03 Nov 2025 22:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Uf-0002VO-K1; Mon, 03 Nov 2025 22:14:03 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Ua-00031V-Sg; Mon, 03 Nov 2025 22:14:00 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 11:13:30 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 11:13:30 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v4 08/30] hw/arm/aspeed: Split YosemiteV2 machine into a
 separate source file for maintainability
Date: Tue, 4 Nov 2025 11:12:46 +0800
Message-ID: <20251104031325.146374-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
References: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
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

This commit moves the YosemiteV2 BMC machine implementation from
aspeed.c into a new standalone file aspeed_ast2500_yosemitev2.c.

To support splitting YosemiteV2 into a dedicated source file,
a new YOSEMITEV2_BMC_HW_STRAP1 macro is added as a copy of
AST2500_EVB_HW_STRAP1.

The refactor is part of an ongoing effort to modularize Aspeed
machine definitions by separating each board into its own source
file. This improves code readability, maintainability, and simplifies
future platform-specific changes.

Key updates include:

- Moved yosemitev2_bmc_i2c_init() and its FRU data into a new file.
- Removed aspeed_machine_yosemitev2_class_init() and type registration
from aspeed.c.
- Removed YosemiteV2 FRUID data and declarations from
aspeed_eeprom.c and aspeed_eeprom.h.
- Added aspeed_ast2500_yosemitev2.c to the build system
(meson.build).

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_eeprom.h             |  3 -
 hw/arm/aspeed.c                    | 37 ------------
 hw/arm/aspeed_ast2500_yosemitev2.c | 92 ++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.c             | 22 -------
 hw/arm/meson.build                 |  1 +
 5 files changed, 93 insertions(+), 62 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_yosemitev2.c

diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
index a9ae95940c..5448eeeab7 100644
--- a/hw/arm/aspeed_eeprom.h
+++ b/hw/arm/aspeed_eeprom.h
@@ -14,9 +14,6 @@ extern const size_t fby35_nic_fruid_len;
 extern const size_t fby35_bb_fruid_len;
 extern const size_t fby35_bmc_fruid_len;
 
-extern const uint8_t yosemitev2_bmc_fruid[];
-extern const size_t yosemitev2_bmc_fruid_len;
-
 extern const uint8_t rainier_bb_fruid[];
 extern const size_t rainier_bb_fruid_len;
 extern const uint8_t rainier_bmc_fruid[];
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 42f4203f9d..731ca7a1aa 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -470,20 +470,6 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
                      TYPE_TMP105, 0x4d);
 }
 
-static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 4), 0x51, 128 * KiB);
-    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
-                          yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len);
-    /* TMP421 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421", 0x1f);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4e);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4f);
-
-}
-
 static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1376,24 +1362,6 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
-                                                 const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Facebook YosemiteV2 BMC (ARM1176)";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = AST2500_EVB_HW_STRAP1;
-    amc->hw_strap2 = 0;
-    amc->fmc_model = "n25q256a";
-    amc->spi_model = "mx25l25635e";
-    amc->num_cs    = 2;
-    amc->i2c_init  = yosemitev2_bmc_i2c_init;
-    mc->default_ram_size       = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_romulus_class_init(ObjectClass *oc,
                                               const void *data)
 {
@@ -1831,11 +1799,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_yosemitev2_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
new file mode 100644
index 0000000000..6aed6bc5d9
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -0,0 +1,92 @@
+/*
+ * Facebook YosemiteV2
+ *
+ * Copyright 2016 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/nvram/eeprom_at24c.h"
+
+/* value: 0xF100C2E6 */
+#define YOSEMITEV2_BMC_HW_STRAP1 ((                                        \
+        AST2500_HW_STRAP1_DEFAULTS |                                    \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_MAC1_RGMII |                                       \
+        SCU_HW_STRAP_MAC0_RGMII) &                                      \
+        ~SCU_HW_STRAP_2ND_BOOT_WDT)
+
+/* Yosemite V2 BMC FRU */
+static const uint8_t yosemitev2_bmc_fruid[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0d, 0x00, 0x00, 0xf1, 0x01, 0x0c, 0x00, 0x36,
+    0xe6, 0xd0, 0xc6, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xd2, 0x42, 0x61,
+    0x73, 0x65, 0x62, 0x6f, 0x61, 0x72, 0x64, 0x20, 0x4d, 0x50, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0xcd, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xce, 0x58, 0x58, 0x58, 0x58, 0x58,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc3, 0x31, 0x2e,
+    0x30, 0xc9, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xd2,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc1, 0x39, 0x01, 0x0c, 0x00, 0xc6,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xd2, 0x59, 0x6f, 0x73, 0x65, 0x6d,
+    0x69, 0x74, 0x65, 0x20, 0x56, 0x32, 0x20, 0x4d, 0x50, 0x00, 0x00, 0x00,
+    0x00, 0xce, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
+    0x58, 0x58, 0x58, 0x58, 0xc4, 0x45, 0x56, 0x54, 0x32, 0xcd, 0x58, 0x58,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc7,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc3, 0x31, 0x2e, 0x30, 0xc9,
+    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc8, 0x43, 0x6f,
+    0x6e, 0x66, 0x69, 0x67, 0x20, 0x41, 0xc1, 0x45,
+};
+
+static const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
+
+static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 4), 0x51, 128 * KiB);
+    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
+                          yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len);
+    /* TMP421 */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421", 0x1f);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4e);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4f);
+
+}
+
+static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
+                                                 const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook YosemiteV2 BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = YOSEMITEV2_BMC_HW_STRAP1;
+    amc->hw_strap2 = 0;
+    amc->fmc_model = "n25q256a";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 2;
+    amc->i2c_init  = yosemitev2_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_yosemitev2_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_yosemitev2_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_yosemitev2_types)
+
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
index f0ced29cf1..124277eaca 100644
--- a/hw/arm/aspeed_eeprom.c
+++ b/hw/arm/aspeed_eeprom.c
@@ -78,27 +78,6 @@ const uint8_t fby35_bmc_fruid[] = {
     0x6e, 0x66, 0x69, 0x67, 0x20, 0x41, 0xc1, 0x45,
 };
 
-/* Yosemite V2 BMC FRU */
-const uint8_t yosemitev2_bmc_fruid[] = {
-    0x01, 0x00, 0x00, 0x01, 0x0d, 0x00, 0x00, 0xf1, 0x01, 0x0c, 0x00, 0x36,
-    0xe6, 0xd0, 0xc6, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xd2, 0x42, 0x61,
-    0x73, 0x65, 0x62, 0x6f, 0x61, 0x72, 0x64, 0x20, 0x4d, 0x50, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0xcd, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xce, 0x58, 0x58, 0x58, 0x58, 0x58,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc3, 0x31, 0x2e,
-    0x30, 0xc9, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xd2,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc1, 0x39, 0x01, 0x0c, 0x00, 0xc6,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xd2, 0x59, 0x6f, 0x73, 0x65, 0x6d,
-    0x69, 0x74, 0x65, 0x20, 0x56, 0x32, 0x20, 0x4d, 0x50, 0x00, 0x00, 0x00,
-    0x00, 0xce, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
-    0x58, 0x58, 0x58, 0x58, 0xc4, 0x45, 0x56, 0x54, 0x32, 0xcd, 0x58, 0x58,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc7,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc3, 0x31, 0x2e, 0x30, 0xc9,
-    0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58, 0xc8, 0x43, 0x6f,
-    0x6e, 0x66, 0x69, 0x67, 0x20, 0x41, 0xc1, 0x45,
-};
-
 const uint8_t rainier_bb_fruid[] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84,
     0x28, 0x00, 0x52, 0x54, 0x04, 0x56, 0x48, 0x44, 0x52, 0x56, 0x44, 0x02,
@@ -163,7 +142,6 @@ const uint8_t gb200nvl_bmc_fruid[] = {
 const size_t fby35_nic_fruid_len = sizeof(fby35_nic_fruid);
 const size_t fby35_bb_fruid_len = sizeof(fby35_bb_fruid);
 const size_t fby35_bmc_fruid_len = sizeof(fby35_bmc_fruid);
-const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
 const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
 const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
 const size_t gb200nvl_bmc_fruid_len = sizeof(gb200nvl_bmc_fruid);
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 870202ce85..8d9f1e1609 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -47,6 +47,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
   'aspeed_ast2500_tiogapass.c',
+  'aspeed_ast2500_yosemitev2.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
-- 
2.43.0


