Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACE9CD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAFM-0002SP-1u; Wed, 29 Apr 2026 15:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEz-00027H-A7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:35 -0400
Received: from p-west3-cluster5-host9-snip4-4.eps.apple.com ([57.103.72.87]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEt-0000XI-99
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:32 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 CD42F18002FE; Wed, 29 Apr 2026 19:06:20 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJB01fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YDRhQVXAVWBlcUeQ1dHUUOVhlaDFIPWw4cFktGExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489584; x=1780081584;
 bh=/HRGlWLuPFRz+dTWvUYo4FsxGpbjTjjRzSa0MkdCpkU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KJWnFtE1fx6DZYomDHGzYTbT2mTYawxvVhOZKXzubCI1/pXHcMcm0oEQlfZuH2p2XQ3vMEjKAPplyANsIT7LgHFLYIaKgPcOM3dTpVi3a6dB9b75MCukyY0vOxKppa+muInJAPt/LXCrkQNKRJLBBnAOcimBz/l9ViSDuH5cJnrNZ7QDEvPvRim9aojvGHOdXum0/zB4lyaTMtNe7klb6wT9li9dPJrLoZuYflvXLIaGnwhtYxbsF0bHF3dYXSiTtgmeom7qj4nuTdWwqhOX2eOZ9njS+BzbhJIfPCmwIN3lWhZXeCQN1c9mCSOx5gtcd2SRFMS47JOCq+aT7hs+0g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 7BA1118000B2; Wed, 29 Apr 2026 19:06:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v21 15/15] hvf: arm: enable vGIC by default for virt-11.1 and
 later
Date: Wed, 29 Apr 2026 21:05:32 +0200
Message-ID: <20260429190532.26538-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX+0TMmKyr6yhw
 QjwkQTxPQrFiSWvAAuTPB+sU1Rej3kxV05hBCTgz8qR4Ubd94+IjUuhqDvO9noTrvDKZ1Qs5UPw
 iD+ogko8iT3ij8evzhrt9sVCKrumHzgU9NM938PlIM08UhW9rUPXjgVrFGxFCiGY5vsTp0r60Ci
 QxFT1HPDu2sXuFF2lhnl4MRG1wgu6Ksg2uJKXRG/xrAj1V1ImJ7UXUFenufQatW3b7VdlItRjOy
 A0ZuLG9GIATwKMOnGdSaVjXeto24zXMBHKqppBTAL02nybWzAoQFyeOwzcitx5O8LyWS+gbgnXZ
 z3LiNNouVFHrKjA/ld07HKH6ETQncw2s/fkiINMpB9mNH8E7v9v2qZo9FBAKLE=
X-Proofpoint-GUID: SEtOQLs6EVwDf8RR6I4lFViaEE2pVzA_
X-Authority-Info-Out: v=2.4 cv=Hq172kTS c=1 sm=1 tr=0 ts=69f256ae
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PDSgDrDRFnq58FnMM9AA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SEtOQLs6EVwDf8RR6I4lFViaEE2pVzA_
Received-SPF: pass client-ip=57.103.72.87;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 accel/hvf/hvf-all.c      | 11 +++++++++++
 hw/arm/virt.c            | 14 ++++++++++++++
 include/hw/arm/virt.h    |  2 ++
 include/hw/core/boards.h |  1 +
 include/system/hvf_int.h |  1 +
 5 files changed, 29 insertions(+)

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
index ad0a459987..3464cf9f9e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3769,6 +3769,16 @@ static int virt_get_physical_address_range(MachineState *ms,
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
@@ -3835,6 +3845,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->get_physical_address_range = virt_get_physical_address_range;
+    mc->get_kernel_irqchip_default = get_kernel_irqchip_default;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
@@ -4079,8 +4090,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
 
 static void virt_machine_11_0_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_11_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    vmc->hvf_no_kernel_irqchip_default = true;
 }
 DEFINE_VIRT_MACHINE(11, 0)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index fc7950da85..13e135a460 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -138,6 +138,8 @@ struct VirtMachineClass {
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
+    /* HVF specific: support for kernel-irqchip=on introduced in QEMU 11.1 */
+    bool hvf_no_kernel_irqchip_default;
 };
 
 struct VirtMachineState {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index ca63304c95..29c68931d8 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -280,6 +280,7 @@ struct MachineClass {
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


