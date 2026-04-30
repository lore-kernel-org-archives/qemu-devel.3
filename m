Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F90CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEvt-000089-KU; Wed, 29 Apr 2026 20:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvQ-00082v-IL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:41 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvO-0001w2-6N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so266393b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507597; x=1778112397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQkQKLK77Dv6DrQmjWfjyf9hVFUzji/KbysWx+6wnbM=;
 b=U7KBFDGOLxm34Tl0Y/Br3aFOx3B4T2MUGU3y/WPwR9KtxZvg3hGtp3tMPHYJwDhMGG
 smi3/IGfaET73BDamxMuV8Sr6/lFevLN4UGeNndfQK/YiuT2ea6Tg1rsGZljvAPE02s/
 844h/VuWR8rX6WvPWPCYuP9zN/XunfVLnqz2uYe+kZQUfhSWTxd8nMntzSpIg1MchSMz
 JA1XHEEUy6U0Y0ORre/s2SgIw1QHRlo6ZsGAVNZYrqIgUYJiFcYR0SS3tLSmQwI3DE3M
 ozDMg/svwMhxaXuWrw5UgxfuQ5PVfEgzdoWVKz+fQ9o5eO6JxRv+92136YYpm5XDyb7i
 8BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507597; x=1778112397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fQkQKLK77Dv6DrQmjWfjyf9hVFUzji/KbysWx+6wnbM=;
 b=XbIleRCt4ct49tDqDiNStOI51iueYJ1AtAuXzy7FSX4FTn3lMQZG7H4MbiRG/PIcrb
 QqiOhF/lwtKL/Z6CQ4fniLPX4Dw4Y8a3bKuFiS1JcefpzR5emW3MO7S9MknOsoYI+SIz
 Hc7S2fxManbe0r0wCzxwnRIQemKQAq9YhYgZbux9rzzcu2Jd3qGiU+cp4kZ+ynEt019n
 aVvdn9xbsWxTz/1XDPD3aWYxHrtsFpxne2n7UaHYFEU0e0y89f7jAAuJq/onNJ1FsZd5
 umz8CdKrnqyM1zTgpq7jXjLKDzjz5MPlcVJ+3MKvsvUFizCBE9vXicBEefK82R8ipazs
 z19A==
X-Gm-Message-State: AOJu0YzHu6r0QeIKReL5z5bhq6Uk3Hz43ddO1zQO3RySzx9miOtEq9/q
 Uc19o1wegGlkymMtadCxo9B6eS3jL/ivTpH3F8X6eT8EdslVYh00dUtFRjWM8+RHFOycADqW3Oa
 jN/CA8FY=
X-Gm-Gg: AeBDietO+2mry+NvUcQvMJ987oRFKLpwlU9cPL5HZS2SVbPXY2AedCjtbE3hsxKUxSe
 rSJnmn2X3fvGARwcJab/ALpEsfNgt0KulwrB8FHwDy3vWgIcB8qDZJm8SzFNSdcwv6Pyaoxhhup
 6qAixRw2LZAYcuBgslusSEDavmTAu7UaVVTY2yD5NMiWNLukDqmFcGGlYhX9+mGkbNy80sDawlK
 ukEuiAbPo6b2IzytX3DDrb7U0CQWt1aUlU7SIqN5luCmtJz/jhrth2v861O+IVgZQZMyQCO5Vwn
 hh5J9Il2+0bb/eunfN0G+HmiEyKICo6fanUV3lGt5Rjc/DJceZghyHzFo+kJZr34K6AFrCFszG2
 aUY2lFeUb54mjTol7Y9A13IhtUwVr4yjFFNY94YVol49+uGlPaTr90B3QfCLcK/h3IH93T+UgwV
 qrtcYQ4oOxXV6fYf+dB6xXTgpV4So6G91XdKwcv1NJ
X-Received: by 2002:a05:6a00:4503:b0:82f:7bec:2050 with SMTP id
 d2e1a72fcca58-834fdc3bd40mr928030b3a.39.1777507596806; 
 Wed, 29 Apr 2026 17:06:36 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 30/40] fpu: Hoist nan check in partsN_addsub
Date: Thu, 30 Apr 2026 10:05:13 +1000
Message-ID: <20260430000524.56046-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The nan test had been down below because it was unlikely.
But if we have to have one anyway because of denormals,
we might as well take care of them right away.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 84aeae2866..0a0f3a4f0b 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -530,13 +530,16 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     bool b_sign = b->sign ^ subtract;
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
+    if (unlikely(ab_mask & float_cmask_anynan)) {
+        *a = partsN(pick_nan)(a, b, s);
+        return a;
+    }
+
     /*
      * For addition and subtraction, we will consume an
      * input denormal unless the other input is a NaN.
      */
-    if (!(ab_mask & float_cmask_anynan)) {
-        record_denormals_used(ab_mask, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     if (a->sign != b_sign) {
         /* Subtraction */
@@ -553,10 +556,6 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             if (a->cls != float_class_inf) {
                 /* N - Inf */
@@ -582,10 +581,6 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             a->cls = float_class_inf;
             return a;
@@ -602,10 +597,6 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
  return_b:
     b->sign = b_sign;
     return b;
-
- p_nan:
-    *a = partsN(pick_nan)(a, b, s);
-    return a;
 }
 
 /*
-- 
2.43.0


