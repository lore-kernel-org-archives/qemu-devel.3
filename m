Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ECAC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAun-00024Q-5I; Wed, 26 Aug 2026 06:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wzAuR-0001wM-H0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:07 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wzAuO-0003OC-2l
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:07 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 9CD02D069;
 Wed, 26 Aug 2026 16:01:01 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v4 11/14] target/loongarch: Translate LVZ guest CSR
 instructions
Date: Wed, 26 Aug 2026 18:30:15 +0800
Message-ID: <e2be598b538ab467dda5603f59cd7aa6faa5d7fe.1787739852.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787739852.git.prcups@krgm.moe>
References: <cover.1787739852.git.prcups@krgm.moe>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Decode and translate GCSRRD, GCSRWR and GCSRXCHG, and select the host or
guest helper and CSR offset from one shared CSRInfo table.

Guest execution of sensitive CSRs raises GSPR without writing an artificial
value to the destination register. Host guest-CSR instructions reuse the
ordinary CSR translation implementation.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/csr.c                        |   4 +-
 target/loongarch/csr.h                        |   4 +-
 target/loongarch/disas.c                      |   8 +
 target/loongarch/insns.decode                 |   6 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 218 ++++++++++++++----
 target/loongarch/tcg/translate.c              |   6 +-
 6 files changed, 193 insertions(+), 53 deletions(-)

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index fa018a4582..928ffeb193 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -10,7 +10,9 @@
     [LOONGARCH_CSR_##NAME] = {                             \
         .name   = (stringify(NAME)),                       \
         .offset = CSR_OFFSET(CSR_##NAME),                  \
-        .flags = FL, .readfn = RD, .writefn = WR           \
+        .flags = FL,                                       \
+        .readfn[LOONGARCH_VM_LEVEL_HOST] = RD,             \
+        .writefn[LOONGARCH_VM_LEVEL_HOST] = WR             \
     }
 
 #define CSR_OFF_ARRAY_FLAGS(NAME, N, FL)                      \
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 647695e248..50f06a359f 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -28,8 +28,8 @@ typedef struct {
     const char *name;
     int offset;
     int flags;
-    GenCSRFunc readfn;
-    GenCSRFunc writefn;
+    GenCSRFunc readfn[LOONGARCH_VM_LEVELS];
+    GenCSRFunc writefn[LOONGARCH_VM_LEVELS];
 } CSRInfo;
 
 CSRInfo *get_csr(unsigned int csr_num);
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3249ab7ac6..59d6a55c78 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -51,6 +51,7 @@ static const char * const csr_names[] = {
     CSR_NAME(BADI),
     CSR_NAME(EENTRY),
     CSR_NAME(TLBIDX),
+    CSR_NAME(GTLBC),
     CSR_NAME(TLBEHI),
     CSR_NAME(TLBELO0),
     CSR_NAME(TLBELO1),
@@ -87,6 +88,10 @@ static const char * const csr_names[] = {
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
@@ -698,6 +703,9 @@ INSN(tlbfill,      empty)
 INSN(tlbclr,       empty)
 INSN(tlbflush,     empty)
 INSN(invtlb,       i_rr)
+INSN(gcsrrd,       r_csr)
+INSN(gcsrwr,       r_csr)
+INSN(gcsrxchg,     rr_csr)
 INSN(cacop,        cop_r_i)
 INSN(lddir,        rr_i)
 INSN(ldpte,        j_i)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 3089d42044..4612af9433 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -493,6 +493,12 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
   csrxchg           0000 0100 .............. ..... .....     @rr_csr
 }
 
+{
+  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
+  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
+  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
+}
+
 iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
 iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
 iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index abedb132b9..117f2c888c 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -39,6 +39,9 @@ GEN_FALSE_TRANS(lddir)
 GEN_FALSE_TRANS(ertn)
 GEN_FALSE_TRANS(dbcl)
 GEN_FALSE_TRANS(idle)
+GEN_FALSE_TRANS(gcsrrd)
+GEN_FALSE_TRANS(gcsrwr)
+GEN_FALSE_TRANS(gcsrxchg)
 
 #else
 
@@ -54,8 +57,8 @@ static bool check_plv(DisasContext *ctx)
     return false;
 }
 
-static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
-                               GenCSRWrite writefn)
+static bool set_csr_trans_func(unsigned int csr_num, int guest,
+                               GenCSRRead readfn, GenCSRWrite writefn)
 {
     CSRInfo *csr;
 
@@ -64,13 +67,17 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
         return false;
     }
 
-    csr->readfn = (GenCSRFunc)readfn;
-    csr->writefn = (GenCSRFunc)writefn;
+    csr->readfn[guest] = (GenCSRFunc)readfn;
+    csr->writefn[guest] = (GenCSRFunc)writefn;
     return true;
 }
 
 #define SET_CSR_FUNC(NAME, read, write)                 \
-        set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
+        set_csr_trans_func(LOONGARCH_CSR_##NAME,        \
+                           LOONGARCH_VM_LEVEL_HOST, read, write)
+#define SET_GCSR_FUNC(NAME, read, write)                \
+        set_csr_trans_func(LOONGARCH_CSR_##NAME,        \
+                           LOONGARCH_VM_LEVEL_GUEST, read, write)
 
 void loongarch_csr_translate_init(void)
 {
@@ -85,12 +92,28 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
     SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
     SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
+    SET_CSR_FUNC(GSTAT, NULL, gen_helper_csrwr_gstat);
+    SET_CSR_FUNC(GTLBC, NULL, gen_helper_csrwr_gtlbc);
+    SET_CSR_FUNC(GINTC, NULL, gen_helper_csrwr_gintc);
+
+    SET_GCSR_FUNC(STLBPS, NULL, gen_helper_gcsrwr_stlbps);
+    SET_GCSR_FUNC(ESTAT, NULL, gen_helper_gcsrwr_estat);
+    SET_GCSR_FUNC(ASID, NULL, gen_helper_gcsrwr_asid);
+    SET_GCSR_FUNC(PGD, gen_helper_gcsrrd_pgd, NULL);
+    SET_GCSR_FUNC(PWCL, NULL, gen_helper_gcsrwr_pwcl);
+    SET_GCSR_FUNC(PWCH, NULL, gen_helper_gcsrwr_pwch);
+    SET_GCSR_FUNC(TCFG, NULL, gen_helper_gcsrwr_tcfg);
+    SET_GCSR_FUNC(TVAL, gen_helper_gcsrrd_tval, NULL);
+    SET_GCSR_FUNC(TICLR, NULL, gen_helper_gcsrwr_ticlr);
 }
 #undef SET_CSR_FUNC
+#undef SET_GCSR_FUNC
 
-static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
+static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr,
+                            int guest, bool write)
 {
-    if ((csr->flags & CSRFL_READONLY) && write) {
+    if ((guest == LOONGARCH_VM_LEVEL_HOST || ctx->guest_mode) &&
+        (csr->flags & CSRFL_READONLY) && write) {
         return false;
     }
     if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
@@ -101,117 +124,214 @@ static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
     return true;
 }
 
-static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
+static const CSRInfo *get_csr_for_level(unsigned int csr_num, int guest)
+{
+    const CSRInfo *csr = get_csr(csr_num);
+
+    if (csr && guest == LOONGARCH_VM_LEVEL_GUEST &&
+        (csr->flags & CSRFL_GUEST_INVALID)) {
+        return NULL;
+    }
+    return csr;
+}
+
+static bool trans_csrrd_impl(DisasContext *ctx, int rd, unsigned int csr_num,
+                             int guest)
 {
     TCGv dest;
     const CSRInfo *csr;
     GenCSRRead readfn;
-    tcg_target_long offset;
 
-    if (check_plv(ctx)) {
-        return false;
-    }
-    csr = get_csr(a->csr);
+    csr = get_csr_for_level(csr_num, guest);
     if (csr == NULL) {
         /* CSR is undefined: read as 0. */
         dest = tcg_constant_tl(0);
     } else {
-        check_csr_flags(ctx, csr, false);
-        dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        readfn = (GenCSRRead)csr->readfn;
-        if (readfn) {
-            readfn(dest, tcg_env);
+        check_csr_flags(ctx, csr, guest, false);
+        if (guest == LOONGARCH_VM_LEVEL_GUEST &&
+            (csr->flags & CSRFL_GSPR)) {
+            if (ctx->guest_mode) {
+                generate_exception(ctx, EXCCODE_GSPR);
+                return true;
+            }
+            dest = tcg_constant_tl(0);
         } else {
-            offset = get_csr_offset(csr, LOONGARCH_VM_LEVEL_HOST);
-            tcg_gen_ld_tl(dest, tcg_env, offset);
+            dest = gpr_dst(ctx, rd, EXT_NONE);
+            readfn = (GenCSRRead)csr->readfn[guest];
+            if (readfn) {
+                readfn(dest, tcg_env);
+            } else {
+                tcg_gen_ld_tl(dest, tcg_env,
+                              get_csr_offset(csr, guest));
+            }
         }
     }
-    gen_set_gpr(a->rd, dest, EXT_NONE);
+    gen_set_gpr(rd, dest, EXT_NONE);
     return true;
 }
 
-static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
+static bool trans_csrwr_impl(DisasContext *ctx, int rd, unsigned int csr_num,
+                             int guest)
 {
     TCGv dest, src1;
     const CSRInfo *csr;
     GenCSRWrite writefn;
     tcg_target_long offset;
 
-    if (check_plv(ctx)) {
-        return false;
-    }
-    csr = get_csr(a->csr);
+    csr = get_csr_for_level(csr_num, guest);
     if (csr == NULL) {
         /* CSR is undefined: write ignored, read old_value as 0. */
-        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        gen_set_gpr(rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+    if (guest == LOONGARCH_VM_LEVEL_GUEST &&
+        (csr->flags & CSRFL_GSPR)) {
+        if (ctx->guest_mode) {
+            generate_exception(ctx, EXCCODE_GSPR);
+        } else {
+            gen_set_gpr(rd, tcg_constant_tl(0), EXT_NONE);
+        }
         return true;
     }
-    if (!check_csr_flags(ctx, csr, true)) {
+    if (!check_csr_flags(ctx, csr, guest, true)) {
         /* CSR is readonly: trap. */
         return false;
     }
-    src1 = gpr_src(ctx, a->rd, EXT_NONE);
-    writefn = (GenCSRWrite)csr->writefn;
+    src1 = gpr_src(ctx, rd, EXT_NONE);
+    writefn = (GenCSRWrite)csr->writefn[guest];
     if (writefn) {
-        dest = gpr_dst(ctx, a->rd, EXT_NONE);
+        dest = gpr_dst(ctx, rd, EXT_NONE);
         writefn(dest, tcg_env, src1);
     } else {
         dest = tcg_temp_new();
-        offset = get_csr_offset(csr, LOONGARCH_VM_LEVEL_HOST);
+        offset = get_csr_offset(csr, guest);
         tcg_gen_ld_tl(dest, tcg_env, offset);
         tcg_gen_st_tl(src1, tcg_env, offset);
     }
-    gen_set_gpr(a->rd, dest, EXT_NONE);
+    gen_set_gpr(rd, dest, EXT_NONE);
     return true;
 }
 
-static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
+static bool trans_csrxchg_impl(DisasContext *ctx, int rd, int rj,
+                               unsigned int csr_num, int guest)
 {
     TCGv src1, mask, oldv, newv, temp;
     const CSRInfo *csr;
     GenCSRWrite writefn;
     tcg_target_long offset;
 
-    if (check_plv(ctx)) {
-        return false;
-    }
-    csr = get_csr(a->csr);
+    csr = get_csr_for_level(csr_num, guest);
     if (csr == NULL) {
         /* CSR is undefined: write ignored, read old_value as 0. */
-        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        gen_set_gpr(rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+    if (guest == LOONGARCH_VM_LEVEL_GUEST &&
+        (csr->flags & CSRFL_GSPR)) {
+        if (ctx->guest_mode) {
+            generate_exception(ctx, EXCCODE_GSPR);
+        } else {
+            gen_set_gpr(rd, tcg_constant_tl(0), EXT_NONE);
+        }
         return true;
     }
 
-    if (!check_csr_flags(ctx, csr, true)) {
+    if (!check_csr_flags(ctx, csr, guest, true)) {
         /* CSR is readonly: trap. */
         return false;
     }
 
-    /* So far only readonly csrs have readfn. */
-    assert(csr->readfn == NULL);
-
-    src1 = gpr_src(ctx, a->rd, EXT_NONE);
-    mask = gpr_src(ctx, a->rj, EXT_NONE);
+    src1 = gpr_src(ctx, rd, EXT_NONE);
+    mask = gpr_src(ctx, rj, EXT_NONE);
     oldv = tcg_temp_new();
     newv = tcg_temp_new();
     temp = tcg_temp_new();
+    offset = get_csr_offset(csr, guest);
 
-    offset = get_csr_offset(csr, LOONGARCH_VM_LEVEL_HOST);
-    tcg_gen_ld_tl(oldv, tcg_env, offset);
+    if (csr->readfn[guest]) {
+        GenCSRRead readfn = (GenCSRRead)csr->readfn[guest];
+        readfn(oldv, tcg_env);
+    } else {
+        tcg_gen_ld_tl(oldv, tcg_env, offset);
+    }
     tcg_gen_and_tl(newv, src1, mask);
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
 
-    writefn = (GenCSRWrite)csr->writefn;
+    writefn = (GenCSRWrite)csr->writefn[guest];
     if (writefn) {
         writefn(oldv, tcg_env, newv);
     } else {
         tcg_gen_st_tl(newv, tcg_env, offset);
     }
-    gen_set_gpr(a->rd, oldv, EXT_NONE);
+    gen_set_gpr(rd, oldv, EXT_NONE);
     return true;
 }
 
+static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
+{
+    if (check_plv(ctx)) {
+        return false;
+    }
+    return trans_csrrd_impl(ctx, a->rd, a->csr, ctx->guest_mode);
+}
+
+static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
+{
+    if (check_plv(ctx)) {
+        return false;
+    }
+    return trans_csrwr_impl(ctx, a->rd, a->csr, ctx->guest_mode);
+}
+
+static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
+{
+    if (check_plv(ctx)) {
+        return false;
+    }
+    return trans_csrxchg_impl(ctx, a->rd, a->rj, a->csr,
+                              ctx->guest_mode);
+}
+
+static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx)) {
+        return false;
+    }
+    if (ctx->guest_mode) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
+    return trans_csrrd_impl(ctx, a->rd, a->csr,
+                            LOONGARCH_VM_LEVEL_GUEST);
+}
+
+static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx)) {
+        return false;
+    }
+    if (ctx->guest_mode) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
+    return trans_csrwr_impl(ctx, a->rd, a->csr,
+                            LOONGARCH_VM_LEVEL_GUEST);
+}
+
+static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx)) {
+        return false;
+    }
+    if (ctx->guest_mode) {
+        generate_exception(ctx, EXCCODE_GSPR);
+        return true;
+    }
+    return trans_csrxchg_impl(ctx, a->rd, a->rj, a->csr,
+                              LOONGARCH_VM_LEVEL_GUEST);
+}
+
 static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
                         void (*func)(TCGv, TCGv_ptr, TCGv))
 {
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
2.55.0


