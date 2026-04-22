Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66735FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdlO-0003Ia-LN; Wed, 22 Apr 2026 16:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlH-0002y7-TJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlE-0002Im-8v
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso23573455e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888082; x=1777492882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i16+K88dP2srwGegwWADZWAYdsg4ufcKlfz38gndrG8=;
 b=tMR99FMwgHH9589XlNaNxuocf9KN+itj7rgJUsBOqqkvtz5KFbQr7tlNhP0Er5SeLo
 hhUsSWUnGib/QXGZmA0S/ZNmWouYqFXVbq7vVfuJ+CexSk1pGIBuCyGjmeWS4FURIvQI
 kqhLsvhhXtdvURyOGaESQWgfY9s2sgRIQo4vz8hha1OOA/yh1h1h/UJE1S1Z0xIfEb2r
 ZDp8oI9ecsKHKU9znnHxtA41vSkkKvVZ7G0F5fP+kqDMptPySaAzwY0cCBgVp49o4FOv
 TWYZrpnusIJfD5d49RRI7V8jo33NYYLLtXh1uDX+BTQ/1JGxWNYIMUPRzzKBbhj3GMmh
 n1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888082; x=1777492882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i16+K88dP2srwGegwWADZWAYdsg4ufcKlfz38gndrG8=;
 b=GiDaq6G9I2q5hRSgVP07b9ApuFcl75Gg1ETUdd4ZfBqgCGyqaryZ1UTPfgPFDRYvIw
 8OThp0mPq6vdejODsj4/pOXAW8N+IrvrQhV7pFsLla9veZdES3bblpbrYBj4C/Ryj+U1
 DQsBKfjshsatiFdLEOMh1QdGVS8eXv5/V1EG2gu9QcnYi7OZb8CtfoWxamE19fyW1eDb
 OqgvzuNgvFD1FGgcwI6R9uiz4bowNYjgHmooKzqz4jp8eiiClht3D7gxvTlI+grPf5Rp
 9fWU8um49wq3zILqZOwFlkbLiNNWcqCsbfhLLtFbNDA2OlGnZzUlaxZElJ+RqI5AS+R0
 YTDg==
X-Gm-Message-State: AOJu0YwZCK3pQOhDx2maM3sAUZNzw4Md6XVhDK8yRb7PLu3LNyBhr3xY
 NgXcGRc+S3gIA6msSfNHwhy5/CvalhtR6ATmyd9PfakvvdPE/ezLg5lgGF437cnyiCLI5AzwGWX
 ArxxB7FI=
X-Gm-Gg: AeBDiet36nMuk5+ez4QGMBVleHopbK04rSiEQxaAK/3RA/HWUVLDGQFLgrDPLtoEZBl
 Len9kcKT0fJo6ducYqbKWteR9veG/JHAbpxii1Z/k2WOzDcnhQ089wyNub5x66Ei4PP/krfSJ6W
 jX84hBJzUAAszPffZUCEJm2Y2g4Wk+ffawPwTaBPzHa5SGGT1n3QwFV8oAvDim6NFhAcgX+KlDh
 nTE/7gPSXIcBYL0MMowt8csaSqbsx4VCmbCkH3UeKHeCw9WVKWozss9sSdARwFZO+2SfdZEDLBb
 VjI+5eqnCf3e8EmZyJBcsHep4zpEawBYVM9ZEtP8HtXk7sdQU5oCgX85kB8g5JgTLdiuaEliOeI
 KEMK8aJvKTR/oaF4Kvg3KynJezJ80IPCYcgV4jmv5XdVcEZTcDyvvejy6KycmvVBwMS16cTCYTt
 bn9cF5p5BpfFpZHcQg48hs1uRNItTEe141l4m04eJMYuGjpxsLnsAN6x7IRzdqYzzd/Xy4rJCKO
 0ExFhW3d8M=
X-Received: by 2002:a05:600c:1587:b0:489:1c02:773a with SMTP id
 5b1f17b1804b1-4891c0277bfmr118768185e9.31.1776888082186; 
 Wed, 22 Apr 2026 13:01:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7ac6aasm147966785e9.25.2026.04.22.13.01.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/48] qom: Restrict compat properties API to system emulation
Date: Wed, 22 Apr 2026 21:57:28 +0200
Message-ID: <20260422195746.88865-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Move compat properties API definitions to their own file
unit, compile it only when system emulation is configured.
Add a pair of stubs for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20260325151728.45378-6-philmd@linaro.org>
---
 MAINTAINERS                   |   1 +
 qom/compat-properties.c       | 116 ++++++++++++++++++++++++++++++++++
 qom/object.c                  | 100 -----------------------------
 stubs/qom-compat-properties.c |  20 ++++++
 qom/meson.build               |   3 +
 stubs/meson.build             |   1 +
 6 files changed, 141 insertions(+), 100 deletions(-)
 create mode 100644 qom/compat-properties.c
 create mode 100644 stubs/qom-compat-properties.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced84..54e15c04e59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3551,6 +3551,7 @@ F: qapi/qom.json
 F: scripts/coccinelle/qom-parent-type.cocci
 F: scripts/qom-cast-macro-clean-cocci-gen.py
 F: qom/
+F: stubs/qom-compat-properties.c
 F: tests/unit/check-qom-interface.c
 F: tests/unit/check-qom-proplist.c
 F: tests/qtest/qom-test.c
diff --git a/qom/compat-properties.c b/qom/compat-properties.c
new file mode 100644
index 00000000000..f8d9b0036ae
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
diff --git a/qom/object.c b/qom/object.c
index 838b1d2b225..f00d659ef0f 100644
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
diff --git a/stubs/qom-compat-properties.c b/stubs/qom-compat-properties.c
new file mode 100644
index 00000000000..f9282aeed27
--- /dev/null
+++ b/stubs/qom-compat-properties.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU Object Model (compat properties stubs for user emulation)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qom/compat-properties.h"
+
+void object_apply_compat_props(Object *obj)
+{
+}
+
+bool object_apply_global_props(Object *obj, const GPtrArray *props,
+                               Error **errp)
+{
+    return true;
+}
diff --git a/qom/meson.build b/qom/meson.build
index 81922434309..bd6f4aadd78 100644
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
diff --git a/stubs/meson.build b/stubs/meson.build
index 7189ff63ed5..f33b1d2a089 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -54,6 +54,7 @@ if have_user
   # Symbols that are used by hw/core.
   stub_ss.add(files('cpu-synchronize-state.c'))
   stub_ss.add(files('cpu-destroy-address-spaces.c'))
+  stub_ss.add(files('qom-compat-properties.c'))
 
   # Stubs for QAPI events.  Those can always be included in the build, but
   # they are not built at all for --disable-system builds.
-- 
2.53.0


