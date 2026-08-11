Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DD6C5CFEB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNk-0001fg-VU; Tue, 11 Aug 2026 12:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNX-0000ii-K1
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNV-0000iT-Dm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEchXuHuAgNPgTCPM5H7W00p5UafZJGAqJCqhKt6F/s=;
 b=RQzWWOatELNFZKN6JDOZMUi52+YEHESs3X2QGAqHZedRiyH3npGi6KDZ9ZsV10tvL+eS4b
 1W92rkooZETdITHlbakTz1iJWzOzM7oTe3xg+LL2wXJ5b8w/Ut+gZNbPdAGXCYEivOQvrs
 PRq338LgF1IWooRfshRVU3Gw1N2ULxo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-XzMLyRfLNGyIxDhUeBj1yw-1; Tue,
 11 Aug 2026 12:30:57 -0400
X-MC-Unique: XzMLyRfLNGyIxDhUeBj1yw-1
X-Mimecast-MFC-AGG-ID: XzMLyRfLNGyIxDhUeBj1yw_1786465856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44DC618009C0; Tue, 11 Aug 2026 16:30:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EEB1195DF91; Tue, 11 Aug 2026 16:30:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/83] hw/gpio: pca9552: register types with DEFINE_TYPES()
Date: Tue, 11 Aug 2026 18:28:49 +0200
Message-ID: <20260811162938.1403216-35-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Replace the separate TypeInfo definitions and pca955x_register_types()
registration function with a single type array registered through the
DEFINE_TYPES() macro, to prepare addition of new PCA955x-derived devices.

No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-1-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9552.c | 49 ++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index b13ac9fd9ce5..50e868a6e9a7 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -492,16 +492,6 @@ static void pca955x_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, pca955x_properties);
 }
 
-static const TypeInfo pca955x_info = {
-    .name          = TYPE_PCA955X,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_init = pca955x_initfn,
-    .instance_size = sizeof(PCA955xState),
-    .class_init    = pca955x_class_init,
-    .class_size    = sizeof(PCA955xClass),
-    .abstract      = true,
-};
-
 static void pca9552_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -526,23 +516,26 @@ static void pca9535_class_init(ObjectClass *oc, const void *data)
     pc->has_led_support = false;
 }
 
-static const TypeInfo pca9552_info = {
-    .name          = TYPE_PCA9552,
-    .parent        = TYPE_PCA955X,
-    .class_init    = pca9552_class_init,
-};
-
-static const TypeInfo pca9535_info = {
-    .name          = TYPE_PCA9535,
-    .parent        = TYPE_PCA955X,
-    .class_init    = pca9535_class_init,
+static const TypeInfo pca955x_types[] = {
+    {
+        .name          = TYPE_PCA955X,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_init = pca955x_initfn,
+        .instance_size = sizeof(PCA955xState),
+        .class_init    = pca955x_class_init,
+        .class_size    = sizeof(PCA955xClass),
+        .abstract      = true,
+    },
+    {
+        .name          = TYPE_PCA9552,
+        .parent        = TYPE_PCA955X,
+        .class_init    = pca9552_class_init,
+    },
+    {
+        .name          = TYPE_PCA9535,
+        .parent        = TYPE_PCA955X,
+        .class_init    = pca9535_class_init,
+    }
 };
 
-static void pca955x_register_types(void)
-{
-    type_register_static(&pca955x_info);
-    type_register_static(&pca9552_info);
-    type_register_static(&pca9535_info);
-}
-
-type_init(pca955x_register_types)
+DEFINE_TYPES(pca955x_types)
-- 
2.55.0


