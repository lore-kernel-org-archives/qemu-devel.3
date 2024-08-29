Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1536DC7115E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 02:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjUS5-0008N8-Ag; Wed, 28 Aug 2024 21:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjUS3-0008Ev-Bs; Wed, 28 Aug 2024 21:59:55 -0400
Received: from mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::728]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjUS1-0007Ke-Eh; Wed, 28 Aug 2024 21:59:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7TYrik/QwjEGYpGh8/hMHFQPjsg7ZHlksztQTQb5bgrRp5l4KimwDwgBVulROCFZYyfKLulakX53/fWw/gg5vXkgNpBxsXM5apnSUiMTv4smsznOSAOcasNm1NXCM7ejMO9kWHZMSxN/06OA+iQzcBwmwDyCoN3enNUbmRW9ER7vHkbgiZcqIaCC0Xl9DyDLmvMBSgbzjAWNO19O7Zmll2iRNZNeIFCmDGD3JGEBiRcr1v602YY8BMh7NVhIM5QSPXzJnuVyeQXXlrskCJPkY9hA6Od7vZ0zvOm4pPCSfzS3YEYVcG2QgSH5bManiuvX+UhjN5XASWKNFJ6SRQ+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAHOqQMDfUXhHM+KBOo/K7oWQabBYpCuJp8UPMq0prU=;
 b=Z7zRt4J40Y9aKIllX5X30T/qpGmvfEcy9tKtBBKz/nwq5uJegDjxTOTJvzfPe37KV7a4pTWJ9lxvk2W4TYiLwIyPVd4e4j+4AEapzuT4L1HUqe9gJiiBHAOmaC3u9k/WwkVMdt+L5PVBith+uLiyW/uqtfWIdQnsDjHTOf7x4nYQrvOHQ+Uezw/M3B5F8J0rHirLmPveGsOWEed4pLX4MX5yBzlpRmVVRk4IxL+oB/ET2Pql3nwpAsaA4DbKHepBSyctjlVY/lF2oDa+Ew9lxEAwJMtwBnEFAQdbSpYLBR+LshzzIyLs5Jnp1WRnKTZ/We0L0NFgi7YNHn/wvorVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 01:59:36 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:59:36 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v5 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Date: Wed, 28 Aug 2024 18:59:19 -0700
Message-Id: <20240829015920.95778-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
References: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1333b4cc-a349-44e4-3f82-08dcc7ce3c16
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: KTXMluSUG4rWxLoEJYxXfom9Ekxd50CAHA68zRtsh/NWVvTZpGzbVS3z9GwkRyRveOQcbPoCqtNNz00+K7QYwgO1CEkBXfZdSpVJR4bZY5YPpRmrwJ3gW52d5GTGeV705AVgBn3qCdpHYPP1WcBuhrVsMVHH+2mH+8p+dSawIt+xxRm0Xk37FhuRLC4tISun360HTDVCgplQGzsyQQFMxUMDoxagOUAcqydxnQygkQpiwwf6lwXRI7Lt4vZNKnolRn06NDOHtiAhXhs2n+eelJA0Nl1F++L/fVq2HcO/K+FijxhmjqGZ15ZsBVrfWoMj3srq0WtIBXQ001hQOY89JlUqCkjAAV+3LSPGQ2rmQJj6KLj8nOzM1QLVxpcv1IPg/s6nglQGEamiuxeSa8V3PaPzAWghGRtMqKIo5xDFmQnc6igqAD9c9aDb40eD23NT7izVSQEw2/MuVw4zRJfYjwueE7uQEVcn/76C1E12VMVo4+Zrg4CTHwHtg5tUXXanP3nGUzf2RaDR/2L/1IcCrcnVvy7YdvdIqZWSyEz8HD9J9tZBaop3gzkItVUuaJSgkUg3I+nMK5tVLAn0uh8T/1OTGkX+x3ZN/sua7Se2dlblB1ZG8yfw8oiEyzXZY3sZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JJ9EYw/eGcrmIqX95L4YYodDPumoRXW1Jh18oKt7P/gHck7fpp6u2I6GbtMP?=
 =?us-ascii?Q?o2DibwBd02+tSGSYINsrY6v7Pjv89VBj1xg0ZsHELcbc1+aaMMthJRwCluwj?=
 =?us-ascii?Q?uw7RFEw7ao7hMVyDdp0zMe8k31VnIe7Qa8Xk4QoGQiEvrNNi7JOKlLQjf47X?=
 =?us-ascii?Q?Gwat0kIZHE9VsGxdZtyz082XRxMCBLMLauN8boTcDwDdxVukn2zneaK/mvLB?=
 =?us-ascii?Q?dtnr3ZE1TL3F7wgj5zRhXZ8nWGLir4l3UlAe58iLb+KCCRNROIoR0Dv9qcPr?=
 =?us-ascii?Q?eMg42MaRZvuOjy+h5Cz6qmdhOiNkg3F2684Rl4ML4HOPCkn14Ns3Vg5V7VXa?=
 =?us-ascii?Q?LYhK3hW4RVQp0Ux1ycJ+UplnKJHe7g7tAVsA8GCmbTPcGGxyhLm8gxfZmUn7?=
 =?us-ascii?Q?vhx573osdZpWwttnc1j0102jJNIN+xXI371TJvgP/ZSmAstRph+5tQaQwM/W?=
 =?us-ascii?Q?dAVojFcICuoL6/y+pDXmEtm+7VrSGw+w6jQyOh692VuWk1p2Zy6B3czUpb1H?=
 =?us-ascii?Q?E2hZpVTwyf5ZePrYXgxD7y92AEHz5S09lbFujSXAj0r5gG10CcokyqWevwrh?=
 =?us-ascii?Q?vHMqLCnx3dyC+kMviNAophpSPptBWuwkQ4OuTUcVCZu/e3AKdKOObaoR5E4W?=
 =?us-ascii?Q?bTPN5UXc1fdV6U8SYjzOIXxBlE/u4h26naIwLPnkInHvELU0KdoQ25bsTmmR?=
 =?us-ascii?Q?Vtp8Vwc12MYc4TiSZ06+W38jhoK9BaftBfqqysCohFZ9umMuC1LdCVXzHtol?=
 =?us-ascii?Q?CvZvwKWgxc/y8NUdTjiFSiE7G8u5sb39hD1ff5wz7Z/cRAnJHSvpi6agehd2?=
 =?us-ascii?Q?I0ZMO/MVB4mKKUhX8wJcAL6Pxj8dZeYkT3WqoQghSBbcHvhKvphn8Vy+JgOM?=
 =?us-ascii?Q?0fNHk6ahV28WZOjup6kSJXcbOkonYF3tS0IJxdGbsZV3chwDbCAlK5+wbDdX?=
 =?us-ascii?Q?kNau1zMAaDgeLyeGoa1xqEvQ2gMfE/P3A2J1a2jdzFC06P/Rukg60uey8lK9?=
 =?us-ascii?Q?CFyaikRbfejeM7FMVq6rcAQrSNIwqNVUByr2qbIuxzxEz1p137LzGPzpPcIy?=
 =?us-ascii?Q?O68dP0jWOu0JAM8gb+1PwSy/XotT4E2GddnQk7srKKCvMTMBw6UXs6IC1XJn?=
 =?us-ascii?Q?OL7cGuwsHRD/+zb715DQrf/ur5LrWSln03LlvPILfUFfNNZMvE4txVYJFUSC?=
 =?us-ascii?Q?wbokWZAEDRfOfRMdbsvbAF5VYqozk4p4K+Otbg/NR9nJnWXXXccs1xRj8SFT?=
 =?us-ascii?Q?1I1IySMMo8JDk7vSV2r3HN0ul7xnbjDd/lUeWdxEWnxSxMsUSJPCTOBbIEn4?=
 =?us-ascii?Q?3i4RBHEjkDKUIcX+Q5nav1x21nw33J5180KohWJ9q+6KZYqvXzeZVenrC03P?=
 =?us-ascii?Q?K//wIR9O/hTKhJukXtUwlEsdCqfGxwpDsHOCAvwuYgB7mThsumknRND5ta//?=
 =?us-ascii?Q?43XdvoDuAAUjxty0YctEjNmEqQASNGOQ5TAOTZO8QKw6FosBY/PpxYmkSS5D?=
 =?us-ascii?Q?p42wIPSH5hyUM/+dq+gG+9n2pzy5sYDUqT6XUASPTo8YTWBe7zJa6+QKsaWd?=
 =?us-ascii?Q?W0WxPLYdmX+u//Px0qn2+TvbxghKLkVZHWCbhenQPuAro1SrJCpwKfpnhKVT?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1333b4cc-a349-44e4-3f82-08dcc7ce3c16
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:59:36.6595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbG1f5J0MIcZtuT1AXouKpmyyAscowkP/5iIw1ciKz/naJQRCw6lX4hxGHAIgjpnAOruu3roOfHaHfmDLy9BVl6x0ABN0T9vamVCR4etVfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1021
Received-SPF: pass client-ip=2406:e500:4440:2::728;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
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
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/acpi/aml-build.c         | 20 ++++++++++++++++----
 hw/arm/virt-acpi-build.c    |  8 ++++++--
 hw/riscv/virt-acpi-build.c  | 12 +++++++++---
 include/hw/acpi/acpi-defs.h |  7 +++++--
 include/hw/acpi/aml-build.h |  2 +-
 5 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..99a1b403e2 100644
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
index f76fb117ad..0b6f5f8d8d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
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


