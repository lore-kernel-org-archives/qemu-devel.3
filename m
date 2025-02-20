Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13094C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J0-0006kY-1A; Thu, 20 Feb 2025 11:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Ix-0006jO-BN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iv-0008BI-JA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4399ee18a57so7306835e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068496; x=1740673296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i7JKENOxLmrhen0LkLvps9gDGv3I4n/oBN1hptBURL0=;
 b=KB75k81wtlxyLyjrXp9OhjpNE/9qEm/MozwHtTrj0XEIM0QzlTvCvAEVPkqNAp/Qfq
 KaJAAn9XjluqW2BQsbrZYmKtPPL13LKUbsXKCVoTUAPvxrzfxAL1P+nnw/It4JQ1jQEY
 lPEt9IAj5OA4WgPwfobroH/s5TrTPMJeZUQdBDA9qG7yeK24MW9+xn8vaVhuLUwbXDUN
 qymO08Aodbl6//QtYulCsxW7y6RE5Du7o3IOqVssjA3BuelwQvbZAstQyeRVHHEnj14u
 qkn34SJxCnYXIZqPc/mHsZwPaxbEZamGD4d9i7lJUrckOoM8bVDMi1Hz5IN/Pg4m5pFG
 +w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068496; x=1740673296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7JKENOxLmrhen0LkLvps9gDGv3I4n/oBN1hptBURL0=;
 b=COrEXpOsjMLimTGcPxV0/YMB+t5TV/pPJJ4DAhBrMg0UXx571tiYgGe5KISRwJcLLL
 zbx3620wn/Bds/Qber0VtuvR0EXg1OrMa1O/euTs651tFu45fZEREep6utiY9tQb0OwD
 3gW3DCaRR5tzDSYXNYLxbhs/U0YRQFxO4uP5RcwQxMjkdKRelsAqzibZ4crM311oDFeb
 s3wqPVgKTcVqnuzi3SwSj5Eve2si8OVEp/r1jUG+5+yMagBiFluPZF2InWm8PgddM0PR
 bUG2tWZ1RSrcOsZ0/hoWnMcvwssL/s/kpRBzVutAWLutHN31T6DpuhDMDeWEwnPRZYAY
 NTIg==
X-Gm-Message-State: AOJu0YwURPXps9i+q8O6DCCACAS8/7GsYEBkcVyvH1hZe86HOWN1xw4P
 aqePKEtouEvB9fHnFPrdtRFErrqn3XhbKWvUy0Cf39M9sM7Q6UQLwX7qLr8jXMIa77QN7k0OkQD
 Y
X-Gm-Gg: ASbGncux2N4aQ1yDNo4g9eb8HbOJcXCyqNaZRjL9w9mHZ55HG7LLIsFANBKVZMAr1W6
 r6jAYqX2hkUJXYEbtG+LeCgmgI+y3RdNDV+M02sor8UeZXCsk8SaLomxgz1iij3K1ix0ahRRcEz
 Qj15OVNOv7MNGnYzqHN0ybgaiQ2eav11TzAZX6BaGdaTu4r6CSe5e2azDDqDVzXnPRoRtIhNVSj
 x4Imz53ZliyIMnx3s0+pWU3h2FpnxWLCxJvOJ/P+hPKpgKJMs2CUbTjnsvb4VfVxCYce1MzPmLx
 VPdaZKFd8IHPuulwWlmMEQ==
X-Google-Smtp-Source: AGHT+IEuzkf3i1qlm5nZ5vgSuMrjOkS5CnPD6grq5CCy8I9EIqGPoCt2xbtljgJcM17ewKBpPB9nzA==
X-Received: by 2002:a05:600c:4f05:b0:439:5fbd:19d2 with SMTP id
 5b1f17b1804b1-439a30c671bmr34358685e9.10.1740068495931; 
 Thu, 20 Feb 2025 08:21:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] hw/intc/arm_gicv3_cpuif(): Remove redundant tests of
 is_a64()
Date: Thu, 20 Feb 2025 16:20:49 +0000
Message-ID: <20250220162123.626941-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
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

In the gicv3_{irq,fiq,irqfiq}_access() functions, in the
arm_current_el(env) == 3 case we do the following test:
    if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
        r = CP_ACCESS_TRAP_EL3;
    }

In this check, the "!is_a64(env)" is redundant, because if
we are at EL3 and in AArch64 then arm_is_el3_or_mon() will
return true and we will skip the if() body anyway.

Remove the unnecessary tests.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-9-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 8a715b3510b..7f1d071c198 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2291,7 +2291,7 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
             r = CP_ACCESS_TRAP_EL3;
             break;
         case 3:
-            if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
+            if (!arm_is_el3_or_mon(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -2353,7 +2353,7 @@ static CPAccessResult gicv3_fiq_access(CPUARMState *env,
             r = CP_ACCESS_TRAP_EL3;
             break;
         case 3:
-            if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
+            if (!arm_is_el3_or_mon(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -2389,7 +2389,7 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
             r = CP_ACCESS_TRAP_EL3;
             break;
         case 3:
-            if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
+            if (!arm_is_el3_or_mon(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
-- 
2.43.0


