Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9E0C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGXi-0005zT-Rz; Sat, 01 Feb 2025 11:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXd-0005wh-Tw
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:21 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXa-00011c-6I
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso34946405e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428016; x=1739032816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ym/Vy7W5OhXOIql5igOUJixOoYcul6MX/px8OEpWdqU=;
 b=mYNjs+/065wWgqOUBjJFxgD0DHflfggBeDnHnLUayjxUEV1MWeouQ6bYOxcz7pjupV
 is4Y4iNdhswPmfXBYPm8igzLxng3580TqAtLI59d8JxTf8e+K7jXRj6vPxg55O92dV92
 qlaBqfn0KxJq2i/Ca+fzlbg9LdIF8HtXYMR1P8Njh9Rcqg6MggcqocUHp7IbG+ldcVMz
 AvUFcdrnKs8SryLd+j4xq90PL8tdAuGxfByRp/cUHBUTLDICCbcyEdGl+4F+Kmv4rZDa
 yHeQo41MOtdyg+OASLZ5XaXTjyxjgrZWPXpLB4EjTM02+Dt8UxuPJUG9C4HDCI88zZHr
 MDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428017; x=1739032817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ym/Vy7W5OhXOIql5igOUJixOoYcul6MX/px8OEpWdqU=;
 b=k4wUTqBL3jIY6X/GfRUV3K1YLd9iVGNqwjQzFwUkpT6qD2BUdgtXaEhuET6TC1W440
 uD0izbkpszimaNvM1918leCPDyaCdP2Px3j5Vcsv4Fw2yj24bXiBmPgnkdCfNv5OrqBJ
 xctvs85FHzJiBf/WbHh5Gekb1kEeeVf7SVYVSIAN8A2o1TaLpIeKasblhFJ9zgHoVdJE
 qNtg1zNJfGtj/c6RCQ1krfZvJDkwNOIdzcYfigv10I8iFiP1YoT2x0Anp6A8UkGQvw1G
 sXYdgsJKEyK92oC59L0iRhxeBZjayK6hDiyVWld9wDInLuFt4vsGM7d5wRRwgxMCMt6W
 6nNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfIURiCu3s8yO2SUloQHb5HkOxMnW/XShn7Itmt5Sxk2yhwW/jmKfkDKDbZjQaFxZvhuhPhOYsUWiZ@nongnu.org
X-Gm-Message-State: AOJu0Yw+wr9hyzEJFGSB5yFsE+zs8fKwW9+4E5lcLbUkCqCXhNNybv8z
 ZuB5eZozKKsSVmw9b6wJAe28Rc8+4DAJqA5eT91novXatlF6kTZvrKOke7ieQLzkkzpGEjmniuL
 v
X-Gm-Gg: ASbGncsyfwhnh6WNKIA+23vMkM7kvHrH4qjq2GesWDHLNtKnkSOlDike65BWKU/Xj1M
 mRaysnpA2DeBewgR0fYOba0Uu2Ae7fccEXlESwB93bBoiHqRtilH+qn3bm5frzbnfK4Ccemdu8O
 VEdSyVZgK3t/GOSrndMu7CSf0sVy4QvqcBm1e1Vs/JdLgpYn43y2pC4i4nkJYU1uc9H8ZgceCmk
 +HVqJ8pv1igc5GkJADi4g1YWg/TQMfP7E6NWdfGACT/7lLURNlLAtMg0nkmdtv+f0GrOow9Da6U
 3Olc9e/FwucW/qROPzH1
X-Google-Smtp-Source: AGHT+IHOrhbdM9WIZFIaJaiI23fakxU017f8BDYBPuorHI4elEh95dDcMIlipCr2HufR8qWzoFUQhg==
X-Received: by 2002:a05:600c:35d3:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-438dc3c3790mr142804375e9.7.1738428016585; 
 Sat, 01 Feb 2025 08:40:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/69] target/i386: Do not raise Invalid for 0 * Inf + QNaN
Date: Sat,  1 Feb 2025 16:39:04 +0000
Message-Id: <20250201164012.1660228-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
index 616c290145f..c177923e319 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -280,11 +280,21 @@ typedef enum __attribute__((__packed__)) {
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
index 3d764bc138d..de6d0b252ec 100644
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
index fee05d0a863..73621f4a970 100644
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


