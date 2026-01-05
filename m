Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0A5C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckA6-000523-0m; Mon, 05 Jan 2026 07:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8w-00048x-4K
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8u-00082c-AM
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKFLzSZUEZIFGnRslnS9T4ahjKX/cHwQ4f2c+hz45ZI=;
 b=HBiH+GVmNsQpTKbS3zEcCPnbMUFXuEd2CRoBdejPQF+Ray9wGf2cm3oxksjnCJS4D3DBb7
 YcoAnTtI0Xlqs6WMyeGuGdwktr9d/2uUk0huTDimJo9rtPQXwfVcTriVLjkCq/jYaPWNqL
 ViqU5WZuHWlyZmupmOO+LkHef06Ge2Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-tPCiZenUMh2p49jsuHB1fg-1; Mon,
 05 Jan 2026 07:57:00 -0500
X-MC-Unique: tPCiZenUMh2p49jsuHB1fg-1
X-Mimecast-MFC-AGG-ID: tPCiZenUMh2p49jsuHB1fg_1767617819
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D818195DE49; Mon,  5 Jan 2026 12:56:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F153519560A7; Mon,  5 Jan 2026 12:56:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/36] hw/arm/aspeed: catalina: add NIC FRU EEPROM
Date: Mon,  5 Jan 2026 13:55:58 +0100
Message-ID: <20260105125613.622667-22-clg@redhat.com>
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

Use ipmitool/frugen tool to generate a CX-7 NIC image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251217-catalina-eeproms-v1-10-dc7b276efd57@stwcx.xyz
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 42 ++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 2c9b4b6fff9a..5044441f38d7 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -381,6 +381,44 @@ static const uint8_t hmc_eeprom[] = {
 };
 static const size_t hmc_eeprom_len = sizeof(hmc_eeprom);
 
+/*
+ * CX-7 NIC FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Nvidia",
+ *            "pname": "Nvidia ConnectX-7 OCP3.0 (QEMU)",
+ *            "pn": "CX70000000-000_00",
+ *            "serial": "000000000000",
+ *            "date": "01/12/2025 00:00"
+ *        },
+ *        "product": {
+ *            "mfg": "Nvidia",
+ *            "pname": "Nvidia ConnectX-7 OCP3.0",
+ *            "pn": "CX71000000-000_01",
+ *            "ver": "A7",
+ *            "serial": "100000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t nic_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xdf, 0x4e, 0x76,
+    0x69, 0x64, 0x69, 0x61, 0x20, 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74,
+    0x58, 0x2d, 0x37, 0x20, 0x4f, 0x43, 0x50, 0x33, 0x2e, 0x30, 0x20, 0x28,
+    0x51, 0x45, 0x4d, 0x55, 0x29, 0x89, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x8d, 0x23, 0x7e, 0x41, 0x10, 0x04, 0x41, 0x10, 0xd4,
+    0x40, 0x10, 0xf4, 0x43, 0x10, 0xc0, 0xc1, 0xc3, 0x01, 0x09, 0x19, 0xc6,
+    0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd8, 0x4e, 0x76, 0x69, 0x64, 0x69,
+    0x61, 0x20, 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74, 0x58, 0x2d, 0x37,
+    0x20, 0x4f, 0x43, 0x50, 0x33, 0x2e, 0x30, 0x8d, 0x23, 0x7e, 0x45, 0x10,
+    0x04, 0x41, 0x10, 0xd4, 0x40, 0x10, 0xf4, 0x43, 0x11, 0x82, 0xe1, 0x05,
+    0x89, 0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x45, 0x83, 0x71,
+    0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0xf3
+};
+static const size_t nic_eeprom_len = sizeof(nic_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -514,7 +552,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* temperature-sensor@1f - tpm421 */
     i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[10], 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[10], 0x50, 8 * KiB, nic_eeprom, nic_eeprom_len);
 
     /* &i2c11 */
     /* ssif-bmc@10 - no model */
@@ -553,7 +591,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* temperature-sensor@1f - tmp421 */
     i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
     /* eeprom@52 */
-    at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[15], 0x52, 8 * KiB, nic_eeprom, nic_eeprom_len);
 }
 
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,
-- 
2.52.0


