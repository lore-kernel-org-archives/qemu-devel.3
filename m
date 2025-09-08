Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A14FCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsD-0001f6-5O; Mon, 08 Sep 2025 06:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs9-0001cr-6B
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs5-0000w6-KP
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JxL0mu6HG+did++z5AjqHBeKoSZ1/tUC6gKjbxSw7M=;
 b=LLIiPfFl0CJuj74MkZ3AXuyyXYi2UPkgP42Ad6V/7Jtx535pgAs+P6BaycpbciPdPAVPly
 3sAppqhXnZbupGlHsmqlboLqrOakk1doGlTOD5jfIv/Z6LrKChEmBq03cgdo+UNCF2ZrjX
 VOlarkkCOxOeue3aEleu8iiaqrF4c+g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-gZLS2OC4MaaVQmCgoCwNqw-1; Mon, 08 Sep 2025 06:13:08 -0400
X-MC-Unique: gZLS2OC4MaaVQmCgoCwNqw-1
X-Mimecast-MFC-AGG-ID: gZLS2OC4MaaVQmCgoCwNqw_1757326387
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de5fdda1aso3357935e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326386; x=1757931186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JxL0mu6HG+did++z5AjqHBeKoSZ1/tUC6gKjbxSw7M=;
 b=cE/pt8thLYjZFqSmskkD86M4atykX0xgI1dlblesN1BqAnBwpUBUOIEHnFtqTx4T01
 H0c+eUCrg+WsVX8QxXFjPpoMgJyeILbGtjsOod/RPOGuC+NKwY/LO677XkH5hJROQTyp
 TQxiIxxKglwrOF8Ip71LS+bBxm2crn+tH68iAYkcfWBCVelDn6Q6+2DotHbhTcVx4VBi
 bhjgMMcAPogH/EGVRC/Aq2GX4CIlhLIaNra6N9WA9o5cFpv46zHII/tcIKGaKKAs4KMP
 FEfiEebAbZ0or3RFSD/3vUzvOOjlrX9CnKNr6U7MWz2R+3MM04Ca4VbreDm+NTrh/Scc
 TYcg==
X-Gm-Message-State: AOJu0Yww/3E7ptovhghn/8/lSpbEM4ELenPa3AvkoFmBCJAzDDMJxSn3
 BoxHUBLLB5fq7rTp5M56uXQYHg/6QtMZiwqoY/YxFdHT2OWn6p8jfS5QbC8DJnUZpoQX7x9+cR6
 kEwRR1FI5qH2CFDJeYebYFhxk3MzwNn6zJvUTMb9wMsP6zvLxPH17HvO321h1YYYnu23yuj1kSM
 qhhTF0Q1LG4RH8zRI7VNnzIFhTeIor8oNQGgfAbckp
X-Gm-Gg: ASbGncsw5e0zHLYsPKalqE6EcuyKnSBPWn1b3M23M1keveDOLeqqXYAJLiTjqEx/DTj
 UCLxHHe8hhNjOu1rjlEYnduxR2s0aEqWhC6eQuBWmxnCXiaeU75a4WST7oKE6yPy3YqlpNH9K7Y
 Ubetv6SNFemtmeIl7qRBPBE4BwJaIYOzGMatwZXDcXuXLRsb3SrGqFhsOId57yxw/t3ZuoToaQT
 1r3WS5J3ZR8JMETO0Uc0VYx4Djr6y+9JpqcEb3o+Yrh2TrYpUPJy55qs0lW4ziIDCi6RX7ehZhF
 fkPEfzOQK4KgFJLB3YbP7Lo8M53I7lcqXiTDuIeqL3pEyqgd1CB1mS3GqefNNWB3Y1mAV7E5gC2
 q1++lSSQuiWVxorrQcXI5qUyINn7dZ9kzzahkhsyCG9Q=
X-Received: by 2002:a05:600c:1d16:b0:459:d780:3604 with SMTP id
 5b1f17b1804b1-45ddde89897mr75840615e9.3.1757326385604; 
 Mon, 08 Sep 2025 03:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFm0BetqOFBzZk+fzzdNuIQJww8nPT0Oa3fCLgeCEvHKqVxVO3DuAbACXN1ZpglRgXW6XO+g==
X-Received: by 2002:a05:600c:1d16:b0:459:d780:3604 with SMTP id
 5b1f17b1804b1-45ddde89897mr75840145e9.3.1757326385073; 
 Mon, 08 Sep 2025 03:13:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9bcda91dsm270386825e9.6.2025.09.08.03.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 09/19] accel: use store_release/load_acquire for cross-thread
 exit_request
Date: Mon,  8 Sep 2025 12:12:31 +0200
Message-ID: <20250908101241.2110068-10-pbonzini@redhat.com>
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c          | 19 +++++++++----------
 accel/tcg/cpu-exec.c         |  7 +++++--
 accel/tcg/tcg-accel-ops-rr.c | 11 +++++++++--
 hw/core/cpu-common.c         |  3 ++-
 target/i386/nvmm/nvmm-all.c  |  5 ++---
 target/i386/whpx/whpx-all.c  |  3 ++-
 6 files changed, 29 insertions(+), 19 deletions(-)

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
index 6eec5c9eee9..e8b0e370a8d 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -242,10 +242,17 @@ static void *rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
-            /* Store rr_current_cpu before evaluating cpu_can_run().  */
+        while (cpu && cpu_work_list_empty(cpu)) {
+            /*
+             * Store rr_current_cpu before evaluating cpu->exit_request.
+             * Pairs with rr_kick_next_cpu().
+             */
             qatomic_set_mb(&rr_current_cpu, cpu);
 
+            /* Pairs with store-release in cpu_exit.  */
+            if (qatomic_load_acquire(&cpu->exit_request)) {
+                break;
+            }
             current_cpu = cpu;
 
             qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 152abc9024b..42463e6258d 100644
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


