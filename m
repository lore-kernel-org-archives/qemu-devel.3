Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C4CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSrs-0001sr-Dz; Mon, 08 Jun 2026 01:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrR-0001Xk-QX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrQ-0000Vd-00
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gj6devSdvGtSJwO1GoRjihnYYTQEc2hzqsdTXSyTwU=;
 b=PxnAkfvz3FqT98pAHsqrcTSzXGrIvqJ03Cw1W1rnLkrQS7bVW/haJyUZS6gJ5tMddlpdqY
 +O/9LjdQprqEwV/2M0oFDdXPFRgj8Zjur4cMc18WtAsCp6V6jIk7CEi5SNSl38m3DjwiPG
 lUIF5fj8mOJVfwOV3kEj5R1TbsjUM/4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-OoG4FNVOMeO20xr87lJTLw-1; Mon,
 08 Jun 2026 01:49:15 -0400
X-MC-Unique: OoG4FNVOMeO20xr87lJTLw-1
X-Mimecast-MFC-AGG-ID: OoG4FNVOMeO20xr87lJTLw_1780897755
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEEBE1800473; Mon,  8 Jun 2026 05:49:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B63527A; Mon,  8 Jun 2026 05:49:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/37] hw/i2c/aspeed_i2c: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:48:11 +0200
Message-ID: <20260608054826.346488-23-clg@redhat.com>
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

Inline 9 standalone TypeInfo variables (aspeed_i2c_bus_info,
aspeed_i2c_bus_slave_info, aspeed_i2c_info as abstract base,
aspeed_2400_i2c_info, aspeed_2500_i2c_info, aspeed_2600_i2c_info,
aspeed_1030_i2c_info and aspeed_2700_i2c_info) directly into the
'aspeed_i2c_types[]' array, removing the need for
separate declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-23-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 113 +++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 65 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 80c445750059..4a6732a18554 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1372,16 +1372,6 @@ static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
     dc->desc = "Aspeed I2C Controller";
 }
 
-static const TypeInfo aspeed_i2c_info = {
-    .name          = TYPE_ASPEED_I2C,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_init = aspeed_i2c_instance_init,
-    .instance_size = sizeof(AspeedI2CState),
-    .class_init    = aspeed_i2c_class_init,
-    .class_size = sizeof(AspeedI2CClass),
-    .abstract   = true,
-};
-
 static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
                                           enum i2c_event event)
 {
@@ -1500,13 +1490,6 @@ static void aspeed_i2c_bus_slave_class_init(ObjectClass *klass,
     sc->send_async = aspeed_i2c_bus_slave_send_async;
 }
 
-static const TypeInfo aspeed_i2c_bus_slave_info = {
-    .name           = TYPE_ASPEED_I2C_BUS_SLAVE,
-    .parent         = TYPE_I2C_SLAVE,
-    .instance_size  = sizeof(AspeedI2CBusSlave),
-    .class_init     = aspeed_i2c_bus_slave_class_init,
-};
-
 static void aspeed_i2c_bus_reset_hold(Object *obj, ResetType type)
 {
     AspeedI2CBus *s = ASPEED_I2C_BUS(obj);
@@ -1565,13 +1548,6 @@ static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, aspeed_i2c_bus_properties);
 }
 
-static const TypeInfo aspeed_i2c_bus_info = {
-    .name           = TYPE_ASPEED_I2C_BUS,
-    .parent         = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(AspeedI2CBus),
-    .class_init     = aspeed_i2c_bus_class_init,
-};
-
 static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2CBus *bus)
 {
     return bus->controller->irq;
@@ -1605,12 +1581,6 @@ static void aspeed_2400_i2c_class_init(ObjectClass *klass, const void *data)
     aic->mem_size = 0x1000;
 }
 
-static const TypeInfo aspeed_2400_i2c_info = {
-    .name = TYPE_ASPEED_2400_I2C,
-    .parent = TYPE_ASPEED_I2C,
-    .class_init = aspeed_2400_i2c_class_init,
-};
-
 static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)
 {
     return bus->controller->irq;
@@ -1640,12 +1610,6 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, const void *data)
     aic->mem_size = 0x1000;
 }
 
-static const TypeInfo aspeed_2500_i2c_info = {
-    .name = TYPE_ASPEED_2500_I2C,
-    .parent = TYPE_ASPEED_I2C,
-    .class_init = aspeed_2500_i2c_class_init,
-};
-
 static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
 {
     return bus->irq;
@@ -1669,12 +1633,6 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, const void *data)
     aic->mem_size = 0x1000;
 }
 
-static const TypeInfo aspeed_2600_i2c_info = {
-    .name = TYPE_ASPEED_2600_I2C,
-    .parent = TYPE_ASPEED_I2C,
-    .class_init = aspeed_2600_i2c_class_init,
-};
-
 static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1693,12 +1651,6 @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *data)
     aic->mem_size = 0x10000;
 }
 
-static const TypeInfo aspeed_1030_i2c_info = {
-    .name = TYPE_ASPEED_1030_I2C,
-    .parent = TYPE_ASPEED_I2C,
-    .class_init = aspeed_1030_i2c_class_init,
-};
-
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1720,25 +1672,56 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
     aic->has_dma64 = true;
 }
 
-static const TypeInfo aspeed_2700_i2c_info = {
-    .name = TYPE_ASPEED_2700_I2C,
-    .parent = TYPE_ASPEED_I2C,
-    .class_init = aspeed_2700_i2c_class_init,
+static const TypeInfo aspeed_i2c_types[] = {
+    {
+        .name           = TYPE_ASPEED_I2C_BUS,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(AspeedI2CBus),
+        .class_init     = aspeed_i2c_bus_class_init,
+    },
+    {
+        .name           = TYPE_ASPEED_I2C_BUS_SLAVE,
+        .parent         = TYPE_I2C_SLAVE,
+        .instance_size  = sizeof(AspeedI2CBusSlave),
+        .class_init     = aspeed_i2c_bus_slave_class_init,
+    },
+    {
+        .name          = TYPE_ASPEED_I2C,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_init = aspeed_i2c_instance_init,
+        .instance_size = sizeof(AspeedI2CState),
+        .class_init    = aspeed_i2c_class_init,
+        .class_size = sizeof(AspeedI2CClass),
+        .abstract   = true,
+    },
+    {
+        .name = TYPE_ASPEED_1030_I2C,
+        .parent = TYPE_ASPEED_I2C,
+        .class_init = aspeed_1030_i2c_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2400_I2C,
+        .parent = TYPE_ASPEED_I2C,
+        .class_init = aspeed_2400_i2c_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2500_I2C,
+        .parent = TYPE_ASPEED_I2C,
+        .class_init = aspeed_2500_i2c_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2600_I2C,
+        .parent = TYPE_ASPEED_I2C,
+        .class_init = aspeed_2600_i2c_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_I2C,
+        .parent = TYPE_ASPEED_I2C,
+        .class_init = aspeed_2700_i2c_class_init,
+    }
 };
 
-static void aspeed_i2c_register_types(void)
-{
-    type_register_static(&aspeed_i2c_bus_info);
-    type_register_static(&aspeed_i2c_bus_slave_info);
-    type_register_static(&aspeed_i2c_info);
-    type_register_static(&aspeed_2400_i2c_info);
-    type_register_static(&aspeed_2500_i2c_info);
-    type_register_static(&aspeed_2600_i2c_info);
-    type_register_static(&aspeed_1030_i2c_info);
-    type_register_static(&aspeed_2700_i2c_info);
-}
-
-type_init(aspeed_i2c_register_types)
+DEFINE_TYPES(aspeed_i2c_types)
 
 
 I2CBus *aspeed_i2c_get_bus(AspeedI2CState *s, int busnr)
-- 
2.54.0


