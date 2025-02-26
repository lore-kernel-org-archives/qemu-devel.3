Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4E5C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI9G-0007CJ-LD; Wed, 26 Feb 2025 09:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8b-0005RC-8m
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:11:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8X-0007ZC-5B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:11:48 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so60168425e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740579103; x=1741183903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFdASjaX52m/LFBMdNIH+YRGWtE+XbpwGlPffnilBbc=;
 b=syisNZssjAHCxXkFkV0CllLHmJDGR/vW0g4InZ2ZUnGYxFslVT5C0RPqUD87j/JU0r
 pgn8UN1ZabsVXtAzZuDz21wioGVXJh0zcX6U5vh9ezUu2LUmZu+KhOIMEZCbzr+kyWDW
 37oXcE37gq2KOVB2+4wM9RKrVnkrKsvZt8+wRoGpR7uU9Os6nuWRjauLXwToKGrQ/vjq
 rLM0UoiL+LOyKgmhIyb+NMv8BNZg1n8U671t6Swe/ELfrRHOOX4U25jGYGATR/IIx5In
 nIuVV556dhQ9oLQXmDxM65lJcCCTLLs3e1VzY/5mXIKv9XKe6zzf6M7vUAvddoOeVbrp
 9Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579103; x=1741183903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFdASjaX52m/LFBMdNIH+YRGWtE+XbpwGlPffnilBbc=;
 b=dd7tkhn9U472dtiHiD1OkGmUWV1KWEQdVHjeun9fmVa9hS1pnvtQOXdgRjhMlpxuvs
 F/+Xr0/Mo8QMHLdpr3FOX8cNoatxP8ZN4n3ivRmI1M7P096MefVk/0LjvX0QOEmHccsl
 8t0eZUW/PcsA5gW//kwEDR2drSvtX+9xML3OrVwMTNtMtbym6IUwHCe2cndegahJROLr
 iZpHc1iiQM1VmmGne/S4zGCrrZ/zjOgNynXlMD1OhcOirE0xDc5fqcl/6dOIDsf17xm9
 C0QH6iui9cgKVV+e6JODCuimWGy3LG/9U6bOIB0cyVMo53by7lk84c7j1mNYtgmEG47e
 QTMg==
X-Gm-Message-State: AOJu0YzS1oXDnA5LpsE5fsuR6iMyJm6zWcaogV/wQ1FdHI4jg/3/yA2x
 sAeB7ke35SuhejQUrpbgIGSR/mJsR1cSMyKL8iCVEKBA9CEU3OZw8iULcTViKy8=
X-Gm-Gg: ASbGncsRaIzLSPqm36XsEPHNT3tKRYnOkgyK26pe4OuQ6yY8wAZgOKs8EAqxWuOiXR2
 o1Gz+VyoPTZkR55WbCGuqvWNjgZE/s63gsaYleXb7GnMwwoyS5Y01u0lu39Tkw84eQSPK9W1Ecu
 PiFO9utq3RZ4E0+9DoMyGHCPQeJbw0CsIF9jbJzSbZzgqgAGoF2ckDstl0qUyoaiKIt1hj+12/6
 ggleVL9p3vajIci0Ylgm179cgj0xeUAv4OlRnxYN/uMC6yfQRrmOEaKuxEOxzs0J2FCbw4L9lc9
 IRTxorFhW6PwSo+1YHrqJQCvQRZ8
X-Google-Smtp-Source: AGHT+IHIZKv/rn4CKhDiNy6dg0I6jgrot4jwFHquIT8dVOKLfVgh4vqogplzc8/LT6RCruY+7dxmQg==
X-Received: by 2002:a05:600c:444e:b0:439:9543:9488 with SMTP id
 5b1f17b1804b1-43ab9015589mr26128155e9.21.1740579103243; 
 Wed, 26 Feb 2025 06:11:43 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532d33sm22850475e9.15.2025.02.26.06.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:11:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1DBB66086F;
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
Subject: [PATCH 22/25] plugins/api: split out the vaddr/hwaddr helpers
Date: Wed, 26 Feb 2025 14:03:40 +0000
Message-Id: <20250226140343.3907080-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-9-alex.bennee@linaro.org>
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


