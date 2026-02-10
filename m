Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74091E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxg-0006ae-R3; Mon, 09 Feb 2026 21:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxf-0006VC-AY
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:47 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxd-00046a-5I
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692325; x=1802228325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cn71uR3nTCNArFKWH13gLj0SrrAGpnRKcH4TTQALhvw=;
 b=C6wL2jnbaeHrzPKAVm77osNFlSo3qRp0qqTjCB/6x2+NrKymv+cXuZws
 M9hHdCTG6PQW9ReorvxPjGm114PtgbPpx/8r7IHsw5nqqEIgIJLzHMyzE
 7ZDB+t8PpxCgvjAblsJuKnPQVOlFJE1LGxEbNOWo5KFEk4F3M/T+5kKIO
 I5o6Q03kIxdA3+cjov0QurWPAbQil0BlJH+n6ab4kjSk/mbCIfumVye+W
 wL1q/qPzD26ioxDPq44IwLuk68KvTiGHy+cewnjuZRKk8RhWNdlV/HD5e
 /Lfjv/ma6ohkpafK+mMZwVcNn9Vv/J4Qbv2zAHgIzj/Tab5u32Pi663qQ w==;
X-CSE-ConnectionGUID: gt+a51iGT4uSZGEz8OpotA==
X-CSE-MsgGUID: Rw0VesatS0yqp2QHGDTe/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854288"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854288"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:44 -0800
X-CSE-ConnectionGUID: F7BhuGCCQSq1hrHdVoI2Yw==
X-CSE-MsgGUID: gjiw+kI7SyqQLCZQ2c+vJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800527"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:38 -0800
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
Subject: [PATCH v2 06/21] qom/object: add helpers to set/get/clear property
 flags
Date: Tue, 10 Feb 2026 11:23:33 +0800
Message-Id: <20260210032348.987549-7-zhao1.liu@intel.com>
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

Introduce four helper functions to operate object property flags:
object_property_set_flags(), object_property_get_flags(),
object_property_check_flags() and object_property_clear_flags().

Among them, object_property_check_flags() is a complement to
object_property_get_flags(), because sometimes it's needed to check
whether certain flags are set without returning all flags.

This encapsulates and separates the flag management logic, avoiding
direct access to ObjectProperty internals in call sites.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 64 ++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 63 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 30c9f20b1d18..856b12e7289c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1086,6 +1086,70 @@ Object *object_ref(void *obj);
  */
 void object_unref(void *obj);
 
+/**
+ * object_property_set_flags:
+ * @obj: the object.
+ * @name: the name of the property.
+ * @flags: the flags to be set for the property.
+ * @errp: pointer to error object.
+ *
+ * Set the @flags to the property. Existing flags are preserved.
+ *
+ * Returns: %true on success, %false on failure.
+ */
+bool object_property_set_flags(Object *obj, const char *name,
+                               ObjectPropertyFlags flags,
+                               Error **errp);
+
+/**
+ * object_property_get_flags:
+ * @obj: the object.
+ * @name: the name of the property.
+ * @flags: pointer to a location to store the retrieved flags. Must not be
+ *  NULL.
+ * @errp: pointer to error object.
+ *
+ * Get the current flags of the specified property.
+ *
+ * Returns: %true on success, %false on failure.
+ */
+bool object_property_get_flags(Object *obj, const char *name,
+                               ObjectPropertyFlags *flags,
+                               Error **errp);
+
+/**
+ * object_property_check_flags:
+ * @obj: the object.
+ * @name: the name of the property.
+ * @flags: the flags to check for on the property.
+ * @errp: pointer to error object.
+ *
+ * Check whether the specified property has all bits in @flags set.
+ * This is useful for detecting if a property has been explicitly set
+ * by the user (e.g. with %OBJ_PROP_FLAG_USER_SET).
+ *
+ * Returns: 1 if all @flags are set, 0 if not all @flags are set,
+ * or -1 on failure (property not found).
+ */
+int object_property_check_flags(Object *obj, const char *name,
+                                ObjectPropertyFlags flags,
+                                Error **errp);
+
+/**
+ * object_property_clear_flags:
+ * @obj: the object.
+ * @name: the name of the property.
+ * @flags: the flags to be removed from the property.
+ * @errp: pointer to error object
+ *
+ * Clear the @flags from the property. Other flags remain unchanged.
+ *
+ * Returns: %true on success, %false on failure.
+ */
+bool object_property_clear_flags(Object *obj, const char *name,
+                                 ObjectPropertyFlags flags,
+                                 Error **errp);
+
 /**
  * object_property_add_full:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index c1a1e5ff3fbe..49ef99a299b6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1233,6 +1233,69 @@ void object_unref(void *objptr)
     }
 }
 
+bool object_property_set_flags(Object *obj, const char *name,
+                               ObjectPropertyFlags flags,
+                               Error **errp)
+{
+    ObjectProperty *prop = object_property_find_err(obj, name, errp);
+    if (!prop) {
+        return false;
+    }
+
+    prop->flags |= flags;
+    return true;
+}
+
+bool object_property_get_flags(Object *obj, const char *name,
+                               ObjectPropertyFlags *flags,
+                               Error **errp)
+{
+    ObjectProperty *prop;
+
+    if (!flags) {
+        error_setg(errp, "invalid argument: flags is NULL");
+        return false;
+    }
+
+    prop = object_property_find_err(obj, name, errp);
+    if (!prop) {
+        return false;
+    }
+
+    *flags = prop->flags;
+    return true;
+}
+
+int object_property_check_flags(Object *obj, const char *name,
+                                ObjectPropertyFlags flags,
+                                Error **errp)
+{
+    ObjectPropertyFlags prop_flags;
+
+    if (!object_property_get_flags(obj, name, &prop_flags, errp)) {
+        return -1;
+    }
+
+    if ((prop_flags & flags) == flags) {
+        return 1;
+    }
+
+    return 0;
+}
+
+bool object_property_clear_flags(Object *obj, const char *name,
+                                 ObjectPropertyFlags flags,
+                                 Error **errp)
+{
+    ObjectProperty *prop = object_property_find_err(obj, name, errp);
+    if (!prop) {
+        return false;
+    }
+
+    prop->flags &= ~flags;
+    return true;
+}
+
 static inline void object_property_flags_init(ObjectProperty *prop,
                                               ObjectPropertyFlags flags)
 {
-- 
2.34.1


