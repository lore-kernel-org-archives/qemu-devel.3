Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F0ECD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZQ-00083V-3o; Wed, 20 May 2026 14:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZJ-0007kK-9W
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ9-0000f2-2Q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c7b9f54d3deso4409391a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301358; x=1779906158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKX5BX/1+tQjNeYVGuKedeMI/pvj+HWD9eF0Xwk36ls=;
 b=rCNkeov6g1bpWjR/Gq6lu6pKGFmKb1pfYYV7WLR4XzMsWaa+1XWuxgjM80PPaBXy/1
 Cr3xXIv0Yk16KJR+zLY5RlBpa8XlRwCydXdXhdDzL2PD+piqqXg/f289+hUKpgUFw5/B
 m6IOP4fuCYDM0TrZBtNNkgYxsu/e3ERj1X6sCZ5X2PXrjixuKoz4eGj467+OWn37QyI8
 f98FgVYC7efHaRHAhDAbnYa/2KNCdEFRqKT5td3z5MTWg3H4IRJE8Korn/vOmIRvc5ee
 LBh41rxrp6YHDDL6/pb6mECIGT912XU8BgzvJU1CcIueaNJ1yOFdtI9pEFFSMd+rZDGW
 gzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301358; x=1779906158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKX5BX/1+tQjNeYVGuKedeMI/pvj+HWD9eF0Xwk36ls=;
 b=G7EVMmBNKZVphYcVPSZshbd+SGiENgb0REoyrIF+wLMDXW3BXBqe9wpJtmBi7LjcIY
 CTo5nuBuPCJxGslzH8mQsuZo7wcWXivvjzLID8VcK16OtPv5bEWlYCc/YjjJKKXX7G7n
 iAD7xbRS5dCUSGuA+7do7GOxDcbXsIkq4phymNtdzlybrAM2BOkHupZ20n6LNXHRj9Md
 EcqT5q41gB0kblfBXY3oOeXct+7VpURgVqJ4voXWCSJ/jzYAGGh82myKdhhUKoWOA6Vn
 Hwf96/ijo/Wq9v+H4vUA6j3OnWRi3UgDfPmEQUThrZAk1mqsbGZnokHZukqtC7H9CUBW
 dcxw==
X-Gm-Message-State: AOJu0YwX7h7snPJmbB4LhMb30gsr1wwJMDlyaYiaNWxGg61T+8OCJ0jw
 l7Aplw+J9JdKgYvZdWgZVPmIQdGXvCdSkJVqbpAiZxQNwqgLDfQf97rSj8tntTSH+jhN6CycaOo
 M8QmIJfA=
X-Gm-Gg: Acq92OE/3LDVqA0rNNOWJ0FfNuZ9x2VO4S+9J2vgHAKl1W+4TELj6MKPsvGwkA+74ly
 bnhUAveUBhHkeBuuaXwU5QmuR6MU22EjaP+wEHYHiFUJadAr8qnUXhsb+w9nyrtc5l/d/xDxf4Z
 XBTrp2pTFT+TpUL5CFOTLhc8mxocYAT2lJKjUtNrLCt3NP7NQ6G8mC47F7cJfM8T/dwr3hz2lw0
 yBMsvaEYdaQi1pOr+OP6t/YC4oQLO2rxRqmPFtNjA6u9tFZBG/c91Ol+GuJWyRdHhq+IYcG2+Q9
 9+3SgjKbI6ztiwoOAww5RGokygqqPdkJFUIyBG7tAbSR/3No+Zvu4+WRqoC65jUo6bEIn857n3F
 4Nr9LEeZMzleFFHuWdIo9tUwEFspDccTHkbcpwx7aPSn5Zq06/BKcQ9o7q4hMBHbsgKyuUZsxY5
 OsiZ+jIgHxCwoPatdHYYogsZc8DGDH
X-Received: by 2002:a17:90b:5848:b0:368:7c0f:ebf7 with SMTP id
 98e67ed59e1d1-36951b75c6fmr23973538a91.16.1779301357594; 
 Wed, 20 May 2026 11:22:37 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 33/64] target/arm: Implement FCVTN,
 FCVTN2 (32- to 8-bit fp) for AdvSIMD
Date: Wed, 20 May 2026 11:21:42 -0700
Message-ID: <20260520182213.872945-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
index a8337a8fb7..f6b3eb6953 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -188,6 +188,13 @@ static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
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
@@ -407,3 +414,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     fp8_cvt_finish(env, &ctx);
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
+    fp8_cvt_finish(env, &ctx);
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


