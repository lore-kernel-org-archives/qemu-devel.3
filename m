Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA83D0E3FC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43jr-0006MA-IA; Thu, 24 Oct 2024 15:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jn-0006Lo-VD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jl-0007zv-PS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d58377339so991842f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729798992; x=1730403792;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTkxEBmFYjhTgE61q2Wuic/Pvst8IIWSyZemzZLXOhI=;
 b=s4YZ3OJxjn1rKhQETOH1KKUjkNkHWgU58ieAQvU+mr2MPqmrj2mAmBR0DIg73dRXYh
 1xPaROULLSLjlg4U0Mbb70iWjkXpa8KB2UTWfz0z1b6H2oP7TI32y6Tr3wWjp7smqBcy
 mkv/V9StMiw9/jvFKDbZDvrvFAXbDPwWy3EEh/bn6b/zc1EyyQ7vz6rPtQX5ElZjKlri
 R02tXlZpvD6Inmo5MgQxXvfmeW4+QAZuDGeCzA7rxSn+pl2jYuOmqY/m66T0mKHwZjjM
 lG/uTsboJ2siwueBBjrWctSPWkUDk5prF7Eg36dOJKjFpEigDLj03npqXPYiWT115mni
 vxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729798992; x=1730403792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTkxEBmFYjhTgE61q2Wuic/Pvst8IIWSyZemzZLXOhI=;
 b=GfNxJmulh3aNzbpkrJ6689+pdTLR75BFdATxawcaNra+aznqiESfOuiN8sOh0Jdrg0
 Q1K1my19i5bJVUqTOVo62FtqdY5JoMx7sbXP2mDW1xteSIOsbARI7YmSc+J12eXhePlY
 N24r/V8PgvivMsjF2JVqabYrmE2BzJ54uWNNWIWAwjQbufKl5ndHf47rH0RUKScqux7L
 aRnjWRE4JhA3SBTvQk2XW8++6tPrVuAGSmU9OKuAPOVLo+XqYJ5lxQlJuer1wohpdsM1
 2neLnRDUkb/sO7NMzdL3u/mY/6N05qXeapsu0ccoPpx9dE49t2JYOIV8Zj8yPIuAxeZR
 nfXQ==
X-Gm-Message-State: AOJu0Yyc1uo0cd9CzuM85mLt3XGDPE7lZVXgy1Y7VkMF0pmLCfdGBa14
 9nrMI30UnBWtCIZBNsKgIpc6amAJSzPYtnAaXPTmClT2VkSirDLTXy9HYXkZwQ+XisDf/16lbl5
 ayw==
X-Google-Smtp-Source: AGHT+IHRayTsrm/xDVgQ3GClezAuv3usuxaXuzfPFbr7p8hDS25sTiuC41GxBcIKLqFSOPiFzbOBkQ==
X-Received: by 2002:adf:8bdd:0:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-37efcf8d06cmr5662201f8f.53.1729798992157; 
 Thu, 24 Oct 2024 12:43:12 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6545sm652536866b.31.2024.10.24.12.43.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 12:43:11 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/4] i386/hvf: Integrates x2APIC support with hvf accel
Date: Thu, 24 Oct 2024 21:43:00 +0200
Message-Id: <20241024194303.32100-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241024194303.32100-1-phil@philjordan.eu>
References: <20241024194303.32100-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::435;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x435.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Support for x2APIC mode was recently introduced in the software emulated
APIC implementation for TCG. Enabling it when using macOS’s hvf
accelerator is useful and significantly helps performance, as Qemu
currently uses the emulated APIC when running on hvf as well.

This change wires up the read & write operations for the MSR VM exits
and allow-lists the CPUID flag in the x86 hvf runtime.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/x86_cpuid.c |  4 ++--
 target/i386/hvf/x86_emu.c   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index e56cd8411ba..4f260d46a81 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -64,8 +64,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
              CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
              CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS;
         ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
-             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
-             CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
+             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+             CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
              CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
              CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
         ecx |= CPUID_EXT_HYPERVISOR;
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 38c782b8e3b..be675bcfb71 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
+static void raise_exception(CPUX86State *env, int exception_index,
+                            int error_code)
+{
+    env->exception_nr = exception_index;
+    env->error_code = error_code;
+    env->has_error_code = true;
+    env->exception_injected = 1;
+}
+
 void simulate_rdmsr(CPUX86State *env)
 {
     X86CPU *cpu = env_archcpu(env);
@@ -677,6 +686,17 @@ void simulate_rdmsr(CPUX86State *env)
     case MSR_IA32_APICBASE:
         val = cpu_get_apic_base(cpu->apic_state);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_read(index, &val);
+        if (ret < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
     case MSR_IA32_UCODE_REV:
         val = cpu->ucode_rev;
         break;
@@ -777,6 +797,17 @@ void simulate_wrmsr(CPUX86State *env)
     case MSR_IA32_APICBASE:
         cpu_set_apic_base(cpu->apic_state, data);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_write(index, data);
+        if (ret < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
     case MSR_FSBASE:
         wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
         break;
-- 
2.39.3 (Apple Git-145)


