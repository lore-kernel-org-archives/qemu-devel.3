Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E90C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaio-0001zD-6R; Sun, 16 Aug 2026 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiT-0001jx-53; Sun, 16 Aug 2026 09:16:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiR-0005Xo-LB; Sun, 16 Aug 2026 09:15:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ9qVLOg8z8D9k4qa4kx4nsqaxmj0shMCSOS+XIR+ofjY1s1+GIOtQ3ybtjFG9h0EBbTnozTAbZYpFX3onRREQ/v/R3FQO6AZrX+BYQ2OuogpWtLoKp0cObeFfhgHx+WeWNHrVLod5jdq16VqjKkEoYXuV1ShxxPllEPvhuLIcvzgHUhgyZFTVktaCWibZ6NAPMvO5OMsANl+EIv6MOaMZE19XWujAvrZbjcu1c0l6+D18jJaA4zx5Tdsti9AJFq6zLFm1cBc3XRQuDcI/vhhSAF3Z2Rncv9Cka2mD2lEeCsJ6QPhNXfBaA/rV1xfJqkLI4XZy1HfQMeVXTJ7k+K/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXGQMNH87wIyWu8NNZq1mO1VhHN+s6MFjqExH0RjmBU=;
 b=knB5NHGt7OI3X3HKRUhoE3FYDWDxPT/BT3YAK/FHFYIi2Jy6PO21CTDcs8b9vrYi7wW42UD/7HJ9OyqCyvaheRkf/KhIe5kDmpqicMubTQwztYPxY/JqOhpc0VTHalaWzYXSUw7PrcNz4BJ8H0Vgh3FTUVj6iqiMIhOPZFO2/QU6PvfJeVw4tBBXelqoPIdH8GK3WM+FysL5y8gacoFzoo55aS5zd8jTNgzoiO5hUwBH2vWDCa/nZGdIoeaWMjpoK1LZ9WalMzVNWSgkNdnFoP981OP4/dKE2cCa8zXvZsmliYCFSCu9OCXBGtLU/u+HlnjiFzbxFWMlhycw54dPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXGQMNH87wIyWu8NNZq1mO1VhHN+s6MFjqExH0RjmBU=;
 b=jU86PaMHrEblQnTUdeU8jpQQtBODYed1OgAzZjZUKKM9meX6BeC/07Gk3KTr3BWTVxu9Jx8SHovVTK5etAfpKazGo29dZLyonNTsF1TQ9NW5NLbUnAVo3gdc2Azy82WzD7fTQQdMzqQO1X4xQOXWq++u9MuiAvgLOk3MRComMHsUYyijke+BPV6HcsJ0DUT+y+z0DOgr4OnzS8BsKCzFUWqPr5hxDrpH558Sm1Ktp04ggLTssQzhus1BauqJzSR6tIziQmAfJShInIg+UNIViuSBL5dbgmFpG9JO5B9hr9B5Pf/ldyK4dFyjoUXp0zUG7/XMLaukD/KXwflMg2XlYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5475.apcprd02.prod.outlook.com (2603:1096:400:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:42 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 19/20] hw/arm: versatilepb: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:49 +0800
Message-ID: <20260816131300.51799-20-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3abc333-6cdb-4848-40df-08defb98796c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lWnk3slLiibl9Y0xNW6lOYTxCkEllz7dSruNMzQNxbrtsTxzbfT6XzhauuE9DmaxsoWISgwSw0swqUx9QSBGWRHAtr3BB7LNnUeSXJ/kJQTaZsHVes6NUygsnRVa0VAwrbMph4yuPYEPDUvWW9ArKa8UJkrB+2BB1F8ras56Rwhs3JhitfECVpPdmMalCQYS5DmjS+TUfydB7gvHcSha+ljYjb5hhNImOJ53eBSl+6g12INa8acnXfeBjtI++wNLkmvKkhe7daLaDCUqdZMOD+QN3jCAetYe27eoNsb2/wYeGrxvBctF0ZQj0Be2yzPGusime/y7CDdZfViecdXU8uvCjxKnZI0S1GzJK/6EyNYrWI5NPGxfHgERUbyetrvDZZp/5QmIBs4uRzEmqnhh60f/Sj9lF14/uws/2o98wVnKh2A3QvHyHenDjDQ7SN4hdjm1TBnRRpHZJYV1UNPAF1y5oOv3zuJ/WthFcXyBxNpMvkv63ZEtZYIheXhwqw9brnRVR7/5+irDLm19tcxoAy3yOA52E3DGgs/QGq/E4RKwBKECKDmIzQm5Okq1p1jXIZUJCVLhba2ZquE5mgpNk0xCPAXoBChR8lcf4K2oa3SCSbQ/K/Koq/1OFly7riiUXPYpnFWo+sP3p8dYdP74MW5Q08EntXI+r/VTHFOShCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vM4To2ZRSkt6aZ8k5OoOMNNmup1i/lv9n7AdbItKxurcBi4agg4Otli1SbiB?=
 =?us-ascii?Q?kPuXurJKXkAzU1rWBcic11TgUq0t5pGIOaxJGgFXiqPruV8RBvorijIQ4Ty9?=
 =?us-ascii?Q?HhHeLuCfFKIgyIbu+z497QMSSnYYL/InMnGfymnwoF/+PiLDvD1tpQELaDwC?=
 =?us-ascii?Q?9Cu/F37BLzQpJuoJojeaawhzqDIIkLcsavWtnhIwUuY+/f4BeNIi3wKqq4IN?=
 =?us-ascii?Q?bzf6ywkMaW12r2Px+B3UiiFiVPeSxXKopXvQvDnqU2rNcVk/QEyL8afvSG3/?=
 =?us-ascii?Q?UuZPhB3hBmcA/vjGpCCdOknq6kqlwuWJQUGHJuBpxBpkM3ddvYZcE3g+2qiF?=
 =?us-ascii?Q?GK/QK6eXOEEdJI0sUBD2KnFaXriYgNP/m7AXljRcgj8kt5vJOuY/KD978wMr?=
 =?us-ascii?Q?bTAtuBPws+RJnyipeQ3VQyTLP4O2NoUOxUIQ2QVDR8SUcianOJst2I8AMQpC?=
 =?us-ascii?Q?zBGczbBqmALwQHurXiHW360USsxUNfnoh4LScf6NBMxF2HaRKNoCdATBO42Y?=
 =?us-ascii?Q?62Bbv9zoi9f1r9Ii0YU6JEYFDl0GUyBB06VH85lZnUbjHP/7zaca0ZBM9Wcs?=
 =?us-ascii?Q?x9pkN/N24Y9D7xMoEYDZDW68hqD6xCqsmchlrzRuy9sKP+CNaL0fjO01f+uo?=
 =?us-ascii?Q?2DEUAeGzJwEpSFFZN2CZwTkh2uXH9uta+ny8bnNPbnLXY1IDXFw7aeAu1HWA?=
 =?us-ascii?Q?cHkZqHZOaRfH7bEsyaZr0NMvlvKCu3KQbbim5Kthgtic5CUl/wtufCHUZtA8?=
 =?us-ascii?Q?8jtbGqtgGqT82UvjA9PBzJQs6Bn+EtB55ysrR40N5bQITQwc2ufmR2Dps/aj?=
 =?us-ascii?Q?95iMqc+vq10S0OlsZMPzuDK7nDlz3jbxDtj3rMOSAlphzsq9WQDmJ+PQr5Nk?=
 =?us-ascii?Q?7xho4jMa3/v3JHHhgml/NuHx8OA/BBogtHrfKx0J6mWiVPn8ntIADkpJOwuR?=
 =?us-ascii?Q?hXIAqOJRmPW5zlTT27AaSpNloZ34gIWDOMqwYfARKAhKHoO5wATn28y1F//o?=
 =?us-ascii?Q?3l9W9Buz//gCeQeBibh84Ek1tHKsmnpmrsBxDUeBK7YgcxAXF9mpkEOZIxCv?=
 =?us-ascii?Q?KngObyY6wbj0SN4vh4ddWg0lIAAX9efpBA1L8yTZiOTL4Cr0OC54bM5CA+N6?=
 =?us-ascii?Q?St2/zjifozgPJl+wBYL0ETY/mgCXmnBVjStm+pknjRmKQ/G6k6wDbpK0B5VJ?=
 =?us-ascii?Q?n7gc7JyFPkZzUgDYcM3qPI1ZMFgqYbcXLfBWxjvzxLRm299MwXn66T7ljtFA?=
 =?us-ascii?Q?EEa/O2Ih8IOc961RzwW2r5qlBK5ZM7UqzKaq1hHchJSYy/NW0EbO5QhTnou6?=
 =?us-ascii?Q?IZ/YfPmjGa/58ZECMYmMvrQOGJMRe+2mHB3ldC9HBxwpEsH9Kavf5TxDPxPL?=
 =?us-ascii?Q?M/HRvJMwfdsX0DSzv3P52zEfg2V1WsTR1XflRt2oGBhXECvLJfUUTdANJR6X?=
 =?us-ascii?Q?j3O/5iqbuSvscmML0JLIrKbnAaxUXK00A+QuBXHW0S2qJi4F6YoL4G2ut3rY?=
 =?us-ascii?Q?rMBDITw5op+L7jyo8KoYdxlYrrXqh+cso4gfbdueVgvaajtZWFlq8q18RT4t?=
 =?us-ascii?Q?V94g9D7W9SW3imet8DNmEuSCEEtnviKJ6DUHxBDqVId3wjnFGVHSYdVE70Rt?=
 =?us-ascii?Q?lIm9CgP4YCZfleVvJE7n3kgauj0YYJED+YzeAIXMllDjJfwd9uUZizwTH0FZ?=
 =?us-ascii?Q?fx7Sx+OUNsesoPHSsHxL0iwLOZFBHHQAwx8PJMrGVyZNGnJ00m8hnMy5haFN?=
 =?us-ascii?Q?8Dgxkldff3Qk2FtwVQF5BmPjD2VI/tk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3abc333-6cdb-4848-40df-08defb98796c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:42.5244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zECgjyZSoP6bij6bgk2OiatlCyXqMJiPIbGbg/5r/Fx075dwKJoqBjRxHKRKSvwP1nvEeBzJy9mWYjkqtQ5Ew0GxpC17rSap5eeBT6S1DUU=
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

Give both machine types the same VersatileMachineState instance struct
and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/versatilepb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index c6991a52e6..520af79c80 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -182,10 +182,16 @@ static void vpb_sic_init(Object *obj)
    peripherals and expansion busses.  For now we emulate a subset of the
    PB peripherals and just change the board ID.  */
 
-static struct arm_boot_info versatile_binfo;
+typedef struct VersatileMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} VersatileMachineState;
 
 static void versatile_init(MachineState *machine, int board_id)
 {
+    /* versatilepb and versatileab embed the same state as first member */
+    VersatileMachineState *vms = (VersatileMachineState *)machine;
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *sysmem = get_system_memory();
@@ -397,9 +403,9 @@ static void versatile_init(MachineState *machine, int board_id)
                           VERSATILE_FLASH_SECT_SIZE,
                           4, 0x0089, 0x0018, 0x0000, 0x0, 0);
 
-    versatile_binfo.ram_size = machine->ram_size;
-    versatile_binfo.board_id = board_id;
-    arm_load_kernel(cpu, machine, &versatile_binfo);
+    vms->bootinfo.ram_size = machine->ram_size;
+    vms->bootinfo.board_id = board_id;
+    arm_load_kernel(cpu, machine, &vms->bootinfo);
 }
 
 static void vpb_init(MachineState *machine)
@@ -431,6 +437,7 @@ static const TypeInfo versatilepb_type = {
     .name = MACHINE_TYPE_NAME("versatilepb"),
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
+    .instance_size = sizeof(VersatileMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -453,6 +460,7 @@ static const TypeInfo versatileab_type = {
     .name = MACHINE_TYPE_NAME("versatileab"),
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
+    .instance_size = sizeof(VersatileMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.53.0


