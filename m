Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5474C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLw-00016F-3H; Thu, 01 May 2025 17:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLp-000120-TB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:50 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLn-0001ak-Iw
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so2103756b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134506; x=1746739306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0jG93rvSyOgsjKDUChcn5N32sYYanMJMMGrdtwKZxY=;
 b=QMlcc1Pz3/7mDpWe+0ru9Ov24mfZcfXAsKX7X/7lxlpLrYIeHVKRahpYDKLT0OPQMi
 KwwFwTFWOWa8SoF6a6okAPDaXGxmD8SkYu3B8Bf7tUZpmUIOvBxmcAV6dKnN3AkxWQzz
 OJquIv08SW3nqpJ79afiemp9hlizw28w/9znR+bknjiv91qYBlCwcNKSYx/6JNrZdJcd
 vBZ/8+1rMN8ESzjlS4sDYrlXfLM19L60IejprrGVXtgVsZtdbma/L7+Yq+5nw25sWsVU
 M1ozfMxtnYHIy/uN0HK6zKCsMPZrNyEwOFH2qGuIg5Mg1v1YTFegSubOXzZusuw/LRG2
 iDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134506; x=1746739306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0jG93rvSyOgsjKDUChcn5N32sYYanMJMMGrdtwKZxY=;
 b=ghvVfeFjy3/OYGgTf5CafEq7TdfiU2XogOaUoosG8aE2Pqys0p+wODXZ7oDyPHt6v3
 1ePnZwcNnA0RphbjibzL5NejjNzjCg8QtmPp1ilKH2nil4ZEcwHqu9fz/ax9lfxIzOBQ
 oun41/ESISmPNb66yvSED8cx+QRb1gZ7oNpVxjfz7wCJ5+fR64szrwhadE1m1uGxdPPD
 Ly6PZ3nTNZL0h+9N5ooM/fmou4iF1zRXfBmfBLStwKzRRIu9h/cjc27aPI0iM1nZ/XA0
 WYHw9VKFEeWIwti1WveeNzf+VdpqpbjSlO6xkkkVnm2g1EkbrBmX+p1q9919G6Co/uj4
 P+qA==
X-Gm-Message-State: AOJu0YwYl3mirC1tWrNv1VLEAX4QXRSFHsrxGDB8Kbcnje12O/t9K1M4
 247wO67BDw8ptA2Tl+rhCBiSBq9R6LwB6SX1yEptQpWxOb8SNkcd2SD+1K2CPdQEL7x7LTAMolG
 t
X-Gm-Gg: ASbGncvIGxGUFGcy0ITeio8qd8mYrpDFd3Gm1dnuHUDaHwrVmyG/jEUYtsEHgPpxeST
 SkoR/TufSmy+6eJvwjC/R3SgH0+89tUgrD8N+LdAUoEhuyJ7STZitiWdkpAiONlwQ6SEu6gzG2i
 ZQyiVsf7gbZ+Q7G6yRuYLYqwngvj7c8QA8qqRxWzaPDMRRDyJnVwOXUYLEJ2z1eoC9SmLPFTCyA
 zQ9H7FtDfiJJolVvc0S8JuqtDbUXV0pZkkyccz/UlsX6UW2UyT54jDmdhmLOXEyF/ARpSdwIAG9
 DJYC3HTFvWF0EFqW+xCG5DK+G7pROtruH0hNLzYaRPgEXJxpmJOZgvT3parTyB0th+coL+uC1IE
 =
X-Google-Smtp-Source: AGHT+IHmxZ2kTAiYA/CM6OCZj/WYwqHgAUaby0RisE9Xan19iLJtZqlWm6CnHZkWBNFIL9dqvspr4A==
X-Received: by 2002:a17:90b:520a:b0:2ff:693a:7590 with SMTP id
 98e67ed59e1d1-30a4e6bf082mr934344a91.33.1746134505980; 
 Thu, 01 May 2025 14:21:45 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 38/59] accel/tcg: Split out accel/tcg/helper-retaddr.h
Date: Thu,  1 May 2025 14:20:52 -0700
Message-ID: <20250501212113.2961531-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Move set_helper_retaddr and clear_helper_retaddr
to a new header file.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst.h       | 34 -----------------------
 include/accel/tcg/helper-retaddr.h | 43 ++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c               |  1 +
 accel/tcg/user-exec.c              |  1 +
 target/arm/tcg/helper-a64.c        |  1 +
 target/arm/tcg/sme_helper.c        |  1 +
 target/arm/tcg/sve_helper.c        |  1 +
 target/ppc/mem_helper.c            |  1 +
 target/s390x/tcg/mem_helper.c      |  1 +
 9 files changed, 50 insertions(+), 34 deletions(-)
 create mode 100644 include/accel/tcg/helper-retaddr.h

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index f97a730703..44a62b54da 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -526,38 +526,4 @@ void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
                         MMUAccessType access_type, int mmu_idx);
 #endif
 
-/*
- * For user-only, helpers that use guest to host address translation
- * must protect the actual host memory access by recording 'retaddr'
- * for the signal handler.  This is required for a race condition in
- * which another thread unmaps the page between a probe and the
- * actual access.
- */
-#ifdef CONFIG_USER_ONLY
-extern __thread uintptr_t helper_retaddr;
-
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-    helper_retaddr = ra;
-    /*
-     * Ensure that this write is visible to the SIGSEGV handler that
-     * may be invoked due to a subsequent invalid memory operation.
-     */
-    signal_barrier();
-}
-
-static inline void clear_helper_retaddr(void)
-{
-    /*
-     * Ensure that previous memory operations have succeeded before
-     * removing the data visible to the signal handler.
-     */
-    signal_barrier();
-    helper_retaddr = 0;
-}
-#else
-#define set_helper_retaddr(ra)   do { } while (0)
-#define clear_helper_retaddr()   do { } while (0)
-#endif
-
 #endif /* ACCEL_TCG_CPU_LDST_H */
diff --git a/include/accel/tcg/helper-retaddr.h b/include/accel/tcg/helper-retaddr.h
new file mode 100644
index 0000000000..037fda2b83
--- /dev/null
+++ b/include/accel/tcg/helper-retaddr.h
@@ -0,0 +1,43 @@
+/*
+ * Get user helper pc for memory unwinding.
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_HELPER_RETADDR_H
+#define ACCEL_TCG_HELPER_RETADDR_H
+
+/*
+ * For user-only, helpers that use guest to host address translation
+ * must protect the actual host memory access by recording 'retaddr'
+ * for the signal handler.  This is required for a race condition in
+ * which another thread unmaps the page between a probe and the
+ * actual access.
+ */
+#ifdef CONFIG_USER_ONLY
+extern __thread uintptr_t helper_retaddr;
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+#else
+#define set_helper_retaddr(ra)   do { } while (0)
+#define clear_helper_retaddr()   do { } while (0)
+#endif
+
+#endif /* ACCEL_TCG_HELPER_RETADDR_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index a7436d2873..a8fbda31ba 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -24,6 +24,7 @@
 #include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/cpu-common.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 70feee8df9..68e01fc584 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -26,6 +26,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
 #include "qemu/main-loop.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9cffda07cd..4f618ae390 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -30,6 +30,7 @@
 #include "qemu/crc32c.h"
 #include "exec/cpu-common.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 3226895cae..de0c6e54d4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9f20ecb51d..a2c363a4e1 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -30,6 +30,7 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/probe.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index aa1af44d22..6ab71a6fcb 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 857005b120..a03609a140 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -32,6 +32,7 @@
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 
-- 
2.43.0


