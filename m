Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18BC25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClfy-0005dO-Fy; Thu, 30 May 2024 15:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClfw-0005cB-BP
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:43:00 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClft-0006HT-0G
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:43:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a667e104375so92875566b.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717098173; x=1717702973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cnc+k2fYpUESVUzqiNhwI1EEtv65T/mceqpj8jrBceI=;
 b=TPGsivEkah+YWZfFOWdgKXB/8asyeaKesCUHcB7OcvcQ1Yb6WnI//SMBdvamuK+k0R
 ryYMti2/NsEMavvSu2N5T4yarHy9b8YwEep3mAsDOlC2RlaNuPktzXjEa1Ib6SNQPESK
 /ULFBjb6lE3zT/nsiwYBwmGCHxAwB82Q56P9vC/Nceu5OSOapCiRDGKA8KHWdfZz88qh
 nJshlUTHHWjllyNo+HiX9umJnoOqW2FEMmWGYDnpS2rJKYU6XzfmJMM5EhSxCQiEDm5e
 hNLrK7A19MKy5fviIUVI04evcuiOt8p84jh60++Syq1HZhtRpOXcf2i4XkcJ6Az++8wg
 jBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717098173; x=1717702973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cnc+k2fYpUESVUzqiNhwI1EEtv65T/mceqpj8jrBceI=;
 b=MqghTdIEWicNxlJvTOfQyu0J5qJpBmPnN077S1m6fp4PNMAS4fAhyt7evUQd10rTlU
 4/Im7P2XBSNCGzYmWXL8FwePmJBdhMneX1xeTfyyCMT55csgUJUVx/j1+7nyUDjMU+Mu
 j8N9IGTKHMN+zWNsdNmAB1zE89P+99jFPW/ZdBGQz4+09Rvo1Zzc+SDkz9UdMw0f33w0
 GBb5udPzdvx+6a0RqHzJXI2I9fwui18sCy4ey9Pw6vzu+ruvIn2XRqDae0qtk7F0NemH
 d29Qce3vizvqawzxUOxvqr/AOzTYrci5XqL2BsBywF9ctjpAqXKXsUtZonZcs8cV8BX1
 WnpQ==
X-Gm-Message-State: AOJu0YwJZ3Vvc3j7wcNxUr1yIdPE0x7YB1HdzlolKGPuuQbS2FHtuxBM
 9pzFzKHB3pX1NkB11d3szNvCporOHaBMIM4l+X+tGlINF0PGabuonbZlB4kcuWw=
X-Google-Smtp-Source: AGHT+IFVOq8MKMEfrXxp4J5Y6CJd2GA9ZM++5hdN2jPC99fsqqvcLrmD9aX73RbTWxQdJn18BZeDlg==
X-Received: by 2002:a17:906:d1c9:b0:a67:aa2b:1032 with SMTP id
 a640c23a62f3a-a67aa2b10f1mr32855366b.28.1717098173261; 
 Thu, 30 May 2024 12:42:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea67b4f8sm7831766b.102.2024.05.30.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C35165F8E3;
 Thu, 30 May 2024 20:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 2/5] cpu: move Qemu[Thread|Cond] setup into common code
Date: Thu, 30 May 2024 20:42:47 +0100
Message-Id: <20240530194250.1801701-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530194250.1801701-1-alex.bennee@linaro.org>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Aside from the round robin threads this is all common code. By
moving the halt_cond setup we also no longer need hacks to work around
the race between QOM object creation and thread creation.

It is a little ugly to free stuff up for the round robin thread but
better it deal with its own specialises than making the other
accelerators jump through hoops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/cpu.h             |  4 ++++
 accel/dummy-cpus.c                |  3 ---
 accel/hvf/hvf-accel-ops.c         |  4 ----
 accel/kvm/kvm-accel-ops.c         |  3 ---
 accel/tcg/tcg-accel-ops-mttcg.c   |  4 ----
 accel/tcg/tcg-accel-ops-rr.c      | 14 +++++++-------
 hw/core/cpu-common.c              |  5 +++++
 target/i386/nvmm/nvmm-accel-ops.c |  3 ---
 target/i386/whpx/whpx-accel-ops.c |  3 ---
 9 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 35d345371b..a405119eda 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -404,10 +404,14 @@ struct qemu_work_item;
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU core.
+ * @thread: Host thread details, only live once @created is #true
+ * @sem: WIN32 only semaphore used only for qtest
+ * @thread_id: native thread id of vCPU, only live once @created is #true
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
  * @created: Indicates whether the CPU thread has been successfully created.
+ * @halt_cond: condition variable sleeping threads can wait on.
  * @interrupt_request: Indicates a pending interrupt request.
  * @halted: Nonzero if the CPU is in suspended state.
  * @stop: Indicates a pending stop request.
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 20519f1ea4..f32d8c8dc3 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -68,9 +68,6 @@ void dummy_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 40d4187d9d..6f1e27ef46 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -463,10 +463,6 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
      */
     assert(hvf_enabled());
 
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
-
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 94c828ac8d..c239dfc87a 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -66,9 +66,6 @@ static void kvm_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, kvm_vcpu_thread_fn,
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index c552b45b8e..49814ec4af 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -137,10 +137,6 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
     g_assert(tcg_enabled());
     tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
 
-    cpu->thread = g_new0(QemuThread, 1);
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
-
     /* create a thread per vCPU with TCG (MTTCG) */
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
              cpu->cpu_index);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 894e73e52c..84c36c1450 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -317,22 +317,22 @@ void rr_start_vcpu_thread(CPUState *cpu)
     tcg_cpu_init_cflags(cpu, false);
 
     if (!single_tcg_cpu_thread) {
-        cpu->thread = g_new0(QemuThread, 1);
-        cpu->halt_cond = g_new0(QemuCond, 1);
-        qemu_cond_init(cpu->halt_cond);
+        single_tcg_halt_cond = cpu->halt_cond;
+        single_tcg_cpu_thread = cpu->thread;
 
         /* share a single thread for all cpus with TCG */
         snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
         qemu_thread_create(cpu->thread, thread_name,
                            rr_cpu_thread_fn,
                            cpu, QEMU_THREAD_JOINABLE);
-
-        single_tcg_halt_cond = cpu->halt_cond;
-        single_tcg_cpu_thread = cpu->thread;
     } else {
-        /* we share the thread */
+        /* we share the thread, dump spare data */
+        g_free(cpu->thread);
+        qemu_cond_destroy(cpu->halt_cond);
         cpu->thread = single_tcg_cpu_thread;
         cpu->halt_cond = single_tcg_halt_cond;
+
+        /* copy the stuff done at start of rr_cpu_thread_fn */
         cpu->thread_id = first_cpu->thread_id;
         cpu->neg.can_do_io = 1;
         cpu->created = true;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 0f0a247f56..6cfc01593a 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -261,6 +261,11 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
     cpu->cflags_next_tb = -1;
 
+    /* allocate storage for thread info, initialise condition variables */
+    cpu->thread = g_new0(QemuThread, 1);
+    cpu->halt_cond = g_new0(QemuCond, 1);
+    qemu_cond_init(cpu->halt_cond);
+
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
     QSIMPLEQ_INIT(&cpu->work_list);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 6b2bfd9b9c..0ba31201e2 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -64,9 +64,6 @@ static void nvmm_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    cpu->thread = g_new0(QemuThread, 1);
-    cpu->halt_cond = g_new0(QemuCond, 1);
-    qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 189ae0f140..1a2b4e1c43 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -64,9 +64,6 @@ static void whpx_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    cpu->thread = g_new0(QemuThread, 1);
-    cpu->halt_cond = g_new0(QemuCond, 1);
-    qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
-- 
2.39.2


