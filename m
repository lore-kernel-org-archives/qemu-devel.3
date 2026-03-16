Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8395F506CD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fn-00010x-Ic; Mon, 16 Mar 2026 09:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fk-00010Z-Id
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:52 -0400
Received: from p-west1-cluster5-host3-snip4-10.eps.apple.com ([57.103.66.161]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fi-0003gK-4H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:52 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 341DB1803D22; Mon, 16 Mar 2026 13:07:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666469; x=1776258469;
 bh=GqbrGjVsSYHpJGb1E0m/LNkTJonM61MZx0UKZwtjwTM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KuwPMuG4hf81WXktnArcevpoUZNLaz17Py5ZO4HH9eVdoZ2kMvCskeFLsdkhwYALMbD4/jxeXqcazldEmFqXqiEUNRf8SvvrYV6YNlByHxaug/6oAd7SFXtkE4dorFetlHzLmOtxOrjiihkGrDhHyQAAYeCeJZntc39cZYHQa51KvCJ7oSHhEwIImmKSUHn2MXK9FCXj7wdg0OA8pGgnqDVX5zXJzhPlunhaZWn0ouxTlj+L1qV3cdfCVqGXGiFlmbyDiIbozpRNt+c9y7wN3WoHHc5jKjorPIFj16Z6aSwE7HvD+/kRT+SE0+wQzqQodM+lVajF2AfwTtbewpdvLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 905B61803D21; Mon, 16 Mar 2026 13:07:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v20 15/15] hvf: arm: enable vGIC by default for virt-11.1 and
 later
Date: Mon, 16 Mar 2026 14:06:42 +0100
Message-ID: <20260316130642.13246-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=FqYIPmrq c=1 sm=1 tr=0 ts=69b800a4
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XVSz2ZBmX9fwo_obKv8A:9
X-Proofpoint-GUID: LuX6pvAQUTUlv-bIiCkz7bupl7ZPDwvk
X-Proofpoint-ORIG-GUID: LuX6pvAQUTUlv-bIiCkz7bupl7ZPDwvk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMCBTYWx0ZWRfX/1u+81SdCelH
 jXRDujtBWOJi7EdyyjN5bdNskMHgFNSrYBp9bsO4VtzXQm/Tu2Z0Z85zbAcEGJ0aq9yBIj/EGzp
 kM1MeZCFEYM0v8N1U9fc6AEd1TYK3ryz//NAyGStIJbjG1g1xgGqMyzATefy+v2vxi5M967t+I1
 eNEnuBLb3PPdV2xVjfEGOk4CtzMfbcreniBUAIdkLMtuUKwrBHiy3ca2LeW6psmnBXaAHEFXAwj
 elL6JGmJCcGI74xBAdBFDx+XsyXhFBXZj+oovbNtSBpWFBKDyyhEIDUym3ya4FI99yMf/Yebdba
 0RCsthgQXo231PTgCsfuS5TG7F5u3goKinf0zeGxruMSLWHQtwDsmk98p/LcDU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=875 malwarescore=0 phishscore=0 clxscore=1030 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160100
Received-SPF: pass client-ip=57.103.66.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Save states are incompatible between kernel-irqchip=on and off on HVF due to opaque vGIC state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c      | 11 +++++++++++
 hw/arm/virt.c            | 22 +++++++++++++++++++++-
 include/hw/arm/virt.h    |  2 ++
 include/hw/core/boards.h |  1 +
 include/system/hvf_int.h |  1 +
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 48c653630f..4e5a8c58a8 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -25,6 +25,7 @@
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
 bool hvf_nested_virt;
+bool hvf_kernel_irqchip_override;
 
 void hvf_nested_virt_enable(bool nested_virt) {
     hvf_nested_virt = nested_virt;
@@ -203,6 +204,13 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
+    if (mc->get_kernel_irqchip_default) {
+        bool kernel_irqchip_default = mc->get_kernel_irqchip_default(ms);
+        if (!hvf_kernel_irqchip_override) {
+            hvf_kernel_irqchip = kernel_irqchip_default;
+        }
+    }
+
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     if (ret == HV_DENIED) {
         error_report("Could not access HVF. Is the executable signed"
@@ -229,6 +237,8 @@ static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
                                    Error **errp)
 {
     OnOffSplit mode;
+
+    hvf_kernel_irqchip_override = true;
     if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
         return;
     }
@@ -268,6 +278,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+    hvf_kernel_irqchip_override = false;
     hvf_kernel_irqchip = false;
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, hvf_set_kernel_irqchip,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 391ec722c0..ad82a7356e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3443,6 +3443,16 @@ static int virt_get_physical_address_range(MachineState *ms,
     return requested_ipa_size;
 }
 
+static bool get_kernel_irqchip_default(const MachineState *ms) {
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    if (hvf_allowed) {
+        return !vmc->hvf_no_kernel_irqchip_default;
+    } else {
+        return true;
+    }
+}
+
 static const char *virt_get_default_cpu_type(const MachineState *ms)
 {
     return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
@@ -3509,6 +3519,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->get_physical_address_range = virt_get_physical_address_range;
+    mc->get_kernel_irqchip_default = get_kernel_irqchip_default;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
@@ -3740,10 +3751,19 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+
 static void virt_machine_11_0_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+    virt_machine_11_1_options(mc);
+
+    vmc->hvf_no_kernel_irqchip_default = true;
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+DEFINE_VIRT_MACHINE(11, 0)
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index dba8ac7f2f..d2575e14a0 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -135,6 +135,8 @@ struct VirtMachineClass {
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
+    /* HVF specific: support for kernel-irqchip=on introduced in QEMU 11.1 */
+    bool hvf_no_kernel_irqchip_default;
 };
 
 struct VirtMachineState {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index f85f31bd90..ad896ed0b7 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -279,6 +279,7 @@ struct MachineClass {
     int (*kvm_type)(MachineState *machine, const char *arg);
     int (*get_physical_address_range)(MachineState *machine,
         int default_ipa_size, int max_ipa_size);
+    bool (*get_kernel_irqchip_default) (const MachineState *machine);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 2621164cb2..ad7d375109 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -112,4 +112,5 @@ bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
 
+extern bool hvf_kernel_irqchip_override;
 #endif
-- 
2.50.1 (Apple Git-155)


