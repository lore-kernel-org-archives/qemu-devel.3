Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5309FEE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZm6-0003T0-VL; Wed, 11 Sep 2024 22:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm2-0003B8-96
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm0-0004CU-6w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2057c6c57b5so2197135ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108891; x=1726713691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaMmQV0DItj/xJn2ESSKL4CE/7QS+SLFEQ94VIkslEw=;
 b=lL2yC71fWwD3qnBMR8uvr/9aRkWE0M3+qG0atQGh+OmKempzLHN2qzXeOc3OoS1ynZ
 xwJT8AbvtbvXD6TdVw+sszSu0jCwtcKnO/QR9y4aE3+f6FxuGXGF9bMqwGIKvFDn2vQ5
 i/MjHQBKqdM2Zzu4vO+YCmeoOjy3J8yR4ac4zdhQy17MJ835ysdTQ9kFkyBDwIEfydaD
 EvgSV9+OsKLbT+C+sBgLm305udUYJpaZr5mBf1AgXVCl6vpdzcTe6CuYbBMZNDcbx45s
 Vt1r/aisOz9pAi6lUJs5bg5dtlm6rZIDlWGW0eyiEgnIVjnOLILd2FRch9KiwjyjXpo5
 lEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108891; x=1726713691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaMmQV0DItj/xJn2ESSKL4CE/7QS+SLFEQ94VIkslEw=;
 b=KjjTaPitptgKscbYWO1gynpQDDNFRiX03uOKzYBRBMwtw12pRitwgHHFCmtlvQTwMM
 u+MDDAqSHAIdNTHea1SqX+qQlAPJJZoouVyAda11dHHI0ap4dqx4LhB3y+WpOlOH34Zn
 wrtW8ULHH688T4PrP5XyB1HkyhSOz812YUiIUqC7vAz0vkDyYi1Q9yYajFmWcdBEoe20
 6FOhom2WQTzlu1ukq+yx42g98RuDLSpkw77mVE5SVir+lFjQzzul5Ycd21fKVF/8tvX0
 G7VXJ2o6h76cjQYDFIW2Q2eJM/V8m7w52BkZTQzoMWSUIiZPfOci07BiWZmRh2A3tVbi
 ixtA==
X-Gm-Message-State: AOJu0YyuriIvLcFjR6rDwo3MfR/xbd+6XGBpdE05sr9lKBSPuYvMJrX3
 Dy59WK4uXTZuEqiB1H4nEKYuqRVdbEs9qMObiCBRL0McFCkw1Y45JHBigtAK6uEp9zHhX3q+AwW
 Z
X-Google-Smtp-Source: AGHT+IEAc6AB36RK+XFgnKU8uIMCgAawgTouWbCPOGM3QwfFSVC9tWqoca9M5Lrq9EZL03qDJAPJwA==
X-Received: by 2002:a17:903:2345:b0:205:76c1:3742 with SMTP id
 d9443c01a7336-2076e551052mr17353805ad.3.1726108890649; 
 Wed, 11 Sep 2024 19:41:30 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 16/29] target/arm: Convert handle_vec_simd_shri to
 decodetree
Date: Wed, 11 Sep 2024 19:41:01 -0700
Message-ID: <20240912024114.1097832-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

This includes SSHR, USHR, SSRA, USRA, SRSHR, URSHR, SRSRA, URSRA, SRI.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 86 +++++++++++-----------------------
 target/arm/tcg/a64.decode      | 63 ++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 60 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 032bd33650..5c76cdf101 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6959,6 +6959,28 @@ static bool trans_Vimm(DisasContext *s, arg_Vimm *a)
     return true;
 }
 
+/*
+ * Advanced SIMD Shift by Immediate
+ */
+
+static bool do_vec_shift_imm(DisasContext *s, arg_qrri_e *a, GVecGen2iFn *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_fn2i(s, a->q, a->rd, a->rn, a->imm, fn, a->esz);
+    }
+    return true;
+}
+
+TRANS(SSHR_v, do_vec_shift_imm, a, gen_gvec_sshr)
+TRANS(USHR_v, do_vec_shift_imm, a, gen_gvec_ushr)
+TRANS(SSRA_v, do_vec_shift_imm, a, gen_gvec_ssra)
+TRANS(USRA_v, do_vec_shift_imm, a, gen_gvec_usra)
+TRANS(SRSHR_v, do_vec_shift_imm, a, gen_gvec_srshr)
+TRANS(URSHR_v, do_vec_shift_imm, a, gen_gvec_urshr)
+TRANS(SRSRA_v, do_vec_shift_imm, a, gen_gvec_srsra)
+TRANS(URSRA_v, do_vec_shift_imm, a, gen_gvec_ursra)
+TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10423,53 +10445,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SSHR[RA]/USHR[RA] - Vector shift right (optional rounding/accumulate) */
-static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = 2 * (8 << size) - immhb;
-    GVecGen2iFn *gvec_fn;
-
-    if (extract32(immh, 3, 1) && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
-    tcg_debug_assert(size <= 3);
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0x02: /* SSRA / USRA (accumulate) */
-        gvec_fn = is_u ? gen_gvec_usra : gen_gvec_ssra;
-        break;
-
-    case 0x08: /* SRI */
-        gvec_fn = gen_gvec_sri;
-        break;
-
-    case 0x00: /* SSHR / USHR */
-        gvec_fn = is_u ? gen_gvec_ushr : gen_gvec_sshr;
-        break;
-
-    case 0x04: /* SRSHR / URSHR (rounding) */
-        gvec_fn = is_u ? gen_gvec_urshr : gen_gvec_srshr;
-        break;
-
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        gvec_fn = is_u ? gen_gvec_ursra : gen_gvec_srsra;
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
-    gen_gvec_fn2i(s, is_q, rd, rn, shift, gvec_fn, size);
-}
-
 /* SHL/SLI - Vector shift left */
 static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
                                  int immh, int immb, int opcode, int rn, int rd)
@@ -10610,18 +10585,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x08: /* SRI */
-        if (!is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x00: /* SSHR / USHR */
-    case 0x02: /* SSRA / USRA (accumulate) */
-    case 0x04: /* SRSHR / URSHR (rounding) */
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        handle_vec_simd_shri(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x0a: /* SHL / SLI */
         handle_vec_simd_shli(s, is_q, is_u, immh, immb, opcode, rn, rd);
         break;
@@ -10660,6 +10623,11 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_fpint_conv(s, false, is_q, is_u, immh, immb, rn, rd);
         return;
     default:
+    case 0x00: /* SSHR / USHR */
+    case 0x02: /* SSRA / USRA (accumulate) */
+    case 0x04: /* SRSHR / URSHR (rounding) */
+    case 0x06: /* SRSRA / URSRA (accum + rounding) */
+    case 0x08: /* SRI */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 278d7873c2..74ba1fa07c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -34,6 +34,7 @@
 &rrx_e          rd rn rm idx esz
 &rrrr_e         rd rn rm ra esz
 &qrr_e          q rd rn esz
+&qrri_e         q rd rn imm esz
 &qrrr_e         q rd rn rm esz
 &qrrx_e         q rd rn rm idx esz
 &qrrrr_e        q rd rn rm ra esz
@@ -1185,11 +1186,71 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
 
-# Advanced SIMD Modified Immediate
+# Advanced SIMD Modified Immediate / Shift by Immediate
 
 %abcdefgh       16:3 5:5
 
+# Right shifts are encoded as N - shift, where N is the element size in bits.
+%neon_rshift_i6 16:6 !function=rsub_64
+%neon_rshift_i5 16:5 !function=rsub_32
+%neon_rshift_i4 16:4 !function=rsub_16
+%neon_rshift_i3 16:3 !function=rsub_8
+
+@q_shri_b       . q:1 .. ..... 0001 ... ..... . rn:5 rd:5   \
+                &qrri_e esz=0 imm=%neon_rshift_i3
+@q_shri_h       . q:1 .. ..... 001 .... ..... . rn:5 rd:5   \
+                &qrri_e esz=1 imm=%neon_rshift_i4
+@q_shri_s       . q:1 .. ..... 01 ..... ..... . rn:5 rd:5   \
+                &qrri_e esz=2 imm=%neon_rshift_i5
+@q_shri_d       . 1 .. ..... 1 ...... ..... . rn:5 rd:5     \
+                &qrri_e esz=3 imm=%neon_rshift_i6 q=1
+
 FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
 
 # MOVI, MVNI, ORR, BIC, FMOV are all intermixed via cmode.
 Vimm            0 q:1 op:1 0 1111 00000 ... cmode:4 01 ..... rd:5 %abcdefgh
+
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_b
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_h
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_s
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_d
+
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_b
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_h
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_s
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_d
+
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_b
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_h
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_s
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_d
+
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_b
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_h
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_s
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_d
+
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_b
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_h
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_s
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_d
+
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_b
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_h
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_s
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_d
+
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_b
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_h
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_s
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_d
+
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_b
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_h
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_s
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_d
+
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_b
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_h
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_s
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_d
-- 
2.43.0


