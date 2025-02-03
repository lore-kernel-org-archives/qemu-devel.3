Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA34C02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyu-00087E-8g; Sun, 02 Feb 2025 22:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temys-00086T-7O
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:38 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyq-0002hW-5W
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:37 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2167141dfa1so66260485ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552715; x=1739157515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7b0UUGninisR0EI4xpwoVGAOe7defoH91cD8t1dIfI=;
 b=d3I5XXZZ65/Fl2TqH7zO2IChMHBzarokQg7EN5nK80/971FSbS3M+Ww+DX9p1HNCy6
 lNzeq1Ku7mX6R9jucXRxpqsJDyubJuEkYqgh5Y4cHEP7vCLhJBh5VyaMn/435qDh96KJ
 Xu7bQxAyugSCv4msL88vjB6enCUZ36CbkMNYAQ0USekRw1kMZNGhyrYgn5WNqrag2TSS
 /uXCDQ1635Bw/x6JH1AoyO7B5vYZMgpGEWmA70NK0FeCHSzaKxLgM+X6mPFzPGiU1a9w
 J+5TSj5AEtfgAWj0cR1t4W8FGVY20vtXRrBQyXebQ/R96Byql8Ae00eQa7l4gGZDt0UJ
 u6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552715; x=1739157515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7b0UUGninisR0EI4xpwoVGAOe7defoH91cD8t1dIfI=;
 b=Vf2e4xBZ9GI+0R7A+F0TkCLSc6Zx9VzSzKkTWnW9DaJb3QQ5ryMUSEwSTz2culiLFn
 CwLe3Z6o57LFpOXPjdHg1jfeOlSDNcfScHlX015kWKj082F89OrwsMLEjv+r1DVk4vuO
 aQONvcN3OgndnxztLpXYv5PeKCXMOIW/0TKOSG3tnQNfXbr4qKTMgObiCD3J3SlssZcG
 dGhazR8I3oagOiiVybmaP0FFMVqIYfCoj8yfUoL608ethnFjUbUBOfrmWx5CkPRwdQOm
 IcLB57KkWO6g0wNUG1VXIhlDGgWtyRotLxW6p1I9yoD5h5nu5c3yPPaYYlQipLlnuqf9
 XIAA==
X-Gm-Message-State: AOJu0YxV7rWliB6O9t5xslfU4mFwbkrudU/0F8+aXf3dPb8ZuIFqVC7H
 yuBSmX4lE5fjg5jwTb6Mx6Dy0+rL3R2GWXjAC65Tulu0J/xWNXOuS+tewAbW0RVfeOil1/EgSZF
 x
X-Gm-Gg: ASbGncv1NlQJQjn4udQeTviH7mDvWmRxV7FpDVucl7/Z1LBx1iXPO8GQurQ0d+KcxPB
 tW+LhKpEEW7mttJXLvBYQ4wZqqUOE79YjPHf1uChA6eUHouuQy+e/lz6Dq7NVj6cU5Kefe7rADr
 Wna0eAjHUffLAHr6JFTGLF4Bz5+nZwa/VCQMVRysEw8wXemBZrrXdgiaUl4sG06Adnm2aqB8l4w
 oyS6xPqmM9pXByJy5YdozmV+UmNFrPIT61RD8NDBOdrgFTzVE2s8ISZdYTklnG70f6U/n2FrOlx
 2TSnDL1flR0wd0WJi7FFJkHzkUwJ4c/TIav5oaxD/+NlaXY=
X-Google-Smtp-Source: AGHT+IEZvakjkrP/urf2k1avafkTYyN7GIDIzQWl3p3Ezh/Ys35Y2qWK0zabUwnEMrCqUGEQqGJkMA==
X-Received: by 2002:a17:903:2f89:b0:216:1079:82bb with SMTP id
 d9443c01a7336-21edd84e33bmr219867975ad.19.1738552714732; 
 Sun, 02 Feb 2025 19:18:34 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 14/14] tcg: Remove TCG_OVERSIZED_GUEST
Date: Sun,  2 Feb 2025 19:18:21 -0800
Message-ID: <20250203031821.741477-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


