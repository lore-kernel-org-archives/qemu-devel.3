Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B849CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRm-0002Gt-5i; Tue, 28 Oct 2025 19:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRX-0002BI-KX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:36 -0400
Received: from p-east1-cluster5-host8-snip4-2.eps.apple.com ([57.103.89.203]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQy-0004oA-MW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:35 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 AB387180312A; Tue, 28 Oct 2025 23:48:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=KLJXCxRspSRDpfdk3bPZ4+2wmalBnWy7d7qziX03lt0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bzwwYaA6v2cQ2GrjvAQLvSu9QP1ThgLTF5AOuhEKuRN/Xtw4Lovual4i+eTgZmEjIEis2scHpNaYDb/PUrhkoXOJJ+2zEbcoGtSwbP4RsJwogZxm73TaPohoAgUaRSCU+CszA5sw7RgJDKKJq+PI6UyDajGF/gb//wU4L2UX/TEmN1eKdmY5Gf72g9+ep2hOT9FJdlvWh2BgZ7csIstWlallTbffwTRkX4t51mJOSCin6Na5TQUca6cE+Uq2wvW8U2jKq4zFcSbsClI8n4rGySjxoHgtLSOJLLvdGoJbzFGXh18/KMMW5kEOc+Tp1bFSWXOHUdFTAo8jyIhbL0Sv7g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 6365B18034E8; Tue, 28 Oct 2025 23:48:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 16/27] hw: arm: virt: rework MSI-X configuration
Date: Wed, 29 Oct 2025 00:47:46 +0100
Message-ID: <20251028234757.39609-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: c-6M42QPI5w1ofrlEmsAvl8Vb-tVIHVn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX7Sz0Aky+AZOv
 284/yOxlE0ApaeWUuu+s5XXvhRvJPt3+A6+NUXmRlSxgWcr59xsd2ru0LEV3RlGntCTEQ+HcelT
 b2IUG9xD3ryk4OXMXNApYtFcVSSRekXLd2sA0JwcO66ojZi/GIds/BaAG4e4yD6mg4YN+JOSODM
 Yif8zknyDTwzR99083PMH2mJTc6RV3l0UJUyXiKI4hvTWk5q7e2U9ssNphtrUECtusLT8DHdCL8
 sKXLfQd2G/IGjLsgCwHcBiZ0oHpgcZCp9sTBo8bYgolDXA5hI86ggCR6G5vHxLicm2AOYxZaw=
X-Proofpoint-ORIG-GUID: c-6M42QPI5w1ofrlEmsAvl8Vb-tVIHVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=908 clxscore=1030 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABKUQ8uclY6tXVKxrn6+jK/YiiMRJcd3sKlYQSIYZYrPTA2O/k2aq32xBE7XMHechG2wY/yS3bd8XTSquKo1HqTqn0OTr+LuvdB0RCorxDF5h9cFEGOF/UvyknUGvdDmYj5O2yL3I9AIbl/WmTkUhjZLPkVbbQ/JfMhXFIxlU2+jBxIf6gDlVbBSTMWNm8lrSwdfZ4WmjkgiIzkKwHSqZkC9ttwu2u7+LW60ZRyH89q5cJSWNtgl76xRDDKRDAFvFbl6AFDDZmZNx4CEsyyvUsngIpoh+fJGd0heoVjToSWw+xq4XuBL89Z/p0UpggSdLhZT+71pPPvD157P5FNnv3IYVu52nSjf7O4lHcf1CpN1m0VzcGp/V29hnq1fNSEG9yY8uDdvQi0PXQznuvPByiH9qP6LDtCzEfeKSXBt4T2ke8lISmrh4r0j/IqGFAa+LMNVS+8AiXiSHuivsa65INZfLm2USD4h6rjQePE0J/u8kTW1idTvarQjnhd6GsmUUAjlcjzYQZDyjoZACQzYXfsSqBw4Lw5lkF4nB0kkdqYtYa0qHC73oNXXohGsx1vK8LHn4c3tMYqrx8KqTxulxOGP9VULmBmA3eQf4gy9B6t8johmSCcJYQW/e+3odz3iXIoF/X7XUjR13Y9e2IzUM4bouQ/WnvxGhkS07TPmuYwQM1r6LNdVm5IarZ2Z5F4LJU2paFyg7Nb373yK82h2YoHJI7C7QROq4OXo57QIM4aA==
Received-SPF: pass client-ip=57.103.89.203;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c |   3 +-
 hw/arm/virt.c            | 110 +++++++++++++++++++++++++++++++--------
 include/hw/arm/virt.h    |   4 +-
 3 files changed, 93 insertions(+), 24 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8e730731ca..a6a56455a9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -961,8 +961,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
-     && !vms->no_gicv3_with_gicv2m) {
+    if (virt_is_gicv2m_enabled(vms)) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dbf9a28b8d..6978d4e867 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -964,12 +964,12 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms)) {
+    if (virt_is_its_enabled(vms)) {
         create_its(vms);
-    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
-        create_v2m(vms);
-    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
+    } else if (virt_is_gicv2m_enabled(vms)) {
         create_v2m(vms);
+    } else {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
     }
 }
 
@@ -2716,32 +2716,93 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
 
 bool virt_is_its_enabled(VirtMachineState *vms)
 {
-    if (vms->its == ON_OFF_AUTO_OFF) {
-        return false;
+    switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
+            return false;
+        case VIRT_MSI_CTRL_ITS:
+            return true;
+        case VIRT_MSI_CTRL_GICV2M:
+            return false;
+        case VIRT_MSI_CTRL_AUTO:
+            if (whpx_enabled() && whpx_irqchip_in_kernel()) {
+                return false;
+            }
+            if (vms->gic_version == VIRT_GIC_VERSION_2) {
+                return false;
+            }
+            return true;
+        default:
+            return false;
     }
-    if (vms->its == ON_OFF_AUTO_AUTO) {
-        if (whpx_enabled()) {
+}
+
+bool virt_is_gicv2m_enabled(VirtMachineState *vms)
+{
+    switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
             return false;
-        }
+        default:
+            return !virt_is_its_enabled(vms);
     }
-    return true;
 }
 
-static void virt_get_its(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static char *virt_get_msi(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    const char *val;
+
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+        val = "off";
+        break;
+    case VIRT_MSI_CTRL_ITS:
+        val = "its";
+        break;
+    case VIRT_MSI_CTRL_GICV2M:
+        val = "gicv2m";
+    default:
+        val = "auto";
+        break;
+    }
+    return g_strdup(val);
+}
+
+static void virt_set_msi(Object *obj, const char *value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-    OnOffAuto its = vms->its;
 
-    visit_type_OnOffAuto(v, name, &its, errp);
+    if (!strcmp(value, "auto")) {
+        vms->msi_controller = VIRT_MSI_CTRL_AUTO; /* Will be overriden later */
+    } else if (!strcmp(value, "its")) {
+        vms->msi_controller = VIRT_MSI_CTRL_ITS;
+    } else if (!strcmp(value, "gicv2m")) {
+        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+    } else if (!strcmp(value, "none")) {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
+    } else {
+        error_setg(errp, "Invalid msi value");
+        error_append_hint(errp, "Valid values are auto, gicv2m, its, off\n");
+    }
 }
 
-static void virt_set_its(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static bool virt_get_its(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    visit_type_OnOffAuto(v, name, &vms->its, errp);
+    return virt_is_its_enabled(vms);
+}
+
+static void virt_set_its(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    if (value) {
+        vms->msi_controller = VIRT_MSI_CTRL_ITS;
+    } else if (vms->no_gicv3_with_gicv2m) {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
+    } else {
+        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+    }
 }
 
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
@@ -3068,6 +3129,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3451,13 +3514,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Memory Tagging Extension");
 
-    object_class_property_add(oc, "its", "OnOffAuto",
-        virt_get_its, virt_set_its,
-        NULL, NULL);
+    object_class_property_add_bool(oc, "its", virt_get_its,
+                                   virt_set_its);
     object_class_property_set_description(oc, "its",
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
 
+    object_class_property_add_str(oc, "msi", virt_get_msi,
+                                  virt_set_msi);
+    object_class_property_set_description(oc, "msi",
+                                          "Set MSI settings. "
+                                          "Valid values are auto/gicv2m/its/off");
+
     object_class_property_add_bool(oc, "dtb-randomness",
                                    virt_get_dtb_randomness,
                                    virt_set_dtb_randomness);
@@ -3514,7 +3582,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_redists = true;
 
     /* Default allows ITS instantiation if available */
-    vms->its = ON_OFF_AUTO_AUTO;
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
     vms->no_gicv3_with_gicv2m = false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 997dd51678..99db8607e7 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -101,6 +101,8 @@ typedef enum VirtIOMMUType {
 
 typedef enum VirtMSIControllerType {
     VIRT_MSI_CTRL_NONE,
+    /* This value is overriden at runtime.*/
+    VIRT_MSI_CTRL_AUTO,
     VIRT_MSI_CTRL_GICV2M,
     VIRT_MSI_CTRL_ITS,
 } VirtMSIControllerType;
@@ -149,7 +151,6 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    OnOffAuto its;
     bool tcg_its;
     bool virt;
     bool ras;
@@ -219,5 +220,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 }
 
 bool virt_is_its_enabled(VirtMachineState *vms);
+bool virt_is_gicv2m_enabled(VirtMachineState *vms);
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


