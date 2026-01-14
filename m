Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922BCD37E3B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18e-0007pp-Bq; Wed, 14 Jan 2026 08:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18c-0007pA-DP
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:18 -0500
Received: from p-east2-cluster3-host3-snip4-1.eps.apple.com ([57.103.77.152]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18a-0006ZP-BJ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:18 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 30B8418004A2; Wed, 14 Jan 2026 13:42:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=CDXmA90VChDNF+mgLamehM2Ivt5rkq6oevwq5r0nHLE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RKjGopJAm9+W4uOKJfZ6RGQHlRgziZxwpEuQ6iIJrU53kH8i+Q/lE7QAOF2ftWnnQqIPkyfwyR4nJaGOl71cmsUyeEoippDl4YjCQJXLVh307Wb4tHVReuTQ9Dnc4G/rarY2qttP2LkiaFGEIm1Vrv5sX/SAZg5v8EyDh5NHZ6f6tdqFMEjlvqFh/3xQn5xQ7MdFl8dt3M+SL8+QH2O8UXEFoqT9l/IYkvArYEnrZlHgDTEzY4Ab6jc8Woxwuptjg3OfHi6OBqD98OnD0wOdlUwDUqImlchAXZumM/SoFjK1kG3IWhCojieWYXrBwn/3Me+fjoMFQR5cOTCJTsgHfQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 744B518004A6; Wed, 14 Jan 2026 13:42:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v14 06/26] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Wed, 14 Jan 2026 14:41:23 +0100
Message-ID: <20260114134143.26198-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -DDL5d9uNq3w8Kgy60D9Sjer7f-UJ0f-
X-Authority-Info: v=2.4 cv=GdIaXAXL c=1 sm=1 tr=0 ts=69679d37
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=065Y4zqepXN3nrMe:21 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=eCCvHKTOcc9AFgEG6kwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX20sRgrt9Pfdk
 u4MEzThTMCkJvmOMU5yjzDvGU5a8Zco33A0kdnqXuqN+ntEzzvz6d8PjaVaAL3mXRAKKSru+V3Z
 Xi7kci2MOzHjFNvU5iGIADttt7xjBGi0QUzuqZJ3gIQ0p6tIwipJraO3v8vr4UohCLDeR8+bdqd
 DymNLAKaBWIVUzglAfSvpNmHoEAisyYitaC1oSGPBbjqVQmb1xU9UcfQ2Dra8zEg0p4Vbq6fZbJ
 c3mUqVRXZ28QOIe1RS52PBwSboJIRIqs6FJcTXaKQb2+8OIhU+WI5TeXBgmLpkcEzQYtVSN5pkP
 O2A8QFVNsOh4ikwDFs6
X-Proofpoint-ORIG-GUID: -DDL5d9uNq3w8Kgy60D9Sjer7f-UJ0f-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 clxscore=1030 mlxlogscore=999 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABU2b57dIHgSbx08SHtJ+xEDfMESc8uWbc9LJdQr2RzmDbckg/yO1zlQL2bl31VZltQ0hCMjP47VDtOzAo3Pp/x9a6sG1YOCCTtH32Q96KLRU7mYufOdl/a7Lf1N5wJRVoWVZZKdRlDSOByRTk9kVceL001IREScs/sF2IWO6zg/FJueJ0wVfySKyujkxJ7/s85oEMTjH6WQU/CLJbD67kEY6v9v0j+U0L8lNq7Zli+pcGNqIW6Zsj8rP03gnkf1yRmbP7iIhLS4VbDyCzEBle0jXy9pblF5w+Oci06jdSwObSqvzYbXZMmT74WCMbGeuioiKtvVaA2i0CavuXNUtERAg/aeP2oovF6rzjWZ7smgKV70o4OrQxASto3ufxg3L1ozI4DNH9LP00iPvFTKTsbKdPS5GU+ViGXaJEAqr1v5+p/sIvO8i374m23ynPMgs1gnL96U7v3u+wFN4ELL1TxfROMJ0ck4W5zi7ZKmA7Iuk3rTvVKqQdGSF9FV3Eu6KUOuXPIO/t5mPgXF9vHtt3ONpwHwT+4bjCS+OMNGuvSc0bWMtLl+xwVTd4L5sd4slkY0vPmttInmGh9HcPrOelWzF28y2zb9I9SDpepWTpE3ncfl8gME6Wvlgw7USeQnzIkhweaarY7fz58C7+ATqJpzxTCg2pTBXtjI73qPskzIlK9YToh0zANqbfNJShVKujYbNxNb3/CZKmTIBGinjnJtD8M8c6lzJnVMeA2QgIj4EcO0VLxENpJYJ7GlLmqABeFmGv6SKyTWxFjPLWVvOoZLFyBflzFx8WkpMmn6i4pfN1/ySOokVlzL0r9iLe6R2xEYICH7oAsqDYPP5YLpaCmzu0X5DQq7YNNsqlR0Vxa8+n6UCx9/YLorwG94B3dvKCREnkZ5NfB/svD9wwKNUmw7FB
Received-SPF: pass client-ip=57.103.77.152;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Switch its to a tristate.

Windows Hypervisor Platform's vGIC doesn't support ITS.
Deal with this by reporting to the user and exiting.

Regular configuration: GICv3 + ITS
New default configuration with WHPX: GICv3 with GICv2m
And its=off explicitly for the newest machine version: GICv3 + GICv2m

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c | 14 ++++++------
 hw/arm/virt.c            | 46 +++++++++++++++++++++++++++++++---------
 include/hw/arm/virt.h    |  4 +++-
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 40ea6b6dd5..86024a1a73 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -473,7 +473,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -484,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             rc_mapping_count += rc_its_idmaps->len;
         }
     } else {
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -499,7 +499,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (vms->its) {
+    if (virt_is_its_enabled(vms)) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -518,7 +518,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -611,7 +611,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
@@ -946,7 +946,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -962,7 +962,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its)
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
      && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4fad34e108..553c7f62cc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -737,7 +737,7 @@ static void create_its(VirtMachineState *vms)
 {
     DeviceState *dev;
 
-    assert(vms->its);
+    assert(virt_is_its_enabled(vms));
     if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
         /*
          * Do nothing if ITS is neither supported by the host nor emulated by
@@ -746,6 +746,15 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (whpx_enabled()) {
+        /*
+         * Signal to the user when ITS is neither supported by the host
+         * nor emulated by the machine.
+         */
+        error_report("ITS not supported on WHPX.");
+        exit(1);
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
@@ -957,7 +966,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+    if (vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms)) {
         create_its(vms);
     } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
         create_v2m(vms);
@@ -2699,18 +2708,34 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
-static bool virt_get_its(Object *obj, Error **errp)
+bool virt_is_its_enabled(VirtMachineState *vms)
+{
+    if (vms->its == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+    if (vms->its == ON_OFF_AUTO_AUTO) {
+        if (whpx_enabled()) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static void virt_get_its(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
+    OnOffAuto its = vms->its;
 
-    return vms->its;
+    visit_type_OnOffAuto(v, name, &its, errp);
 }
 
-static void virt_set_its(Object *obj, bool value, Error **errp)
+static void virt_set_its(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    vms->its = value;
+    visit_type_OnOffAuto(v, name, &vms->its, errp);
 }
 
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
@@ -3427,8 +3452,9 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Memory Tagging Extension");
 
-    object_class_property_add_bool(oc, "its", virt_get_its,
-                                   virt_set_its);
+    object_class_property_add(oc, "its", "OnOffAuto",
+        virt_get_its, virt_set_its,
+        NULL, NULL);
     object_class_property_set_description(oc, "its",
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
@@ -3488,8 +3514,8 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-    /* Default allows ITS instantiation */
-    vms->its = true;
+    /* Default allows ITS instantiation if available */
+    vms->its = ON_OFF_AUTO_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
     vms->no_gicv3_with_gicv2m = false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c5bc47ee88..394b70c62e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -147,7 +147,7 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    bool its;
+    OnOffAuto its;
     bool tcg_its;
     bool virt;
     bool ras;
@@ -216,4 +216,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+bool virt_is_its_enabled(VirtMachineState *vms);
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


