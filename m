Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80B6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCUz-0005Ep-Q5; Tue, 04 Nov 2025 03:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTL-0001oh-Lo
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:33:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTI-0003f6-As
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spfW6+gMyLIxWlB9L5EQE7D0ZiBP1IoB/ZIkqNz+dl4=;
 b=a68E3yvkPUs815bTHNzRMI+oDFuJLrVSRIWueow2wZVla5dDjSy80EwWh03/jwG+6Uel09
 ppPE1h/QR+4PUFj1tJCbzao+MaSABhJhmmi35ATAGXBDFY+aIgyKzzmOGdeSX0uRRe8Ic6
 fw2tiWhA+zDfEBhBzCuIUBu+feoESkQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-ulSWRUj8OhaZWKZ1gZC6Yg-1; Tue,
 04 Nov 2025 03:32:53 -0500
X-MC-Unique: ulSWRUj8OhaZWKZ1gZC6Yg-1
X-Mimecast-MFC-AGG-ID: ulSWRUj8OhaZWKZ1gZC6Yg_1762245172
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F9C1800245; Tue,  4 Nov 2025 08:32:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E66A19560A2; Tue,  4 Nov 2025 08:32:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/30] hw/arm/aspeed: Split AST2700 EVB machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:42 +0100
Message-ID: <20251104083144.187806-29-clg@redhat.com>
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

This commit moves the Aspeed AST2700 EVB machine implementation out of
aspeed.c into a new standalone file aspeed_ast27x0_evb.c.

This refactor continues the ongoing modularization of Aspeed platform
support, organizing each board’s initialization logic into its own
dedicated source file. It improves maintainability, readability, and
makes it easier to extend or update individual platform support without
cluttering aspeed.c.

Key updates include:
- Moved AST2700_EVB_HW_STRAP1 and AST2700_EVB_HW_STRAP2 macro definitions
  into the new aspeed_ast27x0_evb.c file.
- Moved ast2700_evb_i2c_init(), aspeed_machine_ast2700a0_evb_class_init(),
  and aspeed_machine_ast2700a1_evb_class_init() into the new
  aspeed_ast27x0_evb.c file.
- Removed the AST2700 EVB machine type registration from aspeed.c.
- Added aspeed_ast27x0_evb.c to the Meson build system (meson.build).

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-29-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c             | 75 -------------------------------
 hw/arm/aspeed_ast27x0_evb.c | 88 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |  1 +
 3 files changed, 89 insertions(+), 75 deletions(-)
 create mode 100644 hw/arm/aspeed_ast27x0_evb.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ce3610ce5a94..924c02bcb8c8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -33,14 +33,6 @@ static struct arm_boot_info aspeed_board_binfo = {
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
@@ -512,78 +504,11 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
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
-        .interfaces     = arm_machine_interfaces,
-#ifdef TARGET_AARCH64
-    }, {
-        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2700a0_evb_class_init,
-        .interfaces    = aarch64_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-        .interfaces    = aarch64_machine_interfaces,
-#endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
new file mode 100644
index 000000000000..0c4e9cd9cd8e
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -0,0 +1,88 @@
+/*
+ * ASPEED AST27x0 EVB
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
+        .interfaces    = aarch64_machine_interfaces,
+    }, {
+        .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+        .interfaces    = aarch64_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast27x0_evb_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index dc7cde4bc1bc..1467a2034c1b 100644
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
2.51.1


