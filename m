Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52680C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJ3I-0002QR-B5; Tue, 18 Aug 2026 08:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJ3G-0002Q2-7R
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJ3E-0006yY-DR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787056579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+U56nlsVf4mgf1W0GndZT5RbL9JsSUbkFD/AB+XKJsA=;
 b=JgdnW5SJpkIhDftsgVbK10GUMmQ77z8QsIpjJAU+2mEaMBpg48N50SQXoV4cdom7tmC2lY
 v/SNswX3ysKrtzn5gul4SK9xHMbKL6ImHvB82AJGnciLwn/1ZFi71sh0X2QznU8sYCx0EL
 nHGuNq3akLA0tB2XGSoiQtMh6xJm8OI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-V9bzcMOxNDOj3fu6ZwtZzg-1; Tue,
 18 Aug 2026 08:36:13 -0400
X-MC-Unique: V9bzcMOxNDOj3fu6ZwtZzg-1
X-Mimecast-MFC-AGG-ID: V9bzcMOxNDOj3fu6ZwtZzg_1787056572
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4BBD18004BB; Tue, 18 Aug 2026 12:36:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DAAB7423; Tue, 18 Aug 2026 12:36:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 16:36:38 +0400
Subject: [PATCH v3 59/74] qdev: add qapi_type field to PropertyInfo with
 fallback registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-59-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7097;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rVgb3lPZcyuxYB6Idtqpd6v6VbibarNVb6IbHBysRPw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhFGnww5EazEFc5ax6vFOJIIgDUtPcBpua+cGN
 T+JHb8cqIeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRRpwAKCRDa6OEJdZac
 5QwVD/9wCRNtkIz8Of+lNkz/sv7vveDsRCmHU62tPXRVJKxKwfspKy7t172VhAlOyW0T+LKxv/8
 xPTQDXV5a12zb92OfagUG0l5edstP3hHP10lvQuH7560+qwSKV7kFIhZxb5O7ns/m1KCphw2rkA
 qBwhoWF11rJmyAoXtyxtavnyyc6s24dUstkRKuIe87V1ZzHXbHsH3LB/fR9xfrgAU//Mw1rtcyS
 Jb37exDQTwoqxRbiLCP3YPWePhAkpZpZa+O0RIJPBay8kkK6SIGdaNNHyzLB9EqToyE79I8eewX
 YD06MLon3vXqRgno/Fjutg1eYy0q02kVJGN3VvZYnSPG2U7QFP0eLerFWsOexoza5rUOmQPlCg1
 2KQrH6TeuooPq5z8lDZbzP8OnEOgKOuoCl3BoBP9yuAMczVkVpImo5QbzA5miGb305PXIHfW+hc
 5CWgnKGxoVuh4CBzGg95rerdXQ6g2G4XCEDt3FMWFGkqcp89OJ5VF6FfvHa8uZdZdVflwE8m5JL
 zkVJ4GYcz5lMNAZXO+lElLflIG7MYITCQi+q0XZ7UwIyLQ29YYiDKXDMwq5HaD+DZhGKKHtK//3
 UjTZM50/Sy6t+M6gWzKrHeKn7ysQvMnSah8f3g2rYaMnT8Jzd9TtA0f3CG9Pls7gFtUz1TuGj+L
 igLmk0D82HfzIGw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Add a qapi_type field to PropertyInfo to prepare for the transition
from string-based type metadata to QAPI type-info.

Add a qdev_prop_qapi_type() helper that resolves the QAPI type for a
property from .qapi_type. It will be later extended to cope with array
types.

Update qdev_property_add_static() and qdev_class_add_property() to
prefer object_property_add_qapi() when a QAPI type is available, falling
back to the old object_property_add() for unconverted properties.

Update the shared enum accessor functions to prefer .qapi_type->lookup
over .enum_table via a new qdev_propinfo_enum_lookup() helper.

No PropertyInfo definitions are changed, all .qapi_type fields
default to NULL, so the fallback paths are always taken. This patch
is no-op for now.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c         | 67 +++++++++++++++++++++++++++++----------
 include/hw/core/qdev-properties.h |  1 +
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 34d7b26a7303..b3d5abd5053c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -99,13 +99,22 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
+static const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
+{
+    if (info->qapi_type) {
+        assert(info->qapi_type->lookup);
+        return info->qapi_type->lookup;
+    }
+    return info->enum_table;
+}
+
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
@@ -114,14 +123,14 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop)
 {
     object_property_set_default_str(op,
-        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
+        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info), prop->defval.i));
 }
 
 /* Bit */
@@ -941,8 +950,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 
     prop = qdev_prop_find(dev, name);
     object_property_set_str(OBJECT(dev), name,
-                            qapi_enum_lookup(prop->info->enum_table, value),
-                            &error_abort);
+        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info), value),
+        &error_abort);
 }
 
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
@@ -1143,18 +1152,33 @@ const PropertyInfo qdev_prop_link = {
     .set = set_link,
 };
 
+static const QAPITypeInfo *qdev_prop_qapi_type(const Property *prop)
+{
+    /* this will be later extended to cope with QAPI array properties */
+    return prop->info->qapi_type;
+}
+
 void qdev_property_add_static(DeviceState *dev, const Property *prop)
 {
     Object *obj = OBJECT(dev);
     ObjectProperty *op;
+    const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
 
     assert(!prop->info->create);
 
-    op = object_property_add(obj, prop->name, prop->info->type,
-                             field_prop_getter(prop->info),
-                             field_prop_setter(prop->info),
-                             prop->info->release,
-                             (Property *)prop);
+    if (qapi_type) {
+        op = object_property_add_qapi(obj, prop->name, qapi_type,
+                                      field_prop_getter(prop->info),
+                                      field_prop_setter(prop->info),
+                                      prop->info->release,
+                                      (Property *)prop);
+    } else {
+        op = object_property_add(obj, prop->name, prop->info->type,
+                                 field_prop_getter(prop->info),
+                                 field_prop_setter(prop->info),
+                                 prop->info->release,
+                                 (Property *)prop);
+    }
 
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -1176,12 +1200,23 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
     if (prop->info->create) {
         op = prop->info->create(oc, name, prop);
     } else {
-        op = object_class_property_add(oc,
-                                       name, prop->info->type,
-                                       field_prop_getter(prop->info),
-                                       field_prop_setter(prop->info),
-                                       prop->info->release,
-                                       (Property *)prop);
+        const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
+
+        if (qapi_type) {
+            op = object_class_property_add_qapi(oc,
+                                               name, qapi_type,
+                                               field_prop_getter(prop->info),
+                                               field_prop_setter(prop->info),
+                                               prop->info->release,
+                                               (Property *)prop);
+        } else {
+            op = object_class_property_add(oc,
+                                           name, prop->info->type,
+                                           field_prop_getter(prop->info),
+                                           field_prop_setter(prop->info),
+                                           prop->info->release,
+                                           (Property *)prop);
+        }
     }
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index eba5436e53b1..1ea2ba66bb37 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -34,6 +34,7 @@ struct PropertyInfo {
     const char *type;
     const char *description;
     const QEnumLookup *enum_table;
+    const QAPITypeInfo *qapi_type;
     bool realized_set_allowed; /* allow setting property on realized device */
     char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);

-- 
2.55.0.543.g5ebe2ebe4ea8


