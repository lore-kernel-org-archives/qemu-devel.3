Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CA5E9462B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyW-0008RD-Lw; Mon, 09 Feb 2026 21:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyF-0007cg-7v
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:24 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyD-00049n-5S
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692361; x=1802228361;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yalC0/aqWFr4iSafee5JGmouLwexJcSFVL+H5tixrSc=;
 b=WXoJ2Mv55mX2hWRf+e+PmNPqNuJfxndLHOK4z3icsfsnTqxOzb9+is5V
 q+i7h+YmSu4B1b4J9kjsxh186EBFH3viSAgXIzPTCDyYuHecwZKsFfA4N
 m3FIXvKuCRYox4DYWUPb0vlqFZ4JdqhLZu43FjM4ZNdbG3RtcoOxa+i60
 9ljkzSwLtpP4WmWdLQ5FpECit+Cg6G4s5V563UtQuGfpXPRTxlS+o2Exe
 o6mvkhsjyI5zpUdZ9bkfA5OhmQe7JObdm6MEo2NwMKXmqXanIcWJAiXGc
 rDR2UAambunowWIb+6UhLi0OVWH/UA5U27/2vnbLP/5wZQmI/eXJFQM+O w==;
X-CSE-ConnectionGUID: 75px56qeRoG6y9FpJo2Pag==
X-CSE-MsgGUID: dUp9vm1/TqGtdHHA9yBudw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659951"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659951"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:20 -0800
X-CSE-ConnectionGUID: 2oZcElVlRq2Nr5RMhkLzSw==
X-CSE-MsgGUID: xM69DtmVS4mG5gcpkoBh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800693"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:16 -0800
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
Subject: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
Date: Tue, 10 Feb 2026 11:23:41 +0800
Message-Id: <20260210032348.987549-15-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Update qdev property interfaces (qdev_property_add_static() and
qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
This enables marking qdev properties with flags such as DEPRECATED or
INTERNAL.

To facilitate this at the definition level, extend the boolean and
uint8_t property macros (as the examples) to accept variable arguments
(VA_ARGS). This allows callers to optionally specify flags in the
property definition.

Example:

DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
                  .flags = OBJECT_PROPERTY_DEPRECATED),

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/qdev-properties.c         | 26 +++++++++++++++-----------
 include/hw/core/qdev-properties.h | 24 ++++++++++++++----------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 696dc5f201d6..91c4010e7dc9 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1071,11 +1071,13 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
 
     assert(!prop->info->create);
 
-    op = object_property_add(obj, prop->name, prop->info->type,
-                             field_prop_getter(prop->info),
-                             field_prop_setter(prop->info),
-                             prop->info->release,
-                             (Property *)prop);
+    op = object_property_add_full(obj, prop->name, prop->info->type,
+                                  field_prop_getter(prop->info),
+                                  field_prop_setter(prop->info),
+                                  prop->info->release,
+                                  prop->flags,
+                                  (Property *)prop,
+                                  &error_abort);
 
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -1097,12 +1099,14 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
     if (prop->info->create) {
         op = prop->info->create(oc, name, prop);
     } else {
-        op = object_class_property_add(oc,
-                                       name, prop->info->type,
-                                       field_prop_getter(prop->info),
-                                       field_prop_setter(prop->info),
-                                       prop->info->release,
-                                       (Property *)prop);
+        op = object_class_property_add_full(oc,
+                                            name, prop->info->type,
+                                            field_prop_getter(prop->info),
+                                            field_prop_setter(prop->info),
+                                            prop->info->release,
+                                            prop->flags,
+                                            (Property *)prop,
+                                            &error_abort);
     }
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65f1..c06de37b1e9d 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -11,6 +11,7 @@
  *     and the field retains whatever value it was given by instance_init).
  * @defval: default value for the property. This is used only if @set_default
  *     is true.
+ * @flags: property flags to control uses.
  */
 struct Property {
     const char   *name;
@@ -27,6 +28,7 @@ struct Property {
     int          arrayfieldsize;
     uint8_t      bitnr;
     bool         set_default;
+    uint8_t      flags;
 };
 
 struct PropertyInfo {
@@ -97,10 +99,11 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                            \
                 .defval.u    = (bool)_defval)
 
-#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) \
-    DEFINE_PROP(_name, _state, _field, _prop, _type,                       \
-                .set_default = true,                                       \
-                .defval.u  = (_type)_defval)
+#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type, ...) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type,                            \
+                .set_default = true,                                            \
+                .defval.u  = (_type)_defval,                                    \
+                ##__VA_ARGS__)
 
 #define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type)
@@ -118,10 +121,11 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                                        \
                 .defval.i = (OnOffAuto)_defval)
 
-#define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
-                .set_default = true,                         \
-                .defval.u    = (bool)_defval)
+#define DEFINE_PROP_BOOL(_name, _state, _field, _defval, ...) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool,  \
+                .set_default = true,                          \
+                .defval.u    = (bool)_defval,                 \
+                ##__VA_ARGS__)
 
 /**
  * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
@@ -168,8 +172,8 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
                 .link_type  = _type)
 
-#define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+#define DEFINE_PROP_UINT8(_n, _s, _f, _d, ...)                  \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t, ##__VA_ARGS__)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
-- 
2.34.1


