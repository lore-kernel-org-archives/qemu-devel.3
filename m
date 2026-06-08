Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD17CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSr9-0001MZ-5W; Mon, 08 Jun 2026 01:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqy-0001IS-Pm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqw-0000Nb-UJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ngqgxb3O6P0HTCUZfT/yNkohR5MzVE3oWr4BxItoFn4=;
 b=QbL1gYgbQolkoo0NAQbI/sLWArBtdAb/GmWhBnb6h/Su7xlRG4Ks5f/fRbiyAkMfNK1P4A
 hApVIw3w9jsR2Qhot7S/Qk6j9lxFhzD5UuIC7dAnq6inu9gIB6Ej+/7Go+I7fTUoNCEKB9
 U1yRbRr/Kz6RbM0QSYibM0gs6sL+/is=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-lXSkYq6fPF-JEyvl7ks2QA-1; Mon,
 08 Jun 2026 01:48:41 -0400
X-MC-Unique: lXSkYq6fPF-JEyvl7ks2QA-1
X-Mimecast-MFC-AGG-ID: lXSkYq6fPF-JEyvl7ks2QA_1780897721
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6B801800347; Mon,  8 Jun 2026 05:48:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C6FD27A; Mon,  8 Jun 2026 05:48:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/37] hw/misc/aspeed_sbc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:47:54 +0200
Message-ID: <20260608054826.346488-6-clg@redhat.com>
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

Inline 3 standalone TypeInfo variables (aspeed_2600_sbc_info,
aspeed_ast10x0_sbc_info, aspeed_sbc_info) directly into the
'aspeed_sbc_types[]' array, removing the need for separate
declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sbc.c | 46 +++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 6125d2f134e8..1dfcf14e5ba6 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -338,14 +338,6 @@ static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, aspeed_sbc_properties);
 }
 
-static const TypeInfo aspeed_sbc_info = {
-    .name = TYPE_ASPEED_SBC,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedSBCState),
-    .instance_init = aspeed_sbc_instance_init,
-    .class_init = aspeed_sbc_class_init,
-    .class_size = sizeof(AspeedSBCClass)
-};
 
 static void aspeed_ast2600_sbc_class_init(ObjectClass *klass, const void *data)
 {
@@ -356,12 +348,6 @@ static void aspeed_ast2600_sbc_class_init(ObjectClass *klass, const void *data)
     sc->has_otp = true;
 }
 
-static const TypeInfo aspeed_ast2600_sbc_info = {
-    .name = TYPE_ASPEED_AST2600_SBC,
-    .parent = TYPE_ASPEED_SBC,
-    .class_init = aspeed_ast2600_sbc_class_init,
-};
-
 static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -371,17 +357,25 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
     sc->has_otp = true;
 }
 
-static const TypeInfo aspeed_ast10x0_sbc_info = {
-    .name = TYPE_ASPEED_AST10X0_SBC,
-    .parent = TYPE_ASPEED_SBC,
-    .class_init = aspeed_ast10x0_sbc_class_init,
+static const TypeInfo aspeed_sbc_types[] = {
+    {
+        .name = TYPE_ASPEED_SBC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedSBCState),
+        .instance_init = aspeed_sbc_instance_init,
+        .class_init = aspeed_sbc_class_init,
+        .class_size = sizeof(AspeedSBCClass),
+    },
+    {
+        .name = TYPE_ASPEED_AST10X0_SBC,
+        .parent = TYPE_ASPEED_SBC,
+        .class_init = aspeed_ast10x0_sbc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_AST2600_SBC,
+        .parent = TYPE_ASPEED_SBC,
+        .class_init = aspeed_ast2600_sbc_class_init,
+    }
 };
 
-static void aspeed_sbc_register_types(void)
-{
-    type_register_static(&aspeed_ast2600_sbc_info);
-    type_register_static(&aspeed_ast10x0_sbc_info);
-    type_register_static(&aspeed_sbc_info);
-}
-
-type_init(aspeed_sbc_register_types);
+DEFINE_TYPES(aspeed_sbc_types)
-- 
2.54.0


