Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0C2C79F87
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck99-0004Kk-H5; Mon, 05 Jan 2026 07:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8v-00048p-M4
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8t-00082Q-V8
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzoCsiyBMFmffYwLbsFar0Vy3vVAU8xpfAwo2wfzSTU=;
 b=NLHtYPLTBSkFGm0bYNm3zn3ikZphUw44fqZtoaCQw0tyiI2fwUx2VjBrioo/LcFZS/EiGC
 uggITdQj0E6MYFA2hlr3gpgNO7u3Euh0/2pKFHAFsXXz0f7TDnYQA+coE1fho4iQNMcKFZ
 ygL0IAppBDtv5mz0NV1nde3i1lMREhM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-itw1C5J-Pv-Z4lDYEnLjxA-1; Mon,
 05 Jan 2026 07:56:58 -0500
X-MC-Unique: itw1C5J-Pv-Z4lDYEnLjxA-1
X-Mimecast-MFC-AGG-ID: itw1C5J-Pv-Z4lDYEnLjxA_1767617817
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FFE018002C9; Mon,  5 Jan 2026 12:56:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D58A19560A7; Mon,  5 Jan 2026 12:56:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/36] hw/arm/aspeed: catalina: add HMC FRU EEPROM
Date: Mon,  5 Jan 2026 13:55:57 +0100
Message-ID: <20260105125613.622667-21-clg@redhat.com>
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

From: Patrick Williams <patrick@stwcx.xyz>

Use ipmitool/frugen tool to generate a HMC image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251217-catalina-eeproms-v1-9-dc7b276efd57@stwcx.xyz
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 42 +++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 37f0e1b65e48..2c9b4b6fff9a 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -341,6 +341,46 @@ static const uint8_t gb200io_eeprom[] = {
 };
 static const size_t gb200io_eeprom_len = sizeof(gb200io_eeprom);
 
+/*
+ * HMC ("HGX Management Controller") FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "NVIDIA",
+ *            "pname": "P4764-A02 (QEMU)",
+ *            "pn": "000-00000-0000-000",
+ *            "serial": "0000000000000",
+ *            "date": "01/12/2025 00:00",
+ *            "custom": ["Version: G", "Rework: R0"]
+ *        },
+ *        "product": {
+ *            "mfg": "NVIDIA",
+ *            "pname": "HMC for GB200 NVL72",
+ *            "pn": "100-00000-0000-001",
+ *            "ver": "A1",
+ *            "serial": "1000000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t hmc_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x8c,
+    0x19, 0xf0, 0x85, 0xae, 0x9d, 0x92, 0x69, 0x08, 0x8c, 0x30, 0x75, 0x59,
+    0x54, 0x13, 0x42, 0x12, 0x80, 0xc4, 0x65, 0x5b, 0x27, 0x8a, 0x10, 0x04,
+    0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x8e, 0x10, 0x04, 0x35,
+    0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x10, 0x04, 0xc0,
+    0xca, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x3a, 0x20, 0x47, 0xca,
+    0x52, 0x65, 0x77, 0x6f, 0x72, 0x6b, 0x3a, 0x20, 0x52, 0x30, 0xc1, 0x00,
+    0x00, 0x00, 0x00, 0x81, 0x01, 0x09, 0x19, 0x85, 0xae, 0x9d, 0x92, 0x69,
+    0x08, 0xd3, 0x48, 0x4d, 0x43, 0x20, 0x66, 0x6f, 0x72, 0x20, 0x47, 0x42,
+    0x32, 0x30, 0x30, 0x20, 0x4e, 0x56, 0x4c, 0x37, 0x32, 0x8e, 0x11, 0x04,
+    0x35, 0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x50, 0x04,
+    0x82, 0x61, 0x04, 0x8a, 0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04,
+    0x41, 0x11, 0x83, 0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x65
+};
+static const size_t hmc_eeprom_len = sizeof(hmc_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -493,7 +533,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@55 */
     at24c_eeprom_init(i2c[13], 0x55, 256);
     /* eeprom@57 */
-    at24c_eeprom_init(i2c[13], 0x57, 256);
+    at24c_eeprom_init_rom(i2c[13], 0x57, 256, hmc_eeprom, hmc_eeprom_len);
 
     /* &i2c14 */
     /* io_expander9 - pca9555@10 */
-- 
2.52.0


