Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4A4C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3z-0007KB-Sh; Fri, 04 Sep 2026 15:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3y-0007Ge-3g
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3w-0007u8-1b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJMlo6mxcIkXEJsc7YS6atTu83kQpn233MrgN7DUEYM=;
 b=CysKDijeEZ4quTtf29G8dsREfnujDOYN+lVWOg7r5hB9VtyoPYnta2KqA9JFraxvzeARKW
 3tK+J1fBHvQ3HyQBtkhMYIXdcCvah6ukN+1EzStzw5/Je6tME0vgtbF/1MDejGBLJEbUH9
 XrGrnMVFK80dqIdgFX7icpdWluZmWqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-H2SV4zDDOQiMMZ8nsWBlXg-1; Fri,
 04 Sep 2026 15:58:56 -0400
X-MC-Unique: H2SV4zDDOQiMMZ8nsWBlXg-1
X-Mimecast-MFC-AGG-ID: H2SV4zDDOQiMMZ8nsWBlXg_1788551935
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EF1118F0F0D; Fri,  4 Sep 2026 19:58:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EF5918005B5; Fri,  4 Sep 2026 19:58:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:56 +0400
Subject: [PATCH v4 13/75] qom: add object_{class_}property_add_qapi_enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-13-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7531;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eXvKRfomXt/JyMlK7fno7quZI2V64Ljk8AMzmdqMY/M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJ6OygHndUYtiOTV9b3wF84XSdPF05eVO73
 Zrrf+csAAyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5Se8D/9k8YnPE+hiky0pAi6e2wrL0D14U9SH6UWmOSn8KL+FociFBTSJrpVyx93fKulczG0yNjP
 Ley8RYQlsYyGhbiwEHcV/nfP08Q0864aApezkU1v3nZ6LBb4OHKtsufWSCbF/yqu3UdI8xPMY64
 QgxiPE88D1oh9Ymd30xNKe5M+7n1ZRJQJV+ZFYnqL80E75lxUmnBiWiKjzMB9VgW6jB7VUkoeA7
 ny552FGdFNqmZYppRSsJMdodI1bpoqRp9kvmC06hoYyJSfljflszP7E3WnV3ROBnCudd9bS0r5L
 zvriyZbhoB5K9WnqKHuoPxOleXe5U6xVkmoo1v+EYXybDghXAUE5ZvVVDC6DadlQzdOSw4ZRJ0N
 2PfZ6OFWN8woeKXnSjb2rF+nnbO77O6PqzqwoKc8Y6WWsyVTi0ObKhXRPHNgftFWJxprnbKcGz9
 ju6F3C8BxrLO+dvE3A0P1tox8hyfycxr0iZOZSIQUm7LpEU1CvQ/wleH1lvesmQt0veP7QgAar1
 2iFo6t1J21qP3nqTDYQzRST6W00Cpvx6dl19hZJs0iG5cvrpJwGRZ3SZARHGeD/ZapIXBJ3372c
 fc3svknQt/VOmqeE+FsxsTvcFeM0ZRcVwm1gHthLyZRstPPHqx/opMcJqBt4PSLVSjOkDYWklWv
 CTBiJKJv9Wy/mDA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 73 ++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 083fe646c390..c9a5fe4934d0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1993,6 +1993,79 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
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
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
+
+/**
+ * object_class_property_add_qapi_enum:
+ * @klass: the class object to add a property to
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
+object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumProp *prop);
+
 /**
  * object_property_add_qapi:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 7082bc1c0510..2d3bd2ae327d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1210,7 +1210,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
         return;
     }
 
-    if (data->implements_type && 
+    if (data->implements_type &&
         !object_class_dynamic_cast(k, data->implements_type)) {
         return;
     }
@@ -1776,7 +1776,6 @@ int object_property_get_enum(Object *obj, const char *name,
     char *str;
     int ret;
     ObjectProperty *prop = object_property_find_err(obj, name, errp);
-    EnumProperty *enumprop;
 
     if (prop == NULL) {
         return -1;
@@ -1789,14 +1788,17 @@ int object_property_get_enum(Object *obj, const char *name,
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
@@ -2599,6 +2601,83 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
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
+    prop = object_property_add_qapi(obj, e->name, e->qapi_type,
+                                    e->get ? get_qapi_enum : NULL,
+                                    e->set ? set_qapi_enum : NULL,
+                                    NULL,
+                                    (void *)e);
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
+    prop = object_class_property_add_qapi(klass, e->name, e->qapi_type,
+                                          e->get ? get_qapi_enum : NULL,
+                                          e->set ? set_qapi_enum : NULL,
+                                          NULL,
+                                          (void *)e);
+    prop->description = g_strdup(e->description);
+    if (e->default_value >= 0) {
+        prop->init = init_qapi_enum;
+    }
+
+    return prop;
+}
+
 ObjectProperty *
 object_property_add_qapi(Object *obj, const char *name,
                          const QAPITypeInfo *qapi_type,

-- 
2.55.0.543.g5ebe2ebe4ea8


