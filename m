Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EE1D11712
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTQv-00012R-L3; Tue, 02 Dec 2025 11:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQe-0000xp-LX
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:43 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQb-00023o-Lz
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693637; x=1796229637;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9Qq56eCeAvjG3rZCrmAk5vALUPK/ZdcwyH/hbgIGIkY=;
 b=jS8zSvZUpp/vCxvPWO9DkOUg1YL9yW87OksffWsLSS9vXRMv3dZFOUcN
 s6RcyNIdXt3QBuMqhRIlPd9JmCFztcYbbCIincXEwXbdQ8CVjQIpu8Yu7
 xqy+ehL1/PQhj2YX/iuF9nYdRttwLBxS7LDuCdWflb0n3AB0R9vJSi1I1
 4+zjTtXh0m6hPEsDEvaQZv0r6mcAcm8rJAH1xCm7tyL268vsFSjcTj/Yy
 XxQj7eIOIsnrBvRVmQ7qdebqlO4jupY5wjJSd9UWtThfta/gJ5iZdcag8
 WL/XaZ8deaLBr+LYnk0dewUopCHk6GsHLJEBMxxvKirxyhx/Ym1U+I8pE Q==;
X-CSE-ConnectionGUID: NSjIap57Q9a+YVIMIiFLBw==
X-CSE-MsgGUID: z4WPZKjzRUu2vKRHi1JAHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555307"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:33 -0800
X-CSE-ConnectionGUID: mMSJ9o9hR1Wx1kxMk6Yr5g==
X-CSE-MsgGUID: YqXAsNY7TZagf3+YYFQVwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751234"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:30 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 02/10] qom: Add basic object property deprecation hint support
Date: Wed,  3 Dec 2025 01:04:54 +0800
Message-Id: <20251202170502.3228625-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202170502.3228625-1-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now the common (but a bit fragmented) way to mark a property deprecated
is to add the warning in its accssors.

But this is pretty inconvenient for such qdev properties, which are
defined via DEFINE_PROP_* macros in the Property array. For qdev
properties, their accessors are provided by pre-defined PropertyInfo, so
that it's possible to modify PropertyInfo for a single "deprecated"
property.

Then it's necessary to introduce property flags to mark some properties
as deprecated, and to check the property flags when set the property,
thereby to print a deprecation warning.

This not only benefits traditional qdev properties but also helps the
deprecation of generic objects.

Note, internal attempt (except the compat case) should not trigger the
deprecation warning but external user should see the deprecation
information. Whether to perform deprecation checks based on property
flags is controlled by the newly added "check" argument in
object_property_try_add_full().

In subsequent work, the "check" option will be enabled for specific
external property setting paths.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 72 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 130 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 3f807a03f5aa..8f4c2f44d835 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -86,6 +86,12 @@ typedef void (ObjectPropertyRelease)(Object *obj,
  */
 typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
 
+typedef enum ObjectPropertyFlags {
+    OBJECT_PROPERTY_NO_FLAGS     =                             0,
+    OBJECT_PROPERTY_DEPRECATED   =                        1 << 0,
+    OBJECT_PROPERTY_FULL_FLAGS   =    OBJECT_PROPERTY_DEPRECATED,
+} ObjectPropertyFlags;
+
 struct ObjectProperty
 {
     char *name;
@@ -98,6 +104,7 @@ struct ObjectProperty
     ObjectPropertyInit *init;
     void *opaque;
     QObject *defval;
+    uint8_t flags;
 };
 
 /**
@@ -1090,6 +1097,41 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
                                         ObjectPropertyRelease *release,
                                         void *opaque, Error **errp);
 
+/**
+ * object_property_try_add_full:
+ *
+ * Same as object_property_try_add() with more arguments (@flags).
+ *
+ * @obj: the object to add a property to
+ * @name: the name of the property.  This can contain any character except for
+ *  a forward slash.  In general, you should use hyphens '-' instead of
+ *  underscores '_' when naming properties.
+ * @type: the type name of the property.  This namespace is pretty loosely
+ *   defined.  Sub namespaces are constructed by using a prefix and then
+ *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
+ *   'link' namespace would be 'link<virtio-net-pci>'.
+ * @get: The getter to be called to read a property.  If this is NULL, then
+ *   the property cannot be read.
+ * @set: the setter to be called to write a property.  If this is NULL,
+ *   then the property cannot be written.
+ * @release: called when the property is removed from the object.  This is
+ *   meant to allow a property to free its opaque upon object
+ *   destruction.  This may be NULL.
+ * @flags: the flags to control property uses.
+ * @opaque: an opaque pointer to pass to the callbacks for the property
+ * @errp: pointer to error object
+ *
+ * Returns: The #ObjectProperty; this can be used to set the @resolve
+ * callback for child and link properties.
+ */
+ObjectProperty *object_property_try_add_full(Object *obj, const char *name,
+                                             const char *type,
+                                             ObjectPropertyAccessor *get,
+                                             ObjectPropertyAccessor *set,
+                                             ObjectPropertyRelease *release,
+                                             ObjectPropertyFlags flags,
+                                             void *opaque, Error **errp);
+
 /**
  * object_property_add:
  * Same as object_property_try_add() with @errp hardcoded to
@@ -1128,6 +1170,15 @@ ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
                                           ObjectPropertyRelease *release,
                                           void *opaque);
 
+ObjectProperty *object_class_property_add_full(ObjectClass *klass,
+                                               const char *name,
+                                               const char *type,
+                                               ObjectPropertyAccessor *get,
+                                               ObjectPropertyAccessor *set,
+                                               ObjectPropertyRelease *release,
+                                               ObjectPropertyFlags flags,
+                                               void *opaque);
+
 /**
  * object_property_set_default_bool:
  * @prop: the property to set
@@ -1469,6 +1520,27 @@ int object_property_get_enum(Object *obj, const char *name,
 bool object_property_set(Object *obj, const char *name, Visitor *v,
                          Error **errp);
 
+/**
+ * object_property_set_full:
+ *
+ * Same as object_property_set() with extra check over property flags
+ * (ObjectPropertyFlags) if @check is true.
+ *
+ * @obj: the object
+ * @name: the name of the property
+ * @v: the visitor that will be used to write the property value.  This should
+ *   be an Input visitor and the data will be first read with @name as the
+ *   name and then written as the property value.
+ * @check: whether to check if the property can be set over property flags.
+ * @errp: returns an error if this function fails
+ *
+ * Writes a property to a object.
+ *
+ * Returns: %true on success, %false on failure.
+ */
+bool object_property_set_full(Object *obj, const char *name,
+                              Visitor *v, bool check, Error **errp);
+
 /**
  * object_property_parse:
  * @obj: the object
diff --git a/qom/object.c b/qom/object.c
index 85d31bb64b36..184afc6730dd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1234,15 +1234,17 @@ void object_unref(void *objptr)
 }
 
 ObjectProperty *
-object_property_try_add(Object *obj, const char *name, const char *type,
-                        ObjectPropertyAccessor *get,
-                        ObjectPropertyAccessor *set,
-                        ObjectPropertyRelease *release,
-                        void *opaque, Error **errp)
+object_property_try_add_full(Object *obj, const char *name, const char *type,
+                             ObjectPropertyAccessor *get,
+                             ObjectPropertyAccessor *set,
+                             ObjectPropertyRelease *release,
+                             ObjectPropertyFlags flags, void *opaque, Error **errp)
 {
     ObjectProperty *prop;
     size_t name_len = strlen(name);
 
+    assert(!flags || !(flags & ~(OBJECT_PROPERTY_FULL_FLAGS)));
+
     if (name_len >= 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
         int i;
         ObjectProperty *ret = NULL;
@@ -1279,11 +1281,24 @@ object_property_try_add(Object *obj, const char *name, const char *type,
     prop->set = set;
     prop->release = release;
     prop->opaque = opaque;
+    prop->flags = flags;
 
     g_hash_table_insert(obj->properties, prop->name, prop);
     return prop;
 }
 
+ObjectProperty *
+object_property_try_add(Object *obj, const char *name, const char *type,
+                        ObjectPropertyAccessor *get,
+                        ObjectPropertyAccessor *set,
+                        ObjectPropertyRelease *release,
+                        void *opaque, Error **errp)
+{
+    return object_property_try_add_full(obj, name, type, get, set, release,
+                                        OBJECT_PROPERTY_NO_FLAGS, opaque,
+                                        errp);
+}
+
 ObjectProperty *
 object_property_add(Object *obj, const char *name, const char *type,
                     ObjectPropertyAccessor *get,
@@ -1296,17 +1311,19 @@ object_property_add(Object *obj, const char *name, const char *type,
 }
 
 ObjectProperty *
-object_class_property_add(ObjectClass *klass,
-                          const char *name,
-                          const char *type,
-                          ObjectPropertyAccessor *get,
-                          ObjectPropertyAccessor *set,
-                          ObjectPropertyRelease *release,
-                          void *opaque)
+object_class_property_add_full(ObjectClass *klass,
+                               const char *name,
+                               const char *type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               ObjectPropertyFlags flags,
+                               void *opaque)
 {
     ObjectProperty *prop;
 
     assert(!object_class_property_find(klass, name));
+    assert(!flags || !(flags & ~(OBJECT_PROPERTY_FULL_FLAGS)));
 
     prop = g_malloc0(sizeof(*prop));
 
@@ -1317,12 +1334,27 @@ object_class_property_add(ObjectClass *klass,
     prop->set = set;
     prop->release = release;
     prop->opaque = opaque;
+    prop->flags = flags;
 
     g_hash_table_insert(klass->properties, prop->name, prop);
 
     return prop;
 }
 
+ObjectProperty *
+object_class_property_add(ObjectClass *klass,
+                          const char *name,
+                          const char *type,
+                          ObjectPropertyAccessor *get,
+                          ObjectPropertyAccessor *set,
+                          ObjectPropertyRelease *release,
+                          void *opaque)
+{
+    return object_class_property_add_full(klass, name, type, get, set,
+                                          release, OBJECT_PROPERTY_NO_FLAGS,
+                                          opaque);
+}
+
 ObjectProperty *object_property_find(Object *obj, const char *name)
 {
     ObjectProperty *prop;
@@ -1432,8 +1464,8 @@ bool object_property_get(Object *obj, const char *name, Visitor *v,
     return !err;
 }
 
-bool object_property_set(Object *obj, const char *name, Visitor *v,
-                         Error **errp)
+bool object_property_set_full(Object *obj, const char *name,
+                              Visitor *v, bool check, Error **errp)
 {
     ERRP_GUARD();
     ObjectProperty *prop = object_property_find_err(obj, name, errp);
@@ -1447,10 +1479,22 @@ bool object_property_set(Object *obj, const char *name, Visitor *v,
                    object_get_typename(obj), name);
         return false;
     }
+
+    if (check && prop->flags & OBJECT_PROPERTY_DEPRECATED) {
+        warn_report("Property '%s.%s' has been deprecated. "
+                    "Please do not use it.", object_get_typename(obj), name);
+    }
+
     prop->set(obj, v, name, prop->opaque, errp);
     return !*errp;
 }
 
+bool object_property_set(Object *obj, const char *name, Visitor *v,
+                         Error **errp)
+{
+    return object_property_set_full(obj, name, v, false, errp);
+}
+
 bool object_property_set_str(Object *obj, const char *name,
                              const char *value, Error **errp)
 {
-- 
2.34.1


