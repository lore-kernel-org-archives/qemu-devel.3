Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F440CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCTB-00015c-1M; Tue, 04 Nov 2025 03:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCT0-0000mw-WF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSw-0003Y1-Cq
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDaB/IsENP/Y0ThuPfjXCrXO0e2vMI2w9CGr/c7whgE=;
 b=AnnGUxIYF37uCQ5KLnAT5umXK0Lk5UkgBtV9edZOtUBv9Hv/OhUh1LbVexKqmilFEprkwB
 Yo6qcEKk0h+9C3pMIDmFzYr/08wMv7pNnGOnqESSowiOCpOhkQovo9kSepApbInHpSDL5P
 AMSx43Kp0ExTMiMff7OxXKesX1WTpQE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-PEmda5ecNeyxTylJh7Rzdg-1; Tue,
 04 Nov 2025 03:32:31 -0500
X-MC-Unique: PEmda5ecNeyxTylJh7Rzdg-1
X-Mimecast-MFC-AGG-ID: PEmda5ecNeyxTylJh7Rzdg_1762245150
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B6231955F04; Tue,  4 Nov 2025 08:32:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8560319560A2; Tue,  4 Nov 2025 08:32:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/30] hw/arm/aspeed: Split Bletchley machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:32 +0100
Message-ID: <20251104083144.187806-19-clg@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit moves the Facebook Bletchley BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_bletchley.c.

This refactor continues the modularization effort for Aspeed platform support,
placing each board’s logic in its own dedicated source file.
It improves maintainability, readability, and simplifies future development for
new platforms without cluttering aspeed.c.

Key updates include:
- Moved BLETCHLEY_BMC_HW_STRAP1 and BLETCHLEY_BMC_HW_STRAP2 macro definitions into the new file.
- Moved bletchley_bmc_i2c_init() I²C initialization logic into the new file.
- Moved aspeed_machine_bletchley_class_init() and type registration.
- Added aspeed_ast2600_bletchley.c to the build system (meson.build).
- Removed all Bletchley-specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-19-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                   | 77 ------------------------
 hw/arm/aspeed_ast2600_bletchley.c | 97 +++++++++++++++++++++++++++++++
 hw/arm/meson.build                |  1 +
 3 files changed, 98 insertions(+), 77 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_bletchley.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ba0c9a62ff66..3acb45b22c28 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -56,10 +56,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 #define FUJI_BMC_HW_STRAP1    0x00000000
 #define FUJI_BMC_HW_STRAP2    0x00000000
 
-/* Bletchley hardware value */
-#define BLETCHLEY_BMC_HW_STRAP1 0x00002000
-#define BLETCHLEY_BMC_HW_STRAP2 0x00000801
-
 /* GB200NVL hardware value */
 #define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
 #define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
@@ -685,53 +681,6 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
 }
 
-static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CBus *i2c[13] = {};
-    for (int i = 0; i < 13; i++) {
-        if ((i == 8) || (i == 11)) {
-            continue;
-        }
-        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
-    }
-
-    /* Bus 0 - 5 all have the same config. */
-    for (int i = 0; i < 6; i++) {
-        /* Missing model: ti,ina230 @ 0x45 */
-        /* Missing model: mps,mp5023 @ 0x40 */
-        i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0x4f);
-        /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works enough */
-        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x76);
-        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x67);
-        /* Missing model: fsc,fusb302 @ 0x22 */
-    }
-
-    /* Bus 6 */
-    at24c_eeprom_init(i2c[6], 0x56, 65536);
-    /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
-    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
-
-
-    /* Bus 7 */
-    at24c_eeprom_init(i2c[7], 0x54, 65536);
-
-    /* Bus 9 */
-    i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);
-
-    /* Bus 10 */
-    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);
-    /* Missing model: ti,hdc1080 @ 0x40 */
-    i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);
-
-    /* Bus 12 */
-    /* Missing model: adi,adm1278 @ 0x11 */
-    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);
-    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);
-    i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
-}
-
-
 static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1059,27 +1008,6 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
-
-static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
-                                                const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Facebook Bletchley BMC (Cortex-A7)";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = BLETCHLEY_BMC_HW_STRAP1;
-    amc->hw_strap2 = BLETCHLEY_BMC_HW_STRAP2;
-    amc->fmc_model = "w25q01jvq";
-    amc->spi_model = NULL;
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC2_ON;
-    amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,
                                                const void *data)
 {
@@ -1367,11 +1295,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_bletchley_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
new file mode 100644
index 000000000000..b7e84db1438a
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -0,0 +1,97 @@
+/*
+ * Facebook Bletchley
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
+#include "hw/gpio/pca9552.h"
+#include "hw/nvram/eeprom_at24c.h"
+
+#define TYPE_TMP421 "tmp421"
+/* Bletchley hardware value */
+#define BLETCHLEY_BMC_HW_STRAP1 0x00002000
+#define BLETCHLEY_BMC_HW_STRAP2 0x00000801
+#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[13] = {};
+    for (int i = 0; i < 13; i++) {
+        if ((i == 8) || (i == 11)) {
+            continue;
+        }
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* Bus 0 - 5 all have the same config. */
+    for (int i = 0; i < 6; i++) {
+        /* Missing model: ti,ina230 @ 0x45 */
+        /* Missing model: mps,mp5023 @ 0x40 */
+        i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0x4f);
+        /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works enough */
+        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x76);
+        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x67);
+        /* Missing model: fsc,fusb302 @ 0x22 */
+    }
+
+    /* Bus 6 */
+    at24c_eeprom_init(i2c[6], 0x56, 65536);
+    /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
+    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
+
+
+    /* Bus 7 */
+    at24c_eeprom_init(i2c[7], 0x54, 65536);
+
+    /* Bus 9 */
+    i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);
+
+    /* Bus 10 */
+    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);
+    /* Missing model: ti,hdc1080 @ 0x40 */
+    i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);
+
+    /* Bus 12 */
+    /* Missing model: adi,adm1278 @ 0x11 */
+    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);
+    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);
+    i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
+}
+
+static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
+                                                const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook Bletchley BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = BLETCHLEY_BMC_HW_STRAP1;
+    amc->hw_strap2 = BLETCHLEY_BMC_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = NULL;
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC2_ON;
+    amc->i2c_init  = bletchley_bmc_i2c_init;
+    mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_bletchley_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_bletchley_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_bletchley_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index e52901108be2..6d80e2caf9c5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -57,6 +57,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_witherspoon.c',
   'aspeed_ast2500_yosemitev2.c',
   'aspeed_ast2600.c',
+  'aspeed_ast2600_bletchley.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-- 
2.51.1


