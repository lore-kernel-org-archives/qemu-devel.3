Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09337C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 08:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui7Up-0004nm-0D; Sat, 02 Aug 2025 04:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rq-0007aL-D2
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:34 -0400
Received: from p-east3-cluster5-host9-snip4-7.eps.apple.com ([57.103.86.218]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Ro-00056Z-9D
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:34 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 8EFA7180016C; Sat,  2 Aug 2025 08:18:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=5ADiioO3Dt6F4oQtALG/04oDYIDiIfZXV0IYi5u9T6w=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=ceTObE4Mb5EljCYMSdlMK8kSJpbccjMQ6F2G1hgYoETZSAolemvUf1dgy+7RWWy1V1jZlvutaE5bKWnPLTAUBzJHi281iT8TuUZFT+8UaMuDmNqrt6kaWc5+OmNTLybsZKHERbLCCtrI4nNguQ1DUwgcAd3TU/YxP2q2E+XisD23cNC1tUCAeQChcaumyHBRQBdfTr+eL5lTvOvMCV2MHlXVUDZUWvxxDmUYvHqIV7tEJzRHU6Tn3DTMal9ZjFVkgMjGTVE6V84bR6rOc877nY9TI79cFPt8Jdqg2OMbQmxDLQTsZ7q5iz6N/8MdvtykoKRLOs/g1flbO1G2mymihA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 D6C371800105; Sat,  2 Aug 2025 08:18:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 11/14] whpx: arm64: clamp down IPA size
Date: Sat,  2 Aug 2025 10:17:57 +0200
Message-Id: <20250802081800.76030-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802081800.76030-1-mohamed@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3MCBTYWx0ZWRfX5gh+sh8MHTFX
 IoKixUsYwr1uaGm2bNQytYFzB3OHHUzri7yJLQEvw/1G3pPSNa0kwTJ3dv4vV5TUyv0qJpZ7gcz
 gheiADNrJEVN0Lg/jxFdNWNBm8e71UP6rtRY/epXnlGKUteNMaf+FG8f1s/LVmx3K4XvNk9Jr8k
 cDVIwixiA7FLgAZw3G5ctJ1WAOXvwR8DMDRkTMgS09QGw4b14Z4XeiY/XkMe1lnipDxLmwULs92
 YvoKzLyiWC+htGK0WtjJuTcRqAxO1AliT5GaO0siGFatvhNBOAoW+m7KWbNbLKp0vRAFM4ZVs=
X-Proofpoint-GUID: -QjNvoS9Yanh3wY_CQaailB0pQ9DngqO
X-Proofpoint-ORIG-GUID: -QjNvoS9Yanh3wY_CQaailB0pQ9DngqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1030 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508020070
Received-SPF: pass client-ip=57.103.86.218;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Code taken from HVF and adapted for WHPX use. Note that WHPX doesn't
have a default vs maximum IPA distinction.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c               | 32 ++++++++++++++++++++++++++
 include/hw/boards.h         |  1 +
 target/arm/whpx/meson.build |  2 ++
 target/arm/whpx/whpx-all.c  | 45 +++++++++++++++++++++++++++++++++++++
 target/arm/whpx/whpx-stub.c | 15 +++++++++++++
 target/arm/whpx_arm.h       | 16 +++++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1c695c0642..3682d42482 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -70,6 +70,7 @@
 #include "hw/irq.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "whpx_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
@@ -3162,6 +3163,36 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     return fixed_ipa ? 0 : requested_pa_size;
 }
 
+static int virt_whpx_get_physical_address_range(MachineState *ms)
+{
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+
+    int max_ipa_size = whpx_arm_get_ipa_bit_size();
+
+    /* We freeze the memory map to compute the highest gpa */
+    virt_set_memmap(vms, max_ipa_size);
+
+    int requested_ipa_size = 64 - clz64(vms->highest_gpa);
+
+    /*
+     * If we're <= the default IPA size just use the default.
+     * If we're above the default but below the maximum, round up to
+     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only
+     * returns values that are valid ARM PARange values.
+     */
+    if (requested_ipa_size <= max_ipa_size) {
+        requested_ipa_size = max_ipa_size;
+    } else {
+        error_report("-m and ,maxmem option values "
+                     "require an IPA range (%d bits) larger than "
+                     "the one supported by the host (%d bits)",
+                     requested_ipa_size, max_ipa_size);
+        return -1;
+    }
+
+    return requested_ipa_size;
+}
+
 static int virt_hvf_get_physical_address_range(MachineState *ms)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
@@ -3256,6 +3287,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
+    mc->whpx_get_physical_address_range = virt_whpx_get_physical_address_range;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f94713e6e2..dde8013bd7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -276,6 +276,7 @@ struct MachineClass {
     void (*wakeup)(MachineState *state);
     int (*kvm_type)(MachineState *machine, const char *arg);
     int (*hvf_get_physical_address_range)(MachineState *machine);
+    int (*whpx_get_physical_address_range)(MachineState *machine);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
index 1de2ef0283..3df632c9d3 100644
--- a/target/arm/whpx/meson.build
+++ b/target/arm/whpx/meson.build
@@ -1,3 +1,5 @@
 arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
 ))
+
+arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 127e99cda4..79c200495e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -35,6 +35,7 @@
 #include "system/whpx-accel-ops.h"
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
+#include "whpx_arm.h"
 #include "hw/arm/bsa.h"
 #include "arm-powerctl.h"
 
@@ -641,6 +642,40 @@ static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
 {
 }
 
+uint32_t whpx_arm_get_ipa_bit_size(void)
+{
+    WHV_CAPABILITY whpx_cap;
+    UINT32 whpx_cap_size;
+    HRESULT hr;
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
+        sizeof(whpx_cap), &whpx_cap_size);
+    if (FAILED(hr)) {
+        error_report("WHPX: failed to get supported"
+             "physical address width, hr=%08lx", hr);
+    }
+
+    /*
+     * We clamp any IPA size we want to back the VM with to a valid PARange
+     * value so the guest doesn't try and map memory outside of the valid range.
+     * This logic just clamps the passed in IPA bit size to the first valid
+     * PARange value <= to it.
+     */
+    return round_down_to_parange_bit_size(whpx_cap.PhysicalAddressWidth);
+}
+
+static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
+{
+    uint32_t ipa_size = whpx_arm_get_ipa_bit_size();
+    uint64_t id_aa64mmfr0;
+
+    /* Clamp down the PARange to the IPA size the kernel supports. */
+    uint8_t index = round_down_to_parange_index(ipa_size);
+    id_aa64mmfr0 = GET_IDREG(isar, ID_AA64MMFR0);
+    id_aa64mmfr0 = (id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
+    SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
+}
+
 int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
@@ -721,6 +756,7 @@ int whpx_init_vcpu(CPUState *cpu)
     whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1,
                               val);
 
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
     return 0;
 
 error:
@@ -743,6 +779,8 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features = {0};
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int pa_range = 0;
 
     whpx = &whpx_global;
     /* on arm64 Windows Hypervisor Platform, vGICv3 always used */
@@ -753,6 +791,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    if (mc->whpx_get_physical_address_range) {
+        pa_range = mc->whpx_get_physical_address_range(ms);
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
diff --git a/target/arm/whpx/whpx-stub.c b/target/arm/whpx/whpx-stub.c
new file mode 100644
index 0000000000..32e434a5f6
--- /dev/null
+++ b/target/arm/whpx/whpx-stub.c
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * WHPX stubs for ARM
+ *
+ *  Copyright (c) 2025 Mohamed Mediouni
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "whpx_arm.h"
+
+uint32_t whpx_arm_get_ipa_bit_size(void)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/whpx_arm.h b/target/arm/whpx_arm.h
new file mode 100644
index 0000000000..de7406b66f
--- /dev/null
+++ b/target/arm/whpx_arm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * WHPX support -- ARM specifics
+ *
+ * Copyright (c) 2025 Mohamed Mediouni
+ *
+ */
+
+#ifndef QEMU_WHPX_ARM_H
+#define QEMU_WHPX_ARM_H
+
+#include "target/arm/cpu-qom.h"
+
+uint32_t whpx_arm_get_ipa_bit_size(void);
+
+#endif
-- 
2.39.5 (Apple Git-154)


