Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEt-0001Mw-Sy; Fri, 10 Jul 2026 16:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEr-0001Ib-81
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEi-0000gJ-15
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8485bd28dd0so1438939b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716854; x=1784321654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T8Nke7VBw79ok0DwBulA/6kCjtrNSHe+I6s+oojEmf0=;
 b=YhZI+EwUXeEge72K6bVviMRqf/zvXBLGobGhmUtkA8QX17tMGe2WDp1Sgx6oJHtYBg
 nx4FOOCfz70l1wihWL8NGwoZeGjpPGxtid+ht7OoxLcp++13+BEp/npNOxGffoQf1cGK
 gMWj3tBWCcM631ts1c9NrCaiTkwnrogFBHzCNH0/16+lY7W7gLNE06MhIjSAfBgG8EAE
 YMcZvHQPMx9Yt8+GAEVsBvQ9IuRUtLvmh/kwrXeCuqoKs74aZOROJNIi05b1rQOafzaF
 8qKOPbC6QwOycW5OcXUqIPDtu15flBD2fPx9FRlyv0S11iD2etAR4mCxhXGRGsTvMQHZ
 Zn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716854; x=1784321654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T8Nke7VBw79ok0DwBulA/6kCjtrNSHe+I6s+oojEmf0=;
 b=G86NWpBK1ez2INJdEsmjvVayVpfYy5q19U6E3v8AYAmMAc7GrPzEKlotrKEhLuH/XQ
 DAtZpwYs4w0JpWxjC5JL7+BYZb1ZzcQ9WYlMLoWp8RjX0dhR2VfK0w1qvrsS+muoPQDN
 rEkTOTRyLROoHZt2YHUzrMWXVopndZuKhAxZpUX/1xUOMRpeEus5SirB54/SCghCeOtW
 MyTNuDjC6Zr0WtIHyspwmmHsGPMOL3+I/0kuEMQWS2BQm/l4v/6ED4oh9kTIpxQlR8pr
 AG3Akte2HLNwtBABKr6VY7eKEh9HxpcAu9UkLI2KfclVdfPc7e4vUcRP2T79LSL/DITv
 aihA==
X-Gm-Message-State: AOJu0YzeVzxSSt3EqxoY1QxpTz5npTdUrj0tWtfXF8wDIBo8gHQdcYYH
 gX3r3jjhXUR82bEkhvFTYAQO2HeWp2li/r1vz1aMqoBlZGt2zHRdIyRuKlU3QkIWjpU2mCNCWil
 6LZ7v
X-Gm-Gg: AfdE7cnz3pdlJilmiGaTTHraEoO2xtr6wMamWSWftK+OgdS0rBlXPNSYrTmCrWmhI7j
 mP4KJz3ckcNG/7TO8HoOr+OkQZtrKG2Im/4txLiJQWwynzi+h5Je0Ek15kQY4CPtWqlJJGrGlPn
 0HOY4vnHHe+B9zKi0yBZ6hlwxYdWZMhpzbRqXYpoibBExX2v/aaqX4mVxDQg0wZCnZsNRsI3TJJ
 xwQw04f2WaPefJe4bT/1WZ2k1J79+c2KSiMjERjreIkknGrOSKY9m2IQFBCp8EwfrM8Ahfit2rP
 fK5lmZt/ZS9S+K9bfOZkD60Hnsp+1udH70ZKnHsZd49v7YelsioCxEkgo4OrQZ0C+E3IsFADSAk
 jLhz2JAK2H7Dmgzip9acC4WcZQWYACviFByfETTVtw/6lqOgStZhtQAPNGxqth2opdSh0/bq/Nr
 xYB+69csJKGl/3WPjlBw==
X-Received: by 2002:a05:6a00:2304:b0:848:4256:d6ad with SMTP id
 d2e1a72fcca58-848897701f2mr540984b3a.60.1783716854506; 
 Fri, 10 Jul 2026 13:54:14 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 10/51] target/arm: Use bp argument in
 arm_debug_check_breakpoint
Date: Fri, 10 Jul 2026 13:53:20 -0700
Message-ID: <20260710205401.836304-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Use the matched breakpoint instead of looping over all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 519a06fbc7..2389830b2a 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -331,7 +331,6 @@ bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     vaddr pc;
-    int n;
 
     /*
      * If breakpoints are disabled globally or we can't take debug
@@ -363,15 +362,7 @@ bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
      * TODO: We would need to look up the page for PC and verify that
      * it is present and executable.
      */
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
-        if (env->cpu_breakpoint[n] &&
-            env->cpu_breakpoint[n]->pc != pc &&
-            bp_wp_matches(cpu, env->cp15.dbgbcr[n], arm_current_el(env))) {
-            return true;
-        }
-    }
-    return false;
+    return bp_wp_matches(cpu, env->cp15.dbgbcr[bp->id], arm_current_el(env));
 }
 
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *ignore)
-- 
2.43.0


