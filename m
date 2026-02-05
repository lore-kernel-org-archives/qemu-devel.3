Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DF1E9129F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1EE-0003tO-55; Thu, 05 Feb 2026 10:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1EC-0003sV-DG
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:08 -0500
Received: from p-west2-cluster4-host1-snip4-10.eps.apple.com ([57.103.69.201]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1EA-0001iW-7Z
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:08 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 E7CBD18001FA; Thu,  5 Feb 2026 15:25:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305105; x=1772897105;
 bh=XyBHHRZUjZrB24DOEIVWdZ5GavQ/FkCfYqY7wYjlLmk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HzQ+4RJaclWhMjRbdfrWwB8WCarGF5jJyx/C2amuE/kVfQMiRUNGJTHt/FV2k2m+2F/2EYS25Kg258iKKG8fo5UKsw7XbEl26z4n9W0W7E08hCMsJufefAELgne04MZffs0H0SQCVvTVjm8zwkrmddvnvB1nqX+nnpbDcdd2ycjhBsa4rI9ISEDABjNxOufwMsazdAEMMPNQg70qSKVcWcGiAzd1BmYTlyAGco7FMxQur64oy80Qzd9hP0mIdcMZyjSYbUVwWkn3uBOAtzUbd5roItTmF/7tJHCw5hNT6nJz4XasliCkEKzcKPv0t2ab8SBIgg9TzTOdc8y34BNkaw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 1F77A180018C; Thu,  5 Feb 2026 15:24:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 04/22] hw: arm: virt: rework MSI-X configuration
Date: Thu,  5 Feb 2026 16:24:07 +0100
Message-ID: <20260205152432.78208-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=OMgqHCaB c=1 sm=1 tr=0 ts=6984b650
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=XHbtxiRcFRs46boockMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfXzbeGiTKfq80g
 y8A0d76VQFZFCLBMTy7s7X8Csy8Lg3G1h3N0aAM5bRyWXgAGk5L7TM56mmpm/HgFcZL5eYWr/ST
 rSyc2rMLhgz/3hLxQdpb+Q0KKrdQuXaHDpu7P55LX8s8RC69t7kG0mbbytKagFz0qszJBf/M7kJ
 HzkTLmNMx30a2Op6+Z2e2/2ZzBuHsbOJbkoDpsbuQ6eVhyZthGGCFjIFCUmpo7bWgoxDOFQFCXu
 ObrwkSCQJJ/66d2DkTCRGPD13ru75hun1FuZebewwPamQ9lzxa/54083gMkftGqoz8T5aMjZCLn
 E3lCnpUc5HyeecA/lHDZLmsiIzGrQCsatPZdzP1EpUe9CBC6uA0RMVV5+F1ijw=
X-Proofpoint-GUID: bycMThuW5V9QsEzojCUq9CueoOcOoqSh
X-Proofpoint-ORIG-GUID: bycMThuW5V9QsEzojCUq9CueoOcOoqSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 clxscore=1030 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAAB+Sgiwaqrs0w33i5ZffHFX1mRjKcBB08gb6nQdw3vTAaPwQ5/MqmmzpirGgegvEL/tvYTe38bH33PrD3j0faaJNlYnahkIEOOODQekeSA7U5v8QVKV5WfslFfkAa+/saol7lkw+LJKHtGrQRskpoHPZlZ3XFsmaYV/2DQ4TJpZcLmmgYI13Wu92M27eT6gKv6aNwVpDn+MNiOySNg6Vp6Rmjq6qseAznYqLVqb5NEI5kIeAElEdWyLarfgPhc1EIhipzuAJBrcyZMJzBcp7Ycp/yX1yGjuV9EOkhIaulzAhVkc20lFM6s/eoRpNO5pmmJrKKXq4IY3FVJudJKS6yPrT0DXqKaurDF/oFVCr84qN8tBPD3kk2oJ3idox9NA8t9BWVMN0W5aSiPmu00d9O8cvcQ9Ff0gykuzPuo98aI7REeUPLOFnYJD+BY+8IeUJQFjBjFDxwLzLKEE723pz11a1bit4X1yTkBKzKW/djTrwujCFiseljP8wFv4pmknE1miiQtZNqBaCVwZ96HtEa5FGJaosphV1Hir4pHkywApyAyU3LnoPNe6+Uxe1yhMk0M4RnLOjoy80nRKf4WfQ4lkceTt6NDgyVuGUk9ubUaDlYJwTXO8IWxfAmy4+0tE/JUdTmrlCl4w/UJ77JP8QLMfE0Y54nKFwtEKkHOkW1huGpezk4qLk2ebQxL5FuQ0vxpGgpS/9VZOTa124sl3ybP+5nudMEKocSf4kc9EIpU0dNOrjbJMC5/ncain8tteyc+sW1OsMcXT6D9QcVvwRBh85mj6mWuQ6KlbUEdPXtSrwp19ILjCnbZY5PeaZl7ZJsocuutpExqBnR8xikGSwJcUw7gXJS4+6hXDPSFvVzycuo1kupX0wFrRRWmf0GYcbCzulETDAD5ClQt684fQLbZOYxSGU+6nm8yxoDADat03x+/Ge5xyaRYsHiW
Received-SPF: pass client-ip=57.103.69.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c |  20 ++++---
 hw/arm/virt.c            | 119 ++++++++++++++++++++++++++++++++++++---
 include/hw/arm/virt.h    |   5 +-
 3 files changed, 128 insertions(+), 16 deletions(-)

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
index 390845c503..aa5e992712 100644
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
@@ -2137,6 +2136,44 @@ static void finalize_gic_version(VirtMachineState *vms)
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
+        } else {
+            vms->msi_controller = VIRT_MSI_CTRL_NONE;
+        }
+    }
+    if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
+        if (vms->gic_version == VIRT_GIC_VERSION_2) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        } else {
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
@@ -2256,6 +2293,7 @@ static void machvirt_init(MachineState *machine)
      * KVM is not available yet
      */
     finalize_gic_version(vms);
+    finalize_msi_controller(vms);
 
     if (vms->secure) {
         /*
@@ -2705,18 +2743,76 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
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
@@ -3043,6 +3139,9 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+        case VIRT_MSI_LEGACY_OPT_ITS_OFF:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3463,6 +3562,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3518,8 +3623,8 @@ static void virt_instance_init(Object *obj)
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


