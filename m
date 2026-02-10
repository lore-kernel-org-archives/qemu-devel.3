Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4F0E9462B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxm-0006vD-Q4; Mon, 09 Feb 2026 21:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxj-0006fw-Tp
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:51 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxh-00046a-UR
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692330; x=1802228330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i55Q4QB2ibnxrMseEXlw3g+DVhPWxOo/yFApxpM82Oc=;
 b=nVUR/lGOL23Uy8kNaTwICKEXDIXfieBNVvfr3eSefuAWczn6BqRKFOdL
 CzgA90Em4DDWZQeHNlOxXu3OAxiGHgNwrEhO7xU7PtQne9m1XtS7K2q3w
 F+aWeMHlc5noH2nG0AxE3g9xpdl4O33FhGXHG9bBrNWz3Z1xh8NIf3gVj
 29KcR+0R8ls0nsDFCRyEb65FFt6sQ5f0d0exZLDsraoWpOXHOPBi+uRTS
 6Wbb7K58T4slqwIVEYNygKEaD8GCEo118PBl/sA6IqV1M5j5TRBKeBySb
 5ttN0QaeBbDt/tljn1yLhY5SqsoIU1Rq+65MWWd7nfuoMxJ5wfczFmXgG g==;
X-CSE-ConnectionGUID: 37q8+VF4Ry+ZaETbRW0QXA==
X-CSE-MsgGUID: amzovffiTSGS56SP0cNBAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854301"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854301"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:48 -0800
X-CSE-ConnectionGUID: 9Pzac1INTRSQBKFIMMGYZw==
X-CSE-MsgGUID: ZBz3h4RZQVSRCNFh5NqpAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800555"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:44 -0800
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
Subject: [PATCH v2 07/21] qom/object: introduce user interaction flags for
 properties
Date: Tue, 10 Feb 2026 11:23:34 +0800
Message-Id: <20260210032348.987549-8-zhao1.liu@intel.com>
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

Introduce three new flags to `ObjectPropertyFlags` to better manage
property interactions with external users (CLI, QMP, HMP):

1. OBJ_PROP_FLAG_USER_SET:
   Marks a property as having been modified by an external user.

   This flag is designed to be "sticky": once set, it persists even if
   the property value is subsequently overwritten by internal logic.
   It allows the QEMU system to distinguish user intent.

   The advantage of this design is that it is not needed to manually
   clear the USER_SET flag on every internal write. This simplifies the
   logic and decouples flag management from the current property setting
   path (object_property_set()).

   This is chosen over a strict "current origin" approach (where
   internal writes would clear the flag) for a practical reason: QEMU
   code often modifies underlying struct fields (which are defined as
   properties) directly, bypassing the property API entirely. This makes
   it impossible to "accurately" track whether the *current* value truly
   comes from the user. Therefore, a sticky "user touched this" flag is
   the only meaningful and robust solution.

2. OBJ_PROP_FLAG_DEPRECATED:
   Marks a property as deprecated.

3. OBJ_PROP_FLAG_INTERNAL:
   Marks a property as internal-only, disallowing external user access.

Additionally, update object_property_set_flags() to implement the
enforcement logic. When a property is flagged with
OBJ_PROP_FLAG_USER_SET:
 - If the property is also marked OBJ_PROP_FLAG_DEPRECATED, report a
   warning.
 - If the property is also marked OBJ_PROP_FLAG_INTERNAL, raise an error
   and stop the operation.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 24 ++++++++++++++++++++++++
 qom/object.c         | 15 +++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 856b12e7289c..1b77429aa28b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -109,6 +109,30 @@ typedef enum {
      * will automatically add a getter and a setter to this property.
      */
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
+    /*
+     * The property was explicitly set by an external user.
+     *
+     * This flag is set whenever the property is modified via external interfaces
+     * (CLI, QMP, HMP). It allows internal code to distinguish whether the
+     * property has been modified by the user.
+     *
+     * Once set, this flag persists even if the property value is subsequently
+     * overwritten by internal logic. It is NOT automatically cleared and must
+     * be explicitly cleared using object_property_clear_flags().
+     */
+    OBJ_PROP_FLAG_USER_SET = BIT(2),
+    /*
+     * The property is deprecated and will be removed in the future version.
+     *
+     * Any setting to this property by the user will raise a deprecation warning.
+     */
+    OBJ_PROP_FLAG_DEPRECATED = BIT(3),
+    /*
+     * The property is internal only and cannot be set by the user.
+     *
+     * Any setting to this property by the user will raise an error.
+     */
+    OBJ_PROP_FLAG_INTERNAL = BIT(4),
 } ObjectPropertyFlags;
 
 struct ObjectProperty
diff --git a/qom/object.c b/qom/object.c
index 49ef99a299b6..75a1fe7ea1d3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1242,6 +1242,21 @@ bool object_property_set_flags(Object *obj, const char *name,
         return false;
     }
 
+    if ((flags & OBJ_PROP_FLAG_USER_SET)) {
+        if (prop->flags & OBJ_PROP_FLAG_DEPRECATED) {
+            warn_report("Property '%s.%s' has been deprecated. "
+                        "Please do not use it.",
+                        object_get_typename(obj), name);
+        }
+
+        if (prop->flags & OBJ_PROP_FLAG_INTERNAL) {
+            error_setg(errp, "Property '%s.%s' is internal only. "
+                       "It can't be set by external user",
+                       object_get_typename(obj), name);
+            return false;
+        }
+    }
+
     prop->flags |= flags;
     return true;
 }
-- 
2.34.1


