Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD834CD8CA6
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSr8-0001L6-Cn; Mon, 08 Jun 2026 01:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqy-0001IR-K9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqw-0000NN-3t
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6gK0iKpUcHmAVtVCVtQT+7M8qJ3nFde7PqZM+fgqnY=;
 b=dykvahT+QXWpfFHZKgh13hUuATIECESoGolMCGtxfJx2eY80HBPFZzWzuYpzN/bhDVMmR9
 /Ll+tRyTxDUixak0XBfBFhSqMO5aEb8+q7rcy45i9qR4pg6WQ38C0JvscAfukgIa1FBPa+
 hFblbUOxcWt7NsN2mv/+4s68OABQvZk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-FeKF6KTjMcmjJdxRTRLXnA-1; Mon,
 08 Jun 2026 01:48:45 -0400
X-MC-Unique: FeKF6KTjMcmjJdxRTRLXnA-1
X-Mimecast-MFC-AGG-ID: FeKF6KTjMcmjJdxRTRLXnA_1780897724
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD168195608C; Mon,  8 Jun 2026 05:48:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59054765; Mon,  8 Jun 2026 05:48:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/37] hw/misc/aspeed_sdmc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:47:56 +0200
Message-ID: <20260608054826.346488-8-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Inline 5 standalone TypeInfo variables (aspeed_sdmc_info as abstract
base, aspeed_2400_sdmc_info, aspeed_2500_sdmc_info,
aspeed_2600_sdmc_info, aspeed_2700_sdmc_info) directly into the
'aspeed_sdmc_types[]' array, removing the need for separate
declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sdmc.c | 73 ++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 055abf7f50f0..f8fbaebee6ab 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -310,16 +310,6 @@ static void aspeed_sdmc_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, aspeed_sdmc_properties);
 }
 
-static const TypeInfo aspeed_sdmc_info = {
-    .name = TYPE_ASPEED_SDMC,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedSDMCState),
-    .instance_init = aspeed_sdmc_initfn,
-    .class_init = aspeed_sdmc_class_init,
-    .class_size = sizeof(AspeedSDMCClass),
-    .abstract   = true,
-};
-
 static int aspeed_sdmc_get_ram_bits(AspeedSDMCState *s)
 {
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
@@ -393,12 +383,6 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, const void *data)
     asc->valid_ram_sizes = aspeed_2400_ram_sizes;
 }
 
-static const TypeInfo aspeed_2400_sdmc_info = {
-    .name = TYPE_ASPEED_2400_SDMC,
-    .parent = TYPE_ASPEED_SDMC,
-    .class_init = aspeed_2400_sdmc_class_init,
-};
-
 static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 {
     uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
@@ -461,12 +445,6 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, const void *data)
     asc->valid_ram_sizes = aspeed_2500_ram_sizes;
 }
 
-static const TypeInfo aspeed_2500_sdmc_info = {
-    .name = TYPE_ASPEED_2500_SDMC,
-    .parent = TYPE_ASPEED_SDMC,
-    .class_init = aspeed_2500_sdmc_class_init,
-};
-
 static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 {
     uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(3) |
@@ -555,12 +533,6 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, const void *data)
     asc->valid_ram_sizes = aspeed_2600_ram_sizes;
 }
 
-static const TypeInfo aspeed_2600_sdmc_info = {
-    .name = TYPE_ASPEED_2600_SDMC,
-    .parent = TYPE_ASPEED_SDMC,
-    .class_init = aspeed_2600_sdmc_class_init,
-};
-
 static void aspeed_2700_sdmc_reset_hold(Object *obj, ResetType type)
 {
     AspeedSDMCState *s = ASPEED_SDMC(obj);
@@ -690,19 +662,36 @@ static void aspeed_2700_sdmc_class_init(ObjectClass *klass, const void *data)
     asc->valid_ram_sizes = aspeed_2700_ram_sizes;
 }
 
-static const TypeInfo aspeed_2700_sdmc_info = {
-    .name = TYPE_ASPEED_2700_SDMC,
-    .parent = TYPE_ASPEED_SDMC,
-    .class_init = aspeed_2700_sdmc_class_init,
+static const TypeInfo aspeed_sdmc_types[] = {
+    {
+        .name = TYPE_ASPEED_SDMC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedSDMCState),
+        .instance_init = aspeed_sdmc_initfn,
+        .class_init = aspeed_sdmc_class_init,
+        .class_size = sizeof(AspeedSDMCClass),
+        .abstract   = true,
+    },
+    {
+        .name = TYPE_ASPEED_2400_SDMC,
+        .parent = TYPE_ASPEED_SDMC,
+        .class_init = aspeed_2400_sdmc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2500_SDMC,
+        .parent = TYPE_ASPEED_SDMC,
+        .class_init = aspeed_2500_sdmc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2600_SDMC,
+        .parent = TYPE_ASPEED_SDMC,
+        .class_init = aspeed_2600_sdmc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_SDMC,
+        .parent = TYPE_ASPEED_SDMC,
+        .class_init = aspeed_2700_sdmc_class_init,
+    }
 };
 
-static void aspeed_sdmc_register_types(void)
-{
-    type_register_static(&aspeed_sdmc_info);
-    type_register_static(&aspeed_2400_sdmc_info);
-    type_register_static(&aspeed_2500_sdmc_info);
-    type_register_static(&aspeed_2600_sdmc_info);
-    type_register_static(&aspeed_2700_sdmc_info);
-}
-
-type_init(aspeed_sdmc_register_types);
+DEFINE_TYPES(aspeed_sdmc_types)
-- 
2.54.0


