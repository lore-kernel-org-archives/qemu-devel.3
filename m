Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA6AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ai-0005t8-Et; Thu, 03 Sep 2026 07:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ag-0005r6-LM; Thu, 03 Sep 2026 07:26:46 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25af-0006ne-3U; Thu, 03 Sep 2026 07:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utzGos60zYWZyWgJAPaldUyO6E0fG4haP+7Zu4Vg+c6EjmGCnqKglg+Afz/XpyIiZs5M/R0SQBLnJSk6ZNhfoKXeOj7l15QAOKiR6+n7RRQmBmtdAlJ+omkpk6yLeeOJ3/YCwkgxw2CRpONx8xaNt3oZc2oWTFdSreo/j2w3DfdKX56E8QRIRUolxHs1IzAx5gDbW4pyXWfXgj3+CCXUyWPoX6wZiSzvfEIl6ImgHLPDj6Ijxjo0rk8GxmjegraD+csixpfnC5gwSDn8ths7LuWqgx9pgVwfZSaIXf6MAb2BjrYLRDpDXVjPcMyHPlrwauhE6Fl7kqpMkZJCH9yv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWdoXP+CJbEJ2tqJenWq8Kf4jHPhiFZ5BwvvYAAZeJ4=;
 b=WYYPp1L52JAR4vEP/vcgsc+UCvzIJsjV0v4gCVvjb6SiLouvLy3X7fe3WOsl3az8npSiQ15hnCyUTS5N4GlnCO/igdBezVMgzxL1UY6zfC/XkBUEllGQCmqcTgNR4w0MpZ7umqV79BmWcDP4zLNMtRZ9go8TAZZrLKep4l3FUK5RaF5qqPY1X76nWWCkDfXQWPOx6Jt6lAjsSLpcCXavvumAx0xvB7XnSgQ+7nz3fZcCXCUTs37Z06dTnIeXUIsKfsmtlNCVyVncXXElBtWw1otCvHB33VNm4Gxcc3SHnqxeQCAUB25mzzl/lAshcfKV8qNCBOUf0UgIlp4fzAyLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWdoXP+CJbEJ2tqJenWq8Kf4jHPhiFZ5BwvvYAAZeJ4=;
 b=ajk9pOoCPiCfutGfAsucG2YMXnlbhx/6yzFCFTfJXThsaCjiu9Sa5AB35fT+znOzVepoRTgP3skY7eTHYCCx71RH74XBa9dtN/8wGSRKDnT6GMwvJ2HWx1AiIDS4v4jBMKVsGY6pfYAjJ8d8+S6eUVM5B8pUVB0OrXaFHRNivVhDCiKrW7/qeXRtkO4xg+xzBKSC3T3J/kFciafG/jX8Pdre0CCoMfjKaqKb6EQmpMwuZrW+lJeuNNpaVBqDZL/HALYiP6nXVJ8WJr5jUAzP2deG14G+9IKU7k2AC8i1j8dzgDLNbxrK+SFxHrPADNa2Qc4iKkHpBMYvCz4d4kWUKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:35 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:35 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 23/33] hw/arm: phytium: Connect the Phytium E2000 random
 generator
Date: Thu,  3 Sep 2026 19:25:03 +0800
Message-ID: <20260903112532.3276678-24-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e7a9b4-a66f-4af8-2eec-08df09ae3679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: oq11CEs2ggqkF25++idE1wtd7riUQN6/4LIbsjXhr1T+LQIRQgqjd/VAqI2ZBjgq6tPBlESmp5636HPtesIrA/wCAybM9/OwjboXVrn/0ShdNSrHO8+XSp8lxVhw6IlYsSpwgI87fnSbv3T6gyGIKW+HKtLSi89AYX5ApSg/lwj8//DIMiD8jTPcvUAdfbUHhU8j7gLkWX+tSyZXnx/9ENPn5oT7Hruxy3uokJPvtbpXUqpoHt/HACxMehf5THB1AM1O2NeybPz3zFwxeWCkTfHhKffJ4BvPsJrKGgzNufNyu8kzwkpERyiz3IJ5430Nx+EB964MsntVzAD6We1rSOwixAMW+1B9xcDINj07uIlmSEJ6hbX5WMmKNVFC/Tn1iXUUlV/7X/fHZ7bSVjGZH+EQvnb/tvTt4UbuGtHcob2MurqjErjdS2MVgmfDfXa/MguFl5ISOAmLf8XYYuYIKzM5pf2N78ab2MQ69+wW0QFrR6GuilKeqXC9CpwdMv6bhIztSSH7eYxPlohz346ui4LHU7EzGwN2y4a4H7vFeMDu4fZ96/XhHTw9LTjU86DHgUPnRCMGFg3tM/dIsrz5bFD8kYp479ALpZVvXrzqbD35RYs9o6mpHKCtr2itbd21lQiBH09bPyXULte2jRhJfJBtadbWVeT5KGIlFlFMmPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LKs4RL/Po9FUKBdwoGHN07a+B/HArp47ydRMpqHZRvq1/zIHsD9vRKXRywu2?=
 =?us-ascii?Q?cKOlLc1jVScaqFiT6lCSKgqipxGzVhUOoETLIdIFS9NRUM3jToLEoYfFitUs?=
 =?us-ascii?Q?544qA3W1jTVUdK9MXZ3x7WJfga4+2r0bm2LhtG1l+/BIUntrbvCJa9SJktZM?=
 =?us-ascii?Q?lyWRsTNN7E+usFnrHK4ly4Zn5HoCVNCsQZI5wzi1BN+Iddh2HB+SZBvG/2/T?=
 =?us-ascii?Q?gGd2ZN7sY7eK8ogsvT1XUSN/2eGtdqbWY8jpSx5Eb8uKvxq5KVOakbwcBdsf?=
 =?us-ascii?Q?6MMIECj6pOP+7z2N6xU/YlJ8DG8pgHehxMYKpDJU122hnsEliqIVyePlEW/5?=
 =?us-ascii?Q?oGzyawSlEPv16z2rpe/fup1dHRmYpFjrHC8HKQi7ml/iumFxa+TszAl/NnkU?=
 =?us-ascii?Q?YpCBN0n5TgP2GTNA6et3DErMI3h0+jiGsE5GW1wN19bJntURMvgo+DQ2X3Nx?=
 =?us-ascii?Q?lBjDj/Uh8gBtZjDq5LWr2R5Yc7Ki49MN92bFqPav3R/XebHxd6ZCoQuoeGXA?=
 =?us-ascii?Q?S6hhk4+xDg9IUryQSRMcOIfJKAJNKvt8UQJKfUqJcDt3J6UA58oPQDxgqe4B?=
 =?us-ascii?Q?6gVz893WHhCvFnQPTz+Cky220DgppkU+4iNFt8FAdSyQaAbL7iT45u20LVTc?=
 =?us-ascii?Q?32lisCHH3P6Z02oVkkjRzhRNhE5De47ckQe7WSFK0Dt7yP/HfgLWTEROFweY?=
 =?us-ascii?Q?6QxpDE3RuC1UIBw1jmNGx8ts/74BZOOevKiG+KNm/tJP1NJ+z8CRVbYptXjG?=
 =?us-ascii?Q?v/L5t/jTmilqllkKqDiBnwwobojpLIQefuTC36HY+phYHB5iSGB3BhAvIwTf?=
 =?us-ascii?Q?b7KKLMB6bgQ97DapQHf3SqLpryTZVJaXl5lKfFUCWsnlb9YDZZ393UmWbmEO?=
 =?us-ascii?Q?ET3pVhqgYNHPOtXpxjRuwPrro6XjtF7CjB000brK07UQ4b0bH8Z/a1ig9LyG?=
 =?us-ascii?Q?MZothf1zCoK0zb3+aSMUmNr3xci8sNmaBDPBJl+oQOmplNEpjDUOvVSOwXZF?=
 =?us-ascii?Q?bXy4YW+x9gbgUZqJa5m/c16TlIZxivG1Xn4p/CDsP369tTDWqWLjQhjX3dCU?=
 =?us-ascii?Q?4x4APmx4dqLIad1FZdoXVd3+IyUdbxM1WQVSt89uVPnbwjn19mMnaVU9fO2+?=
 =?us-ascii?Q?nR+iYmdFnySvGm6b7xRUHYC94uxeVoFgIDql1bk1xwHWCPBtndTNEjRTrpl0?=
 =?us-ascii?Q?Kqxn8qpFTAaRTTCl7ZOW52OvhLtO2yXujxei1KgXUTYbRfggjp6BiOKEBFCJ?=
 =?us-ascii?Q?MNEbWN4odFMIp94vSf98quylpH+TR+le5lp7eqcbwFvmL96b4vKHkZZfZ55X?=
 =?us-ascii?Q?FV8NG6TquuYlKkaTYkGj1Y0XRqGTlFlka6CNMDwI3ZZB2oT6+YBnZO3YT2eH?=
 =?us-ascii?Q?zXCNWUGtvKgn/+CinciKcVnToSJfineA2rvsphHt570JFVEwT4DCvg6IKEzH?=
 =?us-ascii?Q?ioYN7dvVmCGtQ7dyd8MekDZWHrqSyX5vnzuNLXYM63GwlGTJDXYGQqBoUHAq?=
 =?us-ascii?Q?L8IPxIV8ku1mGI6IzdDourUbl2XceNfpvWduXsHSYiWEQcRAI3NGxcolo4aD?=
 =?us-ascii?Q?8Kf+Bz6aRocJhoBaHDmcbvFWApa/HBrl25AbCktcTO/DkFX8aAe4vTVeCwvp?=
 =?us-ascii?Q?dyveq3xX6pTQMX2AmrBC8E6S2lsf8MP5LqYALxdJP+Z2NN1L1iZQk92beK4e?=
 =?us-ascii?Q?FcryO1HFnUK4+HYA74loIEfVVAFm9nEZTDMvSUjaoM+RCwm8ZbC40OQiYTzp?=
 =?us-ascii?Q?1wMoC3AvBktRfSIClIwVTuwaLeepULo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e7a9b4-a66f-4af8-2eec-08df09ae3679
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:35.4089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1Nzre0lunysz/InVNBkv/sd6ky6gzk0USAxglMjRCnZdHd2qZ+02yVO79aUIAc3axTidNoAnkfRaK7OABJcaDzW5nPNayK8L9UD1CJCjQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Instantiate the RNG in the shared E2000 machine initialization and map
it over the placeholder.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 32c2f23443..5dd91f662b 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -31,6 +31,7 @@
 #include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/phytium_e2000_mhu.h"
 #include "hw/misc/phytium_e2000_pbr.h"
+#include "hw/misc/phytium_e2000_rng.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -97,6 +98,7 @@ enum {
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
     PHYTIUM_E2000_GEM3,
+    PHYTIUM_E2000_RNG_REGS,
     PHYTIUM_E2000_PLATFORM_CTRL,
     PHYTIUM_E2000_SECURITY_CTRL,
     PHYTIUM_E2000_CHIP_CTRL,
@@ -164,6 +166,7 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
     [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
+    [PHYTIUM_E2000_RNG_REGS] =       { 0x32a36000, 0x00001000 },
     [PHYTIUM_E2000_PLATFORM_CTRL] =  { 0x32e40000, 0x00010000 },
     [PHYTIUM_E2000_SECURITY_CTRL] =  { 0x32f00000, 0x00001000 },
     [PHYTIUM_E2000_CHIP_CTRL] =      { 0x33000000, 0x00010000 },
@@ -630,6 +633,17 @@ static void phytium_e2000_create_ddr_status(PhytiumE2000State *s)
     sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_DDR_STATUS_BASE, 2);
 }
 
+static void phytium_e2000_create_rng(PhytiumE2000State *s)
+{
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_RNG);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    object_property_add_child(OBJECT(s), "rng", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0,
+        phytium_e2000_memmap[PHYTIUM_E2000_RNG_REGS].base, 2);
+}
+
 static void phytium_e2000_create_scp_sram(PhytiumE2000State *s)
 {
     /*
@@ -842,6 +856,7 @@ static void phytium_e2000_init(MachineState *ms)
 
     phytium_e2000_create_scp_sram(s);
     phytium_e2000_create_mhu(s);
+    phytium_e2000_create_rng(s);
     phytium_e2000_create_ddr_status(s);
 
     for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
-- 
2.53.0


