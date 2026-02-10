Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0200CE9462D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxs-000708-5K; Mon, 09 Feb 2026 21:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxq-0006xL-0Y
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:58 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxo-00049n-7i
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692336; x=1802228336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YNyb/e63nn9O7NosP48x3bb0jJDEX6gcU+lAI5zDmV0=;
 b=f1xZ6l/uqN5juZVhnGP93MSYObXwtABIA0TNQ3pQntJMU40FrRZKi/5q
 XmTSglYH/KjgYfsvPn1pdCJxnzwCTxcMcYCU49ZZb1Xub4fe1ZCyaLIrq
 Wlvk0H7+PmM/hd/zcYoZXfSwwL81TPX0kYtW3XLtUrG7YIyeevOsaxo81
 bvFF+jg4QCpQOB7ewl6BEI/Q7nuJsXvkYoq+GaFN4BdAt4lddBl3Wo60H
 wUh6OjMANPeaEfgEx8yYdjeAj8j0kpQf4eQbLgruLG4vBcvTvvWtYapxP
 vVQG2UowbbiBt8F78U2fiozhxAGQIsQ1M7FaIaRz7fYAKEqITc2xZXPxB Q==;
X-CSE-ConnectionGUID: 6nQEATuuQgO4X4bAqojWOQ==
X-CSE-MsgGUID: WRqUruB7RVWKSr7Den66tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659874"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659874"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:53 -0800
X-CSE-ConnectionGUID: oO+KYwW8RCqr4J9DDEk/fA==
X-CSE-MsgGUID: sW9euM07SAeKSoWUTl8kcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800570"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:48 -0800
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
Subject: [PATCH v2 08/21] qom/object: add from_user argument in
 object_property_parse()
Date: Tue, 10 Feb 2026 11:23:35 +0800
Message-Id: <20260210032348.987549-9-zhao1.liu@intel.com>
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

Currently, object_property_parse() is used for both internal property
settings and external user configurations (e.g., via HMP or global
properties).

To properly manage property flags (specifically OBJ_PROP_FLAG_USER_SET),
it is necessary to identify the source of the property setting.

Update object_property_parse() to accept a 'from_user' argument and
set the USER_SET flag for the property if 'from_user=true'.

As a first step, all existing callers are updated to have 'from_user=
false'. Next the cases set by specific external user will be identified
(like HMP and global properties) and will update 'from_user' argument to
'true'.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/sgx.c        |  2 +-
 include/qom/object.h |  5 +++--
 qom/object.c         | 20 +++++++++++++++-----
 qom/qom-hmp-cmds.c   |  2 +-
 system/vl.c          |  2 +-
 target/i386/cpu.c    |  4 ++--
 6 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 5e792e8e6e96..8cb71be689ff 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -316,7 +316,7 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
 
         /* set the memdev link with memory backend */
         object_property_parse(OBJECT(dev), SGX_EPC_MEMDEV_PROP,
-                              list->value->memdev, &error_fatal);
+                              list->value->memdev, false, &error_fatal);
         /* set the numa node property for sgx epc object */
         object_property_set_uint(OBJECT(dev), SGX_EPC_NUMA_NODE_PROP,
                                  list->value->node, &error_fatal);
diff --git a/include/qom/object.h b/include/qom/object.h
index 1b77429aa28b..c78e1c03a106 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1655,14 +1655,15 @@ bool object_property_set(Object *obj, const char *name, Visitor *v,
  * @obj: the object
  * @name: the name of the property
  * @string: the string that will be used to parse the property value.
+ * @from_user: whether the property is being set by a external user.
  * @errp: returns an error if this function fails
  *
  * Parses a string and writes the result into a property of an object.
  *
  * Returns: %true on success, %false on failure.
  */
-bool object_property_parse(Object *obj, const char *name,
-                           const char *string, Error **errp);
+bool object_property_parse(Object *obj, const char *name, const char *string,
+                           bool from_user, Error **errp);
 
 /**
  * object_property_print:
diff --git a/qom/object.c b/qom/object.c
index 75a1fe7ea1d3..7140e3f629aa 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -460,7 +460,7 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
             continue;
         }
         p->used = true;
-        if (!object_property_parse(obj, p->property, p->value, &err)) {
+        if (!object_property_parse(obj, p->property, p->value, false, &err)) {
             error_prepend(&err, "can't apply global %s.%s=%s: ",
                           p->driver, p->property, p->value);
             /*
@@ -882,7 +882,7 @@ bool object_set_propv(Object *obj,
         const char *value = va_arg(vargs, char *);
 
         g_assert(value != NULL);
-        if (!object_property_parse(obj, propname, value, errp)) {
+        if (!object_property_parse(obj, propname, value, false, errp)) {
             return false;
         }
         propname = va_arg(vargs, char *);
@@ -1802,13 +1802,23 @@ int object_property_get_enum(Object *obj, const char *name,
     return ret;
 }
 
-bool object_property_parse(Object *obj, const char *name,
-                           const char *string, Error **errp)
+bool object_property_parse(Object *obj, const char *name, const char *string,
+                           bool from_user, Error **errp)
 {
     Visitor *v = string_input_visitor_new(string);
-    bool ok = object_property_set(obj, name, v, errp);
+    bool ok;
 
+    ok = object_property_set(obj, name, v, errp);
     visit_free(v);
+
+    if (!ok) {
+        return false;
+    }
+
+    if (from_user) {
+        ok = object_property_set_flags(obj, name,
+                                       OBJ_PROP_FLAG_USER_SET, errp);
+    }
     return ok;
 }
 
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 32e40630c96a..6bdb241e54bd 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -58,7 +58,7 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
             error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
         } else {
-            object_property_parse(obj, property, value, &err);
+            object_property_parse(obj, property, value, false, &err);
         }
     } else {
         QObject *obj = qobject_from_json(value, &err);
diff --git a/system/vl.c b/system/vl.c
index aa9a15504174..6d8167a50006 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1708,7 +1708,7 @@ static int object_parse_property_opt(Object *obj,
         return 0;
     }
 
-    if (!object_property_parse(obj, name, value, errp)) {
+    if (!object_property_parse(obj, name, value, false, errp)) {
         return -1;
     }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a7b884528ea..94a9dcde1eb1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8089,7 +8089,7 @@ void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
             continue;
         }
         object_property_parse(OBJECT(cpu), pv->prop, pv->value,
-                              &error_abort);
+                              false, &error_abort);
     }
 }
 
@@ -8112,7 +8112,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, const X86CPUModel *model)
 
         for (p = vdef->props; p && p->prop; p++) {
             object_property_parse(OBJECT(cpu), p->prop, p->value,
-                                  &error_abort);
+                                  false, &error_abort);
         }
 
         if (vdef->version == version) {
-- 
2.34.1


