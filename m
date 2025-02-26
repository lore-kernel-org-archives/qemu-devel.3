Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E36C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI9E-00072R-Cp; Wed, 26 Feb 2025 09:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8j-0005TY-O2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:12:01 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8b-0007Zr-0C
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:11:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390df942558so215770f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740579104; x=1741183904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nv4cWAHWB9xQpiEKQ5DeC2E+zGIYJrWZQFyDlGzpbvA=;
 b=za07jxZnoyrXCHFYusF90usgvXkf1yjFbX3+2WA1ND2+ebk5rnZTggwwdOlF3au1QB
 i95MZ6VMatuM445jqQPGgtPGiD5gnRrBfm3YU1rMbI8L+9yMKHGpTJJWq3duFOvnZaZ3
 f8Die9GJYrwicLfsc1qgDXM9En5gix1kJKEPFeZISxFEFI8jj2RD6AG+MBTG6EUXQs67
 yQDf9ySdqpSGYS9EazQ7MWTG5KN8Yz+FG6akF+qPezJ+Ncz/ranjXPMcjEE5AEU+/u3Y
 MAdkAhGHwDfwZjZy0PBDgQvsEKjXJ5GXAKCkFFVtWryvO+opkiaKc1uU2ryNgMfaifqn
 RLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579104; x=1741183904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nv4cWAHWB9xQpiEKQ5DeC2E+zGIYJrWZQFyDlGzpbvA=;
 b=lp87I/1xn1bc41dj7FUEHKR7EUJo2U61P796+jUiFrNJ/RCqUPdu/mAEG3zKHaFrcb
 I6XGqei23xA6C8PTCtoKL4BA3yv7wb0LsJuVqUDJHkLMWPwtuSTY/MSLG/4lqjQKFSvz
 9vFIxGjcMmqmlVoPNRfvUPTDuvfEr0h7V1NpviUyeLcs9KWNOZL0kCoQ6pposmGNqZ0t
 C2oA6RN7xzFtFox0n2UmZEyYUCrDHyNAqyk2v9Cre3weIpojP4qxIu7ICjQVjjQIU0Qw
 21sP/a3yMRhkYQg4OKN4O6fxYaSMdzEoGmQUgWucIXZFk6foxPtZUOMo1CUeDSx4fuew
 cjWA==
X-Gm-Message-State: AOJu0YxcffsolFyGW3GFz6bnuIeYtsxb9BdpgXN+SzLFknHaRUejOM2i
 C6G9DxvNHBb02d4tP+axpW3jlkXPnw36x7ne9VossQMvb1/h/PEHOIy4yivH4MA=
X-Gm-Gg: ASbGncs/1S3ypsgg1LfkQtKVsUmlfwBOITG46zeF8swza1hMNIMbhJjoq5VFGn10vNF
 n1Koh5vCGYCJlEW2rHJ6yjY1O/eTgZANi5gLX26IBteeMvN2D17taVhhE/hYJtt81maqOqIUjzm
 qIQyuLySgozBfsh1IbU6aGJPzZ7gH8yMdfCO4puFPwhyGt8PDxLiyetqK1KqUA4Ge6cHrqNDJB/
 4K4LgT2f/XdYcwOY9z9uhnWldH6x/rgJGO6w9fN0c8NDalSdHLfJhitOOVG8uutr0BX0VdGnN9P
 E1+ss5tEsKP8p/VrqazQd0RmTrwr
X-Google-Smtp-Source: AGHT+IGzCB6oDKWLI8Xt9+/CdQ9g98wMCWns3l4CmvPFvF94InIHtUuzbUjZCOcQd/MpLpI0Q8V0NQ==
X-Received: by 2002:a05:6000:2a7:b0:38d:e190:b713 with SMTP id
 ffacd0b85a97d-390d4f8b3d5mr2990252f8f.37.1740579104013; 
 Wed, 26 Feb 2025 06:11:44 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd866f0asm5746817f8f.12.2025.02.26.06.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:11:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 033E260794;
 Wed, 26 Feb 2025 14:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 21/25] plugins/api: split out binary path/start/end/entry code
Date: Wed, 26 Feb 2025 14:03:39 +0000
Message-Id: <20250226140343.3907080-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Message-Id: <20250225110844.3296991-8-alex.bennee@linaro.org>

---
v2
  - use common-user/plugin-api.c.inc instead
  - add commentary about state of plugins for BSD user
---
 bsd-user/plugin-api.c        | 15 +++++++++++++
 linux-user/plugin-api.c      | 14 ++++++++++++
 plugins/api-system.c         | 39 ++++++++++++++++++++++++++++++++
 plugins/api.c                | 43 ------------------------------------
 common-user/plugin-api.c.inc | 43 ++++++++++++++++++++++++++++++++++++
 bsd-user/meson.build         |  1 +
 linux-user/meson.build       |  1 +
 plugins/meson.build          |  2 +-
 8 files changed, 114 insertions(+), 44 deletions(-)
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
index 0000000000..e4f796d926
--- /dev/null
+++ b/linux-user/plugin-api.c
@@ -0,0 +1,14 @@
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


