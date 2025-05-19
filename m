Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10645C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrmi-0004jU-E4; Mon, 19 May 2025 00:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmV-0004is-Fa
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:17 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmS-00044j-Kk
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-231d4679580so21974565ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627631; x=1748232431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5C5gvbFcMnRIuSXrPTRGKO/UvIsswQe1PqV9iglJ8E=;
 b=aK+8WgfrhELFXcI64rfWvNi3YYU4LIboRumLzdcmWVaILZCQqx7YqA03Y6gx24FD2U
 2BhlEH6C5hRKND6HwjkmovafBMEOG6Hv0SIbrKf0DDmB3Ft8ufXSM29BaA4gJ1Ld82B6
 tgKXQjH8dpQh1eI903woW1ECEtk3m/bnDL37kyDXjp617aipLfzT763KZt6+G25MU4pu
 BOkmHu7bHKdmx6udF+Xx8AoFp1twwrsYvTXQgQpeNDDnCLmSflQuEXwjzoLwdo/jrFOD
 2eapnoyiSYCP9uRnw0d76j8cin5H2ABW/1dksetMDNdugvx51hkIOAvRkF/W0CGtfUUI
 TPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627631; x=1748232431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5C5gvbFcMnRIuSXrPTRGKO/UvIsswQe1PqV9iglJ8E=;
 b=Xh1iNveySQ8nHKgePcNYC/vS+UNdGM+zfFVKtpnRp6rGy8NuUQmP3/e1BQSrmHe//F
 ejejSPxNV5kVERB8sy/JFln2lgOjJ6FTk1LtgDJdcSyMm7AIwGkpYjpKL7I1g8px+h+m
 lCcveI7XwhQ7aSl7ZIsgtNWBGGco5H8PoVTis+p3F7N79ACOR+VVaZjpi6j2zrJU2qCQ
 RisrqhGrZANNd/rDh80RnGJ1BMjYMf3u+iRg5tiNg0SfitgCpvd/Morm+xBTBdozC3ad
 ZKO/4uDQLKftdwMbnGeTAfQQlNtJt41TZJN0iq/VQ2wxrWrlza3FGbMNzoyOBrSRdelx
 w0Ww==
X-Gm-Message-State: AOJu0Yz9msKvrUgY9ZR9Rp+m+YoAsMBKdbwwR+J4dTCetCTVIh/hVvG7
 nS6kndNSFKrBOZqHLtnq+u/wP4mWKG3xC/tpqN0DnFovIyGUQ5kt6YxdLhfCJQ==
X-Gm-Gg: ASbGncvgnV0IFpuussqJnge//+5a+AhxUSo1DFScJQDlIM96NyzQkTDB61WHSPnvLt1
 B9Mni0PT4+nbCardaji2nrhJWEFyJ/rcxUcJPXW+8MOTbMDM11F2CE3v3OesvmsMZrWVNtcEdIW
 qL/chhRv12vqlkdVST1fnmV9md7/u81FFhTNQVySWYLI35HqfR33Dlqayc5fR/7OSKCYA2JDhdD
 q5AtekrO4K1+UELhsUvPlzYKYxUhGJ3pc+vSZe1UQfRjJZMX8Seme4wNxTSfTq9y6fqkGFXZIXv
 QwKRes2exzciRjvvuA1ef0qE+f3el/MSn+j5NumqAtfSdo5TKvg1OUgDBf8rj+cZtreJs3FfC+A
 7WSZMGRTfHg2nYoyhEZ6ku2a5bQVKMtnvFQbJZ/M35FucNvp7ZAGyQmiCg4cJx42p2F8=
X-Google-Smtp-Source: AGHT+IGlNLSuL2Y6S/NobeJ68ilfdCP8vTz0Bvz5kfvvqnwLc6+1trm/4QT6qCkLc4J9EkQQ4vBVGA==
X-Received: by 2002:a17:903:18f:b0:224:249f:9734 with SMTP id
 d9443c01a7336-231d43d9a1fmr169883105ad.4.1747627630581; 
 Sun, 18 May 2025 21:07:10 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/56] hw/riscv/virt-acpi-build: Add support for RIMT
Date: Mon, 19 May 2025 14:04:59 +1000
Message-ID: <20250519040555.3797167-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

RISC-V IO Mapping Table (RIMT) is a new static ACPI table used to
communicate IOMMU information to the OS. Add support for creating this
table when the IOMMU is present. The specification is frozen and
available at [1].

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v0.99/rimt-spec.pdf

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250322043139.2003479-3-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 215 +++++++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 1ad6800508..1eef2fb4eb 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -198,6 +198,32 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
     aml_append(scope, dev);
 }
 
+/*
+ * Add DSDT entry for the IOMMU platform device.
+ * ACPI ID for IOMMU is defined in the section 6.2 of RISC-V BRS spec.
+ * https://github.com/riscv-non-isa/riscv-brs/releases/download/v0.8/riscv-brs-spec.pdf
+ */
+static void acpi_dsdt_add_iommu_sys(Aml *scope, const MemMapEntry *iommu_memmap,
+                                    uint32_t iommu_irq)
+{
+    uint32_t i;
+
+    Aml *dev = aml_device("IMU0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0004")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(iommu_memmap->base,
+                                       iommu_memmap->size, AML_READ_WRITE));
+    for (i = iommu_irq; i < iommu_irq + 4; i++) {
+        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE, AML_ACTIVE_LOW,
+                                      AML_EXCLUSIVE, &i, 1));
+    }
+
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 /*
  * Serial Port Console Redirection Table (SPCR)
  * Rev: 1.10
@@ -450,6 +476,9 @@ static void build_dsdt(GArray *table_data,
     }
 
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
+    if (virt_is_iommu_sys_enabled(s)) {
+        acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
+    }
 
     if (socket_count == 1) {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
@@ -602,6 +631,187 @@ static void build_madt(GArray *table_data,
     acpi_table_end(linker, &table);
 }
 
+#define ID_MAPPING_ENTRY_SIZE        20
+#define IOMMU_ENTRY_SIZE             40
+#define RISCV_INTERRUPT_WIRE_OFFSSET 40
+#define ROOT_COMPLEX_ENTRY_SIZE      20
+#define RIMT_NODE_OFFSET             48
+
+/*
+ * ID Mapping Structure
+ */
+static void build_rimt_id_mapping(GArray *table_data, uint32_t source_id_base,
+                                  uint32_t num_ids, uint32_t dest_id_base)
+{
+    /* Source ID Base */
+    build_append_int_noprefix(table_data, source_id_base, 4);
+    /* Number of IDs */
+    build_append_int_noprefix(table_data, num_ids, 4);
+    /* Destination Device ID Base */
+    build_append_int_noprefix(table_data, source_id_base, 4);
+    /* Destination IOMMU Offset */
+    build_append_int_noprefix(table_data, dest_id_base, 4);
+    /* Flags */
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
+struct AcpiRimtIdMapping {
+    uint32_t source_id_base;
+    uint32_t num_ids;
+};
+typedef struct AcpiRimtIdMapping AcpiRimtIdMapping;
+
+/* Build the rimt ID mapping to IOMMU for a given PCI host bridge */
+static int rimt_host_bridges(Object *obj, void *opaque)
+{
+    GArray *idmap_blob = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
+        PCIBus *bus = PCI_HOST_BRIDGE(obj)->bus;
+
+        if (bus && !pci_bus_bypass_iommu(bus)) {
+            int min_bus, max_bus;
+
+            pci_bus_range(bus, &min_bus, &max_bus);
+
+            AcpiRimtIdMapping idmap = {
+                .source_id_base = min_bus << 8,
+                .num_ids = (max_bus - min_bus + 1) << 8,
+            };
+            g_array_append_val(idmap_blob, idmap);
+        }
+    }
+
+    return 0;
+}
+
+static int rimt_idmap_compare(gconstpointer a, gconstpointer b)
+{
+    AcpiRimtIdMapping *idmap_a = (AcpiRimtIdMapping *)a;
+    AcpiRimtIdMapping *idmap_b = (AcpiRimtIdMapping *)b;
+
+    return idmap_a->source_id_base - idmap_b->source_id_base;
+}
+
+/*
+ * RISC-V IO Mapping Table (RIMT)
+ * https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v0.99/rimt-spec.pdf
+ */
+static void build_rimt(GArray *table_data, BIOSLinker *linker,
+                       RISCVVirtState *s)
+{
+    int i, nb_nodes, rc_mapping_count;
+    size_t node_size, iommu_offset = 0;
+    uint32_t id = 0;
+    g_autoptr(GArray) iommu_idmaps = g_array_new(false, true,
+                                                 sizeof(AcpiRimtIdMapping));
+
+    AcpiTable table = { .sig = "RIMT", .rev = 1, .oem_id = s->oem_id,
+                        .oem_table_id = s->oem_table_id };
+
+    acpi_table_begin(&table, table_data);
+
+    object_child_foreach_recursive(object_get_root(),
+                                   rimt_host_bridges, iommu_idmaps);
+
+    /* Sort the ID mapping  by Source ID Base*/
+    g_array_sort(iommu_idmaps, rimt_idmap_compare);
+
+    nb_nodes = 2; /* RC, IOMMU */
+    rc_mapping_count = iommu_idmaps->len;
+    /* Number of RIMT Nodes */
+    build_append_int_noprefix(table_data, nb_nodes, 4);
+
+    /* Offset to Array of RIMT Nodes */
+    build_append_int_noprefix(table_data, RIMT_NODE_OFFSET, 4);
+    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+
+    iommu_offset = table_data->len - table.table_offset;
+    /*  IOMMU Device Structure */
+    build_append_int_noprefix(table_data, 0, 1);         /* Type - IOMMU*/
+    build_append_int_noprefix(table_data, 1, 1);         /* Revision */
+    node_size =  IOMMU_ENTRY_SIZE;
+    build_append_int_noprefix(table_data, node_size, 2); /* Length */
+    build_append_int_noprefix(table_data, 0, 2);         /* Reserved */
+    build_append_int_noprefix(table_data, id++, 2);      /* ID */
+    if (virt_is_iommu_sys_enabled(s)) {
+        /* Hardware ID */
+        build_append_int_noprefix(table_data, 'R', 1);
+        build_append_int_noprefix(table_data, 'S', 1);
+        build_append_int_noprefix(table_data, 'C', 1);
+        build_append_int_noprefix(table_data, 'V', 1);
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '4', 1);
+        /* Base Address */
+        build_append_int_noprefix(table_data,
+                                  s->memmap[VIRT_IOMMU_SYS].base, 8);
+        build_append_int_noprefix(table_data, 0, 4);   /* Flags */
+    } else {
+        /* Hardware ID */
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '1', 1);
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '0', 1);
+        build_append_int_noprefix(table_data, '1', 1);
+        build_append_int_noprefix(table_data, '4', 1);
+
+        build_append_int_noprefix(table_data, 0, 8);   /* Base Address */
+        build_append_int_noprefix(table_data, 1, 4);   /* Flags */
+    }
+
+    build_append_int_noprefix(table_data, 0, 4);       /* Proximity Domain */
+    build_append_int_noprefix(table_data, 0, 2);       /* PCI Segment number */
+    /* PCIe B/D/F */
+    if (virt_is_iommu_sys_enabled(s)) {
+        build_append_int_noprefix(table_data, 0, 2);
+    } else {
+        build_append_int_noprefix(table_data, s->pci_iommu_bdf, 2);
+    }
+    /* Number of interrupt wires */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Interrupt wire array offset */
+    build_append_int_noprefix(table_data, RISCV_INTERRUPT_WIRE_OFFSSET, 2);
+
+    /*  PCIe Root Complex Node */
+    build_append_int_noprefix(table_data, 1, 1);           /* Type */
+    build_append_int_noprefix(table_data, 1, 1);           /* Revision */
+    node_size =  ROOT_COMPLEX_ENTRY_SIZE +
+                 ID_MAPPING_ENTRY_SIZE * rc_mapping_count;
+    build_append_int_noprefix(table_data, node_size, 2);   /* Length */
+    build_append_int_noprefix(table_data, 0, 2);           /* Reserved */
+    build_append_int_noprefix(table_data, id++, 2);        /* ID */
+    build_append_int_noprefix(table_data, 0, 4);           /* Flags */
+    build_append_int_noprefix(table_data, 0, 2);           /* Reserved */
+    /* PCI Segment number */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* ID mapping array offset */
+    build_append_int_noprefix(table_data, ROOT_COMPLEX_ENTRY_SIZE, 2);
+    /* Number of ID mappings */
+    build_append_int_noprefix(table_data, rc_mapping_count, 2);
+
+    /* Output Reference */
+    AcpiRimtIdMapping *range;
+
+    /* ID mapping array */
+    for (i = 0; i < iommu_idmaps->len; i++) {
+        range = &g_array_index(iommu_idmaps, AcpiRimtIdMapping, i);
+        if (virt_is_iommu_sys_enabled(s)) {
+            range->source_id_base = 0;
+        } else {
+            range->source_id_base = s->pci_iommu_bdf + 1;
+        }
+        range->num_ids = 0xffff - s->pci_iommu_bdf;
+        build_rimt_id_mapping(table_data, range->source_id_base,
+                              range->num_ids, iommu_offset);
+    }
+
+    acpi_table_end(linker, &table);
+}
+
 /*
  * ACPI spec, Revision 6.5+
  * 5.2.16 System Resource Affinity Table (SRAT)
@@ -679,6 +889,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_rhct(tables_blob, tables->linker, s);
 
+    if (virt_is_iommu_sys_enabled(s) || s->pci_iommu_bdf) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_rimt(tables_blob, tables->linker, s);
+    }
+
     acpi_add_table(table_offsets, tables_blob);
     spcr_setup(tables_blob, tables->linker, s);
 
-- 
2.49.0


