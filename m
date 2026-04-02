Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96314D39427
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILJ-0008PO-1D; Thu, 02 Apr 2026 09:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8IKx-0004lE-O1; Thu, 02 Apr 2026 09:43:55 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8HXl-0008QZ-JN; Thu, 02 Apr 2026 08:53:08 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 23C5D20B7136;
 Thu,  2 Apr 2026 05:53:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23C5D20B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775134380;
 bh=m0k2+p45IxRoR7EBbAy9Rxxi2hTnQ1VuZluHvqCqsIY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mqL0UB4qvak1Chc5pYRIuja6w5Vt4dCsuZ3sCNXraeoVACXlJUOSD6acpuPH+1LMi
 DEEXUOwEyGy0vMFJmzf++Fmxv+wdlKzu5qXoDtn5IOmP5DeCpri2MVpRrP2N64MtdB
 T3W1BrbQ2ACzwzif6kQ7q7QJataszzwOnxgVybUk=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 02 Apr 2026 12:52:30 +0000
Subject: [PATCH v2 03/14] meson, target/arm/mshv: Enable arm64 build & add
 initial MSHV support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-mshv_accel_arm64_supp-v2-3-754895c15e9e@linux.microsoft.com>
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

Enable the build of the MSHV accelerator for arm64 in the Meson build
system. Introduce initial files and stub implementations to support MSHV
for the ARM target.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 meson.build                 |  7 +++---
 target/arm/meson.build      |  1 +
 target/arm/mshv/meson.build |  7 ++++++
 target/arm/mshv/mshv-all.c  | 54 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index ed82247111..bf12fda40f 100644
--- a/meson.build
+++ b/meson.build
@@ -303,7 +303,8 @@ if cpu == 'aarch64'
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu'],
     'CONFIG_NITRO': ['aarch64-softmmu'],
-    'CONFIG_WHPX': ['aarch64-softmmu']
+    'CONFIG_WHPX': ['aarch64-softmmu'],
+    'CONFIG_MSHV': ['aarch64-softmmu'],
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -855,8 +856,8 @@ if get_option('kvm').allowed() and host_os == 'linux'
 endif
 
 if get_option('mshv').allowed() and host_os == 'linux'
-  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
-    error('mshv accelerator requires x64_64 host')
+  if get_option('mshv').enabled() and not (host_machine.cpu() in [ 'x86_64', 'aarch64' ])
+    error('The mshv accelerator requires an x86_64 or aarch64 host')
   endif
   accelerators += 'CONFIG_MSHV'
 endif
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0e504a40..8aa8cac137 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -59,6 +59,7 @@ arm_common_system_ss.add(files(
 
 subdir('hvf')
 subdir('whpx')
+subdir('mshv')
 
 if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
diff --git a/target/arm/mshv/meson.build b/target/arm/mshv/meson.build
new file mode 100644
index 0000000000..169643691e
--- /dev/null
+++ b/target/arm/mshv/meson.build
@@ -0,0 +1,7 @@
+arm_mshv_ss = ss.source_set()
+
+arm_mshv_ss.add(files(
+  'mshv-all.c',
+))
+
+arm_system_ss.add_all(when: 'CONFIG_MSHV', if_true: arm_mshv_ss)
diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
new file mode 100644
index 0000000000..1c82e2c593
--- /dev/null
+++ b/target/arm/mshv/mshv-all.c
@@ -0,0 +1,54 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Aastha Rawat          <aastharawat@linux.microsoft.com>
+ *          Anirudh Rayabharam    <anirudh@anirudhrb.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+int mshv_load_regs(CPUState *cpu)
+{
+    return 0;
+}
+
+int mshv_arch_put_registers(const CPUState *cpu)
+{
+    return 0;
+}
+
+int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
+{
+    return 0;
+}
+
+void mshv_arch_init_vcpu(CPUState *cpu)
+{
+
+}
+
+void mshv_arch_destroy_vcpu(CPUState *cpu)
+{
+
+}
+
+void mshv_init_mmio_emu(void)
+{
+
+}
+
+void mshv_arch_amend_proc_features(
+    union hv_partition_synthetic_processor_features *features)
+{
+
+}
+
+int mshv_arch_post_init_vm(int vm_fd)
+{
+    return 0;
+}

-- 
2.45.4


