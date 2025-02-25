Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C507C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzKh-0001ad-JS; Tue, 25 Feb 2025 13:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJT-0008Vl-7F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJI-0002FT-3P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43994ef3872so36685915e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506733; x=1741111533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TnlrEm+jOYg4iMTgEIJfSftvcM8UJSyXDIRsqIENUQg=;
 b=sfWYI1ZtxsETzNUGNALasQ9XZECJydq1TAc5DK0YCE6AOwTvaGuTTj7OteaJ+xDE6t
 YaZGumMDYP+k3+mhbpzeUGKomK8XdJK/zGWYYfsAwV6xcPe98CVJz9xJ8V8c/MWiqRmF
 OrMCCg3dcqBKIf2HTstxFrD5wfApIc8OaryHM6NPUJe4oMcC1pb4u9dfITXyd2s1SZE1
 CaownbBTb53EtPNXUoB+4hM0Gez0GqX7kH9Yn9xzIyTRLEG7GuLCpY2oLHuLUVS3fUL2
 gc8XSCjBO3cnM0l9cMMPYM8iNA4PvRICAsLoum0Nqr/tJDeLAIXHZplwSkpnVf3JmJmW
 lNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506733; x=1741111533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnlrEm+jOYg4iMTgEIJfSftvcM8UJSyXDIRsqIENUQg=;
 b=lRzWAfFhJsh6RJsQbeAGmQO3x4T3NZNvmTRwS8vKGfKL2bmbU7TVNYVyZ00wFfujL4
 Y3YV9dgkg7AtfVck2efc+KcWO7ubwsAKcjMPYpBaywWqvIgo0MpuGMEFkwh2TnvFzgv9
 1fs/GORafBSk3i7SUtBtVzthe1wxzVtJY92ucZ70QFWbz0D9hwtPisN/e0fgCrnJR259
 gEbcj6nd8+zT97QZB2GfvcijANsbXW2LO+AoDfbXQtWeUD+hp004W3CDvXvES+wzqaDt
 3/t24IlCr+1ukxxuyt3V2aX/L+ngHZJoR5ivew/sxVZ2PpSGnnEOPXIoj8sReA+FQbnA
 MU3w==
X-Gm-Message-State: AOJu0Yx49Q87WoWRvmmFZE8SIlW949ssgrLunzKXKFAVHhZyz946V5yI
 EQWm5ZtDkdtZEIu9co9F3NjQhz4WqZwyzSxY06n3MBl3vo6bpQ9nHFXO1Uu1e4jJsIN5BEiJqx0
 D
X-Gm-Gg: ASbGncuQ4r+CNkdiyGJYa7LTibVDU20+3zEVXuNdKa+vLYuPCQhLegrPND5ij5GEW8q
 jg2NJozmRLnoHA5XTp6tOaSCOdGWWbRNvbCBq8/Hh3/KfcXsDvXb88E0lcGoUwF7RZ50QseNJ3o
 lYgRodUMk4iJN2Lnr6buMxmUuFcZGtWEjQu7+VDB//owGh0GnvzHXVueC6J68+KvEkr4boQrzxc
 kWfKSJY+YElO8sD1RR7R71oRFSh89xniPvr3Fcz1B3IqVezkF/edRlwj5TF47dvOfsZGuA0kDwm
 fUTK2K7mLk/iwZNk+r/yUeh3qECZvnIX
X-Google-Smtp-Source: AGHT+IF/avcqL1QdAbnC2Ad1iLoVTAwAV/24gbI64BGdWgqCijI9C+h4U9DDbjbSdG9YQO7NEuLCmA==
X-Received: by 2002:a05:600c:5123:b0:439:88bb:d035 with SMTP id
 5b1f17b1804b1-43ab0f2887dmr43380535e9.5.1740506733460; 
 Tue, 25 Feb 2025 10:05:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/43] fpu: Always decide snan_bit_is_one() at runtime
Date: Tue, 25 Feb 2025 18:04:44 +0000
Message-ID: <20250225180510.1318207-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250224111524.1101196-11-peter.maydell@linaro.org
Message-id: 20250217125055.160887-9-peter.maydell@linaro.org
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


