Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D7FC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXi5-0000HJ-Ej; Thu, 13 Aug 2026 11:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXi3-0000ET-W8; Thu, 13 Aug 2026 11:51:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXi2-00023y-D8; Thu, 13 Aug 2026 11:51:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOuWSHppVKXHLZCJKPDIGyVrQewa8ybNWePsDsLSstTYQJdqU9SFga8gblDtemz+7P8ZyPxFnGQoK8Vj17/2Vl+jD8G7isn9xN3DDMjSBh+zprn7ul9XR7UvOVluxamcTq7TjBxk3ZC4hA05NEZWD/VYbbpvQ7zeR1bLMlBOd3oo8zKQnbqRIXbBNEy2W10ISG+y/I6s3bevRdO16nOIDfE+KgwtGPPZLynFiSNffW9WjyRlcTyP89RZJJWwV8+o7m5nX9aXDv3LVr/+Nxbteo1hpbrbXW2YTgzw+xwAzkFDTVykCeHtekI3fRg/P0D3s8XTVcdipHmBZ0zZzO5NUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjP6ePO9vPArWf2CSSzFlCq9g97uurX56I4ZNbKeb3A=;
 b=rWT0as3yfPiOSVM83TZk8r/bOyU4dZvz1hViH05hemH8YbYg5JxL69ytgAajKqfEV3FBgeWS0MecxCHN5wtopPEprnxaujpZ2XPfvhRXdcJRqcJWe6Qg2Yg/poEFTL7IpdgNH1+/gROiFgjUipTSHIcDcRV/ToogCZIa5R/A9XQQPe76Vc6RPbmuEMwXXaDrQpiAkWl1WP1uLtUapxdpg6CsiuYc2hnf1xcwp0iobZLeAkAdH32JBUx4+FB02bACIFxV3YKo1Mj45GlwbrAFNiyk/5QxF4VCYESIHgz1XVPrZcANg+KQ4nhnZwuIB03IFINjoijFfFbiOoL45ygMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjP6ePO9vPArWf2CSSzFlCq9g97uurX56I4ZNbKeb3A=;
 b=dDgYPoPlFNv6mdNUi9Vgagj7X5DomKYXx6NmLjfwrcCsi/KNS5zjZvgOXGjSLJN+Jr/iJMfKVw753/iTXNlD8BplnzSsghqdpuIcE8ObLrh6duf/Vfcwt4u147hvfaZqRG56jhkG2kGsQi1wQ8MQ+KVVysPXlQ6wquo15iRkhCyrSI3KOzMsogMU17PG2k43VJHQKYc3G1hInCiXv/P9Dv8ZVtEjFABDkNT4Y8DHEBn9VhEI7rUEehVqvwYe3nuY1J1ktVvxOHu7nnttSUzZwZHmieK4OenF6RtXrh/MrZsfsaMaZc62GGmAJp02MucgSXwSgB2VlPv9zyYYLu/shQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:51:02 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:51:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 16/20] hw/arm: orangepi: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:49:04 +0800
Message-ID: <20260813154918.996812-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 0324ba31-7672-49c8-3f57-08def952ad3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qCNfCWB0vs/G+9z9LaupY5SIpC4X8aiMLRWkUpyN6Xp9EZ8HzebiL6f/ubzFMHK3a3gNVyNFPCtmvmmoDWPs7Yit5xpTMt+zDBU1fF02Tw+ie50EylRCXQi+etAexrOCUyhFtz0Dq8blkWWD+wP/wHXJiIMl3oi7m9LtRanvIn/WHHmsg8Mv2OT5ji0636nmDlxp+EpKI7+dQtSVKfY/s2LT+UDa3E/YrYYme56M3K6q2mwS0jdyudldmJFFfwmTlLrxWzYCHen8vmQtAKzKm6FNXaYnNaPyTRnzb1XrI7OEQKBBrSV5LRGcBcQDg3RFRDW8SlhfcBdZVubpuWNVVVoFzo+t+bLHPvefWlL+Iolp5Q4TxcZ5lKXr1jgAjSYg2PgEVImZm6Y2SutKhDCBku12flt0kWaDEXM13BsACJFqzejHhOjjso8YT81YwBCHz4GWat51g1RFO4LSMJTR08nOLm0ZEGCkuAdoc5TbVU9ZAzGCt/CPSo02n8AXakvBz0aCe0nBcvuzZb9/SxAZ0qaRHLUqgU9b3Nbtu95S+K0Frjrj/zN7gnZOcySzxDl3tmu75UXEevO6ytdm6iA5D8rDznCtX1kVZkDxnD4LYQeGwWIvYrAaIfmuNnHdGYaBV07xlzGfjDFecwkMOL6rGqKKni5DC5ZJMXvCbf1RiAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MG3fo/VzPTYh48mrBXbiLFbbhOyYvHShInOAsIlGAnvV35+dazBf/ISsH31K?=
 =?us-ascii?Q?bpm7MlAvd8lQXccYHPx+0au+aiFj/RbvrWEEhAxxd4Ga/5s6y4nE1xmccTIe?=
 =?us-ascii?Q?VVrlT8XU3qNgLdDs986qlmjwMHnoJmTkbHrOLH7vR5xfWcOGlZNkp9OdqHpU?=
 =?us-ascii?Q?+qs17ieOU2FxXVJS4JYPEp1GSeAuv9FyVPh+tDX1feq+cErwDeDoPPJ2uLoM?=
 =?us-ascii?Q?l9e/8DxWy2oZmqUlSYVjbImVCEDfMBzPsNhSt+iEl06BzQrnnJVbfZBTh6zK?=
 =?us-ascii?Q?kz9illkW6I2av26KJFo0PtjPMCblxDxyhH/8IIi54KMrhF2OwtWHsTLRMZO2?=
 =?us-ascii?Q?XotRiN1Q/iJYUJOGtNHxDnlnOG+AyQX8Ao+XLrEq90elR/FizgTdxy+YHolu?=
 =?us-ascii?Q?OsfNKoUBZJKrJUlnzCKfWCRCSm1AwFQprG6M5Px/X89/+Cn+vCAKwuW/EVNP?=
 =?us-ascii?Q?FHG/b4xycHyCXAvV3LMYfzJu79HlRknCToKeDXxnGUJ7OUEkKERdghZv5Nvi?=
 =?us-ascii?Q?fYX1tI7pN0AqMAL3/x/ruwpMzg2IeNxGul5jikcYct4+15N+u3w5VDz/Glfs?=
 =?us-ascii?Q?Wj1bT0US8ncLydLKYPyvR9xxwmXcO+tuETGsLJLe6ALCSNK8s6zoY8ZGIsMm?=
 =?us-ascii?Q?SDCeYnygB6LvG0Y2EM2k0ighYcuyym/+1lZ3VhCeVAVL1DhV8ylH5cnP9V9e?=
 =?us-ascii?Q?8O+MMDebNZKyIEvtXh/OeHILs389rPhUglgH6iMcmCmXcgqDuW+HLJWBPNGE?=
 =?us-ascii?Q?kXkIv/GRSzeSYwwG/Vh5obGLP1RBDAepjoS0+y1o5C7L0OFkAjnKwvuJ5HND?=
 =?us-ascii?Q?5ENvq2v/PHC4Gabk3cmwhYDTvEIujH6CyD8voAnVRO78rIfSoXOdqV5Aa1Mz?=
 =?us-ascii?Q?c36f56s86eeBYzIyGqhIYdBoGGoN1jCV8ozyPiXF5Hp4KY+UV8eL/dow50JI?=
 =?us-ascii?Q?U7OTgwC1w5OyZgn3cPYzKnnkRp4nz0pfoy3AmsTV/Zo065WkTMYosilYfsx5?=
 =?us-ascii?Q?OlSM14LeOmP83ek+HLqOvYjsXxVxFacjM30+Pwab7fMBP4hW0t4DaXSgKJ/+?=
 =?us-ascii?Q?XgyWwqvb21vvIsMOaU1g4CTMtFlJfXUCKDUoWRwqZa71bVyab3Jc8hT7lADy?=
 =?us-ascii?Q?cHZMxAiiF7aNee4oPIrgz2RTOto8pHAk4qxShVzPhqZDAuQYYL6uZ9DTl9Vq?=
 =?us-ascii?Q?+4hUj4xPOjso8kjvlAlyhdZ0h1y5i7i1fdUgGkRwoSLvNUgrXCCcT/N0rdGB?=
 =?us-ascii?Q?5DQJRqeOEHfS9RE7A7PiaoggCu2FNp5X8+kNFsezsgJvjUdf04ftDIWqTYxg?=
 =?us-ascii?Q?pCCbCmVCze2T4IZI6922LqL5NXQ/qnrY5Q+tA6shGlCvLLw6KCgJc2s+lE88?=
 =?us-ascii?Q?AhoizTupjCM4tJ6LYQJCaUEWUK6Ui9AuazMHTfoUQELY3Thxwcx8IF0KW03z?=
 =?us-ascii?Q?+WGLoBYsVIdVXmTQvGdIBwBYW3P/awKOh90G1huufY5VCtSL+AISNJG6by0B?=
 =?us-ascii?Q?S/z42jF+nRdLbSJNSNTgjxhmz67PDgN8HLFM/4BftTsOd8Vf4z6XGcEDulXD?=
 =?us-ascii?Q?12Ood/eYGfeLX28FEW0ND4oZV/l67LnnI0c1F+ijT0Qx8GI5ZSaR0BX3z/5l?=
 =?us-ascii?Q?Xk7ttRMmEtNA4VxLod63PNw3IHFlJ0VMJm/tNH+lCqsOhK6sr9Zw4M+v2+ly?=
 =?us-ascii?Q?WXST84xP3nvUdL65jcvtL1vH36ueQsFDBNj9gUpaIikBvyXgaAOTl90raeeR?=
 =?us-ascii?Q?Ai3YK8MmBXgRKHYxXqb5iLxN/S+tkRI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0324ba31-7672-49c8-3f57-08def952ad3e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:51:02.3307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHMJKvnl5+eXw9CDSTIkxBOPiCdPuy2SyDs8o3pMIkC1+3OdVXB5v0znNhRDCun1jLvkmqy2yHsaZt68xIurvVoX7KMze70HZGcE0n4ZRVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7537
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move it into a new OrangePiMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/orangepi.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d84443bb7b..5b2c13f364 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -28,10 +28,18 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 
-static struct arm_boot_info orangepi_binfo;
+#define TYPE_ORANGEPI_MACHINE MACHINE_TYPE_NAME("orangepi-pc")
+OBJECT_DECLARE_SIMPLE_TYPE(OrangePiMachineState, ORANGEPI_MACHINE)
+
+struct OrangePiMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
 
 static void orangepi_init(MachineState *machine)
 {
+    OrangePiMachineState *opms = ORANGEPI_MACHINE(machine);
     AwH3State *h3;
     DriveInfo *di;
     BlockBackend *blk;
@@ -98,14 +106,16 @@ static void orangepi_init(MachineState *machine)
         /* Use Boot ROM to copy data from SD card to SRAM */
         allwinner_h3_bootrom_setup(h3, blk);
     }
-    orangepi_binfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
-    orangepi_binfo.ram_size = machine->ram_size;
-    orangepi_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    arm_load_kernel(&h3->cpus[0], machine, &orangepi_binfo);
+    opms->bootinfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
+    opms->bootinfo.ram_size = machine->ram_size;
+    opms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    arm_load_kernel(&h3->cpus[0], machine, &opms->bootinfo);
 }
 
-static void orangepi_machine_init(MachineClass *mc)
+static void orangepi_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
@@ -125,4 +135,17 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("orangepi-pc", orangepi_machine_init)
+static const TypeInfo orangepi_machine_typeinfo = {
+    .name = TYPE_ORANGEPI_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = orangepi_machine_class_init,
+    .instance_size = sizeof(OrangePiMachineState),
+    .interfaces = arm_machine_interfaces,
+};
+
+static void orangepi_machine_register_types(void)
+{
+    type_register_static(&orangepi_machine_typeinfo);
+}
+
+type_init(orangepi_machine_register_types)
-- 
2.53.0


