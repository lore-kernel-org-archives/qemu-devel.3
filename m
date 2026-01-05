Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8541CC79F8D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck9s-0004tr-G6; Mon, 05 Jan 2026 07:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8x-000492-2R
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8u-00082o-Jw
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVZDGTnneiiEsr9/YzGC7XE1ut9z/hM7iMuXqfl4I90=;
 b=I4/fOM3B9vDZTmYWr38EcB0JqhpajlsRKur4KwoWATe7hzIhxiTHx9lX1TuMcESYri34S0
 9ixXbq65Ji5gStDBMbwmIoRQ91SQFPXaJyMDUpZYD6nIqta9Fq2KWHn639t8dRoierHEvf
 8kemV/xZ0wx3M2oDPgfwRSDCHdrCus8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-m-yMS8V2MpusPzSiGNfIHg-1; Mon,
 05 Jan 2026 07:57:02 -0500
X-MC-Unique: m-yMS8V2MpusPzSiGNfIHg-1
X-Mimecast-MFC-AGG-ID: m-yMS8V2MpusPzSiGNfIHg_1767617821
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C84618002C1; Mon,  5 Jan 2026 12:57:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE43F19560A7; Mon,  5 Jan 2026 12:56:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/36] hw/arm/aspeed: catalina: add Cable Cartridge FRU EEPROM
Date: Mon,  5 Jan 2026 13:55:59 +0100
Message-ID: <20260105125613.622667-23-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
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

Use ipmitool/frugen tool to generate a Cable Cart image based on a
sanitized set of data from a real device EEPROM.  The EEPROM
bus/address did not match device tree for one of the EEPROMs so move
it from bus 13 / 55 to bus 12 / 54.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251217-catalina-eeproms-v1-11-dc7b276efd57@stwcx.xyz
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 46 +++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 5044441f38d7..4edb30bb16b8 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -419,6 +419,44 @@ static const uint8_t nic_eeprom[] = {
 };
 static const size_t nic_eeprom_len = sizeof(nic_eeprom);
 
+/*
+ * Cable Cartridge FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Nvidia",
+ *            "pname": "18x1RU CBL Cartridge (QEMU)",
+ *            "pn": "000-0000-000",
+ *            "serial": "0000000000000",
+ *            "date": "01/12/2025 00:00"
+ *        },
+ *        "product": {
+ *            "mfg": "Nvidia",
+ *            "pname": "18x1RU CBL Cartridge",
+ *            "pn": "100-00000-0000-001",
+ *            "ver": "E.4",
+ *            "serial": "1000000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t cable_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xdb, 0x31, 0x38,
+    0x78, 0x31, 0x52, 0x55, 0x20, 0x43, 0x42, 0x4c, 0x20, 0x43, 0x61, 0x72,
+    0x74, 0x72, 0x69, 0x64, 0x67, 0x65, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55,
+    0x29, 0x8a, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10,
+    0x89, 0x10, 0x04, 0x35, 0x10, 0x04, 0x41, 0x0d, 0x04, 0x41, 0xc0, 0xc1,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xb1, 0x01, 0x09, 0x19, 0xc6,
+    0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd4, 0x31, 0x38, 0x78, 0x31, 0x52,
+    0x55, 0x20, 0x43, 0x42, 0x4c, 0x20, 0x43, 0x61, 0x72, 0x74, 0x72, 0x69,
+    0x64, 0x67, 0x65, 0x8e, 0x11, 0x04, 0x35, 0x10, 0x04, 0x41, 0x50, 0x03,
+    0x41, 0x10, 0xd4, 0x40, 0x50, 0x04, 0x83, 0xa5, 0x43, 0x01, 0x8a, 0x11,
+    0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x11, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x25
+};
+static const size_t cable_eeprom_len = sizeof(cable_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -561,15 +599,17 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[12], 0x50, 8 * KiB,
                           gb200_eeprom, gb200_eeprom_len);
+    /* eeprom@54 */
+    at24c_eeprom_init_rom(i2c[12], 0x54, 256,
+                          cable_eeprom, cable_eeprom_len);
 
     /* &i2c13 */
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[13], 0x50, 8 * KiB,
                           gb200_eeprom, gb200_eeprom_len);
     /* eeprom@54 */
-    at24c_eeprom_init(i2c[13], 0x54, 256);
-    /* eeprom@55 */
-    at24c_eeprom_init(i2c[13], 0x55, 256);
+    at24c_eeprom_init_rom(i2c[13], 0x54, 256,
+                          cable_eeprom, cable_eeprom_len);
     /* eeprom@57 */
     at24c_eeprom_init_rom(i2c[13], 0x57, 256, hmc_eeprom, hmc_eeprom_len);
 
-- 
2.52.0


