Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46866C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lGt-00056r-7G; Wed, 23 Apr 2025 21:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFT-0002lV-36
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFQ-00079v-0G
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so385201b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457566; x=1746062366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jtt7Oh++1fV+Vh2SgiqUZ2mBLC6qZ0dag5VMp1U8aEA=;
 b=fXv9L5kU5qBcxXFanRDYBVw91WhpnqfwSWMYExouvTP3q712KZv5nEgOhcM6O0eDw/
 wDUWdV2lqjdmMAQ26hOW89qLiDJV+uk9hT8gnWzzCvDeX0SMyKMw7suDAqDKdDcqIWSH
 dUSEe88LazlQ3JOB4Sudqr3FsKigrYgjOv6OjlyJwapMwTFVCmYMC56j4deSznOgb9HU
 EL5/2ddLn8vyWUrR4KwOYw8nIHJ2hWqE1RsLG1Zfb8fqRl8VFcVZcFPEHweOQdb94M5K
 Yn8mKTDaicDYDOGMyD42BW0lQ9UpGfugF3ZadoaGBp1DZfRGJq7BTKZOSTZMmBJxlLki
 7ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457566; x=1746062366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtt7Oh++1fV+Vh2SgiqUZ2mBLC6qZ0dag5VMp1U8aEA=;
 b=cz3SVYFtYw72AvVoVVu9C7IhybNkz2f8dv51VKrZax0Ne/9by6GPzCJJlIxHfhaqhW
 /sj+XTgYxFUTgfU8DXC7MBHsfSTiK0mTikq4u0kl/NQ3Kz6hBpG1UR0IXt/NLHGmJCOr
 CPi7F0g4kGHeZaHbpMAUCYbiay7Hcqwdq/9xZqi4i7LJZFd2Y+ySkWTXmgYT52mnOBqQ
 a6oZfL678wanQ3TEzgJC2TAcM0bOxxhLurUvs6OIU5dH/L79pbLy0jxGR+RKwlzmXoZS
 5bmBWgHRE5nDia3MPPDNH8o/SPUO+L9NlsjNB2zpqEP7TVICgd/SalgY4cfypbxz2Mch
 kBjQ==
X-Gm-Message-State: AOJu0YwWwAbN55fRtzXxlIklFSmA5utNq2B9cE1jpcZlCg4mGLHI7qBq
 x+Y9gZ+vyIW/3KIxVsNPamUHti8FaCltLOZTLxIBgw2j+4drtD2PHlFB5Ihhg8EDaRtOH4xzhxI
 d
X-Gm-Gg: ASbGnctOagNgHECspu1ZVk29wsS2z8JpKDmrLcodZ0q4WQEy/xr9JrBQH/fRbHjd5PZ
 26PwpkVeFQE/oqmTDc0W4eXbH9hVraNykEgsEQUhRU/jDn3lcjLdW7qpvimVbpolIldDh+pjWWT
 lY1T1CMxv0Vrm9Eelf/U2YyuDCWERaYMfrGtJNxU4LrAdYMLOBmgw2fjZo/YT9rZkgpHPYAN+GG
 uw7aIcdQKDs4T00BznBJ1jVv6ZH87IC7t4ZEsXi0oleS7czh+9zAPYXrQqmea7WuxbASGxe1gVd
 VPdLkz5MrifiLJ7iaROtnhGyHhcLG89xRevKtndG4T37PmvtUxKpxhc7gPPL61XLmE31a/L+gpA
 =
X-Google-Smtp-Source: AGHT+IFmYAB/pkkO231HW+jR7UBi7MWJXDoJhPRTSm5V2fS7MTPLAhRlZSmMHo4VFpqwMzE/De9Lug==
X-Received: by 2002:a05:6a00:3a22:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-73e24cfa09amr1267586b3a.20.1745457565871; 
 Wed, 23 Apr 2025 18:19:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] accel/tcg: Merge internal-target.h into
 internal-common.h
Date: Wed, 23 Apr 2025 18:19:13 -0700
Message-ID: <20250424011918.599958-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

There's nothing left in internal-target.h that is
target specific.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 29 +++++++++++++++++++++++
 accel/tcg/internal-target.h | 46 -------------------------------------
 accel/tcg/cpu-exec.c        |  1 -
 accel/tcg/cputlb.c          |  1 -
 accel/tcg/tb-maint.c        |  1 -
 accel/tcg/translate-all.c   |  1 -
 accel/tcg/user-exec.c       |  1 -
 7 files changed, 29 insertions(+), 51 deletions(-)
 delete mode 100644 accel/tcg/internal-target.h

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 2f00560d10..573e8438c3 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -11,6 +11,7 @@
 
 #include "exec/cpu-common.h"
 #include "exec/translation-block.h"
+#include "exec/mmap-lock.h"
 
 extern int64_t max_delay;
 extern int64_t max_advance;
@@ -108,4 +109,32 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
     return get_page_addr_code_hostp(env, addr, NULL);
 }
 
+/*
+ * Access to the various translations structures need to be serialised
+ * via locks for consistency.  In user-mode emulation access to the
+ * memory related structures are protected with mmap_lock.
+ * In !user-mode we use per-page locks.
+ */
+#ifdef CONFIG_USER_ONLY
+#define assert_memory_lock() tcg_debug_assert(have_mmap_lock())
+#else
+#define assert_memory_lock()
+#endif
+
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_DEBUG_TCG)
+void assert_no_pages_locked(void);
+#else
+static inline void assert_no_pages_locked(void) { }
+#endif
+
+#ifdef CONFIG_USER_ONLY
+static inline void page_table_config_init(void) { }
+#else
+void page_table_config_init(void);
+#endif
+
+#ifndef CONFIG_USER_ONLY
+G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
+#endif /* CONFIG_USER_ONLY */
+
 #endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
deleted file mode 100644
index 9a9cef3140..0000000000
--- a/accel/tcg/internal-target.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Internal execution defines for qemu (target specific)
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * SPDX-License-Identifier: LGPL-2.1-or-later
- */
-
-#ifndef ACCEL_TCG_INTERNAL_TARGET_H
-#define ACCEL_TCG_INTERNAL_TARGET_H
-
-#include "cpu-param.h"
-#include "exec/exec-all.h"
-#include "exec/translation-block.h"
-#include "tb-internal.h"
-#include "exec/mmap-lock.h"
-
-/*
- * Access to the various translations structures need to be serialised
- * via locks for consistency.  In user-mode emulation access to the
- * memory related structures are protected with mmap_lock.
- * In !user-mode we use per-page locks.
- */
-#ifdef CONFIG_USER_ONLY
-#define assert_memory_lock() tcg_debug_assert(have_mmap_lock())
-#else
-#define assert_memory_lock()
-#endif
-
-#if defined(CONFIG_SOFTMMU) && defined(CONFIG_DEBUG_TCG)
-void assert_no_pages_locked(void);
-#else
-static inline void assert_no_pages_locked(void) { }
-#endif
-
-#ifdef CONFIG_USER_ONLY
-static inline void page_table_config_init(void) { }
-#else
-void page_table_config_init(void);
-#endif
-
-#ifndef CONFIG_USER_ONLY
-G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
-#endif /* CONFIG_USER_ONLY */
-
-#endif /* ACCEL_TCG_INTERNAL_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b00f046b29..4f1955d3d8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -46,7 +46,6 @@
 #include "tb-context.h"
 #include "tb-internal.h"
 #include "internal-common.h"
-#include "internal-target.h"
 
 /* -icount align implementation. */
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ed6de1e96e..ca69128232 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -43,7 +43,6 @@
 #include "tb-internal.h"
 #include "tlb-bounds.h"
 #include "internal-common.h"
-#include "internal-target.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index f43f5342a6..cf12a28eab 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -36,7 +36,6 @@
 #include "tb-context.h"
 #include "tb-internal.h"
 #include "internal-common.h"
-#include "internal-target.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9bf8728064..38819a507b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -66,7 +66,6 @@
 #include "tb-context.h"
 #include "tb-internal.h"
 #include "internal-common.h"
-#include "internal-target.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
 #include "cpu.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 112292b729..17e3be337f 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -39,7 +39,6 @@
 #include "tcg/tcg-ldst.h"
 #include "backend-ldst.h"
 #include "internal-common.h"
-#include "internal-target.h"
 #include "tb-internal.h"
 
 __thread uintptr_t helper_retaddr;
-- 
2.43.0


