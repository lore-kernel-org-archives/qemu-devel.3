Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38BEE74AD1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZhE-0001hM-Lu; Tue, 03 Dec 2024 15:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZge-0001OX-7l
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:00 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgc-0003BH-7R
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:00 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-29e5c0c46c3so2265677fac.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258397; x=1733863197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/WrKqelHnCbtbsQVD2Xt769eF5XVcZugiQlkdqiXsE=;
 b=WuoUtc+kGPc9t0t7a+YlRfqJ6rgPr2QZWU/oiGcmwPjZZ5c+31ubnjgB+GPENwQNka
 X2Hqa4wKL1jGBoed8LWfaQ+k1jA455xGsedbbJjDGQm1AlVKZLR+hCxew84AgTEtjPjP
 JPqlNiZ4UaIhaE4nXS1i+AwtAZ6FcWb07QmlvLYNIuVMIy++WKoXHzEd7W36i16QB+Jm
 CLpRfaopU5kyS2J00UImVr7cxvVw4wHcmMNEh9ugfKcNdDQB7B9/n4a/JgyWUowArk3N
 py42ncLmeOsbLnhYLPezHfTs0xX3L90KLAeOhKJEwTxHuRK128jHGf3hV52L7XsFu6R+
 C1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258397; x=1733863197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/WrKqelHnCbtbsQVD2Xt769eF5XVcZugiQlkdqiXsE=;
 b=umQYbtL1838Gb/RkjEIwxFgMGFPYIPFLnujDMa3/WFkl9+YzG28DTzeiDyjZhEbYIK
 bYe2CEVFC68bS3skNv5TVSYsfYanFAryq9+ep8C5HebtomSMFBvHmhPNy1wcKS6V4Tjv
 Q+5Hr02phyZP2vr6UWsgPbfUmaVTGBU+efwBwBpNLZ4gCvEBZVP8m/BgcIs4Y4RMe3nP
 R6J2MIaz4JuX44jjQ7S4AhO7pxMYhT1kFCHASo6xFXlyZC7bPtWx4WCccKcLlocFBoI0
 D+/Fcw2LXxvctBm/zBOfnMUU7xzdIGLkn+MMn30le4Rl1rpbVSPTYwDLEcrzZvUanSwD
 XuBw==
X-Gm-Message-State: AOJu0YxmSmARcBsaNoMPO/ZqTvaxoj/FtFzTRMPEXM562cU1ugTT3gKI
 kPBDbBxq72b+DOwy2ORpcBLemv4glgD/idvxKpUQSny8uYiHSQFjjKrL+IhJx/xBIl0+abdXdbT
 mKdE=
X-Gm-Gg: ASbGncsPb3UA4LcpTvEQ84Z/pxghRIJ/LQFLAlC7OulqRCmTUHqlniB+bdTxwLDr1df
 gkvIBeBAAWn1ZG8uO99F+Tmaa/EK8BPqUQDZhwW/GENJXdGLhRepCQhNBIZaLug8+oHK2dpzHh0
 iOlYG7GKHe/Z5V6s7WikaD5SCOV0B1t1J5rdLiP4zs7OwbmhZmuMFhFPAed5dMFwhheG2PcNgfd
 pMh0jP5pCTFESYWAGh0Gcj2bBsu4Te+Ah7Lvwg9DRHgSDj1SGu1p/QohlvZ7og3u3Tr4zCIuwEk
 tNbdP/mgx2dDleaRQ8rKPBXNrYEwOMUG60di
X-Google-Smtp-Source: AGHT+IEbRx7vVOWKfpYwrevKbZ5OG6wMs4PQHI3DcQdniEfaW0H35CeHWFRehskpyqw09xzfQ0NemA==
X-Received: by 2002:a05:6870:8a08:b0:29e:5a89:8ed8 with SMTP id
 586e51a60fabf-29e8863a36emr4100834fac.11.1733258396717; 
 Tue, 03 Dec 2024 12:39:56 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 06/11] softfloat: Move propagateFloatx80NaN to softfloat.c
Date: Tue,  3 Dec 2024 14:39:43 -0600
Message-ID: <20241203203949.483774-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

This function is part of the public interface and
is not "specialized" to any target in any way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                | 52 ++++++++++++++++++++++++++++++++++
 fpu/softfloat-specialize.c.inc | 52 ----------------------------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 027a8e576d..6ba1cfd32a 100644
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
index f26458eaa3..f7a320f6ff 100644
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
2.43.0


