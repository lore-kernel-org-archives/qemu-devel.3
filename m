Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C39DC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Io-0006f5-S1; Thu, 20 Feb 2025 11:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9In-0006eh-Bw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Il-00089j-Qw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:29 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso7345175e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068486; x=1740673286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8FCRx4JR1iGsDp4qI/IJ+hntWqJQNK3GsLMOm2F/CHw=;
 b=G/KFCgmPne9fe9Yd0KLU8KyA9cYrxfDMmRMmtNj0QCaPflaLOLW2C8oWMAgPWU1ad+
 nJ90chlfBhQTqk4Z5DNQMU3jImYn86O0jKceyRJetYVYVOYAZvZ4Inyct0BANpgAHE7m
 Md5rm4VEQDTurONyYiiJAEeNgJZBDp4KExzLpOJ6Hhu40qrhUO8p1/tJ74XJNvsOVvmZ
 iAAUsHgEuFVHnMBspSO+Fst7/WKzJHFATcK5y+pwaAITp2rIKi7c8DROYizi70lz9snT
 B8DEBvQ0WA5OFCrgSGnhL9mTHmSNLFqbZJ+DhgOFwW8IDVON/pAapSdcH0p9YK/Kil/r
 RIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068486; x=1740673286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FCRx4JR1iGsDp4qI/IJ+hntWqJQNK3GsLMOm2F/CHw=;
 b=u7e55COcGKq6xcCNMMRBBTpGU2t9iPRNa9y6kv03xr5dbIGYzUvxAV0debrkd/IA8D
 KieEoWrtZ8TJjIDxNJdVl2Rm3JMg8/NROEFQH1oCWCQdWAoAoYR3L7Wd+Db4CBb7sbhI
 yfbF+oZ+LuinNWSRXv5L/lWG6Q8xmCpAtNw0KEmEXz6/8uvhLMak3ngYwO6Xwz4OabcM
 rW9A+FMD2i0wAI5FrsJYb3B66vyGlS37pAtCEuT0MkQNz960isDkwxSRhGO20jafg1JB
 E6+xHKub3pyGsjUlNgOHJvrqpuWayswAr55HmVwCxPPbefcDLgcCuLXF/7ZOgOsz/HpM
 usXg==
X-Gm-Message-State: AOJu0Yy2rN+UJmuv9kxSH+IRuUH/64bM2vgRpZ8bgobNCxtX033E8YTI
 GRegtVhfB0EXAVPrG8fWUlJNOdbUtQHe9Eedmj+10oyvJBKRY+uUPR/1lgAJ1ntP+tYhXrX99B4
 x
X-Gm-Gg: ASbGncsSTph93e7BVvlV4+pOE9GvoS0Mu7JhciWGuyaZVAwiRdzXFWHLznsh7ULuVLt
 iwlaXujMeQB7AsEEY+uOwrz1VF28cwU5ENk1MqVlgD7aNUOrMuUIQqX2V+MZXZkD49LzJOmXzTM
 bfvLpQONBSAsKwpaoFQ0yJd343ADPHE4gcN8wPEsUkDzOR+Y3wQI+sNep4cIsltkRZhyJBzNokw
 Pe+3BcHOsPJwN1OFRKBh5KYFBMM5vra6BtpH78ICBau9uUv9ylgqfYhrVxY9Nz5wF0vxELvJtrG
 2yNdG4cK8rGulrGO32bHoQ==
X-Google-Smtp-Source: AGHT+IF1m6mhX8bYv1onVMNnnCNdNTgMv4s6MVv9sqEvzJd3KtwRGf1W4RAe8Ku7kWXj2yFBBK6N6w==
X-Received: by 2002:a05:600c:314d:b0:439:9898:f18c with SMTP id
 5b1f17b1804b1-4399898f441mr80145145e9.26.1740068486232; 
 Thu, 20 Feb 2025 08:21:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/41] target/arm: Report correct syndrome for UNDEFINED
 CNTPS_*_EL1 from EL2 and NS EL1
Date: Thu, 20 Feb 2025 16:20:42 +0000
Message-ID: <20250220162123.626941-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The access pseudocode for the CNTPS_TVAL_EL1, CNTPS_CTL_EL1 and
CNTPS_CVAL_EL1 secure timer registers says that they are UNDEFINED
from EL2 or NS EL1.  We incorrectly return CP_ACCESS_TRAP from the
access function in these cases, which means that we report the wrong
syndrome value to the target EL.

Use CP_ACCESS_TRAP_UNCATEGORIZED, which reports the correct syndrome
value for an UNDEFINED instruction.

Cc: qemu-stable@nongnu.org
Fixes: b4d3978c2fd ("target-arm: Add the AArch64 view of the Secure physical timer")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-2-peter.maydell@linaro.org
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7d95eae9971..b7d6afe0a1a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2385,7 +2385,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     switch (arm_current_el(env)) {
     case 1:
         if (!arm_is_secure(env)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_UNCATEGORIZED;
         }
         if (!(env->cp15.scr_el3 & SCR_ST)) {
             return CP_ACCESS_TRAP_EL3;
@@ -2393,7 +2393,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
         return CP_ACCESS_OK;
     case 0:
     case 2:
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     case 3:
         return CP_ACCESS_OK;
     default:
-- 
2.43.0


