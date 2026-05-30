Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3ECD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrF-0008WC-3L; Sat, 30 May 2026 19:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrB-0008Sy-Go
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:41 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr9-0007Td-MV
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:41 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so1281690a91.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182758; x=1780787558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLZTWTNHQmgPXZ+6u4Ok/BrhLJw04DqdyqKLuC9WFEs=;
 b=u97Cevb5w8n/hw7Eo0nClQ8X4WmlCrTttnxuwbE4fov2iV+XU4+RW2GU51PedrERps
 f5L2Y2XSg2HdcGGIr7+wRxqarc/xMGAH6FCHVOtYh0BRgxUBCf3CoOcUyd6MxXhb/p2S
 XstqWSPDyVYsZ9rIdrqzYYEfqvvem0KhFPaC0V9Gbo5I1p+aXvxf1X3KnnXRUCaX7/gD
 hzhvGkbJ2G4DlqCDAYc2UVzCuJwWA6u+RU9a8VpoWdapMaMLEDkE9S0B8sW8sTscdS6r
 1fD8DHT4lKMkJCtGzrJuUqcn9/x6FXvpxQsvyYih3PaQdxsu7pTGiZqK1i+EY6Ymm7/z
 njYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182758; x=1780787558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YLZTWTNHQmgPXZ+6u4Ok/BrhLJw04DqdyqKLuC9WFEs=;
 b=MWl3jIMvSvMgjtPunbmTa/W0YCYnLpsvIh6UrcJ2CW4PybNcWHy0IUff4N04FdriMZ
 DubH/ngqtYQ3milhZx85XZSWi1O2edoMIfr3PGPDi6T2itcYLr/asXg9cj0S2h4mt90/
 Rv7Mo9JyQe8lPuuCQp5cAJiYAYrTjpjiHymBDDBGtG9QwMG9YLFT7wMVCWKF/0VJ8AcV
 i04Ap2jPrCk+aYFAllZeuGOsLoBD9O6ZnCrgLrZTHPIGMoyp2YPbeUnXauPEsMgqXNM4
 K5g8IeYw92C9slxlwqulQ3NemVWLEjl+2tDpOpK9QglVBX1jACOo51U3WmBGVblDAIdP
 q+SQ==
X-Gm-Message-State: AOJu0YxDge1yNUow0X2XifDLH403tofEQJMELX2adAxqYf3PRryOe1CD
 GfFyU9GzB5KNC3dDQcx8dVWhKENr9ENeLh8GKqa8zhiKaofOSQauQzr7L3AidaTVvglXmfXFoDi
 ITavno+c=
X-Gm-Gg: Acq92OHK/jFVW+Yyp7WZCeWPZYiUiF+mcIL0IR/i6gl9XMnyRZIPwW5nkkUjA/zyTTy
 6XcilbxXufSVyAZV2FhhtcYkM20HlUiD1ND+4oP2jrGNrHmNGnfMn8+Q0iv/tqpiiIozxjce34t
 VlabfSy9skbbjOCc7+pPTEIMJZ6DnJWJ8Tls26L1bPJOktyUqA6WbfcSdE5XkP+TedrGCq2d7vh
 W1FUc5Ckdw5p4AvwstmVNJ7Dn1qwEp9azATj9jACnpevL6C0bGzBwnK1bx9xMoMsQMsW9Cv5trw
 iS3aTYtWNFuyGqyO9MTupQaoGe+wHkLKXhHhi4MCbVqsT5tdHKcwybsCWsEYRcT+vrltgqmtLg/
 Rp9xvlzaietwTrM+bG4SGWLkaC1rNT+x2WnISgsFBQ+BopDOXGr5R7HGjiuzhsT7DIkpePVePQq
 wnsulWs/aPpyiwhC34UjAf3PMpmEYQnVLNjaK8sP3GiUMbJ9S2fw==
X-Received: by 2002:a17:90b:17ce:b0:36b:71e6:3de3 with SMTP id
 98e67ed59e1d1-36c4fef326amr4942485a91.3.1780182758033; 
 Sat, 30 May 2026 16:12:38 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 07/41] target/arm: Implement F1CVTL, F1CVTL2, F2CVTL,
 F2CVTL2 for AdvSIMD
Date: Sat, 30 May 2026 16:11:55 -0700
Message-ID: <20260530231229.400441-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 target/arm/tcg/fp8_helper.c      | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  3 +++
 target/arm/tcg/a64.decode        |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 966f83d796..718463422b 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -7,3 +7,5 @@ DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index aad03b0817..0f3c279696 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -103,6 +103,14 @@ static bfloat16 fcvt_fp8_to_b16(uint8_t x, fp8_input_fn *f8fmt,
     return bfloat16_round_pack_canonical(&p, s);
 }
 
+static float16 fcvt_fp8_to_f16(uint8_t x, fp8_input_fn *f8fmt,
+                               int scale, float_status *s)
+{
+    FloatParts64 p = f8fmt(x, s);
+    p = parts64_scalbn(&p, scale, s);
+    return float16_round_pack_canonical(&p, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -123,6 +131,27 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     clear_tail(vd, 16, simd_maxsz(desc));
 }
 
+void HELPER(advsimd_fcvtl_hb)(void *vd, void *vn,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn, scratch[16];
+    float16 *d = vd;
+
+    if (vd == vn) {
+        n = memcpy(scratch, vn, 16);
+    }
+    n += ctx.high * 8;
+
+    for (size_t i = 0; i < 8; ++i) {
+        d[H2(i)] = fcvt_fp8_to_f16(n[H1(i)], input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, 16, simd_maxsz(desc));
+}
+
 void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5c6e88e0bc..5266bbc413 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10726,6 +10726,9 @@ static bool do_f8cvt(DisasContext *s, arg_qrr_e *a,
     return true;
 }
 
+TRANS_FEAT(F1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, false)
+TRANS_FEAT(F2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, true)
+
 TRANS_FEAT(BF1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, false)
 TRANS_FEAT(BF2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, true)
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e30c7e5ca9..3c806259f9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1921,6 +1921,9 @@ URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
 FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
 
+F1CVTL          0.10 1110 001 00001 01111 0 ..... .....     @qrr_h
+F2CVTL          0.10 1110 011 00001 01111 0 ..... .....     @qrr_h
+
 BF1CVTL         0.10 1110 101 00001 01111 0 ..... .....     @qrr_h
 BF2CVTL         0.10 1110 111 00001 01111 0 ..... .....     @qrr_h
 
-- 
2.43.0


