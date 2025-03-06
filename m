Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DE1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEGD-00070t-NQ; Thu, 06 Mar 2025 11:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG4-0006pn-Mo
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:40 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG2-0004db-Tc
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so8062285e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279177; x=1741883977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gn+iRr/DyOLW0klhx/+n+/C8SaHWZdNPyfpde7R5NiY=;
 b=PnSqnbZSWdBa/Xb/D8tqJBI2WZptpWDIQcnncJ2oyjFB9WwpEaPry9ZKPQKd6iF90I
 37puYtKrdpfdvRQ66idItOLh3qI3w9jcPHcFy84Wo3/o740hbVGetHh6PrL/zYFYwwjr
 49eVVsUEwV09rGZ8wdwdptpASc93pYBzNur5nb/kE6yGd/OQ98T5z1zwR21w0RQkKxMC
 sgPy66PLKL5A0MySz1EQ/AWO6iW0Fdu8OiBGim0KtUS6i8Muk8rZPk7UMDGNH9TwOawm
 3DfcGPjBoE/2EPOmIQjYUGAAcmAG7nbal8AvrfUs/AXmVjiezv651tNfQs86m+FQu3xL
 ZqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279177; x=1741883977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gn+iRr/DyOLW0klhx/+n+/C8SaHWZdNPyfpde7R5NiY=;
 b=SLS16e0N5n+hUesfRY6HnnWwzSsyJIM0cd6C4qkn8OQNl0QED3G5p5u5L74yiCXeKF
 ySYX1KniVuP83prpDt959rkOsATKEhLtRjxDA6VJDbeWEsDV9wDKD6PT+fsnX4Lj7LjO
 XhuEoDh17UVp430tTCIe+d+Fa/yHN1ud8LR3kKecKfdeVygQAxDlD3WEpdLp2XtQbp9Y
 4+AaeDuMimOTRNErXKEGsXy3rrd0M2JsCO9jdmLm70HKtW125iX1hGt1IwI15mfoSZI3
 RUh1pHbASO2iFvEgPcpW12UVz/xOBYUjHRnY+b4l9A5xOPb7gwU1le/BFRXJxWpotFbV
 xA1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXewqtpUAv7IX56cMN51E+rloVQIYaDxdjQ13R0z0ibWPnlcXYySQ1Z2hhyF91V/kZlfNH6fLzS+anG@nongnu.org
X-Gm-Message-State: AOJu0YzYNQwzuNmPE5N3yFDM5CVZSrS6AvbC5t3cpr609cLl23nT4FIs
 qg5jSHJPdgoN9GNMz2e6jajEln8MoCoiNmLYGDue/YO3DRQyenH799PhQthhZk4=
X-Gm-Gg: ASbGncucBMQrs6RCppgB1vFX9ax2iieXitv9qsG59EBNqHsopKoZ66fAyNMAyJ7HxOP
 ZmeC0brZg4MuBAiAWjnjEiRpwuvywj7BduoM0USiSAIR1a6OcegKRiJDoCfvjemY7wnUcJ+MY5z
 7pL995CQcaeNnvrMNul6PixwQIJm3M6pPscOWz6ttR4LDIJahNBRXfZWDWfGbTd9YLU9hIHuCTH
 xU5WoYe6efOmgv8W4MEJppSnOKrrFTycKp5nwti2sskwySfyownqMF8R8PJlBD6NxnTuuj7HWZL
 4Xu6TrX9zdtYsT5UWiBSAyrJLnqdNtBllp1l4cWNWsRLrbHXCyE=
X-Google-Smtp-Source: AGHT+IFc8om0H9QBBv0wuiEQDM4mQZFPwxA/4ZSQCFDKgMoJpbSBlTO0sY69P5BijKAPpMjt1oO/LA==
X-Received: by 2002:a05:600c:4f4d:b0:43b:ca5b:847b with SMTP id
 5b1f17b1804b1-43c6872dd3bmr763745e9.30.1741279177128; 
 Thu, 06 Mar 2025 08:39:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/10] target/arm: Forbid return to AArch32 when CPU is
 AArch64-only
Date: Thu,  6 Mar 2025 16:39:24 +0000
Message-ID: <20250306163925.2940297-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
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

In the Arm ARM, rule R_TYTWB states that returning to AArch32
is an illegal exception return if:
 * AArch32 is not supported at any exception level
 * the target EL is configured for AArch64 via SCR_EL3.RW
   or HCR_EL2.RW or via CPU state at reset

We check the second of these, but not the first (which can only be
relevant for the case of a return to EL0, because if AArch32 is not
supported at one of the higher ELs then the RW bits will have an
effective value of 1 and the the "configured for AArch64" condition
will hold also).

Add the missing condition. This isn't currently a bug because
all our CPUs support AArch32 at EL0, but future CPUs we add
might be 64-bit only.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index e2bdf07833d..9244848efed 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -678,6 +678,11 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    if (!return_to_aa64 && !cpu_isar_feature(aa64_aa32, cpu)) {
+        /* Return to AArch32 when CPU is AArch64-only */
+        goto illegal_return;
+    }
+
     if (new_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
         goto illegal_return;
     }
-- 
2.43.0


