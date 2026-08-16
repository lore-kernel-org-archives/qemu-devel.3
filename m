Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FEBC5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvain-0001yR-EW; Sun, 16 Aug 2026 09:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiO-0001jW-LS; Sun, 16 Aug 2026 09:15:58 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiL-0005Xo-Jx; Sun, 16 Aug 2026 09:15:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCd73n0Iy/igWu6OLCPnPheU/5DSQQbPF4KqRW1XSOkXr7IXhbgJxe1oumQXlVoCx7X3qx3yWuunm3qARJ72ujQvbif6H6gTG3FZvz+I4g8V4EiS6mO2yfxyxbGG/uZf5jVY8qZVd34aHMfl2VECx6s/ttwhaISlHZMNMLdgwn9d2HkP0xj79n8d8eJ2oQCzBfJxrSx0mv9TTB2LXdUGlesLklCMgkpEpF2TnwOuKnsTquXMcfV+ci/n0bq3otl6iDTYhUlFlU/zSv3zzcxxv6K/K6ero82mBdHmA557Mxlyjxk6+PxJqUK38+slHKgVMAOr+7QiG1xvlJR7vZ2DJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCloJA4i+CtVVm/CnNR/Po1XMCOFdQThUaaLU/sd+RY=;
 b=siNjuZFIAj6i8IxW7KV5naMCIu7Utv33aCNlm4iWTXavuIvnDz5Hu55H5/CQHSr4MxQdIXVaBgWFfbbyISz7mjbYf9gEaQZCztzSqHO9Ud1bu9fHNpeDiXCgt+kbNHTSiPvu0mEa4T2RQYcJegzi+QDvBBwnM5lqU8DMuhwL6hkyykxBGM+EWPDQZNIG+axerXbtbDq0lnFUtFYSOwprhp8FYR/WJy0A7rm7MVuJZrAgF+eK4P26l2NpeXEDKyXFjaGOc50jspOc3c3zJh78XqOn4e5Yhf5rIA/eYYGX2nP8q5wws1GU/dFvugvvjS7hA+cq8DQwLAYLzt8pmCJmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCloJA4i+CtVVm/CnNR/Po1XMCOFdQThUaaLU/sd+RY=;
 b=eHvFFnuoeULrqfj9z5xdj7lT686y00+mfCuvJDOcaDtQgrb+7h9nwJGk/BnjXU6NdHTS8ktw3Thbx7HGYexxJY9Ddr/LweeXlwJ8GP4Ra7LBk/RLO/EqPElsZ1ST3eVXw1py27qcNTcXtu1mYK/mxsIs/vYdL3ezr7HHoAYDYwoe0PS2MZLyQVsvQzzRQtLigvdppHn4Sn9QqTxBV46aS5eBsGLtreAt8syWLSjG86tsPVCnCbg7Xha4ry0Q7FPe/JZjkv8xe5rZ0icjfBPp5CQeouGmXlYs5M5E/WhEntcZGHi6M1xji+Aevm/eemUNb6kiLQCTVgoT2WVaPA5OFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5475.apcprd02.prod.outlook.com (2603:1096:400:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:39 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:39 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 17/20] hw/arm: realview: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:47 +0800
Message-ID: <20260816131300.51799-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816131300.51799-1-bin.meng@processmission.com>
References: <20260816131300.51799-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e6f16d-9359-41f0-3cc7-08defb98774e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hpdtHqQN/x5N8VObzdvPntLvS+9vkOVMiSjTqgn6ANFuo2Eo7qWWYDmIrTFnO/MFbqFnaGPBPHbDrVfWdpqCizilFK5f0Tyru5FcAaRrZzd0EB4x0mjlR24CtJIOGsbB7GoIpm+alvQn+xq5vBz2P9vNVmiBuLFtPZGbGwWgxJeeuNVZjKYYEpdgw1yQ9x2jAxWsbPC76J930WIAz/oK/kdfq6ycPf/vQ6zYczmQl8/o9SaiRh/6BmNYavFfhrPo4Wsk3kRI8cjCM+EiRH8q+k4FqbnHIQyW7SvDmKce8duFJxkrimCOL6BZz82eE0mVFyjH4r6pALZzVRrZdTU1WOA0I9BPMSr/59p434qAgQjPZPich5yLpDAhqb2yIabPQ0Z7rbjnp0RjAHIc3CqybUoak8nAnuj05IZP+ZJ3SRx289p1tW3UBA9pVrXvnQNeOPcophF1Z15L7mx6GyTaTNOxFdU9JadnPu+kQ1pdrjHbsQ9lExXe5QZkb5jZet/4XD7kMbCn0B2V2QDrPmCPpL7gEQTqKsEH/TvioH60iZWTeDsSoi4EfXJZhJVvYy6fETFQeS+dz62T17WVFjVBczUa/jKzPlYOKihVLzJxU3gJUixzln6suttM2QRt+UKgR7CUwCH9EOc8RgJNKy7W8jjwck6/lKlPfPH/AN8LTT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYUb4uiCMqjHrPM3BiZlxoz40PigJe+zuBzweKDCJNyBX3MlzBacQTFIkYrL?=
 =?us-ascii?Q?h8419k5ArlCDfVY41NvLnCjCRhpF0YX6J5bapO2UdD0ef9krQD/d4e8TSBDs?=
 =?us-ascii?Q?284tD4xvqsGt7UB4yO2f1JCP9ulxjNnmWJMZpPZltTrC0vdiUUwbT5ID4BFS?=
 =?us-ascii?Q?jDrp7ucMuE50FP+SmEly9wFnju0XXaoTYRpsviVz/ckgesNBYPVEKSDWjaaU?=
 =?us-ascii?Q?ZiD9rS7QmVLjQ1qAygEmbjmziij515/DpWOqOzVLtJSFoaSAtw+zk4xitBok?=
 =?us-ascii?Q?2FMLjdV+6W9sxSWcegl3w/x1CuivC9YXji8OHPDp549diZquTbbpWb4qWWnF?=
 =?us-ascii?Q?9JHKZNHuKJpdVPJP0lOcXML2LywP0SROycdr8bHQ7cr71dAJpPQsy/XzWkH0?=
 =?us-ascii?Q?chQLtCBdfAyS7V3+RW5l5D99ajz2WRbTpcM/43nvsJ2fa3QD2XUYnTzVH4xL?=
 =?us-ascii?Q?3hp7vWczxVXWWsOisMoRaAMI2COd5JuYitj5ofsOsEZ0Cnaf77zYcEc7mo9i?=
 =?us-ascii?Q?qifE/23O6L7lbR8Qu+8TpZn4ngPjP7ixStYHosJJyTF1VJM9R+TT6XqvefIK?=
 =?us-ascii?Q?DFGJQ9TUARd1cD8099/yQ5sD1y/aRBhlF7Egjqvk/nI/Hj/DZw1rJ7ZNd3/r?=
 =?us-ascii?Q?B4nexg6QM3yO9uIjEdIdDmk40r9EQ359nNLYe2L6XyKCl75ORV8Xk0ZXzrU5?=
 =?us-ascii?Q?XD56je1VhFCkDkyjFKZ0k1LQmd4FYQAbMjvKqSDb6T67PydHw3sKrjdtc9w3?=
 =?us-ascii?Q?Obcyek+D+or/6WmErBC52bpB99L0V3RL6XZJ7M5p32gapYQgN2xWFPtSN2Wq?=
 =?us-ascii?Q?mFJjmwC1WE2mUbl2d3HiNJSLDpekFLpK0qklltbMFnZ2dGB/0oQqNJW4R7J/?=
 =?us-ascii?Q?IJkAKVzNDBJOo+wxN6hTncxNF765l3fgizsSeUEUCxqCTp/PQWyfPvJAh0FC?=
 =?us-ascii?Q?vp2w1WhRcNrLgpiQe8WhM9PpbPHzNv8VaXcs0mlEYGHTbtpcXroJpeI2Luk3?=
 =?us-ascii?Q?Igl0/pYPNOfW0gb932C8O20kLK/Wd51nARwabUQtIWV7IBc3jSpwsevx22Gu?=
 =?us-ascii?Q?MzLFc/cyQjkscggGtIjFfM8ulWz3J23dHVAl5/rCUq1fRgC6LbNBL/azXDm6?=
 =?us-ascii?Q?KLQ/M7odgVrFphnggmv1ezaQpzNq/kIqZjclJikDsxToqHfZxzsJ9cBimNN+?=
 =?us-ascii?Q?Ocawpm6LfVvgF39lW0nomWT9YXUxX1KgVmQSicLNEMg9fR5Fi38WZLAAd6V2?=
 =?us-ascii?Q?juONvkOjmcSQxApASmIg95142y9TZTYzbMVSjUu6Wa4oYsQeLIJ1aNSBfApR?=
 =?us-ascii?Q?qAzu2Ngw0wEarvDlIBufiCRGdG0MB77iAjzRDl69UrLi9mbQ5pgx8qODi+5y?=
 =?us-ascii?Q?lz8mi1+c7Rm8u1ps9LRqd3Ok4m3wjqPXKERwVTiXc9m7nr2vnGpK/l2jCMtn?=
 =?us-ascii?Q?Abc+PPtoxb8m3xPrAgyd/ltpGGlZt0Qz2wh7NVm9FEWAbE78Wo9PyHe1tu6d?=
 =?us-ascii?Q?t6NTW6NZKgEazycpyz52c9LH5i9lcULw9IvHmOgjuFinlx7BkdunMq8Iw3fP?=
 =?us-ascii?Q?1coxtdVx3qwrAMH79cxlb7mgnMXGZaU3gjocd7KTwHTsS16nwAYv6cAjOn0z?=
 =?us-ascii?Q?XJwC1vmSvKnBzwitHfgUGMKxhMU+IzPEFOowVdIaWs+o484akZapmiHFdSfh?=
 =?us-ascii?Q?A0WjwqS8aU6dF5kd0hLtz6Qigz0DatYsI665Klv8E26JhdhkXbLaIKecUcHh?=
 =?us-ascii?Q?BXSBBFxfHCQ5HGI0osICA6ar3luXTcw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e6f16d-9359-41f0-3cc7-08defb98774e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:38.9696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcHVkGzI4aTVIt6frjwuDwbvLLrqKO65Xop6IF5VvWdSZh9Xo2tu0+eODk753R/m3eIpaDEopCq7iT/GrzlKrgnV/a6eqct6FpUc/oi8H+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5475
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Give all four realview machine types the same RealViewMachineState
instance struct and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/realview.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2b9f3271d6..0c2daf5c01 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -39,10 +39,11 @@
 
 /* Board init.  */
 
-static struct arm_boot_info realview_binfo = {
-    .smp_loader_start = SMP_BOOT_ADDR,
-    .smp_bootreg_addr = SMP_BOOTREG_ADDR,
-};
+typedef struct RealViewMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} RealViewMachineState;
 
 /* The following two lists must be consistent.  */
 enum realview_board_type {
@@ -76,6 +77,8 @@ static void split_irq_from_named(DeviceState *src, const char* outname,
 static void realview_init(MachineState *machine,
                           enum realview_board_type board_type)
 {
+    /* All realview-* machines embed the same state as their first member */
+    RealViewMachineState *rvms = (RealViewMachineState *)machine;
     ARMCPU *cpu = NULL;
     CPUARMState *env;
     MemoryRegion *sysmem = get_system_memory();
@@ -202,7 +205,7 @@ static void realview_init(MachineState *machine,
         }
         sysbus_create_varargs("l2x0", periphbase + 0x2000, NULL);
         /* Both A9 and 11MPCore put the GIC CPU i/f at base + 0x100 */
-        realview_binfo.gic_cpu_if_addr = periphbase + 0x100;
+        rvms->bootinfo.gic_cpu_if_addr = periphbase + 0x100;
     } else {
         uint32_t gic_addr = is_pb ? 0x1e000000 : 0x10040000;
         /* For now just create the nIRQ GIC, and ignore the others.  */
@@ -387,10 +390,12 @@ static void realview_init(MachineState *machine,
                            &error_fatal);
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
-    realview_binfo.ram_size = ram_size;
-    realview_binfo.board_id = realview_board_id[board_type];
-    realview_binfo.loader_start = (board_type == BOARD_PB_A8 ? 0x70000000 : 0);
-    arm_load_kernel(cpu, machine, &realview_binfo);
+    rvms->bootinfo.smp_loader_start = SMP_BOOT_ADDR;
+    rvms->bootinfo.smp_bootreg_addr = SMP_BOOTREG_ADDR;
+    rvms->bootinfo.ram_size = ram_size;
+    rvms->bootinfo.board_id = realview_board_id[board_type];
+    rvms->bootinfo.loader_start = board_type == BOARD_PB_A8 ? 0x70000000 : 0;
+    arm_load_kernel(cpu, machine, &rvms->bootinfo);
 }
 
 static void realview_eb_init(MachineState *machine)
@@ -431,6 +436,7 @@ static const TypeInfo realview_eb_type = {
     .name = MACHINE_TYPE_NAME("realview-eb"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -453,6 +459,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -473,6 +480,7 @@ static const TypeInfo realview_pb_a8_type = {
     .name = MACHINE_TYPE_NAME("realview-pb-a8"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -494,6 +502,7 @@ static const TypeInfo realview_pbx_a9_type = {
     .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.53.0


