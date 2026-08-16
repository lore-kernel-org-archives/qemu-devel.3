Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E2DC5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvai7-0001b2-At; Sun, 16 Aug 2026 09:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahw-0001VP-N4; Sun, 16 Aug 2026 09:15:25 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahv-0005TH-4h; Sun, 16 Aug 2026 09:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvogUJRkx9dtvtSNjFFEz0Hx2IV7v15b/d+n4JjA47u7vH//py6bd4Wc0TB2Omj2AWB9yasq1foH5SWzvUWWMG5mIf8NlU906wznJDxIQGLtDj4hbVVjXQtJXggIzbAGhk+gQ/GtZi+Xu7lExgM/IJIxiN9yXpI1lELAKjyAi476JDp1KfbWXeEav5PUrd6NrV9hd6qnUB39iXj9zz1PtJ4uDHS500fEl7Pc1WSDDeGGqeZhAWgdBSGQZqOij1+iwJmQdpoaIrya55Ijhi6yR/G7T9s8s8aoky0BR06QvDOV+8PKmdwhyRP/Z6mz0j4+AgHzozyB+NxJhR6VprfDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvjDluv1fq2pHbYvZH/0ca0W/EpPWDzvdRukuJyCuqQ=;
 b=q5iq3eFydwvj6IoUec5cHKhUG9Tjqu8v1P5lquH/Xgoszd4DiZP50RqqV1BtLp5BVPyY2oNyyu/+RY596+NSzTYJ9ESunXEtFwUZByasinnGsksQFcUn4yFUkGajUTfhTyiY1kid9RXkq/qomJpMxq/yE0TaM6NGUfhwkxeL6nRf7uugKaLKZGp0gn0Zsg8EpQ4bO00l4T9tdyxmCwi0pIDXeOiSgUyS+5zKfHiCXeWJg/mQgQrB5TX/EGRWq6SC0qeqIBJesVQj+ygYpZRQhao6pNjSj77XJb8pZuprNBUNNznSXodJYrE1n2KDmAXx/ayP5ctcXOg0Xm/cOX4jtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvjDluv1fq2pHbYvZH/0ca0W/EpPWDzvdRukuJyCuqQ=;
 b=IBWiYpjgJASETSBJiQjuYf++7/rVRSIiiy8nsVy2NVu6kolS+nvtxQ7LZAyOVSGI1j/s0lBlhmxseUuS3Mpv3B+grfR+e6kj5K81hf91Nz8GoSD9Tz37t+LNISBLIPGBHUpgA+Zm40u4QPggIPmewSNJpI/Q9JK194+eep36KdTQT00V/AW3QVdW98Nf6BD6VZmPK2C8ZmZIw8vV2DmlLEm9rkCk86AXsjIBhc5JWcF9hw3I3MbnFSq22YFZ7Bh9BHcAjWDgg/duVWv9EnYuup+PmG3f0I10d7QwWjM0aTRmSCyDZ+RS0T/9R0wlroGrEFBZNd2z8EcqGGDMs+aOTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:13 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 03/20] hw/arm: bananapi_m2u: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:33 +0800
Message-ID: <20260816131300.51799-4-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a27f29-0859-4ced-a737-08defb986816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8OCFWXD8cqqaEUe+0T2FLJrcngJaD3jZySaWNSJn0WMRwhR/NcGOhwQLkw8deHn4np4lX+9dnnbVMuZipCNq2IUTFTll1mVqt+SNlnOv6obaI+5+MhBg0pI39O7es8vPhsErG+6nNbPlXmd3tOtpp50NyZyXkSsG0p2PEDeHzU9+aVk4BUcW166K2o5wF/EhDCPQnymsUUU96WHwhFeb0OQrE+wcuVszgtZO5vSvrreqBDBhEr8p/weQFyd9HvvZd4EhKwzbCnR9PFKT30Q3v2pB3QJz/U8RiEIWbpINBtxR4GaEuzDE16NK+fehYtms56IyGnFTFLHXnFc16E6zhRKZLI5VPz60SNxVGMspBJD0HdF4tIxrEh737UAgDKUVKfzVc0nL6wnPXXj2Lp+A6ANfg+2NpunQ0xiWBiShThjoBB1xe9tmgWfUlgeYaC6xKl4mdZnWeMSCCzsCRUcaccEgiZVK2D0hn66Q7IQPfQ+I9DQY7pf3LqbHfUkIelsk6yhJGEQbazXuC1zqPbYmpGm81HSl5w+OF7ttEq5k215oGu7FYMUFwLgGgjQsybcAklJWsyxXu07X36a/TYssH8MoIShph5LJZGyISOrIPMZsyWqTvXdgLtRoLYWxl4HxHNTO088NI2g36DxKhUoMq3nUEvrHt/RQUmkN8Uxw0as=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhpIjWZQPaQd9g7s4GCVFnezWtq2Tcj2aceUS4/8tf/i7hxsvPPQ4ayEvBMU?=
 =?us-ascii?Q?JysdJV0S0oo/ukvAUikBYx9AZ4pytlEPygYiK9kvjpxhinCp5GIv1VS7NR4X?=
 =?us-ascii?Q?6AlXAu48FNMDGvyrTCIlofPvCpraNa/a8MDiN15WQOmrmYerfOmzNxQdTSg+?=
 =?us-ascii?Q?RnJ3YKvYdf/w/t+vuvttQ9F+teOTLN/pzaRoh+urhce/RoT2c7UreADvAekK?=
 =?us-ascii?Q?NSlr0Pt39vbvGNlL5xAZeZKNql6uBOKsXwQ4i8W4BODIzG0Em25JpCD4/6XX?=
 =?us-ascii?Q?sJ1RfM9wp6MeuSBUKysE/eAJPbctZTUv5CmG0SLtvz0sAIpSCrvMj9+0PvEJ?=
 =?us-ascii?Q?epeQddbS6i5KoVljh2oiaJg5zlegdm1hvVpPwTSwe7duZUcPWBzwGxy8g1ZD?=
 =?us-ascii?Q?uH53laKZ+D4CckQ6D/7QsQwct+jaFPrK7Uxe1CTekDWvjktqfM/u7aJ559ET?=
 =?us-ascii?Q?3ifKgqEyFJy3jQucoHsjnUfHxVcz95ygUtGsWPvKEfded55PldSwymWv5IpK?=
 =?us-ascii?Q?2ejld5aENQMcQJrF0r1EuYWOKQAqVeLRdtV8ZbKO2QHfMZldkyqXtCXVH1M0?=
 =?us-ascii?Q?gNhDz/BqKrrYFcZfNCQe/jXImjPyojlEcrJ7QGWZWMpQeR71PPeZ+vUH8+hD?=
 =?us-ascii?Q?jVr7zni35XLF66Eutq7CLiooff6+HZMjkUJqqdq4jm+tfZEGxh+bjwzzG9vO?=
 =?us-ascii?Q?aB3FPthFYEMs6E5BsppZbcjqwHPpBaIBHBtkSRwkK8Mj5DriKCgHb+TIp9SA?=
 =?us-ascii?Q?7CxyPYl4EFmwL5638XtJdYVMgmSU3kxue7XM2NLmcB7Sz3NxxNw2fny84+fT?=
 =?us-ascii?Q?mCd1llOjlif6j9+0KmfNMAhVnYqgCnQU4Cx2ZIMuMF6ZPNm6Ob/wivsOrQbI?=
 =?us-ascii?Q?FTLC8ahYjxcGvIommLq+Uzgtoe+S1B+Sf88Spu6PphsxD2YcmnMg4fX3wN9Y?=
 =?us-ascii?Q?DiPtDcOJGIknA/Q5SBvpHF7NmIHUFyrXhzMjjWcLBvN80thfsTjj/Edw8Yp4?=
 =?us-ascii?Q?eoetDBM2Pt50DeA/wpZ3aYlJnYnmnPaZbTxiDmKrkqqKprl1T9uIg7rqjGpw?=
 =?us-ascii?Q?UVfjnA6RZ+wlRP0kJrxTqALXF/a6owKUDzEBfuNk+fN9FwEqRO6bBCiohGt0?=
 =?us-ascii?Q?bW5IotTFYsUmn+DWyzMAwniNGOLQbIiDromVpHh5TXvyRNXIEhJzbRGdYQHW?=
 =?us-ascii?Q?cTmDVskp1ymT1c1uOSFz0o4Vht7BHcVGOtq1JoU0xl9mp2R1pon8E534L1KN?=
 =?us-ascii?Q?5N8ubG9J5F+LBKq6CIc7bPMF39RNxiR/aPggautmCYvwdFqDL9gEcLpmDCvw?=
 =?us-ascii?Q?PGLwSShV5Xyn3ee03B3rTx8GuHv3EHYobdXnLW3nVDbiqCZXeKOkrUOkZ/jY?=
 =?us-ascii?Q?SSnhxU3LA2PmDIIyFmExEMtPz36Lk22BccpMEIMhWNXM6d3IYmaexXqLvRtV?=
 =?us-ascii?Q?rIO1oMFZzJWkVdl7wHUwFx1gzJ+2zGSwn3zaf+nuRPEaA+VOrTx0OLngBiwo?=
 =?us-ascii?Q?C4hT+ek06ktfJjq08NOBFBlLApA2oWL+OBbY49b//f+44mStCm1uz0lt9As3?=
 =?us-ascii?Q?5cIZJOHsPPrmYGpuZep2/HwZgypdsabNrlTQEWSaNlcF1mWjcSW8cBSPfXf2?=
 =?us-ascii?Q?5pH4U+InxaSvzME8s1K1JYOP94TS4IBsOwAkx3k2+9btRzQzql0hfEeN85WA?=
 =?us-ascii?Q?idWWBBbzHAs/kJpBstL1ZLgLTBaZ5jKG9YVq5ymhD1fAreonUGL6axy86WM9?=
 =?us-ascii?Q?tDkt1mINk8QGGh3yj4OsfQC1DKRElmg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a27f29-0859-4ced-a737-08defb986816
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:13.4389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Amhp3YAt+1a1SyvHZvvBkR2bsYXp8StMfPj8rKy2UAj65N6tNdiUijGLyD5+tkDJjxLyY4CNdG6345UKxWIxgAmucUdo5894leVAS/Bh8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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

 hw/arm/bananapi_m2u.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 9b468cd8ac..0079aa1dd2 100644
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
@@ -120,10 +128,10 @@ static void bpim2u_init(MachineState *machine)
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
 
 static void bpim2u_machine_init(MachineClass *mc)
@@ -145,4 +153,5 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("bpim2u", bpim2u_machine_init)
+DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
+                        bpim2u_machine_init, false, arm_machine_interfaces)
-- 
2.53.0


