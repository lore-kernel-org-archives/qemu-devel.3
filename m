Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CBBC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmu-0005ME-8B; Wed, 23 Apr 2025 20:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kms-0005JO-1p
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmp-0004M7-DM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so349426b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455794; x=1746060594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JDsL2T5fLn8J7LULI7fiLOiZlumyxDt8T+y0OhrNdA=;
 b=zYT7SZAOIP7ToQfmFHMN4KdUYZrQQtRPGIWXbsFc4/cWoQH+aa4OCFnOhn3tPtwACA
 nmlVdSturp2plTRuGqT9kHnhBnBTrkUM+PI2Uwz7SQMrD5HP6eRyjp3w90J9Y8+Is8PA
 YLC1ryiCb6R7Oick3+GMJz83lmK4wrLzGMm8hKN2J2tqdFWzE3/MujF1R3djeMimVdW6
 feAoHDsBHNryu1FLfnRSeA5mdwM+zyIUta8AOiULZy6UztS82FY5JWlGVcsuwj6CJ1BM
 mcbRhMq6rz30V5/Xkc/9Sf/IITIe8oXiCK0Fs4mMPjdQ2U7gGIeuY+S1H0afeP3jOC0Q
 nPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455794; x=1746060594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JDsL2T5fLn8J7LULI7fiLOiZlumyxDt8T+y0OhrNdA=;
 b=cOTx5IQcvv1EnkJub8AcjZ4sSQVoSRfEUTj1K/ynj9LI92BeDoocCLJsKD87Lvts+X
 YGuegiXjFhEKkzP8PjZCg0/Io7zpgnXJG5JgZvdzDcirYBztwLVQmMVkNI7uvRuugjmR
 r35RDspB3LeOmOKb/9jMvWjzVVTwaLDGe1rziLeQh7dsxQlMkBSIngFqHweawoXOxzJb
 aMh1oIyFPWrg4UgzK0td6BhfBd8uCPKDfAe4hhNM7hKZNY0lfGHHDYnex7vSec5iGplr
 j2wwWhfPH88bhmgHbRM/8oJ2tU6bts7FjgUA5sndzxTPPOOO+nRJoX286ZqSgixsDyXs
 nXTw==
X-Gm-Message-State: AOJu0YwTa5gJnJ2opjHzmPxz+IBnuVssUaE33koB0jY7XY88LuNFwTnm
 alM7hbq+ypYyBEdhNS3gvyqQSaqYQsyZqZQjKBAkXmMbsAZzYu5FNZ0NzrsbftIfdQRjv7OqyWN
 E
X-Gm-Gg: ASbGncustQB1jP5+LjOCoXlN1dBY4ed6JvCS86nA+FfAKod7fmePHDsMmyZweLNV97t
 v0rJHSQ3j+lj1RTdO6Du6IByXrvu+mE7z97L3h8uwgfArrX6hYERKuuYVGXXJqvgu7Pe/rp1o5N
 MABmfKdL9QISRt5Dg0UWfDKtWApTT+nv5DGTVZPOk9PTlYmLkLfS/eBqIunJulKMdUKY/I2lnhP
 2d7+UtDRnvXGpQUcRp13XbqxIBNYqRca5ui1pnl/viKdEXJGqjg/pqZ3HD6eXVOTfnUF7+PokKG
 31o+ovDDUrXPtdrhqd0aFMlxWxScu3CZ+vW8IEP/eaQobPzoeYknp7W9dpFKVrxaWUVM37iUPT0
 =
X-Google-Smtp-Source: AGHT+IGgLivJ4ma17VxmN+oHlRa9KyBAfPA/rK09M+An/KliyUKjtaBgFfYjDEc2O8CN/Ky6znn6Lw==
X-Received: by 2002:aa7:9315:0:b0:739:b288:13e7 with SMTP id
 d2e1a72fcca58-73e24ae145dmr1024508b3a.15.1745455793952; 
 Wed, 23 Apr 2025 17:49:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 024/148] include/exec: Split out accel/tcg/cpu-mmu-index.h
Date: Wed, 23 Apr 2025 17:47:29 -0700
Message-ID: <20250424004934.598783-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The implementation of cpu_mmu_index was split between cpu-common.h
and cpu-all.h, depending on CONFIG_USER_ONLY.  We already have the
plumbing common to user and system mode.  Using MMU_USER_IDX
requires the cpu.h for a specific target, and so is restricted to
when we're compiling per-target.

Include the new header only where needed.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-mmu-index.h | 41 +++++++++++++++++++++++++++++++
 include/exec/cpu-all.h            |  6 -----
 include/exec/cpu-common.h         | 20 ---------------
 include/exec/cpu_ldst.h           |  1 +
 semihosting/uaccess.c             |  1 +
 target/arm/gdbstub64.c            |  3 +++
 target/hppa/mem_helper.c          |  1 +
 target/i386/tcg/translate.c       |  1 +
 target/loongarch/cpu_helper.c     |  1 +
 target/microblaze/helper.c        |  1 +
 target/microblaze/mmu.c           |  1 +
 target/openrisc/translate.c       |  1 +
 target/sparc/cpu.c                |  1 +
 target/sparc/mmu_helper.c         |  1 +
 target/tricore/helper.c           |  1 +
 target/xtensa/mmu_helper.c        |  1 +
 16 files changed, 56 insertions(+), 26 deletions(-)
 create mode 100644 include/accel/tcg/cpu-mmu-index.h

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
new file mode 100644
index 0000000000..8d1cb53bfa
--- /dev/null
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -0,0 +1,41 @@
+/*
+ * cpu_mmu_index()
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_CPU_MMU_INDEX_H
+#define ACCEL_TCG_CPU_MMU_INDEX_H
+
+#include "hw/core/cpu.h"
+#include "tcg/debug-assert.h"
+#ifdef COMPILING_PER_TARGET
+# ifdef CONFIG_USER_ONLY
+#  include "cpu.h"
+# endif
+#endif
+
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ */
+static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+#ifdef COMPILING_PER_TARGET
+# ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+# endif
+#endif
+
+    int ret = cs->cc->mmu_index(cs, ifetch);
+    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
+    return ret;
+}
+
+#endif /* ACCEL_TCG_CPU_MMU_INDEX_H */
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 66a4252269..33b9dc81eb 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -34,8 +34,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #ifdef CONFIG_USER_ONLY
 
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
-
 /*
  * Allow some level of source compatibility with softmmu.  We do not
  * support any of the more exotic features, so only invalid pages may
@@ -45,10 +43,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
 #define TLB_WATCHPOINT      0
 
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return MMU_USER_IDX;
-}
 #else
 
 /*
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3771b2130c..be032e1a49 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -272,24 +272,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (CPUState *)env_cpu_const(env);
 }
 
-#ifndef CONFIG_USER_ONLY
-/**
- * cpu_mmu_index:
- * @env: The cpu environment
- * @ifetch: True for code access, false for data access.
- *
- * Return the core mmu index for the current translation regime.
- * This function is used by generic TCG code paths.
- *
- * The user-only version of this function is inline in cpu-all.h,
- * where it always returns MMU_USER_IDX.
- */
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    int ret = cs->cc->mmu_index(cs, ifetch);
-    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
-    return ret;
-}
-#endif /* !CONFIG_USER_ONLY */
-
 #endif /* CPU_COMMON_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 1fbdbe59ae..740f5d937f 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,6 +67,7 @@
 #endif
 
 #include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 382a366ce3..2e33596428 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/cpu-all.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 1a4dbec567..be38016fc7 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -27,6 +27,9 @@
 #include <sys/prctl.h>
 #include "mte_user_helper.h"
 #endif
+#ifdef CONFIG_TCG
+#include "accel/tcg/cpu-mmu-index.h"
+#endif
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index fb1d93ef1f..a1ade9079e 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index abe210cc4e..6418d4bb03 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -20,6 +20,7 @@
 
 #include "qemu/host-utils.h"
 #include "cpu.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 930466ca48..f8965cd155 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "internals.h"
 #include "cpu-csr.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 27fc929bee..022c98f0c3 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index f8587d5ac4..2d18659b99 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 
 static unsigned int tlb_decode_size(unsigned int f)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7a6af183ae..da033bffff 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 5716120117..57fbf16ad2 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "hw/qdev-properties.h"
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 3821cd91ec..78cb24a8e2 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index a64412e6bd..b1ee126112 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -20,6 +20,7 @@
 #include "hw/registerfields.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 63be741a42..40b02f0a2c 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -33,6 +33,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 
-- 
2.43.0


