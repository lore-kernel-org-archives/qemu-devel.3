Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5020CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSr9-0001Mb-CS; Mon, 08 Jun 2026 01:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqx-0001IQ-Ty
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqv-0000NK-Vh
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dhiYeZ3EUQx/S9DT/nIpogqmXSlWQypDxDLdNsrqd4=;
 b=Qwjgguo6x8y4ViptX6bXIt00OZyy5saP5j8pTFXrRgk+G8W7CB3/mJJz8j8eVjZj26TIf6
 NXVkFzHf1Crb9wWkz2KPcyp97RAZDTJUJC/mFDTTn1tbulNuTahL+zcbnpFDvkYKT9hXyr
 lKc2Xa9wCaUaKz8GC2QxtbqNIaqvLS8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-If-X9gydO2qsz7VSUwpJfQ-1; Mon,
 08 Jun 2026 01:48:43 -0400
X-MC-Unique: If-X9gydO2qsz7VSUwpJfQ-1
X-Mimecast-MFC-AGG-ID: If-X9gydO2qsz7VSUwpJfQ_1780897723
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DABE31800473; Mon,  8 Jun 2026 05:48:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65B8B765; Mon,  8 Jun 2026 05:48:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/37] hw/misc/aspeed_scu: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:47:55 +0200
Message-ID: <20260608054826.346488-7-clg@redhat.com>
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

Inline 7 standalone TypeInfo variables (aspeed_scu_info as abstract
base, aspeed_2400_scu_info, aspeed_2500_scu_info, aspeed_2600_scu_info,
aspeed_1030_scu_info, aspeed_2700_scu_info, aspeed_2700_scuio_info)
directly into the 'aspeed_scu_types[]' array, removing the need for
separate declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 107 +++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 61 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 19da6c075fae..fe731a28bd50 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -624,15 +624,6 @@ static void aspeed_scu_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, aspeed_scu_properties);
 }
 
-static const TypeInfo aspeed_scu_info = {
-    .name = TYPE_ASPEED_SCU,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedSCUState),
-    .class_init = aspeed_scu_class_init,
-    .class_size    = sizeof(AspeedSCUClass),
-    .abstract      = true,
-};
-
 static void aspeed_2400_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -648,13 +639,6 @@ static void aspeed_2400_scu_class_init(ObjectClass *klass, const void *data)
     asc->ops = &aspeed_ast2400_scu_ops;
 }
 
-static const TypeInfo aspeed_2400_scu_info = {
-    .name = TYPE_ASPEED_2400_SCU,
-    .parent = TYPE_ASPEED_SCU,
-    .instance_size = sizeof(AspeedSCUState),
-    .class_init = aspeed_2400_scu_class_init,
-};
-
 static void aspeed_2500_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -670,13 +654,6 @@ static void aspeed_2500_scu_class_init(ObjectClass *klass, const void *data)
     asc->ops = &aspeed_ast2500_scu_ops;
 }
 
-static const TypeInfo aspeed_2500_scu_info = {
-    .name = TYPE_ASPEED_2500_SCU,
-    .parent = TYPE_ASPEED_SCU,
-    .instance_size = sizeof(AspeedSCUState),
-    .class_init = aspeed_2500_scu_class_init,
-};
-
 static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
                                         unsigned size)
 {
@@ -859,13 +836,6 @@ static void aspeed_2600_scu_class_init(ObjectClass *klass, const void *data)
     asc->ops = &aspeed_ast2600_scu_ops;
 }
 
-static const TypeInfo aspeed_2600_scu_info = {
-    .name = TYPE_ASPEED_2600_SCU,
-    .parent = TYPE_ASPEED_SCU,
-    .instance_size = sizeof(AspeedSCUState),
-    .class_init = aspeed_2600_scu_class_init,
-};
-
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
                                         unsigned size)
 {
@@ -1099,20 +1069,6 @@ static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *data)
     asc->ops = &aspeed_ast2700_scuio_ops;
 }
 
-static const TypeInfo aspeed_2700_scu_info = {
-    .name = TYPE_ASPEED_2700_SCU,
-    .parent = TYPE_ASPEED_SCU,
-    .instance_size = sizeof(AspeedSCUState),
-    .class_init = aspeed_2700_scu_class_init,
-};
-
-static const TypeInfo aspeed_2700_scuio_info = {
-    .name = TYPE_ASPEED_2700_SCUIO,
-    .parent = TYPE_ASPEED_SCU,
-    .instance_size = sizeof(AspeedSCUState),
-    .class_init = aspeed_2700_scuio_class_init,
-};
-
 static const uint32_t ast1030_a1_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_SYS_RST_CTRL]      = 0xFFC3FED8,
     [AST2600_SYS_RST_CTRL2]     = 0x09FFFFFC,
@@ -1158,22 +1114,51 @@ static void aspeed_1030_scu_class_init(ObjectClass *klass, const void *data)
     asc->ops = &aspeed_ast2600_scu_ops;
 }
 
-static const TypeInfo aspeed_1030_scu_info = {
-    .name = TYPE_ASPEED_1030_SCU,
-    .parent = TYPE_ASPEED_SCU,
-    .instance_size = sizeof(AspeedSCUState),
-    .class_init = aspeed_1030_scu_class_init,
+static const TypeInfo aspeed_scu_types[] = {
+    {
+        .name = TYPE_ASPEED_SCU,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedSCUState),
+        .class_init = aspeed_scu_class_init,
+        .class_size    = sizeof(AspeedSCUClass),
+        .abstract      = true,
+    },
+    {
+        .name = TYPE_ASPEED_1030_SCU,
+        .parent = TYPE_ASPEED_SCU,
+        .instance_size = sizeof(AspeedSCUState),
+        .class_init = aspeed_1030_scu_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2400_SCU,
+        .parent = TYPE_ASPEED_SCU,
+        .instance_size = sizeof(AspeedSCUState),
+        .class_init = aspeed_2400_scu_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2500_SCU,
+        .parent = TYPE_ASPEED_SCU,
+        .instance_size = sizeof(AspeedSCUState),
+        .class_init = aspeed_2500_scu_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2600_SCU,
+        .parent = TYPE_ASPEED_SCU,
+        .instance_size = sizeof(AspeedSCUState),
+        .class_init = aspeed_2600_scu_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_SCU,
+        .parent = TYPE_ASPEED_SCU,
+        .instance_size = sizeof(AspeedSCUState),
+        .class_init = aspeed_2700_scu_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_SCUIO,
+        .parent = TYPE_ASPEED_SCU,
+        .instance_size = sizeof(AspeedSCUState),
+        .class_init = aspeed_2700_scuio_class_init,
+    }
 };
 
-static void aspeed_scu_register_types(void)
-{
-    type_register_static(&aspeed_scu_info);
-    type_register_static(&aspeed_2400_scu_info);
-    type_register_static(&aspeed_2500_scu_info);
-    type_register_static(&aspeed_2600_scu_info);
-    type_register_static(&aspeed_1030_scu_info);
-    type_register_static(&aspeed_2700_scu_info);
-    type_register_static(&aspeed_2700_scuio_info);
-}
-
-type_init(aspeed_scu_register_types);
+DEFINE_TYPES(aspeed_scu_types)
-- 
2.54.0


