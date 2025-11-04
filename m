Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BBACCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCV6-00069t-QG; Tue, 04 Nov 2025 03:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTR-0001xu-81
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTO-0003gv-P0
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+yIP2Ba52TmbuEjWXpaA51f2q5DauqLfThYtNV/Eis=;
 b=XuAY60JqCG5Yv/t8+f/hlWVGOmQk26ddN/+jOwSsl5BpgyckmdytXQOw6gHaxkCOIjbVwB
 9GUnXXLP7RaMcUyKOmd3umUuDUQY9+MOysLrnEgcmDjV2bhi6CR4zQMEIrJxAxBXUpcofF
 k8a8QgM/ungGgWlRLvPynruy/uIWnXE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-EMeC8LXUMxOaEaarLZA2fw-1; Tue,
 04 Nov 2025 03:32:58 -0500
X-MC-Unique: EMeC8LXUMxOaEaarLZA2fw-1
X-Mimecast-MFC-AGG-ID: EMeC8LXUMxOaEaarLZA2fw_1762245177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57B461956063; Tue,  4 Nov 2025 08:32:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97D3619560A2; Tue,  4 Nov 2025 08:32:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/30] hw/arm/aspeed: Split AST1030 EVB machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:44 +0100
Message-ID: <20251104083144.187806-31-clg@redhat.com>
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
References: <20251104083144.187806-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-31-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c             |  89 -----------------------------
 hw/arm/aspeed_ast10x0_evb.c | 108 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   1 +
 3 files changed, 109 insertions(+), 89 deletions(-)
 create mode 100644 hw/arm/aspeed_ast10x0_evb.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 7e9cd532d136..3a5071a38413 100644
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
index 000000000000..7af2a77865e4
--- /dev/null
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -0,0 +1,108 @@
+/*
+ * ASPEED AST10x0 EVB
+ *
+ * Copyright 2016 IBM Corp.
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
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 1467a2034c1b..aeaf654790c2 100644
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
2.51.1


