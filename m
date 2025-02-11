Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0EEC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5U-0006S5-FS; Tue, 11 Feb 2025 11:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5N-0006PM-3o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5L-00033e-66
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:08 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so18793955e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291165; x=1739895965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FqaQg++LCytft5147IVD/040K0ax8ufWG2wwf4dmJvw=;
 b=r8377NMr5yWFt2/Inf8WLmM8Jl/LwBYjbRouBBvWRtXZUCdna/tPuJ+uk9IvnhsnKd
 hSaCY6lkQ+X6XwVsjp/lapBiAh+BMREdwuU8g3i9wuQDSqNZaEsV3OYNpGOJRgexE4l6
 bCFdcppmR6eSrc6hBtwmB+rOFXoNmjxGCA02HE82949Z3q93swi+Eha1/vhcAX7Qs4r/
 +jrYa7G1FfWIBtBRq2O+fN5NI53XnrZr2PKCW0vXBFkFpWmdcREp/QF1UnZvyI0YAN1h
 icaQ0luo3I20oghrF7HZTAy20IWm32yp+7yCpaNZUHWVIK+Q5f3zdcUbN+mD/h9l/DMr
 k9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291165; x=1739895965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqaQg++LCytft5147IVD/040K0ax8ufWG2wwf4dmJvw=;
 b=ot746o57PmPRyIzF8lQXEjY/WDlJOGHbIa7JOsvjN3LC2wftTyIG77k+b7Sb2RFIg8
 XZiCDSMTJiCF20Eb4vHeEdLaYqCW5UYFz2rYLW+zuDQL1+oLHn4+HdP2g+jRhTW1wlnf
 s21fn72Y3DhF8gidtyuV1KUyOPJqvU2DxBr1rULZKMXRoN/Ns9I496D8qP3LI2pedjiX
 +cSWV7nPCWSJtl/oyyULWVjSzFmZtycoTlFxO7Bdm7dXIwC7DbmzBD1aJY9UCZGKWKJ1
 68DmAlAbUhqVK5PpfthGYc7o9BJbIemxL3xJV4Iz6Ji/I0vV9GwCD70cZ1B6W9qUrNn5
 yNAA==
X-Gm-Message-State: AOJu0YzQiG0tLWRwO3gfVdRLy7TjXdLQDiLYOINGPDOeugQxPfmR+JPa
 WSVNKFjXEOHkM0Y86mtgWfry3qS4ev6CBicEDwO0quZ3MvmRdafJOHUkcj3GEDQXxu+2KULtf/Z
 x
X-Gm-Gg: ASbGncuzDkYcNlgbSX2HlP6LvJ1j3kn9zyb/TBnmw9Alx/pTjfvvwG25MKM6/JEokLx
 4w3GcIaKnYl8CGt3s8sZvI5d02vRNXMwlgkgR3QzQd9Oyt35iDaYfNaOu/FzmJmuFwqvzI0pprZ
 FiI7rb7uJzYbdmYuJLpvF6IuFJb4Shmi47U+Hyo8SA2qJQxiMvDM8UXLDKvCQ9nkdJRfbNJigB0
 g1Yj383RnVc6o7qXri32JeVfyZ3kCcHb+f0Hhk2Yq2dVCUHkc5IdpA43OEealLjsWgVHtpdH5cy
 ExhJXk/gEdydOkrSPjCU
X-Google-Smtp-Source: AGHT+IFRBzTpM869by61MNb5g9RnDmMjHjUkj2d+JzvlmXjp29jlEg7rPwgNkO97RY86MxAA5Y4foQ==
X-Received: by 2002:a05:6000:1ac7:b0:38d:e078:43a5 with SMTP id
 ffacd0b85a97d-38de4188ee1mr3779656f8f.13.1739291165543; 
 Tue, 11 Feb 2025 08:26:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/68] target/arm: Adjust exception flag handling for AH = 1
Date: Tue, 11 Feb 2025 16:24:54 +0000
Message-Id: <20250211162554.4135349-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

When FPCR.AH = 1, some of the cumulative exception flags in the FPSR
behave slightly differently for A64 operations:
 * IDC is set when a denormal input is used without flushing
 * IXC (Inexact) is set when an output denormal is flushed to zero

Update vfp_get_fpsr_from_host() to do this.

Note that because half-precision operations never set IDC, we now
need to add float_flag_input_denormal_used to the set we mask out of
fp_status_f16_a64.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ef85c186f17..62b86d56b8e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -78,7 +78,7 @@ static void arm_set_ah_fp_behaviours(float_status *s)
 #ifdef CONFIG_TCG
 
 /* Convert host exception flags to vfp form.  */
-static inline uint32_t vfp_exceptbits_from_host(int host_bits)
+static inline uint32_t vfp_exceptbits_from_host(int host_bits, bool ah)
 {
     uint32_t target_bits = 0;
 
@@ -100,6 +100,16 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
     if (host_bits & float_flag_input_denormal_flushed) {
         target_bits |= FPSR_IDC;
     }
+    /*
+     * With FPCR.AH, IDC is set when an input denormal is used,
+     * and flushing an output denormal to zero sets both IXC and UFC.
+     */
+    if (ah && (host_bits & float_flag_input_denormal_used)) {
+        target_bits |= FPSR_IDC;
+    }
+    if (ah && (host_bits & float_flag_output_denormal_flushed)) {
+        target_bits |= FPSR_IXC;
+    }
     return target_bits;
 }
 
@@ -117,7 +127,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 
     a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
-          & ~float_flag_input_denormal_flushed);
+          & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
      * Flushing an input denormal *only* because FPCR.FIZ == 1 does
      * not set FPSR.IDC; if FPCR.FZ is also set then this takes
@@ -129,7 +139,8 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
         a64_flags &= ~float_flag_input_denormal_flushed;
     }
-    return vfp_exceptbits_from_host(a32_flags | a64_flags);
+    return vfp_exceptbits_from_host(a64_flags, env->vfp.fpcr & FPCR_AH) |
+        vfp_exceptbits_from_host(a32_flags, false);
 }
 
 static void vfp_clear_float_status_exc_flags(CPUARMState *env)
-- 
2.34.1


