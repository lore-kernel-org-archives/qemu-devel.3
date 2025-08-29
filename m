Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F5CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNKu-0003UN-9A; Sat, 30 Aug 2025 11:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryjQ-0001QB-11
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryjN-00009f-W2
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNjdodWk7rcIhhAGNhnPGaLvYybeyDD5TwM221RwZAk=;
 b=he3EUK5Edj3JEck2wYwLTMQgec4gT1as3D84tdettaFZI4agYSmeLKzGtliAQJ1Pyeu+M7
 2kvYiiQDnlm/55WR8n6Ohzf4fGgjoTc+aOzmLc20epyfpBVPnYL5OVo7F1eg6qDSMtYiCc
 a4yUIW758JMtqZ/WwkGoYUmVB9YK4TM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-uJVVF_zZP8KWzOMPC_qA9g-1; Fri, 29 Aug 2025 09:01:24 -0400
X-MC-Unique: uJVVF_zZP8KWzOMPC_qA9g-1
X-Mimecast-MFC-AGG-ID: uJVVF_zZP8KWzOMPC_qA9g_1756472483
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0b46bbso11366965e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472482; x=1757077282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNjdodWk7rcIhhAGNhnPGaLvYybeyDD5TwM221RwZAk=;
 b=Z37oQYzgimntkhi/hTp/gHdkwNZAJugVgT6wnHuYmHNaUEIws4bkj3AVgqSYW32Vya
 6QPQlvkdkhNt0OKGI46T6oxdXLT0R0bQk6NByoU0FLZyrajnDpyWo7DsItzysSqAKA2Q
 7XhejzA0176hdlInBLKspQVtRk6x5UqdyB2Wcecvz0toV2B+aD2Edp4iQ1ps2OH+aKYA
 UuZitvGJMwxcOml082VMNC44DZh6mi17WD168Vygws9WWtcSwNzgyAYU+PaPsD/IbHaN
 r5P4aIz5X1I8FSQ5CeZSGTqeR3XG6IAoEUtS/NBmCgOcuDphhqfAU4d5EECVyVRlDlqP
 oFBw==
X-Gm-Message-State: AOJu0Yz7ygI7+1q0Ey12a5Y5ldDDCnGRJvu1i0Ze3l5xKQCHa/mAlryU
 ShIdmpq7TJTu9lojlfME7jsY5FSat7atLGLMf06vNxENWkufJMOQPFgdJkFPYZYXqu1Wwxm9vQg
 lczMrHuDyRXaJc5LpNGQM3yEKwKD+eeP02XzytD7vur510ZMWPP6CYiR1hNQsFSJ33PWYcJPm5I
 0gvKUQ7ZZDhhf+KHh5ZNylue0Q3wPUF/Vk9afqrteR
X-Gm-Gg: ASbGncusK+M8hbaVReaoDbNqDfMXV1by7DArbKmyXa2Vyjk+srrj9zhQK0VR9YaF/9A
 of5AkFfmAr8vcgYVp5nS5FEI4OSocWfN3je8p3XDfMNuS84vg6IpcfBMnGHOpKV+heVapZDmV5J
 kLeIK/o6lzpLiVzStCrANNGEMXEOO+4UHlH/pyMVllas6fjI/h7F2euU6pq/MRymAswtW+EtzUe
 aChaERbuGPf1AKtG9NFkXd2cMRa7zRvL/Rgmc6FsjqLHICQU5pvPK6Acv99DDpD4TcWp25YyqAw
 0gKzeducC8Hpx6kBARs/Rjj/9o8CsOnA6Q+PFMA+15pOZDlfyN7/XW18vphvt38bJxiabw30Lia
 Yy7otq2PQPIzp+3hDeUi7QXZdiMuJLx/UOz6taXJEAWY=
X-Received: by 2002:a5d:5d87:0:b0:3c8:f348:7882 with SMTP id
 ffacd0b85a97d-3c8f34887d8mr15009744f8f.54.1756472481440; 
 Fri, 29 Aug 2025 06:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSBuU5yy7Mbc2ZujWUqM7uq+Zevh2Of9cZsRwLKDJSP0n7lyT5LILB49ctQmqQ6g17DxWDlw==
X-Received: by 2002:a5d:5d87:0:b0:3c8:f348:7882 with SMTP id
 ffacd0b85a97d-3c8f34887d8mr15009694f8f.54.1756472479781; 
 Fri, 29 Aug 2025 06:01:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0c344f6e3sm2190886f8f.35.2025.08.29.06.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:01:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 27/28] kvm: i386: irqchip: take BQL only if there is an
 interrupt
Date: Fri, 29 Aug 2025 14:59:34 +0200
Message-ID: <20250829125935.1526984-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

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
Link: https://lore.kernel.org/r/20250814160600.2327672-8-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a7b5c8f81bc..306430a0521 100644
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
2.51.0


