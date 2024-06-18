Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D945AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbH9-0003gW-AL; Tue, 18 Jun 2024 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbGl-0003Xo-IF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:16 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbGj-0006ky-LG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:15 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec17eb4493so67108991fa.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726471; x=1719331271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92DFCEMVHNRfMYC9GC2mgRPUeb4rRwPGc14j39ovrXg=;
 b=YEES+ZGEnUhfS7r4WKly+AKEBdTU/ouHBJTPwpTcRh1KIIj9vPqUMxNd6zftkZinIY
 TPw7hCK0pkhARFfvh5Q6eiOjs7MDWplJxBi1FdLCFW/YlZktkNtsf806GvrbsABA0Pmj
 hfJidImjNnGx9URRH0x2Zn3mURMAwIdBiZjviEnICnOJngB4UUeOcLHzXav5EpnbUCz5
 YPxXDbFnJPe+/fbt2R53gC+CbwaIbgvk5PVNNghqZQzuwzgcb3N8yQk091uetDnm1xmk
 U3pw4w3LXL4LrhHJUVCSEjv3fbMKiiqnvd9BGQXsbT86kJ8HEKR4KsBS5cFWvkBOkDjv
 Os8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726471; x=1719331271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92DFCEMVHNRfMYC9GC2mgRPUeb4rRwPGc14j39ovrXg=;
 b=OckGSfghptHzraDTu4JPeZ4FOsyKXwGeEt8cwsfwickScO8GSuHLAso3ETJwyLfAPI
 ryX+fPZVI2vSpsyESIWeEoNtY3bePHQE3iGSqvQ3IhUJ7NNyPcbn4yr8rjYUmf7DJ+gu
 UaRAsBL5hYRqKBtqa7Xz6xM8X0r/j7bOUda/6otL5ZYkbxC8KE+9bCupX5MIlwtDzjJ9
 yP6GnylSOtvsNTRtcTxGgaqxBMLmYayDw08StBT7fb9kOetzr/MrAxqPi3/QwGxlqxhP
 296mvETyDeQsXq05AI3MhyT+8OXw0ACBpC3+MlDo9AKequr4ZgANYjIRQj9pOu/j7OVg
 l/yA==
X-Gm-Message-State: AOJu0YyWltwGCqkR4sU/lZe6Bt3u+VioIynfzO1lmcIMyywSETWWovdQ
 TWe67ValpyQLxgFphbRcudB1sE4QlUdPh6zXPQwr++Dih3pPXcy0cgsE0Os6iSxgsMtoE/wxdWZ
 1
X-Google-Smtp-Source: AGHT+IFaDq/V3ZfsFMLQUkcee5SNiH+sO7tnXRtXTf6EsUv9RLX3xMWkIzrn/+6xGVi+BpjGxhmJig==
X-Received: by 2002:a05:6512:329c:b0:52c:ba7d:f032 with SMTP id
 2adb3069b0e04-52ccaa32987mr43817e87.16.1718726471046; 
 Tue, 18 Jun 2024 09:01:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db674esm626117466b.83.2024.06.18.09.01.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 05/76] hw/i386/acpi: Remove
 PCMachineClass::legacy_acpi_table_size
Date: Tue, 18 Jun 2024 17:59:27 +0200
Message-ID: <20240618160039.36108-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PCMachineClass::legacy_acpi_table_size was only used by the
pc-i440fx-2.0 machine, which got removed. Remove it and simplify
acpi_build().

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240617071118.60464-6-philmd@linaro.org>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/acpi-build.c | 63 +++++++++-----------------------------------
 2 files changed, 12 insertions(+), 52 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3e606949fb..434e531160 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -103,7 +103,6 @@ struct PCMachineClass {
     /* ACPI compat: */
     bool has_acpi_build;
     bool rsdp_in_ram;
-    int legacy_acpi_table_size;
     unsigned acpi_data_size;
     int pci_root_uid;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53f804ac16..f5d74e2b4b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -85,7 +85,6 @@
  * a little bit, there should be plenty of free space since the DSDT
  * shrunk by ~1.5k between QEMU 2.0 and QEMU 2.1.
  */
-#define ACPI_BUILD_LEGACY_CPU_AML_SIZE    97
 #define ACPI_BUILD_ALIGN_SIZE             0x1000
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -2499,13 +2498,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     X86MachineState *x86ms = X86_MACHINE(machine);
     DeviceState *iommu = pcms->iommu;
     GArray *table_offsets;
-    unsigned facs, dsdt, rsdt, fadt;
+    unsigned facs, dsdt, rsdt;
     AcpiPmInfo pm;
     AcpiMiscInfo misc;
     AcpiMcfgInfo mcfg;
     Range pci_hole = {}, pci_hole64 = {};
     uint8_t *u;
-    size_t aml_len = 0;
     GArray *tables_blob = tables->table_data;
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
     Object *vmgenid_dev;
@@ -2551,19 +2549,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     build_dsdt(tables_blob, tables->linker, &pm, &misc,
                &pci_hole, &pci_hole64, machine);
 
-    /* Count the size of the DSDT and SSDT, we will need it for legacy
-     * sizing of ACPI tables.
-     */
-    aml_len += tables_blob->len - dsdt;
-
     /* ACPI tables pointed to by RSDT */
-    fadt = tables_blob->len;
     acpi_add_table(table_offsets, tables_blob);
     pm.fadt.facs_tbl_offset = &facs;
     pm.fadt.dsdt_tbl_offset = &dsdt;
     pm.fadt.xdsdt_tbl_offset = &dsdt;
     build_fadt(tables_blob, tables->linker, &pm.fadt, oem_id, oem_table_id);
-    aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, x86ms,
@@ -2694,49 +2685,19 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * too simple to be enough.  4k turned out to be too small an
      * alignment very soon, and in fact it is almost impossible to
      * keep the table size stable for all (max_cpus, max_memory_slots)
-     * combinations.  So the table size is always 64k for pc-i440fx-2.1
-     * and we give an error if the table grows beyond that limit.
-     *
-     * We still have the problem of migrating from "-M pc-i440fx-2.0".  For
-     * that, we exploit the fact that QEMU 2.1 generates _smaller_ tables
-     * than 2.0 and we can always pad the smaller tables with zeros.  We can
-     * then use the exact size of the 2.0 tables.
-     *
-     * All this is for PIIX4, since QEMU 2.0 didn't support Q35 migration.
+     * combinations.
      */
-    if (pcmc->legacy_acpi_table_size) {
-        /* Subtracting aml_len gives the size of fixed tables.  Then add the
-         * size of the PIIX4 DSDT/SSDT in QEMU 2.0.
-         */
-        int legacy_aml_len =
-            pcmc->legacy_acpi_table_size +
-            ACPI_BUILD_LEGACY_CPU_AML_SIZE * x86ms->apic_id_limit;
-        int legacy_table_size =
-            ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
-                     ACPI_BUILD_ALIGN_SIZE);
-        if ((tables_blob->len > legacy_table_size) &&
-            !pcmc->resizable_acpi_blob) {
-            /* Should happen only with PCI bridges and -M pc-i440fx-2.0.  */
-            warn_report("ACPI table size %u exceeds %d bytes,"
-                        " migration may not work",
-                        tables_blob->len, legacy_table_size);
-            error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.\n");
-        }
-        g_array_set_size(tables_blob, legacy_table_size);
-    } else {
-        /* Make sure we have a buffer in case we need to resize the tables. */
-        if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
-            !pcmc->resizable_acpi_blob) {
-            /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-            warn_report("ACPI table size %u exceeds %d bytes,"
-                        " migration may not work",
-                        tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
-            error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.\n");
-        }
-        acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
+    /* Make sure we have a buffer in case we need to resize the tables. */
+    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
+        !pcmc->resizable_acpi_blob) {
+        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
+        warn_report("ACPI table size %u exceeds %d bytes,"
+                    " migration may not work",
+                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
+        error_printf("Try removing CPUs, NUMA nodes, memory slots"
+                     " or PCI bridges.\n");
     }
+    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
 
-- 
2.41.0


