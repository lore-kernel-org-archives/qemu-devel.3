Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEB3CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5Q-0003ZU-Nc; Tue, 16 Sep 2025 14:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0003Af-5e
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4n-0001da-Vf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45f29dd8490so28414005e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046003; x=1758650803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rC+TMiYJKUB8eByBDe713xQWhD5QH0p+dyLech7y7/s=;
 b=vS46SeO3D8V8CGJNfd1c1nac3zwnvleI+n6lb9xgZJAU7jpYmCVBfiaMnP03w7yRqp
 gLy+YwFGJ7dyZmGFCnWpnFYGbGSPnuUkj7vjchGYQQii8mClQPAp7lDnNlDdaU5t0Zv1
 /KzvwDt4ADRDGaoB8xHxPCCjE8b/zTpEEBNVi4Nl96viaRqiCqz7Jw1IqMIdxG96op4N
 dtEyhacEm4ZD0OI2zYquzNTJphbaySM8Eou7bM4QdF+EEjeTnMFGfVxxsnUDPUp8YkNb
 v3/kbK6xYTy0Tav/+HegejdiMeZegGAADUZtJI9C1QJlerWBla3aE7KmvYH3O2bU3UiJ
 MmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046003; x=1758650803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rC+TMiYJKUB8eByBDe713xQWhD5QH0p+dyLech7y7/s=;
 b=LonBfXdb0S0HLfkc7JEUzjqCqIKC6urYKRnwnGcroJBGTWQUWpXtFoL5T16N8nq8Hm
 jRtTJ3apMtx3ydjuQxFi8a3+QcMazbIyEvLzKWjDjB6ecIFygrHh1CYr24KPz7XQKV0n
 6VbCIIZODVZk0CgcTjOnFBQcH64l9KGZXaxQbOoTDp6w1CtO6o0VnFW8duYAKsHdJ0R7
 j+/RpdrUa7yZbzuwILnOzOY/LVPsDIjfRZLP6Eq4/FIS5dAa9glTbook6JsPvOtOkBu9
 mcHwK9JqaWdAhMWxX8MhctUB+MFUfCtvUxuFA42EcZAUMRPWfHpvXmUB1eNDB0vxq9pn
 LcvQ==
X-Gm-Message-State: AOJu0Yznwzj2JWFHzXHpPpBYA617qdXuBLqxEbQ26iIAAmJVIsWzAqZ5
 CI7mQb2LU3Jv/RSeeUL2etqSOlGBTewQLTcg59srcXwyqj98n3KqfEitzDJHMFn16thS3IDBVwU
 5vxF2
X-Gm-Gg: ASbGncuLRfuHF7VFOhTFd52zrTsP9suh7u+GaRRdGYH2OyHGGNTHQUQFv/Wqfe4wL24
 j8aPvJ9ZXd90V31c3X7OLh4KJU7cTsVPa8QEPwQCFXuTGXr27qo/pWrJ7CRnvIKRuO4f9t9KdOO
 Tsm554ej7HshPwiVgF3m0eB73gRd1wfQu/g7ZOW8L9yTKU2Q29lxLJjKjNiPi+m0RV1n0OQZDfv
 q9oHX3je/cGGJyb6qyoPI+t8txjTJVBWbDak4/PJuWEltHYz+GPg7V04WdSj9teGs9aeJLvEiGy
 1GUvRi1B7EfE4t8CrWyuoH0tvq3P3+V4yJW4U6rJMqpQiDBD+5flmv6hb0oZC7I1iJeYSB9N12Z
 kYWK6KP1neKfISWXZOCPP8k8N+xiC
X-Google-Smtp-Source: AGHT+IFiHiSHrhJ/LurtnXw9VUVCihYc6dyN2uSUgYqmP1qQ5QtHbhuiYrrttXjQHpQWjYLIBxrZRg==
X-Received: by 2002:a7b:cd8f:0:b0:45b:47e1:ef67 with SMTP id
 5b1f17b1804b1-45f212081abmr110670735e9.34.1758046003152; 
 Tue, 16 Sep 2025 11:06:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/36] hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
Date: Tue, 16 Sep 2025 19:06:00 +0100
Message-ID: <20250916180611.1481266-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Introduce a new struct AcpiIortSMMUv3Dev to hold all the information
required for SMMUv3 IORT node and use that for populating the node.

The current machine wide SMMUv3 is named as legacy SMMUv3 as we will
soon add support for user-creatable SMMUv3 devices. These changes will
be useful to have common code paths when we add that support.

Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Message-id: 20250829082543.7680-3-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    |   1 +
 hw/arm/virt-acpi-build.c | 137 ++++++++++++++++++++++++++-------------
 hw/arm/virt.c            |   1 +
 3 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 365a28b082c..ea2cff05b02 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -179,6 +179,7 @@ struct VirtMachineState {
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
     CXLState cxl_devices_state;
+    bool legacy_smmuv3_present;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b01fc4f8ef0..bef4fabe56f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -305,29 +305,65 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+typedef struct AcpiIortSMMUv3Dev {
+    int irq;
+    hwaddr base;
+    GArray *rc_smmu_idmaps;
+    /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
+    size_t offset;
+} AcpiIortSMMUv3Dev;
+
+/*
+ * Populate the struct AcpiIortSMMUv3Dev for the legacy SMMUv3 and
+ * return the total number of associated idmaps.
+ */
+static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    AcpiIortSMMUv3Dev sdev;
+
+    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    object_child_foreach_recursive(object_get_root(), iort_host_bridges,
+                                   sdev.rc_smmu_idmaps);
+    /*
+     * There can be only one legacy SMMUv3("iommu=smmuv3") as it is a machine
+     * wide one. Since it may cover multiple PCIe RCs(based on "bypass_iommu"
+     * property), may have multiple SMMUv3 idmaps. Sort it by input_base.
+     */
+    g_array_sort(sdev.rc_smmu_idmaps, iort_idmap_compare);
+
+    sdev.base = vms->memmap[VIRT_SMMU].base;
+    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    g_array_append_val(sdev_blob, sdev);
+    return sdev.rc_smmu_idmaps->len;
+}
+
 /* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
-static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
+static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 {
     AcpiIortIdMapping *idmap;
     AcpiIortIdMapping next_range = {0};
+    AcpiIortSMMUv3Dev *sdev;
 
-    /*
-     * Based on the RID ranges that are directed to the SMMU, determine the
-     * bypassed RID ranges, i.e., the ones that are directed to the ITS Group
-     * node and do not pass through the SMMU, by subtracting the SMMU-bound
-     * ranges from the full RID range (0x0000–0xFFFF).
-     */
-     for (int i = 0; i < smmu_idmaps->len; i++) {
-        idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+    for (int i = 0; i < smmuv3_devs->len; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        /*
+         * Based on the RID ranges that are directed to the SMMU, determine the
+         * bypassed RID ranges, i.e., the ones that are directed to the ITS
+         * Group node and do not pass through the SMMU, by subtracting the
+         * SMMU-bound ranges from the full RID range (0x0000–0xFFFF).
+         */
+         for (int j = 0; j < sdev->rc_smmu_idmaps->len; j++) {
+            idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, j);
 
-        if (next_range.input_base < idmap->input_base) {
-            next_range.id_count = idmap->input_base - next_range.input_base;
-            g_array_append_val(its_idmaps, next_range);
+            if (next_range.input_base < idmap->input_base) {
+                next_range.id_count = idmap->input_base - next_range.input_base;
+                g_array_append_val(its_idmaps, next_range);
+            }
+
+            next_range.input_base = idmap->input_base + idmap->id_count;
         }
-
-        next_range.input_base = idmap->input_base + idmap->id_count;
     }
-
     /*
      * Append the last RC -> ITS ID mapping.
      *
@@ -341,7 +377,6 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
     }
 }
 
-
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -351,9 +386,12 @@ static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
-    size_t node_size, smmu_offset = 0;
+    AcpiIortSMMUv3Dev *sdev;
+    size_t node_size;
+    int num_smmus = 0;
     uint32_t id = 0;
-    GArray *rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    int rc_smmu_idmaps_len = 0;
+    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
     GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
@@ -361,22 +399,21 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        object_child_foreach_recursive(object_get_root(),
-                                       iort_host_bridges, rc_smmu_idmaps);
+    if (vms->legacy_smmuv3_present) {
+        rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
+    }
 
-        /* Sort the smmu idmap by input_base */
-        g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
-
-        nb_nodes = 2; /* RC and SMMUv3 */
-        rc_mapping_count = rc_smmu_idmaps->len;
+    num_smmus = smmuv3_devs->len;
+    if (num_smmus) {
+        nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
+        rc_mapping_count = rc_smmu_idmaps_len;
 
         if (vms->its) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
              */
-            create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
+            create_rc_its_idmaps(rc_its_idmaps, smmuv3_devs);
 
             nb_nodes++; /* ITS */
             rc_mapping_count += rc_its_idmaps->len;
@@ -411,9 +448,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
     }
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
         int smmu_mapping_count, offset_to_id_array;
+        int irq = sdev->irq;
 
         if (vms->its) {
             smmu_mapping_count = 1; /* ITS Group node */
@@ -422,7 +460,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             smmu_mapping_count = 0; /* No ID mappings */
             offset_to_id_array = 0; /* No ID mappings array */
         }
-        smmu_offset = table_data->len - table.table_offset;
+        sdev->offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
         node_size =  SMMU_V3_ENTRY_SIZE +
@@ -435,7 +473,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Reference to ID Array */
         build_append_int_noprefix(table_data, offset_to_id_array, 4);
         /* Base address */
-        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
+        build_append_int_noprefix(table_data, sdev->base, 8);
         /* Flags */
         build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
@@ -486,21 +524,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
 
     /* Output Reference */
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (num_smmus) {
         AcpiIortIdMapping *range;
 
-        /*
-         * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
-         *
-         * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
-         * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
-         * ITS Group node, if ITS is available.
-         */
-        for (i = 0; i < rc_smmu_idmaps->len; i++) {
-            range = &g_array_index(rc_smmu_idmaps, AcpiIortIdMapping, i);
-            /* Output IORT node is the SMMUv3 node. */
-            build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset);
+        for (i = 0; i < num_smmus; i++) {
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+
+            /*
+             * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
+             *
+             * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS)
+             * is defined in the SMMUv3 table, where all SMMUv3 IDs are mapped
+             * to the ITS Group node, if ITS is available.
+             */
+             for (int j = 0; j < sdev->rc_smmu_idmaps->len; j++) {
+                range = &g_array_index(sdev->rc_smmu_idmaps,
+                                       AcpiIortIdMapping, j);
+                /* Output IORT node is the SMMUv3 node. */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, sdev->offset);
+            }
         }
 
         if (vms->its) {
@@ -525,8 +568,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_table_end(linker, &table);
-    g_array_free(rc_smmu_idmaps, true);
     g_array_free(rc_its_idmaps, true);
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        g_array_free(sdev->rc_smmu_idmaps, true);
+    }
+    g_array_free(smmuv3_devs, true);
 }
 
 /*
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e5c4142e822..16a1ac3c2d9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1651,6 +1651,7 @@ static void create_pcie(VirtMachineState *vms)
                 qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                        0x0, vms->iommu_phandle, 0x0, 0x10000);
             }
+            vms->legacy_smmuv3_present = true;
             break;
         default:
             g_assert_not_reached();
-- 
2.43.0


