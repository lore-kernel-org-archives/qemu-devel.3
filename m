Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7A8C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhF-0008D4-Pc; Thu, 13 Aug 2026 11:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhD-0008C0-Mo; Thu, 13 Aug 2026 11:50:19 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhC-0001nZ-Ah; Thu, 13 Aug 2026 11:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EArkJN6Cc2AwrVtIeYbI6sgYZa1Qi8pkqXD3L62mXaem+hOtwvLgBnsdObBloey4KZzKx8nf05JowMm6urBAaDTaiA5RKt+J8iHZoOBeOhO6CRXF2Mj4OeDotuz7omd3tH7dQcYLie1EO4Rxag9G0MLPTZhbkDa7eHbVZJ6Vwtw7pDoLb5O2HpNVKrzKS3DLPp9H7j0m7k9ZL7UlswmBucTQtgzyIJdQIX/FBjZtD2r01DxSReI64mIvnNZQTulBTNd7aSAgL02nSd+MvexKyhWBHthbRDIjw8YBow9klB7KHrJ5/3BC2xG8K6haxa/Ohbpace1c1ZhOlHq35pHkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FItJiPb02XI7Z0vvGUWPXgbyIdGr+JjrEJkCAPDoC34=;
 b=LrUEWZJzd4OQ4aEUfbEjBoNRfzYCgjGgJuPxP2QWavg+xPpIVkWl7Kg+/X30vRkVxWF4EpSQoXqTdjz9FzYH+45zN7rGSv2fS6EN0CUI63gHptXx2HaCqEMf0+L3hjuzvDl4MXiDp5O4T3xdC3vl8E+LARwNibiDjyydmKFUb+d33XHehIr4blMigr0tKMu2r62H9W4Ztl0Ub5S7BdDmUHJlnkPgs+ZpARdJGDh4GgBOpHJtMBtw+dI7vqidONdJIgKo2wiCJUMOMg8Lpi5yBEmeHfct+AVlWrWENP4mEuUZ2h4rigzor504TwxtZMW8nMIobLZWvjRyTyKS6UDbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FItJiPb02XI7Z0vvGUWPXgbyIdGr+JjrEJkCAPDoC34=;
 b=hRhaA40vONAGXLG8hDe3O7XS5c1BYHAYrMrwl42aE7JHCwIIhvoHuRYC6fyyAAs2eXwUeshLD5ZFwuczWRUVCgrbuN729LodVvNxFw2OmymozxnzBWa8jbGej31TyL59ehPWbDjIUNhyK6BJJqCwOAl2V7NpB9Bu+hnjji7yhTGq/UhTg7Y99Y9Jt7gQZnzU8bznwbKlgdGd9aIy8HFXfPenXHOuuyEUPtQBbuRnA+BHZHt1G8dSwFDJsBqEjdkru8RK0xL0VgggxGZAH8mM2jY5XzCImaf+V+QOyCF8jcR92w5kVB6GWuLdcaeNZsTuEJ3p1Rz9wJ+JoGD3pxdXkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:14 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:14 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 04/20] hw/arm: collie: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:48:52 +0800
Message-ID: <20260813154918.996812-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7c8f062-dfb2-4d33-9fed-08def95290cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8MmtAEy4mAmSdyV0QXwCAT2l9ZcE3kW/J1QIaNExkdJQ9kU/qJpLRlGc1u3xgGjbWjxrG8l5ayoLjh1sMgYE01VxPMWYQpztUuBKw7oIjQutCnHjRoO3vX/GVyG3n9cyGbENHxMPSEeLH7nD+5ZPHJgMRopfBkMwDVkjmIBjMlo2E6cg0Q15O57+P0xhew+nwLxv3QJMU8S+hyDYP5Z3N3jBrmhDbwmOBBmtQN/4U9/TlhNEghA79ugpFCVVBqDCNRQaKYE1uaYUfUTN/Llp+8ZSFFep15RAe0OKAyenjvGZ6ofFv+7z7CR8GTvw2VRc4enVRSLxC+a/H5jqvLM28+DpE+Vk0xrba1RLcgcWnpxFFS7kx4LQ38DiKLn7Pwj4Z4mFgKeKue5dNzbpvGR7bRpuU3cOEkh0Hz3OXv3l9PxAvnWekCT13jjyDPQ/DqtbW1r6LoHAaE4WlCtXqmAYNYmMaQq/OT/XwD1haBI+z3LxxKe5LKLyalmpOruhIYZ834UrwS5IJbmZPCQyGSCG8XfXAe1NoIN3gyb6VUu59VaqdoM0kxyLH60K7BwDsIfpX3MiDVcWPn4mIa6HAW40pMoSBSVx4LUjP9Ko1+B2L0hpuegUMTkzkmQwro3mVLiu6Gj9ipoFhBMIV82ziCVkAb+8Ngtacdv39Msv7BQrft8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hS9TRrnTK5Fom5HewXlIKd56JMoWl2NGd55ABf7SXBqFxb1pIdrrfS0NmCXb?=
 =?us-ascii?Q?0jaM3enHfC9UVWP9MoNvBZu38SJuPkozaa2cD4WfIEnsRAhZxF9jVd17FKDs?=
 =?us-ascii?Q?3cDwxDzgDKOicEQY8AptyDB80BdRl9oXIc2mwZoPUKl6OEuIo+J3U5rjXqew?=
 =?us-ascii?Q?R/PJhlXEwtRB7Npn3i+TQ4YMJjt4Kk4G935o3HhNMyL98oLYcuMGqEIiFFMN?=
 =?us-ascii?Q?KWBlQIHBZiv/qKyFGZ9IXnPODGPSOVGMKMH4KkDsov8yXEDSe1z/NxASWKXP?=
 =?us-ascii?Q?8vRxKl/0LbXfYNRnQgCGUYSqalyP4jdWwwQtB0JHAcfMeyGr7UxaNJAwWk6C?=
 =?us-ascii?Q?1qC3SfDP/IByE9VF2YW5u/0zNEW1mnZ53DlNdfyLN+EGR99erQh/7U45ONdI?=
 =?us-ascii?Q?ot/D29+JOcEur3UXQQo+DZyNrWlh3tLFP0TnVtUIqV0pMJNANjZCrtnc4hDU?=
 =?us-ascii?Q?hnXyARxxClBOPfS3S296bwyEt1d0mkOdqpNcZ5lg7W2UrsMpxEPN60Lx9Bfg?=
 =?us-ascii?Q?fEOvEG9W0qqRJYZ9u8LIcM5M4+vV4ae0Bf8O3TIg853EyAZ9LIrMmTjDQx6q?=
 =?us-ascii?Q?PdOkqkAOUAZFTGET4lN3VLlr/lIQ2yYuyHB2g+yq2J3+YTNacntB4lcCMSas?=
 =?us-ascii?Q?ke6D4nxVIUH3fVkK5jyYUM9ZGTacOtHqF+IqEhZYosjWfYR13xaKOoxr+Fgb?=
 =?us-ascii?Q?sQJlRjqtRMVZg/jYb3ZoeQ+qJ0qCsYxzhApyc3F9SL+2/1P1q/kYlHEBkm0w?=
 =?us-ascii?Q?Tx99f86We2jQvNrEla5UgAa1d7RPDoi/ggvClfM8vUJ9an45fgDDVJh9no23?=
 =?us-ascii?Q?FrEgQi6EROqGB9jncjg867ydIvRhoxyjL9WiKUh1OBWFGlAnHgSX5WTFqRaU?=
 =?us-ascii?Q?zrQayHFGx1bv/92KpIrqkDjGI+vbk06fbTjbORaYVMFdC5Gw1hiqoQXgGWeG?=
 =?us-ascii?Q?i0tvYlIBFjXDCblPEWjirJXHJ+VP7faxdeqePWOSRgNG/fE0yQAdbCsWlQ3v?=
 =?us-ascii?Q?nCr0l74ycb7uDSsvncAdtfwI7Jha0Kj/jG9K4V9UVD23b9quatw3JQ/TtocX?=
 =?us-ascii?Q?mvvHFHmm8Np4TUDEQdFqz8UiZXK1GvcRGZqoR9yV/HgyYzoBemytNxkHzppS?=
 =?us-ascii?Q?6d4nlJcPSrVpAMMKDHt+y19BKS1ZxcJ4l96LM/8fO96svBMgy7/MEQMtp2Ru?=
 =?us-ascii?Q?KiV7yAvVIJ3oYef/u1UN3Bf2JOu4K6Z7AKqHQpxT0h1l9f7DPdDPsa5Gsqxc?=
 =?us-ascii?Q?xdcqAJgrhxxHX+svZt9MMXZK8eFPUSZoZUIlzn5B11f6eiIPiTIyMorKXxZh?=
 =?us-ascii?Q?3rZiD6wlz2/sSwYLAPU6zMHsynji8aJRRjX8UIBnJGbc6wTAcz7fDkwyp3NN?=
 =?us-ascii?Q?9tpKKuXIvfBR5JcKo2GdfXcpyzvXp8Efy33KZ/rCMajhkI3IGxf8gSrUh8hQ?=
 =?us-ascii?Q?lsFiP0+Qpimp3FSwMM8/l+sTjY3vxpsTsw8x8jEaLcpku5WedxCqvmJT2ygJ?=
 =?us-ascii?Q?/CSjEEWfqyqAt34wx+ALiEGCLLbbl3gsmGPNytApDrFilrgDSg81fsG5ST8Y?=
 =?us-ascii?Q?t5b/NOys7Zh2Hu9vOzyVkhxqBhAWbPCOTIjmn7YZeAtuivYHVtGRlMCSj1H9?=
 =?us-ascii?Q?0DSefn41K3eTpLLriO37rBOJfhWhZ8Se7Oy20RMMqp5nFc7+Xj26y1wSiJT8?=
 =?us-ascii?Q?l0O2Q5LiVdTQuUK4Dg33YKJhOTEzRs9ccGsErmL9YABPAdms+r3anpNAO/9J?=
 =?us-ascii?Q?hiFMV0ZW1i8wlS7Kxc+Ia9DWDaBnzCk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c8f062-dfb2-4d33-9fed-08def95290cd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:14.6097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKRwL1t/AWb2I2pj4UAhh06fF/gJg3Xmi1BcJYLOAq7c41/QZrxMzZ0UGV8xp5LyGjmSQ/4rDBX+rc7YC2fdIRcdeW9Jznjjfbi/zhrI8OU=
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

Move the boot info into the existing CollieMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/collie.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 91f0a94b6f..2deca04fd0 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -30,16 +30,12 @@ struct CollieMachineState {
     MachineState parent;
 
     StrongARMState *sa1110;
+    struct arm_boot_info bootinfo;
 };
 
 #define TYPE_COLLIE_MACHINE MACHINE_TYPE_NAME("collie")
 OBJECT_DECLARE_SIMPLE_TYPE(CollieMachineState, COLLIE_MACHINE)
 
-static struct arm_boot_info collie_binfo = {
-    .loader_start = SA_SDCS0,
-    .ram_size = RAM_SIZE,
-};
-
 static void collie_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -66,8 +62,12 @@ static void collie_init(MachineState *machine)
 
     sysbus_create_simple("scoop", 0x40800000, NULL);
 
-    collie_binfo.board_id = 0x208;
-    arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
+    cms->bootinfo = (struct arm_boot_info) {
+        .loader_start = SA_SDCS0,
+        .ram_size = RAM_SIZE,
+        .board_id = 0x208,
+    };
+    arm_load_kernel(cms->sa1110->cpu, machine, &cms->bootinfo);
 }
 
 static void collie_machine_class_init(ObjectClass *oc, const void *data)
-- 
2.53.0


