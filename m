Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ADCC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvC2A-0000OC-3d; Fri, 12 Apr 2024 04:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC20-0000NX-1a; Fri, 12 Apr 2024 04:13:08 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC1u-00067y-V3; Fri, 12 Apr 2024 04:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909577; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=h+T/DHk8h2koOMR/b8RpyQp8Ruu0bssJzW9yKOwKLNA=;
 b=V/tpTay+gK930eKiXkA3kwBxoH/neLs//uFQ/uTlLZhYPFAEFKP77E5fTqR3JgnrzTIEpQ3+7M++dOPUAyU2PjF9OKvf8aR2y5y6vtSMDqecPqKrR236MRanEo//PDFa6C2hk1tFjjqpRI1R355J0+KkuzYACLbZLW3IFgB55Dc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NYa1k_1712909575; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NYa1k_1712909575) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:12:56 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 17/65] target/riscv: Add widening integer add/subtract
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:47 +0800
Message-ID: <20240412073735.76413-18-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

In this patch, we reuse lots of funtions of single-width operations,
except do_opivv_th. The reason why do_opivv_widen_th does not call
do_opivv_th is that widen operation is not applicable to using GVEC
to accerlate the vector operations.

The difference between XTheadVector and RVV1.0 is as same as the single-
width operation patch mentions.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  49 +++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 197 ++++++++++++++++--
 target/riscv/vector_helper.c                  |  15 --
 target/riscv/vector_internals.h               |   9 +
 target/riscv/xtheadvector_helper.c            | 100 +++++++++
 5 files changed, 339 insertions(+), 31 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6a7d2c0a78..3906f17079 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1493,3 +1493,52 @@ DEF_HELPER_6(th_vrsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vrsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vwaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwaddu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsubu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwadd_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vwsub_wx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 6836e9a3b7..f6aea9deff 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1004,28 +1004,193 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
 GEN_OPIVI_GVEC_TRANS_TH(th_vadd_vi, IMM_SX, th_vadd_vx, addi)
 GEN_OPIVI_GVEC_TRANS_TH(th_vrsub_vi, IMM_SX, th_vrsub_vx, rsubi)
 
+/* Vector Widening Integer Add/Subtract */
+
+/* OPIVV with WIDEN */
+static bool opivv_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_reg(s, a->rs1, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                   1 << s->lmul) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                   1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+/*
+ * This function is almost the copy of do_opivv_widen, except:
+ * 1) XTheadVector using different data encoding, add MLEN,
+ *    delete VTA and VMA.
+ */
+static bool do_opivv_widen_th(DisasContext *s, arg_rmrr *a,
+                              gen_helper_gvec_4_ptr *fn,
+                              bool (*checkfn)(DisasContext *, arg_rmrr *))
+{
+    if (checkfn(s, a)) {
+        uint32_t data = 0;
+
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1),
+                           vreg_ofs(s, a->rs2),
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb,
+                           data, fn);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
+#define GEN_OPIVV_WIDEN_TRANS_TH(NAME, CHECK)                \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    static gen_helper_gvec_4_ptr * const fns[3] = {          \
+        gen_helper_##NAME##_b,                               \
+        gen_helper_##NAME##_h,                               \
+        gen_helper_##NAME##_w                                \
+    };                                                       \
+    return do_opivv_widen_th(s, a, fns[s->sew], CHECK);      \
+}
+
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwaddu_vv, opivv_widen_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwadd_vv, opivv_widen_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwsubu_vv, opivv_widen_check_th)
+GEN_OPIVV_WIDEN_TRANS_TH(th_vwsub_vv, opivv_widen_check_th)
+
+/* OPIVX with WIDEN */
+static bool opivx_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+#define GEN_OPIVX_WIDEN_TRANS_TH(NAME, CHECK)                \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    if (CHECK(s, a)) {                                       \
+        static gen_helper_opivx_th * const fns[3] = {        \
+            gen_helper_##NAME##_b,                           \
+            gen_helper_##NAME##_h,                           \
+            gen_helper_##NAME##_w                            \
+        };                                                   \
+        return opivx_trans_th(a->rd, a->rs1, a->rs2, a->vm,  \
+                              fns[s->sew], s);               \
+    }                                                        \
+    return false;                                            \
+}
+
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwaddu_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwadd_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwsubu_vx, opivx_widen_check_th)
+GEN_OPIVX_WIDEN_TRANS_TH(th_vwsub_vx, opivx_widen_check_th)
+
+/* WIDEN OPIVV with WIDEN */
+static bool opiwv_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, true) &&
+            th_check_reg(s, a->rs1, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+static bool do_opiwv_widen_th(DisasContext *s, arg_rmrr *a,
+                              gen_helper_gvec_4_ptr *fn)
+{
+    if (opiwv_widen_check_th(s, a)) {
+        uint32_t data = 0;
+
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1),
+                           vreg_ofs(s, a->rs2),
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data, fn);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
+#define GEN_OPIWV_WIDEN_TRANS_TH(NAME)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    static gen_helper_gvec_4_ptr * const fns[3] = {          \
+        gen_helper_##NAME##_b,                               \
+        gen_helper_##NAME##_h,                               \
+        gen_helper_##NAME##_w                                \
+    };                                                       \
+    return do_opiwv_widen_th(s, a, fns[s->sew]);             \
+}
+
+GEN_OPIWV_WIDEN_TRANS_TH(th_vwaddu_wv)
+GEN_OPIWV_WIDEN_TRANS_TH(th_vwadd_wv)
+GEN_OPIWV_WIDEN_TRANS_TH(th_vwsubu_wv)
+GEN_OPIWV_WIDEN_TRANS_TH(th_vwsub_wv)
+
+/* WIDEN OPIVX with WIDEN */
+static bool opiwx_widen_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, true) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+
+static bool do_opiwx_widen_th(DisasContext *s, arg_rmrr *a,
+                              gen_helper_opivx_th *fn)
+{
+    if (opiwx_widen_check_th(s, a)) {
+        return opivx_trans_th(a->rd, a->rs1, a->rs2, a->vm, fn, s);
+    }
+    return false;
+}
+
+#define GEN_OPIWX_WIDEN_TRANS_TH(NAME)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
+{                                                            \
+    static gen_helper_opivx_th * const fns[3] = {            \
+        gen_helper_##NAME##_b,                               \
+        gen_helper_##NAME##_h,                               \
+        gen_helper_##NAME##_w                                \
+    };                                                       \
+    return do_opiwx_widen_th(s, a, fns[s->sew]);             \
+}
+
+GEN_OPIWX_WIDEN_TRANS_TH(th_vwaddu_wx)
+GEN_OPIWX_WIDEN_TRANS_TH(th_vwadd_wx)
+GEN_OPIWX_WIDEN_TRANS_TH(th_vwsubu_wx)
+GEN_OPIWX_WIDEN_TRANS_TH(th_vwsub_wx)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vwaddu_vv)
-TH_TRANS_STUB(th_vwaddu_vx)
-TH_TRANS_STUB(th_vwadd_vv)
-TH_TRANS_STUB(th_vwadd_vx)
-TH_TRANS_STUB(th_vwsubu_vv)
-TH_TRANS_STUB(th_vwsubu_vx)
-TH_TRANS_STUB(th_vwsub_vv)
-TH_TRANS_STUB(th_vwsub_vx)
-TH_TRANS_STUB(th_vwaddu_wv)
-TH_TRANS_STUB(th_vwaddu_wx)
-TH_TRANS_STUB(th_vwadd_wv)
-TH_TRANS_STUB(th_vwadd_wx)
-TH_TRANS_STUB(th_vwsubu_wv)
-TH_TRANS_STUB(th_vwsubu_wx)
-TH_TRANS_STUB(th_vwsub_wv)
-TH_TRANS_STUB(th_vwsub_wx)
 TH_TRANS_STUB(th_vadc_vvm)
 TH_TRANS_STUB(th_vadc_vxm)
 TH_TRANS_STUB(th_vadc_vim)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8fb0b02976..9774fc62c3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -651,9 +651,6 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
 #define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
 #define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
 #define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
-#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
-#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
-#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
 #define WOP_SUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
 #define WOP_SUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
 #define WOP_SUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
@@ -756,18 +753,6 @@ void HELPER(vec_rsubs64)(void *d, void *a, uint64_t b, uint32_t desc)
 }
 
 /* Vector Widening Integer Add/Subtract */
-#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
-#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
-#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
-#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
-#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
-#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
-#define WOP_WUUU_B  uint16_t, uint8_t, uint16_t, uint16_t, uint16_t
-#define WOP_WUUU_H  uint32_t, uint16_t, uint32_t, uint32_t, uint32_t
-#define WOP_WUUU_W  uint64_t, uint32_t, uint64_t, uint64_t, uint64_t
-#define WOP_WSSS_B  int16_t, int8_t, int16_t, int16_t, int16_t
-#define WOP_WSSS_H  int32_t, int16_t, int32_t, int32_t, int32_t
-#define WOP_WSSS_W  int64_t, int32_t, int64_t, int64_t, int64_t
 RVVCALL(OPIVV2, vwaddu_vv_b, WOP_UUU_B, H2, H1, H1, DO_ADD)
 RVVCALL(OPIVV2, vwaddu_vv_h, WOP_UUU_H, H4, H2, H2, DO_ADD)
 RVVCALL(OPIVV2, vwaddu_vv_w, WOP_UUU_W, H8, H4, H4, DO_ADD)
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 1e118c6a17..24e64c37d4 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -236,6 +236,15 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
 #define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
 #define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
 #define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
+#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
+#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
+#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
+#define WOP_WUUU_B  uint16_t, uint8_t, uint16_t, uint16_t, uint16_t
+#define WOP_WUUU_H  uint32_t, uint16_t, uint32_t, uint32_t, uint32_t
+#define WOP_WUUU_W  uint64_t, uint32_t, uint64_t, uint64_t, uint64_t
+#define WOP_WSSS_B  int16_t, int8_t, int16_t, int16_t, int16_t
+#define WOP_WSSS_H  int32_t, int16_t, int32_t, int32_t, int32_t
+#define WOP_WSSS_W  int64_t, int32_t, int64_t, int64_t, int64_t
 
 /* share functions */
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 1571d372a8..5ebdb5a375 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -950,3 +950,103 @@ GEN_TH_VX(th_vrsub_vx_b, 1, 1, clearb_th)
 GEN_TH_VX(th_vrsub_vx_h, 2, 2, clearh_th)
 GEN_TH_VX(th_vrsub_vx_w, 4, 4, clearl_th)
 GEN_TH_VX(th_vrsub_vx_d, 8, 8, clearq_th)
+
+/* Vector Widening Integer Add/Subtract */
+
+THCALL(TH_OPIVV2, th_vwaddu_vv_b, WOP_UUU_B, H2, H1, H1, TH_ADD)
+THCALL(TH_OPIVV2, th_vwaddu_vv_h, WOP_UUU_H, H4, H2, H2, TH_ADD)
+THCALL(TH_OPIVV2, th_vwaddu_vv_w, WOP_UUU_W, H8, H4, H4, TH_ADD)
+THCALL(TH_OPIVV2, th_vwsubu_vv_b, WOP_UUU_B, H2, H1, H1, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsubu_vv_h, WOP_UUU_H, H4, H2, H2, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsubu_vv_w, WOP_UUU_W, H8, H4, H4, TH_SUB)
+THCALL(TH_OPIVV2, th_vwadd_vv_b, WOP_SSS_B, H2, H1, H1, TH_ADD)
+THCALL(TH_OPIVV2, th_vwadd_vv_h, WOP_SSS_H, H4, H2, H2, TH_ADD)
+THCALL(TH_OPIVV2, th_vwadd_vv_w, WOP_SSS_W, H8, H4, H4, TH_ADD)
+THCALL(TH_OPIVV2, th_vwsub_vv_b, WOP_SSS_B, H2, H1, H1, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsub_vv_h, WOP_SSS_H, H4, H2, H2, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsub_vv_w, WOP_SSS_W, H8, H4, H4, TH_SUB)
+THCALL(TH_OPIVV2, th_vwaddu_wv_b, WOP_WUUU_B, H2, H1, H1, TH_ADD)
+THCALL(TH_OPIVV2, th_vwaddu_wv_h, WOP_WUUU_H, H4, H2, H2, TH_ADD)
+THCALL(TH_OPIVV2, th_vwaddu_wv_w, WOP_WUUU_W, H8, H4, H4, TH_ADD)
+THCALL(TH_OPIVV2, th_vwsubu_wv_b, WOP_WUUU_B, H2, H1, H1, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsubu_wv_h, WOP_WUUU_H, H4, H2, H2, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsubu_wv_w, WOP_WUUU_W, H8, H4, H4, TH_SUB)
+THCALL(TH_OPIVV2, th_vwadd_wv_b, WOP_WSSS_B, H2, H1, H1, TH_ADD)
+THCALL(TH_OPIVV2, th_vwadd_wv_h, WOP_WSSS_H, H4, H2, H2, TH_ADD)
+THCALL(TH_OPIVV2, th_vwadd_wv_w, WOP_WSSS_W, H8, H4, H4, TH_ADD)
+THCALL(TH_OPIVV2, th_vwsub_wv_b, WOP_WSSS_B, H2, H1, H1, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsub_wv_h, WOP_WSSS_H, H4, H2, H2, TH_SUB)
+THCALL(TH_OPIVV2, th_vwsub_wv_w, WOP_WSSS_W, H8, H4, H4, TH_SUB)
+GEN_TH_VV(th_vwaddu_vv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwaddu_vv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwaddu_vv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwsubu_vv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwsubu_vv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwsubu_vv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwadd_vv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwadd_vv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwadd_vv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwsub_vv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwsub_vv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwsub_vv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwaddu_wv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwaddu_wv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwaddu_wv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwsubu_wv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwsubu_wv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwsubu_wv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwadd_wv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwadd_wv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwadd_wv_w, 4, 8, clearq_th)
+GEN_TH_VV(th_vwsub_wv_b, 1, 2, clearh_th)
+GEN_TH_VV(th_vwsub_wv_h, 2, 4, clearl_th)
+GEN_TH_VV(th_vwsub_wv_w, 4, 8, clearq_th)
+
+THCALL(TH_OPIVX2, th_vwaddu_vx_b, WOP_UUU_B, H2, H1, TH_ADD)
+THCALL(TH_OPIVX2, th_vwaddu_vx_h, WOP_UUU_H, H4, H2, TH_ADD)
+THCALL(TH_OPIVX2, th_vwaddu_vx_w, WOP_UUU_W, H8, H4, TH_ADD)
+THCALL(TH_OPIVX2, th_vwsubu_vx_b, WOP_UUU_B, H2, H1, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsubu_vx_h, WOP_UUU_H, H4, H2, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsubu_vx_w, WOP_UUU_W, H8, H4, TH_SUB)
+THCALL(TH_OPIVX2, th_vwadd_vx_b, WOP_SSS_B, H2, H1, TH_ADD)
+THCALL(TH_OPIVX2, th_vwadd_vx_h, WOP_SSS_H, H4, H2, TH_ADD)
+THCALL(TH_OPIVX2, th_vwadd_vx_w, WOP_SSS_W, H8, H4, TH_ADD)
+THCALL(TH_OPIVX2, th_vwsub_vx_b, WOP_SSS_B, H2, H1, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsub_vx_h, WOP_SSS_H, H4, H2, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsub_vx_w, WOP_SSS_W, H8, H4, TH_SUB)
+THCALL(TH_OPIVX2, th_vwaddu_wx_b, WOP_WUUU_B, H2, H1, TH_ADD)
+THCALL(TH_OPIVX2, th_vwaddu_wx_h, WOP_WUUU_H, H4, H2, TH_ADD)
+THCALL(TH_OPIVX2, th_vwaddu_wx_w, WOP_WUUU_W, H8, H4, TH_ADD)
+THCALL(TH_OPIVX2, th_vwsubu_wx_b, WOP_WUUU_B, H2, H1, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsubu_wx_h, WOP_WUUU_H, H4, H2, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsubu_wx_w, WOP_WUUU_W, H8, H4, TH_SUB)
+THCALL(TH_OPIVX2, th_vwadd_wx_b, WOP_WSSS_B, H2, H1, TH_ADD)
+THCALL(TH_OPIVX2, th_vwadd_wx_h, WOP_WSSS_H, H4, H2, TH_ADD)
+THCALL(TH_OPIVX2, th_vwadd_wx_w, WOP_WSSS_W, H8, H4, TH_ADD)
+THCALL(TH_OPIVX2, th_vwsub_wx_b, WOP_WSSS_B, H2, H1, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsub_wx_h, WOP_WSSS_H, H4, H2, TH_SUB)
+THCALL(TH_OPIVX2, th_vwsub_wx_w, WOP_WSSS_W, H8, H4, TH_SUB)
+GEN_TH_VX(th_vwaddu_vx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwaddu_vx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwaddu_vx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwsubu_vx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwsubu_vx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwsubu_vx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwadd_vx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwadd_vx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwadd_vx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwsub_vx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwsub_vx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwsub_vx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwaddu_wx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwaddu_wx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwaddu_wx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwsubu_wx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwsubu_wx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwsubu_wx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwadd_wx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwadd_wx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwadd_wx_w, 4, 8, clearq_th)
+GEN_TH_VX(th_vwsub_wx_b, 1, 2, clearh_th)
+GEN_TH_VX(th_vwsub_wx_h, 2, 4, clearl_th)
+GEN_TH_VX(th_vwsub_wx_w, 4, 8, clearq_th)
-- 
2.44.0


