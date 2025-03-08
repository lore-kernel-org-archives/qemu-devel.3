Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBBFC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Dd-0001uW-V2; Sat, 08 Mar 2025 17:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DT-0001hN-17
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DP-0001vg-I7
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso1478695e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471214; x=1742076014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+NSju37Mir16Ju7IGTAiExpj2eXU+4Tqger0eVMhLE=;
 b=YnrZpC72XCJ9LMNV6NQGzTwt+z/nne6m35Gv9FZB8WJtf4xKs8kAcKDfHE/SJn+elO
 J/FMam6FFdGCWxlIsHfa9B7FH0sOHvAbmqBLzy7pdwQIjs/TfZh/4rBVqsnIQoL86RRx
 vBQKGU26exN3YQesnfc1JAmbuLzWzka2Pt7g9EjUaWUp4UP97bbwi8QoV8FHx3o5v+R3
 /ueXX/Li+U6gR7eOWv16Xl1nKd0AMKohGsHazXVULaiwlpUfJqrmI1Dp3ZDN+rcQNAuB
 RZDp82Md/IW/C2RvvQIT4c6AwmvArGp0AFVqhhz/ThEw7obRa8ORJ2/JKldeR6gf/v1D
 Fi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471214; x=1742076014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+NSju37Mir16Ju7IGTAiExpj2eXU+4Tqger0eVMhLE=;
 b=vtagZavzjDnUcl9G9UKLNLO/UtzcFs+7Emv0Og2ZYFXNDi6ePRC2G41BFIbhZ83Dhm
 N1ppcgTi2o8fh2eL0ZPjrnNUsXY4vTHcWlkOp3XxqBY+b+sx++ZLacqWDI/6tC3Pzu4J
 Y1jaaZXXjD4s12AE1FRuGumzOcOgPbquqRKnrw0jE6vdrepNf67IYdAr3XtKopl27VOE
 3LTSSKo1Ipp7YMJCR3+Wf8p5R8eCzkG0pcY50SuwBWl//gHLXDxruf8y8IWAvzR1GcMB
 VNlAXG2la9RELd95fmReTfR8poUuQcGr11zCRLrpSWsllXdbF8+PaPDiW2aRBFuPvec9
 WlyA==
X-Gm-Message-State: AOJu0YyS4AzB97qIvbVSXipKjlVYHbA0tH2V50wZ/uizyfg6DaWakfaf
 +u/NM9Kd+rH+38dXCQG0D3MD2GLrdotO3RDYBUcTvNmFsrpqH6fp2Ga54rRB6jU=
X-Gm-Gg: ASbGncu3AAkSX1//pYx/Ffx2rpE71gXhB+HtDxjSJfudlGdURhoTwikI3oQ3SFMdG2B
 1KGYO0m71USng5U48O5iJgtYTwKsyXmi75f18gEZUD4inTJZcdGf8pD5icSCEEOtIKz59bRmIWd
 OOcym8vHMTnfJ0aehENd6cPrKc0OJBb4fxyRNle5R6uayzgTt+RjDQQ2mLK7C1hj6CpCS/VuXnp
 oGgoZG7WLD0xXlmS8OFWTew9qr/QyPYNsA3bUWO6dT2ZyP4LaTuvFlXvdiZcEGPNg4Ju0EKGRh5
 xLcnkowtDgg4v0FNi0hHjRoCvwC+0TwtL6/DkeA2mknpxj8=
X-Google-Smtp-Source: AGHT+IG/mrJ3oy7fK0fRnl3vIQ1QHj3IKbtEApNguGBupGuN+f1J3bZwZyPvm1gRYAM4hHJ1+VeO2A==
X-Received: by 2002:a05:600c:4f91:b0:439:a1b8:a246 with SMTP id
 5b1f17b1804b1-43c5cb68df2mr51710725e9.8.1741471213670; 
 Sat, 08 Mar 2025 14:00:13 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc13b23asm98962325e9.1.2025.03.08.14.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3472B60B21;
 Sat,  8 Mar 2025 21:53:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 27/31] plugins/api: split out the vaddr/hwaddr helpers
Date: Sat,  8 Mar 2025 21:53:22 +0000
Message-Id: <20250308215326.2907828-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

These only work for system-mode and are NOPs for user-mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-28-alex.bennee@linaro.org>

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
index ffccd71e4b..82241699a5 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -383,76 +383,6 @@ qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info)
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


