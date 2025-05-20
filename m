Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAED5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLC8-000883-0U; Tue, 20 May 2025 07:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLC6-00087T-Mn
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:38 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLC4-0001Gu-AG
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:38 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5393A2025361;
 Tue, 20 May 2025 04:31:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5393A2025361
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740695;
 bh=rjaMozCY7aAP+h5o2ienXRkjPeskhSPlvOqqoCYivHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AcSKe1/DT4Sjme3P5P1L9Qn2yH690YZb95BNprvjAnETQDXUzsKcYiRkjq9HIQLJm
 YoR1EWL2QiGns8FzLt4qntpBtoMaGCtn7cDwnRODCAj2sKLItb8xjomMxeP3g2eajP
 mljuMSmBmd72ko6oB7zayAijilNhEd4jqon2lQto=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 08/25] accel/mshv: Initialize VM partition
Date: Tue, 20 May 2025 13:30:01 +0200
Message-Id: <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Create the MSHV virtual machine by opening a partition and issuing
the necessary ioctl to initialize it. This sets up the basic VM
structure and initial configuration used by MSHV to manage guest state.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c        | 204 +++++++++++++++++++++++++++++++++++
 accel/mshv/trace-events      |   3 +
 accel/mshv/trace.h           |   1 +
 include/system/mshv.h        |   6 ++
 meson.build                  |   1 +
 target/i386/mshv/meson.build |   1 +
 target/i386/mshv/mshv-cpu.c  |  73 +++++++++++++
 7 files changed, 289 insertions(+)
 create mode 100644 accel/mshv/trace-events
 create mode 100644 accel/mshv/trace.h
 create mode 100644 target/i386/mshv/mshv-cpu.c

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 63b0eca1fc..95f1008a48 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -48,6 +48,178 @@ bool mshv_allowed;
 
 MshvState *mshv_state;
 
+static int init_mshv(int *mshv_fd)
+{
+    int fd = open("/dev/mshv", O_RDWR | O_CLOEXEC);
+    if (fd < 0) {
+        error_report("Failed to open /dev/mshv: %s", strerror(errno));
+        return -1;
+    }
+	*mshv_fd = fd;
+	return 0;
+}
+
+/* freeze 1 to pause, 0 to resume */
+static int set_time_freeze(int vm_fd, int freeze)
+{
+    int ret;
+
+    if (freeze != 0 && freeze != 1) {
+        error_report("Invalid time freeze value");
+        return -1;
+    }
+
+    struct hv_input_set_partition_property in = {0};
+    in.property_code = HV_PARTITION_PROPERTY_TIME_FREEZE;
+    in.property_value = freeze;
+
+    struct mshv_root_hvcall args = {0};
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set time freeze");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int pause_vm(int vm_fd)
+{
+    int ret;
+
+    ret = set_time_freeze(vm_fd, 1);
+    if (ret < 0) {
+        error_report("Failed to pause partition: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int resume_vm(int vm_fd)
+{
+    int ret;
+
+    ret = set_time_freeze(vm_fd, 0);
+    if (ret < 0) {
+        error_report("Failed to resume partition: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int create_partition(int mshv_fd, int *vm_fd)
+{
+    int ret;
+    struct mshv_create_partition args = {0};
+
+    /* Initialize pt_flags with the desired features */
+    uint64_t pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
+                        (1ULL << MSHV_PT_BIT_X2APIC) |
+                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES);
+
+    /* Set default isolation type */
+    uint64_t pt_isolation = MSHV_PT_ISOLATION_NONE;
+
+    args.pt_flags = pt_flags;
+    args.pt_isolation = pt_isolation;
+
+    ret = ioctl(mshv_fd, MSHV_CREATE_PARTITION, &args);
+    if (ret < 0) {
+        error_report("Failed to create partition: %s", strerror(errno));
+        return -1;
+    }
+
+    *vm_fd = ret;
+    return 0;
+}
+
+static int set_synthetic_proc_features(int vm_fd)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    union hv_partition_synthetic_processor_features features = {0};
+
+    /* Access the bitfield and set the desired features */
+    features.hypervisor_present = 1;
+    features.hv1 = 1;
+    features.access_partition_reference_counter = 1;
+    features.access_synic_regs = 1;
+    features.access_synthetic_timer_regs = 1;
+    features.access_partition_reference_tsc = 1;
+    features.access_frequency_regs = 1;
+    features.access_intr_ctrl_regs = 1;
+    features.access_vp_index = 1;
+    features.access_hypercall_regs = 1;
+    features.tb_flush_hypercalls = 1;
+    features.synthetic_cluster_ipi = 1;
+    features.direct_synthetic_timers = 1;
+
+    mshv_arch_amend_proc_features(&features);
+
+    in.property_code = HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES;
+    in.property_value = features.as_uint64[0];
+
+    struct mshv_root_hvcall args = {0};
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    trace_mshv_hvcall_args("synthetic_proc_features", args.code, args.in_sz);
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set synthethic proc features");
+        return -errno;
+    }
+    return 0;
+}
+
+static int initialize_vm(int vm_fd)
+{
+    int ret = ioctl(vm_fd, MSHV_INITIALIZE_PARTITION);
+    if (ret < 0) {
+        error_report("Failed to initialize partition: %s", strerror(errno));
+        return -1;
+    }
+    return 0;
+}
+
+static int create_vm(int mshv_fd)
+{
+    int vm_fd;
+
+    int ret = create_partition(mshv_fd, &vm_fd);
+    if (ret < 0) {
+        close(mshv_fd);
+        return -errno;
+    }
+
+    ret = set_synthetic_proc_features(vm_fd);
+    if (ret < 0) {
+        return -errno;
+    }
+
+    ret = initialize_vm(vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    ret = mshv_arch_post_init_vm(vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    /* Always create a frozen partition */
+    pause_vm(vm_fd);
+
+    return vm_fd;
+}
 
 static void mem_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
@@ -96,22 +268,54 @@ static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
         }
     }
 }
+static void mshv_reset(void *param)
+{
+    warn_report("mshv reset");
+}
+
+int mshv_hvcall(int mshv_fd, const struct mshv_root_hvcall *args)
+{
+    int ret = 0;
+
+    ret = ioctl(mshv_fd, MSHV_ROOT_HVCALL, args);
+    if (ret < 0) {
+        error_report("Failed to perform hvcall: %s", strerror(errno));
+        return -1;
+    }
+    return ret;
+}
 
 
 static int mshv_init(MachineState *ms)
 {
     MshvState *s;
+    int mshv_fd, ret;
+
     s = MSHV_STATE(ms->accelerator);
 
     accel_blocker_init();
 
     s->vm = 0;
 
+    ret = init_mshv(&mshv_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    do {
+        int vm_fd = create_vm(mshv_fd);
+        s->vm = vm_fd;
+    } while (!s->vm);
+
+    resume_vm(s->vm);
+
     s->nr_as = 1;
     s->as = g_new0(MshvAddressSpace, s->nr_as);
 
     mshv_state = s;
 
+    qemu_register_reset(mshv_reset, NULL);
+
     register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
                                   0, "mshv-memory");
     memory_listener_register(&mshv_io_listener, &address_space_io);
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
new file mode 100644
index 0000000000..f99e8c5a41
--- /dev/null
+++ b/accel/mshv/trace-events
@@ -0,0 +1,3 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+mshv_hvcall_args(const char* hvcall, uint16_t code, uint16_t in_sz) "built args for '%s' code: %d in_sz: %d"
diff --git a/accel/mshv/trace.h b/accel/mshv/trace.h
new file mode 100644
index 0000000000..da5b40cd24
--- /dev/null
+++ b/accel/mshv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-accel_mshv.h"
diff --git a/include/system/mshv.h b/include/system/mshv.h
index b93cf027d8..398cda3254 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -76,6 +76,12 @@ struct AccelCPUState {
 #define EFER_LMA   ((uint64_t)0x400)
 #define EFER_LME   ((uint64_t)0x100)
 
+void mshv_arch_amend_proc_features(
+    union hv_partition_synthetic_processor_features *features);
+int mshv_arch_post_init_vm(int vm_fd);
+
+int mshv_hvcall(int mshv_fd, const struct mshv_root_hvcall *args);
+
 
 /* memory */
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
diff --git a/meson.build b/meson.build
index a4269b816b..6cd3e26e39 100644
--- a/meson.build
+++ b/meson.build
@@ -3595,6 +3595,7 @@ endif
 if have_system
   trace_events_subdirs += [
     'accel/kvm',
+    'accel/mshv',
     'audio',
     'backends',
     'backends/tpm',
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 8ddaa7c11d..647e5dafb7 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -1,6 +1,7 @@
 i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
+  'mshv-cpu.c',
   'x86.c',
 ))
 
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
new file mode 100644
index 0000000000..b36f8904fb
--- /dev/null
+++ b/target/i386/mshv/mshv-cpu.c
@@ -0,0 +1,73 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *  Jinank Jain       <jinankjain@microsoft.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/typedefs.h"
+
+#include "system/mshv.h"
+#include "hw/hyperv/linux-mshv.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk.h"
+
+
+#include "trace-accel_mshv.h"
+#include "trace.h"
+
+void mshv_arch_amend_proc_features(
+    union hv_partition_synthetic_processor_features *features)
+{
+    features->access_guest_idle_reg = 1;
+}
+
+/*
+ * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
+ * fault to the guest if it tries to access it. It is possible to override
+ * this behavior with a more suitable option i.e., ignore writes from the guest
+ * and return zero in attempt to read unimplemented.
+ */
+static int set_unimplemented_msr_action(int vm_fd)
+{
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code  = HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION;
+    in.property_value = HV_UNIMPLEMENTED_MSR_ACTION_IGNORE_WRITE_READ_ZERO;
+
+    args.code   = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz  = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    trace_mshv_hvcall_args("unimplemented_msr_action", args.code, args.in_sz);
+
+    int ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set unimplemented MSR action");
+        return -1;
+    }
+    return 0;
+}
+
+int mshv_arch_post_init_vm(int vm_fd)
+{
+    int ret;
+
+    ret = set_unimplemented_msr_action(vm_fd);
+    if (ret < 0) {
+        error_report("Failed to set unimplemented MSR action");
+    }
+
+    return ret;
+}
-- 
2.34.1


