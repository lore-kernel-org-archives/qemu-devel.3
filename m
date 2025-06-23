Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927C6C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThhf-0000Bi-6O; Mon, 23 Jun 2025 09:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThhK-0008NC-2X
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:59:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThhH-0007Jp-6p
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so3233828b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687132; x=1751291932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOV46Ps4a8FdPp4RmxE7rRFywBE4TgcqqV4mGLREwqI=;
 b=ZxThlQyg1ZSim0yRiNdGMgsonDQz6NI+QoIn+eYdyN5ckVhc5WsKJF8Sbp4YUDMgNP
 iKwae4B/R9uGzLKVBS0QTXMPu3f49ghw3od36MF9amVsBaKK7uvITT+EfseL5ncIPKkF
 lt0AJ2T22ItfTQCXsrpacplYLcnq72ZEyyxs9OxYHPPY4jHMCDa+SGEvZXT5lRXhysV+
 yLG+MAPMbEdzDs74Gmv2ohogQMf2uNrSiHMs3Buvx6hdsp1GFjJ8AszBBKGxfBcaZzyv
 hfClgEZ0SNS4UDSAG8lUg9tgBpGLnoT7UM6HDTxMvRn5sVD3uuYFdldXVvqToj1tYrpH
 0gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687132; x=1751291932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOV46Ps4a8FdPp4RmxE7rRFywBE4TgcqqV4mGLREwqI=;
 b=u4LsO98OQgemtqylZ7fWphmIYtrd2+x2vCIdKPxyWoDcSyqKnb8ZPBQ731sJ6f6sHd
 y794SBgQm8WTvRd3lPjvjS/6vfh/5yk3ekiv/J5M+hKTM96WxdTDjbTZmVz5xT9wwXMI
 uiqERgOaExfF7YZ/AITEyL5v27jJ2/0GGTGejDsqObz5ZT/allXWQ3PjvrREkSb9faLK
 WrIGfWztx8wMa132+ZnIsphHhlxhkCXpsR1vstXEPE/DtDkCrvWVZ073SjsdV9zZRJyl
 HOAAhwOQgvmO+GIMFlyVkguqRXxfLTMdeVaw85KrFwbA8mwxYJsnO5wlJLpEBfawAAWJ
 ECkQ==
X-Gm-Message-State: AOJu0YzwS+Du8zOXSSrjXfeGi6+At8fY6iSRZ/q7BxSYw5RtxlKyBzP9
 fQ9Eo41eo3fq/q9hpIG5tntf3F6BwxCGhq5TNfMVGdByF+6M0AuyE+iElHTQOUAzprHGn3r9eFg
 2vLve
X-Gm-Gg: ASbGncubG/wFFq0JqTe7ZCnJ1U6Zlt3odcEEwhiUiwY6L2u9Xul0N1RqrGjXgeqZu6t
 ivIhUex662LBb9+fYtaLKohKG7kJZ4zbKYbWh5SRs+nT8P3TfxFy+U7t41kwzhTraRLhp2R2lMq
 HgNbR/mvjNDcmjxIUdn62DJAjfMX/3CP0s7uhxdZjGY07FZhrF2RSB2H7L9Qoleyi9USkZewUKQ
 neVNbBw//0WzKe7zZTKSXtJpHHfYiBLZSVwFVc6eyBQE0ZQD9Cvuk3tU0DIUtUdhi5rkXVPAFsz
 0GkpgQ5ZeAP0Fb6g2g0yrgIp0xp8WSJLwIQeBnxbJrudl7eyn1NutCpBqoQUCou1tTI=
X-Google-Smtp-Source: AGHT+IFJNmxnYgubIONa8S0ID6ICpLttZdIWCbRmzjTTncyS+bivCcrNi3m2sJ4YPmh1McRRCoCaXQ==
X-Received: by 2002:a05:6a21:3387:b0:218:183b:ccaa with SMTP id
 adf61e73a8af0-220292ec76fmr18167176637.17.1750687131541; 
 Mon, 23 Jun 2025 06:58:51 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:51 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v5 8/9] hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
 when its=off
Date: Mon, 23 Jun 2025 13:57:48 +0000
Message-Id: <20250623135749.691137-9-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135749.691137-1-gustavo.romero@linaro.org>
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42b.google.com
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

Currently, the ITS Group nodes in the IORT table and the GIC ITS Struct
in the MADT table are always generated, even if GIC ITS is not available
on the machine.

This commit fixes it by not generating the ITS Group nodes, not mapping
any other node to them, and not advertising the GIC ITS in the MADT
table, when GIC ITS is not available on the machine.

Since the fix changes the MADT and IORT tables, add the blobs for the
"its=off" test to the allow list and update them in the next commit.

Reported-by: Udo Steinberg <udo@hypervisor.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Co-authored-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt-acpi-build.c                    | 128 ++++++++++++--------
 tests/qtest/bios-tables-test-allowed-diff.h |   2 +
 2 files changed, 80 insertions(+), 50 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 40a782a498..17ae46804a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -328,17 +328,27 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Sort the smmu idmap by input_base */
         g_array_sort(smmu_idmaps, iort_idmap_compare);
 
-	/*
-	 * Knowing the ID ranges from the RC to the SMMU, it's possible to
-	 * determine the ID ranges from RC that go directly to ITS.
-	 */
-        create_its_idmaps(its_idmaps, smmu_idmaps);
-
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
-        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
+        nb_nodes = 2; /* RC and SMMUv3 */
+        rc_mapping_count = smmu_idmaps->len;
+
+        if (vms->its) {
+            /*
+             * Knowing the ID ranges from the RC to the SMMU, it's possible to
+             * determine the ID ranges from RC that go directly to ITS.
+             */
+            create_its_idmaps(its_idmaps, smmu_idmaps);
+
+            nb_nodes++; /* ITS */
+            rc_mapping_count += its_idmaps->len;
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
@@ -347,31 +357,43 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
-
+        int num_id_mappings, offset_to_id_array;
+
+        if (vms->its) {
+            num_id_mappings = 1; /* ITS Group node */
+            offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
+        } else {
+            num_id_mappings = 0; /* No ID mappings */
+            offset_to_id_array = 0; /* No ID mappings array */
+        }
         smmu_offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
-        node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
+        node_size =  SMMU_V3_ENTRY_SIZE +
+                     (ID_MAPPING_ENTRY_SIZE * num_id_mappings);
         build_append_int_noprefix(table_data, node_size, 2); /* Length */
         build_append_int_noprefix(table_data, 4, 1); /* Revision */
         build_append_int_noprefix(table_data, id++, 4); /* Identifier */
-        build_append_int_noprefix(table_data, 1, 4); /* Number of ID mappings */
+        /* Number of ID mappings */
+        build_append_int_noprefix(table_data, num_id_mappings, 4);
         /* Reference to ID Array */
-        build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
+        build_append_int_noprefix(table_data, offset_to_id_array, 4);
         /* Base address */
         build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
         /* Flags */
@@ -387,9 +409,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0, 4); /* Proximity domain */
         /* DeviceID mapping index (ignored since interrupts are GSIV based) */
         build_append_int_noprefix(table_data, 0, 4);
-
-        /* Output IORT node is the ITS Group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        /* Array of ID mappings */
+        if (num_id_mappings) {
+            /* Output IORT node is the ITS Group node (the first node). */
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        }
     }
 
     /* Table 17 Root Complex Node */
@@ -430,7 +454,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          *
          * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
          * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
-         * ITS Group node.
+         * ITS Group node, if ITS is available.
          */
         for (i = 0; i < smmu_idmaps->len; i++) {
             range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
@@ -439,15 +463,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
+             * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
+             * node directly: RC -> ITS.
+             */
+            for (i = 0; i < its_idmaps->len; i++) {
+                range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
+                /* Output IORT node is the ITS Group node (the first node). */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, IORT_NODE_OFFSET);
+            }
         }
     } else {
         /*
@@ -768,18 +794,20 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
 
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a88198d5c2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
-- 
2.34.1


