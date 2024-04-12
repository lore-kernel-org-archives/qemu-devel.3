Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DB4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvC0L-0007uU-8B; Fri, 12 Apr 2024 04:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC0E-0007u7-V7; Fri, 12 Apr 2024 04:11:18 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBzy-0005jR-Af; Fri, 12 Apr 2024 04:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909455; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=y3+kOxM7NvGXOflMMRatwzobkasLbYixMzVleUxj15U=;
 b=Z1e4mUU2qjWfvasxXFQJhVJKfygI6Uq4Z5bo4f2I50bJhQaQwi3S0VUmF7LGoiYsuN/Ax2Kf9DX8jLizsElg8p02alsxNysRioE/ZBKb421UCI7nXwTGdaDiwUlq3IWaCI+gbw0P9N8joyIRR105JlsSlpn+Zw3zzUfPOMgCwnQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nbmri_1712909454; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nbmri_1712909454) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:10:55 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 16/65] target/riscv: Add single-width integer add and subtract
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:46 +0800
Message-ID: <20240412073735.76413-17-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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

In this patch, we add single-width integer add and subtract instructions,
including th.vadd.vv/vx/vi, th.vsub.vv/vx and th.vrsub.vx/vi, also show
the way we implement XTheadVector integer arithmetic instructions.
These instructions diff from RVV1.0 in the following points:
1. Different mask reg layout. For mask bit of element i, XTheadVector
   locates it in bit[mlen], while RVV1.0 locates it in bit[i].
2. Different tail/masked elements process policy. XTheadVector keep the
   masked element value and clear the tail elements. While RVV1.0 has vta
   and vma to set the processing policy, keeping value or overwrite it
   with 1s.
3. Different check policy. XTheadVector does not have fractional lmul, so
   we can use simpler check function.
4. XTheadVector simplifies the judgment logic of whether to accelerate or
   not for its lack of fractional LMUL and vta.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  21 ++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 242 +++++++++++++++++-
 target/riscv/vector_helper.c                  |   4 -
 target/riscv/vector_internals.h               |   4 +
 target/riscv/xtheadvector_helper.c            | 153 +++++++++++
 5 files changed, 413 insertions(+), 11 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c2a26acabc..6a7d2c0a78 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1472,3 +1472,24 @@ DEF_HELPER_6(th_vamominw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vamomaxw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vamominuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vamomaxuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 2bcd9b0832..6836e9a3b7 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -769,19 +769,247 @@ GEN_TH_TRANS(th_vamomaxd_v, 15, rwdvm, amo_op_th, amo_check64_th)
 GEN_TH_TRANS(th_vamominud_v, 16, rwdvm, amo_op_th, amo_check64_th)
 GEN_TH_TRANS(th_vamomaxud_v, 17, rwdvm, amo_op_th, amo_check64_th)
 
+/*
+ * Vector Integer Arithmetic Instructions
+ */
+
+/*
+ * check function
+ * 1) check overlap mask, XTheadVector can overlap mask reg v0 when
+ *    lmul == 1, while RVV1.0 can not.
+ * 2) check reg, XTheadVector Vector register numbers are multiples
+ *    of integral LMUL, while RVV1.0 has fractional LMUL, which allows
+ *    any vector register.
+ */
+static bool opivv_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_reg(s, a->rs1, false));
+}
+
+#define GVecGen3Fn_Th GVecGen3Fn
+/*
+ * This function is almost the copy of do_opivv_gvec, except:
+ * 1) XTheadVector using different data encoding, add MLEN,
+ *    delete VTA and VMA.
+ * 2) XTheadVector simplifies the judgment logic of whether
+ *    to accelerate or not for its lack of fractional LMUL and
+ *    VTA.
+ */
+static inline bool
+do_opivv_gvec_th(DisasContext *s, arg_rmrr *a, GVecGen3Fn_Th *gvec_fn,
+                 gen_helper_gvec_4_ptr *fn)
+{
+    if (a->vm && s->vl_eq_vlmax) {
+        gvec_fn(s->sew, vreg_ofs(s, a->rd),
+                vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
+                MAXSZ(s), MAXSZ(s));
+    } else {
+        uint32_t data = 0;
+        /* Need extra mlen to find the mask bit */
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data, fn);
+    }
+    finalize_rvv_inst(s);
+    return true;
+}
+
+/*
+ * OPIVV with GVEC IR
+ *
+ * GEN_OPIVV_GVEC_TRANS_TH is similar to GEN_OPIVV_GVEC_TRANS
+ * just change the check and do_ functions.
+ */
+#define GEN_OPIVV_GVEC_TRANS_TH(NAME, SUF)                         \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    static gen_helper_gvec_4_ptr * const fns[4] = {                \
+        gen_helper_##NAME##_b, gen_helper_##NAME##_h,              \
+        gen_helper_##NAME##_w, gen_helper_##NAME##_d,              \
+    };                                                             \
+    if (!opivv_check_th(s, a)) {                                   \
+        return false;                                              \
+    }                                                              \
+    return do_opivv_gvec_th(s, a, tcg_gen_gvec_##SUF, fns[s->sew]);\
+}
+
+GEN_OPIVV_GVEC_TRANS_TH(th_vadd_vv, add)
+GEN_OPIVV_GVEC_TRANS_TH(th_vsub_vv, sub)
+
+/*
+ * This function is almost the copy of opivx_trans, except:
+ * 1) XTheadVector using different data encoding, add MLEN,
+ *    delete VTA and VMA.
+ */
+#define gen_helper_opivx_th gen_helper_opivx
+static bool opivx_trans_th(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
+                           gen_helper_opivx_th *fn, DisasContext *s)
+{
+    TCGv_ptr dest, src2, mask;
+    TCGv src1;
+    TCGv_i32 desc;
+    uint32_t data = 0;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    src2 = tcg_temp_new_ptr();
+    src1 = get_gpr(s, rs1, EXT_SIGN);
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
+
+    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, src1, src2, tcg_env, desc);
+
+    finalize_rvv_inst(s);
+    return true;
+}
+
+static bool opivx_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false));
+}
+
+#define GVecGen2sFn_Th GVecGen2sFn
+/*
+ * This function is almost the copy of do_opivx_gvec, except:
+ * 1) XTheadVector simplifies the judgment logic of whether
+ *    to accelerate or not for its lack of fractional LMUL and
+ *    VTA.
+ */
+static inline bool
+do_opivx_gvec_th(DisasContext *s, arg_rmrr *a, GVecGen2sFn_Th *gvec_fn,
+                 gen_helper_opivx_th *fn)
+{
+    if (a->vm && s->vl_eq_vlmax) {
+        TCGv_i64 src1 = tcg_temp_new_i64();
+
+        tcg_gen_ext_tl_i64(src1, get_gpr(s, a->rs1, EXT_SIGN));
+        gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
+                src1, MAXSZ(s), MAXSZ(s));
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return opivx_trans_th(a->rd, a->rs1, a->rs2, a->vm, fn, s);
+}
+
+/* OPIVX with GVEC IR */
+#define GEN_OPIVX_GVEC_TRANS_TH(NAME, SUF)                         \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    static gen_helper_opivx_th * const fns[4] = {                  \
+        gen_helper_##NAME##_b, gen_helper_##NAME##_h,              \
+        gen_helper_##NAME##_w, gen_helper_##NAME##_d,              \
+    };                                                             \
+    if (!opivx_check_th(s, a)) {                                   \
+        return false;                                              \
+    }                                                              \
+    return do_opivx_gvec_th(s, a, tcg_gen_gvec_##SUF, fns[s->sew]);\
+}
+
+GEN_OPIVX_GVEC_TRANS_TH(th_vadd_vx, adds)
+GEN_OPIVX_GVEC_TRANS_TH(th_vsub_vx, subs)
+GEN_OPIVX_GVEC_TRANS_TH(th_vrsub_vx, rsubs)
+
+#define imm_mode_t_th imm_mode_t
+
+/*
+ * This function is almost the copy of opivi_trans, except:
+ * 1) XTheadVector using different data encoding, add MLEN,
+ *    delete VTA and VMA.
+ */
+static bool opivi_trans_th(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
+                           gen_helper_opivx_th *fn, DisasContext *s,
+                           imm_mode_t_th imm_mode)
+{
+    TCGv_ptr dest, src2, mask;
+    TCGv src1;
+    TCGv_i32 desc;
+    uint32_t data = 0;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    src2 = tcg_temp_new_ptr();
+    src1 = tcg_constant_tl(extract_imm(s, imm, imm_mode));
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
+
+    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, src1, src2, tcg_env, desc);
+
+    finalize_rvv_inst(s);
+    return true;
+}
+#define GVecGen2iFn_Th GVecGen2iFn
+/*
+ * This function is almost the copy of do_opivi_gvec, except:
+ * 1) XTheadVector simplifies the judgment logic of whether
+ *    to accelerate or not for its lack of fractional LMUL and
+ *    VTA.
+ */
+static inline bool
+do_opivi_gvec_th(DisasContext *s, arg_rmrr *a, GVecGen2iFn_Th *gvec_fn,
+                 gen_helper_opivx_th *fn, imm_mode_t_th imm_mode)
+{
+    if (a->vm && s->vl_eq_vlmax) {
+        gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
+                extract_imm(s, a->rs1, imm_mode), MAXSZ(s), MAXSZ(s));
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return opivi_trans_th(a->rd, a->rs1, a->rs2, a->vm, fn, s, imm_mode);
+}
+
+/* OPIVI with GVEC IR */
+#define GEN_OPIVI_GVEC_TRANS_TH(NAME, IMM_MODE, OPIVX, SUF)        \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    static gen_helper_opivx_th * const fns[4] = {                  \
+        gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,            \
+        gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,            \
+    };                                                             \
+    if (!opivx_check_th(s, a)) {                                   \
+        return false;                                              \
+    }                                                              \
+    return do_opivi_gvec_th(s, a, tcg_gen_gvec_##SUF,              \
+                            fns[s->sew], IMM_MODE);                \
+}
+
+GEN_OPIVI_GVEC_TRANS_TH(th_vadd_vi, IMM_SX, th_vadd_vx, addi)
+GEN_OPIVI_GVEC_TRANS_TH(th_vrsub_vi, IMM_SX, th_vrsub_vx, rsubi)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vadd_vv)
-TH_TRANS_STUB(th_vadd_vx)
-TH_TRANS_STUB(th_vadd_vi)
-TH_TRANS_STUB(th_vsub_vv)
-TH_TRANS_STUB(th_vsub_vx)
-TH_TRANS_STUB(th_vrsub_vx)
-TH_TRANS_STUB(th_vrsub_vi)
 TH_TRANS_STUB(th_vwaddu_vv)
 TH_TRANS_STUB(th_vwaddu_vx)
 TH_TRANS_STUB(th_vwadd_vv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 695cb7dfec..8fb0b02976 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -647,10 +647,6 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
  */
 
 /* (TD, T1, T2, TX1, TX2) */
-#define OP_SSS_B int8_t, int8_t, int8_t, int8_t, int8_t
-#define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
-#define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
-#define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
 #define OP_SUS_B int8_t, uint8_t, int8_t, uint8_t, int8_t
 #define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
 #define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index ff10cd3806..1e118c6a17 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -138,6 +138,10 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
 #define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
 #define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
 #define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
+#define OP_SSS_B int8_t, int8_t, int8_t, int8_t, int8_t
+#define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
+#define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
+#define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
 
 #define OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
 static void do_##NAME(void *vd, void *vs2, int i)      \
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 1dced03ee3..1571d372a8 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -797,3 +797,156 @@ GEN_TH_AMO(th_vamominw_v_w,  int32_t,  int32_t,  idx_w, clearl_th)
 GEN_TH_AMO(th_vamomaxw_v_w,  int32_t,  int32_t,  idx_w, clearl_th)
 GEN_TH_AMO(th_vamominuw_v_w, uint32_t, uint32_t, idx_w, clearl_th)
 GEN_TH_AMO(th_vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl_th)
+
+/*
+ * Vector Integer Arithmetic Instructions
+ */
+
+/* redefine macros to decouple */
+
+#define THCALL(macro, ...)  macro(__VA_ARGS__)
+
+/* operation of two vector elements */
+#define opivv2_fn_th opivv2_fn
+
+#define TH_OPIVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP) \
+        OPIVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)
+
+#define TH_SUB(N, M) (N - M)
+#define TH_RSUB(N, M) (M - N)
+
+THCALL(TH_OPIVV2, th_vadd_vv_b, OP_SSS_B, H1, H1, H1, TH_ADD)
+THCALL(TH_OPIVV2, th_vadd_vv_h, OP_SSS_H, H2, H2, H2, TH_ADD)
+THCALL(TH_OPIVV2, th_vadd_vv_w, OP_SSS_W, H4, H4, H4, TH_ADD)
+THCALL(TH_OPIVV2, th_vadd_vv_d, OP_SSS_D, H8, H8, H8, TH_ADD)
+THCALL(TH_OPIVV2, th_vsub_vv_b, OP_SSS_B, H1, H1, H1, TH_SUB)
+THCALL(TH_OPIVV2, th_vsub_vv_h, OP_SSS_H, H2, H2, H2, TH_SUB)
+THCALL(TH_OPIVV2, th_vsub_vv_w, OP_SSS_W, H4, H4, H4, TH_SUB)
+THCALL(TH_OPIVV2, th_vsub_vv_d, OP_SSS_D, H8, H8, H8, TH_SUB)
+
+/*
+ * This function is almost the copy of do_vext_vv, except:
+ * 1) XTheadVector has different mask layout, using th_elem_mask
+ *    to get [MLEN*i] bit
+ * 2) XTheadVector using different data encoding, using th_ functions
+ *    to parse.
+ * 3) XTheadVector keep the masked elements value, while RVV1.0 policy is
+ *    determined by vma.
+ * 4) XTheadVector clear the tail elements, while RVV1.0 policy is to rather
+ *    set all bits 1s or keep it, determined by vta.
+ */
+static void do_th_vv(void *vd, void *v0, void *vs1, void *vs2,
+                     CPURISCVState *env, uint32_t desc,
+                     uint32_t esz, uint32_t dsz,
+                     opivv2_fn_th *fn, clear_fn *clearfn)
+{
+    uint32_t vlmax = th_maxsz(desc) / esz;
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t i;
+
+    VSTART_CHECK_EARLY_EXIT(env);
+
+    for (i = env->vstart; i < vl; i++) {
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        fn(vd, vs1, vs2, i);
+    }
+    env->vstart = 0;
+    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+}
+
+/* generate the helpers for OPIVV */
+#define GEN_TH_VV(NAME, ESZ, DSZ, CLEAR_FN)               \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+                  void *vs2, CPURISCVState *env,          \
+                  uint32_t desc)                          \
+{                                                         \
+    do_th_vv(vd, v0, vs1, vs2, env, desc, ESZ, DSZ,       \
+             do_##NAME, CLEAR_FN);                        \
+}
+
+GEN_TH_VV(th_vadd_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vadd_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vadd_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vadd_vv_d, 8, 8, clearq_th)
+GEN_TH_VV(th_vsub_vv_b, 1, 1, clearb_th)
+GEN_TH_VV(th_vsub_vv_h, 2, 2, clearh_th)
+GEN_TH_VV(th_vsub_vv_w, 4, 4, clearl_th)
+GEN_TH_VV(th_vsub_vv_d, 8, 8, clearq_th)
+
+#define opivx2_fn_th opivx2_fn
+
+/*
+ * (T1)s1 gives the real operator type.
+ * (TX1)(T1)s1 expands the operator type of widen or narrow operations.
+ */
+#define TH_OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)    \
+        OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)
+
+THCALL(TH_OPIVX2, th_vadd_vx_b, OP_SSS_B, H1, H1, TH_ADD)
+THCALL(TH_OPIVX2, th_vadd_vx_h, OP_SSS_H, H2, H2, TH_ADD)
+THCALL(TH_OPIVX2, th_vadd_vx_w, OP_SSS_W, H4, H4, TH_ADD)
+THCALL(TH_OPIVX2, th_vadd_vx_d, OP_SSS_D, H8, H8, TH_ADD)
+THCALL(TH_OPIVX2, th_vsub_vx_b, OP_SSS_B, H1, H1, TH_SUB)
+THCALL(TH_OPIVX2, th_vsub_vx_h, OP_SSS_H, H2, H2, TH_SUB)
+THCALL(TH_OPIVX2, th_vsub_vx_w, OP_SSS_W, H4, H4, TH_SUB)
+THCALL(TH_OPIVX2, th_vsub_vx_d, OP_SSS_D, H8, H8, TH_SUB)
+THCALL(TH_OPIVX2, th_vrsub_vx_b, OP_SSS_B, H1, H1, TH_RSUB)
+THCALL(TH_OPIVX2, th_vrsub_vx_h, OP_SSS_H, H2, H2, TH_RSUB)
+THCALL(TH_OPIVX2, th_vrsub_vx_w, OP_SSS_W, H4, H4, TH_RSUB)
+THCALL(TH_OPIVX2, th_vrsub_vx_d, OP_SSS_D, H8, H8, TH_RSUB)
+
+/*
+ * This function is almost the copy of do_vext_vx, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different mask/tail elements process policy
+ */
+static void do_th_vx(void *vd, void *v0, target_long s1, void *vs2,
+                     CPURISCVState *env, uint32_t desc,
+                     uint32_t esz, uint32_t dsz,
+                     opivx2_fn_th fn, clear_fn *clearfn)
+{
+    uint32_t vlmax = th_maxsz(desc) / esz;
+    uint32_t mlen = th_mlen(desc);
+    uint32_t vm = th_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t i;
+
+    VSTART_CHECK_EARLY_EXIT(env);
+
+    for (i = env->vstart; i < vl; i++) {
+        if (!vm && !th_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        fn(vd, s1, vs2, i);
+    }
+    env->vstart = 0;
+    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
+}
+
+/* generate the helpers for OPIVX */
+#define GEN_TH_VX(NAME, ESZ, DSZ, CLEAR_FN)               \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
+                  void *vs2, CPURISCVState *env,          \
+                  uint32_t desc)                          \
+{                                                         \
+    do_th_vx(vd, v0, s1, vs2, env, desc, ESZ, DSZ,        \
+             do_##NAME, CLEAR_FN);                        \
+}
+
+GEN_TH_VX(th_vadd_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vadd_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vadd_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vadd_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vsub_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vsub_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vsub_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vsub_vx_d, 8, 8, clearq_th)
+GEN_TH_VX(th_vrsub_vx_b, 1, 1, clearb_th)
+GEN_TH_VX(th_vrsub_vx_h, 2, 2, clearh_th)
+GEN_TH_VX(th_vrsub_vx_w, 4, 4, clearl_th)
+GEN_TH_VX(th_vrsub_vx_d, 8, 8, clearq_th)
-- 
2.44.0


