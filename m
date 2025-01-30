Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5ADC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCR-0003y0-Bl; Thu, 30 Jan 2025 13:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCL-0003u9-Ft
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:30 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCJ-0000Yc-Iw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:29 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so667132f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261406; x=1738866206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmP8UEFFJb/lmaE2ZgdfHHn0pCkyFx+RjhYIX8J7P0Q=;
 b=wjHx+KfK1qan9SGD7R9+UubvVr431lMZ4Hud71zAbFwVyevdmabmeK+Azx0G3WfFrn
 +NP3vLgvdM6cqBQKSUcYrqOSpmAa2yse8C02z7OUxfwBSMQ4nt7pAYq+inbep81QPph+
 eiT+93EPZuoxCwmX9d9oD7xuhXeo1junleMMdzAaxb3Cgk/FBJn+EiRMO6x1jYW0oHX/
 OHv69DtYSQVn0Okak6p9x5JS4U+Mj4ToBVv2Lh3nHNz52kDx53qpW/0dZ9hkvYI/1Zh0
 9OcA6U46dwx+J4IF8GCD9gStXAMBsL+jt2EII4Vazt7WEOBmnIIcHgrOUbSNc1+DIAmK
 kW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261406; x=1738866206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmP8UEFFJb/lmaE2ZgdfHHn0pCkyFx+RjhYIX8J7P0Q=;
 b=QJUheJuh+BLPq4D6yI+w4svkeIuhA7/Ta8vZA802b44CkeW754o+8OdTkEmtLopozW
 aHqpRAMWG6muzTLueoYmFLPjU3QM2rqQ41yjdx4g+78tfiK7EaJffuVYPo2BjsAFWj3h
 nyBzKKaOeFhJOkEQ2d7yex0W/8CTN6laOngATG3dKcwmG8P08w1JxT1TXPK31It1y3MD
 KSwbGxNHyIShGgglwM6bGRO8bxyf7k55M5vPNrjH5Bx7TyzxS7HPN1DXdtndDtkbB/rI
 UkTUtdcYFUAi2POHPPM2rrTAHlTbTQic+S2E9d0NnVC+FPEG4LBm4TdZ8KPDODi4c1hg
 JT2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJNxLIWW9d3I4EURBEho5qOEwjApgIbOdvcacAtSTTM5mHgb93FNr8VsXauM2y3pnw4rzMkT1INK3X@nongnu.org
X-Gm-Message-State: AOJu0Yx+sAP7YE0RXcoyelOR/kiivSzugCEJv/obWColiDdWoMnhirh8
 iQC3XMubBmxbGvWGT5afPdKAg2LLPaBliTHaNu14LujMbLxIhAzdGvaHqGgPtMWhZDh4ZeC9+BN
 L
X-Gm-Gg: ASbGnctLk9wTwAH0D5C5fZXWpB9IQD9K2bOVIYB5SBAe7wlgPqJ4ZjVMLhrrV+MkG2l
 QprywMgKoCl8WbjUz6qW2bIFgpt3BHLDo0XvjGLZUo8qu0pszkMtMqSE8mMRSIwKygCyDpvhCZV
 zP8D5YDWKPckzW3j0lONgxa6k92o1/CSmz5j2g18nRLOoHIffl+UPz1YtJqxFUFww3Qo9dAWl+j
 wwCmeRbYfECQl3ZlpAAqXn9SJgP1uFTkb0YPGxq2PowAILUjMnukt0+pXUb0+ibdOrj9tq6UESG
 ma087jYMV8zDEi3dQIBFaw==
X-Google-Smtp-Source: AGHT+IG8aY4r7B2b0xDU0aJSvyMovUrSwG/pPfK7hVFdfZtHezOuCQ61vk4gxxdxsTyiDNbfTQoHdw==
X-Received: by 2002:a05:6000:dd2:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38c51969feemr6698796f8f.33.1738261405982; 
 Thu, 30 Jan 2025 10:23:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 14/14] target/arm: Correct errors in WFI/WFE trapping
Date: Thu, 30 Jan 2025 18:23:09 +0000
Message-Id: <20250130182309.717346-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The code for WFI/WFE trapping has several errors:
 * it wasn't using arm_sctlr(), so it would look at SCTLR_EL1
   even if the CPU was in the EL2&0 translation regime
 * it was raising UNDEF, not Monitor Trap, for traps to
   AArch32 EL3 because of SCR.{TWE,TWI}
 * it was not honouring SCR.{TWE,TWI} when running in
   AArch32 at EL3 not in Monitor mode
 * it checked SCR.{TWE,TWI} even on v7 CPUs which don't have
   those bits

Fix these bugs.

Cc: qemu-stable@nongnu.org
Fixes: b1eced713d99 ("target-arm: Add WFx instruction trap support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 2230351a8f4..02c375d196d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -313,15 +313,19 @@ void HELPER(check_bxj_trap)(CPUARMState *env, uint32_t rm)
 }
 
 #ifndef CONFIG_USER_ONLY
-/* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
+/*
+ * Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
  * The function returns the target EL (1-3) if the instruction is to be trapped;
  * otherwise it returns 0 indicating it is not trapped.
+ * For a trap, *excp is updated with the EXCP_* trap type to use.
  */
-static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
+static inline int check_wfx_trap(CPUARMState *env, bool is_wfe, uint32_t *excp)
 {
     int cur_el = arm_current_el(env);
     uint64_t mask;
 
+    *excp = EXCP_UDEF;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         /* M profile cores can never trap WFI/WFE. */
         return 0;
@@ -331,18 +335,9 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
      * WFx instructions being trapped to EL1. These trap bits don't exist in v7.
      */
     if (cur_el < 1 && arm_feature(env, ARM_FEATURE_V8)) {
-        int target_el;
-
         mask = is_wfe ? SCTLR_nTWE : SCTLR_nTWI;
-        if (arm_is_secure_below_el3(env) && !arm_el_is_aa64(env, 3)) {
-            /* Secure EL0 and Secure PL1 is at EL3 */
-            target_el = 3;
-        } else {
-            target_el = 1;
-        }
-
-        if (!(env->cp15.sctlr_el[target_el] & mask)) {
-            return target_el;
+        if (!(arm_sctlr(env, cur_el) & mask)) {
+            return exception_target_el(env);
         }
     }
 
@@ -358,9 +353,12 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
     }
 
     /* We are not trapping to EL1 or EL2; trap to EL3 if SCR_EL3 requires it */
-    if (cur_el < 3) {
+    if (arm_feature(env, ARM_FEATURE_V8) && !arm_is_el3_or_mon(env)) {
         mask = (is_wfe) ? SCR_TWE : SCR_TWI;
         if (env->cp15.scr_el3 & mask) {
+            if (!arm_el_is_aa64(env, 3)) {
+                *excp = EXCP_MON_TRAP;
+            }
             return 3;
         }
     }
@@ -383,7 +381,8 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     return;
 #else
     CPUState *cs = env_cpu(env);
-    int target_el = check_wfx_trap(env, false);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, false, &excp);
 
     if (cpu_has_work(cs)) {
         /* Don't bother to go into our "low power state" if
@@ -399,7 +398,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
             env->regs[15] -= insn_len;
         }
 
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, insn_len == 2),
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, insn_len == 2),
                         target_el);
     }
 
@@ -424,7 +423,8 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 #else
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    int target_el = check_wfx_trap(env, false);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
     uint64_t offset = gt_virt_cnt_offset(env);
@@ -441,8 +441,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, false),
-                        target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
-- 
2.34.1


