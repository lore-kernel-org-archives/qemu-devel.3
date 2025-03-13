Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C31C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW9-0004gT-R6; Wed, 12 Mar 2025 23:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW7-0004fH-Gu
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVu-0007mG-6N
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223959039f4so9366575ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837536; x=1742442336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaCm8HGnBw9Ar6x9XjuT/bwVlFd4+el4jyUvbo0vDuc=;
 b=JVvX6D1XfyLK0wXjdmpmBz4H6ZZtHJGxkx0rgo0OTeOARpMWZai8UCLW4JL8VHNNTT
 Eq46McCcgWiX2ek4eF6/o+urtgUshMO2cgIH1kj8/qoHKMrA+1l30m+v+vzrDSWz1qTB
 f4JvwTr1mUBFy0OQ59YLXgIqNegQxjcfXJd3oIbrjYkzJp9As8HbEOIgbBElSPScTaZ4
 NcJUedw53SOl8uAbGVCF6nSX/ZXpGQ7WYKbAgN594QDsLqcZC3EjnjgawY1D/VN6S1Ng
 QPPHKKX2/YGUvHQq87Dw8Uteg7NJj3Jc268J74WfXzItkufrQMpVIrF72FW8ZjHQ9tix
 dQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837536; x=1742442336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaCm8HGnBw9Ar6x9XjuT/bwVlFd4+el4jyUvbo0vDuc=;
 b=XBJ8i3K3lpSJeFRo9bHtnQ3ed4JdV9Sz9KUMZl/NQ3hWRulACByTghK4drqJXNZcgY
 5xNoYxc5rKZTmX9KwByOeOJMxk458OmpjVKLHxRZb8evkDDE5z4lgcJHhi2ZIYsTO8cH
 s5zhqG0ztXRnkoDoR0zTlFn7F2JOqZG6XiPhOiI/EpvE8k1/bZjcnQUmIbvnnam0O/Ub
 oxteTJEN6lHN9itTt9wGCTOlP/7QO/UM3HaLrJ0km2rA8q57L2rK3BVFmBQcTKnFB8z3
 TDDx+f42WZqIM2pbxs19qH0X1hGpVtl2lw/5DC1yF1VnQm0SLtt5ACpBNN0BoI1suk7N
 WQ2A==
X-Gm-Message-State: AOJu0YwaCHGsm79kTP/PxkQaJRTUyfdtpLgbmAMZ804IRQj3RhNIdGma
 xz2Qze/mQvAxQaFOpE0etp4UfYXtkW6BTaTMoLIETPvy9Flwezk+bV4vbUwFzapTcKzL9Vto9MQ
 Z
X-Gm-Gg: ASbGnctzr82/kv9GwGpWYvx9gb4W7nGB1ohgTmGuzn1J1GlhfXZBQXnmcKwLeTEeyIa
 lkABZof18qebq4SSrxlYc6uZv1hC3GCBebGOf2fWFN0Oj8Eqj8oZx5vlrdU+PzEoPRm6M0BUZkS
 gklZ12cA/EoOhN1mZ8dKPxydoEVsrr4CSBy9kmsyywoVE4A6KJi1V7xFDm/BNUtkEY+m2XL9f1m
 p91Zu2VKBzOADX5CVexqObDN2ke3iwMljI55j2IcMkCQePcpdOhZ2eLssvIbHAOKvjZJh11alBB
 gguZYX28P5XD8uvNhWjbzWa7WhuXQAT1XJX+zyRuodlsYg0maMY+TEASaUme/jcMl2MDlr9B4ZI
 A
X-Google-Smtp-Source: AGHT+IGUF9mPUTYfSw6JDARP0MnUc+3AnFu7rQPlxO4Tm9hdRhCzlXAzjb3AbZ1Tbuwi2YDJ9BBarA==
X-Received: by 2002:a05:6a00:17a7:b0:736:9f20:a176 with SMTP id
 d2e1a72fcca58-736aa9f1135mr40093158b3a.8.1741837536428; 
 Wed, 12 Mar 2025 20:45:36 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 13/37] include/exec: Split out mmap-lock.h
Date: Wed, 12 Mar 2025 20:44:53 -0700
Message-ID: <20250313034524.3069690-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Split out mmap_lock, et al from page-protection.h
to a new header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h    |  1 +
 include/exec/mmap-lock.h       | 33 +++++++++++++++++++++++++++++++++
 include/exec/page-protection.h | 22 ----------------------
 accel/tcg/cpu-exec.c           |  1 +
 accel/tcg/tb-maint.c           |  1 +
 accel/tcg/translate-all.c      |  1 +
 linux-user/arm/cpu_loop.c      |  1 +
 linux-user/elfload.c           |  1 +
 linux-user/flatload.c          |  1 +
 linux-user/mmap.c              |  1 +
 linux-user/syscall.c           |  1 +
 target/arm/helper.c            |  1 +
 12 files changed, 43 insertions(+), 22 deletions(-)
 create mode 100644 include/exec/mmap-lock.h

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 2cdf11c905..c88f007ffb 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -13,6 +13,7 @@
 #include "exec/translation-block.h"
 #include "tb-internal.h"
 #include "tcg-target-mo.h"
+#include "exec/mmap-lock.h"
 
 /*
  * Access to the various translations structures need to be serialised
diff --git a/include/exec/mmap-lock.h b/include/exec/mmap-lock.h
new file mode 100644
index 0000000000..eb02dd409c
--- /dev/null
+++ b/include/exec/mmap-lock.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU user-only mmap lock, with stubs for system mode
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
+#ifndef EXEC_MMAP_LOCK_H
+#define EXEC_MMAP_LOCK_H
+
+#ifdef CONFIG_USER_ONLY
+
+void TSA_NO_TSA mmap_lock(void);
+void TSA_NO_TSA mmap_unlock(void);
+bool have_mmap_lock(void);
+
+static inline void mmap_unlock_guard(void *unused)
+{
+    mmap_unlock();
+}
+
+#define WITH_MMAP_LOCK_GUARD() \
+    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
+         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
+
+#else
+
+static inline void mmap_lock(void) {}
+static inline void mmap_unlock(void) {}
+#define WITH_MMAP_LOCK_GUARD()
+
+#endif /* CONFIG_USER_ONLY */
+#endif /* EXEC_MMAP_LOCK_H */
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index 3e0a8a0333..c43231af8b 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -38,26 +38,4 @@
  */
 #define PAGE_PASSTHROUGH 0x0800
 
-#ifdef CONFIG_USER_ONLY
-
-void TSA_NO_TSA mmap_lock(void);
-void TSA_NO_TSA mmap_unlock(void);
-bool have_mmap_lock(void);
-
-static inline void mmap_unlock_guard(void *unused)
-{
-    mmap_unlock();
-}
-
-#define WITH_MMAP_LOCK_GUARD() \
-    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
-         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
-#else
-
-static inline void mmap_lock(void) {}
-static inline void mmap_unlock(void) {}
-#define WITH_MMAP_LOCK_GUARD()
-
-#endif /* !CONFIG_USER_ONLY */
-
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ef3d967e3a..372b876604 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -27,6 +27,7 @@
 #include "disas/disas.h"
 #include "exec/cpu-common.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3f1bebf6ab..d5899ad047 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -24,6 +24,7 @@
 #include "exec/log.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 82bc16bd53..16e5043597 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -45,6 +45,7 @@
 
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "tb-internal.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 10d8561f9b..cb6e17e50c 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -25,6 +25,7 @@
 #include "signal-common.h"
 #include "semihosting/common-semi.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "user/page-protection.h"
 #include "target/arm/syndrome.h"
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8799e4ea27..f54054dce3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -10,6 +10,7 @@
 #include "user/tswap-target.h"
 #include "user/page-protection.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
 #include "user/guest-base.h"
 #include "user-internals.h"
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index d5cb1830dd..4beb3ed1b9 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -35,6 +35,7 @@
 
 #include "qemu.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "user-internals.h"
 #include "loader.h"
 #include "user-mmap.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d1f36e6f16..f88a80c31e 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "exec/log.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include "qemu.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b32de763f7..4928f0b080 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -26,6 +26,7 @@
 #include "tcg/startup.h"
 #include "target_mman.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include <elf.h>
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f0ead22937..8316beead3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -14,6 +14,7 @@
 #include "cpu-features.h"
 #include "exec/helper-proto.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
-- 
2.43.0


