Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B4DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhKk-0000dk-Jk; Fri, 04 Jul 2025 10:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIA-000502-98
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:32 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI7-0005Q4-IV
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:29 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2efc0ed41efso403637fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638885; x=1752243685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CvnYhdClMbhruEBotoxV/Si4Ta54uQOuX2WFi9R0V0=;
 b=UX6PdGV/ZFIMkpM1pUk5Y0BJaIH+zz4o311IvRfnJkjhjdeqiQSOibwenV0csP+LZu
 uL9jcIQHRSf3N1LSO7MDkTr1hcf+f//1gukPD7Ejyd2LSraQTI2w1jwdVXVCFbEVtrFL
 yVmq6vRPuW3c+vEhoSXeexxSk6xal916N2x7K5kJv9X1KvqNa652CiFldnBo+9zcCRHY
 qTPcUe/mYgJ9uokyG8g/eMtCh/beUdu+fsq3qoEQADIJW0fYDV618GgE09kZ00X649M1
 UZrdfsafO7Szrogf9Q3Fht25FjnU/wXz8AXzVvsUTK4YxuaXEj8dXQ5rm7J5OR8SCHe5
 eGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638885; x=1752243685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CvnYhdClMbhruEBotoxV/Si4Ta54uQOuX2WFi9R0V0=;
 b=oAgVRPPnPR7LZxJL/VK+Rei+LDqrjeFID3f7NlbX50vpkFrV76N8d2kNojcS/yKqu/
 spdKxGUmIew0otacSBDtIR2ZqBqfKfmSaJraj09S1ztHFbXYfIYEp6os3SNYURIVwmRR
 1Bq6/rKYb7uNGQSqTgcWoqVWJTWJ3A1UDnMEm/rQ7GHJJ+NB/2qJrSeHWSICUs42eJJy
 xYo4NvOp3J45rrHFEKN24d15h00ZqdIizpU0aGNNSHJCAV0Sl9nTq6aVEjFjGm3MV0pH
 OblkFBfsFsaULPLhlteOIxyCohtrPw5wSO8KXrDJW7QYrq2okeNszZ9tmOj34nddHsxG
 T+XQ==
X-Gm-Message-State: AOJu0YwNsfjACzFv+lsGBNknA4tC40PtWNdF5PnDeJ41ieovz+rRBNF9
 BPtvOQBeGYLORXbpDmSqKDwzNLJgV1weyCIhbB//MKhvv1f1KXvKblsJI6fiqtB7/bKeAiIHVkm
 JtNh+78Y=
X-Gm-Gg: ASbGncvt5EjALNNPf0yqxhAaAf8Hl7Vl/qf4EZqbQBANJ8XN4DZKADH8l+WtlDuya0q
 PNl4BwnWZh1g4kuAyofBaxW1wgCI2KOH2CFSPATTlC66Liq5zsBFHhpJ/ALiWDluiN3cHQ7CY64
 ZwO26bPVRQMVn85AlS9vC1n9VGM0+0RxRWR/TmV4LLYXFtVly56C8hJ22Oc+MD9qbvhE4vEYTey
 Jx1buCsdRWD1p0vsB+59W9OfEmy0Ref16UJAt0/aQQaNG7dTTJPCNOJZcQcWfIYN6GxfHPPhnrr
 bQA0UUCUyMSl4K6fk7bKe3ByPasCCvk1vlWIuFIwQewSFf8X4IyjsyiWHGo2WkEPi3DOMPT0kKJ
 WZfHWCc5pSEXo5Ac+MMa0q2olguwUnBin5dZpavrZVC3DtVlY
X-Google-Smtp-Source: AGHT+IH1NfTc1UxZ6awm2+MboMpIQKkdBqVgfpBqh/UfWsawdLoz7Kh1EtAURJedl0ZkybZAvCEuiw==
X-Received: by 2002:a05:6870:ebcd:b0:2c7:6150:fff7 with SMTP id
 586e51a60fabf-2f796ce49bcmr1769357fac.35.1751638885391; 
 Fri, 04 Jul 2025 07:21:25 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v4 009/108] target/arm: Fix bfdotadd_ebf vs nan selection
Date: Fri,  4 Jul 2025 08:19:32 -0600
Message-ID: <20250704142112.1018902-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Implement FPProcessNaNs4 within bfdotadd_ebf, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 0e1850182a1 ("target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 75 ++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 986eaf8ffa..3b7f308803 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2989,31 +2989,62 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
-    /*
-     * Compare f16_dotadd() in sme_helper.c, but here we have
-     * bfloat16 inputs. In particular that means that we do not
-     * want the FPCR.FZ16 flush semantics, so we use the normal
-     * float_status for the input handling here.
-     */
-    float64 e1r = float32_to_float64(e1 << 16, fpst);
-    float64 e1c = float32_to_float64(e1 & 0xffff0000u, fpst);
-    float64 e2r = float32_to_float64(e2 << 16, fpst);
-    float64 e2c = float32_to_float64(e2 & 0xffff0000u, fpst);
-    float64 t64;
+    float32 s1r = e1 << 16;
+    float32 s1c = e1 & 0xffff0000u;
+    float32 s2r = e2 << 16;
+    float32 s2c = e2 & 0xffff0000u;
     float32 t32;
 
-    /*
-     * The ARM pseudocode function FPDot performs both multiplies
-     * and the add with a single rounding operation.  Emulate this
-     * by performing the first multiply in round-to-odd, then doing
-     * the second multiply as fused multiply-add, and rounding to
-     * float32 all in one step.
-     */
-    t64 = float64_mul(e1r, e2r, fpst_odd);
-    t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+    /* C.f. FPProcessNaNs4 */
+    if (float32_is_any_nan(s1r) || float32_is_any_nan(s1c) ||
+        float32_is_any_nan(s2r) || float32_is_any_nan(s2c)) {
+        if (float32_is_signaling_nan(s1r, fpst)) {
+            t32 = s1r;
+        } else if (float32_is_signaling_nan(s1c, fpst)) {
+            t32 = s1c;
+        } else if (float32_is_signaling_nan(s2r, fpst)) {
+            t32 = s2r;
+        } else if (float32_is_signaling_nan(s2c, fpst)) {
+            t32 = s2c;
+        } else if (float32_is_any_nan(s1r)) {
+            t32 = s1r;
+        } else if (float32_is_any_nan(s1c)) {
+            t32 = s1c;
+        } else if (float32_is_any_nan(s2r)) {
+            t32 = s2r;
+        } else {
+            t32 = s2c;
+        }
+        /*
+         * FPConvertNaN(FPProcessNaN(t32)) will be done as part
+         * of the final addition below.
+         */
+    } else {
+        /*
+         * Compare f16_dotadd() in sme_helper.c, but here we have
+         * bfloat16 inputs. In particular that means that we do not
+         * want the FPCR.FZ16 flush semantics, so we use the normal
+         * float_status for the input handling here.
+         */
+        float64 e1r = float32_to_float64(s1r, fpst);
+        float64 e1c = float32_to_float64(s1c, fpst);
+        float64 e2r = float32_to_float64(s2r, fpst);
+        float64 e2c = float32_to_float64(s2c, fpst);
+        float64 t64;
 
-    /* This conversion is exact, because we've already rounded. */
-    t32 = float64_to_float32(t64, fpst);
+        /*
+         * The ARM pseudocode function FPDot performs both multiplies
+         * and the add with a single rounding operation.  Emulate this
+         * by performing the first multiply in round-to-odd, then doing
+         * the second multiply as fused multiply-add, and rounding to
+         * float32 all in one step.
+         */
+        t64 = float64_mul(e1r, e2r, fpst_odd);
+        t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+
+        /* This conversion is exact, because we've already rounded. */
+        t32 = float64_to_float32(t64, fpst);
+    }
 
     /* The final accumulation step is not fused. */
     return float32_add(sum, t32, fpst);
-- 
2.43.0


