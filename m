Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1F2C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLC3-00086W-NT; Tue, 20 May 2025 07:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLC0-00085W-2I
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:32 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLBx-0001Fb-Na
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:31 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5286F201DB2F;
 Tue, 20 May 2025 04:31:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5286F201DB2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740688;
 bh=2j2Hac+kfpYWsKAqb5uP4YD7jcUnCWN4nzwJo06Di0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HEGSl+PWo54FP7QYM+KO/QFAw6QUshl0fWnSGipUYL+GqF87/DSZ75ow+wvSZSLM3
 0p3xvaOC1V7u0+oyZIdv/JYtwLIvcUt8mc/Da+k2clUZQ0qZfO1kos9/KUrNME2XDg
 G7WdcN6H82g/tddmlnV/Qv2hjV2szYAWNog5T3hA=
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
Subject: [RFC PATCH 06/25] accel/mshv: Add accelerator skeleton
Date: Tue, 20 May 2025 13:29:59 +0200
Message-Id: <20250520113018.49569-7-magnuskulke@linux.microsoft.com>
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

Introduce the initial scaffold for the MSHV (Microsoft Hypervisor)
accelerator backend. This includes the basic directory structure and
stub implementations needed to integrate with QEMU's accelerator
framework.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/meson.build      |   1 +
 accel/mshv/meson.build |   6 ++
 accel/mshv/mshv-all.c  | 143 +++++++++++++++++++++++++++++++++++++++++
 include/system/mshv.h  |  34 ++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 accel/mshv/meson.build
 create mode 100644 accel/mshv/mshv-all.c

diff --git a/accel/meson.build b/accel/meson.build
index d5e982d152..efa62879b6 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -10,6 +10,7 @@ if have_system
   subdir('kvm')
   subdir('xen')
   subdir('stubs')
+  subdir('mshv')
 endif
 
 # qtest
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
new file mode 100644
index 0000000000..4c03ac7921
--- /dev/null
+++ b/accel/mshv/meson.build
@@ -0,0 +1,6 @@
+mshv_ss = ss.source_set()
+mshv_ss.add(if_true: files(
+  'mshv-all.c'
+))
+
+specific_ss.add_all(when: 'CONFIG_MSHV', if_true: mshv_ss)
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
new file mode 100644
index 0000000000..44605adf94
--- /dev/null
+++ b/accel/mshv/mshv-all.c
@@ -0,0 +1,143 @@
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
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "hw/boards.h"
+
+#include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk.h"
+#include "hw/hyperv/linux-mshv.h"
+
+#include "qemu/accel.h"
+#include "qemu/guest-random.h"
+#include "system/accel-ops.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "system/accel-blocker.h"
+#include "system/address-spaces.h"
+#include "system/mshv.h"
+#include "system/reset.h"
+#include "trace.h"
+#include <err.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
+
+DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
+
+bool mshv_allowed;
+
+MshvState *mshv_state;
+
+
+static int mshv_init(MachineState *ms)
+{
+	error_report("unimplemented");
+	abort();
+}
+
+static void mshv_start_vcpu_thread(CPUState *cpu)
+{
+	error_report("unimplemented");
+	abort();
+}
+
+static void mshv_cpu_synchronize_post_init(CPUState *cpu)
+{
+	error_report("unimplemented");
+	abort();
+}
+
+static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
+{
+	error_report("unimplemented");
+	abort();
+}
+
+static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+	error_report("unimplemented");
+	abort();
+}
+
+static void mshv_cpu_synchronize(CPUState *cpu)
+{
+	error_report("unimplemented");
+	abort();
+}
+
+static bool mshv_cpus_are_resettable(void)
+{
+	error_report("unimplemented");
+	abort();
+}
+
+static void mshv_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+
+    ac->name = "MSHV";
+    ac->init_machine = mshv_init;
+    ac->allowed = &mshv_allowed;
+}
+
+static void mshv_accel_instance_init(Object *obj)
+{
+    MshvState *s = MSHV_STATE(obj);
+
+    s->vm = 0;
+}
+
+static const TypeInfo mshv_accel_type = {
+    .name = TYPE_MSHV_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_init = mshv_accel_instance_init,
+    .class_init = mshv_accel_class_init,
+    .instance_size = sizeof(MshvState),
+};
+
+static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+
+    ops->create_vcpu_thread = mshv_start_vcpu_thread;
+    ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
+    ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
+    ops->synchronize_state = mshv_cpu_synchronize;
+    ops->synchronize_pre_loadvm = mshv_cpu_synchronize_pre_loadvm;
+    ops->cpus_are_resettable = mshv_cpus_are_resettable;
+}
+
+static const TypeInfo mshv_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("mshv"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = mshv_accel_ops_class_init,
+    .abstract = true,
+};
+
+static void mshv_type_init(void)
+{
+    type_register_static(&mshv_accel_type);
+    type_register_static(&mshv_accel_ops_type);
+}
+
+type_init(mshv_type_init);
diff --git a/include/system/mshv.h b/include/system/mshv.h
index bc8f2c228a..0858e47def 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -16,6 +16,14 @@
 #ifndef QEMU_MSHV_INT_H
 #define QEMU_MSHV_INT_H
 
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "hw/hyperv/hyperv-proto.h"
+#include "hw/hyperv/linux-mshv.h"
+#include "hw/hyperv/hvhdk.h"
+#include "qapi/qapi-types-common.h"
+#include "system/memory.h"
+
 #ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_MSHV
 #define CONFIG_MSHV_IS_POSSIBLE
@@ -28,6 +36,32 @@
 #ifdef CONFIG_MSHV_IS_POSSIBLE
 extern bool mshv_allowed;
 #define mshv_enabled() (mshv_allowed)
+
+typedef struct MshvMemoryListener {
+  MemoryListener listener;
+  int as_id;
+} MshvMemoryListener;
+
+typedef struct MshvAddressSpace {
+    MshvMemoryListener *ml;
+    AddressSpace *as;
+} MshvAddressSpace;
+
+typedef struct MshvState {
+  AccelState parent_obj;
+  int vm;
+  MshvMemoryListener memory_listener;
+  /* number of listeners */
+  int nr_as;
+  MshvAddressSpace *as;
+} MshvState;
+extern MshvState *mshv_state;
+
+struct AccelCPUState {
+  int cpufd;
+  bool dirty;
+};
+
 #else /* CONFIG_MSHV_IS_POSSIBLE */
 #define mshv_enabled() false
 #endif
-- 
2.34.1


