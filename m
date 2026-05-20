Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B6CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZM-0007s8-FM; Wed, 20 May 2026 14:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZE-0007ah-IE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:52 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ8-0000gh-VP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:52 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3664df30f53so3098630a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301354; x=1779906154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVvA76owxH9PQty/SqJJ/UFG85eVlU6TRWjKCXix/dI=;
 b=u7R8ZgKIjflISJRf2jYcK0Up1axenr22uYTgmH+jGTw1S8uajS+WOLoWyUApahxhMe
 MoPtYzPJJ7DMszmDMwebH5CFEl9THjbtzXRZAWigFiDDboHoVv6ecQw5NjTOp3a7uPrN
 i1QGnaRjHeCtv+Vv+pRNsdYOhoF7x3W3v9miTDvJy+MbrfE8dDsmAIb16Hz7W+K/mCov
 8sR7maF2ep4/jzc/N8pVMv08n740lVcs1bsu8wYb9PGmKcJFvWSW2GNNn61CI6GObuMD
 TnS6PiBc/PvfJnD86AZKakJl3NPy5MBeuLk5ZmJABXrruqfWnOSoTPl2cx+9TAUz1sar
 kcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301354; x=1779906154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VVvA76owxH9PQty/SqJJ/UFG85eVlU6TRWjKCXix/dI=;
 b=LJAIB7PSzD5dqS1h/Ba3bw6EgjAEM8gLDnY9S94f0P4jA99SiChuKV562boKR61tLo
 v9mFHv5MLWxPu5eVE6D0GtI1AiLgiZrSr/JVL9hnlMeUJrx1poAVfFh5V85a/VIFNh21
 udm40WmgGdKENCbygqnpiZQSufanMpyHnqPiSSNlvaQ1rqPBgPwQO7TU8YRB6boPnrcJ
 59DFzv82wTz2bbI0r4c0dNCx1PRhnqWnCn4lbPplld2O3bCmeQsUdp7pjsFYXUJrrY4r
 iymTsgGyyL+VdmNDv220zLok/9khqENo+kIBnhudYQ2Ofo3vd+/5C7oEC7LvDKQ85HAy
 pvhw==
X-Gm-Message-State: AOJu0YzPXqf4pMK0ebhT8QZujd0T4bleUeGxjRwRS5GOzSSAKeLV1Pi6
 5OiMe1dFOBa9tf7OlP3+3qTzr4bN95Wx18zYiJFREkx6nsCcRjYAm/EFbXYxGL4wEWeolTAj2PV
 uFkBrr3I=
X-Gm-Gg: Acq92OHPTQAJqg9KsjoY4fEwCGDj4znODaCNDAL8L1a0gv13V3wzwQARtNXfM5bAh/4
 J6OUNxE5116uRbfBrkKVXjSSUJX+yvVaEy5P7n/b9CZ1TgH6dg3BaJYmCmXtEJ9yWybl5Otm1tq
 w9mygM2A7mVSCmMbjd7P1yu9y+wiTl5kl6uM82VFVtEHZhmRburiRYIODKLybntC5+tcYmvfIcI
 sWtYjoPfNHJKSz72bCbkcZjqyAg3ijLNFTcQrrrMpK5PeVP90+Zf5NGq26Blmp7T/nbOx5+vAu0
 mAjPdLH2VZNMQVuR/4G6SFh+I9tus1lexOx7zraysp9KKd+7HxMDdi+2jflNXtE5iRvOsaNvlOh
 TfIMsGHTTDJfP+RgvY8qtI6V+5LtmC38bJVe1EPcJdKPvoJdSaZYt+6N66e05W1HyzfIrn5nJ2x
 tGmBhAugEqVIzAaZyOPUMAehJV0gzvouC18XbHmKQ=
X-Received: by 2002:a17:90b:5904:b0:367:d850:6a5f with SMTP id
 98e67ed59e1d1-36951c9f53dmr25853314a91.25.1779301354168; 
 Wed, 20 May 2026 11:22:34 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 28/64] target/arm: Implement F1CVTL, F1CVTL2, F2CVTL,
 F2CVTL2 for AdvSIMD
Date: Wed, 20 May 2026 11:21:37 -0700
Message-ID: <20260520182213.872945-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index 085e7e3b95..565053a1a4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10643,6 +10643,9 @@ static bool do_f8cvt(DisasContext *s, arg_qrr_e *a,
     return true;
 }
 
+TRANS_FEAT(F1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, false)
+TRANS_FEAT(F2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, true)
+
 TRANS_FEAT(BF1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, false)
 TRANS_FEAT(BF2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, true)
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b7aac148f2..26d31d0a33 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1910,6 +1910,9 @@ URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
 FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
 
+F1CVTL          0.10 1110 001 00001 01111 0 ..... .....     @qrr_h
+F2CVTL          0.10 1110 011 00001 01111 0 ..... .....     @qrr_h
+
 BF1CVTL         0.10 1110 101 00001 01111 0 ..... .....     @qrr_h
 BF2CVTL         0.10 1110 111 00001 01111 0 ..... .....     @qrr_h
 
-- 
2.43.0


