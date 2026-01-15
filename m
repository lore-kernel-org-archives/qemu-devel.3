Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821E0D3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB1y-0006At-KQ; Wed, 14 Jan 2026 19:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1t-00063m-8U
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:02 -0500
Received: from p-west3-cluster5-host3-snip4-4.eps.apple.com ([57.103.72.27]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1r-0001up-8I
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:00 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 33E4918000CC; Thu, 15 Jan 2026 00:15:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=pV+1Am7tr1YVsc3hZ5jzgr7hS1W1WG1c4qjADMcW5D0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Uk0g74qWcGJpyy33WbTVZhB+8+idRID0js9A4CQhqbtTWdTxT7nLIFFqDibhksd/zmgBnyFtLtm8P939Kge37hrqI3fgFp4WIUNEFX4oB8BO39CNgqPsK29VforKX91ynboLmupTTfWdDG4VV1VZ0sLOW+2OcwhvjOGLDwKY4UukzFvM1eMvjYpQZlhJclxX6HeYCJuxsU5v5oDFIKxZ3sMTIIW3jcL0KI3S4MK0aiN3mB0vICZ1NDoyMFyfpkLJCamk8wNSp1dKv+I9kroh/VJatoOoAKiRxfiXuXY2CxSSJenz8PQYM426h/5wUy0Xe6ItKOMQABDa3CAF9ETDUA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 34BC418000B6; Thu, 15 Jan 2026 00:15:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v15 07/26] hw: arm: virt: rework MSI-X configuration
Date: Thu, 15 Jan 2026 01:14:46 +0100
Message-ID: <20260115001505.57237-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=dJCrWeZb c=1 sm=1 tr=0 ts=696831bd
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DPHOBc7XtNdUtUkKMRoA:9
X-Proofpoint-GUID: 4zYJpomSZxABtPDLJ9P4n92V72eBPXMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfXwGpQxdxULeGR
 ci7Iaku2cGGDL7HlwEVlKb5hcJWZiP/UXBXH5pK1AqHCR8NO3EquRz28hKx+Jckht5rfazxrHph
 tdQV2JujzqyUuYlqqTuJ4MDSBKT+PXUHz7x9vU3UzROqH+ndL+QbIbtzzbst3N6fIadBOokJM4l
 Nf14rNEN09Uc7+cg6qoDDBOCcnkwTfEsb/8YBWYO7x3OnLyLUjjzoibb/8ofaiWDAIkQu0E/CuG
 dw+E4RSp9C5qhtU7PH4uDdLv9LXEMXAC8sMXf5s165eeFueWsicJslJeuwk1EY5hP2fiaTBhudc
 4VVYJ8kjOz3T+BPwZwW
X-Proofpoint-ORIG-GUID: 4zYJpomSZxABtPDLJ9P4n92V72eBPXMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABI+eroKMuyfNTDCGsdxB2g0/sxUK6KU9SyYtDIqqbr9DuYnbjIGoARxIDln1EARAp4ByO7ag+5SyZ2JaOkcjFy4bzmv/cjxFG9sg1mT9Jrov3/CIV+ZimEn3m6KubtFLif9GnIu1zqagvKw9AqlnesFW/VK4NfVcA2IOBNOGWM0TVVOl/YCHeQzbpeOheswlXLv3c1dIti0YZ91BvoU4UnvRx/35w1ngH/npa7LJGlhMuAb+oB1zwYQbQOswqGS7v1pMVEQL/CY+7GtcF3CxZG0upFcb3NtDnq+gt903Chw9Nn9eyvu7nOt4uKt+bCA6FxnZBMZRg2iQ37Y4fk52e0nXBLOMOMW5Vk9WTFSBw51Vmv4GJremt7i7QxbmX+x4XBjrLvyZm1a4yuDPoVAyiEztRXZ5NFWESyTC/oUxSNxX1jBm+S02NwKX1KbdUbdjFC7VL7rUDBDj5domsI3IF2t4ltR4+IyHAfVz6v2riQ5YVNenNnElqK3yBlKz/EEQZR1EhB4ABW436NuI89NC7DLftcssj0UNhZby6X8lw3jukSU8fPBAebsLKP95pztNZo3C6O4ZOpGTFiupT+nIN2SodjQB3llthPvi/R5y7qy3/0iuaP0oUziEeV/s+HsOL4zeuf7z14nUwaL8a6xa3NUh7XL6HCc62t+/h4BweuDl3Z4ZnqpZD3cW68ag6pe6jGCbGKt4Ui0UJu7asNmdgVA4HpwIatsrhBawJCnXAJVhZ+be0CI1Lm8Kst5teCqCHzE0E0jilk9T+xj9+SDVxDUxq5/TQNENfqHmJS27wDN3aZMWeLgViSv0gb8EJZ2YcbAGSkNQW14iHGs6Q6eHHiC2PYwpj5mditGbxlRR8DVqCUrPf2rPW5gTzkHJy21b24OWLgIKb9yw6tbVbT5K+zRysD5nLZX/6FQ==
Received-SPF: pass client-ip=57.103.72.27;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c |  24 +++++---
 hw/arm/virt.c            | 116 ++++++++++++++++++++++++++++++++-------
 include/hw/arm/virt.h    |   4 +-
 3 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 86024a1a73..187dd4e272 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -440,6 +440,17 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
     }
 }
 
+/*
+ * In the prior Qemu ACPI table handling, GICv2 configurations
+ * had vms->its=1... That's broken.
+ *
+ * Match that assumption to match the existing ACPI tables that
+ * have been shipping for quite a while.
+ */
+static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {
+    return vms->gic_version == 2;
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -473,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -484,7 +495,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             rc_mapping_count += rc_its_idmaps->len;
         }
     } else {
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -499,7 +510,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (virt_is_its_enabled(vms)) {
+    if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -518,7 +529,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -611,7 +622,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
@@ -962,8 +973,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
-     && !vms->no_gicv3_with_gicv2m) {
+    if (virt_is_gicv2m_enabled(vms)) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 553c7f62cc..bc0d54eb7c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -966,12 +966,12 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
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
 
@@ -2710,32 +2710,101 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
 
 bool virt_is_its_enabled(VirtMachineState *vms)
 {
-    if (vms->its == ON_OFF_AUTO_OFF) {
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
         return false;
-    }
-    if (vms->its == ON_OFF_AUTO_AUTO) {
-        if (whpx_enabled()) {
+    case VIRT_MSI_CTRL_ITS:
+        return true;
+    case VIRT_MSI_CTRL_GICV2M:
+        return false;
+    case VIRT_MSI_CTRL_AUTO:
+        if (whpx_enabled() && whpx_irqchip_in_kernel()) {
+            return false;
+        }
+        if (vms->gic_version == VIRT_GIC_VERSION_2) {
             return false;
         }
+        return true;
+    default:
+        g_assert_not_reached();
     }
-    return true;
 }
 
-static void virt_get_its(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+bool virt_is_gicv2m_enabled(VirtMachineState *vms)
+{
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+        return false;
+    case VIRT_MSI_CTRL_ITS:
+    case VIRT_MSI_CTRL_GICV2M:
+    case VIRT_MSI_CTRL_AUTO:
+        return !virt_is_its_enabled(vms);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static char *virt_get_msi(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-    OnOffAuto its = vms->its;
+    const char *val;
 
-    visit_type_OnOffAuto(v, name, &its, errp);
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+        val = "off";
+        break;
+    case VIRT_MSI_CTRL_ITS:
+        val = "its";
+        break;
+    case VIRT_MSI_CTRL_GICV2M:
+        val = "gicv2m";
+        break;
+    case VIRT_MSI_CTRL_AUTO:
+        val = "auto";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return g_strdup(val);
 }
 
-static void virt_set_its(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static void virt_set_msi(Object *obj, const char *value, Error **errp)
+{
+    ERRP_GUARD();
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
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
+}
+
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
@@ -3062,6 +3131,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3452,13 +3523,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3515,7 +3591,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_redists = true;
 
     /* Default allows ITS instantiation if available */
-    vms->its = ON_OFF_AUTO_AUTO;
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
     vms->no_gicv3_with_gicv2m = false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 394b70c62e..ff43bcb739 100644
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
@@ -147,7 +149,6 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    OnOffAuto its;
     bool tcg_its;
     bool virt;
     bool ras;
@@ -217,5 +218,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 }
 
 bool virt_is_its_enabled(VirtMachineState *vms);
+bool virt_is_gicv2m_enabled(VirtMachineState *vms);
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


