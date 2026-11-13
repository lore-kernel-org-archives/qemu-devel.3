Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F98606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmx2-0004Bw-W9; Fri, 13 Nov 2026 03:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvs-00036h-4T
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:54 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvp-0007Qv-Pt
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:51 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 3FA23850;
 Fri, 13 Nov 2026 14:16:38 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 20/26] target/loongarch: add LVZ to CSR operations
Date: Fri, 13 Nov 2026 16:45:35 +0800
Message-ID: <1659205526a31f328b1d7095d060a42ee1b81884.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add vm_level argument to CSR helpers. Make csrrd. Add LVZ handling to trans_csrrd,
trans_csrwr and trans_csrxchg.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/tcg/csr_helper.c             | 29 ++++---
 target/loongarch/tcg/helper.h                 | 22 ++---
 .../tcg/insn_trans/trans_privileged.c.inc     | 84 ++++++++++++++-----
 3 files changed, 93 insertions(+), 42 deletions(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index e0fcac8da8..5ff89f0d10 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -18,7 +18,8 @@
 #include "cpu-csr.h"
 #include "cpu-mmu.h"
 
-target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env,
+                                 target_ulong val, uint32_t vm_level)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_STLBPS;
@@ -40,7 +41,7 @@ target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrrd_pgd)(CPULoongArchState *env)
+target_ulong HELPER(csrrd_pgd)(CPULoongArchState *env, uint32_t vm_level)
 {
     int64_t v;
     CPUSysState *sys = env_sys(env);
@@ -60,7 +61,7 @@ target_ulong HELPER(csrrd_pgd)(CPULoongArchState *env)
     return v;
 }
 
-target_ulong HELPER(csrrd_cpuid)(CPULoongArchState *env)
+target_ulong HELPER(csrrd_cpuid)(CPULoongArchState *env, uint32_t vm_level)
 {
     LoongArchCPU *lac = env_archcpu(env);
     CPUSysState *sys = env_sys(env);
@@ -70,12 +71,12 @@ target_ulong HELPER(csrrd_cpuid)(CPULoongArchState *env)
     return sys->CSR_CPUID;
 }
 
-target_ulong HELPER(csrrd_tval)(CPULoongArchState *env)
+target_ulong HELPER(csrrd_tval)(CPULoongArchState *env, uint32_t vm_level)
 {
     return cpu_loongarch_get_timer_ticks(env_timer(env));
 }
 
-target_ulong HELPER(csrrd_msgir)(CPULoongArchState *env)
+target_ulong HELPER(csrrd_msgir)(CPULoongArchState *env, uint32_t vm_level)
 {
     int irq, new;
     CPUSysState *sys = env_sys(env);
@@ -97,7 +98,8 @@ target_ulong HELPER(csrrd_msgir)(CPULoongArchState *env)
     return irq;
 }
 
-target_ulong HELPER(csrwr_estat)(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_estat)(CPULoongArchState *env,
+                                target_ulong val, uint32_t vm_level)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_ESTAT;
@@ -118,7 +120,8 @@ target_ulong HELPER(csrwr_estat)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_asid)(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_asid)(CPULoongArchState *env,
+                               target_ulong val, uint32_t vm_level)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_ASID;
@@ -131,7 +134,8 @@ target_ulong HELPER(csrwr_asid)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env,
+                               target_ulong val, uint32_t vm_level)
 {
     CPUTimerState *timer = env_timer(env);
     CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
@@ -142,7 +146,8 @@ target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_ticlr)(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_ticlr)(CPULoongArchState *env,
+                                target_ulong val, uint32_t vm_level)
 {
     CPUTimerState *timer = env_timer(env);
     int64_t old_v = 0;
@@ -155,7 +160,8 @@ target_ulong HELPER(csrwr_ticlr)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env,
+                               target_ulong val, uint32_t vm_level)
 {
     uint8_t shift, ptbase;
     CPUSysState *sys = env_sys(env);
@@ -180,7 +186,8 @@ target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env,
+                               target_ulong val, uint32_t vm_level)
 {
     uint8_t has_ptw;
     CPUSysState *sys = env_sys(env);
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 4643ec14d5..1c15e7544a 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -95,17 +95,17 @@ DEF_HELPER_1(rdtime_d, i64, env)
 
 #ifndef CONFIG_USER_ONLY
 /* CSRs helper */
-DEF_HELPER_1(csrrd_pgd, i64, env)
-DEF_HELPER_1(csrrd_cpuid, i64, env)
-DEF_HELPER_1(csrrd_tval, i64, env)
-DEF_HELPER_1(csrrd_msgir, i64, env)
-DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
-DEF_HELPER_2(csrwr_estat, i64, env, tl)
-DEF_HELPER_2(csrwr_asid, i64, env, tl)
-DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
-DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
-DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
-DEF_HELPER_2(csrwr_pwch, i64, env, tl)
+DEF_HELPER_2(csrrd_pgd, i64, env, i32)
+DEF_HELPER_2(csrrd_cpuid, i64, env, i32)
+DEF_HELPER_2(csrrd_tval, i64, env, i32)
+DEF_HELPER_2(csrrd_msgir, i64, env, i32)
+DEF_HELPER_3(csrwr_stlbps, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_estat, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_asid, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_tcfg, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_ticlr, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_pwcl, i64, env, tl, i32)
+DEF_HELPER_3(csrwr_pwch, i64, env, tl, i32)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
 DEF_HELPER_2(iocsrrd_h, i64, env, tl)
 DEF_HELPER_2(iocsrrd_w, i64, env, tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 5575bba9e1..39d217877d 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -42,8 +42,8 @@ GEN_FALSE_TRANS(idle)
 
 #else
 
-typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
-typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
+typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env, TCGv_i32 vm_level);
+typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src, TCGv_i32 vm_level);
 
 static bool check_plv(DisasContext *ctx)
 {
@@ -88,10 +88,14 @@ void loongarch_csr_translate_init(void)
 }
 #undef SET_CSR_FUNC
 
-static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
+static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr,
+                            bool write, int vm_level)
 {
     if ((csr->flags & CSRFL_READONLY) && write) {
-        return false;
+        /* host writes guest read-only CSRs is allowed */
+        if (mmu_idx_vm_level(ctx->mem_idx) || vm_level == VM_LEVEL0) {
+            return false;
+        }
     }
     if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
         ctx->base.is_jmp = DISAS_EXIT_UPDATE;
@@ -101,7 +105,7 @@ static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
     return true;
 }
 
-static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
+static bool trans_csrrd_impl(DisasContext *ctx, arg_r_csr *a, int vm_level)
 {
     TCGv dest;
     const CSRInfo *csr;
@@ -116,21 +120,29 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
         /* CSR is undefined: read as 0. */
         dest = tcg_constant_tl(0);
     } else {
-        check_csr_flags(ctx, csr, false);
-        dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        readfn = (GenCSRRead)csr->readfn;
-        if (readfn) {
-            readfn(dest, tcg_env);
+        check_csr_flags(ctx, csr, false, vm_level);
+        if (vm_level && (csr->flags & CSRFL_GSPR)) {
+            if (mmu_idx_vm_level(ctx->mem_idx)) {
+                generate_exception(ctx, EXCCODE_GSPR);
+                return true;
+            }
+            dest = tcg_constant_tl(0);
         } else {
-            offset = get_csr_offset(csr, 0);
-            tcg_gen_ld_tl(dest, tcg_env, offset);
+            dest = gpr_dst(ctx, a->rd, EXT_NONE);
+            readfn = (GenCSRRead)csr->readfn;
+            if (readfn) {
+                readfn(dest, tcg_env, tcg_constant_i32(vm_level));
+            } else {
+                offset = get_csr_offset(csr, vm_level);
+                tcg_gen_ld_tl(dest, tcg_env, offset);
+            }
         }
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
     return true;
 }
 
-static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
+static bool trans_csrwr_impl(DisasContext *ctx, arg_r_csr *a, int vm_level)
 {
     TCGv dest, src1;
     const CSRInfo *csr;
@@ -146,18 +158,26 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
         gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
         return true;
     }
-    if (!check_csr_flags(ctx, csr, true)) {
+    if (!check_csr_flags(ctx, csr, true, vm_level)) {
         /* CSR is readonly: trap. */
         return false;
     }
+    if (vm_level && (csr->flags & CSRFL_GSPR)) {
+        if (mmu_idx_vm_level(ctx->mem_idx)) {
+            generate_exception(ctx, EXCCODE_GSPR);
+            return true;
+        }
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
     src1 = gpr_src(ctx, a->rd, EXT_NONE);
     writefn = (GenCSRWrite)csr->writefn;
     if (writefn) {
         dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        writefn(dest, tcg_env, src1);
+        writefn(dest, tcg_env, src1, tcg_constant_i32(vm_level));
     } else {
         dest = tcg_temp_new();
-        offset = get_csr_offset(csr, 0);
+        offset = get_csr_offset(csr, vm_level);
         tcg_gen_ld_tl(dest, tcg_env, offset);
         tcg_gen_st_tl(src1, tcg_env, offset);
     }
@@ -165,7 +185,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     return true;
 }
 
-static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
+static bool trans_csrxchg_impl(DisasContext *ctx, arg_rr_csr *a, int vm_level)
 {
     TCGv src1, mask, oldv, newv, temp;
     const CSRInfo *csr;
@@ -182,11 +202,20 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
         return true;
     }
 
-    if (!check_csr_flags(ctx, csr, true)) {
+    if (!check_csr_flags(ctx, csr, true, vm_level)) {
         /* CSR is readonly: trap. */
         return false;
     }
 
+    if (vm_level && (csr->flags & CSRFL_GSPR)) {
+        if (mmu_idx_vm_level(ctx->mem_idx)) {
+            generate_exception(ctx, EXCCODE_GSPR);
+            return true;
+        }
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+
     /* So far only readonly csrs have readfn. */
     assert(csr->readfn == NULL);
 
@@ -196,7 +225,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     newv = tcg_temp_new();
     temp = tcg_temp_new();
 
-    offset = get_csr_offset(csr, 0);
+    offset = get_csr_offset(csr, vm_level);
     tcg_gen_ld_tl(oldv, tcg_env, offset);
     tcg_gen_and_tl(newv, src1, mask);
     tcg_gen_andc_tl(temp, oldv, mask);
@@ -204,7 +233,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
 
     writefn = (GenCSRWrite)csr->writefn;
     if (writefn) {
-        writefn(oldv, tcg_env, newv);
+        writefn(oldv, tcg_env, newv, tcg_constant_i32(vm_level));
     } else {
         tcg_gen_st_tl(newv, tcg_env, offset);
     }
@@ -212,6 +241,21 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     return true;
 }
 
+static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
+{
+    return trans_csrrd_impl(ctx, a, mmu_idx_vm_level(ctx->mem_idx));
+}
+
+static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
+{
+    return trans_csrwr_impl(ctx, a, mmu_idx_vm_level(ctx->mem_idx));
+}
+
+static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
+{
+    return trans_csrxchg_impl(ctx, a, mmu_idx_vm_level(ctx->mem_idx));
+}
+
 static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
                         void (*func)(TCGv, TCGv_ptr, TCGv))
 {
-- 
2.56.0


