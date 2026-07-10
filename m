Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B534C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIHO-0005w3-Hu; Fri, 10 Jul 2026 16:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFU-0002Az-9Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFC-0000wK-AI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc7so798115b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716875; x=1784321675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aii0dYUlzhh0daweMydBIrcsyG896sPYULsiw+pFWxo=;
 b=rLiEaUxP01vMQwKnrM8/kl5XPl7DzHJu8bE/aSe21MdFxjmLpZg/NwJXmdi8C2sz/T
 F1i1rbtO+fSVrJP5UXv10sjEG99VgEi2tLfsfV/ZIYkfpImN+3RsN61/DrbzXGqtI0Fv
 nHYVxitiZP3Sj/v0Qyua/+umztATp+eorr0Yb38/PVci+V2C0bU1L62IOVIGD7qvO6oX
 qRtLJVJmP/6QUM/8ok04JGbh/kaiu8rKZ5EyRbw0e1wnQV4SCag5znPrIDzKgqjutFv/
 qCB/zKS7UphUp2PZv/oE0j7E6GKMeisLDKzzKylp9nuMQ9l4sPIQMFLm4Wl7pkIF04Qj
 gAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716875; x=1784321675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aii0dYUlzhh0daweMydBIrcsyG896sPYULsiw+pFWxo=;
 b=JJePjaXJDoh4cQBh2ZtK2d+a36neKz5Dqs1uvqFyYaodLI7hYatSlElXKRoU/MbQUg
 MdKjqpZXa58yjuxhnNXQ6vcAHQhEtcfge23X9NzAUA2o/OROI77eXAb5nSZMGIQdo096
 5DAHHmIagQ4JoLZC6Dn2Z3CP8D5UKfPmN3MpskBF17aMSimgnOY+xWcAjzG7JYjwdV7S
 5HfMOCVV1IhxxDg55tSzaA1HWNN2vks6JXQKD9qYnZPCWZmnf7jZUwv5A3kuXLzSFeu4
 H50+fjfdu8FH7eFsJrExpPpi1Dgk8xHhiMpH0rBKpYinrTsL+Xxntd2MOWJ8+lXsaU3h
 lpig==
X-Gm-Message-State: AOJu0YyVeoPrcXrfRLNyGAwsjAOKDD7WM/ROZoXIFjM+25A+JSGXRQ0s
 MuGkTrT8bbherHCHFhBU8UcAiMs2cZO1zWNOncBTS0Iz1V9cT8wNu8oocdKTIdyrrXmtRXthYes
 qpknB
X-Gm-Gg: AfdE7cm5r+Ct6WfBAPPqHHn8xG/9E95tVVlGxNg/vu4/Bz9XsaHKfZV3cg/Vcbf3cbV
 EK8Okaal5RN04BZ0pWublRObOl0yHAytLUEPnwDTj5L2pR74OyFbUN+Ix7UNjRoWmL+Znp10w8a
 2RPx1TKzJ04cPJbVYXfazIuWq4HgEgL+MPK5JPTveKCuRFGQMCJCFGSU5WzxDjylSzHq04uTe6E
 MShZbbW7IeXUCcJTr398WvBIvlbw0uZtub1EP/hwtWJWIBqJga4q6iGTRY38xlj+M07B9HArrDI
 WrZQ8UcoW62Se/l0WK3Ehaq1JmBKLGtTUb1II54uZMOZlhPwf6loW/+LFMS9EOBR6m8wJQCTbvG
 rGJ5QhxKYEhSILn71bqij5taC9OWlhQ8Bnz3Mt2hDlG7qlVLo+7bQCXQ/hiRsqWMnBeMOGBVhEM
 BV7Q4MlWjwF1oGb0izcipNUWn3tUth
X-Received: by 2002:a05:6a00:450f:b0:848:2f71:b65b with SMTP id
 d2e1a72fcca58-848897d5cc1mr491288b3a.70.1783716874801; 
 Fri, 10 Jul 2026 13:54:34 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 29/51] target/i386: Pass wp_hit to check_hw_breakpoints
Date: Fri, 10 Jul 2026 13:53:39 -0700
Message-ID: <20260710205401.836304-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Since force_dr6_update is set exclusively for breakpoints,
replace force_dr6_update with wp_hit == NULL.

Use the value of wp_hit to notice which watchpoint is hit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  2 +-
 target/i386/tcg/bpt_helper.c        |  2 +-
 target/i386/tcg/system/bpt_helper.c | 32 ++++++++++++-----------------
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 01f4a8bcd0..2227712e2e 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -114,7 +114,7 @@ int exception_has_error_code(int intno);
 void do_smm_enter(X86CPU *cpu);
 
 /* system/bpt_helper.c */
-bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update);
+bool check_hw_breakpoints(CPUX86State *env, CPUBreakpoint *wp_hit);
 
 /*
  * Do the tasks usually performed by gen_eob().  Callers of this function
diff --git a/target/i386/tcg/bpt_helper.c b/target/i386/tcg/bpt_helper.c
index bc34ac27fe..bcb9869c86 100644
--- a/target/i386/tcg/bpt_helper.c
+++ b/target/i386/tcg/bpt_helper.c
@@ -25,7 +25,7 @@
 G_NORETURN void helper_single_step(CPUX86State *env)
 {
 #ifndef CONFIG_USER_ONLY
-    check_hw_breakpoints(env, true);
+    check_hw_breakpoints(env, NULL);
     env->dr[6] |= DR6_BS;
 #endif
     raise_exception(env, EXCP01_DB);
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index 8ba5dfcfc1..5dab77b2c4 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -160,34 +160,27 @@ void cpu_x86_update_dr7(CPUX86State *env, uint32_t new_dr7)
     env->hflags = (env->hflags & ~HF_IOBPT_MASK) | iobpt;
 }
 
-bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update)
+bool check_hw_breakpoints(CPUX86State *env, CPUBreakpoint *wp_hit)
 {
-    target_ulong dr6;
-    int reg;
+    target_ulong dr6 = env->dr[6] & ~0xf;
+    bool force_dr6_update = wp_hit == NULL;
     bool hit_enabled = false;
 
-    dr6 = env->dr[6] & ~0xf;
-    for (reg = 0; reg < DR7_MAX_BP; reg++) {
-        bool bp_match = false;
-        bool wp_match = false;
+    for (int reg = 0; reg < DR7_MAX_BP; reg++) {
+        bool match = false;
 
         switch (hw_breakpoint_type(env->dr[7], reg)) {
         case DR7_TYPE_BP_INST:
-            if (env->dr[reg] == env->eip) {
-                bp_match = true;
-            }
+            match = env->dr[reg] == env->eip;
             break;
         case DR7_TYPE_DATA_WR:
         case DR7_TYPE_DATA_RW:
-            if (env->cpu_watchpoint[reg] &&
-                env->cpu_watchpoint[reg]->flags & BP_WATCHPOINT_HIT) {
-                wp_match = true;
-            }
+            match = wp_hit == env->cpu_watchpoint[reg];
             break;
         case DR7_TYPE_IO_RW:
             break;
         }
-        if (bp_match || wp_match) {
+        if (match) {
             dr6 |= 1 << reg;
             if (hw_breakpoint_enabled(env->dr[7], reg)) {
                 hit_enabled = true;
@@ -207,10 +200,11 @@ void breakpoint_handler(CPUState *cs, CPUBreakpoint *hit)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (cs->watchpoint_hit) {
-        if (cs->watchpoint_hit->flags & BP_CPU) {
+    hit = cs->watchpoint_hit;
+    if (hit) {
+        if (hit->flags & BP_CPU) {
             cs->watchpoint_hit = NULL;
-            if (check_hw_breakpoints(env, false)) {
+            if (check_hw_breakpoints(env, hit)) {
                 /*
                  * FIXME: #DB should be delayed by one instruction if
                  * INHIBIT_IRQ is set (STI cannot trigger a watchpoint).
@@ -224,7 +218,7 @@ void breakpoint_handler(CPUState *cs, CPUBreakpoint *hit)
         }
     } else {
         if (cpu_breakpoint_test(cs, env->eip, BP_CPU)) {
-            check_hw_breakpoints(env, true);
+            check_hw_breakpoints(env, NULL);
             raise_exception(env, EXCP01_DB);
         }
     }
-- 
2.43.0


