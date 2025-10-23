Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1C4CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtse-0005TJ-SQ; Thu, 23 Oct 2025 07:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsc-0005N7-Ny
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsa-0002aE-KU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso7941005e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220393; x=1761825193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcuUhmYfuiOMUA6fkhcSZ2utpWByLaxsadmUM1Ytmjw=;
 b=mIrZO1EkK5++0T97kde2qev8sr0mJL7l/rD3l25HsbHbyh06myu9CSzjLkYNk37wAA
 ei14u73yR16DCLqq9IRrvVdyyc507CUMVNWHfhOnbQVmGDQULhmI5jMoHU46HWPwN//E
 oEfjjTP3RYNZmHO80Gth07a1Z6xrD/2EBSp3CRBTSnlLF70FdBC9Is+fQidQn2kdcQSb
 D/zPhANoENlUh3axUcAFYTJ2ncz6DViQ2+rFztiJb+1H+h0Ol2rSku2OBODYMO0HlVUf
 hl4dDlvYdJm7wutBZQNYbD1VFhGSnExVVai3r2jda655aNzi/DSwirtF49Sa54pQXkal
 7r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220393; x=1761825193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcuUhmYfuiOMUA6fkhcSZ2utpWByLaxsadmUM1Ytmjw=;
 b=XfcTKXfDFPqON+VL/U2R0h4MQlGwKIuEoalQAX+dZY63LARcdUArWkFP8Iah0SqizZ
 C5tqmzcXfnfRCHfQh34EWUtayZJYxH8BrAs8OCkcJGkIkF1A7VxwfIVJUHwSUO9IBv5w
 2hsIqElFsF/oxcZdiJr9Lt/nr3SRG8vEKk852VMq6uKsXQUF4jnfg/aHxNKvG7WoHK9C
 1QkZv8E/Tq8P/EpSKwOhC6aX6Rd65zPLMip30fBpZG1bYIce/ZOWsCLr4HfRWhO56yRi
 T4yR8IfZXMi4+A4zzb/Hzt63tkKQdqrPtow1Clhtgh6Z+SB9uR4mD7nAyuIAqNcY7Nrj
 VjyQ==
X-Gm-Message-State: AOJu0YxnjQrCYO/zLeQyG26OHpZtC2LCHxK42XGUEmnfmlt8YF2IvDHL
 j3SeKVNelNP/iI5rrlqp0f6cnURfLLavF7+D2bk+FShTCIcbJ5508AeT2pA+V1NKsX3EkZZzp02
 vTtWWj8Y=
X-Gm-Gg: ASbGncsS2VtfmSrx1fk9e6qdblek9b4Gcdda30iFVn8TN6Czse06KRbotIrwQWuSOdC
 Sr/v8WLp6aATr0H8eT8lyQO5royWghn83OGohvnXJG2B+Gral8aoKjyEIRLjECb6qyBAL87hmKt
 1CLGTFzbPSybsatKDiwwplI9omz0qYk5YCwWALQDNtL5f099QooSlZMkW7v8WuKcDMx1fJpKlKn
 wqWnU/Ka9w7K4kYmwuvWUYwZIPal/WmXd8KHMWAq2zAGvRnQOJWVDUHQRwlgvx76KT15m9Y8fAo
 sP6+lBo+75eaISxqVHmxuGRj88I+B/EhWYV3J1Jsc3UU3PT2mL8NXiGfmoy9+DgkVWp7ROti/9F
 vtKXKgaEXOGIpQBlP54akxe4RZ8kGUPdy6vAdLL04uy2tUTerKd7trnLfcwn3zE9u3PeIbmWWyX
 VztdR+ZcQzV9v4Ital/YpU/QaPrjiSAJKZjnH5TXY04Y4OcZ1SGQ==
X-Google-Smtp-Source: AGHT+IEXZEZsRuDE4uGNeWOqPatKxg3anrumOc/RC6nTgP06JMi9bVb0uqT8L9tZDj0jRZA34AMf8A==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-471179176b9mr206081475e9.28.1761220393079; 
 Thu, 23 Oct 2025 04:53:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496bf7137sm59345735e9.3.2025.10.23.04.53.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:53:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 30/58] target/arm: Re-use arm_is_psci_call() in HVF
Date: Thu, 23 Oct 2025 13:52:41 +0200
Message-ID: <20251023115311.6944-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Re-use arm_is_psci_call() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 67130ce27d2..e913662dee5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1945,7 +1945,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
@@ -1958,7 +1958,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_SMC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
             advance_pc = true;
 
             if (!hvf_handle_psci_call(cpu)) {
-- 
2.51.0


