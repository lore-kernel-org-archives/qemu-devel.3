Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BEDCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbuRI-00038Z-J5; Tue, 23 Jun 2026 02:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wbuRF-00037H-Vj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 02:16:50 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wbuRB-0002Rm-SZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 02:16:49 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 46BE3240AE99;
 Tue, 23 Jun 2026 14:16:33 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v2 4/4] target/loongarch: Add LVZ instruction decode,
 translation and disassembly
Date: Tue, 23 Jun 2026 14:16:15 +0800
Message-ID: <446555db76a103774b136f0dbb1ef28de2621e86.1782194683.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1782194683.git.prcups@krgm.moe>
References: <cover.1782194683.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2400:e920:0:e::2c (failed)
Received-SPF: pass client-ip=2400:e920:0:e::2c; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add decode patterns for LVZ virtualization instructions:
gcsrrd, gcsrwr, gcsrxchg for guest CSR access, gtlbclr,
gtlbflush, gtlbsrch, gtlbrd, gtlbwr, gtlbfill for guest
TLB management, and hvcl for hypervisor call. Add TCG
translation with guest-mode CSR access, GSPR trapping,
GUEST_READONLY flag checking, and guest TLB operations.
Finalize CSR offset mechanism with per-VM-level offsets.
Add disassembly support for new CSR names.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/csr.c                        |   8 +-
 target/loongarch/csr.h                        |   9 +-
 target/loongarch/disas.c                      |  16 +
 target/loongarch/insns.decode                 |  14 +
 .../tcg/insn_trans/trans_extra.c.inc          |   2 +-
 .../tcg/insn_trans/trans_privileged.c.inc     | 289 ++++++++++++++++--
 target/loongarch/tcg/translate.c              |   6 +-
 7 files changed, 314 insertions(+), 30 deletions(-)

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 2157f55fb5..ed9d25edf2 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -9,14 +9,14 @@
 #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
     [LOONGARCH_CSR_##NAME] = {                             \
         .name   = (stringify(NAME)),                       \
-        .offset = CSR_OFFSET(CSR_##NAME),                  \
+        .offset = CSR_OFFSET(CSR_##NAME, 0),               \
         .flags = FL, .readfn = RD, .writefn = WR           \
     }
 
 #define CSR_OFF_ARRAY(NAME, N)                                \
     [LOONGARCH_CSR_##NAME(N)] = {                             \
         .name   = (stringify(NAME##N)),                       \
-        .offset = CSR_OFFSET(CSR_##NAME[N]),                  \
+        .offset = CSR_OFFSET(CSR_##NAME[N], 0),               \
         .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
     }
 
@@ -25,13 +25,13 @@
 #define GCSR_OFF_FUNCS(NAME, FL, RD, WR)                  \
     [LOONGARCH_CSR_##NAME] = {                            \
         .name   = (stringify(GCSR_##NAME)),               \
-        .offset = CPU_CSR_OFFSET(CSR_##NAME, 1),          \
+        .offset = CSR_OFFSET(CSR_##NAME, 1),              \
         .flags = FL, .readfn = RD, .writefn = WR          \
     }
 #define GCSR_OFF_ARRAY(NAME, N)                               \
     [LOONGARCH_CSR_##NAME(N)] = {                             \
         .name   = (stringify(GCSR_##NAME##N)),                \
-        .offset = CPU_CSR_OFFSET(CSR_##NAME[N], 1),           \
+        .offset = CSR_OFFSET(CSR_##NAME[N], 1),               \
         .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
     }
 #define GCSR_OFF_FLAGS(NAME, FL) GCSR_OFF_FUNCS(NAME, FL, NULL, NULL)
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index e233338dd3..c39230f30c 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -8,10 +8,9 @@
 
 #include "cpu-csr.h"
 
-#define CSR_OFFSET(id)                  offsetof(CPUSysState, id)
-#define CPU_CSR_OFFSET(id, vm_level)                                     \
+#define CSR_OFFSET(id, vm_level)                                     \
                     (offsetof(CPULoongArchState, sys_states[vm_level])   \
-                             + CSR_OFFSET(id))
+                    + offsetof(CPUSysState, id))
 
 typedef void (*GenCSRFunc)(void);
 enum {
@@ -35,8 +34,4 @@ typedef struct {
 CSRInfo *get_csr(unsigned int csr_num);
 CSRInfo *get_gcsr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
-static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
-{
-    return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
-}
 #endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3249ab7ac6..db0e556adb 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -51,6 +51,8 @@ static const char * const csr_names[] = {
     CSR_NAME(BADI),
     CSR_NAME(EENTRY),
     CSR_NAME(TLBIDX),
+    CSR_NAME(GTLBC),
+    CSR_NAME(TRGP),
     CSR_NAME(TLBEHI),
     CSR_NAME(TLBELO0),
     CSR_NAME(TLBELO1),
@@ -87,6 +89,10 @@ static const char * const csr_names[] = {
     CSR_NAME(TVAL),
     CSR_NAME(CNTC),
     CSR_NAME(TICLR),
+    CSR_NAME(GSTAT),
+    CSR_NAME(GCFG),
+    CSR_NAME(GINTC),
+    CSR_NAME(GCNTC),
     CSR_NAME(LLBCTL),
     CSR_NAME(IMPCTL1),
     CSR_NAME(IMPCTL2),
@@ -698,6 +704,16 @@ INSN(tlbfill,      empty)
 INSN(tlbclr,       empty)
 INSN(tlbflush,     empty)
 INSN(invtlb,       i_rr)
+INSN(gcsrrd,       r_csr)
+INSN(gcsrwr,       r_csr)
+INSN(gcsrxchg,     rr_csr)
+INSN(gtlbclr,      empty)
+INSN(gtlbflush,    empty)
+INSN(gtlbsrch,     empty)
+INSN(gtlbrd,       empty)
+INSN(gtlbwr,       empty)
+INSN(gtlbfill,     empty)
+INSN(hvcl,         i)
 INSN(cacop,        cop_r_i)
 INSN(lddir,        rr_i)
 INSN(ldpte,        j_i)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 3089d42044..b40fabe9d7 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -493,6 +493,20 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
   csrxchg           0000 0100 .............. ..... .....     @rr_csr
 }
 
+{
+  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
+  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
+  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
+}
+
+gtlbclr          0000 01100100 10000 01000 00000 00001    @empty
+gtlbflush        0000 01100100 10000 01001 00000 00001    @empty
+gtlbsrch         0000 01100100 10000 01010 00000 00001    @empty
+gtlbrd           0000 01100100 10000 01011 00000 00001    @empty
+gtlbwr           0000 01100100 10000 01100 00000 00001    @empty
+gtlbfill         0000 01100100 10000 01101 00000 00001    @empty
+hvcl             0000 0000 0010 1011 1 ...............    @i15
+
 iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
 iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
 iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index 655dce329e..5a404632f5 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -55,7 +55,7 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
         tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
     }
 
-    offset = CPU_CSR_OFFSET(CSR_TID, 0);
+    offset = CSR_OFFSET(CSR_TID, 0);
     tcg_gen_ld_i64(dst2, tcg_env, offset);
 
     return true;
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 3cdf061e3d..adf088627e 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -39,6 +39,16 @@ GEN_FALSE_TRANS(lddir)
 GEN_FALSE_TRANS(ertn)
 GEN_FALSE_TRANS(dbcl)
 GEN_FALSE_TRANS(idle)
+GEN_FALSE_TRANS(gcsrrd)
+GEN_FALSE_TRANS(gcsrwr)
+GEN_FALSE_TRANS(gcsrxchg)
+GEN_FALSE_TRANS(gtlbclr)
+GEN_FALSE_TRANS(gtlbflush)
+GEN_FALSE_TRANS(gtlbsrch)
+GEN_FALSE_TRANS(gtlbrd)
+GEN_FALSE_TRANS(gtlbwr)
+GEN_FALSE_TRANS(gtlbfill)
+GEN_FALSE_TRANS(hvcl)
 
 #else
 
@@ -69,8 +79,25 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
     return true;
 }
 
+static bool set_gcsr_trans_func(unsigned int csr_num, GenCSRRead readfn,
+                                GenCSRWrite writefn)
+{
+    CSRInfo *csr;
+
+    csr = get_gcsr(csr_num);
+    if (!csr) {
+        return false;
+    }
+
+    csr->readfn = (GenCSRFunc)readfn;
+    csr->writefn = (GenCSRFunc)writefn;
+    return true;
+}
+
 #define SET_CSR_FUNC(NAME, read, write)                 \
         set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
+#define SET_GCSR_FUNC(NAME, read, write)                \
+        set_gcsr_trans_func(LOONGARCH_CSR_##NAME, read, write)
 
 void loongarch_csr_translate_init(void)
 {
@@ -85,14 +112,28 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
     SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
     SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
+    SET_CSR_FUNC(GSTAT, NULL, gen_helper_csrwr_gstat);
+    SET_CSR_FUNC(GTLBC, NULL, gen_helper_csrwr_gtlbc);
+    SET_CSR_FUNC(GINTC, NULL, gen_helper_csrwr_gintc);
+
+    SET_GCSR_FUNC(ESTAT, NULL, gen_helper_gcsrwr_estat);
+    SET_GCSR_FUNC(ASID, NULL, gen_helper_gcsrwr_asid);
+    SET_GCSR_FUNC(PGD, gen_helper_gcsrrd_pgd, NULL);
+    SET_GCSR_FUNC(TCFG, NULL, gen_helper_gcsrwr_tcfg);
+    SET_GCSR_FUNC(TVAL, gen_helper_gcsrrd_tval, NULL);
+    SET_GCSR_FUNC(TICLR, NULL, gen_helper_gcsrwr_ticlr);
 }
 #undef SET_CSR_FUNC
+#undef SET_GCSR_FUNC
 
 static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
 {
     if ((csr->flags & CSRFL_READONLY) && write) {
         return false;
     }
+    if ((csr->flags & CSRFL_GUEST_READONLY) && ctx->guest_mode && write) {
+        return false;
+    }
     if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
         ctx->base.is_jmp = DISAS_EXIT_UPDATE;
     } else if ((csr->flags & CSRFL_EXITTB) && write) {
@@ -106,24 +147,27 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
     TCGv dest;
     const CSRInfo *csr;
     GenCSRRead readfn;
-    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
     }
-    csr = get_csr(a->csr);
+    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
     if (csr == NULL) {
         /* CSR is undefined: read as 0. */
         dest = tcg_constant_tl(0);
     } else {
         check_csr_flags(ctx, csr, false);
+        if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
+            gen_helper_gspr(tcg_env);
+            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+            return true;
+        }
         dest = gpr_dst(ctx, a->rd, EXT_NONE);
         readfn = (GenCSRRead)csr->readfn;
         if (readfn) {
             readfn(dest, tcg_env);
         } else {
-            offset = get_csr_offset(csr, 0);
-            tcg_gen_ld_tl(dest, tcg_env, offset);
+            tcg_gen_ld_tl(dest, tcg_env, csr->offset);
         }
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -135,17 +179,21 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     TCGv dest, src1;
     const CSRInfo *csr;
     GenCSRWrite writefn;
-    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
     }
-    csr = get_csr(a->csr);
+    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
     if (csr == NULL) {
         /* CSR is undefined: write ignored, read old_value as 0. */
         gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
         return true;
     }
+    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
+        gen_helper_gspr(tcg_env);
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
     if (!check_csr_flags(ctx, csr, true)) {
         /* CSR is readonly: trap. */
         return false;
@@ -157,9 +205,8 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
         writefn(dest, tcg_env, src1);
     } else {
         dest = tcg_temp_new();
-        offset = get_csr_offset(csr, 0);
-        tcg_gen_ld_tl(dest, tcg_env, offset);
-        tcg_gen_st_tl(src1, tcg_env, offset);
+        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
+        tcg_gen_st_tl(src1, tcg_env, csr->offset);
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
     return true;
@@ -170,25 +217,140 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     TCGv src1, mask, oldv, newv, temp;
     const CSRInfo *csr;
     GenCSRWrite writefn;
-    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
     }
-    csr = get_csr(a->csr);
+    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
     if (csr == NULL) {
         /* CSR is undefined: write ignored, read old_value as 0. */
         gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
         return true;
     }
+    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
+        gen_helper_gspr(tcg_env);
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
 
     if (!check_csr_flags(ctx, csr, true)) {
         /* CSR is readonly: trap. */
         return false;
     }
 
-    /* So far only readonly csrs have readfn. */
-    assert(csr->readfn == NULL);
+    src1 = gpr_src(ctx, a->rd, EXT_NONE);
+    mask = gpr_src(ctx, a->rj, EXT_NONE);
+    oldv = tcg_temp_new();
+    newv = tcg_temp_new();
+    temp = tcg_temp_new();
+
+    if (csr->readfn) {
+        GenCSRRead readfn = (GenCSRRead)csr->readfn;
+        readfn(oldv, tcg_env);
+    } else {
+        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
+    }
+    tcg_gen_and_tl(newv, src1, mask);
+    tcg_gen_andc_tl(temp, oldv, mask);
+    tcg_gen_or_tl(newv, newv, temp);
+
+    writefn = (GenCSRWrite)csr->writefn;
+    if (writefn) {
+        writefn(oldv, tcg_env, newv);
+    } else {
+        tcg_gen_st_tl(newv, tcg_env, csr->offset);
+    }
+    gen_set_gpr(a->rd, oldv, EXT_NONE);
+    return true;
+}
+
+static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
+{
+    TCGv dest;
+    const CSRInfo *csr;
+    GenCSRRead readfn;
+
+    if (check_plv(ctx) || !avail_LVZ(ctx)) {
+        return false;
+    }
+    csr = get_gcsr(a->csr);
+    if (csr == NULL) {
+        dest = tcg_constant_tl(0);
+    } else {
+        dest = gpr_dst(ctx, a->rd, EXT_NONE);
+        if (csr->flags & CSRFL_GSPR) {
+            tcg_gen_movi_tl(dest, 0);
+        } else {
+            readfn = (GenCSRRead)csr->readfn;
+            if (readfn) {
+                readfn(dest, tcg_env);
+            } else {
+                tcg_gen_ld_tl(dest, tcg_env, csr->offset);
+            }
+        }
+    }
+    gen_set_gpr(a->rd, dest, EXT_NONE);
+    return true;
+}
+
+static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
+{
+    TCGv dest, src1;
+    const CSRInfo *csr;
+    GenCSRWrite writefn;
+
+    if (check_plv(ctx) || !avail_LVZ(ctx)) {
+        return false;
+    }
+    csr = get_gcsr(a->csr);
+    if (csr == NULL) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+    if (!check_csr_flags(ctx, csr, true)) {
+        return false;
+    }
+    if (csr->flags & CSRFL_GSPR) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+
+    src1 = gpr_src(ctx, a->rd, EXT_NONE);
+    writefn = (GenCSRWrite)csr->writefn;
+    if (writefn) {
+        dest = gpr_dst(ctx, a->rd, EXT_NONE);
+        writefn(dest, tcg_env, src1);
+    } else {
+        dest = tcg_temp_new();
+        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
+        tcg_gen_st_tl(src1, tcg_env, csr->offset);
+    }
+    gen_set_gpr(a->rd, dest, EXT_NONE);
+    return true;
+}
+
+static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
+{
+    TCGv src1, mask, oldv, newv, temp;
+    const CSRInfo *csr;
+    GenCSRRead readfn;
+    GenCSRWrite writefn;
+
+    if (check_plv(ctx) || !avail_LVZ(ctx)) {
+        return false;
+    }
+    csr = get_gcsr(a->csr);
+    if (csr == NULL) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+    if (!check_csr_flags(ctx, csr, true)) {
+        return false;
+    }
+    if (csr->flags & CSRFL_GSPR) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
 
     src1 = gpr_src(ctx, a->rd, EXT_NONE);
     mask = gpr_src(ctx, a->rj, EXT_NONE);
@@ -196,8 +358,12 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     newv = tcg_temp_new();
     temp = tcg_temp_new();
 
-    offset = get_csr_offset(csr, 0);
-    tcg_gen_ld_tl(oldv, tcg_env, offset);
+    readfn = (GenCSRRead)csr->readfn;
+    if (readfn) {
+        readfn(oldv, tcg_env);
+    } else {
+        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
+    }
     tcg_gen_and_tl(newv, src1, mask);
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
@@ -206,7 +372,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     if (writefn) {
         writefn(oldv, tcg_env, newv);
     } else {
-        tcg_gen_st_tl(newv, tcg_env, offset);
+        tcg_gen_st_tl(newv, tcg_env, csr->offset);
     }
     gen_set_gpr(a->rd, oldv, EXT_NONE);
     return true;
@@ -218,6 +384,11 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
@@ -231,6 +402,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     TCGv val = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
@@ -249,7 +425,7 @@ TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
-    if (ctx->mem_idx != MMU_DA_IDX) {
+    if (ctx->mem_idx != MMU_DA_IDX && ctx->mem_idx != MMU_GUEST_DA_IDX) {
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
         ctx->base.is_jmp = DISAS_EXIT;
     }
@@ -273,6 +449,24 @@ static bool trans_tlbrd(DisasContext *ctx, arg_tlbrd *a)
     return true;
 }
 
+static bool trans_gtlbsrch(DisasContext *ctx, arg_gtlbsrch *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbsrch(tcg_env);
+    return true;
+}
+
+static bool trans_gtlbrd(DisasContext *ctx, arg_gtlbrd *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbrd(tcg_env);
+    return true;
+}
+
 static bool trans_tlbwr(DisasContext *ctx, arg_tlbwr *a)
 {
     if (check_plv(ctx)) {
@@ -283,6 +477,16 @@ static bool trans_tlbwr(DisasContext *ctx, arg_tlbwr *a)
     return true;
 }
 
+static bool trans_gtlbwr(DisasContext *ctx, arg_gtlbwr *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbwr(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
 static bool trans_tlbfill(DisasContext *ctx, arg_tlbfill *a)
 {
     if (check_plv(ctx)) {
@@ -293,6 +497,16 @@ static bool trans_tlbfill(DisasContext *ctx, arg_tlbfill *a)
     return true;
 }
 
+static bool trans_gtlbfill(DisasContext *ctx, arg_gtlbfill *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbfill(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
 static bool trans_tlbclr(DisasContext *ctx, arg_tlbclr *a)
 {
     if (check_plv(ctx)) {
@@ -303,6 +517,16 @@ static bool trans_tlbclr(DisasContext *ctx, arg_tlbclr *a)
     return true;
 }
 
+static bool trans_gtlbclr(DisasContext *ctx, arg_gtlbclr *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbclr(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
 static bool trans_tlbflush(DisasContext *ctx, arg_tlbflush *a)
 {
     if (check_plv(ctx)) {
@@ -313,6 +537,16 @@ static bool trans_tlbflush(DisasContext *ctx, arg_tlbflush *a)
     return true;
 }
 
+static bool trans_gtlbflush(DisasContext *ctx, arg_gtlbflush *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbflush(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
 static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
 {
     TCGv rj = gpr_src(ctx, a->rj, EXT_NONE);
@@ -444,6 +678,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
     if (check_plv(ctx)) {
         return false;
     }
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
     generate_exception(ctx, EXCCODE_DBP);
     return true;
 }
@@ -454,9 +692,26 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a)
         return false;
     }
 
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
+
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
     gen_helper_idle(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
+
+static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
+{
+    if (!avail_LVZ(ctx) || !ctx->guest_mode) {
+        return false;
+    }
+
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+    gen_helper_hvcl(tcg_env, tcg_constant_i32(a->imm));
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
 #endif
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 124dce6269..15c83ef72d 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -122,12 +122,16 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     CPULoongArchState *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
+    ctx->guest_mode = (ctx->base.tb->flags & HW_FLAGS_GUEST_MODE) != 0;
     ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
     ctx->plv = ctx->base.tb->flags & HW_FLAGS_PLV_MASK;
     if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
         ctx->mem_idx = ctx->plv;
+        if (ctx->guest_mode) {
+            ctx->mem_idx += MMU_GUEST_IDX;
+        }
     } else {
-        ctx->mem_idx = MMU_DA_IDX;
+        ctx->mem_idx = ctx->guest_mode ? MMU_GUEST_DA_IDX : MMU_DA_IDX;
     }
 
     /* Bound the number of insns to execute to those left on the page.  */
-- 
2.52.0


