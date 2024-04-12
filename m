Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B42DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvC80-00041h-SA; Fri, 12 Apr 2024 04:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC7z-00040V-3u; Fri, 12 Apr 2024 04:19:19 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC7u-000722-RN; Fri, 12 Apr 2024 04:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712909943; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=0bIc/Q6v2L6SYxXtcDSnlBWrOUgRyTmsETGPlvTfqys=;
 b=tV/LjvSWuf5jIrDfvkY9QRU/yEvf/F10KJPxdgeLNHKo6+hBFWnTzhF0xS+w2/Mh++WZfxaqwWZDlqGWq7vtAoHDoGQOxmp0XuskPpwPvcDQaU5+xUl7rnmzgERcu1KlRL94emr/hXYKaGZfNuMHphUL11oOtZP+JIYxFXGMdaU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nan8p_1712909940; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nan8p_1712909940) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:19:01 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 20/65] target/riscv: Add single-width bit shift instructions
 for XTheadVector
Date: Fri, 12 Apr 2024 15:36:50 +0800
Message-ID: <20240412073735.76413-21-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
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

The difference between XTheadVector and RVV1.0 is same as the other patchs:
1. Different mask reg layout.
2. Different tail/masked elements process policy.
3. Simpler acceleration judgment logic.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         |  25 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  61 ++++++++--
 target/riscv/xtheadvector_helper.c            | 115 ++++++++++++++++++
 3 files changed, 192 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6599b2f2f5..77251af8c9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1600,3 +1600,28 @@ DEF_HELPER_6(th_vxor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vxor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vxor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vxor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vsll_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsll_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsll_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsll_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vsll_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsll_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsll_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsll_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsrl_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vsra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 2b7b2cfe20..d72320699c 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1325,21 +1325,64 @@ GEN_OPIVI_GVEC_TRANS_TH(th_vand_vi, IMM_SX, th_vand_vx, andi)
 GEN_OPIVI_GVEC_TRANS_TH(th_vor_vi, IMM_SX, th_vor_vx,  ori)
 GEN_OPIVI_GVEC_TRANS_TH(th_vxor_vi, IMM_SX, th_vxor_vx, xori)
 
+/* Vector Single-Width Bit Shift Instructions */
+GEN_OPIVV_GVEC_TRANS_TH(th_vsll_vv,  shlv)
+GEN_OPIVV_GVEC_TRANS_TH(th_vsrl_vv,  shrv)
+GEN_OPIVV_GVEC_TRANS_TH(th_vsra_vv,  sarv)
+
+#define GVecGen2sFn32_Th GVecGen2sFn32
+
+/*
+ * This function is almost the copy of do_opivx_gvec_shift, except:
+ * 1) XTheadVector simplifies the judgment logic of whether
+ *    to accelerate or not for its lack of fractional LMUL and
+ *    VTA.
+ */
+static inline bool
+do_opivx_gvec_shift_th(DisasContext *s, arg_rmrr *a, GVecGen2sFn32_Th *gvec_fn,
+                       gen_helper_opivx_th *fn)
+{
+    if (a->vm && s->vl_eq_vlmax) {
+        TCGv_i32 src1 = tcg_temp_new_i32();
+
+        tcg_gen_trunc_tl_i32(src1, get_gpr(s, a->rs1, EXT_NONE));
+        tcg_gen_extract_i32(src1, src1, 0, s->sew + 3);
+        gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
+                src1, MAXSZ(s), MAXSZ(s));
+
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return opivx_trans_th(a->rd, a->rs1, a->rs2, a->vm, fn, s);
+}
+
+#define GEN_OPIVX_GVEC_SHIFT_TRANS_TH(NAME, SUF)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
+{                                                                         \
+    static gen_helper_opivx * const fns[4] = {                            \
+        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                     \
+        gen_helper_##NAME##_w, gen_helper_##NAME##_d,                     \
+    };                                                                    \
+    if (!opivx_check_th(s, a)) {                                          \
+        return false;                                                     \
+    }                                                                     \
+    return do_opivx_gvec_shift_th(s, a, tcg_gen_gvec_##SUF, fns[s->sew]); \
+}
+
+GEN_OPIVX_GVEC_SHIFT_TRANS_TH(th_vsll_vx,  shls)
+GEN_OPIVX_GVEC_SHIFT_TRANS_TH(th_vsrl_vx,  shrs)
+GEN_OPIVX_GVEC_SHIFT_TRANS_TH(th_vsra_vx,  sars)
+
+GEN_OPIVI_GVEC_TRANS_TH(th_vsll_vi, IMM_TRUNC_SEW, th_vsll_vx,  shli)
+GEN_OPIVI_GVEC_TRANS_TH(th_vsrl_vi, IMM_TRUNC_SEW, th_vsrl_vx,  shri)
+GEN_OPIVI_GVEC_TRANS_TH(th_vsra_vi, IMM_TRUNC_SEW, th_vsra_vx,  sari)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vsll_vv)
-TH_TRANS_STUB(th_vsll_vx)
-TH_TRANS_STUB(th_vsll_vi)
-TH_TRANS_STUB(th_vsrl_vv)
-TH_TRANS_STUB(th_vsrl_vx)
-TH_TRANS_STUB(th_vsrl_vi)
-TH_TRANS_STUB(th_vsra_vv)
-TH_TRANS_STUB(th_vsra_vx)
-TH_TRANS_STUB(th_vsra_vi)
 TH_TRANS_STUB(th_vnsrl_vv)
 TH_TRANS_STUB(th_vnsrl_vx)
 TH_TRANS_STUB(th_vnsrl_vi)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 85fa69dd82..d3f10ad873 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1274,3 +1274,118 @@ GEN_TH_VX(th_vxor_vx_b, 1, 1, clearb_th)
 GEN_TH_VX(th_vxor_vx_h, 2, 2, clearh_th)
 GEN_TH_VX(th_vxor_vx_w, 4, 4, clearl_th)
 GEN_TH_VX(th_vxor_vx_d, 8, 8, clearq_th)
+
+/* Vector Single-Width Bit Shift Instructions */
+#define TH_SLL(N, M)  (N << (M))
+#define TH_SRL(N, M)  (N >> (M))
+
+/*
+ * generate the helpers for shift instructions with two vector operators
+ *
+ * GEN_TH_SHIFT_VV and GEN_TH_SHIFT_VX are almost the copy of
+ * GEN_VEXT_SHIFT_VV and GEN_VEXT_SHIFT_VX, except:
+ * 1) different mask layout
+ * 2) different data encoding
+ * 3) different masked/tail elements process policy
+ */
+#define GEN_TH_SHIFT_VV(NAME, TS1, TS2, HS1, HS2, OP, MASK, CLEAR_FN)     \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
+                  void *vs2, CPURISCVState *env, uint32_t desc)           \
+{                                                                         \
+    uint32_t mlen = th_mlen(desc);                                        \
+    uint32_t vm = th_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                \
+    uint32_t esz = sizeof(TS1);                                           \
+    uint32_t vlmax = th_maxsz(desc) / esz;                                \
+    uint32_t i;                                                           \
+                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+    for (i = env->vstart; i < vl; i++) {                                  \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                          \
+            continue;                                                     \
+        }                                                                 \
+        TS1 s1 = *((TS1 *)vs1 + HS1(i));                                  \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
+        *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
+    }                                                                     \
+    env->vstart = 0;                                                      \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                              \
+}
+
+GEN_TH_SHIFT_VV(th_vsll_vv_b, uint8_t,  uint8_t, H1, H1, TH_SLL,
+                0x7, clearb_th)
+GEN_TH_SHIFT_VV(th_vsll_vv_h, uint16_t, uint16_t, H2, H2, TH_SLL,
+                0xf, clearh_th)
+GEN_TH_SHIFT_VV(th_vsll_vv_w, uint32_t, uint32_t, H4, H4, TH_SLL,
+                0x1f, clearl_th)
+GEN_TH_SHIFT_VV(th_vsll_vv_d, uint64_t, uint64_t, H8, H8, TH_SLL,
+                0x3f, clearq_th)
+
+GEN_TH_SHIFT_VV(th_vsrl_vv_b, uint8_t, uint8_t, H1, H1, TH_SRL,
+                0x7, clearb_th)
+GEN_TH_SHIFT_VV(th_vsrl_vv_h, uint16_t, uint16_t, H2, H2, TH_SRL,
+                0xf, clearh_th)
+GEN_TH_SHIFT_VV(th_vsrl_vv_w, uint32_t, uint32_t, H4, H4, TH_SRL,
+                0x1f, clearl_th)
+GEN_TH_SHIFT_VV(th_vsrl_vv_d, uint64_t, uint64_t, H8, H8, TH_SRL,
+                0x3f, clearq_th)
+
+GEN_TH_SHIFT_VV(th_vsra_vv_b, uint8_t,  int8_t, H1, H1, TH_SRL,
+                0x7, clearb_th)
+GEN_TH_SHIFT_VV(th_vsra_vv_h, uint16_t, int16_t, H2, H2, TH_SRL,
+                0xf, clearh_th)
+GEN_TH_SHIFT_VV(th_vsra_vv_w, uint32_t, int32_t, H4, H4, TH_SRL,
+                0x1f, clearl_th)
+GEN_TH_SHIFT_VV(th_vsra_vv_d, uint64_t, int64_t, H8, H8, TH_SRL,
+                0x3f, clearq_th)
+
+/* generate the helpers for shift instructions with one vector and one scalar */
+#define GEN_TH_SHIFT_VX(NAME, TD, TS2, HD, HS2, OP, MASK, CLEAR_FN)   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
+        void *vs2, CPURISCVState *env, uint32_t desc)                 \
+{                                                                     \
+    uint32_t mlen = th_mlen(desc);                                    \
+    uint32_t vm = th_vm(desc);                                        \
+    uint32_t vl = env->vl;                                            \
+    uint32_t esz = sizeof(TD);                                        \
+    uint32_t vlmax = th_maxsz(desc) / esz;                            \
+    uint32_t i;                                                       \
+                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                     \
+    for (i = env->vstart; i < vl; i++) {                              \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {                      \
+            continue;                                                 \
+        }                                                             \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                              \
+        *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);                      \
+    }                                                                 \
+    env->vstart = 0;                                                  \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                          \
+}
+
+GEN_TH_SHIFT_VX(th_vsll_vx_b, uint8_t, int8_t, H1, H1, TH_SLL,
+                0x7, clearb_th)
+GEN_TH_SHIFT_VX(th_vsll_vx_h, uint16_t, int16_t, H2, H2, TH_SLL,
+                0xf, clearh_th)
+GEN_TH_SHIFT_VX(th_vsll_vx_w, uint32_t, int32_t, H4, H4, TH_SLL,
+                0x1f, clearl_th)
+GEN_TH_SHIFT_VX(th_vsll_vx_d, uint64_t, int64_t, H8, H8, TH_SLL,
+                0x3f, clearq_th)
+
+GEN_TH_SHIFT_VX(th_vsrl_vx_b, uint8_t, uint8_t, H1, H1, TH_SRL,
+                0x7, clearb_th)
+GEN_TH_SHIFT_VX(th_vsrl_vx_h, uint16_t, uint16_t, H2, H2, TH_SRL,
+                0xf, clearh_th)
+GEN_TH_SHIFT_VX(th_vsrl_vx_w, uint32_t, uint32_t, H4, H4, TH_SRL,
+                0x1f, clearl_th)
+GEN_TH_SHIFT_VX(th_vsrl_vx_d, uint64_t, uint64_t, H8, H8, TH_SRL,
+                0x3f, clearq_th)
+
+GEN_TH_SHIFT_VX(th_vsra_vx_b, int8_t, int8_t, H1, H1, TH_SRL,
+                0x7, clearb_th)
+GEN_TH_SHIFT_VX(th_vsra_vx_h, int16_t, int16_t, H2, H2, TH_SRL,
+                0xf, clearh_th)
+GEN_TH_SHIFT_VX(th_vsra_vx_w, int32_t, int32_t, H4, H4, TH_SRL,
+                0x1f, clearl_th)
+GEN_TH_SHIFT_VX(th_vsra_vx_d, int64_t, int64_t, H8, H8, TH_SRL,
+                0x3f, clearq_th)
-- 
2.44.0


