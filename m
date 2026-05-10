Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B6CD37B9
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Za-0005i7-8D; Sun, 10 May 2026 09:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4ZH-0005TI-Eg
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4ZF-0006DR-MH
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELQ2Jz9mBNnU4CG5YzKJ0CYjxCpkx4NH59Wdsf+TZXI=;
 b=Mme7l4ZqnRkRR/XwbFG8dQ7LTobjiewq4Ivr6dtkt+V0CPK7CFZhLwDep21wlgjj4oiS+6
 en0BoZJ87+4f4iFjPOk4g7BTu1nmMThUPpbynqbo7uqObfeli3cl3JvFdWPzvcHiPIR0wW
 BLKwaWJQTCn0/WNdfWBfVgGNkuLWr+E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-EnmFJjusOo-PyXXxuNiv7Q-1; Sun,
 10 May 2026 09:51:35 -0400
X-MC-Unique: EnmFJjusOo-PyXXxuNiv7Q-1
X-Mimecast-MFC-AGG-ID: EnmFJjusOo-PyXXxuNiv7Q_1778421095
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C00B195608B
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:51:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A61171955D84; Sun, 10 May 2026 13:51:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:39 +0400
Subject: [PATCH 42/54] qdev: add qapi_type field to PropertyInfo with
 fallback registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-42-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7090;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Wwh7buzscwJbNXPhO4VYG5a2f+zRJrKude+oVOyfVK0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwEAvoFdG1UfPdEtUCzVgFus4b1r0EzPp+Z
 Zs7ojQSnz+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5dNBD/9/TGqVlGa40JrSFRo4XtAbjjnEIs/jmrNGODy2pEJ6R3HovAwxpryu3yLrF64IrQDLbSP
 zNWkoNl+SJHi5hSrlS6gJn7iViP3whb95Xa2aixmeqWQxWHcElExDUOe62KdOnidWA+AGKETKOo
 F6dMoH+Cg+8QB448/oOGq2eGKkXEncv4q3ihajrE8fxUq76KI+hs7fJvLQzlbpP3d4EiA6bdEvd
 8l1BbKadZGxSlMH80cgHfNYucmLu3rtFZ0+UaQBpPKByA1BkM6q/BU01z3VB/Kaony2hNYOfDjO
 2pvPw3JzRsL0DsW8LLyMELi4mczTW6e2PBqpenPBoeQJlFOijA8Cbhq19lVgP1/5G/ThxtzKTU7
 Ekg1RovhQ2uxjksmx4Y0wU15wyDe9VNjN5ldjfLSPdaOxsEOB01yaYs8wrIcxbhNKPub5GwS/B4
 uyvSi3hL91+JkG+D+yTJakl4s+ibEG+zAFaXOi7fNR2rn6XxtGqCVRY0uVJxwddaoI8DjlmIrSB
 GH9T5ylY2WtHnVkPw1yto7H8iaklm6Pic3O2Trxv8u6dfx9F5uGWsbJZg6j+rZJ3pjGNnBQo39l
 Seas38PCxKasQiGa7eNt3rc8o0vXZrz6lMdTJE2iANuBHubspGVVpl8PUYiC11UxM7KRxgttYuF
 kaF35xZTFQ92tpA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 include/hw/core/qdev-properties.h |  1 +
 hw/core/qdev-properties.c         | 67 +++++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 17543957a6c..441f77a501d 100644
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
index 73539c727b3..eb7caa32557 100644
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
@@ -940,8 +949,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 
     prop = qdev_prop_find(dev, name);
     object_property_set_str(OBJECT(dev), name,
-                            qapi_enum_lookup(prop->info->enum_table, value),
-                            &error_abort);
+        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info), value),
+        &error_abort);
 }
 
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
@@ -1065,18 +1074,33 @@ const PropertyInfo qdev_prop_link = {
     .create = create_link_property,
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
@@ -1098,12 +1122,23 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
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


