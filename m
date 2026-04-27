Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10ACFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAU-0005lY-FN; Mon, 27 Apr 2026 02:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAG-0005SO-QT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAE-0000sW-MX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:52 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35d95017a68so6455440a91.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270189; x=1777874989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KX+3SOCuQUbPEu/VIUduN2Znq88BG6/CnPypiQ0pEP4=;
 b=MGosBwi2+Ke20sKONBrS16Q4ogfJPu0FROmJnXFdcnbgaWqcg0KT3N8GtqCNzn9qGf
 3hIkZ9LkuI6plbSnPi02KNBaE4fyfQ+M6MXAl8IKpPTCWtJ7Lk9iqF91oKx0v96aKPhW
 gD/2EYYxIr8b4rrIrp/GdqRBxOT4AqOHBYE24pGR4VE1xTdgU2OJlobgYz6FzgD/9IQX
 ogj58GMgkuzxVeQ4G6NpmH6wighUYOXwEyAeSEPigDMtn/Dzp+qh9WsO0PzrrI0uEI8j
 umWPhvDu4KC6PekSnjU+gwDCkTwmJFxQhuUm0LtGeFdJ30rabWY8krofLYhCn+M22pLS
 vFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270189; x=1777874989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KX+3SOCuQUbPEu/VIUduN2Znq88BG6/CnPypiQ0pEP4=;
 b=f+7yZMBoxVRXmEexnlu/GuY0JoGvwM5WKutrVfLARZlh8x1v8yfWuMjhuo//3+cNDo
 2dLKnFM9gqdxovGt88PjTV3H7sHan4mW49Ac3U7XiAhC01X8TRZF38m0Q8Orv5RvH/d4
 as62wZEq8ail3cQDjluCG52sNYwN/4zvYvb6ost35X7OE39ldFig6/VwbeNqY8jv19KU
 a2/qZJprlCCS/BUHxUthcg9BS2lFuXQt6MZjvYpSkws8S+FlZofhPwKyDj9Rkb20m4EU
 +fXu0zWo0i8CywYUXoTV78q1d0pj28PBt8aGTGXCSLCdXniLJgKsJlPdSxvDMGBlbFZF
 mW8Q==
X-Gm-Message-State: AOJu0Yzfp3NWahZ03T8+oG9lc1TT/YMdoCuZ6bhNXy+n/R2PjO0femiu
 FuPUIaC8GJv0nbQuvcqCmHAvnHrqG4jltxwX5c7J4WkWfcRqqKX4f6kbmGkY1V5G7EPeF745j8E
 ooPocoGBuePTg1tCjE9mylp/x10qamoOYIpOwATL/uNhEWb6+pPX/7eeSp3DMBYK/SpBak/X6o+
 wA/hxTASZm2nL+NDIXwgpC06ozXJYLSHlepfP7Epo=
X-Gm-Gg: AeBDievgw3FIJsOy14ROtsna6UqfTlkAs0+feJKh+VEWnRvXM0lOgWm2Qky0zbSA+pM
 4t47fhT0NeWrunlnqYHtO/l6tFTs0S+4wqG7eh3iqO5ZKTOlnGU//rOpvn9NmeADq1OuzACKJvN
 e45TqSCgL2PW5IJNxKC6Cc3wTH7bS5TYnQlckSqnNhReLYsWLFeDW+bpOAkFmFBSpkcozWmjfJ6
 QKAd9JMFVSXgKIIr0Gis83s7UZzELJziyFygVT9T8Te0zZn3yTrZBdCjYPqJ5Jl2pYAKaD6CavG
 t5UavHkDy2aotkgP3gFlME8IvZrVTO6qFoJ5CsKgqYFlRIhZzL57/I+YAh3ahxDI/sTGmDrHQ8z
 K934rPpIiBUZAQmJr+HW2cjXOqWhK0qa2/e5f4SBZuLYmSeLLOj/J+Ty2F9vFP636XOWDaoO7pW
 sCCWee0UakAMsQisQzcRWYQs00uVGynGKot3ZcKgNEO4fz2bo0Px+XAMSJFB5DE7U4U2GrmxneT
 7rkklpP/uvjgcjTG2rA7lHKFy0VxQztYt0yGA==
X-Received: by 2002:a17:90b:3882:b0:361:3224:2f5f with SMTP id
 98e67ed59e1d1-3614049c8a4mr46151622a91.22.1777270188700; 
 Sun, 26 Apr 2026 23:09:48 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:48 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 4/9] target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8
 to BF16 conversion for Zvfofp8min extension
Date: Mon, 27 Apr 2026 14:09:23 +0800
Message-ID: <20260427060928.2322570-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the Zvfofp8min extension, the vfwcvtbf16.f.f.v instruction
supports OFP8 to BF16 conversion when SEW is 8.
And the VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: OFP8.e4m3 to BF16
* altfmt = 1: OFP8.e5m2 to BF16

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                      | 12 +++
 target/riscv/insn_trans/trans_rvbf16.c.inc | 16 +++-
 target/riscv/vector_helper.c               | 99 +++++++++++++++++++++-
 3 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 54d2331966..508314e154 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1249,6 +1249,18 @@ DEF_HELPER_5(vfwcvtbf16_f_f_v, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmaccbf16_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmaccbf16_vf, void, ptr, ptr, i64, ptr, env, i32)
 
+/* OFP8 functions */
+DEF_HELPER_5(vfwcvtbf16_f_f_v_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvtbf16_f_f_v_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_f_f_w_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_f_f_w_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_sat_f_f_w_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_sat_f_f_w_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+
 /* Vector crypto functions */
 DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 066dc364c5..86eb86f615 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -92,11 +92,20 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZVFBFMIN(ctx);
 
-    if (opfv_widen_check(ctx, a) && (ctx->sew == MO_16)) {
+    if (opfv_widen_check(ctx, a) &&
+        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
+         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
+        gen_helper_gvec_3_ptr *fn;
         uint32_t data = 0;
 
+        if (ctx->sew == MO_16) {
+            fn = gen_helper_vfwcvtbf16_f_f_v;
+        } else {
+            fn = ctx->altfmt ? gen_helper_vfwcvtbf16_f_f_v_ofp8e5m2 :
+                               gen_helper_vfwcvtbf16_f_f_v_ofp8e4m3;
+        }
+
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -106,8 +115,7 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
                            ctx->cfg_ptr->vlenb,
-                           ctx->cfg_ptr->vlenb, data,
-                           gen_helper_vfwcvtbf16_f_f_v);
+                           ctx->cfg_ptr->vlenb, data, fn);
         finalize_rvv_inst(ctx);
         return true;
     }
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 73437c1d20..e7925f387b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -89,7 +89,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
 
     switch (vsew) {
     case MO_8:
-        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa || cpu->cfg.ext_zvfofp8min);
         break;
     case MO_16:
         ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
@@ -5025,6 +5025,103 @@ GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4)
 RVVCALL(OPFVV1, vfncvtbf16_f_f_w, NOP_UU_H, H2, H4, float32_to_bfloat16)
 GEN_VEXT_V_ENV(vfncvtbf16_f_f_w, 2)
 
+/*
+ * OCP FP8 Narrowing Conversions (BF16/F32 -> FP8)
+ * 1. Initialize a local float_status with RISC-V specific NaN handling
+ * 2. Call the softfloat conversion function with saturation parameter
+ * 3. Merge exception flags back to the original status
+ */
+#define GEN_OCP_FP8_NARROW(NAME, CONVERT_FN, SATURATE, IN_TYPE)  \
+static uint8_t NAME(IN_TYPE a, float_status *s)                  \
+{                                                                \
+    float_status local = *s;                                     \
+    local.default_nan_pattern = 0x70;                            \
+    local.default_nan_mode = true;                               \
+    uint8_t result = CONVERT_FN(a, SATURATE, &local);            \
+    s->float_exception_flags |= local.float_exception_flags;     \
+    return result;                                               \
+}
+
+/* BF16 -> E4M3/E5M2 conversions */
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e4m3, bfloat16_to_float8_e4m3, false,
+                   uint16_t)
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e5m2, bfloat16_to_float8_e5m2, false,
+                   uint16_t)
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e4m3_sat, bfloat16_to_float8_e4m3, true,
+                   uint16_t)
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e5m2_sat, bfloat16_to_float8_e5m2, true,
+                   uint16_t)
+
+/* F32 -> E4M3/E5M2 conversions */
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e4m3, float32_to_float8_e4m3, false, uint32_t)
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e5m2, float32_to_float8_e5m2, false, uint32_t)
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e4m3_sat, float32_to_float8_e4m3, true,
+                   uint32_t)
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e5m2_sat, float32_to_float8_e5m2, true,
+                   uint32_t)
+
+/*
+ * OCP FP8 Widening Conversions (FP8 -> BF16)
+ * According to Zvfofp8min isa specification: "No rounding occurs, and no
+ * floating-point exception flags are set."
+ * 1. Initialize a local float_status with no_signaling_nans=true
+ * 2. Call the softfloat conversion function
+ * 3. Intentionally DISCARD exception flags (not merged back)
+ */
+#define GEN_OCP_FP8_WIDEN(NAME, CONVERT_FN)      \
+static uint16_t NAME(uint8_t a, float_status *s) \
+{                                                \
+    float_status local = *s;                     \
+    local.no_signaling_nans = true;              \
+    return CONVERT_FN(a, &local);                \
+}
+
+GEN_OCP_FP8_WIDEN(vfwcvt_e4m3_to_bf16, float8_e4m3_to_bfloat16)
+GEN_OCP_FP8_WIDEN(vfwcvt_e5m2_to_bf16, float8_e5m2_to_bfloat16)
+
+/* vfwcvtbf16.f.f.w vd, vs2, vm # Convert OFP8 to BF16. */
+RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e4m3, WOP_UU_B, H2, H1,
+        vfwcvt_e4m3_to_bf16)
+RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e5m2, WOP_UU_B, H2, H1,
+        vfwcvt_e5m2_to_bf16)
+GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v_ofp8e4m3, 2)
+GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v_ofp8e5m2, 2)
+
+/* vfncvtbf16.f.f.w vd, vs2, vm # Convert BF16 to OFP8 without saturation. */
+RVVCALL(OPFVV1, vfncvtbf16_f_f_w_ofp8e4m3, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e4m3)
+RVVCALL(OPFVV1, vfncvtbf16_f_f_w_ofp8e5m2, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e5m2)
+GEN_VEXT_V_ENV(vfncvtbf16_f_f_w_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvtbf16_f_f_w_ofp8e5m2, 1)
+
+/* vfncvtbf16.sat.f.f.w vd, vs2, vm # Convert BF16 to OFP8 with saturation. */
+RVVCALL(OPFVV1, vfncvtbf16_sat_f_f_w_ofp8e4m3, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e4m3_sat)
+RVVCALL(OPFVV1, vfncvtbf16_sat_f_f_w_ofp8e5m2, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e5m2_sat)
+GEN_VEXT_V_ENV(vfncvtbf16_sat_f_f_w_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvtbf16_sat_f_f_w_ofp8e5m2, 1)
+
+/* Quad-width narrowing type for FP32 to OFP8 */
+#define QOP_UU_B uint8_t, uint32_t, uint32_t
+
+/* vfncvt.f.f.q vd, vs2, vm # Convert FP32 to OFP8. */
+RVVCALL(OPFVV1, vfncvt_f_f_q_ofp8e4m3, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e4m3)
+RVVCALL(OPFVV1, vfncvt_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e5m2)
+GEN_VEXT_V_ENV(vfncvt_f_f_q_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvt_f_f_q_ofp8e5m2, 1)
+
+/* vfncvt.sat.f.f.q vd, vs2, vm # Convert FP32 to OFP8 with saturation. */
+RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e4m3, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e4m3_sat)
+RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e5m2_sat)
+GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
+
 /*
  * Vector Reduction Operations
  */
-- 
2.52.0


