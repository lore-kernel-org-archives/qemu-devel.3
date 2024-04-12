Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDB3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDCM-0001a6-00; Fri, 12 Apr 2024 05:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDCH-0001Xs-9k; Fri, 12 Apr 2024 05:27:49 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDCD-0003X4-3Y; Fri, 12 Apr 2024 05:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914055; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=u18ajQw8BnyfQfbSYOWjFV4OF+CR1EdD+IwPlrADmSY=;
 b=qQGukJHBu0ps21+a/jPDEDmO0OBJ5sWDwXztUD5e96fI6xjt2iN23HvZBL3nRNQGjXM+ZZa7HuFxmI1RBwqUadn6eM3lnTfdn4Aiz9uRfsG5p2RFqOhytw4hSL8Xtz+HZkpH9OcYBaqmeVoyyPbneHjj5C8IxMitaHrq1TzYQSs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Novpj_1712914053; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Novpj_1712914053) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:27:34 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 46/65] target/riscv: Add floating-point classify and merge
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:16 +0800
Message-ID: <20240412073735.76413-47-eric.huang@linux.alibaba.com>
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
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  8 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 51 +++++++++++++++-
 target/riscv/xtheadvector_helper.c            | 58 +++++++++++++++++++
 3 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 5771a4fa8a..886655899e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2189,3 +2189,11 @@ DEF_HELPER_6(th_vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(th_vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(th_vfclass_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfclass_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfclass_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(th_vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 1e773c673e..8e928febb7 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2143,15 +2143,60 @@ GEN_OPFVF_TRANS_TH(th_vmfgt_vf, opfvf_cmp_check_th)
 GEN_OPFVF_TRANS_TH(th_vmfge_vf, opfvf_cmp_check_th)
 GEN_OPFVF_TRANS_TH(th_vmford_vf, opfvf_cmp_check_th)
 
+/* Vector Floating-Point Classify Instruction */
+GEN_OPFV_TRANS_TH(th_vfclass_v, opfv_check_th)
+
+/* Vector Floating-Point Merge Instruction */
+GEN_OPFVF_TRANS_TH(th_vfmerge_vfm,  opfvf_check_th)
+
+/* Besides of check function, th_vfmv_v_f just reuse the helper_th_vmv_v_x */
+static bool trans_th_vfmv_v_f(DisasContext *s, arg_th_vfmv_v_f *a)
+{
+    if (require_xtheadvector(s) &&
+        vext_check_isa_ill(s) &&
+        th_check_reg(s, a->rd, false) &&
+        (s->sew != 0)) {
+
+        TCGv_i64 t1;
+
+        if (s->vl_eq_vlmax) {
+            t1 = tcg_temp_new_i64();
+            /* NaN-box f[rs1] */
+            do_nanbox(s, t1, cpu_fpr[a->rs1]);
+            tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), t1);
+        } else {
+            TCGv_ptr dest;
+            TCGv_i32 desc;
+            uint32_t data = FIELD_DP32(0, VDATA_TH, LMUL, s->lmul);
+            static gen_helper_vmv_vx_th * const fns[3] = {
+                gen_helper_th_vmv_v_x_h,
+                gen_helper_th_vmv_v_x_w,
+                gen_helper_th_vmv_v_x_d,
+            };
+
+            t1 = tcg_temp_new_i64();
+            /* NaN-box f[rs1] */
+            do_nanbox(s, t1, cpu_fpr[a->rs1]);
+
+            dest = tcg_temp_new_ptr();
+            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                              s->cfg_ptr->vlenb, data));
+            tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
+            fns[s->sew - 1](dest, t1, tcg_env, desc);
+        }
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfclass_v)
-TH_TRANS_STUB(th_vfmerge_vfm)
-TH_TRANS_STUB(th_vfmv_v_f)
 TH_TRANS_STUB(th_vfcvt_xu_f_v)
 TH_TRANS_STUB(th_vfcvt_x_f_v)
 TH_TRANS_STUB(th_vfcvt_f_xu_v)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 603b34a094..e31e13dff3 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3147,3 +3147,61 @@ GEN_TH_CMP_VV_ENV(th_vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
 GEN_TH_CMP_VF(th_vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
 GEN_TH_CMP_VF(th_vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
 GEN_TH_CMP_VF(th_vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
+
+/* Vector Floating-Point Classify Instruction */
+#define TH_OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP) \
+        OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)
+
+#define GEN_TH_V(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
+                  CPURISCVState *env, uint32_t desc)   \
+{                                                      \
+    uint32_t vlmax = th_maxsz(desc) / ESZ;             \
+    uint32_t mlen = th_mlen(desc);                     \
+    uint32_t vm = th_vm(desc);                         \
+    uint32_t vl = env->vl;                             \
+    uint32_t i;                                        \
+                                                       \
+    VSTART_CHECK_EARLY_EXIT(env);                      \
+    for (i = env->vstart; i < vl; i++) {               \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {       \
+            continue;                                  \
+        }                                              \
+        do_##NAME(vd, vs2, i);                         \
+    }                                                  \
+    env->vstart = 0;                                   \
+    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+}
+
+THCALL(TH_OPIVV1, th_vfclass_v_h, OP_UU_H, H2, H2, fclass_h)
+THCALL(TH_OPIVV1, th_vfclass_v_w, OP_UU_W, H4, H4, fclass_s)
+THCALL(TH_OPIVV1, th_vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
+GEN_TH_V(th_vfclass_v_h, 2, 2, clearh_th)
+GEN_TH_V(th_vfclass_v_w, 4, 4, clearl_th)
+GEN_TH_V(th_vfclass_v_d, 8, 8, clearq_th)
+
+/* Vector Floating-Point Merge Instruction */
+#define GEN_VFMERGE_VF_TH(NAME, ETYPE, H, CLEAR_FN)           \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = th_mlen(desc);                            \
+    uint32_t vm = th_vm(desc);                                \
+    uint32_t vl = env->vl;                                    \
+    uint32_t esz = sizeof(ETYPE);                             \
+    uint32_t vlmax = th_maxsz(desc) / esz;                    \
+    uint32_t i;                                               \
+                                                              \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+    for (i = env->vstart; i < vl; i++) {                      \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        *((ETYPE *)vd + H(i))                                 \
+          = (!vm && !th_elem_mask(v0, mlen, i) ? s2 : s1);    \
+    }                                                         \
+    env->vstart = 0;                                          \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+}
+
+GEN_VFMERGE_VF_TH(th_vfmerge_vfm_h, int16_t, H2, clearh_th)
+GEN_VFMERGE_VF_TH(th_vfmerge_vfm_w, int32_t, H4, clearl_th)
+GEN_VFMERGE_VF_TH(th_vfmerge_vfm_d, int64_t, H8, clearq_th)
-- 
2.44.0


