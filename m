Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5777AC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO0T-0004uV-7h; Thu, 16 Jan 2025 06:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO0P-0004tG-5A
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:25:46 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO0K-00047z-Rb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:25:43 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so1166241f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 03:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737026739; x=1737631539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDPF+4K2rDn9TxZs98v9wgYutJWTgJoEDlnBGph0wf8=;
 b=ZhxFmAb1RcZ5ooJWnNEe29MPaph+aB9pfEzNnXRysnrtu5Lo81Bf3QO9zea0fJCMcZ
 +/xSlw0rtNAnMRGUOILYXZNFcFFctdVrJ7iGWm9QqYbu6rmZVF3cOFmcyEKYt31ewe9D
 YydOFb57Ofic+6c/vceogay+8/tFFTv9DRWIO1j2mSRo3sZ2fa9UWoYnVUICkoRQfpLP
 i2EgFjlGu5epWH8APsmQWKnEEKozLYZGymMS6uvCJAbHIt0tVR+ARbCMaZ1cKWfoEg4Y
 MdtbanjLKbO+Qz3lcCTJxlMJcaCG+sv7HRljcJB9cQN6FtEvn6/sMs18hQYx80Y5QstL
 Idng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737026739; x=1737631539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDPF+4K2rDn9TxZs98v9wgYutJWTgJoEDlnBGph0wf8=;
 b=npwzf1NRfannk/LgHpdCE1dnfB4PZMW7r0536B0v1bSJR7KpZnj3DqAUtqo7G2/IEE
 pz0eNJBa5FyGk6wodsSnI327y6ggLQjdKVFzuhqx8bmnR+UDW/vd3VYXnga3ahJNBO6I
 a773Iq9RUe/cEhc0ENDP3J1Wd3NIvMj4UYrL2os2caBH3cVR5W93V0/XlBlJova0q8bV
 JRp0oTJZFLFejSiHWPTnPnBZNmqq1pqlJ9g9KkQvLJCCWy4q6mImzp8PYT9MzZDl+zbn
 0qcyVqfhYmyzZJUqG/GgRp6Ux3pV0Iz5oYofbRhAFK/YcbUrN/AlG2sF56m11IakiFg+
 k7Mg==
X-Gm-Message-State: AOJu0Yzcq2IjCq9CFxLTMor4EQpstbWSe01YlXx7F30dUHRwy6alhjeH
 XLLJt4ryV8SclFSxMuDrZxsoz5X/HB+wwXUxsApb6Eo5XaMsa6oo6lcQHvHYS+wqEFbJPUhvIzj
 /
X-Gm-Gg: ASbGncvNBbytCdbjAU3l8t5/vDzVRKndFhOLmsrYuKC+q+yfnE1mTH2T5Eu1GWmoJ5h
 lCe+9yKyKsogsG4ezKxgtVHf3NLt6ZBdFEJphVSTLk4tItOx0pSLVgzVYX/M+OUqXiplEasIHBO
 lMlgh+GP75CjJ/143Hoo5jmS5s/fJMw2omAwBbHwfTRlZuyhni69ehM2dX5AendOi81lt19pHKH
 YuJRVd0E9d8Vg2P4esACrCsGNqWTf1jMulGK2qNcUZux3L6lFUzNBqvo4ORSak=
X-Google-Smtp-Source: AGHT+IGmArGGCeZOyZVsrhA0puUe690n5AOrvO5UzI3Kvdwje1JoW/xY+8y4DABlVfjUSgMg6B0lQQ==
X-Received: by 2002:adf:9cc4:0:b0:386:3afc:14a7 with SMTP id
 ffacd0b85a97d-38bec4fb4ecmr1462522f8f.7.1737026739043; 
 Thu, 16 Jan 2025 03:25:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm20636654f8f.10.2025.01.16.03.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:25:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] target/i386: Do not raise Invalid for 0 * Inf + QNaN
Date: Thu, 16 Jan 2025 11:25:35 +0000
Message-Id: <20250116112536.4117889-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116112536.4117889-1-peter.maydell@linaro.org>
References: <20250116112536.4117889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
index 9d37cdfaa8e..c51b2a5b3de 100644
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
+    float_infzeronan_suppress_invalid = (1 << 7),
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


