Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C49C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvC9r-00053h-2T; Fri, 12 Apr 2024 04:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC9o-00053N-Kt; Fri, 12 Apr 2024 04:21:12 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvC9m-0007aQ-0A; Fri, 12 Apr 2024 04:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712910063; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=CvEg4L7EWN8kOWi0WEBbcpERM3281h1RojXMFy93aWQ=;
 b=bo9LP6mIUcgbpBYLCml0PxJBm70f4foBSDqP6frbMaTSJvN9KZQT77xdf4GUoQS1Iyf/WTK7fnZhkhBl5XpxOKmhJlwBfe+k6AxLy9TGn7uvrCPRDeIHx8sXfpE8o/+Hq2vxMCmK7y3omeahTkpVykeXczMoMrjNGRTiWNYB3CA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NfDVK_1712910061; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NfDVK_1712910061) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 16:21:02 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 21/65] target/riscv: Add narrowing integer right shift
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:36:51 +0800
Message-ID: <20240412073735.76413-22-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
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
 target/riscv/helper.h                         | 13 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 99 +++++++++++++++++--
 target/riscv/xtheadvector_helper.c            | 26 +++++
 3 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 77251af8c9..d3170ba91f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1625,3 +1625,16 @@ DEF_HELPER_6(th_vsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(th_vsra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(th_vnsrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnsrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnsrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnsra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnsra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnsra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vnsrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnsrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(th_vnsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index d72320699c..68810ff0ec 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -1377,18 +1377,105 @@ GEN_OPIVI_GVEC_TRANS_TH(th_vsll_vi, IMM_TRUNC_SEW, th_vsll_vx,  shli)
 GEN_OPIVI_GVEC_TRANS_TH(th_vsrl_vi, IMM_TRUNC_SEW, th_vsrl_vx,  shri)
 GEN_OPIVI_GVEC_TRANS_TH(th_vsra_vi, IMM_TRUNC_SEW, th_vsra_vx,  sari)
 
+/* Vector Narrowing Integer Right Shift Instructions */
+static bool opivv_narrow_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, true) &&
+            th_check_reg(s, a->rs1, false) &&
+            th_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                                   2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+/* OPIVV with NARROW */
+#define GEN_OPIVV_NARROW_TRANS_TH(NAME)                            \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (opivv_narrow_check_th(s, a)) {                             \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_b,                                 \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+        };                                                         \
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
+                           fns[s->sew]);                           \
+        finalize_rvv_inst(s);                                      \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPIVV_NARROW_TRANS_TH(th_vnsra_vv)
+GEN_OPIVV_NARROW_TRANS_TH(th_vnsrl_vv)
+
+static bool opivx_narrow_check_th(DisasContext *s, arg_rmrr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, true) &&
+            th_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                                   2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+/* OPIVX with NARROW */
+#define GEN_OPIVX_NARROW_TRANS_TH(NAME)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                      \
+{                                                                           \
+    if (opivx_narrow_check_th(s, a)) {                                      \
+        static gen_helper_opivx * const fns[3] = {                          \
+            gen_helper_##NAME##_b,                                          \
+            gen_helper_##NAME##_h,                                          \
+            gen_helper_##NAME##_w,                                          \
+        };                                                                  \
+        return opivx_trans_th(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s);\
+    }                                                                       \
+    return false;                                                           \
+}
+
+GEN_OPIVX_NARROW_TRANS_TH(th_vnsra_vx)
+GEN_OPIVX_NARROW_TRANS_TH(th_vnsrl_vx)
+
+/* OPIVI with NARROW */
+#define GEN_OPIVI_NARROW_TRANS_TH(NAME, ZX, OPIVX)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opivx_narrow_check_th(s, a)) {                                   \
+        static gen_helper_opivx * const fns[3] = {                       \
+            gen_helper_##OPIVX##_b,                                      \
+            gen_helper_##OPIVX##_h,                                      \
+            gen_helper_##OPIVX##_w,                                      \
+        };                                                               \
+        return opivi_trans_th(a->rd, a->rs1, a->rs2, a->vm,              \
+                              fns[s->sew], s, ZX);                       \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVI_NARROW_TRANS_TH(th_vnsra_vi, IMM_ZX, th_vnsra_vx)
+GEN_OPIVI_NARROW_TRANS_TH(th_vnsrl_vi, IMM_ZX, th_vnsrl_vx)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vnsrl_vv)
-TH_TRANS_STUB(th_vnsrl_vx)
-TH_TRANS_STUB(th_vnsrl_vi)
-TH_TRANS_STUB(th_vnsra_vv)
-TH_TRANS_STUB(th_vnsra_vx)
-TH_TRANS_STUB(th_vnsra_vi)
 TH_TRANS_STUB(th_vmseq_vv)
 TH_TRANS_STUB(th_vmseq_vx)
 TH_TRANS_STUB(th_vmseq_vi)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index d3f10ad873..f4bd80349d 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -1389,3 +1389,29 @@ GEN_TH_SHIFT_VX(th_vsra_vx_w, int32_t, int32_t, H4, H4, TH_SRL,
                 0x1f, clearl_th)
 GEN_TH_SHIFT_VX(th_vsra_vx_d, int64_t, int64_t, H8, H8, TH_SRL,
                 0x3f, clearq_th)
+
+/* Vector Narrowing Integer Right Shift Instructions */
+GEN_TH_SHIFT_VV(th_vnsrl_vv_b, uint8_t,  uint16_t, H1, H2, TH_SRL,
+                0xf, clearb_th)
+GEN_TH_SHIFT_VV(th_vnsrl_vv_h, uint16_t, uint32_t, H2, H4, TH_SRL,
+                0x1f, clearh_th)
+GEN_TH_SHIFT_VV(th_vnsrl_vv_w, uint32_t, uint64_t, H4, H8, TH_SRL,
+                0x3f, clearl_th)
+GEN_TH_SHIFT_VV(th_vnsra_vv_b, uint8_t,  int16_t, H1, H2, TH_SRL,
+                0xf, clearb_th)
+GEN_TH_SHIFT_VV(th_vnsra_vv_h, uint16_t, int32_t, H2, H4, TH_SRL,
+                0x1f, clearh_th)
+GEN_TH_SHIFT_VV(th_vnsra_vv_w, uint32_t, int64_t, H4, H8, TH_SRL,
+                0x3f, clearl_th)
+GEN_TH_SHIFT_VX(th_vnsrl_vx_b, uint8_t, uint16_t, H1, H2, TH_SRL,
+                0xf, clearb_th)
+GEN_TH_SHIFT_VX(th_vnsrl_vx_h, uint16_t, uint32_t, H2, H4, TH_SRL,
+                0x1f, clearh_th)
+GEN_TH_SHIFT_VX(th_vnsrl_vx_w, uint32_t, uint64_t, H4, H8, TH_SRL,
+                0x3f, clearl_th)
+GEN_TH_SHIFT_VX(th_vnsra_vx_b, int8_t, int16_t, H1, H2, TH_SRL,
+                0xf, clearb_th)
+GEN_TH_SHIFT_VX(th_vnsra_vx_h, int16_t, int32_t, H2, H4, TH_SRL,
+                0x1f, clearh_th)
+GEN_TH_SHIFT_VX(th_vnsra_vx_w, int32_t, int64_t, H4, H8, TH_SRL,
+                0x3f, clearl_th)
-- 
2.44.0


