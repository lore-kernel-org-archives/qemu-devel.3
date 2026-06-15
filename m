Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AECCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4y-0003oq-13; Mon, 15 Jun 2026 16:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4w-0003hl-O2
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4u-0002IY-MI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MoUKEH3gnZh2AHlqJmyp/DbswGxCG7RiHkCtvRfiz+w=;
 b=cKEPvJaENwDLU1RNRR6cN5hFwyWJZc7BkhqKjg2AZJQt5G+adqCWgSd7a/haaZtS3T0B4W
 uXx7N0xo5+lFukFq9JGbsvdpw9F8Hu9ZA/qyeOutj3Pk4s02z7mKlRTY7aktiIjR68OUEN
 hbBlAJdXQwKL1I9Oef6oBmnVmQSdEQM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-yV5kHtNhPJ-LTUY8hWxIFw-1; Mon,
 15 Jun 2026 16:38:37 -0400
X-MC-Unique: yV5kHtNhPJ-LTUY8hWxIFw-1
X-Mimecast-MFC-AGG-ID: yV5kHtNhPJ-LTUY8hWxIFw_1781555916
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80A251955F03; Mon, 15 Jun 2026 20:38:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D4D4175F; Mon, 15 Jun 2026 20:38:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:36 +0400
Subject: [PATCH v2 10/53] qom: add QAPI-aware property registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-10-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11038;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nTO3Ini0MhAK38pzKixH6YsYP0a1QoyWP8p7LzxxFMU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOUYapivWo69HJo65rE8vn5WSBSnI+/h1tr
 o9CRLEeD1yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5V0YEACtVLtuq/g2FNh/1cCsVCC2OKEh9vU6+hhLPgEMk+7kkJwJ2SbsJAvVfD9TMSy49pYUYks
 b52RuZBzvZIHRJh3Bnb55BpNUKO1sG752FCC92zLfw3dzurHhZVZuTk/OPIrAP1Aq3Ijs4YVlQ9
 KALdbcfO5DHGjlP+1MNkMYkbsnrZe6ITSQQtkh7JTKYI03dFdjSrUvm/idGEIPGXZHMY+3Fr9p8
 SkB1mBSZ2gIJiouJHnyI4fFvOvS2+O8By0QfjNz6O/vn8rCO2LJ8KSNvLinrQBUK20mBk0rIfLe
 woNl+5JksI1PyBiYDSZ+8WJ1tqAgLtmO5jesi7eopJYm4wcIcEXIWswHWarhxnfg5ikoh5St/wi
 nA+OQISpG5VZn+GzRphHJh9al3B/XK7nJdYZjaUi1wB0anDHj+MMUXxJ/csVwOLqO184EsPobm9
 OPWfJSrMCQxf0A2M4TZoTUYrK8Z5RD5u3zVHZhgTw9F+4q2ZicSIun3J2VgoNMINeK6eUYhXxe6
 dZ77wu043Dio6ZBh9Fa78Uee3CpfpaEvBm5xh/dZ5iFLWT+mABlzdbtfLYDsQXCE3S8FyCmStf8
 jROAqGw7xQr0HXMPZvEVLt/Fr2enrnlda1+5o63JIiCH6H7Lr4EHvpKf56XkZO/6mbo15H09Tix
 ypbkaRGG0Hb70zQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add object{_class}_property_add_qapi_enum(), and
object_{_class}_property_add_qapi() functions. Set the qapi_type pointer
on the resulting ObjectProperty.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 105 +++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 131 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 232 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index d96a9afe21d..ebfdbff9a94 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1223,6 +1223,15 @@ void object_property_set_default_bool(ObjectProperty *prop, bool value);
  */
 void object_property_set_default_str(ObjectProperty *prop, const char *value);
 
+/**
+ * object_property_set_default_enum:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_enum(ObjectProperty *prop, int value);
+
 /**
  * object_property_set_default_list:
  * @prop: the property to set
@@ -1915,6 +1924,102 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
 
+/**
+ * struct QapiEnumProp - Descriptor for a QOM property backed by a QAPI enum type
+ *
+ * Binds a QOM object property to a QAPI enum, providing automatic
+ * string<->int conversion through QAPI visitors and optional
+ * default-value initialization during object instance init.
+ *
+ * Use the QAPI_ENUM_PROP() macro to construct instances inline.
+ *
+ * @name: property name exposed on the QOM object
+ * @description: human-readable description (shown in ``-device help``, etc.)
+ * @default_value: initial enum value applied via @set during instance init,
+ *                 or -1 (the QAPI_ENUM_PROP default) to skip initialization
+ * @qapi_type: pointer to the generated QAPITypeInfo for the enum
+ *             (provides the string<->int lookup table)
+ * @get: getter that returns the current enum value as int, or -1 on error
+ * @set: setter that receives the enum value as int; %NULL for read-only props
+ */
+typedef struct QapiEnumProp {
+    const char *name;
+    const char *description;
+    const int default_value;
+    const QAPITypeInfo *qapi_type;
+    int (*get)(Object *, Error **);
+    void (*set)(Object *, int, Error **);
+} QapiEnumProp;
+
+#define QAPI_ENUM_PROP(...) ({                                           \
+    static const QapiEnumProp _prop = {                                  \
+        .default_value = -1, __VA_ARGS__                                 \
+    };                                                                   \
+    &_prop; })
+
+/**
+ * object_property_add_qapi_enum:
+ * @obj: the object to add a property to
+ * @prop: property descriptor
+ *
+ * Add an enum property with QAPI type association.
+ *
+ * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
+ * inline. If .default_value is not set, the property is not initialized
+ * (default_value is -1). Otherwise, the setter is called with
+ * default_value during object instance init.
+ *
+ * Example::
+ *
+ *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+ *       .name = "policy",
+ *       .description = "Set the NUMA policy",
+ *       .default_value = HOST_MEM_POLICY_DEFAULT,
+ *       .qapi_type = &HostMemPolicy_type_info,
+ *       .get = my_get_policy,
+ *       .set = my_set_policy,
+ *   ));
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
+
+ObjectProperty *
+object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumProp *prop);
+
+/**
+ * object_property_add_qapi:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @qapi_type: QAPI type info descriptor
+ * @get: the getter or %NULL if the property is write-only.
+ * @set: the setter or %NULL if the property is read-only
+ * @release: called when the property is removed from the object
+ * @opaque: opaque pointer for get/set/release
+ *
+ * Add a property with a QAPI type association. The property type name
+ * is derived from @qapi_type->name.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_qapi(Object *obj, const char *name,
+                         const QAPITypeInfo *qapi_type,
+                         ObjectPropertyAccessor *get,
+                         ObjectPropertyAccessor *set,
+                         ObjectPropertyRelease *release,
+                         void *opaque);
+
+ObjectProperty *
+object_class_property_add_qapi(ObjectClass *klass,
+                               const char *name,
+                               const QAPITypeInfo *qapi_type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               void *opaque);
+
 /**
  * object_property_add_tm:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index a085e78557f..e5e2f09a0a2 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -24,6 +24,7 @@
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qobject/qdict.h"
+#include "qapi/qapi-type-info.h"
 #include "qobject/qjson.h"
 #include "qemu/id.h"
 #include "qapi/qmp/qerror.h"
@@ -1717,6 +1718,15 @@ void object_property_set_default_str(ObjectProperty *prop, const char *value)
     object_property_set_default(prop, QOBJECT(qstring_from_str(value)));
 }
 
+void object_property_set_default_enum(ObjectProperty *prop, int value)
+{
+    assert(prop && prop->qapi_type && prop->qapi_type->lookup);
+
+    object_property_set_default(prop, QOBJECT(qstring_from_str(
+        qapi_enum_lookup(prop->qapi_type->lookup, value)
+    )));
+}
+
 void object_property_set_default_list(ObjectProperty *prop)
 {
     object_property_set_default(prop, QOBJECT(qlist_new()));
@@ -1775,7 +1785,6 @@ int object_property_get_enum(Object *obj, const char *name,
     char *str;
     int ret;
     ObjectProperty *prop = object_property_find_err(obj, name, errp);
-    EnumProperty *enumprop;
 
     if (prop == NULL) {
         return -1;
@@ -1788,14 +1797,17 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    enumprop = prop->opaque;
-
     str = object_property_get_str(obj, name, errp);
     if (!str) {
         return -1;
     }
 
-    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    if (prop->qapi_type) {
+        ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
+    } else {
+        EnumProperty *enumprop = prop->opaque;
+        ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    }
     g_free(str);
 
     return ret;
@@ -2598,6 +2610,117 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
                                      prop);
 }
 
+static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const QapiEnumProp *prop = opaque;
+    int value;
+    Error *err = NULL;
+
+    value = prop->get(obj, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp);
+}
+
+static void set_qapi_enum(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const QapiEnumProp *prop = opaque;
+    int value;
+
+    if (!visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp)) {
+        return;
+    }
+    prop->set(obj, value, errp);
+}
+
+static void init_qapi_enum(Object *obj, ObjectProperty *prop)
+{
+    const QapiEnumProp *e = prop->opaque;
+
+    if (e->set && e->default_value >= 0) {
+        e->set(obj, e->default_value, &error_abort);
+    }
+}
+
+ObjectProperty *
+object_property_add_qapi_enum(Object *obj, const QapiEnumProp *e)
+{
+    ObjectProperty *prop;
+
+    assert(e && e->qapi_type && e->qapi_type->lookup);
+
+    prop = object_property_add(obj, e->name, e->qapi_type->name,
+                               e->get ? get_qapi_enum : NULL,
+                               e->set ? set_qapi_enum : NULL,
+                               NULL,
+                               (void *)e);
+    prop->qapi_type = e->qapi_type;
+    prop->description = g_strdup(e->description);
+    if (e->default_value >= 0) {
+        prop->init = init_qapi_enum;
+    }
+
+    return prop;
+}
+
+ObjectProperty *
+object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumProp *e)
+{
+    ObjectProperty *prop;
+
+    assert(e && e->qapi_type && e->qapi_type->lookup);
+
+    prop = object_class_property_add(klass, e->name, e->qapi_type->name,
+                                     e->get ? get_qapi_enum : NULL,
+                                     e->set ? set_qapi_enum : NULL,
+                                     NULL,
+                                     (void *)e);
+    prop->qapi_type = e->qapi_type;
+    prop->description = g_strdup(e->description);
+    if (e->default_value >= 0) {
+        prop->init = init_qapi_enum;
+    }
+
+    return prop;
+}
+
+ObjectProperty *
+object_property_add_qapi(Object *obj, const char *name,
+                         const QAPITypeInfo *qapi_type,
+                         ObjectPropertyAccessor *get,
+                         ObjectPropertyAccessor *set,
+                         ObjectPropertyRelease *release,
+                         void *opaque)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add(obj, name, qapi_type->name,
+                               get, set, release, opaque);
+    prop->qapi_type = qapi_type;
+    return prop;
+}
+
+ObjectProperty *
+object_class_property_add_qapi(ObjectClass *klass, const char *name,
+                               const QAPITypeInfo *qapi_type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               void *opaque)
+{
+    ObjectProperty *prop;
+
+    prop = object_class_property_add(klass, name, qapi_type->name,
+                                     get, set, release, opaque);
+    prop->qapi_type = qapi_type;
+    return prop;
+}
+
 typedef struct TMProperty {
     void (*get)(Object *, struct tm *, Error **);
 } TMProperty;

-- 
2.54.0


