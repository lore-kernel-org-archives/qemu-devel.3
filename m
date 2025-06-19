Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D590EC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5u-0003hG-IF; Thu, 19 Jun 2025 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5l-0003fH-Ud
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5k-0003vt-AI
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so7806765e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338845; x=1750943645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3vxCB8AF1OexrFi26RMBcdit/f0pHUtl0WDW3lo3q4=;
 b=DMaUwi8UaqKiHT3XdYHdzvT8l3ni0strEsyePaZgEsgvrAxMas/pfdODI8xHDCyZ1A
 08vPfAkk7rcEA9e1S9xkH2NK6l2gxr3/hba0g/jz49O42Su+CNGtve36fqbrUSvSQHg2
 tXLEm2jorJUJdhefBexmBNMdpKNXFiqqsTQcHp7m/jZfNwrj0/rM5u018OWn3OuOeH/Q
 /zrpm72vYnQ+ZWgyPmmr6h/RZOEW1jRD8qHnGOaLFBFuueiMR0nALtfYlMKxK49HfvXR
 aDZeb6jx+N/8fnFHY/DKq3i45yH1E98bCBlAHEHKSXMVfhUFvZYDPlyTdJba9/rmbIfs
 hqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338845; x=1750943645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3vxCB8AF1OexrFi26RMBcdit/f0pHUtl0WDW3lo3q4=;
 b=vcLOQ1LKnryc3dvsyk98SoqViH3Be5VKfXOLLWdtUD3+kB7OORHmmL5TQNODZt76M4
 UEwyHXxZrBmdZGjP8pdeCAXzHo1O6m2vU49KvV0O8FiYkWWf70b+fj7x+5LsR0kAJX+M
 dEM3PZ3hanUwKkPbbnjWy+DGgBa0YVfjxXcqyzoeEsNBsKR0mVcQSr9xuqu/abIqVfxf
 36Otzsk86swVT1lUWN4nJvn+071BoIvBSwhcwRiDJHN0gbWTGYldFj5WBrggAIDTuqiS
 bpzxfn742R7qLEovHiYGRwECijwFRDnq+/+1abGD5pLyTeExm8NO+1pe8g6h5JMoRYxu
 W+Sw==
X-Gm-Message-State: AOJu0Yyp6gRE/S+IBNOQlZN1joPBnBBCDVDYq4o2MLSz7nwxwPUEYn1P
 98ZydsUJkQLMFD6quODu3KRunCy0C+WFDwvPwXIFmTLx35enjcFOpWG60Oq7wzxe3kmoz8p9MXv
 V3SGefO8=
X-Gm-Gg: ASbGncu5qQw0NI91iWLzGrCQKj8h6JORmySH1NlE6hjcHJHkT76t14H0AaStO9YYFwG
 MlObkgED7fnh0gcTCbKBm5zjKxF9vjkvrgsgNZEb6nRYCxqYP+FaOGjZ27LEYIsr2dpdLf56GPp
 Pa0r1MEUsGXUEAhHc8Y6ssyqHq34qDYlM0qzxZFVXa52lzLgrVm/6Ejz0/vCPbmE3PvX7fOCN9P
 ento+ErOuy5zKqfyjFsyDww7Z1RNq4RBMHHNw357Vl889eutCxqQjID+Ef6cAhsUDtRP8pakJlM
 u0i0uj3Im7lTZw5RFTJNN+xioFd3DbWHWBRczlcsJT0cRcYmj6j3pEsT3Gr5f0VgAtP5ZebW7ka
 9KG+Qd5AHUh/Kky8XT5HiC2N/md6URvVsTB5H
X-Google-Smtp-Source: AGHT+IHelkidw/tQQ9RKP0VDtKPsH2g6yNSOnkNt0atUABraIjdPtrs1NJAkAu3tXReVPLd5lAEiMA==
X-Received: by 2002:a05:600c:1e1d:b0:453:b44:eb69 with SMTP id
 5b1f17b1804b1-4533ca7518dmr224054745e9.13.1750338845548; 
 Thu, 19 Jun 2025 06:14:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97ac4asm28331335e9.3.2025.06.19.06.14.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 08/20] target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
Date: Thu, 19 Jun 2025 15:13:07 +0200
Message-ID: <20250619131319.47301-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Tracing $PC for unknown HVC instructions to not have to
look at the disassembled flow of instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c        | 4 ++--
 target/arm/hvf/trace-events | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1ff3ff7b91a..ccdadce4766 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2069,12 +2069,12 @@ int hvf_vcpu_exec(CPUState *cpu)
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
index a4870e0a5c4..245338c5bf4 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -5,7 +5,7 @@ hvf_inject_irq(void) "injecting IRQ"
 hvf_data_abort(uint64_t pc, uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [pc=0x%"PRIx64" va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
 hvf_sysreg_read(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg read 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d) = 0x%016"PRIx64
 hvf_sysreg_write(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg write 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d, val=0x%016"PRIx64")"
-hvf_unknown_hvc(uint64_t x0) "unknown HVC! 0x%016"PRIx64
+hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PRIx64
 hvf_unknown_smc(uint64_t x0) "unknown SMC! 0x%016"PRIx64
 hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%x pc=0x%"PRIx64"]"
 hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpu=0x%x"
-- 
2.49.0


