Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B957CC021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWRP-0005qn-DX; Mon, 24 Feb 2025 06:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR5-0005nk-FC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR2-00019u-7l
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4399deda38cso25180275e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395739; x=1741000539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nf5bfpfYc3QDe9rpAHEHV/dGaYf8w2BaIghlHVtGZRU=;
 b=FWtX7nLEShH+rN3uhY7B9NQdu0HLeCSfThKJDj+1HQA1aZBoq9N6qq0tI0moAeDgSW
 MYUNDvw45nDFgrtM3WXQXjndoacoC4uBSBg+bZqD8vniAWo3dkdVo1j/aC1jBw7Wtz0z
 HJykWFfCsjc+9bJ78XVL+JcP9lkBN/PMwfPotUB7Zb5ykhkNl/hLOH+1d9d/KUMq2Y5Y
 gr1JofMUbjVYtD11uqAlCLt9/a8Rr6KGWllG0lDuvAedEydD34L7fNKmbspd4o6bASZW
 CCdo8trSGjRgsAmjmjjkaCWSTBgQOrGGd3z47JMVkAvGnoKJKysXsX/cbUDFCFuC52jN
 bxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395739; x=1741000539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nf5bfpfYc3QDe9rpAHEHV/dGaYf8w2BaIghlHVtGZRU=;
 b=cEpL11etfOMplSZZVGmctf7HAy4RUm0VjNUJHmKeYvpa7IMDFFATOcO8Kv0nabN1cX
 4DsI4LqCjBhDa81KmxCIJS1qrhl/tZhE6Q0g126VYu8kHTLIt/a1LBUJhDMiPrsp4pYY
 1PWQYoasg8nT/EVMPxajrFlCNez4Dw60/xkrDMTmXLSiL8XlxbFLLrLQSAOXkGQRRgEH
 nAa/cG+gAz3HSxG5ulqPEZyUTK6BXu4CGGiyEUPdOtQAaOfxfp53yPRyO5CVflADijNy
 Me3AM+DdiIgccrkMWiXw4xcRDN4vKdllHhZMBFID13dzrF0P+MV/RxzuL69N56lmnBwh
 HBHQ==
X-Gm-Message-State: AOJu0YyD4sGu4+VW64NbUrR42Sgvu9sOUJ5AWt6jycDhfbAG02zV0DTb
 V9SdD3sMJqD8o7r7uCpTphdlUHFjt6A8Y7QJ6ZqbyuhgBjjFQnQGdG58MxHRjVwM/XOmsvzqs/M
 H
X-Gm-Gg: ASbGncvsrKawi//xeIosTr9H6j/pkFh950Fp/HTCE2qXS5lYu1TLZp9AM7V4Hpy5RZI
 HCTtRpwHeQUdsP14yxYbgyvv50hIrz8eB5VpIsKtPBIvCXaCEzT7or+0DQRsQ7A6vUfZP20Ilic
 vI/cSgre+hI9C7mPkLAdX61KC48QgxcWOPPEWeRgL5coUHyvzATtJAUAYcFjA6IQ9s3QJ9rRBMS
 /1+F2ASOR75WUWT6qMN36kOAzyR1zbwEEt3RIU0Q4efQSuWvF2xdPNjm23yfmJp9JVIUvrZ3MYJ
 SNp0QRzViY0VMlmNACNiJ9BlTciuSIT4
X-Google-Smtp-Source: AGHT+IH0uKs7neb0QCox+REk+ODpnHaGL9XwHuZZNVVUR+kXl9/pdowBNlm3nNcknr7Xo0S0+mD+aA==
X-Received: by 2002:a05:600c:458e:b0:439:8340:637 with SMTP id
 5b1f17b1804b1-439ae21e4c8mr125849215e9.30.1740395738577; 
 Mon, 24 Feb 2025 03:15:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/12] fpu: Always decide snan_bit_is_one() at runtime
Date: Mon, 24 Feb 2025 11:15:22 +0000
Message-ID: <20250224111524.1101196-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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


