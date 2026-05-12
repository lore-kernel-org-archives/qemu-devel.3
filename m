Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36CACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 12:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMmFn-0000Ox-C2; Tue, 12 May 2026 08:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMmFb-0000M5-8p
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMmFV-00028l-Ff
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778589007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yssNP4Qju6M+L9O9i/N+1SAZ/OA+QE9LNFEMu8/6mU4=;
 b=Kzf5TcQ8kc6kzXxs/aYQs8MS4P3//X2Uu7lKG+O2eIS+29s13SqWUthEYACgFNa0bLQWsO
 Zy8bqmcgvZsVJ7177v2J2RBZhNP4mIj9yNHqiPtjO6ccYYOsq2KO69T3T1lk6xraGfxAn8
 lJpn4qasdFtWtzroUwxUaXZEgc/bo6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-HkeNxPIvPzeLuy30bJMSUQ-1; Tue,
 12 May 2026 08:30:06 -0400
X-MC-Unique: HkeNxPIvPzeLuy30bJMSUQ-1
X-Mimecast-MFC-AGG-ID: HkeNxPIvPzeLuy30bJMSUQ_1778589005
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28DD319560B5; Tue, 12 May 2026 12:30:05 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 281F230001BB; Tue, 12 May 2026 12:30:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 01/10] qom: add trace events for object/property lifecycle
Date: Tue, 12 May 2026 13:29:49 +0100
Message-ID: <20260512122958.788097-2-berrange@redhat.com>
In-Reply-To: <20260512122958.788097-1-berrange@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

This adds tracing around object allocation & finalization, the addition &
deletion of properties, and the addition & deletion of children.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c     | 34 +++++++++++++++++++++++++++-------
 qom/trace-events | 12 ++++++++++--
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f981e27044..9c391071fb 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -603,6 +603,8 @@ static void object_property_del_all(Object *obj)
         object_property_iter_init(&iter, obj);
         while ((prop = object_property_iter_next(&iter)) != NULL) {
             if (g_hash_table_add(done, prop)) {
+                trace_object_property_del(obj, obj->class->type->name,
+                                          prop->name, prop->opaque);
                 if (prop->release) {
                     prop->release(obj, prop->name, prop->opaque);
                     released = true;
@@ -621,10 +623,14 @@ static void object_property_del_child(Object *obj, Object *child)
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
@@ -664,7 +670,7 @@ static void object_finalize(void *data)
 {
     Object *obj = data;
     TypeImpl *ti = obj->class->type;
-
+    trace_object_finalize(obj, obj->class->type->name);
     object_property_del_all(obj);
     object_deinit(obj, ti);
 
@@ -714,6 +720,7 @@ static Object *object_new_with_type(Type type)
     object_initialize_with_type(obj, size, type);
     obj->free = obj_free;
 
+    trace_object_new(obj, obj->class->type->name);
     return obj;
 }
 
@@ -844,8 +851,9 @@ Object *object_dynamic_cast(Object *obj, const char *typename)
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
@@ -935,8 +943,9 @@ ObjectClass *object_class_dynamic_cast_assert(ObjectClass *class,
 {
     ObjectClass *ret;
 
-    trace_object_class_dynamic_cast_assert(class ? class->type->name : "(null)",
-                                           typename, file, line, func);
+    trace_object_class_dynamic_cast_assert(
+        class ? class->type->name : "(null)",
+        typename, file, line, func);
 
 #ifdef CONFIG_QOM_CAST_DEBUG
     int i;
@@ -1220,6 +1229,8 @@ object_property_try_add(Object *obj, const char *name, const char *type,
     prop->release = release;
     prop->opaque = opaque;
 
+    trace_object_property_add(obj, obj->class->type->name,
+                              prop->name, prop->opaque);
     g_hash_table_insert(obj->properties, prop->name, prop);
     return prop;
 }
@@ -1258,6 +1269,8 @@ object_class_property_add(ObjectClass *klass,
     prop->release = release;
     prop->opaque = opaque;
 
+    trace_object_class_property_add(klass->type->name, prop->name,
+                                    prop->opaque);
     g_hash_table_insert(klass->properties, prop->name, prop);
 
     return prop;
@@ -1346,6 +1359,8 @@ void object_property_del(Object *obj, const char *name)
 {
     ObjectProperty *prop = g_hash_table_lookup(obj->properties, name);
 
+    trace_object_property_del(obj, obj->class->type->name, prop->name,
+                              prop->opaque);
     if (prop->release) {
         prop->release(obj, name, prop->opaque);
     }
@@ -1634,8 +1649,11 @@ int object_property_get_enum(Object *obj, const char *name,
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
@@ -1766,6 +1784,8 @@ object_property_try_add_child(Object *obj, const char *name,
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


