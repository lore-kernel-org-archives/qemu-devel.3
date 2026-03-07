Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE5FC9EDA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncB-0006i8-4E; Sat, 07 Mar 2026 04:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vync4-0006es-Ve
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:21 -0500
Received: from qs-2007k-snip4-11.eps.apple.com ([57.103.84.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vync1-0000xQ-Bg
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:20 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 7D3AB1800138; Sat,  7 Mar 2026 09:06:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874376; x=1775466376;
 bh=MVkulPZG/P32eig2T0uS/HmO19+ssM94R08S2oM1hno=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=WaXdxC+aRiroW2olGmX6TGHLwx4MFAMzqbDyTFjMiK2QvxAr57BcNAqMTeEAoRG9Hf3FLbaM+lTq2qGnPRZglF/VVpwlAnEaOqD8f0E+jPDXQsw221jv2D5UpzH0QVGbbDECq8vpUWUOqzCckntqLGSUT8UgkEhSMlxBnioJcSbbwuHJnlV9aFSH9FYlosO8IaPsdb70hIMv54XhXmWycnQDWPGxFTuGAJM3xfShCEOoYFz+7b+C214LJJp34AUui4ZMVG+doIE7YkmrUc8scfeBGau5EZsOEoHaB77sqhngfxBc4thsLTqSnyjwJa3Rf7fA720ffXBIeIeiMwgOxg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 D108F18000A2; Sat,  7 Mar 2026 09:06:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 03/14] accel, hw/arm,
 include/system/hvf: infrastructure changes for HVF vGIC
Date: Sat,  7 Mar 2026 10:05:55 +0100
Message-ID: <20260307090606.95300-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AZa83nXG c=1 sm=1 tr=0 ts=69abea87
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=n4FVybPFTm1vobq06wUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8Nf9TH5e4ktW7pRvFuafFSi_SWtVBEd3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfXwBm7ujWJawbR
 0WMvpIrE3Dy2ACEcfWOGC7trAbbgNGq+elwjx2on3ilbPffvcJle0pKTR08C5LGO8AuI5Uo4NPq
 AhdMUc4Ftjc2OuVNhUykAGkhfFJDFT1I0HBK8J+JkR4lMtZCZAcjGkHX/v5sJSWieOHGTEl6laK
 GyTCfdkini4hQPzbMnT0mVGfGF1Sn1n1D0ApixJDTkHxepNMF6JNaLcFuR8rOiZkSs6EH6rVCgG
 YS1Nqel0XVCdG8myqJLVYfBtTQb739K9p5AenB999Bwj8LyqZ71jSJMo3akN59LabkOG6/5Md8z
 YTdLd4B3D//pyur9d18t8wJWtfpY/+FJFYbnG8umeiykC8UvUdMIu7rWqCV7yk=
X-Proofpoint-GUID: 8Nf9TH5e4ktW7pRvFuafFSi_SWtVBEd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070083
X-JNJ: AAAAAAABnekHjfnLpsCdbuJ8v0VXnVSO+UyJLGvlnSG7nY/+RulHoQvM9UlY5igjgFDPZQQjvrkIj2l8k49brNDCK22OzW9cZOouOfjNhr0zm3xJeUXOs2pypSbhoNIUPYzmDs2QATREeAZOhWFw/XcduSXBNmRELzCxznPsFckgJKSE+ynrUQuLY9zczZq+5liqECLOO/tdDOLPQEx3mE1ZksPJsEOz7s4t6pQR2ISBD9YiAPSRlYgXpjOpurUo8R9IZt1r/7dnSxIJlcucJZPYN8pNeSmWUl1BwHpI614+0cU9tQDzC41zT7Hp3vJT9bXUlbAvoSzoVqrO55c+wBsZbGtZn8T2ejBQgWmkp274NbWUTBMkQ2ODH+aAd321BG31if+MLbZV7YAWMZjLcOCZtmYtq0hgcQIp/lX6LahucLGwncfGt/3GWIT8cddjt9RvCQPyAribqBiov22KgwgzYGbiXU0Zo3NchQjqI+YU195tKdRmtX+tTtrqRIKOj2+FPuMff2qxJ0zmmrtx0OM4M2uGN9iF5Vod/uoPsOljye2Ay9Req1jwLWg0+S4gvXSDRdJxFYcwUmgh64TD23ol92aC/jdBi4e+6wP6YrIBbVq0ovjHJ68QRfLRAgrahcujtgUSAa/9WMCSsUsk2ztaknf8T2gak8LKZQnhIoW5Ovqrmxa5PNAYZf6PrsromQ+WjRHMOsjbeQeZpoak50RBFs/+rVgwMdKrpgpZTghj2uREUoa5mhN4mrP1MjqwPsJQ091IN0iYFOR4T1mL4FuQRS/f62se
Received-SPF: pass client-ip=57.103.84.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c        | 50 ++++++++++++++++++++++++++++++++++++++
 accel/stubs/hvf-stub.c     |  1 +
 hw/arm/virt.c              | 23 +++++++++++++++---
 hw/intc/arm_gicv3_common.c |  3 +++
 include/system/hvf.h       |  3 +++
 system/vl.c                |  2 ++
 6 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 5f357c6d19..a296b108bc 100644
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
@@ -21,6 +23,7 @@
 #include "trace.h"
 
 bool hvf_allowed;
+bool hvf_kernel_irqchip;
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -216,6 +219,43 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
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
@@ -223,6 +263,16 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
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
index 7456614d05..7a6fad1094 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -837,7 +837,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
     qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
-    if (!kvm_irqchip_in_kernel()) {
+    if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
         qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
@@ -860,7 +860,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
 
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() &&
+         !(hvf_enabled() && hvf_irqchip_in_kernel())) {
             if (vms->tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
@@ -871,7 +872,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                  ARCH_GIC_MAINT_IRQ);
         }
     } else {
-        if (!kvm_irqchip_in_kernel()) {
+        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
             qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
@@ -2118,7 +2119,15 @@ static void finalize_gic_version(VirtMachineState *vms)
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
@@ -2160,6 +2169,8 @@ static void finalize_msi_controller(VirtMachineState *vms)
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else if (whpx_enabled()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }  else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2179,6 +2190,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
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
index 9c3fb2f4bf..f7ba74e6d5 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -33,6 +33,7 @@
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
 #include "system/whpx.h"
+#include "system/hvf.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -659,6 +660,8 @@ const char *gicv3_class_name(void)
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
index 38d7b849e0..871799a2ae 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1780,6 +1780,8 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
                                    false);
         object_register_sugar_prop(ACCEL_CLASS_NAME("whpx"), "kernel-irqchip", value,
                                    false);
+        object_register_sugar_prop(ACCEL_CLASS_NAME("hvf"), "kernel-irqchip", value,
+                                   false);
         qdict_del(qdict, "kernel-irqchip");
     }
 
-- 
2.50.1 (Apple Git-155)


