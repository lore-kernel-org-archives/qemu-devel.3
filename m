Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F3EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCdK-0003Gn-IU; Fri, 12 Apr 2024 04:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCdG-0003D5-Pf; Fri, 12 Apr 2024 04:51:39 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvCdC-0005nE-Rs; Fri, 12 Apr 2024 04:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712911885; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=eUj5n97wrTCwLeO2A7acdUv4TXegDzvT7ygrNj10q4A=;
 b=Vwk8sSYFjyTqT0ZX12DM6JXg8fMBGkI2lVGRMOMD5Syj9yIaB1d+zso7kF5OYIdGOqBs6r4aFeJJRfiacsshfnR91vT0XFWff0OyinktNTyhmZn4BghiACGNL2bR17xXkBDDPyTH2FZDZ59wzgySPz1yNd6YlsxZCwYKm/ea4/w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NgUmG_1712911884; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NgUmG_1712911884) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:51:25 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 36/65] target/riscv: Add single-width floating-point add/sub
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:06 +0800
Message-ID: <20240412073735.76413-37-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

In this patch, we add single-width floating-point add/sub instructions
to show the way we implement XTheadVector floating-point arithmetic
instructions. XTheadVector diff from RVV1.0 in the following points:
1. Different mask reg layout.
2. Different tail/masked elements process policy.
3. Different check policy. XTheadVector does not have fractional lmul, so we can
   use simpler check function.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  16 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 113 +++++++++++++++++-
 target/riscv/vector_helper.c                  |   6 +-
 target/riscv/vector_internals.h               |   4 +
 target/riscv/xtheadvector_helper.c            | 106 ++++++++++++++++
 5 files changed, 237 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6254be771f..04bd363ac0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1996,3 +1996,19 @@ DEF_HELPER_6(th_vnclipu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vnclip_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vnclip_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vnclip_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vfadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 108f3249d0..a18c661f24 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1746,17 +1746,120 @@ GEN_OPIVX_NARROW_TRANS_TH(th_vnclip_vx)
 GEN_OPIVI_NARROW_TRANS_TH(th_vnclipu_vi, IMM_ZX, th_vnclipu_vx)
 GEN_OPIVI_NARROW_TRANS_TH(th_vnclip_vi, IMM_ZX, th_vnclip_vx)
 
+/*
+ * Vector Float Point Arithmetic Instructions
+ */
+
+/* Vector Single-Width Floating-Point Add/Subtract Instructions */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised.
+ */
+static bool opfvv_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return require_xtheadvector(s) &&
+           vext_check_isa_ill(s) &&
+           th_check_overlap_mask(s, a->rd, a->vm, false) &&
+           th_check_reg(s, a->rd, false) &&
+           th_check_reg(s, a->rs2, false) &&
+           th_check_reg(s, a->rs1, false) &&
+           (s->sew != 0);
+}
+
+/*
+ * The macro below including GEN_OPFVV_TRANS_TH and GEN_OPFVF_TRANS_TH,
+ * are just changed the data encoding compared to RVV1.0.
+ */
+
+/* OPFVV without GVEC IR */
+#define GEN_OPFVV_TRANS_TH(NAME, CHECK)                            \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+            gen_helper_##NAME##_d,                                 \
+        };                                                         \
+        gen_set_rm(s, RISCV_FRM_DYN);                              \
+                                                                   \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);          \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);          \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0),                         \
+                           vreg_ofs(s, a->rs1),                    \
+                           vreg_ofs(s, a->rs2), tcg_env,           \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
+                           fns[s->sew - 1]);                       \
+        finalize_rvv_inst(s);                                      \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPFVV_TRANS_TH(th_vfadd_vv, opfvv_check_th)
+GEN_OPFVV_TRANS_TH(th_vfsub_vv, opfvv_check_th)
+
+#define gen_helper_opfvf_th gen_helper_opfvf
+
+static bool opfvf_check_th(DisasContext *s, arg_rmrr *a)
+{
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+    return require_xtheadvector(s) &&
+           vext_check_isa_ill(s) &&
+           th_check_overlap_mask(s, a->rd, a->vm, false) &&
+           th_check_reg(s, a->rd, false) &&
+           th_check_reg(s, a->rs2, false) &&
+           (s->sew != 0);
+}
+
+/*
+ * OPFVF without GVEC IR
+ *
+ * XTheadVector has different process policy when FLEN < SEW from
+ * RVV1.0. In XTheadVector, when FLEN < SEW, the value in freg should
+ * be nanboxed, while in RVV1.0, this situation is reserved.
+ * However, RVF-only cpus always have values NaN-boxed to 64-bits, so
+ * we do not have to deal with this situation differently. We can just
+ * use the RVV function opfvf_trans
+ */
+#define GEN_OPFVF_TRANS_TH(NAME, CHECK)                           \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
+{                                                                 \
+    if (CHECK(s, a)) {                                            \
+        uint32_t data = 0;                                        \
+        static gen_helper_opfvf_th *const fns[3] = {              \
+            gen_helper_##NAME##_h,                                \
+            gen_helper_##NAME##_w,                                \
+            gen_helper_##NAME##_d,                                \
+        };                                                        \
+        gen_set_rm(s, RISCV_FRM_DYN);                             \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);         \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);             \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);         \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
+                           fns[s->sew - 1], s);                   \
+    }                                                             \
+    return false;                                                 \
+}
+
+GEN_OPFVF_TRANS_TH(th_vfadd_vf,  opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfsub_vf,  opfvf_check_th)
+GEN_OPFVF_TRANS_TH(th_vfrsub_vf,  opfvf_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfadd_vv)
-TH_TRANS_STUB(th_vfadd_vf)
-TH_TRANS_STUB(th_vfsub_vv)
-TH_TRANS_STUB(th_vfsub_vf)
-TH_TRANS_STUB(th_vfrsub_vf)
 TH_TRANS_STUB(th_vfwadd_vv)
 TH_TRANS_STUB(th_vfwadd_vf)
 TH_TRANS_STUB(th_vfwadd_wv)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 262cb28824..3784096da2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2904,17 +2904,17 @@ GEN_VEXT_VF(vfsub_vf_h, 2)
 GEN_VEXT_VF(vfsub_vf_w, 4)
 GEN_VEXT_VF(vfsub_vf_d, 8)
 
-static uint16_t float16_rsub(uint16_t a, uint16_t b, float_status *s)
+uint16_t float16_rsub(uint16_t a, uint16_t b, float_status *s)
 {
     return float16_sub(b, a, s);
 }
 
-static uint32_t float32_rsub(uint32_t a, uint32_t b, float_status *s)
+uint32_t float32_rsub(uint32_t a, uint32_t b, float_status *s)
 {
     return float32_sub(b, a, s);
 }
 
-static uint64_t float64_rsub(uint64_t a, uint64_t b, float_status *s)
+uint64_t float64_rsub(uint64_t a, uint64_t b, float_status *s)
 {
     return float64_sub(b, a, s);
 }
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index a42dc080ec..5f250ab7ba 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -340,4 +340,8 @@ uint8_t vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b);
 uint16_t vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b);
 uint32_t vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b);
 
+uint16_t float16_rsub(uint16_t a, uint16_t b, float_status *s);
+uint32_t float32_rsub(uint32_t a, uint32_t b, float_status *s);
+uint64_t float64_rsub(uint64_t a, uint64_t b, float_status *s);
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 2e97a95392..60811ca813 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -2590,3 +2590,109 @@ THCALL(TH_OPIVX2_RM, th_vnclipu_vx_w, NOP_UUU_W, H4, H8, vnclipu32)
 GEN_TH_VX_RM(th_vnclipu_vx_b, 1, 1, clearb_th)
 GEN_TH_VX_RM(th_vnclipu_vx_h, 2, 2, clearh_th)
 GEN_TH_VX_RM(th_vnclipu_vx_w, 4, 4, clearl_th)
+
+/*
+ * Vector Float Point Arithmetic Instructions
+ */
+
+/* Vector Single-Width Floating-Point Add/Subtract Instructions */
+
+/*
+ * Some functions or macros are just the same as RVV1.0.
+ * But it is not worthy to extract them from RVV1.0, so we just copy
+ * them.
+ */
+#define TH_OPFVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)\
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i,   \
+                      CPURISCVState *env)                      \
+{                                                              \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                            \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                            \
+    *((TD *)vd + HD(i)) = OP(s2, s1, &env->fp_status);         \
+}
+
+#define GEN_TH_VV_ENV(NAME, ESZ, DSZ, CLEAR_FN)           \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+                  void *vs2, CPURISCVState *env,          \
+                  uint32_t desc)                          \
+{                                                         \
+    uint32_t vlmax = th_maxsz(desc) / ESZ;                \
+    uint32_t mlen = th_mlen(desc);                        \
+    uint32_t vm = th_vm(desc);                            \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+    for (i = env->vstart; i < vl; i++) {                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {          \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, vs1, vs2, i, env);                  \
+    }                                                     \
+    env->vstart = 0;                                      \
+    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
+}
+
+THCALL(TH_OPFVV2, th_vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
+THCALL(TH_OPFVV2, th_vfadd_vv_w, OP_UUU_W, H4, H4, H4, float32_add)
+THCALL(TH_OPFVV2, th_vfadd_vv_d, OP_UUU_D, H8, H8, H8, float64_add)
+GEN_TH_VV_ENV(th_vfadd_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfadd_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfadd_vv_d, 8, 8, clearq_th)
+
+#define TH_OPFVF2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)     \
+static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i, \
+                      CPURISCVState *env)                      \
+{                                                              \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                            \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, &env->fp_status);\
+}
+
+#define GEN_TH_VF(NAME, ESZ, DSZ, CLEAR_FN)               \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
+                  void *vs2, CPURISCVState *env,          \
+                  uint32_t desc)                          \
+{                                                         \
+    uint32_t vlmax = th_maxsz(desc) / ESZ;                \
+    uint32_t mlen = th_mlen(desc);                        \
+    uint32_t vm = th_vm(desc);                            \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+    for (i = env->vstart; i < vl; i++) {                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {          \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, s1, vs2, i, env);                   \
+    }                                                     \
+    env->vstart = 0;                                      \
+    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
+}
+
+THCALL(TH_OPFVF2, th_vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
+THCALL(TH_OPFVF2, th_vfadd_vf_w, OP_UUU_W, H4, H4, float32_add)
+THCALL(TH_OPFVF2, th_vfadd_vf_d, OP_UUU_D, H8, H8, float64_add)
+GEN_TH_VF(th_vfadd_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfadd_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfadd_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVV2, th_vfsub_vv_h, OP_UUU_H, H2, H2, H2, float16_sub)
+THCALL(TH_OPFVV2, th_vfsub_vv_w, OP_UUU_W, H4, H4, H4, float32_sub)
+THCALL(TH_OPFVV2, th_vfsub_vv_d, OP_UUU_D, H8, H8, H8, float64_sub)
+GEN_TH_VV_ENV(th_vfsub_vv_h, 2, 2, clearh_th)
+GEN_TH_VV_ENV(th_vfsub_vv_w, 4, 4, clearl_th)
+GEN_TH_VV_ENV(th_vfsub_vv_d, 8, 8, clearq_th)
+THCALL(TH_OPFVF2, th_vfsub_vf_h, OP_UUU_H, H2, H2, float16_sub)
+THCALL(TH_OPFVF2, th_vfsub_vf_w, OP_UUU_W, H4, H4, float32_sub)
+THCALL(TH_OPFVF2, th_vfsub_vf_d, OP_UUU_D, H8, H8, float64_sub)
+GEN_TH_VF(th_vfsub_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfsub_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfsub_vf_d, 8, 8, clearq_th)
+
+THCALL(TH_OPFVF2, th_vfrsub_vf_h, OP_UUU_H, H2, H2, float16_rsub)
+THCALL(TH_OPFVF2, th_vfrsub_vf_w, OP_UUU_W, H4, H4, float32_rsub)
+THCALL(TH_OPFVF2, th_vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
+GEN_TH_VF(th_vfrsub_vf_h, 2, 2, clearh_th)
+GEN_TH_VF(th_vfrsub_vf_w, 4, 4, clearl_th)
+GEN_TH_VF(th_vfrsub_vf_d, 8, 8, clearq_th)
-- 
2.44.0


