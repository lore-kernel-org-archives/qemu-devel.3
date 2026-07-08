Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C2BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzg-00016W-G6; Wed, 08 Jul 2026 12:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUze-00015Y-KA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzb-0006zF-4A
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso9794415ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527562; x=1784132362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h28akbz6f9qvZJ7vZ2QSjhKAHqinsgLeTG+Wx27cvBM=;
 b=QnsvYvCl22O7clL53e5ZBW7Pw6CvMyGCnnpyN2X0ectztf5kLZPxPQMUIuDhEQAdGE
 u03U6WwkWoBgMta9KVKpHaUoY+3U0B2g2Y0xkOku+6VmNa8YEGqQyqtpn2quh7RgoS8g
 +ixlpKqM6zBHeNywxRMco9inO0cTMcnzFQCPyORgU8SVzLfpKxQVCXr6CxMah6cVX9vY
 HwujWx+rcBmjj60ILnE1AMVOJapsC8RS8HpKgcytTXT6+gfbbLxT8LbmDwwp908gcWmC
 mBEpIn3otvpb6Bnji08aq60c8vfMPKcArCtj7yTaBZ7BekZWI8OMrHUgbOWZRkCxaBdn
 dXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527562; x=1784132362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h28akbz6f9qvZJ7vZ2QSjhKAHqinsgLeTG+Wx27cvBM=;
 b=J9b8ZVSHEjx4ZDU3kg3WBUeRMfOiyOpNZJb4ZhD0GuEYfZlYReOxG9O1r3e/nxMCvO
 PPpprkYvl7g1svntW3gVRX9ScBPOOV80OD8LA2lnip2oWDn3Kg/UIuK5DfyjQSINY9k5
 WHOKceURhcrsWCzOQPgpesmxukUFU5OKgQjTF2Jr1iG0pD0tMOxDFioDhVqn8EUCwgv3
 aDRBTL1+PI7VD5/qBl83squR3L34SlyScj0DjpyGpnqmRkDYDDS53fT903yyGJ9z1Qmn
 v2r5JZosNjqO5uNRWXXETwkIU4OfizRx4JhADc3cr7diqNDZDF/Ix/1B2V7ICQVx80bX
 S5Gg==
X-Gm-Message-State: AOJu0YxMM8+JnnMoZaQV1cuQ6MzNa7gSMNoQli5GFhi3ke37FWzjcVFh
 fQEMB3Erz/dgHSJwmHfHuc/KBzXyVuclm32+Phh52Zq7scPNXf1nmOT3jLJZe77hfi/QvFH7PKn
 WzFAZSoRAJ7Aq2M9kmC1KUYEapnULAu6T/ms5usEQLESPjyxq8tmgZ/LHxKheqn+f3u658g+uzm
 ze8h1Gmju/rOHFFJ3VEEusogw/b37QtIUjEv00bsY=
X-Gm-Gg: AfdE7clcbv5KLe0o5Ji3Xap7mL/0i/ggIyWsLt1Jc974FL1MDZD9C7JAlgbnklPaB+r
 QaD5QwnEIAJopkwhcd9Orm1jHOwTxVJyB/B5yVyWRYrjDdQPwMxWpAB3JOS8i+mqRPy/HEz6fPv
 bZwc5QokPsfsKJnw8MrPNEUlN+T94HXCd7nb8NXQjXL4hhjDfd7b/vp8PsSFfFqKpAtSf9uV3ga
 5X1bakDTCER3+iEFljLdi+FlmwM97rqR2IngqEnkGE0Il1n45Ews6jZSNpfMPEuRpTjFrQko4Ea
 bBPIQfNa8OoWCPpBlnpFhcfNlgn1Qa0gLDSdK/mGVvLxH0yYFKnZp0M2oNpz/6vFA77/rMRS+bx
 RW9lJbST1zl581mADJUhSH4t5bevz/TK64ICS2Ssh1HK4YJm1tdEUZ1pUnjU07AWZ4y2PXRiwmC
 +wYIxJgEKxjnHiBjTggPVhLBxiaybpukcr1vFK5PiNo4wWpcXWeMKFF1krDyQeGX7Jsv51cepxI
 P1FZv+yr2+AvIBZ
X-Received: by 2002:a17:903:947:b0:2ca:d463:27fc with SMTP id
 d9443c01a7336-2ccea4604fcmr33107215ad.45.1783527561570; 
 Wed, 08 Jul 2026 09:19:21 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:21 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 5/9] target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8
 to BF16 conversion for Zvfofp8min extension
Date: Thu,  9 Jul 2026 00:18:55 +0800
Message-ID: <20260708161859.1124848-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/riscv/cpu.c                            |   1 +
 target/riscv/helper.h                         |  12 ++
 .../riscv/tcg/insn_trans/trans_rvbf16.c.inc   |  16 ++-
 target/riscv/tcg/vector_helper.c              | 115 +++++++++++++++++-
 4 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8cd1a5e056..1cc5f33d63 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1076,6 +1076,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     set_default_nan_mode(1, &env->fp_status);
     /* Default NaN value: sign bit clear, frac msb set */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
+    set_float_e4m3_nan_is_snan(false, &env->fp_status);
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 542b7c264f..3a2d692f9e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1253,6 +1253,18 @@ DEF_HELPER_5(vfwcvtbf16_f_f_v, void, ptr, ptr, ptr, env, i32)
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
diff --git a/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc b/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
index 066dc364c5..86eb86f615 100644
--- a/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
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
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 6b736948ff..306bda7951 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -88,7 +88,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
 
     switch (vsew) {
     case MO_8:
-        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa || cpu->cfg.ext_zvfofp8min);
         break;
     case MO_16:
         ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
@@ -5071,6 +5071,119 @@ GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4)
 RVVCALL(OPFVV1, vfncvtbf16_f_f_w, NOP_UU_H, H2, H4, float32_to_bfloat16)
 GEN_VEXT_V_ENV(vfncvtbf16_f_f_w, 2)
 
+/*
+ * Initialize a local float_status for OCP FP8 narrowing conversions with
+ * RISC-V specific NaN handling: default_nan_pattern = 0x70 produces the
+ * canonical OCP FP8 NaN payload (0x7F) for both E4M3 and E5M2 in default-NaN
+ * mode, per the Zvfofp8min specification.
+ */
+static inline void riscv_ofp8_narrow_status_init(float_status *local,
+                                                 float_status *s)
+{
+    *local = *s;
+    local->default_nan_pattern = 0x70;
+}
+
+/*
+ * OCP FP8 Narrowing Conversions (BF16/F32 -> FP8)
+ * 1. Initialize a local float_status with RISC-V specific NaN handling
+ * 2. Call the softfloat conversion function with saturation parameter
+ * 3. Force the canonical NaN to 0x7f for non-saturating overflow. Per
+ *    Zvfofp8min, the canonical NaN for both E4M3 and E5M2 is 0x7f.
+ * 4. Merge exception flags back to the original status
+ */
+#define GEN_OCP_FP8_NARROW(NAME, CONVERT_FN, SATURATE, IN_TYPE)  \
+static uint8_t NAME(IN_TYPE a, float_status *s)                  \
+{                                                                \
+    float_status local;                                          \
+    riscv_ofp8_narrow_status_init(&local, s);                    \
+    uint8_t result = CONVERT_FN(a, SATURATE, &local);            \
+    if (!(SATURATE) && result == 0xff) {                         \
+        result = 0x7f;                                           \
+    }                                                            \
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
+ * 1. Copy float_status into a local so exception flags can be discarded
+ * 2. Call the softfloat conversion function
+ * 3. Intentionally DISCARD exception flags (not merged back)
+ */
+#define GEN_OCP_FP8_WIDEN(NAME, CONVERT_FN)      \
+static uint16_t NAME(uint8_t a, float_status *s) \
+{                                                \
+    float_status local = *s;                     \
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
2.55.0


