Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBCDCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv1x-0001Z2-B7; Thu, 23 Oct 2025 09:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1o-0001Rp-I9
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1m-0006Jh-O2
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso8976735e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761224808; x=1761829608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvnDiGB/ScoEzWWOO6VF5KOR9EI5aejneEWS4HSU6NA=;
 b=vj30sYqjKlvn7J8J84v2U0E2XuGiqAmt5m+dDmGGmSA2J+2RsDyGZq6XYPocucSz35
 WVc/Wz+3xTmnBw7szoNARLKu/3IM5m+qxYcLWpG1XoSZ67SGthJ1FTVohwz/zTG0iP32
 G07nES6U0tv755j/ftOpbM5Icudqg3SnO89jWotOMhzqES4jrxYO2KChbWt1j1lzNyY+
 IfwbPE+mEywNP9xVSWTsHJ+IWoCWn9yM/8j5pbHU8zMp7wSQxbZtbNLXbbXbQepaa3cf
 KQzzhlvojDyKXomCk7EDEmbe+QjL5yevsbTqpzvn21pvoHMjwkSV0jVKmqoqsjxCHw2x
 hULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224808; x=1761829608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvnDiGB/ScoEzWWOO6VF5KOR9EI5aejneEWS4HSU6NA=;
 b=P+uHyCCNki3KS03rPl8rDwCYzqzctFcoBTZWG2X5kMLu1SEIz+f2dL5lagmYepMbq9
 T3QYoBX3RJNlZDD4SPpJe53alzTg8NOACr+6PnQGJX5yPu5PNYkxQdpOqco/0D4a5uiV
 /7Mv3nZnoT8MvNMVQsI4fBG9U153RZcY3j/MlfZDEkvz4o6hv4MeCiG4eJXzP8fbEyiP
 h5CrHOTN5+Om0QuSr5w/AY/gN5Q47O2zJwdAKjmmTC6FC64h55uhuCcqeBmCQy5l3aq8
 h5cT+ijdi6byIinjWiVet9VIZp1/EiFG5YWnKEJh6U6zCCjNKgK0EEpCwuEgBgyvfJAv
 L+Yg==
X-Gm-Message-State: AOJu0Yxcl6bgGve6ycaBq0iwQ+K1E5L+ueMcivil/CCfYt9cF7gzqFSQ
 JyU4w5Ymd0cCGO3UBpGSAylPeUWjQjoWuUza048vaJo/LaP9NLRv+DeTezAMHZfjp7ZL7sLyksR
 22fy/cvc=
X-Gm-Gg: ASbGncuvXiKmDHFMoE9XqPC6AbI6WsK9atlZ3Y0wJdHJwk8KIXt20mUlzA0619K1Kpx
 WjkDGMwYUdjLLG3Dcd4/Bjpwvt9nYHLIsVmokbKWETuyfhjPYSl1Xl0f1ECysIsQyRH2plGjKQ8
 2FD0Y19SqyNWk1KFGdWfKOKfoofW3+dyjFv6xGN1OVdeP03nxJP/vBLsPLHy5WSbx4n1XS6fNb8
 J9ZgSj5lRUilSAIuLjHAO+02RlrotrRhK2aR1+668CoQZgpKem5fmuoERJUQRHMe3k2ys6gnhYp
 Mnmd4mEClBCsX+SmcgX94ogWNKbF70eBI9VlLxAjuEfxK3Stbiv2289c8mAKTunCoMOIO+gZeIx
 sx9wV7u0DLA+WBAC8PSUYtTO34iCgIZJ+t7T2Dhb3EZWBWin5+k3cU9AzMVJ16Mfo7D2KHIVzGy
 Mx7XqqvegfCY2GFsA/1vP0d2zUf0qGvUCk5z7pJApaKtDO8cEv4imlXeJ+39g/3TggXAD4Ng8=
X-Google-Smtp-Source: AGHT+IG2XyxY5paEm73our2Qgpsle8ksGIFwPN9bx48OT2DZ2LZFl5eC3PZdw138qznEak6DQrA7/w==
X-Received: by 2002:a05:600c:3b04:b0:45b:7b54:881 with SMTP id
 5b1f17b1804b1-471178767ffmr161304575e9.1.1761224808519; 
 Thu, 23 Oct 2025 06:06:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b33sm95619935e9.14.2025.10.23.06.06.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 06:06:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 46/58] accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
Date: Thu, 23 Oct 2025 15:06:22 +0200
Message-ID: <20251023130625.9157-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Return EXCP_HLT to the main loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d3d05b0ccba..b0918de5f92 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -302,8 +302,6 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
-static int hvf_wfi(CPUState *cpu);
-
 static uint32_t chosen_ipa_bit_size;
 
 typedef struct HVFVTimer {
@@ -1009,7 +1007,7 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
  * Returns 0 on success
  *         -1 when the PSCI call is unknown,
  */
-static bool hvf_handle_psci_call(CPUState *cpu)
+static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1092,9 +1090,8 @@ static bool hvf_handle_psci_call(CPUState *cpu)
             ret = QEMU_PSCI_RET_INVALID_PARAMS;
             break;
         }
-        /* Powerdown is not supported, we always go into WFI */
         env->xregs[0] = 0;
-        hvf_wfi(cpu);
+        *excp_ret = EXCP_HLT;
         break;
     case QEMU_PSCI_0_1_FN_MIGRATE:
     case QEMU_PSCI_0_2_FN_MIGRATE:
@@ -1925,7 +1922,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
             /* Do NOT advance $pc for HVC */
-            if (!hvf_handle_psci_call(cpu)) {
+            if (!hvf_handle_psci_call(cpu, &ret)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
@@ -1941,7 +1938,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
-            if (!hvf_handle_psci_call(cpu)) {
+            if (!hvf_handle_psci_call(cpu, &ret)) {
                 trace_hvf_unknown_smc(env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
-- 
2.51.0


