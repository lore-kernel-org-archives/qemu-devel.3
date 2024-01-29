Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F975C48286
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 02:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHBE-00067G-Fa; Sun, 28 Jan 2024 21:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUHBC-00066a-3i; Sun, 28 Jan 2024 21:15:22 -0500
Received: from mail-bjschn02on20617.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::617]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUHB9-0002cP-PX; Sun, 28 Jan 2024 21:15:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYHivSp6ymIi4D5Vy7anSQ+dRsswQUaWKNNDUzmSiPCk0mbs6O1gp9OjbGFJLJu7T4pYm5yPUjpJMNsKFjfJOSbL5UK2gWsSjkRUYWyawWEkfl0mniRFQrfuhhOL/9AAqmVhC5kx7JYgXKhHRHi8H6CUMvP7PNP4pKoQnTrE+cS5BQU+zynXlNcvliqIiN5zsN//Z/grM5KTdOEDMCtiHHt/OxTnS8WzLPjovwJDGj0Fs36QhIwIKM9GP94/1qgKMSXfYG1DPJd7Epop7Xp4aVEEvabIKVlPqvOLTLZmlwKs1M2ubUXJyu9x4yXe+ILNvYKjLknXK3Va0NeYdNuF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvUQs5EwDieDi245Mv3eG/jlzvXs0vEue7vdm3fvcpE=;
 b=TVC9WfWX9yuGoXkN41H2/xBkblmj30zG+O2zI8JF48aBsa9FCYkXpEkcEWiyW1FmcbDn7HsLM3BO1xhaWtOwfWH5wNnhy6M8LqVJs6ucwKBJ6+/MZgpkC8Q+ukxzFaR1l2sdnLVt7vhB4uCliRMTrGS1ANBXJ92BnYxhu1X+PzEJ9aKT2BiKerxlqcCAu94Nh3oMIAVPNbFBs2ruGIFdEJ9DsEWcvh1nqyJdeD2goBMGbdkX5TItZkZRZmSYiYWpZcvFhP8axJhNgM2cFr1WvHDPG76WPkMu7Fqb4Srt6hXSUvTebX4eokL8cXHKUFUaSC0d0cbaGKritotwIrZNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0852.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 02:15:01 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 02:15:01 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
Date: Sun, 28 Jan 2024 18:14:39 -0800
Message-Id: <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::27) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0852:EE_
X-MS-Office365-Filtering-Correlation-Id: df388a2c-436a-4da9-65d6-08dc207018f8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdTXV3JYa8pHPRluH74oB0uWV8p1X4F4nABmJ5fYIVVcfy7u6AuBdH4rzUHKCe4CjVXfCIl9tc0XDhsV6QGG3877axpQeFp72dKJEHljrZfJg75SF6lVdVT6SW241m5AOUc79ZPjRd++NtfA+WxNLxC5sfzA9gzK90GJC06epKFJs1wKqlGJRaiejyZeCjkB/d0qlDHxaYfcak5wyI29P1VkrAq2EKljMd4wj3BCFE6Q/Dcqnbe/E5a4NCTWXOf+pMSPeJjQghTjCOfRtBWnhF//DiegPNYYaWOS2tby40M6iUBjcDbMetatS2aBkOp59HZ71V+MSc1vmnf4rM+sAhZc27NlEO4L7Es7pc0sgyFCD8az0hKEef51KPkcAh2T2iZ4ZcjcIE2xb0BZewgymB840riogjDK1mGiBEy3HZ9lvzNYOcTRpsoFhOO5af+64Jn1tGCyXyJSnjpd2dmxDz0mWuTeBJ8BPkQaH+/u92/3to6SSvWfUQ3pq/RDm7nExaUj3UQWKvOFktlL4Pi2lpyVQQkJNIUd/iHqX180uH0EYuMsB0Re2WlI5nxUjIAI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(39830400003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6666004)(36756003)(40180700001)(7416002)(5660300002)(2906002)(40160700002)(38100700002)(8936002)(8676002)(52116002)(4326008)(1076003)(83380400001)(508600001)(41300700001)(86362001)(66476007)(66946007)(26005)(2616005)(66556008)(41320700001)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqXrJCQC4be2YmHja/F/o4LVItbNVC78pF8TP1PBmSKoYd5CWJD1ylfThTdx?=
 =?us-ascii?Q?+RDybMoFXMzNznHqqc0d6vJYBOaXGWiuzWt9GlLKWVrqK5BtklMOPmCuMiiq?=
 =?us-ascii?Q?TWDRFf5SboiRdtN3rNqG7vp/gGWHQNgaGfxaCBiSEbQQAOQihRug2qVQMi/k?=
 =?us-ascii?Q?QDxfkVoIp3AGImcBhvEBPXw/kUS6p77+ridpfH/ZzQhNKZsBm4y8PZQXlTvg?=
 =?us-ascii?Q?qxeg8c41gPegmOBFrZ4uMKtCr/FQhzrDs5JUMWJI2uHn697NLxSuhX4gDfHD?=
 =?us-ascii?Q?JT6l2jZE3vvVAYgYJCKpIQ6HOEKfZTJxN0aFiXkHUIxDs5rE3zHqWTYS4+UM?=
 =?us-ascii?Q?HqNExJzUA8LY6KDDzfxyRfrzue4Sqa1++RuPqphwWe1G8BvH3xVyfl5muxa3?=
 =?us-ascii?Q?PPDRXg6on5N2/1+il0gBdG61mC3sd22Op4aUuRaBXjGDY+K5KctMpYQuPdLd?=
 =?us-ascii?Q?VetpBPBd5l1hdI/+j4p9JfnkWIchM+bqi0tuoeFYUBEj37pWIopPbvr3AuTX?=
 =?us-ascii?Q?QIiewSBtlnHz2/PO6EgSXzVpPzGQ7nxqT9n//6GSFv9g4K5RwlVScATpv6Y5?=
 =?us-ascii?Q?kelO7tHDp2tcTOCdedR8QOwpjIt8QdpSG9M69k/yhHMXpYnrOz4y28bWMV/i?=
 =?us-ascii?Q?prGT0aWMfZjNudNzsaYjg9QW2adJlV+ilb1i0oaKeh684Nw/6NnibLX9Zs3Z?=
 =?us-ascii?Q?uUF+Y1s5tACq913tPq9M4LYgu6YRpBH17jLlXh1jDN5+H/f+PKU6530oi2YU?=
 =?us-ascii?Q?nCwy+46Ad/ZP5w6stXJbSLpGQ0gIxhU2KfiuArQYKVdUuPxsxmLEVVVaP18o?=
 =?us-ascii?Q?njvQqMtAziD9woTlKShVQsJ4GunoDYdTCAaM2+vCHAiFnNeZRmIISlEX6biB?=
 =?us-ascii?Q?+DNxymijiDvUvnVmPgmmVJc6TrE0mwS2EXKxLDovfjDQCK7hpiR4SoRiq0dF?=
 =?us-ascii?Q?fyakDRW8ea/kI6C+z4eqP6BDpKvGGfmpa4pMczDq0JHO9Xrv3m5BNuJvjdoY?=
 =?us-ascii?Q?7FUzg15O6HOZUSP9nE7qf4hd7rEFPWeMW7i2tlEwS19shPRihMlmxriU+/4c?=
 =?us-ascii?Q?HCOSyMDePFukKoMkmHyVT7zCDtDV55Ux08wzqMBHMixJ5cjRUscAPe3t9ulD?=
 =?us-ascii?Q?zEPdNnUrVBfcBPKXwnx4DlCEvlJwcbeRwNCHhB3wsQyfdcHjtipy9xuSk+0S?=
 =?us-ascii?Q?AVDl9sMJsuzMiLCXWSTWe/KudlirJHai8ImQQCC3ifHGRKNkaRFCoPU++BXt?=
 =?us-ascii?Q?JNWhIe9+WYxYbsgdqCXdSA20Q3Sr9SgK9cvR8wnf7ukyQnIDcdjPuXNRWOeL?=
 =?us-ascii?Q?Stjz7u+nFU3LZzmhYWazAofkFEMeHLm8gOL4/m+VIeb4Ud5IZ3rpUp7/OJnk?=
 =?us-ascii?Q?hOgYVIH2kCAycFPBDkTI+7ONKvA4pkC362egRmA+ozfEhAx3/Fm5eClhwPvF?=
 =?us-ascii?Q?PxrmPLXyySXV7tNcEOesZKyngIfe+Tv0YLLC/Hgnqpxe2tjWVpFwjvfMQ5P9?=
 =?us-ascii?Q?YszKM5GRavAghXdClU9vc23DNiNKyktwLP43x+zHvGZycwsuJDKv7I09L2AW?=
 =?us-ascii?Q?D6mGgLsSh2UFkb9sD2F2UNTLXpZZxjHpQdo9oPcYT5gwhgGCr8MwzlDiSh+M?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df388a2c-436a-4da9-65d6-08dc207018f8
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:15:00.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR7O+VmeY3bxjTOZvfg5tnkbF+aeuw7eA0y20dxI/A7yqp/wa+iOm1MV1MdsjAF4k/pS9rm7FcyfdpmPmoPzD9mHy5GoLxyy5r9sM3i1it4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0852
Received-SPF: pass client-ip=2406:e500:4440:2::617;
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

RISC-V should also generate the SPCR in a manner similar to ARM.
Therefore, instead of replicating the code, relocate this function
to the common AML build.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
 include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
 include/hw/acpi/aml-build.h |  4 +++
 4 files changed, 115 insertions(+), 41 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index af66bde0f5..f3904650e4 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
     }
 }
 
+void build_spcr(GArray *table_data, BIOSLinker *linker,
+                const AcpiSpcrData *f, const uint8_t rev,
+                const char *oem_id, const char *oem_table_id)
+{
+    AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+
+    acpi_table_begin(&table, table_data);
+    /* Interface type */
+    build_append_int_noprefix(table_data, f->interface_type, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 3);
+    /* Base Address */
+    build_append_gas(table_data, f->base_addr.id, f->base_addr.width,
+                     f->base_addr.offset, f->base_addr.size,
+                     f->base_addr.addr);
+    /* Interrupt type */
+    build_append_int_noprefix(table_data, f->interrupt_type, 1);
+    /* IRQ */
+    build_append_int_noprefix(table_data, f->pc_interrupt, 1);
+    /* Global System Interrupt */
+    build_append_int_noprefix(table_data, f->interrupt, 4);
+    /* Baud Rate */
+    build_append_int_noprefix(table_data, f->baud_rate, 1);
+    /* Parity */
+    build_append_int_noprefix(table_data, f->parity, 1);
+    /* Stop Bits */
+    build_append_int_noprefix(table_data, f->stop_bits, 1);
+    /* Flow Control */
+    build_append_int_noprefix(table_data, f->flow_control, 1);
+    /* Terminal Type */
+    build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* PCI Device ID  */
+    build_append_int_noprefix(table_data, f->pci_device_id, 2);
+    /* PCI Vendor ID */
+    build_append_int_noprefix(table_data, f->pci_vendor_id, 2);
+    /* PCI Bus Number */
+    build_append_int_noprefix(table_data, f->pci_bus, 1);
+    /* PCI Device Number */
+    build_append_int_noprefix(table_data, f->pci_device, 1);
+    /* PCI Function Number */
+    build_append_int_noprefix(table_data, f->pci_function, 1);
+    /* PCI Flags */
+    build_append_int_noprefix(table_data, f->pci_flags, 4);
+    /* PCI Segment */
+    build_append_int_noprefix(table_data, f->pci_segment, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    acpi_table_end(linker, &table);
+}
 /*
  * ACPI spec, Revision 6.3
  * 5.2.29 Processor Properties Topology Table (PPTT)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a22a2f43a5..195767c0f0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -431,48 +431,34 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
  * Rev: 1.07
  */
 static void
-build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    AcpiTable table = { .sig = "SPCR", .rev = 2, .oem_id = vms->oem_id,
-                        .oem_table_id = vms->oem_table_id };
-
-    acpi_table_begin(&table, table_data);
-
-    /* Interface Type */
-    build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
-    build_append_int_noprefix(table_data, 0, 3); /* Reserved */
-    /* Base Address */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
-                     vms->memmap[VIRT_UART].base);
-    /* Interrupt Type */
-    build_append_int_noprefix(table_data,
-        (1 << 3) /* Bit[3] ARMH GIC interrupt */, 1);
-    build_append_int_noprefix(table_data, 0, 1); /* IRQ */
-    /* Global System Interrupt */
-    build_append_int_noprefix(table_data,
-                              vms->irqmap[VIRT_UART] + ARM_SPI_BASE, 4);
-    build_append_int_noprefix(table_data, 3 /* 9600 */, 1); /* Baud Rate */
-    build_append_int_noprefix(table_data, 0 /* No Parity */, 1); /* Parity */
-    /* Stop Bits */
-    build_append_int_noprefix(table_data, 1 /* 1 Stop bit */, 1);
-    /* Flow Control */
-    build_append_int_noprefix(table_data,
-        (1 << 1) /* RTS/CTS hardware flow control */, 1);
-    /* Terminal Type */
-    build_append_int_noprefix(table_data, 0 /* VT100 */, 1);
-    build_append_int_noprefix(table_data, 0, 1); /* Language */
-    /* PCI Device ID  */
-    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, 2);
-    /* PCI Vendor ID */
-    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, 2);
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Bus Number */
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Device Number */
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Function Number */
-    build_append_int_noprefix(table_data, 0, 4); /* PCI Flags */
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Segment */
-    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+    AcpiSpcrData serial = {
+        .interface_type = 3,       /* ARM PL011 UART */
+        .base_addr.id = AML_AS_SYSTEM_MEMORY,
+        .base_addr.width = 32,
+        .base_addr.offset = 0,
+        .base_addr.size = 3,
+        .base_addr.addr = vms->memmap[VIRT_UART].base,
+        .interrupt_type = (1 << 3),/* Bit[3] ARMH GIC interrupt*/
+        .pc_interrupt = 0,         /* IRQ */
+        .interrupt = (vms->irqmap[VIRT_UART] + ARM_SPI_BASE),
+        .baud_rate = 3,            /* 9600 */
+        .parity = 0,               /* No Parity */
+        .stop_bits = 1,            /* 1 Stop bit */
+        .flow_control = 1 << 1,    /* RTS/CTS hardware flow control */
+        .terminal_type = 0,        /* VT100 */
+        .language = 0,             /* Language */
+        .pci_device_id = 0xffff,   /* not a PCI device*/
+        .pci_vendor_id = 0xffff,   /* not a PCI device*/
+        .pci_bus = 0,
+        .pci_device = 0,
+        .pci_function = 0,
+        .pci_flags = 0,
+        .pci_segment = 0,
+    };
 
-    acpi_table_end(linker, &table);
+    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
 }
 
 /*
@@ -930,7 +916,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    build_spcr(tables_blob, tables->linker, vms);
+    spcr_setup(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_dbg2(tables_blob, tables->linker, vms);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 2b42e4192b..0e6e82b339 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -90,6 +90,39 @@ typedef struct AcpiFadtData {
     unsigned *xdsdt_tbl_offset;
 } AcpiFadtData;
 
+typedef struct AcpiGas {
+    uint8_t id;                /* Address space ID */
+    uint8_t width;             /* Register bit width */
+    uint8_t offset;            /* Register bit offset */
+    uint8_t size;              /* Access size */
+    uint64_t addr;             /* Address */
+} AcpiGas;
+
+/* SPCR (Serial Port Console Redirection table) */
+typedef struct AcpiSpcrData {
+    uint8_t interface_type;
+    uint8_t reserved[3];
+    struct AcpiGas base_addr;
+    uint8_t interrupt_type;
+    uint8_t pc_interrupt;
+    uint32_t interrupt;        /* Global system interrupt */
+    uint8_t baud_rate;
+    uint8_t parity;
+    uint8_t stop_bits;
+    uint8_t flow_control;
+    uint8_t terminal_type;
+    uint8_t language;
+    uint8_t reserved1;
+    uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
+    uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
+    uint8_t pci_bus;
+    uint8_t pci_device;
+    uint8_t pci_function;
+    uint32_t pci_flags;
+    uint8_t pci_segment;
+    uint32_t reserved2;
+} AcpiSpcrData;
+
 #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
 #define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
 
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index ff2a310270..a3784155cb 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -497,4 +497,8 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
 
 void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
                 const char *oem_id, const char *oem_table_id);
+
+void build_spcr(GArray *table_data, BIOSLinker *linker,
+                const AcpiSpcrData *f, const uint8_t rev,
+                const char *oem_id, const char *oem_table_id);
 #endif
-- 
2.34.1


