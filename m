Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A996E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSr-0001gP-Og; Wed, 11 Dec 2024 11:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSi-0001Jz-PJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSh-0007t4-4t
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so69482385e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934077; x=1734538877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nWq50s5wH/Zfni782SA5A5nzRTm2bkE87fiXY9DTnyA=;
 b=hDX/nE5/zQ/yWDY0eCH39etUxC6jwOhn5Vw4Rdu5Usd09ZLsKEKIGf1M/j39/c5XvH
 BUFdUg17X2Jk1w4BCcsSWU2lDdCKQS6b1L4mqS2egy79gZc4/JfGAtzB6hxiPbKCzQX8
 WqFL9eRCUXVehlw1KIxMZb7w8dDdmMe7KvAcvFWeSEB+BDbLI3lfSLBgaBTwjLwoH/l0
 cO7iSJL3wnAoOgojmCiNfH/EZobln+btaHlMhQv3T5RZw5942vASC5FMDH3MQ7TggBKD
 nsPsoLMnr/bcpw5XxvD+tarvRWukn/DUXD3w/SfqRDiDxHwzI9lHrTG6/mrKcaha1CeF
 NjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934077; x=1734538877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWq50s5wH/Zfni782SA5A5nzRTm2bkE87fiXY9DTnyA=;
 b=k+oCO9sFyjsJmeg6DZWKz1VNc6EljmRxgHsJUUggJlyedMj5XseHE1Gdn0i/DrnAe2
 JKbIzLsuZlLC1meJni9mi/bEpiQsB5wsRIlmMg/lzqIB3j7jPFXxawkSKTmdjkgbTGix
 4qGr1m3utws7mRz7ljCdZMbVf/Nt3r1OWhgbLKYNLLDSTKQ2gW1W1kzhDHKivIDJyuV0
 xdZvEO1PeqAIbbDQLBmATCBRAt+P5zBR1r3zsr/3MSNzAb28z4fZb8ySzoHFPp6Phs5J
 Z12lhI09ICEKEnyBxomqve8yfCoXNssUFF4q7hou9HDURA+lI1R+agvK8qNaZNqJvwnO
 k5xA==
X-Gm-Message-State: AOJu0Yxq2ns7gSIO845t89TfK66RJPHawxBOUvdVqvBPwoVE/teF+Una
 NXQ0FZ7KPa8hRPjKbSjUSySUmLO0DLxo6uW0dFnsyJ8/TZelDGku2gnEzhsNel2O7zRvho2y5vB
 2
X-Gm-Gg: ASbGnctZHi/ZCeNpR9p4ToLWTPujJ9iur9rgq4sLjoLRB+ZWtBaAkr5VSgetUJvDI2E
 VhySBd9n8ng5tG1djezOBTaCINgZ5sX9rMVNmi93OaxqCTtfLJs9aKminDQ5vEXr5pDRUgdWdRq
 +wg/Gsc6+6M2Aka+HDcGGmaC7pDI0XWjTv/KbCUJvBIhEThxoI+fy8eL4JYGD9Wbi8yqWmELd5V
 r6HZWtRUdvdDQ/KBwigWlOexR7Lt/oNRHSrBLxAAswuAeEYKjIKmrjUiT5X
X-Google-Smtp-Source: AGHT+IFxIiQdJi6eFRTobRpLNJOEOn3bnn/blBD86qCndjgESTcKhiQEW35oT0P70Lz8AvPTyufpHA==
X-Received: by 2002:a05:600c:4511:b0:436:1bbe:f686 with SMTP id
 5b1f17b1804b1-43622863994mr2808905e9.21.1733934076689; 
 Wed, 11 Dec 2024 08:21:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/72] softfloat: Use goto for default nan case in
 pick_nan_muladd
Date: Wed, 11 Dec 2024 16:19:54 +0000
Message-Id: <20241211162004.2795499-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove "3" as a special case for which and simply
branch to return the desired value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241203203949.483774-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index c1a97c35b20..be7e93127d4 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -85,7 +85,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
          * But if we're not in default-NaN mode then the target must
          * specify.
          */
-        which = 3;
+        goto default_nan;
     } else if (infzero) {
         /*
          * Inf * 0 + NaN -- some implementations return the
@@ -93,17 +93,18 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
          */
         switch (s->float_infzeronan_rule) {
         case float_infzeronan_dnan_never:
-            which = 2;
             break;
         case float_infzeronan_dnan_always:
-            which = 3;
-            break;
+            goto default_nan;
         case float_infzeronan_dnan_if_qnan:
-            which = is_qnan(c->cls) ? 3 : 2;
+            if (is_qnan(c->cls)) {
+                goto default_nan;
+            }
             break;
         default:
             g_assert_not_reached();
         }
+        which = 2;
     } else {
         FloatClass cls[3] = { a->cls, b->cls, c->cls };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
@@ -123,11 +124,6 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         }
     }
 
-    if (which == 3) {
-        parts_default_nan(a, s);
-        return a;
-    }
-
     switch (which) {
     case 0:
         break;
@@ -144,6 +140,10 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         parts_silence_nan(a, s);
     }
     return a;
+
+ default_nan:
+    parts_default_nan(a, s);
+    return a;
 }
 
 /*
-- 
2.34.1


