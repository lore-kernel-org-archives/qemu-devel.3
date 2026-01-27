Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488B5D2FEDD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4o-0000Ww-35; Tue, 27 Jan 2026 13:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4H-0000Jf-1f
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:40 -0500
Received: from p-east2-cluster6-host6-snip4-10.eps.apple.com ([57.103.76.231]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4C-0007az-A0
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:34 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 8F21118000AE; Tue, 27 Jan 2026 18:45:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539531; x=1772131531;
 bh=oatTtAt4teOQxb6j4BZyrH73W+FjN+jfcjbUb60eS04=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ChXoPGAk1rQEL5NWKIHRTFx+uKHdgTETB7TjeEk8VZvbOGbI/2LqCIK7RAoPrDU32r62Q/JQfT77QZ84ULvht8gHaX+FVy9FywUZqLQef/CcNlS26csjMtSke3a2iCWLFNoNFy+nlmC9YhZl3zyXfhqTayCEMNC2vawgiK/yRVcBXsShXrlRkAZztmKKLm0WgbA9G7XyFDvEFmX/QCog1+N+8l/8pjLBI2TQW1PwmvXXlNk2a1Ci4MjPRlJn4ErVuQMFb2Mm3moi53QCeh3iZDKsn55C/8H+d8aZOR84FV1MWLPymNOFcf+jSCXti8lBM7q8dWUDlB0+QWD0op5kwQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 E861B180066A; Tue, 27 Jan 2026 18:45:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 02/12] accel, hw/arm,
 include/system/hvf: infrastructure changes for HVF vGIC
Date: Tue, 27 Jan 2026 19:45:13 +0100
Message-ID: <20260127184523.5357-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=LNdrgZW9 c=1 sm=1 tr=0 ts=697907cb
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=n4FVybPFTm1vobq06wUA:9
X-Proofpoint-ORIG-GUID: KnBOPV2HsgAfnLe6ohU7GbhbW7pgWKcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX5L15n8e+VpwV
 ycAH9h/BRHWxzcgAMeMpLbs1p2m6OiR9wfLBb/5Za1N6S/6aIkr9Syyo5DL793+C0X/x9YVO5E2
 D6rg4volxyPmkfE/mDzLx6zUMtXQDXFCtNPjvEVa3OQCxxDnYY1hSPSLmKpQRWC47olvL02x+Vo
 6q8gzAhjaumBhVxOEpT7ULQ8AXkInieIhoF8vvcyLHAVtPT4wd/rcFk9RTuB8yNa1bPhOZw2qbg
 v3z0Xh1Os9K39Gztch1O+imQOE1Yp8DCS/KDs2f3dsRedGNQraBZh7MoSw94w8bEFwowh/1v4Cb
 e2X0M8gkdqc2/09K7RJ
X-Proofpoint-GUID: KnBOPV2HsgAfnLe6ohU7GbhbW7pgWKcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1030 adultscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601270153
X-JNJ: AAAAAAABZQh2E1/X5TFLZW3alVTp6r6Khy1v4gSxGuIQf8YpHJIXCVB7BlpX1Nq/d6FBhJn5ylx2VMVibMSoNXdyGe4bOxo3ggB0gBSJjL+u/POnx5CKsNuR9fOIi5EKkqq7zjzJk8d2hZsbpzN5snlgv8iQmvwfxHozBYSjWDI5qngP2LHVG8qa/El6lKBASu7XDi2lvOaCaYx60NmOQPCKTQk9vaRDco//h4CUUbNBsJpSrGT5kxPBnztT5NDe05SKMbCFHemPN/t9Hk22EXaGU77blSxOBH0LFxS6B9trHEyxsl454B8kFI1I6eoO/u5qsvwN/CGSjup3U6J0XP/3+7FSiFQnq9yJ8B8tOAdmxg3rGG4tI9pYm4Epue4NQdBGo5WZVpR9QTuo0We8AwhA9+4ZrtlG8rtUtXiStjZ6A4kQOpdObcA8XR7quOThckb1ypGv4ZMLKKEriflSxRdeXBEkWlfrwfv1RPb/5+VthhXPS6Y3RVRqJ+dd0Lb6IRjKU93ND+N3+sTeMNL1NM0pDXpp96vP+QzTACnm/2whQGLrlYYmi4SFnqOj6OBYUAGialbxjfOXRGwAg5WoN3Mu14GFsDAlCZGl/H3lb3mOj9rJC60ss8eBVZIhaMz9sN0GmLDKFvQCrASijjwAvEirbqfbBQcCKiY0rjWNXD1IuXFpmC9ZXN9B74ZbUsMxGn0zwtU9VUtEfVGu/F1X8H+YuxSIYTnzVsjuM/W4Dy9asNWitqpxOFooMA==
Received-SPF: pass client-ip=57.103.76.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

Misc changes needed for HVF vGIC enablement.

Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
Keeping an #ifdef here in case we end up supporting that...

However, given that x86_64 macOS is on its way out, it'll probably (?) not be supported in Qemu.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c        | 50 ++++++++++++++++++++++++++++++++++++++
 accel/stubs/hvf-stub.c     |  1 +
 hw/arm/virt.c              | 24 +++++++++++++++---
 hw/intc/arm_gicv3_common.c |  3 +++
 include/system/hvf.h       |  3 +++
 system/vl.c                |  2 ++
 6 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 033c677b6f..929f53fd37 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,6 +10,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-common.h"
 #include "accel/accel-ops.h"
 #include "exec/cpu-common.h"
 #include "system/address-spaces.h"
@@ -22,6 +24,7 @@
 #include "trace.h"
 
 bool hvf_allowed;
+bool hvf_kernel_irqchip;
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -217,6 +220,43 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    OnOffSplit mode;
+    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_SPLIT_ON:
+#ifdef HOST_X86_64
+        /* macOS 12 onwards exposes an HVF virtual APIC. */
+        error_setg(errp, "HVF: kernel irqchip is not currently implemented for x86.");
+        break;
+#else
+        hvf_kernel_irqchip = true;
+        break;
+#endif
+
+    case ON_OFF_SPLIT_OFF:
+        hvf_kernel_irqchip = false;
+        break;
+
+    case ON_OFF_SPLIT_SPLIT:
+        error_setg(errp, "HVF: split irqchip is not supported on HVF.");
+        break;
+
+    default:
+        /*
+         * The value was checked in visit_type_OnOffSplit() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -224,6 +264,16 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+#ifdef HOST_X86_64
+    hvf_kernel_irqchip = false;
+#else
+    hvf_kernel_irqchip = true;
+#endif
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
index fd9a3ed480..d82fe10934 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -838,7 +838,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
     qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
-    if (!kvm_irqchip_in_kernel()) {
+    if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
         qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
@@ -861,7 +861,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
 
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() &&
+         !(hvf_enabled() && hvf_irqchip_in_kernel())) {
             if (vms->tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
@@ -872,7 +873,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                  ARCH_GIC_MAINT_IRQ);
         }
     } else {
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
             qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
@@ -2114,7 +2115,15 @@ static void finalize_gic_version(VirtMachineState *vms)
         accel_name = "KVM with kernel-irqchip=off";
     } else if (whpx_enabled()) {
         gics_supported |= VIRT_GIC_VERSION_3_MASK;
-    } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
+    } else if (hvf_enabled()) {
+        if (!hvf_irqchip_in_kernel()) {
+            gics_supported |= VIRT_GIC_VERSION_2_MASK;
+        }
+        /* Hypervisor.framework doesn't expose EL2<->1 transition notifiers */
+        if (!(!hvf_irqchip_in_kernel() && vms->virt)) {
+            gics_supported |= VIRT_GIC_VERSION_3_MASK;
+        }
+    } else if (tcg_enabled() || qtest_enabled())  {
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         if (module_object_class_by_name("arm-gicv3")) {
             gics_supported |= VIRT_GIC_VERSION_3_MASK;
@@ -2150,6 +2159,9 @@ static void finalize_msi_controller(VirtMachineState *vms)
         if (whpx_enabled() && whpx_irqchip_in_kernel()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         }
+        if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         }
@@ -2168,6 +2180,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
             error_report("ITS not supported on WHPX.");
             exit(1);
         }
+        if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+            error_report("ITS not supported on HVF when using the hardware vGIC.");
+            exit(1);
+        }
     }
 
     assert(vms->msi_controller != VIRT_MSI_CTRL_AUTO);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 9054143ea7..d98f95be00 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -33,6 +33,7 @@
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
 #include "system/whpx.h"
+#include "system/hvf.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -666,6 +667,8 @@ const char *gicv3_class_name(void)
         return "kvm-arm-gicv3";
     } else if (whpx_enabled()) {
         return TYPE_WHPX_GICV3;
+    } else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+        return TYPE_HVF_GICV3;
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
index aa9a155041..d3f311eff8 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1778,6 +1778,8 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
                                    false);
         object_register_sugar_prop(ACCEL_CLASS_NAME("whpx"), "kernel-irqchip", value,
                                    false);
+        object_register_sugar_prop(ACCEL_CLASS_NAME("hvf"), "kernel-irqchip", value,
+                                   false);
         qdict_del(qdict, "kernel-irqchip");
     }
 
-- 
2.50.1 (Apple Git-155)


