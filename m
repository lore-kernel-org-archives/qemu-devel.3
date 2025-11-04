Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F668CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCTK-0001g5-5a; Tue, 04 Nov 2025 03:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCT8-00015N-Mp
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCT6-0003av-I9
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ra8SahqO93wb8Whi/sdkqAyMOyj1uv9oODSIvyozkw=;
 b=DD+AvQLbigR9tye0/xgNbjQRNdDzDytGHUKjPIuCHSVGgLlIWkK+yIHpLnbqBcDWi+UCI5
 AG8YvcOf14a7Cg4CDaXpgN7VGUL0n/CJwjgRxLOstMVI5XzBgkL2JPzkHNTf5m09rhJIds
 0U+SZILbxdEym+OQI1jLQm/HfXNFYuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-FHgwttFIPz2s8Iz1W4jiwA-1; Tue,
 04 Nov 2025 03:32:38 -0500
X-MC-Unique: FHgwttFIPz2s8Iz1W4jiwA-1
X-Mimecast-MFC-AGG-ID: FHgwttFIPz2s8Iz1W4jiwA_1762245157
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56AFD18002F5; Tue,  4 Nov 2025 08:32:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFC3419560A2; Tue,  4 Nov 2025 08:32:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/30] hw/arm/aspeed: Split QCOM Firework machine into a
 separate source file for maintainability
Date: Tue,  4 Nov 2025 09:31:35 +0100
Message-ID: <20251104083144.187806-22-clg@redhat.com>
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
References: <20251104083144.187806-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

This commit moves the QCOM Firework BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_qcom-firework.c.

This refactor continues the modularization effort for Aspeed platform support,
placing each board’s logic in its own dedicated source file. It improves
maintainability, readability, and simplifies future development for new
platforms without cluttering aspeed.c.

Key updates include:
- Removed qcom_dc_scm_firework_i2c_init() and its Firework-specific devices
  from aspeed.c.
- Removed aspeed_machine_qcom_firework_class_init() and its type registration
  ("qcom-firework-bmc") from aspeed_machine_types[].
- Added new source file aspeed_ast2600_qcom-firework.c containing the
  Firework-specific initialization and machine class definition.
- Updated hw/arm/meson.build to include aspeed_ast2600_qcom-firework.c.
- Cleaned up all Firework-specific code from aspeed.c.
- Renamed `QCOM_DC_SCM_V1_BMC_HW_STRAP1` to
  `QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP1` to avoid dependency conflicts with
  other QCOM DC-SCM machines.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-22-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                       | 57 -----------------
 hw/arm/aspeed_ast2600_qcom-firework.c | 91 +++++++++++++++++++++++++++
 hw/arm/meson.build                    |  1 +
 3 files changed, 92 insertions(+), 57 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 29a036b675ea..f72b1e2eeac7 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -635,38 +635,6 @@ static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
 }
 
-static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CSlave *therm_mux, *cpuvr_mux;
-
-    /* Create the generic DC-SCM hardware */
-    qcom_dc_scm_bmc_i2c_init(bmc);
-
-    /* Now create the Firework specific hardware */
-
-    /* I2C7 CPUVR MUX */
-    cpuvr_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
-                                        "pca9546", 0x70);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2), "pca9548", 0x72);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3), "pca9548", 0x72);
-
-    /* I2C8 Thermal Diodes*/
-    therm_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
-                                        "pca9548", 0x70);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0), TYPE_LM75, 0x4C);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1), TYPE_LM75, 0x4C);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2), TYPE_LM75, 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3), TYPE_LM75, 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4), TYPE_LM75, 0x48);
-
-    /* I2C9 Fan Controller (MAX31785) */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x54);
-}
-
 static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
 {
     return ASPEED_MACHINE(obj)->mmio_exec;
@@ -1063,26 +1031,6 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
-                                                    const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Qualcomm DC-SCM V1/Firework BMC (Cortex A7)";
-    mc->deprecation_reason = "use 'ast2600-evb' instead";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = QCOM_DC_SCM_V1_BMC_HW_STRAP1;
-    amc->hw_strap2 = QCOM_DC_SCM_V1_BMC_HW_STRAP2;
-    amc->fmc_model = "n25q512a";
-    amc->spi_model = "n25q512a";
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
-    amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
@@ -1094,11 +1042,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_qcom_firework_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_qcom-firework.c b/hw/arm/aspeed_ast2600_qcom-firework.c
new file mode 100644
index 000000000000..a4dbe6eea8ab
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_qcom-firework.c
@@ -0,0 +1,91 @@
+/*
+ * Qualcomm DC-SCM V1/Firework
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
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/sensor/tmp105.h"
+
+/* Qualcomm DC-SCM Firework hardware value */
+#define QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP1  0x00000000
+#define QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP2  0x00000041
+
+#define TYPE_LM75 TYPE_TMP105
+
+static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
+}
+
+static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CSlave *therm_mux, *cpuvr_mux;
+
+    /* Create the generic DC-SCM hardware */
+    qcom_dc_scm_bmc_i2c_init(bmc);
+
+    /* Now create the Firework specific hardware */
+
+    /* I2C7 CPUVR MUX */
+    cpuvr_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
+                                        "pca9546", 0x70);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0), "pca9548", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1), "pca9548", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2), "pca9548", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3), "pca9548", 0x72);
+
+    /* I2C8 Thermal Diodes*/
+    therm_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
+                                        "pca9548", 0x70);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0), TYPE_LM75, 0x4C);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1), TYPE_LM75, 0x4C);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2), TYPE_LM75, 0x48);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3), TYPE_LM75, 0x48);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4), TYPE_LM75, 0x48);
+
+    /* I2C9 Fan Controller (MAX31785) */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x52);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x54);
+}
+
+static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
+                                                    const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Qualcomm DC-SCM V1/Firework BMC (Cortex A7)";
+    mc->deprecation_reason = "use 'ast2600-evb' instead";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP1;
+    amc->hw_strap2 = QCOM_DC_SCM_FIREWORK_BMC_HW_STRAP2;
+    amc->fmc_model = "n25q512a";
+    amc->spi_model = "n25q512a";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
+    amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2600_qcom_firework_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_qcom_firework_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_qcom_firework_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index e6f6ab424547..fbe063cf0bd4 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_bletchley.c',
   'aspeed_ast2600_fby35.c',
   'aspeed_ast2600_fuji.c',
+  'aspeed_ast2600_qcom-firework.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-- 
2.51.1


