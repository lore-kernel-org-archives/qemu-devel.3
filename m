Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75CEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCPV-0004R1-8A; Fri, 12 Apr 2024 04:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCPT-0004QV-Tv; Fri, 12 Apr 2024 04:37:23 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCPQ-00021S-PW; Fri, 12 Apr 2024 04:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712911036; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=tbVKlp+UKVB3nmIVN6O3Pf2UE5h2FFT6aCNuFKLTbOc=;
 b=GjMVALnASny8hbUF0Yi66TQ7REV+BkDFfdq2JbWJ0wMWWi1sh0/8+jyvVHRHjFm2ChZj195b3kFSdqisFHicMV7/qTgjF5n0I6+gGeHTBCZN3/Vin8TID+q5Xtu+3AxDTkVZsupR2H9YBa6Bo6TuA/gzwokCEL759SbGvNn/LIc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NfJWY_1712911034; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NfJWY_1712911034) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:37:14 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 29/65] target/riscv: Add integer merge and move instructions
 for XTheadVector
Date: Fri, 12 Apr 2024 15:36:59 +0800
Message-ID: <20240412073735.76413-30-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0. Except of
th.vmv.v.x, the difference is that XTheadVector has no limit of SEW
of 8 to 64, Therefore, it is not suitable to use acceleration when
xlen < SEW.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  17 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 124 +++++++++++++++++-
 target/riscv/xtheadvector_helper.c            | 104 +++++++++++++++
 3 files changed, 239 insertions(+), 6 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8b8dd62761..ba548ebdc9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1868,3 +1868,20 @@ DEF_HELPER_6(th_vwmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vmerge_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmerge_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmerge_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmerge_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmerge_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmerge_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmerge_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmerge_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_4(th_vmv_v_v_b, void, ptr, ptr, env, i32)
+DEF_HELPER_4(th_vmv_v_v_h, void, ptr, ptr, env, i32)
+DEF_HELPER_4(th_vmv_v_v_w, void, ptr, ptr, env, i32)
+DEF_HELPER_4(th_vmv_v_v_d, void, ptr, ptr, env, i32)
+DEF_HELPER_4(th_vmv_v_x_b, void, ptr, i64, env, i32)
+DEF_HELPER_4(th_vmv_v_x_h, void, ptr, i64, env, i32)
+DEF_HELPER_4(th_vmv_v_x_w, void, ptr, i64, env, i32)
+DEF_HELPER_4(th_vmv_v_x_d, void, ptr, i64, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index bfa3a26f78..6d0ce9f966 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1576,18 +1576,130 @@ GEN_OPIVX_WIDEN_TRANS_TH(th_vwmacc_vx, opivx_widen_check_th)
 GEN_OPIVX_WIDEN_TRANS_TH(th_vwmaccsu_vx, opivx_widen_check_th)
 GEN_OPIVX_WIDEN_TRANS_TH(th_vwmaccus_vx, opivx_widen_check_th)
 
+/* Vector Integer Merge and Move Instructions */
+
+/*
+ * This function is almost the copy of trans_vmv_v_v, except:
+ * 1) XTheadVector simplifies the judgment logic of whether
+ *    to accelerate or not for its lack of fractional LMUL and
+ *    VTA.
+ */
+static bool trans_th_vmv_v_v(DisasContext *s, arg_th_vmv_v_v *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s) &&
+        th_check_reg(s, a->rd, false) &&
+        th_check_reg(s, a->rs1, false)) {
+
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),
+                             vreg_ofs(s, a->rs1),
+                             MAXSZ(s), MAXSZ(s));
+        } else {
+            uint32_t data = FIELD_DP32(0, VDATA_TH, LMUL, s->lmul);
+            static gen_helper_gvec_2_ptr * const fns[4] = {
+                gen_helper_th_vmv_v_v_b, gen_helper_th_vmv_v_v_h,
+                gen_helper_th_vmv_v_v_w, gen_helper_th_vmv_v_v_d,
+            };
+
+            tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
+                               tcg_env, s->cfg_ptr->vlenb,
+                               s->cfg_ptr->vlenb, data,
+                               fns[s->sew]);
+        }
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
+
+#define gen_helper_vmv_vx_th gen_helper_vmv_vx
+/*
+ * This function is almost the copy of trans_vmv_v_x, except:
+ * 1) Simplier judgment logic of acceleration
+ * 2) XTheadVector has no limit of SEW of 8 to 64, Therefore, it is not
+ *    suitable to use acceleration when xlen < SEW.
+ */
+static bool trans_th_vmv_v_x(DisasContext *s, arg_th_vmv_v_x *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s) &&
+        th_check_reg(s, a->rd, false)) {
+
+        TCGv s1;
+        s1 = get_gpr(s, a->rs1, EXT_SIGN);
+
+        if (s->vl_eq_vlmax && (8 << s->sew) <= get_xlen(s)) {
+            tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
+                                MAXSZ(s), MAXSZ(s), s1);
+        } else {
+            TCGv_i32 desc;
+            TCGv_i64 s1_i64 = tcg_temp_new_i64();
+            TCGv_ptr dest = tcg_temp_new_ptr();
+            uint32_t data = FIELD_DP32(0, VDATA_TH, LMUL, s->lmul);
+            static gen_helper_vmv_vx_th * const fns[4] = {
+                gen_helper_th_vmv_v_x_b, gen_helper_th_vmv_v_x_h,
+                gen_helper_th_vmv_v_x_w, gen_helper_th_vmv_v_x_d,
+            };
+
+            tcg_gen_ext_tl_i64(s1_i64, s1);
+            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                              s->cfg_ptr->vlenb, data));
+            tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
+            fns[s->sew](dest, s1_i64, tcg_env, desc);
+        }
+
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
+/* The difference is same as trans_th_vmv_v_v */
+static bool trans_th_vmv_v_i(DisasContext *s, arg_th_vmv_v_i *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s) &&
+        th_check_reg(s, a->rd, false)) {
+
+        int64_t simm = sextract64(a->rs1, 0, 5);
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), simm);
+        } else {
+            TCGv_i32 desc;
+            TCGv_i64 s1;
+            TCGv_ptr dest;
+            uint32_t data = FIELD_DP32(0, VDATA_TH, LMUL, s->lmul);
+            static gen_helper_vmv_vx_th * const fns[4] = {
+                gen_helper_th_vmv_v_x_b, gen_helper_th_vmv_v_x_h,
+                gen_helper_th_vmv_v_x_w, gen_helper_th_vmv_v_x_d,
+            };
+
+            s1 = tcg_constant_i64(simm);
+            dest = tcg_temp_new_ptr();
+            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                              s->cfg_ptr->vlenb, data));
+            tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
+            fns[s->sew](dest, s1, tcg_env, desc);
+        }
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
+GEN_OPIVV_TRANS_TH(th_vmerge_vvm, opivv_vadc_check_th)
+GEN_OPIVX_TRANS_TH(th_vmerge_vxm, opivx_vadc_check_th)
+GEN_OPIVI_TRANS_TH(th_vmerge_vim, IMM_SX, th_vmerge_vxm, opivx_vadc_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vmv_v_v)
-TH_TRANS_STUB(th_vmv_v_x)
-TH_TRANS_STUB(th_vmv_v_i)
-TH_TRANS_STUB(th_vmerge_vvm)
-TH_TRANS_STUB(th_vmerge_vxm)
-TH_TRANS_STUB(th_vmerge_vim)
 TH_TRANS_STUB(th_vsaddu_vv)
 TH_TRANS_STUB(th_vsaddu_vx)
 TH_TRANS_STUB(th_vsaddu_vi)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 19aad626c9..d8a0e3af90 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1923,3 +1923,107 @@ GEN_TH_VX(th_vwmaccsu_vx_w, 4, 8, clearq_th)
 GEN_TH_VX(th_vwmaccus_vx_b, 1, 2, clearh_th)
 GEN_TH_VX(th_vwmaccus_vx_h, 2, 4, clearl_th)
 GEN_TH_VX(th_vwmaccus_vx_w, 4, 8, clearq_th)
+
+/* Vector Integer Merge and Move Instructions */
+
+/*
+ * The funtions below of VMV and vmerge are all the copy of RVV1.0 functions,
+ * except:
+ * 1) different desc encoding
+ * 2) different tail/masked element process policy
+ * 3) different mask layout
+ */
+#define GEN_TH_VMV_VV(NAME, ETYPE, H, CLEAR_FN)                      \
+void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
+                  uint32_t desc)                                     \
+{                                                                    \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = th_maxsz(desc) / esz;                           \
+    uint32_t i;                                                      \
+                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    for (i = env->vstart; i < vl; i++) {                             \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
+        *((ETYPE *)vd + H(i)) = s1;                                  \
+    }                                                                \
+    env->vstart = 0;                                                 \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_TH_VMV_VV(th_vmv_v_v_b, int8_t,  H1, clearb_th)
+GEN_TH_VMV_VV(th_vmv_v_v_h, int16_t, H2, clearh_th)
+GEN_TH_VMV_VV(th_vmv_v_v_w, int32_t, H4, clearl_th)
+GEN_TH_VMV_VV(th_vmv_v_v_d, int64_t, H8, clearq_th)
+
+#define GEN_TH_VMV_VX(NAME, ETYPE, H, CLEAR_FN)                      \
+void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
+                  uint32_t desc)                                     \
+{                                                                    \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = th_maxsz(desc) / esz;                           \
+    uint32_t i;                                                      \
+                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    for (i = env->vstart; i < vl; i++) {                             \
+        *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
+    }                                                                \
+    env->vstart = 0;                                                 \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_TH_VMV_VX(th_vmv_v_x_b, int8_t,  H1, clearb_th)
+GEN_TH_VMV_VX(th_vmv_v_x_h, int16_t, H2, clearh_th)
+GEN_TH_VMV_VX(th_vmv_v_x_w, int32_t, H4, clearl_th)
+GEN_TH_VMV_VX(th_vmv_v_x_d, int64_t, H8, clearq_th)
+
+#define GEN_TH_VMERGE_VV(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
+                  CPURISCVState *env, uint32_t desc)                 \
+{                                                                    \
+    uint32_t mlen = th_mlen(desc);                                   \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = th_maxsz(desc) / esz;                           \
+    uint32_t i;                                                      \
+                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    for (i = env->vstart; i < vl; i++) {                             \
+        ETYPE *vt = (!th_elem_mask(v0, mlen, i) ? vs2 : vs1);        \
+        *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
+    }                                                                \
+    env->vstart = 0;                                                 \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_TH_VMERGE_VV(th_vmerge_vvm_b, int8_t,  H1, clearb_th)
+GEN_TH_VMERGE_VV(th_vmerge_vvm_h, int16_t, H2, clearh_th)
+GEN_TH_VMERGE_VV(th_vmerge_vvm_w, int32_t, H4, clearl_th)
+GEN_TH_VMERGE_VV(th_vmerge_vvm_d, int64_t, H8, clearq_th)
+
+#define GEN_TH_VMERGE_VX(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
+                  void *vs2, CPURISCVState *env, uint32_t desc)      \
+{                                                                    \
+    uint32_t mlen = th_mlen(desc);                                   \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = th_maxsz(desc) / esz;                           \
+    uint32_t i;                                                      \
+                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+    for (i = env->vstart; i < vl; i++) {                             \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
+        ETYPE d = (!th_elem_mask(v0, mlen, i) ? s2 :                 \
+                   (ETYPE)(target_long)s1);                          \
+        *((ETYPE *)vd + H(i)) = d;                                   \
+    }                                                                \
+    env->vstart = 0;                                                 \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_TH_VMERGE_VX(th_vmerge_vxm_b, int8_t,  H1, clearb_th)
+GEN_TH_VMERGE_VX(th_vmerge_vxm_h, int16_t, H2, clearh_th)
+GEN_TH_VMERGE_VX(th_vmerge_vxm_w, int32_t, H4, clearl_th)
+GEN_TH_VMERGE_VX(th_vmerge_vxm_d, int64_t, H8, clearq_th)
-- 
2.44.0


