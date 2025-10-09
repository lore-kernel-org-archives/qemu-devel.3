Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABECCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQm-0008Oj-4x; Thu, 09 Oct 2025 03:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQj-0008KH-Um
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQa-0004Pj-85
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jql7MUxN6DyQAt65oei9CU9WqI9qc1PVKDanIBuSZI=;
 b=WhIoQO2m3OBenNCvbGV4B8uLTFLnxR2L40mKtOMu5CqIoawKOwO8ebIu1nD9xnEY8dZ1AS
 J1d7IMnqiTxHZh+hIzjWl9jJgw8pAuqsJS0+U5wOg/tXSqGtFb6w+RbeBi/1RhDiT4ZMEv
 zXay2YBF/ISN7R7ZvtMWz+AwZzc0y2I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-1Uxvgyj1NyyEBApO9SPepQ-1; Thu, 09 Oct 2025 03:51:05 -0400
X-MC-Unique: 1Uxvgyj1NyyEBApO9SPepQ-1
X-Mimecast-MFC-AGG-ID: 1Uxvgyj1NyyEBApO9SPepQ_1759996265
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e7a2c3773so7856585e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996263; x=1760601063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jql7MUxN6DyQAt65oei9CU9WqI9qc1PVKDanIBuSZI=;
 b=ObteTb/HQOeOS7J4WCy0F2HpHmllxn4ZLR0ggPuKFM79m1PWu9WN/dZVpZjp8+SNty
 Ej+7YkNNDZ/XdrSiWGH4A4nE+gqG0mW/l1GWkhPblfHL9a/+55xTBwhhXVsDhwv3gB8n
 2d+tWXwVBrj0sB/ERuYoda9ILpM3SQrMva7BnvzKO3KGxVyTDzHg3df7W5rrwDe52sak
 lCTNUEVtoPZ7tfPe/8JAB6bJt5WhpR9BBh/p/5CY9hITkvjUoRDf3FMbyyOQyq8f1n4O
 aCJ8y4KToRU4+PqDlcAPMILp4ajm7WDtQMP9yqaLM/sKonqrnoPL9cTOmY13WG1X7e/O
 aEow==
X-Gm-Message-State: AOJu0Yx1ZaRE6Cl56F1OJ/d22sFEpIFRVkF4IfoYt+8fIhiphjrBb6Fq
 9sDvU9RzJGGrd16BjxYCJcISfQmOD3TRaRxbQoQoVpBfX/FeGjocwumfxdVtwx0pYyXWhBJWNTj
 e+TxbYOfZ6xM1oXG9KM2UKMdSEpFx3DGNM8zIiYqpXsWJeFHlx253JgAmWnFUHhIW0vHKIdRXT1
 wpyQOhDFtSSVHzRt3DMYjoiLT3IBM9pEd9NENKgXGD3wY=
X-Gm-Gg: ASbGnctqeN1dG8LdSO3fdFrQ59rY6ZOS/kYXHjCYtoMGoZIbcvbFQmem4ejrLLJrnQA
 utgcQysTyAB1+D2fTrsvBJKNQqiscBJ975RfwjQ7MI/PshHGS4Hr44V3kesSxgnHx0qRHwcmfdf
 7nJY0phVGMN1kHL9NrQ644cd3gFR3XkzuxRP8Qp872FiY0/gnRehqMawouO11TZTnWT0qEQNPzw
 6ksIp+iPFGMKbTMPF7zFwNmrm+hR4fXgmAiXOsjl850gaP176SHJ37dm3kR5LDkMTi57bedL0kp
 EC0vOYdMmMAjLz1qNuWAYzGErpmow3OxZRkwq3nSX37Uolg7IEpm1vHlqTada4bXYOd+RX3Nnu3
 JRafnvCjpptu9uV7g5af4AKyrVq4tq3oUcdKNdBSzJrS/thc0
X-Received: by 2002:a05:6000:2386:b0:425:6fb5:2ad4 with SMTP id
 ffacd0b85a97d-425829e78f4mr6787994f8f.15.1759996263044; 
 Thu, 09 Oct 2025 00:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/09Lu9aEGppm7HeredNwct2rqsEPCktxM0aQDFNI66hpR08C76DkfP/ogl+xXjG0GTWyUXg==
X-Received: by 2002:a05:6000:2386:b0:425:6fb5:2ad4 with SMTP id
 ffacd0b85a97d-425829e78f4mr6787968f8f.15.1759996262435; 
 Thu, 09 Oct 2025 00:51:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b8bsm33340575f8f.4.2025.10.09.00.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 16/35] accel/mshv: Add vCPU creation and execution loop
Date: Thu,  9 Oct 2025 09:50:06 +0200
Message-ID: <20251009075026.505715-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Create MSHV vCPUs using MSHV_CREATE_VP and initialize their state.
Register the MSHV CPU execution loop loop with the QEMU accelerator
framework to enable guest code execution.

The target/i386 functionality is still mostly stubbed out and will be
populated in a later commit in this series.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-11-magnuskulke@linux.microsoft.com
[Fix g_free/g_clear_pointer confusion; rename qemu_wait_io_event;
 mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h       |   2 +-
 include/system/mshv_int.h   |  20 ++++
 accel/mshv/mshv-all.c       | 186 +++++++++++++++++++++++++++++++++---
 target/i386/mshv/mshv-cpu.c |  63 ++++++++++++
 accel/mshv/trace-events     |   2 +
 5 files changed, 260 insertions(+), 13 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 1011e81df47..bbc42f4dc3a 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -41,7 +41,7 @@ extern bool mshv_allowed;
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
 #else /* CONFIG_MSHV_IS_POSSIBLE */
 #define mshv_enabled() false
-#define mshv_msi_via_irqfd_enabled() false
+#define mshv_msi_via_irqfd_enabled() mshv_enabled()
 #endif
 
 typedef struct MshvState MshvState;
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index b36124a0ea7..fb80f69772b 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_MSHV_INT_H
 #define QEMU_MSHV_INT_H
 
+typedef struct hyperv_message hv_message;
+
 struct AccelCPUState {
     int cpufd;
     bool dirty;
@@ -44,6 +46,24 @@ typedef struct MshvMsiControl {
     GHashTable *gsi_routes;
 } MshvMsiControl;
 
+#define mshv_vcpufd(cpu) (cpu->accel->cpufd)
+
+/* cpu */
+typedef enum MshvVmExit {
+    MshvVmExitIgnore   = 0,
+    MshvVmExitShutdown = 1,
+    MshvVmExitSpecial  = 2,
+} MshvVmExit;
+
+void mshv_init_mmio_emu(void);
+int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
+void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
+int mshv_load_regs(CPUState *cpu);
+int mshv_store_regs(CPUState *cpu);
+int mshv_arch_put_registers(const CPUState *cpu);
+void mshv_arch_init_vcpu(CPUState *cpu);
+void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_post_init_vm(int vm_fd);
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 653195c57c9..e02421d79d4 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -393,6 +393,24 @@ int mshv_hvcall(int fd, const struct mshv_root_hvcall *args)
     return ret;
 }
 
+static int mshv_init_vcpu(CPUState *cpu)
+{
+    int vm_fd = mshv_state->vm;
+    uint8_t vp_index = cpu->cpu_index;
+    int ret;
+
+    mshv_arch_init_vcpu(cpu);
+    cpu->accel = g_new0(AccelCPUState, 1);
+
+    ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    cpu->accel->dirty = true;
+
+    return 0;
+}
 
 static int mshv_init(AccelState *as, MachineState *ms)
 {
@@ -415,6 +433,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
         return -1;
     }
 
+    mshv_init_mmio_emu();
+
     mshv_init_msicontrol();
 
     ret = create_vm(mshv_fd, &vm_fd);
@@ -444,40 +464,182 @@ static int mshv_init(AccelState *as, MachineState *ms)
     return 0;
 }
 
+static int mshv_destroy_vcpu(CPUState *cpu)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vm_fd = mshv_state->vm;
+
+    mshv_remove_vcpu(vm_fd, cpu_fd);
+    mshv_vcpufd(cpu) = 0;
+
+    mshv_arch_destroy_vcpu(cpu);
+    g_clear_pointer(&cpu->accel, g_free);
+    return 0;
+}
+
+static int mshv_cpu_exec(CPUState *cpu)
+{
+    hv_message mshv_msg;
+    enum MshvVmExit exit_reason;
+    int ret = 0;
+
+    bql_unlock();
+    cpu_exec_start(cpu);
+
+    do {
+        if (cpu->accel->dirty) {
+            ret = mshv_arch_put_registers(cpu);
+            if (ret) {
+                error_report("Failed to put registers after init: %s",
+                              strerror(-ret));
+                ret = -1;
+                break;
+            }
+            cpu->accel->dirty = false;
+        }
+
+        ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
+        if (ret < 0) {
+            error_report("Failed to run on vcpu %d", cpu->cpu_index);
+            abort();
+        }
+
+        switch (exit_reason) {
+        case MshvVmExitIgnore:
+            break;
+        default:
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+    } while (ret == 0);
+
+    cpu_exec_end(cpu);
+    bql_lock();
+
+    if (ret < 0) {
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
+
+    return ret;
+}
+
+static void *mshv_vcpu_thread(void *arg)
+{
+    CPUState *cpu = arg;
+    int ret;
+
+    rcu_register_thread();
+
+    bql_lock();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id = qemu_get_thread_id();
+    current_cpu = cpu;
+    ret = mshv_init_vcpu(cpu);
+    if (ret < 0) {
+        error_report("Failed to init vcpu %d", cpu->cpu_index);
+        goto cleanup;
+    }
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        qemu_process_cpu_events(cpu);
+        if (cpu_can_run(cpu)) {
+            mshv_cpu_exec(cpu);
+        }
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    mshv_destroy_vcpu(cpu);
+cleanup:
+    cpu_thread_signal_destroyed(cpu);
+    bql_unlock();
+    rcu_unregister_thread();
+    return NULL;
+}
+
 static void mshv_start_vcpu_thread(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+
+    qemu_cond_init(cpu->halt_cond);
+
+    trace_mshv_start_vcpu_thread(thread_name, cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, mshv_vcpu_thread, cpu,
+                       QEMU_THREAD_JOINABLE);
+}
+
+static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    int ret = mshv_arch_put_registers(cpu);
+    if (ret < 0) {
+        error_report("Failed to put registers after init: %s", strerror(-ret));
+        abort();
+    }
+
+    cpu->accel->dirty = false;
 }
 
 static void mshv_cpu_synchronize_post_init(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    run_on_cpu(cpu, do_mshv_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
 static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    int ret = mshv_arch_put_registers(cpu);
+    if (ret) {
+        error_report("Failed to put registers after reset: %s",
+                     strerror(-ret));
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
+    cpu->accel->dirty = false;
+}
+
+static void do_mshv_cpu_synchronize_pre_loadvm(CPUState *cpu,
+                                               run_on_cpu_data arg)
+{
+    cpu->accel->dirty = true;
 }
 
 static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    run_on_cpu(cpu, do_mshv_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
+}
+
+static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
+{
+    if (!cpu->accel->dirty) {
+        int ret = mshv_load_regs(cpu);
+        if (ret < 0) {
+            error_report("Failed to load registers for vcpu %d",
+                         cpu->cpu_index);
+
+            cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+            vm_stop(RUN_STATE_INTERNAL_ERROR);
+        }
+
+        cpu->accel->dirty = true;
+    }
 }
 
 static void mshv_cpu_synchronize(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    if (!cpu->accel->dirty) {
+        run_on_cpu(cpu, do_mshv_cpu_synchronize, RUN_ON_CPU_NULL);
+    }
 }
 
 static bool mshv_cpus_are_resettable(void)
 {
-    error_report("unimplemented");
-    abort();
+    return false;
 }
 
 static void mshv_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index de0c26bc6c6..02d71ebc14a 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -22,15 +22,78 @@
 #include "hw/hyperv/hvgdk_mini.h"
 #include "hw/hyperv/hvhdk_mini.h"
 
+#include "cpu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
+#include "emulate/x86_flags.h"
+
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
+int mshv_store_regs(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+int mshv_load_regs(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+int mshv_arch_put_registers(const CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features)
 {
     features->access_guest_idle_reg = 1;
 }
 
+int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+void mshv_remove_vcpu(int vm_fd, int cpu_fd)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+void mshv_init_mmio_emu(void)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+void mshv_arch_init_vcpu(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    env->emu_mmio_buf = g_new(char, 4096);
+}
+
+void mshv_arch_destroy_vcpu(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    g_clear_pointer(&env->emu_mmio_buf, g_free);
+}
+
 /*
  * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
  * fault to the guest if it tries to access it. It is possible to override
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index 6130c4abf8a..a4dffeb24a3 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -3,6 +3,8 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+mshv_start_vcpu_thread(const char* thread, uint32_t cpu) "thread=%s cpu_index=%d"
+
 mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "add=%d gpa=0x%" PRIx64 " size=0x%" PRIx64 " user=0x%" PRIx64 " readonly=%d result=%d"
 mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" PRIx64 " size=%d data=0x%x"
 mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" PRIx64 " size=%d data=0x%x"
-- 
2.51.0


