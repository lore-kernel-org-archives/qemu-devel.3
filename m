Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555FBC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvC4H-0001qI-Jp; Fri, 12 Apr 2024 04:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC43-0001nD-VF; Fri, 12 Apr 2024 04:15:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC3w-0006U9-KJ; Fri, 12 Apr 2024 04:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909698; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=qlt/5Mp05T6u3nwzd3/bnHiRuWYLiQjE9zreh2l8OK0=;
 b=fSP+IkDeh1AVrW5xWxfpxiCy9X6QAywrp3ra5RaXdbiVC2aPRkqwYEn8itnebqNW8VuLvLG9HoAdshNqm5Gtui2WT5H0lPvUQWBAmuGQC8yCCHLwT7xfzYSLL2ZLcYjT1Yhmmte9fsN38rdu+8ld8ByfirMeZ2qUQghxys7PpQg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NYaj5_1712909697; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NYaj5_1712909697) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:14:58 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 18/65] target/riscv: Add integer
 add-with-carry/sub-with-borrow instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:48 +0800
Message-ID: <20240412073735.76413-19-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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

XTheadVector adc/sbc instructions diff from RVV1.0 in the following points:
1. Different mask reg layout.
2. Different tail elements process policy.
3. Different check policy.
4. When vm = 1, RVV1.0 vmadc and vmsbc perform the computation without
   carry-in/borrow-in. While XTheadVector does not have this kind of situation.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  33 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 139 +++++++++++++-
 target/riscv/xtheadvector_helper.c            | 173 ++++++++++++++++++
 3 files changed, 335 insertions(+), 10 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3906f17079..25fb8f81c7 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1542,3 +1542,36 @@ DEF_HELPER_6(th_vwadd_wx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwsub_wx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwsub_wx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vwsub_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vadc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vadc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vadc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vadc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vadc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmadc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vmsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index f6aea9deff..a9e20a6dcb 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1185,22 +1185,141 @@ GEN_OPIWX_WIDEN_TRANS_TH(th_vwadd_wx)
 GEN_OPIWX_WIDEN_TRANS_TH(th_vwsubu_wx)
 GEN_OPIWX_WIDEN_TRANS_TH(th_vwsub_wx)
 
+/* Vector Integer Add-with-Carry / Subtract-with-Borrow Instructions */
+
+/*
+ * This function is almost the copy of opivv_trans, except:
+ * 1) XTheadVector using different data encoding, add MLEN,
+ *    delete VTA and VMA.
+ */
+static bool opivv_trans_th(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
+                           gen_helper_gvec_4_ptr *fn, DisasContext *s)
+{
+    uint32_t data = 0;
+
+    data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA_TH, VM, vm);
+    data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);
+    tcg_gen_gvec_4_ptr(vreg_ofs(s, vd), vreg_ofs(s, 0),
+                       vreg_ofs(s, vs1), vreg_ofs(s, vs2),
+                       tcg_env, s->cfg_ptr->vlenb,
+                       s->cfg_ptr->vlenb, data, fn);
+    finalize_rvv_inst(s);
+    return true;
+}
+
+/* OPIVV without GVEC IR */
+#define GEN_OPIVV_TRANS_TH(NAME, CHECK)                            \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        static gen_helper_gvec_4_ptr * const fns[4] = {            \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,          \
+        };                                                         \
+        return opivv_trans_th(a->rd, a->rs1, a->rs2, a->vm,        \
+                              fns[s->sew], s);                     \
+    }                                                              \
+    return false;                                                  \
+}
+
+/*
+ * For vadc and vsbc, an illegal instruction exception is raised if the
+ * destination vector register is v0 and LMUL > 1.
+ */
+static bool opivv_vadc_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_reg(s, a->rs1, false) &&
+            ((a->rd != 0) || (s->lmul == 0)));
+}
+
+GEN_OPIVV_TRANS_TH(th_vadc_vvm, opivv_vadc_check_th)
+GEN_OPIVV_TRANS_TH(th_vsbc_vvm, opivv_vadc_check_th)
+
+/*
+ * For vmadc and vmsbc, an illegal instruction exception is raised if the
+ * destination vector register overlaps a source vector register group.
+ */
+static bool opivv_vmadc_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_reg(s, a->rs1, false) &&
+            th_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
+            th_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+}
+
+GEN_OPIVV_TRANS_TH(th_vmadc_vvm, opivv_vmadc_check_th)
+GEN_OPIVV_TRANS_TH(th_vmsbc_vvm, opivv_vmadc_check_th)
+
+static bool opivx_vadc_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            ((a->rd != 0) || (s->lmul == 0)));
+}
+
+/* OPIVX without GVEC IR */
+#define GEN_OPIVX_TRANS_TH(NAME, CHECK)                                  \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        static gen_helper_opivx * const fns[4] = {                       \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                \
+        };                                                               \
+                                                                         \
+        return opivx_trans_th(a->rd, a->rs1, a->rs2, a->vm,              \
+                              fns[s->sew], s);                           \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVX_TRANS_TH(th_vadc_vxm, opivx_vadc_check_th)
+GEN_OPIVX_TRANS_TH(th_vsbc_vxm, opivx_vadc_check_th)
+
+static bool opivx_vmadc_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+}
+
+GEN_OPIVX_TRANS_TH(th_vmadc_vxm, opivx_vmadc_check_th)
+GEN_OPIVX_TRANS_TH(th_vmsbc_vxm, opivx_vmadc_check_th)
+
+/* OPIVI without GVEC IR */
+#define GEN_OPIVI_TRANS_TH(NAME, ZX, OPIVX, CHECK)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        static gen_helper_opivx * const fns[4] = {                       \
+            gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,              \
+            gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,              \
+        };                                                               \
+        return opivi_trans_th(a->rd, a->rs1, a->rs2, a->vm,              \
+                              fns[s->sew], s, ZX);                       \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVI_TRANS_TH(th_vadc_vim, IMM_SX, th_vadc_vxm, opivx_vadc_check_th)
+GEN_OPIVI_TRANS_TH(th_vmadc_vim, IMM_SX, th_vmadc_vxm, opivx_vmadc_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vadc_vvm)
-TH_TRANS_STUB(th_vadc_vxm)
-TH_TRANS_STUB(th_vadc_vim)
-TH_TRANS_STUB(th_vmadc_vvm)
-TH_TRANS_STUB(th_vmadc_vxm)
-TH_TRANS_STUB(th_vmadc_vim)
-TH_TRANS_STUB(th_vsbc_vvm)
-TH_TRANS_STUB(th_vsbc_vxm)
-TH_TRANS_STUB(th_vmsbc_vvm)
-TH_TRANS_STUB(th_vmsbc_vxm)
 TH_TRANS_STUB(th_vand_vv)
 TH_TRANS_STUB(th_vand_vx)
 TH_TRANS_STUB(th_vand_vi)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 5ebdb5a375..e5058d09f6 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -134,6 +134,15 @@ static inline int th_elem_mask(void *v0, int mlen, int index)
     return (((uint64_t *)v0)[idx] >> pos) & 1;
 }
 
+static inline void th_set_elem_mask(void *v0, int mlen, int index,
+                                    uint8_t value)
+{
+    int idx = (index * mlen) / 64;
+    int pos = (index * mlen) % 64;
+    uint64_t old = ((uint64_t *)v0)[idx];
+    ((uint64_t *)v0)[idx] = deposit64(old, pos, mlen, value);
+}
+
 /* elements operations for load and store */
 typedef void th_ldst_elem_fn(CPURISCVState *env, abi_ptr addr,
                              uint32_t idx, void *vd, uintptr_t retaddr);
@@ -1050,3 +1059,167 @@ GEN_TH_VX(th_vwadd_wx_w, 4, 8, clearq_th)
 GEN_TH_VX(th_vwsub_wx_b, 1, 2, clearh_th)
 GEN_TH_VX(th_vwsub_wx_h, 2, 4, clearl_th)
 GEN_TH_VX(th_vwsub_wx_w, 4, 8, clearq_th)
+
+/* Vector Integer Add-with-Carry / Subtract-with-Borrow Instructions */
+
+#define TH_VADC(N, M, C) (N + M + C)
+#define TH_VSBC(N, M, C) (N - M - C)
+/*
+ * This function is almost the copy of GEN_VEXT_VADC_VVM, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different tail elements process policy
+ */
+#define GEN_TH_VADC_VVM(NAME, ETYPE, H, DO_OP, CLEAR_FN)      \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = th_mlen(desc);                            \
+    uint32_t vl = env->vl;                                    \
+    uint32_t esz = sizeof(ETYPE);                             \
+    uint32_t vlmax = th_maxsz(desc) / esz;                    \
+    uint32_t i;                                               \
+                                                              \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+    for (i = env->vstart; i < vl; i++) {                      \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        uint8_t carry = th_elem_mask(v0, mlen, i);            \
+                                                              \
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
+    }                                                         \
+    env->vstart = 0;                                          \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+}
+
+GEN_TH_VADC_VVM(th_vadc_vvm_b, uint8_t,  H1, TH_VADC, clearb_th)
+GEN_TH_VADC_VVM(th_vadc_vvm_h, uint16_t, H2, TH_VADC, clearh_th)
+GEN_TH_VADC_VVM(th_vadc_vvm_w, uint32_t, H4, TH_VADC, clearl_th)
+GEN_TH_VADC_VVM(th_vadc_vvm_d, uint64_t, H8, TH_VADC, clearq_th)
+
+GEN_TH_VADC_VVM(th_vsbc_vvm_b, uint8_t,  H1, TH_VSBC, clearb_th)
+GEN_TH_VADC_VVM(th_vsbc_vvm_h, uint16_t, H2, TH_VSBC, clearh_th)
+GEN_TH_VADC_VVM(th_vsbc_vvm_w, uint32_t, H4, TH_VSBC, clearl_th)
+GEN_TH_VADC_VVM(th_vsbc_vvm_d, uint64_t, H8, TH_VSBC, clearq_th)
+/*
+ * This function is almost the copy of GEN_VEXT_VADC_VXM, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different tail elements process policy
+ */
+#define GEN_TH_VADC_VXM(NAME, ETYPE, H, DO_OP, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
+                  CPURISCVState *env, uint32_t desc)                     \
+{                                                                        \
+    uint32_t mlen = th_mlen(desc);                                       \
+    uint32_t vl = env->vl;                                               \
+    uint32_t esz = sizeof(ETYPE);                                        \
+    uint32_t vlmax = th_maxsz(desc) / esz;                               \
+    uint32_t i;                                                          \
+                                                                         \
+    VSTART_CHECK_EARLY_EXIT(env);                                        \
+    for (i = env->vstart; i < vl; i++) {                                 \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
+        uint8_t carry = th_elem_mask(v0, mlen, i);                       \
+                                                                         \
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
+    }                                                                    \
+    env->vstart = 0;                                                     \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                             \
+}
+
+GEN_TH_VADC_VXM(th_vadc_vxm_b, uint8_t,  H1, TH_VADC, clearb_th)
+GEN_TH_VADC_VXM(th_vadc_vxm_h, uint16_t, H2, TH_VADC, clearh_th)
+GEN_TH_VADC_VXM(th_vadc_vxm_w, uint32_t, H4, TH_VADC, clearl_th)
+GEN_TH_VADC_VXM(th_vadc_vxm_d, uint64_t, H8, TH_VADC, clearq_th)
+
+GEN_TH_VADC_VXM(th_vsbc_vxm_b, uint8_t,  H1, TH_VSBC, clearb_th)
+GEN_TH_VADC_VXM(th_vsbc_vxm_h, uint16_t, H2, TH_VSBC, clearh_th)
+GEN_TH_VADC_VXM(th_vsbc_vxm_w, uint32_t, H4, TH_VSBC, clearl_th)
+GEN_TH_VADC_VXM(th_vsbc_vxm_d, uint64_t, H8, TH_VSBC, clearq_th)
+
+#define TH_MADC(N, M, C) (C ? (__typeof(N))(N + M + 1) <= N :           \
+                          (__typeof(N))(N + M) < N)
+#define TH_MSBC(N, M, C) (C ? N <= M : N < M)
+/*
+ * This function is almost the copy of GEN_VEXT_VMADC_VVM, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different tail elements process policy
+ * 4) When vm = 1, RVV1.0 vmadc and vmsbc perform the computation
+ *    without carry-in/borrow-in. While XTheadVector does not have
+ *    this kind of situation.
+ */
+#define GEN_TH_VMADC_VVM(NAME, ETYPE, H, DO_OP)               \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = th_mlen(desc);                            \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = th_maxsz(desc) / sizeof(ETYPE);          \
+    uint32_t i;                                               \
+                                                              \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+    for (i = env->vstart; i < vl; i++) {                      \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        uint8_t carry = th_elem_mask(v0, mlen, i);            \
+                                                              \
+        th_set_elem_mask(vd, mlen, i, DO_OP(s2, s1, carry));  \
+    }                                                         \
+    env->vstart = 0;                                          \
+    for (; i < vlmax; i++) {                                  \
+        th_set_elem_mask(vd, mlen, i, 0);                     \
+    }                                                         \
+}
+
+GEN_TH_VMADC_VVM(th_vmadc_vvm_b, uint8_t,  H1, TH_MADC)
+GEN_TH_VMADC_VVM(th_vmadc_vvm_h, uint16_t, H2, TH_MADC)
+GEN_TH_VMADC_VVM(th_vmadc_vvm_w, uint32_t, H4, TH_MADC)
+GEN_TH_VMADC_VVM(th_vmadc_vvm_d, uint64_t, H8, TH_MADC)
+
+GEN_TH_VMADC_VVM(th_vmsbc_vvm_b, uint8_t,  H1, TH_MSBC)
+GEN_TH_VMADC_VVM(th_vmsbc_vvm_h, uint16_t, H2, TH_MSBC)
+GEN_TH_VMADC_VVM(th_vmsbc_vvm_w, uint32_t, H4, TH_MSBC)
+GEN_TH_VMADC_VVM(th_vmsbc_vvm_d, uint64_t, H8, TH_MSBC)
+/*
+ * This function is almost the copy of GEN_VEXT_VMADC_VXM, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different tail elements process policy
+ * 4) When vm = 1, RVV1.0 vmadc and vmsbc perform the computation
+ *    without carry-in/borrow-in. While XTheadVector does not have
+ *    this kind of situation.
+ */
+#define GEN_TH_VMADC_VXM(NAME, ETYPE, H, DO_OP)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
+                  void *vs2, CPURISCVState *env, uint32_t desc) \
+{                                                               \
+    uint32_t mlen = th_mlen(desc);                              \
+    uint32_t vl = env->vl;                                      \
+    uint32_t vlmax = th_maxsz(desc) / sizeof(ETYPE);            \
+    uint32_t i;                                                 \
+                                                                \
+    VSTART_CHECK_EARLY_EXIT(env);                               \
+    for (i = env->vstart; i < vl; i++) {                        \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
+        uint8_t carry = th_elem_mask(v0, mlen, i);              \
+                                                                \
+        th_set_elem_mask(vd, mlen, i,                           \
+                DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
+    }                                                           \
+    env->vstart = 0;                                            \
+    for (; i < vlmax; i++) {                                    \
+        th_set_elem_mask(vd, mlen, i, 0);                       \
+    }                                                           \
+}
+
+GEN_TH_VMADC_VXM(th_vmadc_vxm_b, uint8_t,  H1, TH_MADC)
+GEN_TH_VMADC_VXM(th_vmadc_vxm_h, uint16_t, H2, TH_MADC)
+GEN_TH_VMADC_VXM(th_vmadc_vxm_w, uint32_t, H4, TH_MADC)
+GEN_TH_VMADC_VXM(th_vmadc_vxm_d, uint64_t, H8, TH_MADC)
+
+GEN_TH_VMADC_VXM(th_vmsbc_vxm_b, uint8_t,  H1, TH_MSBC)
+GEN_TH_VMADC_VXM(th_vmsbc_vxm_h, uint16_t, H2, TH_MSBC)
+GEN_TH_VMADC_VXM(th_vmsbc_vxm_w, uint32_t, H4, TH_MSBC)
+GEN_TH_VMADC_VXM(th_vmsbc_vxm_d, uint64_t, H8, TH_MSBC)
-- 
2.44.0


