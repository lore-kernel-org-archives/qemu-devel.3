Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E74CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOa-0003vq-EV; Sat, 30 Aug 2025 11:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14o-0001pd-TE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14j-0000Wh-Lh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Il9fVLSXcWcC7+/gSGPAuA02qOumhhulMbyrxn4IdXI=;
 b=i1sjlZD0E+k2N31EEm4D8v46YUfKi/yuGTDw54FQMclJxs4jnDPKIncPYo/dDCyxDWUgwk
 FqLtQQh+sfvHbk8Ix4UdXLSbwCECjBBgfOXtnmDh+5j9R3ZMGvtq3cvQrxrorVRNoiGHf2
 VFe29O4Oyc1ARAt8FNv07FHbeqZr+eg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-mXV8banKMNq69OzpXNdSpw-1; Fri, 29 Aug 2025 11:31:35 -0400
X-MC-Unique: mXV8banKMNq69OzpXNdSpw-1
X-Mimecast-MFC-AGG-ID: mXV8banKMNq69OzpXNdSpw_1756481494
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7d497abbso9698015e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481493; x=1757086293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Il9fVLSXcWcC7+/gSGPAuA02qOumhhulMbyrxn4IdXI=;
 b=E7QRrInlRAkCwCax1RFQ63rfvRBjDCqARKSLX5rNlNEtimZbP3veWNeZyavzYUsFvA
 vhCeONmW+w3tNKvspU0eu+UY77ilHfY9uvrq2FqcZofMpmVp91rnJapvODM3RP9xV2MR
 YQ+dVsSS6xEsEVQq6RRAbfPN7igdhFZz8Bq18BhoenshlNvA8CSqA7shHyA9AOad9FmS
 qHI94Tpelh70LqQ+otLxs2gfaokBCmhEUoJNof7/l+6TrNxznM9RcQ6ADeE234QtjTHn
 1e8idcqSc/d2JmpFzrhgMzx6w8zwgRLoztJL7VddFhch/UUJUsKO7S20bucXaUx4I+//
 vVJA==
X-Gm-Message-State: AOJu0YwzcYmDGXEIaeIxXNukJ+eu3wd7lqpEEi+lFYPyeffZWfcx7YXz
 gZ/NwWxDG1OYC6gAvi/mcTX2G1jB0lHvDtmNkga+joHGvzDT6xiY3b9PV/zvsUgznsf0At1q6W7
 92G4KWc+o+MGwnAu3utHzuotR1OxOoEATgmDyrNNZuygvJM6zLsyGJ/76ZCKg7IR8eNQBmnYc3F
 Bia4d1B0ofjzs71uoot2kURqoY/Cdh1peyXNi3ENJj
X-Gm-Gg: ASbGnctbTBUysjSfvVHR3AjCP2H9VMS/Uko0e5cPR/1Uy7ZKmJyeV6cDdQZ1bwLO/0g
 xCAFgxuHz8qDD7yJM0bz9QRsvoQzhVI4EcWdN45/TD87DPV6bQKGTTLhq8M1eloVHCFbQiKnI8N
 Rl3eZS/baIB6yqSf7ddTLxf8MQl6dwF9/Ek4HYCIQgSDC5yu3A3Z5Kj6REPtGnlatYk6Y9YpGeD
 5t0WNnF1eJtS2miGVv2vi7FjPbXSNduKPVVn3pR/znK+72da1rxgHeiPuRoQ1is+wum2ZOM4VT0
 u1Q2TVYM52E91oawXbbciLkovPSW2eB608oJz2O8bCo/O8uAJRUUNwsTQ+3+6aLS4Odh1rZnsHA
 XLgYSYW928nmGwr5+ajlTxATxR8iySAXG3xXy9d+ujx0=
X-Received: by 2002:a05:600c:c87:b0:45b:47e1:ef76 with SMTP id
 5b1f17b1804b1-45b517dfe11mr226904545e9.37.1756481492772; 
 Fri, 29 Aug 2025 08:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ0PgVX0P1ngjZik4srSxcKc3GT0bZbMIcmHMQfPUWXhmLJSzivFXQ/aVf8nwyqSALh/TTVQ==
X-Received: by 2002:a05:600c:c87:b0:45b:47e1:ef76 with SMTP id
 5b1f17b1804b1-45b517dfe11mr226904115e9.37.1756481492228; 
 Fri, 29 Aug 2025 08:31:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e887fdcsm43206055e9.13.2025.08.29.08.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 09/18] accel: use store_release/load_acquire for cross-thread
 exit_request
Date: Fri, 29 Aug 2025 17:31:06 +0200
Message-ID: <20250829153115.1590048-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
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

Reads and writes cpu->exit_request do not use a load-acquire/store-release
pair right now, but this means that cpu_exit() may not write cpu->exit_request
after any flags that are read by the vCPU thread.

Probably everything is protected one way or the other by the BQL, because
cpu->exit_request leads to the slow path, where the CPU thread often takes
the BQL (for example, to go to sleep by waiting on the BQL-protected
cpu->halt_cond); but it's not clear, so use load-acquire/store-release
consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c          | 19 +++++++++----------
 accel/tcg/cpu-exec.c         |  7 +++++--
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 hw/core/cpu-common.c         |  3 ++-
 target/i386/nvmm/nvmm-all.c  |  5 ++---
 target/i386/whpx/whpx-all.c  |  3 ++-
 6 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f36dfe33492..bd9e5e3886d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3029,10 +3029,6 @@ static void kvm_eat_signals(CPUState *cpu)
 
     if (kvm_immediate_exit) {
         qatomic_set(&cpu->kvm_run->immediate_exit, 0);
-        /* Write kvm_run->immediate_exit before the cpu->exit_request
-         * write in kvm_cpu_exec.
-         */
-        smp_wmb();
         return;
     }
 
@@ -3187,7 +3183,8 @@ int kvm_cpu_exec(CPUState *cpu)
         }
 
         kvm_arch_pre_run(cpu, run);
-        if (qatomic_read(&cpu->exit_request)) {
+        /* Corresponding store-release is in cpu_exit. */
+        if (qatomic_load_acquire(&cpu->exit_request)) {
             trace_kvm_interrupt_exit_request();
             /*
              * KVM requires us to reenter the kernel after IO exits to complete
@@ -3197,13 +3194,15 @@ int kvm_cpu_exec(CPUState *cpu)
             kvm_cpu_kick_self();
         }
 
-        /* Read cpu->exit_request before KVM_RUN reads run->immediate_exit.
-         * Matching barrier in kvm_eat_signals.
-         */
-        smp_rmb();
-
         run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
 
+        /*
+         * After writing cpu->exit_request, cpu_exit() sends a signal that writes
+         * kvm->run->immediate_exit.  The signal is already happening after the
+         * write to cpu->exit_request so, if KVM read kvm->run->immediate_exit
+         * as true, cpu->exit_request will always read as true.
+         */
+
         attrs = kvm_arch_post_run(cpu, run);
 
 #ifdef KVM_HAVE_MCE_INJECTION
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 508d2d2d9e2..f838535d111 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -851,8 +851,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     }
 #endif /* !CONFIG_USER_ONLY */
 
-    /* Finally, check if we need to exit to the main loop.  */
-    if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
+    /*
+     * Finally, check if we need to exit to the main loop.
+     * The corresponding store-release is in cpu_exit.
+     */
+    if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
         qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee9..1e551e92d6d 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -242,7 +242,7 @@ static void *rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
+        while (cpu && cpu_work_list_empty(cpu) && !qatomic_load_acquire(&cpu->exit_request)) {
             /* Store rr_current_cpu before evaluating cpu_can_run().  */
             qatomic_set_mb(&rr_current_cpu, cpu);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 9ea1f3764a8..ca00accd162 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -74,7 +74,8 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
 
 void cpu_exit(CPUState *cpu)
 {
-    qatomic_set(&cpu->exit_request, 1);
+    /* Ensure cpu_exec will see the reason why the exit request was set.  */
+    qatomic_store_release(&cpu->exit_request, true);
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     smp_wmb();
     qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index e1151b04c6e..10bd51d9b59 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -743,7 +743,8 @@ nvmm_vcpu_loop(CPUState *cpu)
 
         nvmm_vcpu_pre_run(cpu);
 
-        if (qatomic_read(&cpu->exit_request)) {
+        /* Corresponding store-release is in cpu_exit. */
+        if (qatomic_load_acquire(&cpu->exit_request)) {
 #if NVMM_USER_VERSION >= 2
             nvmm_vcpu_stop(vcpu);
 #else
@@ -751,8 +752,6 @@ nvmm_vcpu_loop(CPUState *cpu)
 #endif
         }
 
-        /* Read exit_request before the kernel reads the immediate exit flag */
-        smp_rmb();
         ret = nvmm_vcpu_run(mach, vcpu);
         if (ret == -1) {
             error_report("NVMM: Failed to exec a virtual processor,"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c09a0a64f22..2106c29c3a0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1714,7 +1714,8 @@ static int whpx_vcpu_run(CPUState *cpu)
         if (exclusive_step_mode == WHPX_STEP_NONE) {
             whpx_vcpu_pre_run(cpu);
 
-            if (qatomic_read(&cpu->exit_request)) {
+            /* Corresponding store-release is in cpu_exit. */
+            if (qatomic_load_acquire(&cpu->exit_request)) {
                 whpx_vcpu_kick(cpu);
             }
         }
-- 
2.51.0


