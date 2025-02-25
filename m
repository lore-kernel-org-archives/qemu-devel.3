Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0BC021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoT-0001eo-OO; Tue, 25 Feb 2025 06:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso3-0001ZG-UI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso0-0007lI-Oz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439a4dec9d5so52160465e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481730; x=1741086530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95zpMPBQ4vqu24tnUZPYM2mX9mrk7ldJk6RK0AKliOA=;
 b=cP1D6ikRg+WT2KUyEkEDS9Qx6Vse6Pqcz4rLS1W508wCoivshD+N945B3B8Kb9SOio
 4ny2qbp/TaPI6rnMu4avFPqfCWavcSj9zl2BxVOPodZJ0cqbaBzKcWOD6eVW/1eEQjXd
 rCJ69U7bctiu56U2fQkQHvR8ms2KXJXSL32Xte1YlyikuMUJasMQmzvOMCxR/CeE1fd0
 41oJEc7MnfJV9XZjNM9QL9H1FqGyrcmozfIAJcVDMrtTGU7EzHHeQadjRVYRIcDKtEeg
 Otvv6YcsWYq2IIVgaM0ZktZAcXK47McDKPRK6THHkDZGlMbGT2kvcmODYBGrogeYz+Ym
 iinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481730; x=1741086530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95zpMPBQ4vqu24tnUZPYM2mX9mrk7ldJk6RK0AKliOA=;
 b=Y9aHyeZeQhDAGlLDHGiuXb3AP9clSm+rLvm9aV8mqwUuDCIYl8SJqsBLabfOeZdX3A
 w/327PCLI0+DJ3N5YUkArhbZVx2b9OmsZBJv/HlCPyyL3Dl/wUBbId+Dr9lKCQhWVXNH
 xQqIpQd6szbPd94IpXONkV9RiQNLucKFx9brUzHt5AiiS1/ZsIEZK0Rsf6HYk2OkGyYY
 +rnBYiVSUJ6jJPjJuhOnM0kn6jqxd4LZjqQIq7iKUe9eAjQcfbbb1N4RZY5Pt0pmz8/6
 l8kShyervtZQMI91caDUbwfMTeUrz0lUTCSCwdMFZ5VcLK/kc2SKbLCBUQkunf/4K2zn
 77dA==
X-Gm-Message-State: AOJu0YxT83smC08M1ksKT+XIX7j1oGDbZLhocdiaN76kZjIFLlBpbO6F
 +MRKA64xnUFuhJBY6WEhdnLT0+MD4rnuLBD52EkEXmfyGtlxdhHHnpk01Pcwciw=
X-Gm-Gg: ASbGncvXzukWUW8AF8kk4hhAcKCcDawxvnPHtnlHkyqgdQNM/8BHwaKiX0W8RNX4AQv
 sG/z9zhu/nTeqH9fN2S/liyAwMSR3XuC60QtYXrBRFMI+0Kdh07yLXeDbmQ7LZHf2ht19xVXLIi
 utrv/1IsdRmJ9iMa3ZIuAU2M44nHf5/5D2G21aeuTdc92nXBEoRgnx0jpH4m8hBSvdnirJyTTDt
 fHEL0lZYMFSkgz92Q4AaNpFMNYj6jEAjEOG5Cmm1sbMCCk9ctMS4gzJko8MnvswDlDNYUHDfe3K
 JLyulibD1jePG0ZiBapOXcQxu7HN
X-Google-Smtp-Source: AGHT+IFsD9hDABRfI47X5NncnP9sNEp3mQvZj1NNIw2GwLhQB5ci+aNrcVLIEDAZM8h4hSwpFmSGFw==
X-Received: by 2002:a05:600c:3d19:b0:43a:b186:8abc with SMTP id
 5b1f17b1804b1-43ab1868ac3mr22306705e9.2.1740481729920; 
 Tue, 25 Feb 2025 03:08:49 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86cd10sm1944786f8f.37.2025.02.25.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3B015FB97;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 07/10] plugins/api: split out binary path/start/end/entry code
Date: Tue, 25 Feb 2025 11:08:41 +0000
Message-Id: <20250225110844.3296991-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/plugin-api.c | 43 +++++++++++++++++++++++++++++++++++++++++
 plugins/api-system.c    | 39 +++++++++++++++++++++++++++++++++++++
 plugins/api.c           | 43 -----------------------------------------
 linux-user/meson.build  |  1 +
 plugins/meson.build     |  2 +-
 5 files changed, 84 insertions(+), 44 deletions(-)
 create mode 100644 linux-user/plugin-api.c
 create mode 100644 plugins/api-system.c

diff --git a/linux-user/plugin-api.c b/linux-user/plugin-api.c
new file mode 100644
index 0000000000..42e977c339
--- /dev/null
+++ b/linux-user/plugin-api.c
@@ -0,0 +1,43 @@
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
index 3e1aac7bfb..12a3b6a66d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -470,49 +470,6 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
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


