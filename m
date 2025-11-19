Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB044CF31B7
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 12:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhMV-0007sq-A3; Wed, 19 Nov 2025 07:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhMH-0007qA-2S
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:32:26 -0500
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhME-00057R-1f
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:32:23 -0500
Received: from cslab-raptor.s.cslab.moe (unknown [166.111.238.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id E638D49A7E9;
 Wed, 19 Nov 2025 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1763555537; bh=dxV7C6QfUefSt1XKUJGbvphyErev3tTV2/yWZyHusj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nCJb/4V188z/MgvBoAeGZf7aQZwO42etrRHUR2KNSB9ZCo+GLNscYJmoOJx/nwsOz
 NJP3yGMm3hJOQuh2xG0oAUers2O/QVK5TxSjAK1tOVkIhN+m8AvhLTshzGGtdkbOYF
 9wRQVg1JZfevkNKoKTRfmYIuBZN04NhZ1gaDI5So=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v2 5/7] target/loongarch: Add llacq/screl instructions
Date: Wed, 19 Nov 2025 20:30:56 +0800
Message-ID: <20251119123101.1542976-5-c@jia.je>
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

Add the following instructions in LoongArch v1.1:

- llacq.w
- screl.w
- llacq.d
- screl.d

They are guarded by CPUCFG2.LLACQ_SCREL.

Signed-off-by: Jiajie Chen <c@jia.je>
Co-developed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.h                        |  1 +
 target/loongarch/disas.c                      |  4 ++++
 target/loongarch/insns.decode                 |  5 ++++
 .../tcg/insn_trans/trans_atomic.c.inc         | 24 ++++++++++++++-----
 target/loongarch/translate.h                  |  3 +++
 5 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 740e474d79..5cab02ad6f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -141,6 +141,7 @@ FIELD(CPUCFG2, HPTW, 24, 1)
 FIELD(CPUCFG2, FRECIPE, 25, 1)
 FIELD(CPUCFG2, LAM_BH, 27, 1)
 FIELD(CPUCFG2, LAMCAS, 28, 1)
+FIELD(CPUCFG2, LLACQ_SCREL, 29, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e5e1b37ce0..3164fade9b 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -584,6 +584,10 @@ INSN(fldx_s,       frr)
 INSN(fldx_d,       frr)
 INSN(fstx_s,       frr)
 INSN(fstx_d,       frr)
+INSN(llacq_w,      rr_i)
+INSN(screl_w,      rr_i)
+INSN(llacq_d,      rr_i)
+INSN(screl_d,      rr_i)
 INSN(amcas_b,      rrr)
 INSN(amcas_h,      rrr)
 INSN(amcas_w,      rrr)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 92078f0f9f..7898f5f719 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -69,6 +69,7 @@
 @rr_i14s2         .... ....  .............. rj:5 rd:5    &rr_i imm=%i14s2
 @rr_i16                     .... .. imm:s16 rj:5 rd:5    &rr_i
 @rr_i16s2         .... ..  ................ rj:5 rd:5    &rr_i imm=%offs16
+@rr_i0            .... ..  ................ rj:5 rd:5    &rr_i imm=0
 @hint_r_i12           .... ...... imm:s12 rj:5 hint:5    &hint_r_i
 @hint_rr         .... ........ ..... rk:5 rj:5 hint:5    &hint_rr
 @rrr_sa2p1        .... ........ ... .. rk:5 rj:5 rd:5    &rrr_sa  sa=%sa2p1
@@ -261,6 +262,10 @@ ll_w            0010 0000 .............. ..... .....     @rr_i14s2
 sc_w            0010 0001 .............. ..... .....     @rr_i14s2
 ll_d            0010 0010 .............. ..... .....     @rr_i14s2
 sc_d            0010 0011 .............. ..... .....     @rr_i14s2
+llacq_w         0011 10000101 01111 00000 ..... .....    @rr_i0
+screl_w         0011 10000101 01111 00001 ..... .....    @rr_i0
+llacq_d         0011 10000101 01111 00010 ..... .....    @rr_i0
+screl_d         0011 10000101 01111 00011 ..... .....    @rr_i0
 amcas_b         0011 10000101 10000 ..... ..... .....    @rrr
 amcas_h         0011 10000101 10001 ..... ..... .....    @rrr
 amcas_w         0011 10000101 10010 ..... ..... .....    @rrr
diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 1b2673b82d..c9a6dcfdeb 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
+static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool acq)
 {
     TCGv t1 = tcg_temp_new();
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -14,10 +14,14 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
     gen_set_gpr(a->rd, t1, EXT_NONE);
 
+    if (acq) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+
     return true;
 }
 
-static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
+static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool rel)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -29,6 +33,10 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGLabel *done = gen_new_label();
 
     tcg_gen_addi_tl(t0, src1, a->imm);
+
+    if (rel) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
     tcg_gen_brcond_tl(TCG_COND_EQ, t0, cpu_lladdr, l1);
     tcg_gen_movi_tl(dest, 0);
     tcg_gen_br(done);
@@ -86,10 +94,14 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(ll_w, ALL, gen_ll, MO_TESL)
-TRANS(sc_w, ALL, gen_sc, MO_TESL)
-TRANS(ll_d, 64, gen_ll, MO_TEUQ)
-TRANS(sc_d, 64, gen_sc, MO_TEUQ)
+TRANS(ll_w, ALL, gen_ll, MO_TESL, false)
+TRANS(sc_w, ALL, gen_sc, MO_TESL, false)
+TRANS(ll_d, 64, gen_ll, MO_TEUQ, false)
+TRANS(sc_d, 64, gen_sc, MO_TEUQ, false)
+TRANS(llacq_w, LLACQ_SCREL, gen_ll, MO_TESL, true)
+TRANS(screl_w, LLACQ_SCREL, gen_sc, MO_TESL, true)
+TRANS(llacq_d, LLACQ_SCREL_64, gen_ll, MO_TEUQ, true)
+TRANS(screl_d, LLACQ_SCREL_64, gen_sc, MO_TEUQ, true)
 TRANS(amcas_b, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_SB)
 TRANS(amcas_h, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESW)
 TRANS(amcas_w, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESL)
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 331f79c8f2..76bceedf98 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -39,6 +39,9 @@
 #define avail_FRECIPE_LSX(C)   (avail_FRECIPE(C) && avail_LSX(C))
 #define avail_FRECIPE_LASX(C)   (avail_FRECIPE(C) && avail_LASX(C))
 
+#define avail_LLACQ_SCREL(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LLACQ_SCREL))
+#define avail_LLACQ_SCREL_64(C) (avail_64(C) && avail_LLACQ_SCREL(C))
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
-- 
2.51.0


