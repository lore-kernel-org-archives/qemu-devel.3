Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5710C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSh-0005kg-Pt; Tue, 01 Jul 2025 13:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSb-0005gT-3V
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSY-0003da-09
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4530921461aso39393075e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389672; x=1751994472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lu+dhy8iYnnYk+OhSlOhY3EbkuSfbLX8WS//TkMmK/k=;
 b=nv3THcCsQ1ifJwASqqj6d3A0RuwwNglJhWZyAc/5uLYxpnh+Kvx1zEXrYiFyQIYVnQ
 GXbtZrvL4UtK5Ivhr2E6FNo5wdwFwmQLINvakFvVVKL0doYEfDVIM7h67sF39mnX21fR
 ve8NkbkzyWpXL8kcP2s6L/UBwslmxifoG6BGDeV22T57kj1CuJv6ZkbDunDREfaTkyRf
 xZYZyayzx4s96jFi+lE1ffKEqG7uaJPEbdcFhITBD174YT2DO3gdgc9B0vMWmdmvkdlw
 qDUKxUbdSZUU6O7yDOYoLfuaazVEpAMitQh/xq+deQ7Ya9TV2FLButUf/OTUEUwsuMmf
 QkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389672; x=1751994472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lu+dhy8iYnnYk+OhSlOhY3EbkuSfbLX8WS//TkMmK/k=;
 b=krhX//KvDLIS5by6yoxOYp9rckbvdAEdft90ZALDBchZgxuar8K92kriuCIAIeHOqG
 aVT043F6nBt8JJewmgPhGOeuAVTkpTceISXlml52E712EkgW+UkihI68EZVbZuiKbqpm
 d0DqsGsU+e9W5n8zg2DDIWQd9UrOby6Kf1UKMHe0BNoa5UjyrPT7ZiOCq3aqq5WoNZzG
 y/e6pJget9+O9GjeTieT0NRIhied66hbRKswECUoy6kYdhke2aYEJ4ZrLAICvmPLhY40
 XgnhLR7S70ZVRm3gHdncrLXtWYc1p6JUTFHld2RwFPXBarKrflZPu3/gmjZsraVx94cI
 A3NQ==
X-Gm-Message-State: AOJu0YygQYbZzPFfFH2y+3HAl6ohcy8ig3Td/D9kD3cPYqOvTOk3DzL0
 qk5cu8+VImb1Dm1a/0T5ZYH1E+7qDIhvZCH4lGvgDaSrvvPRIFbQZUdVwxaIrFYH70znTHHaNwZ
 97d9e
X-Gm-Gg: ASbGnctxbNVh8iguhxKgGkBsSHu2cVbS/lduJSZPU0gl5Pvxfbb9RJ96zHTNIM1JOb4
 T3XogxegyvmkOsJrFEKIe9J6FI1jfk9pGxjNENdepkuuxPcRVcCSqpCAjWZLE2hHIveZ6RrTiU6
 WNxHwjtncOghazKEFYYjyKnrJi4u3ounQR1CCqNQPYMyphut0yRV/jA7xK7VJ2Lsc/auORvDIgZ
 1C3LCIssKLEiTiIT/6zZDjpzikn3wPf7rsiSfpPyFITR/pWQg2c2B56hspRea7143GZSndP9biQ
 mfRx1t5pYFTQgN96NnuTFWEmUkhpXpozPwh7wEde9x3/6qOsGXP0btRWPCs6aVWhHzmW
X-Google-Smtp-Source: AGHT+IF1iW576U9wQl2v3l/A39HPtB+dawMBh74KE+hTTjbYB/60I0cGnKmXzAnGJNQbvljoQs8Scw==
X-Received: by 2002:a05:600c:c4ac:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-4538ee85615mr163266255e9.22.1751389672270; 
 Tue, 01 Jul 2025 10:07:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/43] target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
Date: Tue,  1 Jul 2025 18:07:06 +0100
Message-ID: <20250701170720.4072660-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Tracing $PC for unknown HVC instructions to not have to
look at the disassembled flow of instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 4 ++--
 target/arm/hvf/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0943365a681..f36973a32eb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2072,12 +2072,12 @@ int hvf_vcpu_exec(CPUState *cpu)
         cpu_synchronize_state(cpu);
         if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
             if (!hvf_handle_psci_call(cpu)) {
-                trace_hvf_unknown_hvc(env->xregs[0]);
+                trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
         } else {
-            trace_hvf_unknown_hvc(env->xregs[0]);
+            trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
         }
         break;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index a4870e0a5c4..b49746f28d1 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -5,10 +5,10 @@ hvf_inject_irq(void) "injecting IRQ"
 hvf_data_abort(uint64_t pc, uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [pc=0x%"PRIx64" va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
 hvf_sysreg_read(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg read 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d) = 0x%016"PRIx64
 hvf_sysreg_write(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg write 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d, val=0x%016"PRIx64")"
-hvf_unknown_hvc(uint64_t x0) "unknown HVC! 0x%016"PRIx64
+hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PRIx64
 hvf_unknown_smc(uint64_t x0) "unknown SMC! 0x%016"PRIx64
 hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%x pc=0x%"PRIx64"]"
-hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpu=0x%x"
+hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
-- 
2.43.0


