Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736DACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbH-0005YE-0i; Fri, 22 May 2026 14:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbD-0005NQ-Vc
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbC-0005cG-5T
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ba6485d219so58752415ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474473; x=1780079273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAL0NWt9fknjtElvJKYUD//qbRuUXv5dAUd78LHy/Wg=;
 b=rJa6X6PV869hyEgtpC2ZtJKHLVtuGBajUGHRG69tAD9/ziyr2iXgLr6fGSH05KOBKd
 d0spzZ8AVroNrQI9kyxPckQ11uheOjOJU9JEZrEs+BVGNmHpc0nKsV2kejQTQL1MfK/5
 hZMxDXm39rwyPccUJ4zlFJ8uzGCj/+Tklaqb6+ihwfViOlxJ5i9AbYNxY7iy1aN4SaLC
 LCJum1Xc6j58nwlc8I+kZoDE2Pw8laJJNnJ0/K75zMqXXI9tD8cJZAnrA8htmg2DuMHC
 CvqEaf9VgMaFrXFeEgxSbl00YJODkfEEAbIGQMqQp44BV2363Eg4wWs9EFI4oQMe1k30
 TzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474473; x=1780079273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAL0NWt9fknjtElvJKYUD//qbRuUXv5dAUd78LHy/Wg=;
 b=KKUF+nnf/8CYURRYWVl+v/2ORcW7creSibZst8snZ5JmbC9tYTHp7Nc9x3o/vauEVP
 D++uVytmWPbAbCVHSegR4CO1PC+byNGl4OU6YPr12cjTmdTrAxu7XtBWEiLXjQEzL+2k
 pu1jsBTS5f19NHtIOhzfjuhsFOfM4q8FM8EyDosCz/CV4+iXenSWMt/ilpP70QoY4Avc
 9mDg4sHVcYENKXn+dcVTdkTuSKi3jT1QScZeLkj8SWQ1NMlLP8buuwuW12sso0xy472R
 bSd0eCy6OsAs7zr7jeZGFaqbhg/4YFBkK8uIznmDi9CEPxHXFWfNu2jus2czLLSVPcug
 i97A==
X-Gm-Message-State: AOJu0YxLYS+dllUs8uyZhznyjvvufNbJWGxlqlxxwrTB1DJ1mVRAp9dw
 tVLXle0x6Crfm9xuFcKIf80XnClkovt2TQ6nG/ntqzYArWsKB73UZ+wEw7T9cFMsM+RxSm1lrhd
 M4CTA
X-Gm-Gg: Acq92OE8LLm6Kf6zb33w1zo4z8eJ5gz8lRHxA1XMtrU7KzYQOuMBYUCyaxTmEISaC70
 UymtIzpN6b/Q/oOngU0xGJU1mHqYXT5GfJ8x5eHEqfGXmgXNXS5kAexIQLmdk3jwXqltfPLygZD
 VvutsgjhYncOJcNlvNyNoPi07utCKDnvRTKWf9/sn3fPqDn8ORv9aMd0fRjz6Y1AffMrx6S7ia9
 vnLuhsU8uzyXyaHVhRPKDLPHQaodmjkAKE89ji0JZxx46PKQ8woLNTE5Lh7BOFGV752nTLgkew/
 mMDWOZBIFtASpqMWqBkMjXKMZLdFdMrrE2nAwd9L1TuFOGettzFKEX2Mm88BdkBGOOwIhvcoEQp
 KpcdIumKuBHkekIFr8juQ+qAceHQYcqCfqH8I3B+SPMli6DQDp7z2TvPZsSAUddU1fnfpRokrN5
 FsmcxVxYh2DLjmMmP67FMyrPgGQATOJZPWcAvt6OM=
X-Received: by 2002:a17:902:e745:b0:2b2:4cd2:e16c with SMTP id
 d9443c01a7336-2beb05e413emr49999405ad.20.1779474472704; 
 Fri, 22 May 2026 11:27:52 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/30] fpu: Introduce float_status.e4m3_nan_is_snan
Date: Fri, 22 May 2026 11:26:56 -0700
Message-ID: <20260522182658.184604-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Introduce a separate control from float_snan_rule
that applies only to the OCP E4M3 format.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 +++++
 include/fpu/softfloat-types.h   | 5 +++++
 fpu/softfloat-parts.c.inc       | 2 +-
 fpu/softfloat-specialize.c.inc  | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 4791a7fc87..8df0273132 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -131,6 +131,11 @@ static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
     status->float_snan_rule = val;
 }
 
+static inline void set_float_e4m3_nan_is_snan(bool val, float_status *status)
+{
+    status->e4m3_nan_is_snan = val;
+}
+
 static inline void set_float_rebias_overflow(bool val, float_status *status)
 {
     status->rebias_overflow = val;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index c5a6684763..d7f5303a6b 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -431,6 +431,11 @@ typedef struct float_status {
     /* do we detect and flush denormal results before or after rounding? */
     bool ftz_before_rounding : 1;
     FloatSNaNRule float_snan_rule : 2;
+    /*
+     * Overriding float_snan_rule, is the single NaN representation for
+     * the OCP E4M3 format an SNaN or QNaN?
+     */
+    bool e4m3_nan_is_snan : 1;
     Float2NaNPropRule float_2nan_prop_rule : 3;
     Float3NaNPropRule float_3nan_prop_rule : 7;
     FloatInfZeroNaNRule float_infzeronan_rule: 3;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 184614ea47..559e40d196 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -246,7 +246,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
         case float_expmax_e4m3:
             if (p->frac_hi == 0b111) {
                 fracN(shl)(p, fmt->frac_shift);
-                p->cls = (parts_is_snan_frac(p->frac_hi, status)
+                p->cls = (get_float_e4m3_nan_is_snan(status)
                           ? float_class_snan : float_class_qnan);
                 return;
             }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b97c971ae6..8b765ef623 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -104,6 +104,11 @@ static inline bool get_float_rebias_underflow(const float_status *status)
     return status->rebias_underflow;
 }
 
+static inline bool get_float_e4m3_nan_is_snan(const float_status *status)
+{
+    return status->e4m3_nan_is_snan;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


