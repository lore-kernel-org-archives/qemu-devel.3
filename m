Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9AAC27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvJ-0000Hn-6R; Tue, 04 Jun 2024 05:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvH-0008Uw-1H
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvE-0002Bt-Vw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-354f14bd80cso664790f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495059; x=1718099859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4b/mmQIhvhV7OjyWLu/roxTepS1wlgLdQck8dHERJM8=;
 b=IKWP3YLAoGrG4UI1EE4h5oK4QxtI4sKI/cmB6RYVZayElu0fkmc8hsXRka2hdnQFKY
 +IKx6Si3S6dt36KPr5We+b5bdqO8wIOPSe8xuybZYl8akxnW9vxN73PPysyjGNelwpW4
 WkB8yEbrJyaQMLjpn5XhDSG+4nxsQ4rQQcW3v0MTA3gGxLiDKLPSVpoJUO8JKKJvksmF
 GQuE/tK02XEFk0Pf+zRGN8nZwUU2+BljvRrSp0Z0+qYR29yIr6ER6EujXtMUEai/iDpN
 IrhWTEjX7RfyWx+fAs4PnRgM3kypFsBGTFz9dcMms705ACbWwUhzScnDU/3ThvdMaPi6
 7z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495059; x=1718099859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4b/mmQIhvhV7OjyWLu/roxTepS1wlgLdQck8dHERJM8=;
 b=frSUFtX5eeNt105rvWCi04slqwPA3LnFC4XXpdQj+d2yzG5Lte7meQBX0npdwPNBNx
 uMVib5Q7AIv5m+D61YaVcgWriffH1YNSx8Yk1ebwMo1asMMCVX64CnKhvrrvybkKkpRC
 Q3iG+KZJVaiiW3lH49oU3DfTkYISpp6n3tsnnBDLZ2cu+lkEz1UIEZ6WC9WHwGKZGLPk
 Ted2QsXrBmETzU5E+P21SvArqNHmar02mKkfFERzRWjWAp0EDEJicq/g4dpbsDDQxazw
 fkPsWIIWk/LEKhdr3BRCmNXkuPOpTpkv/4jB8YicGdZc/WxxcdG5oZMoC7GO+fT1/os7
 EWyQ==
X-Gm-Message-State: AOJu0YzEgdRH+xlI0q4dAbd/vCeZPMfhIHRPx7uY0ZnvXqWSNGgTISZW
 0QtQZCBHeaKcKfvJxsJ933/pCzKxTrVMQIVT52SDsHaXFTLMPbYwsgtuVhaPxIlyQqLPBQSDHK5
 S
X-Google-Smtp-Source: AGHT+IEq1weK1263FRX84P+UvjTwIOfTS68wvdj7q6X/0nrfeBq8SrMAuF2Bx+d7ydu4/k4gq8lr2A==
X-Received: by 2002:a5d:5231:0:b0:35d:cb8b:bd2e with SMTP id
 ffacd0b85a97d-35e0f330f2cmr7994202f8f.67.1717495058986; 
 Tue, 04 Jun 2024 02:57:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0de3sm11096895f8f.9.2024.06.04.02.57.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/32] cpu: move Qemu[Thread|Cond] setup into common code
Date: Tue,  4 Jun 2024 11:55:52 +0200
Message-ID: <20240604095609.12285-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Aside from the round robin threads this is all common code. By
moving the halt_cond setup we also no longer need hacks to work around
the race between QOM object creation and thread creation.

It is a little ugly to free stuff up for the round robin thread but
better it deal with its own specialises than making the other
accelerators jump through hoops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240530194250.1801701-3-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index be44746d24..a2c8536943 100644
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
2.41.0


