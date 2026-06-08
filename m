Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70ACCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSrF-0001TW-ON; Mon, 08 Jun 2026 01:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrE-0001SU-Js
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrC-0000SA-MK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA4VTxBMv/eFsypPaw7iuNoEF9+XJvFkkQ8VRSb6QsI=;
 b=AEkpw39JlgEtHdQRSUvqNM55IuVybz1ChFRbvCbv/ZwT2ACHewl+jWMnt873Y013cYva5g
 r100Tg3FG4OS0wQ6eKpm+/8oTR2vA3TSLX3kTwIqxR1AfB0C/MqfgVwr/xphCw8ZaItgDT
 jTJ+ovg5dzaVxu/ZUJR1GcQEumx0WP4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-6VP8uo9DNRK1vXQ5EnmF-g-1; Mon,
 08 Jun 2026 01:49:00 -0400
X-MC-Unique: 6VP8uo9DNRK1vXQ5EnmF-g-1
X-Mimecast-MFC-AGG-ID: 6VP8uo9DNRK1vXQ5EnmF-g_1780897739
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 112EF18003FC; Mon,  8 Jun 2026 05:48:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 507F3765; Mon,  8 Jun 2026 05:48:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/37] hw/intc/aspeed_intc: convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:48:03 +0200
Message-ID: <20260608054826.346488-15-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inline 9 standalone TypeInfo variables (aspeed_intc_info as abstract
base, aspeed_2700_intc_info, aspeed_2700_intcio_info,
aspeed_2700_intcioexp1_info, aspeed_2700_intcioexp2_info,
aspeed_2700ssp_intc_info, aspeed_2700ssp_intcio_info,
aspeed_2700tsp_intc_info, aspeed_2700tsp_intcio_info) directly into
the 'aspeed_intc_types[]' array, removing the need for separate
declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-15-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/aspeed_intc.c | 121 ++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 70 deletions(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 389280943091..5a36fff52040 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -758,16 +758,6 @@ static void aspeed_intc_class_init(ObjectClass *klass, const void *data)
     aic->reg_ops = &aspeed_intc_ops;
 }
 
-static const TypeInfo aspeed_intc_info = {
-    .name = TYPE_ASPEED_INTC,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_init = aspeed_intc_instance_init,
-    .instance_size = sizeof(AspeedINTCState),
-    .class_init = aspeed_intc_class_init,
-    .class_size = sizeof(AspeedINTCClass),
-    .abstract = true,
-};
-
 static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_GICINT192_201_EN, R_GICINT192_201_STATUS},
 };
@@ -788,12 +778,6 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, const void *data)
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc_irqs);
 }
 
-static const TypeInfo aspeed_2700_intc_info = {
-    .name = TYPE_ASPEED_2700_INTC,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700_intc_class_init,
-};
-
 static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},
     {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},
@@ -817,12 +801,6 @@ static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);
 }
 
-static const TypeInfo aspeed_2700_intcioexp2_info = {
-    .name = TYPE_ASPEED_2700_INTCIOEXP2,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700_intcioexp2_class_init,
-};
-
 static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},
     {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},
@@ -846,12 +824,6 @@ static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);
 }
 
-static const TypeInfo aspeed_2700_intcioexp1_info = {
-    .name = TYPE_ASPEED_2700_INTCIOEXP1,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700_intcioexp1_class_init,
-};
-
 static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
     {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
@@ -878,12 +850,6 @@ static void aspeed_2700_intcio_class_init(ObjectClass *klass, const void *data)
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcio_irqs);
 }
 
-static const TypeInfo aspeed_2700_intcio_info = {
-    .name = TYPE_ASPEED_2700_INTCIO,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700_intcio_class_init,
-};
-
 static AspeedINTCIRQ aspeed_2700ssp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_SSPINT160_169_EN, R_SSPINT160_169_STATUS},
 };
@@ -905,12 +871,6 @@ static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700ssp_intc_irqs);
 }
 
-static const TypeInfo aspeed_2700ssp_intc_info = {
-    .name = TYPE_ASPEED_2700SSP_INTC,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700ssp_intc_class_init,
-};
-
 static AspeedINTCIRQ aspeed_2700ssp_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 1, R_SSPINT160_EN, R_SSPINT160_STATUS},
     {1, 1, 1, R_SSPINT161_EN, R_SSPINT161_STATUS},
@@ -938,12 +898,6 @@ static void aspeed_2700ssp_intcio_class_init(ObjectClass *klass,
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700ssp_intcio_irqs);
 }
 
-static const TypeInfo aspeed_2700ssp_intcio_info = {
-    .name = TYPE_ASPEED_2700SSP_INTCIO,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700ssp_intcio_class_init,
-};
-
 static AspeedINTCIRQ aspeed_2700tsp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_TSPINT160_169_EN, R_TSPINT160_169_STATUS},
 };
@@ -965,12 +919,6 @@ static void aspeed_2700tsp_intc_class_init(ObjectClass *klass, const void *data)
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700tsp_intc_irqs);
 }
 
-static const TypeInfo aspeed_2700tsp_intc_info = {
-    .name = TYPE_ASPEED_2700TSP_INTC,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700tsp_intc_class_init,
-};
-
 static AspeedINTCIRQ aspeed_2700tsp_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 1, R_TSPINT160_EN, R_TSPINT160_STATUS},
     {1, 1, 1, R_TSPINT161_EN, R_TSPINT161_STATUS},
@@ -998,23 +946,56 @@ static void aspeed_2700tsp_intcio_class_init(ObjectClass *klass,
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700tsp_intcio_irqs);
 }
 
-static const TypeInfo aspeed_2700tsp_intcio_info = {
-    .name = TYPE_ASPEED_2700TSP_INTCIO,
-    .parent = TYPE_ASPEED_INTC,
-    .class_init = aspeed_2700tsp_intcio_class_init,
+static const TypeInfo aspeed_intc_types[] = {
+    {
+        .name = TYPE_ASPEED_INTC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_init = aspeed_intc_instance_init,
+        .instance_size = sizeof(AspeedINTCState),
+        .class_init = aspeed_intc_class_init,
+        .class_size = sizeof(AspeedINTCClass),
+        .abstract = true,
+    },
+    {
+        .name = TYPE_ASPEED_2700_INTC,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700_intc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_INTCIO,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700_intcio_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700SSP_INTC,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700ssp_intc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700SSP_INTCIO,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700ssp_intcio_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700TSP_INTC,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700tsp_intc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700TSP_INTCIO,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700tsp_intcio_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_INTCIOEXP1,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700_intcioexp1_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_INTCIOEXP2,
+        .parent = TYPE_ASPEED_INTC,
+        .class_init = aspeed_2700_intcioexp2_class_init,
+    }
 };
 
-static void aspeed_intc_register_types(void)
-{
-    type_register_static(&aspeed_intc_info);
-    type_register_static(&aspeed_2700_intc_info);
-    type_register_static(&aspeed_2700_intcio_info);
-    type_register_static(&aspeed_2700_intcioexp1_info);
-    type_register_static(&aspeed_2700_intcioexp2_info);
-    type_register_static(&aspeed_2700ssp_intc_info);
-    type_register_static(&aspeed_2700ssp_intcio_info);
-    type_register_static(&aspeed_2700tsp_intc_info);
-    type_register_static(&aspeed_2700tsp_intcio_info);
-}
-
-type_init(aspeed_intc_register_types);
+DEFINE_TYPES(aspeed_intc_types)
-- 
2.54.0


