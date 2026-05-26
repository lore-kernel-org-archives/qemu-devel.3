Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117E9CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsnV-00024W-Jt; Tue, 26 May 2026 10:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmu-0001UX-LD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsms-0001VA-V9
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so112138125e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805781; x=1780410581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7zEXoxHe4tEeDjtW6/nWdJr7RedH88EGZCuOfLggJ20=;
 b=TATD4JsS93PTRQBE/RF27pCVaLwgvB76Wz9qW0Jzde/eRq7rbnAHkXy3kFqCQk8kok
 RJGuBqfSSrucgDgZm76wuUFdeqqwCl08OBg2oJGXhn6owYN8JRqG5W8wMSnl3JYlZQLu
 Jhl6QDy/afaXPAQLecOJ2f1XezxhCJ0WL37z4SuE2cLyKscSdjfkgv1y22vVxmhp/l+U
 MwGsRH7WkCe0eLo9v96Azy8+XZ3efx3RhPEY8DQMNyRABAbJsvxGnddxsjWhBXw8gaQn
 B/FdtLMOAu5QoVsUXpxcsyc4AsV9LaB3LrQKVgwlmRCr7ns7oS/ILaUdXj94MwirKjBa
 juWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805781; x=1780410581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7zEXoxHe4tEeDjtW6/nWdJr7RedH88EGZCuOfLggJ20=;
 b=qAdECWpWRQnPRvO6sSuNRtPZ5V+k22l+TosE1SyWW1P5E5Z7pEkkgetmv6+RhuopVf
 iEYxY80xcpG8THjTfEZz6rYN9RC31x/jZgkL7evimO2etLRhXa9pBg44XtfzPs1NCAk/
 DAFlmems5upsv4xwCyfer41AsYZW5LvBtQe+HX7g9mcPhCMdi1Msja4Yja4trUOWMSyn
 u4FUgRWVMwT0mOQ1tDNlP8MmEq0quo+Fp0moyhGIHnl8IvsCpxHigfpTh4EudahrvFh3
 yXnY4NJVs+DJWk5t1G8ZxaHXFnG6Bv3nitI+rmlnZYEDQgR0nCuui7mHugishaddEeJM
 wDgw==
X-Gm-Message-State: AOJu0YwiTQv5QxKxXKhHXX9rar1aNuXgr5MTtr7B5kD0tpPaPCDo/eEi
 8Q5K+c02PagR0rFO1vGsUt+ZTtn29wJQcYXIAHHdIjLVCos9WXHMl0q2Xzjht2zFpQeivk/mJ97
 Voshz
X-Gm-Gg: Acq92OGPbwQZtTaoDyzxwiRYz/734mGVgwOTna6YiEWJFuy+x0XBIcVeTVTDTEB79mK
 p7T1n8dDCEAmKTIwKfDdZ7I09gcQLPgshCxC0hFNoF3umclUu+9QYPhbU7aG0xWQysEG1hkLWyW
 WqHVdKQWv8EaoTqhE5qyE1PtmTo9JRPOXexA6xy1uz4Ztu0DwbFhtSr+U1YdJ1EB4CzxAFJaBDZ
 sf8k8x6GMu4RF5vzqK6gw7ISTuXyhdyP1820vwkwfAaxpIlHXeSQQ3eeQnqFKqkPj/pfLOvMAc+
 ezTtvMBdlQqj/lrPCL2rsmMOcopdl9bsIcvQ/M3zyTDpRXMj9wUgkWzDmwZuURk7L7++3jaHJyd
 fwExpOYdCGSY1E4RPd9V3AI6THLhlcVqmldCwK7Q72vbCWIVQvgcI0Ry5Ro6WNrtx4znjACpxNG
 ijWQvX7JOsDxYG4Orf9bwV56LvbvrU+jl22UEsPhhCYteL52u16IZ2WNSvXPuZRcaulIcMTwk6p
 qh3RpDdWq65HocNdKmmfWeA1DYCyxI=
X-Received: by 2002:a05:600c:1393:b0:490:3890:605b with SMTP id
 5b1f17b1804b1-490428e0bf3mr315471015e9.31.1779805781515; 
 Tue, 26 May 2026 07:29:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/54] target/arm: Implement FSCALE for AdvSIMD
Date: Tue, 26 May 2026 15:28:47 +0100
Message-ID: <20260526142850.2326589-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode        | 3 +++
 target/arm/tcg/helper-a64-defs.h | 4 ++++
 target/arm/tcg/sve_helper.c      | 6 ------
 target/arm/tcg/translate-a64.c   | 7 +++++++
 target/arm/tcg/vec_helper64.c    | 4 ++++
 target/arm/tcg/vec_internal.h    | 6 ++++++
 6 files changed, 24 insertions(+), 6 deletions(-)

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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9490f0327f..a002006ea5 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4736,12 +4736,6 @@ DO_ZPZZ_FP(sve_ah_fabd_h, uint16_t, H1_2, ah_abd_h)
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
-- 
2.43.0


