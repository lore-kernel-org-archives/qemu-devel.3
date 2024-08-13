Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD19BC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdk1U-0008Ds-VR; Tue, 13 Aug 2024 01:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdk0Q-0006q1-QK; Tue, 13 Aug 2024 01:23:44 -0400
Received: from mail-sh0chn02on20701.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::701]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdk0M-0001ZA-VL; Tue, 13 Aug 2024 01:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5wkxou57FI5DvZ/bk+n5ifTC2QFySabVTt/LYknkrqOe1UBS0db/4WGGYpVzEyJNJl2atSD5BELyN5rAEvrJtzcVKTknglj1NyvL19kRB56117Tb1Ett8bClD+4r8ouOHNX5zT1kE8ORkrwEv1tzgN61bo9rcVGlEGXiDMYkmIpDyhXAf18XNndAEc3PsBZnVRGGYcJ5EQbdaMmyJoApw15k0BFOcDou945jYsZofx5DTRs3jWUhIG+0T1/GhyREqJ2289t4xigNVIsF25tVLAfY2Vpmoobb0LLuRR2eOGdldA/1MBfJXS9kO0gJtzhFwMBkQLFw6LNcSV85JgTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJmqaOfHU2UZFFr1RMmErXlPOwQc+KWCaLdFoV1GKx4=;
 b=msMccxmeRWCpu3c3Cogayr0DmHZIAMODyTF1swQfLvjHk0kynSKsF7dU9UjHd4yVhf3/YLtBbCo4yyu7x1o2l2MDKwu3wIR8hxKWsjwQz/oflbdeE0a6eqC3yzc7+Q2syTS6apjDmm5vsOl1YctMMkdkaIw98jNRjK2UlE4yRneNjxC7rBPrJa0Fhewfh5GhDy1y2Q1A0UmQCmrTNgbhabFRrBCTqFovbVeaAYgzTe9qyKh6OOUrXF+aolPuYqyl7F9GO5HyPoIPIJftxCdNS0qq16n59dczC9l7UHZi3QlUmVRycG52oWquotqKBHVCFw5sNJ4HzLJiinUhIYulgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0976.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 05:22:54 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc]) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 05:22:54 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v3 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR table
 version 4 format
Date: Mon, 12 Aug 2024 22:22:22 -0700
Message-Id: <20240813052223.1033420-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
References: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0976:EE_
X-MS-Office365-Filtering-Correlation-Id: e7854b25-1734-49c1-0e15-08dcbb57fc2f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: 5NW6YyoEDBtQ+3TcWO9zYBXsdqBVoWVjBzpVKp4lk/RwjrBoITdCJMyyWi7o7LsOvWD4HW11M34TPsLqoInu/aWSIHCz9X7HNe23oTpMK1s0KZIpYz9ldPulXSiIFE0T2xpFSn2LKrp8FSjI0BDHphn5NFx1znLgDmSBb8enxK481XmT0BAUXRxWgYhkO6AM7YFom7SDdv4t9P9EPWsnf4As86bZhN6cCJBaIXx+zZzKK1Aav2XVrQpVGG9vxzLPC/MWQJy53tA0V4YMPtfit6IdWPEWi/1RoNayUUzky3jWEbxhTY9LaNtCmBXqb0dHtmXzKnnkieR63suSmcW44FuUzjanVbuInsll8w/n9sN5+nKiflCKb46Ng3NvCC+ptDWnCtrPCC9im20WlSmJmiJfsnVsd2WhytX6KZbaYx2BsXQSFhe5hP84tJ6bnFsKps0DeUYtW/0byJtDUm90cbtnjqYigCwHjiKgmGeQUco2Yfa700dwylSnTUFwRyoBOU12Osyyh88VHdjqBcOiqVGtsqapjM/9YXvbVCL2RMfjq1T2FA8ZDvxfKN9KJlEzafUIlxmTgGTK84abHAnJba24i1/kbNwUnLaenYN4z+zvDMnWTBiqsOmWPx+HEwGu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvXjM1vZwsYX52a/uSgt8jWebRRz23zpY5IXIKs6f884kxW8EI4Xtn4q5eJz?=
 =?us-ascii?Q?qOSTF/ru/5No0YPzt/i0HW5pfAbhfl1Ii8CXXIVw6DXDb1qvFdma8lHqbeIx?=
 =?us-ascii?Q?igLj1TGxibCmShbBa9Fzyh9iAjEwK8+9ALQghiZun0zHpqVp29jqtbsmmTDY?=
 =?us-ascii?Q?d2HPwWuyKFX+IQ51hmFnSC9WqwpjufpS2+8T7hpCx0PpJCAhUkh44/mAPmYn?=
 =?us-ascii?Q?mu3TibxMzZK8B9CugqhTVsRjtmD2YyxOcZNkXJMd1VI3vtoAKNtqv7jGaZlY?=
 =?us-ascii?Q?jBdXJSq1yYW5TXdHWypZ6ovVQNZ2S9rqK8oPlDxJDjX4zxwCtdDOQJv0bBPk?=
 =?us-ascii?Q?XsRVXQB2x5wPEb2dnSRStyMYNpKs4ZJZGpVAGj4i/7GSt41Mun1YJp4hchOW?=
 =?us-ascii?Q?46POBvwS7cAQhUt840/PFiu+lJc5GWNeV/JyDupaLGsVq0/Ovlsa7S3nnKQx?=
 =?us-ascii?Q?izu81ljgm9WCypJdT/cqttEht0iNwKTmBHsIdKBv2bcyuqN5FhciW8PLMv3c?=
 =?us-ascii?Q?an1Qm147esFy+ItvPsngqrbNdOMnhJn6SrQCPmNgRxMVCwbS7ezTaTpQe1KU?=
 =?us-ascii?Q?9Mbvvu4tsH/OiLWpGh/ujt/VGMef8fbq8ukHGz8IVLlGrmilaT4lqFK6NBZi?=
 =?us-ascii?Q?fTe2YDhcgQFUWZXBtAj++ieEiLZovOTFF73+cfvaP0WR8VNkrcGHn6zcTLSb?=
 =?us-ascii?Q?N1E+H/zBA9IhdIR4VfCDENpL8ksvCnO4ajas9f7rL0Wst7WfU8pD0Hb19Y38?=
 =?us-ascii?Q?8TQdWaSYzVDWyMIUYCNs368i98fPDMubt4O2uZfLzsRp6YArFPFnkmX1p+Vb?=
 =?us-ascii?Q?PNAyktvHOtbA5K7QPFzJ/+/gOjU9d+25895P9fozPO17SV7QOFix3yKW1sM+?=
 =?us-ascii?Q?bDsx4OegH2IaNs35mU2GEs9kD/FXnzsNe86xuVEB88cbg8RMMsYsQ33hBK2C?=
 =?us-ascii?Q?wa8W5BWyPXoRUB3NJjhPtkJuriIjqOBWlyVLbbhXoGdeVy7E89VbYSfILqtm?=
 =?us-ascii?Q?5UbX/tEkd3l6R59xVer1J130A3Bj0culVj4t/TIheWo7dnmyh3G/rxpPSDeE?=
 =?us-ascii?Q?9uJtnkDyva8Hm5XiZY/FjasYhHOAhXVZE564H981YO/02imoWZ+7Jx+yf4Bw?=
 =?us-ascii?Q?XZlBSCtZjJexh5K6jeQnK2Uyk05qcEOyU1Zvoweq3ZmLvr3G8tUuz7PudOIj?=
 =?us-ascii?Q?Mm2EXbQMAELjUF3S5Th/7jZ2ah1+vP3mf8+qOtVHFZn7W+22IqkeIYf4m+nA?=
 =?us-ascii?Q?NReJigpeJErdvCPBQHATD8JxEhyvDwwWvtNUpSIUMy7oxidmYlrUr8VUgB7R?=
 =?us-ascii?Q?UbQUY2O2oP05VNQh3g3XFVIRr1U26WkWPMhuXjoUAiorW+eU2lYtMaOsnzIF?=
 =?us-ascii?Q?janE/KKq7PuAGEZu0Z4NFCotXBdMLvriOwu88tQfgnV18qrszvccY+Xclhx5?=
 =?us-ascii?Q?hi5EEUqBI6IW0/HRciNueh9csngWGyqONILHrxPy0JM9wT9AVI0yLjNNBpfY?=
 =?us-ascii?Q?WMQSC6+BY2gsMl0eu24cI4qCR4DCkv0L7UsaaRQywAXGatQcB624rcW8WyUV?=
 =?us-ascii?Q?gqUz08OZYdfZh7sO8GIjRxBSYSvk1WWQQC2sgEqINkqMMOyIeB9GuU4hJPpG?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7854b25-1734-49c1-0e15-08dcbb57fc2f
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 05:22:54.8926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiS14ypSL1dJPB6ddbYNT5mwGnH+vfj5WPZxGuXMlTLYcmzCm6CkF6cLVjBnbqQJ2Jc8C2B0D1FkT1p8/oJ4xyy3mLcIFuK6r13DKBN/wsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0976
Received-SPF: pass client-ip=2406:e500:4420:2::701;
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

Update the SPCR table to accommodate the SPCR Table version 4 [1].
The SPCR table has been modified to adhere to the version 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/acpi/aml-build.c         | 14 +++++++++++---
 hw/arm/virt-acpi-build.c    | 10 ++++++++--
 hw/riscv/virt-acpi-build.c  | 12 +++++++++---
 include/hw/acpi/acpi-defs.h |  7 +++++--
 include/hw/acpi/aml-build.h |  2 +-
 5 files changed, 34 insertions(+), 11 deletions(-)

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
index e10cad86dd..ae075dc9fd 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -435,11 +435,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
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
@@ -463,9 +464,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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


