Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DAAC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLpH-0008Et-1i; Fri, 08 Aug 2025 08:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnT-0003mI-LQ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnQ-00078U-TU
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dpqqvy4tW2b5oBXI77fzo08kVsk829PqDywLM2A3hck=;
 b=RnZLsa38v3vv5ah6rUM17c83YuRVfWop7m371Tp8w8FpbMQO+imRhiwoD5QzN7fRhfnKCE
 xar4fUsr/ibKZh6oaXNszyiloNg4jPGCecMi8XBNDfguaMnfad453KMCe6wkJNOobTyHrG
 wXBA++ACY9VKKPvqEJvcAvZokZbpzmA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-C8T2-2J0MEqH7jKKi6voHw-1; Fri,
 08 Aug 2025 08:02:02 -0400
X-MC-Unique: C8T2-2J0MEqH7jKKi6voHw-1
X-Mimecast-MFC-AGG-ID: C8T2-2J0MEqH7jKKi6voHw_1754654521
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB50819560B2; Fri,  8 Aug 2025 12:02:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6334419560AD; Fri,  8 Aug 2025 12:01:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 07/10] x86: kvm: use cpu_test_interrupt() instead of oppen
 coding checks
Date: Fri,  8 Aug 2025 14:01:34 +0200
Message-ID: <20250808120137.2208800-8-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

on top of that cpu_test_interrupt() uses barrier to ensure proper order
when interrupts are set from outside of vcpu thread.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/kvm/kvm.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..a7b5c8f81b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5453,8 +5453,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     int ret;
 
     /* Inject NMI */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
             bql_lock();
             cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
             bql_unlock();
@@ -5465,7 +5465,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
                         strerror(-ret));
             }
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
             bql_lock();
             cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
             bql_unlock();
@@ -5486,12 +5486,12 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
      * or (for userspace APIC, but it is cheap to combine the checks here)
      * pending TPR access reports.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
             cpu->exit_request = 1;
         }
     }
@@ -5499,7 +5499,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (!kvm_pic_in_kernel()) {
         /* Try to inject an interrupt if the guest can accept it */
         if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
             (env->eflags & IF_MASK)) {
             int irq;
 
@@ -5523,7 +5523,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
          * interrupt, request an interrupt window exit.  This will
          * cause a return to userspace as soon as the guest is ready to
          * receive interrupts. */
-        if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
             run->request_interrupt_window = 1;
         } else {
             run->request_interrupt_window = 0;
@@ -5595,7 +5595,7 @@ int kvm_arch_process_async_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_MCE) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_MCE)) {
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
@@ -5618,7 +5618,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         }
     }
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_init(cpu);
@@ -5628,20 +5628,20 @@ int kvm_arch_process_async_events(CPUState *cs)
         return 0;
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         cs->halted = 0;
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
         kvm_cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
@@ -5656,9 +5656,9 @@ static int kvm_handle_halt(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
 
-    if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!(cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         cs->halted = 1;
         return EXCP_HLT;
     }
-- 
2.47.1


