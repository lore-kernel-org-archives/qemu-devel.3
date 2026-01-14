Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77899D37E39
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18j-0007t8-MX; Wed, 14 Jan 2026 08:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18h-0007s5-VF
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:23 -0500
Received: from p-east2-cluster3-host7-snip4-4.eps.apple.com ([57.103.77.235]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18f-0006gj-3Q
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:23 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 6208C1800143; Wed, 14 Jan 2026 13:42:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=TMdu6vjPJzDykpNRvPgMSFKOFoQTM9f9J1ejCcVIHN0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=J+1lF0Pw1rhymzcMTfOaogXVFIzLtVBSUG3HnRA1NdTnj/RPIb4ewzVlWgva0a54FyZiOTjcAAPwji4Wl6JRWuEZkKgUAlNjqFRalsErM+gWh8BctdQFIe0u0plgx0EFyr1qEMP5liK5iCcgD+ecXnOA9A5Qo62MgXzEye4njZ6diqNcPU8FAhVeQCRF0WrpaBhT/ga5iKieRtwpWEXJR4/tZX9pbQgJxg1h9G2n4RNvljjwsSoLI9LNpXcBvzjcak3B2ebmS5zfaB/WhaIQanELqoPBzFSv/bSpzqSEVUqchWmyd4ykvFqLFNzdd/6+mP2Lh5D8pA5+r/9IVXcbYg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 D9A3F180048A; Wed, 14 Jan 2026 13:42:12 +0000 (UTC)
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
Subject: [PATCH v14 07/26] hw: arm: virt: rework MSI-X configuration
Date: Wed, 14 Jan 2026 14:41:24 +0100
Message-ID: <20260114134143.26198-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qiGHyfTg6ZBAr4P991_kQUrwRn3mXd90
X-Authority-Info: v=2.4 cv=Ev/fbCcA c=1 sm=1 tr=0 ts=69679d3a
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BHL3GN1Ck1RhGNPO6CcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX0beqPcu7RSqn
 Osx716w7WI2pKXgbDeSVbDOQRxhc0K2+AGW6jOcL47YFd99tGv1CKRYo75J/+YmJIV5hwa/floB
 9Coibq/Q029wIy12kcm7P/TnDTEStmziIvVqGokwK7GguGN0pRj/ra/ypOfrDtaj1V1XjUwM3bb
 zMFln/7B5N51oOsIfLKFlpXhMqKqsvgPIiScydr3ZmGSnJjKjQpYejmA8BEIM1pcyJ5sqqVTHwf
 9OmpjdF74oGPrQbOD3keNDUkafJllF08ejW+xjncs79ZwDWNZHpKAaB5lYDzN/FCiN3GTsXEDvT
 31mWM/bzvFVFWSrhjSP
X-Proofpoint-GUID: qiGHyfTg6ZBAr4P991_kQUrwRn3mXd90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 clxscore=1030 bulkscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABeJwHKH8Z2IR79z5lsV+14fFT+r8Gfqp53lUsJyZ7603C5Zr+4jdDcS98nMsRI0VdobnelC5+5p0xVurF6oBLmjM3HtOABtu0CA1/caEHnSCQ088EFck9w27P7kwXZLPz1Iyw7/eAyPgX0MZAgZSte51uLTQsQ2SbfRznACaiHTp3bXVTY+8pfsRpN4xCHSLWjrM7VdOZYsWdxOiprfZwha7O82htHywaYMVDuFHjS7P7pF5tVFdBkvK+pfljD15Dc7qtgvszR/rz7dd+VTsY5spOzBnTL2UPkLve80fBXcnkBq37W8t1eiTmdigw6KnEsfD59+AtI14N6yOIGyAU3GNww2Kg0BcHDnbzcS6L1i1nZt23eZPFalIcRO5kwThvsytjSKzixFK4EudI7BSv8CryXcBA3vDa6GXdVNYJ7sMuFe6iZiAV3xDd9BMlMmAn+9poBCLqztQopF9HCUZUNfwhesbw6/C0h63cZLDm+FlNH478S60zYVIxLYyN/AkyzA4bvJzy4OfS1ld9B6R4fjiYv4+5S0ERSaGycgQcSQ7fEk3mS8dLWdhz0jh9LdA2kkpMMai9qXLOciwGGZz5jTchdiwDyF76u7Ti2l1vt1JUxpgu5oPJmXrQOqBdV/8bgA4Hp4ubNJScl4u/NR4cNKwnUgUKkbgJQKexJXBnigj0FTtiVoFrKHgtEuZgAdo/99CHvzutsOR77wWgKz6gtKIaPmbNK5sISbHHFlmor8JgiE1KBNXwqxaE53vxF+zBxLtZ8A9EvxM6lBUFLBesSyjg+Q0eVEO8KsocgtVtwcXS4z9f6cRe6WnJU2lra3mSDSNWIdiftsCrhJ2LJr2QMwYguC7fFq7+RghtIZ2RRnT9Yd4eeTCOLk9NLeqD1EYtNQ==
Received-SPF: pass client-ip=57.103.77.235;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c |  24 ++++++---
 hw/arm/virt.c            | 108 +++++++++++++++++++++++++++++++--------
 include/hw/arm/virt.h    |   4 +-
 3 files changed, 108 insertions(+), 28 deletions(-)

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
index 553c7f62cc..0e84ccd82c 100644
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
 
@@ -2710,32 +2710,93 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
 
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
+    default:
+        return !virt_is_its_enabled(vms);
+    }
+}
+
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
+        break;
+    case VIRT_MSI_CTRL_AUTO:
+        val = "auto";
+        break;
+    }
+    return g_strdup(val);
+}
+
+static void virt_set_msi(Object *obj, const char *value, Error **errp)
 {
+    ERRP_GUARD();
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
@@ -3062,6 +3123,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3452,13 +3515,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3515,7 +3583,7 @@ static void virt_instance_init(Object *obj)
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


