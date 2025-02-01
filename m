Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440E4C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGXt-00063r-RO; Sat, 01 Feb 2025 11:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXk-00060d-Lx
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXi-00013y-VL
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so30059885e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428025; x=1739032825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oHCiuj4JVKpkS58JWQkdgF532nZyU3vTNz6sMG44ioQ=;
 b=jC1uLzTi5nY8CQ9aAYShjn+1855uTel7O/C5avNtckpwu2X49UGAKcCxuZgUpUyhEs
 SszdxF8M7BSaJnIk31JOBnzaHh5KW0NhGrl6fT/hb4uw+Opep5jlw0QH528D/4vu7Yp1
 iWxluC1sAh1gVVAa23ZWklJePpaG68NJFF9A6wgr9GH+sE3Nd5IrYoZdckTlMeZcDV6t
 f44m0hIEZE4v1YshXedVzSoxszLVPD5hhJz57XUAseSUG4TA9t8HM9Vvly/g/2RUsAo0
 j08x4iTHm9JoKwn7auLHvBCtVss7vfLt33EpSyN3KBbjyW4b8AUXHKvwCwX59z9AtvJA
 rsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428025; x=1739032825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHCiuj4JVKpkS58JWQkdgF532nZyU3vTNz6sMG44ioQ=;
 b=q1Ywz+SihAYcVUtgKDlcTExgEJgKpWWJnG8/9SPPtkeE4mAw6VnKh38okMLwcL5QbP
 AM+KN6BMix0k61EoFW0h2GAgWF8e8Keg5Z+l1dbw7N1mzC5EKUlXZCVTMX4nXpFVekf8
 x69WoZvFNXm9h4XQDOBRCaZCE87REaPWT4raNmxxX1lb3du74lMymdkotr/QhzBXAkNG
 TDHd8fIuTzZQHejUSpikICWfdtw8o9AZQqE3IonlxlywQ6dnnfHg3FZ7wuj+KjBUc0UT
 jJNxaiaBYXCseU8C44NoUx1vSehjp97d5zOQ2NzZmzjuocAw/B7W4QAudl7X/6hHpx0H
 ILmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPfsmZsMv1B/EbXcZRDtlGC8dKagn/nhxiHUJRG3W++ssC4a1ZFalklRHFu4Si+d8CgJHP+2PbiZe@nongnu.org
X-Gm-Message-State: AOJu0YxX7V2BgBlKulNioDXPelvsXnuRWIce2cls40vdO9tPm6iNdtwi
 DPg9+eNSglYIMOR4q8eCX+mfj9OW+uWI6plNYk/tVf51QkRp2Ix2tmtOyNjti+Y=
X-Gm-Gg: ASbGncvzqb21gUTJyxesCfvwMhpnWdRZ/fxDBSEV7QzA3e7UwqzbHXA0MQAx5JYsuwk
 mu7Qs7F0X/pV4T9VL6bhpgDGeC7eZwclfiopQzsg5bL8MKsaeAUAWrVsD7Gnl2rN7YmyQPo3eEB
 VSUwAQXS23Ds5iw1DwBttL1EoXzC59j2P5vsIGrUCmvsg+G7qaYbCiFQiDkkvJ884SCtMtBmJhw
 4NzxQ6ohSH0o4SLcvVfRDQG7tUnz+wfks/LfHuwUZT6CvMyL5q7GrD6WfYyYxNjU+rbe0aiBnjJ
 kYTfXM7uoT8Gay5wmB5b
X-Google-Smtp-Source: AGHT+IGEHprhiKTLQjyeHfOhk5zFg7RKqTA2O/vxGQULYZfzO8+TGpib10tvlPEOQmVS2acVqUSY2A==
X-Received: by 2002:a05:600c:501e:b0:434:f297:8e78 with SMTP id
 5b1f17b1804b1-438dc3be859mr141987755e9.7.1738428025400; 
 Sat, 01 Feb 2025 08:40:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/69] target/arm: Implement FPCR.FIZ handling
Date: Sat,  1 Feb 2025 16:39:10 +0000
Message-Id: <20250201164012.1660228-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Part of FEAT_AFP is the new control bit FPCR.FIZ.  This bit affects
flushing of single and double precision denormal inputs to zero for
AArch64 floating point instructions.  (For half-precision, the
existing FPCR.FZ16 control remains the only one.)

FPCR.FIZ differs from FPCR.FZ in that if we flush an input denormal
only because of FPCR.FIZ then we should *not* set the cumulative
exception bit FPSR.IDC.

FEAT_AFP also defines that in AArch64 the existing FPCR.FZ only
applies when FPCR.AH is 0.

We can implement this by setting the "flush inputs to zero" state
appropriately when FPCR is written, and by not reflecting the
float_flag_input_denormal status flag into FPSR reads when it is the
result only of FPSR.FIZ.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 60 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 8c79ab4fc8a..30c170ecee5 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -61,19 +61,31 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
 
 static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
-    uint32_t i = 0;
+    uint32_t a32_flags = 0, a64_flags = 0;
 
-    i |= get_float_exception_flags(&env->vfp.fp_status_a32);
-    i |= get_float_exception_flags(&env->vfp.fp_status_a64);
-    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    a32_flags |= get_float_exception_flags(&env->vfp.standard_fp_status);
     /* FZ16 does not generate an input denormal exception.  */
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
+    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
           & ~float_flag_input_denormal_flushed);
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
+    a32_flags |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
           & ~float_flag_input_denormal_flushed);
-    i |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
+
+    a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
+    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~float_flag_input_denormal_flushed);
-    return vfp_exceptbits_from_host(i);
+    /*
+     * Flushing an input denormal *only* because FPCR.FIZ == 1 does
+     * not set FPSR.IDC; if FPCR.FZ is also set then this takes
+     * precedence and IDC is set (see the FPUnpackBase pseudocode).
+     * So squash it unless (FPCR.AH == 0 && FPCR.FZ == 1).
+     * We only do this for the a64 flags because FIZ has no effect
+     * on AArch32 even if it is set.
+     */
+    if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
+        a64_flags &= ~float_flag_input_denormal_flushed;
+    }
+    return vfp_exceptbits_from_host(a32_flags | a64_flags);
 }
 
 static void vfp_clear_float_status_exc_flags(CPUARMState *env)
@@ -91,6 +103,17 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
 }
 
+static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
+{
+    /*
+     * Synchronize any pending exception-flag information in the
+     * float_status values into env->vfp.fpsr, and then clear out
+     * the float_status data.
+     */
+    env->vfp.fpsr |= vfp_get_fpsr_from_host(env);
+    vfp_clear_float_status_exc_flags(env);
+}
+
 static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     uint64_t changed = env->vfp.fpcr;
@@ -130,9 +153,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
+        /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+    }
+    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
+        /*
+         * A64: Flush denormalized inputs to zero if FPCR.FIZ = 1, or
+         * both FPCR.AH = 0 and FPCR.FZ = 1.
+         */
+        bool fitz_enabled = (val & FPCR_FIZ) ||
+            (val & (FPCR_FZ | FPCR_AH)) == FPCR_FZ;
+        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status_a64);
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
@@ -141,6 +173,14 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
     }
+    /*
+     * If any bits changed that we look at in vfp_get_fpsr_from_host(),
+     * we must sync the float_status flags into vfp.fpsr now (under the
+     * old regime) before we update vfp.fpcr.
+     */
+    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
+        vfp_sync_and_clear_float_status_exc_flags(env);
+    }
 }
 
 #else
-- 
2.34.1


