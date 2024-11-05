Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391ECD2B950
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LzL-0006j5-Rb; Tue, 05 Nov 2024 11:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzI-0006gl-2v
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:00 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzE-0007OE-VH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:00:59 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso6599871a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730822455; x=1731427255;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLGSZwK3UxPn1kZOhpJnWP1fni4o9+7TVcds9qkz8Vo=;
 b=tCJmQcFHwtlC/FhiB5h/Z2lkbIEDMixN11ycCF2H2QUq/UoiwrtjDKzwlY/kndnLw2
 Qq2PF0u52EtDI/l4DKSIjhj3/JcUcMu8vq1aMMWpsy5Pdxn/7VqArbvOj+ZB2YsUDCbu
 +VAvmNR/nEbjL0W6L+fZAmzsF8Lw7GQBSiEStbvbD56uFqoNeXwAOz5k1CO6l3uH4qvj
 hiAIX2Gy8mkkbWm/BsB3FAAJr+Qi2/4YLa34qSWMdWQ34V+eMjuIIvxRfsLQIFy+5fhe
 ay4LD63e3DE9G3hcO96j76poLOUFyKteK11zKjtCjQ4Egxgjcmj1tpNgoCTsDiDOfCoQ
 Wg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822455; x=1731427255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLGSZwK3UxPn1kZOhpJnWP1fni4o9+7TVcds9qkz8Vo=;
 b=YHqzDT33/6uocthJcNVnr+FsURJH/hp6Oo21mr8Z28/WIyhHOcpYdv63yEynzD0IrG
 gbfrNYImu3s7y1Cfrc/KOqHPHZdMo5qKmJM3nSRzzKV4Thc+Fgmn3gHQWi0mzcbm5MHp
 DlsuY+qSL/ER/AiwgItnw+vybw87u4KCPGJvtsZcVH5SPtl1XQ5zB8vl1WzjCSWO39Ii
 MTS1ASsILQIpFk7n1ld7mIs/DY8nD97dEybWh151bPSDcQs4/hixizglUEUDgWtO3k/Z
 TAHwjvw7fROIICTTJVNiGXjURd1tw9HjfJvLvvx/G3hG5gH4t7lJ+gmuInlzePEYWNCA
 vV/w==
X-Gm-Message-State: AOJu0YwnNLCWpAwFmpWU5Yn/oYfvy6uFEXD5s30g+SlAookdCko7IS+C
 Twjoxjq4Uy5WJJ++sHllfac1MawLuJUUZ7oDA4YpfMa649282I3spplN6P8LR0BWTRM2TcL9sDa
 r0g==
X-Google-Smtp-Source: AGHT+IEdE+/dkCePTdsFNvInxRUqaZQvpfEuUzw6kpBRTizb35saxv9i1LRTSeJsBYMGOjqbW+KA5Q==
X-Received: by 2002:a05:6402:210f:b0:5ce:add3:feaf with SMTP id
 4fb4d7f45d1cf-5ceadd40012mr15751012a12.22.1730822454488; 
 Tue, 05 Nov 2024 08:00:54 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6a9a41bsm1467773a12.14.2024.11.05.08.00.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 08:00:54 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, pbonzini@redhat.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/5] i386/hvf: Integrates x2APIC support with hvf accel
Date: Tue,  5 Nov 2024 16:57:56 +0100
Message-Id: <20241105155800.5461-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241105155800.5461-1-phil@philjordan.eu>
References: <20241105155800.5461-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52b;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52b.google.com
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

v2:

 * Fixed merge conflict due to recent upstream CPUID code change.

 target/i386/hvf/x86_cpuid.c |  2 +-
 target/i386/hvf/x86_emu.c   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 3a116548a3d..ac922d7fd16 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -77,7 +77,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
         ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
              CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
              CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
-             CPUID_EXT_POPCNT | CPUID_EXT_AES |
+             CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_X2APIC |
              (supported_xcr0 ? CPUID_EXT_XSAVE : 0) |
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


