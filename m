Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B3CC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWRL-0005pT-VQ; Mon, 24 Feb 2025 06:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR2-0005n4-6s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR0-00018x-5S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4399deda38cso25180025e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395737; x=1741000537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqXeXRoWaJ3QKZJ6jrqg2FahLEljcBiEpPgYa/U9aIk=;
 b=sjMPmDmdrCOEQ6VEueSOQo39KclZbLqFrPryYe666ds4ttMtUGNjoFZ8rYJBwYiEOC
 6Hj+wC4OD2hncJJ6J0aOh3uyE3a87Z35Zvsb8NzAaew3uGT169hhF4yJttt8En9wDgua
 goRst6ORbDgsQE/zxkR7iG1e4LR8oyRfYF1/VadcipK7UIDY//94A+o7bjUMIOimhQdI
 0I9jQpXnXtY663elFTxn1oDgT1iaUqVTo88IwtsGjkClZ/JHH2DBshO38gBRwHYB2nqi
 Clmo5bRLo5zhm/GVAzKVR+Fw3kLVJtItAvG7tOI/WlPiigI4/Sc49wuce3+aW577o2lx
 o57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395737; x=1741000537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqXeXRoWaJ3QKZJ6jrqg2FahLEljcBiEpPgYa/U9aIk=;
 b=VPVJ8MppsywdpI1IfBRbeuGg6UPn/T8HiZTfnxAjXxtO9TERyaMkPiYI2wit1/PlW0
 HxZNy80RwAApas1GbojE5iRfmGeZLWDBjm4cO0TfiBpoOGyabweG9B0CRJ1hSiw7AAuO
 R5miaySeVp40bqOuh1rjhhtjY460tmyWf6YQgeGkwwVQz4Zt3t3O4FEBcvl5st3QC3RJ
 LoNglQMqmRxJR1drXHequwhG3aCkwmrqq3GXYqpg361LNgmZOOSJUTIa33hJy9gBYsy7
 xmGy9P5CWjHo+fL+geGyPqWdE49PNHx6dqZVUtA0GVzesB38IFUvaLUt+Zrj1Rlp50A7
 TQ5Q==
X-Gm-Message-State: AOJu0YximThg6U2+kv4AY/XN8BNY5G8Ad10+PlTon2dqg+ysmJ3/1neN
 Fq1D0Nz7JOWWysXjYZcJT94dM7xDgR4Yb1i17EpWf081T8o0VuPGwF5wYXyFYvDDcLy7GiGOH8+
 m
X-Gm-Gg: ASbGncv0ACRS+tlM32VVzCe0o96t0O/lVB2pvLAoCDxbKcV1Gt91ZCN+x3GF4QFFUA2
 nvIXY5dWEF70WA74gr5saaSdwQbrLBAufYxuEeF19JfIu1VdrBY1yXq55YXVroNUBmTaZQZThGn
 u6z1QI5NY1Qa3mTdyNIcPHnWPVzI2kC9bXdZSpV/nH4Z11BEtBtdSp9VZofJnaFE/cm8gi26FDe
 sU0TK7K8yVX543o+G/4AERgetWyYgCuCqVv34V6LpiEYKCYY8tTwuYvgC8NbrTMRFKUWprcoXhl
 /x55yk9lpBhSG2j2C7/Dh+7my0up+8Oy
X-Google-Smtp-Source: AGHT+IHKrUtm8nDC4mB4T6pWXNR12sBYJkdtlG3hQTtihGebc/UngvQ0QcxmY3WbZeJGyujLi7NmuA==
X-Received: by 2002:a05:600c:5246:b0:439:9c3a:bba7 with SMTP id
 5b1f17b1804b1-439ae21d280mr98358935e9.28.1740395736631; 
 Mon, 24 Feb 2025 03:15:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/12] fpu: Move m68k_denormal fmt flag into
 floatx80_behaviour
Date: Mon, 24 Feb 2025 11:15:20 +0000
Message-ID: <20250224111524.1101196-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250217125055.160887-7-peter.maydell@linaro.org
---
 include/fpu/softfloat-types.h | 19 +++++++++++++++++++
 fpu/softfloat.c               |  9 ++++-----
 target/m68k/cpu.c             |  3 ++-
 fpu/softfloat-parts.c.inc     | 27 ++++++++++++++++++++++++---
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index b1941384aef..1af2a0cb14b 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -349,6 +349,25 @@ typedef enum __attribute__((__packed__)) {
      * and using them as inputs to a float op will raise Invalid.
      */
     floatx80_unnormal_valid = 8,
+
+    /*
+     * If the exponent is 0 and the Integer bit is set, Intel call
+     * this a "pseudo-denormal"; x86 supports that only on input
+     * (treating them as denormals by ignoring the Integer bit).
+     * For m68k, the integer bit is considered validly part of the
+     * input value when the exponent is 0, and may be 0 or 1,
+     * giving extra range. They may also be generated as outputs.
+     * (The m68k manual actually calls these values part of the
+     * normalized number range, not the denormalized number range.)
+     *
+     * By default you get the Intel behaviour where the Integer
+     * bit is ignored; if this is set then the Integer bit value
+     * is honoured, m68k-style.
+     *
+     * Either way, floatx80_invalid_encoding() will always accept
+     * pseudo-denormals.
+     */
+    floatx80_pseudo_denormal_valid = 16,
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
index 505fa97a53f..2617d8f6ede 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -139,7 +139,8 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero |
                            floatx80_pseudo_inf_valid |
                            floatx80_pseudo_nan_valid |
-                           floatx80_unnormal_valid,
+                           floatx80_unnormal_valid |
+                           floatx80_pseudo_denormal_valid,
                            &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1d09f066c5d..171bfd06e3a 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -195,6 +195,25 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
 static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
                                  const FloatFmt *fmt)
 {
+    /*
+     * It's target-dependent how to handle the case of exponent 0
+     * and Integer bit set. Intel calls these "pseudodenormals",
+     * and treats them as if the integer bit was 0, and never
+     * produces them on output. This is the default behaviour for QEMU.
+     * For m68k, the integer bit is considered validly part of the
+     * input value when the exponent is 0, and may be 0 or 1,
+     * giving extra range. They may also be generated as outputs.
+     * (The m68k manual actually calls these values part of the
+     * normalized number range, not the denormalized number range,
+     * but that distinction is not important for us, because
+     * m68k doesn't care about the input_denormal_used status flag.)
+     * floatx80_pseudo_denormal_valid selects the m68k behaviour,
+     * which changes both how we canonicalize such a value and
+     * how we uncanonicalize results.
+     */
+    bool has_pseudo_denormals = fmt->has_explicit_bit &&
+        (status->floatx80_behaviour & floatx80_pseudo_denormal_valid);
+
     if (unlikely(p->exp == 0)) {
         if (likely(frac_eqz(p))) {
             p->cls = float_class_zero;
@@ -206,7 +225,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             int shift = frac_normalize(p);
             p->cls = float_class_denormal;
             p->exp = fmt->frac_shift - fmt->exp_bias
-                   - shift + !fmt->m68k_denormal;
+                   - shift + !has_pseudo_denormals;
         }
     } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
         p->cls = float_class_normal;
@@ -342,13 +361,15 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         frac_clear(p);
     } else {
         bool is_tiny = s->tininess_before_rounding || exp < 0;
+        bool has_pseudo_denormals = fmt->has_explicit_bit &&
+            (s->floatx80_behaviour & floatx80_pseudo_denormal_valid);
 
         if (!is_tiny) {
             FloatPartsN discard;
             is_tiny = !frac_addi(&discard, p, inc);
         }
 
-        frac_shrjam(p, !fmt->m68k_denormal - exp);
+        frac_shrjam(p, !has_pseudo_denormals - exp);
 
         if (p->frac_lo & round_mask) {
             /* Need to recompute round-to-even/round-to-odd. */
@@ -379,7 +400,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
 
-        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !fmt->m68k_denormal;
+        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !has_pseudo_denormals;
         frac_shr(p, frac_shift);
 
         if (is_tiny) {
-- 
2.43.0


