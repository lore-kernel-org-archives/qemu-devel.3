Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E934CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE7h-0005Md-AI; Mon, 15 Jun 2026 16:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7f-0005FK-Na
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7e-00039u-4m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWdGXwIyNbTrVNJtaN8PpZgAfNP2DgFTH5IaS3ncjZ4=;
 b=Dlicx1RKlzh/xWJ+8igxgPonaBVM7qrpBjgV1kkU7buRE99KsTtORJShm0+sJFEoujP8kX
 Mf6XgD/23kGV8kwj1wqL1DHJ0QW4SIwrgjueGS0pkBIdXGwMivQCGJQFMO4TCddHYZ4bLZ
 YGr3sH/BaPgjn8a1LCNrn056i1zOVG8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-Ozp0K4XxO1SsyjOdz_H7bg-1; Mon,
 15 Jun 2026 16:41:26 -0400
X-MC-Unique: Ozp0K4XxO1SsyjOdz_H7bg-1
X-Mimecast-MFC-AGG-ID: Ozp0K4XxO1SsyjOdz_H7bg_1781556085
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D0C519540C8; Mon, 15 Jun 2026 20:41:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D05A1800347; Mon, 15 Jun 2026 20:41:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:08 +0400
Subject: [PATCH v2 42/53] qdev: add qapi_type field to PropertyInfo with
 fallback registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-42-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7075;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ihOMSGfmerocP/uWGqL/8cFJcxxgdAYw+vXojYuEHLo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPYvSeUENp4pcBvMJtX6TffmHl45cOCbaCG
 ZyApxgdOcKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5R5iD/47Tz5fuoxPrJQDBW955QGQs6V6dNKtcAsPbdZ9XLoFlxirTTbdYtcWhcO37Smm+xKEAVy
 Trb01Jklpu50UGqFjl+ptVZGUKbD1IOJnrcHhn6oraJOmcxjB1O99TcNg3El3cy4DOqMn2thGHq
 aF12Z3PQSn6cK1lSJ/nTtIkTPKvleiCY8FIwMsNFG/6ZvzhLPkZPCQRp2pEhzTqSNWnjAWwVhWF
 NsZ0Kh6i6ONZf90tEIUL5iCdWPHIdQhJaAcJms5kEsAGyTpB2uogaVkvg5KowKBgELrQleAyFy3
 garCY6SsILXw0oCI0sRWQZ4XDOzf6yGXkj1oKSopVjRn9UqqRksl3jAS1/sSp05WxUWQ8qYEzUQ
 +OzyUbhlMiox7R24Y2ssBT3WKF187kBiPvo+yfnaJ9LiuDJwqKJueO8taZje2vvmHM/H70FCJSS
 2CzUTVB811DZPpCGNmJB+xABWPC24bIUjbWgCvpDctXesjf5y0OlH+rmryB7MzCOs/W9HOIdrra
 ohzbgrME6sUpsGsPJHZTG0MEbrwGJEhuf85f15sDdYLtixRUnbzwzFwy+WbEVBXtr/uEhPGzS6v
 SlxuIuSUtHoBlcl2lc7O8JfRHFhb3Lo136iO6lD7JzAvKsTkmaRx7UjGeNmPL31UCELkmhuIm0k
 TKNHj8bB0Yp65kQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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
 include/hw/core/qdev-properties.h |  1 +
 hw/core/qdev-properties.c         | 67 +++++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index eba5436e53b..1ea2ba66bb3 100644
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
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 34d7b26a730..b3d5abd5053 100644
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

-- 
2.54.0


