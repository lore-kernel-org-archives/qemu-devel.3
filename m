Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A15E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEm-0007uU-1T; Tue, 17 Dec 2024 12:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEj-0007tK-9m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:57 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEa-0006AB-8a
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:55 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso2787551f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455985; x=1735060785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WJ/CPb13gYil8uu9o2JlnbILGe0I31RG8COUNiZ0+GI=;
 b=POvBDQ4W2SGg8QaD70O4oNJSj3LCkK0cn8FL2m4g59YDM3Ig1Hq6Nuqcx1YCPdfUK9
 IxEPIT1Cxc2rRo6HTVS0KNOejO5OL7/TPWI7DyEfyKbaoIkARW43aXxKmZ1/RIBJyd1A
 JvJPRt/VXcn3i3p46bY6qSkmPShDAky2xnLukST8q5N+oBaadbItxIDA8IC4bL0xAPWp
 xMu5qmSiY1ZxWkXb/Ej0nAA5w4bu2mjZkggkS9u4EtMHN9BhiX7FbhOXgTuJ4UeKcZ+s
 XQF+dd9Msxfo/CxFOmENDL5C2fNjEg4homPjo2jXhdXXmABFYToC7s/rWwMz8hVpQ1oS
 VJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455985; x=1735060785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJ/CPb13gYil8uu9o2JlnbILGe0I31RG8COUNiZ0+GI=;
 b=JU9ygzQ8A4exXaVKWALzmGbWMBlOnXJtOHtdlHVVAQFgfOFZl0+lT+Iz/tmcMdI6qw
 S/pwXKe/GLFsZ11k5s5gcY/SB9uMpwGuTqsbQdyFzDSmxQqRcuAx26u+S3etEVyMVEs8
 u2a1wLElS02GnYw59ZX2Ix+vltu/0UQcdS9zP+kzK2mKJQzTcrE+XttBD9X469Wvd5dp
 SSinGFZvFLcWFsx06myDvShwDb1ebNKz2zq4zYiBpafitM1aQcqM18B7z61qaujb34lC
 vTS4U1U/hDaXE7kyww8zIvXj72ShmCRrBlmvm1NyWlpSCtf4MsPRIGjh2t+xZjV9W/eh
 fANw==
X-Gm-Message-State: AOJu0Ywx7G4ZyONHEXeCXEZG/i0z+CNqlzvJDzQeXOBLVXXe9f1P0YgP
 6mr5Uv5c4y9XQQ25PkohfFt4kLbEI8S6Q7pRHBRM53appkA81EeNyvgZV/aDe/2zd2m0PcJKlFW
 B
X-Gm-Gg: ASbGncvFPWaNusWauGlMpCrqF0YSmNHgU9XDOx5ye3iPxoRKw4mzltZmutPmYKaw23J
 CnVSbvrwfKmOMZBmwrVsNF+9d5wJWQTPcFcZ/+Ge2nFWgLRtLBMQduMTKA9qfTjiG9MDDNJVMOJ
 /RckHl6ZDDSMF00ZQbt+1+rknTxqYr3bbAuConO2LAbOHYvbaSd4XWv+p17vluqe9xnmvrGw5Gi
 HmrYDPQdA5y57da2r4SxjC9uIhqf8peAaXZfROou0RyJo8f40BwH4K2AHqlAKA=
X-Google-Smtp-Source: AGHT+IHO1oB28m4d+ixSMR3qyMyRNQWtitarogjzIFnVDQIDNi4NgspebIwzXMVzp/X4coyIJm695A==
X-Received: by 2002:a5d:6da2:0:b0:386:2ebe:7aeb with SMTP id
 ffacd0b85a97d-3888e0b887dmr15058607f8f.44.1734455985323; 
 Tue, 17 Dec 2024 09:19:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] target/arm: Convert neon_helper.c to fpst alias
Date: Tue, 17 Dec 2024 17:19:23 +0000
Message-Id: <20241217171937.3899947-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031224.78525-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h          | 14 +++++++-------
 target/arm/tcg/neon_helper.c | 21 +++++++--------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8ba9e1ce6f0..9a1b6d1b6d7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -424,13 +424,13 @@ DEF_HELPER_FLAGS_2(neon_qneg_s16, TCG_CALL_NO_RWG, i32, env, i32)
 DEF_HELPER_FLAGS_2(neon_qneg_s32, TCG_CALL_NO_RWG, i32, env, i32)
 DEF_HELPER_FLAGS_2(neon_qneg_s64, TCG_CALL_NO_RWG, i64, env, i64)
 
-DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_cge_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acge_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acge_f64, i64, i64, i64, ptr)
-DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, ptr)
+DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_cge_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_acge_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_acge_f64, i64, i64, i64, fpst)
+DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, fpst)
 
 /* iwmmxt_helper.c */
 DEF_HELPER_2(iwmmxt_maddsq, i64, i64, i64)
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index c687e882ad9..99fbebbe14a 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -1180,51 +1180,44 @@ uint64_t HELPER(neon_qneg_s64)(CPUARMState *env, uint64_t x)
  * Note that EQ doesn't signal InvalidOp for QNaNs but GE and GT do.
  * Softfloat routines return 0/1, which we convert to the 0/-1 Neon requires.
  */
-uint32_t HELPER(neon_ceq_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_ceq_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float32_eq_quiet(make_float32(a), make_float32(b), fpst);
 }
 
-uint32_t HELPER(neon_cge_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_cge_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float32_le(make_float32(b), make_float32(a), fpst);
 }
 
-uint32_t HELPER(neon_cgt_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_cgt_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float32_lt(make_float32(b), make_float32(a), fpst);
 }
 
-uint32_t HELPER(neon_acge_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_acge_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float32 f0 = float32_abs(make_float32(a));
     float32 f1 = float32_abs(make_float32(b));
     return -float32_le(f1, f0, fpst);
 }
 
-uint32_t HELPER(neon_acgt_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_acgt_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float32 f0 = float32_abs(make_float32(a));
     float32 f1 = float32_abs(make_float32(b));
     return -float32_lt(f1, f0, fpst);
 }
 
-uint64_t HELPER(neon_acge_f64)(uint64_t a, uint64_t b, void *fpstp)
+uint64_t HELPER(neon_acge_f64)(uint64_t a, uint64_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float64 f0 = float64_abs(make_float64(a));
     float64 f1 = float64_abs(make_float64(b));
     return -float64_le(f1, f0, fpst);
 }
 
-uint64_t HELPER(neon_acgt_f64)(uint64_t a, uint64_t b, void *fpstp)
+uint64_t HELPER(neon_acgt_f64)(uint64_t a, uint64_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float64 f0 = float64_abs(make_float64(a));
     float64 f1 = float64_abs(make_float64(b));
     return -float64_lt(f1, f0, fpst);
-- 
2.34.1


