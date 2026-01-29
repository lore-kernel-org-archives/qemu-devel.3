Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88804D6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUay-0001Ht-CB; Thu, 29 Jan 2026 11:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaj-0000Tm-H0
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:01 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUad-0006gz-BO
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso10446245e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702990; x=1770307790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7tnPJl/fdy53AJrKdl7gdXxzjONlXeX1A8lfCUG4COA=;
 b=siD4EmLeIJnR/NjcL0XZQw9tAJdV+igApkXVPQkqHqnEDvwyKS/Kn88cXE9KVlmt8Q
 DjNRxBgf/EpChXO/NLwsPjmxen8Tu+onQDLf4hKEQvV1cDMUBmT4hTWylnDnXMHEq+Ch
 Ell/CRsyvTbRb5ttgZcSOnc/MGh00ivMC6lmrxo7MG4aFe5uf3spfxpxbcvsquUQ5xeX
 Ot5hFTEVSG6y1Z95yrfCByqkvIkC1x+kJ3U1kbFcnYnSbhrNv/NkdriidNYqFJOxEyjC
 PqiiJHxfSwsjv16L5RcoqpYvPbKrc+S8hacm43fYe/Z0sl2XAZGkM6R2426JBKoc7QAk
 mOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702990; x=1770307790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7tnPJl/fdy53AJrKdl7gdXxzjONlXeX1A8lfCUG4COA=;
 b=tFJotkXVzII128Oji5v7nHDbOsAq4/fXk+FvdCYTKz1mknbDsowG1EhKkfduOcUZMi
 +Im7ganU57ZgftadGJnk96eMdnv8Ogx0kaMXzcc0yDhP+L6jDiIcGO6H74OAAMcBeHaS
 Oi3kRGoyDm38ksDnTR3iKIvCR5lmH7lCAaOWVc3wITBxWLM+uABn1bfviq3Do1wumC/z
 4Xr1+ltWSHQ5hwJcU2MO0y2atKv3U8xSjl4nDIUfvMJLCYuKCTE1W/WnHyE9MT09o5nu
 2qDheM64E7/D5lkr+VNT2vAM1BZVLNPawwcxHbNTRsJgA3mS3D1mHJhJmXVc8NXslSzh
 hu9w==
X-Gm-Message-State: AOJu0YwWYkbNaFygawhtDYHJz+xfuU/cNDfT83GqwvoMR7VF7VaoPGGN
 5WZtE2cNmx5u4YOg3PcHl6X/m7Bqdgsk5cbwp6NOh1K3sBcG4DwqMAWgy4XI6pAGKo2yY143Nne
 BEW44npY=
X-Gm-Gg: AZuq6aK9T3gY+vP37rRMIPDUWtcXR2Xypw3F+53+JlFe8JmouPSXnvTFXDf0pcVoYEO
 L2qrXTt8FHBBSqeL2GTtc33VLXGfU7DyzhmsYbFCjusqn0QFb82pI0ImOLDE3oTBUVS4N6F1frq
 hP5MkoOU7WpBRKkdq3xG4rIHBo6R8o4PA+zUlEHWbs6ixa/75U1+ugGG2T0IB9S8M/QO9PO3EmG
 Vku97239wPfvVX2G75oLpgpqVNlTV6cTpjRK9qWE1MBMSTa28vclliwAvD7+Uu638ZI2tFuDcwU
 MIigDhhUosST+r+hNiLHWSgB1mOElXF3ypn5ebjTlSBl75jLW0RGq5BodQiOc3ixykb3HOZ00Wm
 7FPf6lxRsV+4ZxKc+5DbZScoicLRqOat1+KanWrBLjEq3kKfVRx9TbdSuT9TRa4Ri87RUWDawvI
 Fmxuqyl+48JtZO8Cn2vCx9nmlb294K/w==
X-Received: by 2002:a05:600c:2dc8:b0:47e:e452:ec12 with SMTP id
 5b1f17b1804b1-4808493b38cmr28292025e9.15.1769702989706; 
 Thu, 29 Jan 2026 08:09:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/43] hw/arm/virt-acpi-build: Add IORT RMR regions to handle
 MSI nested binding
Date: Thu, 29 Jan 2026 16:08:59 +0000
Message-ID: <20260129160917.1415092-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

To handle SMMUv3 accel=on mode(which configures the host SMMUv3 in nested
mode), it is practical to expose the guest with reserved memory regions
(RMRs) covering the IOVAs used by the host kernel to map physical MSI
doorbells.

Those IOVAs belong to [0x8000000, 0x8100000] matching MSI_IOVA_BASE and
MSI_IOVA_LENGTH definitions in kernel arm-smmu-v3 driver. This is the
window used to allocate IOVAs matching physical MSI doorbells.

With those RMRs, the guest is forced to use a flat mapping for this range.
Hence the assigned device is programmed with one IOVA from this range.
Stage 1, owned by the guest has a flat mapping for this IOVA. Stage2,
owned by the VMM then enforces a mapping from this IOVA to the physical
MSI doorbell.

The creation of those RMR nodes is only relevant if nested stage SMMU is
in use, along with VFIO. As VFIO devices can be hotplugged, all RMRs need
to be created in advance.

Initialise AcpiIortSMMUv3Dev structures to avoid using uninitialised
state when building the IORT, as legacy and device SMMUv3 paths
populate different fields now(e.g. accel).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260126104342.253965-26-skolothumtho@nvidia.com
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 115 +++++++++++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9032a5df1c..4ae4cbc6cd 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -257,6 +257,29 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
 #define ROOT_COMPLEX_ENTRY_SIZE 36
 #define IORT_NODE_OFFSET 48
 
+#define IORT_RMR_NUM_ID_MAPPINGS     1
+#define IORT_RMR_NUM_MEM_RANGE_DESC  1
+#define IORT_RMR_COMMON_HEADER_SIZE  28
+#define IORT_RMR_MEM_RANGE_DESC_SIZE 20
+
+/*
+ * IORT RMR flags:
+ *   Bit[0] = 0  Disallow remapping of reserved ranges
+ *   Bit[1] = 0  Unprivileged access
+ *   Bits[9:2] = 0x00 Device nGnRnE memory
+ */
+#define IORT_RMR_FLAGS  0
+
+/*
+ * MSI doorbell IOVA window used by the host kernel SMMUv3 driver.
+ * Described in IORT RMR nodes to reserve the IOVA range where the host
+ * kernel maps physical MSI doorbells for devices. This ensures guests
+ * preserve a flat mapping for MSI doorbell in nested SMMUv3(accel=on)
+ * configurations.
+ */
+#define MSI_IOVA_BASE   0x8000000
+#define MSI_IOVA_LENGTH 0x100000
+
 /*
  * Append an ID mapping entry as described by "Table 4 ID mapping format" in
  * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
@@ -265,7 +288,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
  * Note that @id_count gets internally subtracted by one, following the spec.
  */
 static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
-                                  uint32_t id_count, uint32_t out_ref)
+                                  uint32_t id_count, uint32_t out_ref,
+                                  uint32_t flags)
 {
     build_append_int_noprefix(table_data, input_base, 4); /* Input base */
     /* Number of IDs - The number of IDs in the range minus one */
@@ -273,7 +297,7 @@ static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
     build_append_int_noprefix(table_data, input_base, 4); /* Output base */
     build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
     /* Flags */
-    build_append_int_noprefix(table_data, 0 /* Single mapping (disabled) */, 4);
+    build_append_int_noprefix(table_data, flags, 4);
 }
 
 struct AcpiIortIdMapping {
@@ -321,6 +345,7 @@ typedef struct AcpiIortSMMUv3Dev {
     GArray *rc_smmu_idmaps;
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
+    bool accel;
 } AcpiIortSMMUv3Dev;
 
 /*
@@ -330,7 +355,7 @@ typedef struct AcpiIortSMMUv3Dev {
 static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
 {
     VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
-    AcpiIortSMMUv3Dev sdev;
+    AcpiIortSMMUv3Dev sdev = {0};
 
     sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     object_child_foreach_recursive(object_get_root(), iort_host_bridges,
@@ -362,10 +387,10 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
 static int iort_smmuv3_devices(Object *obj, void *opaque)
 {
     VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    AcpiIortSMMUv3Dev sdev = {0};
     GArray *sdev_blob = opaque;
     AcpiIortIdMapping idmap;
     PlatformBusDevice *pbus;
-    AcpiIortSMMUv3Dev sdev;
     int min_bus, max_bus;
     SysBusDevice *sbdev;
     PCIBus *bus;
@@ -375,6 +400,9 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     }
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    if (object_property_find(obj, "accel")) {
+        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+    }
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -448,10 +476,69 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
     }
 }
 
+static void
+build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
+{
+    AcpiIortSMMUv3Dev *sdev;
+    AcpiIortIdMapping *idmap;
+    int i;
+
+    for (i = 0; i < smmuv3_devices->len; i++) {
+        uint16_t rmr_len;
+        int bdf;
+
+        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
+        if (!sdev->accel) {
+            continue;
+        }
+
+        /*
+         * Spec reference:Arm IO Remapping Table(IORT), ARM DEN 0049E.d,
+         * Section 3.1.1.5 "Reserved Memory Range node"
+         */
+        idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, 0);
+        bdf = idmap->input_base;
+        rmr_len = IORT_RMR_COMMON_HEADER_SIZE
+                 + (IORT_RMR_NUM_ID_MAPPINGS * ID_MAPPING_ENTRY_SIZE)
+                 + (IORT_RMR_NUM_MEM_RANGE_DESC * IORT_RMR_MEM_RANGE_DESC_SIZE);
+
+        /* Table 18 Reserved Memory Range Node */
+        build_append_int_noprefix(table_data, 6 /* RMR */, 1); /* Type */
+        /* Length */
+        build_append_int_noprefix(table_data, rmr_len, 2);
+        build_append_int_noprefix(table_data, 3, 1); /* Revision */
+        build_append_int_noprefix(table_data, (*id)++, 4); /* Identifier */
+        /* Number of ID mappings */
+        build_append_int_noprefix(table_data, IORT_RMR_NUM_ID_MAPPINGS, 4);
+        /* Reference to ID Array */
+        build_append_int_noprefix(table_data, IORT_RMR_COMMON_HEADER_SIZE, 4);
+
+        /* RMR specific data */
+
+        /* Flags */
+        build_append_int_noprefix(table_data, IORT_RMR_FLAGS, 4);
+        /* Number of Memory Range Descriptors */
+        build_append_int_noprefix(table_data, IORT_RMR_NUM_MEM_RANGE_DESC, 4);
+        /* Reference to Memory Range Descriptors */
+        build_append_int_noprefix(table_data, IORT_RMR_COMMON_HEADER_SIZE +
+                        (IORT_RMR_NUM_ID_MAPPINGS * ID_MAPPING_ENTRY_SIZE), 4);
+        build_iort_id_mapping(table_data, bdf, idmap->id_count, sdev->offset,
+                              1);
+
+        /* Table 19 Memory Range Descriptor */
+
+        /* Physical Range offset */
+        build_append_int_noprefix(table_data, MSI_IOVA_BASE, 8);
+        /* Physical Range length */
+        build_append_int_noprefix(table_data, MSI_IOVA_LENGTH, 8);
+        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+    }
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049E.b, Feb 2021
+ * Document number: ARM DEN 0049E.d, Feb 2022
  */
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -465,7 +552,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
     GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
-    AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
+    AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
@@ -491,6 +578,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             nb_nodes++; /* ITS */
             rc_mapping_count += rc_its_idmaps->len;
         }
+        /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
+        for (i = 0; i < num_smmus; i++) {
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            if (sdev->accel) {
+                nb_nodes++;
+            }
+        }
     } else {
         if (vms->its) {
             nb_nodes = 2; /* RC and ITS */
@@ -563,7 +657,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Array of ID mappings */
         if (smmu_mapping_count) {
             /* Output IORT node is the ITS Group node (the first node). */
-            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
         }
     }
 
@@ -615,7 +709,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                        AcpiIortIdMapping, j);
                 /* Output IORT node is the SMMUv3 node. */
                 build_iort_id_mapping(table_data, range->input_base,
-                                      range->id_count, sdev->offset);
+                                      range->id_count, sdev->offset, 0);
             }
         }
 
@@ -628,7 +722,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                 range = &g_array_index(rc_its_idmaps, AcpiIortIdMapping, i);
                 /* Output IORT node is the ITS Group node (the first node). */
                 build_iort_id_mapping(table_data, range->input_base,
-                                      range->id_count, IORT_NODE_OFFSET);
+                                      range->id_count, IORT_NODE_OFFSET, 0);
             }
         }
     } else {
@@ -637,9 +731,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          * SMMU: RC -> ITS.
          * Output IORT node is the ITS Group node (the first node).
          */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
     }
 
+    build_iort_rmr_nodes(table_data, smmuv3_devs, &id);
     acpi_table_end(linker, &table);
     g_array_free(rc_its_idmaps, true);
     for (i = 0; i < num_smmus; i++) {
-- 
2.43.0


