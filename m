Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13323C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2OlF-0000vz-JF; Thu, 02 May 2024 01:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s2Oko-0000m0-0j; Thu, 02 May 2024 01:13:11 -0400
Received: from mail-bjschn02on2070a.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::70a]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s2Okm-0005U9-3X; Thu, 02 May 2024 01:13:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFQm/Tlrlc/VZMnfcZuUdGoLKT4Ns7L3fpQA4BKwRNl5AZrEG+1xSbu340pWMg/eK0L8R/hYLkvKzW+D2yJRzmFz8NPMljSG6LDFIYYTuGJsI+eFIAOfXzO9gBH4rrC2F/myj1X0x2yJSNSaczx00yQhgJPkONXaaEvPFNCDJUMwMmlHNMnbV6ilPeuzopRS7fMBPb7U+zdgqOwq5sfOMmubWqJkRJR0xmHzpndOnnD8M5Coj7/QcDcfY+8SC2JN2ggU3Srob/rpgNDo4FXolOwY5Ia8WAMj4KYxft+hGf5ka+++VVVgJF/GIOzz3HwafwmjlSYk8aFvlpLMdJiv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjaKTnKHpMrtN+U8R/RWEPVJl/v8Zgl5EuDYGGTZTkA=;
 b=U4IHc1BH8Ur4uLl1JG6/m4ebb5vnCZeF74auibXvYBxjVI+r7f/S38tShMtj2WeqA7VKkFAv2EWQqw1k8k8S+bqf0kCtwxzJ0lDekmDfhzumkFzu7rDJdEncuYBHNqJBh3TFsXEy9W40wD3X+iIwXXcfQezuPThCl6Z8RrpEmrrHjPs2a0lZxiB1mCkppcWN70hVzP0iJ8yZJWNk53dQeasaYevxempERzPEQ4B2kKYQVihA3/6xSJeuDg7TYZbNBAedx3M0+WvS2DvOUGrtolgxYC5+JuHAFrPcAzQi99Nk2SNhBXiWITqUzUIjpS+KMXgrzn7Eb/BPFOeY5ilIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0973.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Thu, 2 May
 2024 05:12:58 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 05:12:58 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v1 2/2] hw/acpi: Upgrade ACPI SPCR table to support SPCR table
 version 4 format
Date: Wed,  1 May 2024 22:12:33 -0700
Message-Id: <20240502051233.50749-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
References: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0051.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::18) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: df62c320-8a2d-46c7-9767-08dc6a668821
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/ruCM3suRXKgsLeBTR7NyoEKFVIQHWjRj1Xpt6wfJ+pIlS7MjpptJoHgHhzgPdTEVPvPoqD54mcnbkRFmC/4TDnTBhyU5oSM/xMknscqirBdmHHb0sT9BC1u6otjBfbXM95ajs1xz/Y3BtE0us/iRu74Ikg96Kcvd/2773bXzl17d5dDd8e2UhP5Pc+M12BlVN2hVbwP6uw+jqvLE71TwWnq9dmDGhXKjTWMQT8y36eIRr8z4FmXLD7QL4xNwsWKoR5isdaM2TLQzEhAVLNwLA5/H2L5Fu3fT9yTwSzAYCew35cc+6wlXdPKOhB9dX+VB0BMATpHE+i/TiGd+2yUC831s1PLC9VETrtmry47rh62XAIU7wmYZOPkGNG+ab+9FP7f98zLqv5HU32Ssv5MJmQ5o4EiA6UQ4erMmxT8snGjArWD+omHa7pSeGsHjpqjJUW9auZmKBhn/ltbLbSxvwPhycKHaVZEBq7Jxp7wUyM/rYXHcsN++KlFxGuu+nEO72KQOnohCqtf+Q6h88U4RQBRNWgRDDH1s0ueRS0L2LDz3ioHmts44NIQzSms3+pHUMj/Rip5bJSODNkUApTJNIpWXofkF7rkwRVHQuz9sGXaDDST+q+/Cg7c8fKhCeg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(7416005)(41320700004)(366007)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZcpJuVcWmXseYGbaVKFD+KG4BymYPKn+0hZJ1jGns+sS+/J/So/+oaSwL/J?=
 =?us-ascii?Q?NsruAJuZnBQr9uiynRICLfGnO4mHIYswcbYB1E2L0xwVQhhWgc2jkiQwVv+E?=
 =?us-ascii?Q?254MnfcsiFhXhePIOy+mHZ6BZ+eaPKBIcv86WCFQ/liQvasmfqK1NPPuiMkt?=
 =?us-ascii?Q?bhkv/YwM8wKiOelI/3zbNeMjl63CJCziEXnOXyKmBbo8vbj+RU8pfPGb66cB?=
 =?us-ascii?Q?hRXTRG+TRmH4La3en1UbniSjeG4PRwf6foBT3n8h7QmBFuHVl5g0kPtY9Xpf?=
 =?us-ascii?Q?t7syGdkVTVp4Z7XwivuBj9pg8b4IYJeTMEhtle9gWQLjTctEKfEm6q1CJKR4?=
 =?us-ascii?Q?2mzX56AcUSRQGxlcsLT/Lx33QbaKqiQfyWSMOhoZP33Ae28eAadnGesq8PRh?=
 =?us-ascii?Q?Jrf/xMiOdlCDdeBxNTTm9UuN9dF51/DR4Dpe4dGur0aNA6Sf4Jge/w6P4kxL?=
 =?us-ascii?Q?oUb6zVfzY5JS8Jjbl7hvwPNZknLkqNtA4sC6gANfPCHXBYW9s+3b8Kwm3FCK?=
 =?us-ascii?Q?UcPKr6kPO+CsyQf3mDeyltcYnawlShrV3NNLST31Di63OMS037swY5nGJEjj?=
 =?us-ascii?Q?otbUmyrBlbaIyQ4KXfm6ja6BDiucROD+aCU3lfk8j81B/Tfxp+1DVtL4sCFD?=
 =?us-ascii?Q?l6c29I2N6H1+cBV2M5EC3ELYYveD8+6/Wst22H2dY6RyPG2oACroVt/a2MGu?=
 =?us-ascii?Q?570Bf95ZnE2fIQi+gBhrbI90Pg6MQHHOyTLBUfnUnNhSn8yNtn8/NlnrRiI5?=
 =?us-ascii?Q?gWdzUK+1niqhF/0nfcCIUPCdcshS4MgM+Cp82GAAXI/hQs+lnXl3bTeRuqL6?=
 =?us-ascii?Q?F16ARtKNJ/RZS+/b2jiehch2C5VBTT1SqKfqDvfxC47v8BzQC0dLvpk4TRjV?=
 =?us-ascii?Q?eSoTY5UJf4LG/MHaNx9h19xpiqeGjHSsTZBGJsdcY32kHR/49FFSuEmzr3Lc?=
 =?us-ascii?Q?x6Tj5qO2PpxnpXhdJPZ3jifMo5tfWi8TjgaIw9quVS/k+veH8eqJLnJqA2Y/?=
 =?us-ascii?Q?VBE6XE++wwZzqNGpWo3Sdnylo+TJx0Hf/FYCogcYa18uvILg1mh3ZDXRnC61?=
 =?us-ascii?Q?liBy6VZ5B3vywlr+hx/ebmMhtb7S6NS/NHaOyUNafmiKD3obq1yc/WUQSf4y?=
 =?us-ascii?Q?kHsirpUK1mbKjm9mB7OZE9RSDXdfGSuIPUHEeGIkYpE0LOg9P9Tfp35V+lus?=
 =?us-ascii?Q?1lY10FyHQ4Y3m+DgFfoc86L5PUQfx0rQnQ9+VFIVZqWehCCl8QlOiVYXVFZW?=
 =?us-ascii?Q?1pPsUjIY8vL/w93kAc/zi5WUYZz2C6VnMkgQGi5CMClsTWw5WGYuI0kIWOgV?=
 =?us-ascii?Q?ahEe4E0L1cZ8G+Dnt/BZHHHuKWp2aCWMVHdUJOr5y/b9eScohEKcCJ+6JlTR?=
 =?us-ascii?Q?fbWm+9sMSX8DIPJao6areZejc8gN6u4iQvVKKYATr4xHFrIG1mawyIiKPTal?=
 =?us-ascii?Q?r0Ah6eJQ9PmouamBSBngBYUl4NxukUHcnXciEYRJ71MBeeXp1KncwTW16LNK?=
 =?us-ascii?Q?/pIgV3RWooaMKW1LyOT2ORRXXXYWgVu9EecbIgRg/ShTUDlKEEj9J93KxO6L?=
 =?us-ascii?Q?RaRuwNMq5eKUAMqZ/5cRNwEAB4+BUK2HBGpxqgnX/bKl+KJeY5SVxK+/D/BF?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df62c320-8a2d-46c7-9767-08dc6a668821
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:12:58.4556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upNA0P/+MavvV7JEnN3dqRFvItqpykP0bvJfH2aFb1GmImUgUGT2FBls2mZznVNvq2WvNoeKiV1JzkwPjofFymltAORtA2a78T5IbTJ+ybM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0973
Received-SPF: pass client-ip=2406:e500:4440:2::70a;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Update the SPCR table to accommodate the SPCR Table version 4 [1].
The SPCR table has been modified to adhere to the version 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/acpi/aml-build.c         | 14 +++++++++++---
 hw/arm/virt-acpi-build.c    | 10 ++++++++--
 hw/riscv/virt-acpi-build.c  | 10 ++++++++--
 include/hw/acpi/acpi-defs.h |  7 +++++--
 include/hw/acpi/aml-build.h |  2 +-
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..7c43573eef 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1996,7 +1996,7 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
 
 void build_spcr(GArray *table_data, BIOSLinker *linker,
                 const AcpiSpcrData *f, const uint8_t rev,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id, const char *name)
 {
     AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -2042,8 +2042,16 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->pci_flags, 4);
     /* PCI Segment */
     build_append_int_noprefix(table_data, f->pci_segment, 1);
-    /* Reserved */
-    build_append_int_noprefix(table_data, 0, 4);
+    /* UartClkFreq */
+    build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
+    /* PreciseBaudrate */
+    build_append_int_noprefix(table_data, f->precise_baudrate, 4);
+    /* NameSpaceStringLength */
+    build_append_int_noprefix(table_data, f->namespace_string_length, 2);
+    /* NameSpaceStringOffset */
+    build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
+    /* NamespaceString[] */
+    g_array_append_vals(table_data, name, f->namespace_string_length);
 
     acpi_table_end(linker, &table);
 }
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3ccfef026..fc7b0176ed 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -429,11 +429,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
 /*
  * Serial Port Console Redirection Table (SPCR)
- * Rev: 1.07
+ * Rev: 1.10
  */
 static void
 spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
+    const char name[] = ".";
     AcpiSpcrData serial = {
         .interface_type = 3,       /* ARM PL011 UART */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
@@ -457,9 +458,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         .pci_function = 0,
         .pci_flags = 0,
         .pci_segment = 0,
+        .uart_clk_freq = 0,
+        .precise_baudrate = 0,
+        .namespace_string_length = sizeof(name),
+        .namespace_string_offset = 88,
     };
 
-    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
+    build_spcr(table_data, linker, &serial, 4, vms->oem_id, vms->oem_table_id,
+               name);
 }
 
 /*
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160..5712211847 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -176,12 +176,13 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
 
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
         .interface_type = 0,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
@@ -205,9 +206,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
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
index a3784155cb..68c0f2dbee 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -500,5 +500,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 
 void build_spcr(GArray *table_data, BIOSLinker *linker,
                 const AcpiSpcrData *f, const uint8_t rev,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id, const char *name);
 #endif
-- 
2.34.1


