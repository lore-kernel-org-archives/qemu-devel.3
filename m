Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0ECCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqu4-0004Qr-Hu; Mon, 03 Nov 2025 04:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqty-0004D3-Ij; Mon, 03 Nov 2025 04:31:04 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqtu-0002S6-DK; Mon, 03 Nov 2025 04:31:02 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 17:28:18 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 17:28:18 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 22/30] hw/arm/aspeed: Split QCOM DC-SCM V1 machine into a
 separate source file for maintainability
Date: Mon, 3 Nov 2025 17:27:33 +0800
Message-ID: <20251103092801.1282602-23-jamin_lin@aspeedtech.com>
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

This commit moves the QCOM DC-SCM V1 BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_qcom-dc-scm-v1.c.

This refactor continues the modularization effort for Aspeed platform support,
placing each board’s logic in its own dedicated source file. It improves
maintainability, readability, and simplifies future development for new
platforms without cluttering aspeed.c.

Key updates include:
- Moved QCOM_DC_SCM_V1_BMC_HW_STRAP1 and QCOM_DC_SCM_V1_BMC_HW_STRAP2 macro
  into the new file aspeed_ast2600_qcom-dc-scm-v1.c.
- Moved qcom_dc_scm_bmc_i2c_init() and aspeed_machine_qcom_dc_scm_v1_class_init()
  into the new file aspeed_ast2600_qcom-dc-scm-v1.c.
- Moved "qcom-dc-scm-v1-bmc" machine type registration from aspeed.c to the new file.
- Updated hw/arm/meson.build to include aspeed_ast2600_qcom-dc-scm-v1.c.
- Cleaned up all QCOM DC-SCM V1-specific code from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                        | 36 -----------------
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c | 56 ++++++++++++++++++++++++++
 hw/arm/meson.build                     |  1 +
 3 files changed, 57 insertions(+), 36 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f72b1e2eea..89a4632425 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -56,10 +56,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 #define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
 #define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
 
-/* Qualcomm DC-SCM hardware value */
-#define QCOM_DC_SCM_V1_BMC_HW_STRAP1  0x00000000
-#define QCOM_DC_SCM_V1_BMC_HW_STRAP2  0x00000041
-
 #define AST_SMP_MAILBOX_BASE            0x1e6e2180
 #define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
 #define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
@@ -628,13 +624,6 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
                           gb200nvl_bmc_fruid_len);
 }
 
-static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
-}
-
 static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
 {
     return ASPEED_MACHINE(obj)->mmio_exec;
@@ -1011,37 +1000,12 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
 }
 #endif
 
-static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
-                                                     const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Qualcomm DC-SCM V1 BMC (Cortex A7)";
-    mc->deprecation_reason = "use 'ast2600-evb' instead";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = QCOM_DC_SCM_V1_BMC_HW_STRAP1;
-    amc->hw_strap2 = QCOM_DC_SCM_V1_BMC_HW_STRAP2;
-    amc->fmc_model = "n25q512a";
-    amc->spi_model = "n25q512a";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
-    amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c b/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
new file mode 100644
index 0000000000..822c61c737
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
@@ -0,0 +1,56 @@
+/*
+ * Qualcomm DC-SCM V1
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+
+/* Qualcomm DC-SCM hardware value */
+#define QCOM_DC_SCM_V1_BMC_HW_STRAP1  0x00000000
+#define QCOM_DC_SCM_V1_BMC_HW_STRAP2  0x00000041
+
+static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
+}
+
+static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
+                                                     const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Qualcomm DC-SCM V1 BMC (Cortex A7)";
+    mc->deprecation_reason = "use 'ast2600-evb' instead";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = QCOM_DC_SCM_V1_BMC_HW_STRAP1;
+    amc->hw_strap2 = QCOM_DC_SCM_V1_BMC_HW_STRAP2;
+    amc->fmc_model = "n25q512a";
+    amc->spi_model = "n25q512a";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
+    amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2600_qcom_dc_scm_v1_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_qcom_dc_scm_v1_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index fbe063cf0b..588a72bdf2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_bletchley.c',
   'aspeed_ast2600_fby35.c',
   'aspeed_ast2600_fuji.c',
+  'aspeed_ast2600_qcom-dc-scm-v1.c',
   'aspeed_ast2600_qcom-firework.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
-- 
2.43.0


