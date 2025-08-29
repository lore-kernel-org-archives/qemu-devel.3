Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB46BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOh-0004Mw-QN; Sat, 30 Aug 2025 11:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us15C-0001zT-5U
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us15A-0000b5-1h
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xEtUsJi2kRdlofIL/bHxeoYx243AvCSlnxju7PVGk0=;
 b=HLNn/KWudYJOcKIXGw/K2unJouyiMOrA1+6wqsFAzpkuVm7eiPY85DwK+8ZM34lWPkYEqb
 Mvh9KASjpT2CvB/WF4Ik8yrCVP7j7yv3ud+K6EE3wCfvzglsHcQ6LDRlMHDeTnBNCMATmT
 3ydlOkOl72L0ZGm0dvCkcN0KDtV+U0w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-tYLIXmZBN--ZCbROzjxejQ-1; Fri, 29 Aug 2025 11:32:01 -0400
X-MC-Unique: tYLIXmZBN--ZCbROzjxejQ-1
X-Mimecast-MFC-AGG-ID: tYLIXmZBN--ZCbROzjxejQ_1756481520
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c9bf5c8b12so1265934f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481520; x=1757086320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xEtUsJi2kRdlofIL/bHxeoYx243AvCSlnxju7PVGk0=;
 b=q3TMNusGc9rilVK+eaukrOt3jAEqkrEwt6sFwkEGPz8/30zgbUKqfCbYy8eTiXhtDr
 keHPpKtoqvW6k9U/e5MrDbsNOWhXbZw3dtzFaMJt41ioIHU2Vn4Tw+3LxmDrsl/atjfc
 r6Ox/41oj+ebXVmHuxHsFC+P9RPTnh/WJfevlrKYRQK/iJWNXBNwQEuRt8lD3x3hcKZU
 fUHpX04bwxCMTCtTYRZjlUMGQD+z27f72bQ5njpLnPF6Eh3yEgeYOnpPCUU3PSAgtCLa
 8W5agALjcCFA8QN0G/Bi8qm1eRB6KF3E4OuVn8jtcWdtzgLeL486qQ4nyAMKbwXjffsT
 0LNQ==
X-Gm-Message-State: AOJu0Yxi5mgT3ibjG/LI7QM++BLw/o8Jx3oqpE//DgEzoOBCCkxqyabo
 bo3PgRXtJccVbm/qSEY8kTa/NGZK3Kh/Nc5QeGFbaxkxB9EjJ3w8IcrfLzSa53gmJgUYevi6VxL
 4sZjhiy5/Va+gEpbr5OWqwekhpHnLSFwLEZntGVvwujGJefJHL/5PSfWS1zt8d590JFROCWkHTn
 +yR9yeskNX8p11wIG8J6JYyi4KAYVKyGS2+Eqc3+M4
X-Gm-Gg: ASbGncszu5Lec7nGQ18Z60TogxyED2zxCVhf7ixyPs+WHQMbAQrmyf2g3v3UVHz0O+Z
 ciPBd+xn0Gp7XZ0RpCTisNr0gUVMUQ62O5uD1pblRD5v01r0UjBMKSBcFKTDXi795jkDY1QaPvQ
 sGy7mo3h9OQmIgrYMJSq9SsvP/MhKjNrtyMOW/1128UfIhzWfSIC4i1OXK0d8Wn9szuQy08IH9y
 gp0oAFFBUC1HEWEwCpxlh5IsABsdOPExtJZmDUB7n04uTDfi+NXCqsRckfIxheSiflh6deXyibY
 tNKQg0M71WfKejoRCvMkxBjNV5gjnw7VHYOtKWacR5e2kMGVO2RRVk2ycQwHfOsU3CHk+orQl70
 fBldKS/deetmMMX7NNmMQXfrRgbyt1VUFaMwqz96mQPA=
X-Received: by 2002:a05:6000:288c:b0:3c7:e6d0:b1b6 with SMTP id
 ffacd0b85a97d-3cbb15c9be8mr12089818f8f.9.1756481519868; 
 Fri, 29 Aug 2025 08:31:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDd0hSecw53TDIY0Eq5K2Ve1opxUjoRN2WNO7QmHlB76yVxirGLYKu0o6muX+xVYkkkKrsOw==
X-Received: by 2002:a05:6000:288c:b0:3c7:e6d0:b1b6 with SMTP id
 ffacd0b85a97d-3cbb15c9be8mr12089781f8f.9.1756481519316; 
 Fri, 29 Aug 2025 08:31:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm3911965f8f.12.2025.08.29.08.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 17/18] accel: make all calls to qemu_wait_io_event look the
 same
Date: Fri, 29 Aug 2025 17:31:14 +0200
Message-ID: <20250829153115.1590048-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
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

There is no reason for some accelerators to use qemu_wait_io_event_common
(which is separated from qemu_wait_io_event() specifically for round
robin).  They can also check for events directly on the first pass through
the loop, instead of setting cpu->exit_request to true.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/dummy-cpus.c                |  2 +-
 accel/hvf/hvf-accel-ops.c         |  2 +-
 accel/kvm/kvm-accel-ops.c         |  3 ++-
 accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++---
 accel/tcg/tcg-accel-ops-rr.c      | 43 ++++++++++++++-----------------
 target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
 target/i386/whpx/whpx-accel-ops.c |  6 ++---
 7 files changed, 30 insertions(+), 39 deletions(-)

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
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 1148ebcaae5..04012900a30 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -84,10 +84,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
-    /* process any pending work */
-    qatomic_set(&cpu->exit_request, true);
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
index e9d291dc391..28897288db7 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -211,13 +211,30 @@ static void *rr_cpu_thread_fn(void *arg)
 
     cpu = first_cpu;
 
-    /* process any pending work */
-    qatomic_set(&cpu->exit_request, true);
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
+            qatomic_set(&cpu->exit_request, false);
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
@@ -285,26 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
 
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
-
-        if (cpu) {
-            /*
-             * This could even reset exit_request for all CPUs, but in practice
-             * races between CPU exits and changes to "cpu" are so rare that
-             * there's no advantage in doing so.
-             */
-            qatomic_set(&cpu->exit_request, false);
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
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 86869f133e9..f51244740d8 100644
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
-- 
2.51.0


