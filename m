Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7FBCCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcmD-0001hn-Cy; Tue, 28 Oct 2025 02:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcln-0001OD-3j
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:01:23 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcld-0005ba-VU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:01:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4270491e9easo4529705f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631272; x=1762236072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFhev+ViAFFSzJ1smEp5sPV4YLk7YFAUxT1dvo2z6os=;
 b=DYzAq1SBw9H+MlUbEDXHoHbt9kU2bbfEbCz/dLF2wIvczgl13y3cd+x/k06ezLT4Ub
 WIt48qCEmxHZ51V+0Sxu/hz/6/2utX1r5aqa2G9wtQY7nUUV3gRnGAzf61wcm0zdoaIo
 x+dm1tonCU+yaF6MkA4CqHuHZg0ErLUrvGAHVUPzSm3qSEXVacZ79Xg6mYgXo6TB7087
 oWRywGMzED/ag4mKTijzUzuwur5INKdkRlKORALAP938ZkTUqVhTvI+UdDDpJ4M2pkTO
 jJV9eihkT/kpSsS2xsljBbDpIFp+xdgE8mLvqjFniyqQcqvUCjsaKa2+vr1s0Ejzxby/
 cv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631272; x=1762236072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFhev+ViAFFSzJ1smEp5sPV4YLk7YFAUxT1dvo2z6os=;
 b=oXSxIn3i3IJrZSo1joahSggOix5nODPaqdjCK0bfNI5wNSqIXUjmr50Lif1c4uqYqZ
 hBf7le+O65aFdflIrTDtiikhHDcD8DevNYC+BrnfL1EdvVT9ig8WwltLi24DHr0DfX8e
 wVi16wOwQ4LLNX3F5amy1+OCXnOs7OYvaWZcEDWLwuVZIqW6Ov/+SbcNRGufOycH4xG/
 0gw4zVmVa32112Fdo2/E1d1X2Z2qQxkNgRkRbTn2EdNTtdkB73TUnM7+MAwswUAml/AC
 /uwN/v1MnNTxu1c3PRW89a4XGjD5P0qvz0uDXaiaMZm9Glg/1MD7h1JP+3AbTz6oeb11
 s6kA==
X-Gm-Message-State: AOJu0YwqVdMCRH/hkvfzQfstscgFFtGnCKiVtDGNYQ5y5s952eCrC8KH
 /vSEqbN5cHC5zaun9EJ38mCzSv/2b/tqiaJE4uQ7UBzyDndyol2NX9ewPUvXk1TOveagf9iwN4H
 SyM9iMY4=
X-Gm-Gg: ASbGncvGdhRE0cpFHLdxiVmntXX2rhaNumL/RHHTBrWkkocvn/12mP+cpBz/08LuG8j
 fNkSSrYUR2PsSLhnkXhxZrR1ZxcvTqMsfpLSWCqtpI6e6fTQxrnj6sq91vx3nyVccsD2quyuiWV
 kVMQKK9Uy7/d+JHJWK/MG0wSLK3EiXaOWRFHg/UO/hctf/95gWWsFhvz2cUKm2ziKFpUmLiz41B
 1hjq+hyYpAJxZ8EduDZORKjDyc1A1xdvN3W9Bqe5d0rRbhGvM9V+O1jvV3K2K/9EarIEOd1FVDB
 /+TMzUnbT5mYbcUMU+nCTQVms9YIBYBRLbLJOxv8a7RksxsYwsYc0YLdWbH3+mBVjcl5ooaHwEv
 Oo+z8fys9gwelpfuPCUAsIDifaQkymh7LGlJv6ij4ZFf8Kdfk0Y2Ds6QkF0qWjdHf9AN/PpXn/V
 TBVrOnpycJIpAegwNedk/qMtX2ZnWLimCEZwn3wVkaoEdegMHRQuW5/sY=
X-Google-Smtp-Source: AGHT+IH7yne3eVNVI10002KbW8Od/u2ibkGXmfbRK8wakFldV85f8E9RfyKRdst1ttHCkAWdPTtjqQ==
X-Received: by 2002:a05:6000:2911:b0:428:52d8:9680 with SMTP id
 ffacd0b85a97d-429a7e5522bmr1619947f8f.18.1761631271610; 
 Mon, 27 Oct 2025 23:01:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm18184125f8f.28.2025.10.27.23.01.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:01:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 26/59] target/arm/hvf: Rename 'vgic' -> 'emu_reginfo' in
 trace events
Date: Tue, 28 Oct 2025 06:42:02 +0100
Message-ID: <20251028054238.14949-27-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

In order to extend the trace events to other registers,
rename and pass the register group as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c        | 14 ++++++++------
 target/arm/hvf/trace-events |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c882f4c89cf..26bafee259e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1149,7 +1149,8 @@ static uint32_t hvf_reg2cp_reg(uint32_t reg)
                               (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
 }
 
-static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
+static bool hvf_sysreg_read_cp(CPUState *cpu, const char *cpname,
+                               uint32_t reg, uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1172,7 +1173,7 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
         } else {
             *val = raw_read(env, ri);
         }
-        trace_hvf_vgic_read(ri->name, *val);
+        trace_hvf_emu_reginfo_read(cpname, ri->name, *val);
         return true;
     }
 
@@ -1261,7 +1262,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (hvf_sysreg_read_cp(cpu, reg, val)) {
+        if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
         }
         break;
@@ -1432,7 +1433,8 @@ static void pmswinc_write(CPUARMState *env, uint64_t value)
     }
 }
 
-static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
+static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
+                                uint32_t reg, uint64_t val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1455,7 +1457,7 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
             raw_write(env, ri, val);
         }
 
-        trace_hvf_vgic_write(ri->name, val);
+        trace_hvf_emu_reginfo_write(cpname, ri->name, val);
         return true;
     }
 
@@ -1581,7 +1583,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (hvf_sysreg_write_cp(cpu, reg, val)) {
+        if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
         }
         break;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index 538af6e0707..29387780e3f 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -9,7 +9,7 @@ hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PR
 hvf_unknown_smc(uint64_t x0) "unknown SMC! 0x%016"PRIx64
 hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%x pc=0x%"PRIx64"]"
 hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
-hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
-hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
+hvf_emu_reginfo_write(const char *cpname, const char *regname, uint64_t val) "[%s] write to %s [val=0x%016"PRIx64"]"
+hvf_emu_reginfo_read(const char *cpname, const char *regname, uint64_t val) "[%s] read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
 hvf_kick_vcpu_thread(unsigned cpuidx, bool stop) "cpu:%u stop:%u"
-- 
2.51.0


