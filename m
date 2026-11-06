Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7927606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b21eZYRM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHkh-00053Z-6K; Fri, 06 Nov 2026 06:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkd-0004yT-9P
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkZ-0007jb-AT
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793963090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceA+nKf0GWBYwGs9r7/5ZfoeTuo6AD4DS04okpE8QxE=;
 b=b21eZYRMEnQ9TZGtrMPNkINxrLwJR64h05f4lgE8q/2VOGNEf5kaR+PBHlr+e79TW7b2NA
 rAg/rlKE4w+5FKuudHv38TAKTKX5C5+MAMsUERM2KVBgUxkPhPwN/zQaEnAsmtSMUABKC8
 SvZVVBP3cn1eftow7qCwlhqbAn0Aapg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-RBgQ8u_IO7KYu_jZ9lCkTA-1; Fri,
 06 Nov 2026 06:04:47 -0500
X-MC-Unique: RBgQ8u_IO7KYu_jZ9lCkTA-1
X-Mimecast-MFC-AGG-ID: RBgQ8u_IO7KYu_jZ9lCkTA_1793963086
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D43818005BA; Fri,  6 Nov 2026 11:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F151E1848D40; Fri,  6 Nov 2026 11:04:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4E5721E6884; Fri, 06 Nov 2026 12:04:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, mark.caveayland@nutanix.com
Subject: [PATCH 5/8] hw/gpio/pca9554: Convert pin properties to class
 properties
Date: Fri,  6 Nov 2026 12:04:37 +0100
Message-ID: <20261106110440.3552588-6-armbru@redhat.com>
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
 hw/gpio/pca9554.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 1362b605c2..ed304e4639 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -290,18 +290,18 @@ static void pca9554_reset(DeviceState *dev)
     s->len = 0;
 }
 
-static void pca9554_initfn(Object *obj)
+static void pca9554_pin_init(PCA9554Class *pc)
 {
-    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(obj);
     int pin;
 
     for (pin = 0; pin < pc->pin_count; pin++) {
         char *name;
 
         name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "str", &str_type_info,
-                            pca9554_get_pin, pca9554_set_pin,
-                            NULL, NULL);
+        object_class_property_add(OBJECT_CLASS(pc), name,
+                                  "str", &str_type_info,
+                                  pca9554_get_pin, pca9554_set_pin,
+                                  NULL, NULL);
         g_free(name);
     }
 }
@@ -352,6 +352,7 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
     PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
 
     pc->pin_count = PCA9554_PIN_COUNT;
+    pca9554_pin_init(pc);
 }
 
 static void pca9536_class_init(ObjectClass *klass, const void *data)
@@ -359,13 +360,13 @@ static void pca9536_class_init(ObjectClass *klass, const void *data)
     PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
 
     pc->pin_count = PCA9536_PIN_COUNT;
+    pca9554_pin_init(pc);
 }
 
 static const TypeInfo pca9554_types[] = {
     {
         .name          = TYPE_PCA9554_BASE,
         .parent        = TYPE_I2C_SLAVE,
-        .instance_init = pca9554_initfn,
         .instance_size = sizeof(PCA9554State),
         .class_init    = pca9554_base_class_init,
         .class_size    = sizeof(PCA9554Class),
@@ -378,7 +379,7 @@ static const TypeInfo pca9554_types[] = {
     },
     {
         .name          = TYPE_PCA9536,
-        .parent        = TYPE_PCA9554,
+        .parent        = TYPE_PCA9554_BASE,
         .class_init    = pca9536_class_init,
     }
 };
-- 
2.55.0


