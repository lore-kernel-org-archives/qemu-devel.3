Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4CFCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSs2-0001yu-D9; Mon, 08 Jun 2026 01:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSra-0001dR-0N
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrW-0000Z8-Fg
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEjZ/uidbnSpokxNLxjtJNU0rw4LKVtvkjl/yUDH/B4=;
 b=CxIbYxXoVY8BZ1AXSHWrpyFmjUTwT28arORaQ+t7ESF72YGQTAyD5p/U3imnNdzaqCcbCZ
 9CHSpq+kZXcYgGEsVlG0wmsGfvZqu9/UDgYlbKdSOah5+Um1VKnh0uKQTSkWLjeBNp4o1W
 /ffjsL+pBiHqex5t1sxcAMPnyL1zsNk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-lAy0ledVN7GaH2VKZ3EmFA-1; Mon,
 08 Jun 2026 01:49:20 -0400
X-MC-Unique: lAy0ledVN7GaH2VKZ3EmFA-1
X-Mimecast-MFC-AGG-ID: lAy0ledVN7GaH2VKZ3EmFA_1780897759
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBBEA180061D; Mon,  8 Jun 2026 05:49:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DF78765; Mon,  8 Jun 2026 05:49:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/37] hw/ssi/aspeed_smc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:48:13 +0200
Message-ID: <20260608054826.346488-25-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Replace the legacy type_register_static()/type_init() registration
pattern with the modern DEFINE_TYPES() macro.

Inline 18 standalone TypeInfo variables (aspeed_smc_flash_info,
aspeed_smc_info as abstract base, aspeed_2400_smc_info,
aspeed_2400_fmc_info, aspeed_2400_spi1_info, aspeed_2500_fmc_info,
aspeed_2500_spi1_info, aspeed_2500_spi2_info, aspeed_2600_fmc_info,
aspeed_2600_spi1_info, aspeed_2600_spi2_info, aspeed_1030_fmc_info,
aspeed_1030_spi1_info, aspeed_1030_spi2_info, aspeed_2700_fmc_info,
aspeed_2700_spi0_info, aspeed_2700_spi1_info, aspeed_2700_spi2_info)
directly into the 'aspeed_smc_types[]' array, removing the need for
separate declarations.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-25-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ssi/aspeed_smc.c | 228 +++++++++++++++++++-------------------------
 1 file changed, 96 insertions(+), 132 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 3767ad0c7a3e..d87fbd798c62 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1312,16 +1312,6 @@ static void aspeed_smc_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_aspeed_smc;
 }
 
-static const TypeInfo aspeed_smc_info = {
-    .name           = TYPE_ASPEED_SMC,
-    .parent         = TYPE_SYS_BUS_DEVICE,
-    .instance_init  = aspeed_smc_instance_init,
-    .instance_size  = sizeof(AspeedSMCState),
-    .class_size     = sizeof(AspeedSMCClass),
-    .class_init     = aspeed_smc_class_init,
-    .abstract       = true,
-};
-
 static void aspeed_smc_flash_realize(DeviceState *dev, Error **errp)
 {
     AspeedSMCFlash *s = ASPEED_SMC_FLASH(dev);
@@ -1358,13 +1348,6 @@ static void aspeed_smc_flash_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, aspeed_smc_flash_properties);
 }
 
-static const TypeInfo aspeed_smc_flash_info = {
-    .name           = TYPE_ASPEED_SMC_FLASH,
-    .parent         = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(AspeedSMCFlash),
-    .class_init     = aspeed_smc_flash_class_init,
-};
-
 /*
  * The Segment Registers of the AST2400 and AST2500 have a 8MB
  * unit. The address range of a flash SPI peripheral is encoded with
@@ -1415,12 +1398,6 @@ static void aspeed_2400_smc_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2400_smc_info = {
-    .name =  "aspeed.smc-ast2400",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2400_smc_class_init,
-};
-
 static const uint32_t aspeed_2400_fmc_resets[ASPEED_SMC_R_MAX] = {
     /*
      * CE0 and CE1 types are HW strapped in SCU70. Do it here to
@@ -1466,12 +1443,6 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2400_fmc_info = {
-    .name =  "aspeed.fmc-ast2400",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2400_fmc_class_init,
-};
-
 static const AspeedSegments aspeed_2400_spi1_segments[] = {
     { 0x30000000, 64 * MiB },
 };
@@ -1506,12 +1477,6 @@ static void aspeed_2400_spi1_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2400_spi1_info = {
-    .name =  "aspeed.spi1-ast2400",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2400_spi1_class_init,
-};
-
 static const uint32_t aspeed_2500_fmc_resets[ASPEED_SMC_R_MAX] = {
     [R_CONF] = (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |
                 CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),
@@ -1552,12 +1517,6 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2500_fmc_info = {
-    .name =  "aspeed.fmc-ast2500",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2500_fmc_class_init,
-};
-
 static const AspeedSegments aspeed_2500_spi1_segments[] = {
     { 0x30000000, 32 * MiB }, /* start address is readonly */
     { 0x32000000, 96 * MiB }, /* end address is readonly */
@@ -1588,12 +1547,6 @@ static void aspeed_2500_spi1_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2500_spi1_info = {
-    .name =  "aspeed.spi1-ast2500",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2500_spi1_class_init,
-};
-
 static const AspeedSegments aspeed_2500_spi2_segments[] = {
     { 0x38000000, 32 * MiB }, /* start address is readonly */
     { 0x3A000000, 96 * MiB }, /* end address is readonly */
@@ -1624,12 +1577,6 @@ static void aspeed_2500_spi2_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2500_spi2_info = {
-    .name =  "aspeed.spi2-ast2500",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2500_spi2_class_init,
-};
-
 /*
  * The Segment Registers of the AST2600 have a 1MB unit. The address
  * range of a flash SPI peripheral is encoded with offsets in the overall
@@ -1712,12 +1659,6 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2600_fmc_info = {
-    .name =  "aspeed.fmc-ast2600",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2600_fmc_class_init,
-};
-
 static const AspeedSegments aspeed_2600_spi1_segments[] = {
     { 0x0, 128 * MiB }, /* start address is readonly */
     { 0x0, 0 }, /* disabled */
@@ -1752,12 +1693,6 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2600_spi1_info = {
-    .name =  "aspeed.spi1-ast2600",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2600_spi1_class_init,
-};
-
 static const AspeedSegments aspeed_2600_spi2_segments[] = {
     { 0x0, 128 * MiB }, /* start address is readonly */
     { 0x0, 0 }, /* disabled */
@@ -1793,12 +1728,6 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2600_spi2_info = {
-    .name =  "aspeed.spi2-ast2600",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2600_spi2_class_init,
-};
-
 /*
  * The FMC Segment Registers of the AST1030 have a 512KB unit.
  * Only bits [27:19] are used for decoding.
@@ -1877,12 +1806,6 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_1030_fmc_info = {
-    .name =  "aspeed.fmc-ast1030",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_1030_fmc_class_init,
-};
-
 static const AspeedSegments aspeed_1030_spi1_segments[] = {
     { 0x0, 128 * MiB }, /* start address is readonly */
     { 0x0, 0 }, /* disabled */
@@ -1916,11 +1839,6 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_1030_spi1_info = {
-    .name =  "aspeed.spi1-ast1030",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_1030_spi1_class_init,
-};
 static const AspeedSegments aspeed_1030_spi2_segments[] = {
     { 0x0, 128 * MiB }, /* start address is readonly */
     { 0x0, 0 }, /* disabled */
@@ -1954,12 +1872,6 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_1030_spi2_info = {
-    .name =  "aspeed.spi2-ast1030",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_1030_spi2_class_init,
-};
-
 /*
  * The FMC Segment Registers of the AST2700 have a 64KB unit.
  * Only bits [31:16] are used for decoding.
@@ -2061,12 +1973,6 @@ static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2700_fmc_info = {
-    .name =  "aspeed.fmc-ast2700",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2700_fmc_class_init,
-};
-
 static const AspeedSegments aspeed_2700_spi0_segments[] = {
     { 0x0, 128 * MiB }, /* start address is readonly */
     { 128 * MiB, 128 * MiB }, /* start address is readonly */
@@ -2102,12 +2008,6 @@ static void aspeed_2700_spi0_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2700_spi0_info = {
-    .name =  "aspeed.spi0-ast2700",
-    .parent = TYPE_ASPEED_SMC,
-    .class_init = aspeed_2700_spi0_class_init,
-};
-
 static const AspeedSegments aspeed_2700_spi1_segments[] = {
     { 0x0, 128 * MiB }, /* start address is readonly */
     { 0x0, 0 }, /* disabled */
@@ -2142,12 +2042,6 @@ static void aspeed_2700_spi1_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2700_spi1_info = {
-        .name =  "aspeed.spi1-ast2700",
-        .parent = TYPE_ASPEED_SMC,
-        .class_init = aspeed_2700_spi1_class_init,
-};
-
 static const AspeedSegments aspeed_2700_spi2_segments[] = {
     { 0x0, 128 * MiB }, /* start address is readonly */
     { 0x0, 0 }, /* disabled */
@@ -2182,32 +2076,102 @@ static void aspeed_2700_spi2_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
-static const TypeInfo aspeed_2700_spi2_info = {
-        .name =  "aspeed.spi2-ast2700",
-        .parent = TYPE_ASPEED_SMC,
+static const TypeInfo aspeed_smc_types[] = {
+    {
+        .name           = TYPE_ASPEED_SMC_FLASH,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(AspeedSMCFlash),
+        .class_init     = aspeed_smc_flash_class_init,
+    },
+    {
+        .name           = TYPE_ASPEED_SMC,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_init  = aspeed_smc_instance_init,
+        .instance_size  = sizeof(AspeedSMCState),
+        .class_size     = sizeof(AspeedSMCClass),
+        .class_init     = aspeed_smc_class_init,
+        .abstract       = true,
+    },
+    {
+        .name       = "aspeed.fmc-ast1030",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_1030_fmc_class_init,
+    },
+    {
+        .name       = "aspeed.spi1-ast1030",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_1030_spi1_class_init,
+    },
+    {
+        .name       = "aspeed.spi2-ast1030",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_1030_spi2_class_init,
+    },
+    {
+        .name       = "aspeed.smc-ast2400",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2400_smc_class_init,
+    },
+    {
+        .name       = "aspeed.fmc-ast2400",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2400_fmc_class_init,
+    },
+    {
+        .name       = "aspeed.spi1-ast2400",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2400_spi1_class_init,
+    },
+    {
+        .name       = "aspeed.fmc-ast2500",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2500_fmc_class_init,
+    },
+    {
+        .name       = "aspeed.spi1-ast2500",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2500_spi1_class_init,
+    },
+    {
+        .name       = "aspeed.spi2-ast2500",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2500_spi2_class_init,
+    },
+    {
+        .name       = "aspeed.fmc-ast2600",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2600_fmc_class_init,
+    },
+    {
+        .name       = "aspeed.spi1-ast2600",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2600_spi1_class_init,
+    },
+    {
+        .name       = "aspeed.spi2-ast2600",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2600_spi2_class_init,
+    },
+    {
+        .name       = "aspeed.fmc-ast2700",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2700_fmc_class_init,
+    },
+    {
+        .name       = "aspeed.spi0-ast2700",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2700_spi0_class_init,
+    },
+    {
+        .name       = "aspeed.spi1-ast2700",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2700_spi1_class_init,
+    },
+    {
+        .name       = "aspeed.spi2-ast2700",
+        .parent     = TYPE_ASPEED_SMC,
         .class_init = aspeed_2700_spi2_class_init,
+    }
 };
 
-static void aspeed_smc_register_types(void)
-{
-    type_register_static(&aspeed_smc_flash_info);
-    type_register_static(&aspeed_smc_info);
-    type_register_static(&aspeed_2400_smc_info);
-    type_register_static(&aspeed_2400_fmc_info);
-    type_register_static(&aspeed_2400_spi1_info);
-    type_register_static(&aspeed_2500_fmc_info);
-    type_register_static(&aspeed_2500_spi1_info);
-    type_register_static(&aspeed_2500_spi2_info);
-    type_register_static(&aspeed_2600_fmc_info);
-    type_register_static(&aspeed_2600_spi1_info);
-    type_register_static(&aspeed_2600_spi2_info);
-    type_register_static(&aspeed_1030_fmc_info);
-    type_register_static(&aspeed_1030_spi1_info);
-    type_register_static(&aspeed_1030_spi2_info);
-    type_register_static(&aspeed_2700_fmc_info);
-    type_register_static(&aspeed_2700_spi0_info);
-    type_register_static(&aspeed_2700_spi1_info);
-    type_register_static(&aspeed_2700_spi2_info);
-}
-
-type_init(aspeed_smc_register_types)
+DEFINE_TYPES(aspeed_smc_types)
-- 
2.54.0


