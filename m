Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C29C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYSp-0004aC-5u; Wed, 21 Jan 2026 08:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSm-0004XE-Nh
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:36 -0500
Received: from qs-2003i-snip4-6.eps.apple.com ([57.103.86.89]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSk-0001Bf-EL
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:36 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 433A91800145; Wed, 21 Jan 2026 13:41:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002893; x=1771594893;
 bh=rfDkDuUckmPPc5WUko6RqUCpzzULCs3PQQuhX62aaUI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gaCR+EpQKVjykJSON61OG54FXnoBp18Yv0CjqNyNxrxuA3MdIeTic0/gQjGEC7b8eeqoVtJYoM1RqY4PZ5cJNu+aJ949JjnD8scn/RpLPMdFmUf5CzQDlx4hbcefgPlIfcABgv1FVZGhGUww71whETXe5clS34uuRYJuUWpyda33rn1LuxEuHOwYJZguw4WRig5fxwgTxWP3oqrC3ws8QoCtOmNQ+q5ocQ53nZ5ylv7N2GF2v98V1j3wH0Hv2KINpvt8EV30+LnQOLiQkst7J29SZmdYxZsEff8/paOLImhcPcmL+RVMxPgpUE3d+wMvXwHsm3PnPGKGU/Qp752s1g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 9FAA11800135; Wed, 21 Jan 2026 13:41:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v17 03/21] hw: arm: virt: rework MSI-X configuration
Date: Wed, 21 Jan 2026 14:40:54 +0100
Message-ID: <20260121134114.9781-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX+Z89wEKPHW8F
 WYC6vs5C5Fe56kmJ0gcrbu39DTAjmpaqjDfHd0KO+DMKH2U/hu44RpWZD5fcwIPIJNCRcZMT4Hw
 H7daiFrcGGQKRoVCaPiUBFDndYIkHGzHhODSafRYNBWrBTOPp0geK2RtA3A8cShB/GHM4h6Dsuo
 pGQ4ZWTWx0btzxi2Ou1KqG74kAo9pLLX4ggo9pdTHhmEwjvgtxa7iG1KmtBdmeefmRhLo6n+yyo
 SOFDwfKHY+L+2/XzG6jpj7Aijs2jUxIHTfG09mzKnQN4xLL/B9cJM64CJ4kKywRYpd7bj57+pF6
 F5hBr4L3wPplzo9ilpK
X-Proofpoint-GUID: ZhR8LjpK5Y3NnGJV2tLy4PCp_J8WldbO
X-Authority-Info-Out: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=6970d78c
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XHbtxiRcFRs46boockMA:9
X-Proofpoint-ORIG-GUID: ZhR8LjpK5Y3NnGJV2tLy4PCp_J8WldbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABGHajuPFCkX+GqncVZN8gdxeuT9MC4apZwcA+fuhx270nsIO+IQWbL1HlqIpU3yL7eX0JIXyQXzo4EIS92DWj9DSnpUObBmoouxfrYJVansfM4N0cpRyDLHKiDV1Eil9f7KE4td8x6hiuyR6GoM4cfOZOddDrxmh/qs/iDvu9xxaTjKMJryZ4J39z3RSKbuqKEJXGP4wnmCLXWMBoGD5VJk15UY6PBue/s+P7Ys3wBt+AJyWKU1qvZlIF33xS8XXR5VyyZuHd3+8n1WtV4B819M28qYhk/M9OfV6XjwQcmZd5IVtNb9Q1u3HsfGlvGirE5HIAE+3KQoTqjDHL+WNuaPHkpOWq8BpqZImq0EGRFpzw9PKalrOcTxlkTwOsj5xhOxA6OYiJv5SZ/z3SRpiO3eFw7xiL4naI6WARdeeuTBV0lv2WfGzyV3uFNsLsYy99ya5IpZJqX+ioP+O+wXCuuMwVgjgPkA8mdFgnPUjea0OHtYT73Ts+Gn2Qc3mmaUFkJ0EUxfH9KsTsGHG98YFvDKHbXfm+8KdRHSqkd26CKVS7HZhrJ2OgFO2fO/btNJ6OuFnXnrLPPs42+1XpJA9IscAPXjn5WiiT7sDh+KRpjatvVE0Iy6/0XW5g9sPpYYlK3Lrmi9nx9BAww5oSjyCFtgm/gkFP9z5l3aAvvkuQY1drnuLqY4VHoY0BwY5BUf2GnoB5j8hLd79NK/ujkTUIcxqLfAsk5xK6MWvUKBL9mvp1y45ZxE2Q0jVEQV5WO/e00CdcbMjvpVallJN5TbETpRuPPtdevA66IB33VkSMC1wJ+EyItYYWPcbimpx0jeH8DZ1s7pQyphLPsxRUK1d1tNB1Ll8+L/m/c82Zsuvm
Received-SPF: pass client-ip=57.103.86.89;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 hw/arm/virt-acpi-build.c |  27 ++++++--
 hw/arm/virt.c            | 137 +++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h    |   8 ++-
 3 files changed, 157 insertions(+), 15 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 03b4342574..187dd4e272 100644
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
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -484,7 +495,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             rc_mapping_count += rc_its_idmaps->len;
         }
     } else {
-        if (vms->its) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -499,7 +510,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (vms->its) {
+    if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -518,7 +529,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -611,7 +622,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
@@ -946,7 +957,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -960,7 +971,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (virt_is_gicv2m_enabled(vms)) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4badc1a734..3f62247f94 100644
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
@@ -957,9 +957,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+    if (virt_is_its_enabled(vms)) {
         create_its(vms);
-    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
+    } else if (virt_is_gicv2m_enabled(vms)) {
         create_v2m(vms);
     }
 }
@@ -2132,6 +2132,36 @@ static void finalize_gic_version(VirtMachineState *vms)
                                                gics_supported, max_cpus);
 }
 
+static void finalize_msi_controller(VirtMachineState *vms)
+{
+    if (vms->msi_controller == VIRT_MSI_LEGACY_OPT_ITS_OFF) {
+        if (vms->gic_version == 2) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }
+        else {
+            vms->msi_controller = VIRT_MSI_CTRL_NONE;
+        }
+    }
+    if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
+        if (vms->gic_version == VIRT_GIC_VERSION_2) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }
+        else {
+            vms->msi_controller = VIRT_MSI_CTRL_ITS;
+        }
+    }
+
+    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+        if (vms->gic_version == VIRT_GIC_VERSION_2) {
+            /* Older Qemu releases accepted this, but better to error. */
+            error_report("GICv2 + ITS is an invalid configuration.");
+            exit(1);
+        }
+    }
+
+    assert(vms->msi_controller != VIRT_MSI_CTRL_AUTO);
+}
+
 /*
  * virt_post_cpus_gic_realized() must be called after the CPUs and
  * the GIC have both been realized.
@@ -2251,6 +2281,7 @@ static void machvirt_init(MachineState *machine)
      * KVM is not available yet
      */
     finalize_gic_version(vms);
+    finalize_msi_controller(vms);
 
     if (vms->secure) {
         /*
@@ -2700,18 +2731,101 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
+bool virt_is_its_enabled(VirtMachineState *vms)
+{
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+        return false;
+    case VIRT_MSI_CTRL_ITS:
+        return true;
+    case VIRT_MSI_CTRL_GICV2M:
+        return false;
+    case VIRT_MSI_CTRL_AUTO:
+        /*
+         * Earlier Qemu considered its=on as the default when using the GICv2.
+         * It is safe to do this because this is called is prior to
+         * finalize_msi_controller.
+         */
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
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
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    const char *val;
+
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+    case VIRT_MSI_LEGACY_OPT_ITS_OFF:
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
+}
+
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
 static bool virt_get_its(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    return vms->its;
+    return virt_is_its_enabled(vms);
 }
 
 static void virt_set_its(Object *obj, bool value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    vms->its = value;
+    if (value) {
+        vms->msi_controller = VIRT_MSI_CTRL_ITS;
+    } else {
+        vms->msi_controller = VIRT_MSI_LEGACY_OPT_ITS_OFF;
+    }
 }
 
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
@@ -3038,6 +3152,9 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+        case VIRT_MSI_LEGACY_OPT_ITS_OFF:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3438,6 +3555,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3493,8 +3616,8 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-    /* Default allows ITS instantiation */
-    vms->its = true;
+    /* Default allows ITS instantiation if available */
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5907d41dbb..6ca849e3fd 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -101,6 +101,10 @@ typedef enum VirtIOMMUType {
 
 typedef enum VirtMSIControllerType {
     VIRT_MSI_CTRL_NONE,
+    /* This value is overriden at runtime.*/
+    VIRT_MSI_CTRL_AUTO,
+    /* Legacy option: its=off provides a GICv2m when using GICv2 */
+    VIRT_MSI_LEGACY_OPT_ITS_OFF,
     VIRT_MSI_CTRL_GICV2M,
     VIRT_MSI_CTRL_ITS,
 } VirtMSIControllerType;
@@ -146,7 +150,6 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    bool its;
     bool tcg_its;
     bool virt;
     bool ras;
@@ -216,4 +219,7 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+bool virt_is_its_enabled(VirtMachineState *vms);
+bool virt_is_gicv2m_enabled(VirtMachineState *vms);
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


