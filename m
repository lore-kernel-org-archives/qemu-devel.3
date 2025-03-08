Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1745C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr276-0003LN-Fj; Sat, 08 Mar 2025 16:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr275-0003KV-EL
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr273-0000xb-7z
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso16783935e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470819; x=1742075619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgXwB/ncZFy5BnYBAj8eMjbITTEJZxceGTFwM5B/TMg=;
 b=g029L4d+2UZY9KtAaMV8W7d/EDjyk7kbcKnzuJ4tknl/gSJcXmLLdykcC0fsMI5kls
 uxg3+A5zNwM+i4gXH5qgXfbwBCgrLwKE9mqZZ6MrSVU4XeO0WQa+L3ce31IbuYJqgFj/
 2+1UA0ijaGAnR4+vb8lFbtqB5yY14x26cAIFYKyCM1SlXqH5dZG77glJAr8M6RxIl2y0
 zhhRBTXG8rEOF6ez1cp/5n58/2BDyDVleTuYMu+PneUI5usBFZV5SS7cmZhVnsg3kDfJ
 Xt/r4CFlrRmqRTv1MF5BXt0dDYhFRHNZFH+eFh2OG2hxS7OzzLN7KRODsefhRrTH0eLq
 2g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470819; x=1742075619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AgXwB/ncZFy5BnYBAj8eMjbITTEJZxceGTFwM5B/TMg=;
 b=biAx7PGcwy39zfF0xO5EOePcD9b/guXqOJpthmxm23OSVvYGMy15IbjDOLwJlovSIN
 aoI6mv5fI2zkERJgBfLZ54hHQN291k+tU2kMT+ViTzHfdAWNbn95jD69Ji8B66W9i5LZ
 VQcr/NGYa/hy6bkusPBRNaOlOmUxMqoi3ZEG/9BXgGSxALspBJGj6wlBXmmsI+XwJffz
 lanctCnVNXcjIMFcybRiE1unEGHoezIYCyjCxNFMoHxfZKEq3HECsb8/BH6+RuvQBE5c
 v3GADvYMqX0gCEiuiVuPyMtU9ZViMbIrtS0KQRa1oQdjW4xVWoVymFIbT/1BraIAR850
 L1aA==
X-Gm-Message-State: AOJu0YzcP8X0cu67MacEJTWF+0xt/20VSVUfjb7mW2q1gpYnSXJIpdPC
 BwpME22v1/lsYDvHUMyxgJuCV+1kxM1sSSeR634gFctJqjoOFjx1j6e/OOIPv38=
X-Gm-Gg: ASbGncvDmmT35Q5M23kYUpFV/+Eup60oP+aNIYGz5pScV3/9smueAa33jyeyVedK0wj
 OKGMDppHTbTs9E3RUeVrfInD9NPPh8KURD5avLlqX8Bt6/5zVWyaYCLnKRr6iU08BL7y0FX/lOJ
 IWpIrwyTONHt5FsPo5whtUPP0nWlLPoCbDkbf2v3RWPUkMARwN6UoI1emsNa1gas/r1s//ZkMV2
 tkmDeszqfQ55rUqyq+3V5ARnnuYhE4nGx3OiH6+eqOaGxHn558Njn+yhspNU30imZkgim6kLQxw
 4Lkp0IbwGMP0VBfqnbgilcTlrISlL2TDCjPqnMdzMBVb+lkVJe3gAMUn3g==
X-Google-Smtp-Source: AGHT+IGsUgTZxJk4dzlNb6PlVZeRP0MST9oIxmEaajIFgEALrxCI10EXzFuJiqwK7C5+mfmHoDP1zQ==
X-Received: by 2002:a05:600c:470c:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43cf051022dmr4181225e9.11.1741470819381; 
 Sat, 08 Mar 2025 13:53:39 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da097sm97965175e9.17.2025.03.08.13.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1725C60B0B;
 Sat,  8 Mar 2025 21:53:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 26/31] plugins/api: split out binary path/start/end/entry code
Date: Sat,  8 Mar 2025 21:53:21 +0000
Message-Id: <20250308215326.2907828-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-27-alex.bennee@linaro.org>

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


