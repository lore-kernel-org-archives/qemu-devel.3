Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA68C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEv-0001Ql-DO; Fri, 10 Jul 2026 16:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEq-0001Hx-Pz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:24 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEh-0000fs-JG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so1110606b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716854; x=1784321654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w7mbi44ms/ED7IuWTQq/DSHUQAsdDGZrhybOFw4BdE8=;
 b=Ku7BUNiKjm3IT0HvBzZtYO66oSesFDeHdf6uXzsv+AHHoj458mpIjq0NjlEVwz3kuK
 1NFDByL8GYnlXkU6CAdDL+VvrGlV8n0OlG7iHpXWRQEnH/NBcooM2QDSk7lU2cwI2D5j
 aIzzddcEb5/Qr1wQ2R8j2cQR/Nb+O8DQqx+tFslBQhInlbUnTkF6BQeHCVLbYeMGxWyC
 8g1s/as//YLxMAY6U5blGMds76wPB7TTJs+N+/1zoHgBvxYUhUEiUjFAkqCDjhfbB2T1
 XIxERueJyP6EOfoZxB0T622pwXDzAfBsi5TiqQyshpGG7/wTs2/rc+F15G8Z7jdG6jtk
 96Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716854; x=1784321654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w7mbi44ms/ED7IuWTQq/DSHUQAsdDGZrhybOFw4BdE8=;
 b=EiUHji2fpBFUWEEkqlisz4eI2GoPGhTdH4NXoR8Y41f6utX0cg18iBwnpfFuTc8NnN
 H8CDo56KdbiTbury9Ounhw3wRGGXfmjYmCGbewNBT/8U9zLkWTvCWfhEaCNX4IXHYWLO
 lv5Mmyf1lkqIV4gCN1AxnGHnpvhUxYzxHZuUXHEX4wtYo7RJPdFcWZ2pAuEjbEKqLb25
 9FEjETphBQBxfAV1mQsfkIpn8vypVad2dwAb58e6zywcUGLLdMFOSnlKb1ss3PgY39KJ
 JU0f15tiErxhgUZ6Bjx0mBgBPtf6DE7d1TaUZxaR0OxtPMXzDxV/mOecJfOxppy2Lpit
 h6Uw==
X-Gm-Message-State: AOJu0YwwFzaqcwEwouB7Q/2uekU04r2g1r7utwzZaax1L+BMB6Z0iFNC
 h86P0BN2o/l8ITYa8pVFURTboVzVCTRxg1y6qH8Wh196vPzVcZJu+QtFzH+3EkgZ8/1xdtihjMW
 sTyVe
X-Gm-Gg: AfdE7cn1E1nLCe6CP1XgHh7usqdTFlkStElplobXTA5ZdJqs2/D/pi+XkjW3Q/l8O7J
 mEoEwEEFv7EIVleIFyCXVMh6sVH1IyYcQ7XUDEGAmNeTkZEPySPv2rp7R1jUN+x3TzGgHEWBly1
 5twWSa5W0YTpvxViz44Zk0+iVZpSuaVwW2BoJkgLlpy+M2YQ2J29W2KQjVLPhH/RjMcVbIb3PVp
 4V696HDtGqr7imFds4fNTtOqo/SrUsHArZPSULsf2wKOgdqHGCgzzKAintk28mJJGnsVeoUiGxa
 baKIpQ73zy6kN6xSOvDYZFe4IomjOH15TUypb3k3NsFZMA+EStLypfAhhN//9qvLbD9ezved+rD
 HIZErGraIwWX5td3wR415BXg5wlQEz8/LFL7iGyq1V05FPe+56+Boi/VW0Rn6CmafBhzI+QkR07
 WrH06vkfDQ54SielVwtw==
X-Received: by 2002:a05:6a00:4207:b0:848:68cb:5c74 with SMTP id
 d2e1a72fcca58-848898343a8mr470769b3a.60.1783716853081; 
 Fri, 10 Jul 2026 13:54:13 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 09/51] target/arm: Split is_wp out of bp_wp_matches
Date: Fri, 10 Jul 2026 13:53:19 -0700
Message-ID: <20260710205401.836304-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

This function is only called twice, once for each of
breakpoint and watchpoint.  Hoist the separate bp/wp
code into the respective callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 49 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 306106b7e8..519a06fbc7 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -252,41 +252,16 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     return contextidr == (uint32_t)env->cp15.dbgbvr[lbn];
 }
 
-static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
+static bool bp_wp_matches(ARMCPU *cpu, uint64_t cr, int access_el)
 {
     CPUARMState *env = &cpu->env;
-    uint64_t cr;
     int pac, hmc, ssc, wt, lbn;
     /*
      * Note that for watchpoints the check is against the CPU security
      * state, not the S/NS attribute on the offending data access.
      */
     bool is_secure = arm_is_secure(env);
-    int access_el = arm_current_el(env);
 
-    if (is_wp) {
-        CPUWatchpoint *wp = env->cpu_watchpoint[n];
-
-        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
-            return false;
-        }
-        cr = env->cp15.dbgwcr[n];
-        if (wp->hitattrs.user) {
-            /*
-             * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
-             * match watchpoints as if they were accesses done at EL0, even if
-             * the CPU is at EL1 or higher.
-             */
-            access_el = 0;
-        }
-    } else {
-        uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
-
-        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc != pc) {
-            return false;
-        }
-        cr = env->cp15.dbgbcr[n];
-    }
     /*
      * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
      * enabled and that the address and access type match; for breakpoints
@@ -390,14 +365,16 @@ bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
      */
 
     for (n = 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
-        if (bp_wp_matches(cpu, n, false)) {
+        if (env->cpu_breakpoint[n] &&
+            env->cpu_breakpoint[n]->pc != pc &&
+            bp_wp_matches(cpu, env->cp15.dbgbcr[n], arm_current_el(env))) {
             return true;
         }
     }
     return false;
 }
 
-bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *ignore)
 {
     /*
      * Called by core code when a CPU watchpoint fires; need to check if this
@@ -417,7 +394,21 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     }
 
     for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
+        CPUWatchpoint *wp = env->cpu_watchpoint[n];
+        int access_el;
+
+        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
+            continue;
+        }
+
+        /*
+         * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
+         * match watchpoints as if they were accesses done at EL0, even if
+         * the CPU is at EL1 or higher.
+         */
+        access_el = (wp->hitattrs.user ? 0 : arm_current_el(env));
+
+        if (bp_wp_matches(cpu, env->cp15.dbgwcr[n], access_el)) {
             return true;
         }
     }
-- 
2.43.0


