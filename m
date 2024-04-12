Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A293EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDIE-0004TW-9E; Fri, 12 Apr 2024 05:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDI8-0004T5-8N; Fri, 12 Apr 2024 05:33:52 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDI4-0004qE-JD; Fri, 12 Apr 2024 05:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914419; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=rC93BLhcxBARDE3kNCwShP8uX2l3KK8J6hT0P2jkSUg=;
 b=glHiHUEktGvcFtJrzTzT2rA9mX4nzwrjsa1MF60ZVck0r/VhxaPyRwOYwCfJJ/JucjUcVx+pQgopjf1p/oJM3Fz6FaICO7I0RPXR0eBCFuvCdfj95zA67RAyVCjTJPex9lZYav+VGjU8a2hfuhxFs7Mt81zBzITMgpP4QgKP3uA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NqQpB_1712914417; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NqQpB_1712914417) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:33:38 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 49/65] target/riscv: Add narrowing floating-point/integer
 type-convert instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:19 +0800
Message-ID: <20240412073735.76413-50-eric.huang@linux.alibaba.com>
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

Compared to RVV1.0, XTheadVector lacks .rtz and .rod instructions, which specify the
rounding mode.
Except of lack of similar instructions, the instructions have the same function
as RVV1.0. Overall there are only general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 13 +++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 94 ++++++++++++++++++-
 target/riscv/vector_helper.c                  |  5 +-
 target/riscv/vector_internals.h               |  3 +
 target/riscv/xtheadvector_helper.c            | 41 ++++++++
 5 files changed, 147 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e2d737c9c4..c666a5a020 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2223,3 +2223,16 @@ DEF_HELPER_5(th_vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(th_vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(th_vfncvt_xu_f_v_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_x_f_v_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(th_vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 72643facb1..d2734c007a 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2285,17 +2285,101 @@ GEN_OPFV_WIDEN_TRANS_TH(th_vfwcvt_xu_f_v)
 GEN_OPFV_WIDEN_TRANS_TH(th_vfwcvt_x_f_v)
 GEN_OPFV_WIDEN_TRANS_TH(th_vfwcvt_f_f_v)
 
+/* Narrowing Floating-Point/Integer Type-Convert Instructions */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_narrow_check_th(DisasContext *s, arg_rmr *a)
+{
+    return (require_xtheadvector(s) &&
+            vext_check_isa_ill(s) &&
+            th_check_overlap_mask(s, a->rd, a->vm, false) &&
+            th_check_reg(s, a->rd, false) &&
+            th_check_reg(s, a->rs2, true) &&
+            th_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                                   2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+static bool opxfv_narrow_check_th(DisasContext *s, arg_rmr *a)
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
+#define GEN_OPXFV_NARROW_TRANS_TH(NAME)                            \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opxfv_narrow_check_th(s, a)) {                             \
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
+
+GEN_OPXFV_NARROW_TRANS_TH(th_vfncvt_xu_f_v)
+GEN_OPXFV_NARROW_TRANS_TH(th_vfncvt_x_f_v)
+
+#define GEN_OPFV_NARROW_TRANS_TH(NAME)                             \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfv_narrow_check_th(s, a)) {                              \
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
+GEN_OPFV_NARROW_TRANS_TH(th_vfncvt_f_xu_v)
+GEN_OPFV_NARROW_TRANS_TH(th_vfncvt_f_x_v)
+GEN_OPFV_NARROW_TRANS_TH(th_vfncvt_f_f_v)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfncvt_xu_f_v)
-TH_TRANS_STUB(th_vfncvt_x_f_v)
-TH_TRANS_STUB(th_vfncvt_f_xu_v)
-TH_TRANS_STUB(th_vfncvt_f_x_v)
-TH_TRANS_STUB(th_vfncvt_f_f_v)
 TH_TRANS_STUB(th_vredsum_vs)
 TH_TRANS_STUB(th_vredand_vs)
 TH_TRANS_STUB(th_vredor_vs)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 105c2eb00a..baa0f47da6 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4315,10 +4315,7 @@ RVVCALL(OPFVV1, vfwcvtbf16_f_f_v, WOP_UU_H, H4, H2, bfloat16_to_float32)
 GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
-/* (TD, T2, TX2) */
-#define NOP_UU_B uint8_t,  uint16_t, uint32_t
-#define NOP_UU_H uint16_t, uint32_t, uint32_t
-#define NOP_UU_W uint32_t, uint64_t, uint64_t
+
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
 RVVCALL(OPFVV1, vfncvt_xu_f_w_b, NOP_UU_B, H1, H2, float16_to_uint8)
 RVVCALL(OPFVV1, vfncvt_xu_f_w_h, NOP_UU_H, H2, H4, float32_to_uint16)
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index aac96f830c..9033eae1cf 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -135,6 +135,9 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
 #define WOP_UU_B uint16_t, uint8_t,  uint8_t
 #define WOP_UU_H uint32_t, uint16_t, uint16_t
 #define WOP_UU_W uint64_t, uint32_t, uint32_t
+#define NOP_UU_B uint8_t,  uint16_t, uint32_t
+#define NOP_UU_H uint16_t, uint32_t, uint32_t
+#define NOP_UU_W uint32_t, uint64_t, uint64_t
 
 /* (TD, T1, T2, TX1, TX2) */
 #define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index 42328a8a58..3a7512ecd8 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3282,3 +3282,44 @@ THCALL(TH_OPFVV1, th_vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
 THCALL(TH_OPFVV1, th_vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, float32_to_float64)
 GEN_TH_V_ENV(th_vfwcvt_f_f_v_h, 2, 4, clearl_th)
 GEN_TH_V_ENV(th_vfwcvt_f_f_v_w, 4, 8, clearq_th)
+
+/* Narrowing Floating-Point/Integer Type-Convert Instructions */
+
+/* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+THCALL(TH_OPFVV1, th_vfncvt_xu_f_v_b, NOP_UU_B, H1, H2, float16_to_uint8)
+THCALL(TH_OPFVV1, th_vfncvt_xu_f_v_h, NOP_UU_H, H2, H4, float32_to_uint16)
+THCALL(TH_OPFVV1, th_vfncvt_xu_f_v_w, NOP_UU_W, H4, H8, float64_to_uint32)
+GEN_TH_V_ENV(th_vfncvt_xu_f_v_b, 1, 1, clearb_th)
+GEN_TH_V_ENV(th_vfncvt_xu_f_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfncvt_xu_f_v_w, 4, 4, clearl_th)
+
+/* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
+THCALL(TH_OPFVV1, th_vfncvt_x_f_v_b, NOP_UU_B, H1, H2, float16_to_int8)
+THCALL(TH_OPFVV1, th_vfncvt_x_f_v_h, NOP_UU_H, H2, H4, float32_to_int16)
+THCALL(TH_OPFVV1, th_vfncvt_x_f_v_w, NOP_UU_W, H4, H8, float64_to_int32)
+GEN_TH_V_ENV(th_vfncvt_x_f_v_b, 1, 1, clearb_th)
+GEN_TH_V_ENV(th_vfncvt_x_f_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfncvt_x_f_v_w, 4, 4, clearl_th)
+
+/* vfncvt.f.xu.v vd, vs2, vm # Convert double-width unsigned integer to float */
+THCALL(TH_OPFVV1, th_vfncvt_f_xu_v_h, NOP_UU_H, H2, H4, uint32_to_float16)
+THCALL(TH_OPFVV1, th_vfncvt_f_xu_v_w, NOP_UU_W, H4, H8, uint64_to_float32)
+GEN_TH_V_ENV(th_vfncvt_f_xu_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfncvt_f_xu_v_w, 4, 4, clearl_th)
+
+/* vfncvt.f.x.v vd, vs2, vm # Convert double-width integer to float. */
+THCALL(TH_OPFVV1, th_vfncvt_f_x_v_h, NOP_UU_H, H2, H4, int32_to_float16)
+THCALL(TH_OPFVV1, th_vfncvt_f_x_v_w, NOP_UU_W, H4, H8, int64_to_float32)
+GEN_TH_V_ENV(th_vfncvt_f_x_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfncvt_f_x_v_w, 4, 4, clearl_th)
+
+/* vfncvt.f.f.v vd, vs2, vm # Convert double float to single-width float. */
+static uint16_t vfncvtffv16(uint32_t a, float_status *s)
+{
+    return float32_to_float16(a, true, s);
+}
+
+THCALL(TH_OPFVV1, th_vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
+THCALL(TH_OPFVV1, th_vfncvt_f_f_v_w, NOP_UU_W, H4, H8, float64_to_float32)
+GEN_TH_V_ENV(th_vfncvt_f_f_v_h, 2, 2, clearh_th)
+GEN_TH_V_ENV(th_vfncvt_f_f_v_w, 4, 4, clearl_th)
-- 
2.44.0


