Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC6CF31B4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 12:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhMs-0008WN-46; Wed, 19 Nov 2025 07:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhMp-0008V3-U6
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:32:59 -0500
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhMn-00059c-3B
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:32:59 -0500
Received: from cslab-raptor.s.cslab.moe (unknown [166.111.238.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 909C549A7E7;
 Wed, 19 Nov 2025 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1763555575; bh=88oi0S5i+ruLPjvaInPKifU47JfIBK7DmaKwzRiwJlQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O+TXXjzQUzE+P/xl6Ud4QNi9/+hvr8CuzAfp7MYIJK8bDel52I1IwdqaR8S6NNppM
 TO4lZXgIJNPBf/xrcAx24udAl124cp8/lYSvmjpyORkdCc/X9Yb3tq2TSBImLcjrdG
 iXDMZ6oLmXZi+TtAeyliRCT47eqF/srgOw/h5zwU=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v2 6/7] target/loongarch: Add sc.q instructions
Date: Wed, 19 Nov 2025 20:30:57 +0800
Message-ID: <20251119123101.1542976-6-c@jia.je>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119123101.1542976-4-c@jia.je>
References: <20251119122822.1513788-1-c@jia.je>
 <20251119123101.1542976-4-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the sc.q instruction in LoongArch v1.1, guarded by CPUCFG2.SCQ. It
is implemented by reading 128bit data (llval + llval_high) in ll.d when
aligned to 16B boundary, and cmpxchg 128bit in sc.q. If ld.d
matches the higher part of the 128bit, its data is taken from
llval_high.

Expected assembly sequence:

ll.d lo, base, 0
ld.d hi, base, 8
sc.q lo, hi, base

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h                        |  3 +
 target/loongarch/disas.c                      |  1 +
 target/loongarch/insns.decode                 |  1 +
 .../tcg/insn_trans/trans_atomic.c.inc         | 82 +++++++++++++++++++
 .../tcg/insn_trans/trans_memory.c.inc         | 22 +++++
 target/loongarch/tcg/translate.c              |  6 +-
 target/loongarch/translate.h                  |  1 +
 7 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5cab02ad6f..0a89c06b01 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -142,6 +142,7 @@ FIELD(CPUCFG2, FRECIPE, 25, 1)
 FIELD(CPUCFG2, LAM_BH, 27, 1)
 FIELD(CPUCFG2, LAMCAS, 28, 1)
 FIELD(CPUCFG2, LLACQ_SCREL, 29, 1)
+FIELD(CPUCFG2, SCQ, 30, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
@@ -377,6 +378,8 @@ typedef struct CPUArchState {
     uint32_t fcsr0_mask;
     uint64_t lladdr; /* LL virtual address compared against SC */
     uint64_t llval;
+    uint64_t llval_high; /* For 128-bit atomic SC.Q */
+    uint64_t llbit_scq; /* Potential LL.D+LD.D+SC.Q sequence in effect */
 #endif
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3164fade9b..3249ab7ac6 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -584,6 +584,7 @@ INSN(fldx_s,       frr)
 INSN(fldx_d,       frr)
 INSN(fstx_s,       frr)
 INSN(fstx_d,       frr)
+INSN(sc_q,         rrr)
 INSN(llacq_w,      rr_i)
 INSN(screl_w,      rr_i)
 INSN(llacq_d,      rr_i)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 7898f5f719..3089d42044 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -262,6 +262,7 @@ ll_w            0010 0000 .............. ..... .....     @rr_i14s2
 sc_w            0010 0001 .............. ..... .....     @rr_i14s2
 ll_d            0010 0010 .............. ..... .....     @rr_i14s2
 sc_d            0010 0011 .............. ..... .....     @rr_i14s2
+sc_q            0011 10000101 01110 ..... ..... .....    @rrr
 llacq_w         0011 10000101 01111 00000 ..... .....    @rr_i0
 screl_w         0011 10000101 01111 00001 ..... .....    @rr_i0
 llacq_d         0011 10000101 01111 00010 ..... .....    @rr_i0
diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index c9a6dcfdeb..565daa7219 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -6,14 +6,48 @@
 static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool acq)
 {
     TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv t0 = make_address_i(ctx, src1, a->imm);
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv mask = tcg_constant_tl(0xf);
+    TCGv one = tcg_constant_tl(1);
+    TCGv zero = tcg_constant_tl(0);
+    TCGLabel *l1 = gen_new_label();
+    TCGLabel *done = gen_new_label();
+
+    if (avail_SCQ(ctx) && mop == MO_TEUQ) {
+        /*
+         * The LL.D+LD.D may be paired with SC.Q,
+         * load 128-bit if aligned: (t0 & 0xf) == 0
+         */
+        tcg_gen_and_tl(t1, t0, mask);
+        tcg_gen_brcond_tl(TCG_COND_EQ, t1, zero, l1);
+        /* fallthrough if not aligned to 16B */
+    }
 
     tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop | MO_ALIGN);
     tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
     gen_set_gpr(a->rd, t1, EXT_NONE);
 
+    if (avail_SCQ(ctx) && mop == MO_TEUQ) {
+        tcg_gen_br(done);
+
+        gen_set_label(l1);
+
+        /* Load 16B data and save into llval/llval_high */
+        tcg_gen_qemu_ld_i128(t16, t0, ctx->mem_idx, MO_128 | MO_ALIGN);
+        tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
+        tcg_gen_extr_i128_i64(t1, t2, t16);
+        tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
+        tcg_gen_st_tl(t2, tcg_env, offsetof(CPULoongArchState, llval_high));
+        tcg_gen_st_tl(one, tcg_env, offsetof(CPULoongArchState, llbit_scq));
+        gen_set_gpr(a->rd, t1, EXT_NONE);
+
+        gen_set_label(done);
+    }
+
     if (acq) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
@@ -28,6 +62,7 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool rel)
     TCGv src2 = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv t0 = tcg_temp_new();
     TCGv val = tcg_temp_new();
+    TCGv zero = tcg_constant_tl(0);
 
     TCGLabel *l1 = gen_new_label();
     TCGLabel *done = gen_new_label();
@@ -37,6 +72,11 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool rel)
     if (rel) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     }
+
+    if (avail_SCQ(ctx)) {
+        tcg_gen_st_tl(zero, tcg_env, offsetof(CPULoongArchState, llbit_scq));
+    }
+
     tcg_gen_brcond_tl(TCG_COND_EQ, t0, cpu_lladdr, l1);
     tcg_gen_movi_tl(dest, 0);
     tcg_gen_br(done);
@@ -53,6 +93,47 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool rel)
     return true;
 }
 
+static bool gen_sc_q(DisasContext *ctx, arg_rrr *a, MemOp mop)
+{
+    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
+    TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv src2 = gpr_src(ctx, a->rd, EXT_NONE);
+    TCGv src3 = gpr_src(ctx, a->rk, EXT_NONE);
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv_i128 c16 = tcg_temp_new_i128();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv zero = tcg_constant_tl(0);
+
+    TCGLabel *l1 = gen_new_label();
+    TCGLabel *done = gen_new_label();
+
+    tcg_gen_st_tl(zero, tcg_env, offsetof(CPULoongArchState, llbit_scq));
+    tcg_gen_brcond_tl(TCG_COND_EQ, src1, cpu_lladdr, l1);
+    tcg_gen_movi_tl(dest, 0);
+    tcg_gen_br(done);
+
+    gen_set_label(l1);
+    tcg_gen_concat_i64_i128(t16, src2, src3);
+    tcg_gen_concat_i64_i128(c16, cpu_llval,
+                            cpu_llval_high);
+
+    /* generate cmpxchg */
+    tcg_gen_atomic_cmpxchg_i128(t16, cpu_lladdr, c16,
+                              t16, ctx->mem_idx, mop | MO_ALIGN);
+
+    /* check if success */
+    tcg_gen_extr_i128_i64(t1, t2, t16);
+    tcg_gen_xor_i64(t1, t1, cpu_llval);
+    tcg_gen_xor_i64(t2, t2, cpu_llval_high);
+    tcg_gen_or_i64(t1, t1, t2);
+    tcg_gen_setcondi_i64(TCG_COND_EQ, dest, t1, 0);
+    gen_set_label(done);
+    gen_set_gpr(a->rd, dest, EXT_NONE);
+
+    return true;
+}
+
 static bool gen_cas(DisasContext *ctx, arg_rrr *a,
                     void (*func)(TCGv, TCGv, TCGv, TCGv, TCGArg, MemOp),
                     MemOp mop)
@@ -98,6 +179,7 @@ TRANS(ll_w, ALL, gen_ll, MO_TESL, false)
 TRANS(sc_w, ALL, gen_sc, MO_TESL, false)
 TRANS(ll_d, 64, gen_ll, MO_TEUQ, false)
 TRANS(sc_d, 64, gen_sc, MO_TEUQ, false)
+TRANS(sc_q, 64, gen_sc_q, MO_128)
 TRANS(llacq_w, LLACQ_SCREL, gen_ll, MO_TESL, true)
 TRANS(screl_w, LLACQ_SCREL, gen_sc, MO_TESL, true)
 TRANS(llacq_d, LLACQ_SCREL_64, gen_ll, MO_TEUQ, true)
diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
index 42f4e74012..8b3c1b037c 100644
--- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
@@ -7,11 +7,33 @@ static bool gen_load(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv t1 = tcg_temp_new();
+    TCGv mask = tcg_constant_tl(0x8);
+    TCGv zero = tcg_constant_tl(0);
+    TCGLabel *done = gen_new_label();
+    TCGLabel *l1 = gen_new_label();
 
     addr = make_address_i(ctx, addr, a->imm);
 
+    if (avail_SCQ(ctx) && mop == MO_TEUQ) {
+        /*
+         * The LL.D+LD.D may be paired with SC.Q,
+         * use llval_high if llbit_scq && (addr == lladdr ^ 0x8)
+         */
+        tcg_gen_brcond_tl(TCG_COND_EQ, cpu_llbit_scq, zero, l1);
+        tcg_gen_xor_tl(t1, addr, mask);
+        tcg_gen_brcond_tl(TCG_COND_NE, cpu_lladdr, t1, l1);
+        gen_set_gpr(a->rd, cpu_llval_high, EXT_NONE);
+        tcg_gen_br(done);
+        gen_set_label(l1);
+    }
+
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
+
+    if (avail_SCQ(ctx) && mop == MO_TEUQ) {
+        gen_set_label(done);
+    }
     return true;
 }
 
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 055f6fb604..2023f892be 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -24,7 +24,7 @@
 
 /* Global register indices */
 TCGv cpu_gpr[32], cpu_pc;
-static TCGv cpu_lladdr, cpu_llval;
+static TCGv cpu_lladdr, cpu_llval, cpu_llval_high, cpu_llbit_scq;
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -360,6 +360,10 @@ void loongarch_translate_init(void)
                     offsetof(CPULoongArchState, lladdr), "lladdr");
     cpu_llval = tcg_global_mem_new(tcg_env,
                     offsetof(CPULoongArchState, llval), "llval");
+    cpu_llval_high = tcg_global_mem_new(tcg_env,
+                    offsetof(CPULoongArchState, llval_high), "llval_high");
+    cpu_llbit_scq = tcg_global_mem_new(tcg_env,
+                    offsetof(CPULoongArchState, llbit_scq), "llbit_scq");
 
 #ifndef CONFIG_USER_ONLY
     loongarch_csr_translate_init();
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 76bceedf98..ba1c89e57b 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -30,6 +30,7 @@
 #define avail_LAMCAS(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAMCAS))
 #define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
 #define avail_LASX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
+#define avail_SCQ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, SCQ))
 #define avail_IOCSR(C)  (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
 #define avail_CRC(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, CRC))
 
-- 
2.51.0


