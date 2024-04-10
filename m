Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F0CCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSO7-0006kc-GB; Wed, 10 Apr 2024 03:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNv-0006FN-Ei; Wed, 10 Apr 2024 03:28:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNr-0004xP-Ui; Wed, 10 Apr 2024 03:28:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C75E75D6AB;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 67261B02EB;
 Wed, 10 Apr 2024 10:23:08 +0300 (MSK)
Received: (nullmailer pid 4191827 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 59/87] target/i386/tcg: Enable page walking from MMIO
 memory
Date: Wed, 10 Apr 2024 10:22:32 +0300
Message-Id: <20240410072303.4191455-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

From: Gregory Price <gregory.price@memverge.com>

CXL emulation of interleave requires read and write hooks due to
requirement for subpage granularity. The Linux kernel stack now enables
using this memory as conventional memory in a separate NUMA node. If a
process is deliberately forced to run from that node
$ numactl --membind=1 ls
the page table walk on i386 fails.

Useful part of backtrace:

    (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
    at ../../cpu-target.c:359
    (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
    at ../../accel/tcg/cputlb.c:1339
    (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
    (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
    (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
    at ../../accel/tcg/ldst_common.c.inc:301
    at ../../target/i386/tcg/sysemu/excp_helper.c:173
    (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
    at ../../target/i386/tcg/sysemu/excp_helper.c:578
    (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604

Avoid this by plumbing the address all the way down from
x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
which provide it to probe_access_full() which already handles MMIO accesses.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2180
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2220
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <20240307155304.31241-2-Jonathan.Cameron@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 9dab7bbb017d11b64c52239fa4e2f910a6a004f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8f7011d966..7a57b7dd10 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -59,14 +59,14 @@ typedef struct PTETranslate {
     hwaddr gaddr;
 } PTETranslate;
 
-static bool ptw_translate(PTETranslate *inout, hwaddr addr)
+static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
     CPUTLBEntryFull *full;
     int flags;
 
     inout->gaddr = addr;
     flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, 0);
+                              inout->ptw_idx, true, &inout->haddr, &full, ra);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -82,20 +82,20 @@ static bool ptw_translate(PTETranslate *inout, hwaddr addr)
     return true;
 }
 
-static inline uint32_t ptw_ldl(const PTETranslate *in)
+static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldl_p(in->haddr);
     }
-    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
-static inline uint64_t ptw_ldq(const PTETranslate *in)
+static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldq_p(in->haddr);
     }
-    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
 /*
@@ -132,7 +132,8 @@ static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
 }
 
 static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
-                          TranslateResult *out, TranslateFault *err)
+                          TranslateResult *out, TranslateFault *err,
+                          uint64_t ra)
 {
     const target_ulong addr = in->addr;
     const int pg_mode = in->pg_mode;
@@ -164,11 +165,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                  * Page table level 5
                  */
                 pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
-                if (!ptw_translate(&pte_trans, pte_addr)) {
+                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                     return false;
                 }
             restart_5:
-                pte = ptw_ldq(&pte_trans);
+                pte = ptw_ldq(&pte_trans, ra);
                 if (!(pte & PG_PRESENT_MASK)) {
                     goto do_fault;
                 }
@@ -188,11 +189,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 4
              */
             pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_4:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -208,11 +209,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_3_lma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -235,12 +236,12 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
             rsvd_mask |= PG_HI_USER_MASK;
         restart_3_nolma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -257,11 +258,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_pae:
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -283,10 +284,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -301,11 +302,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_nopae:
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -330,10 +331,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -526,7 +527,8 @@ static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
 
 static bool get_physical_address(CPUX86State *env, vaddr addr,
                                  MMUAccessType access_type, int mmu_idx,
-                                 TranslateResult *out, TranslateFault *err)
+                                 TranslateResult *out, TranslateFault *err,
+                                 uint64_t ra)
 {
     TranslateParams in;
     bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
@@ -546,7 +548,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                 env->nested_pg_mode & PG_MODE_LMA ? MMU_USER64_IDX : MMU_USER32_IDX;
             in.ptw_idx = MMU_PHYS_IDX;
 
-            if (!mmu_translate(env, &in, out, err)) {
+            if (!mmu_translate(env, &in, out, err, ra)) {
                 err->stage2 = S2_GPA;
                 return false;
             }
@@ -577,7 +579,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                     return false;
                 }
             }
-            return mmu_translate(env, &in, out, err);
+            return mmu_translate(env, &in, out, err, ra);
         }
         break;
     }
@@ -597,7 +599,8 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     TranslateResult out;
     TranslateFault err;
 
-    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err)) {
+    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err,
+                             retaddr)) {
         /*
          * Even if 4MB pages, we map only one 4KB page in the cache to
          * avoid filling it too fast.
-- 
2.39.2


