Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76EBCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSqo-0001Ez-9k; Mon, 08 Jun 2026 01:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqm-0001EC-Bb
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqk-0000Ja-95
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwdjZWKXLxETGhhU/dXr2xDEQpIttY2UFHIiC84tea8=;
 b=hICydxn1LMYU5ixEmNa8+YL+mgYhnIwqF+f+Ztb4sn66mczNKkwIg4ySomwUF/fmtUGWAu
 fO4TbzOi7b3bxxLcjk9Be074Y7GVNDN73V9KUJYKW7m6brLIucvnClw5wIN0CNs9onisA5
 PY0iwon3x15298R8uW9WL3ON+zczi/8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-PBvvE04sNr6Lm0Ik2CUuwQ-1; Mon,
 08 Jun 2026 01:48:33 -0400
X-MC-Unique: PBvvE04sNr6Lm0Ik2CUuwQ-1
X-Mimecast-MFC-AGG-ID: PBvvE04sNr6Lm0Ik2CUuwQ_1780897713
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19FC18003FC; Mon,  8 Jun 2026 05:48:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E8BA27A; Mon,  8 Jun 2026 05:48:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/37] hw/misc/aspeed_hace: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:47:50 +0200
Message-ID: <20260608054826.346488-2-clg@redhat.com>
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

Inline 6 standalone TypeInfo variables (aspeed_hace_info as abstract
base, aspeed_2400_hace_info, aspeed_2500_hace_info,
aspeed_2600_hace_info, aspeed_1030_hace_info, aspeed_2700_hace_info)
directly into the 'aspeed_hace_types[]' array, removing the need for
separate declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 81 ++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 4c9e913f6c66..c61efe50c4ff 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -696,14 +696,6 @@ static void aspeed_hace_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_aspeed_hace;
 }
 
-static const TypeInfo aspeed_hace_info = {
-    .name = TYPE_ASPEED_HACE,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedHACEState),
-    .class_init = aspeed_hace_class_init,
-    .class_size = sizeof(AspeedHACEClass)
-};
-
 static void aspeed_ast2400_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -718,12 +710,6 @@ static void aspeed_ast2400_hace_class_init(ObjectClass *klass, const void *data)
     ahc->hash_mask = 0x000003ff; /* No SG or SHA512 modes */
 }
 
-static const TypeInfo aspeed_ast2400_hace_info = {
-    .name = TYPE_ASPEED_AST2400_HACE,
-    .parent = TYPE_ASPEED_HACE,
-    .class_init = aspeed_ast2400_hace_class_init,
-};
-
 static void aspeed_ast2500_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -738,12 +724,6 @@ static void aspeed_ast2500_hace_class_init(ObjectClass *klass, const void *data)
     ahc->hash_mask = 0x000003ff; /* No SG or SHA512 modes */
 }
 
-static const TypeInfo aspeed_ast2500_hace_info = {
-    .name = TYPE_ASPEED_AST2500_HACE,
-    .parent = TYPE_ASPEED_HACE,
-    .class_init = aspeed_ast2500_hace_class_init,
-};
-
 static void aspeed_ast2600_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -758,12 +738,6 @@ static void aspeed_ast2600_hace_class_init(ObjectClass *klass, const void *data)
     ahc->hash_mask = 0x00147FFF;
 }
 
-static const TypeInfo aspeed_ast2600_hace_info = {
-    .name = TYPE_ASPEED_AST2600_HACE,
-    .parent = TYPE_ASPEED_HACE,
-    .class_init = aspeed_ast2600_hace_class_init,
-};
-
 static void aspeed_ast1030_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -778,12 +752,6 @@ static void aspeed_ast1030_hace_class_init(ObjectClass *klass, const void *data)
     ahc->hash_mask = 0x00147FFF;
 }
 
-static const TypeInfo aspeed_ast1030_hace_info = {
-    .name = TYPE_ASPEED_AST1030_HACE,
-    .parent = TYPE_ASPEED_HACE,
-    .class_init = aspeed_ast1030_hace_class_init,
-};
-
 static void aspeed_ast2700_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -823,20 +791,39 @@ static void aspeed_ast2700_hace_class_init(ObjectClass *klass, const void *data)
     ahc->has_dma64 = true;
 }
 
-static const TypeInfo aspeed_ast2700_hace_info = {
-    .name = TYPE_ASPEED_AST2700_HACE,
-    .parent = TYPE_ASPEED_HACE,
-    .class_init = aspeed_ast2700_hace_class_init,
+static const TypeInfo aspeed_hace_types[] = {
+    {
+        .name = TYPE_ASPEED_HACE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedHACEState),
+        .class_init = aspeed_hace_class_init,
+        .class_size = sizeof(AspeedHACEClass),
+    },
+    {
+        .name = TYPE_ASPEED_AST1030_HACE,
+        .parent = TYPE_ASPEED_HACE,
+        .class_init = aspeed_ast1030_hace_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_AST2400_HACE,
+        .parent = TYPE_ASPEED_HACE,
+        .class_init = aspeed_ast2400_hace_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_AST2500_HACE,
+        .parent = TYPE_ASPEED_HACE,
+        .class_init = aspeed_ast2500_hace_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_AST2600_HACE,
+        .parent = TYPE_ASPEED_HACE,
+        .class_init = aspeed_ast2600_hace_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_AST2700_HACE,
+        .parent = TYPE_ASPEED_HACE,
+        .class_init = aspeed_ast2700_hace_class_init,
+    }
 };
 
-static void aspeed_hace_register_types(void)
-{
-    type_register_static(&aspeed_ast2400_hace_info);
-    type_register_static(&aspeed_ast2500_hace_info);
-    type_register_static(&aspeed_ast2600_hace_info);
-    type_register_static(&aspeed_ast1030_hace_info);
-    type_register_static(&aspeed_ast2700_hace_info);
-    type_register_static(&aspeed_hace_info);
-}
-
-type_init(aspeed_hace_register_types);
+DEFINE_TYPES(aspeed_hace_types)
-- 
2.54.0


