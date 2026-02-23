Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD2E98E0A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRCt-0001yk-JT; Mon, 23 Feb 2026 03:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCs-0001yT-05
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:18 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCq-0007tL-72
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:17 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c61343f82d7so1362680a12.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834935; x=1772439735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7P4L6KRGUfnJuZGklnenZefdnYuPN4EZ2NjRTD5rCHQ=;
 b=uAlhqBwF2zjMjg3UGjo76YPmeLQMPz6jx48Z81mnh1vnNt/iAMDtAaJHER6X0TR8Sd
 CPYL6Q0/Kpv4uy3kcQw4l7i2rcT2Ayn+z9nP9CUlrBAxiUvfWJAX66ABRs/GJBiuuXGE
 gtnSxBgOaeNG3FxltT6/dxv05gaUUuMlxaQaYOShwx01O9VoN/4Rd0nclO7WXeINDGJH
 5/qHIBi9ZVjfpsvaGxhWgmlklhlx5yfCJOI4NKLwkMUQhPXX5OnFQa7Wm3wvbqhyVz5u
 +uGUUSU251FPRzms12FF6NdoexUHX+jYixaRVtV1Nj0Zlt6Xt+SoMJ3wfbEB4AMZtPZY
 lYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834935; x=1772439735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7P4L6KRGUfnJuZGklnenZefdnYuPN4EZ2NjRTD5rCHQ=;
 b=a5TiMkBhUe5658bYfw+L71klPSqkp2XmbwMuAIB5QVd+0F/Xuk9f2XC2i7rDWSM6Fc
 3LT38rfvnBtbNcrJ35/ATZbXlqQAsavcd91Tgn6Oa9l9HdmGzvUxwz2oa6Pp2wkM3QaD
 fmfGlg933s/i3mMufYfTeK1fO8uZTsfcAFYRmjj7XFdrUU0q6AovhTU6Xz6urveT2kE9
 5/kcuOT1gufyTtoA3PH+xC8EeQNtCIBaFsjXDFtqQhzDFoHDtkb9Y1oTsZBvzaTc04dj
 yJ35R+vbtvUV0IEvPPtlDA12SbpTFWZhpbEzACwm4MTJPxWvLovpx1SR4NyIlPdhqOta
 Uj4g==
X-Gm-Message-State: AOJu0YwTYFoYxPkUqHBzq9riLWzt5VMRYuts7wZLXRg3zrNEdNZzEoLT
 jtQsijSCbKWoXjY1kW8RFel8R1Kw9tVUe7V6EoNjXzGJ988K5tT0s+wDq+gMS+yQlf7kcijgFF0
 xnKgvdqk=
X-Gm-Gg: ATEYQzxSO8pTRpFCMiDdcReWTVDwZ5sDJD044jXkaSm9ras/NjW0HXX9hHWOiOi3xyL
 FRIIjp+cBpGnhYvBRDWiW7pRYJD2gtU9oEN4hnS7ZuWhFNvuHGubiMZ/eMHrclMO0elm+pTefxZ
 ShK8ofoEVHRNPH+T1ycXofubnRao+wBRwSozfnSMR62RRjrU9tmNtGKkXXGuKqj58Z/gw6E4vs3
 R/Yimya/3nPm5ZQIAKlVdOakxDQ0kCh66Cw6Jz7mGGgxAbSibzb1I/cL6Ma680KgN1YceNI8pTG
 ZDNqmqzZyUOw/P8mHyy2RlTTlShKD18wBNZCGQ0nJbjHn5RgMq4gGBkJ+gPb4dRUYs6OZBzmV+G
 QaBFLB/XqOgB4LXIyzrbL0CinGSf3gUGmDb5XtKrMC87WZ6Rd9xnAKo65JwkrvC/l98cnnpkIQj
 PadGAA99FU57rgBr4km3Tr+6O7odZy/jrIH9VctXkOpKpSJEQXiMaZcFm7E5+T/rt4Xg==
X-Received: by 2002:a17:902:cf10:b0:2ad:4029:9e01 with SMTP id
 d9443c01a7336-2ad74463f6fmr65391145ad.14.1771834934724; 
 Mon, 23 Feb 2026 00:22:14 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 3/9] target/i386: Fix pseudo-NaN handling in
 FPATAN/FYL2XP1/FYL2X helpers
Date: Mon, 23 Feb 2026 19:21:48 +1100
Message-ID: <20260223082154.5623-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223082154.5623-1-richard.henderson@linaro.org>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

From: Max Chou <max.chou@sifive.com>

According to Intel's x87 FPU specification (Table 8-10, Vol. 1), arithmetic
operations on operands in unsupported formats (including pseudo-NaNs) must
return the QNaN floating-point indefinite value.

The helper functions for FPATAN, FYL2XP1, and FYL2X incorrectly check for
signaling NaN before checking for invalid encodings. This causes pseudo-NaNs
to be treated as valid signaling NaNs and silenced, rather than being
rejected as unsupported formats.

Reorder the checks to test floatx80_invalid_encoding before
floatx80_is_signaling_nan, matching the correct behavior already
implemented in helper_fscale.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260204051756.667397-5-max.chou@sifive.com>
---
 target/i386/tcg/fpu_helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b3b23823fd..37c83ded38 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1377,16 +1377,16 @@ void helper_fpatan(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2061,16 +2061,16 @@ void helper_fyl2xp1(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2159,16 +2159,16 @@ void helper_fyl2x(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
-- 
2.43.0


