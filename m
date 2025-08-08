Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D7C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJI-0006EL-W5; Fri, 08 Aug 2025 14:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJG-0006De-RQ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJF-0006g2-6I
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrVXt3xbYChrYy+q8fC6Jz8QBJwcNkprpohDabmVtrs=;
 b=LV1LXMl7x5c0u8YLE7dARh9Bn9gzfgw3qsMcocJD6Hk06L9B+C/h8ymU1mS1uIlLcA3En7
 fWq3OYtd6sTYIy+8XuyfbQFZHcsQJo1zpGsvKgLl8ucT5Ec3xX6JBtEJOZ5igxTvafAA5A
 wbu6QiS52KiEVurqGVHvRObdHOhU5JQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-AUuwm6DPO1KTScFk0vGq6w-1; Fri, 08 Aug 2025 14:59:19 -0400
X-MC-Unique: AUuwm6DPO1KTScFk0vGq6w-1
X-Mimecast-MFC-AGG-ID: AUuwm6DPO1KTScFk0vGq6w_1754679558
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-456106b7c4aso12787275e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679557; x=1755284357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrVXt3xbYChrYy+q8fC6Jz8QBJwcNkprpohDabmVtrs=;
 b=cEDikEHBRxV2xdmPUMeuwy/FkLs8Zo9fW0Gs4ouZ8NLEetwEh8TUoE650RxZuq5Wo7
 3MADtg+DjlfyoS8S//MwdDdMyJv8ghcVZMa4eucxvr5UnjpGL0bM7n1+ED1flZS4+CyH
 b9y3fdjD2oF3gNneiwEeEpNCuBa1gaLswZBH/tjGOlhfmbyojsXo2zq5Zt5rEnC2Qe60
 SpLtlSzcetjIVm6rJLc4FTMIuAw6qy6JPwk4aEPqzk1CPx/b3hVsljNiPbH7jV7lLQNZ
 Dtv1dzuPL/G4ADPRPqH4xynqEdY1VMbGpVMz0L21QSC3khH6vKaAH5yofemeQ4M/eMNB
 V4rA==
X-Gm-Message-State: AOJu0YxR9+TrFGPR1Wc1jrdWJihcq3yI73W3YFAQW4LXzcGn4rjuKchm
 8MWkG+FP++qEZmC87BFxS/Dm+oPO0L3S+vqxgvFmhsasG40dtTIKEJNeOhg3w7S5rCxIRXqGmTE
 JM3Z56SW/yBPGUtyrL2RDaP9QZ+vZs+CxKDMY8+MecptJicCwxeX4EtxfUtYJvNR/i8I1wtr17z
 MIxWel+TRgfggjUxA7rpDYma6IIaCsSkmRD/ly17jX
X-Gm-Gg: ASbGncvY1HYbSD1N5ihHfeVWsuSZh3XAdBkJq9B/GE66RlHExM/MdECWORH2SEp7Hgw
 Q20yY6SAmj7hUVC17NpvA2MlABdvliMo4yiVT8v8Xr8nwYoS01+ZT/VWu9w6baP2NWiSk/eY3kL
 BIdVKq4yPexFMmc85+OpZdftqcc3XOkTsxh1hNMstilIkpsSkkyfOQI7I12wHKgIw+tCELXj7yD
 yhTOOwarS+BworvCNtvKiGE2V92hvsPhaPYWlTEx52rjI+Hdi4ZMXQDkvSf0Bs2MzpIyA1dDFTU
 QBQ59opTMU9trM/3PUYSEkTELKoyc5xVrkMqGkEcVwkM
X-Received: by 2002:a05:600c:3b1b:b0:459:e39e:e5a5 with SMTP id
 5b1f17b1804b1-459f51a7fbamr37300325e9.5.1754679556836; 
 Fri, 08 Aug 2025 11:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCM/Pp9WgCSSnWFP5mPwLStDTtNjyCCdnYpR+9+Fr6gKo4jSfZBboHQsaMThahH/+9rZYutQ==
X-Received: by 2002:a05:600c:3b1b:b0:459:e39e:e5a5 with SMTP id
 5b1f17b1804b1-459f51a7fbamr37300105e9.5.1754679556314; 
 Fri, 08 Aug 2025 11:59:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm157348725e9.13.2025.08.08.11.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 3/8] accel: use atomic accesses for exit_request
Date: Fri,  8 Aug 2025 20:59:00 +0200
Message-ID: <20250808185905.62776-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808185905.62776-1-pbonzini@redhat.com>
References: <20250808185905.62776-1-pbonzini@redhat.com>
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

CPU threads write exit_request as a "note to self" that they need to
go out to a slow path.  This write happens out of the BQL and can be
a data race with another threads' cpu_exit(); use atomic accesses
consistently.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
 accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
 hw/ppc/spapr_hcall.c              | 6 +++---
 target/i386/kvm/kvm.c             | 2 +-
 target/i386/nvmm/nvmm-accel-ops.c | 2 +-
 target/i386/nvmm/nvmm-all.c       | 2 +-
 target/i386/whpx/whpx-all.c       | 6 +++---
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 337b993d3da..39237421757 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -85,7 +85,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* process any pending work */
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, 1);
 
     do {
         if (cpu_can_run(cpu)) {
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 1e551e92d6d..c06f3beef2e 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -212,7 +212,7 @@ static void *rr_cpu_thread_fn(void *arg)
     cpu = first_cpu;
 
     /* process any pending work */
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, 1);
 
     while (1) {
         /* Only used for icount_enabled() */
@@ -286,7 +286,7 @@ static void *rr_cpu_thread_fn(void *arg)
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
 
-        if (cpu && cpu->exit_request) {
+        if (cpu && qatomic_read(&cpu->exit_request)) {
             qatomic_set_mb(&cpu->exit_request, 0);
         }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1e936f35e44..03a62b047b3 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -509,7 +509,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
-        cs->exit_request = 1;
+        qatomic_set(&cs->exit_request, 1);
         ppc_maybe_interrupt(env);
     }
 
@@ -531,7 +531,7 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
     }
     cs->halted = 1;
     cs->exception_index = EXCP_HALTED;
-    cs->exit_request = 1;
+    qatomic_set(&cs->exit_request, 1);
     ppc_maybe_interrupt(&cpu->env);
 
     return H_SUCCESS;
@@ -624,7 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     cs->exception_index = EXCP_YIELD;
-    cs->exit_request = 1;
+    qatomic_set(&cs->exit_request, 1);
     cpu_loop_exit(cs);
 
     return H_SUCCESS;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 306430a0521..867eabc6969 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5604,7 +5604,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         if (env->exception_nr == EXCP08_DBLE) {
             /* this means triple fault */
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-            cs->exit_request = 1;
+            qatomic_set(&cs->exit_request, 1);
             return 0;
         }
         kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 3799260bbde..3658a583bc8 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -77,7 +77,7 @@ static void nvmm_start_vcpu_thread(CPUState *cpu)
  */
 static void nvmm_kick_vcpu_thread(CPUState *cpu)
 {
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, 1);
     cpus_kick_thread(cpu);
 }
 
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index a5e3485c1f8..d2d90f38976 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -414,7 +414,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
      * or commit pending TPR access.
      */
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        cpu->exit_request = 1;
+        qatomic_set(&cpu->exit_request, 1);
     }
 
     if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9f88e368d4d..9b07716121a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1489,10 +1489,10 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
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
 
@@ -1539,7 +1539,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
-        cpu->exit_request = 1;
+        qatomic_set(&cpu->exit_request, 1);
         reg_names[reg_count] = WHvX64RegisterCr8;
         reg_count += 1;
     }
-- 
2.50.1


