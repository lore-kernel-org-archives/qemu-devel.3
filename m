Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8D5C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kro-0006El-1M; Wed, 23 Apr 2025 20:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015X-TO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqC-0004j7-0b
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso510857b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456002; x=1746060802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov1D5DRp2B1Vosai0+UfYupVFAv3Pz5JSReUzKCYE4s=;
 b=uKLQrOjG5yxJWNQfeCaFvtVzTWD/h+eUiyRuNS8N2cKV8vNi43LN5UuuspSX3T2OO+
 LOw3y7Zb7r57SYlUnCt5DgDqkomtjEz9+v8wKYUSpva2RrLkQ2rwHnQdsYknp8gygZr4
 TbUejk6pfP6Y5eRtCcN9Tvn/6JeWm5CLAdZTmeYjAp7h4dta36GahjKvkL7cjeXUmxYq
 8kG6pspWnIPuXZ3oZHKsi6OErMLr8OQ+glpMrDFJpVT5A7nIqsADraL5yRNxXjv8PQeV
 SrhOPfpsy8D9GZw0/uLW7iIHfba49wBoJcDPW3GftUub3vR6ismirWRytHm/Gh9FtCIc
 aHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456002; x=1746060802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ov1D5DRp2B1Vosai0+UfYupVFAv3Pz5JSReUzKCYE4s=;
 b=lJPXcChSISz4oiWFL+DxTYrIG/0L2fogYpZiXeAYFz//xkxFW6IAR8x2u77kZntYLJ
 A1pCfZI1vbFQU9IOxF1EkRz7xX6JkvZllXd52JDkTNIziY4UFHTcovIecZYGdR2qfifk
 wtVuhCH2G04FM3k5II4pUS5SnE1tWCKRt0drxd4eGYYYLeSMHklLjNOWKr4rUmLTA4dB
 vvJjEbYnLOSnl3+tnTYArJAJmVp2MlxH9ndkH4Xi40OvQysjAtEtQLXYTGefWawEZCjY
 YjWHmIi2EbaDjtaZJQ6SKIPhAmTz84aESQpmAwStDwEULmHuY22UqxSczKaeA0j5Pls2
 zLJw==
X-Gm-Message-State: AOJu0YyJJgQzsTT1fbLdllhES9A6Riyk77sfvRwjRz/GU3753rKnGLuu
 G7UHS8mDFS5JK2ox15DUOVfCin/veOpuO5Rf5o6qWlzmsbXhDRQB0W5LB1jfWoFdpF0rQ/YmVLt
 R
X-Gm-Gg: ASbGncsV0QCw24PYFSUq9/NQ0U0M1sLylyVuXj0/iJjdZxadKBuea5vzTMIbbmDUKGQ
 3XcWU4rDnSNpupYJ1g7CMc9WWYLiwCuFVuLFim02mMDKfa2SCIFocbbzZ4TZ+5fZJYnly8+HSG2
 TAIWzSfgbTVB4F9wWYtBC4lluhM2sDx0nFoH7EHxnea159dy59VYTl7AyvwekyKhi9lpjPPfdFA
 igT7q21fihmtfj/8almFlYwyUmrS0rUVkRvZtBeB9y7/qXGr6IoVxk3k0RmpFw22saKd/s51WRr
 5HcGsOg/eBnsMZzl7nyqavkSpmQqRA7mKS+jUU9eG2t8mNqDpFkIt3ulczKkg9qSIxpKNHn5GNo
 =
X-Google-Smtp-Source: AGHT+IFDW7rU5QFVZi06bpd8UzxBRGFIAY1Lb5BAM2nW4/0YV+w5yhDweqOfI481ROI5PxboPQomjQ==
X-Received: by 2002:a05:6a00:1412:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-73e268414d9mr535708b3a.11.1745456002434; 
 Wed, 23 Apr 2025 17:53:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 062/148] exec/cpu-all: extract tlb flags defines to
 exec/tlb-flags.h
Date: Wed, 23 Apr 2025 17:48:07 -0700
Message-ID: <20250424004934.598783-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250320223002.2915728-3-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h               | 63 --------------------
 include/exec/tlb-flags.h             | 89 ++++++++++++++++++++++++++++
 accel/tcg/cputlb.c                   |  1 +
 accel/tcg/user-exec.c                |  1 +
 semihosting/uaccess.c                |  1 +
 target/arm/ptw.c                     |  1 +
 target/arm/tcg/helper-a64.c          |  1 +
 target/arm/tcg/mte_helper.c          |  1 +
 target/arm/tcg/sve_helper.c          |  1 +
 target/i386/tcg/system/excp_helper.c |  1 +
 target/riscv/op_helper.c             |  1 +
 target/riscv/vector_helper.c         |  1 +
 target/s390x/tcg/mem_helper.c        |  1 +
 target/sparc/mmu_helper.c            |  1 +
 14 files changed, 101 insertions(+), 63 deletions(-)
 create mode 100644 include/exec/tlb-flags.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 4395fd08af..5c4379f0d0 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -35,69 +35,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #include "cpu.h"
 
-#ifdef CONFIG_USER_ONLY
-
-/*
- * Allow some level of source compatibility with softmmu.  We do not
- * support any of the more exotic features, so only invalid pages may
- * be signaled by probe_access_flags().
- */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
-#define TLB_WATCHPOINT      0
-
-#else
-
-/*
- * Flags stored in the low bits of the TLB virtual address.
- * These are defined so that fast path ram access is all zeros.
- * The flags all must be between TARGET_PAGE_BITS and
- * maximum address alignment bit.
- *
- * Use TARGET_PAGE_BITS_MIN so that these bits are constant
- * when TARGET_PAGE_BITS_VARY is in effect.
- *
- * The count, if not the placement of these bits is known
- * to tcg/tcg-op-ldst.c, check_max_alignment().
- */
-/* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-/* Set if TLB entry references a clean RAM page.  The iotlb entry will
-   contain the page physical address.  */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
-/* Set if TLB entry is an IO callback.  */
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
-/* Set if TLB entry writes ignored.  */
-#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
-/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
-#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
-
-/*
- * Use this mask to check interception with an alignment mask
- * in a TCG backend.
- */
-#define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
-
-/*
- * Flags stored in CPUTLBEntryFull.slow_flags[x].
- * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
- */
-/* Set if TLB entry requires byte swap.  */
-#define TLB_BSWAP            (1 << 0)
-/* Set if TLB entry contains a watchpoint.  */
-#define TLB_WATCHPOINT       (1 << 1)
-/* Set if TLB entry requires aligned accesses.  */
-#define TLB_CHECK_ALIGNED    (1 << 2)
-
-#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
-
-/* The two sets of flags must not overlap. */
-QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
-
-#endif /* !CONFIG_USER_ONLY */
-
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
new file mode 100644
index 0000000000..a0e51a4b37
--- /dev/null
+++ b/include/exec/tlb-flags.h
@@ -0,0 +1,89 @@
+/*
+ * TLB flags definition
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef TLB_FLAGS_H
+#define TLB_FLAGS_H
+
+#include "exec/cpu-defs.h"
+
+#ifdef CONFIG_USER_ONLY
+
+/*
+ * Allow some level of source compatibility with softmmu.  We do not
+ * support any of the more exotic features, so only invalid pages may
+ * be signaled by probe_access_flags().
+ */
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
+#define TLB_WATCHPOINT      0
+
+#else
+
+/*
+ * Flags stored in the low bits of the TLB virtual address.
+ * These are defined so that fast path ram access is all zeros.
+ * The flags all must be between TARGET_PAGE_BITS and
+ * maximum address alignment bit.
+ *
+ * Use TARGET_PAGE_BITS_MIN so that these bits are constant
+ * when TARGET_PAGE_BITS_VARY is in effect.
+ *
+ * The count, if not the placement of these bits is known
+ * to tcg/tcg-op-ldst.c, check_max_alignment().
+ */
+/* Zero if TLB entry is valid.  */
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
+/*
+ * Set if TLB entry references a clean RAM page.  The iotlb entry will
+ * contain the page physical address.
+ */
+#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
+/* Set if TLB entry is an IO callback.  */
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
+/* Set if TLB entry writes ignored.  */
+#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
+/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
+#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
+
+/*
+ * Use this mask to check interception with an alignment mask
+ * in a TCG backend.
+ */
+#define TLB_FLAGS_MASK \
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
+    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
+
+/*
+ * Flags stored in CPUTLBEntryFull.slow_flags[x].
+ * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
+ */
+/* Set if TLB entry requires byte swap.  */
+#define TLB_BSWAP            (1 << 0)
+/* Set if TLB entry contains a watchpoint.  */
+#define TLB_WATCHPOINT       (1 << 1)
+/* Set if TLB entry requires aligned accesses.  */
+#define TLB_CHECK_ALIGNED    (1 << 2)
+
+#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
+
+/* The two sets of flags must not overlap. */
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
+
+#endif /* !CONFIG_USER_ONLY */
+
+#endif /* TLB_FLAGS_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 613f919fff..b2db49e305 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 #include "exec/log.h"
 #include "exec/helper-proto-common.h"
+#include "exec/tlb-flags.h"
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "tb-internal.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ebc7c3ecf5..667c5e0354 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -21,6 +21,7 @@
 #include "disas/disas.h"
 #include "exec/vaddr.h"
 #include "exec/exec-all.h"
+#include "exec/tlb-flags.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 2e33596428..ccb0c96070 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -11,6 +11,7 @@
 #include "exec/cpu-all.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
+#include "exec/tlb-flags.h"
 #include "semihosting/uaccess.h"
 
 void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 4330900348..8d4e9e07a9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -12,6 +12,7 @@
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/tlb-flags.h"
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9244848efe..fa79d19425 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -31,6 +31,7 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/tlb-flags.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 80164a8050..888c670754 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -31,6 +31,7 @@
 #endif
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index d786b4b111..e3bed77b48 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 6876329de2..b0b74df72f 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -22,6 +22,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/tlb-flags.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 72dc48e58d..f3d26b6b95 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "trace.h"
 
 /* Exceptions processing helpers */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 67b3bafebb..83978be060 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -25,6 +25,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 8187b917ba..0ff2e10d81 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -29,6 +29,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
+#include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 78cb24a8e2..249b1f6c4c 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
+#include "exec/tlb-flags.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
 
-- 
2.43.0


