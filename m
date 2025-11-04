Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55320CCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 03:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG7Uz-0002Y9-1t; Mon, 03 Nov 2025 22:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7UP-0002SY-NO; Mon, 03 Nov 2025 22:13:46 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7UN-00031V-Qx; Mon, 03 Nov 2025 22:13:45 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 11:13:27 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 11:13:27 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v4 03/30] hw/arm/aspeed: Export and rename create_pca9552()
 for reuse
Date: Tue, 4 Nov 2025 11:12:41 +0800
Message-ID: <20251104031325.146374-4-jamin_lin@aspeedtech.com>
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

The helper function create_pca9552() has been renamed to
aspeed_create_pca9552() and made non-static for reuse by other Aspeed
machine source files. A corresponding prototype is now declared in
aspeed.h.

This allows multiple Aspeed platforms to share PCA9552 I2C LED controller
initialization logic, improving code reuse and reducing duplication.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 12 +++++++++++
 hw/arm/aspeed.c         | 44 ++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 712014497e..9b765295d9 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -68,4 +68,16 @@ struct AspeedMachineClass {
  */
 void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
 
+/*
+ * aspeed_create_pca9552:
+ * @soc: pointer to the #AspeedSoCState.
+ * @bus_id: the I2C bus index to attach the device.
+ * @addr: the I2C address of the PCA9552 device.
+ *
+ * Create and attach a PCA9552 LED controller device to the specified I2C bus
+ * of the given Aspeed SoC. The device is instantiated using
+ * i2c_slave_create_simple() with the PCA9552 device type.
+ */
+void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f23af5bf8c..c6f272d986 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -537,7 +537,7 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
 }
 
-static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
+void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
 {
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
                             TYPE_PCA9552, addr);
@@ -565,9 +565,9 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
                           eeprom4_54);
     /* PCA9539 @ 0x76, but PCA9552 is compatible */
-    create_pca9552(soc, 4, 0x76);
+    aspeed_create_pca9552(soc, 4, 0x76);
     /* PCA9539 @ 0x77, but PCA9552 is compatible */
-    create_pca9552(soc, 4, 0x77);
+    aspeed_create_pca9552(soc, 4, 0x77);
 
     /* bus 6 : */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
@@ -578,8 +578,8 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
     uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
                           eeprom8_56);
-    create_pca9552(soc, 8, 0x60);
-    create_pca9552(soc, 8, 0x61);
+    aspeed_create_pca9552(soc, 8, 0x60);
+    aspeed_create_pca9552(soc, 8, 0x61);
     /* bus 8 : adc128d818 @ 0x1d */
     /* bus 8 : adc128d818 @ 0x1f */
 
@@ -710,7 +710,7 @@ static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
 
     /* It expects a pca9555 but a pca9552 is compatible */
-    create_pca9552(soc, 8, 0x30);
+    aspeed_create_pca9552(soc, 8, 0x30);
 }
 
 static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
@@ -720,7 +720,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
 
-    create_pca9552(soc, 3, 0x61);
+    aspeed_create_pca9552(soc, 3, 0x61);
 
     /* The rainier expects a TMP275 but a TMP105 is compatible */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
@@ -734,14 +734,14 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
-    create_pca9552(soc, 4, 0x60);
+    aspeed_create_pca9552(soc, 4, 0x60);
 
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
                      0x48);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
                      0x49);
-    create_pca9552(soc, 5, 0x60);
-    create_pca9552(soc, 5, 0x61);
+    aspeed_create_pca9552(soc, 5, 0x60);
+    aspeed_create_pca9552(soc, 5, 0x61);
     i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
@@ -760,12 +760,12 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 3), 0x51, 64 * KiB);
 
-    create_pca9552(soc, 7, 0x30);
-    create_pca9552(soc, 7, 0x31);
-    create_pca9552(soc, 7, 0x32);
-    create_pca9552(soc, 7, 0x33);
-    create_pca9552(soc, 7, 0x60);
-    create_pca9552(soc, 7, 0x61);
+    aspeed_create_pca9552(soc, 7, 0x30);
+    aspeed_create_pca9552(soc, 7, 0x31);
+    aspeed_create_pca9552(soc, 7, 0x32);
+    aspeed_create_pca9552(soc, 7, 0x33);
+    aspeed_create_pca9552(soc, 7, 0x60);
+    aspeed_create_pca9552(soc, 7, 0x61);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
     /* Bus 7: TODO si7021-a20@20 */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
@@ -782,8 +782,8 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
                           64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
                           64 * KiB, rainier_bmc_fruid, rainier_bmc_fruid_len);
-    create_pca9552(soc, 8, 0x60);
-    create_pca9552(soc, 8, 0x61);
+    aspeed_create_pca9552(soc, 8, 0x60);
+    aspeed_create_pca9552(soc, 8, 0x61);
     /* Bus 8: ucd90320@11 */
     /* Bus 8: ucd90320@b */
     /* Bus 8: ucd90320@c */
@@ -804,17 +804,17 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-    create_pca9552(soc, 11, 0x60);
+    aspeed_create_pca9552(soc, 11, 0x60);
 
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 13), 0x50, 64 * KiB);
-    create_pca9552(soc, 13, 0x60);
+    aspeed_create_pca9552(soc, 13, 0x60);
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 14), 0x50, 64 * KiB);
-    create_pca9552(soc, 14, 0x60);
+    aspeed_create_pca9552(soc, 14, 0x60);
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 15), 0x50, 64 * KiB);
-    create_pca9552(soc, 15, 0x60);
+    aspeed_create_pca9552(soc, 15, 0x60);
 }
 
 static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
-- 
2.43.0


