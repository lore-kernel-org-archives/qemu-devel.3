Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD65FE9462B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxb-0006Nw-C8; Mon, 09 Feb 2026 21:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxa-0006JK-4s
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:42 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxX-00046a-Mo
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692320; x=1802228320;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w3wF2PJ2NmfCFav9tehjq5GSJZrLiro42nNm6SLBWjc=;
 b=WP6ieVZTcBi+ZhccvDbLLThyjBqacuVkjWxZmis+VmJ/iG4AB2Zsx58F
 +KnzrqN8xnQm/JYg100hLs9XkvEud51SxCT0h3Z9zx9EkT4xqI7hV16gL
 zm40qE9vH6LW7bI1KPlhGMP5XAqNcFKfZiCCtyDHsEcS7cV2OWeY9+sXO
 nQdKdiZhQEYNStCtDEQ+Ri4tJBRBVL5NUcWFypsngDXD1nVIXt+RqOeTK
 SU9NLIYCnFNDdGK/QvB3QqMxXXTzedp5c/x5lXJF+WZL0WwUEwFnl65ay
 1Q+z6BvXjAd73Uxzhm720PahisVlIVBMRzNI8FAML3CPOBk/LCOeNmFy5 A==;
X-CSE-ConnectionGUID: hg/zOwx0RhORvWnPNr/+yA==
X-CSE-MsgGUID: zE8iLhVPQYOmChsqCFdw3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854274"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854274"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:38 -0800
X-CSE-ConnectionGUID: A2FODYfKTBuQIL6DWiuJ1Q==
X-CSE-MsgGUID: 3/j2jgLfR66TOH3rhBEdYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800508"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:34 -0800
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
Subject: [PATCH v2 05/21] qom/object: rename object_{class_}property_try_add()
 to object_{class_}property_add_full()
Date: Tue, 10 Feb 2026 11:23:32 +0800
Message-Id: <20260210032348.987549-6-zhao1.liu@intel.com>
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

The suffixes "_try_add" and "_add" typically distinguish functions based
solely on their error-handling behavior.

However, the object_{class_}property_try_add() variants now support the
additional 'flags' argument. Consequently, naming them based only on
error handling no longer accurately reflects the distinction between the
two interface variants.

Rename object_{class_}property_try_add() to
object_{class_}property_add_full() to indicate that these interfaces
offer comprehensive argument support, including the new flags.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 38 ++++++++++++++++++------------------
 qom/object.c         | 46 ++++++++++++++++++++++----------------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 7d8a7be1bad3..30c9f20b1d18 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1087,7 +1087,7 @@ Object *object_ref(void *obj);
 void object_unref(void *obj);
 
 /**
- * object_property_try_add:
+ * object_property_add_full:
  * @obj: the object to add a property to
  * @name: the name of the property.  This can contain any character except for
  *  a forward slash.  In general, you should use hyphens '-' instead of
@@ -1114,17 +1114,17 @@ void object_unref(void *obj);
  * Returns: The #ObjectProperty; this can be used to set the @resolve
  * callback for child and link properties.
  */
-ObjectProperty *object_property_try_add(Object *obj, const char *name,
-                                        const char *type,
-                                        ObjectPropertyAccessor *get,
-                                        ObjectPropertyAccessor *set,
-                                        ObjectPropertyRelease *release,
-                                        ObjectPropertyFlags flags,
-                                        void *opaque, Error **errp);
+ObjectProperty *object_property_add_full(Object *obj, const char *name,
+                                         const char *type,
+                                         ObjectPropertyAccessor *get,
+                                         ObjectPropertyAccessor *set,
+                                         ObjectPropertyRelease *release,
+                                         ObjectPropertyFlags flags,
+                                         void *opaque, Error **errp);
 
 /**
  * object_property_add:
- * Same as object_property_try_add() with @flags hardcoded to 0 and @errp
+ * Same as object_property_add_full() with @flags hardcoded to 0 and @errp
  * hardcoded to &error_abort.
  *
  * @obj: the object to add a property to
@@ -1154,7 +1154,7 @@ ObjectProperty *object_property_add(Object *obj, const char *name,
 void object_property_del(Object *obj, const char *name);
 
 /**
- * object_class_property_try_add:
+ * object_class_property_add_full:
  * @klass: the object class to add a property to
  * @name: the name of the property.  This can contain any character except for
  *  a forward slash.  In general, you should use hyphens '-' instead of
@@ -1181,18 +1181,18 @@ void object_property_del(Object *obj, const char *name);
  * Returns: The #ObjectProperty; this can be used to set the @resolve
  * callback for child and link properties.
  */
-ObjectProperty *object_class_property_try_add(ObjectClass *klass, const char *name,
-                                              const char *type,
-                                              ObjectPropertyAccessor *get,
-                                              ObjectPropertyAccessor *set,
-                                              ObjectPropertyRelease *release,
-                                              ObjectPropertyFlags flags,
-                                              void *opaque, Error **errp);
+ObjectProperty *object_class_property_add_full(ObjectClass *klass, const char *name,
+                                               const char *type,
+                                               ObjectPropertyAccessor *get,
+                                               ObjectPropertyAccessor *set,
+                                               ObjectPropertyRelease *release,
+                                               ObjectPropertyFlags flags,
+                                               void *opaque, Error **errp);
 
 /**
  * object_class_property_add:
- * Same as object_class_property_try_add() with @flags hardcoded to 0 and @errp
- * hardcoded to &error_abort.
+ * Same as object_class_property_add_full() with @flags hardcoded to 0 and
+ * @errp hardcoded to &error_abort.
  *
  * @klass: the object class to add a property to
  * @name: the name of the property.  This can contain any character except for
diff --git a/qom/object.c b/qom/object.c
index 543e42cd6f16..c1a1e5ff3fbe 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1246,12 +1246,12 @@ static inline void object_property_flags_init(ObjectProperty *prop,
 }
 
 ObjectProperty *
-object_property_try_add(Object *obj, const char *name, const char *type,
-                        ObjectPropertyAccessor *get,
-                        ObjectPropertyAccessor *set,
-                        ObjectPropertyRelease *release,
-                        ObjectPropertyFlags flags,
-                        void *opaque, Error **errp)
+object_property_add_full(Object *obj, const char *name, const char *type,
+                         ObjectPropertyAccessor *get,
+                         ObjectPropertyAccessor *set,
+                         ObjectPropertyRelease *release,
+                         ObjectPropertyFlags flags,
+                         void *opaque, Error **errp)
 {
     ObjectProperty *prop;
     size_t name_len = strlen(name);
@@ -1265,8 +1265,8 @@ object_property_try_add(Object *obj, const char *name, const char *type,
         for (i = 0; i < INT16_MAX; ++i) {
             char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
 
-            ret = object_property_try_add(obj, full_name, type, get, set,
-                                          release, flags, opaque, NULL);
+            ret = object_property_add_full(obj, full_name, type, get, set,
+                                           release, flags, opaque, NULL);
             g_free(full_name);
             if (ret) {
                 break;
@@ -1305,19 +1305,19 @@ object_property_add(Object *obj, const char *name, const char *type,
                     ObjectPropertyRelease *release,
                     void *opaque)
 {
-    return object_property_try_add(obj, name, type, get, set, release,
-                                   0, opaque, &error_abort);
+    return object_property_add_full(obj, name, type, get, set, release,
+                                    0, opaque, &error_abort);
 }
 
 ObjectProperty *
-object_class_property_try_add(ObjectClass *klass,
-                              const char *name,
-                              const char *type,
-                              ObjectPropertyAccessor *get,
-                              ObjectPropertyAccessor *set,
-                              ObjectPropertyRelease *release,
-                              ObjectPropertyFlags flags,
-                              void *opaque, Error **errp)
+object_class_property_add_full(ObjectClass *klass,
+                               const char *name,
+                               const char *type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               ObjectPropertyFlags flags,
+                               void *opaque, Error **errp)
 {
     ObjectProperty *prop;
 
@@ -1352,8 +1352,8 @@ object_class_property_add(ObjectClass *klass,
                           ObjectPropertyRelease *release,
                           void *opaque)
 {
-    return object_class_property_try_add(klass, name, type, get, set, release,
-                                         0, opaque, &error_abort);
+    return object_class_property_add_full(klass, name, type, get, set, release,
+                                          0, opaque, &error_abort);
 }
 
 ObjectProperty *object_property_find(Object *obj, const char *name)
@@ -1863,9 +1863,9 @@ object_property_try_add_child(Object *obj, const char *name,
 
     type = g_strdup_printf("child<%s>", object_get_typename(child));
 
-    op = object_property_try_add(obj, name, type, object_get_child_property,
-                                 NULL, object_finalize_child_property, 0,
-                                 child, errp);
+    op = object_property_add_full(obj, name, type, object_get_child_property,
+                                  NULL, object_finalize_child_property, 0,
+                                  child, errp);
     if (!op) {
         return NULL;
     }
-- 
2.34.1


