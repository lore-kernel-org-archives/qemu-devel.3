Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C0C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEd8-0006QU-Rx; Sun, 05 Jul 2026 00:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc7-0004tZ-7G
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:55 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbt-0004Am-Gd
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:54 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca1328b8584so1150984a12.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226260; x=1783831060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T8Nke7VBw79ok0DwBulA/6kCjtrNSHe+I6s+oojEmf0=;
 b=lTHhJdm7H0A//GAo9jYNCUamzVjag5y6LaTdpX+rzYIqqciJ3oHP9bXvq9Iqfl4GQx
 ApLqsVlnramr1dBWokAlCIkclSYpyGBrpxSOxIgFcassbSgkCGsePOPN0KYKHOzMA4kl
 kd6xFxKdJYR7vaNcI2vfyzVl+oLRj1iflY+i4ICEA4YMuybXM/4sjFP8xZezym5gBnIi
 22og0OpVvYwi8McFG1IVN9oaSjZjEWLIDNLfXVJ3bzcvpEV/xZyRdKRoEJ69vxgsthKV
 o7/8+dffi6LEHUjVD2+KnCtHKwlb7M72QjV1PhRF50+wKwTYhsCpJ7Y9KuYMltcXforX
 6C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226260; x=1783831060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T8Nke7VBw79ok0DwBulA/6kCjtrNSHe+I6s+oojEmf0=;
 b=ngHNy2MGi6FIpGXt1xVF8XLnpvCfJBkq2zPfoIG9fy9j5NbExF7FcGmLm/ZCP8vw6U
 kEN6hb5oc2WztMHNtgbLU0xaZN8FBRLES7BoFHp9PZKrTmkU4q2ZyVkBMyHVaOeyrzZ0
 dro9wfy6hvyPCsAA8C0lIhQKiPVYK+DKwQsnE1DAo7A+nB/1obkCRbAf8t/n4kFARRSO
 RB87Kz/fUKoBPBnM0E8dM9zKpEtDuUwoY8hWjGwoMdAoGHhVnwg5ogVael3knd5ehY5Q
 7lKY3jWNypGhAfGAhn/nLoY+W8zhA77jb0yiVvcEiid/BwsQMjqBThSWzXzOiBzC66RD
 PE+w==
X-Gm-Message-State: AOJu0YwWUmSzw3jLGYREhMw3ZvhGWRpbv3CiexkJ9Oi19aePEq7jJfap
 67lbFM/FI32F5t/Rjt157Bw92BmbKsUg5jPx6elmfo9c8mV0U8Ous8/Woldc9wvd810aK7sp8sZ
 pUCNC
X-Gm-Gg: AfdE7cl1r6QFVAAOHKOk7oxxhVz+65GEdnWB1aZabYEo9mtvH0voZJ7/nBG5QOSQiD+
 KGhHKiOHhXaIjPuBJqAKXH5XxO/cMckYK5O3YfjuAvv4p0WnLi/Ry1RMv4PpFBN0ag58VcQnghy
 jt3Y27VBKnZM2uFUsqRqdiaNeqytvyKh5XWo36OV1Hiizdcrf4AcVVdczMt8CZ9LkCMRZFPxprg
 JcZkTrvyGlmKf5c6OxeLHvuXwDUrn9I8VYmqEdof106rOEgbu78cJt6H0+mxA4ZQa7WcHaAprh6
 47kZOoRzLb3BfkAqOiTPInWvIDbb4kNhjQRjNQ/zeqH8jLB/T/gKo+jBqdTNeYUXPxsr9SU9Ppv
 oH+hynIQQ7AHVbZGYP3GcS/u8eXh+aTKt33GB3xmc8NyrZ9NRXRPu2Z5hamuB9NawFLERLjv7hD
 GbOVyfScBaEhonZ/NZZqjyZIFeXEKtV5DEAZ5l8aucS8HI3oc=
X-Received: by 2002:a17:902:db05:b0:2c8:1f1e:6922 with SMTP id
 d9443c01a7336-2cbb9ee11admr53447715ad.37.1783226259896; 
 Sat, 04 Jul 2026 21:37:39 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 14/46] target/arm: Use bp argument in
 arm_debug_check_breakpoint
Date: Sat,  4 Jul 2026 21:36:53 -0700
Message-ID: <20260705043725.1373137-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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


