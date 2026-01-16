Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F21C2A08F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkGJ-0003Ew-5v; Fri, 16 Jan 2026 08:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGD-0003Ah-4g
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:09 -0500
Received: from ci-2004k-snip4-11.eps.apple.com ([57.103.89.113]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkG7-00026r-BN
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:08 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 0B188180F902; Fri, 16 Jan 2026 13:52:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=SdkDw3mmBKiRUSrpgahAMGCt2Fg4nL0LRdYY7rn6dQI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A9hf/GHCK1ZLe3tp1KKWDLe/j0V2xilY3oted9dEcU2Fg09fR4Mmq1TS15X5WsSRnNmK3BDRMvW4wb3MSmw5An37V8mNJhaBBRR2BXwcmfQjv1DFVXyI9gQD+qcg+b02Gj9wSacupxjuhzlxXLQjsKaNj7QyKif5dYXtYHO9b+mhTq+TBomansQYebBKHpDb60n7c2AksccTumdwvR0NrtizvHM2UDjgV/JfWq645lKPNnjxQwFDHTvJfU6m+/n2cFSMQD8vA0CRrHVWiMPDPurMYCDeES7cwbW6RWksf1ldsZsY4DY78cI/OqF8UuQd3rQWQph8pOkwiSL1VFaC6w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 4A24E180F91B; Fri, 16 Jan 2026 13:52:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 07/26] hw: arm: virt: rework MSI-X configuration
Date: Fri, 16 Jan 2026 14:52:16 +0100
Message-ID: <20260116135235.38092-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX4CokwmFrGwoI
 h/K7HDhfvnvabkXqWUDtq/3eOTLv1y65HweXW4aJsccly2yZoxnyd1+sHbW8QsJWTptkaBvqsut
 L/7Pw+PyqFnxKDX/JzmCGWtMqRjM5ThUqILsd9CyKATm+LC9PDYxKfuL0Z26+AYMaaGw65cNLLb
 RjWxRfe0c7zBql947mOXUu1d9lroQcY2mGIlbEhX9Q7JPuuBKjvqJHqkOLeJDPc1ilTW3kAaZBz
 yBt0olydegUq+EkYONveLO2rQUt5zXueebI+Oc23Zwigup4uluYsjq4hj/fXbG8g/zqnKGZ3Lif
 tWlDKNN5yK4MKIbA+YA
X-Authority-Info: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=696a42bc
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=DPHOBc7XtNdUtUkKMRoA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: M2k855p3hQhvF1Q_avHtzuatScgs0niX
X-Proofpoint-GUID: M2k855p3hQhvF1Q_avHtzuatScgs0niX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABcWDSS31yVVjG682RRKOZ7gCBXgOof8tEV1j9pzkxlpd/cIfkqHJbHjnXHDg5GEpcK6wEedQMMb4NHXM/CvRMoGwXwEvxtRyb1F8pCGeQDl9OGY9IknS1C5ej8rjtvmq7qxHKC5oKSkkd0Rte4HfumDNWR6dJk9G7SeSaTmhLgWu33EQnWy1neeZmQE9XbLN6yACc4N9xIJOxq9R2+BMrR5c0uW9XetO/ebmSb1ckjOdiCCJiz8jM089YbqEwgRaMZWfy1Qbf9T8b8NLMAQOQAgydLpsOwFujUdKwbrUXtQJk0DcjS2PT3vmZlfmkHMlkAOA+anmEEynsOoW5O9SujtaBcJ6+n9UCcSv/lK6ghkIv1wtGoxCf30YBSpCOwP6JBUB2pQfItin7ZohrhoFJkI7sgOI4JLBaS0p8tT6SsFNpfH92JTPonVXbOdh9i/bJYE6BQxpvnzbf08UFjsdjrP2aCIJmWZ2i0rOGjYIjgWpGux6zghW8uY51pRMvHRRHWqKW67te0AnKalG79Aor/eJ2Xcxqk0OmI/0TrDDERytah2OzHdegl7G70c5wCJGd2glUDwksCS4MwR76psu7Twlox2W7G9lBIejxcNHnZ6wvpm/tJ3SvjoeL+v+w9OSMfw/aawZUTuhIr5VSQpbjuFRns2bIRz5CBE1jg1WNZB/wfY+qU6vUmngPWtLxUg9UA6UeP7O2JCenTExWg6reOg1az8a8bgY9exemV3RGKvqap7umc1RktEjpfXtGhHHPpZDyVdHzLHAYjriv7KUsX+mkG+Q5tfPaqQ5a
Received-SPF: pass client-ip=57.103.89.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index b4656b3476..1bbc030baf 100644
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
 
@@ -2715,32 +2715,101 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
 
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
@@ -3067,6 +3136,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3461,13 +3532,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3524,7 +3600,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_redists = true;
 
     /* Default allows ITS instantiation if available */
-    vms->its = ON_OFF_AUTO_AUTO;
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
     vms->no_gicv3_with_gicv2m = false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 23c714d67e..72ecc5e62a 100644
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
@@ -219,5 +220,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 }
 
 bool virt_is_its_enabled(VirtMachineState *vms);
+bool virt_is_gicv2m_enabled(VirtMachineState *vms);
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


