Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC9606ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJYm2qp3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDm-0003VZ-Sc; Mon, 02 Nov 2026 09:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDN-0003JS-Is
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDC-0008VH-0N
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaLGGKF0opda71yqFAD9mxSczRfJiJ5HeDFJIYvuvG8=;
 b=IJYm2qp3tJTOAIVyH0qKmQP0jJehdM64LpC3jEz5bOx4N1k4Md8RODUdVk0KCfEJ02NAZA
 dP53krf9wOCU9VMG3+PWDmrIHmviB/BqHlDfE//8MqO6fcLI1ZlB7KGAJG8qbZCD2bUaeM
 DuVTBOM/b/c2TZ0VKVHqwJxylaCYI0A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-CgFTn6gwO9imXs3Q_vWTsw-1; Mon,
 02 Nov 2026 09:40:34 -0500
X-MC-Unique: CgFTn6gwO9imXs3Q_vWTsw-1
X-Mimecast-MFC-AGG-ID: CgFTn6gwO9imXs3Q_vWTsw_1793630433
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24CFC180A9DA; Mon,  2 Nov 2026 14:40:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D966D30001A2; Mon,  2 Nov 2026 14:40:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 243B121E65E0; Mon, 02 Nov 2026 15:40:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 70/74] qdev: PropertyInfo.enum_table is no longer used, drop
Date: Mon,  2 Nov 2026 15:40:14 +0100
Message-ID: <20261102144018.3212223-71-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Now that all PropertyInfo for enums definitions use .qapi_type, remove
the legacy .enum_table field from PropertyInfo, along with the
qdev_propinfo_enum_lookup() helper.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-53-armbru@redhat.com>
---
 hw/core/qdev-prop-internal.h      |  2 --
 include/hw/core/qdev-properties.h |  1 -
 hw/core/qdev-properties-system.c  | 12 +++++-------
 hw/core/qdev-properties.c         | 17 ++++-------------
 4 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index c190b7b88c..d7b77844fe 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -8,8 +8,6 @@
 #ifndef HW_CORE_QDEV_PROP_INTERNAL_H
 #define HW_CORE_QDEV_PROP_INTERNAL_H
 
-const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info);
-
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp);
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 1ea2ba66bb..a57291a5a1 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -33,7 +33,6 @@ struct Property {
 struct PropertyInfo {
     const char *type;
     const char *description;
-    const QEnumLookup *enum_table;
     const QAPITypeInfo *qapi_type;
     bool realized_set_allowed; /* allow setting property on realized device */
     char *(*print)(Object *obj, const Property *prop);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8924f84806..4d605c2056 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -592,7 +592,7 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
     int value;
 
     if (!visit_type_enum(v, name, &value,
-                         qdev_propinfo_enum_lookup(prop->info), errp)) {
+                         prop->info->qapi_type->lookup, errp)) {
         return;
     }
 
@@ -1081,8 +1081,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &speed,
-                    qdev_propinfo_enum_lookup(prop->info), errp);
+    visit_type_enum(v, name, &speed, prop->info->qapi_type->lookup, errp);
 }
 
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
@@ -1093,7 +1092,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     int speed;
 
     if (!visit_type_enum(v, name, &speed,
-                         qdev_propinfo_enum_lookup(prop->info), errp)) {
+                         prop->info->qapi_type->lookup, errp)) {
         return;
     }
 
@@ -1167,8 +1166,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &width,
-                    qdev_propinfo_enum_lookup(prop->info), errp);
+    visit_type_enum(v, name, &width, prop->info->qapi_type->lookup, errp);
 }
 
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
@@ -1179,7 +1177,7 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
     int width;
 
     if (!visit_type_enum(v, name, &width,
-                         qdev_propinfo_enum_lookup(prop->info), errp)) {
+                         prop->info->qapi_type->lookup, errp)) {
         return;
     }
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index fb11eb1f1c..e2ea894595 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -101,22 +101,13 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
-const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
-{
-    if (info->qapi_type) {
-        assert(info->qapi_type->lookup);
-        return info->qapi_type->lookup;
-    }
-    return info->enum_table;
-}
-
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
+    visit_type_enum(v, name, ptr, prop->info->qapi_type->lookup, errp);
 }
 
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
@@ -125,14 +116,14 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
+    visit_type_enum(v, name, ptr, prop->info->qapi_type->lookup, errp);
 }
 
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop)
 {
     object_property_set_default_str(op,
-        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info),
+        qapi_enum_lookup(prop->info->qapi_type->lookup,
                          prop->defval.i));
 }
 
@@ -970,7 +961,7 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 
     prop = qdev_prop_find(dev, name);
     object_property_set_str(OBJECT(dev), name,
-        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info), value),
+        qapi_enum_lookup(prop->info->qapi_type->lookup, value),
         &error_abort);
 }
 
-- 
2.55.0


