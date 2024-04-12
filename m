Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E43C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDjZ-00037w-Ug; Fri, 12 Apr 2024 06:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDjY-00037U-3K; Fri, 12 Apr 2024 06:02:12 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDjR-0001DV-Ox; Fri, 12 Apr 2024 06:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712916120; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=rKnpcCoeh0YvzwdWQhd/twJaWjtVRJRykEO5548t2OA=;
 b=v19+I8YBi84yIYzaofvSN4NEZxoKqWjLkOTxzuJeQv9c2LmQjW//LxNkmnwFDook/JXQpRT2mZPFa+glAdGRTvfvhBnY+2sJfJO2NVsB3Va//asr+a4HQKjtAYImFCzncO+h0tCH0EOm2ddn6R5IIYJU2ewDKM5WHjCb00C/nsM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NtRJZ_1712916118; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NtRJZ_1712916118) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 18:01:59 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 63/65] target/riscv: Add vector register gather instructions
 for XTheadVector
Date: Fri, 12 Apr 2024 15:37:33 +0800
Message-ID: <20240412073735.76413-64-eric.huang@linux.alibaba.com>
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  9 ++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 85 ++++++++++++++++++-
 target/riscv/xtheadvector_helper.c            | 64 ++++++++++++++
 3 files changed, 155 insertions(+), 3 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6ce0bcbba7..b650e299cf 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2333,3 +2333,12 @@ DEF_HELPER_6(th_vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vrgather_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrgather_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrgather_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrgather_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vrgather_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 46cfc51690..f6da1ff384 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2816,13 +2816,92 @@ GEN_OPIVX_TRANS_TH(th_vslidedown_vx, opivx_check_th)
 GEN_OPIVX_TRANS_TH(th_vslide1down_vx, opivx_check_th)
 GEN_OPIVI_TRANS_TH(th_vslidedown_vi, IMM_ZX, th_vslidedown_vx, opivx_check_th)
 
+/* Vector Register Gather Instruction */
+static bool vrgather_vv_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs1, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2) && (a->rd != a->rs1));
+}
+
+GEN_OPIVV_TRANS_TH(th_vrgather_vv, vrgather_vv_check_th)
+
+static bool vrgather_vx_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2));
+}
+
+/* vrgather.vx vd, vs2, rs1, vm # vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
+static bool trans_th_vrgather_vx(DisasContext *s, arg_rmrr *a)
+{
+    if (!vrgather_vx_check_th(s, a)) {
+        return false;
+    }
+
+    if (a->vm && s->vl_eq_vlmax) {
+        int vlmax = (s->cfg_ptr->vlenb << 3) / s->mlen;
+        TCGv_i64 dest = tcg_temp_new_i64();
+
+        if (a->rs1 == 0) {
+            th_element_loadi(s, dest, a->rs2, 0);
+        } else {
+            th_element_loadx(s, dest, a->rs2, cpu_gpr[a->rs1], vlmax);
+        }
+
+        tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                             MAXSZ(s), MAXSZ(s), dest);
+        finalize_rvv_inst(s);
+    } else {
+        static gen_helper_opivx * const fns[4] = {
+            gen_helper_th_vrgather_vx_b, gen_helper_th_vrgather_vx_h,
+            gen_helper_th_vrgather_vx_w, gen_helper_th_vrgather_vx_d
+        };
+        return opivx_trans_th(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s);
+    }
+    return true;
+}
+
+/* vrgather.vi vd, vs2, imm, vm # vd[i] = (imm >= VLMAX) ? 0 : vs2[imm] */
+static bool trans_th_vrgather_vi(DisasContext *s, arg_rmrr *a)
+{
+    if (!vrgather_vx_check_th(s, a)) {
+        return false;
+    }
+
+    if (a->vm && s->vl_eq_vlmax) {
+        if (a->rs1 >= (s->cfg_ptr->vlenb << 3) / s->mlen) {
+            tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), 0);
+        } else {
+            tcg_gen_gvec_dup_mem(s->sew, vreg_ofs(s, a->rd),
+                                 endian_ofs(s, a->rs2, a->rs1),
+                                 MAXSZ(s), MAXSZ(s));
+        }
+        finalize_rvv_inst(s);
+    } else {
+        static gen_helper_opivx * const fns[4] = {
+            gen_helper_th_vrgather_vx_b, gen_helper_th_vrgather_vx_h,
+            gen_helper_th_vrgather_vx_w, gen_helper_th_vrgather_vx_d
+        };
+        return opivi_trans_th(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew],
+                              s, IMM_ZX);
+    }
+    return true;
+}
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vrgather_vv)
-TH_TRANS_STUB(th_vrgather_vx)
-TH_TRANS_STUB(th_vrgather_vi)
 TH_TRANS_STUB(th_vcompress_vm)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 73a15eb070..2598824bb3 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3801,3 +3801,67 @@ GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_b, uint8_t, H1, clearb_th)
 GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_h, uint16_t, H2, clearh_th)
 GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_w, uint32_t, H4, clearl_th)
 GEN_TH_VSLIDE1DOWN_VX(th_vslide1down_vx_d, uint64_t, H8, clearq_th)
+
+/* Vector Register Gather Instruction */
+#define GEN_TH_VRGATHER_VV(NAME, ETYPE, H, CLEAR_FN)                      \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    uint32_t index, i;                                                    \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        index = *((ETYPE *)vs1 + H(i));                                   \
+        if (index >= vlmax) {                                             \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
+        }                                                                 \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
+GEN_TH_VRGATHER_VV(th_vrgather_vv_b, uint8_t, H1, clearb_th)
+GEN_TH_VRGATHER_VV(th_vrgather_vv_h, uint16_t, H2, clearh_th)
+GEN_TH_VRGATHER_VV(th_vrgather_vv_w, uint32_t, H4, clearl_th)
+GEN_TH_VRGATHER_VV(th_vrgather_vv_d, uint64_t, H8, clearq_th)
+
+#define GEN_TH_VRGATHER_VX(NAME, ETYPE, H, CLEAR_FN)                      \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vlmax = (env_archcpu(env)->cfg.vlenb << 3) / mlen;           \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    uint32_t index = s1, i;                                               \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        if (index >= vlmax) {                                             \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
+        }                                                                 \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
+GEN_TH_VRGATHER_VX(th_vrgather_vx_b, uint8_t, H1, clearb_th)
+GEN_TH_VRGATHER_VX(th_vrgather_vx_h, uint16_t, H2, clearh_th)
+GEN_TH_VRGATHER_VX(th_vrgather_vx_w, uint32_t, H4, clearl_th)
+GEN_TH_VRGATHER_VX(th_vrgather_vx_d, uint64_t, H8, clearq_th)
-- 
2.44.0


