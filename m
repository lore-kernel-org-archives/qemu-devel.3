Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36947D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXZH-0005Av-S3; Thu, 29 Jan 2026 14:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZG-00052g-LK
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:38 -0500
Received: from ci-2007f-snip4-11.eps.apple.com ([57.103.88.63]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZA-0005pq-5Z
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:34 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 2D2611801882; Thu, 29 Jan 2026 19:20:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714431; x=1772306431;
 bh=wiTfFbalASc7qWsWVzfuwztjk0Qn23RSC8w/z5wFhEY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=evsDIQitiJgqC2T5suV8KJ+e0u85iLOAJwekvEuwWiKv9btTyVDRcZa1k78dLuWaB6Axlx5pI7OfZj+NaKoemfiWYBPbqbnW8IBLMFxgeI6elDygAVv2AyXfZlZseu3uVEQ4KrzNE3IfvE+prYNhU+00rW9euwaHxcaVit7UR8HDe0WTGQ64+0KeiOLpGU4dm1jZ/7YsG2e2Z/BIyTIqTyHgjVssu18eJ6oES4iPpwCAmj9lAe1K0tK65eVFM4r50QavMm+4hC7af9xMSxbee8mtCT6YAag8L9T16eJTld6omXHqVNX67diSs13mRbPrJeMmZmFQBTCWQfyBfvRFWQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 AD8411800175; Thu, 29 Jan 2026 19:20:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 04/22] hw: arm: virt: rework MSI-X configuration
Date: Thu, 29 Jan 2026 20:19:49 +0100
Message-ID: <20260129192009.14707-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=LLBrgZW9 c=1 sm=1 tr=0 ts=697bb2fd
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XHbtxiRcFRs46boockMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfXxC7M4WK+dQrJ
 Pj7aO5G1WDFzvWosxg9+OtQbl8CxenyqdO3XZyppHe9OgFULn6zWMwJ7gWByPDzMQpELFQUdthe
 qCcJOfeD6uhaapYUKxTiRPls4qct3qCgk4msLRPi0lc8MZt7tBOkAhuuVbatTE9pexHSXrk7izB
 s0gubErFLiZ2KC6/R1eHEB2Z6vQtGuCWhFrkNfT+9x7dbOSBTQSf8T5XMXQbm11tjWBTGNnG11s
 o/5o8XnmtDlULQG2LVtQ06nB2JySGAK8yqZPWwq51gb7vqImcrz/94hTnURzwJJdOaUeWNQjTHl
 Es7afTiEOi1sYnNlhVoTHv2rrNO6v9BsJ3QBuLSqhkrYJQZ6qqvsZ0o4ncr9Bg=
X-Proofpoint-GUID: rlf7Sdy9xQd7x_k32PQiF5abEaOWoxsu
X-Proofpoint-ORIG-GUID: rlf7Sdy9xQd7x_k32PQiF5abEaOWoxsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABdvnJq+DcABJoWsjQJYMo3zROvNlhZDegdES5887IFo/Y+TcCQsc1wVaHondKOmDtiRCSCk2c3RCr+mvGItWXNCsOoeMGnCsSUlIBMRkyTfzTnyjRrGaq6nOWK2jMkxGeHqofuQU9+fO8gUG3hgZ1t8B6U/X6NsgwKqJYV7KFW2Mw35AfPsqg42QH0mq9dlI0M6sUgwvPmE3gF02zbPIJGYW2lrLYIF17dNJ5Udh+xTYMM782G9+60SSshocjWraqieoQmMPi7O7L9L1ifNL3r3EIl/EV0kiu+CA6g8J9rnybvIuhrbwCQFudJdUQCox4pujAlQy+JDLeTmJkjVFto0Ni4o4gELd7wYCQDf2bxXmGy3RjJzJPTizbDocCdQNJHMBUIxVIMVs8Xbztk+vK3jFR2V0+eeTlbHVFupaxXDP5HjqS6Y2vm+/W7yTef9QKIuAZXYyz2iN3F/hnaKzLGxEGE2X81e7OBnTB+pQpjdNX/NDz/bAkyoYEOYxWgMBye7WEW0ggQK3qam9O5i79ssV5/g4LdBTERQVxLexFouDqzwZv+96/D8AA44Xwnm3h2C4W8qI37+613mDPvBlZnrC+28FEvAPW3MpPigXIoPLuUDcOoHUu5vIoU4Ww4ghiAMlIBRQzekpX3mTn7deG4+wDvS9X0AXYt7aMi8dnczv8SUO+egkLY3+outEIP9fDDn6rLcKQA3C/lJUSjbkLeett1uOFBnoK8WEmNBpJAw0fom4Oc8muNuMmizPIV6quTAa2/aaYN8+3XiHbDast+uKkAkjP2uJ1rmJzXzKxneLAmCp5CPzzIR5WRFZRh23PXBnvaecZ0A5YEmUd4Y/po4ZTlg==
Received-SPF: pass client-ip=57.103.88.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


