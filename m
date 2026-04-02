Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C34FD39428
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILJ-0008Pj-6Q; Thu, 02 Apr 2026 09:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8IKv-0006PC-NZ; Thu, 02 Apr 2026 09:43:53 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8HXu-0008SF-LC; Thu, 02 Apr 2026 08:53:17 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3F91F20B7001;
 Thu,  2 Apr 2026 05:53:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F91F20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775134382;
 bh=TMVtmh/ACGMIWBY0kUMfU5jbSQ2Sl8D1oMQaMBRtJhw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=V/rqnTSfmOR6z0ZVQiPSoIXMpj9rCQP2OP0mFwi1ui1/62kgIehYjU0wTBDgAmkim
 eHAq5jGTiaNh7fCm+oz7WNeBnsGZTPY/jau8JWP5t7HG1nOcaD5cONldAk/oJ2sYj3
 zxLkRGmqHl8mqWw9dvkKI1heGvyfXooSwXT7fa1M=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 02 Apr 2026 12:52:33 +0000
Subject: [PATCH v2 06/14] accel/mshv: add arch-specific accelerator init hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-mshv_accel_arm64_supp-v2-6-754895c15e9e@linux.microsoft.com>
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

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

Introduce mshv_arch_accel_init() as an arch-specific hook called early
in mshv_init(), before VM creation. This allows each architecture to
perform platform-specific initialization at accelerator init time.

For arm64, the hook queries the hypervisor for the supported IPA bit
size and validates it against the guest memory map via the machine's
get_physical_address_range callback, following the same pattern used by
HVF and WHPX. This also populates the memory map which comes in handy
later when retreiving the vGIC layout.

For x86, the hook calls mshv_init_mmio_emu() which was previously called
directly from the common init path. Also move set_unimplemented_msr_action()
and mshv_arch_post_init_vm() from mshv-cpu.c to the new mshv-all.c, as
they are not vCPU-specific.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 accel/mshv/mshv-all.c        |  5 ++-
 include/system/mshv_int.h    |  1 +
 target/arm/mshv/mshv-all.c   | 25 ++++++++++----
 target/i386/mshv/meson.build |  1 +
 target/i386/mshv/mshv-all.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
 target/i386/mshv/mshv-cpu.c  | 40 ----------------------
 6 files changed, 105 insertions(+), 47 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 44f35a1463..6940ad9989 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -434,7 +434,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
         return -1;
     }
 
-    mshv_init_mmio_emu();
+    ret = mshv_arch_accel_init(as, ms, mshv_fd);
+    if (ret < 0) {
+        return -1;
+    }
 
     mshv_init_msicontrol();
 
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index ff3ab957b5..c72c91cd23 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -96,6 +96,7 @@ void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
+int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd);
 int mshv_arch_post_init_vm(int vm_fd);
 void mshv_setup_hvcall_args(AccelCPUState *state);
 
diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
index db1174b444..8d16971c0d 100644
--- a/target/arm/mshv/mshv-all.c
+++ b/target/arm/mshv/mshv-all.c
@@ -9,12 +9,13 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/virt.h"
 
 #include "system/cpus.h"
 #include "target/arm/cpu.h"
@@ -188,11 +189,6 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     state->hvcall_args = (MshvHvCallArgs){0};
 }
 
-void mshv_init_mmio_emu(void)
-{
-
-}
-
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features)
 {
@@ -394,3 +390,20 @@ void mshv_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->midr = arm_host_cpu_features.midr;
     cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
 }
+
+int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int pa_range;
+    uint32_t ipa_size;
+
+    if (mc->get_physical_address_range) {
+        ipa_size = mshv_arm_get_ipa_bit_size(mshv_fd);
+        pa_range = mc->get_physical_address_range(ms, ipa_size, ipa_size);
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 6091c21887..ce54e134cb 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -1,6 +1,7 @@
 i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
+  'mshv-all.c',
   'mshv-cpu.c',
   'msr.c',
 ))
diff --git a/target/i386/mshv/mshv-all.c b/target/i386/mshv/mshv-all.c
new file mode 100644
index 0000000000..f0b43aa86f
--- /dev/null
+++ b/target/i386/mshv/mshv-all.c
@@ -0,0 +1,80 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Ziqiao Zhou   <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke  <magnuskulke@microsoft.com>
+ *          Jinank Jain   <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/memalign.h"
+
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+#include "system/address-spaces.h"
+#include "linux/mshv.h"
+#include "hw/hyperv/hvgdk.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/i386/apic_internal.h"
+
+#include "cpu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
+#include "emulate/x86_flags.h"
+
+#include "trace-accel_mshv.h"
+#include "trace.h"
+
+#include <sys/ioctl.h>
+
+int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd)
+{
+    mshv_init_mmio_emu();
+    return 0;
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
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 9a80dc34d0..8325ac74a3 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1482,43 +1482,3 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     state->hvcall_args = (MshvHvCallArgs){0};
     g_clear_pointer(&env->emu_mmio_buf, g_free);
 }
-
-/*
- * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
- * fault to the guest if it tries to access it. It is possible to override
- * this behavior with a more suitable option i.e., ignore writes from the guest
- * and return zero in attempt to read unimplemented.
- */
-static int set_unimplemented_msr_action(int vm_fd)
-{
-    struct hv_input_set_partition_property in = {0};
-    struct mshv_root_hvcall args = {0};
-
-    in.property_code  = HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION;
-    in.property_value = HV_UNIMPLEMENTED_MSR_ACTION_IGNORE_WRITE_READ_ZERO;
-
-    args.code   = HVCALL_SET_PARTITION_PROPERTY;
-    args.in_sz  = sizeof(in);
-    args.in_ptr = (uint64_t)&in;
-
-    trace_mshv_hvcall_args("unimplemented_msr_action", args.code, args.in_sz);
-
-    int ret = mshv_hvcall(vm_fd, &args);
-    if (ret < 0) {
-        error_report("Failed to set unimplemented MSR action");
-        return -1;
-    }
-    return 0;
-}
-
-int mshv_arch_post_init_vm(int vm_fd)
-{
-    int ret;
-
-    ret = set_unimplemented_msr_action(vm_fd);
-    if (ret < 0) {
-        error_report("Failed to set unimplemented MSR action");
-    }
-
-    return ret;
-}

-- 
2.45.4


