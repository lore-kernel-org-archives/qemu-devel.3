Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B44C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoS-0001ee-AE; Tue, 25 Feb 2025 06:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso2-0001YG-Ls
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso0-0007lK-Op
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso32432105e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481730; x=1741086530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOGEdNee22ihZNFYvdXhvyToWGXPcrh3omffan4xEow=;
 b=tVddNTMVckHB/wEVxwty7MhRbEQNkQCkI6HOF0kXWgKG1MelbdfSjE0jNlpVVzc/hM
 8m7ekslgk6/Ld6gaZcVnWIMeYiRWvrmlAgTtphMzPMK4/4iBg6TL56BuSCQXOkcasmg/
 6pw1mPncQkT4Ap1xbWM14XncTEJMoOhaO+tWZDElyonXQhnrJ45kvFyNmY4dCCOoh4yE
 SDuJtLV+bIhYzJWD9OCZJphWOhMTtMuADArPzwOdXuzoI/pO5Ejek26G/1ZHM3rHB1Mh
 TEYPcuDk0DHF3QJJA0yGRzS2S87H7HIX8XwXcNpmRrT9fVeLIlRgV0/ILUgTCRpCZksz
 BZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481730; x=1741086530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOGEdNee22ihZNFYvdXhvyToWGXPcrh3omffan4xEow=;
 b=Wmm12/bUwTvDrdt1wVnSnfmhryj3Jh8m8EoRNXepIPkdcwNgtqRtg0Cu0SBwZ0HQ1P
 CrvOZO4iRXDspTgH6H6/v0yMxXIdkQlZGFvcPupQtNTunmMXu+X6PJQ5S0Zfa0MnSSBv
 y3CAbXTj5oUinYiShbTlEYi3YF13W0CMVHK4XkRPsFiC/hQ5O64xz7JqUQxh5M3tVNXm
 caaSugxvV0rAZ23KUfm7DCBnGGLP7sqMUFW8eadaPmuw+GVKZ5b82wCTFWLFo0JgE6HE
 7nI+SuNAMlRqTDS5jxxGArLegGzTY+h2BRyly91I74NOrrj+KI2sHHWQc3fgQ18jdzK9
 lbwA==
X-Gm-Message-State: AOJu0Yx44Sz4eHDNrkt3qpQ9Zwi/YbTAVz/msQPT9dSJ871Qxwt4rzqS
 AZsb6TVTliRM7EAh6G5AxjrX9Zu6MPt6P1AshA3wgTX2FpScxVXe148wFUidH7Y=
X-Gm-Gg: ASbGncvU/wM1r/h/L5BUuIFk3hac4QyQaf5lXt+CBAlHog6a2HClqEaAQEnwCgZWFOa
 1t12JTtJueKvoIOI9d0DD7PDAZWWRiga4D8A8+9nktVmkqNB3OiFY35rXVHhMdyJhf3YUUfG8sI
 zHZFko7iszPJS1urNOoLAdsbnI6zXIPyLGkKvN4pMUeIUN5bk81nmnCVHzD330U1xxaDO/nuIpF
 t99aQkNLDMFOpJqoXrOCaWOcnEAMBo+Ed0D3cPTLPloxGbgdMQSwsGy8xjmlkDsoIalARQziwme
 oc4glj3VUHLGRjF/XiKYFto+Gc3b
X-Google-Smtp-Source: AGHT+IEBa+SJBlL9dnOxtbQjAnQN5WHbjzmu75hWgbM/9i9vhTmk1ZzGMTuFhBaudUCQ6MjhAMw98Q==
X-Received: by 2002:a05:600c:5949:b0:439:8345:17a6 with SMTP id
 5b1f17b1804b1-439a30d38e9mr151142155e9.12.1740481730292; 
 Tue, 25 Feb 2025 03:08:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f23c2sm138795405e9.17.2025.02.25.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF0775FF26;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 08/10] plugins/api: split out the vaddr/hwaddr helpers
Date: Tue, 25 Feb 2025 11:08:42 +0000
Message-Id: <20250225110844.3296991-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

These only work for system-mode and are NOPs for user-mode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/api-system.c | 58 ++++++++++++++++++++++++++++++++++++
 plugins/api-user.c   | 40 +++++++++++++++++++++++++
 plugins/api.c        | 70 --------------------------------------------
 plugins/meson.build  |  2 +-
 4 files changed, 99 insertions(+), 71 deletions(-)
 create mode 100644 plugins/api-user.c

diff --git a/plugins/api-system.c b/plugins/api-system.c
index cb0dd8f730..38560de342 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -12,6 +12,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
+#include "hw/boards.h"
+#include "qemu/plugin-memory.h"
 #include "qemu/plugin.h"
 
 /*
@@ -37,3 +41,57 @@ uint64_t qemu_plugin_entry_code(void)
 {
     return 0;
 }
+
+/*
+ * Virtual Memory queries
+ */
+
+static __thread struct qemu_plugin_hwaddr hwaddr_info;
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    CPUState *cpu = current_cpu;
+    unsigned int mmu_idx = get_mmuidx(info);
+    enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
+    hwaddr_info.is_store = (rw & QEMU_PLUGIN_MEM_W) != 0;
+
+    assert(mmu_idx < NB_MMU_MODES);
+
+    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
+                           hwaddr_info.is_store, &hwaddr_info)) {
+        error_report("invalid use of qemu_plugin_get_hwaddr");
+        return NULL;
+    }
+
+    return &hwaddr_info;
+}
+
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
+{
+    return haddr->is_io;
+}
+
+uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
+{
+    if (haddr) {
+        return haddr->phys_addr;
+    }
+    return 0;
+}
+
+const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
+{
+    if (h && h->is_io) {
+        MemoryRegion *mr = h->mr;
+        if (!mr->name) {
+            unsigned maddr = (uintptr_t)mr;
+            g_autofree char *temp = g_strdup_printf("anon%08x", maddr);
+            return g_intern_string(temp);
+        } else {
+            return g_intern_string(mr->name);
+        }
+    } else {
+        return g_intern_static_string("RAM");
+    }
+}
diff --git a/plugins/api-user.c b/plugins/api-user.c
new file mode 100644
index 0000000000..867b420339
--- /dev/null
+++ b/plugins/api-user.c
@@ -0,0 +1,40 @@
+/*
+ * QEMU Plugin API - user-mode only implementations
+ *
+ * This provides the APIs that have a user-mode specific
+ * implementations or are only relevant to user-mode.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+
+/*
+ * Virtual Memory queries - these are all NOPs for user-mode which
+ * only ever has visibility of virtual addresses.
+ */
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    return NULL;
+}
+
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
+{
+    return false;
+}
+
+uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
+{
+    return 0;
+}
+
+const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
+{
+    return g_intern_static_string("Invalid");
+}
diff --git a/plugins/api.c b/plugins/api.c
index 12a3b6a66d..b04577424f 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -382,76 +382,6 @@ qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info)
     return value;
 }
 
-/*
- * Virtual Memory queries
- */
-
-#ifdef CONFIG_SOFTMMU
-static __thread struct qemu_plugin_hwaddr hwaddr_info;
-#endif
-
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
-                                                  uint64_t vaddr)
-{
-#ifdef CONFIG_SOFTMMU
-    CPUState *cpu = current_cpu;
-    unsigned int mmu_idx = get_mmuidx(info);
-    enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
-    hwaddr_info.is_store = (rw & QEMU_PLUGIN_MEM_W) != 0;
-
-    assert(mmu_idx < NB_MMU_MODES);
-
-    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
-                           hwaddr_info.is_store, &hwaddr_info)) {
-        error_report("invalid use of qemu_plugin_get_hwaddr");
-        return NULL;
-    }
-
-    return &hwaddr_info;
-#else
-    return NULL;
-#endif
-}
-
-bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
-{
-#ifdef CONFIG_SOFTMMU
-    return haddr->is_io;
-#else
-    return false;
-#endif
-}
-
-uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
-{
-#ifdef CONFIG_SOFTMMU
-    if (haddr) {
-        return haddr->phys_addr;
-    }
-#endif
-    return 0;
-}
-
-const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
-{
-#ifdef CONFIG_SOFTMMU
-    if (h && h->is_io) {
-        MemoryRegion *mr = h->mr;
-        if (!mr->name) {
-            unsigned maddr = (uintptr_t)mr;
-            g_autofree char *temp = g_strdup_printf("anon%08x", maddr);
-            return g_intern_string(temp);
-        } else {
-            return g_intern_string(mr->name);
-        }
-    } else {
-        return g_intern_static_string("RAM");
-    }
-#else
-    return g_intern_static_string("Invalid");
-#endif
-}
-
 int qemu_plugin_num_vcpus(void)
 {
     return plugin_num_vcpus();
diff --git a/plugins/meson.build b/plugins/meson.build
index 9c9bc9e5bb..942b59e904 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -58,7 +58,7 @@ if host_os == 'windows'
   )
 endif
 
-user_ss.add(files('user.c'))
+user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
 common_ss.add(files('loader.c'))
-- 
2.39.5


