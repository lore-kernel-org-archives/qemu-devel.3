Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CC7CA0EC1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJW-0006Ij-Fu; Fri, 08 Aug 2025 14:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJT-0006I0-Pu
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJR-0006hF-SL
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d2XHvUBpwg8VKpJHI1tJuy/t/ZJPlJT11M9aWPvcQuQ=;
 b=OT9sAmlDV9vfVKvG0XhKvYmuPnWzogENncscjJcaWLzjKDIPuO8ISXLAYIz3/3gO5XUe/3
 uL8JDyJlbjaAzS6AhlbUpUWKhgnzsqAwiL1yvKQCW3YOg2pURs9je6ZgOfA8aguG2Wi/s6
 Tbi1Eo3c+A3ZxIWGKMKsKR0c6CUX370=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-og6S16JpMlOFh_pzZNUFpw-1; Fri, 08 Aug 2025 14:59:31 -0400
X-MC-Unique: og6S16JpMlOFh_pzZNUFpw-1
X-Mimecast-MFC-AGG-ID: og6S16JpMlOFh_pzZNUFpw_1754679571
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7886bfc16so1463292f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679570; x=1755284370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d2XHvUBpwg8VKpJHI1tJuy/t/ZJPlJT11M9aWPvcQuQ=;
 b=TiseESi3SMWd8FTN4b+Sa03PlgVRqDjDaPvv8bhrGt7FuYZHMACWOSBqXlTwrlCxnY
 QQkMYtDpajdC9ZjeB7IgqPeE1uoU2fYFVjWTxfRHx5bI951tYdXTbRrICsBBTrCT0Wvp
 24cHFayKyeqHF2zjHdtOuP6Y+TuwmWyotQ/zeUegRXWPBGN5JJhA/wUHQ16A8DT323H7
 OQ4J2ak90dTyv3nN0fVqW9awfv72H0UQzou5m+n1TjAdPtxmQNgnRsEVnAJNvljkayGU
 rwgTHpI84aRNa7b6VfgndGt0pVoo/8qdN4SGH0j51MUqYzCnpbK3QNLmGkGcSY452ocn
 si5w==
X-Gm-Message-State: AOJu0Yw1n7CzTGnXmxb0v9c2Ch1Tbc1x7SuZ4xrqKCTp6MXahc50Nxwl
 S4nYxyrUDPFmz/oESX8SjiTPZ92I44u7ObskTqCnX3EPJ6kNu6sLtz3OSkJtEPCVTm8i+NU1PBt
 B35okoJbvw4GpJFBNC6qZJq/q7oY4izHK1hVk8LGez5l8V8V+MnOb7ig77g85tN3ABttXT4Do9+
 eMSIHtw1kgyebhNxXgiVDQhclltHiP6+jyjLVSKpzI
X-Gm-Gg: ASbGncuwxmEzrBGJcuzcJ4XyxBXZpR4/YdetVmR010WoJYiUDGSEZ83pCZ7R04A/UVf
 J9iJKxTM4KaRpsLg7JzWQ2MNe4PIIa0m9NIzYgurxJUISWVirkjR1IOG99PhNKFRdbqeZDeHPNr
 O0NfQ25/SdqWTEaQkwcVdj6lk6aqW5+heGQHZnOt8qN0Gh59fmAXzEiYaADamJ/Oe3xd+n+o6OH
 RZgGt4e4xR3tX6PmFxnKaQ/a6uBA/3Obk2yImzGrNuhmMmKj9Yvz6HYNb4tsV4Dg1RVHMUeu2Me
 e0tM+jFg4NMDcceYosCnkQi/+AV/+CUcbV50r54LJmvB
X-Received: by 2002:a5d:5d0c:0:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3b900b4d2edmr3042324f8f.18.1754679569563; 
 Fri, 08 Aug 2025 11:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUja3DQXvAKiNWluT9lmBxnTPvUxuFbWd4C59nbnBnbB1ud7Pd3+gKhdVZ5S981JR+z010gQ==
X-Received: by 2002:a5d:5d0c:0:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3b900b4d2edmr3042305f8f.18.1754679569028; 
 Fri, 08 Aug 2025 11:59:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469582sm30574957f8f.52.2025.08.08.11.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 8/8] accel: make all calls to qemu_wait_io_event look the same
Date: Fri,  8 Aug 2025 20:59:05 +0200
Message-ID: <20250808185905.62776-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808185905.62776-1-pbonzini@redhat.com>
References: <20250808185905.62776-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

There is no reason for some accelerators to use qemu_wait_io_event_common
(which is specifically separated for round robin).  They can also check
on the first pass through the loop as well directly, without setting
cpu->exit_request for no particular reason.

There is also no need to use qatomic_set_mb() because the ordering of
the communication between I/O and vCPU threads is always the same.
In the I/O thread:

(a) store other memory locations that will be checked if cpu->exit_request
    or cpu->interrupt_request is 1 (for example cpu->stop or cpu->work_list
    for cpu->exit_request)

(b) cpu_exit(): store-release cpu->exit_request, or
(b) cpu_interrupt(): store-release cpu->interrupt_request

>>> at this point, cpu->halt_cond is broadcast and the BQL released

(c) do the accelerator-specific kick (e.g. write icount_decr for TCG,
    pthread_kill for KVM, etc.)

In the vCPU thread instead the opposite order is respected:

(c) the accelerator's execution loop exits thanks to the kick

(b) then the inner execution loop checks cpu->interrupt_request
    and cpu->exit_request.  If needed cpu->interrupt_request is
    converted into cpu->exit_request when work is needed outside
    the execution loop.

(a) then the other memory locations are checked.  Some may need
    to be read under the BQL, and the vCPU thread may also take
    for the vCPU thread can sleep on cpu->halt_cond; but in
    principle this step is correct even without the BQL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/dummy-cpus.c                |  2 +-
 accel/hvf/hvf-accel-ops.c         |  2 +-
 accel/kvm/kvm-accel-ops.c         |  3 ++-
 accel/kvm/kvm-all.c               |  2 --
 accel/tcg/cpu-exec.c              |  1 -
 accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++----
 accel/tcg/tcg-accel-ops-rr.c      | 38 ++++++++++++++++---------------
 accel/tcg/tcg-accel-ops.c         |  2 --
 system/cpus.c                     |  1 +
 target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
 target/i386/nvmm/nvmm-all.c       |  2 --
 target/i386/whpx/whpx-accel-ops.c |  6 ++---
 target/i386/whpx/whpx-all.c       |  2 --
 13 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 03cfc0fa01e..1f74c727c42 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -43,6 +43,7 @@ static void *dummy_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_wait_io_event(cpu);
         bql_unlock();
 #ifndef _WIN32
         do {
@@ -57,7 +58,6 @@ static void *dummy_cpu_thread_fn(void *arg)
         qemu_sem_wait(&cpu->sem);
 #endif
         bql_lock();
-        qemu_wait_io_event(cpu);
     } while (!cpu->unplug);
 
     bql_unlock();
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d488d6afbac..4ba3e40831f 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -192,13 +192,13 @@ static void *hvf_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_wait_io_event(cpu);
         if (cpu_can_run(cpu)) {
             r = hvf_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     hvf_vcpu_destroy(cpu);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index b709187c7d7..80f0141a8a6 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -47,13 +47,14 @@ static void *kvm_vcpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_wait_io_event(cpu);
+
         if (cpu_can_run(cpu)) {
             r = kvm_cpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     kvm_destroy_vcpu(cpu);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 57e35960125..db95e06e768 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3155,7 +3155,6 @@ int kvm_cpu_exec(CPUState *cpu)
     trace_kvm_cpu_exec();
 
     if (kvm_arch_process_async_events(cpu)) {
-        qatomic_set(&cpu->exit_request, 0);
         return EXCP_HLT;
     }
 
@@ -3345,7 +3344,6 @@ int kvm_cpu_exec(CPUState *cpu)
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
 
-    qatomic_set(&cpu->exit_request, 0);
     return ret;
 }
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b9da2e3770e..f474ccb37f5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -871,7 +871,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * The corresponding store-release is in cpu_exit.
      */
     if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
-        qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
         }
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 5757324a8c2..04012900a30 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -84,10 +84,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
-    /* process any pending work */
-    qatomic_set(&cpu->exit_request, 1);
-
     do {
+        qemu_wait_io_event(cpu);
+
         if (cpu_can_run(cpu)) {
             int r;
             bql_unlock();
@@ -112,8 +111,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
                 break;
             }
         }
-
-        qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     tcg_cpu_destroy(cpu);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 87b49377c78..205f379b6f8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -211,13 +211,30 @@ static void *rr_cpu_thread_fn(void *arg)
 
     cpu = first_cpu;
 
-    /* process any pending work */
-    qatomic_set(&cpu->exit_request, 1);
-
     while (1) {
         /* Only used for icount_enabled() */
         int64_t cpu_budget = 0;
 
+        if (cpu) {
+            /*
+             * This could even reset exit_request for all CPUs, but in practice
+             * races between CPU exits and changes to "cpu" are so rare that
+             * there's no advantage in doing so.
+             */
+            qatomic_set(&cpu->exit_request, 0);
+        }
+
+        if (icount_enabled() && all_cpu_threads_idle()) {
+            /*
+             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
+             * in the main_loop, wake it up in order to start the warp timer.
+             */
+            qemu_notify_event();
+        }
+
+        rr_wait_io_event();
+        rr_deal_with_unplugged_cpus();
+
         bql_unlock();
         replay_mutex_lock();
         bql_lock();
@@ -285,21 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
 
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
-
-        if (cpu && qatomic_read(&cpu->exit_request)) {
-            qatomic_set_mb(&cpu->exit_request, 0);
-        }
-
-        if (icount_enabled() && all_cpu_threads_idle()) {
-            /*
-             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
-             * in the main_loop, wake it up in order to start the warp timer.
-             */
-            qemu_notify_event();
-        }
-
-        rr_wait_io_event();
-        rr_deal_with_unplugged_cpus();
     }
 
     g_assert_not_reached();
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index f4d5372866a..ad3f29107e1 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -82,8 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
 
-    qatomic_set_mb(&cpu->exit_request, 0);
-
     return ret;
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index d2cfa2a9c4e..0cc14eae6a0 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -458,6 +458,7 @@ void qemu_wait_io_event(CPUState *cpu)
 {
     bool slept = false;
 
+    qatomic_set(&cpu->exit_request, false);
     while (cpu_thread_is_idle(cpu)) {
         if (!slept) {
             slept = true;
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 3658a583bc8..6d2e2542d80 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -42,16 +42,14 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_wait_io_event(cpu);
+
         if (cpu_can_run(cpu)) {
             r = nvmm_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait_bql(cpu->halt_cond);
-        }
-        qemu_wait_io_event_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     nvmm_destroy_vcpu(cpu);
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index d2d90f38976..09839d45b92 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -817,8 +817,6 @@ nvmm_vcpu_loop(CPUState *cpu)
     cpu_exec_end(cpu);
     bql_lock();
 
-    qatomic_set(&cpu->exit_request, false);
-
     return ret < 0;
 }
 
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index da58805b1a6..611eeedeef7 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -42,16 +42,14 @@ static void *whpx_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_wait_io_event(cpu);
+
         if (cpu_can_run(cpu)) {
             r = whpx_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait_bql(cpu->halt_cond);
-        }
-        qemu_wait_io_event_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     whpx_destroy_vcpu(cpu);
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9b07716121a..2e248a0a6d5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2050,8 +2050,6 @@ static int whpx_vcpu_run(CPUState *cpu)
         whpx_last_vcpu_stopping(cpu);
     }
 
-    qatomic_set(&cpu->exit_request, false);
-
     return ret < 0;
 }
 
-- 
2.50.1


