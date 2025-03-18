Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DA7C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYG-0001Q0-3w; Tue, 18 Mar 2025 17:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXr-0001Eo-6z
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXo-0000jF-FC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:18 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22349bb8605so137297715ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333535; x=1742938335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ed/f0ps4N0zqTL5jgBMLusXY9jc4rfpD8cqPEiyV4Ok=;
 b=FPEPPNDR0hhfETTnZu8IbJRR3AxGYLa0KnSS1kXE8Hz5N80cegoH1GgWQMdbn6nLbo
 4bITSZeN+TMehyzmhK9opZqqscDtGU4ePnZ266G1v5aJrPNtWu+PuD/ARpxw3d83jZNB
 4MUCwX1Qybo1i6Mv4LaX65M5H76fB2t1sNQDU6I/kA/n8SSGiXo6lDUkoHZb99Nfksjv
 2ysJiXoYliW2MzRCoe5/TGLUP3TslTMfrhgoTfYRJxI19pA5EQcj7PNqMtJyldJQIOCt
 fK5HT+pqqL/dqPEeDvbTvsb05Y/Mb5kFOPXdC8rYEqK4V1M89YyzvoKY1fhlZsexrhta
 1nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333535; x=1742938335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ed/f0ps4N0zqTL5jgBMLusXY9jc4rfpD8cqPEiyV4Ok=;
 b=iltWiBLovKGJjLtCJDmwM1TEyfVjr5I60deyDwTlqeXx/HvShmW3Ws0EgHcum+iaDW
 XQjTxM2Ku9LeevynBW8HDTIDpKDE0852bsgO8Ph3QXul174B6H3HW15+LY4A1ZmKPkXv
 exrUvI0lqDcbyKbn9qFflqz+lfjs9/8hA84C2loVjLuM0Ame4mtirLjEcqMVh52/AOTn
 gSjPa7l0Ukqaxq4j7Zxj0QmQxtF5HGC+LpM0Ro4W2ER3APDbuw0WaHdrYV8noPFNIEWk
 3pcUW5FwZ0tuTNS41iWhgotH/dcfJlVVrY2qX7h1KjJnaJg4wpHbuzoI3CtC5Tk2dmiI
 Dbdg==
X-Gm-Message-State: AOJu0YziXFYZOE+/Ia7FLLUHpNceiAAkfUykMpm3EcvTfWf1sRRZCf3J
 LK6h4o+x0rfqCHfdeTEggSacyLJMnhYQdG4GAwOf/PEqomGg9bTQ8MTEDjfJHGXeNQAjllKn6tv
 X
X-Gm-Gg: ASbGncv5+lI2H7vM1+MuMfxx/hFFZfPJIXsibdG5Rapl3ZbMPBbuQvSb1hroLd25cty
 0jxLpeokX7Pt9GBktivBF766D9dM1sJaht1gSzRYwnj6UU5VNX1iVwkC2txvgbR8bqOL91+tZk1
 LOczRHYWex+fMB+9pVYy0+Sv//nH4ejrGhybAcLwr+eyitXuCWNbPrsLQptrLCL3EBOfPjDtKzb
 DE3bW8Sn+9HtDzwu4bN6rG6WJjCDUu/lduj1TAHlFSED42NzcZzL7TImIs4bfElIGypoTfxl3Cm
 reJz5GRKbUNlP/nU8xsogNNOY0SzIOZl6btsR1pNroGlNQ9VnQs8y87SRNL/rI8RnNMJSnn7K//
 6
X-Google-Smtp-Source: AGHT+IHXtN1UPT58yNyHUnR64daUQ6hkKFL3I4goA93NC47Dl3iVWQcWufyIqPueuIp8IuZ5I3WocA==
X-Received: by 2002:a05:6a20:1605:b0:1f5:8e33:c417 with SMTP id
 adf61e73a8af0-1fbeb18508emr366826637.2.1742333534774; 
 Tue, 18 Mar 2025 14:32:14 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
Date: Tue, 18 Mar 2025 14:31:31 -0700
Message-ID: <20250318213209.2579218-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h        |  6 ------
 include/exec/cpu-common.h     | 20 ------------------
 include/exec/cpu-mmu-index.h  | 39 +++++++++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h       |  1 +
 semihosting/uaccess.c         |  1 +
 target/arm/gdbstub64.c        |  3 +++
 target/hppa/mem_helper.c      |  1 +
 target/i386/tcg/translate.c   |  1 +
 target/loongarch/cpu_helper.c |  1 +
 target/microblaze/helper.c    |  1 +
 target/microblaze/mmu.c       |  1 +
 target/openrisc/translate.c   |  1 +
 target/sparc/cpu.c            |  1 +
 target/sparc/mmu_helper.c     |  1 +
 target/tricore/helper.c       |  1 +
 target/xtensa/mmu_helper.c    |  1 +
 16 files changed, 54 insertions(+), 26 deletions(-)
 create mode 100644 include/exec/cpu-mmu-index.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 902ca1f3c7..6108351f58 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -48,8 +48,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #ifdef CONFIG_USER_ONLY
 
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
-
 /*
  * Allow some level of source compatibility with softmmu.  We do not
  * support any of the more exotic features, so only invalid pages may
@@ -59,10 +57,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
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
diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
new file mode 100644
index 0000000000..b46e622048
--- /dev/null
+++ b/include/exec/cpu-mmu-index.h
@@ -0,0 +1,39 @@
+/*
+ * cpu_mmu_index()
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
+
+#ifndef EXEC_CPU_MMU_INDEX_H
+#define EXEC_CPU_MMU_INDEX_H
+
+#include "hw/core/cpu.h"
+#include "tcg/debug-assert.h"
+#ifdef COMPILING_PER_TARGET
+#include "cpu.h"
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
+#endif /* EXEC_CPU_MMU_INDEX_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 1fbdbe59ae..0b10d840fe 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,6 +67,7 @@
 #endif
 
 #include "exec/cpu-ldst-common.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 382a366ce3..a957891166 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/cpu-all.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 1a4dbec567..a9d8352b76 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -27,6 +27,9 @@
 #include <sys/prctl.h>
 #include "mte_user_helper.h"
 #endif
+#ifdef CONFIG_TCG
+#include "exec/cpu-mmu-index.h"
+#endif
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index fb1d93ef1f..510786518d 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487a..20a5c69795 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -20,6 +20,7 @@
 
 #include "qemu/host-utils.h"
 #include "cpu.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 930466ca48..8662fb36ed 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/cpu-mmu-index.h"
 #include "internals.h"
 #include "cpu-csr.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 27fc929bee..996514ffe8 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index f8587d5ac4..987ac9e3a7 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 
 static unsigned int tlb_decode_size(unsigned int f)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7a6af183ae..5b437959ac 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 5716120117..1bf00407af 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "hw/qdev-properties.h"
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 7548d01777..4a0cedd9e2 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index a64412e6bd..be3d97af78 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -20,6 +20,7 @@
 #include "hw/registerfields.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 63be741a42..96140c89c7 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -33,6 +33,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 
-- 
2.43.0


