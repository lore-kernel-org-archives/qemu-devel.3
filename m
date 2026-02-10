Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24681E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxw-0007Ax-I8; Mon, 09 Feb 2026 21:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxs-00071G-PF
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:01 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxr-00049n-3T
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692339; x=1802228339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FxBUkSvbGuB1vBs3AIUiH7+IqEBydGey1Vi/I25uNSQ=;
 b=RKky6QJDefmPLZ7thBp3fxMwI+G4gUWFOESdZBzmjs9VME1nmBYscOji
 +T2uHKYA5DXeBFlgMEOwXAR1cTSazXMXTLeRsCMrDvXKWG3uj7y3xBEHa
 4nBX7Py/fZ832K5hkGRyavh7gtEoUyb/U0ySdEmdjMOBlX/3blAvNQV4g
 N90mJlop23/Qdf8v9Nx9+d1sj9SXhdiLtuBZc8eTPGr+WQfEXE+mFSgTj
 BWhvmP5dFucS1fxdGk2D4eCOLqAVLLL14qecETSD3KrRPS63PMsJeLyGB
 5dJjg2FJ9O1G8czR5irOTmILWQZAFiP2EBxfj6fr9jqMkS25ZvGhW6VuX w==;
X-CSE-ConnectionGUID: BlND7lESTjqhScfVeWapag==
X-CSE-MsgGUID: GeT9GQeCQIuhocU3J7VDfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659892"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659892"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:57 -0800
X-CSE-ConnectionGUID: c5czF4V8Qa6Xe0gLHud71Q==
X-CSE-MsgGUID: 5FPuJl0BQQy1SPmrXlAIPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800584"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:53 -0800
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
Subject: [PATCH v2 09/21] qom/object: mark global property set from CLI as
 USER_SET
Date: Tue, 10 Feb 2026 11:23:36 +0800
Message-Id: <20260210032348.987549-10-zhao1.liu@intel.com>
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

There are now two major categories of global properties:

One category consists of true global properties collected in
global_props(), sourced from CLI options like `-global` and CPU features
like `-cpu`.

The other category comprises compat properties derived from
object_compat_props[]. Within this, object_compat_props[0] and
object_compat_props[1] represent compat properties for accelerators and
machines, respectively. Meanwhile, object_compat_props[2] collects sugar
properties from the CLI.

Although sugar properties are also applied for legacy machine options
(MachineClass::default_machine_opts), considerring those hardcoded
defaults simulate CLI arguments, so treating them as USER_SET is
acceptable as they emulate user behavior.

Therefore, among all global properties, only those in global_props() and
object_compat_props[2] originate from external users. Consequently, when
applying global properties via object_apply_global_props(), these two
categories of user-provided properties are marked as USER_SET by passing
"from_user=true" to object_property_parse().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/qdev-properties.c | 2 +-
 include/qom/object.h      | 2 +-
 qom/object.c              | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c96ccfb26353..696dc5f201d6 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1017,7 +1017,7 @@ int qdev_prop_check_globals(void)
 
 void qdev_prop_set_globals(DeviceState *dev)
 {
-    object_apply_global_props(OBJECT(dev), global_props(),
+    object_apply_global_props(OBJECT(dev), global_props(), true,
                               dev->hotplugged ? NULL : &error_fatal);
 }
 
diff --git a/include/qom/object.h b/include/qom/object.h
index c78e1c03a106..b621803f61bb 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -751,7 +751,7 @@ Object *object_new_with_propv(const char *typename,
                               va_list vargs);
 
 bool object_apply_global_props(Object *obj, const GPtrArray *props,
-                               Error **errp);
+                               bool from_user, Error **errp);
 void object_set_machine_compat_props(GPtrArray *compat_props);
 void object_set_accelerator_compat_props(GPtrArray *compat_props);
 void object_register_sugar_prop(const char *driver, const char *prop,
diff --git a/qom/object.c b/qom/object.c
index 7140e3f629aa..4ead0befb351 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -441,7 +441,7 @@ static void object_post_init_with_type(Object *obj, TypeImpl *ti)
 }
 
 bool object_apply_global_props(Object *obj, const GPtrArray *props,
-                               Error **errp)
+                               bool from_user, Error **errp)
 {
     int i;
 
@@ -460,7 +460,8 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
             continue;
         }
         p->used = true;
-        if (!object_property_parse(obj, p->property, p->value, false, &err)) {
+        if (!object_property_parse(obj, p->property, p->value,
+                                   from_user, &err)) {
             error_prepend(&err, "can't apply global %s.%s=%s: ",
                           p->driver, p->property, p->value);
             /*
@@ -536,6 +537,7 @@ void object_apply_compat_props(Object *obj)
 
     for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
         object_apply_global_props(obj, object_compat_props[i],
+                                  i == 2 ? true : false,
                                   i == 2 ? &error_fatal : &error_abort);
     }
 }
-- 
2.34.1


