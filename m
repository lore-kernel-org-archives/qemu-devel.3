Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E7C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLh-0000to-JF; Thu, 01 May 2025 17:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLU-0000m6-9r
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:28 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLS-0001Sf-4k
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:28 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af50f56b862so1014280a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134483; x=1746739283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gx1D17kjC4RgXXRQvEjiHkImf6y4k2mPs3w7o5UMf50=;
 b=CYVrwFFozIX8Nq+vutC3d/tpm8WbeMDZITShY7NWpVDtkVxRquiZsTCSuJ6ODsKWpc
 +X9FGcEp1iWMesKpf6skXDgpYslVQCWLIs5vpZbr2Qostgnvm87gaTvy1T4pim4ugBfD
 xT/7XC4FlD8UGEsOjTxc+uA+VUdrqPaY+2Sblv3vuTV/obt36el4qeqPaVhyrbRySwWD
 wOHDR70gm3jeOgmYb2Cs8kcdCEdne71JrZYgQdGdW0HANp6nrTTD/lUsNqy2IdRfdDZo
 ZOlMH/Di9AOtj/Zm177TXT1dle7ZyPmbVcEA6drFUpoONskQrAvxsB/ML5w7DZ2xwnFa
 GCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134483; x=1746739283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gx1D17kjC4RgXXRQvEjiHkImf6y4k2mPs3w7o5UMf50=;
 b=PPbonteN7S0ENupL1Y8n2ZlFEuot7RP/zZc8wBjLBmSYsBpRa3iRexndIq+wuFIqHC
 8UGnOHml0y19WxxusZ8gBlyKyll9AVI2ztcATOS2i+QXCHroA6ThDNo3zeH/BnSXS5X6
 KHS9dTRJDPswkSEPxTDjNRf9vaGRffW0nfZUs08lE/DIck+ouposdmZBIOUyuQWqj5Fj
 IXa/6y7hcqbHrwdFGiJZlCcv19wzh/KaK65MZ4gSUp7UKI1PefdGgPpvjoSenDSobsgI
 2S/5mOLwMfdcDYL9oX98UTR3OHa5ESgvO+YUgh5FdemT+7vAVTCys3IUvdHZXU0l50I9
 78AQ==
X-Gm-Message-State: AOJu0YyXlZJXofkQSK8QfAiFTC31nOAHoxyBuMj9QeO2OsifGGvX5UDV
 ZWLP06TtrJ5lCooGSmQ3VX8jLZh4vqFgA1ONTIjqAMVWVnXlkkFoQ9c8IM5mupzBOKWZCre+1Tm
 o
X-Gm-Gg: ASbGncvbP0ml9WIbYu2fO0drdWI3B99y7cphu0FENUjkLTF84YjQm2WM+vIozxh3dz9
 6NwmSc7MH0r+D4xG+5rc/If96UXmzXSRLS4Brq1h49By4YvRBeJQ50y1Yr/pDtL+Kq2ZGXZsjX4
 VHsxZyaCu3ddek8PNp+H5KKVkSTZgU3pTgJ3ngVtsFLDuEbGrtqRNYGBbJ+6wJ1CDPsKvdyHu7B
 Qp15gyJwC3ZopdRpamU1xwwAGDfJOAos12nkssKjWvPEtLPZgSPpC0fZyPX3zC97Ssy08QxgqIQ
 h0r1xT2QLtXoX6vK6yq2FcDiVozBWOTKVcr5GYBGhjVfpz8eaRDxdmZZ3aGqh6DORrXh0VF5Ya0
 =
X-Google-Smtp-Source: AGHT+IHzMMmbPcmEYqc+C1L/1QcPTWCILh+ZKKW26ZYnaOu92lhT6oqz00fruVW5HMPU8vPVrTsLig==
X-Received: by 2002:a17:90b:2dd2:b0:301:c5cb:7b13 with SMTP id
 98e67ed59e1d1-30a4e55f5c3mr829333a91.3.1746134483192; 
 Thu, 01 May 2025 14:21:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 10/59] accel/tcg: Merge internal-target.h into internal-common.h
Date: Thu,  1 May 2025 14:20:24 -0700
Message-ID: <20250501212113.2961531-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 87eba83d7d..279df5fae7 100644
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
index 13d0376bc7..b144fcd4a0 100644
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


