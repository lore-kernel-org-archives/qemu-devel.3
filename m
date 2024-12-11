Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0380E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRk-00008V-Va; Wed, 11 Dec 2024 11:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRj-00006n-1f
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRh-0007bx-32
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-435004228c0so31037455e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934015; x=1734538815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jjHu6tm+33f5za7B2UGWHozRv7iZoKjmmA7yl7uJ0xo=;
 b=tAMPGuUWzdM8ngPSBx/yyajeIjOUwscAYBPGvLUNhePqoQkkhWTRLKRiUTozpF2jNR
 w0cA1EqiQGn5V0TZwtGlCTUZa4xdPT1bXx5RyH36ZuQ2tTdWDymNlRr9OjWAe4T4LNDj
 1/LmVzGF07YPYAs/IU3AIA7m6TTWCLdoGcLnjp4ETJZHvU0KDYlos33R+td7gBqqFkq7
 Ecc9q9xIgBsGQSOHV71EcY8P7449p0CWA95UME4FLLFGArf39hCBiZ7rcGb4UO5VFk+x
 LqFjkN40kHPWm5+a/7WNSzfLtGufHrYlMz3P3LlmIFO7kDYqyBZA6v4b6N7y2Le9H1pi
 Zk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934015; x=1734538815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjHu6tm+33f5za7B2UGWHozRv7iZoKjmmA7yl7uJ0xo=;
 b=TWkw1xCUuF8ijk8qpMmqqXAKlshcdmZC6Siokgza4yuYiHCGEgLOep1Ii1B2r6sCaj
 e3aZkxKBNFP0JINTeHsZB6g+QrQfBWilkFR22UYWm8njNbRw8wHlwwGUQrkqO2tRkVvD
 8LVRw4lI+tVAMKhPeVBWTH1zez/8gIObRKH30E6F6NQ3iT1mgt+uUaRni6+dExPQB0+T
 rZ1YigkDfN4spDdQnlKhLT3UE1o5kdnMdtvKgQWa7fHFFec701q5nWO/GsZpFLu/3Tif
 mN1sGNKya5DlB02HLNo8bQBTbdzc6yip4+Y7mGMi8X4cGuEXXj0hlopxIAnCQGKSasEo
 Uw4A==
X-Gm-Message-State: AOJu0YxH6OEYfZ/zD19GWCgBdHFj5PuFdgyBlUtLIPf+m/3Me/GgEv8v
 82S8jt7bshAvqCOzvQaD7HuZLSeUaCEdi4zEE42xXCZ2+3uXS9nLyFm4O6Qc5P3Qlkz+1cS4QOA
 S
X-Gm-Gg: ASbGncs/C6mIvGp36US406HSbQT0QliY6Y/adiVN30ZS1BWoBSD858vvb32P+fJQGEV
 5rrOSNAWQgqukF9JcIwY/l1jTZmVLWAIvHPgaIX2QfntQ83DIN1KTrZzRXKMCkGLWuC9Nl/BsRQ
 SOoIWE9sXLOyMOcPIfAjrGMJDlKiU9Oi+ZmeJ+9qw6+XfjeJkUsxnvPUKJc5sb652WmGo70pGPn
 r0qy7DiEUJnNQ883UYMTWgTcadmsSR3eKam/hNdtT23cye7aa7kHJ1hf72F
X-Google-Smtp-Source: AGHT+IGpSiIlOwwOGpD9QdeTRVNqSQ35bjP7TfDX2WZAdrluTSM1pP+boDuo9zKhqOuM4yPuWgK2hw==
X-Received: by 2002:a05:600c:c18:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-4361c43d6camr25181595e9.28.1733934015350; 
 Wed, 11 Dec 2024 08:20:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/72] fpu: handle raising Invalid for infzero in
 pick_nan_muladd
Date: Wed, 11 Dec 2024 16:18:58 +0000
Message-Id: <20241211162004.2795499-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Message-id: 20241202131347.498124-2-peter.maydell@linaro.org
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


