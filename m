Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E959CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCST-0000O1-FZ; Tue, 04 Nov 2025 03:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSR-0000Ks-R6
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSP-0003Q5-Ng
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81BgKlRJTVoj7USuocovf/NBDfJv5OHsbVzpCIGcWLY=;
 b=d+SWV+mPE97EckMVO5Auc48BL8VyKYiqbSXqTLTBz0tUag/HZgTemGvsx9iGaV4/3jy1ip
 Z6SCHfNTpf3KCftRgZpfpye5sGPC8eksHoZR4jS5M4VHow/8kwvvP0Yit5GIrAf8JpUXjk
 g6+FbFy+vo035EKbgbRPDOWJdq0OP4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-45iNF-SZNemJNfVk_i-JDw-1; Tue,
 04 Nov 2025 03:31:59 -0500
X-MC-Unique: 45iNF-SZNemJNfVk_i-JDw-1
X-Mimecast-MFC-AGG-ID: 45iNF-SZNemJNfVk_i-JDw_1762245118
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41D1D18001D1; Tue,  4 Nov 2025 08:31:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9517919560BC; Tue,  4 Nov 2025 08:31:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/30] hw/arm/aspeed: Rename and export create_pca9554() as
 aspeed_create_pca9554()
Date: Tue,  4 Nov 2025 09:31:18 +0100
Message-ID: <20251104083144.187806-5-clg@redhat.com>
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

The helper function create_pca9554() has been renamed to
aspeed_create_pca9554() and made globally available.

Previously, the function was declared static inside aspeed.c, restricting
its visibility to that file. As more Aspeed machine implementations
require PCA9554 I2C expander setup, it makes sense to rename it with the
aspeed_ prefix and export its declaration in aspeed.h for shared use.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 14 ++++++++++++++
 hw/arm/aspeed.c         |  8 ++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 9b765295d906..16b24e68870a 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -80,4 +80,18 @@ void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
  */
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
 
+/*
+ * aspeed_create_pca9554:
+ * @soc: pointer to the #AspeedSoCState.
+ * @bus_id: the I2C bus index to attach the device.
+ * @addr: the I2C address of the PCA9554 device.
+ *
+ * Create and attach a PCA9554 I/O expander to the specified I2C bus
+ * of the given Aspeed SoC. The device is created via
+ * i2c_slave_create_simple() and returned as an #I2CSlave pointer.
+ *
+ * Returns: a pointer to the newly created #I2CSlave instance.
+ */
+I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr);
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c6f272d9865d..59416eb5ae6c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -543,7 +543,7 @@ void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
                             TYPE_PCA9552, addr);
 }
 
-static I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
+I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
 {
     return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
                             TYPE_PCA9554, addr);
@@ -1142,7 +1142,7 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
     }
 
     /* Bus 5 Expander */
-    create_pca9554(soc, 4, 0x21);
+    aspeed_create_pca9554(soc, 4, 0x21);
 
     /* Mux I2c Expanders */
     i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
@@ -1153,12 +1153,12 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
 
     /* Bus 10 */
-    dev = DEVICE(create_pca9554(soc, 9, 0x20));
+    dev = DEVICE(aspeed_create_pca9554(soc, 9, 0x20));
 
     /* Set FPGA_READY */
     object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
 
-    create_pca9554(soc, 9, 0x21);
+    aspeed_create_pca9554(soc, 9, 0x21);
     at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
     at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
 
-- 
2.51.1


