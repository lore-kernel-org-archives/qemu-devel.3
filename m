Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A73C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh7Wl-00082i-KO; Wed, 30 Jul 2025 10:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh66J-0005kf-3O
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh66D-0006wZ-Fs
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753879199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnkKV/qN9hIacD0TfY2P1fY0zKaP/nMy687lfMn0F8c=;
 b=NvFGKUQDnCOTOYCFbvXfgRqOLKDvSj1Ld2VZrpNDvRzAGC2jWj3kbPRjpTg5+BgYyMaxmB
 cZbz+7zRGYRb+PQRw3kFDUNRvduGp/48PNix7T0Exoeqvx1SzrpxqLSKG97dZqxzOADFoq
 grB6mVJepjeurSSowQU2PEgEsLPvCkc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-JPex7cTPPh6wE-oUrm9VtQ-1; Wed,
 30 Jul 2025 08:39:56 -0400
X-MC-Unique: JPex7cTPPh6wE-oUrm9VtQ-1
X-Mimecast-MFC-AGG-ID: JPex7cTPPh6wE-oUrm9VtQ_1753879195
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8453F1956088; Wed, 30 Jul 2025 12:39:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D8C930001BE; Wed, 30 Jul 2025 12:39:52 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 6/6] kvm: i386: irqchip: take BQL only if there is an
 interrupt
Date: Wed, 30 Jul 2025 14:39:34 +0200
Message-ID: <20250730123934.1787379-7-imammedo@redhat.com>
In-Reply-To: <20250730123934.1787379-1-imammedo@redhat.com>
References: <20250730123934.1787379-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

when kernel-irqchip=split is used, QEMU still hits BQL
contention issue when reading ACPI PM/HPET timers
(despite of timer[s] access being lock-less).

So Windows with more than 255 cpus is still not able to
boot (since it requires iommu -> split irqchip).

Problematic path is in kvm_arch_pre_run() where BQL is taken
unconditionally when split irqchip is in use.

There are a few parts tha BQL protects there:
  1. interrupt check and injecting

    however we do not take BQL when checking for pending
    interrupt (even within the same function), so the patch
    takes the same approach for cpu->interrupt_request checks
    and takes BQL only if there is a job to do.

  2. request_interrupt_window access
      CPUState::kvm_run::request_interrupt_window doesn't need BQL
      as it's accessed on side QEMU only by its own vCPU thread.
      The only thing that BQL provides there is implict barrier.
      Which can be done by using cheaper explicit barrier there.

  3. cr8/cpu_get_apic_tpr access
      the same (as #2) applies to CPUState::kvm_run::cr8 write,
      and APIC registers are also cached/synced (get/put) within
      the vCPU thread it belongs to.

Taking BQL only when is necessary, eleminates BQL bottleneck on
IO/MMIO only exit path, improoving latency by 80% on HPET micro
benchmark.

This lets Windows to boot succesfully (in case hv-time isn't used)
when more than 255 vCPUs are in use.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/kvm/kvm.c | 58 +++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..32024d50f5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5450,6 +5450,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    bool release_bql = 0;
     int ret;
 
     /* Inject NMI */
@@ -5478,15 +5479,16 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
         }
     }
 
-    if (!kvm_pic_in_kernel()) {
-        bql_lock();
-    }
 
     /* Force the VCPU out of its inner loop to process any INIT requests
      * or (for userspace APIC, but it is cheap to combine the checks here)
      * pending TPR access reports.
      */
     if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if (!kvm_pic_in_kernel()) {
+            bql_lock();
+            release_bql = true;
+        }
         if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
@@ -5497,24 +5499,31 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     }
 
     if (!kvm_pic_in_kernel()) {
-        /* Try to inject an interrupt if the guest can accept it */
-        if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
-            (env->eflags & IF_MASK)) {
-            int irq;
-
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
-            irq = cpu_get_pic_interrupt(env);
-            if (irq >= 0) {
-                struct kvm_interrupt intr;
-
-                intr.irq = irq;
-                DPRINTF("injected interrupt %d\n", irq);
-                ret = kvm_vcpu_ioctl(cpu, KVM_INTERRUPT, &intr);
-                if (ret < 0) {
-                    fprintf(stderr,
-                            "KVM: injection failed, interrupt lost (%s)\n",
-                            strerror(-ret));
+        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+            if (!release_bql) {
+                bql_lock();
+                release_bql = true;
+            }
+
+            /* Try to inject an interrupt if the guest can accept it */
+            if (run->ready_for_interrupt_injection &&
+                (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+                (env->eflags & IF_MASK)) {
+                int irq;
+
+                cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+                irq = cpu_get_pic_interrupt(env);
+                if (irq >= 0) {
+                    struct kvm_interrupt intr;
+
+                    intr.irq = irq;
+                    DPRINTF("injected interrupt %d\n", irq);
+                    ret = kvm_vcpu_ioctl(cpu, KVM_INTERRUPT, &intr);
+                    if (ret < 0) {
+                        fprintf(stderr,
+                                "KVM: injection failed, interrupt lost (%s)\n",
+                                strerror(-ret));
+                    }
                 }
             }
         }
@@ -5531,7 +5540,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 
         DPRINTF("setting tpr\n");
         run->cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
+        /*
+         * make sure that request_interrupt_window/cr8 are set
+         * before KVM_RUN might read them
+         */
+        smp_mb();
+    }
 
+    if (release_bql) {
         bql_unlock();
     }
 }
-- 
2.47.1


