Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BF7C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aO-0005fU-PF; Thu, 03 Sep 2026 07:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aM-0005bY-KG; Thu, 03 Sep 2026 07:26:26 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aL-0006k3-3s; Thu, 03 Sep 2026 07:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpgOTuYxTDX/6tTHjZd6rJ+LmxrquAhx0n+m5/NgJR/MQ7Zo9IxmrdaFdIvwagMs4zxyxcpPA8xzUKBhJnAQaCqfd6dpRGkKjtoWXbWcWIG2vAsqdp5dUQ0QmTc0vgTmgMjPWQFMvPFokcqMrMD0RU07KzXEyBdi00VEdSX1Ihk1TbvTWw3BoNyXTXOG7nkFd5z3YTagvFwCZxrhzHwIrd4c34O8MoY5P+1/RmtPyuv9H76Y3bIu9zlXHQ6OIJjyd6+c/ZiuW703TrtfuQpBF9Y5dmxVTcq+3g5sVKSw7ON/oAcV+kukPxcwGFBtLP2uAb/LifLa3DX6Mhi6YeJ0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vCRSG8GvzegJRwVZ/ioclH/rbVjrr98Hmwdsp4KnHQ=;
 b=iC9TrIxRavdLwZNT/Ww/3FKghclzlehU5mWO6nAPoWzKunHSOPaat2YwX2/uHrDysHNVTVxrS/IRQ2wKoRGyOtht2edehTDy5er7SHwuOkRDRo7EPOhlEzMpQLdVwKIv3KRZ5Z8tZO9XmDub8IBsMFOJtQpXH/6bUwohrJ3tJB+A3kFXll8eXtjJ+eW3GhPzZ/EPyOC1pxyUvXIfyy5mMD6DrLJHPSuXSv5ULUK8wDCe00nJ66E8sSxv3m54X6dRW2S7pg/I6+xpxqotpVk+O+m6vLwCx8m25SlO4nqTFlZhcOR+uykrd+rDwETV8MYl8Hemu97kFg6Z9dVW3It9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vCRSG8GvzegJRwVZ/ioclH/rbVjrr98Hmwdsp4KnHQ=;
 b=CgMhkRmJeBBqfXUc4zmULhZ1ClJNC4U78UgNWWEkDo4b7AkjUxE6oKjy+AvkHqKNCgrEy+GchnXNzmqyswdlL9dBNPGoYJOC1a3OP23AmgaejT5Ew50mhBgxkbClaMnAGRJOquF3PDuPa6xz3FYP243fcaIwxSMxdbRYkGzOecfE3Kr4gx+O98B4bOrLyazO5iHhUWh7jCNNWSheDGDucC+K+qz59SCSmFB5E0nyzYfjYkOn3oMNuxwInh8zyALscrwz4W2x1xfj0aphpT+bl1ZT68tbLcz5dSvl60IwDazmdPgc8hlAEhvkEsLwJhIZB9iYRBnmle97nzY185pcKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:19 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:19 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 14/33] hw/arm: phytium: Connect the Phytium E2000 QSPI
 controller
Date: Thu,  3 Sep 2026 19:24:54 +0800
Message-ID: <20260903112532.3276678-15-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd7e1c4c-3741-4878-de6e-08df09ae2ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: H+YdtdzeFVgz7p1VdgskRnu93gZbdQEyk9PVajaRMlwr1ZZ1HfoQWdqyQ2VCBY+4I+MtoBl5BKqn4JlQLWT9/u9p2uILpPYFVy8FGumcb/1fBWi4jQdyMt1C3It3ol4hpHjamKkTVuaSK2VojBovSBnN/Rbm0UvCLwJL/Up+R62hJyH/S61Y2ox6qiZM7Zhx87WE9jDIk+t0IweZOFOt357kNri6OhGN44+Fu8WmsBL6H0+F6eLvE08AeP0l/RAxZozBdY7fgz9+IMO4Wc/kwEiZxCb/ua39toZXyx/9gxciwlM2BxMDVe+gMIdp4rmV6G4Dn9rKEvxpflyIPhs6Dj2kAbVaM3aTJREg6BYKrYdda0u/U6RpQ0ZLHM3z7YD3k1ZjzJ+Ol+2LazVaPc6T0W2fnErwTgk00PdLy0jZWF+jZ7Sl384z84NFqtxdDCfsm4DvEwA5LLPJiMfl0rRYJqbBnSG5qPqzuLwaHLKWirIxXnSUzDRpFwdNZpVmGsMXjzOveZ8JSMs+M+H/NwDRL/PxaN+wiAnn04VGSHCYPPTcoDlp9SgJ6OvJJ1FzyPUrjbaOcntrYU4ZGqtYM7MuCH7fLTjdCXtYEsrZtizWBoyJj6KtK6IW5oTcMm8573Xtqrtuee66sP2sE6V9cHECkXN0LiS4WoR8ghA3qy9GKzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iKEH/rH07M0WjOsJcSmzNCWxWnaJmA7wZW/BqvEJ78SWAVUngav0RPLOSR/V?=
 =?us-ascii?Q?vLs0vVi++ygpGJe5HeZSFCd47OuNP4WwPvln6Wlnh5gUmP0rD7vOegTHD99Y?=
 =?us-ascii?Q?UqX+MHFMIyuKMqGd4tTebgVRBGWdD8S8Nn2Pn6nEhNJmKCIQtdY7p1MnOyMh?=
 =?us-ascii?Q?8uhCC0wwX7bBC9MfD6QgsXz0t2QjBjuWXo0lcZBAdr3zj9ITFeteT33GKdh3?=
 =?us-ascii?Q?xyVfGskbZSjbedb9b19mLlXspQpASXdIBxdTrZSCCespP3ZxSxLGE2+GK3E8?=
 =?us-ascii?Q?j8gCEQbDIiRkh62ktRA0SQWda8A1QzVqHmskGKfBCcePnf8F8a3L1Vo4zN/r?=
 =?us-ascii?Q?PSXxbTJjdePjXJF9D7WpZXClkGA4pQ5lmObZfAJt08GjakqX/0gfdi0aLU5p?=
 =?us-ascii?Q?qcIoEiiXY1sYG+syK3hVBUR+5k9mwPWLPDPiWzXou954rLEiGb3WQG+xyIJu?=
 =?us-ascii?Q?rKs8WAWSZIUXAr70ifdOMdjZxAm8peSUTe/PAs/7x1+uzHdE1+FBG3Er6h5d?=
 =?us-ascii?Q?BO2CBTpbfH9A7yHAyDApTVrW7K7kddTR+AHaQwuGNSOpo9nPEAYuM0pP3QpJ?=
 =?us-ascii?Q?lQxZaNV20+4oTXxtx5dpyAAnK3YFrTTioPp5U8j8nGDLjzRP53VeO6u56YZG?=
 =?us-ascii?Q?erdQ+CaRSiAoAVq4VBxhlaWp6SGyheZMoorZG+it7LZ912DnzmtUQT0MtXcD?=
 =?us-ascii?Q?jD/WWG/HCBuR4jo9fdkqeR/5/6DjnlgT2J7M1cIJYthTckyB7yadLCYpj7HZ?=
 =?us-ascii?Q?Z1vFQqUWeAzParwHP2NdKZPhMt/wkZZubDlIWcFX7assvSJS7JGsjjRNPwPG?=
 =?us-ascii?Q?hyAjtpWkheiegRGQzC8TNmbiWEPmOxxYENDf9VJtH1c4fMU0pXjyUKZsUlAd?=
 =?us-ascii?Q?i05ncyLoa7IVkPkuHaKox1X6H8WFqPtSdzIvf+Q8NL8h40y04xx3pcHH9G0d?=
 =?us-ascii?Q?dtWOgiG9T+CbwSEwuUeWqH8Sq19Yj0HMmklrKvmouAt4YemCFb4FfFV6uKdc?=
 =?us-ascii?Q?8fvc09w8WlTN756tkRawXjiJ5JxhkOzQYkExqVbCamZjosA1mOHQQwSbS9qU?=
 =?us-ascii?Q?HyZFN1Hc+vgBoQjt8BXt9Y+chjOs8M8xh6sXR0wiN4nO0XDJIN5xsrBTpGmm?=
 =?us-ascii?Q?whoeB5rczKjLvwxmBG9T2nkhiXuQTxLfAK/KQdfwyaQBneu2QEj2f1QW4qzC?=
 =?us-ascii?Q?+iONah1R9Po+t69IIf79W7f/TgXQiCsuYhMB3eLFkIsR2A5nO7fZePtbRAPJ?=
 =?us-ascii?Q?B9nXmHkTemxRcMwlaCG0x/0uC3h93C3bjKZdTEp22jIExWIoTuL/Wzs1sttZ?=
 =?us-ascii?Q?vtbRDU/17XsP1oNf2zOhuuvXc6yDgOCC2NIYT85AW8NGYR/ue87/YSVCrV2G?=
 =?us-ascii?Q?oruWoQJT6tTkbvGM6FqxX/Gy9I6m5HYT36Eg7hzQ3gET+47RA0+kEJ22ATpm?=
 =?us-ascii?Q?AzQTKOPLxySEiKdWevuPUgIkIBgywm/WS0wousMy4GiA3AC5AZp94UY6aCcu?=
 =?us-ascii?Q?Pjh4t9bDaZqSvdvWcRFHC/BOQLj+CN9/LDYh0VFVkzc2o/2kiVrsIJQPVauy?=
 =?us-ascii?Q?1Ew71aw3jxNDsCX0TjLkU7XtWPQlI6nBtNFK+M+jnNG4p0OQYW/VihJnhOoX?=
 =?us-ascii?Q?5UaM3+1E7RhKMw+MLvzvR2wmkAoobMvgoMwdj5CpuDyZbh3MmThdD1WPUmAa?=
 =?us-ascii?Q?4KWw0Zvr7acSauQ7ywUz36nP3PCtkS1k8o+wd4s66aSYxyZrI+doHHN2FNBh?=
 =?us-ascii?Q?wZ5RHV98g41Re4tLwhpKsWUggPJt2mw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7e1c4c-3741-4878-de6e-08df09ae2ca5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:18.9305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrUfu1MWWQvX4G9sXODIekY6/SPcCN5JtjtjYKdj5f0wAzgWZHVrPp2Yv9VMdPC06FeMCX/cDcg8E7Zqj69eDdSABdBMXwoHzNy/sW4cjxs=
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

Instantiate QSPI0 at its command and direct-map windows so accesses
from E2000 firmware reach the controller model.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  1 +
 hw/arm/phytium_e2000.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 08128232ca..891d09e86b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -136,6 +136,7 @@ config PHYTIUM_E2000
     select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
+    select PHYTIUM_E2000_QSPI
     select PL011
     select SD
     select UNIMP
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index ff8dd3354b..c6d789bb04 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -33,6 +33,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/sd/phytium_e2000_mci.h"
 #include "hw/sd/sd.h"
+#include "hw/ssi/phytium_qspi.h"
 #include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
@@ -58,9 +59,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000State, PHYTIUM_PI)
 #define PHYTIUM_E2000_GTIMER_HZ       50000000
 
 enum {
+    PHYTIUM_E2000_QSPI_DIRECT,
     PHYTIUM_E2000_LOW_PERIPH,
     PHYTIUM_E2000_MCI0,
     PHYTIUM_E2000_MCI1,
+    PHYTIUM_E2000_QSPI_REGS,
     PHYTIUM_E2000_UART0,
     PHYTIUM_E2000_UART1,
     PHYTIUM_E2000_UART2,
@@ -92,6 +95,7 @@ struct PhytiumE2000State {
     MachineState parent;
     struct arm_boot_info bootinfo;
     DeviceState *gic;
+    DeviceState *qspi;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
     MemoryRegion scp_sram;
@@ -105,9 +109,11 @@ struct PhytiumE2000State {
  * handoff data and IACC is the fixed execution window for system firmware.
  */
 static const MemMapEntry phytium_e2000_memmap[] = {
+    [PHYTIUM_E2000_QSPI_DIRECT] =    { 0x00000000, 0x10000000 },
     [PHYTIUM_E2000_LOW_PERIPH] =     { 0x28000000, 0x00100000 },
     [PHYTIUM_E2000_MCI0] =           { 0x28000000, 0x00001000 },
     [PHYTIUM_E2000_MCI1] =           { 0x28001000, 0x00001000 },
+    [PHYTIUM_E2000_QSPI_REGS] =      { 0x28008000, 0x00001000 },
     [PHYTIUM_E2000_UART0] =          { 0x2800c000, 0x00001000 },
     [PHYTIUM_E2000_UART1] =          { 0x2800d000, 0x00001000 },
     [PHYTIUM_E2000_UART2] =          { 0x2800e000, 0x00001000 },
@@ -453,6 +459,18 @@ static void phytium_e2000_create_mci(PhytiumE2000State *s, int index)
     phytium_e2000_attach_sd_card(DW_MCI(mci), index);
 }
 
+static void phytium_e2000_create_qspi(PhytiumE2000State *s)
+{
+    DeviceState *controller = qdev_new(TYPE_PHYTIUM_E2000_QSPI);
+
+    s->qspi = controller;
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(controller), &error_fatal);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(controller), 0,
+        phytium_e2000_memmap[PHYTIUM_E2000_QSPI_REGS].base, 2);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(controller), 1,
+        phytium_e2000_memmap[PHYTIUM_E2000_QSPI_DIRECT].base, 2);
+}
+
 static void phytium_e2000_create_ddr_status(PhytiumE2000State *s)
 {
     DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_DDR);
@@ -611,6 +629,8 @@ static void phytium_pi_init(MachineState *ms)
     phytium_e2000_create_ram(s);
     phytium_e2000_create_unimplemented();
 
+    phytium_e2000_create_qspi(s);
+
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
-- 
2.53.0


