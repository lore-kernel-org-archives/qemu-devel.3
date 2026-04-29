Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F94FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPg-000612-RH; Wed, 29 Apr 2026 18:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPd-0005oE-8D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:46 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPb-0006zF-6S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:44 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so152575a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501782; x=1778106582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHmOg59hKNCh0zEzhXicgb+EWPS1IYr49yABmIu3FaQ=;
 b=mHVAsW/gXC35/3Aardh6MpqDej/tmxjZeOOUYG7ALt4P1tZVoF3JrTq1rDUBVmdy9W
 j1nSJYA1BGGEg1Hzf0SRdEr6NuGRF1dP2pSCJgwr6z3Dtht8QddPSCMLPyF5Yzdkzpau
 Cg3WwxFxwZu9sQk8NVN69yzQl8/spjUj/Yaci+APlf0uUYWGGp+ef3RRvn5pWDsXophu
 zQxl8OcNU2hXAW6erhq6sISRmu96KFb+DQ5N5DBnvu7M/YxMPhgJH+NDHIEWPSYSFUAo
 bEsrZsPynefS+nFJbEG1C34mqW9Q3O+qRhec4KKHH28BAiyZ9/0B8yv+KiyeDqgxTt7S
 RQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501782; x=1778106582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MHmOg59hKNCh0zEzhXicgb+EWPS1IYr49yABmIu3FaQ=;
 b=e0neuyyLU/h17gPz/INip8IxnVeD5Jkd6LVybuFGUc7frTj0At8IXOZ8o+Gn08mXoM
 tbAVBU2h1VbxHnyqZC/8TamLCGe7dF1VEXKjqo9L6AhxK2HLFawr1unD/BbryhdTEAFP
 G/Rd2YqcZLiHhm+Bw2DQqTdzoAzsGF+w8VB5lNHVG6oNx5J6ic5dBnlx0hyf6trDlEaX
 hw9WfVjXTx2oKbetqskexILfFXcdJRKlWn7YZZAGko1g82XDUMg6bj884fHEHo9C6El7
 BEFfZ/SsfpwK8YaGCryyicmZFCfWpORYpoAk7SkIkSmcHHSSJz7JrNruJx0Vz+1qQtpb
 NjKg==
X-Gm-Message-State: AOJu0YyQzs0RK7DAuI0959XyfxH0/90LS/vNO0VEp/t12Ghqi8btIE1W
 NF9zdZSyHAKy4YioiJaws7fE0ALDnpSGDMs8OiZTwgitZirTBmO8wZRXW8FBNPp3Q/og/wR7VwY
 19zSexNs=
X-Gm-Gg: AeBDiet/QZ3Jqoph3U1rQgoCCJTM5jfZYdfwSbrJYZu730Z8m8ZRHaUBpZgXHR/bX5h
 7t0fM5cRwoG1jwJNhyV+KH9D2EmOmD51lHPtXLRc8g07eQgWwBiPqqAttsTgwuOb/9iDDrO+FQy
 EkaThiW1NKrgXwf+Pn9uNsmXgnibXuOtYEGgfqMhyxXUbGdqH5S9/2uqBFxp+ghVdXTWLQ+QL+x
 zF65jwEEXUr8SlNNwR1OiPXUSiSxlb4FpodTGX3JNB1MVI2swRZhXmMbzNTddfVte2ddO9piZoZ
 Tc6inwi7Ghb21qFQOSIHP4yxSpfCgY2fSrm9jdBAYMcCRhHoR2O/krRyX9ue3V7fTY5B1WEEUXk
 UwEZAbwIuffEEkOuMTkLOGVWAmTMn9hVy9hUS1EZJItRunXSOnqehddEJqy3hJvtgrK+xd2iZo3
 r0uQQsAKx2IxYpF5fmKnzr18R31s4DCRwbi9BEIP5d
X-Received: by 2002:a17:90b:524f:b0:35d:93ff:2854 with SMTP id
 98e67ed59e1d1-364c2f6cdf8mr195128a91.8.1777501781760; 
 Wed, 29 Apr 2026 15:29:41 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/48] fpu: Inline float64_unpack_raw into callers
Date: Thu, 30 Apr 2026 08:24:39 +1000
Message-ID: <20260429222445.26301-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5e33eab8d5..e1b92b38b6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
-{
-    *p = unpack_raw64(&float64_params, f);
-}
-
 static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
 {
     *p = (FloatParts128) {
@@ -1538,7 +1533,7 @@ static float32 float32_round_pack_canonical(FloatParts64 *p,
 static void float64_unpack_canonical(FloatParts64 *p, float64 f,
                                      float_status *s)
 {
-    float64_unpack_raw(p, f);
+    *p = unpack_raw64(&float64_params, f);
     parts64_canonicalize(p, s, &float64_params);
 }
 
@@ -4918,9 +4913,8 @@ float32 float32_silence_nan(float32 a, float_status *status)
 
 float64 float64_silence_nan(float64 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = unpack_raw64(&float64_params, a);
 
-    float64_unpack_raw(&p, a);
     p.frac <<= float64_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
@@ -4990,9 +4984,8 @@ float32 float32_squash_input_denormal(float32 a, float_status *status)
 float64 float64_squash_input_denormal(float64 a, float_status *status)
 {
     if (status->flush_inputs_to_zero) {
-        FloatParts64 p;
+        FloatParts64 p = unpack_raw64(&float64_params, a);
 
-        float64_unpack_raw(&p, a);
         if (parts_squash_denormal(p, status)) {
             return float64_set_sign(float64_zero, p.sign);
         }
-- 
2.43.0


