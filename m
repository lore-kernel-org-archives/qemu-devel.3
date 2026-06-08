Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DC9CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSr8-0001LX-GI; Mon, 08 Jun 2026 01:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSr2-0001Jq-F8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSr0-0000Oa-Ks
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHcHJoucPFwsCxq4xIZR4rtiISi7bo8yUfNEI1LLM5c=;
 b=QFIvSmIPy4wO4UhPA5t2nLHXb1Z5hVlXbBE/koA6sXjfXbuJ2yIb6Ihr/Wn6PdrRjXJhvu
 A/sp4v+FWoK45hupV5ibN0lkIVETCyhKmiuEhkS0LoTVs4JQVf74wJxU5ARQeIg5T4remL
 efnt9S60+a8u9/z29z6L/rqsAyofeUU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-nu4G4NDHNsq8geiaFDnQcw-1; Mon,
 08 Jun 2026 01:48:49 -0400
X-MC-Unique: nu4G4NDHNsq8geiaFDnQcw-1
X-Mimecast-MFC-AGG-ID: nu4G4NDHNsq8geiaFDnQcw_1780897729
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE2C8180059A; Mon,  8 Jun 2026 05:48:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69717765; Mon,  8 Jun 2026 05:48:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/37] hw/misc/aspeed_xdma: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:47:58 +0200
Message-ID: <20260608054826.346488-10-clg@redhat.com>
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

Inline 4 standalone TypeInfo variables (aspeed_xdma_info as abstract
base, aspeed_2400_xdma_info, aspeed_2500_xdma_info,
aspeed_2600_xdma_info) directly into the 'aspeed_xdma_types[]'
array, removing the need for separate declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_xdma.c | 58 +++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 80b32593336c..58a471ee0306 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -167,12 +167,6 @@ static void aspeed_2600_xdma_class_init(ObjectClass *klass, const void *data)
         XDMA_AST2600_IRQ_STATUS_DS_COMP;
 }
 
-static const TypeInfo aspeed_2600_xdma_info = {
-    .name = TYPE_ASPEED_2600_XDMA,
-    .parent = TYPE_ASPEED_XDMA,
-    .class_init = aspeed_2600_xdma_class_init,
-};
-
 static void aspeed_2500_xdma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -189,12 +183,6 @@ static void aspeed_2500_xdma_class_init(ObjectClass *klass, const void *data)
     axc->intr_complete = XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP;
 };
 
-static const TypeInfo aspeed_2500_xdma_info = {
-    .name = TYPE_ASPEED_2500_XDMA,
-    .parent = TYPE_ASPEED_XDMA,
-    .class_init = aspeed_2500_xdma_class_init,
-};
-
 static void aspeed_2400_xdma_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -211,12 +199,6 @@ static void aspeed_2400_xdma_class_init(ObjectClass *klass, const void *data)
     axc->intr_complete = XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP;
 };
 
-static const TypeInfo aspeed_2400_xdma_info = {
-    .name = TYPE_ASPEED_2400_XDMA,
-    .parent = TYPE_ASPEED_XDMA,
-    .class_init = aspeed_2400_xdma_class_init,
-};
-
 static void aspeed_xdma_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
@@ -227,20 +209,30 @@ static void aspeed_xdma_class_init(ObjectClass *classp, const void *data)
     dc->vmsd = &aspeed_xdma_vmstate;
 }
 
-static const TypeInfo aspeed_xdma_info = {
-    .name          = TYPE_ASPEED_XDMA,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedXDMAState),
-    .class_init    = aspeed_xdma_class_init,
-    .class_size    = sizeof(AspeedXDMAClass),
-    .abstract      = true,
+static const TypeInfo aspeed_xdma_types[] = {
+    {
+        .name          = TYPE_ASPEED_XDMA,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedXDMAState),
+        .class_init    = aspeed_xdma_class_init,
+        .class_size    = sizeof(AspeedXDMAClass),
+        .abstract      = true,
+    },
+    {
+        .name = TYPE_ASPEED_2400_XDMA,
+        .parent = TYPE_ASPEED_XDMA,
+        .class_init = aspeed_2400_xdma_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2500_XDMA,
+        .parent = TYPE_ASPEED_XDMA,
+        .class_init = aspeed_2500_xdma_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2600_XDMA,
+        .parent = TYPE_ASPEED_XDMA,
+        .class_init = aspeed_2600_xdma_class_init,
+    }
 };
 
-static void aspeed_xdma_register_type(void)
-{
-    type_register_static(&aspeed_xdma_info);
-    type_register_static(&aspeed_2400_xdma_info);
-    type_register_static(&aspeed_2500_xdma_info);
-    type_register_static(&aspeed_2600_xdma_info);
-}
-type_init(aspeed_xdma_register_type);
+DEFINE_TYPES(aspeed_xdma_types)
-- 
2.54.0


