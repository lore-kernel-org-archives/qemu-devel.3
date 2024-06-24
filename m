Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D710C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgIB-0005vL-IA; Mon, 24 Jun 2024 05:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sLgI9-0005vB-Bc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:47:17 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sLgI7-0001tU-3G
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:47:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57d203d4682so4838807a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719222433; x=1719827233;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vm1+u9RMLtAJgeoBM6Efk666xOoNwf4tI75owi8IaIk=;
 b=YEtQGQ4xeuR5oHpLvmlsEj99IgAAfaP2WZ9m+f59HwbHXVk/Q0n3aRJpWZYejXEaDL
 2butHQo9IJP+cpzQS5ILCkJAynNRhFoeBZT8SN27DQwS2qwJovd8Jv0oJ2MJLLAVjKnd
 R/VEmw21ojErlltt5nDhsKYLMILTK2SXG6gck4xbE7gaRTVGxDN+RDxv7qrDJQOnMdab
 r2ikpoF6AitzovoU2jya56CAqPgtpZ0FWYPQ1PHyq6nCuJKIZgF+vNH0pA5To8zX7mLh
 2xUJj+2rvkubtT+0ZPcZD54Uw6EE0dYvJBjbqh0s4nSQUhgJRbSG3Ebp2uYZmuMH01YE
 8Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719222433; x=1719827233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vm1+u9RMLtAJgeoBM6Efk666xOoNwf4tI75owi8IaIk=;
 b=PzAF2a0utryyJ4jexQ55/1LsDrdCxI0/OxLT689kygIUpIMNdY8wO+dbDrLP598Fpv
 souyj5W8Fzz7DSZFtjNvs+FHd8b3O/ZL8vk5Bw6Lun3X+SkAp1IkH8Q7au2H7kDMhidw
 Ol1eOh0i75XYNTAt5WYxppU3A3Od3RB9HAplY2PFJUb2eqvhkly6EnouTBGoxn1Q7C3O
 B6IOuNQo2raLqMsJnzOg4RMOLs7MayDQK0xeD02qhPokmkFSXvG3Eh6v/c/judF6bd0l
 67+QYcMXMNnDp+Lvc9v1+qxUN52nQyoiyi353t+wxMxtqa9avsj8OzJS0Hx4sGixFGwo
 +VNw==
X-Gm-Message-State: AOJu0YwFQC4eHHMUHLwvgdJ8fy5t10AGJFd2RNFVQMcZRIczSYg5EhIR
 1z0Wx5butHwFoHQgtX4AQt3l08MG9GqWXtxXOJlMpRzbIR/v/4ejotlm1g72jFZxRSnuQgDOuqN
 ylg==
X-Google-Smtp-Source: AGHT+IEbDYLCDbnoYpYflpY8CKgNvuyj2GSykkwADn6OojuvV7soONOZrCGQUj2qon0C47Gnlynz4w==
X-Received: by 2002:a50:d50c:0:b0:578:676e:324 with SMTP id
 4fb4d7f45d1cf-57d45791fc4mr2910621a12.17.1719222432898; 
 Mon, 24 Jun 2024 02:47:12 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534e35sm4464712a12.62.2024.06.24.02.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 02:47:12 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 minhquangbui99@gmail.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH] i386/hvf: Integrates x2APIC support with hvf accel
Date: Mon, 24 Jun 2024 11:46:47 +0200
Message-Id: <20240624094647.77156-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::533;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x533.google.com
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
index e56cd8411b..4f260d46a8 100644
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
index 38c782b8e3..be675bcfb7 100644
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
2.39.3 (Apple Git-146)


