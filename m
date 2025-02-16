Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3E6C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6K-0007do-1c; Sat, 15 Feb 2025 19:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS63-0007bP-1t
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:20 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS5z-0006FP-BM
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:17 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so4296465a91.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664074; x=1740268874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0D+qkdUAnGyLEvzj5WsailDQ6IwrMLobTEZGdeMA0tw=;
 b=b6wjgN54bsOMXR9iLr/J4McJbJa0RnBWXNdycqJedf/bHKZRfACsfNYDtASvVog/Ii
 U5MGT/MwfoCvvGGwynI2qVhYP4e2vBDujFdYbuFBj0+zmKvnbrQlxhuXMpnU9nwHGGLn
 iCPHv3N8zOO8x+ET1mJDoM7dBW+x1X0ynV4bY5q4uSMvxF0Jm8W366lfmtTS/BMuirQW
 0uL/9De4iFe6fQ1OvZG/NgeEZW6JPMX3EwHMHEv3GwyjYLJz0GYXmQAUJmjU0nwU/bKc
 fkLc8cDwu0eJEjrZ2rCKju1w8z1N8AyeRwysLyAyKWw1B2MSX4Rpio2/a2JUjB7jiqtE
 NW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664074; x=1740268874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0D+qkdUAnGyLEvzj5WsailDQ6IwrMLobTEZGdeMA0tw=;
 b=vx+sI0DP8rQOe4iM26EuubnDRdnQ7iPhYQlOjcedXsaYiH99GH5IHhvcpnKSHQWIBQ
 C3D0pmheban4QIzx59N3nWo+NgTJHql+F3PVObByGnd31F5f5x2V+dWH9GeMhc1VghUB
 NCm/fm4+EVzFyCG9QSlFU3ke8M0S0LA3+yskvk59SsKfk5W0hvftP4Wt2wzTazRJx7Gu
 F6BB4DFKpOYlLUQDek1c+GRkFb1awHGJrME5r07oJ6T/g9IohuqDpenju5QH9Z4AmMht
 gXnRTEiQBHDf+Q9yJW5jdaa0HFZzVhd3IXCYh2+/RJEzsQAH9iUOJbiR0AGIxx1fy28T
 rnZg==
X-Gm-Message-State: AOJu0Yx7z3LpncG2iuEptSbi9Nr+Xt868xQ+pCDdmmb/ihHYEJ4C4NgS
 8pUx0GMtqeerI9I+WSFlbJBVM+nYFgTHa+7pVEEg4C8QyLU8AOt7dNvfQxodPOn+UmMTVyAoIZU
 m
X-Gm-Gg: ASbGnctiaAajiV+X5W3iutb05YBel/ky4F3Bf2QTBuugYGLLGiaurxwbUHvRhZ3UeDk
 0Nk06S5q5VBmAn15rxRaDUCYkdstIv4A9ukIbSuSGk0PnJT4vu5FCgiz98S95D8Y/G32emMwesS
 IJi2imRmiav1PgQ07x8MRz/FkaboJ7eqLLSi1zMeST0MsNDvHmoA19XMmVxmnyVpsXrSaxycI+p
 frs9cCDuLAYUEJlPtKMXFQatRsjAbfJ+oZWbI2PsjxEdgbqeTkN5mxjPmJyoS7jmkXjw844puD3
 vM/sUHuGXfCx4ZoxtSBt7JpeHnxkYB88W/P4WjVoqHloaxo=
X-Google-Smtp-Source: AGHT+IH1uyhDYadMTPIzSgE0g6nSW2trqVOmbsHgH5eZT/62guVtfJynl2kBkcxTAnuzUu2qqMowyQ==
X-Received: by 2002:a17:90b:2243:b0:2fa:1a8a:cff8 with SMTP id
 98e67ed59e1d1-2fc41150925mr7273663a91.29.1739664072178; 
 Sat, 15 Feb 2025 16:01:12 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/24] tcg: Remove TCG_OVERSIZED_GUEST
Date: Sat, 15 Feb 2025 16:00:46 -0800
Message-ID: <20250216000109.2606518-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

This is now prohibited in configuration.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/atomic.h           | 18 +++--------------
 include/tcg/oversized-guest.h   | 23 ----------------------
 accel/tcg/cputlb.c              |  7 -------
 accel/tcg/tcg-all.c             |  9 ++++-----
 target/arm/ptw.c                | 34 ---------------------------------
 target/riscv/cpu_helper.c       | 13 +------------
 docs/devel/multi-thread-tcg.rst |  1 -
 7 files changed, 8 insertions(+), 97 deletions(-)
 delete mode 100644 include/tcg/oversized-guest.h

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 7a3f2e6576..f80cba24cf 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -56,25 +56,13 @@
  */
 #define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
 
-/* Sanity check that the size of an atomic operation isn't "overly large".
+/*
+ * Sanity check that the size of an atomic operation isn't "overly large".
  * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
  * want to use them because we ought not need them, and this lets us do a
  * bit of sanity checking that other 32-bit hosts might build.
- *
- * That said, we have a problem on 64-bit ILP32 hosts in that in order to
- * sync with TCG_OVERSIZED_GUEST, this must match TCG_TARGET_REG_BITS.
- * We'd prefer not want to pull in everything else TCG related, so handle
- * those few cases by hand.
- *
- * Note that x32 is fully detected with __x86_64__ + _ILP32, and that for
- * Sparc we always force the use of sparcv9 in configure. MIPS n32 (ILP32) &
- * n64 (LP64) ABIs are both detected using __mips64.
  */
-#if defined(__x86_64__) || defined(__sparc__) || defined(__mips64)
-# define ATOMIC_REG_SIZE  8
-#else
-# define ATOMIC_REG_SIZE  sizeof(void *)
-#endif
+#define ATOMIC_REG_SIZE  sizeof(void *)
 
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
diff --git a/include/tcg/oversized-guest.h b/include/tcg/oversized-guest.h
deleted file mode 100644
index 641b9749ff..0000000000
--- a/include/tcg/oversized-guest.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define TCG_OVERSIZED_GUEST
- * Copyright (c) 2008 Fabrice Bellard
- */
-
-#ifndef EXEC_TCG_OVERSIZED_GUEST_H
-#define EXEC_TCG_OVERSIZED_GUEST_H
-
-#include "tcg-target-reg-bits.h"
-#include "cpu-param.h"
-
-/*
- * Oversized TCG guests make things like MTTCG hard
- * as we can't use atomics for cputlb updates.
- */
-#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
-#define TCG_OVERSIZED_GUEST 1
-#else
-#define TCG_OVERSIZED_GUEST 0
-#endif
-
-#endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b4ccf0cdcb..17e2251695 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -47,7 +47,6 @@
 #include "qemu/plugin-memory.h"
 #endif
 #include "tcg/tcg-ldst.h"
-#include "tcg/oversized-guest.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -118,12 +117,8 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
     return qatomic_read(ptr);
 #else
     const uint64_t *ptr = &entry->addr_idx[access_type];
-# if TCG_OVERSIZED_GUEST
-    return *ptr;
-# else
     /* ofs might correspond to .addr_write, so use qatomic_read */
     return qatomic_read(ptr);
-# endif
 #endif
 }
 
@@ -908,8 +903,6 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
             uint32_t *ptr_write = (uint32_t *)&tlb_entry->addr_write;
             ptr_write += HOST_BIG_ENDIAN;
             qatomic_set(ptr_write, *ptr_write | TLB_NOTDIRTY);
-#elif TCG_OVERSIZED_GUEST
-            tlb_entry->addr_write |= TLB_NOTDIRTY;
 #else
             qatomic_set(&tlb_entry->addr_write,
                         tlb_entry->addr_write | TLB_NOTDIRTY);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 95adaacee8..c1a30b0121 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -28,7 +28,6 @@
 #include "exec/replay-core.h"
 #include "system/cpu-timers.h"
 #include "tcg/startup.h"
-#include "tcg/oversized-guest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
@@ -41,6 +40,8 @@
 #include "hw/boards.h"
 #endif
 #include "internal-common.h"
+#include "cpu-param.h"
+
 
 struct TCGState {
     AccelState parent_obj;
@@ -72,7 +73,7 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
 
 static bool default_mttcg_enabled(void)
 {
-    if (icount_enabled() || TCG_OVERSIZED_GUEST) {
+    if (icount_enabled()) {
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
@@ -145,9 +146,7 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
     TCGState *s = TCG_STATE(obj);
 
     if (strcmp(value, "multi") == 0) {
-        if (TCG_OVERSIZED_GUEST) {
-            error_setg(errp, "No MTTCG when guest word size > hosts");
-        } else if (icount_enabled()) {
+        if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
 #ifndef TARGET_SUPPORTS_MTTCG
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 64bb6878a4..4330900348 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -16,9 +16,6 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "idau.h"
-#ifdef CONFIG_TCG
-# include "tcg/oversized-guest.h"
-#endif
 
 typedef struct S1Translate {
     /*
@@ -840,7 +837,6 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
         ptw->out_rw = true;
     }
 
-#ifdef CONFIG_ATOMIC64
     if (ptw->out_be) {
         old_val = cpu_to_be64(old_val);
         new_val = cpu_to_be64(new_val);
@@ -852,36 +848,6 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
         cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
         cur_val = le64_to_cpu(cur_val);
     }
-#else
-    /*
-     * We can't support the full 64-bit atomic cmpxchg on the host.
-     * Because this is only used for FEAT_HAFDBS, which is only for AA64,
-     * we know that TCG_OVERSIZED_GUEST is set, which means that we are
-     * running in round-robin mode and could only race with dma i/o.
-     */
-#if !TCG_OVERSIZED_GUEST
-# error "Unexpected configuration"
-#endif
-    bool locked = bql_locked();
-    if (!locked) {
-        bql_lock();
-    }
-    if (ptw->out_be) {
-        cur_val = ldq_be_p(host);
-        if (cur_val == old_val) {
-            stq_be_p(host, new_val);
-        }
-    } else {
-        cur_val = ldq_le_p(host);
-        if (cur_val == old_val) {
-            stq_le_p(host, new_val);
-        }
-    }
-    if (!locked) {
-        bql_unlock();
-    }
-#endif
-
     return cur_val;
 #else
     /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1dfc4ecbf..8ff6d900f2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -32,7 +32,6 @@
 #include "system/cpu-timers.h"
 #include "cpu_bits.h"
 #include "debug.h"
-#include "tcg/oversized-guest.h"
 #include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
@@ -1167,9 +1166,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr pte_addr;
     int i;
 
-#if !TCG_OVERSIZED_GUEST
-restart:
-#endif
+ restart:
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
         target_ulong idx;
         if (i == 0) {
@@ -1388,13 +1385,6 @@ restart:
                                      false, MEMTXATTRS_UNSPECIFIED);
         if (memory_region_is_ram(mr)) {
             target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
-#if TCG_OVERSIZED_GUEST
-            /*
-             * MTTCG is not enabled on oversized TCG guests so
-             * page table updates do not need to be atomic
-             */
-            *pte_pa = pte = updated_pte;
-#else
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) == MXL_RV32) {
                 old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
@@ -1405,7 +1395,6 @@ restart:
                 goto restart;
             }
             pte = updated_pte;
-#endif
         } else {
             /*
              * Misconfigured PTE in ROM (AD bits are not preset) or
diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 7fd0a07633..b0f473961d 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -37,7 +37,6 @@ if:
 
 * forced by --accel tcg,thread=single
 * enabling --icount mode
-* 64 bit guests on 32 bit hosts (TCG_OVERSIZED_GUEST)
 
 In the general case of running translated code there should be no
 inter-vCPU dependencies and all vCPUs should be able to run at full
-- 
2.43.0


