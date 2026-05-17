Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F5DCD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPl-0008Gu-PD; Sat, 16 May 2026 20:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOw-0007HX-8X
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOs-00058n-G1
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:37 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8027e876fcso372130a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977832; x=1779582632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dm33jZjik7glMCC+c/+qnvEzbGhxwqQSJMW0dasLBYQ=;
 b=v86Q4bWbD4s/fsq1v56uskYfxQ0NdP5PsNS7mjbuHEuttudMZZJyEtlrAEDz93Gy7V
 PP48PNmdE2ecwNKTxg7SNFuHHj/fS5Fk3mjhfTiaqun4yYHWzuj/hUedC6GsYi9lJXWI
 9LInkR1x3EpZ0eH5yfB+MGkhBt/mXQkpaRENB+NZBocqyzbD41Wnk7LYzh7cDE0vdRBR
 jl8V2fAEFjrb7BTmVbWY9px4/TOGpgZZsvFf+5NZw581S2htJyAEsI72p7tDTlpGPRWm
 JYYViHevtktPLB/GiZMHKw6antPHeWD8X8JgW889Gz7BMmRSNyyeIYJNbehiC50DYP9Y
 Tb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977832; x=1779582632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dm33jZjik7glMCC+c/+qnvEzbGhxwqQSJMW0dasLBYQ=;
 b=bysruejW+fvW1mB1w/ofIhVQMYUJbDgTnMtr9oMwkbl5dR8C9XVmKp4d0z54mMCLVb
 nwD3qweErulLtj9eDMJbOMzCtf8QnBh1zdhSWqTT9OosSVxJsxRxdJ6Pw5tGqeymlfYw
 1XwKsgehU8FZm4lip4f1nKqS3O45isP3ZedcpCVawA/8zp9Fp0aVeCUKw02hRmuLbg+B
 N3UPREZHe1pyZpgCo/dIJUMxnti7KYlueBGH1SRxt6U1S1Po908xiZBLUjo59GU3Swbg
 wOwI4MMLkMPmPd0UgQw/04R81ej3iEb6NpjYvCbESNk96d9QCbaySs01ttKnlyFON7Na
 fD7g==
X-Gm-Message-State: AOJu0YxLzg5hjZZLoEAiaU4HoH2Bn3YJS5MLYuSQZKCzdvJjU7mFMHQX
 AFWFpp6udbLlRZGKKj9wpzbjMidrBGarqBFrfGpUNM3cqqz1LO2HfPGILBWLbC64SBrrdF0LcRX
 YK+ck
X-Gm-Gg: Acq92OGt29iw2GrjOdhWGCLJj3Ee3qmybkB+OHPmzDrj948HtwYxoML8DUKu4RTmHXV
 hwImKqy4ppftsiNZ2HhlG30Cmnkeg8q9YMw29zAsl7jVpdRSpSY1YdzTe+/N+gFF7qeWEvDpBF4
 mr2B5x4ZtPpSf+F75Tb2rnXK+mUqwLF9L/dQZ5ij6hWVzqatpRBRKSTwuNaWzupJzK1PC4LFSUN
 QRTIXzqDZEe3ssnVgc0aC9gmxH6GoQrMbI79B0txZg8oomdOIXXjWDTTismuve9n05Ejhu/GNpa
 nw1H7SQ18Vuu317SFy0k+bGGvI7lE6JLYyrMq+km7nQmIHfivT+NwSemJ1N4svUZRr7BALjdb4O
 5NYslFSZPBPWJEYR73Aa9zrW+FXVfNH9UF5xHxNQSO39hzkiZfpS9mvSnWhzo7kCf8l7LhuFRPH
 UDZbV/oo7yHyg2JbvBTzrl1aE7UmJSQwrgXkIbGlIcBH874Ywhbg==
X-Received: by 2002:a05:6a00:1943:b0:838:af72:fb1f with SMTP id
 d2e1a72fcca58-83f33ba0ac9mr10563478b3a.2.1778977831772; 
 Sat, 16 May 2026 17:30:31 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 32/63] target/arm: Implement FCVTN,
 FCVTN2 (32- to 8-bit fp) for AdvSIMD
Date: Sat, 16 May 2026 17:29:31 -0700
Message-ID: <20260517003002.321430-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 33 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 16 ++++++++++++++++
 target/arm/tcg/a64.decode        |  1 +
 4 files changed, 52 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 6530d1a6da..023a49e12f 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,3 +16,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 95c37a037e..4689ffa88b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -190,6 +190,13 @@ static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
     return f8fmt(&p, scale, saturate, s);
 }
 
+static uint8_t fcvt_f32_to_fp8(float32 x, fcvt_fp8_output_fn *f8fmt,
+                               int scale, bool saturate, float_status *s)
+{
+    FloatParts64 p = float32_unpack_canonical(x, s);
+    return f8fmt(&p, scale, saturate, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -409,3 +416,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     fp8_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
+                             CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n = vn, *m = vm, scratch[4];
+    uint8_t *d = vd + 8 * ctx.high;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    if (vd == vm) {
+        m = memcpy(scratch, vm, 16);
+    }
+
+    for (size_t i = 0; i < 4; ++i) {
+        d[H1(i + 0)] = fcvt_f32_to_fp8(n[H4(i)], output_fmt,
+                                       ctx.scale, osc, &ctx.stat);
+    }
+    for (size_t i = 0; i < 4; ++i) {
+        d[H1(i + 4)] = fcvt_f32_to_fp8(m[H4(i)], output_fmt,
+                                       ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_finish(env, &ctx);
+    clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0927eb6516..3c784afc99 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6537,6 +6537,22 @@ static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
     return true;
 }
 
+static bool trans_FCVTN_bs(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, 16, vec_full_reg_size(s),
+                           (a->q << 1) | FPST_A64 << 2,
+                           gen_helper_advsimd_fcvt_bs);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 71456d44e1..a9cf259b9b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1202,6 +1202,7 @@ FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


