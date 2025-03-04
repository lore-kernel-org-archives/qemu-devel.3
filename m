Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD807C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpamP-0000RB-IR; Tue, 04 Mar 2025 17:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpam5-00089F-Jp
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:14 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaly-0007mq-Bd
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:02 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e549af4927so4688889a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127393; x=1741732193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AVfGi7ra8MkKWd/PMrFZCQLGgeEHyEMJkQKuf70mbg=;
 b=SREjOW/DiS/TR1yGxrLznKg+HuYAIimZM2F8m1leZ/vwBzaynvVNwC6Gb8z4kQmA9B
 yZ2fsrLA0N0dEAr4IskFHVpoBEMW+oQYy1B5K4tva/nj74O2dL84U5vJHrTi2LFddQja
 rx3rfF0OX45Km9VXpnK0cdRSKUxqPGHlhe8Wbt4oGMuuFeWXtVhPoThW/i8M+1gftwSh
 yy8HBGFX0ro3RpbFD31EbZ+yRjLZUgDCv9XDM2gWSdHara0N8lh7EY9X1zdDyfw8volB
 nvaUHFH/WGmE3SrFEynqiSfnbzTtOizPG8aset4x4J3GxWLGebDjVxJTIIwf2iWN0qQU
 vBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127393; x=1741732193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AVfGi7ra8MkKWd/PMrFZCQLGgeEHyEMJkQKuf70mbg=;
 b=oprnL/tep3sMirHyzwRYPfMunZ12Z9Gu1NdyItMOnGW2IPzagR7IOs/wI0Shng8DCN
 LnPmzADG+ZNYkJ3F72FI7SUVKVwHk5h+CgDBcSIBT5vNt/owbjm6wRfhGP12jvHm2lzP
 jHT1YZ9/u6Sgyf0Yefr1dKRKo/eqhTU2Y+9PabOQOFGzCxYoPaeTyNv9TgsjafpiiDex
 Sn1NEQZMu2iMlQIMauEmQ706WksODwFZRjjFt69r4GRuRMkTfJ0XvkBMaP1+VFyqN8+9
 GmNV2vHm2B3D6qg/jIh1ufocNIJ9sE2CoCY6HDcCPdUf8kHKgWkYFGZGmmXOewisEw44
 bIoQ==
X-Gm-Message-State: AOJu0YwqdY28GHl6gRncam0/rSLQj5bWEaZXAMI+nUG1WKxhYsn+V43H
 /KSEFAxGb+AGCp1ucknS+V0GmYmpcsV+zklzFXrU+FPcH5DNlynedOSl8j5Sgsg=
X-Gm-Gg: ASbGncur31jm9CUo4W7RZ5tY8ODtoLZUaPwJroG5LHEYhYzktHFmfKiR9xCzHQ0vUIg
 dUDhGUW6l3QJ67KPH/1LoM0KJ/YzHPUmycQFPhtEBnDJHJD9DoJU/Hq9saHFITvzbwPp0PutW+d
 vS2tdAUbL8/D/QH19e4l1mSayw+akObG9aGOT01YRwi/AcchiQvjn33dgojMz5B2Jf3roR3Csym
 0oCuovfEUDXa0rrlLXfnMwZMWIPYs4PASBO7ktXwnMHLMOZeVFpCP0DWRvzay3ONuCyKQ+ncF/U
 0714fnwNwaWaqYIz8yrUmvHZlgm5ryEqeogHjlVkaKR9OQ8=
X-Google-Smtp-Source: AGHT+IERA880j6e67WUjpyHdkX4yep3LdFkWTt9nGTZHfgOT36fGdT1yfqweSs83ZsV68Zp49yjBrA==
X-Received: by 2002:a05:6402:3596:b0:5e0:7509:4543 with SMTP id
 4fb4d7f45d1cf-5e59f48a5c3mr627213a12.32.1741127393170; 
 Tue, 04 Mar 2025 14:29:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c43a6ab7sm8743631a12.74.2025.03.04.14.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 09CBB625D9;
 Tue,  4 Mar 2025 22:24:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 26/32] plugins/api: split out binary path/start/end/entry
 code
Date: Tue,  4 Mar 2025 22:24:33 +0000
Message-Id: <20250304222439.2035603-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

To move the main api.c to a single build compilation object we need to
start splitting out user and system specific code. As we need to grob
around host headers we move these particular helpers into the *-user
mode directories.

The binary/start/end/entry helpers are all NOPs for system mode.

While using the plugin-api.c.inc trick means we build for both
linux-user and bsd-user the BSD user-mode command line is still
missing -plugin. This can be enabled once we have reliable check-tcg
tests working for the BSDs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20250226140343.3907080-22-alex.bennee@linaro.org>

---
v2
  - use common-user/plugin-api.c.inc instead
  - add commentary about state of plugins for BSD user
v3
  - add missing osdep include
---
 bsd-user/plugin-api.c        | 15 +++++++++++++
 linux-user/plugin-api.c      | 15 +++++++++++++
 plugins/api-system.c         | 39 ++++++++++++++++++++++++++++++++
 plugins/api.c                | 43 ------------------------------------
 common-user/plugin-api.c.inc | 43 ++++++++++++++++++++++++++++++++++++
 bsd-user/meson.build         |  1 +
 linux-user/meson.build       |  1 +
 plugins/meson.build          |  2 +-
 8 files changed, 115 insertions(+), 44 deletions(-)
 create mode 100644 bsd-user/plugin-api.c
 create mode 100644 linux-user/plugin-api.c
 create mode 100644 plugins/api-system.c
 create mode 100644 common-user/plugin-api.c.inc

diff --git a/bsd-user/plugin-api.c b/bsd-user/plugin-api.c
new file mode 100644
index 0000000000..6ccef7eaa0
--- /dev/null
+++ b/bsd-user/plugin-api.c
@@ -0,0 +1,15 @@
+/*
+ * QEMU Plugin API - bsd-user-mode only implementations
+ *
+ * Common user-mode only APIs are in plugins/api-user. These helpers
+ * are only specific to bsd-user.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "common-user/plugin-api.c.inc"
diff --git a/linux-user/plugin-api.c b/linux-user/plugin-api.c
new file mode 100644
index 0000000000..66755df526
--- /dev/null
+++ b/linux-user/plugin-api.c
@@ -0,0 +1,15 @@
+/*
+ * QEMU Plugin API - linux-user-mode only implementations
+ *
+ * Common user-mode only APIs are in plugins/api-user. These helpers
+ * are only specific to linux-user.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "common-user/plugin-api.c.inc"
diff --git a/plugins/api-system.c b/plugins/api-system.c
new file mode 100644
index 0000000000..cb0dd8f730
--- /dev/null
+++ b/plugins/api-system.c
@@ -0,0 +1,39 @@
+/*
+ * QEMU Plugin API - System specific implementations
+ *
+ * This provides the APIs that have a specific system implementation
+ * or are only relevant to system-mode.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/plugin.h"
+
+/*
+ * In system mode we cannot trace the binary being executed so the
+ * helpers all return NULL/0.
+ */
+const char *qemu_plugin_path_to_binary(void)
+{
+    return NULL;
+}
+
+uint64_t qemu_plugin_start_code(void)
+{
+    return 0;
+}
+
+uint64_t qemu_plugin_end_code(void)
+{
+    return 0;
+}
+
+uint64_t qemu_plugin_entry_code(void)
+{
+    return 0;
+}
diff --git a/plugins/api.c b/plugins/api.c
index c3ba1e98e8..ffccd71e4b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -471,49 +471,6 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
     return name && value && qapi_bool_parse(name, value, ret, NULL);
 }
 
-/*
- * Binary path, start and end locations
- */
-const char *qemu_plugin_path_to_binary(void)
-{
-    char *path = NULL;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = get_task_state(current_cpu);
-    path = g_strdup(ts->bprm->filename);
-#endif
-    return path;
-}
-
-uint64_t qemu_plugin_start_code(void)
-{
-    uint64_t start = 0;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = get_task_state(current_cpu);
-    start = ts->info->start_code;
-#endif
-    return start;
-}
-
-uint64_t qemu_plugin_end_code(void)
-{
-    uint64_t end = 0;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = get_task_state(current_cpu);
-    end = ts->info->end_code;
-#endif
-    return end;
-}
-
-uint64_t qemu_plugin_entry_code(void)
-{
-    uint64_t entry = 0;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = get_task_state(current_cpu);
-    entry = ts->info->entry;
-#endif
-    return entry;
-}
-
 /*
  * Create register handles.
  *
diff --git a/common-user/plugin-api.c.inc b/common-user/plugin-api.c.inc
new file mode 100644
index 0000000000..5b8a1396b6
--- /dev/null
+++ b/common-user/plugin-api.c.inc
@@ -0,0 +1,43 @@
+/*
+ * QEMU Plugin API - *-user-mode only implementations
+ *
+ * Common user-mode only APIs are in plugins/api-user. These helpers
+ * are only specific to the *-user frontends.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/plugin.h"
+#include "qemu.h"
+
+/*
+ * Binary path, start and end locations. Host specific due to TaskState.
+ */
+const char *qemu_plugin_path_to_binary(void)
+{
+    TaskState *ts = get_task_state(current_cpu);
+    return g_strdup(ts->bprm->filename);
+}
+
+uint64_t qemu_plugin_start_code(void)
+{
+    TaskState *ts = get_task_state(current_cpu);
+    return ts->info->start_code;
+}
+
+uint64_t qemu_plugin_end_code(void)
+{
+    TaskState *ts = get_task_state(current_cpu);
+    return ts->info->end_code;
+}
+
+uint64_t qemu_plugin_entry_code(void)
+{
+    TaskState *ts = get_task_state(current_cpu);
+    return ts->info->entry;
+}
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 39bad0ae33..37b7cd6de8 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -13,6 +13,7 @@ bsd_user_ss.add(files(
   'elfload.c',
   'main.c',
   'mmap.c',
+  'plugin-api.c',
   'signal.c',
   'strace.c',
   'uaccess.c',
diff --git a/linux-user/meson.build b/linux-user/meson.build
index f75b4fe0e3..f47a213ca3 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -27,6 +27,7 @@ linux_user_ss.add(libdw)
 linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
 linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
 linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('semihost.c'))
+linux_user_ss.add(when: 'CONFIG_TCG_PLUGINS', if_true: files('plugin-api.c'))
 
 syscall_nr_generators = {}
 
diff --git a/plugins/meson.build b/plugins/meson.build
index f7820806d3..9c9bc9e5bb 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -59,7 +59,7 @@ if host_os == 'windows'
 endif
 
 user_ss.add(files('user.c'))
-system_ss.add(files('system.c'))
+system_ss.add(files('system.c', 'api-system.c'))
 
 common_ss.add(files('loader.c'))
 
-- 
2.39.5


