Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C839BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSg-0005jG-0Y; Tue, 01 Jul 2025 13:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSX-0005dG-0I
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSR-0003XY-4S
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:52 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso39550675e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389665; x=1751994465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8nJYMFQTTQlV3cPi/X87l7YEfQlAZXZ97oIiIECIivw=;
 b=lqwhjkphRRLj2UCn+1Vt7KwHwThtQA3cczOoHHUKSPmH0eO+DSAAOdysDtlXT3sATK
 BGAs6AC63VLoErrHhfHDHt2C5Y/LvYJ1I8iWBUaDkcEJs5z+HCAP2xzPXp6VnvwE+/Nn
 WVahvee8A0dnbI0roODSTNLtK57Ouc1ZqzaFupLKByTXEQW56XJP5VYIlOYCkPKPnSxc
 +YGzK/58zoZObNWpoRE/m9zfgdDrciHp27Ecv0H+G+8F53UkA4y5vkZ/W0GA+x5fdVtf
 7X1/eW7xqv8JoRbPjrW9htdNFJcfB3gqTDunj7m2JqSWjsocZNY0rlYtJm8J/6LclVlL
 VBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389665; x=1751994465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nJYMFQTTQlV3cPi/X87l7YEfQlAZXZ97oIiIECIivw=;
 b=m+W/uoU5B5BQ9O/04k9LcETDcAr12VRPm7bfn5SSwO8J8AMjwjTjzSks9vPw2Dkcaj
 Myzh09wLjXKoNxkplUSH0SJUb5CAr1DfdLExMyKh3+SfKWH8e3+farJ+cNaVh8Venn8T
 DYkRP5pj9XCYylhq2+tBd13Ss/CROKYMblfvGbXnNC9P+XUduHxsyswReTt8jHNf0+Es
 9Ft9A4aTO133oiVlgU7wS/zSzbR7fumKWscZ/JfvRGZIDe1CTS7hi47MOaGLfGbonbws
 +/NmCkjN/5QRV2LWBnxxb9cbTkCesNxfUTMainsZw1nsYHPzDHKoelTfaJHg2QTzPWuA
 bvXQ==
X-Gm-Message-State: AOJu0YyMCApdpti1ed1YeiGEU+kcxY8HvJOVihtKbFVCWBvrZEZWI5bs
 Wy5NyI5HLbjTx/Mx5i2sdUGn+vFF/51OQRsJunZrw6kePEaWaor7lGVwbrcWoIESIQo5FPC2p05
 LyaKY
X-Gm-Gg: ASbGnctsaLqfsHUz9VsaA2BTYHquEBnY4zmPW7OiljHFGQa/r23O0zHHiICDh9m2iIC
 qhkBLgKpOdGTY6ivEfZboFax13SAzF2eq4sHoG+Q2N8BKEYn0hpWajTcTcXReYJNr8DAPe1C3Bd
 kOBA547iy6AmRpnCOeSqX/dJVsDk7O898XExFu3Ls0fMgv60NxzEp1vVluUv25/msue1YSOQ9sB
 kc+ERnzsBHsNyMqgX8SmQfWVCjSjtq3T2mmfNksEGTnGrSfBvn39Oa+RYo1UtzObW2x6SFP8TxN
 15VPpw5HGhUjIugOK2uLihCMCz2tFxmFlRmi1IQjo0DyMH5PIv4mGO2uszjeDHkaXJd2
X-Google-Smtp-Source: AGHT+IG7C0fyAcYUoS/NQ70Cxzj+20uLHwxg8kI2njr5lE3zSdWGDO3fAdZvuh0yaEpQtRc8Qzm0/A==
X-Received: by 2002:a05:600c:4f06:b0:442:e9eb:1b48 with SMTP id
 5b1f17b1804b1-4539002c9f6mr178124175e9.24.1751389664872; 
 Tue, 01 Jul 2025 10:07:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/43] hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
 when its=off
Date: Tue,  1 Jul 2025 18:06:58 +0100
Message-ID: <20250701170720.4072660-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Currently, the ITS Group nodes in the IORT table and the GIC ITS Struct
in the MADT table are always generated, even if GIC ITS is not available
on the machine.

This commit fixes it by not generating the ITS Group nodes, not mapping
any other node to them, and not advertising the GIC ITS in the MADT
table, when GIC ITS is not available on the machine.

Since the fix changes the MADT and IORT tables, add the blobs for the
"its=off" test to the allow list and update them in the next commit.

This commit also renames the smmu_idmaps and its_idmaps variables in
build_iort() to rc_smmu_idmaps and rc_its_idmaps, respectively, to make
it clearer which nodes are involved in the mappings associated with
these variables.

Reported-by: Udo Steinberg <udo@hypervisor.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20250628195722.977078-9-gustavo.romero@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Co-authored-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: wrapped an overlong comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 +
 hw/arm/virt-acpi-build.c                    | 140 ++++++++++++--------
 2 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..a88198d5c2a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5886192fe3f..cd90c47976c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -267,7 +267,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 }
 
 /* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
-static void create_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
+static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
 {
     AcpiIortIdMapping *idmap;
     AcpiIortIdMapping next_range = {0};
@@ -314,8 +314,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, nb_nodes, rc_mapping_count;
     size_t node_size, smmu_offset = 0;
     uint32_t id = 0;
-    GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
-    GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    GArray *rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
@@ -324,22 +324,38 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         object_child_foreach_recursive(object_get_root(),
-                                       iort_host_bridges, smmu_idmaps);
+                                       iort_host_bridges, rc_smmu_idmaps);
 
         /* Sort the smmu idmap by input_base */
-        g_array_sort(smmu_idmaps, iort_idmap_compare);
+        g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
 
         /*
          * Knowing the ID ranges from the RC to the SMMU, it's possible to
          * determine the ID ranges from RC that are directed to the ITS.
          */
-        create_its_idmaps(its_idmaps, smmu_idmaps);
+        create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
 
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
-        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
+        nb_nodes = 2; /* RC and SMMUv3 */
+        rc_mapping_count = rc_smmu_idmaps->len;
+
+        if (vms->its) {
+            /*
+             * Knowing the ID ranges from the RC to the SMMU, it's possible to
+             * determine the ID ranges from RC that go directly to ITS.
+             */
+            create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
+
+            nb_nodes++; /* ITS */
+            rc_mapping_count += rc_its_idmaps->len;
+        }
     } else {
-        nb_nodes = 2; /* RC, ITS */
-        rc_mapping_count = 1;
+        if (vms->its) {
+            nb_nodes = 2; /* RC and ITS */
+            rc_mapping_count = 1; /* Direct map to ITS */
+        } else {
+            nb_nodes = 1; /* RC only */
+            rc_mapping_count = 0; /* No output mapping */
+        }
     }
     /* Number of IORT Nodes */
     build_append_int_noprefix(table_data, nb_nodes, 4);
@@ -348,31 +364,43 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    /* Table 12 ITS Group Format */
-    build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
-    node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
-    build_append_int_noprefix(table_data, node_size, 2); /* Length */
-    build_append_int_noprefix(table_data, 1, 1); /* Revision */
-    build_append_int_noprefix(table_data, id++, 4); /* Identifier */
-    build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
-    build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
-    build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
-    /* GIC ITS Identifier Array */
-    build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
+    if (vms->its) {
+        /* Table 12 ITS Group Format */
+        build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
+        node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
+        build_append_int_noprefix(table_data, node_size, 2); /* Length */
+        build_append_int_noprefix(table_data, 1, 1); /* Revision */
+        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
+        build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
+        build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
+        build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
+        /* GIC ITS Identifier Array */
+        build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
+    }
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+        int smmu_mapping_count, offset_to_id_array;
 
+        if (vms->its) {
+            smmu_mapping_count = 1; /* ITS Group node */
+            offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
+        } else {
+            smmu_mapping_count = 0; /* No ID mappings */
+            offset_to_id_array = 0; /* No ID mappings array */
+        }
         smmu_offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
-        node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
+        node_size =  SMMU_V3_ENTRY_SIZE +
+                     (ID_MAPPING_ENTRY_SIZE * smmu_mapping_count);
         build_append_int_noprefix(table_data, node_size, 2); /* Length */
         build_append_int_noprefix(table_data, 4, 1); /* Revision */
         build_append_int_noprefix(table_data, id++, 4); /* Identifier */
-        build_append_int_noprefix(table_data, 1, 4); /* Number of ID mappings */
+        /* Number of ID mappings */
+        build_append_int_noprefix(table_data, smmu_mapping_count, 4);
         /* Reference to ID Array */
-        build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
+        build_append_int_noprefix(table_data, offset_to_id_array, 4);
         /* Base address */
         build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
         /* Flags */
@@ -388,9 +416,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0, 4); /* Proximity domain */
         /* DeviceID mapping index (ignored since interrupts are GSIV based) */
         build_append_int_noprefix(table_data, 0, 4);
-
-        /* Output IORT node is the ITS Group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        /* Array of ID mappings */
+        if (smmu_mapping_count) {
+            /* Output IORT node is the ITS Group node (the first node). */
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        }
     }
 
     /* Table 17 Root Complex Node */
@@ -431,24 +461,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          *
          * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
          * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
-         * ITS Group node.
+         * ITS Group node, if ITS is available.
          */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+        for (i = 0; i < rc_smmu_idmaps->len; i++) {
+            range = &g_array_index(rc_smmu_idmaps, AcpiIortIdMapping, i);
             /* Output IORT node is the SMMUv3 node. */
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, smmu_offset);
         }
 
-        /*
-         * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
-         * node directly: RC -> ITS.
-         */
-        for (i = 0; i < its_idmaps->len; i++) {
-            range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
-            /* Output IORT node is the ITS Group node (the first node). */
-            build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, IORT_NODE_OFFSET);
+        if (vms->its) {
+            /*
+             * Map bypassed (don't go through the SMMU) RIDs (input) to
+             * ITS Group node directly: RC -> ITS.
+             */
+            for (i = 0; i < rc_its_idmaps->len; i++) {
+                range = &g_array_index(rc_its_idmaps, AcpiIortIdMapping, i);
+                /* Output IORT node is the ITS Group node (the first node). */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, IORT_NODE_OFFSET);
+            }
         }
     } else {
         /*
@@ -460,8 +492,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_table_end(linker, &table);
-    g_array_free(smmu_idmaps, true);
-    g_array_free(its_idmaps, true);
+    g_array_free(rc_smmu_idmaps, true);
+    g_array_free(rc_its_idmaps, true);
 }
 
 /*
@@ -769,18 +801,20 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        /*
-         * ACPI spec, Revision 6.0 Errata A
-         * (original 6.0 definition has invalid Length)
-         * 5.2.12.18 GIC ITS Structure
-         */
-        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
-        build_append_int_noprefix(table_data, 20, 1);   /* Length */
-        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
-        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
-        /* Physical Base Address */
-        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
-        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
+        if (vms->its) {
+            /*
+             * ACPI spec, Revision 6.0 Errata A
+             * (original 6.0 definition has invalid Length)
+             * 5.2.12.18 GIC ITS Structure
+             */
+            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
+            build_append_int_noprefix(table_data, 20, 1);   /* Length */
+            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
+            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
+            /* Physical Base Address */
+            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
+            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
+        }
     } else {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
-- 
2.43.0


