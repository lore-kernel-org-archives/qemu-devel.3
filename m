Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2F8C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOW-0004Vp-0m; Tue, 11 Aug 2026 12:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOM-0004Ov-UJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOK-0000v6-33
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgH6ERZczx4UxGVPBPz89mnVaYqeZ2Y6omJz4Q7M7lY=;
 b=ibdcQ4vuSEh/XBhTnQCiToQX5uBaPNuzh1VIn82jYiZRDXWCbA0aRYofzzPfHfJDYXgjkV
 BRvwSKxE2AjiHqDE3VMt7PlI73gc1/Sv2EqQvt7tJ91BWqYFx4xbwG0mWf3e4c5k9zUe52
 C2rsUvHIa8UioWpCQZ/N7cyHoNjQZYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-S7rYabjnPjOvXyX6OCMJYQ-1; Tue,
 11 Aug 2026 12:31:49 -0400
X-MC-Unique: S7rYabjnPjOvXyX6OCMJYQ-1
X-Mimecast-MFC-AGG-ID: S7rYabjnPjOvXyX6OCMJYQ_1786465908
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B5D21800868; Tue, 11 Aug 2026 16:31:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D964195DF96; Tue, 11 Aug 2026 16:31:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 58/83] hw/arm: catalina: add NIC and FIO temperature sensors
Date: Tue, 11 Aug 2026 18:29:13 +0200
Message-ID: <20260811162938.1403216-59-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Model the temperature sensors described by the Catalina device tree that
have existing QEMU device models but were not yet instantiated: the four
IOB NIC TMP421 sensors behind the i2c0 PCA9546 muxes at 0x71 and 0x75, and
the FIO remote TMP75 sensor at 0x4f on the i2c1 mux.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-25-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f3b22e9aa9a0..f714c9d1b32b 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -472,7 +472,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c0 */
     /* i2c-mux@71 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
+
+    /* i2c0mux0ch0 */
+    /* IOB0 NIC0 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+                            TYPE_TMP421, 0x1f);
+    /* i2c0mux0ch2 */
+    /* IOB0 NIC1 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
+                            TYPE_TMP421, 0x1f);
 
     /* i2c-mux@72 (PCA9546) on i2c0 */
     i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
@@ -489,7 +498,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
 
     /* i2c-mux@75 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
+
+    /* i2c0mux3ch0 */
+    /* IOB1 NIC0 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+                            TYPE_TMP421, 0x1f);
+    /* i2c0mux3ch2 */
+    /* IOB1 NIC1 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
+                            TYPE_TMP421, 0x1f);
 
     /* i2c-mux@76 (PCA9546) on i2c0 */
     i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
@@ -544,6 +562,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
                           fio_eeprom, fio_eeprom_len);
     /* temperature-sensor@4b - tmp75 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
+    /* temperature-sensor@4f - tmp75 (FIO remote) */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4f);
 
     /* &i2c2 */
     /* io_expander0 - pca9555@20 */
@@ -564,11 +584,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
                           hdd_eeprom, hdd_eeprom_len);
-    /* i2c5mux0ch7 */
-    /* ina230@40 - no model */
-    /* ina230@41 - no model */
-    /* ina230@44 - no model */
-    /* ina230@45 - no model */
+    /* i2c5mux0ch7 - empty */
 
     /* &i2c6 */
     /* io_expander3 - pca9555@21 */
-- 
2.55.0


