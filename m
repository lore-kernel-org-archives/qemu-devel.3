Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63B1CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsN-0001pU-RK; Mon, 08 Sep 2025 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsK-0001oo-Ql
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsD-0000x6-88
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9F9omlNx3zkAVVgrXaGDIxi/SyKkxZLJobZOnZwp8BQ=;
 b=TyFwglgstsuUAICrZFVOUZrww4FPSDfW7czFguUWc9nPm4BzBXrM5SECMijr1Ctr+818wH
 ynaot6TpTlLJ9Raq6lwP1gUMSzeyUedlLiCtXhbI2qPUbCQvJkEsRKMNewa+mX8rxa7lve
 +ftIESco114mhkHP6ExSEALE3LGRgDA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-MkwKhkZVP9WCgaQbjLgtug-1; Mon, 08 Sep 2025 06:13:12 -0400
X-MC-Unique: MkwKhkZVP9WCgaQbjLgtug-1
X-Mimecast-MFC-AGG-ID: MkwKhkZVP9WCgaQbjLgtug_1757326391
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e3b77972cbso1450135f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326388; x=1757931188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F9omlNx3zkAVVgrXaGDIxi/SyKkxZLJobZOnZwp8BQ=;
 b=HeZu1ZTYGV4qketcJLJI2If8IXHEJ3Q08iOpIkDMBYDQ55sq31ITtx+OS81gbEcknD
 4qagXlCuNPDpOeWFo/yT03iIaTSHEc+6e/+5TFgUob9Vq4CcmQHRiby6bwpl/HJjDoFS
 nqINVGKGv/akLDnJiUQkmoiCxYKQy2xeHjv/qF/cCIptZvKX7GvzgWQlguEtqXsifR2d
 wNxOwEWJq2opGL7hJ+YzPeBarMplRFEMLlIwhiKKuo9EPif9fjdIVOWGxKRGq9cXZO6O
 FyObf4ivrOYWH3i/YHE+wEuyJWaBWoSH+rdFYl1XS1GNs9j+lRzBDlQYS9mTAM2Qw3/A
 Al2Q==
X-Gm-Message-State: AOJu0YzsgvgjCQ/axufWAUepYb18wYdS5lXBbS2iVkvIpBB+fxMu9YVT
 aVzTBUBxx+abtNZpOxBKd5DtmkwUGRHg/ZLKKiFEyEeG+BPozTNKarnWB5bf6pA6QJ8z9gCqNSN
 m+c8LkrSG0XlhOfJuYcmPN39anuAm7a3j2JrVjuyDNOYAnTKRSXW34lsJGcTEWo+xb94odkLU89
 5orAXJyRMQiYMYJQzR+p227pwlXwZVLLzoUrAn5zk0
X-Gm-Gg: ASbGncuOgn6N/ik8KkZvk4l6TgBSfeDes1Bf2uQ7NdbvBvaXbJwKe2UdIf1uzOebUvn
 NMgMjoffSU9WjnXSaumkL/rNAIn+SoJ784qQmiSwZb1lQZG5cs7PLGRpYgngaODoJkEm9o1AB6L
 rH/XfMwGfXeYvfF/+592qQx2U5yo8oE66QdrhKIvqmjMUYnAKPKQKo6VUcQqPriHSLaaYRVIC2B
 VwIbsKlBZE1f9q6el5/W+ZY8XyYbHXyjBLYY4Bn/BDEnLjhKvM7nVOIEQoFewH1IPnXNCf/yTJP
 mOtcrOT6W7wv66+JuravRg1/W8vWeI29Eh7nox8WcdQmksiG6llMCgcb5iyIfhXFf9sZ8htydXn
 3PD1UwKcX8V16XEC9RajY/BkaDuMDGle/jobNz2wnwyA=
X-Received: by 2002:a05:6000:1acd:b0:3e5:50:e070 with SMTP id
 ffacd0b85a97d-3e64c789650mr4848514f8f.50.1757326388281; 
 Mon, 08 Sep 2025 03:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETPYIPWARpMny9jmQtqFuA7IPClj38ZHOG5z7M2vc4aWwgns8nIwsGlIiGgLvABmVep2ujJw==
X-Received: by 2002:a05:6000:1acd:b0:3e5:50:e070 with SMTP id
 ffacd0b85a97d-3e64c789650mr4848477f8f.50.1757326387757; 
 Mon, 08 Sep 2025 03:13:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d729a96912sm28665067f8f.8.2025.09.08.03.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 10/19] accel: use atomic accesses for exit_request
Date: Mon,  8 Sep 2025 12:12:32 +0200
Message-ID: <20250908101241.2110068-11-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

CPU threads write exit_request as a "note to self" that they need to
go out to a slow path.  This write happens out of the BQL and can be
a data race with another threads' cpu_exit(); use atomic accesses
consistently.

While at it, change the source argument from int ("1") to bool ("true").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h             | 9 +++++++++
 accel/kvm/kvm-all.c               | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
 accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
 hw/ppc/spapr_hcall.c              | 6 +++---
 target/i386/kvm/kvm.c             | 6 +++---
 target/i386/nvmm/nvmm-accel-ops.c | 2 +-
 target/i386/nvmm/nvmm-all.c       | 2 +-
 target/i386/whpx/whpx-all.c       | 6 +++---
 9 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8b57bcd92c9..338757e5254 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -422,6 +422,15 @@ struct qemu_work_item;
  * valid under cpu_list_lock.
  * @created: Indicates whether the CPU thread has been successfully created.
  * @halt_cond: condition variable sleeping threads can wait on.
+ * @exit_request: Another thread requests the CPU to call qemu_wait_io_event().
+ *   Should be read only by CPU thread with load-acquire, to synchronize with
+ *   other threads' store-release operation.
+ *
+ *   In some cases, accelerator-specific code will write exit_request from
+ *   within the same thread, to "bump" the effect of qemu_cpu_kick() to
+ *   the one provided by cpu_exit(), especially when processing interrupt
+ *   flags.  In this case, the write and read happen in the same thread
+ *   and the write therefore can use qemu_atomic_set().
  * @interrupt_request: Indicates a pending interrupt request.
  *   Only used by system emulation.
  * @halted: Nonzero if the CPU is in suspended state.
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bd9e5e3886d..e4167d94b4f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3730,7 +3730,7 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
     have_sigbus_pending = true;
     pending_sigbus_addr = addr;
     pending_sigbus_code = code;
-    qatomic_set(&cpu->exit_request, 1);
+    qatomic_set(&cpu->exit_request, true);
     return 0;
 #else
     return 1;
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 337b993d3da..b12b7a36b5d 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -85,7 +85,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* process any pending work */
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, true);
 
     do {
         if (cpu_can_run(cpu)) {
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index e8b0e370a8d..d13e0d8b44d 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -212,7 +212,7 @@ static void *rr_cpu_thread_fn(void *arg)
     cpu = first_cpu;
 
     /* process any pending work */
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, true);
 
     while (1) {
         /* Only used for icount_enabled() */
@@ -293,7 +293,7 @@ static void *rr_cpu_thread_fn(void *arg)
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
 
-        if (cpu && cpu->exit_request) {
+        if (cpu && qatomic_read(&cpu->exit_request)) {
             qatomic_set_mb(&cpu->exit_request, 0);
         }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1e936f35e44..51875e32a09 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -509,7 +509,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
-        cs->exit_request = 1;
+        qatomic_set(&cs->exit_request, true);
         ppc_maybe_interrupt(env);
     }
 
@@ -531,7 +531,7 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
     }
     cs->halted = 1;
     cs->exception_index = EXCP_HALTED;
-    cs->exit_request = 1;
+    qatomic_set(&cs->exit_request, true);
     ppc_maybe_interrupt(&cpu->env);
 
     return H_SUCCESS;
@@ -624,7 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     cs->exception_index = EXCP_YIELD;
-    cs->exit_request = 1;
+    qatomic_set(&cs->exit_request, true);
     cpu_loop_exit(cs);
 
     return H_SUCCESS;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8420c4090ef..34e74f24470 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5486,10 +5486,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
-            qatomic_set(&cpu->exit_request, 1);
+            qatomic_set(&cpu->exit_request, true);
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
-            qatomic_set(&cpu->exit_request, 1);
+            qatomic_set(&cpu->exit_request, true);
         }
     }
 
@@ -5604,7 +5604,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         if (env->exception_nr == EXCP08_DBLE) {
             /* this means triple fault */
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-            cs->exit_request = 1;
+            qatomic_set(&cs->exit_request, true);
             return 0;
         }
         kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 3799260bbde..86869f133e9 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -77,7 +77,7 @@ static void nvmm_start_vcpu_thread(CPUState *cpu)
  */
 static void nvmm_kick_vcpu_thread(CPUState *cpu)
 {
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, true);
     cpus_kick_thread(cpu);
 }
 
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 10bd51d9b59..7e36c42fbb4 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -414,7 +414,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
      * or commit pending TPR access.
      */
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        cpu->exit_request = 1;
+        qatomic_set(&cpu->exit_request, true);
     }
 
     if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2106c29c3a0..00fb7e23100 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1489,10 +1489,10 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
-            cpu->exit_request = 1;
+            qatomic_set(&cpu->exit_request, true);
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
-            cpu->exit_request = 1;
+            qatomic_set(&cpu->exit_request, true);
         }
     }
 
@@ -1539,7 +1539,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
-        cpu->exit_request = 1;
+        qatomic_set(&cpu->exit_request, true);
         reg_names[reg_count] = WHvX64RegisterCr8;
         reg_count += 1;
     }
-- 
2.51.0


