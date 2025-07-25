Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D9EC87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEDr-0007by-Gb; Fri, 25 Jul 2025 04:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDh-0007O7-U6
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:03 -0400
Received: from p-west3-cluster2-host12-snip4-8.eps.apple.com ([57.103.74.101]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDf-0001r8-Uw
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:01 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id
 59C9A1800099; Fri, 25 Jul 2025 08:55:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jJOGyIhLIcX1vAvbV7H3PNba35G2QEX+o9kg0SfkkBA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=IHN7IxneU/oUnG516IuPadMAFDWS4LOqGOrOLAev8lknNnTuFqnwGhfXvizrS+QExZllGRz3kIMpE6R/GmVuxaj9wU/J5s+kn32kaKL90zJS06CIx+FEbqKowEdGZUq0h6P06KnpIUjOuUFQKf6LYuw+lN8UaNMSyeUDmb00o0hniDtDZv+2FS2xS5HN0Gkz5eqOEVzUz2D4C3fPApAEFFvCKn1REqoPb/AGVt16cYdajGTYHyvgmLE8IhiO4DyNJqEqSYudfRp91qMJuHhEmdKSWgm3JJRNGhob1xoXHOJXJIMaP0rrcj+0f1/cdcBgzTku6L/zay6sBs2M3Xrs2g==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id
 8208518000B9; Fri, 25 Jul 2025 08:55:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 2/9] accel, hw/arm,
 include/system/hvf: plumbing changes for HVF vGIC
Date: Fri, 25 Jul 2025 10:55:38 +0200
Message-Id: <20250725085545.93619-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725085545.93619-1-mohamed@unpredictable.fr>
References: <20250725085545.93619-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NSBTYWx0ZWRfX4tEzheQQIQrJ
 Kv+Db5fvqDBwekEAY43nup/T7B3upozvKjL3PI80X7VOMQCESXiiw5tOL1wll6QSnQ3roPcneVO
 +4G/xsAjJeg7Uv7oOeL9TSXl2otl3dFMg0IOdT6OleIb+QPL3763XrT3975vJEOz1h3tFEa86Fb
 /Tr2k4owNqQJS0bsfJ1z4b46sy0ItMPhrCJfwxPEC8aUiPMd55fdhxXoczVNSpFt8hUzJQLJ7B7
 IrZzKWbhBBmY4Ju+ywz2EqCDBWpcPzNoqzOu+H4sdAOCXBKoeNfpNK8TRADV58GtXoJP7UHWE=
X-Proofpoint-GUID: 5VYpoCsbgTCW18uBm0bIHD1_cGAvpEgy
X-Proofpoint-ORIG-GUID: 5VYpoCsbgTCW18uBm0bIHD1_cGAvpEgy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 clxscore=1030 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250075
Received-SPF: pass client-ip=57.103.74.101;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

Misc changes for HVF vGIC enablement.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c        | 44 ++++++++++++++++++++++++++++++++++++++
 accel/stubs/hvf-stub.c     |  1 +
 hw/arm/virt.c              | 17 +++++++++------
 hw/intc/arm_gicv3_common.c |  3 +++
 include/system/hvf.h       |  3 +++
 system/vl.c                |  2 ++
 6 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index e67a8105a6..d9408e259f 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,6 +10,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-common.h"
 #include "accel/accel-ops.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -20,6 +22,7 @@
 #include "trace.h"
 
 bool hvf_allowed;
+bool hvf_kernel_irqchip;
 
 struct mac_slot {
     int present;
@@ -290,6 +293,41 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+#ifdef __aarch64__
+    OnOffSplit mode;
+    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_SPLIT_ON:
+        hvf_kernel_irqchip = true;
+        break;
+
+    case ON_OFF_SPLIT_OFF:
+        hvf_kernel_irqchip = false;
+        break;
+
+    case ON_OFF_SPLIT_SPLIT:
+        error_setg(errp, "HVF: split irqchip is not supported on Arm.");
+        break;
+
+    default:
+        /*
+         * The value was checked in visit_type_OnOffSplit() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+#else
+    error_setg(errp, "HVF: setting irqchip configuration not supported on x86_64.");
+#endif
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -297,6 +335,12 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+    hvf_kernel_irqchip = true;
+    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
+        NULL, hvf_set_kernel_irqchip,
+        NULL, NULL);
+    object_class_property_set_description(oc, "kernel-irqchip",
+        "Configure HVF irqchip");
 }
 
 static const TypeInfo hvf_accel_type = {
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index 42eadc5ca9..6bd08759ba 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -10,3 +10,4 @@
 #include "system/hvf.h"
 
 bool hvf_allowed;
+bool hvf_kernel_irqchip;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f..a26bde4c75 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -830,7 +830,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
     qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
-    if (!kvm_irqchip_in_kernel()) {
+    if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
         qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
@@ -853,8 +853,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
 
-        if (!kvm_irqchip_in_kernel()) {
-            if (vms->tcg_its) {
+        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
+            if (vms->its && vms->tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
@@ -864,7 +864,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                  ARCH_GIC_MAINT_IRQ);
         }
     } else {
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
             qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
@@ -2058,11 +2058,16 @@ static void finalize_gic_version(VirtMachineState *vms)
         /* KVM w/o kernel irqchip can only deal with GICv2 */
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         accel_name = "KVM with kernel-irqchip=off";
-    } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
+    } else if (hvf_enabled()) {
+        if (!hvf_irqchip_in_kernel()) {
+            gics_supported |= VIRT_GIC_VERSION_2_MASK;
+        }
+        gics_supported |= VIRT_GIC_VERSION_3_MASK;
+    } else if (tcg_enabled() || qtest_enabled()) {
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         if (module_object_class_by_name("arm-gicv3")) {
             gics_supported |= VIRT_GIC_VERSION_3_MASK;
-            if (vms->virt) {
+            if (vms->virt && !hvf_enabled()) {
                 /* GICv4 only makes sense if CPU has EL2 */
                 gics_supported |= VIRT_GIC_VERSION_4_MASK;
             }
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e438d8c042..7c0eb5eb1e 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -32,6 +32,7 @@
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
+#include "system/hvf.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -662,6 +663,8 @@ const char *gicv3_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
         return "kvm-arm-gicv3";
+    } else if (hvf_irqchip_in_kernel()) {
+        return "hvf-arm-gicv3";
     } else {
         if (kvm_enabled()) {
             error_report("Userspace GICv3 is not supported with KVM");
diff --git a/include/system/hvf.h b/include/system/hvf.h
index d3dcf088b3..dc8da85979 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -26,8 +26,11 @@
 #ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
+extern bool hvf_kernel_irqchip;
+#define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
 #else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
+#define hvf_irqchip_in_kernel() 0
 #endif /* !CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c6..1c072d15a4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1773,6 +1773,8 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
                                    false);
         object_register_sugar_prop(ACCEL_CLASS_NAME("whpx"), "kernel-irqchip", value,
                                    false);
+        object_register_sugar_prop(ACCEL_CLASS_NAME("hvf"), "kernel-irqchip", value,
+                                   false);
         qdict_del(qdict, "kernel-irqchip");
     }
 
-- 
2.39.5 (Apple Git-154)


