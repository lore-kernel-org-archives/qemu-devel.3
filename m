Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12C3C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYG-0003jD-5p; Fri, 24 Jan 2025 11:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMY6-0003Vo-Rk
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:52 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMXy-0005LJ-HY
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so16737145e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736120; x=1738340920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aZAtVcMAZKjHRvt52hIevKlBELo2Ys5/XXx3UpdxpVg=;
 b=KKDa7+LROzcessQPiB6IqGJhJMGxrlkhFDa83Iobu+rOPy2vqNu+6fwEW6nPuIUhoS
 EQCTqjuNetmlryARHaDbFv7ZoyvCtgoZ7cdfWeD6J3tUEtuwFrYe/JaI6SqsNObarZDz
 xVwRIXecz6UxOssb1QBRK6E2qbgEbBIFxpVQSwXRV5rFdo738NGjyEPs/s0gpqXwicQn
 iopuWzdXp7kivGwS3onsOwyyY+c6BO11FWnWrCafCIRBFUteGRokPn8shm0StY6tgBGX
 7sa5DagaSBHm+0ZuO/8+tkOrDKtNwlyUbqr+z695tJVhI0jJh2rVV6v07PwN8y/5R67s
 R4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736120; x=1738340920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZAtVcMAZKjHRvt52hIevKlBELo2Ys5/XXx3UpdxpVg=;
 b=V5nPs5SwgWGczV5U6Rv6XalKMa8bLc+Z3SQ4HJ4+yjI9o8EC5kuQRggdCdc+X+Dexj
 gHrNOmIo5cvWBMu7YsGovSHmBVq+eQ4GFzZGi+sNb4S5YZ7sVhF3xNo4SVvW/IXel7Wy
 NnX7a43Lk7XsxI/puGUKXmWDQRL2qSEGnqHC+InAj2PSuZyjYafRa3QisYQRW9Er2CpK
 XPUa5V5aubyclxZEE7gVY8icvGaboy5gIeuIl3lpYModwuiP2pPM3wuD7HgcoM9jkzSN
 9AMvsUvN/9JNd0En4ubsSuCSYfAFMIIWjN03ae18G7sdTKCHLJvS0L2QR9e0G9rk4bTr
 rq0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNGY1FOWc6EG4Mq+a0VWfVWMt0TLgmKj2ceTQA8X8HFv9raK5GJ2WdrmoHUerq6Qak0ALyLqTsD1zn@nongnu.org
X-Gm-Message-State: AOJu0YxMbZGEor3pYYbQkm4RkqFuc/6cuw215ElRGIvAaDWZ4vI8YgRe
 lIaANU71Psmz0xnBWukiGs0dkkJIGRTAGyiw8qcMmZUXF3N91oU07vkfw68iLvk=
X-Gm-Gg: ASbGncusKH/wLdqIB5bQKu+4UI/T2xiouBIpqczDfSqbgvmgXm+ExrrDz7F4JGI2w4n
 JTqhzrjBGuUciL5KFF9nl8bsTtXgf1u3xFe13eXNgadGJZWqB89u9vEOqfpPidVsYf2onhsZUN5
 gKNkgSlPxaHX3OOW5Hh6pzg35gk0mVz7DnvR9NAYvCn4BxLSiUO/vZs7qjGMmfq/9LOluXGizLT
 uwjZXZ2KWgPb6+8PzzcOGKBEFypIE7a+m3zN9nhoUwVujjh8ynNB4QY6AdhtWg4GvVftMtJCy9k
 nGDUPtpbDY4=
X-Google-Smtp-Source: AGHT+IGOUZjXYEuNBjIYqkBLzOOpKGr8pLMeXLweYoHO20oLo58xfpwgqJrYKA+05weulzWov6tu6w==
X-Received: by 2002:a05:600c:1d1d:b0:434:faa9:5266 with SMTP id
 5b1f17b1804b1-438913e79e2mr281251225e9.13.1737736120003; 
 Fri, 24 Jan 2025 08:28:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/76] target/i386: Do not raise Invalid for 0 * Inf + QNaN
Date: Fri, 24 Jan 2025 16:27:21 +0000
Message-Id: <20250124162836.2332150-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In commit 8adcff4ae7 ("fpu: handle raising Invalid for infzero in
pick_nan_muladd") we changed the handling of 0 * Inf + QNaN to always
raise the Invalid exception regardless of target architecture.  (This
was a change affecting hppa, i386, sh4 and tricore.) However, this
was incorrect for i386, which documents in the SDM section 14.5.2
that for the 0 * Inf + NaN case that it will only raise the Invalid
exception when the input is an SNaN.  (This is permitted by the IEEE
754-2008 specification, which documents that whether we raise Invalid
for 0 * Inf + QNaN is implementation defined.)

Adjust the softfloat pick_nan_muladd code to allow the target to
suppress the raising of Invalid for the inf * zero + NaN case (as an
extra flag orthogonal to its choice for when to use the default NaN),
and enable that for x86.

We do not revert here the behaviour change for hppa, sh4 or tricore:
 * The sh4 manual is clear that it should signal Invalid
 * The tricore manual is a bit vague but doesn't say it shouldn't
 * The hppa manual doesn't talk about fused multiply-add corner
   cases at all

Cc: qemu-stable@nongnu.org
Fixes: 8adcff4ae7 (""fpu: handle raising Invalid for infzero in pick_nan_muladd")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-types.h | 16 +++++++++++++---
 target/i386/tcg/fpu_helper.c  |  5 ++++-
 fpu/softfloat-parts.c.inc     |  5 +++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 9d37cdfaa8e..d8f831c331d 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -278,11 +278,21 @@ typedef enum __attribute__((__packed__)) {
     /* No propagation rule specified */
     float_infzeronan_none = 0,
     /* Result is never the default NaN (so always the input NaN) */
-    float_infzeronan_dnan_never,
+    float_infzeronan_dnan_never = 1,
     /* Result is always the default NaN */
-    float_infzeronan_dnan_always,
+    float_infzeronan_dnan_always = 2,
     /* Result is the default NaN if the input NaN is quiet */
-    float_infzeronan_dnan_if_qnan,
+    float_infzeronan_dnan_if_qnan = 3,
+    /*
+     * Don't raise Invalid for 0 * Inf + NaN. Default is to raise.
+     * IEEE 754-2008 section 7.2 makes it implementation defined whether
+     * 0 * Inf + QNaN raises Invalid or not. Note that 0 * Inf + SNaN will
+     * raise the Invalid flag for the SNaN anyway.
+     *
+     * This is a flag which can be ORed in with any of the above
+     * DNaN behaviour options.
+     */
+    float_infzeronan_suppress_invalid = (1 << 2),
 } FloatInfZeroNaNRule;
 
 /*
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index d0a1e2f3c8a..e0a072b4ebc 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -178,8 +178,11 @@ void cpu_init_fp_statuses(CPUX86State *env)
      * "Fused-Multiply-ADD (FMA) Numeric Behavior" the NaN handling is
      * specified -- for 0 * inf + NaN the input NaN is selected, and if
      * there are multiple input NaNs they are selected in the order a, b, c.
+     * We also do not raise Invalid for the 0 * inf + (Q)NaN case.
      */
-    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never |
+                              float_infzeronan_suppress_invalid,
+                              &env->sse_status);
     set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
     /* Default NaN: sign bit set, most significant frac bit set */
     set_float_default_nan_pattern(0b11000000, &env->fp_status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ebde42992fc..4bb341b2f94 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -126,7 +126,8 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
-    if (infzero) {
+    if (infzero &&
+        !(s->float_infzeronan_rule & float_infzeronan_suppress_invalid)) {
         /* This is (0 * inf) + NaN or (inf * 0) + NaN */
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
@@ -144,7 +145,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
          * Inf * 0 + NaN -- some implementations return the
          * default NaN here, and some return the input NaN.
          */
-        switch (s->float_infzeronan_rule) {
+        switch (s->float_infzeronan_rule & ~float_infzeronan_suppress_invalid) {
         case float_infzeronan_dnan_never:
             break;
         case float_infzeronan_dnan_always:
-- 
2.34.1


