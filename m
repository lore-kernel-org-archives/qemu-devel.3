Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20314C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfn7-0005mq-69; Fri, 17 Jul 2026 06:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfn5-0005mT-Vo; Fri, 17 Jul 2026 06:27:36 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfn4-0000OT-27; Fri, 17 Jul 2026 06:27:35 -0400
Received: from localhost (unknown [131.107.159.8])
 by linux.microsoft.com (Postfix) with ESMTPSA id 96D7620B716C;
 Fri, 17 Jul 2026 03:27:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96D7620B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784284042;
 bh=3F9+arkC1uiSexFloo23u4mxdhDWKX7XhaEN/wwXo0w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=d6iNxTfMVmpEtEfh3kM4Ly4+3d7V2Uhg33dfev3CGkk2PVcIbndpeO8zk8VDXTEEK
 yJ9c+0JF1rXxTiMJYYgWlKR6URV0lXchiMTXn+T6RywTiJw0JQejkAh2BMw3MN7psm
 rdFWajbVY1srjlCjXlXibVhVdGFPrCWTO3ubUbVU=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Fri, 17 Jul 2026 10:27:17 +0000
Subject: [PATCH v5 02/13] accel/mshv: add arch-specific accelerator init hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mshv_accel_arm64_supp-v5-2-ef07d4c6b337@linux.microsoft.com>
References: <20260717-mshv_accel_arm64_supp-v5-0-ef07d4c6b337@linux.microsoft.com>
In-Reply-To: <20260717-mshv_accel_arm64_supp-v5-0-ef07d4c6b337@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For x86, the hook calls mshv_init_mmio_emu() which was previously called
directly from the common init path. Also move set_unimplemented_msr_action()
and mshv_arch_post_init_vm() from mshv-cpu.c to the new mshv-all.c, as
they are not vCPU-specific.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 accel/mshv/mshv-all.c        |  5 ++-
 include/system/mshv_int.h    |  1 +
 target/i386/mshv/meson.build |  1 +
 target/i386/mshv/mshv-all.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
 target/i386/mshv/mshv-cpu.c  | 40 ----------------------
 5 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 72721d0f0d..7cf99b44e0 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -557,7 +557,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
         return -1;
     }
 
-    mshv_init_mmio_emu();
+    ret = mshv_arch_accel_init(as, ms, mshv_fd);
+    if (ret < 0) {
+        return -1;
+    }
 
     ret = create_vm(mshv_fd, &vm_fd);
     if (ret < 0) {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index e9f4a2f9b9..81e233be5f 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -104,6 +104,7 @@ void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 void mshv_arch_disable_partition_proc_features(
      union hv_partition_processor_features *disabled_features);
+int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd);
 int mshv_arch_post_init_vm(int vm_fd);
 void mshv_setup_hvcall_args(AccelCPUState *state);
 
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
index a142f79801..0ae1c643a6 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -2037,46 +2037,6 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
     return ret;
 }
 
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
-
 static void mshv_cpu_xsave_init(void)
 {
     static bool first = true;

-- 
2.45.4


