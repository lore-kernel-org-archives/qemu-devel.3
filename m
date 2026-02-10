Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348C3E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxO-00062J-8W; Mon, 09 Feb 2026 21:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxM-00061w-Cj
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:28 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxK-00046a-Ig
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692307; x=1802228307;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3N/SwZLpsJhPnT1hj2JLd5OJ+UF0eDFP2x5yKTQlPEg=;
 b=DCZfstVpGBvqzrv1qmMkUOnqzHdJZS58ttK3ChBT2cfRbMhYCtkv/6D4
 lWW3rWngkT/Eu8OuXzreOaibHW+SFyT7jzoz212xuX0tmT8d5gtgVaSjc
 WlYUU+xVlXhRk5Y4WYSqrM9RF6cubU4tj/0igtj/7aeK8njICo5hLTjNb
 wcHGPp71mZiE7HsN+ek8gKog37tn0+A4dtc0Vj9vl+f1h5572a2AJ37gY
 BOXKS1nHOmQRMFHmjsDzA6yeFOUJdyr2uIL69SVp2PwbJEh4NzwSGQAJn
 GRFkHAi05LAyuaqXJeMFwiGd1jPZSQAWmFgl5QFJzr+lC1eg7+RVs8BlX g==;
X-CSE-ConnectionGUID: cUrpRaNqQaKM2OdUVEd37g==
X-CSE-MsgGUID: l6MibZx7RzyEikh+S5jfFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854237"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854237"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:25 -0800
X-CSE-ConnectionGUID: Kh4wfJ2nRp2esYlklM4GwA==
X-CSE-MsgGUID: zoSKirtdQNSWvFThDGGnHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800442"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:19 -0800
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
Subject: [PATCH v2 02/21] qom/object: cache ObjectPropertyFlags in
 ObjectProperty
Date: Tue, 10 Feb 2026 11:23:29 +0800
Message-Id: <20260210032348.987549-3-zhao1.liu@intel.com>
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

Introduce a 'flags' field in the ObjectProperty structure to store
property-specific behavior modifiers.

Currently, ObjectPropertyFlags (READ/WRITE) are only used for property
creation (e.g., initialize accessors for pointer properties).

By caching these flags directly in ObjectProperty, we can:
1. Preserve the initial access intent (read/write) of the property.
   * the READ/WRITE flags cached in ObjectProperty have no effect for
     now, but they may be useful for cases need write-once, if needed.

2. Reuse existing ObjectPropertyFlags and provide a foundation for
   future flags (e.g., to track if a property was explicitly set by
   external user).

To avoid "incomplete type" error, move ObjectPropertyFlags before
ObjectProperty definition, and polish the comment of ObjectPropertyFlags
to clarify how READ/WRITE flags work for general properties.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 34 +++++++++++++++++++++++++---------
 qom/object.c         | 16 +++++++++++++++-
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 6226b88c1eda..05706d4d7e3a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -87,6 +87,30 @@ typedef void (ObjectPropertyRelease)(Object *obj,
  */
 typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
 
+typedef enum {
+    /*
+     * The property is readable and has a getter.
+     *
+     * For pointer property, this flag (set in object_{class_}property_add_*_ptr())
+     * will automatically add a getter to this property.
+     */
+    OBJ_PROP_FLAG_READ = BIT(0),
+    /*
+     * The property is writable and has a setter.
+     *
+     * For pointer property, this flag (set in object_{class_}property_add_*_ptr())
+     * will automatically add a setter to this property.
+     */
+    OBJ_PROP_FLAG_WRITE = BIT(1),
+    /*
+     * The property is readable and writable, as well as has a getter and a setter.
+     *
+     * For pointer property, this flag (set in object_{class_}property_add_*_ptr())
+     * will automatically add a getter and a setter to this property.
+     */
+    OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
+} ObjectPropertyFlags;
+
 struct ObjectProperty
 {
     char *name;
@@ -99,6 +123,7 @@ struct ObjectProperty
     ObjectPropertyInit *init;
     void *opaque;
     QObject *defval;
+    ObjectPropertyFlags flags;
 };
 
 /**
@@ -1840,15 +1865,6 @@ ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
                             const char *name,
                             void (*get)(Object *, struct tm *, Error **));
 
-typedef enum {
-    /* Automatically add a getter to the property */
-    OBJ_PROP_FLAG_READ = BIT(0),
-    /* Automatically add a setter to the property */
-    OBJ_PROP_FLAG_WRITE = BIT(1),
-    /* Automatically add a getter and a setter to the property */
-    OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
-} ObjectPropertyFlags;
-
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a328e..f5801f4624c8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1233,6 +1233,19 @@ void object_unref(void *objptr)
     }
 }
 
+static inline void object_property_flags_init(ObjectProperty *prop)
+{
+    uint8_t flags = 0;
+
+    if (prop->set) {
+        flags |= OBJ_PROP_FLAG_WRITE;
+    }
+    if (prop->get) {
+        flags |= OBJ_PROP_FLAG_READ;
+    }
+    prop->flags |= flags;
+}
+
 ObjectProperty *
 object_property_try_add(Object *obj, const char *name, const char *type,
                         ObjectPropertyAccessor *get,
@@ -1279,6 +1292,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
     prop->set = set;
     prop->release = release;
     prop->opaque = opaque;
+    object_property_flags_init(prop);
 
     g_hash_table_insert(obj->properties, prop->name, prop);
     return prop;
@@ -1317,9 +1331,9 @@ object_class_property_add(ObjectClass *klass,
     prop->set = set;
     prop->release = release;
     prop->opaque = opaque;
+    object_property_flags_init(prop);
 
     g_hash_table_insert(klass->properties, prop->name, prop);
-
     return prop;
 }
 
-- 
2.34.1


