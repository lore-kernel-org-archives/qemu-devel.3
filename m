Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B573CCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSrK-0001VM-Bx; Mon, 08 Jun 2026 01:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrH-0001UF-W2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrG-0000Ss-6E
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVNxIapeP19+wx1gDjvqqWIIr+P2jHWr5RYAQhzozXc=;
 b=OlOHIdXZorU4nTmCn+xIg0v5iN2MHJS6bZAbRnWQEWuSDRzfQ+Ll95PUjYFVGXB5YHaj6M
 4uy8jPP2NnWBVmtGxTGw09A417+BITy0ROl7+iWBj8V+GuPUmxwDx9n6rL999GIt0ImBnO
 Q1we1KuCzkI6UDkVv9H5tB4YtKP17Lc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-tDUH6tROMim-ziT8GJCmCQ-1; Mon,
 08 Jun 2026 01:49:06 -0400
X-MC-Unique: tDUH6tROMim-ziT8GJCmCQ-1
X-Mimecast-MFC-AGG-ID: tDUH6tROMim-ziT8GJCmCQ_1780897745
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 345231956096; Mon,  8 Jun 2026 05:49:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FEBF765; Mon,  8 Jun 2026 05:49:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/37] hw/watchdog/wdt_aspeed: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:48:06 +0200
Message-ID: <20260608054826.346488-18-clg@redhat.com>
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

Inline 6 standalone TypeInfo variables (aspeed_wdt_info as abstract
base, aspeed_2400_wdt_info, aspeed_2500_wdt_info, aspeed_2600_wdt_info,
aspeed_1030_wdt_info, aspeed_2700_wdt_info) directly into the
'aspeed_wdt_types[]' array, removing the need for separate declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-18-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/watchdog/wdt_aspeed.c | 93 +++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index ae411593c583..deed970c89b9 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -321,15 +321,6 @@ static void aspeed_wdt_class_init(ObjectClass *klass, const void *data)
     dc->desc = "Aspeed watchdog device";
 }
 
-static const TypeInfo aspeed_wdt_info = {
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .name  = TYPE_ASPEED_WDT,
-    .instance_size  = sizeof(AspeedWDTState),
-    .class_init = aspeed_wdt_class_init,
-    .class_size    = sizeof(AspeedWDTClass),
-    .abstract      = true,
-};
-
 static void aspeed_2400_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -345,13 +336,6 @@ static void aspeed_2400_wdt_class_init(ObjectClass *klass, const void *data)
     awc->default_reload_value = 0x03EF1480;
 }
 
-static const TypeInfo aspeed_2400_wdt_info = {
-    .name = TYPE_ASPEED_2400_WDT,
-    .parent = TYPE_ASPEED_WDT,
-    .instance_size = sizeof(AspeedWDTState),
-    .class_init = aspeed_2400_wdt_class_init,
-};
-
 static void aspeed_2500_wdt_reset_pulse(AspeedWDTState *s, uint32_t property)
 {
     if (property) {
@@ -383,13 +367,6 @@ static void aspeed_2500_wdt_class_init(ObjectClass *klass, const void *data)
     awc->default_reload_value = 0x014FB180;
 }
 
-static const TypeInfo aspeed_2500_wdt_info = {
-    .name = TYPE_ASPEED_2500_WDT,
-    .parent = TYPE_ASPEED_WDT,
-    .instance_size = sizeof(AspeedWDTState),
-    .class_init = aspeed_2500_wdt_class_init,
-};
-
 static void aspeed_2600_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -406,13 +383,6 @@ static void aspeed_2600_wdt_class_init(ObjectClass *klass, const void *data)
     awc->default_reload_value = 0x014FB180;
 }
 
-static const TypeInfo aspeed_2600_wdt_info = {
-    .name = TYPE_ASPEED_2600_WDT,
-    .parent = TYPE_ASPEED_WDT,
-    .instance_size = sizeof(AspeedWDTState),
-    .class_init = aspeed_2600_wdt_class_init,
-};
-
 static void aspeed_1030_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -429,13 +399,6 @@ static void aspeed_1030_wdt_class_init(ObjectClass *klass, const void *data)
     awc->default_reload_value = 0x014FB180;
 }
 
-static const TypeInfo aspeed_1030_wdt_info = {
-    .name = TYPE_ASPEED_1030_WDT,
-    .parent = TYPE_ASPEED_WDT,
-    .instance_size = sizeof(AspeedWDTState),
-    .class_init = aspeed_1030_wdt_class_init,
-};
-
 static void aspeed_2700_wdt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -452,21 +415,45 @@ static void aspeed_2700_wdt_class_init(ObjectClass *klass, const void *data)
     awc->default_reload_value = 0x014FB180;
 }
 
-static const TypeInfo aspeed_2700_wdt_info = {
-    .name = TYPE_ASPEED_2700_WDT,
-    .parent = TYPE_ASPEED_WDT,
-    .instance_size = sizeof(AspeedWDTState),
-    .class_init = aspeed_2700_wdt_class_init,
+static const TypeInfo aspeed_wdt_types[] = {
+    {
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .name  = TYPE_ASPEED_WDT,
+        .instance_size  = sizeof(AspeedWDTState),
+        .class_init = aspeed_wdt_class_init,
+        .class_size    = sizeof(AspeedWDTClass),
+        .abstract      = true,
+    },
+    {
+        .name = TYPE_ASPEED_1030_WDT,
+        .parent = TYPE_ASPEED_WDT,
+        .instance_size = sizeof(AspeedWDTState),
+        .class_init = aspeed_1030_wdt_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2400_WDT,
+        .parent = TYPE_ASPEED_WDT,
+        .instance_size = sizeof(AspeedWDTState),
+        .class_init = aspeed_2400_wdt_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2500_WDT,
+        .parent = TYPE_ASPEED_WDT,
+        .instance_size = sizeof(AspeedWDTState),
+        .class_init = aspeed_2500_wdt_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2600_WDT,
+        .parent = TYPE_ASPEED_WDT,
+        .instance_size = sizeof(AspeedWDTState),
+        .class_init = aspeed_2600_wdt_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_WDT,
+        .parent = TYPE_ASPEED_WDT,
+        .instance_size = sizeof(AspeedWDTState),
+        .class_init = aspeed_2700_wdt_class_init,
+    }
 };
 
-static void wdt_aspeed_register_types(void)
-{
-    type_register_static(&aspeed_wdt_info);
-    type_register_static(&aspeed_2400_wdt_info);
-    type_register_static(&aspeed_2500_wdt_info);
-    type_register_static(&aspeed_2600_wdt_info);
-    type_register_static(&aspeed_2700_wdt_info);
-    type_register_static(&aspeed_1030_wdt_info);
-}
-
-type_init(wdt_aspeed_register_types)
+DEFINE_TYPES(aspeed_wdt_types)
-- 
2.54.0


