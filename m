Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D2CC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJL-0006FI-29; Fri, 08 Aug 2025 14:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJI-0006EJ-Qs
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJH-0006gC-6C
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iXq6LWl1KGiN5VNE9pg5mJWSYw365L8S6DEXN3jbo0=;
 b=Seb7ml9idCQqlOprT0jIgOjQqRHmvNMrDrYJqvEQCjmUvtXtIbtqx/vDfbFpg0VjP6s6vP
 dxya6F1gMffHqAwvAu7uSJ1fUo7AoIyYKJTkwT3wkdXCa/Lqd78keu95xl8VXMFPEP0ciN
 LBLhLNlwmqfMDT/5YHfTP6FTYE0DSGI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-v3_PJcD7M_O0XQv0rT8uhw-1; Fri, 08 Aug 2025 14:59:21 -0400
X-MC-Unique: v3_PJcD7M_O0XQv0rT8uhw-1
X-Mimecast-MFC-AGG-ID: v3_PJcD7M_O0XQv0rT8uhw_1754679560
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7886bfc16so1463224f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679559; x=1755284359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iXq6LWl1KGiN5VNE9pg5mJWSYw365L8S6DEXN3jbo0=;
 b=tAheP4z7bP25Vfts4zBxdfpZIq/uzqpSqXgcFvn8BysuAb8NCSz53yykwyO3QErb12
 /mJ6CG0C/F8k59wnFSeWAP/ilGnHasbexWSHOHdZADpknDSN8PvGs7NNEzwvNkQZxPcY
 NNlr1sHRpF6nBYuau+g7lzbWAAH0rYseKVDrqg/awyWs+fQyON/lqVnda13uCc7bldKB
 IkIt1FDmdyySmihf/2L0l+y99GNyuskDMj1Fe22Mp4chEgr+kfAmLsVs7DCrJTS9gVKu
 Q3b365xfg/+g7j5P5LdhTyLxCTld5hMU3D67tYdXpb7voc4rG3JrRYG/64D1o4epFNC3
 STVg==
X-Gm-Message-State: AOJu0YxcrWgFumA7LUfto5fJOJlYA/LxrUaAiAPN2JCBwV2+1m0BIQHx
 fF+QLudE+9duKxext1Eu2ZuzXNTvhWc/2AeA7+jOT1YJHR69bF9kMqVD89IeLj5qEl9Y75+fWa6
 jz0figldgDQqLSTy5gK1B318d7nrRWWoDyZ9arQKEUrlHndur8y1npUiZ1DebfKeogvl/uMxAQV
 fJ17G2jpBE5kKssm3pvH10qOEgABp+TL9IWLXInufA
X-Gm-Gg: ASbGncu7kojVE3CvhFQSPChTIv5Zbk5cTzgfbkrt5pmq02/7RrgDhRcbAzfciVL8CvW
 rUKnmFvMl//ga/6YWkSkAfSNNggORyUtRMXIASxB+1mO2ddArSw8Ef4uuZlEMC5RxVwzV/0Ceti
 AqoxA29NTshratY2R9REV/tgbf7JZmNpywRwCmBqKYxnq4IwMyT2eBTkt+Fvyg9ezyZOIUbWbUS
 gUIBypNS+zj2Q0nKjuHQtYVmdi78usdlN8HbpKicc8NnfUuHWjus0sN7b3hf5uM3Shi2EkkErQz
 6eeaa5qbOV5SpYMyKloNqKWlD4qAefe/vbIjbqUJvU5+
X-Received: by 2002:a05:6000:230f:b0:3b7:899c:e867 with SMTP id
 ffacd0b85a97d-3b900b805dcmr3760224f8f.59.1754679558981; 
 Fri, 08 Aug 2025 11:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDiOfCpTJWGhzTsCf7cuEsCuYlfwrsPnX0M0sgwDYvSStCWouGv9hn625lHKQ6PS6kubDDRQ==
X-Received: by 2002:a05:6000:230f:b0:3b7:899c:e867 with SMTP id
 ffacd0b85a97d-3b900b805dcmr3760210f8f.59.1754679558506; 
 Fri, 08 Aug 2025 11:59:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c470102sm30983453f8f.53.2025.08.08.11.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 4/8] accel/tcg: introduce tcg_kick_vcpu_thread
Date: Fri,  8 Aug 2025 20:59:01 +0200
Message-ID: <20250808185905.62776-5-pbonzini@redhat.com>
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

qemu_cpu_kick() does not always have to set cpu->exit_request,
though it does for now.  Introduce a function tcg_kick_vcpu_thread()
which can be changed in the future to not set cpu->exit_request,
and reserve cpu_exit() for when *all accelerators* need to set
that flag.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/tcg-icount.rst       |  2 +-
 accel/tcg/tcg-accel-ops-mttcg.h |  3 ---
 include/exec/cpu-common.h       |  1 +
 accel/tcg/cpu-exec.c            | 17 ++++++++++++++++-
 accel/tcg/tcg-accel-ops-mttcg.c |  5 -----
 accel/tcg/tcg-accel-ops-rr.c    |  2 +-
 accel/tcg/tcg-accel-ops.c       |  2 +-
 bsd-user/main.c                 |  2 +-
 linux-user/main.c               |  2 +-
 9 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
index 7df883446a7..a1dcd79e0fd 100644
--- a/docs/devel/tcg-icount.rst
+++ b/docs/devel/tcg-icount.rst
@@ -37,7 +37,7 @@ translator starts by allocating a budget of instructions to be
 executed. The budget of instructions is limited by how long it will be
 until the next timer will expire. We store this budget as part of a
 vCPU icount_decr field which shared with the machinery for handling
-cpu_exit(). The whole field is checked at the start of every
+qemu_cpu_kick(). The whole field is checked at the start of every
 translated block and will cause a return to the outer loop to deal
 with whatever caused the exit.
 
diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..5c145cc8595 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -10,9 +10,6 @@
 #ifndef TCG_ACCEL_OPS_MTTCG_H
 #define TCG_ACCEL_OPS_MTTCG_H
 
-/* kick MTTCG vCPU thread */
-void mttcg_kick_vcpu_thread(CPUState *cpu);
-
 /* start an mttcg vCPU thread */
 void mttcg_start_vcpu_thread(CPUState *cpu);
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9b658a3f48f..e843b09cc99 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -226,6 +226,7 @@ G_NORETURN void cpu_loop_exit(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
 /* accel/tcg/cpu-exec.c */
+void tcg_kick_vcpu_thread(CPUState *cpu);
 int cpu_exec(CPUState *cpu);
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4bd9ee01c19..1a973596d87 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -748,6 +748,20 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
+void tcg_kick_vcpu_thread(CPUState *cpu)
+{
+    /*
+     * Ensure cpu_exec will see the reason why the exit request was set.
+     * FIXME: this is not always needed.  Other accelerators instead
+     * read interrupt_request and set exit_request on demand from the
+     * CPU thread; see kvm_arch_pre_run() for example.
+     */
+    qatomic_store_release(&cpu->exit_request, 1);
+
+    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
+    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
+}
+
 static inline bool icount_exit_request(CPUState *cpu)
 {
     if (!icount_enabled()) {
@@ -774,7 +788,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
      * Ensure zeroing happens before reading cpu->exit_request or
-     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
+     * cpu->interrupt_request (see also store-release in
+     * tcg_kick_vcpu_thread())
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 39237421757..5757324a8c2 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -123,11 +123,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-void mttcg_kick_vcpu_thread(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 void mttcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index c06f3beef2e..87b49377c78 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -43,7 +43,7 @@ void rr_kick_vcpu_thread(CPUState *unused)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        cpu_exit(cpu);
+        tcg_kick_vcpu_thread(cpu);
     };
 }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 02c7600bb7d..f4d5372866a 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -207,7 +207,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
 
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
-        ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
+        ops->kick_vcpu_thread = tcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
         ops->create_vcpu_thread = rr_start_vcpu_thread;
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7e5d4bbce09..20159207040 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -216,7 +216,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
 
 void qemu_cpu_kick(CPUState *cpu)
 {
-    cpu_exit(cpu);
+    tcg_kick_vcpu_thread(cpu);
 }
 
 /* Assumes contents are already zeroed.  */
diff --git a/linux-user/main.c b/linux-user/main.c
index 68972f00a15..dc68fd448b7 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -192,7 +192,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
 
 void qemu_cpu_kick(CPUState *cpu)
 {
-    cpu_exit(cpu);
+    tcg_kick_vcpu_thread(cpu);
 }
 
 void task_settid(TaskState *ts)
-- 
2.50.1


