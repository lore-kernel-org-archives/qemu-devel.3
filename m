Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E4CE7E36B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8c08-00040B-Hc; Fri, 03 Apr 2026 06:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c06-0003zc-PW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c04-0005Zs-RM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775212971; bh=TtuDL2Etv4LGoH/eh3G6KM/jsLfmjseHryGBapyUNqw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=s78AUX8TQ/4tOF3a/T8OlkpugjcKgdt/JB3tI6P8CX2p/5RCVjFNZfz+JCJWFPzzC
 8ZhAyMbOac6vrH0QPdNN6PLO7p2RMXaIbzzJjFUiM1kCtNzmorlHr6LGD3aY+Dflk5
 dcBpeKHpOTDiEifSP02z5R228PM0mYCu5TKjhsyv41652VrCophLnss+EGN/lQb1pU
 ZqIgqp1itP9CSUvtFJs5KGEnftRV2KQwx7V1Oagf/AdzhQq4tBrTYN3g3ZcQXFgr8b
 g5nwn1l134YnTVcvLZQh8Tp09EyGeIYD2KSmLnblhpMY/GanrZWeY2hCwrgmtyFNUa
 He7VD9LFARBpQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3238119A63F;
 Fri, 03 Apr 2026 13:42:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4A8638DB6F;
 Fri, 03 Apr 2026 13:43:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for-11.0 5/6] qom: Restrict compat properties API to system
 emulation
Date: Fri,  3 Apr 2026 13:43:25 +0300
Message-ID: <20260403104327.1163942-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403104327.1163942-1-mjt@tls.msk.ru>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move compat properties API definitions to their own file
unit, compile it only when system emulation is configured.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qom/compat-properties.c | 116 ++++++++++++++++++++++++++++++++++++++++
 qom/meson.build         |   3 ++
 qom/object.c            | 100 ----------------------------------
 3 files changed, 119 insertions(+), 100 deletions(-)
 create mode 100644 qom/compat-properties.c

diff --git a/qom/compat-properties.c b/qom/compat-properties.c
new file mode 100644
index 0000000000..f8d9b0036a
--- /dev/null
+++ b/qom/compat-properties.c
@@ -0,0 +1,116 @@
+/*
+ * QEMU Object Model
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/compat-properties.h"
+#include "qom/qom-qobject.h"
+#include "hw/core/qdev.h"
+
+bool object_apply_global_props(Object *obj, const GPtrArray *props,
+                               Error **errp)
+{
+    int i;
+
+    if (!props) {
+        return true;
+    }
+
+    for (i = 0; i < props->len; i++) {
+        GlobalProperty *p = g_ptr_array_index(props, i);
+        Error *err = NULL;
+
+        if (object_dynamic_cast(obj, p->driver) == NULL) {
+            continue;
+        }
+        if (p->optional && !object_property_find(obj, p->property)) {
+            continue;
+        }
+        p->used = true;
+        if (!object_property_parse(obj, p->property, p->value, &err)) {
+            error_prepend(&err, "can't apply global %s.%s=%s: ",
+                          p->driver, p->property, p->value);
+            /*
+             * If errp != NULL, propagate error and return.
+             * If errp == NULL, report a warning, but keep going
+             * with the remaining globals.
+             */
+            if (errp) {
+                error_propagate(errp, err);
+                return false;
+            } else {
+                warn_report_err(err);
+            }
+        }
+    }
+
+    return true;
+}
+
+/*
+ * Global property defaults
+ * Slot 0: accelerator's global property defaults
+ * Slot 1: machine's global property defaults
+ * Slot 2: global properties from legacy command line option
+ * Each is a GPtrArray of GlobalProperty.
+ * Applied in order, later entries override earlier ones.
+ */
+static GPtrArray *object_compat_props[3];
+
+/*
+ * Retrieve @GPtrArray for global property defined with options
+ * other than "-global".  These are generally used for syntactic
+ * sugar and legacy command line options.
+ */
+void object_register_sugar_prop(const char *driver, const char *prop,
+                                const char *value, bool optional)
+{
+    GlobalProperty *g;
+    if (!object_compat_props[2]) {
+        object_compat_props[2] = g_ptr_array_new();
+    }
+    g = g_new0(GlobalProperty, 1);
+    g->driver = g_strdup(driver);
+    g->property = g_strdup(prop);
+    g->value = g_strdup(value);
+    g->optional = optional;
+    g_ptr_array_add(object_compat_props[2], g);
+}
+
+/*
+ * Set machine's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_machine_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[1]);
+    object_compat_props[1] = compat_props;
+}
+
+/*
+ * Set accelerator's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_accelerator_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[0]);
+    object_compat_props[0] = compat_props;
+}
+
+void object_apply_compat_props(Object *obj)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
+        object_apply_global_props(obj, object_compat_props[i],
+                                  i == 2 ? &error_fatal : &error_abort);
+    }
+}
diff --git a/qom/meson.build b/qom/meson.build
index 8192243430..bd6f4aadd7 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -5,6 +5,9 @@ qom_ss.add(files(
   'object_interfaces.c',
   'qom-qobject.c',
 ))
+if have_system
+  qom_ss.add(files('compat-properties.c'))
+endif
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
 system_ss.add(files('qom-hmp-cmds.c'))
diff --git a/qom/object.c b/qom/object.c
index 838b1d2b22..f00d659ef0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -440,106 +440,6 @@ static void object_post_init_with_type(Object *obj, TypeImpl *ti)
     }
 }
 
-bool object_apply_global_props(Object *obj, const GPtrArray *props,
-                               Error **errp)
-{
-    int i;
-
-    if (!props) {
-        return true;
-    }
-
-    for (i = 0; i < props->len; i++) {
-        GlobalProperty *p = g_ptr_array_index(props, i);
-        Error *err = NULL;
-
-        if (object_dynamic_cast(obj, p->driver) == NULL) {
-            continue;
-        }
-        if (p->optional && !object_property_find(obj, p->property)) {
-            continue;
-        }
-        p->used = true;
-        if (!object_property_parse(obj, p->property, p->value, &err)) {
-            error_prepend(&err, "can't apply global %s.%s=%s: ",
-                          p->driver, p->property, p->value);
-            /*
-             * If errp != NULL, propagate error and return.
-             * If errp == NULL, report a warning, but keep going
-             * with the remaining globals.
-             */
-            if (errp) {
-                error_propagate(errp, err);
-                return false;
-            } else {
-                warn_report_err(err);
-            }
-        }
-    }
-
-    return true;
-}
-
-/*
- * Global property defaults
- * Slot 0: accelerator's global property defaults
- * Slot 1: machine's global property defaults
- * Slot 2: global properties from legacy command line option
- * Each is a GPtrArray of GlobalProperty.
- * Applied in order, later entries override earlier ones.
- */
-static GPtrArray *object_compat_props[3];
-
-/*
- * Retrieve @GPtrArray for global property defined with options
- * other than "-global".  These are generally used for syntactic
- * sugar and legacy command line options.
- */
-void object_register_sugar_prop(const char *driver, const char *prop,
-                                const char *value, bool optional)
-{
-    GlobalProperty *g;
-    if (!object_compat_props[2]) {
-        object_compat_props[2] = g_ptr_array_new();
-    }
-    g = g_new0(GlobalProperty, 1);
-    g->driver = g_strdup(driver);
-    g->property = g_strdup(prop);
-    g->value = g_strdup(value);
-    g->optional = optional;
-    g_ptr_array_add(object_compat_props[2], g);
-}
-
-/*
- * Set machine's global property defaults to @compat_props.
- * May be called at most once.
- */
-void object_set_machine_compat_props(GPtrArray *compat_props)
-{
-    assert(!object_compat_props[1]);
-    object_compat_props[1] = compat_props;
-}
-
-/*
- * Set accelerator's global property defaults to @compat_props.
- * May be called at most once.
- */
-void object_set_accelerator_compat_props(GPtrArray *compat_props)
-{
-    assert(!object_compat_props[0]);
-    object_compat_props[0] = compat_props;
-}
-
-void object_apply_compat_props(Object *obj)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
-        object_apply_global_props(obj, object_compat_props[i],
-                                  i == 2 ? &error_fatal : &error_abort);
-    }
-}
-
 static void object_class_property_init_all(Object *obj)
 {
     ObjectPropertyIterator iter;
-- 
2.47.3


