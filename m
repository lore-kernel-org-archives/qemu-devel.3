Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F33CAC583
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsa-0001uq-H3; Mon, 08 Sep 2025 06:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsV-0001u3-1m
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsL-0000zk-5s
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FBfbeW/bflO49mLQZHyXRm3QyIf16LzEEIoDWnaeYA=;
 b=B+8ya+cRz+VpVepFT3Vv9sQu0INP/2F3cHB/q8GxQmQQ4mmUeDelhHAssksioj7w1JgAmP
 SbRqXci0bsHpW5WOFx6JyfEFRGI3/EbxPpJXXM5LsCMedoMM5LHP5pO2hAemYIDXW1LOyt
 FR49yjDh799JME5Z7VsgUGzYEQCXX68=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Rj8YtlReNKaT1fBNVgNVMg-1; Mon, 08 Sep 2025 06:13:22 -0400
X-MC-Unique: Rj8YtlReNKaT1fBNVgNVMg-1
X-Mimecast-MFC-AGG-ID: Rj8YtlReNKaT1fBNVgNVMg_1757326401
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3d3d2472b92so2323191f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326400; x=1757931200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FBfbeW/bflO49mLQZHyXRm3QyIf16LzEEIoDWnaeYA=;
 b=NOCvN/teHIF3LvL3F2swrGdomcgzVCv1Lln1t4myHCFqB7niPgD2Q4VP97k8fTkJkG
 sOZvy7P56sHAsJph/rD/t4KwspGkAWHVqZncH8XsKP/mx164agQouhA8zKBSB8brxKGA
 13dE1LuHReAdJRmgfDFS7Pv7kyOAz5sANFUseG2ocGFay0i+P6EuClfRy1w3KX8s8HaK
 kjxJDQTarW8GrmjNZYAnMrinBE/CaOMhJpnxfUgEDWLVPKUNjqaKI8CNgHF2CgHFvIxm
 bDGXRtWSisrSS6px/GrkZeBvK0xUpd2DUa6YxjVFOR1gIgji1LS3CIKlmoeZ/DpAmmQH
 1suA==
X-Gm-Message-State: AOJu0YzFpP8CtBDSO5GrE026lAVGCTmpY5Ft+Ga35SCoANw1/4MAKIcP
 lDLtgJroxiXXEdmFvYL8NnynGtdhjaL49WeB2Tez84Hc0sGC7JZ3Ucl9ZbfLJSpiJVKcczNhMHI
 c1nGGdUsOGkh/hDL4BiJKlOjhjuLQOuYIifFeh1FyA7mwSdoseQtDp29f8UE5NKMXJHUf1rtrPx
 gyUuC53mg2jvZN55Me/0zNq8mFx1oqOdb00t5QD+rh
X-Gm-Gg: ASbGnctSZjmY3JrDCQuivbIuGR2hYPiNpZ+aft1ynTqPyBxSzr5MJbSOrTIwICDqoBS
 vdadKuU1AkbvsD+yPU2FJJ8rWcwSSYa7AoR3du99JPDh3HdZEZv49IGGDmSt05Pd8fU1E6PCT/9
 dCkUDOkodk7QCNgiimI1qAZgOc/DwPloQjz3W8kbzkGFL1FJwXzekrUxUDKGl8EZ4U+WifGfNja
 ZAAHUzNYwZHmN39hITTVV0wZyQ9EmsV4QFOXv+GCqlyRK/BswdUGA/ieBQKZh/roaBsJUJO5blu
 L/tT0AEaUO+ZjvAwD6yCz2NiE1XqX+4lS7sTyhhYUTivdTJy4yYw0o6iuzXyK1cTh9ZsZ4tF3PE
 Uzn17rIR9B5PNxbWoLK/+vjafBYHi3KkMOSbPlvY750o=
X-Received: by 2002:a05:6000:40db:b0:3dc:eb5:503b with SMTP id
 ffacd0b85a97d-3e64cc62ff0mr7321730f8f.56.1757326399757; 
 Mon, 08 Sep 2025 03:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrFY3aqEX7kFKEcD2VLRVHo7Gc2EfYAGCOyIc+1my4e3LyXglW+oZG6E7Yzm+WfGwFHt4chA==
X-Received: by 2002:a05:6000:40db:b0:3dc:eb5:503b with SMTP id
 ffacd0b85a97d-3e64cc62ff0mr7321679f8f.56.1757326399130; 
 Mon, 08 Sep 2025 03:13:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f30fe02sm506873265e9.18.2025.09.08.03.13.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/19] cpus: properly kick CPUs out of inner execution loop
Date: Mon,  8 Sep 2025 12:12:36 +0200
Message-ID: <20250908101241.2110068-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that cpu_exit() actually kicks all accelerators, use it whenever
the message to another thread is processed in qemu_wait_io_event().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-common.c                | 3 ++-
 hw/ppc/ppc.c                | 2 ++
 hw/ppc/spapr_hcall.c        | 7 +++----
 hw/ppc/spapr_rtas.c         | 2 +-
 replay/replay-events.c      | 3 ++-
 system/cpu-timers.c         | 6 +++---
 system/cpus.c               | 5 +++--
 target/arm/tcg/mte_helper.c | 2 +-
 target/i386/kvm/hyperv.c    | 1 -
 9 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/cpu-common.c b/cpu-common.c
index ef5757d23bf..152661df8e9 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -137,7 +137,8 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     wi->done = false;
     qemu_mutex_unlock(&cpu->work_mutex);
 
-    qemu_cpu_kick(cpu);
+    /* exit the inner loop and reach qemu_wait_io_event_common().  */
+    cpu_exit(cpu);
 }
 
 void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 43d0d0e7553..3e436c70413 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -190,6 +190,7 @@ static void ppc970_set_irq(void *opaque, int pin, int level)
             if (level) {
                 trace_ppc_irq_cpu("stop");
                 cs->halted = 1;
+                cpu_exit(cs);
             } else {
                 trace_ppc_irq_cpu("restart");
                 cs->halted = 0;
@@ -386,6 +387,7 @@ static void ppc40x_set_irq(void *opaque, int pin, int level)
             if (level) {
                 trace_ppc_irq_cpu("stop");
                 cs->halted = 1;
+                cpu_exit(cs);
             } else {
                 trace_ppc_irq_cpu("restart");
                 cs->halted = 0;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 51875e32a09..c594d4b916e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -509,8 +509,8 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
-        qatomic_set(&cs->exit_request, true);
         ppc_maybe_interrupt(env);
+        cpu_exit(cs);
     }
 
     return H_SUCCESS;
@@ -531,8 +531,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
     }
     cs->halted = 1;
     cs->exception_index = EXCP_HALTED;
-    qatomic_set(&cs->exit_request, true);
     ppc_maybe_interrupt(&cpu->env);
+    cpu_exit(cs);
 
     return H_SUCCESS;
 }
@@ -624,8 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     cs->exception_index = EXCP_YIELD;
-    qatomic_set(&cs->exit_request, true);
-    cpu_loop_exit(cs);
+    cpu_exit(cs);
 
     return H_SUCCESS;
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 78309dbb09d..143bc8c3794 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -221,7 +221,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
     cs->halted = 1;
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     kvmppc_set_reg_ppc_online(cpu, 0);
-    qemu_cpu_kick(cs);
+    cpu_exit(cs);
 }
 
 static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spapr,
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 8959da9f1fa..a96e47e7740 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -118,7 +118,8 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 
     g_assert(replay_mutex_locked());
     QTAILQ_INSERT_TAIL(&events_list, event, events);
-    qemu_cpu_kick(first_cpu);
+    /* Kick the TCG thread out of tcg_cpu_exec().  */
+    cpu_exit(first_cpu);
 }
 
 void replay_bh_schedule_event(QEMUBH *bh)
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index cb35fa62b8a..9919b46230f 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -246,14 +246,14 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 
     if (qemu_in_vcpu_thread()) {
         /*
-         * A CPU is currently running; kick it back out to the
+         * A CPU is currently running; send it out of the
          * tcg_cpu_exec() loop so it will recalculate its
          * icount deadline immediately.
          */
-        qemu_cpu_kick(current_cpu);
+        cpu_exit(current_cpu);
     } else if (first_cpu) {
         /*
-         * qemu_cpu_kick is not enough to kick a halted CPU out of
+         * cpu_exit() is not enough to kick a halted CPU out of
          * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
          * causes cpu_thread_is_idle to return false.  This way,
          * handle_icount_deadline can run.
diff --git a/system/cpus.c b/system/cpus.c
index 9bfbe2b0607..bb13942cbb7 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -604,7 +604,7 @@ void cpu_pause(CPUState *cpu)
         qemu_cpu_stop(cpu, true);
     } else {
         cpu->stop = true;
-        qemu_cpu_kick(cpu);
+        cpu_exit(cpu);
     }
 }
 
@@ -644,6 +644,7 @@ void pause_all_vcpus(void)
 
     while (!all_vcpus_paused()) {
         qemu_cond_wait(&qemu_pause_cond, &bql);
+        /* FIXME: is this needed? */
         CPU_FOREACH(cpu) {
             qemu_cpu_kick(cpu);
         }
@@ -672,7 +673,7 @@ void cpu_remove_sync(CPUState *cpu)
 {
     cpu->stop = true;
     cpu->unplug = true;
-    qemu_cpu_kick(cpu);
+    cpu_exit(cpu);
     bql_unlock();
     qemu_thread_join(cpu->thread);
     bql_lock();
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 0efc18a181e..302e899287c 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -591,7 +591,7 @@ static void mte_async_check_fail(CPUARMState *env, uint64_t dirty_ptr,
      * which is rather sooner than "normal".  But the alternative
      * is waiting until the next syscall.
      */
-    qemu_cpu_kick(env_cpu(env));
+    cpu_exit(env_cpu(env));
 #endif
 }
 
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 9865120cc43..f7a81bd2700 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -81,7 +81,6 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
          * necessary because memory hierarchy is being changed
          */
         async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
-        cpu_exit(CPU(cpu));
 
         return EXCP_INTERRUPT;
     case KVM_EXIT_HYPERV_HCALL: {
-- 
2.51.0


