Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADD9C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelq-0001JM-8O; Thu, 27 Feb 2025 09:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekr-0007Or-QD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekk-0003nn-Uo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9+wmdhWJh7eNAeDIFKf+aCQUmB7mSKSBUhZD4+88Vg=;
 b=bhhoFYT7bfimPMjuS1fjCfLMeDnP/z3PUS75/oVJKxwL+nMtxRO0b6r+quZIqKj/vcxAUg
 gCfxEZIUvRgWEy7SU5wTCruCreXUlXMT3HU9+PL5GTaovrU1O4WKbqS5Ieg5zt8zHH4GVA
 XsfRGBCSe5AQgwnwEfAxN96gwkUi4Do=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-AKn3mjsoNm-qvc_4wnQWEw-1; Thu, 27 Feb 2025 09:20:36 -0500
X-MC-Unique: AKn3mjsoNm-qvc_4wnQWEw-1
X-Mimecast-MFC-AGG-ID: AKn3mjsoNm-qvc_4wnQWEw_1740666036
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab77e03f2c0so105740566b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666034; x=1741270834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9+wmdhWJh7eNAeDIFKf+aCQUmB7mSKSBUhZD4+88Vg=;
 b=dlxzjDnQbqILUHsP9Ihj1tAyP/Nbx1iuHMpjH/VLtlGl2PUyYO2P/AIysRrVKkHINJ
 BXzhoqGZBNWvIxlQMCUf4t4JNIEV2m0G5RIqd0aH3iwIUrp+N5VHEC/pazyzq2hjfbGQ
 WLIWKRmly2qg0tYs3zGad29x97RHFRrRi2YK17JYjaNXw2loB93IAM4NzUY4Rn/0HeD0
 MyXkQRSNrfMj1MJP0tieVBHNNBG4cYMQkDBxbwgT/iqFqBvXv5o0eFhuoRXA+pm90fQR
 1SXaMnzM6S1lG3EYcGX0JWmulOy6iTxS3D37d4dxJZxyg1aftngP4qph7v1dVSokGdRY
 jrAg==
X-Gm-Message-State: AOJu0YyKbryxWGKNYFYbOFIHaK/qb49L3+ET/LfXiIyfu241vIquhWih
 LdjWtOisbn6oWs1UG+0w3toUBskjsmvpOSgWiCAstD1bLlla8TN447HTmY3hY814RZIPu7ejNM4
 +/MTpjm+W+xAO9uDl3qTDf3nYYvpeF7Gi9fXU3dNNMheIqq4RnYjL4kmwmc4t0CZsprNGrPNHiE
 sYesH39rzM71EiB8/zG83FPKDOnYmdrRLrqK3llhg=
X-Gm-Gg: ASbGnctt8+EbsII9XVOqiLnIAF0P9ECVo3s2nj0JZX+80KBZEmTs/Hb32AijunTDEJL
 jx9me45OZ3WBehOAZ9MfFHY5JVrl+hk6aUUBumD1afHcj2TxTGT85XRsJMZBf0E5OTwjNSMEwwq
 Udf2B+OreLvpIv6go8IVceSKnOQaK8zFp5NBnEVSY4WozZGlfq726nAv/g2BAdmLkIe1jGMSIwx
 9yt4F7cpUI4Wt7DvGSXiX1jkUModeHwZ2MzOopDbpbOXrmXN5vyHgj2Rpvaamd5szJ6EEf+K9vI
 d8IyWdQeDCWtd1v5BJLS
X-Received: by 2002:a17:907:6ea1:b0:ab7:f245:fbc1 with SMTP id
 a640c23a62f3a-abc0d97e4f9mr3167706366b.3.1740666033838; 
 Thu, 27 Feb 2025 06:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3A3zPIwkuEo2Un+v8PsDyfW+6auWuI/J1AqTspj2xH0s8Og9eUOd4HvcdAdvWVV7AJ6o9Bw==
X-Received: by 2002:a17:907:6ea1:b0:ab7:f245:fbc1 with SMTP id
 a640c23a62f3a-abc0d97e4f9mr3167700866b.3.1740666033267; 
 Thu, 27 Feb 2025 06:20:33 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ee4b3sm126995466b.112.2025.02.27.06.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 18/34] target/i386/hvf: move and rename simulate_{rdmsr, wrmsr}
Date: Thu, 27 Feb 2025 15:19:36 +0100
Message-ID: <20250227141952.811410-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Liu <liuwe@linux.microsoft.com>

This requires making raise_exception non-static. That function needs to be
renamed to avoid clashing with a function in TCG.

Mostly code movement. No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1740126987-8483-12-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf-i386.h |   2 +
 target/i386/hvf/x86_emu.h  |   4 +-
 target/i386/hvf/hvf.c      | 216 +++++++++++++++++++++++++++++++++++-
 target/i386/hvf/x86_emu.c  | 219 +------------------------------------
 4 files changed, 220 insertions(+), 221 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 046b681d134..044ad236ae8 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,6 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
+void hvf_simulate_rdmsr(CPUX86State *env);
+void hvf_simulate_wrmsr(CPUX86State *env);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index cd953849c99..bc0fc72c761 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -25,9 +25,7 @@
 
 void init_emu(void);
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
-
-void simulate_rdmsr(CPUX86State *env);
-void simulate_wrmsr(CPUX86State *env);
+void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code);
 
 target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 3ab3c0043db..9ba0e04ac75 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -481,6 +481,218 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
+void hvf_simulate_rdmsr(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t msr = ECX(env);
+    uint64_t val = 0;
+
+    switch (msr) {
+    case MSR_IA32_TSC:
+        val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
+        break;
+    case MSR_IA32_APICBASE:
+        val = cpu_get_apic_base(cpu->apic_state);
+        break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_read(index, &val);
+        if (ret < 0) {
+            x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
+    case MSR_IA32_UCODE_REV:
+        val = cpu->ucode_rev;
+        break;
+    case MSR_EFER:
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
+        break;
+    case MSR_FSBASE:
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE);
+        break;
+    case MSR_GSBASE:
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE);
+        break;
+    case MSR_KERNELGSBASE:
+        val = rvmcs(cs->accel->fd, VMCS_HOST_FS_BASE);
+        break;
+    case MSR_STAR:
+        abort();
+        break;
+    case MSR_LSTAR:
+        abort();
+        break;
+    case MSR_CSTAR:
+        abort();
+        break;
+    case MSR_IA32_MISC_ENABLE:
+        val = env->msr_ia32_misc_enable;
+        break;
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask;
+        break;
+    case MSR_MTRRfix64K_00000:
+        val = env->mtrr_fixed[0];
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1];
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3];
+        break;
+    case MSR_MTRRdefType:
+        val = env->mtrr_deftype;
+        break;
+    case MSR_CORE_THREAD_COUNT:
+        val = cpu_x86_get_msr_core_thread_count(cpu);
+        break;
+    default:
+        /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
+        val = 0;
+        break;
+    }
+
+    RAX(env) = (uint32_t)val;
+    RDX(env) = (uint32_t)(val >> 32);
+}
+
+void hvf_simulate_wrmsr(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t msr = ECX(env);
+    uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
+
+    switch (msr) {
+    case MSR_IA32_TSC:
+        break;
+    case MSR_IA32_APICBASE: {
+        int r;
+
+        r = cpu_set_apic_base(cpu->apic_state, data);
+        if (r < 0) {
+            x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_write(index, data);
+        if (ret < 0) {
+            x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
+    case MSR_FSBASE:
+        wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
+        break;
+    case MSR_GSBASE:
+        wvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE, data);
+        break;
+    case MSR_KERNELGSBASE:
+        wvmcs(cs->accel->fd, VMCS_HOST_FS_BASE, data);
+        break;
+    case MSR_STAR:
+        abort();
+        break;
+    case MSR_LSTAR:
+        abort();
+        break;
+    case MSR_CSTAR:
+        abort();
+        break;
+    case MSR_EFER:
+        /*printf("new efer %llx\n", EFER(cs));*/
+        wvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER, data);
+        if (data & MSR_EFER_NXE) {
+            hv_vcpu_invalidate_tlb(cs->accel->fd);
+        }
+        break;
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base = data;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask = data;
+        break;
+    case MSR_MTRRfix64K_00000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix64K_00000] = data;
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1] = data;
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3] = data;
+        break;
+    case MSR_MTRRdefType:
+        env->mtrr_deftype = data;
+        break;
+    default:
+        break;
+    }
+
+    /* Related to support known hypervisor interface */
+    /* if (g_hypervisor_iface)
+         g_hypervisor_iface->wrmsr_handler(cs, msr, data);
+
+    printf("write msr %llx\n", RCX(cs));*/
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -663,9 +875,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         {
             hvf_load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
-                simulate_rdmsr(env);
+                hvf_simulate_rdmsr(env);
             } else {
-                simulate_wrmsr(env);
+                hvf_simulate_wrmsr(env);
             }
             env->eip += ins_len;
             hvf_store_regs(cpu);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 8b0d54d69a0..df815941156 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -661,8 +661,7 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void raise_exception(CPUX86State *env, int exception_index,
-                            int error_code)
+void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code)
 {
     env->exception_nr = exception_index;
     env->error_code = error_code;
@@ -670,227 +669,15 @@ static void raise_exception(CPUX86State *env, int exception_index,
     env->exception_injected = 1;
 }
 
-void simulate_rdmsr(CPUX86State *env)
-{
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-    uint32_t msr = ECX(env);
-    uint64_t val = 0;
-
-    switch (msr) {
-    case MSR_IA32_TSC:
-        val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
-        break;
-    case MSR_IA32_APICBASE:
-        val = cpu_get_apic_base(cpu->apic_state);
-        break;
-    case MSR_APIC_START ... MSR_APIC_END: {
-        int ret;
-        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-
-        ret = apic_msr_read(index, &val);
-        if (ret < 0) {
-            raise_exception(env, EXCP0D_GPF, 0);
-        }
-
-        break;
-    }
-    case MSR_IA32_UCODE_REV:
-        val = cpu->ucode_rev;
-        break;
-    case MSR_EFER:
-        val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
-        break;
-    case MSR_FSBASE:
-        val = rvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE);
-        break;
-    case MSR_GSBASE:
-        val = rvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE);
-        break;
-    case MSR_KERNELGSBASE:
-        val = rvmcs(cs->accel->fd, VMCS_HOST_FS_BASE);
-        break;
-    case MSR_STAR:
-        abort();
-        break;
-    case MSR_LSTAR:
-        abort();
-        break;
-    case MSR_CSTAR:
-        abort();
-        break;
-    case MSR_IA32_MISC_ENABLE:
-        val = env->msr_ia32_misc_enable;
-        break;
-    case MSR_MTRRphysBase(0):
-    case MSR_MTRRphysBase(1):
-    case MSR_MTRRphysBase(2):
-    case MSR_MTRRphysBase(3):
-    case MSR_MTRRphysBase(4):
-    case MSR_MTRRphysBase(5):
-    case MSR_MTRRphysBase(6):
-    case MSR_MTRRphysBase(7):
-        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base;
-        break;
-    case MSR_MTRRphysMask(0):
-    case MSR_MTRRphysMask(1):
-    case MSR_MTRRphysMask(2):
-    case MSR_MTRRphysMask(3):
-    case MSR_MTRRphysMask(4):
-    case MSR_MTRRphysMask(5):
-    case MSR_MTRRphysMask(6):
-    case MSR_MTRRphysMask(7):
-        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask;
-        break;
-    case MSR_MTRRfix64K_00000:
-        val = env->mtrr_fixed[0];
-        break;
-    case MSR_MTRRfix16K_80000:
-    case MSR_MTRRfix16K_A0000:
-        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1];
-        break;
-    case MSR_MTRRfix4K_C0000:
-    case MSR_MTRRfix4K_C8000:
-    case MSR_MTRRfix4K_D0000:
-    case MSR_MTRRfix4K_D8000:
-    case MSR_MTRRfix4K_E0000:
-    case MSR_MTRRfix4K_E8000:
-    case MSR_MTRRfix4K_F0000:
-    case MSR_MTRRfix4K_F8000:
-        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3];
-        break;
-    case MSR_MTRRdefType:
-        val = env->mtrr_deftype;
-        break;
-    case MSR_CORE_THREAD_COUNT:
-        val = cpu_x86_get_msr_core_thread_count(cpu);
-        break;
-    default:
-        /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
-        val = 0;
-        break;
-    }
-
-    RAX(env) = (uint32_t)val;
-    RDX(env) = (uint32_t)(val >> 32);
-}
-
 static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_rdmsr(env);
+    hvf_simulate_rdmsr(env);
     env->eip += decode->len;
 }
 
-void simulate_wrmsr(CPUX86State *env)
-{
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-    uint32_t msr = ECX(env);
-    uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
-
-    switch (msr) {
-    case MSR_IA32_TSC:
-        break;
-    case MSR_IA32_APICBASE: {
-        int r;
-
-        r = cpu_set_apic_base(cpu->apic_state, data);
-        if (r < 0) {
-            raise_exception(env, EXCP0D_GPF, 0);
-        }
-
-        break;
-    }
-    case MSR_APIC_START ... MSR_APIC_END: {
-        int ret;
-        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-
-        ret = apic_msr_write(index, data);
-        if (ret < 0) {
-            raise_exception(env, EXCP0D_GPF, 0);
-        }
-
-        break;
-    }
-    case MSR_FSBASE:
-        wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
-        break;
-    case MSR_GSBASE:
-        wvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE, data);
-        break;
-    case MSR_KERNELGSBASE:
-        wvmcs(cs->accel->fd, VMCS_HOST_FS_BASE, data);
-        break;
-    case MSR_STAR:
-        abort();
-        break;
-    case MSR_LSTAR:
-        abort();
-        break;
-    case MSR_CSTAR:
-        abort();
-        break;
-    case MSR_EFER:
-        /*printf("new efer %llx\n", EFER(cs));*/
-        wvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER, data);
-        if (data & MSR_EFER_NXE) {
-            hv_vcpu_invalidate_tlb(cs->accel->fd);
-        }
-        break;
-    case MSR_MTRRphysBase(0):
-    case MSR_MTRRphysBase(1):
-    case MSR_MTRRphysBase(2):
-    case MSR_MTRRphysBase(3):
-    case MSR_MTRRphysBase(4):
-    case MSR_MTRRphysBase(5):
-    case MSR_MTRRphysBase(6):
-    case MSR_MTRRphysBase(7):
-        env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base = data;
-        break;
-    case MSR_MTRRphysMask(0):
-    case MSR_MTRRphysMask(1):
-    case MSR_MTRRphysMask(2):
-    case MSR_MTRRphysMask(3):
-    case MSR_MTRRphysMask(4):
-    case MSR_MTRRphysMask(5):
-    case MSR_MTRRphysMask(6):
-    case MSR_MTRRphysMask(7):
-        env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask = data;
-        break;
-    case MSR_MTRRfix64K_00000:
-        env->mtrr_fixed[ECX(env) - MSR_MTRRfix64K_00000] = data;
-        break;
-    case MSR_MTRRfix16K_80000:
-    case MSR_MTRRfix16K_A0000:
-        env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1] = data;
-        break;
-    case MSR_MTRRfix4K_C0000:
-    case MSR_MTRRfix4K_C8000:
-    case MSR_MTRRfix4K_D0000:
-    case MSR_MTRRfix4K_D8000:
-    case MSR_MTRRfix4K_E0000:
-    case MSR_MTRRfix4K_E8000:
-    case MSR_MTRRfix4K_F0000:
-    case MSR_MTRRfix4K_F8000:
-        env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3] = data;
-        break;
-    case MSR_MTRRdefType:
-        env->mtrr_deftype = data;
-        break;
-    default:
-        break;
-    }
-
-    /* Related to support known hypervisor interface */
-    /* if (g_hypervisor_iface)
-         g_hypervisor_iface->wrmsr_handler(cs, msr, data);
-
-    printf("write msr %llx\n", RCX(cs));*/
-}
-
 static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_wrmsr(env);
+    hvf_simulate_wrmsr(env);
     env->eip += decode->len;
 }
 
-- 
2.48.1


