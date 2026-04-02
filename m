Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96E2D3941D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILI-0008P4-Sn; Thu, 02 Apr 2026 09:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8IKw-0004lE-8H; Thu, 02 Apr 2026 09:43:55 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8HXl-0008QM-JN; Thu, 02 Apr 2026 08:53:09 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5803620B7135;
 Thu,  2 Apr 2026 05:52:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5803620B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775134379;
 bh=HJT/I+bbATbzpZa7IFBQev2FeK1wmUQopVue49jowBM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SCHwIjL692COZw/8pbjnMyFLcDEBqUgjJxhYYbB2tMutNb0ass7XBrDxmTE9R2Rq+
 S9la6TDwxEvlbT8HBds/MXENFavkTnF37TXsPiuXFDRSNP8TWFwlup3XfyjMdcKeuQ
 +apmEAUZ82TEGl37mFZ0vmoXhNKhqyrp8XU4315s=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 02 Apr 2026 12:52:29 +0000
Subject: [PATCH v2 02/14] accel/mshv: extract common CPU register helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-mshv_accel_arm64_supp-v2-2-754895c15e9e@linux.microsoft.com>
References: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
In-Reply-To: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move arch-independent MSHV CPU register handling functions into
accel/mshv/mshv-cpu-common.c. Update x86 MSHV backends to use these
shared helpers.

Prefix get_generic_regs() with mshv_ for proper namespacing since it
is now public.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 accel/mshv/meson.build       |   3 +-
 accel/mshv/mshv-cpu-common.c | 151 +++++++++++++++++++++++++++++++++++++++++++
 include/system/mshv_int.h    |   3 +
 target/i386/mshv/mshv-cpu.c  | 130 +------------------------------------
 4 files changed, 159 insertions(+), 128 deletions(-)

diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index e433187cde..ebe32921b3 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(when: 'CONFIG_MSHV', if_true: files(
   'irq.c',
   'mem.c',
-  'mshv-all.c'
+  'mshv-all.c',
+  'mshv-cpu-common.c'
 ))
diff --git a/accel/mshv/mshv-cpu-common.c b/accel/mshv/mshv-cpu-common.c
new file mode 100644
index 0000000000..b104720161
--- /dev/null
+++ b/accel/mshv/mshv-cpu-common.c
@@ -0,0 +1,151 @@
+/*
+ * QEMU MSHV common CPU register helpers
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Ziqiao Zhou   <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke  <magnuskulke@microsoft.com>
+ *          Jinank Jain   <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/memalign.h"
+
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+#include "hw/core/cpu.h"
+#include "linux/mshv.h"
+
+#include <sys/ioctl.h>
+
+int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
+                          size_t n_regs)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+    size_t in_sz, assocs_sz;
+    hv_input_set_vp_registers *in = cpu->accel->hvcall_args.input_page;
+    struct mshv_root_hvcall args = {0};
+    int ret;
+
+    /* find out the size of the struct w/ a flexible array at the tail */
+    assocs_sz = n_regs * sizeof(hv_register_assoc);
+    in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
+
+    /* fill the input struct */
+    memset(in, 0, sizeof(hv_input_set_vp_registers));
+    in->vp_index = vp_index;
+    memcpy(in->elements, assocs, assocs_sz);
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_SET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uint64_t) in;
+    args.reps = (uint16_t) n_regs;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set registers");
+        return -1;
+    }
+
+    /* assert we set all registers */
+    if (args.reps != n_regs) {
+        error_report("Failed to set registers: expected %zu elements"
+                     ", got %u", n_regs, args.reps);
+        return -1;
+    }
+
+    return 0;
+}
+
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                            size_t n_regs)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+    hv_input_get_vp_registers *in = cpu->accel->hvcall_args.input_page;
+    hv_register_value *values = cpu->accel->hvcall_args.output_page;
+    size_t in_sz, names_sz, values_sz;
+    int i, ret;
+    struct mshv_root_hvcall args = {0};
+
+    /* find out the size of the struct w/ a flexible array at the tail */
+    names_sz = n_regs * sizeof(hv_register_name);
+    in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
+
+    /* fill the input struct */
+    memset(in, 0, sizeof(hv_input_get_vp_registers));
+    in->vp_index = vp_index;
+    for (i = 0; i < n_regs; i++) {
+        in->names[i] = assocs[i].name;
+    }
+
+    /* determine size of value output buffer */
+    values_sz = n_regs * sizeof(union hv_register_value);
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_GET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uint64_t) in;
+    args.out_sz = values_sz;
+    args.out_ptr = (uint64_t) values;
+    args.reps = (uint16_t) n_regs;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to retrieve registers");
+        return -1;
+    }
+
+    /* assert we got all registers */
+    if (args.reps != n_regs) {
+        error_report("Failed to retrieve registers: expected %zu elements"
+                     ", got %u", n_regs, args.reps);
+        return -1;
+    }
+
+    /* copy values into assoc */
+    for (i = 0; i < n_regs; i++) {
+        assocs[i].value = values[i];
+    }
+
+    return 0;
+}
+
+int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
+{
+    int ret;
+    struct mshv_create_vp vp_arg = {
+        .vp_index = vp_index,
+    };
+
+    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
+    if (ret < 0) {
+        error_report("failed to create mshv vcpu: %s", strerror(errno));
+        return -1;
+    }
+
+    *cpu_fd = ret;
+
+    return 0;
+}
+
+void mshv_remove_vcpu(int vm_fd, int cpu_fd)
+{
+    close(cpu_fd);
+}
+
+void mshv_setup_hvcall_args(AccelCPUState *state)
+{
+    void *mem = qemu_memalign(HV_HYP_PAGE_SIZE, 2 * HV_HYP_PAGE_SIZE);
+
+    state->hvcall_args.base = mem;
+    state->hvcall_args.input_page = mem;
+    state->hvcall_args.output_page = (uint8_t *)mem + HV_HYP_PAGE_SIZE;
+}
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 35386c422f..ff3ab957b5 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -89,12 +89,15 @@ int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                        size_t n_regs);
 int mshv_arch_put_registers(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_post_init_vm(int vm_fd);
+void mshv_setup_hvcall_args(AccelCPUState *state);
 
 typedef struct mshv_root_hvcall mshv_root_hvcall;
 int mshv_hvcall(int fd, const mshv_root_hvcall *args);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2bc978deb2..9a80dc34d0 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -148,103 +148,6 @@ static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
     return 0;
 }
 
-int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
-                          size_t n_regs)
-{
-    int cpu_fd = mshv_vcpufd(cpu);
-    int vp_index = cpu->cpu_index;
-    size_t in_sz, assocs_sz;
-    hv_input_set_vp_registers *in = cpu->accel->hvcall_args.input_page;
-    struct mshv_root_hvcall args = {0};
-    int ret;
-
-    /* find out the size of the struct w/ a flexible array at the tail */
-    assocs_sz = n_regs * sizeof(hv_register_assoc);
-    in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
-
-    /* fill the input struct */
-    memset(in, 0, sizeof(hv_input_set_vp_registers));
-    in->vp_index = vp_index;
-    memcpy(in->elements, assocs, assocs_sz);
-
-    /* create the hvcall envelope */
-    args.code = HVCALL_SET_VP_REGISTERS;
-    args.in_sz = in_sz;
-    args.in_ptr = (uint64_t) in;
-    args.reps = (uint16_t) n_regs;
-
-    /* perform the call */
-    ret = mshv_hvcall(cpu_fd, &args);
-    if (ret < 0) {
-        error_report("Failed to set registers");
-        return -1;
-    }
-
-    /* assert we set all registers */
-    if (args.reps != n_regs) {
-        error_report("Failed to set registers: expected %zu elements"
-                     ", got %u", n_regs, args.reps);
-        return -1;
-    }
-
-    return 0;
-}
-
-static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
-                            size_t n_regs)
-{
-    int cpu_fd = mshv_vcpufd(cpu);
-    int vp_index = cpu->cpu_index;
-    hv_input_get_vp_registers *in = cpu->accel->hvcall_args.input_page;
-    hv_register_value *values = cpu->accel->hvcall_args.output_page;
-    size_t in_sz, names_sz, values_sz;
-    int i, ret;
-    struct mshv_root_hvcall args = {0};
-
-    /* find out the size of the struct w/ a flexible array at the tail */
-    names_sz = n_regs * sizeof(hv_register_name);
-    in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
-
-    /* fill the input struct */
-    memset(in, 0, sizeof(hv_input_get_vp_registers));
-    in->vp_index = vp_index;
-    for (i = 0; i < n_regs; i++) {
-        in->names[i] = assocs[i].name;
-    }
-
-    /* determine size of value output buffer */
-    values_sz = n_regs * sizeof(union hv_register_value);
-
-    /* create the hvcall envelope */
-    args.code = HVCALL_GET_VP_REGISTERS;
-    args.in_sz = in_sz;
-    args.in_ptr = (uint64_t) in;
-    args.out_sz = values_sz;
-    args.out_ptr = (uint64_t) values;
-    args.reps = (uint16_t) n_regs;
-
-    /* perform the call */
-    ret = mshv_hvcall(cpu_fd, &args);
-    if (ret < 0) {
-        error_report("Failed to retrieve registers");
-        return -1;
-    }
-
-    /* assert we got all registers */
-    if (args.reps != n_regs) {
-        error_report("Failed to retrieve registers: expected %zu elements"
-                     ", got %u", n_regs, args.reps);
-        return -1;
-    }
-
-    /* copy values into assoc */
-    for (i = 0; i < n_regs; i++) {
-        assocs[i].value = values[i];
-    }
-
-    return 0;
-}
-
 static int set_standard_regs(const CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -334,7 +237,7 @@ int mshv_get_standard_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = STANDARD_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get standard registers");
         return -1;
@@ -412,7 +315,7 @@ int mshv_get_special_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = SPECIAL_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get special registers");
         return -errno;
@@ -1525,29 +1428,6 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
     return 0;
 }
 
-void mshv_remove_vcpu(int vm_fd, int cpu_fd)
-{
-    close(cpu_fd);
-}
-
-
-int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
-{
-    int ret;
-    struct mshv_create_vp vp_arg = {
-        .vp_index = vp_index,
-    };
-    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
-    if (ret < 0) {
-        error_report("failed to create mshv vcpu: %s", strerror(errno));
-        return -1;
-    }
-
-    *cpu_fd = ret;
-
-    return 0;
-}
-
 static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
@@ -1580,8 +1460,6 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *state = cpu->accel;
-    size_t page = HV_HYP_PAGE_SIZE;
-    void *mem = qemu_memalign(page, 2 * page);
 
     /* sanity check, to make sure we don't overflow the page */
     QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
@@ -1589,9 +1467,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
                       + sizeof(hv_input_get_vp_registers)
                       > HV_HYP_PAGE_SIZE));
 
-    state->hvcall_args.base = mem;
-    state->hvcall_args.input_page = mem;
-    state->hvcall_args.output_page = (uint8_t *)mem + page;
+    mshv_setup_hvcall_args(state);
 
     env->emu_mmio_buf = g_new(char, 4096);
 }

-- 
2.45.4


