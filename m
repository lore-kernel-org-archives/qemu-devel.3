Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F7C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 11:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shSXG-0001I2-Cp; Fri, 23 Aug 2024 07:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSXD-0001BN-Mm; Fri, 23 Aug 2024 07:32:52 -0400
Received: from mail-sh0chn02on20706.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::706]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSXA-00086J-QF; Fri, 23 Aug 2024 07:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgJxruUIz3JOJ3L+kL5F8yFx23SyRTcEJt3Ll00q6IuCdoaInAAhnoZ+RUGLxiXvzL8BCW7xVlnAcn4NAza+JkewlFVWyAw5piB4VqiNIb27xltu/xB7DcoFUQFx/k2f4rgb1GoU72DKSp/3ztk87OMH8TPHmGOlqTAQiwFFh2Ub0qjg7gZXxsI2S04Plk8G1xs194+rVg5Q7agkpiJWa7QgdLuL2YfKSPN3/TGy3mjaDuxYQSR9LsDhp2MvFp59FdS7W/ePO3apzYnpHlsE6eEj3vSvuHrw0rQxyxjcCqoOHJ2LGKXRHxQIrVKrGMjPQ5LIws4mpkXUm0vCnEONzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhLS90av1iSS0tvtS4Qk4EXpxNTCqeCFCkRKwh5pL2I=;
 b=NUXhEuybZxVUvSpPB2j7DW6x484XwvhO5529x28gEDtxLhUE4giHhawliJ/UcN5bqjXdaEoXi2S57rCZYNR2OAEckPVJ33jRNHU2uovGW3LuxoNU32dIosSiu8Nncb2DMyp5KF9pgrP2i6r0DAdu5lwYt3wn5jwcpbvXG3FZBcdIWcbTRGk0LUui/j/jaVuQHrqojZx0xOzM5wXo5/Fy91yn6FdYhhqANTqQ8Jq2rAhnEGgN7Lrb4IcroJfF6ZhPfQocN52rtqsnZps5GhNm02+N90jl3JnYxYqI1/9JTcD2bPFBv6w86+VvZEEvS9tDt3oaBawxPQ++488dHwZbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0973.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Fri, 23 Aug
 2024 11:32:10 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.014; Fri, 23 Aug 2024 11:32:10 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH RESEND v4 2/3] hw/acpi: Upgrade ACPI SPCR table to support
 SPCR table revision 4 format
Date: Fri, 23 Aug 2024 04:31:41 -0700
Message-Id: <20240823113142.161727-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ae07ce-4ed9-4d7e-5f6d-08dcc36739e0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: Y+BPU5QcugEMr4z4nFkjkG3oKaEsB98OKYpfowleQXXy11643k9VtHjqbKfOX53YkIIe6BMF82Xtrujud5hkeACLHJ1RxhiW9AA6KD2+sFQJ6GFe6UtjbvGW7d9HyKxBtWGL8XZLOFvGVlIdVzOUK1P3JaL2v51cc+/ZkU4vqhuZmpgpVMe/mzyimix68VBaleplePgvkcfORyLN2Pb2IPe4PqShL2rHA/2QXuwWKeqKLWU+SNpV56YZaSl0XVSuiom4Uyc6Xux8cAnCLVJNrLm2W/8Dyqeksdpq+QyQtlvdDPjjX1TkIQ+Vk7np+6hZWDBLKDyJDc8RQKKJtJyfKzDJuG4bK7PUGrocfIlOyr2WJbIRH9Qyq/sO5vMScHFqMjWM1jlkmPTR1vtU7dZ6ISsOEB2znK996YUshNWt8xBihV6hL82oAsqOoFcpdKx8AJPZCh/mAF3RkOIQ4rpseUI4XgQ8Ts29BA0IKY1OJcYkUyTlYD1qyYM1dEtJz+5k6W8wsxCknmxERksi/piWvKFZgrwCmZcH+qBgWbyhYtHXEvayTr4HnkTzBp3zvobN0vGJaA88LPDiBe4pkY18d3eFouCMN8RQ+q0DEppJYgo17m7rziRr7wO0eC8UKTEd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qqp9Yc3i5ApLPeYdTA7Ygyy9pAV+T6Hn41ytDANN5oPosbnwFmqMGKhZ2GOt?=
 =?us-ascii?Q?6bXzo3qe67lkaWoMUZKRgEWYTxYjQeq4xRl6Flj+elF9Z2QB6fewI70qizzM?=
 =?us-ascii?Q?0BNcZ2lcsNn9ilgxjY+lVXoVGKnyBodCS9esfGMVEKy5RtEGr3lfrpmjyW3B?=
 =?us-ascii?Q?jUiJ9wsB8iEs9KWACj7dfkNY5/Pi7lRm7OnhDh0XwNCFvcHb84TTRNkAyN9Y?=
 =?us-ascii?Q?53lGVf6aKrnQ10xtFvwMme4bdPfmHJHHzMYwt/H1ET3GO2uWwfxr0Hkvbd5Z?=
 =?us-ascii?Q?ggVP90m0yflk3ly25SztmRik67LJbLkKx2htz3Ex4ewRu+KS69axNsqBOb9i?=
 =?us-ascii?Q?MYEi2SoPS2PI2IfggmBTrG2xc8XrXfl0vMq+o0sI6t9soPaxWQzBOIlrBv6m?=
 =?us-ascii?Q?gIIQQYobVGfrYqbD9+djmDaTAMtagSsX6/uRluADLkeHcCm3NUWSJtUIll+n?=
 =?us-ascii?Q?xrrJ+7sEyrSoXsKFiBc6j+Pd2n6HQBB2HhXLue353a+ly/qRLvlePab6GXVg?=
 =?us-ascii?Q?cCWXtR77nBOrYxqlfyy1O/hPg9peCjFcPWZPdQup+L2EROc9Nu8fJu9Ubsjw?=
 =?us-ascii?Q?7TY01DBL1GoKHm8jtZqT30S5suIcQgpDULLekCwc8jMjp7tgKu86R3vfmX6/?=
 =?us-ascii?Q?VV7bW2sAGq6cn77SI6S3gwI+9QRWoXhfOCnfkYIneZuLpp1t0iorEN9elO3s?=
 =?us-ascii?Q?cuAAWq+uMHWJP9sM4lN2mJ05Dfy74o82I1IJqXsuNlBJcThVjg0uT7+Tn/5V?=
 =?us-ascii?Q?VrrUjSs3FIXiZvBk66VqdbPv1gAThLyVe7HvSV8A8z6ZKXzV8QCjtwVYkfQN?=
 =?us-ascii?Q?ckYLbJyea+pBDbZ5j2jzNXEfv9Vh3Ikju8PVsFBuUzDUQshGIRhVHBrESBDp?=
 =?us-ascii?Q?uTbGAd09dzx0BDuU+5nBk5gVE+0X/TDabnngLXBxT0zkkIbS6zYyq6+py83R?=
 =?us-ascii?Q?eQpvnb5Q7Wu8HieEPzWp5nNXjGhX2IimYb576gDSW0hgVzmm/PzNwD26SC1N?=
 =?us-ascii?Q?5maJZXDfkOh9ro8BDHuaPO+IP0wtK1p2uSpY0tpkjogL3yU+duOmilp/+Btn?=
 =?us-ascii?Q?pp0ud0TkEbX+gEr+OPfzCnP8llCeCZ1ZO1g0q9Zy6XC8mCfyLBo75knIOleg?=
 =?us-ascii?Q?bQUT2pH0Qn6ifP7NVEZRs5D9i4IIoyBBwYqk8NPQfDWliPU+CdoKYcSWo9Bv?=
 =?us-ascii?Q?zLKdiHsyF6DO+5rqol+LrdvWgqNo9JT61FS0/70+HMKbo/kB7o02jeeJhLaR?=
 =?us-ascii?Q?xzsbmkM0RdemIYfl7+fbR+O4J/Xyhva+8JVFU/Zd/3mtzavrIDA7vcBUaa6u?=
 =?us-ascii?Q?nhrCwbq8sTSFKz2D1CONhiOi++OCFUlVn25s3osiIyDPaZ+pSVFOEMjIzNzi?=
 =?us-ascii?Q?OibVolQkBu9x1D3LV4pEvOBEoqWMhvGvwWBUoL9AhTTMehSL3Fe5Rdy/x0wi?=
 =?us-ascii?Q?g6U3vdsTBAH0XtMKQx4FwDtYxVmRucbqZ9l4oh1nZz8IYTPjvUKTYz+h0zrB?=
 =?us-ascii?Q?OAbeAutKULWHcellcpbJ02E2phydEk5RNeUTWgtkzvRP6GNc9xzFpYwOMnbG?=
 =?us-ascii?Q?ujIrwkIt4AjU046xDO1iBOMYIIR+5AIPb8nINAT/cQEtfv34bA67e0uMfdrG?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ae07ce-4ed9-4d7e-5f6d-08dcc36739e0
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:32:10.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHh4wocUH5VMoybHsWQzWZH6bsQNQIveKwzqdKhpFPaJoJwUCoEiumj+bsj3d6Wq4M/7HCDj7HL6IYeAbYM7uYOmHTqbYzRMx/Whx1DpNK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0973
Received-SPF: pass client-ip=2406:e500:4420:2::706;
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


