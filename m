Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D06C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXi3-0000D1-2T; Thu, 13 Aug 2026 11:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXi1-0000CD-HM; Thu, 13 Aug 2026 11:51:09 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhw-00023y-Qs; Thu, 13 Aug 2026 11:51:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUKfe+ov0PxMQuBqxmZU8fMMhiKXEaurzidGexZ3IeUrBcKN2tVx70bz0gwS7Gzx8pK77a0UFCa1hw4seEr9HWMh/fxiKfar9RGEnLsuS814X930J+3WmF8R+YbfqfX0mtSrcy+Yy09ZqHEfYodaYodDi9HejBkhKPqSY0nsSJYbuj3YUXM4lmTWzBsWlkFWKfYlH1UT4P9xxw1DDmaDLn4kCM3ZputG9aL7e6jfDKADN01BP2lK4b+usRaY9JkHuvk8yXR7qHkvwMg2qhwSEiQHiNnGGLLyVum/7w3DFP62XnFOhDeNQXkTc2uXmqMHmLUElrx25kdnBx8/Oiw+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDvtXfiSonJWrvYeKqpEJNZKMv4iqF2/w8gfqiAqfTQ=;
 b=RbDQWUZeTWQ27Kuwr6DkI61+uSsbYeJsaOWDhjxgNdcRpBSHMCOARZzAtaAQGfmdl4Oyu9R9otEgwY5wViPwAUdrl2zDhOQu8IvtOIGFHBZWvSv4i1GPs1nu6PQqfNj5JhCjNCmNQO16aSlB/WkbU1lm42Oxqr29395B12Mxxo0QtDLuTv85la7o9zf82lJqH7JHNpq/z8HKxdG+k8p45/XPil0ZHUt6mIGtBe4QqD546olHBGfID/9g8QyXxBHrVzAYjrfmPp/9M0V3IUo/1iLzYxvsrmy9SZsIV9BGZlUAPxf1Tr3n6nQwHjdencbCC6p5rgZwUGBIS7VqJ525JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDvtXfiSonJWrvYeKqpEJNZKMv4iqF2/w8gfqiAqfTQ=;
 b=IY+svVhrXZtfq3Gn11W/vnv+F9mU4xRYkTxx8ObhYYMKCvv/eXcXdg25xR6FfKXP/Yn1TcOXrFllr2UsMMRX1IJzWx8kFhZlFxk2fZMoC1xJd8AiEJlivZyzEqJ4cPbIF5WZ4EJw8IVpVkosZfxYaeko5GIPjPl56pUl2T5egAif+ho1KRojZQgZ2TEbsidDOwfkpFf5hdaR/561ZL0X7H4+9izF9OZzhvU8MbrIsAUaLTsyPpVo7d2OGHj5h/tIl5cAU9iHLRZUV8R41TA3ZaCR4LNnX9P5MtBuQmUA4VVIMoGUgCSh0ciY1+4zkQUxPpfqKgF/1LIlxAH6V063CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:50:58 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 15/20] hw/arm: omap_sx1: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:49:03 +0800
Message-ID: <20260813154918.996812-16-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb8057cd-0314-4496-ccb5-08def952aad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2ovVd5SFuVJ81irRjwDmj2VUgwV/X+K1d+Ipj/K2dIkO3XhrhLW65OKwxIE+odjHZ/Nj8E26VU0u1FINjWyeaGrJHFvGYfDY+D8Kz5SPz9PbDNyzWVy4JP139qvZHQLibs3fe/8cbNA50WrETE+vcfrpeCxv/9lJT3t5q8VZPImbYbsXwELtSaAUFwL98QCDduKLykzANyn5AT756rk0kkYCwdCkmCOBgYbw3lxy+S/v17I9seD3c1NMNOxvCu9FAdFTq4uU/lniBQpMPfzGc5ZlFaItkxHJeeL+PaKAAemHHH+kFyxnjOe61s3klIuy2uNmRPcEFiTes+APml8pOaVNS1ZaCedrViXSDbd1XPqbeZPmt/B407rM/v2DWsBx78vim4FxAIG0ABFLWKcI6CHO5aQPd+9HyTCbYlYn6nAYDVFuf51fzTNNMdSPqvtW11KvP8LULI7pf309NpodV1oV/ertA2MxGbrczerTQOvCskkoYZ4bQC59s1SNuIt1Ylcl0znyONK4ezBn5I4VlOcxdSphHLGSA2tIsQfIROQT28fbLN6KdLvDyrTR+TE4fGLnV8FQmmqzq7ZcodoJ/t1q4VhNQ/TFUaxBbehwzCnAlq93yZNwhc4pWhbDG0m7jU5f/a7cTUVR3425RCa/PidK8F/oZWwj62jvbzOHJ5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYXE279NHTiI1C8cxgngTgbIVZb63EJpDg6LETK49htejhs1C8NKfBplbM9J?=
 =?us-ascii?Q?5u0JB0YHMSfO80Vl5rbEmlRcTBO9Ox+L9JZn5BmbOhJVrHy6bjr5kPKKJv3U?=
 =?us-ascii?Q?9BWaQJMebeTDtYSNiC5YNpySqJKC5NZcPHJoLgZHXmP3lhaKdOTraR+2neI+?=
 =?us-ascii?Q?OBbYGhlt7dwy8qRNNvNEH1QME1iPDDEBCD8WTgOT2QXv0K0l+5UMG3ysv5C+?=
 =?us-ascii?Q?mqswTVYVLxfvDcmFoJvzqZFT/IXQopZhYA/eCzPIhl36Ht781myztpPB0BXB?=
 =?us-ascii?Q?dyU/mtcTbJvYY3JqoOl+cXBldv4y7iWXdaNgzEseG2PgmxTxSTB+Fcf8CYPp?=
 =?us-ascii?Q?gew5tyd4cjpLvHL/Ae82dRzRBLzrIgdVlClhIdI2ttJIrpGwp1yfkmpVtT3p?=
 =?us-ascii?Q?SiNtCyHCqhDTbZ705PhODi0SPs9mYugu5Av3NOeF/ciu+5dIFyLFj9SeShev?=
 =?us-ascii?Q?1eDzOMN8eyHYlwMe81r8xrHEPMuAFKaDXa6T4/ZU8lLAKKERgMRztgxflK73?=
 =?us-ascii?Q?Xj5lPRgbRfXm8BnyPcYfzSvPC8jfZJAfN6QXCOVvXLfZtw5nB0dkDFKLmx4d?=
 =?us-ascii?Q?biMwSJO0CmfpEg+K2Vbiv+8DlhB8eAvuGPYr938CIUdSZbtbvQ1ydI/+FikO?=
 =?us-ascii?Q?3+wDs5n7rGNP7Okrue8RUui4xkUDaf1FxPDnSHybqxvn0KYbTZahWtKTf7qH?=
 =?us-ascii?Q?kdrX/z6iHNZXN5UZTeUX4Ogdfn+uH69hMSWEi84xStY7hbcEv9PHrBajx02w?=
 =?us-ascii?Q?+O/tT8AeyFbrE9nBZq59B1gIvPrjzIcoRXe6t6Ye/49n3MxMRvZ33pM9Lj5x?=
 =?us-ascii?Q?A8XYpnFkFqZLHeebaXEdc/9k+dMlZQs5HS21GkoCmdC1EeoatxjLJ2lr72PK?=
 =?us-ascii?Q?j9y1oQztw4AB/siK6qrMtgXI+dOVqQY4FHpymrpnnSCu/3TFXxRo5ci9CTlq?=
 =?us-ascii?Q?iBmfTFf5s38taUmd38m4yTTNTpYlw9gLyguHs4yD1LaxmsA45UmwuxohRw1f?=
 =?us-ascii?Q?ZUpiDOo+fx+0P9q1+mRnj6jVykAWaRjrYXNM5EZbemcPGJE+1Lvjxgfq/SV8?=
 =?us-ascii?Q?SruTHpRL2+MRMqadu+eo3qRs5+OD5bjPfLcjORDr6QPV84qRv6cvadGmIcHw?=
 =?us-ascii?Q?2vxsphGMm0PbtEJ/IkGNnXUH0TW4KMX6z66RXo2BmUZkrUIbpQtHkLEX/BUR?=
 =?us-ascii?Q?FMduX2M0UAUIx0KxxyTzCzh3XtGv5aXMoWoj6z7GMDG02V7Z1VvJ9TeEOCif?=
 =?us-ascii?Q?KhmVxEAwUfac4GI9blhQEF9DGnX22P4ujTrW4eiAU0p68IlIi88NnpgeRfrH?=
 =?us-ascii?Q?+meDUc7whdAf/v3ApuPOJjWTk2tB8NHH6wIVbKxo2/IsI+8O0u4f2LV4Y+P+?=
 =?us-ascii?Q?HSJ+WbGH8UjLEKxL5uKJuch2H4tebA/zOQ89PB9fSW0ppqOkj8Rhzwe1nhpf?=
 =?us-ascii?Q?XS0StV6t1XGG0PqY527XeoTXutTfxa2WwRFF/AetwX5+lAwA+KxC49P84yHg?=
 =?us-ascii?Q?OkgZRH87qn6+cM/0tN0I1m6hrPuteZIub8PvvDwYc25kLbmv8z7PUelearuC?=
 =?us-ascii?Q?iURhgTj8gSMHe9aDM2O64v+8/ZwMGsitR1NR0mqwmZjiENZHvT5oeuRJrSGZ?=
 =?us-ascii?Q?uaaXUBB/qEafcum2YicM4n+mLlssCLe1WTNd+Vu9EisLgDHJJuzSQhZ38RYI?=
 =?us-ascii?Q?1AOuqPgjqYanQP4iFbmpUl8RUYkJ10qzoMPBTBV07G8EYNLXbaTEYDIQOVLS?=
 =?us-ascii?Q?lykJS9nIuXPgXXsMZvDF9PZ8a2kYw7g=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8057cd-0314-4496-ccb5-08def952aad6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:58.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISFtEMwVU5cDmJYVZ86d79tW2tuuy/2jOvyKhmb6mlC3MBIxw1twUXaEUC1e8YEvWQefMFOqT/vK1YDKPeqWCf1oyRALrn1O7niBaf17OXU=
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

Give both the sx1 and sx1-v1 machine types the same Sx1MachineState
instance struct and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/omap_sx1.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index bcb7105323..d60b5cf392 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -91,14 +91,16 @@ static const MemoryRegionOps static_ops = {
 #define FLASH1_SIZE     (8 * MiB)
 #define FLASH2_SIZE     (32 * MiB)
 
-static struct arm_boot_info sx1_binfo = {
-    .loader_start = OMAP_EMIFF_BASE,
-    .ram_size = SDRAM_SIZE,
-    .board_id = 0x265,
-};
+typedef struct Sx1MachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} Sx1MachineState;
 
 static void sx1_init(MachineState *machine, const int version)
 {
+    /* Both sx1 and sx1-v1 embed the same state as their first member */
+    Sx1MachineState *sms = (Sx1MachineState *)machine;
     struct omap_mpu_state_s *mpu;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space = get_system_memory();
@@ -187,7 +189,12 @@ static void sx1_init(MachineState *machine, const int version)
     }
 
     /* Load the kernel.  */
-    arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
+    sms->bootinfo = (struct arm_boot_info) {
+        .loader_start = OMAP_EMIFF_BASE,
+        .ram_size = SDRAM_SIZE,
+        .board_id = 0x265,
+    };
+    arm_load_kernel(mpu->cpu, machine, &sms->bootinfo);
 
     /* TODO: fix next line */
     //~ qemu_console_resize(ds, 640, 480);
@@ -220,6 +227,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .name = MACHINE_TYPE_NAME("sx1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
+    .instance_size = sizeof(Sx1MachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -240,6 +248,7 @@ static const TypeInfo sx1_machine_v1_type = {
     .name = MACHINE_TYPE_NAME("sx1-v1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
+    .instance_size = sizeof(Sx1MachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.53.0


