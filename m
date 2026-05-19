Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31225CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJxE-00082I-AG; Tue, 19 May 2026 08:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJwt-0007TR-QV
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJwk-00014a-PW
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7C2Z2x5rN4Ack7PYt2FC2o/xoovv41BQKNbjaIQCsWI=;
 b=gOkIwKPf/wlhqqail/lF0A9gGaaqlE2rkUKpA2YEUtbkap2jr5AaA5Jc04MClAHiW1FiRn
 JRxBE8RsV9AZ5UJA3Cp2PNPO84wt1K+zqNHPWF54yoGADn8gFlMrvPz4i/k58PX/KB0xtZ
 HevnLOW2sF/7L7U33wKy7T1CvWS+YVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-NEQpJ_ndNPCY_T6VbljneA-1; Tue,
 19 May 2026 08:53:14 -0400
X-MC-Unique: NEQpJ_ndNPCY_T6VbljneA-1
X-Mimecast-MFC-AGG-ID: NEQpJ_ndNPCY_T6VbljneA_1779195193
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7620B19560A5; Tue, 19 May 2026 12:53:13 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC48418004A3; Tue, 19 May 2026 12:53:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 19/28] qom: add trace events for object/property lifecycle
Date: Tue, 19 May 2026 13:51:43 +0100
Message-ID: <20260519125153.1015315-20-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds tracing around object allocation & finalization, the addition &
deletion of properties, and the addition & deletion of children.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c     | 34 +++++++++++++++++++++++++++-------
 qom/trace-events | 12 ++++++++++--
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index dfdc5c8e42..4a15151c3b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -594,6 +594,8 @@ static void object_property_del_all(Object *obj)
         object_property_iter_init(&iter, obj);
         while ((prop = object_property_iter_next(&iter)) != NULL) {
             if (g_hash_table_add(done, prop)) {
+                trace_object_property_del(obj, obj->class->type->name,
+                                          prop->name, prop->opaque);
                 if (prop->release) {
                     prop->release(obj, prop->name, prop->opaque);
                     released = true;
@@ -612,10 +614,14 @@ static void object_property_del_child(Object *obj, Object *child)
     GHashTableIter iter;
     gpointer key, value;
 
+    trace_object_property_del_child(obj, obj->class->type->name,
+                                    child, child->class->type->name);
     g_hash_table_iter_init(&iter, obj->properties);
     while (g_hash_table_iter_next(&iter, &key, &value)) {
         prop = value;
         if (object_property_is_child(prop) && prop->opaque == child) {
+            trace_object_property_del(obj, obj->class->type->name,
+                                      prop->name, prop->opaque);
             if (prop->release) {
                 prop->release(obj, prop->name, prop->opaque);
                 prop->release = NULL;
@@ -655,7 +661,7 @@ static void object_finalize(void *data)
 {
     Object *obj = data;
     TypeImpl *ti = obj->class->type;
-
+    trace_object_finalize(obj, obj->class->type->name);
     object_property_del_all(obj);
     object_deinit(obj, ti);
 
@@ -705,6 +711,7 @@ static Object *object_new_with_type(Type type)
     object_initialize_with_type(obj, size, type);
     obj->free = obj_free;
 
+    trace_object_new(obj, obj->class->type->name);
     return obj;
 }
 
@@ -835,8 +842,9 @@ Object *object_dynamic_cast(Object *obj, const char *typename)
 Object *object_dynamic_cast_assert(Object *obj, const char *typename,
                                    const char *file, int line, const char *func)
 {
-    trace_object_dynamic_cast_assert(obj ? obj->class->type->name : "(null)",
-                                     typename, file, line, func);
+    trace_object_dynamic_cast_assert(
+        obj, obj ? obj->class->type->name : "(null)",
+        typename, file, line, func);
 
 #ifdef CONFIG_QOM_CAST_DEBUG
     int i;
@@ -926,8 +934,9 @@ ObjectClass *object_class_dynamic_cast_assert(ObjectClass *class,
 {
     ObjectClass *ret;
 
-    trace_object_class_dynamic_cast_assert(class ? class->type->name : "(null)",
-                                           typename, file, line, func);
+    trace_object_class_dynamic_cast_assert(
+        class ? class->type->name : "(null)",
+        typename, file, line, func);
 
 #ifdef CONFIG_QOM_CAST_DEBUG
     int i;
@@ -1211,6 +1220,8 @@ object_property_try_add(Object *obj, const char *name, const char *type,
     prop->release = release;
     prop->opaque = opaque;
 
+    trace_object_property_add(obj, obj->class->type->name,
+                              prop->name, prop->opaque);
     g_hash_table_insert(obj->properties, prop->name, prop);
     return prop;
 }
@@ -1249,6 +1260,8 @@ object_class_property_add(ObjectClass *klass,
     prop->release = release;
     prop->opaque = opaque;
 
+    trace_object_class_property_add(klass->type->name, prop->name,
+                                    prop->opaque);
     g_hash_table_insert(klass->properties, prop->name, prop);
 
     return prop;
@@ -1337,6 +1350,8 @@ void object_property_del(Object *obj, const char *name)
 {
     ObjectProperty *prop = g_hash_table_lookup(obj->properties, name);
 
+    trace_object_property_del(obj, obj->class->type->name, prop->name,
+                              prop->opaque);
     if (prop->release) {
         prop->release(obj, name, prop->opaque);
     }
@@ -1625,8 +1640,11 @@ int object_property_get_enum(Object *obj, const char *name,
 bool object_property_parse(Object *obj, const char *name,
                            const char *string, Error **errp)
 {
-    Visitor *v = string_input_visitor_new(string);
-    bool ok = object_property_set(obj, name, v, errp);
+    Visitor *v;
+    bool ok;
+    trace_object_property_parse(obj, obj->class->type->name, name, string);
+    v = string_input_visitor_new(string);
+    ok = object_property_set(obj, name, v, errp);
 
     visit_free(v);
     return ok;
@@ -1757,6 +1775,8 @@ object_property_try_add_child(Object *obj, const char *name,
     g_autofree char *type = NULL;
     ObjectProperty *op;
 
+    trace_object_property_add_child(obj, obj->class->type->name, name,
+                                    child, child->class->type->name);
     assert(!child->parent);
 
     type = g_strdup_printf("child<%s>", object_get_typename(child));
diff --git a/qom/trace-events b/qom/trace-events
index b2e9f4a712..44c63e72af 100644
--- a/qom/trace-events
+++ b/qom/trace-events
@@ -1,5 +1,13 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # object.c
-object_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
-object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
+object_dynamic_cast_assert(void *obj, const char *type, const char *target, const char *file, int line, const char *func) "obj=%p type=%s->%s (%s:%d:%s)"
+object_finalize(void *obj, const char *type) "obj=%p type=%s"
+object_new(void *obj, const char *type) "obj=%p type=%s"
+object_property_add(void *obj, const char *type, const char *name, void *value) "obj=%p type=%s name=%s value=%p"
+object_property_add_child(void *obj, const char *type, const char *name, void *child, const char *childtype) "obj=%p type=%s name=%s child=%p child-type=%s"
+object_property_del(void *obj, const char *type, const char *name, void *value) "obj=%p type=%s name=%s value=%p"
+object_property_del_child(void *obj, const char *type, void *child, const char *childtype) "obj=%p type=%s child=%p child-type=%s"
+object_property_parse(void *obj, const char *type, const char *name, const char *value) "obj=%p type=%s prop=%s value=%s"
+object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "type=%s->%s (%s:%d:%s)"
+object_class_property_add(const char *type, const char *name, void *value) "type=%s name=%s value=%p"
-- 
2.54.0


