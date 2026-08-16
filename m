Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75535C5DF76
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaim-0001tQ-0i; Sun, 16 Aug 2026 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiC-0001fw-Rv; Sun, 16 Aug 2026 09:15:41 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiB-0005Tk-0z; Sun, 16 Aug 2026 09:15:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLr3JTSLEOIMXxW+FVu/Rzkv8ZdBE1+dTcFrPNkz4Muc//r0BwiFD9h2tqdh5bHg6Tc4rJ27kd5RcZJ3hlSjtsUClE79QA4mF+0z8rn5vBHDhH4hD7ttdPx0jYmTbdZMwn9qAssz57m257075GmYsCoPubKLeEZW4mG+TFlmvSilMmUNVqXqP/bA2Stiy5XN3aukZIuejRrzwsy2lxuq7HMGPL/WVTKbAqPeNA9UeMpZ30PpPVscKBWHdDaOanMl+Ys77HBMqDCtPYV3mSskVfbkGoSGa0pJE4+M+U/K9JwUtT6cAgd1nX+3GH1ckIfK734zKT720+6Ui99rOvvdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8nKHrbB1EywJy4tcYKX3Z+Za/VhlmUzxEWaL83SYCQ=;
 b=oIBDvApHqUHtWJeiSvpNEyDS9tHknGH4kzVXXuZ3iTpGdYbKYaTyxMqQElVx6OVsVSHl9b1WG+PUTHdc0bCAvVsrbpF6RkmHmwFfAGfxambRtlhEt83JymnsUw+JBf20CGCQo0MdQNFbvwjTmqnRNxjF8zyln/OWImTA7oCFguFMcHRSggT/aM0uSYXA44PjbH+uGJdhwgbmgyZNHpFjR3vxnSTzy2P/gnGvCUWzM8brmp1n0saU0MpN8o5djC8aawaqBKrU+rmM6W9LZq+W/ZGt6hpoKqu5FBCKnh6TVu5RzcOo24miw5uDC7HOa27vNCNm/AYTheJZTnvyf3jEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8nKHrbB1EywJy4tcYKX3Z+Za/VhlmUzxEWaL83SYCQ=;
 b=a+kHSUy8e6FDSdhilJOnBrNL/FRK2DqbEKQ226B2V3vP+H244wGZ54NE7wC3T3DmOQm/DMv9NLWuqZyCzOvdW1Et3TC+wgouUuW3RyKDgEA82wZQWZgt57RZp1dPFf3I/+8wZM2SB/j6fnJMTC9HMdQMrUfJWnzthVx0Yv4tue2ky/vBo6P9l5yhC0lAagcWCiLOozNDU9A0GtzR6UvRXaxkGkJDkLEK3RsOcvOUTDugVwICnxiwlTs8zICoXqOKJ7rQtEUzNM6qFJjl6094l6a9R6dPW7o5wBJz3Pr7vwi+r5QYUO7/syZf/OUDc8VSx2dpWCalGp7IXpv/YEjriw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:33 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 14/20] hw/arm: npcm8xx: Store boot info in the machine state
Date: Sun, 16 Aug 2026 21:12:44 +0800
Message-ID: <20260816131300.51799-15-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: c10b68ab-d2c7-47ba-9c35-08defb98741f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sOb8NAIiaD0MBPrxIx6qgoWHfzvwz6il+OwP2NAQ9wEBf8IsFl2qo7nVk25daqXuKyECOHcZXnXaKFv3GA0uF07plnTJashtFPOe4UXcRlZLWCbh66f/eJ8CZCgic7VeqcsesNDe7hLDI1CR962KO6lxuhdMLz51hIB2wIVSPOl/5sAUW+cuyo3GGXl0y+gtOwyHnWYR9M04JEh17457So4PFGcS70Pf16Z1nYBJ+k3U0/FjjBuaNWZxeee2QbVi2KlgKUoPU5jTTA/5SbkymfgCWVjzUu8OFETVW6lVXQwn8hs4usRrMnk2/VB7gHiFALqvw6LiKe8Yz756fJs4m5yeGzDNbVLUoWx7NUyFmitpaegEyzIzVefqiXDFZOK5IUzSIrAssZZpd67l/R/igYb2ehu6LpjCVYMyALw56vXCyyLF/3a/qyhSr50UoCjHUyVrlQKdSndEdQopv8xH8bYEKh5ABF0IRd+fpsMk0Re1BD+GAJgVrsYQXAdvQEd4RWy7+74vGS63HIi3QypfExYiJVI4+9M0Kgi0bXQ05r2QSuzxNyiQ+2deeYv5+ot3qU4J53OrsgqnzBpNPXOErsBoL6rgYk4ggJjqnq1ASn30iU0A5vVWiWXy3R9+2mKI5KKIyx/taFD34AHvnNg96YkGoqu+/MkpjiIWw4NofJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XiEYtzvK3CjTYgZAlEOeX1lYsWZND8n9b+bb0lb4nDOWsJLqA1nv7FjGUjWW?=
 =?us-ascii?Q?nmUxtORChWMtEiVyDNNuBSXJp58XScBKStSsRC0XFssYtvi+trtjwCKrWFmF?=
 =?us-ascii?Q?iTfVL1R662if/5z0+0sErn3LBycX8xUb5dF19zbrJDsYn+l+jvVuHWyXwueD?=
 =?us-ascii?Q?QnjzGYcT04jwtedUI3re8cz/zDiyUYjakm52BPxIitHGt8FwUvBzvDlJk0ID?=
 =?us-ascii?Q?xv63XIwsH3Y9s/T67TDL4vNeBt1jc8suvMqmBvUjWIl7YG+Ne4plXEDBmyVq?=
 =?us-ascii?Q?ueNhJ8PdNorPSaIcs1atb2tUMWqx9SmL0Nw2cOZ4YBK+dolnexQII+QmIQtA?=
 =?us-ascii?Q?6eAl5fP+CfbdQuRh5fEBifc1RtmcV48wg6FiqiZosMmAYbu8NSkCTJEuU8QK?=
 =?us-ascii?Q?3vKbdrOAsQhq/TEVBjFnTkzQmvKS8Rnw+grxAE9rpNb02aah4u0SAQ1To55g?=
 =?us-ascii?Q?X172ONC5xn7VFGZq7rbhnT1l88JAAUwW2wtFmQcwM+YfiQyaTJR3Ef6eatDi?=
 =?us-ascii?Q?JXJ4mqtJRpoNXg3m+h1Ub8s6Uw8wbKld/u5HyaGhzdL7085t+IFKVafUzlt5?=
 =?us-ascii?Q?znF2K+jVpCu7a7rSBWMLsW/mTzNJ32MKOsPMfoz9KxVfjl1FSGqL4wjmHymk?=
 =?us-ascii?Q?8zxvF2+wcwy+LVsOkRbouQzWP+JqYRk0sdj1awI6aAobk+yOSHnVfQOWxeCi?=
 =?us-ascii?Q?amyEwD2zRAkPQV3IrCbmntChXJSwqAmleuKBeS2ivVA8qjO2xs5CjZ8MIcLz?=
 =?us-ascii?Q?jIpdJUz9spmSMxW0fMDj+mUS99IpYRQdWUCiRCXXmg9oRjpWMGTSE2KhTXd7?=
 =?us-ascii?Q?JGHEf0uWL1Ge+E24ehvHOQ0k7H/W66zMlDUSL1E6wcHwds9MHzomckcwYrN9?=
 =?us-ascii?Q?TToet86duOTf7qLu1rMbQn5BxgrtEVZeC8y/7CK65qmhAU7azkFywxFzA6q0?=
 =?us-ascii?Q?YRJO2FzzTvEhRWE4kxcgqGUpOOyf4VXQpqYUB7SqxY0yYCwicskdCrKh39xQ?=
 =?us-ascii?Q?tkYpJyo1UMllkIzP/hqK6CL5jvwbqYqHFUKYNs4rMSu17KpGoqwHXivM4sds?=
 =?us-ascii?Q?xSQzOjYpfCht1bPlzuQ09JSe9qrWVuG/3FivgVp68qitIIxaCF/r6WFrUwDf?=
 =?us-ascii?Q?xInvXT0xaXDZ2QQcanU4K3fYAFMLSlLw0ryfwo15RR0cmJrD7HLBPCEHwDw2?=
 =?us-ascii?Q?k4Fp73/puiGRGW7nwL04JpFjhVWr2kpkydkSA2wmBjof2igNHQSzYNN1SbCv?=
 =?us-ascii?Q?5FonwyzutbfeB1tu3DF/BYPRo5Odci0q6HLNkm786DjB+vv7hV85sKL8BXj5?=
 =?us-ascii?Q?9Y0v1KI+swrL1as6Uv98LyfQQLs8xC+Q5E/7VU/330hCxk1oE9liAAWMImLY?=
 =?us-ascii?Q?dgBjAR2PH3DoxT61uGbvt2KlKm8KzEzP5tPdAcTGECNKhEb+DYeJtqW1qPS/?=
 =?us-ascii?Q?0QsDsbs9nX4QFx2Zzzn9EbpnmJPa0GhwoDcJRlFeP/dvCmtkKFPZJkmwVBiV?=
 =?us-ascii?Q?sGcQ5bRbOskV1j2Bx/CHtqKMAnO3rF6q3WsIzJwYst1EVXIeQAn6XlZzBmwR?=
 =?us-ascii?Q?wT+/h7Qws8bTtIELlielvfto+LlSfHxGtskxBmx82ufsLjUXnO8FM/OvI40k?=
 =?us-ascii?Q?z5Jwfr8iE4GNKzjTP36ADeuLGN6a38lzoYhOMp8iPgrqJGhl2qshjtUh1X/S?=
 =?us-ascii?Q?E6EhvLGcr0hpRxeE+CWxkMqnU4o71AfXThQwRm+JfBttEyyRkH+pswgVt4Ds?=
 =?us-ascii?Q?k/bXXTeYDKlFLTtz8sHCWrZ4qfsSpSw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b68ab-d2c7-47ba-9c35-08defb98741f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:33.6365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXJ4H3pke84+th+Z8v6bWJp4uNmHxpwzNxwEwt2MDYETtp85+kcJv0Zrt7NE4Kz5KipSNwaXJTp1hmzVw9yFwHbZ6JMq8Y47IoZQAsJzjEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
rather than to a file scoped static object inside
npcm8xx_load_kernel().

Let the caller own the boot info: the board stores it in its
NPCM8xxMachine and passes it to npcm8xx_load_kernel(), which only
fills in the SoC specific values.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/npcm8xx.c         | 28 +++++++++++++---------------
 hw/arm/npcm8xx_boards.c  |  2 +-
 include/hw/arm/npcm8xx.h | 10 ++++++++--
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 9ce6ea52d9..7d707a09b4 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -357,22 +357,20 @@ static const struct {
     },
 };
 
-static struct arm_boot_info npcm8xx_binfo = {
-    .loader_start           = NPCM8XX_LOADER_START,
-    .smp_loader_start       = NPCM8XX_SMP_LOADER_START,
-    .smp_bootreg_addr       = NPCM8XX_SMP_BOOTREG_ADDR,
-    .gic_cpu_if_addr        = NPCM8XX_GICC_BA,
-    .secure_boot            = false,
-    .board_id               = -1,
-    .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
-    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
-};
-
-void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc)
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc,
+                         struct arm_boot_info *binfo)
 {
-    npcm8xx_binfo.ram_size = machine->ram_size;
-
-    arm_load_kernel(&soc->cpu[0], machine, &npcm8xx_binfo);
+    binfo->loader_start = NPCM8XX_LOADER_START;
+    binfo->smp_loader_start = NPCM8XX_SMP_LOADER_START;
+    binfo->smp_bootreg_addr = NPCM8XX_SMP_BOOTREG_ADDR;
+    binfo->gic_cpu_if_addr = NPCM8XX_GICC_BA;
+    binfo->secure_boot = false;
+    binfo->board_id = -1;
+    binfo->board_setup_addr = NPCM8XX_BOARD_SETUP_ADDR;
+    binfo->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    binfo->ram_size = machine->ram_size;
+
+    arm_load_kernel(&soc->cpu[0], machine, binfo);
 }
 
 static void npcm8xx_init_fuses(NPCM8xxState *s)
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 042a928857..f462369bea 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -198,7 +198,7 @@ static void npcm845_evb_init(MachineState *machine)
     npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm845_evb_i2c_init(soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
-    npcm8xx_load_kernel(machine, soc);
+    npcm8xx_load_kernel(machine, soc, &NPCM8XX_MACHINE(machine)->bootinfo);
 }
 
 static void npcm8xx_set_soc_type(NPCM8xxMachineClass *nmc, const char *type)
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index a8377db490..676c82150d 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -23,6 +23,7 @@
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "hw/mem/npcm7xx_mc.h"
+#include "hw/arm/boot.h"
 #include "hw/misc/npcm_clk.h"
 #include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
@@ -62,6 +63,7 @@ struct NPCM8xxMachine {
      */
     SplitIRQ            fan_splitter[NPCM8XX_NR_PWM_MODULES *
                                      NPCM7XX_PWM_PER_MODULE];
+    struct arm_boot_info bootinfo;
 };
 
 
@@ -122,11 +124,15 @@ OBJECT_DECLARE_TYPE(NPCM8xxState, NPCM8xxClass, NPCM8XX)
  * npcm8xx_load_kernel - Loads memory with everything needed to boot
  * @machine - The machine containing the SoC to be booted.
  * @soc - The SoC containing the CPU to be booted.
+ * @binfo - Caller owned boot info structure to be filled in.
  *
  * This will set up the ARM boot info structure for the specific NPCM8xx
  * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
- * into memory, if requested by the user.
+ * into memory, if requested by the user.  The boot info is owned by the
+ * caller because arm_load_kernel() keeps a pointer to it for the lifetime
+ * of the CPUs.
  */
-void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc);
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc,
+                         struct arm_boot_info *binfo);
 
 #endif /* NPCM8XX_H */
-- 
2.53.0


