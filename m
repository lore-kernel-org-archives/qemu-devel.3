Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217ABD2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrl-0001nF-FY; Tue, 27 Jan 2026 13:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknor-0002Dz-Ig
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:42 -0500
Received: from p-west2-cluster5-host3-snip4-4.eps.apple.com ([57.103.71.87]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknoo-0003lo-7j
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:41 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 1F0B318001E6; Tue, 27 Jan 2026 18:29:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538573; x=1772130573;
 bh=3CEC0K0yCRaDKfMtdWsQ+wsxVh2pkGJE98uF0Yg+sIc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PalTnNdeECTn7ol7T/A6fg/7KNUgeMQgJuZzpFcgkqNmmkKHW+GIPi3abBTKqUvb5m3UGaUJAcF9xUyTahdq/c2aQj8nTcGR/5kdQCvuQujmqG7YK2NsLj/cpIRZCH6/uB+NH7ShG4lrmU9uXtIkF7Flxmk0nvHfahRNm3DXbsR0nEd5Fy4QgAKmAeKkpIWX+BuJp/oo4a60X2jMhZulQldP4lD+79jgQYeyIKfyahnTIo086Wf/iKPVtne5tfuEcH/WZfXZlNAyDB3lSjzj3StIS11mcppyObwyREgAg+XnVuyXkZnF5qSzNCkhYMEfP8CKDe61a08JH4LzzEYUvw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 89FC718001E0; Tue, 27 Jan 2026 18:29:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 17/22] whpx: arm64: clamp down IPA size
Date: Tue, 27 Jan 2026 19:27:57 +0100
Message-ID: <20260127182805.73212-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HUSDZ4HRI8y-y4ayE25e2nobPDpKYHR8
X-Authority-Info-Out: v=2.4 cv=bJQb4f+Z c=1 sm=1 tr=0 ts=6979040d
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Pkv3TnVKpG-98NsSaS0A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX26nQ2EpbQ98I
 wY8iUgdmMIvwbo7IUm9PmpdgAcqYx4kqm/QBF9/PeEkF3vFWVWYhrZQFOsr3HLJSDk33ZX+i3Rl
 TucHhkgrkleCpYqkZtxcaQF7h1sR0o1xGHFQoAmSqKuG58LTz/Q1K8RUKOlMJ5pEmX2PRENsfqT
 qsceeGHeWDmogMgsPknBpJTtBWlkpXyQlLL9pwJ/xvOar0Cv76XdUJJh7TRqfO8AKrP+tMUBwZN
 jDrW9u7ijPBeEKIjfg58UTQeJv3Ct4PpMOy09J8QD2PcHZjYoA9e5EUosHJIgJfJPy/YRZcoZ6n
 c3mocI+PBAuPbe2Mno/Q71PyGVqAN5PrCkiSCnJ46thJmIh795pVQBXUWr3mfI=
X-Proofpoint-ORIG-GUID: HUSDZ4HRI8y-y4ayE25e2nobPDpKYHR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 clxscore=1030 bulkscore=0
 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAAB7dLqxbQE+RaG+pXmVsdIPXNVSlJsQF36+lwdbFrjD4A8//v/rEWv8/1mPzaRVocUWmK2WHvJJmiWZzkPSL6u5cZnBtJwhlhJm01X3jf2RzsfPdfVSk40oJTFGUxwXOacxSReBbHHVWmSwI84sJSHAop7m6zAvLcpy4GClV5II9gYqUpd3k89CeADtssk/spr03MLlAlgPKeK8fWBxPAVJ2Os73Rd1xiTCucFDIu10nRu/Frfq7DeivlAnh5wgfPCi6QGae2o8bWmrfeHtM6nW2a5L8oJ4mcf3F3T2kFx/sXHNODEhz0izWf3Y/1lyncjxkbxeSAmaWC2BeHRxYdi21Ey9k6O8WM7gyQWYNmG1Tgvh1zj9FZyYNqJu8oczhoR7O7jguLxghmG6m+fsP3sXKq2PhuXzABLdq3k12E9ZPZdtuhZdq8Qs1bLnJdlRM60LOtOaQAvI7UEvIVC2GcZO5TxEbPkGSDW4rugr2iqsiyfoGhOvYDc9aEPT81a2ZvbJcbRqm/ImTOBHwRWs8YRJ6tN0HoJ+XfGqCwrZnxobgIN63zMcuRrKsstISns1fi8b4mVoukY5HiFqpnTRY5SY769FTauce+9pBbCbeqaES8uiSUXEt+qlQKoijBDo7dqg7fKNt0q82H+LOeHPEOl0npy4tLG6nIbENUZRP4FN+9ZYS1ha34HtBKvUnbX+nyxotMQ/rQfiYkq/kFexcfqrXL/scX8SiS2DpMiCwPH7JVrSn6gC2loWw7WaAcm/nTGurmVfG4Omeqw/B4lcai3BQhO4zuB//hjxRjsLKjkgPBMieYgd9GaBOUE0YzUfrSiRQ7JC2NnAKXLTDevUooHMnnK/DCl1WjUBMPcjmBx9lHp+81ncpMGS4rthRMTvnUcm7oR8PBwK6G8fxh8/k6+qxPEMXPyzclHCA==
Received-SPF: pass client-ip=57.103.71.87;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Code taken from HVF and adapted for WHPX use. Note that WHPX doesn't
have a default vs maximum IPA distinction.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt.c               | 32 ++++++++++++++++++++++++++
 include/hw/core/boards.h    |  1 +
 target/arm/whpx/meson.build |  2 ++
 target/arm/whpx/whpx-all.c  | 45 +++++++++++++++++++++++++++++++++++++
 target/arm/whpx/whpx-stub.c | 15 +++++++++++++
 target/arm/whpx_arm.h       | 16 +++++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9e989b721b..7a9bcd15fd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -72,6 +72,7 @@
 #include "hw/core/irq.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "whpx_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
@@ -3329,6 +3330,36 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
+     * the maximum. whpx_arm_get_max_ipa_bit_size() conveniently only
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
@@ -3428,6 +3459,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
+    mc->whpx_get_physical_address_range = virt_whpx_get_physical_address_range;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 07f8938752..0b2aefb126 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -278,6 +278,7 @@ struct MachineClass {
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
index 192d7ec7a8..850f6ec81f 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -35,6 +35,7 @@
 #include "system/whpx-accel-ops.h"
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
+#include "whpx_arm.h"
 #include "hw/arm/bsa.h"
 #include "arm-powerctl.h"
 
@@ -633,6 +634,40 @@ static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
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
+        error_report("WHPX: failed to get supported "
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
@@ -706,6 +741,7 @@ int whpx_init_vcpu(CPUState *cpu)
     val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);
     whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
 
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
     return 0;
 }
 
@@ -722,6 +758,8 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int pa_range = 0;
 
     whpx = &whpx_global;
     /* on arm64 Windows Hypervisor Platform, vGICv3 always used */
@@ -732,6 +770,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


