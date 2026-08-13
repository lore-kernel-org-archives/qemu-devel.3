Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78596C5DF67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhD-0008Bg-4l; Thu, 13 Aug 2026 11:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhB-0008BS-CH; Thu, 13 Aug 2026 11:50:17 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXh9-0001nZ-Rj; Thu, 13 Aug 2026 11:50:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYqHsk2+sh94b/cByZTLrLfavij+q0L1kyHUA1qOWlTTDp5xoRv89On9nh+zqqMdHlcLaFf7qaADOO6vsV5wHHgakgqW26fz8WN+gqONNCMIbrVFFjM1cUcv3UP3bMgGtNAJ8UaRWwv4SW7lfjejM5yQBT1HEpQseSUWRk954cUnz20hWye/z1xKBywulqGyIV/3/ix1/bV1POhj23I92cByL2iLHaSghK/nnlxHXkZwFGBcYCPX1x7ii2g17SrxvSQLvFIGMGFder0ey16sM3hCttIvCykUu+bwMwmxkwIUpDqWkYQzK6qVGb8RlEMeXhJLo9x1/Z2JsuuULDxqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzh/0lrjyIbB2T3UjXiUS2joY+n2qcJ/cqNnKenUYIw=;
 b=ehWeg/6pxdmMO9JBptePf3aoeG8BfcElPzVyhKXtYPOHgl6dVGsbQ4GkNE/lKy3EJPtVtzHU/thyLCj/WiBC5Gi1NrtFNp5M+J4t8EqJ2ZjB8SSo/M572NEgSb2EBhcNaI12LclRXb/C7CsEnoHtFwO4JCFNzCE//yqWYV+Qcj/Cstc5b9eshySF6laSuVGMP7nJlG5CSaNEbnDftCQ+5JhawqAjRTsCNeoJpbSbZMUFUag0d+NMejYg6QUkG4cqAdEmSepfVcCvftMAXX0m2qfN++HP7geidXw4k9OcvTWfl68aC1fXyBf5ZwFtuawB+Eh9/0S6lZxxwFXyiUSf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzh/0lrjyIbB2T3UjXiUS2joY+n2qcJ/cqNnKenUYIw=;
 b=IT66SYeFyForNBBum2Bc8yFOoKOAb2v9RI9P9HomcDfBynwDvJ5DZASaX7+CFVau+bx22OlTNO5y3wmEN3B0cwpm1POVHrlObRuxpz8MJLS9JZ0NAs9w+neKDl6jHSqx3dfnzGRZrdpXhYfSqohE7781PKo58mg6ycLQ1kiaNasWALk3vU3/Dp4DysLZIxrC3g0rx89VNX7dJqfkn1cJwzzKD0b0Wu9CAurd9Ap8xj0tpejcxHewwFFA78/gMFKI4OPAamawnaJiBxtlU+cH12cAhJ9jzpRNbgw9kEL2nW1nIBlfh0SxOUgXhXuIKA49jJxnOh/nmwVEmDhOsfkcPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:11 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:11 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 03/20] hw/arm: bananapi_m2u: Store boot info in the machine
 state
Date: Thu, 13 Aug 2026 23:48:51 +0800
Message-ID: <20260813154918.996812-4-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SI2PR02MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 0deae7c8-5de3-4d17-d84e-08def9528ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qgfYnCG+uOmhaOL0UjY0PlO8XIG+u6p/ZhFc/SdEbYtiahxX5qpwm3IPkLXn1g4nLaKH8sA8+ZKtjuujwUBN/2MQlkxa2Rp0OOypYNp08e5hfY92A7N+9di6tHIxlMmdqMtvsng8qzS4t9ElcQizLRlI5DpnKvqpTAtVEo8Cx+vRFItVYqeKkn8TAfzuNB6V0x/OJ42YYpD2J1OnO3D0HxM+cNlmgsfxIDPmMwUBUNc91JRF8as+0iN+XA59J64HJY7u09dO95xByPpSr+9O8fw9+ZT+CEeEPxRT+ZIh0hzh0LbjkqE1MMsraqHTFGRjoIecf+8gX0+yiLXb+n1EyuXLPCP5rF1MWJOiJZQ7x4Ck3DQrmUjxn7lIRVLBqZl9n0K9Mpf8u/+mSop+HfzLx3QNmC8na+g2VvwdKiAG+puwbILzzuUoVkBHuyVie/jrtD6a71NQMqMHjuwKfbPoB9socdAGIdcZwokWR5/p60wkHGWfnGbptybhh1M7171k/IkXfc1XjmEa3LEEu8BxKgbtD90KzOMQd9hipF+O78QK0kvs01reU/yFKPsuPzV4mXtZ7zEWYhmDYWPGyZRUejRc7AcK298b4pyc8RVPnCzvQS69GRYqMo8lDKm/7OAuqgn/xvZ8Szlt621sLERcc8o826txUyIftps1yhJpP1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q0xoWZ1innZG5yy0lv8+wL0GJyvM3WwmJQIl+wJyLtR9b8iM5QGKBSOhueZr?=
 =?us-ascii?Q?/JINNGtkdlu8zvjh2KOmwRf0u6nrliEz3tYVaIwTl/WUXVxQCbGOMHM7TOW1?=
 =?us-ascii?Q?yCVXmO63BkHkPD+x7ZEA6XAlfk4ByScKjYg+N1fTb2Koh/m7cSbhqI5GdtAf?=
 =?us-ascii?Q?mXnzy8oxubpaTyW/ga/hYKINxq5YA7daJDHqCYu3aNWkXeo+Snec8Obo+hxv?=
 =?us-ascii?Q?9pOj7Zc1ekW97n+GGJ1y6hoDiCsFEHZf1QxIsie9gk893NvbeAtRNf+PFZUz?=
 =?us-ascii?Q?64oONRrzoiWE4VucGdkKeN+o3qgnMarkN8tKIC3Qx3wBttvF+0bn0n3gb6lq?=
 =?us-ascii?Q?lwuMlVkobgTSg3o1hGCiE+vN8IjbzATVJ87DvXtnUU9920nnhmMzyyvh6ZrY?=
 =?us-ascii?Q?mLYpcoADmSUXBPfx56u6KHJJd8rSLlUbpDkbrEZufsbfvJNTMMtctvRhqEg3?=
 =?us-ascii?Q?uIhAvPimrrj+TZIFCWSxpuNNxGsU5lO2QF2Gz2fYysQMh9C9yAmFaqP7V21c?=
 =?us-ascii?Q?eljcdA6oukEXs4nc3/0ICc9FT9PT7ZItviI7M1pz5+cVYNqd9hVsLDf42v5+?=
 =?us-ascii?Q?Wq9CZfCcimmS90sfv4N8n98IlMszyqjxJlphGuXqLs0HoIqEum2iWvQ55RAu?=
 =?us-ascii?Q?twDv3BxxKQaEe6FsqhCaToKjByoJS85+OrYDjCe8DBQqrmsLELLK+SVkDAdY?=
 =?us-ascii?Q?dJnODArSOl6vDOHXEXkGlYHoyQSM0TJc48INx9RW9ociZIuwMmHzNPK8wbS3?=
 =?us-ascii?Q?f+FjuEQqLPm3EbMLLnpSu/uMkcOcmFd9Ps/fhJQywkCWxc/JzZFvca1N2/F5?=
 =?us-ascii?Q?yF28Pnrw2yYBLkEU64Qf1kkx44RJx0zWqEqnJj8fRnOh5th2xi0mzO5oSf1L?=
 =?us-ascii?Q?SIhat6IruG/lVz+3opFPdhKxLSD9eqMm7AllbPOaT6v5WulA0NVnNkBwGAR1?=
 =?us-ascii?Q?sdg8GHL/ccE4J2dYr+yiZFfxb4e9/kjYPwKMnH9xTQJG/T+XX9hFicdP3b8P?=
 =?us-ascii?Q?PnS+xhCNKBm8dGI0+n2OK0a09ZYNkW6VowGTa4uhqkJf41/Uvo+oZvEB7oMr?=
 =?us-ascii?Q?QyikqtsOyENCjrTSNuUTY2JH4l3txWbd+VUa0EiPBWOht9NOm1DjF4JyhBTT?=
 =?us-ascii?Q?q+bsNPiBHe+hazj4yPUrm2f+/ttlxXYo68Dh3DBxL1wt/VX3Xccduzl7XLrk?=
 =?us-ascii?Q?2qU69tue+rrTh1q+kIH92g2d7YhwipoaVAX++v/6Wj7hv8tU1lZwweTWNLfK?=
 =?us-ascii?Q?+CAf2QVDGgiCJMrjoeqb7VY7q4Kk075NrgEUnHmBybwfw/iNQcgHLyqicTC+?=
 =?us-ascii?Q?8AC7kVyQIAf6MqM2kxmvBQtgtuCQAA+ha8i8hqNke1Snh/Et+6lCiHsbVEEW?=
 =?us-ascii?Q?32pe06M2J5tt2GTPsjLa8+/+u83gSjiKvtZnRPFwCN1fXE3hS59wzVqpb2pZ?=
 =?us-ascii?Q?4J8ti75pRUTzKhrO8+z2BascmsUrh+9nioYn/LYf4vmtOSlPscm9vssx2bBb?=
 =?us-ascii?Q?pQEz4Zyh0hf9WwrCNk5qOvOU8ar+Z9ryzJHSB9LS5ysL6X8/lJD39HiyQHSl?=
 =?us-ascii?Q?yXXqW44jTJ7mQsi+bCONYrTMnLNWvHgOmP+1mnD0eG0D7jvHq64DwFc4CFBa?=
 =?us-ascii?Q?2kBtVdZbG28z6TyFL+CZqbMRhzmIqdwZQW3pTClYUTqKfw1jNpiximDd0oeL?=
 =?us-ascii?Q?CHzRGTtmDhmCXNssuk11G1OrdJE6fFuwR+BnTFeUZ8P2BMHpL0JjtO+k7hiK?=
 =?us-ascii?Q?tNP6OomKWIwLerh3qeNc6vDxUkhOs1I=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deae7c8-5de3-4d17-d84e-08def9528ea7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:11.0336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwIVCQHEp1GzpB+FlQEENRlauBkmutczxHKkMs0YWdcxq8Ef6NoDZiTegeQqW2FKHgwXKh3Tamx0KvNNcuVfEJJgU16yJIor8Ti+foqoFS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
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

Move it into a new Bpim2uMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/bananapi_m2u.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 9b468cd8ac..4648d915ae 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -29,7 +29,14 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 
-static struct arm_boot_info bpim2u_binfo;
+#define TYPE_BPIM2U_MACHINE MACHINE_TYPE_NAME("bpim2u")
+OBJECT_DECLARE_SIMPLE_TYPE(Bpim2uMachineState, BPIM2U_MACHINE)
+
+struct Bpim2uMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
 
 /*
  * R40 can boot from mmc0 and mmc2, and bpim2u has two mmc interface, one is
@@ -62,6 +69,7 @@ static void mmc_attach_drive(AwR40State *s, AwSdHostState *mmc, int unit,
 
 static void bpim2u_init(MachineState *machine)
 {
+    Bpim2uMachineState *bpms = BPIM2U_MACHINE(machine);
     bool bootroom_loaded = false;
     AwR40State *r40;
     I2CBus *i2c;
@@ -120,14 +128,16 @@ static void bpim2u_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(),
                                 r40->memmap[AW_R40_DEV_SDRAM], machine->ram);
 
-    bpim2u_binfo.loader_start = r40->memmap[AW_R40_DEV_SDRAM];
-    bpim2u_binfo.ram_size = machine->ram_size;
-    bpim2u_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    arm_load_kernel(&r40->cpus[0], machine, &bpim2u_binfo);
+    bpms->bootinfo.loader_start = r40->memmap[AW_R40_DEV_SDRAM];
+    bpms->bootinfo.ram_size = machine->ram_size;
+    bpms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    arm_load_kernel(&r40->cpus[0], machine, &bpms->bootinfo);
 }
 
-static void bpim2u_machine_init(MachineClass *mc)
+static void bpim2u_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
@@ -145,4 +155,17 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("bpim2u", bpim2u_machine_init)
+static const TypeInfo bpim2u_machine_typeinfo = {
+    .name = TYPE_BPIM2U_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = bpim2u_machine_class_init,
+    .instance_size = sizeof(Bpim2uMachineState),
+    .interfaces = arm_machine_interfaces,
+};
+
+static void bpim2u_machine_register_types(void)
+{
+    type_register_static(&bpim2u_machine_typeinfo);
+}
+
+type_init(bpim2u_machine_register_types)
-- 
2.53.0


