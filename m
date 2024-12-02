Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233CAD7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6G2-0001nm-0L; Mon, 02 Dec 2024 08:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FR-0001k5-Rf
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FN-00035p-05
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:13:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so39681755e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145231; x=1733750031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URx6rpKRY5AUX4gzx0lKGV+i3UM8kCWTj0TBxOydcdc=;
 b=O7m9zpbN2DPxmcZbsn6LPt/+K9/bV1JOIi6pi+n8B9VyKtb4jI+EQUFqqFo743nDo5
 BBIffUv1VAGlFYSK8YL7i6YVilyYvm8zZQDVZWIzATyNpugW39AAssflmm5poebNgMXK
 OyXS6aV0KbBzo+lF017vFb0WF21mPh+bf65D7t/GBku2GQzi9ISskMxmnR0q/2x+PbcG
 gclCsxtLh8Zi+ul2U8x/Jv0Qnn7BDrf70ToqPcgLeqKH+xynq5mYpX9/EYz2KmSCdRku
 Ekbaw1DwSdT13+ZsB2P5fpXbS/Y9sVZVkb01LlH9nHS3Z1ArEeh1WZgOhJ86oe030afe
 gxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145231; x=1733750031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URx6rpKRY5AUX4gzx0lKGV+i3UM8kCWTj0TBxOydcdc=;
 b=IQxt7ohZEC0RSpwGMrurLd03/DwIToavn/l2liok9oUphpvrE/Y2b8wZPmjagkap4/
 64ur0lo5rsJ2TOu3avO5wHlEfcOB3quHNZE9URN/mwMAxdtXJXfvDWCyw6P4DrZzYbTU
 A+9Lty7AEjRlpustqZ+rlOYj7oZriXa8o7LqNSyjF5s6zdhUxVFoBrV9+fLSBXQGWiZt
 fktL2eJTo5RT+vnZwrYGc+oYkjRyyAmP7QU9YlPXtXEDp1eFqB51VqKApUTIJKiJRffa
 lEnfZB7xD+p4Sl2kA2F7ERiS7iWg0R/VUyH0MH2NPYXbJ59f6Xul3Li4isO8aSdpRFTq
 m6IA==
X-Gm-Message-State: AOJu0YwPM0DHszqLwuyhKnhYbCQS3kNlsn1LVYa6CthyJeRaGOE8/4wS
 2Vk/WT5wf5bF+wzvZvgXCQlm48F/QFC8+v9pWrluvatSusS5tnxJeeriCzoc+ICGz27W0CuHAKg
 E
X-Gm-Gg: ASbGncuHIQB32VHOV1lUC/x0Vd+gK8kBzRmJ7/pDeJ32DZbp1c4IdUtNAHqBOI95m7/
 aHe6M5Ca1XzKAZMcjUuEBtMuPNzviD3DV3rXLhu5/S5hRtjc/uR6rcAM1FZoXbGtPQt0J8H17OL
 lZlwXZqC7RzQ/pS1jGSEvWmAgnUfKkAwybwXH7EJ/YaXhOM/Gxcqo0iQ4elpYhxgGdn22UzDTj4
 BHUN6PgT8iu2I4vA6fOWOWWSUUxvNTo2I7eK5yHGkebyO1SZHhkK/4=
X-Google-Smtp-Source: AGHT+IGTnHUdbOMrbpzVCxLquKG7nOzVVR+6pJz3DvC2xGSbU9WIxVPWyJnqr0N/OahjZZ5fVRRMkg==
X-Received: by 2002:a5d:64ae:0:b0:385:f220:f779 with SMTP id
 ffacd0b85a97d-385f220fb3cmr3997762f8f.49.1733145230928; 
 Mon, 02 Dec 2024 05:13:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 01/54] fpu: handle raising Invalid for infzero in
 pick_nan_muladd
Date: Mon,  2 Dec 2024 13:12:54 +0000
Message-Id: <20241202131347.498124-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

For IEEE fused multiply-add, the (0 * inf) + NaN case should raise
Invalid for the multiplication of 0 by infinity.  Currently we handle
this in the per-architecture ifdef ladder in pickNaNMulAdd().
However, since this isn't really architecture specific we can hoist
it up to the generic code.

For the cases where the infzero test in pickNaNMulAdd was
returning 2, we can delete the check entirely and allow the
code to fall into the normal pick-a-NaN handling, because this
will return 2 anyway (input 'c' being the only NaN in this case).
For the cases where infzero was returning 3 to indicate "return
the default NaN", we must retain that "return 3".

For Arm, this looks like it might be a behaviour change because we
used to set float_flag_invalid | float_flag_invalid_imz only if C is
a quiet NaN.  However, it is not, because Arm target code never looks
at float_flag_invalid_imz, and for the (0 * inf) + SNaN case we
already raised float_flag_invalid via the "abc_mask &
float_cmask_snan" check in pick_nan_muladd.

For any target architecture using the "default implementation" at the
bottom of the ifdef, this is a behaviour change but will be fixing a
bug (where we failed to raise the Invalid exception for (0 * inf +
QNaN).  The architectures using the default case are:
 * hppa
 * i386
 * sh4
 * tricore

The x86, Tricore and SH4 CPU architecture manuals are clear that this
should have raised Invalid; HPPA is a bit vaguer but still seems
clear enough.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 13 +++++++------
 fpu/softfloat-specialize.c.inc | 29 +----------------------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index cc6e06b9761..d63cd957a19 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -66,19 +66,20 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
                                             int ab_mask, int abc_mask)
 {
     int which;
+    bool infzero = (ab_mask == float_cmask_infzero);
 
     if (unlikely(abc_mask & float_cmask_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
-    which = pickNaNMulAdd(a->cls, b->cls, c->cls,
-                          ab_mask == float_cmask_infzero, s);
+    if (infzero) {
+        /* This is (0 * inf) + NaN or (inf * 0) + NaN */
+        float_raise(float_flag_invalid | float_flag_invalid_imz, s);
+    }
+
+    which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
 
     if (s->default_nan_mode || which == 3) {
-        /*
-         * Note that this check is after pickNaNMulAdd so that function
-         * has an opportunity to set the Invalid flag for infzero.
-         */
         parts_default_nan(a, s);
         return a;
     }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 9bca03c4aed..c557c41b2af 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -480,7 +480,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      * the default NaN
      */
     if (infzero && is_qnan(c_cls)) {
-        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
         return 3;
     }
 
@@ -507,7 +506,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
          * case sets InvalidOp and returns the default NaN
          */
         if (infzero) {
-            float_raise(float_flag_invalid | float_flag_invalid_imz, status);
             return 3;
         }
         /* Prefer sNaN over qNaN, in the a, b, c order. */
@@ -529,10 +527,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
          * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
          * case sets InvalidOp and returns the input value 'c'
          */
-        if (infzero) {
-            float_raise(float_flag_invalid | float_flag_invalid_imz, status);
-            return 2;
-        }
         /* Prefer sNaN over qNaN, in the c, a, b order. */
         if (is_snan(c_cls)) {
             return 2;
@@ -553,10 +547,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
      * case sets InvalidOp and returns the input value 'c'
      */
-    if (infzero) {
-        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
-        return 2;
-    }
+
     /* Prefer sNaN over qNaN, in the c, a, b order. */
     if (is_snan(c_cls)) {
         return 2;
@@ -576,10 +567,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      * to return an input NaN if we have one (ie c) rather than generating
      * a default NaN
      */
-    if (infzero) {
-        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
-        return 2;
-    }
 
     /* If fRA is a NaN return it; otherwise if fRB is a NaN return it;
      * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
@@ -592,14 +579,9 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         return 1;
     }
 #elif defined(TARGET_RISCV)
-    /* For RISC-V, InvalidOp is set when multiplicands are Inf and zero */
-    if (infzero) {
-        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
-    }
     return 3; /* default NaN */
 #elif defined(TARGET_S390X)
     if (infzero) {
-        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
         return 3;
     }
 
@@ -617,11 +599,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         return 2;
     }
 #elif defined(TARGET_SPARC)
-    /* For (inf,0,nan) return c. */
-    if (infzero) {
-        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
-        return 2;
-    }
     /* Prefer SNaN over QNaN, order C, B, A. */
     if (is_snan(c_cls)) {
         return 2;
@@ -641,10 +618,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      * For Xtensa, the (inf,zero,nan) case sets InvalidOp and returns
      * an input NaN if we have one (ie c).
      */
-    if (infzero) {
-        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
-        return 2;
-    }
     if (status->use_first_nan) {
         if (is_nan(a_cls)) {
             return 0;
-- 
2.34.1


