Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC573CA0EE8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 16:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umaTR-0001lA-Af; Thu, 14 Aug 2025 12:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1umaTN-0001kv-VP
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1umaTL-0005lQ-Vx
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755187594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VVuTG6HLe6NnLPADyzf+X8klPPHgKjfBnNfYtgdoJI=;
 b=GtXu5ryL9OViIMkSirTn/4mZS2mA9fEH9HuGw9ohSoo6F7G8ameZKMg0kB2Sfrkh5/wp53
 EcTPU9FHVJB6CLnAMwxkRVxnc4SGOCFeJDTS6quAocaZh39+c/2/UOATcbaGsr7yBAYXVN
 utaaeIwFBBpvGx6sSHcGgHYs3p/ropM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-D4XkgNxCPqedkWjlYvXKCg-1; Thu,
 14 Aug 2025 12:06:33 -0400
X-MC-Unique: D4XkgNxCPqedkWjlYvXKCg-1
X-Mimecast-MFC-AGG-ID: D4XkgNxCPqedkWjlYvXKCg_1755187592
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8025C1800289
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 16:06:32 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B297A180044F; Thu, 14 Aug 2025 16:06:30 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, mtosatti@redhat.com
Subject: [PATCH v4 7/8] kvm: i386: irqchip: take BQL only if there is an
 interrupt
Date: Thu, 14 Aug 2025 18:05:59 +0200
Message-ID: <20250814160600.2327672-8-imammedo@redhat.com>
In-Reply-To: <20250814160600.2327672-1-imammedo@redhat.com>
References: <20250814160600.2327672-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

when kernel-irqchip=split is used, QEMU still hits BQL
contention issue when reading ACPI PM/HPET timers
(despite of timer[s] access being lock-less).

So Windows with more than 255 cpus is still not able to
boot (since it requires iommu -> split irqchip).

Problematic path is in kvm_arch_pre_run() where BQL is taken
unconditionally when split irqchip is in use.

There are a few parts that BQL protects there:
  1. interrupt check and injecting

    however we do not take BQL when checking for pending
    interrupt (even within the same function), so the patch
    takes the same approach for cpu->interrupt_request checks
    and takes BQL only if there is a job to do.

  2. request_interrupt_window access
      CPUState::kvm_run::request_interrupt_window doesn't need BQL
      as it's accessed by its own vCPU thread.

  3. cr8/cpu_get_apic_tpr access
      the same (as #2) applies to CPUState::kvm_run::cr8,
      and APIC registers are also cached/synced (get/put) within
      the vCPU thread it belongs to.

Taking BQL only when is necessary, eleminates BQL bottleneck on
IO/MMIO only exit path, improoving latency by 80% on HPET micro
benchmark.

This lets Windows to boot succesfully (in case hv-time isn't used)
when more than 255 vCPUs are in use.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
v3:
  * drop net needed pair of () in cpu->interrupt_request & CPU_INTERRUPT_HARD
    check
  * Paolo Bonzini <pbonzini@redhat.com>
     * don't take BQL when setting exit_request, use qatomic_set() instead
     * after above simplification take/release BQL unconditionally
     * drop smp_mb() after run->cr8/run->request_interrupt_window update
---
 target/i386/kvm/kvm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a7b5c8f81b..306430a052 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5478,9 +5478,6 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
         }
     }
 
-    if (!kvm_pic_in_kernel()) {
-        bql_lock();
-    }
 
     /* Force the VCPU out of its inner loop to process any INIT requests
      * or (for userspace APIC, but it is cheap to combine the checks here)
@@ -5489,10 +5486,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
-            cpu->exit_request = 1;
+            qatomic_set(&cpu->exit_request, 1);
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
-            cpu->exit_request = 1;
+            qatomic_set(&cpu->exit_request, 1);
         }
     }
 
@@ -5503,6 +5500,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
             (env->eflags & IF_MASK)) {
             int irq;
 
+            bql_lock();
+
             cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
             irq = cpu_get_pic_interrupt(env);
             if (irq >= 0) {
@@ -5517,6 +5516,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
                             strerror(-ret));
                 }
             }
+            bql_unlock();
         }
 
         /* If we have an interrupt but the guest is not ready to receive an
@@ -5531,8 +5531,6 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 
         DPRINTF("setting tpr\n");
         run->cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
-
-        bql_unlock();
     }
 }
 
-- 
2.47.1


