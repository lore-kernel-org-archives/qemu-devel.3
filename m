Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57300CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Sxo-0001fS-TE; Thu, 16 Oct 2025 14:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxn-0001dw-CN
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:35 -0400
Received: from p-east3-cluster6-host1-snip4-10.eps.apple.com ([57.103.85.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxd-000262-1J
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:35 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 A518618003BE; Thu, 16 Oct 2025 18:44:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=QN0Y+jb4TLvDyTZQNjsuK0fm92amTX0w5qulKq1Wcdo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OHGMg/px8XZOt1TtoGc2+skgX09F32iUKIFG95VqFmR4+j7DkW7sYJlKNEVovRy4Gf+/sp3oyXvF6D7oE3N/JVfK3hQgfW1YzKzj/YkHxzzPvBNQbJLWVvj5fj2djt1d11rYIJInEtx3Fcu9doSC3QRHYdVpRt+YvHhjyjjBFdDkvMx1+fwjWHYKA+hpS5BLi+IBU3LkUwkHqcgnVgHSaINriRbJiBMASLL/DkrSc7o2SSuQLHDbuWvB6sUOxNXk+i+iJHXYBGPYpsL4PyjQ89ZDwTviqZD2FQe/qmD6tBpLxBuqcNDxwh75DMm0O92BAsgGnl0mW56YcacBIRozvw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 989FE1800177; Thu, 16 Oct 2025 18:44:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 17/24] whpx: arm64: clamp down IPA size
Date: Thu, 16 Oct 2025 20:44:06 +0200
Message-ID: <20251016184413.69870-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzNyBTYWx0ZWRfX8vcDi6+kEkFY
 0jHHciSHdhMcbs1PprYCvLtkHj1zMLz8tMU8RKyChHjXvuhP5WyJ5Ve9LLkBzXVF8lKp76lhKj9
 moYsv15fnVNE1h+Eklw64EVSi/yzGykkM0OuoYzTD/sCpEehLetoNRVg4oac8dWayWLUZ69IwuP
 26SdrDszqrMiXTwOIEpnTcxYX5bFiOzu5aP+C+9umuInUxoZx+aYHuMydFPITGNyBCIiKuNBNwg
 5GefVu6oZVJzfgH6AZI4rYnIIFm2iBRbZuiANO6Vy6/ezTOzOTmu5Rpt00IzMKFbnscFpEYNk=
X-Proofpoint-ORIG-GUID: 397aL8Fm8xdsyeOT5ksG9r7ahKQoshcR
X-Proofpoint-GUID: 397aL8Fm8xdsyeOT5ksG9r7ahKQoshcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510160137
X-JNJ: AAAAAAABL23/ytAWXdrjLd37WRJuRmgCF/Wt/HUj9QtVvH53wpT7clYxBDINT4E6sPF8m0HyYfrxiAuW5D/p4vOz2N1crYuSJ9L1f2EMqfqkCpQVA9KhdHeaPxnGp77DuzoVzDdllPfLCrXfoFRLzT8C1Wb7/u9jGGuK/NZhZQgVioH9BvXvSdU/qokaVQrb4QfCfbIL75xhEBNjaz+SrNfu2fBNR9nEg4KgmXS8aTPUdKNXjQLD48ySVPEgkHmg+4y5tsqNpOO7NsyY42iIVDp0AIO6A1Lc8WLoYZhY7Jf746FLNi0fKoU55JM8rc3RI4I6je2fPQQ6UkAsqQv1/68FipPSZ6S4EDglJMMy7PcLeqQ9sOtkS/9NOPEQF5t/wS7NdAmcqtzAwvMhXhXx+mjxeW/2JHZyuPv6l9LE0faEmfPkaXIMwDmREfCo7mzaDsIWE1/ZXhfbOKXsaABmn/BFz4E4KFa63y5YAZg/3VzUJJVG7hNoKElnQ9aWsMdKKxWKsKhmmNKNcey+tnv3AyBMapj1/GKkyXTMJ/9g+j0Z5r8PfnImoHm2FG0NiFq5OD1IHWEPCprQRZ+6bKFN/jw+WaJmEIEr8XN+Wax/iUUsN2trvnlTPmUsKNh2uhAOWbA6/f2uHwgKZHrw82zg7goIt2zVeZnlP2EzVifEVMBI60BuDNzQyXlUDjol783Ax6/ArbN1Fc/+
Received-SPF: pass client-ip=57.103.85.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index dbf9a28b8d..7afc275f79 100644
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
@@ -3253,6 +3254,36 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
@@ -3345,6 +3376,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
+    mc->whpx_get_physical_address_range = virt_whpx_get_physical_address_range;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 665b620121..3d01fb8cc9 100644
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
index 8c34650765..e6bafb0601 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -35,6 +35,7 @@
 #include "system/whpx-accel-ops.h"
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
+#include "whpx_arm.h"
 #include "hw/arm/bsa.h"
 #include "arm-powerctl.h"
 
@@ -657,6 +658,40 @@ static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
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
@@ -735,6 +770,7 @@ int whpx_init_vcpu(CPUState *cpu)
     val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);
     whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
 
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
     return 0;
 
 error:
@@ -757,6 +793,8 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features = {0};
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int pa_range = 0;
 
     whpx = &whpx_global;
     /* on arm64 Windows Hypervisor Platform, vGICv3 always used */
@@ -767,6 +805,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
2.50.1 (Apple Git-155)


