Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1B9109C029
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Pzt-00055e-JT; Wed, 25 Mar 2026 11:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Pzo-0004vJ-Cl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Pzm-0000Gd-Ej
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so10702905e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451889; x=1775056689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jek66EmZwh90Q0GbeJB2FKCf8mZ1pqgxf9FHcRMVDAM=;
 b=An+Vzzv5JYxqrmfKsXRY942e61w+UibF/N83A3HPn8vNZ06rGeE7OoZoONLjq6jAxZ
 UQP2JnHEjWDBrAydbvpRryA3e7VXu3vvF2TmlWSM9a+EWt6FcNvQMBrHH2l45UPvBzrs
 jGm+0XneZ6mSn6gVfAIxsbsj+QJq6yQZaM8GiQnYvkQGR1UsjtcHS6jhS2nRrUubDVce
 cn/51HlJNsv31fJmK0w/Pt4OSO1mp0zymM5ihUlpjd/52s5+Hs29CUP9x0j5FFH8PG+e
 Zf8Xsk/INKexB/JMwdcRbwFi7DLAfXcoNkW6WZj0W9UHKFij3ziRsOgqXlGHbKXi9f9Q
 7jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451889; x=1775056689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jek66EmZwh90Q0GbeJB2FKCf8mZ1pqgxf9FHcRMVDAM=;
 b=eEMho61lkW/4nMOwPpPcd6e9q1I4/khRRYQWhx0Yr9Aq9eYoBVv+/Eh2Y6X8kAJ/Df
 TA1pd7ybuS0Wl/PyfclkUP2zNfGmYG/J0W6mIrq8BSR/7a37XAMDzuyltn0Hq/qZHYBS
 XnJN1FZGiXoNxjtfaR6KOKyGOOH0V67swqxYWMbq6HmTsHDvIlOpOst2DGNMU4L35+Y4
 knk2fteKFzsee0uPNg9kz7YS0DYvgi3cVJHR1VS4M17L467vuO1vZ1KELEh2Pnu+xyKw
 tVcXD/wGkmx+1cQHFlSvf8lElWfTFGxmGO+GLg8RhWSRvuFjH+mLgHMBJZxUKeHfmBXT
 6v7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5i45xyh94bCO+yBrQvYPVidNNMqqFeJcmxfrGACxr7S2myh7wk/u0e9FqHVSl+KYLaoIgb18BqN+Q@nongnu.org
X-Gm-Message-State: AOJu0YycXfnLVov0pYukgYJQxYErpKZxBxb6Bq5cRQ2aOdgBfCBwDgpf
 bDQgxnp/4TvtjfL8qTT7zLO48hZYZ1l+7K+Na2K645dV3K+X9M0nR7jETy/Br2nMrcmaG4I3rTn
 tJ69zMho=
X-Gm-Gg: ATEYQzxuSz3xURh8aDqwkH9umVWO0rTams6X5CI0WZauYi1i/q4vbneC+3wFelRtBxe
 MGLyE8Zj2n/9m0LSWYo2RD35EpTezV1/n2TnHiwjhbxTUYXYn1ulZMj0E/zvGylDAjfAZhQTfBy
 Lu/qWCGI1anTcWps48PPMCNmdl7uAdY9NQu2W+91eTFtIqj5UOwPd8j2duqGLZ+SWxejiJkyHxC
 O8lFIfFD+uOLgUhezSurX1fc9U+yhxPNjyHVwlVhMqFz1tLVisp4h8HTt77UCO3i0G1TZb1gd3J
 +ffqCSsAIDMm6104d73hsXAdyjVfks4xmJ71wbmg1nkokbfogYrY2zt08hVQ8js6xoU8sPNE4IF
 6FHRs5zwOqlQ6E5qIADRZp7K58yPvr416bH5DfI1034BIm2mHAZxLbbuBwlWZSdcUG6L9w+GxeL
 ykg0SJF4+kOD9VXt93wiCve0Z+ET/wdResa9XTpnL4eOBv+c0Op12ujgIkOmLN+JRsQCWLyc8Z
X-Received: by 2002:a05:600c:6814:b0:485:3c11:de84 with SMTP id
 5b1f17b1804b1-487160a2589mr53284815e9.14.1774451888875; 
 Wed, 25 Mar 2026 08:18:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871174f2cesm139339185e9.10.2026.03.25.08.18.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 08:18:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH-for-11.0? 5/6] qom: Restrict compat properties API to system
 emulation
Date: Wed, 25 Mar 2026 16:17:27 +0100
Message-ID: <20260325151728.45378-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/compat-properties.c | 116 ++++++++++++++++++++++++++++++++++++++++
 qom/object.c            | 100 ----------------------------------
 qom/meson.build         |   3 ++
 3 files changed, 119 insertions(+), 100 deletions(-)
 create mode 100644 qom/compat-properties.c

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
-- 
2.53.0


