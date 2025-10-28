Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd8m-0001H0-FS; Tue, 28 Oct 2025 02:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd8N-0000pn-1n; Tue, 28 Oct 2025 02:24:43 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd8J-0000d4-Pt; Tue, 28 Oct 2025 02:24:41 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Oct
 2025 14:23:14 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Oct 2025 14:23:14 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 14/16] hw/arm/aspeed: Split AST2700 EVB machine into a
 separate source file for maintainability
Date: Tue, 28 Oct 2025 14:22:58 +0800
Message-ID: <20251028062307.2410346-15-jamin_lin@aspeedtech.com>
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

This commit moves the Aspeed AST2700 EVB machine implementation out of
aspeed.c into a new standalone file aspeed_ast27x0_evb.c.

This refactor continues the ongoing modularization of Aspeed platform
support, organizing each board’s initialization logic into its own
dedicated source file. It improves maintainability, readability, and
makes it easier to extend or update individual platform support without
cluttering aspeed.c.

Key updates include:
- Removed AST2700_EVB_HW_STRAP1 and AST2700_EVB_HW_STRAP2 macro definitions.
- Moved ast2700_evb_i2c_init(), aspeed_machine_ast2700a0_evb_class_init(),
  and aspeed_machine_ast2700a1_evb_class_init() into the new
  aspeed_ast27x0_evb.c file.
- Removed the AST2700 EVB machine type registration from aspeed.c.
- Added aspeed_ast27x0_evb.c to the Meson build system (meson.build).

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c             | 72 -------------------------------
 hw/arm/aspeed_ast27x0_evb.c | 86 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |  1 +
 3 files changed, 87 insertions(+), 72 deletions(-)
 create mode 100644 hw/arm/aspeed_ast27x0_evb.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 74d35021db..fc37f48802 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -32,14 +32,6 @@ static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
 };
 
-#ifdef TARGET_AARCH64
-/* AST2700 evb hardware value */
-/* SCU HW Strap1 */
-#define AST2700_EVB_HW_STRAP1 0x00000800
-/* SCUIO HW Strap1 */
-#define AST2700_EVB_HW_STRAP2 0x00000700
-#endif
-
 #define AST_SMP_MAILBOX_BASE            0x1e6e2180
 #define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
 #define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
@@ -511,75 +503,11 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-#ifdef TARGET_AARCH64
-static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    /* LM75 is compatible with TMP105 driver */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0),
-                            TYPE_TMP105, 0x4d);
-}
-
-static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
-                                                    const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc = "Aspeed AST2700 A0 EVB (Cortex-A35)";
-    amc->soc_name  = "ast2700-a0";
-    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
-    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
-    amc->fmc_model = "w25q01jvq";
-    amc->spi_model = "w25q512jv";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
-    amc->uart_default = ASPEED_DEV_UART12;
-    amc->i2c_init  = ast2700_evb_i2c_init;
-    amc->vbootrom = true;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
-static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
-                                                    const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->alias = "ast2700-evb";
-    mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
-    amc->soc_name  = "ast2700-a1";
-    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
-    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
-    amc->fmc_model = "w25q01jvq";
-    amc->spi_model = "w25q512jv";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
-    amc->uart_default = ASPEED_DEV_UART12;
-    amc->i2c_init  = ast2700_evb_i2c_init;
-    amc->vbootrom = true;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-#endif
-
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
-#ifdef TARGET_AARCH64
-    }, {
-        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2700a0_evb_class_init,
-        }, {
-        .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-#endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
new file mode 100644
index 0000000000..76cbe2caf0
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -0,0 +1,86 @@
+/*
+ * ASPEED AST27x0 EVB
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
+#include "hw/sensor/tmp105.h"
+
+/* AST2700 evb hardware value */
+/* SCU HW Strap1 */
+#define AST2700_EVB_HW_STRAP1 0x00000800
+/* SCUIO HW Strap1 */
+#define AST2700_EVB_HW_STRAP2 0x00000700
+
+static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    /* LM75 is compatible with TMP105 driver */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0),
+                            TYPE_TMP105, 0x4d);
+}
+
+static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
+                                                    const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc = "Aspeed AST2700 A0 EVB (Cortex-A35)";
+    amc->soc_name  = "ast2700-a0";
+    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
+    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = "w25q512jv";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
+    amc->uart_default = ASPEED_DEV_UART12;
+    amc->i2c_init  = ast2700_evb_i2c_init;
+    amc->vbootrom = true;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
+                                                    const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->alias = "ast2700-evb";
+    mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
+    amc->soc_name  = "ast2700-a1";
+    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
+    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = "w25q512jv";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
+    amc->uart_default = ASPEED_DEV_UART12;
+    amc->i2c_init  = ast2700_evb_i2c_init;
+    amc->vbootrom = true;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast27x0_evb_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2700a0_evb_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_ast27x0_evb_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index c3c054b74e..8e568e21b5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -70,6 +70,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'fby35.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast27x0.c',
+  'aspeed_ast27x0_evb.c',
   'aspeed_ast27x0-fc.c',
   'aspeed_ast27x0-ssp.c',
   'aspeed_ast27x0-tsp.c',
-- 
2.43.0


