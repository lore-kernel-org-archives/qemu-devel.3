Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA443E7718C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2a6-0003tn-Pb; Wed, 18 Dec 2024 17:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zf-0003TP-Un
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zd-0003IQ-KI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:23 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2167141dfa1so1640445ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561079; x=1735165879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXiMs7faKyZmCOi20Vpzvry683l81D2FYIjjSmSNVsA=;
 b=l64AmjlP8781V9FEXxjXh/iD4rf9i0w5+0PYfhon9vWqqrhDJ6n3xSI8ziPURknpJE
 oQYeXJg15PFjmgLgF9YJStkhFz4bQ82cBzlima1ygAluyMzO7u5Nv/pKgs+YXzPcqgh6
 FwJHqx4FEVsBSsq5OIHaX5Ja+OSOyWDGYISZwbWeRejJwbfTfCr7RsRvxeniVDyk9+Tq
 2PTG7slZA8ueIBbc1leNd7TT41SC/vFzA8N91FfNl1Wal3ID6ooXU6XSG6y0hliv97XF
 iDHKlkEQoFZJPmof1RtPn9G8z35WrMNYlv7FRY0GP92jCdXHkxepRMZVMS4H3yiijXHq
 zhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561079; x=1735165879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXiMs7faKyZmCOi20Vpzvry683l81D2FYIjjSmSNVsA=;
 b=VI23wghOaia0A8aWqEwy1hO0ll0w5kmqsXwlyz4bBro3nk3F4zTDVyit9XtlLWl7PH
 e3RoOEKr2BOf2+IBdsRQzU0vq6EzgVpFM03rRWuJEfAXAFK3sSBkFSEt1/hUUB6N0R+J
 mIbqXjs75Qd7OecCArExoTVTuZVGRldnt7FF90No7EqHDtFiwTy0WuwIb27mGQHtCVWc
 XnGQeCe+AoZTAG+njwBp/HuKODVZuM2tGIfBlKddCxfi7M+DuHy+T3vzHNPgFKMMd93f
 Fr/6NtuZEN/Bfe1vlfZ1zCw04s2oNaEhKiDZr660JfqxTm23pLc6/fak21LPedF+w8ly
 cJJw==
X-Gm-Message-State: AOJu0YwpcvUyRH9Ji+nZoUdIoN4jOFfb4+LyTorcKZUbjnMrzHny5Unj
 qAeYkVJ4umA3hf975D6ivALD9cm3Bo9mf3q61wnXKOYnideNiIPqvGb1/tst
X-Gm-Gg: ASbGnctvKv60AZS1/DKGc8/wQHd8dYSS/cFVwFkASUw9XwSAJW4/x2l0FcwZ8vEw4zY
 cMM07Sg4CTwdzufibdlJk1RqvgQktwPTV3UvTsfHSdYIQlrjSU3bwNq6dPRtIJk44myewSIRIW+
 japLXYW7BLqDFENg8LdiSRszVyJacR0RpuMmm56WFUkT8U0yXgTc4KFFMvPHszLbUClShOxZ320
 ul70DIZQtvvM6d7p3PiDjC1vtJRzr4elVqakjm97h1nDsANRb1EKqQ1uBHO59DyaX8stBxWm5Zb
 NeIuzAjnx388Ju79nBRsJIsR7A5KPeK0VfRQyLPFqpkIWmo9Cvt71i5UD709vEs=
X-Google-Smtp-Source: AGHT+IFsn8UxnKodlKaXrl0VvgfgsVuHwglpbPxX6poZZeRLc4Ox3hYz8S+azjmo9QyqE9foK7a7bw==
X-Received: by 2002:a17:902:da81:b0:216:59f1:c7d9 with SMTP id
 d9443c01a7336-219da6eabaemr12761605ad.19.1734561079359; 
 Wed, 18 Dec 2024 14:31:19 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 21/39] hw/acpi: Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Date: Thu, 19 Dec 2024 08:29:51 +1000
Message-ID: <20241218223010.1931245-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Update the SPCR table to accommodate the SPCR Table revision 4 [1].
The SPCR table has been modified to adhere to the revision 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20241028015744.624943-3-jeeheng.sia@starfivetech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/acpi/acpi-defs.h |  7 +++++--
 include/hw/acpi/aml-build.h |  2 +-
 hw/acpi/aml-build.c         | 20 ++++++++++++++++----
 hw/arm/virt-acpi-build.c    |  8 ++++++--
 hw/loongarch/acpi-build.c   |  6 +++++-
 hw/riscv/virt-acpi-build.c  | 12 +++++++++---
 6 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 0e6e82b339..2e6e341998 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -112,7 +112,6 @@ typedef struct AcpiSpcrData {
     uint8_t flow_control;
     uint8_t terminal_type;
     uint8_t language;
-    uint8_t reserved1;
     uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
     uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
     uint8_t pci_bus;
@@ -120,7 +119,11 @@ typedef struct AcpiSpcrData {
     uint8_t pci_function;
     uint32_t pci_flags;
     uint8_t pci_segment;
-    uint32_t reserved2;
+    uint32_t uart_clk_freq;
+    uint32_t precise_baudrate;
+    uint32_t namespace_string_length;
+    uint32_t namespace_string_offset;
+    char namespace_string[];
 } AcpiSpcrData;
 
 #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 4fd5da49e7..c18f681342 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -507,5 +507,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 
 void build_spcr(GArray *table_data, BIOSLinker *linker,
                 const AcpiSpcrData *f, const uint8_t rev,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id, const char *name);
 #endif
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 72282b173e..e4d58d7051 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2078,7 +2078,7 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
 
 void build_spcr(GArray *table_data, BIOSLinker *linker,
                 const AcpiSpcrData *f, const uint8_t rev,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id, const char *name)
 {
     AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -2124,9 +2124,21 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->pci_flags, 4);
     /* PCI Segment */
     build_append_int_noprefix(table_data, f->pci_segment, 1);
-    /* Reserved */
-    build_append_int_noprefix(table_data, 0, 4);
-
+    if (rev < 4) {
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 4);
+    } else {
+        /* UartClkFreq */
+        build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
+        /* PreciseBaudrate */
+        build_append_int_noprefix(table_data, f->precise_baudrate, 4);
+        /* NameSpaceStringLength */
+        build_append_int_noprefix(table_data, f->namespace_string_length, 2);
+        /* NameSpaceStringOffset */
+        build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
+        /* NamespaceString[] */
+        g_array_append_vals(table_data, name, f->namespace_string_length);
+    }
     acpi_table_end(linker, &table);
 }
 /*
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 620992c92c..e92d3bddc8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -463,8 +463,12 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         .pci_flags = 0,
         .pci_segment = 0,
     };
-
-    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
+    /*
+     * Passing NULL as the SPCR Table for Revision 2 doesn't support
+     * NameSpaceString.
+     */
+    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id,
+               NULL);
 }
 
 /*
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 50709bda0f..4e04f7b6c1 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -276,8 +276,12 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     };
 
     lvms = LOONGARCH_VIRT_MACHINE(machine);
+    /*
+     * Passing NULL as the SPCR Table for Revision 2 doesn't support
+     * NameSpaceString.
+     */
     build_spcr(table_data, linker, &serial, 2, lvms->oem_id,
-               lvms->oem_table_id);
+               lvms->oem_table_id, NULL);
 }
 
 typedef
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 36d6a3a412..68ef15acac 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -200,14 +200,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
 
 /*
  * Serial Port Console Redirection Table (SPCR)
- * Rev: 1.07
+ * Rev: 1.10
  */
 
 static void
 spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
 {
+    const char name[] = ".";
     AcpiSpcrData serial = {
-        .interface_type = 0,       /* 16550 compatible */
+        .interface_type = 0x12,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
         .base_addr.width = 32,
         .base_addr.offset = 0,
@@ -229,9 +230,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
         .pci_function = 0,
         .pci_flags = 0,
         .pci_segment = 0,
+        .uart_clk_freq = 0,
+        .precise_baudrate = 0,
+        .namespace_string_length = sizeof(name),
+        .namespace_string_offset = 88,
     };
 
-    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_id);
+    build_spcr(table_data, linker, &serial, 4, s->oem_id, s->oem_table_id,
+               name);
 }
 
 /* RHCT Node[N] starts at offset 56 */
-- 
2.47.1


