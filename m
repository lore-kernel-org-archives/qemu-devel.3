Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C91C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi76W-00063r-Ju; Fri, 10 Jul 2026 05:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wi76K-0005wr-On
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:00:55 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wi76C-00049H-VH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:00:48 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 88655241FC93;
 Fri, 10 Jul 2026 17:00:37 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 4/8] target/loongarch: Add LVZ guest CSR tables
Date: Fri, 10 Jul 2026 17:00:13 +0800
Message-ID: <0bcc5d30b6495f266413e773a4c1bbe203ac0b68.1783673526.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783673526.git.prcups@krgm.moe>
References: <cover.1783673526.git.prcups@krgm.moe>
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

Add the guest CSR lookup table and get_gcsr() helper, mark guest
read-only registers and guest sensitive privileged resources, and store
host and guest CSRInfo offsets relative to CPULoongArchState so CSR
access generation can select the host or guest table directly.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c                        |   2 +-
 target/loongarch/csr.c                        | 124 +++++++++++++++++-
 target/loongarch/csr.h                        |  12 +-
 .../tcg/insn_trans/trans_extra.c.inc          |   2 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  16 +--
 5 files changed, 133 insertions(+), 23 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa..492b17e136 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -783,7 +783,7 @@ static void loongarch_cpu_dump_csr(CPUState *cs, FILE *f)
             qemu_fprintf(f, " CSR%03d:", col);
         }
 
-        addr = (void *)env + get_csr_offset(csr_info, 0);
+        addr = (void *)env + csr_info->offset;
         qemu_fprintf(f, " %s ", csr_info->name);
         len = strlen(csr_info->name);
         for (; len < 6; len++) {
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 309b826ca9..ed9d25edf2 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -9,19 +9,34 @@
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
-        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
+        .offset = CSR_OFFSET(CSR_##NAME[N], 0),               \
+        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
     }
 
 #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
+#define GCSR_OFF_FUNCS(NAME, FL, RD, WR)                  \
+    [LOONGARCH_CSR_##NAME] = {                            \
+        .name   = (stringify(GCSR_##NAME)),               \
+        .offset = CSR_OFFSET(CSR_##NAME, 1),              \
+        .flags = FL, .readfn = RD, .writefn = WR          \
+    }
+#define GCSR_OFF_ARRAY(NAME, N)                               \
+    [LOONGARCH_CSR_##NAME(N)] = {                             \
+        .name   = (stringify(GCSR_##NAME##N)),                \
+        .offset = CSR_OFFSET(CSR_##NAME[N], 1),               \
+        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
+    }
+#define GCSR_OFF_FLAGS(NAME, FL) GCSR_OFF_FUNCS(NAME, FL, NULL, NULL)
+#define GCSR_OFF(NAME) GCSR_OFF_FLAGS(NAME, CSRFL_BASIC)
+#define GCSR_GSPR(NAME) GCSR_OFF_FLAGS(NAME, CSRFL_GSPR)
 
 static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
@@ -35,6 +50,8 @@ static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
     CSR_OFF(EENTRY),
     CSR_OFF(TLBIDX),
+    CSR_OFF(GTLBC),
+    CSR_OFF(TRGP),
     CSR_OFF(TLBEHI),
     CSR_OFF(TLBELO0),
     CSR_OFF(TLBELO1),
@@ -71,6 +88,10 @@ static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
     CSR_OFF(CNTC),
     CSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    CSR_OFF(GSTAT),
+    CSR_OFF(GCFG),
+    CSR_OFF_FLAGS(GINTC, CSRFL_IO),
+    CSR_OFF(GCNTC),
     CSR_OFF(LLBCTL),
     CSR_OFF(IMPCTL1),
     CSR_OFF(IMPCTL2),
@@ -135,6 +156,87 @@ static CSRInfo csr_info[] = {
     CSR_OFF(MSGIR),
 };
 
+static CSRInfo gcsr_info[] = {
+    GCSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
+    GCSR_OFF(PRMD),
+    GCSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
+    GCSR_OFF_FLAGS(MISC, CSRFL_GUEST_READONLY),
+    GCSR_OFF(ECFG),
+    GCSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
+    GCSR_OFF(ERA),
+    GCSR_OFF(BADV),
+    GCSR_OFF_FLAGS(BADI, CSRFL_GUEST_READONLY),
+    GCSR_OFF(EENTRY),
+    GCSR_OFF(TLBIDX),
+    GCSR_GSPR(GTLBC),
+    GCSR_GSPR(TRGP),
+    GCSR_OFF(TLBEHI),
+    GCSR_OFF(TLBELO0),
+    GCSR_OFF(TLBELO1),
+    GCSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
+    GCSR_OFF(PGDL),
+    GCSR_OFF(PGDH),
+    GCSR_OFF_FLAGS(PGD, CSRFL_GUEST_READONLY),
+    GCSR_OFF(PWCL),
+    GCSR_OFF(PWCH),
+    GCSR_OFF(STLBPS),
+    GCSR_OFF(RVACFG),
+    GCSR_OFF_FLAGS(CPUID, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG1, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG2, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG3, CSRFL_GUEST_READONLY),
+    GCSR_OFF_ARRAY(SAVE, 0),
+    GCSR_OFF_ARRAY(SAVE, 1),
+    GCSR_OFF_ARRAY(SAVE, 2),
+    GCSR_OFF_ARRAY(SAVE, 3),
+    GCSR_OFF_ARRAY(SAVE, 4),
+    GCSR_OFF_ARRAY(SAVE, 5),
+    GCSR_OFF_ARRAY(SAVE, 6),
+    GCSR_OFF_ARRAY(SAVE, 7),
+    GCSR_OFF_ARRAY(SAVE, 8),
+    GCSR_OFF_ARRAY(SAVE, 9),
+    GCSR_OFF_ARRAY(SAVE, 10),
+    GCSR_OFF_ARRAY(SAVE, 11),
+    GCSR_OFF_ARRAY(SAVE, 12),
+    GCSR_OFF_ARRAY(SAVE, 13),
+    GCSR_OFF_ARRAY(SAVE, 14),
+    GCSR_OFF_ARRAY(SAVE, 15),
+    GCSR_OFF(TID),
+    GCSR_OFF_FLAGS(TCFG, CSRFL_IO),
+    GCSR_OFF_FLAGS(TVAL, CSRFL_GUEST_READONLY | CSRFL_IO),
+    GCSR_OFF(CNTC),
+    GCSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    GCSR_GSPR(GSTAT),
+    GCSR_GSPR(GCFG),
+    GCSR_GSPR(GINTC),
+    GCSR_GSPR(GCNTC),
+    GCSR_OFF(LLBCTL),
+    GCSR_GSPR(IMPCTL1),
+    GCSR_GSPR(IMPCTL2),
+    GCSR_OFF(TLBRENTRY),
+    GCSR_OFF(TLBRBADV),
+    GCSR_OFF(TLBRERA),
+    GCSR_OFF(TLBRSAVE),
+    GCSR_OFF(TLBRELO0),
+    GCSR_OFF(TLBRELO1),
+    GCSR_OFF(TLBREHI),
+    GCSR_OFF(TLBRPRMD),
+    GCSR_GSPR(MERRCTL),
+    GCSR_GSPR(MERRINFO1),
+    GCSR_GSPR(MERRINFO2),
+    GCSR_GSPR(MERRENTRY),
+    GCSR_GSPR(MERRERA),
+    GCSR_GSPR(MERRSAVE),
+    GCSR_GSPR(CTAG),
+    GCSR_OFF_ARRAY(DMW, 0),
+    GCSR_OFF_ARRAY(DMW, 1),
+    GCSR_OFF_ARRAY(DMW, 2),
+    GCSR_OFF_ARRAY(DMW, 3),
+    GCSR_GSPR(DBG),
+    GCSR_GSPR(DERA),
+    GCSR_GSPR(DSAVE),
+};
+
 CSRInfo *get_csr(unsigned int csr_num)
 {
     CSRInfo *csr;
@@ -151,6 +253,22 @@ CSRInfo *get_csr(unsigned int csr_num)
     return csr;
 }
 
+CSRInfo *get_gcsr(unsigned int csr_num)
+{
+    CSRInfo *csr;
+
+    if (csr_num >= ARRAY_SIZE(gcsr_info)) {
+        return NULL;
+    }
+
+    csr = &gcsr_info[csr_num];
+    if (csr->flags == 0) {
+        return NULL;
+    }
+
+    return csr;
+}
+
 bool set_csr_flag(unsigned int csr_num, int flag)
 {
     CSRInfo *csr;
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index c2b6b882bc..c39230f30c 100644
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
@@ -20,6 +19,8 @@ enum {
     CSRFL_IO       = (1 << 2),
     CSRFL_UNUSED   = (1 << 3),
     CSRFL_BASIC    = (1 << 4),
+    CSRFL_GUEST_READONLY = (1 << 5),
+    CSRFL_GSPR     = (1 << 6),
 };
 
 typedef struct {
@@ -31,9 +32,6 @@ typedef struct {
 } CSRInfo;
 
 CSRInfo *get_csr(unsigned int csr_num);
+CSRInfo *get_gcsr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
-static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
-{
-    return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
-}
 #endif /* TARGET_LOONGARCH_CSR_H */
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
index 6728ce5ec9..2094d182ac 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -106,7 +106,6 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
     TCGv dest;
     const CSRInfo *csr;
     GenCSRRead readfn;
-    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
@@ -122,8 +121,7 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
         if (readfn) {
             readfn(dest, tcg_env);
         } else {
-            offset = get_csr_offset(csr, 0);
-            tcg_gen_ld_tl(dest, tcg_env, offset);
+            tcg_gen_ld_tl(dest, tcg_env, csr->offset);
         }
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -135,7 +133,6 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     TCGv dest, src1;
     const CSRInfo *csr;
     GenCSRWrite writefn;
-    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
@@ -157,9 +154,8 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
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
@@ -170,7 +166,6 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     TCGv src1, mask, oldv, newv, temp;
     const CSRInfo *csr;
     GenCSRWrite writefn;
-    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
@@ -196,8 +191,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     newv = tcg_temp_new();
     temp = tcg_temp_new();
 
-    offset = get_csr_offset(csr, 0);
-    tcg_gen_ld_tl(oldv, tcg_env, offset);
+    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
     tcg_gen_and_tl(newv, src1, mask);
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
@@ -206,7 +200,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     if (writefn) {
         writefn(oldv, tcg_env, newv);
     } else {
-        tcg_gen_st_tl(newv, tcg_env, offset);
+        tcg_gen_st_tl(newv, tcg_env, csr->offset);
     }
     gen_set_gpr(a->rd, oldv, EXT_NONE);
     return true;
-- 
2.52.0


