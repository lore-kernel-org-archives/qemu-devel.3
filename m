Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EDE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSw-00021x-4m; Wed, 11 Dec 2024 11:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSl-0001Lz-Nj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSj-0007tn-J9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434f30ba149so25943045e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934079; x=1734538879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5+3C2AdZ9fftwrmxk/ig7qIyG/mfuZxKLEQCuOb4ibU=;
 b=FSY9KYZhsZrqA9lgHwinrmbX6KXWluu1gDZjh1FGbcmaMa1FhBbi7sQIQGATZpt8V0
 AvsiyuN905+58RVrnDKTKBv5/Y38TplRGsElsv9pzi33f/JLBQH3bjrXeGQOrgbD0yOc
 0JxT+jrrIKskWBSS0h0LskCi+jv+G+8Y0DuvAnr4G2cvYWapzp3SbPvsVslRjO7NiEXG
 HMT2yq/JPnH2zySYv88Zy72kt/T5BTHPUoX5c6kcq4P51yqOrtE5FsWc8WtB2bQ1/IIh
 eT9MGJSbS8wLcNS+mJ40+E/6ivSygDSbvla1a3d1uOX9qcB1EyOVSz3InYcmvjm02ol0
 b2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934079; x=1734538879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+3C2AdZ9fftwrmxk/ig7qIyG/mfuZxKLEQCuOb4ibU=;
 b=GJ31I7KEZ2DueWGCdSddU6P3TTph9RCTUIYs5UP4gl9dHJ3wty7b7t11b8SppZs0LS
 yOTgBHSJIESb5yqW7z0g+pjcoz71qHM4zcu6g2kUAGnHeZ4ByydevcThQhQzpVJflFyI
 kXgF3gBS7X6L7wNV+8GExxcbUx5zZtE1FJgNScoN4qpmUOqiY90zcNcIjiqOZ0NB9Bfx
 I2FuFlCsR+joPqM3rREIDOZkcAoQoW8FEcA4h93TXLW8d1OVhh6sQgTgU1FjzG8x2CRn
 5JnyO9GGFZMpIxYBML6methmOh5Es7lfcb7ZVbmF0C1kWgKv+fuThgKyRvvZ2wdzFM6u
 0QQw==
X-Gm-Message-State: AOJu0Yz26YYkJuZY/K1LayFoi4CiRq7z0fOOdMCygQoZPDdm7Ut9L8xy
 zA3/aNiE8Efq0GPvtY0QcvezOZBk+cuh9Yyb1IP2dPeu666KnooF29vDQwxNAiPDWhL1Q7DADUw
 Y
X-Gm-Gg: ASbGncui/pAZnRFjTYHnciYvs6sO/Axy3EBS5Z61oInQMdMZAHFsdoQjUmkXWc1l4Od
 E6V41E91Vpwwh9/BJ7XR5SZ8D4zVXFS0L+z9EMniti2AYXLJ3ywCyaev6VCt/uMRkkdqGq4rFfo
 wh5PkOVUwxy6G5QhenutiFGgoWaaTXh/cOrvVxseyAPpOOccq4pD9hfr3QbnsER5q0dLi1ALodc
 n4EZvh8VLArp3JJBzf9MeQ694cSpnIbocBuKjjuFBo4/rbiI4KKXE8wYgpm
X-Google-Smtp-Source: AGHT+IFEkKKRg30SD0pVjKVuw93S1OtWePsFg+1Qz9W1gtupLPJX6/FD2k6buc3HrzWevg9Gt8KSfQ==
X-Received: by 2002:a05:600c:4f86:b0:434:f871:1b97 with SMTP id
 5b1f17b1804b1-4361c42e258mr26904065e9.33.1733934079514; 
 Wed, 11 Dec 2024 08:21:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/72] softfloat: Move propagateFloatx80NaN to softfloat.c
Date: Wed, 11 Dec 2024 16:19:57 +0000
Message-Id: <20241211162004.2795499-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

This function is part of the public interface and
is not "specialized" to any target in any way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241203203949.483774-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c                | 52 ++++++++++++++++++++++++++++++++++
 fpu/softfloat-specialize.c.inc | 52 ----------------------------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 027a8e576d3..6ba1cfd32a0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4920,6 +4920,58 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
     *zExpPtr = 1 - shiftCount;
 }
 
+/*----------------------------------------------------------------------------
+| Takes two extended double-precision floating-point values `a' and `b', one
+| of which is a NaN, and returns the appropriate NaN result.  If either `a' or
+| `b' is a signaling NaN, the invalid exception is raised.
+*----------------------------------------------------------------------------*/
+
+floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
+{
+    bool aIsLargerSignificand;
+    FloatClass a_cls, b_cls;
+
+    /* This is not complete, but is good enough for pickNaN.  */
+    a_cls = (!floatx80_is_any_nan(a)
+             ? float_class_normal
+             : floatx80_is_signaling_nan(a, status)
+             ? float_class_snan
+             : float_class_qnan);
+    b_cls = (!floatx80_is_any_nan(b)
+             ? float_class_normal
+             : floatx80_is_signaling_nan(b, status)
+             ? float_class_snan
+             : float_class_qnan);
+
+    if (is_snan(a_cls) || is_snan(b_cls)) {
+        float_raise(float_flag_invalid, status);
+    }
+
+    if (status->default_nan_mode) {
+        return floatx80_default_nan(status);
+    }
+
+    if (a.low < b.low) {
+        aIsLargerSignificand = 0;
+    } else if (b.low < a.low) {
+        aIsLargerSignificand = 1;
+    } else {
+        aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
+    }
+
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
+        if (is_snan(b_cls)) {
+            return floatx80_silence_nan(b, status);
+        }
+        return b;
+    } else {
+        if (is_snan(a_cls)) {
+            return floatx80_silence_nan(a, status);
+        }
+        return a;
+    }
+}
+
 /*----------------------------------------------------------------------------
 | Takes an abstract floating-point value having sign `zSign', exponent `zExp',
 | and extended significand formed by the concatenation of `zSig0' and `zSig1',
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index f26458eaa31..f7a320f6ff9 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -551,58 +551,6 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
-| Takes two extended double-precision floating-point values `a' and `b', one
-| of which is a NaN, and returns the appropriate NaN result.  If either `a' or
-| `b' is a signaling NaN, the invalid exception is raised.
-*----------------------------------------------------------------------------*/
-
-floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
-{
-    bool aIsLargerSignificand;
-    FloatClass a_cls, b_cls;
-
-    /* This is not complete, but is good enough for pickNaN.  */
-    a_cls = (!floatx80_is_any_nan(a)
-             ? float_class_normal
-             : floatx80_is_signaling_nan(a, status)
-             ? float_class_snan
-             : float_class_qnan);
-    b_cls = (!floatx80_is_any_nan(b)
-             ? float_class_normal
-             : floatx80_is_signaling_nan(b, status)
-             ? float_class_snan
-             : float_class_qnan);
-
-    if (is_snan(a_cls) || is_snan(b_cls)) {
-        float_raise(float_flag_invalid, status);
-    }
-
-    if (status->default_nan_mode) {
-        return floatx80_default_nan(status);
-    }
-
-    if (a.low < b.low) {
-        aIsLargerSignificand = 0;
-    } else if (b.low < a.low) {
-        aIsLargerSignificand = 1;
-    } else {
-        aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
-    }
-
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
-        if (is_snan(b_cls)) {
-            return floatx80_silence_nan(b, status);
-        }
-        return b;
-    } else {
-        if (is_snan(a_cls)) {
-            return floatx80_silence_nan(a, status);
-        }
-        return a;
-    }
-}
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the quadruple-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
-- 
2.34.1


