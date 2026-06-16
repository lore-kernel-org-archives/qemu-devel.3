Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3458CCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW9P-0002B2-MH; Tue, 16 Jun 2026 11:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9N-00028F-Ia
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9L-0003oo-4O
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781625386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bo7jn8LqtJ2JkPL2e0g5qPHWAc2w+sVwMteBw+aQUSA=;
 b=hjtRNStJRLruv4Ubk8nv84uc54J3LwvCI1g8eggbw8XGllTaZeP597HpuBUydBbOVV8R06
 ZBnTC6haOzY/pWX6NHV68XVao9ifZc/JfHhpDQOCQcuAWFRZfzn3Wf5t/0+ucfYDCLWgpw
 4YHwa0pjG62pkKeFhrNrMKjjaJUF1EI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-ugmAhsAQN9mgaEJU8abeSQ-1; Tue,
 16 Jun 2026 11:56:22 -0400
X-MC-Unique: ugmAhsAQN9mgaEJU8abeSQ-1
X-Mimecast-MFC-AGG-ID: ugmAhsAQN9mgaEJU8abeSQ_1781625381
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 104B518004A9; Tue, 16 Jun 2026 15:56:21 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7191D195419E; Tue, 16 Jun 2026 15:56:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 3/7] qom: deprecate use of instance properties
Date: Tue, 16 Jun 2026 16:55:50 +0100
Message-ID: <20260616155554.264412-4-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-1-berrange@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The concept of class properties was introduced over 10 years ago.
While there is significant use of class properties, there is a
long way to go before any conversion is complete and new uses are
often introduced as it is not obvious that class properties are
preferred.

The downsides of instances properties are:

 * Increased memory usage as the property info is duplicated
   across every instance.

 * Introspection side effects, since instances need to be created
   to be introspected and this can have unexpected side effects
   if code is not expecting these throwaway instances to be
   around.

 * Non-introspectable designs, if properties are conditionally
   registered against instances, those props may not be visible
   when a dummy instances is created for introspection.

This deprecates the use of instance properties for all regular
scalar properties. ie strings, integers, enums, etc.

It does not deprecate instance properties used for setting up
the QOM composition tree child relationships, nor the link or
alias properties.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 70 +++++++++++++++++++++++++++++++++++++-------
 qom/object.c         | 28 ++++++++++++++++++
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index dd708b1136..e9ce15d595 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1175,6 +1175,10 @@ void object_unref(void *obj);
  * @opaque: an opaque pointer to pass to the callbacks for the property
  * @errp: pointer to error object
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add()
+ * function and not registered against instances.
+ *
  * Returns: The #ObjectProperty; this can be used to set the @resolve
  * callback for child and link properties.
  */
@@ -1183,7 +1187,8 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
                                         ObjectPropertyAccessor *get,
                                         ObjectPropertyAccessor *set,
                                         ObjectPropertyRelease *release,
-                                        void *opaque, Error **errp);
+                                        void *opaque, Error **errp)
+    QEMU_DEPRECATED;
 
 /**
  * object_property_add:
@@ -1206,13 +1211,18 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
  *   meant to allow a property to free its opaque upon object
  *   destruction.  This may be NULL.
  * @opaque: an opaque pointer to pass to the callbacks for the property
+ *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add()
+ * function and not registered against instances.
  */
 ObjectProperty *object_property_add(Object *obj, const char *name,
                                     const char *type,
                                     ObjectPropertyAccessor *get,
                                     ObjectPropertyAccessor *set,
                                     ObjectPropertyRelease *release,
-                                    void *opaque);
+                                    void *opaque)
+    QEMU_DEPRECATED;
 
 void object_property_del(Object *obj, const char *name);
 
@@ -1873,11 +1883,16 @@ Object *object_resolve_and_typecheck(const char *path, const char *name,
  * Add a string property using getters/setters.  This function will add a
  * property of type 'string'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_str()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_str(Object *obj, const char *name,
                              char *(*get)(Object *, Error **),
-                             void (*set)(Object *, const char *, Error **));
+                             void (*set)(Object *, const char *, Error **))
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_str(ObjectClass *klass,
                                    const char *name,
@@ -1895,11 +1910,16 @@ ObjectProperty *object_class_property_add_str(ObjectClass *klass,
  * Add a bool property using getters/setters.  This function will add a
  * property of type 'bool'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_bool()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_bool(Object *obj, const char *name,
                               bool (*get)(Object *, Error **),
-                              void (*set)(Object *, bool, Error **));
+                              void (*set)(Object *, bool, Error **))
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
                                     const char *name,
@@ -1918,13 +1938,18 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
  * Add an enum property using getters/setters.  This function will add a
  * property of type '@typename'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_enum()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_enum(Object *obj, const char *name,
                               const char *typename,
                               const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
-                              void (*set)(Object *, int, Error **));
+                              void (*set)(Object *, int, Error **))
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
@@ -1942,10 +1967,15 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
  * Add a read-only struct tm valued property using a getter function.
  * This function will add a property of type 'struct tm'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_tm()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_tm(Object *obj, const char *name,
-                            void (*get)(Object *, struct tm *, Error **));
+                            void (*get)(Object *, struct tm *, Error **))
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
                             const char *name,
@@ -1970,11 +2000,16 @@ typedef enum {
  * Add an integer property in memory.  This function will add a
  * property of type 'uint8'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_uint8_ptr()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
-                                              ObjectPropertyFlags flags);
+                                              ObjectPropertyFlags flags)
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
@@ -1991,11 +2026,16 @@ ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
  * Add an integer property in memory.  This function will add a
  * property of type 'uint16'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_uint16_ptr()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
-                                    ObjectPropertyFlags flags);
+                                    ObjectPropertyFlags flags)
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
@@ -2012,11 +2052,16 @@ ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
  * Add an integer property in memory.  This function will add a
  * property of type 'uint32'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_uint32_ptr()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
-                                    ObjectPropertyFlags flags);
+                                    ObjectPropertyFlags flags)
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
@@ -2033,11 +2078,16 @@ ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
  * Add an integer property in memory.  This function will add a
  * property of type 'uint64'.
  *
+ * Use of this function is now deprecated. All properties must be
+ * registered against the class, using the object_class_property_add_uint64_ptr()
+ * function and not registered against instances.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
-                                    ObjectPropertyFlags flags);
+                                    ObjectPropertyFlags flags)
+    QEMU_DEPRECATED;
 
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
diff --git a/qom/object.c b/qom/object.c
index 33b2801ee4..415d5c5291 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1362,8 +1362,10 @@ object_property_try_add(Object *obj, const char *name, const char *type,
         for (i = 0; i < INT16_MAX; ++i) {
             char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
 
+            QEMU_DEPRECATIONS_OFF;
             ret = object_property_try_add(obj, full_name, type, get, set,
                                           release, opaque, NULL);
+            QEMU_DEPRECATIONS_ON;
             g_free(full_name);
             if (ret) {
                 break;
@@ -1403,8 +1405,10 @@ object_property_add(Object *obj, const char *name, const char *type,
                     ObjectPropertyRelease *release,
                     void *opaque)
 {
+    QEMU_DEPRECATIONS_OFF;
     return object_property_try_add(obj, name, type, get, set, release,
                                    opaque, &error_abort);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -1951,9 +1955,11 @@ object_property_try_add_child(Object *obj, const char *name,
 
     type = g_strdup_printf("child<%s>", object_get_typename(child));
 
+    QEMU_DEPRECATIONS_OFF;
     op = object_property_try_add(obj, name, type, object_get_child_property,
                                  NULL, object_finalize_child_property,
                                  child, errp);
+    QEMU_DEPRECATIONS_ON;
     if (!op) {
         return NULL;
     }
@@ -1967,7 +1973,9 @@ ObjectProperty *
 object_property_add_child(Object *obj, const char *name,
                           Object *child)
 {
+    QEMU_DEPRECATIONS_OFF;
     return object_property_try_add_child(obj, name, child, &error_abort);
+    QEMU_DEPRECATIONS_ON;
 }
 
 void object_property_allow_set_link(const Object *obj, const char *name,
@@ -2145,11 +2153,13 @@ object_add_link_prop(Object *obj, const char *name,
 
     full_type = g_strdup_printf("link<%s>", type);
 
+    QEMU_DEPRECATIONS_OFF;
     op = object_property_add(obj, name, full_type,
                              object_get_link_property,
                              check ? object_set_link_property : NULL,
                              object_release_link_property,
                              prop);
+    QEMU_DEPRECATIONS_ON;
     op->resolve = object_resolve_link_property;
     return op;
 }
@@ -2442,11 +2452,13 @@ object_property_add_str(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, "string",
                                get ? property_get_str : NULL,
                                set ? property_set_str : NULL,
                                property_release_data,
                                prop);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2512,11 +2524,13 @@ object_property_add_bool(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, "bool",
                                get ? property_get_bool : NULL,
                                set ? property_set_bool : NULL,
                                property_release_data,
                                prop);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2577,11 +2591,13 @@ object_property_add_enum(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, typename,
                                get ? property_get_enum : NULL,
                                set ? property_set_enum : NULL,
                                property_release_data,
                                prop);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2655,10 +2671,12 @@ object_property_add_tm(Object *obj, const char *name,
 
     prop->get = get;
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, "struct tm",
                                get ? property_get_tm : NULL, NULL,
                                property_release_data,
                                prop);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2775,8 +2793,10 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
         setter = property_set_uint8_ptr;
     }
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, "uint8",
                                getter, setter, NULL, (void *)v);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2815,8 +2835,10 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
         setter = property_set_uint16_ptr;
     }
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, "uint16",
                                getter, setter, NULL, (void *)v);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2855,8 +2877,10 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
         setter = property_set_uint32_ptr;
     }
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, "uint32",
                                getter, setter, NULL, (void *)v);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2895,8 +2919,10 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
         setter = property_set_uint64_ptr;
     }
 
+    QEMU_DEPRECATIONS_OFF;
     return object_property_add(obj, name, "uint64",
                                getter, setter, NULL, (void *)v);
+    QEMU_DEPRECATIONS_ON;
 }
 
 ObjectProperty *
@@ -2983,11 +3009,13 @@ object_property_add_alias(Object *obj, const char *name,
     prop->target_obj = target_obj;
     prop->target_name = g_strdup(target_name);
 
+    QEMU_DEPRECATIONS_OFF;
     op = object_property_add(obj, name, prop_type,
                              property_get_alias,
                              property_set_alias,
                              property_release_alias,
                              prop);
+    QEMU_DEPRECATIONS_ON;
     op->resolve = property_resolve_alias;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
-- 
2.54.0


