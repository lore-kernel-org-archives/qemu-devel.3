Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006DBCC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnkm-00077Q-NY; Tue, 13 Oct 2026 21:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjp-0005s8-41; Tue, 13 Oct 2026 21:25:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjn-0006ql-9t; Tue, 13 Oct 2026 21:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXTSfL65VfOGzxSmRx4L5+X+EKYV0Hag0Npr55rg1OuyfTn2DYhj8UM1QzM9tChWlo+64XswfoBKL8oyJw+mnfJerNNWK17nLjrpotpaOzurA8SdA7/cHYLE++WDQrkX/9v4y3eF3L3uvzbUcU1XTWwB50noRAXHhP5NCnRLLDhzLHL0GGYXswSWCBxn5+GjssWFM40NJVFh6n5rKJSKtKU1BWZN3S2xUohaKC9rznnp2s8G7X3ntv1dkWc0wZMw2A4LngmEojqj0jRgayXaWVD6dPpKtJ6+zAGhXvTq4hwtf+wVth4YWUv0Ds8aBgku9CfLiJAUlcC030nNDdUzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TIb+VeHLJPw3/dRRRSKWYFeHgaBR+x6A81rHXHsrEI=;
 b=GS4GfAZG4JoXwx56tMJG57tfOLD7Ut4tZXt2UuhOhYnWq1OOplCbd7ObQKUOl9b/WSXAMSmhJpNkmp8GvgfQN81+hpUsPmZfQ+wE7fJvvugI3RLNjm10j78DHMwv31wDqeIBDc4LkD8gwbNR/v7e2GDxcsn3yIyiyh+k3Msa1UaLcV0OLx0YfkH42X3lFDtj/wsfj0kUXZkSuuQs1HVhKKftGa6zGyr9+vnWME0tUP5QVQJXjXnEXeXFuI+m5F5ukLLghBatnTw7zf5Dt+K953rTAc5T+QvNuLRLOPM+x8stfgtLKbQwk31FAUBqTp+ycPurrWuYNCvTGtXsO+Y4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TIb+VeHLJPw3/dRRRSKWYFeHgaBR+x6A81rHXHsrEI=;
 b=pPhvpr6JtHjG8iB9WqpV8lN/tZmn+AIZCpoxcEF72gapDEqsUyVXhqDJGpGRJ5TtxWyXdaDqCJne26lskWUXdIv2X1Cp7rro0ajwMzoVHVuF+Egdflv7GrHpZFAprHM1xKcorIM53TBbGPO5kGkdaTPQ6JX0bFeb4iIRgeuK8sQo1NdJ7K7eM4vK4w/JCjOoM02fi+yo9i45tMf6iXTuSK8W+eXDfMtWFhvjWTOzNlQizZyujlumWDjy+OSKNCaIgEzCg15mNSXB2/3AE7cCdJvpOTXM5hzw4qgvJgrXYV8GL8m/q4mwzg0vvwTAlEGAnFAu9j6ULDS0ru8g9p+Frg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:27 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:27 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 15/27] hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
Date: Wed, 14 Oct 2026 09:22:55 +0800
Message-ID: <20261014012323.322790-16-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: aadef904-d6b4-447f-8664-08df2991e346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|18002099003|22082099003|10067099003|3023799007|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 0VQ+86AkPlFvDZ5Yd4KpkuZ1E9kX9xdtQ5bNYHOqc7r0ncFN8TTGCDq4o8wOx3bPd9Hj6i6VEB+LC56Hp0zeRVyPQOfeXzsfPCeyWCd1Jhg9xV54BLSdSbwguKzc7xqalyOMIzqW0g33oah9Kw4t6FFKnH4ejxVU5Zf02sBuMTkNOhmmJ1zBbiXS6D/Npokcz9zlmNCCfftS9Z/zWt9hCJIz5UtPYtJpUiL25kTJMCa4W4WLRNulNrrrsePhi4a3D9VGM8ytWOq76rUciCfhWQhBg+HLrHvzp+Bn+wIkAoq+nthlezDqymHb3Z4qAOPgtvS/Xn4n5mtzI+iR9Jvn18WftdW32yGC7SvZffB6+abnMx9532PFCv/QvMChM43lTKAEQRi7MJLz7g5RRfPgOWTdxU2LKK72GxHAxew288UuHqT4rauQgVjtiQX23FM844ZUHxGvjZsDNdrSv6gRNwI5QXHb/Eg1aiWmQFUURW0SPQuyPh+KJvLp1oAOyHYbSn6zj6u4tZfBKJuIPM3PMnhj2Iu1ec3GynBPVRCaJ5CNmCtbm+poR32QxHAcUt7Y9DmLossK3qRsTZu2TA1DumxR+tsfqv8ceuKkUg2Ll6trtgtb8b6Hwusjt8ac3SQHI0DY1b2tXpwpYnYtfpXzlc2xJS5V0it79rI27o5o004=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pm5oqvsjoneJ8i7jW884BciqqCfOfpvkVIsiEGGFLoImvaq5W3gYmRHjaS54?=
 =?us-ascii?Q?HuwvgDknhfCu7vETcimD/wgxqpHTj6A9Fg9f85wdNEstKhEBCnALNyLGLOfQ?=
 =?us-ascii?Q?d/j9DA0kUVjGp/9JGWkkF7nunfnDAMAHV4134CGwuYguEWd1OLJjme7qqI0z?=
 =?us-ascii?Q?UqBWot5Rqz//XMh8Si5STjBh2fHzDn45I7yNMy8h06taD/bWLQrlJFAm93a3?=
 =?us-ascii?Q?mZQmNM2x5DhBDuNNktCFGNDfaJtET+JJt4OQYJq8ZheRPdZNMg1CjRjakXHC?=
 =?us-ascii?Q?IA277ToSrZWeNW/LeWxz0YerOBDLXRKei28oF6qAiZC7OrTH2NszRjBoVXCg?=
 =?us-ascii?Q?5deng+vcmtjtyy3luf7sDB8uW28BkKHVoOGzxAWhWwVz5s5GWzXkuaU76wNW?=
 =?us-ascii?Q?yjT4j7YQpAy2hjMgRnY+4OC7Sp+Zv0gaAnzFAXHsDjkQyP7ia/BYc68AVERy?=
 =?us-ascii?Q?aw0GOxgtDPx7j7YdtDqjAo0lOs6ZSrN+WUY2COu38BmmcIqQl5fgcBZ9ywpq?=
 =?us-ascii?Q?IlQBlz2f/UjsnshhXfitYdv9V/IRy+PqFvKsoQsV7jEwLDZu54PSQ0FfYRgM?=
 =?us-ascii?Q?pLXGVycIhIq5v+k3UUCnDPWkDy8VThoJqn46e+qoFJmmBnfBTmN55vM4QLz1?=
 =?us-ascii?Q?c9QJyPt8P1vZ16PtBzW2QprkDQ6jAsDC5vkmAO3U5YZ0OwPxUsU/huNE6gK/?=
 =?us-ascii?Q?ihT5qjjR4gbdwCWjgMsVAULqQRSadQbfwRsRURa6N97AKTEShyAM1q6YrhrF?=
 =?us-ascii?Q?syj01eDJJZ8b1k83Bkm0Z5aJ2p4/5r2T1MYZ0ueuldb1hO49uQ3eWEybTj2D?=
 =?us-ascii?Q?+0CK/dc3DYRF3AYSVZ9FyO0CUJMYqtHiFopmkXN5egWHoK23oTpZrEjUOGHp?=
 =?us-ascii?Q?tqQFjRbDUlpWpBgHRylSauKQNoAfNjtVUBsoWXl2HOaDC1GwbmglJDbCMw03?=
 =?us-ascii?Q?BmmvGyz4yoTynsGP4FGCI2QH5fvhSy5cE4uY2XRrEu79zUZhH6Dr//LoGfiI?=
 =?us-ascii?Q?0ZDXIgaiv1BBwHDdHYQS6Rc1+Z8JXSgqtlKqNIveAy47LcOGj3B7kcS/zpQ+?=
 =?us-ascii?Q?+c1a6eF3Q1tGBmhSy6mWFoTuIUSUNlpAB51AKA0GssJlShNKVxmURRJyTrdR?=
 =?us-ascii?Q?o1xTCpfGuWyXDSR64xau295x/eTbjWrJWYLvaOG/uf4AtJaiLqH1VcB51zJC?=
 =?us-ascii?Q?TWmB172KjAMe4Mgl6l6z0VCRelMgC/5YTK1TmJJxhkMxH+QhugdmlOpSXk6O?=
 =?us-ascii?Q?0ZgGRsk8O1dWUaSlc4n720jbDnPcWrKqGio9tvj45pF33oi9tMRLqzuUK7VG?=
 =?us-ascii?Q?LtFbD/6JX3wER9zCCg5XDU2T3Zdeb89XfpnSrB4H2dssEAOBRO7Jqu1HJPj1?=
 =?us-ascii?Q?/P11K2i8p+aRHTTjATr67//I4EH+v0yUI13On3EVffl3fdgvctzS5NPRF3C6?=
 =?us-ascii?Q?P3iI5vDjEUP9jFTjNkVlg+Xi67zZfIcuZzXMRCB83eywy9d8rBxrE7OMmi+4?=
 =?us-ascii?Q?J+I/9YdBoUs094Mf8imKHFyyNhPnRROHreCj80qd+HXsn2C6CYREFTkvPN26?=
 =?us-ascii?Q?guMzSKawsZj0ldf21Zf/D3k4VEvP+v9GbQeL5dLYX2OLjSaha/iId9CHjNWX?=
 =?us-ascii?Q?T+z1covWnswnntGM5eIORT1qQu7misABrcDxQ3fD0uq3z6LzkFewOgXy+TrF?=
 =?us-ascii?Q?Y3+FyHAOM3XspPHBSq0rjr19DgDoVyjvWmObdAP9NKvsLHi1Pr6mJVlHfQHH?=
 =?us-ascii?Q?nksCzl8sOlcL83JlMFija4zAOihvB2k=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadef904-d6b4-447f-8664-08df2991e346
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:27.1467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVBZYR466KXQ6jtIUqlt1r7bPoEDMu9Ct2bHCznWiBx4MZwJR2i/4M0eV+Lxz0Ybaa5d+JsxSy/yqahE3J2UVa47/wPOpC4VISSn7s9028Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

The Icicle Kit memory map advertises the PolarFire RTC, but the
machine leaves its MMIO range unmapped. Linux faults when it
programs the RTC prescaler during boot.

Select and instantiate the RTC, map it at the documented address,
and wire its wakeup and match outputs to PLIC interrupts 80 and 81.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 include/hw/riscv/microchip_pfsoc.h |  4 ++++
 hw/riscv/microchip_pfsoc.c         | 11 +++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 18f5003850..5827d6be2f 100644
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
index 3d1b3246db..36c894b677 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -183,6 +183,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "sysreg", &s->sysreg,
                             TYPE_MCHP_PFSOC_SYSREG);
 
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MCHP_PFSOC_RTC);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -293,6 +295,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
index b2b816de6a..877c020052 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -19,6 +19,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_RTC
     select MCHP_PFSOC_SYSREG
     select RISCV_ACLINT
     select SIFIVE_L2CC
-- 
2.53.0


