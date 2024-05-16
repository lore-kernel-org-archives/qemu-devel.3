Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61673C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cBl-000483-IS; Thu, 16 May 2024 10:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cBk-00047b-2G; Thu, 16 May 2024 10:34:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cBh-0008LC-HB; Thu, 16 May 2024 10:34:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G8vQL8004205;
 Thu, 16 May 2024 14:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=3yqLx61ZnkmBsG3RyfUDJ14/YMf3ppRWmVy96fNexlI=; b=RA
 5nuiV2XfsUpyBGQa1tDL0GeDn/8UGak6hDNJunksNLTCEz646tak7yeezAGWy9w/
 c1F9FXf2f0BrzEg02aHBbW+l5A1EUMzc5GKmOI5GvagFfbGSrqGKZviaZ5SFIh/I
 n9shZOAnjVM4RiSn2wWG4yPDaOr+nxnRIHz5KTNcDncQyeLY1exrckjJOyAzlnJ0
 3Nt8yR+kF6RJ6VftnsYmoDR9+UPruRrgvDk1tCOvYVvMCChjS9cZMG3S83CXjNwz
 OZdGxpOkpWnQbw7s8hX5ILTZxiw8NE7ZpEPKzio+QO0Pknvc6Gyj9bIqxuV4qO8U
 LBjUJ5Rta+jrpK7DtSSA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y2125m093-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GEYQaN009353
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:26 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 May 2024 07:34:21 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v2 04/12] gunyah: Basic support
Date: Thu, 16 May 2024 14:33:48 +0000
Message-ID: <20240516143356.1739402-5-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
References: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: aUMM39dkCCty9NeKcKoYxaD6J3vCXgKZ
X-Proofpoint-ORIG-GUID: aUMM39dkCCty9NeKcKoYxaD6J3vCXgKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=959 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160102
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add a new accelerator, gunyah, with basic functionality of creating a
VM. Subsequent patches will add support for other functions required to
run a VM.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 MAINTAINERS                     |   7 ++
 docs/about/build-platforms.rst  |   2 +-
 meson.build                     |  12 +++-
 include/sysemu/gunyah.h         |  30 ++++++++
 include/sysemu/gunyah_int.h     |  27 +++++++
 accel/gunyah/gunyah-accel-ops.c | 121 ++++++++++++++++++++++++++++++++
 accel/gunyah/gunyah-all.c       |  70 ++++++++++++++++++
 accel/stubs/gunyah-stub.c       |  13 ++++
 hw/arm/virt.c                   |   3 +
 target/arm/cpu.c                |   3 +-
 target/arm/cpu64.c              |   5 +-
 accel/Kconfig                   |   3 +
 accel/gunyah/meson.build        |   7 ++
 accel/meson.build               |   1 +
 accel/stubs/meson.build         |   1 +
 meson_options.txt               |   2 +
 scripts/meson-buildoptions.sh   |   3 +
 17 files changed, 305 insertions(+), 5 deletions(-)
 create mode 100644 include/sysemu/gunyah.h
 create mode 100644 include/sysemu/gunyah_int.h
 create mode 100644 accel/gunyah/gunyah-accel-ops.c
 create mode 100644 accel/gunyah/gunyah-all.c
 create mode 100644 accel/stubs/gunyah-stub.c
 create mode 100644 accel/gunyah/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 84391777db..d8d63b1c3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -523,6 +523,13 @@ F: accel/hvf/
 F: include/sysemu/hvf.h
 F: include/sysemu/hvf_int.h
 
+GUNYAH
+M: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
+S: Maintained
+F: accel/gunyah
+F: include/sysemu/gunyah.h
+F: include/sysemu/gunyah_int.h
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8fd7da140a..47e314d562 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -40,7 +40,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - kvm (64 bit only), tcg, xen
+     - kvm (64 bit only), tcg, xen, gunyah (64 bit only)
    * - MIPS (little endian only)
      - kvm, tcg
    * - PPC
diff --git a/meson.build b/meson.build
index 43da492372..25ce20b1e0 100644
--- a/meson.build
+++ b/meson.build
@@ -248,7 +248,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu in ['aarch64']
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_GUNYAH': ['aarch64-softmmu']
   }
 endif
 
@@ -736,6 +737,11 @@ if get_option('hvf').allowed()
   endif
 endif
 
+gunyah = not_found
+if get_option('gunyah').allowed() and host_os == 'linux'
+    accelerators += 'CONFIG_GUNYAH'
+endif
+
 nvmm = not_found
 if host_os == 'netbsd'
   nvmm = cc.find_library('nvmm', required: get_option('nvmm'))
@@ -882,6 +888,9 @@ elif get_option('plugins')
 else
   gmodule = not_found
 endif
+if 'CONFIG_GUNYAH' not in accelerators and get_option('gunyah').enabled()
+  error('Gunyah not available on this platform')
+endif
 
 # This workaround is required due to a bug in pkg-config file for glib as it
 # doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
@@ -4270,6 +4279,7 @@ if have_system
     summary_info += {'xen ctrl version':  xen.version()}
   endif
   summary_info += {'Xen emulation':     config_all_devices.has_key('CONFIG_XEN_EMU')}
+  summary_info += {'Gunyah support':    config_all_accel.has_key('CONFIG_GUNYAH')}
 endif
 summary_info += {'TCG support':       config_all_accel.has_key('CONFIG_TCG')}
 if config_all_accel.has_key('CONFIG_TCG')
diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
new file mode 100644
index 0000000000..4f26938521
--- /dev/null
+++ b/include/sysemu/gunyah.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* header to be included in non-Gunyah-specific code */
+
+#ifndef QEMU_GUNYAH_H
+#define QEMU_GUNYAH_H
+
+#include "qemu/accel.h"
+#include "qom/object.h"
+
+#ifdef NEED_CPU_H
+#include "cpu.h"
+#endif
+
+extern bool gunyah_allowed;
+
+#define gunyah_enabled() (gunyah_allowed)
+
+#define TYPE_GUNYAH_ACCEL ACCEL_CLASS_NAME("gunyah")
+typedef struct GUNYAHState GUNYAHState;
+DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
+                         TYPE_GUNYAH_ACCEL)
+
+#endif  /* QEMU_GUNYAH_H */
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
new file mode 100644
index 0000000000..37de628b37
--- /dev/null
+++ b/include/sysemu/gunyah_int.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* header to be included in Gunyah-specific code */
+
+#ifndef GUNYAH_INT_H
+#define GUNYAH_INT_H
+
+#include "qemu/accel.h"
+#include "qemu/typedefs.h"
+
+struct GUNYAHState {
+    AccelState parent_obj;
+
+    int fd;
+    int vmfd;
+};
+
+int gunyah_create_vm(void);
+void *gunyah_cpu_thread_fn(void *arg);
+
+#endif    /* GUNYAH_INT_H */
diff --git a/accel/gunyah/gunyah-accel-ops.c b/accel/gunyah/gunyah-accel-ops.c
new file mode 100644
index 0000000000..af8a4ad606
--- /dev/null
+++ b/accel/gunyah/gunyah-accel-ops.c
@@ -0,0 +1,121 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * (based on KVM accelerator code structure)
+ *
+ * Copyright 2008 IBM Corporation
+ *           2008 Red Hat, Inc.
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+#include "hw/boards.h"
+#include "hw/core/cpu.h"
+#include "sysemu/accel-ops.h"
+#include "sysemu/cpus.h"
+#include "sysemu/gunyah.h"
+#include "sysemu/gunyah_int.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+
+bool gunyah_allowed;
+
+static int gunyah_init(MachineState *ms)
+{
+    return gunyah_create_vm();
+}
+
+static void gunyah_accel_instance_init(Object *obj)
+{
+    GUNYAHState *s = GUNYAH_STATE(obj);
+
+    s->fd = -1;
+    s->vmfd = -1;
+}
+
+static void gunyah_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+
+    ac->name = "GUNYAH";
+    ac->init_machine = gunyah_init;
+    ac->allowed = &gunyah_allowed;
+}
+
+static const TypeInfo gunyah_accel_type = {
+    .name = TYPE_GUNYAH_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_init = gunyah_accel_instance_init,
+    .class_init = gunyah_accel_class_init,
+    .instance_size = sizeof(GUNYAHState),
+};
+
+static void gunyah_type_init(void)
+{
+    type_register_static(&gunyah_accel_type);
+}
+type_init(gunyah_type_init);
+
+static void gunyah_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/Gunyah",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, gunyah_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+}
+
+static void gunyah_kick_vcpu_thread(CPUState *cpu)
+{
+    cpus_kick_thread(cpu);
+}
+
+static bool gunyah_vcpu_thread_is_idle(CPUState *cpu)
+{
+    return false;
+}
+
+static bool gunyah_check_capability(AccelCap cap)
+{
+    switch (cap) {
+    case CONFIDENTIAL_GUEST_SUPPORTED:
+        return true;
+    case CONFIDENTIAL_GUEST_CAN_SHARE_MEM_WITH_HOST:
+        /* fall-through */
+    default:
+        return false;
+    }
+}
+
+static void gunyah_accel_ops_class_init(ObjectClass *oc, void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+
+    ops->create_vcpu_thread = gunyah_start_vcpu_thread;
+    ops->kick_vcpu_thread = gunyah_kick_vcpu_thread;
+    ops->cpu_thread_is_idle = gunyah_vcpu_thread_is_idle;
+    ops->check_capability = gunyah_check_capability;
+};
+
+static const TypeInfo gunyah_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("gunyah"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = gunyah_accel_ops_class_init,
+    .abstract = true,
+};
+
+static void gunyah_accel_ops_register_types(void)
+{
+    type_register_static(&gunyah_accel_ops_type);
+}
+
+type_init(gunyah_accel_ops_register_types);
diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
new file mode 100644
index 0000000000..370add75f9
--- /dev/null
+++ b/accel/gunyah/gunyah-all.c
@@ -0,0 +1,70 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * (based on KVM accelerator code structure)
+ *
+ * Copyright 2008 IBM Corporation
+ *           2008 Red Hat, Inc.
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "qemu/typedefs.h"
+#include "hw/core/cpu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/gunyah.h"
+#include "sysemu/gunyah_int.h"
+#include "linux-headers/linux/gunyah.h"
+#include "qemu/error-report.h"
+
+static int gunyah_ioctl(int type, ...)
+{
+    void *arg;
+    va_list ap;
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+
+    assert(s->fd);
+
+    va_start(ap, type);
+    arg = va_arg(ap, void *);
+    va_end(ap);
+
+    return ioctl(s->fd, type, arg);
+}
+
+int gunyah_create_vm(void)
+{
+    GUNYAHState *s;
+
+    s = GUNYAH_STATE(current_accel());
+
+    s->fd = qemu_open_old("/dev/gunyah", O_RDWR);
+    if (s->fd == -1) {
+        error_report("Could not access Gunyah kernel module at /dev/gunyah: %s",
+                                strerror(errno));
+        exit(1);
+    }
+
+    s->vmfd = gunyah_ioctl(GH_CREATE_VM, 0);
+    if (s->vmfd < 0) {
+        error_report("Could not create VM: %s", strerror(errno));
+        exit(1);
+    }
+
+    return 0;
+}
+
+void *gunyah_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    do {
+        /* Do nothing */
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    return NULL;
+}
diff --git a/accel/stubs/gunyah-stub.c b/accel/stubs/gunyah-stub.c
new file mode 100644
index 0000000000..1edbe1433e
--- /dev/null
+++ b/accel/stubs/gunyah-stub.c
@@ -0,0 +1,13 @@
+/*
+ * QEMU Gunyah stub
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/gunyah.h"
+
+bool gunyah_allowed;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2a3eb4075d..fee1e5dab5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -87,6 +87,7 @@
 #include "sysemu/cpus.h"
 #include "exec/confidential-guest-support.h"
 #include "qom/object_interfaces.h"
+#include "sysemu/gunyah.h"
 
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -1682,6 +1683,8 @@ static void virt_build_smbios(VirtMachineState *vms)
 
     if (kvm_enabled()) {
         product = "KVM Virtual Machine";
+    } else if (gunyah_enabled()) {
+        product = "Gunyah Virtual Machine";
     }
 
     smbios_set_defaults("QEMU", product,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77f8c9c748..ea22b7d25f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -44,6 +44,7 @@
 #include "sysemu/tcg.h"
 #include "sysemu/qtest.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/gunyah.h"
 #include "kvm_arm.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
@@ -1500,7 +1501,7 @@ static void arm_cpu_initfn(Object *obj)
     cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
 
-    if (tcg_enabled() || hvf_enabled()) {
+    if (tcg_enabled() || hvf_enabled() || gunyah_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c15d086049..e6ac00d12e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -34,6 +34,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
+#include "sysemu/gunyah.h"
 
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
@@ -727,7 +728,7 @@ static void aarch64_host_initfn(Object *obj)
 
 static void aarch64_max_initfn(Object *obj)
 {
-    if (kvm_enabled() || hvf_enabled()) {
+    if (kvm_enabled() || hvf_enabled() || gunyah_enabled()) {
         /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
         aarch64_host_initfn(obj);
         return;
@@ -747,7 +748,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_GUNYAH)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
diff --git a/accel/Kconfig b/accel/Kconfig
index 794e0d18d2..020dda9737 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -17,3 +17,6 @@ config XEN
     bool
     select FSDEV_9P if VIRTFS
     select XEN_BUS
+
+config GUNYAH
+    bool
diff --git a/accel/gunyah/meson.build b/accel/gunyah/meson.build
new file mode 100644
index 0000000000..226eea0f2c
--- /dev/null
+++ b/accel/gunyah/meson.build
@@ -0,0 +1,7 @@
+gunyah_ss = ss.source_set()
+gunyah_ss.add(files(
+  'gunyah-all.c',
+  'gunyah-accel-ops.c',
+))
+
+specific_ss.add_all(when: 'CONFIG_GUNYAH', if_true: gunyah_ss)
diff --git a/accel/meson.build b/accel/meson.build
index 5eaeb68338..970bad6c5a 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -9,6 +9,7 @@ if have_system
   subdir('kvm')
   subdir('xen')
   subdir('stubs')
+  subdir('gunyah')
 endif
 
 # qtest
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 91a2d21925..459a8acd5c 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -2,5 +2,6 @@ system_stubs_ss = ss.source_set()
 system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_GUNYAH', if_false: files('gunyah-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
diff --git a/meson_options.txt b/meson_options.txt
index adc77bae0c..61c49bb7d4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -111,6 +111,8 @@ option('dbus_display', type: 'feature', value: 'auto',
        description: '-display dbus support')
 option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
+option('gunyah', type: 'feature', value: 'auto',
+       description: 'Gunyah acceleration support')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0a29d35fdb..d3a75f05c7 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -126,6 +126,7 @@ meson_options_help() {
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
+  printf "%s\n" '  gunyah          Gunyah acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
@@ -335,6 +336,8 @@ _meson_option_parse() {
     --disable-guest-agent) printf "%s" -Dguest_agent=disabled ;;
     --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=enabled ;;
     --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=disabled ;;
+    --enable-gunyah) printf "%s" -Dgunyah=enabled ;;
+    --disable-gunyah) printf "%s" -Dgunyah=disabled ;;
     --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
     --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
     --enable-hv-balloon) printf "%s" -Dhv_balloon=enabled ;;
-- 
2.25.1


