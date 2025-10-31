Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAA3CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtx4-0004ul-1j; Fri, 31 Oct 2025 14:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtx1-0004tx-Ok
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:15 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwV-0006Fs-Gt
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429bccca1e8so959661f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935618; x=1762540418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Mh0LFeLH94Zb/IHGtCh2CyI9et5bSgPlympa9h6fmo=;
 b=kLfagaZWFKTEdD9iR99znzMRn/iYTleoBg/g6DbZE9FUbuGU/fbmkrsIRi3ndxTBkc
 ndoungJTKSxmG3e4EXVzXuGIzfrf+dWbulVBeXx8LfH9TtLhPZp3ve9bH0A/rWeB1Qj1
 YsZXbP2HrG725+QrS+J0XKsmJax3Snve5/aHLCeqIV2RZGzFiPDzoJzaXKsOHgJYtlmp
 bR4EP1iEqskPrW8ILyFRujj1y+aEBZLYVe8sp9krkkHJZZxx9BiLAIWpK7osk6La+FtB
 cjGY8tIllPkdmbp1TGCf0WM24d8XopvgHOm6cXxMdOu2/S12sTBfAInIDGj3/NvAi0a0
 xeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935618; x=1762540418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Mh0LFeLH94Zb/IHGtCh2CyI9et5bSgPlympa9h6fmo=;
 b=a1hnU1e3b8JP1JDZWBZRLC9/aQQ3DTYJLxpPBzM/1jO8rC6nEXU7vbwLp6xfnj/BnZ
 Gh8JIOry1/tprSTP0mPynhB2YbsxH0DShD/sC8nU5YVYWkwG88fhNZin0M6mKozPO+yC
 qyIjb2K7JJmm8V2s5ofrX9dnfn5RWk8xX74p43Z8OKp0rf0sQd8mRaaXgkwvuQdWfOar
 4eQVD4fCe3spSAOqdRmQLHHe1QGqHSNoSf//bViVd2UpPRgYtZ9mC1Ldf8rQ0TYS+7AI
 vuo6sxvxzUh8AX6tfhO/yD8BdsxXrkqSMxQvg/Wtolnb4/wu4Ujv7xHnpUTx3MpK/P98
 OnbQ==
X-Gm-Message-State: AOJu0YxAw/Xp8tv3DSn7kXX5UyNTRGMiuiAPaT8zLG0ixfH5TtxQY6MB
 XI6k5FSiWdGbVM42b43pX/pZKS9Omd5lFMyDYXH+hEWWr49QmMzN+D4L2oviDoxBJhtklNLpbPh
 Afr9P
X-Gm-Gg: ASbGncs4nW2V6P2jwoNvdxxG6c6HbDNuizAm41UvYMrfds0XAK+fAUPSLeZDWrPiKxs
 xRRpDQOce92HNhd5gN7CbeWvKJnc25SdVkcYOpd2ZGsJwkkKj+U1aYtLbO/9btKKtZY5yHcjrIT
 l3Ao8cSZ8T1/9wcC3SdA2kNMbD1PRdAhrjfFh5GCdmwEnUdJD2eh5Qil6XwsusGF8kmOItM4ziF
 JmlQJzoqMKX8w/aDhKmFglDRrh0lS0hlTtBv68q4OQIb9yBRkOkoQ0BpZe+DDfvv+QbZGjTaydT
 Atef84kpTHj5K6RRXDcmxDOVoe9vBlO9oanBEjW6NmMis+5Uoy75YLcJ0aTLDFgERnTX2uyVgDN
 +PDWErAAx0UChuQ0vcu2UP6yXpp06dOX0taRaibiEAxhd1XXBDWyovFDDNlEH8EA/81eybBPJfp
 42mJP3k8PeSzr3As7s
X-Google-Smtp-Source: AGHT+IExex/Xy7CpWdnX8gc3S5fPAFNRcd6+zmOV99fDHVgu2dlaAR1CjhIygzP2V2tRc8MkF8I4yw==
X-Received: by 2002:a05:6000:2301:b0:3e7:68b2:c556 with SMTP id
 ffacd0b85a97d-429bd6836c2mr4045322f8f.26.1761935617842; 
 Fri, 31 Oct 2025 11:33:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/38] target/i386/hvf: Factor hvf_handle_vmexit() out
Date: Fri, 31 Oct 2025 18:32:58 +0000
Message-ID: <20251031183310.3778349-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Factor hvf_handle_vmexit() out of hvf_arch_vcpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/hvf/hvf.c | 478 +++++++++++++++++++++---------------------
 1 file changed, 244 insertions(+), 234 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 76a58cb0350..28d98659ec2 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -721,6 +721,249 @@ void hvf_simulate_wrmsr(CPUState *cs)
     printf("write msr %llx\n", RCX(cs));*/
 }
 
+static int hvf_handle_vmexit(CPUState *cpu)
+{
+    X86CPU *x86_cpu = env_archcpu(cpu_env(cpu));
+    uint64_t exit_reason = rvmcs(cpu->accel->fd, VMCS_EXIT_REASON);
+    uint64_t exit_qual = rvmcs(cpu->accel->fd, VMCS_EXIT_QUALIFICATION);
+    uint32_t ins_len = (uint32_t)rvmcs(cpu->accel->fd,
+                                       VMCS_EXIT_INSTRUCTION_LENGTH);
+
+    uint64_t idtvec_info = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
+    int ret = 0;
+
+    hvf_store_events(cpu, ins_len, idtvec_info);
+    rip = rreg(cpu->accel->fd, HV_X86_RIP);
+    env->eflags = rreg(cpu->accel->fd, HV_X86_RFLAGS);
+
+    bql_lock();
+
+    update_apic_tpr(cpu);
+    current_cpu = cpu;
+
+    switch (exit_reason) {
+    case EXIT_REASON_HLT: {
+        macvm_set_rip(cpu, rip + ins_len);
+        if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)
+              && (env->eflags & IF_MASK))
+            && !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)
+            && !(idtvec_info & VMCS_IDT_VEC_VALID)) {
+            cpu->halted = 1;
+            ret = EXCP_HLT;
+            break;
+        }
+        ret = EXCP_INTERRUPT;
+        break;
+    }
+    case EXIT_REASON_MWAIT: {
+        ret = EXCP_INTERRUPT;
+        break;
+    }
+    /* Need to check if MMIO or unmapped fault */
+    case EXIT_REASON_EPT_FAULT:
+    {
+        hvf_slot *slot;
+        uint64_t gpa = rvmcs(cpu->accel->fd, VMCS_GUEST_PHYSICAL_ADDRESS);
+
+        if (((idtvec_info & VMCS_IDT_VEC_VALID) == 0) &&
+            ((exit_qual & EXIT_QUAL_NMIUDTI) != 0)) {
+            vmx_set_nmi_blocking(cpu);
+        }
+
+        slot = hvf_find_overlap_slot(gpa, 1);
+        /* mmio */
+        if (ept_emulation_fault(slot, gpa, exit_qual)) {
+            struct x86_decode decode;
+
+            hvf_load_regs(cpu);
+            decode_instruction(env, &decode);
+            exec_instruction(env, &decode);
+            hvf_store_regs(cpu);
+            break;
+        }
+        break;
+    }
+    case EXIT_REASON_INOUT:
+    {
+        uint32_t in = (exit_qual & 8) != 0;
+        uint32_t size =  (exit_qual & 7) + 1;
+        uint32_t string =  (exit_qual & 16) != 0;
+        uint32_t port =  exit_qual >> 16;
+        /*uint32_t rep = (exit_qual & 0x20) != 0;*/
+        struct x86_decode decode;
+
+        if (!string && in) {
+            uint64_t val = 0;
+
+            hvf_load_regs(cpu);
+            hvf_handle_io(env_cpu(env), port, &val, 0, size, 1);
+            if (size == 1) {
+                AL(env) = val;
+            } else if (size == 2) {
+                AX(env) = val;
+            } else if (size == 4) {
+                RAX(env) = (uint32_t)val;
+            } else {
+                RAX(env) = (uint64_t)val;
+            }
+            env->eip += ins_len;
+            hvf_store_regs(cpu);
+            break;
+        } else if (!string && !in) {
+            RAX(env) = rreg(cpu->accel->fd, HV_X86_RAX);
+            hvf_handle_io(env_cpu(env), port, &RAX(env), 1, size, 1);
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        }
+
+        hvf_load_regs(cpu);
+        decode_instruction(env, &decode);
+        assert(ins_len == decode.len);
+        exec_instruction(env, &decode);
+        hvf_store_regs(cpu);
+
+        break;
+    }
+    case EXIT_REASON_CPUID: {
+        uint32_t rax = (uint32_t)rreg(cpu->accel->fd, HV_X86_RAX);
+        uint32_t rbx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RBX);
+        uint32_t rcx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RCX);
+        uint32_t rdx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RDX);
+
+        if (rax == 1) {
+            /* CPUID1.ecx.OSXSAVE needs to know CR4 */
+            env->cr[4] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR4);
+        }
+        hvf_cpu_x86_cpuid(env, rax, rcx, &rax, &rbx, &rcx, &rdx);
+
+        wreg(cpu->accel->fd, HV_X86_RAX, rax);
+        wreg(cpu->accel->fd, HV_X86_RBX, rbx);
+        wreg(cpu->accel->fd, HV_X86_RCX, rcx);
+        wreg(cpu->accel->fd, HV_X86_RDX, rdx);
+
+        macvm_set_rip(cpu, rip + ins_len);
+        break;
+    }
+    case EXIT_REASON_XSETBV: {
+        uint32_t eax = (uint32_t)rreg(cpu->accel->fd, HV_X86_RAX);
+        uint32_t ecx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RCX);
+        uint32_t edx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RDX);
+
+        if (ecx) {
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        }
+        env->xcr0 = ((uint64_t)edx << 32) | eax;
+        wreg(cpu->accel->fd, HV_X86_XCR0, env->xcr0 | 1);
+        macvm_set_rip(cpu, rip + ins_len);
+        break;
+    }
+    case EXIT_REASON_INTR_WINDOW:
+        vmx_clear_int_window_exiting(cpu);
+        ret = EXCP_INTERRUPT;
+        break;
+    case EXIT_REASON_NMI_WINDOW:
+        vmx_clear_nmi_window_exiting(cpu);
+        ret = EXCP_INTERRUPT;
+        break;
+    case EXIT_REASON_EXT_INTR:
+        /* force exit and allow io handling */
+        ret = EXCP_INTERRUPT;
+        break;
+    case EXIT_REASON_RDMSR:
+    case EXIT_REASON_WRMSR:
+    {
+        hvf_load_regs(cpu);
+        if (exit_reason == EXIT_REASON_RDMSR) {
+            hvf_simulate_rdmsr(cpu);
+        } else {
+            hvf_simulate_wrmsr(cpu);
+        }
+        env->eip += ins_len;
+        hvf_store_regs(cpu);
+        break;
+    }
+    case EXIT_REASON_CR_ACCESS: {
+        int cr;
+        int reg;
+
+        hvf_load_regs(cpu);
+        cr = exit_qual & 15;
+        reg = (exit_qual >> 8) & 15;
+
+        switch (cr) {
+        case 0x0: {
+            macvm_set_cr0(cpu->accel->fd, RRX(env, reg));
+            break;
+        }
+        case 4: {
+            macvm_set_cr4(cpu->accel->fd, RRX(env, reg));
+            break;
+        }
+        case 8: {
+            if (exit_qual & 0x10) {
+                RRX(env, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
+            } else {
+                int tpr = RRX(env, reg);
+                cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+                ret = EXCP_INTERRUPT;
+            }
+            break;
+        }
+        default:
+            error_report("Unrecognized CR %d", cr);
+            abort();
+        }
+        env->eip += ins_len;
+        hvf_store_regs(cpu);
+        break;
+    }
+    case EXIT_REASON_APIC_ACCESS: { /* TODO */
+        struct x86_decode decode;
+
+        hvf_load_regs(cpu);
+        decode_instruction(env, &decode);
+        exec_instruction(env, &decode);
+        hvf_store_regs(cpu);
+        break;
+    }
+    case EXIT_REASON_TPR: {
+        ret = 1;
+        break;
+    }
+    case EXIT_REASON_TASK_SWITCH: {
+        uint64_t vinfo = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
+        x86_segment_selector sel = {.sel = exit_qual & 0xffff};
+
+        vmx_handle_task_switch(cpu, sel, (exit_qual >> 30) & 0x3,
+                               vinfo & VMCS_INTR_VALID,
+                               vinfo & VECTORING_INFO_VECTOR_MASK,
+                               vinfo & VMCS_INTR_T_MASK);
+        break;
+    }
+    case EXIT_REASON_TRIPLE_FAULT: {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        ret = EXCP_INTERRUPT;
+        break;
+    }
+    case EXIT_REASON_RDPMC:
+        wreg(cpu->accel->fd, HV_X86_RAX, 0);
+        wreg(cpu->accel->fd, HV_X86_RDX, 0);
+        macvm_set_rip(cpu, rip + ins_len);
+        break;
+    case VMX_REASON_VMCALL:
+        env->exception_nr = EXCP0D_GPF;
+        env->exception_injected = 1;
+        env->has_error_code = true;
+        env->error_code = 0;
+        break;
+    default:
+        error_report("%llx: unhandled exit %llx", rip, exit_reason);
+    }
+
+    return ret;
+}
+
 int hvf_arch_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -752,240 +995,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
-        /* handle VMEXIT */
-        uint64_t exit_reason = rvmcs(cpu->accel->fd, VMCS_EXIT_REASON);
-        uint64_t exit_qual = rvmcs(cpu->accel->fd, VMCS_EXIT_QUALIFICATION);
-        uint32_t ins_len = (uint32_t)rvmcs(cpu->accel->fd,
-                                           VMCS_EXIT_INSTRUCTION_LENGTH);
-
-        uint64_t idtvec_info = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
-
-        hvf_store_events(cpu, ins_len, idtvec_info);
-        rip = rreg(cpu->accel->fd, HV_X86_RIP);
-        env->eflags = rreg(cpu->accel->fd, HV_X86_RFLAGS);
-
-        bql_lock();
-
-        update_apic_tpr(cpu);
-        current_cpu = cpu;
-
-        ret = 0;
-        switch (exit_reason) {
-        case EXIT_REASON_HLT: {
-            macvm_set_rip(cpu, rip + ins_len);
-            if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
-                (env->eflags & IF_MASK))
-                && !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI) &&
-                !(idtvec_info & VMCS_IDT_VEC_VALID)) {
-                cpu->halted = 1;
-                ret = EXCP_HLT;
-                break;
-            }
-            ret = EXCP_INTERRUPT;
-            break;
-        }
-        case EXIT_REASON_MWAIT: {
-            ret = EXCP_INTERRUPT;
-            break;
-        }
-        /* Need to check if MMIO or unmapped fault */
-        case EXIT_REASON_EPT_FAULT:
-        {
-            hvf_slot *slot;
-            uint64_t gpa = rvmcs(cpu->accel->fd, VMCS_GUEST_PHYSICAL_ADDRESS);
-
-            if (((idtvec_info & VMCS_IDT_VEC_VALID) == 0) &&
-                ((exit_qual & EXIT_QUAL_NMIUDTI) != 0)) {
-                vmx_set_nmi_blocking(cpu);
-            }
-
-            slot = hvf_find_overlap_slot(gpa, 1);
-            /* mmio */
-            if (ept_emulation_fault(slot, gpa, exit_qual)) {
-                struct x86_decode decode;
-
-                hvf_load_regs(cpu);
-                decode_instruction(env, &decode);
-                exec_instruction(env, &decode);
-                hvf_store_regs(cpu);
-                break;
-            }
-            break;
-        }
-        case EXIT_REASON_INOUT:
-        {
-            uint32_t in = (exit_qual & 8) != 0;
-            uint32_t size =  (exit_qual & 7) + 1;
-            uint32_t string =  (exit_qual & 16) != 0;
-            uint32_t port =  exit_qual >> 16;
-            /*uint32_t rep = (exit_qual & 0x20) != 0;*/
-
-            if (!string && in) {
-                uint64_t val = 0;
-                hvf_load_regs(cpu);
-                hvf_handle_io(env_cpu(env), port, &val, 0, size, 1);
-                if (size == 1) {
-                    AL(env) = val;
-                } else if (size == 2) {
-                    AX(env) = val;
-                } else if (size == 4) {
-                    RAX(env) = (uint32_t)val;
-                } else {
-                    RAX(env) = (uint64_t)val;
-                }
-                env->eip += ins_len;
-                hvf_store_regs(cpu);
-                break;
-            } else if (!string && !in) {
-                RAX(env) = rreg(cpu->accel->fd, HV_X86_RAX);
-                hvf_handle_io(env_cpu(env), port, &RAX(env), 1, size, 1);
-                macvm_set_rip(cpu, rip + ins_len);
-                break;
-            }
-            struct x86_decode decode;
-
-            hvf_load_regs(cpu);
-            decode_instruction(env, &decode);
-            assert(ins_len == decode.len);
-            exec_instruction(env, &decode);
-            hvf_store_regs(cpu);
-
-            break;
-        }
-        case EXIT_REASON_CPUID: {
-            uint32_t rax = (uint32_t)rreg(cpu->accel->fd, HV_X86_RAX);
-            uint32_t rbx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RBX);
-            uint32_t rcx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RCX);
-            uint32_t rdx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RDX);
-
-            if (rax == 1) {
-                /* CPUID1.ecx.OSXSAVE needs to know CR4 */
-                env->cr[4] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR4);
-            }
-            hvf_cpu_x86_cpuid(env, rax, rcx, &rax, &rbx, &rcx, &rdx);
-
-            wreg(cpu->accel->fd, HV_X86_RAX, rax);
-            wreg(cpu->accel->fd, HV_X86_RBX, rbx);
-            wreg(cpu->accel->fd, HV_X86_RCX, rcx);
-            wreg(cpu->accel->fd, HV_X86_RDX, rdx);
-
-            macvm_set_rip(cpu, rip + ins_len);
-            break;
-        }
-        case EXIT_REASON_XSETBV: {
-            uint32_t eax = (uint32_t)rreg(cpu->accel->fd, HV_X86_RAX);
-            uint32_t ecx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RCX);
-            uint32_t edx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RDX);
-
-            if (ecx) {
-                macvm_set_rip(cpu, rip + ins_len);
-                break;
-            }
-            env->xcr0 = ((uint64_t)edx << 32) | eax;
-            wreg(cpu->accel->fd, HV_X86_XCR0, env->xcr0 | 1);
-            macvm_set_rip(cpu, rip + ins_len);
-            break;
-        }
-        case EXIT_REASON_INTR_WINDOW:
-            vmx_clear_int_window_exiting(cpu);
-            ret = EXCP_INTERRUPT;
-            break;
-        case EXIT_REASON_NMI_WINDOW:
-            vmx_clear_nmi_window_exiting(cpu);
-            ret = EXCP_INTERRUPT;
-            break;
-        case EXIT_REASON_EXT_INTR:
-            /* force exit and allow io handling */
-            ret = EXCP_INTERRUPT;
-            break;
-        case EXIT_REASON_RDMSR:
-        case EXIT_REASON_WRMSR:
-        {
-            hvf_load_regs(cpu);
-            if (exit_reason == EXIT_REASON_RDMSR) {
-                hvf_simulate_rdmsr(cpu);
-            } else {
-                hvf_simulate_wrmsr(cpu);
-            }
-            env->eip += ins_len;
-            hvf_store_regs(cpu);
-            break;
-        }
-        case EXIT_REASON_CR_ACCESS: {
-            int cr;
-            int reg;
-
-            hvf_load_regs(cpu);
-            cr = exit_qual & 15;
-            reg = (exit_qual >> 8) & 15;
-
-            switch (cr) {
-            case 0x0: {
-                macvm_set_cr0(cpu->accel->fd, RRX(env, reg));
-                break;
-            }
-            case 4: {
-                macvm_set_cr4(cpu->accel->fd, RRX(env, reg));
-                break;
-            }
-            case 8: {
-                if (exit_qual & 0x10) {
-                    RRX(env, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
-                } else {
-                    int tpr = RRX(env, reg);
-                    cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
-                    ret = EXCP_INTERRUPT;
-                }
-                break;
-            }
-            default:
-                error_report("Unrecognized CR %d", cr);
-                abort();
-            }
-            env->eip += ins_len;
-            hvf_store_regs(cpu);
-            break;
-        }
-        case EXIT_REASON_APIC_ACCESS: { /* TODO */
-            struct x86_decode decode;
-
-            hvf_load_regs(cpu);
-            decode_instruction(env, &decode);
-            exec_instruction(env, &decode);
-            hvf_store_regs(cpu);
-            break;
-        }
-        case EXIT_REASON_TPR: {
-            ret = 1;
-            break;
-        }
-        case EXIT_REASON_TASK_SWITCH: {
-            uint64_t vinfo = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
-            x86_segment_selector sel = {.sel = exit_qual & 0xffff};
-            vmx_handle_task_switch(cpu, sel, (exit_qual >> 30) & 0x3,
-             vinfo & VMCS_INTR_VALID, vinfo & VECTORING_INFO_VECTOR_MASK, vinfo
-             & VMCS_INTR_T_MASK);
-            break;
-        }
-        case EXIT_REASON_TRIPLE_FAULT: {
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-            ret = EXCP_INTERRUPT;
-            break;
-        }
-        case EXIT_REASON_RDPMC:
-            wreg(cpu->accel->fd, HV_X86_RAX, 0);
-            wreg(cpu->accel->fd, HV_X86_RDX, 0);
-            macvm_set_rip(cpu, rip + ins_len);
-            break;
-        case VMX_REASON_VMCALL:
-            env->exception_nr = EXCP0D_GPF;
-            env->exception_injected = 1;
-            env->has_error_code = true;
-            env->error_code = 0;
-            break;
-        default:
-            error_report("%llx: unhandled exit %llx", rip, exit_reason);
-        }
+        ret = hvf_handle_vmexit(cpu);
     } while (ret == 0);
 
     return ret;
-- 
2.43.0


