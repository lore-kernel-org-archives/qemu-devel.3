Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09A606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D8v3B6b/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHkg-00052S-1B; Fri, 06 Nov 2026 06:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkb-0004wL-3a
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkX-0007hx-3t
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793963086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZzEPuDnBmaAmd0oqE88lPKikLxGxptxKINwlTFkB0U=;
 b=D8v3B6b/qb4Yy/ZDqAPLKk3x8lSOf6qVh8/4ReuMYfpMgU2J3Lmidh008yAx7T/qK5zIm/
 cl/0KAwmMr3v95ilnE45xC1g8//HGcfzI8aICd2vZBoa4QkINV/Oc9msT9Bpx7fAKqS43j
 o2O+0D4G7G4BJF/OlEXnDKzRLQT09Xs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-iYJUXcWFN8uPZUyX6dA3VA-1; Fri,
 06 Nov 2026 06:04:45 -0500
X-MC-Unique: iYJUXcWFN8uPZUyX6dA3VA-1
X-Mimecast-MFC-AGG-ID: iYJUXcWFN8uPZUyX6dA3VA_1793963083
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99C6D1800288; Fri,  6 Nov 2026 11:04:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F8EA1800480; Fri,  6 Nov 2026 11:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B314F21E692D; Fri, 06 Nov 2026 12:04:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, mark.caveayland@nutanix.com
Subject: [PATCH 1/8] hw/gpio/pca9552: Convert pin and led properties to class
 properties
Date: Fri,  6 Nov 2026 12:04:33 +0100
Message-ID: <20261106110440.3552588-2-armbru@redhat.com>
In-Reply-To: <20261106110440.3552588-1-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/gpio/pca9552.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 90ccf5170e..65a718ef31 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -557,10 +557,8 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
     s->len = 0;
 }
 
-static void pca955x_initfn(Object *obj)
+static void pca955x_pin_init(PCA955xClass *k)
 {
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-
     assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
     for (int ix = 0; ix < k->pin_count; ix++) {
         char *name;
@@ -568,13 +566,17 @@ static void pca955x_initfn(Object *obj)
         if (k->has_led_support) {
             /* LED variant: expose the LED selector state as led%d. */
             name = g_strdup_printf("led%d", ix);
-            object_property_add(obj, name, "str", &str_type_info,
-                                pca955x_get_led, pca955x_set_led, NULL, NULL);
+            object_class_property_add(OBJECT_CLASS(k), name,
+                                      "str", &str_type_info,
+                                      pca955x_get_led, pca955x_set_led,
+                                      NULL, NULL);
         } else {
             /* GPIO variant: expose the pin logic level as pin%d. */
             name = g_strdup_printf("pin%d", ix);
-            object_property_add(obj, name, "str", &str_type_info,
-                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
+            object_class_property_add(OBJECT_CLASS(k), name,
+                                      "str", &str_type_info,
+                                      pca955x_get_pin, pca955x_set_pin,
+                                      NULL, NULL);
         }
         g_free(name);
     }
@@ -640,6 +642,7 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
     pc->has_led_support = true;
+    pca955x_pin_init(pc);
 }
 
 static void pca95x5_class_init(ObjectClass *oc, const void *data)
@@ -653,13 +656,13 @@ static void pca95x5_class_init(ObjectClass *oc, const void *data)
     pc->max_reg = PCA9535_CONFIG1;
     pc->pin_count = 16;
     pc->has_led_support = false;
+    pca955x_pin_init(pc);
 }
 
 static const TypeInfo pca955x_types[] = {
     {
         .name          = TYPE_PCA955X,
         .parent        = TYPE_I2C_SLAVE,
-        .instance_init = pca955x_initfn,
         .instance_size = sizeof(PCA955xState),
         .class_init    = pca955x_class_init,
         .class_size    = sizeof(PCA955xClass),
-- 
2.55.0


