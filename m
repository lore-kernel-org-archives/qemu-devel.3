Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B18DC79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8v-00048E-1Y; Mon, 05 Jan 2026 07:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8g-0003sq-9g
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8e-0007z1-BY
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VkRyG+nuOL2if1Rh7rIC8AA3xkyAH90XSBBfJpYnefc=;
 b=KbJjfUUQofRnWkyqe1oR3u8Ch5qHZvGuB4rtk09ZekGpRyN6c6DqTOtnSMqRVPM9vALSxv
 0ot5aVOempLouxW/OWeP9G7CownmLxJegivyDE3u4XRTnNM4Sc6p/knNdYAR27XOoNe1Vj
 Z/2cuL1YnnRh7byhYN+rZxzn9XxYj9I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-f5nJHjXmOLaC4YJzEY5owA-1; Mon,
 05 Jan 2026 07:56:46 -0500
X-MC-Unique: f5nJHjXmOLaC4YJzEY5owA-1
X-Mimecast-MFC-AGG-ID: f5nJHjXmOLaC4YJzEY5owA_1767617805
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78DDD180028B; Mon,  5 Jan 2026 12:56:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 066EF19560A7; Mon,  5 Jan 2026 12:56:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/36] hw/arm/aspeed: catalina: add PDB FRU EEPROM
Date: Mon,  5 Jan 2026 13:55:51 +0100
Message-ID: <20260105125613.622667-15-clg@redhat.com>
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

Use ipmitool/frugen tool to generate a PDB image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251217-catalina-eeproms-v1-3-dc7b276efd57@stwcx.xyz
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 51 +++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 6e8f4d39d97e..2ba2c5c08850 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -103,6 +103,54 @@ static const uint8_t scm_eeprom[] = {
 };
 static const size_t scm_eeprom_len = sizeof(scm_eeprom);
 
+/*
+ * "Power Distribution Board" FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Quanta",
+ *            "pname": "Catalina PDB MP (QEMU)",
+ *            "pn": "00000000000",
+ *            "serial": "00000000000000",
+ *            "date": "01/12/2025 00:00",
+ *            "custom": [
+ *                "19-100579",
+ *                "",
+ *                "",
+ *                "hsc-ltc fsc-max vr-delta gndsen-ina p12vsen-ina p12vfan-mps"
+ *            ]
+ *        },
+ *        "product": {
+ *            "mfg": "Quanta",
+ *            "pname": "CI-Catalina",
+ *            "pn": "10000000001",
+ *            "ver": "MP",
+ *            "serial": "10000000000000",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t pdb_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x12, 0x00, 0x00, 0xec, 0x01, 0x11, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xd6, 0x43, 0x61,
+    0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x20, 0x50, 0x44, 0x42, 0x20, 0x4d,
+    0x50, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55, 0x29, 0x8b, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x89, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x01, 0xc0, 0x87, 0x51, 0xd6, 0x44, 0x10,
+    0x54, 0x5d, 0x19, 0xc0, 0xc0, 0xfb, 0x68, 0x73, 0x63, 0x2d, 0x6c, 0x74,
+    0x63, 0x20, 0x66, 0x73, 0x63, 0x2d, 0x6d, 0x61, 0x78, 0x20, 0x76, 0x72,
+    0x2d, 0x64, 0x65, 0x6c, 0x74, 0x61, 0x20, 0x67, 0x6e, 0x64, 0x73, 0x65,
+    0x6e, 0x2d, 0x69, 0x6e, 0x61, 0x20, 0x70, 0x31, 0x32, 0x76, 0x73, 0x65,
+    0x6e, 0x2d, 0x69, 0x6e, 0x61, 0x20, 0x70, 0x31, 0x32, 0x76, 0x66, 0x61,
+    0x6e, 0x2d, 0x6d, 0x70, 0x73, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24,
+    0x01, 0x07, 0x19, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xcb, 0x43,
+    0x49, 0x2d, 0x43, 0x61, 0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x89, 0x11,
+    0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x14, 0x01, 0x82, 0x2d, 0x0c, 0x8b,
+    0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x83,
+    0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x37
+};
+static const size_t pdb_eeprom_len = sizeof(pdb_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -166,7 +214,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c1mux0ch5 */
     /* eeprom@54 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB,
+                          pdb_eeprom, pdb_eeprom_len);
     /* tpm75@4f */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
 
-- 
2.52.0


