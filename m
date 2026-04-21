Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A0F55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Sg-0000Yu-3S; Tue, 21 Apr 2026 01:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rw-0008Hm-OJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Ru-0006gP-IK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2adff872068so17895925ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748501; x=1777353301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMcr01u60LrCES988dBDvl79mkeVcUNH9ZYKZAUuh5E=;
 b=WUiXqLJorFqDg+oR9aUZPOfyl6+BfI8dJ7lj+XkxzLUtQiBWyjSmOqhqRb0E5oZJQB
 gBbuF2AkOPXJdy9wu9uXptogqCEYWp9YPgf7pJDrbjhtI8xnClLPxhbyMQ0WazHEuNTh
 8c7hdmE+bm9T46LghN3g82myImXBvLo4NcUWMESLzpDSw2xf0y+W4NNN4Dam6z+3qw8G
 HIFH9WS4/cmTky0VZWzcDbQU+uoUa45n+C2g7ilf2RqmQFwSI0hTlNLHwKG/xkj6W+53
 Jj+Cxvbb8MQ7w1QvPzklXrr3zyIRpCMPmH257tHcTE/tFSoLrcUn/nVL0hl4OwuU85PQ
 hGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748501; x=1777353301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMcr01u60LrCES988dBDvl79mkeVcUNH9ZYKZAUuh5E=;
 b=KWmbErCVr6fqe1m8tUhwW3uhsG6VTub+0QQ2gOLztV9FAWLeMCu0vG9rTq/vZUeHSk
 dIacg6+QNWBnOHk2vL5xKFjINqCHoYD8UI5l31HPSRUz4Hw4zx/CkqfGcn0+ak59M6r6
 2FZdoDxt7zOcnc8zflyBF5UhCxvKws5R0/O0rJqcpQXKn45rQTNupwVtTFuzfPZg6PRP
 WXlxvNfIb4XhKcCarR1UjZwy08e8WlpPeCsSCoS1W2vV8+dpOC7UtJeLklNRGDJm3CTy
 fCmcG5ehKeNxzjaP2jTsQ09XrJgP0dXbOj8mxFK8RU0npZA8CvaK+Til5IW6z6jg0wnU
 JrLw==
X-Gm-Message-State: AOJu0Yye8RL7qh4y+ZNz3+9I6AwyG3umnEdrFDaBcbBuRg2r2vcnZdHo
 L1ng/02i9x+aGKQGa/Adn1kQRgOIZ6MHVZLKAvvI4J82Xp61HdxKWS4B64G6LMFJQLa3gge3t1Q
 HELQxXfY=
X-Gm-Gg: AeBDietyZPO61oo0C7FSxTYZXMH80EvT25WQ6B0+sPC7PABcNWB9fFU2UVl8s9vdRcK
 JocYSd9mHNosmJyIb2bdCfehw2pgvpEYLJBVraQ6BY1OIrzHyqVSe5p7QJ1XLC9URB9tXTsTI7i
 G0rUXTpCVIzznCbrsDAkPQr8mrXcuwS7IcJ0vFHR1tSSiLNmfMvXLRjOmEeexdSFNF7l2BI2Qyq
 2BxSpxSNm/DPEzlQdghaunG28q551l/cdNgy7JyuWG+1Cie6ArJVn6j3GqeOPJLMsQ9AFzECC7I
 hdy5r952tsKaXomXlgKouO5a6Q+OKwHKmBUx53vatcAN/lfz9XUjZLAhDdiW8fgSncACNCHAIpi
 IXg5tMM/suNg1lc6BOQx4pamnI8aGZGBsfVSASsOVi+TWB1XEsRyS+IaR3rtIRR/LIrFLKx18Ek
 CgzXCKl5b2/1rdMzJU92BbHtARwp92G2xKm3r3O6SS
X-Received: by 2002:a17:902:e746:b0:2ae:504c:ae8a with SMTP id
 d9443c01a7336-2b5f9f08601mr209357905ad.16.1776748500949; 
 Mon, 20 Apr 2026 22:15:00 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:15:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 29/37] target/arm: Implement F1CVT, F1CVTL, F2CVT,
 F2CVTL for SME
Date: Tue, 21 Apr 2026 15:13:38 +1000
Message-ID: <20260421051346.41106-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 +
 target/arm/tcg/fp8_helper.c      | 79 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  5 ++
 target/arm/tcg/sme.decode        |  5 ++
 4 files changed, 91 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3021dafd44..b5dc2b7064 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -10,3 +10,5 @@ DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 32c7a82647..2b1955508d 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -264,6 +264,50 @@ void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
 }
 
+void HELPER(sme2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vectors_overlap(vd, 2, vn, 1)) {
+        n = memcpy(&scratch, vn, oprsz);
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i)];
+            d0[H2(i)] = float8_e5m2_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i) + nelem];
+            d1[H2(i)] = float8_e5m2_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i)];
+            d0[H2(i)] = float8_e4m3_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i) + nelem];
+            d1[H2(i)] = float8_e4m3_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -298,3 +342,38 @@ void HELPER(sme2_bfcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e0 = n[H1(2 * i + 0)];
+            float8_e5m2 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = float8_e5m2_to_float16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = float8_e5m2_to_float16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e0 = n[H1(2 * i + 0)];
+            float8_e4m3 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = float8_e4m3_to_float16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = float8_e4m3_to_float16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3e1da83535..29d116a57a 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1545,6 +1545,11 @@ static bool do_f8cvt(DisasContext *s, arg_zz_n *a,
     return true;
 }
 
+TRANS_FEAT(F1CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_hb, 0)
+TRANS_FEAT(F2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_hb, 1)
+TRANS_FEAT(F1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtl_hb, 0)
+TRANS_FEAT(F2CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtl_hb, 1)
+
 TRANS_FEAT(BF1CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 0)
 TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
 TRANS_FEAT(BF1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 0)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index df9586c1a5..d6192eb59d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -853,6 +853,11 @@ UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
 
+F1CVT           11000001 001 00110 111000 ..... ....0       @zz_2x1
+F2CVT           11000001 101 00110 111000 ..... ....0       @zz_2x1
+F1CVTL          11000001 001 00110 111000 ..... ....1       @zz_2x1
+F2CVTL          11000001 101 00110 111000 ..... ....1       @zz_2x1
+
 BF1CVT          11000001 011 00110 111000 ..... ....0       @zz_2x1
 BF2CVT          11000001 111 00110 111000 ..... ....0       @zz_2x1
 BF1CVTL         11000001 011 00110 111000 ..... ....1       @zz_2x1
-- 
2.43.0


