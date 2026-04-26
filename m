Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA36AFF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzsQ-0007Rz-QT; Sun, 26 Apr 2026 09:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzrw-0006zy-17
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:49:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzrt-0002qx-8o
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:49:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82f33d28c1dso4992586b3a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211391; x=1777816191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfGQWAwKA0HR0AfaerNK4G6lb/Q53GYjwSjKhKZtA3k=;
 b=h/zp2Cf+hoa8CJd+zGfm4IhnPl1JD7HgEwUVtEARV9s3n+2lGz2cLFMUZUJ0OMViTV
 Tze15yezdbFjfibceUJ8jrkf/ID3HTkyQ9nySWdlCvv8RIcZvWA1OWSjNYOsqhnV+54Q
 nk8CJQ1UkfFlX+DklMC2XaWUvNAFBa7Ii6hbvFBdPETo0ZfZ96CrGLn59hFcM6FZqvjk
 X2b2URq7xaJ8NFo4uQv3l+VZqHY0tdLJuZHliNvX/OxLHueULxRawzD1QZRSBg5BdK++
 WymGfTGIGc5s3aajlgx6jZs+e8KF7/nAcmMkKSc2zW75g83pA8yVvMuMnK7vy3JlBe6I
 Ubqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211391; x=1777816191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HfGQWAwKA0HR0AfaerNK4G6lb/Q53GYjwSjKhKZtA3k=;
 b=fCzMzmo2GEjGuW//P/oWgukx1HlRFQlmyJOzrk8gllgsSa05JDX+UWwBlObtUgqJjB
 eAtnFSl9wBhd9jipptZV4b1sYFJBWknq6lcEEnCWqjGkEJHKXq/BUCtiWm+8DLlg/UHs
 AYbb+Q5/46Fr+Sl4IGlXvdW6ks87AwJd/8UvcTUZs8AWtaf1eTsY6t/ZdCgefEwEb64X
 wow3r3MOWfAmJxSpGgr+rU82ieMoyNB7rmF8bYK2uA1ggcB6xGbhPv/F8dHRCszCCiyI
 pAR1X8kiP2r64hOAiDbLrFA+ryMqWYQBnb8OYP7kuH9UORRLvWpsC5tGSw24EB/gFfGk
 GKRw==
X-Gm-Message-State: AOJu0YzB1d+5yyNtqsx+1SKVTmDK683fyMT1P5Ni97cLcBss6HJgJX8D
 Piy4j+Q0kpWTHWCPnL1kbHxnLfaj+XbjxjNogVNKPjA2QBZBO7sQmT0T1Axd1xQ4y24eSFJaExm
 o6BrOsK4=
X-Gm-Gg: AeBDievIp1qsUf3ocHsWMtPCu3pNEdfycI+2LTyTDHfN+4nKEqzVZ07FM6tPdPC6MPs
 mVJRO80l1+tjFZZ8ACuQ0FIC0JwDsuWpiAHFOtbNvrL7TKxF4cuTDfnq0kL6emU2fGBxecUvghC
 wqkRiN5iUZL5YVmsQwmJtS1aVl5t8X9TlGifB5e6Fi+fbhYCrddxKjpFxX8UgjyIDjDP92IJWfH
 bqY2f2+AOlf16NfN27Eb20QfS2BNsHlo188BvMJspFTMEf8EEEETEJ0fhGmlpx6yd1hxzv7qXvm
 0lrSJLYiL/rTs9Yb60tiYdlLHfkUbkVSXGZPcwyrsTlmA28vuS6hs/jrXmHSIhxI8YKblzUCWVR
 f/kRS8ZRmBl0VPQNwHgYqgmlAS3onkRe/5oQf/Rf+wIpCqNzhDLmlBxIbbQKCo88T7tGUdY6SSu
 LyoDKpkcp1Vl6r7acBbnqMULElSXxsG/7PxUTNkdUx
X-Received: by 2002:a05:6a00:4b4f:b0:82a:780f:a187 with SMTP id
 d2e1a72fcca58-82f8c94425bmr40215399b3a.36.1777211391196; 
 Sun, 26 Apr 2026 06:49:51 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebba485sm36307102b3a.38.2026.04.26.06.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:49:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 80/84] fpu: Simplify 0 +/- N case in parts_addsub
Date: Sun, 26 Apr 2026 23:39:57 +1000
Message-ID: <20260426134002.865628-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Consolidate the tests for zero and anynorm.
Add comments for a few cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 6d65b7bfe3..5854f0dc48 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -556,6 +556,7 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 - 0 */
             a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
@@ -581,23 +582,20 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 + 0 */
             return a;
         }
 
         if (ab_mask & float_cmask_inf) {
+            /* N + Inf or Inf + N */
             a.cls = float_class_inf;
             return a;
         }
     }
 
-    if (b.cls == float_class_zero) {
-        g_assert(is_anynorm(a.cls));
-        return a;
-    }
-
-    g_assert(a.cls == float_class_zero);
-    g_assert(is_anynorm(b.cls));
-    return b;
+    /* 0 +/- N or N +/- 0 */
+    assert((ab_mask & float_cmask_zero) && (ab_mask & float_cmask_anynorm));
+    return b.cls == float_class_zero ? a : b;
 }
 
 /*
-- 
2.43.0


