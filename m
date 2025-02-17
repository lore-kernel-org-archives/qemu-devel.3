Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9087AC021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b6-0001hz-4L; Mon, 17 Feb 2025 07:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ae-0001cZ-Iu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ac-0002GQ-67
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43932b9b09aso46831705e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796666; x=1740401466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cy/6YVWpf8F5PvLPoIpeVzTAzLrwFHmrf3eRGC9gQWw=;
 b=c/cmn6S92WpcTkQ5l7uheprHIbdr0rvBtbyrxt/vEi8y0Ksgo/azK7Z1Bg/D5DQIYi
 Uk4IuXZoo3vR3N+VTT8eR8QvrjNzeZIJcQZA1+HAJkifhlStbmT9+gE1RSgzoR7Elohk
 r/9G0p8h6oRh2r/iVr00xnKQQteDJHS56DB+QpZlGUuPvu16AqNhT1ZgshVMYSx13v15
 JmRbG39++O+pSJD/FKu/ARaQklkN0Moa0aHnMIHhJE6wQ3nAe13fYEkDR/E47UnLzUwI
 8Y8Qil20Eic0bHyR3FNOQ5SXNUnlxzDqGHryxCMhDC/5GZ663Hgs6Btrwb0z2cux6sFz
 As0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796666; x=1740401466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cy/6YVWpf8F5PvLPoIpeVzTAzLrwFHmrf3eRGC9gQWw=;
 b=XxYtZohT3K7/VIC3zahvt+KqGkDaW0rJeugDVl7prQJPPZZs+6uz4LkrxZntbeWuBZ
 MWIUqg+NzRRhJkRC//igepSENPvVlp4UOtckasGHbY/7ZINpJ82Bs4H5nW1BUDb1iW7z
 D0jgHy5RNu+UuzTFfK6ogmu8wwRXnmObx+SfLoX+cN4Lj+WhaZlVQ5aBiXH/SLAt5JVp
 USsjVQN13aILRDb68U4k6dibUD2SBixGFYhz6iWvnj4EQwnqbWeHIL3zAlO/LP3lrZl+
 X4KE/ISeUy9MmrUvz/O/pjqLqoTRX8iHoVBMGd2CUtr3nyktubhcOL4fqoEc2pveL3tk
 q2Mw==
X-Gm-Message-State: AOJu0Yz8POZUolQN3vRBpoO5RKPHPTsInAIITKr/IizDIiMqW1N4PeBM
 munqmfnfYYKnE6I6pz+gP5Ilkzeq+4orlXv3IQUm/bL5rt7kWp5jDUsAOJ0f6gAxtu25BKUFmx4
 K
X-Gm-Gg: ASbGnctWQnlCpaiFdGRwvmQVC+gvOXfgBATQpu+t7q1ytGeEy12Kvp+JPC4tZ6mpK/e
 yPsIMwx3IXkOQiZTJDxpWhCj4f3MIPJmizaJHgwb92GqO9ElNsSAYhNGSTllRZZ9tJsp1iByMPJ
 Y8gEsp0RLsr05HrGwY9LNulT07DCKFslCECs/7aLz+U/PbDE4FAOHjnI5rhsy7geYBm0o6QElrm
 NsZdqcXpybvFnE5WhGSJ7ksb4LMbjo4MnEgyK+auOf0tOY5px5Nq+ST6Js+Efwu8IgyK8HEHqO/
 VTPRolnLTMgtvrdlfnbNCA==
X-Google-Smtp-Source: AGHT+IHcrHSdOCqAXtZeiuJ6HQQTx2bll2yJjPnTnkLIHxQ+5CEqyaTaNXGlYLs7HL9Y3e255+qVig==
X-Received: by 2002:a05:600c:3b87:b0:439:553c:2a34 with SMTP id
 5b1f17b1804b1-4396e698eebmr98661425e9.4.1739796665774; 
 Mon, 17 Feb 2025 04:51:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 08/10] fpu: Always decide snan_bit_is_one() at runtime
Date: Mon, 17 Feb 2025 12:50:53 +0000
Message-ID: <20250217125055.160887-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
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

Currently we have a compile-time shortcut where we return a hardcode
value from snan_bit_is_one() on everything except MIPS, because we
know that's the only target that needs to change
status->no_signaling_nans at runtime.

Remove the ifdef, so we always look at the status flag.  This means
we must update the two targets (HPPA and SH4) that were previously
hardcoded to return true so that they set the status flag correctly.

This has no behavioural change, but will be necessary if we want to
build softfloat once for all targets.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hppa/fpu_helper.c       | 1 +
 target/sh4/cpu.c               | 1 +
 fpu/softfloat-specialize.c.inc | 7 -------
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 8ff4b448049..a62d9d30831 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -67,6 +67,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     /* Default NaN: sign bit clear, msb-1 frac bit set */
     set_float_default_nan_pattern(0b00100000, &env->fp_status);
+    set_snan_bit_is_one(true, &env->fp_status);
     /*
      * "PA-RISC 2.0 Architecture" says it is IMPDEF whether the flushing
      * enabled by FPSR.D happens before or after rounding. We pick "before"
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 4ac693d99bd..ccfe222bdf3 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -128,6 +128,7 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_to_zero(1, &env->fp_status);
 #endif
     set_default_nan_mode(1, &env->fp_status);
+    set_snan_bit_is_one(true, &env->fp_status);
     /* sign bit clear, set all frac bits other than msb */
     set_float_default_nan_pattern(0b00111111, &env->fp_status);
     /*
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index a2c6afad5da..ba4fa08b7be 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -93,17 +93,10 @@ static inline bool no_signaling_nans(float_status *status)
  * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
  * the msb must be zero.  MIPS is (so far) unique in supporting both the
  * 2008 revision and backward compatibility with their original choice.
- * Thus for MIPS we must make the choice at runtime.
  */
 static inline bool snan_bit_is_one(float_status *status)
 {
-#if defined(TARGET_MIPS)
     return status->snan_bit_is_one;
-#elif defined(TARGET_HPPA) || defined(TARGET_SH4)
-    return 1;
-#else
-    return 0;
-#endif
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


