Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48068CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXz7-00017s-Kg; Fri, 22 May 2026 18:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxt-0007kx-5P
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:36 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxq-0008Ir-Dz
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:32 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so5145261a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487407; x=1780092207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEcxILczO0i6hvUfeM82ZYl1jJG/iJuT4NwlPrz2R1g=;
 b=ULmnB38uUSYFww0Is5CL6X+caT8r4WjloVDlTTS5CI3kw9ZHjxBuR69DGNWnfg6u2v
 lsr3yzlMgKEAgHPBxo7zIdgA0W7vmN62HtgnCmJ9f2w2zPBrFPoHrhSid2Ytnvl8gMHB
 2fOV9zZL+BW332gdv+0fKD96RVwgZ8XuUwQyXC1k2ogiXPIJOrqVr8Y1rO7Kac03ZSP+
 njJJxmiDa9oqA+CiAI6TNLznOTkNQnK7f7m8vYfJk2HbnjfutMtfaKZTGAwK+nL9mSS6
 sMkoRBD5vFXBR94Zv588H6g37diHEk0f37bKXaF7hlI+iLZmmNId0wDw3VKnvZlXrqpX
 by0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487407; x=1780092207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bEcxILczO0i6hvUfeM82ZYl1jJG/iJuT4NwlPrz2R1g=;
 b=qEDCEuqrNQJv2DDPPtH6IElYFhFonDUXdJgNLsB0fFm4ANnpmkZTazQuK10XUpYerS
 t06ZUN3sCR3pfCPQbfSXSaO24ER3TTxVsnaeYc02dlWu2T2e9BiZX+Ya/BP7UBn4LeHZ
 29J1tOFJzEhyOFEdW5B1kcRA48yFIk0NwURaz/u28iPFkC1O37MCKpnGEUyNmVAtnxed
 tEpbedOIRm79Y9lj/bAjsPW2tG9WGdn2KXZ8fBHf0GTJbySdtdrlYhMynOPJKVxLTv8j
 yZQ1SbuAXVDyppYCqxwf/z1apOfU23YuWqGVyNlWxJGKsY2+fXteZhdDn+Kvn5WD8VXK
 LVyg==
X-Gm-Message-State: AOJu0Yxgw6AVsS9M3J0xphvIVoaRsdI8t9buXIeoQhVYxiMA7bRvFW8m
 gML8KTMgqPz2Ln4vzAw1ef64iXRPCFnEvoNE8o5yc5VjjaXEunmWEA+aV0CCuBg+8HYWlxtTMX6
 +0Xx/
X-Gm-Gg: Acq92OECsUzVhCbM1DIGIV2kpAWEkZHyfSRlqWug2ryyJTIf4xRZ6yft2501Tig1i7i
 vn5M/DvPFZw1snqR6mb1XjOWUBzvef16B+b7312iQ16lFITt3t/kDZ8TMIi1QKEN2hI3eB5uHDZ
 JAXw6sKutcWDkyYa2qLNc6ogslCjh61n/6spVsb1JtLbeJLGEs066e/8twkyBBspWIAfddgipMD
 LVQzK7a2AVupH+xcVrbG7SlsxRjvn6fteCDho3tii3Tr80b/PAoX7uGGKN7t12/KcVnkEcK75VI
 i2UlHXIjHQCCBSEq+pWGysEGhmL9OheeUNN/NBrEoZpnFQOSzOInk6Z98ED+0VZ4OXPRDDXfYmr
 MyQ1fxv6v+zXH/b60GBfdbG+7fFcUlYzlCD9+RCJplRUTc5vYCyzB7ARljA5yCY+X8K1YTplFgp
 pLGvCvnbVYnleVwQ5zMzUB9YUP/JZU
X-Received: by 2002:a17:90a:d88d:b0:36a:3a95:55f8 with SMTP id
 98e67ed59e1d1-36a676f58f9mr5428525a91.5.1779487407477; 
 Fri, 22 May 2026 15:03:27 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 20/64] target/arm: Implement FSCALE for AdvSIMD
Date: Fri, 22 May 2026 15:02:22 -0700
Message-ID: <20260522220306.235200-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 4 ++++
 target/arm/tcg/vec_internal.h    | 6 ++++++
 target/arm/tcg/sve_helper.c      | 6 ------
 target/arm/tcg/translate-a64.c   | 7 +++++++
 target/arm/tcg/vec_helper64.c    | 4 ++++
 target/arm/tcg/a64.decode        | 3 +++
 6 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 215df1201b..b7880f773e 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -152,6 +152,10 @@ DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fscale_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fscale_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fscale_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(exception_return, void, env, i64)
 #endif
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 5c3f51eed3..758e3db1c3 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -349,6 +349,12 @@ float32 float32_famin(float32, float32, float_status *);
 float64 float64_famax(float64, float64, float_status *);
 float64 float64_famin(float64, float64, float_status *);
 
+static inline float64 scalbn_d(float64 a, int64_t b, float_status *s)
+{
+    int b_int = MIN(MAX(b, INT_MIN), INT_MAX);
+    return float64_scalbn(a, b_int, s);
+}
+
 /*
  * Decode helper functions for predicate as counter.
  */
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9968600f75..982db8836f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4728,12 +4728,6 @@ DO_ZPZZ_FP(sve_ah_fabd_h, uint16_t, H1_2, ah_abd_h)
 DO_ZPZZ_FP(sve_ah_fabd_s, uint32_t, H1_4, ah_abd_s)
 DO_ZPZZ_FP(sve_ah_fabd_d, uint64_t, H1_8, ah_abd_d)
 
-static inline float64 scalbn_d(float64 a, int64_t b, float_status *s)
-{
-    int b_int = MIN(MAX(b, INT_MIN), INT_MAX);
-    return float64_scalbn(a, b_int, s);
-}
-
 DO_ZPZZ_FP(sve_fscalbn_h, int16_t, H1_2, float16_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_s, int32_t, H1_4, float32_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_d, int64_t, H1_8, scalbn_d)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 41dd013784..15b40090c0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6493,6 +6493,13 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[3] = {
 };
 TRANS_FEAT(FAMIN, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index cb55a2b441..d8b25b868e 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -178,3 +178,7 @@ DO_3OP(gvec_famax_s, float32_famax, float32)
 DO_3OP(gvec_famin_s, float32_famin, float32)
 DO_3OP(gvec_famax_d, float64_famax, float64)
 DO_3OP(gvec_famin_d, float64_famin, float64)
+
+DO_3OP(gvec_fscale_h, float16_scalbn, int16_t)
+DO_3OP(gvec_fscale_s, float32_scalbn, int32_t)
+DO_3OP(gvec_fscale_d, scalbn_d, int64_t)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 666a293540..02c7264cb9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1198,6 +1198,9 @@ FAMAX           0.00 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 FAMIN           0.10 1110 110 ..... 00011 1 ..... ..... @qrrr_h
 FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 
+FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
+FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


