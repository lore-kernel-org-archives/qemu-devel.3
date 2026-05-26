Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9D4CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0H-0005Dd-Q7; Tue, 26 May 2026 04:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0G-0005Cu-8H
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0D-0007Xu-JX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrnseKuv3x4/lbCdy5/Oq2+oy5HacRijNtMBdoT6X7E=;
 b=ccCNgc/8uQxoAiLox3+gybcbebqGkWmE5Q7Lb99N7EsYU0eyl85nC7ZGRoRA+rn+QlMWaS
 /jZ0f97kUTGe97o7KQ78zW6Tt5q3oxpqW/lufWpXZ6SSm+ZnBDAebu2hm3/Ok3LlEOagpa
 JWoSSxZcIQxalnPhxQJ5LNcFzW4/sAc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-w6RaSJohOEeZpyeJWMdP2Q-1; Tue,
 26 May 2026 04:19:02 -0400
X-MC-Unique: w6RaSJohOEeZpyeJWMdP2Q-1
X-Mimecast-MFC-AGG-ID: w6RaSJohOEeZpyeJWMdP2Q_1779783541
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4687F195608E; Tue, 26 May 2026 08:19:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C33641800577; Tue, 26 May 2026 08:18:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: William de Abreu Pinho <williamdapinho@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/37] hw/arm/aspeed: add anacapa-bmc machine
Date: Tue, 26 May 2026 10:18:15 +0200
Message-ID: <20260526081848.651835-5-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: William de Abreu Pinho <williamdapinho@gmail.com>

Add the Facebook Anacapa BMC machine.  The I2C topology is based on the
Linux kernel device tree [1].  Hardware strap register values are taken
from real hardware.

A functional test is included using the OpenBMC image built from [2],
similar to the tests for bletchley-bmc and catalina-bmc.

[1]: https://github.com/torvalds/linux/blob/76b4ec8efdc3887cdbf730da2e55881fc1a18770/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
[2]: https://github.com/openbmc/openbmc/commit/8e22df918eaaa5d83143471d24ef0eeb1c1e3c7c

Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260519-add-anacapa-machine-v3-2-56c23993a20a@gmail.com
[ clg: docs/system/arm/aspeed.rst : fixed 'Aspeed family boards' title change ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst                  |   5 +-
 hw/arm/aspeed_ast2600_anacapa.c             | 153 ++++++++++++++++++++
 hw/arm/meson.build                          |   1 +
 tests/functional/arm/meson.build            |   2 +
 tests/functional/arm/test_aspeed_anacapa.py |  25 ++++
 5 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_anacapa.c
 create mode 100644 tests/functional/arm/test_aspeed_anacapa.py

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index df2f539b0257..a2eccf54892d 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-==============================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``anacapa-bmc``, ``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+===============================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -33,6 +33,7 @@ AST2600 SoC based machines :
 - ``fuji-bmc``             Facebook Fuji BMC
 - ``bletchley-bmc``        Facebook Bletchley BMC
 - ``fby35-bmc``            Facebook fby35 BMC
+- ``anacapa-bmc``          Facebook Anacapa BMC
 - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
 
 Supported devices
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
new file mode 100644
index 000000000000..c24f00d44cde
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -0,0 +1,153 @@
+/*
+ * Facebook Anacapa
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
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
+#include "hw/gpio/pca9552.h"
+#include "hw/nvram/eeprom_at24c.h"
+
+/* Anacapa hardware value */
+#define ANACAPA_BMC_HW_STRAP1 0x00002002
+#define ANACAPA_BMC_HW_STRAP2 0x00000000
+#define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    /* Reference: aspeed-bmc-facebook-anacapa.dts */
+
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16] = {};
+    I2CSlave *i2c_mux;
+
+    for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* &i2c0 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[0], 0x50, 256 * KiB);
+    /* i2c-mux@70 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x70);
+
+    /* &i2c1 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[1], 0x50, 256 * KiB);
+    /* i2c-mux@70 (PCA9546) — 4 channels, empty */
+    i2c_slave_create_simple(i2c[1], TYPE_PCA9546, 0x70);
+
+    /* &i2c4 */
+    /* i2c-mux@70 (PCA9548) */
+    i2c_slave_create_simple(i2c[4], TYPE_PCA9548, 0x70);
+
+    /* &i2c6 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[6], 0x50, 32 * KiB);
+
+    /* &i2c8 */
+    /* i2c-mux@72 (PCA9546) */
+    i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
+
+    /* i2c8mux ch0 */
+    /* adc128d818@1f — no model */
+    /* pca9555@22 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+                            TYPE_PCA9552, 0x22);
+    /* pca9555@24 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+                            TYPE_PCA9552, 0x24);
+    /* eeprom@50 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB);
+
+    /* i2c8mux ch1 */
+    /* pca9555@22 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+                            TYPE_PCA9552, 0x22);
+    /* pca9555@24 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+                            TYPE_PCA9552, 0x24);
+    /* eeprom@50 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB);
+
+    /* &i2c9 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[9], 0x50, 16 * KiB);
+    /* eeprom@56 */
+    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
+
+    /* &i2c10 */
+    /* i2c-mux@71 (PCA9548) */
+    i2c_mux = i2c_slave_create_simple(i2c[10], TYPE_PCA9548, 0x71);
+
+    /* i2c10mux ch5 */
+    /* pca9555@22*/
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
+                            TYPE_PCA9552, 0x22);
+    /* eeprom@52 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
+
+    /* &i2c11 */
+    /* i2c-mux@71 (PCA9548) */
+    i2c_mux = i2c_slave_create_simple(i2c[11], TYPE_PCA9548, 0x71);
+
+    /* i2c11mux ch0-ch4 — empty */
+
+    /* i2c11mux ch5 */
+    /* pca9555@22 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
+                            TYPE_PCA9552, 0x22);
+    /* eeprom@52 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
+
+    /* &i2c13 */
+    /* i2c-mux@70 (PCA9548) */
+    i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
+
+    /* i2c13mux ch3 */
+    /* adc128d818@1f - no model */
+
+    /* i2c13mux ch4 */
+    /* eeprom@51 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB);
+
+    /* i2c13mux ch7 */
+    /* nfc@28 — no model */
+}
+
+static void aspeed_machine_anacapa_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook Anacapa BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = ANACAPA_BMC_HW_STRAP1;
+    amc->hw_strap2 = ANACAPA_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = NULL;
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC2_ON;
+    amc->i2c_init  = anacapa_bmc_i2c_init;
+    mc->default_ram_size = ANACAPA_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_anacapa_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_anacapa_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_anacapa_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 80068f70bb9c..4fe7efd189e2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -54,6 +54,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_witherspoon.c',
   'aspeed_ast2500_yosemitev2.c',
   'aspeed_ast2600.c',
+  'aspeed_ast2600_anacapa.c',
   'aspeed_ast2600_bletchley.c',
   'aspeed_ast2600_catalina.c',
   'aspeed_ast2600_evb.c',
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 2f538f29a2de..959179a56f6d 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -12,6 +12,7 @@ test_arm_timeouts = {
   'aspeed_ast2600_sdk' : 720,
   'aspeed_ast2600_sdk_515' : 720,
   'aspeed_ast2600_sdk_otp' : 720,
+  'aspeed_anacapa' : 480,
   'aspeed_bletchley' : 480,
   'aspeed_catalina' : 480,
   'aspeed_gb200nvl_bmc' : 480,
@@ -45,6 +46,7 @@ tests_arm_system_thorough = [
   'aspeed_ast2600_sdk',
   'aspeed_ast2600_sdk_515',
   'aspeed_ast2600_sdk_otp',
+  'aspeed_anacapa',
   'aspeed_bletchley',
   'aspeed_catalina',
   'aspeed_gb200nvl_bmc',
diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
new file mode 100644
index 000000000000..27f8bd8b56a8
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -0,0 +1,25 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import FacebookAspeedTest
+
+
+class AnacapaMachine(FacebookAspeedTest):
+
+    ASSET_ANACAPA_FLASH = Asset(
+        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
+        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
+
+    def test_arm_ast2600_anacapa_openbmc(self):
+        image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
+
+        self.do_test_arm_aspeed_openbmc('anacapa-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3')
+
+if __name__ == '__main__':
+    FacebookAspeedTest.main()
-- 
2.54.0


