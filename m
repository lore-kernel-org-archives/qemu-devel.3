Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F766EC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnz9q-0007cL-U8; Thu, 05 Feb 2026 08:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9n-0007bA-8r
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:27 -0500
Received: from p-west2-cluster3-host12-snip4-10.eps.apple.com ([57.103.69.43]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9j-0001XJ-DE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:26 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 460911800160; Thu,  5 Feb 2026 13:12:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297142; x=1772889142;
 bh=dmdlOMsXZyLONskFyCZro+qJfARcBfqdz3mKfCEcKrk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PJG4bZKetYkTL4L+D3YX28fKjb1GxcwKcLIgZ04BLlOOgbqSPsTgNhLDhuwli8LyJHW/RvVoVJgFx7YDg9wkRC/mtiN5os1fpvqCIWf2QxT5BlQ/Y53R3VW/u07Uf9XRHZFhaRg4am5cbA3ynnNi8hhdvb4u95tvD0nqOMLwGXysIqZmxrK+YazfWnOFdwBohAAgzawrbT4pqN8AdaF5UxdjdJQZpX9C7RjkuGj8CpLARsV31uxOzrBhJZhKQ52FKulfUYPNzPQ1oRHo7covQgt9ex99Z5J4eD8wX8iTOwI9b0+qqzclBy22uOlbYNnNxalwIS1JqoQpc21Cist02g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 CD11F18003F7; Thu,  5 Feb 2026 13:12:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 04/22] hw: arm: virt: rework MSI-X configuration
Date: Thu,  5 Feb 2026 14:11:33 +0100
Message-ID: <20260205131155.22780-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MyOd345yscwAZ_Hk9kRUAgZe9zz6yqBn
X-Proofpoint-ORIG-GUID: MyOd345yscwAZ_Hk9kRUAgZe9zz6yqBn
X-Authority-Info-Out: v=2.4 cv=ZrXg6t7G c=1 sm=1 tr=0 ts=69849735
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=XHbtxiRcFRs46boockMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX8RrA1rqcuscF
 iHAq6Dh1hhgKQgqYH7/7PfUoZSWILFoQUGrSXF0xjIk9ZsUHb07l8kxkurwwhszrLoiXG1kr8vI
 IrL7fcGYPVdt04mxiy14b0kpQtqakcyRtQFlFAX2iM/w250zE2MdGuUlJnsMoJp8Xi1ngJkiHep
 +QLlRX17UsrP5zSBRaS3sHATUERHZLQo9I+SA/HR/ZtgciwKrlyhkJm2mWcqfre/zafRw+Qkpfp
 e2NrVPuDLQw0F0chnEcyjc6U0rDoHTfTkvnKw88JAjegMnXJV97ejZ59O3Sbj1mr+ZhGIQ1OzP5
 biK7Np0/GcVUBEf2YAjiYSdEsGyw8xMaq80fECbaJHhUqxhxXzBN9NoxIU0rHg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1030
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602050098
X-JNJ: AAAAAAABFooL1P40FKu6/o17TB3iXdFrDriZV/pyVzpsQy6NM4mg2NMAfmzSm9PfBWdkipvKWkVxiSU4yscglAfy+co3GNkpNJvJIOcdHcq2R2hpIQ20vkw5kaBon4tUMIxpfF/xNNqjHm5DUIc2hot2NuoJL1Opx5s/h2nllGs52NEzmfSOebBV/TdKoWG1SXpTGqBXercxAkAJGAoAkPflo1ImPVcrPcrutWtmVm4DiXVCk7hJKHr8j8T0QUHYjhpVNmpIQVi3hKKnPKLY9+Pk76bccfHPe6r+rPjajQgxtBwteFIxYVdbrWl19AdoSWqND2t1aUo86gIpOFrR8miU7S38znDHWu3OvMFnuqWVuTUPhNuaRVtJymfwjX6Ov8M3fM6XFGlg+HDgWsq0sg8XbflD8XlVEPD5I6MAJJBx2HJb3OijMGTk7AC0HSrs9YiSepxCEZTQFSXrVR6F/A0UaG/y3syOSe9C9gNkKPpJwvdBscEreawoO1/RCQu4rlOIYy11BYc203hU1qXrt8lOpy4HQXnDD8XphsGE7mGSniF/YZA/n822zz2pWxKB86GysHXIfCjq90gsWeMXFgc/vKzETSM20PQVVLeDwsrprWz8r9S4AY2qKvEdL41KP2tlXeTpdVDXfkoj1/9jAPZU/IjnA3nMJXr7g/9qU+cOp20CFuQ4x5lmfq/LTtGGhtUpZ3Kp1dtI1x6iDytM+QdtRJH0nqS26xqwZmxknSorUdDWjMoQiyaae9BPCWdJl9XYz77+xXDQupUjoKpX+Zx7yQWsdv2JBIQMnNss+L1HvC097PSmRr4kV7Uc1ky4H/7YgEhhZPEbvnT1yDCMHnJ1HotcuI23c/im6xsiOAH4ZIcnOShFdwQpJTjMsp7aMGBcS5cLweHjIH4WuQm9k/z8rZXeqs5/NLBnV58mWNe9jJJkFXf6BeLvPJiu
Received-SPF: pass client-ip=57.103.69.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c |  20 ++++---
 hw/arm/virt.c            | 121 ++++++++++++++++++++++++++++++++++++---
 include/hw/arm/virt.h    |   5 +-
 3 files changed, 130 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c145678185..544004615d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -569,7 +569,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -590,7 +590,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
     } else {
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -605,7 +605,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (vms->its) {
+    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -624,7 +624,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -717,7 +717,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
@@ -735,7 +735,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          * SMMU: RC -> ITS.
          * Output IORT node is the ITS Group node (the first node).
          */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
+        }
     }
 
     build_iort_rmr_nodes(table_data, smmuv3_devs, &id);
@@ -1053,7 +1055,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -1067,7 +1069,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 390845c503..dde43caba9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -737,7 +737,6 @@ static void create_its(VirtMachineState *vms)
 {
     DeviceState *dev;
 
-    assert(vms->its);
     if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
         /*
          * Do nothing if ITS is neither supported by the host nor emulated by
@@ -957,9 +956,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
         create_its(vms);
-    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
+    } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
         create_v2m(vms);
     }
 }
@@ -2137,6 +2136,46 @@ static void finalize_gic_version(VirtMachineState *vms)
                                                gics_supported, max_cpus);
 }
 
+static void finalize_msi_controller(VirtMachineState *vms)
+{
+    /*
+     * VIRT_MSI_LEGACY_OPT_ITS_OFF is an option to replicate
+     * behavior of its=off when running with a GICv2, where a
+     * GICv2m is still present. Otherwise, it behaves the same
+     * as msi=off.
+     */
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
+            /*
+             * The legacy its= option in earlier releases allowed specifying
+             * this configuration and treated it as GICv3 + GICv2m.
+             * Diagnose it as an error even for that case. 
+             */
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
@@ -2256,6 +2295,7 @@ static void machvirt_init(MachineState *machine)
      * KVM is not available yet
      */
     finalize_gic_version(vms);
+    finalize_msi_controller(vms);
 
     if (vms->secure) {
         /*
@@ -2705,18 +2745,76 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
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
+    } else if (!strcmp(value, "off")) {
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
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_AUTO:
+    case VIRT_MSI_CTRL_ITS:
+        return true;
+    case VIRT_MSI_CTRL_NONE:
+    case VIRT_MSI_CTRL_GICV2M:
+    case VIRT_MSI_LEGACY_OPT_ITS_OFF:
+        return false;
+    default:
+        g_assert_not_reached();
+    }
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
@@ -3043,6 +3141,9 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+        case VIRT_MSI_LEGACY_OPT_ITS_OFF:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3463,6 +3564,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
 
+    object_class_property_add_str(oc, "msi", virt_get_msi,
+                                  virt_set_msi);
+    object_class_property_set_description(oc, "msi",
+                                          "Set MSI settings. "
+                                          "Valid values are auto, gicv2m, its and off");
+
     object_class_property_add_bool(oc, "dtb-randomness",
                                    virt_get_dtb_randomness,
                                    virt_set_dtb_randomness);
@@ -3518,8 +3625,8 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-    /* Default allows ITS instantiation */
-    vms->its = true;
+    /* Default allows ITS instantiation if available */
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3b382bdf49..8069422769 100644
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
-- 
2.50.1 (Apple Git-155)


