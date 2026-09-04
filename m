Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644FCC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJv-0005Nt-KH; Fri, 04 Sep 2026 11:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJj-00055T-5f; Fri, 04 Sep 2026 11:59:03 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJg-0004Pg-Kk; Fri, 04 Sep 2026 11:59:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX+VBObAU/FVqgwewMobilo5vPhOzfdRDkjekPzs7HgEpHsI6IR2HLOvf4xaMvU4MgLy4eSVKDPqu7hQdqWvLj8AFADxxNpdErTy363JMoS/D97RoZKyAK0eAisxtZcy9FyR0Ia8Q86oofvjososXF0koM5bfFdfmHr43Fxl7bjeuW20/LLDWrrKsW9WUf4BSsZT0s3SMvzNnyDGMk0tLnmbNQjW/Y2gfa1/yuYR6gg2DEpzdjUj9CEsGCBL1P4AdZ+XPy/AtHUPFuVTsQN4PFT+g7W+EbIs5Bdqn2LWuLJavMe7phRu7malkhh4qGK4Oz58I+sTNrmw6rTMacrWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBCyOqk79EDeCw3ZNunkVps4fe60+VY0lwVI2MUlhrI=;
 b=KBZKZ5E4ZeFbLs91vHRHMDHEtumfvkRU12dovuLCSBd9MOn0Vb+jhqSPwEP0r/6CPr4VAMeC4gWA68XRVDASHI1DD0Rb9zTe/By8eWnZ0M96d3G//HUPYOc/tV4XKWDYHMyG6PY6BDDrLSs5BEngUkr3wxOfVBquWPoN99u923O5Wt2v6WgRPEe46hc4wNcH246nh7WhbuWWEDm4T54QlAQ11J7DeOOxP4U8FbH2WkoBjXNNGOBum7BiFdAXVaVMwcmguUqIBm+Mw2RuS8LS+9Tm2bY1uZDLRponjRA8oIBYqy8CzTQ/9z3HO7Cd0mx1SP4yhSz8b3nA31MHSNrnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBCyOqk79EDeCw3ZNunkVps4fe60+VY0lwVI2MUlhrI=;
 b=gvHUWnK2EkK9AqaHcejE98UlFSGvB6ol1v0o/ggwmBY3Piok8V0235JRZuk5pnIVbKWcZiVGcxq7qShga8by34rLYENkhtOPZtEVKB6KDw6dfuIs+1bmmjntXrayOBqFLmEL70n7yDjPGQ5Mk/zTiKD90/4JYeZ14Ukc7leaoldO0a8R6wPE16A/2wuj7luK5hthEcxvTQ3/QOMbA31vaOxXfho0WT4GFDxGI9Bx2IJO5IKZsxq/s4LTUE0wna4aDn7vl0RktKLmsBxSH7OGXALj2EexPmYH/cXtKwmp+WXouJDp57woVoVDPEMPXUXK6+oZNFQCeb2xzDgwQ6eulQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:54 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:54 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 14/24] hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
Date: Fri,  4 Sep 2026 23:57:33 +0800
Message-ID: <20260904155758.3833179-15-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c059b9e-32f4-4601-c4d4-08df0a9d6b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|5023799004|56012099006|10067099003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 0mnah0QSdiuLyzlHSOOv+yixNMjUuZ6fLxQsFbkg60vRwDKZiqy8OvSIDL+g/+q0zhnGPgPYh/dYO3pBkOsM0E+PQTSYOmgkFE+Lrx192PV5QqY1k6QkuQnMZzr+cs3+4phtznYe7TSQI78Hx7f7aDnDIiCKE9htNn4ZJd67TFFxc2SG7351F/+Cozz8NleLzPZpbTWdnh4hbq4UFV1q8MYoqCljLpgAwL+SnE4TGSrZQR7eKPq/sj3S2mnDXY06DePp7SfGCt60AY/fLF8oXrEYyj42wIYKWNbTTKHGgK1QguUWmA9ALMiP3kzbaacQRX4dza421U1fm/ttZKWwuOAhrc9kr7XqjFEnRlSyCJkv6SH8W4P6b5mn9cwd2Rxpso0iaZ/rWdeu7AC1GBE2aTbtQl22YaLFU6YjjStrV15pTN8D7f7+gkHazxvwztPGYgQ7RvEYE3XwfZ/eai37pC/+uu/JYfJ8ZNkyVoTc2QaUzm0Y+uiriO+QzrCGy33W8rGNxGEsMwFwz9du5/0P3jXDcnre7j6544TFQN75A7aBFbCVeTiK570SD6oet7jvUILNp5plQ1ZKzpFrPsUKdjArKDkUYpO6AW1eEcBLPOkEaoWopYL2C+FDIEES37o+IxE3wRYTII8wAdPd7oZzg4rpD6c/mBISKMloldMWb3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(5023799004)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4taS18HOMmdlj8toQEYsXc2bB0SnRhQ2Lm3D4Jo6XL2UHasQAIdijgA1PHhK?=
 =?us-ascii?Q?HahjjPcCbUXRgSfYtbu0C2MOXs+Z4A5vWOJYprjo6xw07Yr1AVBj+KKtfmEf?=
 =?us-ascii?Q?T0QFz0N8GhG+4UlbIfG9Vj4MwFFiIPtVqWGoDJua03UqR7+g2PmyS+1eHvCa?=
 =?us-ascii?Q?MWeJjIVEeuGVqmfQ6+VOvKumqS3LW88oLBiZB3t7EQzZ3le3YCDff/Afa3Nr?=
 =?us-ascii?Q?cyLk2B+JbwFXXBi6sQO6njLXcHtbhER/64YuVIGceYyALH6/Mw4Gz+Fwc0Mg?=
 =?us-ascii?Q?nzZn/EDhNhM+IFFgjvXtTXVI+xdbNPQLgg29t5N7g4pO2giEJ/JUj8UNelu8?=
 =?us-ascii?Q?/vti0WowbJQYzsXo3Ryc7F8ltXnaxtXtEXx7ji6neEomgv7FSFHBdcRdNE6e?=
 =?us-ascii?Q?WJP0wxLz/Mpbpg00kgsrHLpQzDS153L4+3Wg6mrUjAE77ToLUQvpjnRth78p?=
 =?us-ascii?Q?yMztL9VFgMshOM0PZey9JrpZppMFNsoocWXFvx712nrjmqh4A+7VTnK1vl3u?=
 =?us-ascii?Q?eoJsI2QAYeBwNS8vHtjGvkoDTr5zHF6xa6Pb1z9DcaASdp8h8Z9XfoOJFnx5?=
 =?us-ascii?Q?ckYfMCgEgNrndiWEbtXwC67DRXupPuZrh+jpmxLIJRZJsBaeCxD51dj33i9i?=
 =?us-ascii?Q?u2Mw3AE25gRDbg0HiEBDadB+/wZas3L146Nw7W+/a74/s3Ch4whOcNpSQdQc?=
 =?us-ascii?Q?NPo9f2dtaGLBgrM3G0M5zvbtg8LCfo4bPYcfsKa4A9GM6aZ1Cp/duUy1pzPD?=
 =?us-ascii?Q?gK05jCWBL+vzaQl2as0scutUwDjjfQhcEDpgXaeZIZ01Q+gIpmid1mJEE+Fe?=
 =?us-ascii?Q?2WxgiZ2sS5xN5oiJq7lo4mn9op1/Gr498LyfFlm/0gK7YJOdI9dY6XIVQe/R?=
 =?us-ascii?Q?Ke1u9+AthM6bIxQKaLAPFmGVJZM/opzSf79eD+a+IWUAiRqk2yRhG5oC0QU3?=
 =?us-ascii?Q?KXRUx4K8Ade6xITqplYDH3l/Qvj5Ma6UbVF3aXeuKH5Y6ble0gnC4/WsZHcB?=
 =?us-ascii?Q?Hg8DiQzbQbw18UPHIpRczjKk617D7Sds4zrMenxtD4sB88ffKAIJusuhC5D0?=
 =?us-ascii?Q?dW0WZER2mn9HmeKzmr33b5n17mOEM7hYjMhH85SubOr3JVKBTULO7SFNJAct?=
 =?us-ascii?Q?RnOSv0XVyYImL5VoKr8cT08DgE1LNGSn17ska6hmoZvaFV1EDF9p18LFq1du?=
 =?us-ascii?Q?A9XHxSaxLtBBOxN75nhuj1eSJWZ8o8Ro8mlY4smQ+zapJHpdtBLcykwkUEko?=
 =?us-ascii?Q?DnDwE2ktE+hSVYU7IhcwS7L1RcghYuq1qfuf2jm16M7Eh43I1nQKxY0pGqzJ?=
 =?us-ascii?Q?a1GElHg/0XcSAcg3q7qr4rvywH5tBT9BbpF+4W4NFKWa+o1Ebbux/wC5p7+V?=
 =?us-ascii?Q?Mg5aIq3Eug8a83M19VKPZYnYCdd6gjbe4P0BDnXp7c3sQeESmvwrN9rsGky0?=
 =?us-ascii?Q?X2jfvRVqvImTSa7JP4SUZRVpOZNIXv+KeI/umGi4i3G8rmec5SO+GmOWPR1f?=
 =?us-ascii?Q?2JtTrY+rfzJady3wgYovsCS6tnaTkGVP0kQbeUjYDHYb19pd1NGAPbcCyEWu?=
 =?us-ascii?Q?SxERbk2zA8t3FVBuGckw1WZyj545fFL6Gs/5JnTsI6gAy8Pmp3YIqJpiUkLi?=
 =?us-ascii?Q?l+3GCMQbsAkMn1Ytvx7EseK8PuewMzZC8qwMEKFpLr5GZ91PBT9mTh/P8TCi?=
 =?us-ascii?Q?x6dqQJMeU/hpm+7PqYBfdUUWkdIjPWC06LRS1bMBv92FIaj6GXsi2j5U88MD?=
 =?us-ascii?Q?anxslEknEjjBB9vb7KHg0vp0gKTyNjg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c059b9e-32f4-4601-c4d4-08df0a9d6b87
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:54.1658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLZ2BjBAKuwrIVKnN27K1sCPTlPLqBzYKCh8xaQPFzRxwMjNp5SRkwSQ8MX56MhLfTQWXKk5E9w2AA9GKut8111bJ7lV5trsQIp3JJtngxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
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

The Icicle Kit memory map advertises the PolarFire RTC, but the
machine leaves its MMIO range unmapped. Linux faults when it
programs the RTC prescaler during boot.

Select and instantiate the RTC, map it at the documented address,
and wire its wakeup and match outputs to PLIC interrupts 80 and 81.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

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
index b1df852ddd..fb0e18edba 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -180,6 +180,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "sysreg", &s->sysreg,
                             TYPE_MCHP_PFSOC_SYSREG);
 
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MCHP_PFSOC_RTC);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -311,6 +313,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
index 85b535c7cb..de1da02761 100644
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
2.53.0


