Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E59D13595
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 01:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5F1R-0002mU-OX; Sun, 27 Oct 2024 21:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t5F1P-0002lK-On; Sun, 27 Oct 2024 21:58:19 -0400
Received: from mail-bjschn02on20701.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::701]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t5F1N-0007Ma-Ms; Sun, 27 Oct 2024 21:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP53Fj6ee7dXSnXxgWXMxhyx80+Tg3IJyf8JOsf8wAHIXCHu3XU62WA7VSFmPJVgu8ir9dpnBE7sg715sunngazkjcfJWBIaaWRpmX7nPF+GYBypFlAYNMLseT5wkP23UDqLX7FPQqeX0sk5NDCX8LlOBEpLdgx1JfKepraH+pNJ7oo6GgDSSVx0nWLYvHUw13Okgu6FhoC7yg4o4hjmbwPJlYd5qCS/oqC4SzeV/w2ig7w7Mog34h2QSe8nd3TbUCRmqKW4zOJoCyyn5YvqLYcqcWNzd1OdgvQcAgZsuUMI3L+58wwvmD7Y6HV8YTv4G2wUM/nAEAK1XdrHLELvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/OkOrdTHPiKx33flKKjBuqLL2qokvB4SEkPs91a1y0=;
 b=bCq1w6pCEENe0JseH92SYN7JPJ6DKBgv8u4rSLREvYuAFgwNKPJLtrRHJGxfpdr/DnyPdEe5Hq+A8ilcnZZZSDqTXSWn1/EgPytruhRiTBs5mttw8R8tdT9z+w/xUaIMFFdZKBxaJdTXeCgbfAnBTt2z1aiKCJUawPego7gId42QmYDp+dTcVjb23JXOf/SCdx94aupi2UhIeWg9ZKUJTEIyUb1eCW3FGs59jMX8BIr6T0xTml8dtE9/N/WxToWMbQmPuDhSgMJLvb+cCRFS10Fubo0thLEg9Q/cmSkJXECCuT64kxiK6pkZzIYyRbFunglwGMQ+wZ0PKW9GoQIUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1263.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:58:13 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%6])
 with mapi id 15.20.8069.031; Mon, 28 Oct 2024 01:58:13 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, maobibo@loongson.cn
Subject: [PATCH v6 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Date: Sun, 27 Oct 2024 18:57:43 -0700
Message-ID: <20241028015744.624943-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
References: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1263:EE_
X-MS-Office365-Filtering-Correlation-Id: e4562586-f568-4157-0ed0-08dcf6f3fb21
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: z49ZfgWfo4BFNkKLXQHScPhIqeXEQrPBYfqfQN/EhpIXJkXlL5lImkNPyH3FvCgKb7Q/feE6JaDeLb5olvypizHCtdEyM3qcy2KnxlMKXlVfDUdYymkxy2qb4Oo5eMxzkJN9z/za7avWLmSRMVYI0LxWvQs56UH+a+ptm1n3E2d+IyL/98TKB4QC7jcAAExVh7NlKpJlE1S6G2ZcwVEXqLY0IO2PxHrFnGEsofXYcZNtr7MS5Fq7hz3HgTb7sLHHHuUDoujctUbFbUkHgOD/jJwnyQ2D43kDdB03DaNKg/X5lHLT6rC9qUz3VJG7+kqOePLUBu3yUBUBV7nlv9oS8XVL3vM5fXx1u4zXLAFPFXMuVDrYKV00xk7kTQR3p0xUSzCawdqNkHyf9rnBWalxOHMOAlrl+jpNSZK+RLJ7LUxbpHa0J6Eh9XTZhwsxL5D5SIsndVaGfvm4TGUX1rGPIdw5lCG8QkFdOMv7aNs5LCHMtyHHcn9PbPiuyTnk+TnXPnV3FJxvo6jReDWy1dYKGEqzYQBfuRCT85DnXcEKP9Xz3y7GDFY2mNyHngFD9J6LlYySgDKzdXL49USsI5/G/GHzADqirF7j/xnNDINyJCQ6+9q0hzbVygWT6vip+de1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22xibRUAjPz7eiXM0E+gq1MDBLSFESJfmTycsxNFopxI1bdsIAChiyags5j3?=
 =?us-ascii?Q?gLHrfO0apTQvsiY9vqIyxJDdq24tRhqDhyKYAVzA5s2gcKs+95+VsdUxdzLH?=
 =?us-ascii?Q?mgZ2JbX7OzTM/O7ese7wwuKfhX3Mu20VOZ2PJXpB6MX6DJXLrpgzTo8HhjGi?=
 =?us-ascii?Q?xbh1GmmlPjqCRDHt/ShL6dPQ1HgEyPlx1lVt97nBvXVb4J2dDP1jHLf59koN?=
 =?us-ascii?Q?e7eV2ssANkv1gWvRalwZswO8omcclwtx+k7HhWHrHX/IaID7+ERyUTJBf3iY?=
 =?us-ascii?Q?25L2sC69YhpqttJhGtsjqTaxzXp7XJkCRQY2fxgkaF7/71aPfWawJrNu8el/?=
 =?us-ascii?Q?ECXnCiTWXAt0PrtvdEPTzPxxDjXrN01hyMify2e3CWvV83JDegjaxaDbJqD7?=
 =?us-ascii?Q?+NygqeWz783Org6/63S4BCj4Vd2AoexZkahJ8be61zjpeYEZLQBkWQ9r3p0x?=
 =?us-ascii?Q?Dh7frh47OzYKCrzd62tlbirhTa0llpdYZs4o9tC1qlylhJFeUeEBgx29E+X5?=
 =?us-ascii?Q?sKLlZUCgJobZQlkSDoZKZt8D+mk4MEtLxmcG0PFAOfRxwrOA3DDNDBVorz8u?=
 =?us-ascii?Q?FEVWOxQdEdMh1PnKHNDRp5FbB3EGCiFTF/OIFtP8gKo+h28uotdLWBW/tZtF?=
 =?us-ascii?Q?RKZ9rKASDu5w2xWa5VeVNuFIeIl1HFcqO6UMcPIJzJQIDazLNUJqj9ocqkey?=
 =?us-ascii?Q?LyRUejEKRX/QdhdBKmoiU6RJa1u6Df7n8JyL8OTAgXg4LgTq7ieFjwD03q1i?=
 =?us-ascii?Q?Qb35rZuayYNqcfWU/0npScqDLodiXST6wrAeKE4E/sSxIZY67/+SaXsPaSH6?=
 =?us-ascii?Q?mLeAAXes6WPraibMh5zTLJ7ZPYTpaZ4gO6FSdmsn7lWjKzO2y+ssBXKAozYu?=
 =?us-ascii?Q?Ri0DC7DcLr1Hd9cd1gkkMTXfzNiOGembkzBKLOoW39JuY98pQKQpPBLP6EV4?=
 =?us-ascii?Q?yMhg6oOI4/hCQTFrP8s05oLw7EfpEHuGbut09ZiaXk3WiNFpYHv9dCTS0i/y?=
 =?us-ascii?Q?pzzt/ceeNu5sVTKRJByt8VpvS5MsamuTVaxnAwQWZqBCPbTNU2gQegjcKjVE?=
 =?us-ascii?Q?ljeRA2+NqeTWpqndf7JxBFiiU+c9QsKXEVlcKg5UhHe+V3zTwPWYjxTK1Hfm?=
 =?us-ascii?Q?9HVRaWvXLH14cNlK40tld0peAYPNU+HzAyVffO8C9+q3VCoYVwvtzxQ6htuo?=
 =?us-ascii?Q?N4zNKsDsT1hZ/C+lwR/T2cyfB34O0hzeRx1Cen/btHWihwzbQ2rqWtzKkc8w?=
 =?us-ascii?Q?EobRvjbawCCbteMELHo5f0inlYrAVmPeKnVsB0zJPndL6p8jomFYNhZ9hsKr?=
 =?us-ascii?Q?fJnt10zfU5QcN8ctfMXnThP7nkP3EHDAjfot8297Fq+q3X2ayz2H+flLVBzK?=
 =?us-ascii?Q?1gJtx47PEApd9/qRXM6A5EmRWduleZcWCOcwvuiJn3oCnq1ea684hDO1QxfG?=
 =?us-ascii?Q?Pvo3Nee7k2dMQyfr2hEt2sP+m6trI3udfd+ThzWMmQfqy6vEWdSQIpYQiaJZ?=
 =?us-ascii?Q?X4Dh1D6jKsjIPV4yUbelxqHLWdH55pIC/xNvDqFAVKoEDcLFuF7ggi9/HTV/?=
 =?us-ascii?Q?a1xm80ez5cb6Xx0eesUG/Jn5dr4qdxHE5VMAe36ZLFnfsqEL+fI3IYqovrn8?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4562586-f568-4157-0ed0-08dcf6f3fb21
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:58:13.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwc1v0x8H6JYgoOq9DBPVDFlC882aO1scI8qKE6IXMTZ6b6E0HJlJV0WTmBJxEahTeHYNgRiHasj1eAI1pgMeQ9QpwApvoHENtfxw5Puj3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1263
Received-SPF: pass client-ip=2406:e500:4440:2::701;
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

Update the SPCR table to accommodate the SPCR Table revision 4 [1].
The SPCR table has been modified to adhere to the revision 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/acpi/aml-build.c         | 20 ++++++++++++++++----
 hw/arm/virt-acpi-build.c    |  8 ++++++--
 hw/loongarch/acpi-build.c   |  6 +++++-
 hw/riscv/virt-acpi-build.c  | 12 +++++++++---
 include/hw/acpi/acpi-defs.h |  7 +++++--
 include/hw/acpi/aml-build.h |  2 +-
 6 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 34e0ddbde8..69c4bdfa22 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1995,7 +1995,7 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
 
 void build_spcr(GArray *table_data, BIOSLinker *linker,
                 const AcpiSpcrData *f, const uint8_t rev,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id, const char *name)
 {
     AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -2041,9 +2041,21 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
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
2.43.0


