Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFD1C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b7-0001it-LY; Mon, 17 Feb 2025 07:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ac-0001cW-U7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aZ-0002G0-6x
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:10 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso46954215e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796664; x=1740401464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiePYr4R2lPPeGmP7plfEQSYVmoy1fTzZ+m/7c9OtK4=;
 b=OGPNK5PkIh9I+zB79BBL2qsrr5Sg4XfyAvJUzXrxmvMSkt9/VWkC34nrqcMtsoa4xn
 wEONP6XAhv5qx95uo1ruMVqaFY7JK22UVIijbIb+A7Ry+OqOW/cWxTh5CHsH+WAgcPNw
 wZoVlQf6KaY04MYLR3A2Lpj7aJCbdynMSAj90zkSnJMmNUPY9q32FmuhmrtOrWIZi/0L
 pGszgke2SuogTRSrXadfynqL+/7Fjm5RcvrlATgHxq5VTpCzOypb2FoGQGY9aY7rVW5R
 7S2O/ZI1eFXnfMd0qY9393ZtdjdoUwtTGm/hHlPSu0ORxtkC9QKcG4wIb1Igr5o5zGZ4
 4wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796664; x=1740401464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiePYr4R2lPPeGmP7plfEQSYVmoy1fTzZ+m/7c9OtK4=;
 b=WG9/VEriyAl78kFqezJL6NV+kMIcEbr/iLd4aHzITsWGO8F4XU/YW73eT25ZAbzJOL
 YKs5j62bq/slT3wFTNQFk2wkIsNAgoX6wqQc2NeN/fVoRq6pNxfj0WON2FyFLoZuK4L5
 QwX6kbV7jbWJI/AnKqVZyFB+Hs43a7D4BOGK0yXgKq3gpNXIU04kbseHEGGfuj9OZCW9
 luyI0GzMO/uYlrLa1cHWT+ymeXjxHLLtlb7CJVQCuybqLvwU4gOzPd26SOtUN3VJgPYy
 PL1Ib8MG3FI2DzGl5rZ7U3iCOAPYXicqUDCNsuaCkY9rB1w4Q1eS3147izJY08RqOACk
 bROQ==
X-Gm-Message-State: AOJu0Yxpt8Ynr7RS6Bss0CW4E2mONfGOjGi3UTj64tjdyDDLWVRZsni7
 urrFBpfP475FZTgaQHaEuvblfj3SNhihcNBFkZMetfjTxYjkAtzOkR+omK5kkeHZD4VdAKVzp8/
 /
X-Gm-Gg: ASbGncujPnY0ykEYaP5GOw0p2OR12kpeh+cuDNS5dztK3a2w5A+KhHTTtNRRyQH6BT5
 p70gRY02RlMKUIwZWn2Ejx0/6BL0q2+XKhbJtWqUg8U2LypjKlwCrbauKCdAKBrSd8DMe7dZFRJ
 9elRIUeLjVKBORm413J1358pX0X1WRccpkcGpw8F+vDUjwTJ7TJ8JxM4lGq46LeNOAse2znU9b7
 xbPopyQ/sirg/Pk0cnq3xbjGTrAGQx4yydeV1Zf7vbeoh6OZtuV6bOKAdDGbfHXzOw6kDLWO2Zb
 h9qEvsfoaWTvMyBtpDU2kg==
X-Google-Smtp-Source: AGHT+IElPVSunQDoj/LR1wcuGU5Drvuf/9A5RYMYQmgm9PQYjhi4/urSiFNfZQDg/wbJTds7Iu0Guw==
X-Received: by 2002:a05:600c:a384:b0:439:88bb:d023 with SMTP id
 5b1f17b1804b1-43988bbd481mr27389535e9.11.1739796663906; 
 Mon, 17 Feb 2025 04:51:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 06/10] fpu: Move m68k_denormal fmt flag into floatx80_behaviour
Date: Mon, 17 Feb 2025 12:50:51 +0000
Message-ID: <20250217125055.160887-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Currently we compile-time set an 'm68k_denormal' flag in the FloatFmt
for floatx80 for m68k.  This controls our handling of what the Intel
documentation calls a "pseudo-denormal": a value where the exponent
field is zero and the explicit integer bit is set.

For x86, the x87 FPU is supposed to accept a pseudo-denormal as
input, but never generate one on output.  For m68k, these values are
permitted on input and may be produced on output.

Replace the flag in the FloatFmt with a flag indicating whether the
float format has an explicit bit (which will be true for floatx80 for
all targets, and false for every other float type).  Then we can gate
the handling of these pseudo-denormals on the setting of a
floatx80_behaviour flag.

As far as I can see from the code we don't actually handle the
x86-mandated "accept on input but don't generate" behaviour, because
the handling in partsN(canonicalize) looked at fmt->m68k_denormal.
So I have added TODO comments to that effect.

This commit doesn't change any behaviour for any target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm confident this commit preserves existing behaviour, but
somewhat less confident that I've correctly analysed what our
current code does, in particular that it doesn't do the x86
mandated "handle pseudo-denormals on input" part.
---
 include/fpu/softfloat-types.h | 10 ++++++++++
 fpu/softfloat.c               |  9 ++++-----
 target/m68k/cpu.c             |  3 ++-
 fpu/softfloat-parts.c.inc     | 20 +++++++++++++++++---
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index b1941384aef..f57c7193653 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -349,6 +349,16 @@ typedef enum __attribute__((__packed__)) {
      * and using them as inputs to a float op will raise Invalid.
      */
     floatx80_unnormal_valid = 8,
+    /*
+     * If the exponent is 0 and the Integer bit is set, Intel call
+     * this a "pseudo-denormal"; x86 supports that only on input
+     * (treating them as denormals). m68k calls these a type of
+     * normalized number, and may both input and output them.
+     * TODO: currently we only support "handle on both input and
+     * output" or "don't handle and don't generate".
+     * floatx80_invalid_encoding() will always accept them.
+     */
+    floatx80_pseudo_denormal_output_valid = 16,
 } FloatX80Behaviour;
 
 /*
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2a20ae871eb..b299cfaf860 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -537,7 +537,8 @@ typedef struct {
  *   round_mask: bits below lsb which must be rounded
  * The following optional modifiers are available:
  *   arm_althp: handle ARM Alternative Half Precision
- *   m68k_denormal: explicit integer bit for extended precision may be 1
+ *   has_explicit_bit: has an explicit integer bit; this affects whether
+ *   the float_status floatx80_behaviour handling applies
  */
 typedef struct {
     int exp_size;
@@ -547,7 +548,7 @@ typedef struct {
     int frac_size;
     int frac_shift;
     bool arm_althp;
-    bool m68k_denormal;
+    bool has_explicit_bit;
     uint64_t round_mask;
 } FloatFmt;
 
@@ -600,9 +601,7 @@ static const FloatFmt floatx80_params[3] = {
     [floatx80_precision_d] = { FLOATX80_PARAMS(52) },
     [floatx80_precision_x] = {
         FLOATX80_PARAMS(64),
-#ifdef TARGET_M68K
-        .m68k_denormal = true,
-#endif
+        .has_explicit_bit = true,
     },
 };
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 505fa97a53f..b21813a1b96 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -139,7 +139,8 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero |
                            floatx80_pseudo_inf_valid |
                            floatx80_pseudo_nan_valid |
-                           floatx80_unnormal_valid,
+                           floatx80_unnormal_valid |
+                           floatx80_pseudo_denormal_output_valid,
                            &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1d09f066c5d..6abd6b28b85 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -195,6 +195,18 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
 static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
                                  const FloatFmt *fmt)
 {
+    /*
+     * It's target-dependent whether exponent 0 and Integer bit set
+     * is valid. TODO: the x86 manual says that the x87 FPU will
+     * accept these on inputs, treating them as denormals, but will
+     * never output them. However we seem to not handle them on
+     * either input or output. Also we think of them as denormal
+     * numbers for m68k, though that doesn't matter since m68k doesn't
+     * use the input_denormal_used flag.
+     */
+    bool has_pseudo_denormals = fmt->has_explicit_bit &&
+        (status->floatx80_behaviour & floatx80_pseudo_denormal_output_valid);
+
     if (unlikely(p->exp == 0)) {
         if (likely(frac_eqz(p))) {
             p->cls = float_class_zero;
@@ -206,7 +218,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             int shift = frac_normalize(p);
             p->cls = float_class_denormal;
             p->exp = fmt->frac_shift - fmt->exp_bias
-                   - shift + !fmt->m68k_denormal;
+                   - shift + !has_pseudo_denormals;
         }
     } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
         p->cls = float_class_normal;
@@ -342,13 +354,15 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         frac_clear(p);
     } else {
         bool is_tiny = s->tininess_before_rounding || exp < 0;
+        bool has_pseudo_denormals = fmt->has_explicit_bit &&
+            (s->floatx80_behaviour & floatx80_pseudo_denormal_output_valid);
 
         if (!is_tiny) {
             FloatPartsN discard;
             is_tiny = !frac_addi(&discard, p, inc);
         }
 
-        frac_shrjam(p, !fmt->m68k_denormal - exp);
+        frac_shrjam(p, !has_pseudo_denormals - exp);
 
         if (p->frac_lo & round_mask) {
             /* Need to recompute round-to-even/round-to-odd. */
@@ -379,7 +393,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
 
-        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !fmt->m68k_denormal;
+        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !has_pseudo_denormals;
         frac_shr(p, frac_shift);
 
         if (is_tiny) {
-- 
2.43.0


