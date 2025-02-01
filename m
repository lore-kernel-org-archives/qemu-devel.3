Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83603C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZB-0000aN-BO; Sat, 01 Feb 2025 11:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYo-0007Se-IO
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYm-0001MP-PZ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436202dd730so21764445e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428091; x=1739032891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HoNLO7yBRe54Mx81W03YzXvC/uBOlTA5jxKvJkJGICc=;
 b=Le4XMvzkEks2qcl3ZhdDHwbYdO7O4NV7sAEOXo54Z/mgSlZcFUg5abHzP2aMGRJ0Wy
 /fd33mX0VygZoWJYTXQ1NdCGa9uVfGeHlkH+9MQ0KjG3cwtd62TT2mbCGd1UHeFdFWad
 uj3/YbcOA7EWEG4IAh06+GPSmFQ8Z+aBXuE837RJH46J2QoyqCyjtQiJ4nw9D0azGu/R
 vhl4wFWyGhxfZrg9atuixk5dGCYsOP/x/XtOoz0v1gn8aZXomi/ViuSmxGHL5kTL6DMW
 i450C1ibMx1YuihIOTeC/Lv2fMwybDNZ8dF2QQXj7p7QsluHt7mBotM1FRazvO0Ri+2B
 cN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428091; x=1739032891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoNLO7yBRe54Mx81W03YzXvC/uBOlTA5jxKvJkJGICc=;
 b=hDZLfosqyPLEtowL+GZDWD3ZIPqCf24NIZw0rbyG0DmBoBcJDRGiA4DXL6L8s7LgoM
 iF4tGE2MfC2cVrjJlWPqX1mgPEAEh7vXZ/+F2lhdvATq6ia8Fn7RGvVgjoztRFp8saZE
 CC3azfbDyOsd+CX1Uns2LzXgfUb+jeI4KvD14XT12k2XIc2uaGrm6L9z+6KXiwfsPv6W
 ayMuVl/T1jQbnpRKIsfD3IXVf7ck/n1Nuyop/Z3eO64zcEJkQ9r2+AfjI0x9fLBGuPeX
 xeKJ5b/QlFAJ+Pf3fp1s1kwxos9ECz0ADc6zahvr1my6Qn0Uleo5mTCXUt1IYjWU1Qh6
 k4ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa6Kr2PSYCLTihI5Op9oiIqO7O6DX4kjVE7M8zF09AGFJfM+FgGoVKc8Hz372tTBg0K9EyrzWV0uD3@nongnu.org
X-Gm-Message-State: AOJu0YzzYYv/aqYtnGv54a1pT30oU1AZSB0Xn3lC+OOrEhZHh1oyCfQ/
 wX4hM8huPSLSmkrRY5KJ5pYQbRSRc8vfx/WbCwx+EzEgoJ0asJ0/pUtR1g/JtsaMRPdPq7DM99f
 A
X-Gm-Gg: ASbGncubgN4YV/peB9/c3VoWugzwnAQ+xyfB81ybGf8i/lTXiy5YosR9CD1aQbg8pVR
 QRzxvmrLjUpoIZAQrnBPayJ/ask9QL3h7VtdEupTTBCx/radet2Sd94INNYau9t7dv8NcMs3TPA
 52HmTrX1sXt3/JhoLmSXOyQF1KyhHOZ2O11yV/onOUohuGMaXuWn4U+xe4ySy4hF1m/XRqM+e3l
 rEkbVIi33EBArmX+739ahxAbqqQqwyLYqrPXIUybaf9yRX1C5T+o9X9V6fy7PyfPNFwDTdHbsmg
 QPAMHMbLslPmnEdxODWh
X-Google-Smtp-Source: AGHT+IHr33Odfn1sejDhOEC5zcumwJu+fpUYhPZlrgUX9Brk+nVe8QKoLh1rNVyD83C5lRLfsfPjAw==
X-Received: by 2002:a05:6000:1acc:b0:38c:2745:2dfd with SMTP id
 ffacd0b85a97d-38c52095a72mr12203484f8f.42.1738428091356; 
 Sat, 01 Feb 2025 08:41:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 60/69] target/arm: Remove ah_fp_status_f16
Date: Sat,  1 Feb 2025 16:40:03 +0000
Message-Id: <20250201164012.1660228-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Replace with fp_status[FPST_AH_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        |  3 +--
 target/arm/cpu.c        |  2 +-
 target/arm/vfp_helper.c | 10 +++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 18afff85098..0f7d5d54305 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -237,7 +237,7 @@ typedef struct NVICState NVICState;
  * behaviour when FPCR.AH == 1: they don't update cumulative
  * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
- * which means we need an ah_fp_status_f16 as well.
+ * which means we need an FPST_AH_F16 as well.
  *
  * To avoid having to transfer exception bits around, we simply
  * say that the FPSCR cumulative exception flags are the logical
@@ -695,7 +695,6 @@ typedef struct CPUArchState {
                 float_status fp_status_f16_a32;
                 float_status fp_status_f16_a64;
                 float_status ah_fp_status;
-                float_status ah_fp_status_f16;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 26e3465a4b8..ffb2151de56 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -559,7 +559,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
     set_flush_to_zero(1, &env->vfp.ah_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
-    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status_f16);
+    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 3180c125ca3..b77f27d1811 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -129,7 +129,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from ah_fp_status or ah_fp_status_f16, because
+     * We do not merge in flags from ah_fp_status or FPST_AH_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
@@ -162,7 +162,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
-    set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
 }
 
 static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
@@ -208,11 +208,11 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
@@ -237,7 +237,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
-        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status_f16);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_AH) {
         bool ah_enabled = val & FPCR_AH;
-- 
2.34.1


