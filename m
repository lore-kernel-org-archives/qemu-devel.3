Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34F2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4MvS-0000wz-BQ; Thu, 02 Oct 2025 13:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Muu-0000m2-8a
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Muf-0005lH-QS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jql7MUxN6DyQAt65oei9CU9WqI9qc1PVKDanIBuSZI=;
 b=OhAF0yBuTthfJSdXIvYVCYniP/qqODuOwVUvucMUwDMSJzJiW38R4efkHelffLRLKInx5F
 oKuDboqTbB6LaJbym/2qEfzHHl9SQk06dI07G9/QeFlgDopDg8ww0Dp2VQsUGoLknnYiPq
 hfALZgQutfzVKFVDKviPY2et5PiLSeI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-bHoYzL4FORGmWIQNMMTuBg-1; Thu, 02 Oct 2025 13:16:08 -0400
X-MC-Unique: bHoYzL4FORGmWIQNMMTuBg-1
X-Mimecast-MFC-AGG-ID: bHoYzL4FORGmWIQNMMTuBg_1759425367
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3c72638b5dso112784866b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425366; x=1760030166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jql7MUxN6DyQAt65oei9CU9WqI9qc1PVKDanIBuSZI=;
 b=ZclnO8W3jH1xCWsWWh4fLf4RPBXKp/g3dcJXNc2mWd6CRPM39GX/I2kzWVMSvQ3V1y
 mhJwuUxxweSG8TK9OoqneSwddaqlEvoXq+H9PLPhyZR0tMpWTRxr1lAhXpdeo28zEgYO
 S5/ZE14UisHOYFrCHjuZODapJ8/r1nS/wYzbwtg+SQOatT1n0S2dJQYgoJ3nYYwLwdLS
 sRENxsrUZoTM16gzs8mgTzuDghblLuXroN5BKTkU6s29BH34zGrVWNqPibdtGyxkMc41
 0J2VIe6Uih7FdWeWjlkb4SywSujvDSOqoaCaulAHNq2Q/1jF+jpqU8XqVDNcwjd4DS+j
 9xoA==
X-Gm-Message-State: AOJu0YxGOhUgGBL5bkCTZk6JWa2o+lwKGU8HBQbN2oCzAJRYYZC6UrEm
 2VBlfO0LMVh6fNYW+rHWLbUGa1l+kOXovm7hJNiMkAoBaYmQ6R1QZSe5Dilu9YQ80sRl6FSt6pr
 luE/T6Ay/hiPBav1FT2tgMQtatFfzy/LWTd0ucYQIP7s82wkDnrW5BNetpPQpfZv4L9p2z/u7cH
 NxGaAI4G+Whv4toUbwyXe4WwsZlLfY85CElTukD3fX
X-Gm-Gg: ASbGnctelyWowGtg84YNeXYuirxgyxaPWBjsVQqWsb5acFwLs2hY1teaJfznzjTy10A
 3329bRcWU0MTmefWi5q7RAUuzztbgu9NzNlJ3O4f3okOgDM9DPmEQgqWWXhwxzNSHcCzEHrd5Yx
 21sDR4+W0dx1AqazFeqQCLKEtFNAecmHuH7ZR6z/ny+Jdu0V41ph4kg8K4i3tVEw6/SGp2WzUeg
 01MsdEzyHSgc5rxqP88cXr9kajwkiTdmJ88TUsIsLpxpo3vJM2NSKd/bOSYey9QPRrEHhhcvmWg
 VxwKcPexgaKIZpCR34j/BVUCZDwOiFtXJMMSJTMHlV463CY0/NzM3gsoX3XqFxeTGe2V/D6W9zH
 MzNHvasBNWrE8li8FTUPvGrOJemxgiDeExoCH14UOm19zXULH
X-Received: by 2002:a17:907:7fa8:b0:b47:c1d9:519e with SMTP id
 a640c23a62f3a-b49c3350328mr21105966b.64.1759425366036; 
 Thu, 02 Oct 2025 10:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM1JTPjWdwoqqaG3tSRITNXF9p1FAxqDFJ0d7MFt7B+y8c3hgS3HgiUJ0uhDhHVqsKkDfcNw==
X-Received: by 2002:a17:907:7fa8:b0:b47:c1d9:519e with SMTP id
 a640c23a62f3a-b49c3350328mr21101466b.64.1759425365390; 
 Thu, 02 Oct 2025 10:16:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63788100129sm2228666a12.24.2025.10.02.10.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 10/27] accel/mshv: Add vCPU creation and execution loop
Date: Thu,  2 Oct 2025 19:15:19 +0200
Message-ID: <20251002171536.1460049-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


