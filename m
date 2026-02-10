Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAD1E9462D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxV-00067w-6D; Mon, 09 Feb 2026 21:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxT-00066P-UV
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:35 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxS-00046a-7T
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692314; x=1802228314;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dBgoK4B2qNgQOD7PnKDbnz8gI+dd9KzHU6YXtY8BNFU=;
 b=f4DiK29jP1p+sodHTw4+a37xfF7cb9He/nx5756zKTklViV2OuYShkxN
 do+RNPXfvzB5lHgRzxyyPoLt0IzPVbTit6HkwKKfG+voE4xtML7mYEElV
 85B+5d9TEg17Z9EPUq64yNO/L/9ql9wF/ljUmIjugoLpRFIqHJgo5goN0
 ZPZxtZj+Xj7ydF/5j5pbMkIrAe0n9KUaHqjqmTSBKawVBNESKo9ay1pMS
 hJStXqE99dgmjSkE3lpUkHNYp5b0O+XmXngaZ+ZOBzpa7OjPOxVmCdsRp
 TaZZRXPYoYjSkxcgWdtwNdbCZgiGah5ATujT0oJTAwt0YLAAAf3wZ+0+d A==;
X-CSE-ConnectionGUID: C/cWd2dKSWu0lm4o5GnFXA==
X-CSE-MsgGUID: O++zCyM2R/qTkdA6bHFtQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854263"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854263"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:34 -0800
X-CSE-ConnectionGUID: ANdU9nG2SqOGNaBxJup4ag==
X-CSE-MsgGUID: Ra8qE3gHTAe9OmdAvdxF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800474"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:29 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: [PATCH v2 04/21] qom/object: add flags argument in
 object_{class_}property_try_add()
Date: Tue, 10 Feb 2026 11:23:31 +0800
Message-Id: <20260210032348.987549-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the flags argument in object_property_try_add() and
object_class_property_try_add(), allowing callers to explicitly specify
the property flags during creation.

This will be helpful to extend qdev property definition to support
marking as deprecated or internal-only.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 21 ++++++++++++++++-----
 qom/object.c         | 19 ++++++++++---------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 060db136988b..7d8a7be1bad3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1103,6 +1103,11 @@ void object_unref(void *obj);
  * @release: called when the property is removed from the object.  This is
  *   meant to allow a property to free its opaque upon object
  *   destruction.  This may be NULL.
+ * @flags: property flags used to control property uses.  The
+ *   OBJ_PROP_FLAG_READ and OBJ_PROP_FLAG_WRITE flags are automatically
+ *   set based on the presence of the @get and @set callbacks.  The value
+ *   passed here is bitwise-ORed with those automatic flags.  Pass 0 if no
+ *   other flags are needed.
  * @opaque: an opaque pointer to pass to the callbacks for the property
  * @errp: pointer to error object
  *
@@ -1114,12 +1119,13 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
                                         ObjectPropertyAccessor *get,
                                         ObjectPropertyAccessor *set,
                                         ObjectPropertyRelease *release,
+                                        ObjectPropertyFlags flags,
                                         void *opaque, Error **errp);
 
 /**
  * object_property_add:
- * Same as object_property_try_add() with @errp hardcoded to
- * &error_abort.
+ * Same as object_property_try_add() with @flags hardcoded to 0 and @errp
+ * hardcoded to &error_abort.
  *
  * @obj: the object to add a property to
  * @name: the name of the property.  This can contain any character except for
@@ -1164,6 +1170,11 @@ void object_property_del(Object *obj, const char *name);
  * @release: called when the property is removed from the object.  This is
  *   meant to allow a property to free its opaque upon object
  *   destruction.  This may be NULL.
+ * @flags: property flags used to control property uses.  The
+ *   OBJ_PROP_FLAG_READ and OBJ_PROP_FLAG_WRITE flags are automatically
+ *   set based on the presence of the @get and @set callbacks.  The value
+ *   passed here is bitwise-ORed with those automatic flags.  Pass 0 if no
+ *   other flags are needed.
  * @opaque: an opaque pointer to pass to the callbacks for the property
  * @errp: pointer to error object
  *
@@ -1175,13 +1186,13 @@ ObjectProperty *object_class_property_try_add(ObjectClass *klass, const char *na
                                               ObjectPropertyAccessor *get,
                                               ObjectPropertyAccessor *set,
                                               ObjectPropertyRelease *release,
+                                              ObjectPropertyFlags flags,
                                               void *opaque, Error **errp);
 
-
 /**
  * object_class_property_add:
- * Same as object_class_property_try_add() with @errp hardcoded to
- * &error_abort.
+ * Same as object_class_property_try_add() with @flags hardcoded to 0 and @errp
+ * hardcoded to &error_abort.
  *
  * @klass: the object class to add a property to
  * @name: the name of the property.  This can contain any character except for
diff --git a/qom/object.c b/qom/object.c
index f101b48154d1..543e42cd6f16 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1233,10 +1233,9 @@ void object_unref(void *objptr)
     }
 }
 
-static inline void object_property_flags_init(ObjectProperty *prop)
+static inline void object_property_flags_init(ObjectProperty *prop,
+                                              ObjectPropertyFlags flags)
 {
-    uint8_t flags = 0;
-
     if (prop->set) {
         flags |= OBJ_PROP_FLAG_WRITE;
     }
@@ -1251,6 +1250,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
                         ObjectPropertyAccessor *get,
                         ObjectPropertyAccessor *set,
                         ObjectPropertyRelease *release,
+                        ObjectPropertyFlags flags,
                         void *opaque, Error **errp)
 {
     ObjectProperty *prop;
@@ -1266,7 +1266,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
             char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
 
             ret = object_property_try_add(obj, full_name, type, get, set,
-                                          release, opaque, NULL);
+                                          release, flags, opaque, NULL);
             g_free(full_name);
             if (ret) {
                 break;
@@ -1292,7 +1292,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
     prop->set = set;
     prop->release = release;
     prop->opaque = opaque;
-    object_property_flags_init(prop);
+    object_property_flags_init(prop, flags);
 
     g_hash_table_insert(obj->properties, prop->name, prop);
     return prop;
@@ -1306,7 +1306,7 @@ object_property_add(Object *obj, const char *name, const char *type,
                     void *opaque)
 {
     return object_property_try_add(obj, name, type, get, set, release,
-                                   opaque, &error_abort);
+                                   0, opaque, &error_abort);
 }
 
 ObjectProperty *
@@ -1316,6 +1316,7 @@ object_class_property_try_add(ObjectClass *klass,
                               ObjectPropertyAccessor *get,
                               ObjectPropertyAccessor *set,
                               ObjectPropertyRelease *release,
+                              ObjectPropertyFlags flags,
                               void *opaque, Error **errp)
 {
     ObjectProperty *prop;
@@ -1336,7 +1337,7 @@ object_class_property_try_add(ObjectClass *klass,
     prop->set = set;
     prop->release = release;
     prop->opaque = opaque;
-    object_property_flags_init(prop);
+    object_property_flags_init(prop, flags);
 
     g_hash_table_insert(klass->properties, prop->name, prop);
     return prop;
@@ -1352,7 +1353,7 @@ object_class_property_add(ObjectClass *klass,
                           void *opaque)
 {
     return object_class_property_try_add(klass, name, type, get, set, release,
-                                         opaque, &error_abort);
+                                         0, opaque, &error_abort);
 }
 
 ObjectProperty *object_property_find(Object *obj, const char *name)
@@ -1863,7 +1864,7 @@ object_property_try_add_child(Object *obj, const char *name,
     type = g_strdup_printf("child<%s>", object_get_typename(child));
 
     op = object_property_try_add(obj, name, type, object_get_child_property,
-                                 NULL, object_finalize_child_property,
+                                 NULL, object_finalize_child_property, 0,
                                  child, errp);
     if (!op) {
         return NULL;
-- 
2.34.1


