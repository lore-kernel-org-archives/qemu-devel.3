Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05974C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOQ-0004SS-Hh; Tue, 11 Aug 2026 12:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOL-0004KI-Js
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOJ-0000uy-T4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sunI39eslSg7P37aKo3+ffroIIqzgtxUAS0ps9rYLBw=;
 b=GcHUvLVqxShHosOzVffMkhzHVse7qjmXsMnXc6P6k8FMdpF6zfOA4b6s0/sTLVdd9nW+Ai
 lFkEWibUz67lZ+u9mkFIG8JF8DqjLuC3HoaAHMdpIMyLOCXzFL0zCPoMVRitKiKm5k0GGi
 pxd9AY9ruo1XLzAdi9q2ymbAKmBR+8k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-NugpU0OgN0yizT_fh9zV1w-1; Tue,
 11 Aug 2026 12:31:47 -0400
X-MC-Unique: NugpU0OgN0yizT_fh9zV1w-1
X-Mimecast-MFC-AGG-ID: NugpU0OgN0yizT_fh9zV1w_1786465906
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A13AE18009C7; Tue, 11 Aug 2026 16:31:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33B6C195DF91; Tue, 11 Aug 2026 16:31:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 57/83] hw/arm: catalina: model PCA9555 IO expanders with their
 own type
Date: Tue, 11 Aug 2026 18:29:12 +0200
Message-ID: <20260811162938.1403216-58-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Catalina BMC device tree describes several IO expanders as nxp,pca9555.
These were previously instantiated as PCA9552 devices as no PCA9555 model
existed. Now that a dedicated PCA9555 device is available, use it so the
emulated IO expanders match the hardware.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-24-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 65495a524ea5..f3b22e9aa9a0 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -533,7 +533,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
                             TYPE_PCA9554, 0x27);
     /* io_expander6 - pca9555@25 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
-                            TYPE_PCA9552, 0x25);
+                            TYPE_PCA9555, 0x25);
     /* eeprom@51 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
                           osfp_eeprom, osfp_eeprom_len);
@@ -547,11 +547,11 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c2 */
     /* io_expander0 - pca9555@20 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x20);
     /* io_expander0 - pca9555@21 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x21);
     /* io_expander0 - pca9555@27 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x27);
     /* eeprom@50 */
     at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
     /* eeprom@51 */
@@ -572,13 +572,13 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c6 */
     /* io_expander3 - pca9555@21 */
-    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9555, 0x21);
     /* rtc@6f - nct3018y */
     i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
 
     /* &i2c9 */
     /* io_expander4 - pca9555@4f */
-    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
+    i2c_slave_create_simple(i2c[9], TYPE_PCA9555, 0x4f);
     /* temperature-sensor@4b - tpm75 */
     i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
     /* eeprom@50 */
@@ -615,17 +615,17 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c14 */
     /* io_expander9 - pca9555@10 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x10);
     /* io_expander10 - pca9555@11 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x11);
     /* io_expander11 - pca9555@12 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x12);
     /* io_expander12 - pca9555@13 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x13);
     /* io_expander13 - pca9555@14 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x14);
     /* io_expander14 - pca9555@15 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x15);
 
     /* &i2c15 */
     /* temperature-sensor@1f - tmp421 */
-- 
2.55.0


