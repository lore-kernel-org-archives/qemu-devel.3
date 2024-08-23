Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D601C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 11:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shS5Y-0001mo-6M; Fri, 23 Aug 2024 07:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shS5V-0001f1-UA; Fri, 23 Aug 2024 07:04:13 -0400
Received: from mail-sh0chn02on20726.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::726]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shS5U-0003L3-1f; Fri, 23 Aug 2024 07:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fStQIaJuQxwUJu+FAobu6ftQCjsYKRREq5p1lz33KUL8NCKcRmWNjRbzdBL3yB9oRB/sEdWL/B68SW5hTHMZ+F3k6ThtmoHKH1AKjQymIX+P+UkGgTYehtJk594gcrupV76R8ApIg8JdBpFle6K/4Ry5OuAT5zpJFnVQHzmeVkKB0JS45R/Q/omEuRo/00cSPYfQEVI2W9b9duGmfI5j3aI2A0TwUQ07KrDddFPW+UyesRfcmLdxxlv/wEB8ih5ojNoPV48Bun8bXObSndDc3gPk6q0OseJEriLZku08VSIofuzlS8zscnDk7y9l5PtN+7VUqwn7xo38SIkFs0bDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhLS90av1iSS0tvtS4Qk4EXpxNTCqeCFCkRKwh5pL2I=;
 b=M/IBKqsvFuN8ZcMqkirBZQFOipoK/v0nuuVyhCh4p/bhJWbx0+UNJE/PJDXUpOuWdSq/0HltjPEdvaBE10hVS0J32Elq0H3lpGyGK11dGdgUb+b0Qnh6722AFbr8VGvPB6mBCHWLnfZzh9Gb2C7Uqg/3I1FYB82nkEPvIBMLgF24HpHlHnS0GFB4r3ii0KYHFkUU0IiZcr506ABIiCqqXINyz/cEBMpyG4Z+4sNABCa5QjcWyVu+7nXqBFiiHERIsgckpUL1tBWCQ7AgLucu7l7fkvZA8d5oDGjepYa8uTmQ1eHfoO54l7OnaXMlTJlsKY3USGDP3LTPYe2fqu5c3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1327.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 11:03:32 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.014; Fri, 23 Aug 2024 11:03:32 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v4 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Date: Fri, 23 Aug 2024 04:03:00 -0700
Message-Id: <20240823110301.161588-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823110301.161588-1-jeeheng.sia@starfivetech.com>
References: <20240823110301.161588-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::33) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1327:EE_
X-MS-Office365-Filtering-Correlation-Id: 700d705f-e02e-4652-3e3b-08dcc36339fa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: uoUCLpGX0grGmxq3hIqqtqjRnkoMjOLARQDv9qizBRoKVrT9QOeo2SCbwo5eH2xFEonYpD5NOUpcsTvKIRu+KR4Pm0ATJwwUlPMM53rx4CGJf2sHyzot1Kb9h9smTiIR6YNMeyJCP7l9/lfv2sqqoQA+L8+2+0jK8XLe99cN8Wx+L9ioSaSSdLnDPxtDW4tJC20C8Fibiv84WVNWGn4g+Ilyt5Xf81FPUfCI/zFgj3zhsENQdcBzBBRYcmAzXYaWATVjhkkW413jSY+liQ03FgqfcLKh2/RcTBB1egwvRg9kjesPFCSictbxPzWDQxBmVtidPZvXpcUReeKAyyqCjBgkN5vcYMB684vNGVt19m68CpHvE/7NQqSQkNfm+2ilWtyN3fIvg4jIRAFnBvkRGIIVs4RE7zWXxZ3pKfg4jQu7Ua30eJmEIf0rt2Od0GCnyx5AHviMS2Qs2+SONV/onJJ+3JMuKEp69OCOHaWmCaqNgKo7pMVfIySZeoiK/eHr8N0iSmkUVOCkY38Vlc9RFBktGlzZNqT1TNoeq58Aqo1kiXFfScptLaPzyzhEWF8tnLtn1OmUz+wjMyAbkkMizrgrJfbEECv0hYBq3EsabEytOnTpsdFtxIQsYJ7js0eF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXNIpm+xZVJRRyFiuJE/KGUHF93zKb2FNlwFxAjnG15CO7G1mBvuDCUwCgRZ?=
 =?us-ascii?Q?ceT/rbyS9ngajfZLrLJsXbxOLiXYM7t3pWinX6Pag88CgBUsUF3QPCPHFPhb?=
 =?us-ascii?Q?0x2QTjdGGi2jRQhkppICm9tZUbZ5hxfHTcPJFMO0g9SsETnhrK0nj/An4l9H?=
 =?us-ascii?Q?mUK6R826qPL069vwKNd7XZ+9nMILk2EURFqPhOOckEq5wj6gS/1V0wql7KtD?=
 =?us-ascii?Q?TlHuqkkwA938DN32AybSqN0BDkYz+nc6N6swzkHu7/u9fNaLtpIsc74VuNwx?=
 =?us-ascii?Q?3us9LHof6cYLVW5SKuAhebt4WuUMXy3AnJs7rsugdAjlaqtS3jjH4Chtt/DX?=
 =?us-ascii?Q?beaFwbHJsnpRftOQGetmgp4zJFw2R9IOcN8JXyNl26hUi1pyiL5DM92yPWz0?=
 =?us-ascii?Q?y5eUbqMbDQ2dzayiMpA373ah64IPdvu3V/EnOo8NklJ2DieCjgxXWAXHQFwY?=
 =?us-ascii?Q?ywSoH066urpJdhpVqjaLm5OO4A7r36/sVehuJ6udOfV84oVR4X3K9XczK6L7?=
 =?us-ascii?Q?s750SCYr1HwLsAkGNr69YdphjSPYCk3z23sUu6WoQ6qfGSbuLbXdtRVV9Uu6?=
 =?us-ascii?Q?bfWViqp7dB8cWEq3hY6yxsf7xDaHgn0wCZdITdW9IQGgUJcqFpyVC4MGvSgN?=
 =?us-ascii?Q?zThUiQBVRpJr/0ToU1CmysSMxO9h0GiFyH7z//e8KYlW4cNdiYQ/wx9WtAeV?=
 =?us-ascii?Q?KFaAjIYGfH2s9w44lLVXBHP5bIoqrzZYXj6RC+4wylCzB2/pFrV813GoQbRu?=
 =?us-ascii?Q?xGZRb3YBwOStXjqR0VxCGhloZ38Wv+4rtbQDLXDgyUZzy8Lembpyc09pW8Io?=
 =?us-ascii?Q?aE5QEMkjiZogcxyX2F4lrV9XiFVNjygdPY1tEXxUrDSI6DeocnHJ4grseUIr?=
 =?us-ascii?Q?PP4faLZTb79+u2jUFZSdjFw1O4IaFzfJNBhKHUhzbz0/3Nvw+hF/EFwngMUz?=
 =?us-ascii?Q?BtnrFcC9AUOA2MJo/HS3xHTOwqYc8mvjiRnNO24zIkoMdMLiNKElU9hjP6f2?=
 =?us-ascii?Q?Xsofmq86LEzrmz93nKjIyInlUrhXlEHYK0q9yfe9Iy8l+cMCqvkyfXQMNC25?=
 =?us-ascii?Q?YFJ75uZ+tvPcNE4x2i2gdPc46m9QINuWnryeV7xD4aFB55szTAdTYT3TzeEd?=
 =?us-ascii?Q?+0w5iC69BUquPIIVIZ9gsIHp/P4rEdK2kJYDphHZc60JTvcm+JvDOKqOoXuY?=
 =?us-ascii?Q?8Ju7ykXY2dkHyug0neJfeySgTz9bpERGj1PTJMh2F4CpXIILEOKGENbl9YuS?=
 =?us-ascii?Q?Bv0A4IdYMk5DTWqvWEOeKg4+FraXWEIeEX13JqrXd7QPP6NwtdEz4UaUO0OZ?=
 =?us-ascii?Q?f3aoRMZWMkA9oAKDPv4XjRyl4qRYeJE8TH3AniZtnoqg+5lLYrRtChEQBkaN?=
 =?us-ascii?Q?wKEsQwztBa4h0lykFl06UHuUx2ns4ctQM5QezQNgttA6RtFQ3PimHhYJplc9?=
 =?us-ascii?Q?hJ7cuWpDUpN6yoBrIjge396tJ3KGXLBBTesAp0MZ6UI+F3jLvG84oLC0NWPX?=
 =?us-ascii?Q?D8OYNjr6VrnMopRgqtNNNeE86ZTZDw7pauOzt8DoQke1M0KoPH9jramv9dxj?=
 =?us-ascii?Q?Cw7mRCHyQWU+9UZ7oKXY5QZY4S67BAcL77BmrHTnYDamEV1+2xxe1AJUbcGz?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700d705f-e02e-4652-3e3b-08dcc36339fa
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:03:32.3202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZgfEEtAFu7kKNKT7NteOhfqSc/M52Sg3k3TDt4U493USlO1N4oCtvQXwd10H3N2YTt0QddqrSkJoC8+l4UyDuHuiwRzpdwcanQwim2UmxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1327
Received-SPF: pass client-ip=2406:e500:4420:2::726;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Update the SPCR table to accommodate the SPCR Table revision 4 [1].
The SPCR table has been modified to adhere to the revision 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/acpi/aml-build.c         | 20 ++++++++++++++++----
 hw/arm/virt-acpi-build.c    | 10 +++++++---
 hw/riscv/virt-acpi-build.c  | 12 +++++++++---
 include/hw/acpi/acpi-defs.h |  7 +++++--
 include/hw/acpi/aml-build.h |  2 +-
 5 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..ad0a306db1 100644
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
@@ -2042,9 +2042,21 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
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
index f76fb117ad..cc27ba7daf 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -435,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
 /*
  * Serial Port Console Redirection Table (SPCR)
- * Rev: 1.07
+ * Rev: 1.10
  */
 static void
 spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -464,8 +464,12 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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


