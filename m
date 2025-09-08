Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28E2CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsI-0001nj-5f; Mon, 08 Sep 2025 06:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsF-0001fj-KB
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs6-0000wC-B1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQF19VJadKTqyXrZHyk7Nk2a3lmDngVPUnI4hoa6BvU=;
 b=VTOjf9Ob7FD865LpW+mxzmD0kinkmLUKM7bFnxU80V+9pz/Xb3rzugN8x4gIGLTee9U4y+
 ZHVdEX5k0r4KeDXmNW2zYmDS1afUUYBhRig/EJvmRoeSI2SiWSG+0IzJH+XAN4RoJSTl0L
 CMkJA22k1QTnh0OA2mbeRACPxVc8SjQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-49FWne5qNLCq7hNpa4fuHA-1; Mon, 08 Sep 2025 06:13:02 -0400
X-MC-Unique: 49FWne5qNLCq7hNpa4fuHA-1
X-Mimecast-MFC-AGG-ID: 49FWne5qNLCq7hNpa4fuHA_1757326380
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3db4cfcc23eso2151263f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326378; x=1757931178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQF19VJadKTqyXrZHyk7Nk2a3lmDngVPUnI4hoa6BvU=;
 b=ocVfKpK0sB1CsNHli5p5CIQUyNaUVka8sDMW9yyn+IrGv8/ermroyeXz1V7pFNh6px
 /5X+1YyfoWCXBbOS38i9h8nIlthZGzIYOv1NaaC07gObgG38auuOEnfH9OrisOyOo0AF
 gjvSFoOv8CjvIj+GFF85esVPYwKo3jbh9WQZmQ0DcfcM4Z04VdevRwSznW+cnge3XpWK
 MZ00YlLvHwzBM9ZOZnnyc1GlWmSmUIWsU/ppKRvfX/48C2VlfkGj/7EpHz7EsDpmCyB1
 hjb8Yz1QjrvcnZ0BnBnzSqBJCAY4cmymAEUyBKbsVp515rXw2Eq/esVFwZbVVcEKXgkk
 OC1A==
X-Gm-Message-State: AOJu0YxVEfG/kmrUTHkPQkuK97/Q2+HpYugntZHVo5ivjtVE3ChBdsdo
 +jiUPVwfa9UDykYfsn7eEwjXdwTEjpkyCGmK0VQDqjJf6IyshA4cylu54yitR1fjgopLJiYvO4k
 bTII2n3Lmy7nW3NsR0et6I46a0myrRlTR6AWSmz0piv8Mf4YsBizcbkXFQWPeHCgFZjPUuJGzdo
 3LYZOKc+9hFWScnEMv70PvbvbTAXfXdAyUtcE83iAS
X-Gm-Gg: ASbGncvTV0ZwNEUl3BjajztkLqR47eg1vqX8Kr8UFZhEr62AIV/rfmX/Bm6G3bKPcDP
 3Yba/IQDayqF/kCmuIaMFsagu6ohsWopzoKtJNnXuaP33npQMesW4wr/yqzG2Y2Ez8UUUQCZUy4
 rIeJdsn+jYb7LH4lpNq6PSLqdrMkak+DkyNF3UFbxhXPHDolUUd0cifgYLRGQznS3OI+gZLvbSu
 GEgasygz+itgTWtkubKLICtDiQTW3hJj+Uv8kMTIFDMNyI/HnKDKDp+2HSlyrcrld93e/koxl6h
 qjIei8hm8iS0x/cYMAm7DT1sxj113QNzAoWbwm1zwh0iW6mzz0O03cN/s4h//nUKKE3MyxV5DWJ
 TEpWqT3oDHeKJd+z1B1oFP4EM+rGhLutiQ19TpQSXh2M=
X-Received: by 2002:a05:6000:2689:b0:3d2:52e3:920c with SMTP id
 ffacd0b85a97d-3e643555d8cmr5586580f8f.44.1757326378324; 
 Mon, 08 Sep 2025 03:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9DvSlUs7gkDAhO3CRRxk0TJV91LvXsp+22vusJhMTpQeocXsDRXHR8E1QaHLvNuBzNgyYTw==
X-Received: by 2002:a05:6000:2689:b0:3d2:52e3:920c with SMTP id
 ffacd0b85a97d-3e643555d8cmr5586557f8f.44.1757326377793; 
 Mon, 08 Sep 2025 03:12:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e748aa8104sm3557380f8f.40.2025.09.08.03.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 06/19] treewide: clear bits of cs->interrupt_request with
 cpu_reset_interrupt()
Date: Mon,  8 Sep 2025 12:12:28 +0200
Message-ID: <20250908101241.2110068-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Open coding cpu_reset_interrupt() can cause bugs if the BQL is not
taken, for example i386 has the call chain kvm_cpu_exec() ->
kvm_put_vcpu_events() -> kvm_arch_put_registers().

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c                |  6 +++---
 hw/core/cpu-system.c                |  2 +-
 target/avr/helper.c                 |  4 ++--
 target/i386/hvf/x86hvf.c            |  8 ++++----
 target/i386/kvm/kvm.c               | 14 +++++++-------
 target/i386/nvmm/nvmm-all.c         | 10 +++++-----
 target/i386/tcg/system/seg_helper.c | 13 ++++++-------
 target/i386/tcg/system/svm_helper.c |  2 +-
 target/i386/whpx/whpx-all.c         | 12 ++++++------
 target/openrisc/sys_helper.c        |  2 +-
 target/rx/helper.c                  |  4 ++--
 target/s390x/tcg/excp_helper.c      |  2 +-
 12 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8491e5badd1..508d2d2d9e2 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -784,7 +784,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(cpu_test_interrupt(cpu, ~0))) {
         bql_lock();
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
             cpu->exception_index = EXCP_DEBUG;
             bql_unlock();
             return true;
@@ -793,7 +793,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* Do nothing */
         } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HALT)) {
             replay_interrupt();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
             cpu->halted = 1;
             cpu->exception_index = EXCP_HLT;
             bql_unlock();
@@ -840,7 +840,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             }
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
             /* ensure that no TB jump will be modified as
                the program flow was changed */
             *last_tb = NULL;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index a975405d3a0..09c928c1f92 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -204,7 +204,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
          * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
          * version_id is increased.
          */
-        cpu->interrupt_request &= ~0x01;
+        cpu_reset_interrupt(cpu, 0x01);
 
         tlb_flush(cpu);
 
diff --git a/target/avr/helper.c b/target/avr/helper.c
index b9cd6d5ef27..4b29ab35263 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -47,7 +47,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             cs->exception_index = EXCP_RESET;
             avr_cpu_do_interrupt(cs);
 
-            cs->interrupt_request &= ~CPU_INTERRUPT_RESET;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_RESET);
             return true;
         }
     }
@@ -59,7 +59,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
             env->intsrc &= env->intsrc - 1; /* clear the interrupt */
             if (!env->intsrc) {
-                cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+                cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
             }
             return true;
         }
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 9e05e0e5765..a502437c303 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -397,7 +397,7 @@ bool hvf_inject_interrupts(CPUState *cs)
 
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
-            cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_NMI);
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
             wvmcs(cs->accel->fd, VMCS_ENTRY_INTR_INFO, info);
         } else {
@@ -409,7 +409,7 @@ bool hvf_inject_interrupts(CPUState *cs)
         cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(env);
-        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         if (line >= 0) {
             wvmcs(cs->accel->fd, VMCS_ENTRY_INTR_INFO, line |
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
@@ -437,7 +437,7 @@ int hvf_process_events(CPUState *cs)
     }
 
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
     if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
@@ -450,7 +450,7 @@ int hvf_process_events(CPUState *cs)
         do_cpu_sipi(cpu);
     }
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
         cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 306430a0521..8420c4090ef 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5066,7 +5066,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
              */
             events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
             events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
-            cs->interrupt_request &= ~(CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
         } else {
             /* Keep these in cs->interrupt_request.  */
             events.smi.pending = 0;
@@ -5456,7 +5456,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
             bql_lock();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             bql_unlock();
             DPRINTF("injected NMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
@@ -5467,7 +5467,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
             bql_lock();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
             bql_unlock();
             DPRINTF("injected SMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
@@ -5502,7 +5502,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 
             bql_lock();
 
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
             irq = cpu_get_pic_interrupt(env);
             if (irq >= 0) {
                 struct kvm_interrupt intr;
@@ -5597,7 +5597,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
-        cs->interrupt_request &= ~CPU_INTERRUPT_MCE;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_MCE);
 
         kvm_cpu_synchronize_state(cs);
 
@@ -5627,7 +5627,7 @@ int kvm_arch_process_async_events(CPUState *cs)
     }
 
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
     if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
@@ -5640,7 +5640,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         do_cpu_sipi(cpu);
     }
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
         kvm_cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index c1ac74c4f04..e1151b04c6e 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -419,7 +419,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
 
     if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         if (nvmm_can_take_nmi(cpu)) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             event->type = NVMM_VCPU_EVENT_INTR;
             event->vector = 2;
             has_event = true;
@@ -428,7 +428,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
 
     if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         if (nvmm_can_take_int(cpu)) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
             event->type = NVMM_VCPU_EVENT_INTR;
             event->vector = cpu_get_pic_interrupt(env);
             has_event = true;
@@ -437,7 +437,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
 
     /* Don't want SMIs. */
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
     }
 
     if (sync_tpr) {
@@ -697,7 +697,7 @@ nvmm_vcpu_loop(CPUState *cpu)
         /* set int/nmi windows back to the reset state */
     }
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
     if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
@@ -710,7 +710,7 @@ nvmm_vcpu_loop(CPUState *cpu)
         do_cpu_sipi(x86_cpu);
     }
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_TPR);
         nvmm_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
             env->tpr_access_type);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 794a23ddfc4..38072e51d72 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -178,7 +178,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
      */
     switch (interrupt_request) {
     case CPU_INTERRUPT_POLL:
-        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
         break;
     case CPU_INTERRUPT_SIPI:
@@ -186,23 +186,22 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         break;
     case CPU_INTERRUPT_SMI:
         cpu_svm_check_intercept_param(env, SVM_EXIT_SMI, 0, 0);
-        cs->interrupt_request &= ~CPU_INTERRUPT_SMI;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SMI);
         do_smm_enter(cpu);
         break;
     case CPU_INTERRUPT_NMI:
         cpu_svm_check_intercept_param(env, SVM_EXIT_NMI, 0, 0);
-        cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_NMI);
         env->hflags2 |= HF2_NMI_MASK;
         do_interrupt_x86_hardirq(env, EXCP02_NMI, 1);
         break;
     case CPU_INTERRUPT_MCE:
-        cs->interrupt_request &= ~CPU_INTERRUPT_MCE;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_MCE);
         do_interrupt_x86_hardirq(env, EXCP12_MCHK, 0);
         break;
     case CPU_INTERRUPT_HARD:
         cpu_svm_check_intercept_param(env, SVM_EXIT_INTR, 0, 0);
-        cs->interrupt_request &= ~(CPU_INTERRUPT_HARD |
-                                   CPU_INTERRUPT_VIRQ);
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_VIRQ);
         intno = cpu_get_pic_interrupt(env);
         qemu_log_mask(CPU_LOG_INT,
                       "Servicing hardware INT=0x%02x\n", intno);
@@ -215,7 +214,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         qemu_log_mask(CPU_LOG_INT,
                       "Servicing virtual hardware INT=0x%02x\n", intno);
         do_interrupt_x86_hardirq(env, intno, 1);
-        cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
         env->int_ctl &= ~V_IRQ_MASK;
         break;
     }
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 3569196bdda..505788b0e26 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -824,7 +824,7 @@ void do_vmexit(CPUX86State *env)
     env->intercept_exceptions = 0;
 
     /* Clears the V_IRQ and V_INTR_MASKING bits inside the processor. */
-    cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
+    cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
     env->int_ctl = 0;
 
     /* Clears the TSC_OFFSET inside the processor. */
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 878cdd1668c..c09a0a64f22 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1471,14 +1471,14 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (!vcpu->interruption_pending &&
         cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             vcpu->interruptable = false;
             new_int.InterruptionType = WHvX64PendingNmi;
             new_int.InterruptionPending = 1;
             new_int.InterruptionVector = 2;
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
         }
     }
 
@@ -1502,7 +1502,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             vcpu->interruptable && (env->eflags & IF_MASK)) {
             assert(!new_int.InterruptionPending);
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
-                cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+                cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
                 irq = cpu_get_pic_interrupt(env);
                 if (irq >= 0) {
                     new_int.InterruptionType = WHvX64PendingInterrupt;
@@ -1520,7 +1520,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         }
     } else if (vcpu->ready_for_pic_interrupt &&
                cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
         irq = cpu_get_pic_interrupt(env);
         if (irq >= 0) {
             reg_names[reg_count] = WHvRegisterPendingEvent;
@@ -1607,7 +1607,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
@@ -1623,7 +1623,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_TPR);
         whpx_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
                                       env->tpr_access_type);
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index d96b41a01c2..b091a9c6685 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -196,7 +196,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
                 env->ttmr = (rb & ~TTMR_IP) | ip;
             } else {    /* Clear IP bit.  */
                 env->ttmr = rb & ~TTMR_IP;
-                cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
+                cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
             }
             cpu_openrisc_timer_update(cpu);
             bql_unlock();
diff --git a/target/rx/helper.c b/target/rx/helper.c
index ce003af4219..41c9606fd1d 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -63,7 +63,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->bpsw = save_psw;
             env->pc = env->fintv;
             env->psw_ipl = 15;
-            cs->interrupt_request &= ~CPU_INTERRUPT_FIR;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
             qemu_set_irq(env->ack, env->ack_irq);
             qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
         } else if (do_irq & CPU_INTERRUPT_HARD) {
@@ -73,7 +73,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             cpu_stl_data(env, env->isp, env->pc);
             env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
             env->psw_ipl = env->ack_ipl;
-            cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
             qemu_set_irq(env->ack, env->ack_irq);
             qemu_log_mask(CPU_LOG_INT,
                           "interrupt 0x%02x raised\n", env->ack_irq);
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index e4c75d0ce01..4c7faeee82b 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -559,7 +559,7 @@ try_deliver:
 
     /* we might still have pending interrupts, but not deliverable */
     if (!env->pending_int && !qemu_s390_flic_has_any(flic)) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 
     /* WAIT PSW during interrupt injection or STOP interrupt */
-- 
2.51.0


