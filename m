Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A898D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTR8-0001H2-Eb; Tue, 02 Dec 2025 11:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQt-00012B-Na
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:57 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQq-0002E0-UY
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693652; x=1796229652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4L58Pynfj8H1B71aYDQrPJ7Fi/01QINRH+Wk2l/rkZY=;
 b=c3yc6PrzVEhkTa1VxRRgt9T1ygkyh81Fa57GlLgI+hj/kG8M3akVwC/O
 RBe9hBhCcgcuyRKoGc6EJh7Oe6heVN8RSFFYef7QxtX2aP6/hTopT7VDC
 gEW4SwnBNsaSur7BebkeKdccZBMSPPmTj03NMNHdrmB9VPHuAKFJRxld/
 SLyridyrDYuAuBI/o2g93pqeIMCB2ccirZLC9ATRNFgtKfj5RCtD3rGLB
 rijYq6+v7oCq0OmdHX+dqS5kzYkOfEaGeBzT2xBftpnYjGoRgJyJxapVi
 Ik5dgr4YJRcJjMiwhMQo5hU+yKQO/poCEAGZmQJ7d7pmQCql6pG4Avhrc A==;
X-CSE-ConnectionGUID: GRC4OO+gQTmwVAbpWWBSrQ==
X-CSE-MsgGUID: LjNxOSxmR/C8+anyf4P5uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555364"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555364"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:51 -0800
X-CSE-ConnectionGUID: DiCukenSRB2g2dYVQQ0rmQ==
X-CSE-MsgGUID: 8PFY2kKGTcqzrSf0ovPKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751346"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:47 -0800
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
Subject: [RFC 07/10] hw/core/qdev-properties: Allow to mark qdev property as
 deprecated
Date: Wed,  3 Dec 2025 01:04:59 +0800
Message-Id: <20251202170502.3228625-8-zhao1.liu@intel.com>
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

With deprecation flag, make qdev property interfaces to accept
ObjectPropertyFlags, and provide the boolean and uint8_t macro variants
to help on deprecation as examples.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/qdev-properties.c    | 24 +++++++++++++-----------
 include/hw/qdev-properties.h | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 422a486969c8..2cd7de5cec2d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1069,11 +1069,12 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
 
     assert(!prop->info->create);
 
-    op = object_property_add(obj, prop->name, prop->info->type,
-                             field_prop_getter(prop->info),
-                             field_prop_setter(prop->info),
-                             prop->info->release,
-                             (Property *)prop);
+    op = object_property_try_add_full(obj, prop->name, prop->info->type,
+                                      field_prop_getter(prop->info),
+                                      field_prop_setter(prop->info),
+                                      prop->info->release,
+                                      prop->flags, (Property *)prop,
+                                      &error_abort);
 
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -1095,12 +1096,13 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
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
+                                            (Property *)prop);
     }
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 60b81330097d..383f3f54f0ab 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
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
@@ -102,6 +104,13 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                                       \
                 .defval.u  = (_type)_defval)
 
+#define DEFINE_PROP_UNSIGNED_DEPRECATED(_name, _state, _field, \
+                                        _defval, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type,           \
+                .set_default = true,                           \
+                .defval.u    = (_type)_defval,                 \
+                .flags       = OBJECT_PROPERTY_DEPRECATED)
+
 #define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type)
 
@@ -123,6 +132,12 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                         \
                 .defval.u    = (bool)_defval)
 
+#define DEFINE_PROP_BOOL_DEPRECATED(_name, _state, _field, _defval)     \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool,            \
+                .set_default = true,                                    \
+                .defval.u    = (bool)_defval,                           \
+                .flags       = OBJECT_PROPERTY_DEPRECATED)
+
 /**
  * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
  * against corresponding bitmask, rejects the value if it violates.
@@ -189,6 +204,9 @@ extern const PropertyInfo qdev_prop_link;
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
 
+#define DEFINE_PROP_UINT8_DEPRECATED(_n, _s, _f, _d)                       \
+    DEFINE_PROP_UNSIGNED_DEPRECATED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+
 /*
  * Set properties between creation and realization.
  *
-- 
2.34.1


