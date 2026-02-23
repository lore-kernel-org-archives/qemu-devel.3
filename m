Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C560EE98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRD2-0002Bb-CA; Mon, 23 Feb 2026 03:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCz-00025f-Ed
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:25 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCx-000879-NG
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:25 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so35797585ad.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834942; x=1772439742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SssxklF3WDtpYf8gJiGXdyp/wnJOPYk1NXsSx2j5Wc=;
 b=V0LLneveYi+AT10tX7M+NQzmYsoNEPmAv/By05V4xxL/8ZNbkPfE2TmTE7lkssUOYF
 QLYLNRaBmyvwtIC07La3ObGQSx77Fcp1MzSIlIJJfSDPlLXONF9NhMKnoXBGcd1Z8eoo
 BxVCHRyVYExXOh8vukqbp25myQ1vBI67HiB/B05vrqo7IrwjGozGlyO/eO+xRTrQMCEY
 IJOJcXFvzr4dYMBsuCSxQAalV98s/qiKH0n5iObDuHTj+rwz6ugr7q/1NVm1lBn+KoZb
 hIK07uDZoUvp6IwiNdVmbWRA20FCMnj/bHli+p1h4Mq+zyeq+dOTxr8cVSkxGxMZGV8a
 Pg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834942; x=1772439742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2SssxklF3WDtpYf8gJiGXdyp/wnJOPYk1NXsSx2j5Wc=;
 b=bnDueKiW1RkUT3pEUr1HS6scCipsjBqVzr4n3jp373mOikCqjmTFNaPlyyOf0lpDXy
 YNB/geINJ3InMu4R9TSRbFNGmwF8ujV87r/+Nzr7zqeQFQmSYvTk7T8BvZAG3//FHo9z
 7QpjTP2Hi6A8L3eUwJj1ru3IgwIVqhsQddmRxSa7I15Po3XrcU5E/KQ6HZf/K58WgmXS
 v7Esb6+KmMNpPSPppBStbGR9MVyVeF7dn4y8UvvoBGrPvZONzk+dxOqKrFwLzrkhGJJA
 hgjYEUlNF+y28L7X4qdYUzfO20IHND5fPsdRJ1KRgf8NEeEJMkqiJv7IIoCPv5VyDUnn
 cX9g==
X-Gm-Message-State: AOJu0YxcGueBgIaWogNYWr1mQtlgLG7ND96+jnM9kQbruGTY8vAnyFBf
 QxcV3D9q2HzcFngwFYBdJN/E4VRVZUW1xBLJKlSPYBu2yQiaqQyD3xlCVYdT8JyaDfPwCECGLuP
 KX50oVDg=
X-Gm-Gg: ATEYQzyTwxtNTwfuwPp4xVayLczN0hBh3pC5wjWBV1o0v9GlvnCcLImhMWQaRJRurW6
 CU+c2UGnxNWsfOEe/NNUSjT/DB32Ipz9LLc1dd6IxbUGSXhIQUjy3Bdjkckeh/labxVZ2Y1/YGr
 fqaMrJ9Z1AcCTQUm8ADiXPIlDziUqoNRJVv2l39rqIDWUzuLzyXHjB3mA9CS1YsrfT2H2HVxzPT
 7PBb75Dtca9DCWELXCdTkXWxj8bVgdJxwlm9I7f0hbhSS+FfY8grlIDT4ZNikML6BYSDb5JB3Nn
 gOWPfH6h5fHkG00iVuZoiMw3qliDbuIUabznGC8fjUobzd7FzAS2kDQ5TlIT+lRHL0H9iEhfHrr
 JcNpD0NkIvZ0l20yZy/LTkYLkY5vDk5msMshpOvZojip39cHysiDZOCXWcXlYuN96Ab8nqcxtKO
 sDim6aRDxph2hmCh3+t+JPOFiaCz1m6g4+VnHJfuFmDRvOMq5CcV9OnzDVU1X5nCvxzA==
X-Received: by 2002:a17:903:1aa3:b0:2a9:6281:6a48 with SMTP id
 d9443c01a7336-2ad74537350mr69996165ad.44.1771834942082; 
 Mon, 23 Feb 2026 00:22:22 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 5/9] fpu: Add overflow_raises_invalid to FloatFmt
Date: Mon, 23 Feb 2026 19:21:50 +1100
Message-ID: <20260223082154.5623-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223082154.5623-1-richard.henderson@linaro.org>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

ARM Alt HP raises different exceptions on overflow than is
standard for IEEE when saturating a value.  Add a flag to
control this effect.

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 6 +++++-
 fpu/softfloat-parts.c.inc | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8d8e576757..9d06a1bb59 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -542,7 +542,9 @@ typedef enum __attribute__((__packed__)) {
  * The following optional modifiers are available:
  *   exp_max_kind: affects how exp == exp_max is interpreted
  *   has_explicit_bit: has an explicit integer bit; this affects whether
- *   the float_status floatx80_behaviour handling applies
+ *       the float_status floatx80_behaviour handling applies
+ *   overflow_raises_invalid: for float_expmax_normal, raise invalid
+ *       instead of overflow.
  */
 typedef struct {
     int exp_size;
@@ -553,6 +555,7 @@ typedef struct {
     int frac_shift;
     FloatFmtExpMaxKind exp_max_kind;
     bool has_explicit_bit;
+    bool overflow_raises_invalid;
     uint64_t round_mask;
 } FloatFmt;
 
@@ -576,6 +579,7 @@ static const FloatFmt float16_params = {
 static const FloatFmt float16_params_ahp = {
     FLOAT_PARAMS(5, 10),
     .exp_max_kind = float_expmax_normal,
+    .overflow_raises_invalid = true,
 };
 
 static const FloatFmt bfloat16_params = {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 455bbf281e..4909ff7418 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -348,7 +348,9 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             case float_expmax_normal:
                 if (unlikely(exp > exp_max)) {
                     /* Overflow.  Return the maximum normal.  */
-                    flags = float_flag_invalid;
+                    flags = (fmt->overflow_raises_invalid
+                             ? float_flag_invalid
+                             : float_flag_overflow | float_flag_inexact);
                     exp = exp_max;
                     frac_allones(p);
                     p->frac_lo &= ~round_mask;
-- 
2.43.0


