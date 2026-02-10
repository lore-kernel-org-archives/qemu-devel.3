Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1E7E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxR-00064t-PZ; Mon, 09 Feb 2026 21:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxQ-00063G-Hm
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:32 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxO-00046a-6J
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692310; x=1802228310;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s/JlYnxjXvIrGB6oJxc/D12Kh0TiBPjCTqhRHSqsD3A=;
 b=G4qMGfIZIZp3jfSRQFS98glvRTFdBp8QmCdccNfMjpvF/H6jeWjUpeCX
 aRRrfNOZ0rmU1Ns0vuhoOuXr8djJPFTy6jxR4D8UCJLw9e2Ht4IHkRh+E
 9PMkobyfauf9eQn7MdlZUY2IsXjDLJdNHAuZgL3MLdok0addHZ9hj1Uzq
 EyCQx5R4Dof9/qWpqxZkYehYRxwa+ldXI2qIym4bLJoUxU6UFVXy0IvNO
 yhc/5xiw3lxsBPq3mlT8yHpvXoQBTSsV7L0J0QZU44fX+BD65e0f4DHXy
 23bp51+e8tPuxuPCJoU42iUOjaJuKa3Nlut3cJ8srYk2xsRlHA6W5Qjf1 A==;
X-CSE-ConnectionGUID: +lwqZmhjTFuotFOWmovjEQ==
X-CSE-MsgGUID: zulYyosESueEYcFGPlZ50A==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854249"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854249"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:30 -0800
X-CSE-ConnectionGUID: ayAaCdiVSB2REoX++RGXJw==
X-CSE-MsgGUID: XikgiVXbTQyXeA48f7Z3eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800457"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:24 -0800
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
Subject: [PATCH v2 03/21] qom/object: factor out
 object_class_property_try_add()
Date: Tue, 10 Feb 2026 11:23:30 +0800
Message-Id: <20260210032348.987549-4-zhao1.liu@intel.com>
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

Similar to object_property_try_add(), factor out
object_class_property_try_add().

This allows adding more arguments to the core implementation without
changing the signature of object_class_property_add(), avoiding the
need to modify the extensive number of callers distributed throughout
the code tree.

While at it, add documentation for these functions.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 56 ++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 34 ++++++++++++++++++++-------
 2 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 05706d4d7e3a..060db136988b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1147,6 +1147,62 @@ ObjectProperty *object_property_add(Object *obj, const char *name,
 
 void object_property_del(Object *obj, const char *name);
 
+/**
+ * object_class_property_try_add:
+ * @klass: the object class to add a property to
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
+ * @opaque: an opaque pointer to pass to the callbacks for the property
+ * @errp: pointer to error object
+ *
+ * Returns: The #ObjectProperty; this can be used to set the @resolve
+ * callback for child and link properties.
+ */
+ObjectProperty *object_class_property_try_add(ObjectClass *klass, const char *name,
+                                              const char *type,
+                                              ObjectPropertyAccessor *get,
+                                              ObjectPropertyAccessor *set,
+                                              ObjectPropertyRelease *release,
+                                              void *opaque, Error **errp);
+
+
+/**
+ * object_class_property_add:
+ * Same as object_class_property_try_add() with @errp hardcoded to
+ * &error_abort.
+ *
+ * @klass: the object class to add a property to
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
+ * @opaque: an opaque pointer to pass to the callbacks for the property
+ *
+ * Returns: The #ObjectProperty; this can be used to set the @resolve
+ * callback for child and link properties.
+ */
 ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
                                           const char *type,
                                           ObjectPropertyAccessor *get,
diff --git a/qom/object.c b/qom/object.c
index f5801f4624c8..f101b48154d1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1310,17 +1310,22 @@ object_property_add(Object *obj, const char *name, const char *type,
 }
 
 ObjectProperty *
-object_class_property_add(ObjectClass *klass,
-                          const char *name,
-                          const char *type,
-                          ObjectPropertyAccessor *get,
-                          ObjectPropertyAccessor *set,
-                          ObjectPropertyRelease *release,
-                          void *opaque)
+object_class_property_try_add(ObjectClass *klass,
+                              const char *name,
+                              const char *type,
+                              ObjectPropertyAccessor *get,
+                              ObjectPropertyAccessor *set,
+                              ObjectPropertyRelease *release,
+                              void *opaque, Error **errp)
 {
     ObjectProperty *prop;
 
-    assert(!object_class_property_find(klass, name));
+    if (object_class_property_find(klass, name) != NULL) {
+        error_setg(errp, "attempt to add duplicate property '%s'"
+                   " to object class (type '%s')",
+                   name, object_class_get_name(klass));
+        return NULL;
+    }
 
     prop = g_malloc0(sizeof(*prop));
 
@@ -1337,6 +1342,19 @@ object_class_property_add(ObjectClass *klass,
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
+    return object_class_property_try_add(klass, name, type, get, set, release,
+                                         opaque, &error_abort);
+}
+
 ObjectProperty *object_property_find(Object *obj, const char *name)
 {
     ObjectProperty *prop;
-- 
2.34.1


