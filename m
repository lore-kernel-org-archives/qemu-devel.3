Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3DECD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JJ-0002Go-6J; Thu, 07 May 2026 12:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Io-0001uF-4N
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:18 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ik-0008Ay-Lx
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:15 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dca4debedaso1074124a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170213; x=1778775013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tno4FRdkKISmgYOrfh62o7rJBcHuyC+6/bmV3xDjQJQ=;
 b=W/EnVHkPhOKQ8NZjrgMZ6sXmgnFVe/D7mAlcbuWF1bQE/MmoKPycxUyvQOW+WbrTH/
 1DtcsxphxRqaM+stQtYBDQT0F89PFWv7+u4xo3ngDTLS3ooKB2Z4lW1Xo56nqUlgFC3p
 iMBBSonk8Gqzc3bs9OBk6jlPdmHplUXFThD4OGT+7rtnc2Xgdl5AjUZvx26Js6RrNwLE
 cJbPCRITMm8WmM89j1wsxXstBDT+AxTMEbP9Xm1tL6LluQxJHAkx+pOke0g0AjoKK7ZX
 u9vWxGJgJpDLr7sfSQ6VWqf1sl/0IFM36AOFiyO8AkjNGeyDr5PNkgindsNNZ7Nn1FX3
 olhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170213; x=1778775013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tno4FRdkKISmgYOrfh62o7rJBcHuyC+6/bmV3xDjQJQ=;
 b=RWd4WQtRGuR94kIWvrvqNbiqJ1RDbwcSQ1pPGULvunXhltg9bDbx1ngHYCLHL0J4lS
 Yl9nLMkWUfpCVw48kHahyElCvMqeY6fuA7b+G3rLvZQ+SXenD7IaoZpL/cmaEQ09zVzA
 lNj6rEB8zqfXMDRRywI/2wjdjlXUxfu0kHjiXjZ1zUuPVg9A4bboDCvG72iR4IReShkg
 an8jFeRa7QCa69zqEKN8n57b7jepgoKic6FNpDdhzmfpV02QTFQxnIMzzd6Gan8Jk9l5
 BZwl9FZjSNSUa6r9Jx1XGiW/fJU+xznFdVEhEPbU3K+5Chr8vE/6evr2akRRoXIR/hV0
 +Tdg==
X-Gm-Message-State: AOJu0Ywqtaa126lM8I8brnuWps3D/o3k2a7PXxUfR8kPwmxhTRMwVN1K
 KE9tvnMEWWCiQEb8TuMmVErbUNhtbdmUtvzksxpUSQXkOuklKaBVImnhPmJOWHFwqJeBpOsz+Sz
 1bNnv
X-Gm-Gg: AeBDietCxerI/tTuIJmD3RMOZgaTvzqUHnsX195+cY0XIvjHK/Toe/tYaErXq7cRWZT
 8m48VpFqwjXTPTIs8rVcb350AFLKymIN9+UQoZj7FyZ057xiXd2nfRAv5oF3ZIeHdcUPeVT+Oyw
 SYE1+vUQ5+42Mr6kxad/05aPB5UlcGmc5idtIO/e20hGL+rEcERFaUbEoR0VXNiFB5bMpxHvp9N
 V/hpiiA89Ni1Ch+Oxydm4M+6hZL/Dc0bwwBO18iNyv1QCH/5wqsgoAK1AiEd4uG/sajE7fsyd+k
 LVYQNssWNKYUkIZVEkrL4NdXAguDmuQLRFYJC2zAXOEgUoQt05Om/DjcfhBHRfUvVaEvTNiWBDd
 HqJRstm7C0eRPuoTtR+ou5az3mV95lWv0u6Ce4PXTqqKpCPSVjO6p0t/V3F79YoePhnISzqhXaU
 ctsL0YWMFmw385r/sMFBvzmLgK9DdoUV+DSuRVpUfzLTHP9u3v08i9A9Gt
X-Received: by 2002:a05:6830:67f8:b0:7de:51f3:e7ed with SMTP id
 46e09a7af769-7e1df210cdamr5452475a34.26.1778170213375; 
 Thu, 07 May 2026 09:10:13 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/11] fpu: Introduce exp_scalbn
Date: Thu,  7 May 2026 11:09:59 -0500
Message-ID: <20260507160959.449170-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Avoid exponent overflow as well as checking that we don't
lose information with opposing scaling.  Use it in partsN(scalbn)
and partsN(round_to_int_normal).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 17 +++++++++++++++++
 fpu/softfloat-parts.c.inc |  5 ++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6a14c5d639..a6ab3ee0f8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -601,6 +601,23 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.c.inc"
 
+static int32_t exp_scalbn(int32_t exp, int32_t scale)
+{
+    /*
+     * Catch chains of scaling which lose information.
+     * In particular, if the exponent has been saturated,
+     * do not allow it to become unsaturated.
+     */
+    if (unlikely(exp == INT32_MAX)) {
+        assert(scale >= 0);
+    } else if (unlikely(exp == INT32_MIN)) {
+        assert(scale <= 0);
+    } else {
+        exp = sadd32_saturate(exp, scale);
+    }
+    return exp;
+}
+
 /*
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index c5a828eb90..789a41d24e 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1107,8 +1107,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     uint64_t frac_lsb, frac_lsbm1, rnd_even_mask, rnd_mask, inc;
     int shift_adj;
 
-    scale = MIN(MAX(scale, -0x10000), 0x10000);
-    a->exp += scale;
+    a->exp = exp_scalbn(a->exp, scale);
 
     if (a->exp < 0) {
         bool one;
@@ -1632,7 +1631,7 @@ FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
     case float_class_normal:
         {
             FloatPartsN r = *a;
-            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            r.exp = exp_scalbn(r.exp, n);
             return r;
         }
     default:
-- 
2.43.0


