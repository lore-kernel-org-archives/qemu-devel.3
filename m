Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD8DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCSS-0000Mt-Ss; Tue, 04 Nov 2025 03:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSP-0000IJ-SA
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSN-0003PU-8q
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5gKpXKo4AebYATK0mjDZy3wl18sIC13gJHb6iA3ZA8=;
 b=YCF2hPB4/eZZRgnCoeQi8hiUekhhH8bLe3cMvHNs93opjUwQx6OttkUCeEmpDDMTUe0VFh
 WdvuIegKTYkh+yKw8d5CC2uqIAcjonOgppvnHfVUEHXg5dW7TR/J5xyEH4pVejTRjamsZ+
 q9Wbw3GunwvBNNio4VxEf+Wd7qOg3BE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-vJsiK1lSOM-9bbpVILv3zw-1; Tue,
 04 Nov 2025 03:31:57 -0500
X-MC-Unique: vJsiK1lSOM-9bbpVILv3zw-1
X-Mimecast-MFC-AGG-ID: vJsiK1lSOM-9bbpVILv3zw_1762245116
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 160AA195609F; Tue,  4 Nov 2025 08:31:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 482F319560A2; Tue,  4 Nov 2025 08:31:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/30] hw/arm/aspeed: Export and rename create_pca9552() for
 reuse
Date: Tue,  4 Nov 2025 09:31:17 +0100
Message-ID: <20251104083144.187806-4-clg@redhat.com>
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

The helper function create_pca9552() has been renamed to
aspeed_create_pca9552() and made non-static for reuse by other Aspeed
machine source files. A corresponding prototype is now declared in
aspeed.h.

This allows multiple Aspeed platforms to share PCA9552 I2C LED controller
initialization logic, improving code reuse and reducing duplication.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 12 +++++++++++
 hw/arm/aspeed.c         | 44 ++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 712014497e90..9b765295d906 100644
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
index f23af5bf8c39..c6f272d9865d 100644
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
2.51.1


