Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64E1C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhMY-00057H-2Z; Fri, 04 Jul 2025 10:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI8-0004zD-Qs
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:31 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI5-0005Oq-5j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:28 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2f75f1c7206so363548fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638884; x=1752243684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfwmDf3/yL1RuRZgQLbRD4ioWrvuc1PHMAmmtaTrtA8=;
 b=fgfE3BC7qkG3PEH5pGXO6BoEj7VAQZtiwtw8QUySekQ4yJ4JyyAEzzZitaa8BRxNY9
 AMmmTx4g6g92ccsbN7vlwGr2+D6/6A3tY9K/nJLDSMc7vZQSmbOzpdHHO/SGVGFRq83n
 S2p6KhLCsjJIT7z70Hxo/6rV62aPqIIIVaU8y0P8s/VSR2Fz1969QYSDwhlKXYZ0/AQQ
 MSFdrUJUeUIZ9EbsatAmm8EE5oEicVUpIw7AQCZF+TgLS81P2o2xaO8tgjvxvqTb8Ae/
 anFmvaN0+9tqYSGl8KCU3KCiE/oO43ZeBQYlyHgwoUnB0qBCXTA3U0yz27whMfryqgKu
 85Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638884; x=1752243684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfwmDf3/yL1RuRZgQLbRD4ioWrvuc1PHMAmmtaTrtA8=;
 b=S1ZvxRmHzUdBaVbzJzW2vZ+b/F4jujuGlCyc/rbGTPR2PD4sTIUTFBGVTEYyVtTDpT
 Zj3S9bKEsXDkNsAnqwzOk3tG/eIrpEGf4uA3CvbWB4CW+GMsvGJENHtPD4xPF/u/dse6
 DmRJWPEjrm8+9qglF+r+vpcZHmkOhLC3yTfpCkaBjwJUBWgPOOV/Xg6u//LTcI4M7wH2
 QDPyefNwtEivEDTZSVROOFHp9MuJdUxfECKZEJGBp/JEwcdaRzYPdZFnMEoXh81YPHzV
 lAC2YTzJq/VubiwAWN+AbuYREfX8xXIGCoZzoefxi/5axTkI6iCuwjm9qaRnxC12MvVd
 Clyw==
X-Gm-Message-State: AOJu0Ywq4HocoayURbXZHXroeravRD/eF+Ds0wr1RDPyDus4f+uJoruF
 KbtrDwuxDS/SeTH4wiRlkTHJZQfwzBtg/0kwy7Ft+c8lQge230LLEpNIyZ77HfDqEK1qX/xpxHR
 YQActqDA=
X-Gm-Gg: ASbGncuGxhRKryjtP+44TpiJ/z++UeO0k/Xwu6tuobHlmBPwfEiPB9eEd1Bjfa2aQfO
 6bIPj3/w2esstz6YewSXsdf0TDmsuQHdfLZwu2jXMwbLi6s0UsDfaHX5FABtuEXZLET2kk+vY4T
 c1Wfg8tFtrqhcmnWnC8i89DsjlmmOBXCMus8JiXNVlfKv98bUzF1lak5iJD/YyjP1/EoE5O6ykT
 IeHca8RLuhVJXojr7Isp01kjxiQJgskBdQgQWP1fAunWrdBIOJnZxxkJK9bbr4paP3RkL4y3nBE
 T2hDZVUe8v1VW+ny8uRJbwlVIOGt1d/8ZCmucw6X9paBGNKaOMvZLRLdJ6/SS3xJB4B5Gr22KtM
 ZtVOTrx1PljkKEXJrKnp3tyIGoz/ncD7pnzJcfBgjlklu2kqV
X-Google-Smtp-Source: AGHT+IF2EiS2Vxv5WDDApOVLg5Ch3vC2oNqi97o+T5VRfHtUPFLHuiU+rdYsg4iBfQZTk2U43VCpsw==
X-Received: by 2002:a05:6870:a351:b0:2d9:45b7:8ffc with SMTP id
 586e51a60fabf-2f796a7b418mr1595963fac.3.1751638883993; 
 Fri, 04 Jul 2025 07:21:23 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v4 008/108] target/arm: Fix f16_dotadd vs nan selection
Date: Fri,  4 Jul 2025 08:19:31 -0600
Message-ID: <20250704142112.1018902-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement FPProcessNaNs4 within f16_dotadd, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 62 +++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index de0c6e54d4..8f33387e4b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1005,25 +1005,55 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
      *  - we have pre-set-up copy of s_std which is set to round-to-odd,
      *    for the multiply (see below)
      */
-    float64 e1r = float16_to_float64(e1 & 0xffff, true, s_f16);
-    float64 e1c = float16_to_float64(e1 >> 16, true, s_f16);
-    float64 e2r = float16_to_float64(e2 & 0xffff, true, s_f16);
-    float64 e2c = float16_to_float64(e2 >> 16, true, s_f16);
-    float64 t64;
+    float16 h1r = e1 & 0xffff;
+    float16 h1c = e1 >> 16;
+    float16 h2r = e2 & 0xffff;
+    float16 h2c = e2 >> 16;
     float32 t32;
 
-    /*
-     * The ARM pseudocode function FPDot performs both multiplies
-     * and the add with a single rounding operation.  Emulate this
-     * by performing the first multiply in round-to-odd, then doing
-     * the second multiply as fused multiply-add, and rounding to
-     * float32 all in one step.
-     */
-    t64 = float64_mul(e1r, e2r, s_odd);
-    t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
+    /* C.f. FPProcessNaNs4 */
+    if (float16_is_any_nan(h1r) || float16_is_any_nan(h1c) ||
+        float16_is_any_nan(h2r) || float16_is_any_nan(h2c)) {
+        float16 t16;
 
-    /* This conversion is exact, because we've already rounded. */
-    t32 = float64_to_float32(t64, s_std);
+        if (float16_is_signaling_nan(h1r, s_f16)) {
+            t16 = h1r;
+        } else if (float16_is_signaling_nan(h1c, s_f16)) {
+            t16 = h1c;
+        } else if (float16_is_signaling_nan(h2r, s_f16)) {
+            t16 = h2r;
+        } else if (float16_is_signaling_nan(h2c, s_f16)) {
+            t16 = h2c;
+        } else if (float16_is_any_nan(h1r)) {
+            t16 = h1r;
+        } else if (float16_is_any_nan(h1c)) {
+            t16 = h1c;
+        } else if (float16_is_any_nan(h2r)) {
+            t16 = h2r;
+        } else {
+            t16 = h2c;
+        }
+        t32 = float16_to_float32(t16, true, s_f16);
+    } else {
+        float64 e1r = float16_to_float64(h1r, true, s_f16);
+        float64 e1c = float16_to_float64(h1c, true, s_f16);
+        float64 e2r = float16_to_float64(h2r, true, s_f16);
+        float64 e2c = float16_to_float64(h2c, true, s_f16);
+        float64 t64;
+
+        /*
+         * The ARM pseudocode function FPDot performs both multiplies
+         * and the add with a single rounding operation.  Emulate this
+         * by performing the first multiply in round-to-odd, then doing
+         * the second multiply as fused multiply-add, and rounding to
+         * float32 all in one step.
+         */
+        t64 = float64_mul(e1r, e2r, s_odd);
+        t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
+
+        /* This conversion is exact, because we've already rounded. */
+        t32 = float64_to_float32(t64, s_std);
+    }
 
     /* The final accumulation step is not fused. */
     return float32_add(sum, t32, s_std);
-- 
2.43.0


