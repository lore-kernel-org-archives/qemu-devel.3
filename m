Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED05CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYyhU-0000kw-Vh; Mon, 15 Jun 2026 00:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wYygl-0000dK-PN; Mon, 15 Jun 2026 00:12:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wYygf-0002W0-Mk; Mon, 15 Jun 2026 00:12:42 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65F4CEdg067027
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 13:12:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=YyAGKnXvH/LGzt6y5HcFEyLsMb6x8XNx72eLD1BWzf8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1781496739; v=1;
 b=N6xf4pkcFACzXMrl5cvBFnX1t1kV7aMiSLLbdib6BF8Yij1b6e8T+8czgAmKX3/8
 qtvkMvVjPqJ5kKB4wj5PPFZfQwMAU6r2NAzYdlzq/LdzsPKYHgBtus37dr0aCIwl
 KYZW5Fq+9pMeA+4aT3p+LIAGu6VSgwwhSqB04EITMQbD3/HT3FjncszFtUBv0+Os
 SPvDf7lJrslf98PTMFwH2qcKAvrJv9UNS7X34vLCDjU9hQ6BXmNAXyeFC+l6MgKe
 sE00YyiJHEaZThy2xhF4bguGMGdAUMG6gjWoEOWbr9Cr7iDNiJ6ZyqxGqf/3YrUC
 UvnsXCUJKEWtjsXKBlU7bg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 13:11:07 +0900
Subject: [PATCH 2/2] qom: Manage references to embedded child objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=11387;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=NiwcA/iX1K8nXPU3LxiIUkcDgIjjHRx062jRLUc2jD4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5Z+9aLmKOtoG6U7nSe+5qtus9rmdFlWsfDtvlINi71W1
 y4FvSvpKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEjjKYZ/Cr4MXcLpD0QUJGvC
 snr272IVYs57sUhzabqd/I72hQ+fMjL8W/Z00jahTWs+zpeJ3DaXn6cyLaXgc9Lihkm8zo49SXM
 ZAQ==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

Problem
=======

The Rust wrapper for object_ref() is marked unsafe and has:
> The object must not be embedded in another unless the outer
> object is guaranteed to have a longer lifetime.

In other words, object_ref() does not work for embedded objects and
does not keep embedded objects alive. MemoryRegion has its own
memory_region_ref() helper to call object_ref() on its owner for this
reason.

However, this is insufficient to avoid calling object_ref() for all
embedded objects. For example, consider an embedded Device that has a
MemoryRegion. When referencing a MemoryRegion for guest memory access,
QEMU automatically references the owning Device to keep the MemoryRegion
alive. However, that reference is ineffective if the Device itself is
embedded, because object_ref() does not keep the containing storage
alive.

One concrete case is qemu-xhci: XHCIPciState embeds XHCIState as a
child object, and the embedded XHCIState owns the MemoryRegion used for
PCI BAR 0. When memory core references that region, memory_region_ref()
references the embedded XHCIState owner, but that does not keep the
containing XHCIPciState storage alive across runtime unplug.

To avoid such a use-after-free hazard, memory_region_init*() would also
need a SAFETY comment saying "the owner must not be embedded in another
unless its outer object is guaranteed to have a longer lifetime." The
unsafe nature of object_ref() propagates across the codebase and
spreads SAFETY comments across the codebase, and any failure to fulfill
the requirement can cause use-after-free.

Solution
========

Eliminate this whole class of use-after-free hazard by properly managing
references to the "storage" of embedded child objects. Objects now have
a separate storage reference counter for their storage. If an object is
embedded, the reference counter is set to UINT32_MAX. Otherwise, it
represents the number of references to the object's storage - 1.

Object::free is now a union with Object::storage, which holds a
reference to the storage for an embedded object. This forms the
following reference graph:

Parent -> Storage
Parent -> Embedded Child -> Storage

Functions for taking and dropping references to object storage are also
exposed as APIs. This is particularly useful when the storage needs to
be freed asynchronously due to RCU, for example.

A possible concern is that this adds a uint32_t to Object. This is not a
problem in most situations where the host uses 64-bit addressing because
the member is added to a gap needed for alignment. It does increase
memory usage for 32-bit hosts, but proliferation of SAFETY comments to
avoid the overhead is unlikely to be worthwhile.

Note that the Rust wrapper for object_ref() is still marked as unsafe.
This is because an object implemented in C may have pointers whose
lifetimes are not properly extended according to the reference counter.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qom/object.h | 39 +++++++++++++++++++++++++++-------
 qom/object.c         | 60 +++++++++++++++++++++++++++++++++++++++++++++-------
 rust/qom/src/qom.rs  |  8 +++----
 3 files changed, 87 insertions(+), 20 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index c4dcf65dcf7f..b5d656e3758c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -155,8 +155,12 @@ struct Object
 {
     /* private: */
     ObjectClass *class;
-    ObjectFree *free;
+    union {
+        ObjectFree *free;
+        Object *storage;
+    };
     GHashTable *properties;
+    uint32_t storage_ref;
     uint32_t ref;
     Object *parent;
 };
@@ -613,7 +617,7 @@ struct InterfaceClass
  * @klass: The class to instantiate.
  *
  * This function will initialize a new object using heap allocated memory.
- * The returned object has a reference count of 1, and will be freed when
+ * The returned object has a reference count of 1, and will be finalized when
  * the last reference is dropped.
  *
  * Returns: The newly allocated and instantiated object.
@@ -625,7 +629,7 @@ Object *object_new_with_class(ObjectClass *klass);
  * @typename: The name of the type of the object to instantiate.
  *
  * This function will initialize a new object using heap allocated memory.
- * The returned object has a reference count of 1, and will be freed when
+ * The returned object has a reference count of 1, and will be finalized when
  * the last reference is dropped.
  *
  * Returns: The newly allocated and instantiated object.
@@ -641,7 +645,7 @@ Object *object_new(const char *typename);
  * @...: list of property names and values
  *
  * This function will initialize a new object using heap allocated memory.
- * The returned object has a reference count of 1, and will be freed when
+ * The returned object has a reference count of 1, and will be finalized when
  * the last reference is dropped.
  *
  * The @id parameter will be used when registering the object as a
@@ -1120,8 +1124,8 @@ GSList *object_class_get_list_sorted(const char *implements_type,
  * object_ref:
  * @obj: the object
  *
- * Increase the reference count of a object.  A object cannot be freed as long
- * as a reference remains.
+ * Increase the reference count of a object.  A object cannot be finalized as
+ * long as a reference remains.
  * Returns: @obj
  */
 Object *object_ref(void *obj);
@@ -1130,11 +1134,30 @@ Object *object_ref(void *obj);
  * object_unref:
  * @obj: the object
  *
- * Decrease the reference count of a object.  A object cannot be freed as long
- * as a reference remains.
+ * Decrease the reference count of a object.  A object cannot be finalized as
+ * long as a reference remains.
  */
 void object_unref(void *obj);
 
+/**
+ * object_storage_ref:
+ * @obj: the object
+ *
+ * Increase the reference count of a object's storage.  A object cannot be
+ * freed as long as its storage is referenced.
+ * Returns: the object that provides the storage
+ */
+Object *object_storage_ref(void *obj);
+
+/**
+ * object_storage_unref:
+ * @obj: the object
+ *
+ * Decrease the reference count of a object's storage.  A object cannot be
+ * freed as long as its storage is referenced.
+ */
+void object_storage_unref(void *obj);
+
 /**
  * object_property_try_add:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 761eff1337e6..0a2c7ce9710d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -487,7 +487,8 @@ static void object_class_property_init_all(Object *obj)
     }
 }
 
-static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
+static void object_initialize_with_type(Object *obj, size_t size,
+                                        TypeImpl *type, Object *storage)
 {
     type_initialize(type);
 
@@ -496,6 +497,10 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
     g_assert(size >= type->instance_size);
 
     memset(obj, 0, type->instance_size);
+    if (storage) {
+        obj->storage_ref = UINT32_MAX;
+        obj->storage = object_storage_ref(storage);
+    }
     obj->class = type->class;
     object_class_property_init_all(obj);
     obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
@@ -508,7 +513,7 @@ void object_initialize(void *data, size_t size, const char *typename)
 {
     TypeImpl *type = type_get_or_load_by_name(typename, &error_fatal);
 
-    object_initialize_with_type(data, size, type);
+    object_initialize_with_type(data, size, type, NULL);
 }
 
 bool object_initialize_child_with_props(Object *parentobj,
@@ -531,14 +536,15 @@ bool object_initialize_child_with_props(Object *parentobj,
 bool object_initialize_child_with_propsv(Object *parentobj,
                                          const char *propname,
                                          void *childobj, size_t size,
-                                         const char *type,
+                                         const char *typename,
                                          Error **errp, va_list vargs)
 {
+    TypeImpl *type = type_get_or_load_by_name(typename, &error_fatal);
     bool ok = false;
     Object *obj;
     UserCreatable *uc;
 
-    object_initialize(childobj, size, type);
+    object_initialize_with_type(childobj, size, type, parentobj);
     obj = OBJECT(childobj);
 
     if (!object_set_propv(obj, vargs, errp)) {
@@ -667,9 +673,7 @@ static void object_finalize(void *data)
     object_deinit(obj, ti);
 
     g_assert(obj->parent == NULL);
-    if (obj->free) {
-        obj->free(obj);
-    }
+    object_storage_unref(obj);
 }
 
 /* Find the minimum alignment guaranteed by the system malloc. */
@@ -708,7 +712,7 @@ static Object *object_new_with_type(Type type)
         obj_free = qemu_vfree;
     }
 
-    object_initialize_with_type(obj, size, type);
+    object_initialize_with_type(obj, size, type, NULL);
     obj->free = obj_free;
 
     trace_object_new(obj, obj->class->type->name);
@@ -1334,6 +1338,46 @@ void object_unref(void *objptr)
     }
 }
 
+Object *object_storage_ref(void *objptr)
+{
+    Object *obj = OBJECT(objptr);
+    uint32_t ref;
+
+    if (!obj) {
+        return NULL;
+    }
+
+    while (qatomic_read(&obj->storage_ref) == UINT32_MAX) {
+        obj = obj->storage;
+    }
+
+    ref = qatomic_fetch_inc(&obj->storage_ref);
+    /* Assert waaay before the integer overflows */
+    g_assert(ref < INT_MAX);
+    return obj;
+}
+
+void object_storage_unref(void *objptr)
+{
+    Object *obj = OBJECT(objptr);
+    uint32_t ref;
+
+    if (!obj) {
+        return;
+    }
+
+    while (qatomic_read(&obj->storage_ref) == UINT32_MAX) {
+        obj = obj->storage;
+    }
+
+    ref = qatomic_fetch_dec(&obj->storage_ref);
+    g_assert(ref < INT_MAX);
+
+    if (ref == 0 && obj->free) {
+        obj->free(obj);
+    }
+}
+
 ObjectProperty *
 object_property_try_add(Object *obj, const char *name, const char *type,
                         ObjectPropertyAccessor *get,
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index cc00ddcfc988..34f7fff64083 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -809,8 +809,8 @@ impl<T: ObjectType> Owned<T> {
     /// # Safety
     ///
     /// The caller must indeed own a reference to the QOM object.
-    /// The object must not be embedded in another unless the outer
-    /// object is guaranteed to have a longer lifetime.
+    /// The object's implementation must guarantee functionality as long as it
+    /// is referenced.
     ///
     /// A raw pointer obtained via [`Owned::into_raw()`] can always be passed
     /// back to `from_raw()` (assuming the original `Owned` was valid!),
@@ -836,8 +836,8 @@ pub fn into_raw(src: Owned<T>) -> *mut T {
     ///
     /// # Safety
     ///
-    /// The object must not be embedded in another, unless the outer
-    /// object is guaranteed to have a longer lifetime.
+    /// The object's implementation must guarantee functionality as long as it
+    /// is referenced.
     pub unsafe fn from(obj: &T) -> Self {
         unsafe {
             object_ref(obj.as_object_mut_ptr().cast::<c_void>());

-- 
2.54.0


