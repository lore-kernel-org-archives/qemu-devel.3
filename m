Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D779C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDw2-0006v3-T8; Mon, 27 Jul 2026 01:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDw0-0006sH-L4; Mon, 27 Jul 2026 01:31:28 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDvz-0002hT-3h; Mon, 27 Jul 2026 01:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKG+s+MbWRHHkBl5ezf93v957+D2HREzRXDqPNn/oul0FhZ61Ds4Vfh2jxJI2TLqX9mnbzFHE063agaw9yqNZyRaNAJRGMoGukGvPi8Ktwms11tCLZBfKfm1FWsA/d6i/dtwzzyReHZ1RXr3M06DAoqEDG+m/dUOHDrkwhcdrHqLOqwY9+kgndsOuKwaQSwmgUqNFkwc19Rck/i60ksmYk+yiVzJPVcIEEaMnrdDnMv7EP74/eAEsHGl1mSnjFV7p2RI4chLZIKZkcv97KpueUjwQRL66Nd5tpKnK35+YtGySldlaUsCkvpkwxJtOwJpLeIs+Avn8JgTJVYMsIATmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnOCvqEGnfhVcKNBf/9lXzAe2uMZdxl7l/XaAxmCkRA=;
 b=fvfPzcvtdqXU1PzYPsV9XDSgNMrg+qWBx8LNOulSEIX0olexuhMh3syo0Pj6SUQvym1TmlSdY1OINJEB0Tq3Sqls0sOzRVtVTfjp4y6W+dSPfa7cbh9T4NcahFRTleICQ+OpcT9OCIjq5bC/x/dE4i7jJC6ngIc5+VVUGfQ8bkkFvZiz9tvwk2zX28JM/pDtq5KzvMznor4IAtcBbC6f9Be2l60nb/tstH21bz16Ex+QqpNOlGrU2i5Bx5qlS+/DKyNHtVrIFi6s+Ef8I1GIW78EEdvGQQ4O+eTx0+rllKvhc/XFb5bjvDij8Me4JTJUxiRWv/ZebrHzYOdRNGa7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnOCvqEGnfhVcKNBf/9lXzAe2uMZdxl7l/XaAxmCkRA=;
 b=KM7uBoYdFPqFmWTT/c7+XzvZHM7UDZiHqAWbuhoeXYkBien0X9fJZKR6QellwgBUvFkY1mX/GL2c2HbFH8P05db7Ljn1Kcw5P62csRW2/kFbMbZBdIpn0o8no6hVDSD8pxWVvzVFcPZS8cqoLQG4acjwytVPrB+tpiKHQCNxmVnFss2IIWPkiqVNjnG9CR07Jz/Sf/1Z8Wja7dSQIVni3W92eylOsisA64GuWfTdexv+oOFwlDyVHBfnG23/YrcEj/TB5TTgZoVGSS0xs97mLip8wuOV9YirTTrou2C43+lPyMl1LY1dGt5qUlVdo8KuS5Xb+NYZ8ceQ7GSirSs4PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB6022.apcprd02.prod.outlook.com (2603:1096:4:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:31:21 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:31:21 +0000
Date: Mon, 27 Jul 2026 13:31:16 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 17/26] hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
Message-ID: <ambtGfqcjBhrPNIb@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-18-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-18-bin.meng@processmission.com>
X-ClientProxiedBy: PH8PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::15) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a13e314-3198-4e46-296f-08deeba04ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: c2PpRtsH7qtsKBeHp+eN78my+D9FvhcC2+K+S4KwKi25IRnDK0uyEq3evsXExzq+86Ybq1R/nZEFQmMkyA/Fxz3OFF7rgS2PLsi2ghPgksYqTvVZd7Pt1pe3reO1l0IpXvioXURCMk1tWsl3WaGgZOyhuePkEkk9Sp6BUBiCTrMi2bJA1EQHtKger7JbesOTMXnu4nqkbXP6ETS6N8cE229Wy2hAvUEOxZ0v9uAeLAIAqRqiz1nMNGMIXJkTWOwEbXThOKNa2kH08sEAzveYqh7GzAKSTXpF7UaxmOA67UR7Pz3LT9pK6QlE0ZWV3Crejzvzln7LUc6OmCoi6k4TOd7XI+1WXx/HOxF3SnMysbDK42/+vGHyu+uo3w86+8w4/ahw/gx4MmfybZ3Xzol139Y1rjOj3zt2n+bZwfbeioCfxGHJdrnGQlpwGn38UgvgpWPgikp9SR0rQQs+H8A03APtOBS0TK+mYVImfHFJQ3fZOLmepkNXxbQBgD/cMAqwj0XJtWkxazEwBbZtBLoXBmPY8/jIFSht2Uwce+doAeWA+zevyjoq967YuTN1D6yRNo3Dp7sjz738sCt/57QM/jSFHu8JJvgZiqqMrI0yE147GVqRZSJ83qahw0QVaDhitYfxZuRmSrQgo3CRexWfhm+dOFuRsTslGYjSyEGpaBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uyBvFO+cKK1pcXQoqNpTmD7a4yk0CNu8ihLyP6ieOPP7U2QdEQn7My8qbSGb?=
 =?us-ascii?Q?GW7LYNcrHcvywnHujdGvSmn8R/quzGlCZQTII9K1nhRLp3uiBv/80jW6GMMl?=
 =?us-ascii?Q?yHXKVtfIQ79tiR2RxTf2EEJ4AoUANELiDzOr6E3kemef/KMeuBLWA8kR4XTq?=
 =?us-ascii?Q?dNmATmrGx3suF+CJjxPHD+np7yk22xCPEOnqwiMHdu68ZR3LnS+gaJxCnvqa?=
 =?us-ascii?Q?bLw2U0ruoJsqe3Wh6LakAETpTVo5bLiNkJLK7J9RSLdwpgpp1l/KZtweVWF0?=
 =?us-ascii?Q?1y2Re60T3d04W6tzYmpqo7TUNVWlODdZ/Wn924k577eL81S41dcqfziZbfm+?=
 =?us-ascii?Q?iv8wdAVdFQVevf6CIptKFyvSaBD8NRzIhvarl8kV+aEtv5aDyQ88Q6AT8dX+?=
 =?us-ascii?Q?0zO10AmCh7ZrnoGAsArmUf9BokZBGliwJ8qUiRFgIIwZV4ptbXtG6lzCto4o?=
 =?us-ascii?Q?2MmU9UDFcqeU0av9xaSqEaXrWGvVyJ8hHSXlbQaDsxc47Sq2Wg+Rm0GdZciP?=
 =?us-ascii?Q?z3tnuNIWrfl9LVI5gmmsJo6IrxPM8rEWvPItGVaWe1CVKAlSnltaiosSfOfr?=
 =?us-ascii?Q?+whpkf2GsurxqzOw5oUETYkG2zTFTqPuRFrZuOdUbyyiN4/pCtHqLz+AuV3A?=
 =?us-ascii?Q?eh8LQntRSOA+v3LEQqlZJCRhBQMZWVf723usNJQOYuSeiIiYe2BwJ3BI1MYG?=
 =?us-ascii?Q?A++9S2JolAj1x+YdI6pFhM0wE4nCagp5hd3IVa3R4YEfnV0UXMw/Aca7+rC5?=
 =?us-ascii?Q?/oWT6q+1L5r9nEdP07d4pPO3e0fAHJK7ZMe5ZgAh8J4UJ7ApUOwLuHQ9uVcB?=
 =?us-ascii?Q?TD4ZIK8//L5VbhXILIws/C4t9rzwSPjI14JafcM340rG6fQh7JZgNmH1WzIM?=
 =?us-ascii?Q?c+noR70JzEkNA0lO4QKDNmecALvGkHj01N4zbTdPnO01Uh8+uGJkqJitcmWa?=
 =?us-ascii?Q?7bbEEgFqTs+IdgmBNA67yuVqu0q8dMVx6ybreyHMzzc/JKC0Eq5shUE0OwYD?=
 =?us-ascii?Q?dCPnNxNTWGYQYGoysAzyvG2WUh4SbNG6TY2AU6C8RMRYmcZi7wTwd2hjGlTS?=
 =?us-ascii?Q?1BGAyfv+px6HCQ1xVtMU8jABquHTMASj8fXkRstACfOY45qF9aX3RgxrV6nm?=
 =?us-ascii?Q?XOlaIxe5RovcvER/THuXD9gpHjlPRUHonbaDZbt2O/YRLOnIF9UnPTbEv4tf?=
 =?us-ascii?Q?nWm++jKW27plJJtHzlssCDe8eNlcWElTO3KcIhciVUabLzhsiDuyIW9PjypA?=
 =?us-ascii?Q?1ghSY8YguyvGfthvje2jCuyPPV8uMVJP1VVwnwCe/fcT2sDzi1gAdduC0n3Y?=
 =?us-ascii?Q?wZKgD2Emsvnd1ke6IfHqSzCrVkFgdVSaw3j4DhGUilwj8v5kc2iO23OTF1Yo?=
 =?us-ascii?Q?YbGUS6syQEAWd225ic8h244sjnbxtlJAAg0g+taYO/E79H7W3b9bSg9o5D79?=
 =?us-ascii?Q?YjoS/MZZt6SIVE7+nvtMO0lK0Og4DCz1Oncs4D7af0gwqWzkCDFQYOZEnpGJ?=
 =?us-ascii?Q?2Lj+NrdclZe/UxKGhRBmQyQExPLBDrDe6aebXsZQA0aGMBYLd8kVin9tpeRB?=
 =?us-ascii?Q?aEMy8ANrySje6uzRcu7WLdOzV213uhMQn4+UPANmaA/0K1NZ2ODaEbcdIvzt?=
 =?us-ascii?Q?D1JqhRBQdAP3cEG7oTbC8AovExEYvzQOUxOe3ipF3/3i9yEYp/K/nfoYi7SZ?=
 =?us-ascii?Q?KEYh12eDi3ZD6gvxwEsAL6VnTJt5IYE06eNOFwWWsMyFStfgv2iSMR2r8vmH?=
 =?us-ascii?Q?gV8RzrBsavaP2Ifbc6A6nYp0fhyAZTA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a13e314-3198-4e46-296f-08deeba04ab7
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:31:21.4662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ew4X85Wku6Eet6rwTRhnjbt91gbLaJ4NDuvMaVI1ubKR8jwK38VtUb6ubfShPjlwFRhMKzDBYS9jr+x/pJqi859j6RQQjYezHKkCRcH0sM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB6022
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
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

On Thu, Jul 23, 2026 at 11:18:44PM +0800, Bin Meng wrote:
> The Icicle Kit memory map advertises the PolarFire RTC, but the
> machine leaves its MMIO range unmapped. Linux faults when it
> programs the RTC prescaler during boot.
> 
> Select and instantiate the RTC, map it at the documented address,
> and wire its wakeup and match outputs to PLIC interrupts 80 and 81.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  include/hw/riscv/microchip_pfsoc.h |  4 ++++
>  hw/riscv/microchip_pfsoc.c         | 11 +++++++++++
>  hw/riscv/Kconfig                   |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 0aeccedf77..26d28252ea 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -31,6 +31,7 @@
>  #include "hw/misc/mchp_pfsoc_ioscb.h"
>  #include "hw/misc/mchp_pfsoc_sysreg.h"
>  #include "hw/net/cadence_gem.h"
> +#include "hw/rtc/mchp_pfsoc_rtc.h"
>  #include "hw/sd/cadence_sdhci.h"
>  #include "hw/riscv/riscv_hart.h"
>  
> @@ -53,6 +54,7 @@ typedef struct MicrochipPFSoCState {
>      MchpPfSoCMMUartState *serial2;
>      MchpPfSoCMMUartState *serial3;
>      MchpPfSoCMMUartState *serial4;
> +    MchpPfSoCRtcState rtc;
>      MchpPfSoCSysregState sysreg;
>      SiFivePDMAState dma;
>      CadenceGEMState gem0;
> @@ -148,6 +150,8 @@ enum {
>      MICROCHIP_PFSOC_DMA_IRQ7 = 12,
>      MICROCHIP_PFSOC_GEM0_IRQ = 64,
>      MICROCHIP_PFSOC_GEM1_IRQ = 70,
> +    MICROCHIP_PFSOC_RTC_WAKEUP_IRQ = 80,
> +    MICROCHIP_PFSOC_RTC_MATCH_IRQ = 81,
>      MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
>      MICROCHIP_PFSOC_MMUART0_IRQ = 90,
>      MICROCHIP_PFSOC_MMUART1_IRQ = 91,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 248de4d022..63658fbeb0 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -181,6 +181,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>      object_initialize_child(obj, "sysreg", &s->sysreg,
>                              TYPE_MCHP_PFSOC_SYSREG);
>  
> +    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MCHP_PFSOC_RTC);
> +
>      object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
>                              TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
>      object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
> @@ -308,6 +310,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_PLIC].size);
>      g_free(plic_hart_config);
>  
> +    /* RTC */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0,
> +                    memmap[MICROCHIP_PFSOC_RTC].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_WAKEUP_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 1,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_MATCH_IRQ));
> +
>      /* DMA */
>      sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 22619481e4..d69c9f7629 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -20,6 +20,7 @@ config MICROCHIP_PFSOC
>      select MCHP_PFSOC_IOSCB
>      select MCHP_PFSOC_L2CC
>      select MCHP_PFSOC_MMUART
> +    select MCHP_PFSOC_RTC
>      select MCHP_PFSOC_SYSREG
>      select RISCV_ACLINT
>      select SIFIVE_PDMA
> -- 
> 2.34.1
> 

