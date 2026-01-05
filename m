Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28871C79F95
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck98-0004Jf-BH; Mon, 05 Jan 2026 07:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8r-000435-DC
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8o-00081H-IX
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POHV0+sltmYevysbodtEg4zKU7FV0FfzvTJN2VPCqVI=;
 b=HRMWYLe7aqgBD75PElivt+AWl/a8PIfCP3q//cFOd1z5Whc2Ill7qiBW04pODNflLaCVuq
 tDCXPI3sBG+X43q/xCY2X3KiIJYCE3MriT6kIACdPdNVPoGwe6fTp5pD5w0kLbMxTGSkrL
 324lq9O9iFM/yZj5qDKECfQl+KAg+KE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-0X9lNW4hP_Cc0-NzD8x9tQ-1; Mon,
 05 Jan 2026 07:56:56 -0500
X-MC-Unique: 0X9lNW4hP_Cc0-NzD8x9tQ-1
X-Mimecast-MFC-AGG-ID: 0X9lNW4hP_Cc0-NzD8x9tQ_1767617815
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90118180035A; Mon,  5 Jan 2026 12:56:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7AC91953984; Mon,  5 Jan 2026 12:56:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/36] hw/arm/aspeed: catalina: add GB200-IO FRU EEPROM
Date: Mon,  5 Jan 2026 13:55:56 +0100
Message-ID: <20260105125613.622667-20-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Patrick Williams <patrick@stwcx.xyz>

Use ipmitool/frugen tool to generate a GB200-IO image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251217-catalina-eeproms-v1-8-dc7b276efd57@stwcx.xyz
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 43 ++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 4dd72c615dc7..37f0e1b65e48 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -304,6 +304,43 @@ static const uint8_t gb200_eeprom[] = {
 };
 static const size_t gb200_eeprom_len = sizeof(gb200_eeprom);
 
+/*
+ * GB200 IO Board FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Nvidia",
+ *            "pname": "2x ConnectX-7 Mezz (QEMU)",
+ *            "pn": "000-00000-0000-000",
+ *            "serial": "000000000000",
+ *            "date": "01/12/2025 00:00"
+ *        },
+ *        "product": {
+ *            "mfg": "Nvidia",
+ *            "pname": "2x ConnectX-7 Mezz",
+ *            "pn": "100-00000-0000-001",
+ *            "ver": "A1",
+ *            "serial": "100000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t gb200io_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd9, 0x32, 0x78,
+    0x20, 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74, 0x58, 0x2d, 0x37, 0x20,
+    0x4d, 0x65, 0x7a, 0x7a, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55, 0x29, 0x89,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x8e, 0x10, 0x04,
+    0x35, 0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x10, 0x04,
+    0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x8e, 0x01, 0x08, 0x19, 0xc6,
+    0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd2, 0x32, 0x78, 0x20, 0x43, 0x6f,
+    0x6e, 0x6e, 0x65, 0x63, 0x74, 0x58, 0x2d, 0x37, 0x20, 0x4d, 0x65, 0x7a,
+    0x7a, 0x8e, 0x11, 0x04, 0x35, 0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10,
+    0xd4, 0x40, 0x50, 0x04, 0x82, 0x61, 0x04, 0x89, 0x11, 0x04, 0x41, 0x10,
+    0x04, 0x41, 0x10, 0x04, 0x45, 0x83, 0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x04
+};
+static const size_t gb200io_eeprom_len = sizeof(gb200io_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -329,7 +366,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x20);
     /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
+                          gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@73 (PCA9546) on i2c0 */
     i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
@@ -345,7 +383,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x21);
     /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
+                          gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@77 (PCA9546) on i2c0 */
     i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);
-- 
2.52.0


