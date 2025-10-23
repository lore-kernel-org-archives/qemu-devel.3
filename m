Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6373CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw5S-0006Kd-Eg; Thu, 23 Oct 2025 10:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw5F-00063O-AO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw5B-0007RG-DG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so620621f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228862; x=1761833662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0e3/oLz91m0M4PKqzD0FMNzJKdz5qkqdZGotGocB/sY=;
 b=tRQSx7uUmE4TuTs8DNKMnM9tEdAyvOgv0r55fudns25AykH1/2LFMRkJmmX21yhxq/
 Sc/HhxObE5T3tfO+cCYQ92M4YJOTe1ItL33i4Ni1g0I6/xsFpDVrDq2ezi6Zw0xXS2v5
 Aq7zqN4LBKfdbEHWaUOPbI2I1eZZXiSYYmE0Yst/7kOkivX5RO8koniExcAYDqe/OFBr
 tbFbzzjuNkuUSV7mBwYigK1XVmUrwlROx0izqXZmO/R4JNvBpS0EFVEmWYOLATXmvWog
 MEPCr3idYIP2IAlLe/Z5ms/ZmkyM1cudA9/r7XBNV1NDGfRDcPiFsl0xuSdUNNpl9gKI
 PqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228862; x=1761833662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0e3/oLz91m0M4PKqzD0FMNzJKdz5qkqdZGotGocB/sY=;
 b=d0cAvu5VwDdknM61oK9nNMOuAqhZpPbD2RKPaszo4YuADXLtVd4WE0Ro7Z4yM8q+Dm
 ADG70f41nN/vlV1oUsRD2psa7+sMsKC/z5iwI11tHUmQNaBR7kgIzHWcF0A777LOl4OH
 9Wx3WMRmY/l1ZHoNcRFVjvHBHmNfec0rkxR3IjnQvbQg9QReD+A+GkXdI1xTBxjDGc4p
 goTqEHtx5Kssaobar/y3hlt+Xd99K+sl6ulnVq2RQILGQR5kJhcC1IRStYKtr/LYP382
 Jwcq4BTot6QeiqrKveAoNUaWSLRIa+ohc/fitcHm6veOUXsBTxJzqnO1RFnwRNCP+qzo
 wW6Q==
X-Gm-Message-State: AOJu0Ywh+jLoY7ioZtSXDfdq8WodMtarWCMKhuc8uJaOxlG9uxiSAMHB
 E0swiqWHxhtgpYgwrK9vuSNwmkelE4+8IG1sOuF+W813ln/qw32o1W50/WEAX32Wbr7k/AkvkWc
 IPRGDPuE=
X-Gm-Gg: ASbGncsANJP9JFIrZfTN0Y1f5xuliD1mfYFZknfLtZF4P1bn76snd2yY4qRprnbR1uO
 S/KD+32n+Nq2ce6Nr80/UM+o8pwYfRcVNfjn/XEvcwqFjE3N4jg34N+Q6YBioOcIWwNFOJO0KJ8
 u6rfS5+QSDdKvnRvuEJ6MkVBwi9OlDU7aHXGcowS5AmSnYFxKJgM0rjgxUuQEDimAQ8C08kad59
 WYPm4nQHM1vcKcFZ43OrWMcti1y1OH/1DPqhfYI87YBEXpHkXF7aeJw9i5s4d5Mc8Wa3O88dHQO
 Vvs0QK95+piDBnPIydoQ7c9O4KHYPJ5oaBDDN4aT8bQTM+j4Zt2xP0n89TCm0SMOCbi9tDfbxnl
 MPKd+8mL2W3sfthANU1CSYYI6ryh7+X3QeHI7tQIDJB2CARECk5lyB3vx0nYm6Fknro3HwR/JJc
 /OZJBbC1r1n7/ZkI1kWIvOsbq6RZUoWmod2+6b4YLMPp1HtCXdxw==
X-Google-Smtp-Source: AGHT+IFKiy+g0Qp3DW9IbB4fDmn9/sBjcbm6QTJeX8mOOw5VZa/yKCHvwlkueSeSC8ims1kgraG/IQ==
X-Received: by 2002:a05:6000:2f83:b0:427:880:9538 with SMTP id
 ffacd0b85a97d-4298a0bd253mr1981490f8f.45.1761228861765; 
 Thu, 23 Oct 2025 07:14:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898eac60sm4123656f8f.39.2025.10.23.07.14.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:14:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 18/58] target/i386/hvf: Factor hvf_handle_vmexit() out
Date: Thu, 23 Oct 2025 16:13:37 +0200
Message-ID: <20251023141339.10143-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
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

Factor hvf_handle_vmexit() out of hvf_arch_vcpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 477 +++++++++++++++++++++---------------------
 1 file changed, 244 insertions(+), 233 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 76a58cb0350..2929a92defe 100644
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
@@ -753,239 +996,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         assert_hvf_ok(r);
 
         /* handle VMEXIT */
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
2.51.0


