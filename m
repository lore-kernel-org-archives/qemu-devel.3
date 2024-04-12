Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87784C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDG5-0003fa-LN; Fri, 12 Apr 2024 05:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDG4-0003f9-AR; Fri, 12 Apr 2024 05:31:44 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDG2-0004FG-2m; Fri, 12 Apr 2024 05:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914297; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=OQkwqlQyAGecjgu36JEhPI+x+SwzdeavdQ8Z7kWrmk8=;
 b=N/xasp9Fa5+6OGnwkM6lf87zZ6gdkszNCWr69MDatzkuX+1HUXAZsJg3kYa2PvdMXUY+TOg8V0znkPwYR3Qq+QmtVdy0I+rUKOn24Nr/huweVzZFNL7i4ptelE3EzwH0p5geDPS0kxnNv3Z51Y9VvESG6bMfFJ/f02WT608DCJU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NqQ8L_1712914296; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NqQ8L_1712914296) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:31:36 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 48/65] target/riscv: Add widening floating-point/integer
 type-convert instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:18 +0800
Message-ID: <20240412073735.76413-49-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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

Compared to RVV1.0, XTheadVector lacks .rtz instructions, which specify the
rounding mode of rounding to zero.
Except of lack of similar instructions, the instructions have the same function
as RVV1.0. Overall there are only general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 13 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 93 ++++++++++++++++++-
 target/riscv/vector_helper.c                  |  5 +-
 target/riscv/vector_internals.h               |  3 +
 target/riscv/xtheadvector_helper.c            | 44 +++++++++
 5 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 18640c4a1e..e2d737c9c4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2210,3 +2210,16 @@ DEF_HELPER_5(th_vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(th_vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_xu_v_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_x_v_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 27a06c2cac..72643facb1 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2197,17 +2197,100 @@ GEN_OPFV_TRANS_TH(th_vfcvt_x_f_v, opfv_check_th)
 GEN_OPFV_TRANS_TH(th_vfcvt_f_xu_v, opfv_check_th)
 GEN_OPFV_TRANS_TH(th_vfcvt_f_x_v, opfv_check_th)
 
+/* Widening Floating-Point/Integer Type-Convert Instructions */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_widen_check_th(DisasContext *s, arg_rmr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                   1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+static bool opfxv_widen_check_th(DisasContext *s, arg_rmr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, true) &&
+            th_check_reg(s, a->rd, true) &&
+            th_check_reg(s, a->rs2, false) &&
+            th_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                   1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+#define GEN_OPFXV_WIDEN_TRANS_TH(NAME)                             \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfxv_widen_check_th(s, a)) {                              \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_b,                                 \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+        };                                                         \
+        gen_set_rm(s, RISCV_FRM_DYN);                              \
+                                                                   \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);          \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);          \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0),                         \
+                           vreg_ofs(s, a->rs2), tcg_env,           \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
+                           fns[s->sew]);                           \
+        finalize_rvv_inst(s);                                      \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPFXV_WIDEN_TRANS_TH(th_vfwcvt_f_xu_v)
+GEN_OPFXV_WIDEN_TRANS_TH(th_vfwcvt_f_x_v)
+
+#define GEN_OPFV_WIDEN_TRANS_TH(NAME)                              \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfv_widen_check_th(s, a)) {                               \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[2] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+        };                                                         \
+        gen_set_rm(s, RISCV_FRM_DYN);                              \
+                                                                   \
+        data = FIELD_DP32(data, VDATA_TH, MLEN, s->mlen);          \
+        data = FIELD_DP32(data, VDATA_TH, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA_TH, LMUL, s->lmul);          \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0),                         \
+                           vreg_ofs(s, a->rs2), tcg_env,           \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
+                           fns[s->sew - 1]);                       \
+        finalize_rvv_inst(s);                                      \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPFV_WIDEN_TRANS_TH(th_vfwcvt_xu_f_v)
+GEN_OPFV_WIDEN_TRANS_TH(th_vfwcvt_x_f_v)
+GEN_OPFV_WIDEN_TRANS_TH(th_vfwcvt_f_f_v)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfwcvt_xu_f_v)
-TH_TRANS_STUB(th_vfwcvt_x_f_v)
-TH_TRANS_STUB(th_vfwcvt_f_xu_v)
-TH_TRANS_STUB(th_vfwcvt_f_x_v)
-TH_TRANS_STUB(th_vfwcvt_f_f_v)
 TH_TRANS_STUB(th_vfncvt_xu_f_v)
 TH_TRANS_STUB(th_vfncvt_x_f_v)
 TH_TRANS_STUB(th_vfncvt_f_xu_v)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c966600d0c..105c2eb00a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4265,10 +4265,7 @@ GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4)
 GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8)
 
 /* Widening Floating-Point/Integer Type-Convert Instructions */
-/* (TD, T2, TX2) */
-#define WOP_UU_B uint16_t, uint8_t,  uint8_t
-#define WOP_UU_H uint32_t, uint16_t, uint16_t
-#define WOP_UU_W uint64_t, uint32_t, uint32_t
+
 /*
  * vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.
  */
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index b870e15392..aac96f830c 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -132,6 +132,9 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
 #define OP_UU_H uint16_t, uint16_t, uint16_t
 #define OP_UU_W uint32_t, uint32_t, uint32_t
 #define OP_UU_D uint64_t, uint64_t, uint64_t
+#define WOP_UU_B uint16_t, uint8_t,  uint8_t
+#define WOP_UU_H uint32_t, uint16_t, uint16_t
+#define WOP_UU_W uint64_t, uint32_t, uint32_t
 
 /* (TD, T1, T2, TX1, TX2) */
 #define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 7e98c1ead2..42328a8a58 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3238,3 +3238,47 @@ THCALL(TH_OPFVV1, th_vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
 GEN_TH_V_ENV(th_vfcvt_f_x_v_h, 2, 2, clearh_th)
 GEN_TH_V_ENV(th_vfcvt_f_x_v_w, 4, 4, clearl_th)
 GEN_TH_V_ENV(th_vfcvt_f_x_v_d, 8, 8, clearq_th)
+
+/* Widening Floating-Point/Integer Type-Convert Instructions */
+
+/* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
+THCALL(TH_OPFVV1, th_vfwcvt_xu_f_v_h, WOP_UU_H, H4, H2, float16_to_uint32)
+THCALL(TH_OPFVV1, th_vfwcvt_xu_f_v_w, WOP_UU_W, H8, H4, float32_to_uint64)
+GEN_TH_V_ENV(th_vfwcvt_xu_f_v_h, 2, 4, clearl_th)
+GEN_TH_V_ENV(th_vfwcvt_xu_f_v_w, 4, 8, clearq_th)
+
+/* vfwcvt.x.f.v vd, vs2, vm # Convert float to double-width signed integer. */
+THCALL(TH_OPFVV1, th_vfwcvt_x_f_v_h, WOP_UU_H, H4, H2, float16_to_int32)
+THCALL(TH_OPFVV1, th_vfwcvt_x_f_v_w, WOP_UU_W, H8, H4, float32_to_int64)
+GEN_TH_V_ENV(th_vfwcvt_x_f_v_h, 2, 4, clearl_th)
+GEN_TH_V_ENV(th_vfwcvt_x_f_v_w, 4, 8, clearq_th)
+
+/* vfwcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to double-width float */
+THCALL(TH_OPFVV1, th_vfwcvt_f_xu_v_b, WOP_UU_B, H2, H1, uint8_to_float16)
+THCALL(TH_OPFVV1, th_vfwcvt_f_xu_v_h, WOP_UU_H, H4, H2, uint16_to_float32)
+THCALL(TH_OPFVV1, th_vfwcvt_f_xu_v_w, WOP_UU_W, H8, H4, uint32_to_float64)
+GEN_TH_V_ENV(th_vfwcvt_f_xu_v_b, 1, 2, clearh_th)
+GEN_TH_V_ENV(th_vfwcvt_f_xu_v_h, 2, 4, clearl_th)
+GEN_TH_V_ENV(th_vfwcvt_f_xu_v_w, 4, 8, clearq_th)
+
+/* vfwcvt.f.x.v vd, vs2, vm # Convert integer to double-width float. */
+THCALL(TH_OPFVV1, th_vfwcvt_f_x_v_b, WOP_UU_B, H2, H1, int8_to_float16)
+THCALL(TH_OPFVV1, th_vfwcvt_f_x_v_h, WOP_UU_H, H4, H2, int16_to_float32)
+THCALL(TH_OPFVV1, th_vfwcvt_f_x_v_w, WOP_UU_W, H8, H4, int32_to_float64)
+GEN_TH_V_ENV(th_vfwcvt_f_x_v_b, 1, 2, clearh_th)
+GEN_TH_V_ENV(th_vfwcvt_f_x_v_h, 2, 4, clearl_th)
+GEN_TH_V_ENV(th_vfwcvt_f_x_v_w, 4, 8, clearq_th)
+
+/*
+ * vfwcvt.f.f.v vd, vs2, vm #
+ * Convert single-width float to double-width float.
+ */
+static uint32_t vfwcvtffv16(uint16_t a, float_status *s)
+{
+    return float16_to_float32(a, true, s);
+}
+
+THCALL(TH_OPFVV1, th_vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
+THCALL(TH_OPFVV1, th_vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, float32_to_float64)
+GEN_TH_V_ENV(th_vfwcvt_f_f_v_h, 2, 4, clearl_th)
+GEN_TH_V_ENV(th_vfwcvt_f_f_v_w, 4, 8, clearq_th)
-- 
2.44.0


