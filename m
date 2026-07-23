Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8653C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDh-0004iB-0d; Thu, 23 Jul 2026 11:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD9-0004C9-6N; Thu, 23 Jul 2026 11:19:48 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD7-00084Z-Dm; Thu, 23 Jul 2026 11:19:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT4HqwCXHvogFGHk3rGx1YrCvQ9NnwkmBKM48t+T+J1J5qrrlYxvMHx5xa+NybBaEfHnWxLrdk7rBC4HthEEZ5d8r0c18T4+GqzTsLsfsk/taeskBtCdK3fq2OdkXtf5GuRUBriJLEVWWkhcoJXckoAVVScmJa8llhtCaA7Ba1z90M/QoCa28A+ceOgrmtPoDTpDvHKBVFViczkIb9Ze224emX6IfdJpvsT6KpEHRrL0sXHFwJ8FaA6jmjvosEDyzw95dw83OCZtAGrL57AktXkGQw8q1UrcCTxx46//fkFH85nSserDbL5PkoF1BvLUiG391S6OC6a5Vq5YhI15xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tfGvMk7jmo7ZfUel37LobxHifLq1W24S3SYRjJ/p/0=;
 b=Ov2djCEKdVtoMcjtWsYHRrWvzXvHk+7UbWKYNJfxHyvQHonOJKX3ru7MSJhdsQencNoFGpqsb0S89m/uPaYSY3XKxPuzcV4HK5j8WMdVaRf0H0z1FNh3lrVpb+V1LJaGtKI8h3CJNyklIrmlp1XQ9RtXYfp5e0BMrDJaO/cBhTGMjRBGAoNSJL0bw7xK/cEERsudN/rU2K+Tc/u4iO+w4YZ5W8gsnfKFMmqH1OCJnXPjuGlFyYF1E9oqIM3paW426LBZT6lr7XKpPW2xYF74ZN7yXRICE7GRmjli294cAaFTITC0BgjilIskl0pR8XC67Ua2pNgjDIg3VjAx6j458A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tfGvMk7jmo7ZfUel37LobxHifLq1W24S3SYRjJ/p/0=;
 b=kXujXEJEAjw95q3FYKefpZ2x2pmvQPiYUuWLvcWk8A0pkzbuUvXyVVvcL0+GJtNxYZmI6JtnkEzF2N4LF8UcoFQlwLwKg1OvCema+ozVS1wP3OdoCj9rDmsQn0PeGMqWLrY9XwOSSCi4QVfRyHqh4ebrTs9ojemSWzMxBoJpI+EIZzIhfbsntCY7RgmOle202TsSWP8Swx29lYsodQrWlLNEEfNEFWJTE6NAskTJaYeCazCDA6r+y845H76ZKzK+G74LcJ4Xd7ULcb0oKCkO+J2UFckg3KxH1B/3VbHawQeXcaQM3kjzsogCy+7OCO6UVsnlSpHsU9OtR/F6rlgbuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:36 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:36 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 17/26] hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
Date: Thu, 23 Jul 2026 23:18:44 +0800
Message-Id: <20260723151853.2143177-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: fceb3c7e-6387-41ef-85c7-08dee8cdce59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|34096008|376014|366016|23010399003|1800799024|22082099003|18002099003|5023799004|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: DmDbXCa6wK25+jNsJK1GPYOcC8/0v6bNwZZVmhNdnnSgpca79AgNjzd+/54FcMTg/duHB3yxQjckVXwgcHLCzCyjq30z5JRSWS04LEnw6ofoHFt/na9m6vIkU1N0APKTSC4aPeJcRTC4qmqIue8pkTSy5RPc9Hq0/g6x9vEc4kMRMbsFOfle9OY84GLbeHA80yRZCynVONNET6oNKYvIkGAaDB98Jd1o7vGXJ3fbwGX1KGBbqZnBwmfozw/+2D9QBNWyjeeFs/8Fp/HAcMqNN1viMXm3Krh/WtHhU5P6N/uabG04/v8KF51Xma8oSO0R410lkSQWPGlbEgEEd04Dmq+w5HhV4grBbq0rgniz9cjUown0Kq6O+vFaFW5wJRvIalbQM9mlsaSQ8xICQ9tThIA+rIXEuxt0ZEtdAWOdk7BPdQ6UgpZ3REfLctVR4B1QE83ipRtsRrtLlqoW+dMw7migH5a2V59oLLi2DveAWN42QfM8gQ4e1ADX/LdBro4PmWJ/ZG+PKDy2MKYYM7sQCExioGCF+Y9MZJcbsDt6+3/p2+Mup8uyufqhnYg+3hU+2DFQ7Ixurj94NycWCEkge6Yv5kYJihU3gWhclsB11NJSUcvrLSNmjdmzGGzT54irUUxCIfb/zEWffu7KOdCyOgyv6WmhtG82WHY/ZghTPgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(34096008)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(5023799004)(10067099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rmoBRFf0w23r+wMOW55Ss3mPHQnjc5BSpVnB1nNhIL0Eskrc+no4D05gNLZw?=
 =?us-ascii?Q?zYUgWJ1UohCapZaE3gUPP2Gq2JxWD7fnuGNMcy/hlrHA1vYQFDFtw8WPu7XY?=
 =?us-ascii?Q?O89mvTqVL9aDBYPbqGf5JyRuPDR+98+d/mo0XH50F41M75JmFJg7I0V4H9aM?=
 =?us-ascii?Q?FVKDLFbBpiwvF8S95RzsZUDF/2eh1oxOR8aiq6InnsNYppTeDnrk4/xHpXq4?=
 =?us-ascii?Q?TDGaqWv8lqadzKDG2l7WP57LpwPjNe7AyJezfKY+x8GmVXZbeaLzx1u+ieKg?=
 =?us-ascii?Q?+rEVIAuFm9WDvqjlwrdo4SGEIRY8j2KMVHcmUY+Ak+3tQx2hvpKW8q/4//v+?=
 =?us-ascii?Q?EAGr64kpRcybNsuaRDVT9S4ex9PjXg1+ZQMXl9gF7VrnSUMGGlc9Ahlu3Hf/?=
 =?us-ascii?Q?Ezh+e059HBdOdC2H/CUrWtepnMr8KeBO4lgTawYCbsajEbiVSAT7sMQeW68u?=
 =?us-ascii?Q?hJCivl9c5oi3/dVZVVzSjuoy2/7gzDQrf5wKf58j7BG0TNAtJ7fta4IygKCW?=
 =?us-ascii?Q?CwZhDIzsCX7+A/pTy4jo+FNrnd2xS8TSUB8qPUvomvsNu1alh2J2XsxZ98Yk?=
 =?us-ascii?Q?F/WIEIPRv2z0DyZrK6r9NxCsKg+y3Ca2Of3c2pI12WLsp1vmDGUXpwrNllh3?=
 =?us-ascii?Q?8a+nw6QkIRF+2jM2VErZSOJe8lB7Vz7S5KF9xWGR4CinS8mPhucu+lUQHHx+?=
 =?us-ascii?Q?6cd1QLgl7sEl3WdI2XjNttiqKHzkKJgYSq2/x+pwKGGGaR0zyBSZ84z9A9w5?=
 =?us-ascii?Q?mNKFOjdr/cd6FX2T/dQeH3hy2fRGqme8Vk2VDtBuvnDiuOKr6fR8TJ1+lb1R?=
 =?us-ascii?Q?nHx0fTVZk7sNDu6iJUI4zq0mRamCmOV97DjhzPEG3IqfiLuKARwVYSQlmDyc?=
 =?us-ascii?Q?AHPUXEJbpNwVoCfTFZDqiux7X2menUuHvGBEpas9M6RSfjis+iGtVvLj3e/s?=
 =?us-ascii?Q?8dAkcCJqpcpXKyZ1PrpGKIGmckkwVZHMgsbuSH6/YQ83gtowxOogzFupTXzh?=
 =?us-ascii?Q?wd4jXaCBnlbwnPVCmMiRViYi3MhsJwTNkqgSqdQyIi0KEqniDbiIhWiqoOnc?=
 =?us-ascii?Q?O/3boWNghYALAr8fOV1pwEgTzccru4RHnA7ohbL5rHIIi4s0num2t9FXy12x?=
 =?us-ascii?Q?Q11n1/eYjJ1CA81LJAlzftjX1I2gZMveVySptFVlSNapOWtW+Bi4idvA/VZ+?=
 =?us-ascii?Q?2fjMz9B6VaY/V7rYKDzI8tCJ0CyJE/erEgCNdW69qfeZqy0fAAJ8N9O5sLC/?=
 =?us-ascii?Q?0+mNRargGVMdU36FTZuaCI+qp7A5hscBWrRfYHmFmzA0MeGrFFvXnLpDxM/O?=
 =?us-ascii?Q?KvvamNIW70IMwHNQ9Itd77BfO8E92P+zOiqTmq9CPHicfSIfCQ2OFd1li7G8?=
 =?us-ascii?Q?zolc5E5uH64QMX09PdnWCcO08/Ti0ZBTq8lnP/kY0SqRV+tJminedPIANoCC?=
 =?us-ascii?Q?oNOwyOdmrLMTSAYHD/ZzE4M9FIdadQzHrCJhef0FCpG9NUOTeCeT7Aq5t4tm?=
 =?us-ascii?Q?oJJf6KUmXITswnMGqDoRFmKe7NXEyYnyEZYpDPLkxXYumdwVRPdPwpVUdqFR?=
 =?us-ascii?Q?NPTDOJ2rwy1jGiXbmvmrW/HhAkgQSNJWCF6WuLMzRQs6BqWoJAsDWigL28vO?=
 =?us-ascii?Q?ntK4VTzeaYlLXNMPkmbmfsBWg+UNyMXkgnfQuOA4SvISG//y22f65XsSeQi8?=
 =?us-ascii?Q?j395x5yCwaNh2fmgEx1N/yW02FtZlDdWYKoZLyF7VwBmLYHet2BGd43c5iHn?=
 =?us-ascii?Q?+D4tlMrYuTL5Cq58OO2KCfBmw2bsLqU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fceb3c7e-6387-41ef-85c7-08dee8cdce59
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:36.2713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6uMK6216CEqhXIZNRyoEwHNmlgm8KEIxh2cveSMwValW49r9KT4r6ApIZm8r4nn278jW0OVBZ24X1k76TwdTykyf1VT9z5QGAVTloKkGW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
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

The Icicle Kit memory map advertises the PolarFire RTC, but the
machine leaves its MMIO range unmapped. Linux faults when it
programs the RTC prescaler during boot.

Select and instantiate the RTC, map it at the documented address,
and wire its wakeup and match outputs to PLIC interrupts 80 and 81.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/riscv/microchip_pfsoc.h |  4 ++++
 hw/riscv/microchip_pfsoc.c         | 11 +++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 0aeccedf77..26d28252ea 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -31,6 +31,7 @@
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/rtc/mchp_pfsoc_rtc.h"
 #include "hw/sd/cadence_sdhci.h"
 #include "hw/riscv/riscv_hart.h"
 
@@ -53,6 +54,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    MchpPfSoCRtcState rtc;
     MchpPfSoCSysregState sysreg;
     SiFivePDMAState dma;
     CadenceGEMState gem0;
@@ -148,6 +150,8 @@ enum {
     MICROCHIP_PFSOC_DMA_IRQ7 = 12,
     MICROCHIP_PFSOC_GEM0_IRQ = 64,
     MICROCHIP_PFSOC_GEM1_IRQ = 70,
+    MICROCHIP_PFSOC_RTC_WAKEUP_IRQ = 80,
+    MICROCHIP_PFSOC_RTC_MATCH_IRQ = 81,
     MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
     MICROCHIP_PFSOC_MMUART0_IRQ = 90,
     MICROCHIP_PFSOC_MMUART1_IRQ = 91,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 248de4d022..63658fbeb0 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -181,6 +181,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "sysreg", &s->sysreg,
                             TYPE_MCHP_PFSOC_SYSREG);
 
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MCHP_PFSOC_RTC);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -308,6 +310,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_PLIC].size);
     g_free(plic_hart_config);
 
+    /* RTC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0,
+                    memmap[MICROCHIP_PFSOC_RTC].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_WAKEUP_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 1,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_MATCH_IRQ));
+
     /* DMA */
     sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 22619481e4..d69c9f7629 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -20,6 +20,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_L2CC
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_RTC
     select MCHP_PFSOC_SYSREG
     select RISCV_ACLINT
     select SIFIVE_PDMA
-- 
2.34.1


