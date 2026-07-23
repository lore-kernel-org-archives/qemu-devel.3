Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CB1C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmp03-00076I-CE; Thu, 23 Jul 2026 04:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmp01-000760-Le; Thu, 23 Jul 2026 04:41:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmozy-00087J-F6; Thu, 23 Jul 2026 04:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWI2bkHCISF/nyOUG4s72AFlFhBNwzkk/5DPneZBt43ngE0+Ii5m3U0NIHFTkG897m8MSUVfXZR8bAgmfA1w1G3mgxDclJPuOL3wkhIz2cegPMg3j9AyCBrfOnmyzbDfpIEZSMw/TvOX5fvWC5RO29rhqozo3fWYBcpRuBmSx8GfeM/7kRQg+NOOBaWo8Ws7awbYV/h9gDDhCnESJuXMf4PS3iCwI1IA/FZ840Rw2XcmzllUzoiVMY+sZlZ9Mlcu3a3hgvzt2ue9bJk3Sx919gShWDXcNMfAImCUHocNgKH/D+a/3Ey95ydKbBHr6ylFNJmuxiXszt+9W5Mv9VJx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3aIRVqI6DreWz5nkAziOrWK2T/+jFrpKOkqXtsTVUU=;
 b=ZKwnZymcmhTYdJfpmKm7eNx2NpBrxaZhyd0Mk6VfbBN82qBeId8k6t3JzgagbN/JzU7RkQTliyxRBEeHc7UUEzt6or/pmwN+zlAzm2r7VpBx6zWX4mfA5LDRpcXeGCnRH89jtGrCfhjlR6FouBgPBBOZFGtiO9qFL/eWfC18LcMm8gt3DNszncJX97RjAMG0NW/xsF/JRHzSm04uI1kmb25nUMir5oZmpy6/fYbcLyTX+S/zS1jYRhsHMY/QOSz1OXRdELaJ3QhQrKMEh7qH+4maKesFX1StndYO+deHtOE253WEwqvc2ABF78UqzCyMjnBqLlFGBRbFZpkHUnf4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3aIRVqI6DreWz5nkAziOrWK2T/+jFrpKOkqXtsTVUU=;
 b=aWbbOvLSSfluI6KqaQ3oQdczsKmjKMjBC8L42MbmbuGkj3cisI0GSp6w6CnHz+HwIcApQ2EcsIqyZbG8YzzAcl5WQuVU2OKiVWfNVeSPIAdCzHHDBw9idm/wVQ+JkDQfvUUZIOk97ObxE/3iPXQ/8KBMqNFXdFgr1a8sxABnT+MYcMQhai2WthcFa0uNUySvGrtZZiGhm9N8pjtn4JItJcPvoP1DeBoudf8Nn1T2uC+kZaMjiXzKYNymMrbsz+YP4XmuEFT0IGqIa3CHHij8TPDlmR4mPHV2idlKr+yH+dJ2HJO2AQQ8PpVA2t08GBMFNs2eQLL3FD0SfqG09slwJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KU2PPFC0B102DF4.apcprd02.prod.outlook.com (2603:1096:d18::467)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.27; Thu, 23 Jul
 2026 08:41:33 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:41:32 +0000
Date: Thu, 23 Jul 2026 16:41:25 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Junze Cao <caojunze424@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/3] hw/misc: Add K230 DDR controller and PHY models
Message-ID: <amHToqJqAYFWtDvL@ChaodeMacBook-Pro.local>
References: <20260716132423.931427-1-caojunze424@gmail.com>
 <20260716132423.931427-2-caojunze424@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716132423.931427-2-caojunze424@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::14) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KU2PPFC0B102DF4:EE_
X-MS-Office365-Filtering-Correlation-Id: 245e5b61-ac25-4695-b127-08dee896322d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|7416014|23010399003|366016|376014|1800799024|6133799003|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gU1vtyzjrihsYPop6wFgCPFDoDeRHO21yEoxJcMHPpP6/R+3twU8dC4+/huIjmakAuTOZskWNz7zqGFc0e+wYe4yB2BETp1ho2YGl75PMtMFREWouVMxSrB2GspJ7vQuCxzydCpwvK5RqEjyoyxTiaxqQH9o3C8bnFZ7bKm0mPTHhIja90EGbA9OzvIKGVndgN8M9OHWJyXrDz8kHtDd7uIQ2HfuDJDQNKOJPGNxtnn8Sd4tKSxVXeQbW/c0rT+xwKKDYfeM+yEkfXI0z0JsugmJIegA+jpoteIYlJy4erO38P/H6oMAWmunspNO7dJIxaAkQaG7aX8CAJ+K7G6enuRQWe86CP25dyVdF4REvIGlGYzuGDNS+qYqSK72cDjzizGJqCKykAscPuIwOk6/UrnfpgjZGxzEOzJ5tavKT1fy/kxhmN6CuqQkL1VkgqhjRaamXHrNCsoZOvFGd/pcfI/XYuMPakDO0Bha9EZz2cDlCHA0/WJak6xUV4IHLG/Cef6V2nRmKaqD/WQaFOxvaJAFbhczHGv4SPC1mz7sSebY2S6lt6s3unMr3O7L348G/Zsd0lb83j+AKO2ZrrARJ4qgdrdoL8WUTMRwtj20gn8Ejunjg/7uJmIAPuVLI7OneEio1fjYJ3F8aWM9J2J7V8pCaEg90QBVSRcGt4epm6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FmNig0mBzVIrk5aFN1VFhPfzG65F1axNtu7pXdEr6WgNMn/d8JKMGBRbVWlY?=
 =?us-ascii?Q?fwaGe0JRM4bdc9uaTN9JB239m4F8QRwEzyxXaobE2VWVYodLR7MQR9Od7M+i?=
 =?us-ascii?Q?2f8HltSmZDR8h3NATaMpm5ecWDiG3YQl8+udR8+joQoAwW+d5oN4yan7ERiE?=
 =?us-ascii?Q?HBuZO+zl/0ZMKcTWhXDIzFiLMezdumwbzKjVIrTmpbbc51R9HPttH/c52v63?=
 =?us-ascii?Q?Ja0uhvVCyYGMbaoqu9KXxR2060GZAhUPFjfliMRyniEN1UYBfpj9BvDxQ0t0?=
 =?us-ascii?Q?qGY4Lt2ZRPjJkzKIudbr0WSBm09XWoSlJt/7bHcdk1NaBX5xzhPLWLoY6gN0?=
 =?us-ascii?Q?1JVDYjebGwdUNM02himvletBU/kpQp1+ZRt5+205IHM0XHmsmOurefzRWgXy?=
 =?us-ascii?Q?OLNJesjVFVeaBJpAe7EvkRVbmpOEtehbMo5eSDi791b1Cm2L/nLXDP/D+HAs?=
 =?us-ascii?Q?RAmMXt6s0E3lqNTxEN37l5ehWZGXVvJyyBNi3c9Ivq1a4+AGGdSaV8H7oWqs?=
 =?us-ascii?Q?zCkD/gdFn2JcvkGfzEPX6pUZtVOiFKnn/QzYoHxon2a2WkKM36fpa22Q/LuL?=
 =?us-ascii?Q?7w8+7hyEAbmLsbWlN4eafr5WrTnmDVFts8ZdF9DKiOggzfOxsAtIoqXzAeDd?=
 =?us-ascii?Q?8ZGh+AH4r73e/wdCHa9oacwHw6w8S0uDfEy2xkp/KGy0BIjQ1c9216FZ3676?=
 =?us-ascii?Q?7+D8iFVHIx/MrrCkKB8MzO9WeQWZLs+EHDqdynXBeKNTK6JMlfCTpHTnB1Mi?=
 =?us-ascii?Q?XgG0YAlPJfoizf9qUsdlDaR4yu6PcUxk3cPZ32CHzy9G+9JWqXO2I2QtyhSi?=
 =?us-ascii?Q?Ut91SU1TfIUhuROG5LqWGnCpwVvi1Y7TaQJs/01dIcLnkfgz5XK27HXrt6Ki?=
 =?us-ascii?Q?Qdm5KGh642GjxQ/gaobI2Dv5/L6qik6/ZebGfz9T8E267IKDYmv5XverkNHA?=
 =?us-ascii?Q?PXaENF/IR/4Fi/etpmGkbvZWGl//REuXy5ohJJI1438j0N6VtBpOkvk5AT4Q?=
 =?us-ascii?Q?EBxMPpoEPfwqvTfvx8FP1aW5HY3rOD8CM27PStTSSoSQwYkxhukBYWRyQQLi?=
 =?us-ascii?Q?RDDXJKOGKmvuL6px9YuZaT8AXK1PPmtZXEFGUEmUFGuHm/0IGkE2eeyzZqS4?=
 =?us-ascii?Q?qRhCKlJzw9o7kNMGp5lAsdOxtqYgUtQVF61qP09/ajfO7ljwOFZmQduMoJ61?=
 =?us-ascii?Q?EUrIbQ7emlZZrbUTahdgE1Ce31LWWMcUHk5LSuXlI+mE296qgll75RTMtvwL?=
 =?us-ascii?Q?LQo1ReCXfSY0XARzPEQXv01f5AYQB1cseQhXTJPNfVOA+OUzGoJt2HUCMh23?=
 =?us-ascii?Q?hnb5hDKOPseTKiktxmtgMiRvpLFiDOXWuFeTEUAFq7vcn2TCicXsAQera9uy?=
 =?us-ascii?Q?Y0Ynm5MoYk1Y79CcsVNbYMVUKB57iyVTGLc8xI2VR0qtF7LHTdVCZeWNqaQp?=
 =?us-ascii?Q?lLtFuruZo5XB+lMgR/pCSzhuSJ0PrSVEt0sYTWngdftErzL/f8hxxuPEEJ4h?=
 =?us-ascii?Q?aZExggdQbJPR3Epx1tjPhxiGaNxdc1OiUDvSqaGxKJz6Tn6pIAGi6b03gFW3?=
 =?us-ascii?Q?o4SsO3hEdY1mHLdlnZlJ8dXm0aNEMopnsQJipd5t7DrP9NnPVjE+mrVxgrrw?=
 =?us-ascii?Q?PdBu6HwVyGBGuQb7htO27eJiud45R1H1E3X3+9MzbBHbsnKHkmBHoKIYtzjt?=
 =?us-ascii?Q?MtDX9j2Ci+CpnNq0y/UxKk1+cP4CiRAxHGYgkUpHokv3zn1fRFFDzew82vOJ?=
 =?us-ascii?Q?pxFoSRUzsG8snqoD97BHlXNDzyrPT8o=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245e5b61-ac25-4695-b127-08dee896322d
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:41:32.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YI8A9Ei7mc0tGh3nqN1B3TxWuTZXWallVmSWDr21LCivgI79hR/3cNWkJV+rYYdsonldQbemw9/+2jJIGDQy86urH2/RtsJlzVJft6aYzds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFC0B102DF4
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
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

On Thu, Jul 16, 2026 at 09:24:21PM +0800, Junze Cao wrote:
> The K230 SDK U-Boot SPL programs K230 DDRC CFG and K230 DDR PHY
> registers before DRAM can be used.
> 
> Add separate SysBus devices for both register ranges. Model controller
> reset values, DFI and software-update handshakes. For the PHY, model
> register ownership, the training mailbox, and DFI completion.
> 
> Include migration state for both devices.
> 
> Signed-off-by: Junze Cao <caojunze424@gmail.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  MAINTAINERS                |   2 +
>  hw/misc/k230_ddr.c         | 544 +++++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build        |   1 +
>  include/hw/misc/k230_ddr.h |  59 ++++
>  4 files changed, 606 insertions(+)
>  create mode 100644 hw/misc/k230_ddr.c
>  create mode 100644 include/hw/misc/k230_ddr.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecb8cfdc41..1cb3ef6c02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1826,8 +1826,10 @@ M: Chao Liu <chao.liu@processmission.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: docs/system/riscv/k230.rst
> +F: hw/misc/k230_ddr.c
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
> +F: include/hw/misc/k230_ddr.h
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
>  F: tests/functional/riscv64/test_k230.py
> diff --git a/hw/misc/k230_ddr.c b/hw/misc/k230_ddr.c
> new file mode 100644
> index 0000000000..9ff2714e34
> --- /dev/null
> +++ b/hw/misc/k230_ddr.c
> @@ -0,0 +1,544 @@
> +/*
> + * Kendryte K230 DDR controller and PHY models
> + *
> + * Models the K230 DDRC CFG registers and K230 DDR PHY registers exercised
> + * by the K230 SDK U-Boot SPL.
> + *
> + * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "migration/vmstate.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/resettable.h"
> +#include "hw/misc/k230_ddr.h"
> +
> +/* DDRC CFG registers */
> +
> +enum K230DDRCOperatingMode {
> +    K230_DDRC_MODE_INIT = 0,
> +    K230_DDRC_MODE_NORMAL = 1,
> +};
> +
> +REG32(K230_DDRC_MSTR, 0x000)
> +
> +REG32(K230_DDRC_STAT, 0x004)
> +    FIELD(K230_DDRC_STAT, OPERATING_MODE, 0, 3)
> +
> +REG32(K230_DDRC_PWRCTL, 0x030)
> +
> +REG32(K230_DDRC_RFSHCTL0, 0x050)
> +
> +REG32(K230_DDRC_RFSHTMG, 0x064)
> +
> +REG32(K230_DDRC_RFSHTMG1, 0x068)
> +
> +REG32(K230_DDRC_INIT0, 0x0d0)
> +
> +REG32(K230_DDRC_INIT2, 0x0d8)
> +
> +REG32(K230_DDRC_INIT3, 0x0dc)
> +
> +REG32(K230_DDRC_INIT5, 0x0e4)
> +
> +REG32(K230_DDRC_DRAMTMG0, 0x100)
> +#define R_K230_DDRC_DRAMTMG(index) \
> +    (R_K230_DDRC_DRAMTMG0 + (index))
> +
> +REG32(K230_DDRC_ZQCTL0, 0x180)
> +
> +REG32(K230_DDRC_ZQCTL1, 0x184)
> +
> +REG32(K230_DDRC_ZQCTL2, 0x188)
> +
> +REG32(K230_DDRC_ZQSTAT, 0x18c)
> +
> +REG32(K230_DDRC_DFITMG0, 0x190)
> +
> +REG32(K230_DDRC_DFITMG1, 0x194)
> +
> +REG32(K230_DDRC_DFIUPD0, 0x1a0)
> +
> +REG32(K230_DDRC_DFIUPD1, 0x1a4)
> +
> +REG32(K230_DDRC_DFIUPD2, 0x1a8)
> +
> +REG32(K230_DDRC_DFIMISC, 0x1b0)
> +    FIELD(K230_DDRC_DFIMISC, DFI_INIT_COMPLETE_EN, 0, 1)
> +    FIELD(K230_DDRC_DFIMISC, DFI_INIT_START, 5, 1)
> +
> +REG32(K230_DDRC_DFITMG2, 0x1b4)
> +
> +REG32(K230_DDRC_DFISTAT, 0x1bc)
> +    FIELD(K230_DDRC_DFISTAT, DFI_INIT_COMPLETE, 0, 1)
> +
> +REG32(K230_DDRC_ODTCFG, 0x240)
> +
> +REG32(K230_DDRC_SWCTL, 0x320)
> +    FIELD(K230_DDRC_SWCTL, SW_DONE, 0, 1)
> +
> +REG32(K230_DDRC_SWSTAT, 0x324)
> +    FIELD(K230_DDRC_SWSTAT, SW_DONE_ACK, 0, 1)
> +
> +static const uint32_t k230_ddrc_reset_values[K230_DDRC_REG_COUNT] = {
> +    [R_K230_DDRC_MSTR]      = 0x01040000,
> +    [R_K230_DDRC_RFSHCTL0]  = 0x00210000,
> +    [R_K230_DDRC_RFSHTMG]   = 0x0062008c,
> +    [R_K230_DDRC_RFSHTMG1]  = 0x0000008c,
> +    [R_K230_DDRC_INIT0]     = 0x0002004e,
> +    [R_K230_DDRC_INIT3]     = 0x00000510,
> +    [R_K230_DDRC_INIT5]     = 0x00100000,
> +    [R_K230_DDRC_DRAMTMG(0)]  = 0x0f101b0f,
> +    [R_K230_DDRC_DRAMTMG(1)]  = 0x00080414,
> +    [R_K230_DDRC_DRAMTMG(2)]  = 0x0305060d,
> +    [R_K230_DDRC_DRAMTMG(3)]  = 0x00004000,
> +    [R_K230_DDRC_DRAMTMG(4)]  = 0x05040405,
> +    [R_K230_DDRC_DRAMTMG(5)]  = 0x05050403,
> +    [R_K230_DDRC_DRAMTMG(6)]  = 0x02020005,
> +    [R_K230_DDRC_DRAMTMG(7)]  = 0x00000202,
> +    [R_K230_DDRC_DRAMTMG(8)]  = 0x03034405,
> +    [R_K230_DDRC_DRAMTMG(9)]  = 0x0004040d,
> +    [R_K230_DDRC_DRAMTMG(10)] = 0x001c180a,
> +    [R_K230_DDRC_DRAMTMG(11)] = 0x440c021c,
> +    [R_K230_DDRC_DRAMTMG(12)] = 0x00020610,
> +    [R_K230_DDRC_DRAMTMG(13)] = 0x1c200004,
> +    [R_K230_DDRC_DRAMTMG(14)] = 0x000000a0,
> +    [R_K230_DDRC_DRAMTMG(16)] = 0x05100404,
> +    [R_K230_DDRC_ZQCTL0]    = 0x02000040,
> +    [R_K230_DDRC_ZQCTL1]    = 0x02000100,
> +    [R_K230_DDRC_DFITMG0]   = 0x07020002,
> +    [R_K230_DDRC_DFITMG1]   = 0x00000404,
> +    [R_K230_DDRC_DFIUPD0]   = 0x00400003,
> +    [R_K230_DDRC_DFIUPD1]   = 0x00010001,
> +    [R_K230_DDRC_DFIUPD2]   = 0x80000000,
> +    [R_K230_DDRC_DFIMISC]   = 0x00000001,
> +    [R_K230_DDRC_DFITMG2]   = 0x00000202,
> +    [R_K230_DDRC_ODTCFG]    = 0x04000400,
> +    [R_K230_DDRC_SWCTL]     = 0x00000001,
> +    [R_K230_DDRC_SWSTAT]    = 0x00000001,
> +};
> +
> +/* K230 DDR PHY CSRs use byte offset = CSR index * 4. */
> +#define K230_DDR_PHY_CSR_OFFSET(index) ((index) * 4)
> +#define K230_DDR_PHY_MASTER_CSR(reg) \
> +    K230_DDR_PHY_CSR_OFFSET(0x20000 + (reg))
> +#define K230_DDR_PHY_APBONLY_CSR(reg) \
> +    K230_DDR_PHY_CSR_OFFSET(0xd0000 + (reg))
> +
> +#define K230_DDR_PHY_ATX_IMPEDANCE_RESET UINT32_C(0x03ff)
> +
> +REG32(K230_DDR_PHY_MICRO_CONT_MUX_SEL,
> +      K230_DDR_PHY_APBONLY_CSR(0x000))
> +    FIELD(K230_DDR_PHY_MICRO_CONT_MUX_SEL, MICRO_CONT_MUX_SEL, 0, 1)
> +
> +REG32(K230_DDR_PHY_TRAINING_STATUS,
> +      K230_DDR_PHY_APBONLY_CSR(0x004))
> +    FIELD(K230_DDR_PHY_TRAINING_STATUS, MAILBOX_EMPTY, 0, 1)
> +
> +REG32(K230_DDR_PHY_TRAINING_ACK,
> +      K230_DDR_PHY_APBONLY_CSR(0x031))
> +
> +REG32(K230_DDR_PHY_TRAINING_MESSAGE,
> +      K230_DDR_PHY_APBONLY_CSR(0x032))
> +
> +REG32(K230_DDR_PHY_TRAINING_TRIGGER,
> +      K230_DDR_PHY_APBONLY_CSR(0x099))
> +
> +#define K230_DDR_PHY_TX_IMPEDANCE_CTRL1_RESET UINT32_C(0x0fff)
> +
> +REG32(K230_DDR_PHY_DFI_INIT_COMPLETE,
> +      K230_DDR_PHY_MASTER_CSR(0x0f9))
> +    FIELD(K230_DDR_PHY_DFI_INIT_COMPLETE, DFI_INIT_COMPLETE, 0, 1)
> +
> +REG32(K230_DDR_PHY_VREF_IN_GLOBAL,
> +      K230_DDR_PHY_MASTER_CSR(0x0b2))
> +#define K230_DDR_PHY_VREF_IN_GLOBAL_RESET UINT32_C(0x0200)
> +
> +static void k230_ddr_cfg_update_state(K230DDRCfgState *s)
> +{
> +    bool dfi_complete = false;
> +    unsigned int operating_mode = K230_DDRC_MODE_INIT;
> +
> +    if (s->phy) {
> +        dfi_complete = FIELD_EX32(s->phy->dfi_init_complete,
> +                                  K230_DDR_PHY_DFI_INIT_COMPLETE,
> +                                  DFI_INIT_COMPLETE);
> +    }
> +
> +    ARRAY_FIELD_DP32(s->regs, K230_DDRC_DFISTAT,
> +                     DFI_INIT_COMPLETE, dfi_complete);
> +    ARRAY_FIELD_DP32(s->regs, K230_DDRC_SWSTAT, SW_DONE_ACK,
> +                     ARRAY_FIELD_EX32(s->regs, K230_DDRC_SWCTL, SW_DONE));
> +
> +    if (dfi_complete &&
> +        ARRAY_FIELD_EX32(s->regs, K230_DDRC_DFIMISC,
> +                         DFI_INIT_COMPLETE_EN)) {
> +        s->initialized = true;
> +    }
> +
> +    if (s->initialized) {
> +        operating_mode = K230_DDRC_MODE_NORMAL;
> +    }
> +
> +    ARRAY_FIELD_DP32(s->regs, K230_DDRC_STAT,
> +                     OPERATING_MODE, operating_mode);
> +}
> +
> +static uint64_t k230_ddr_cfg_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    K230DDRCfgState *s = opaque;
> +    uint64_t value = 0;
> +
> +    if (addr < K230_DDRC_REG_SIZE) {
> +        k230_ddr_cfg_update_state(s);
> +        value = s->regs[addr / sizeof(uint32_t)];
> +    }
> +
> +    return value;
> +}
> +
> +static void k230_ddr_cfg_write(void *opaque, hwaddr addr, uint64_t value,
> +                               unsigned int size)
> +{
> +    K230DDRCfgState *s = opaque;
> +    uint32_t val = value;
> +
> +    if (addr >= K230_DDRC_REG_SIZE) {
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case A_K230_DDRC_STAT:
> +    case A_K230_DDRC_DFISTAT:
> +    case A_K230_DDRC_ZQSTAT:
> +    case A_K230_DDRC_SWSTAT:
> +        return;
> +    case A_K230_DDRC_PWRCTL:
> +        s->regs[R_K230_DDRC_PWRCTL] = val & MAKE_64BIT_MASK(0, 9);
> +        break;
> +    case A_K230_DDRC_ZQCTL2:
> +        /* ZQ reset completes immediately and the W1S bit self-clears. */
> +        s->regs[R_K230_DDRC_ZQCTL2] = 0;
> +        s->regs[R_K230_DDRC_ZQSTAT] = 0;
> +        break;
> +    case A_K230_DDRC_DFIMISC:
> +        s->regs[R_K230_DDRC_DFIMISC] =
> +            val & (MAKE_64BIT_MASK(0, 6) | MAKE_64BIT_MASK(8, 5));
> +        if (s->phy && s->phy->training_complete &&
> +            FIELD_EX32(val, K230_DDRC_DFIMISC, DFI_INIT_START)) {
> +            s->phy->dfi_init_complete = FIELD_DP32(
> +                s->phy->dfi_init_complete,
> +                K230_DDR_PHY_DFI_INIT_COMPLETE, DFI_INIT_COMPLETE, 1);
> +        }
> +        break;
> +    case A_K230_DDRC_SWCTL:
> +        s->regs[R_K230_DDRC_SWCTL] =
> +            val & R_K230_DDRC_SWCTL_SW_DONE_MASK;
> +        break;
> +    default:
> +        s->regs[addr / sizeof(uint32_t)] = val;
> +        break;
> +    }
> +
> +    k230_ddr_cfg_update_state(s);
> +}
> +
> +static bool k230_ddr_phy_decode_anib(hwaddr addr, unsigned int *anib)
> +{
> +    uint32_t csr = addr / sizeof(uint32_t);
> +
> +    if ((csr & 0xfff) != 0x043) {
> +        return false;
> +    }
> +
> +    *anib = csr >> 12;
> +    return *anib < K230_DDR_PHY_ANIB_COUNT;
> +}
> +
> +static bool k230_ddr_phy_decode_dbyte(hwaddr addr, uint32_t reg,
> +                                     unsigned int *dbyte,
> +                                     unsigned int *nibble)
> +{
> +    uint32_t csr = addr / sizeof(uint32_t);
> +    uint32_t block_offset;
> +
> +    if (csr < 0x10000) {
> +        return false;
> +    }
> +
> +    csr -= 0x10000;
> +    *dbyte = csr >> 12;
> +    if (*dbyte >= K230_DDR_PHY_DBYTE_COUNT) {
> +        return false;
> +    }
> +
> +    block_offset = csr & 0xfff;
> +    *nibble = block_offset >> 8;
> +    return *nibble < K230_DDR_PHY_NIBBLES_PER_DBYTE &&
> +           (block_offset & 0xff) == reg;
> +}
> +
> +static uint64_t k230_ddr_phy_read(void *opaque, hwaddr addr,
> +                                  unsigned int size)
> +{
> +    K230DDRPhyState *s = opaque;
> +    unsigned int dbyte;
> +    unsigned int nibble;
> +    unsigned int anib;
> +    uint64_t value = 0;
> +
> +    switch (addr) {
> +    case A_K230_DDR_PHY_MICRO_CONT_MUX_SEL:
> +        value = s->micro_cont_mux_sel;
> +        break;
> +    case A_K230_DDR_PHY_TRAINING_STATUS:
> +        value = s->mailbox_message_pending ? 0 :
> +                R_K230_DDR_PHY_TRAINING_STATUS_MAILBOX_EMPTY_MASK;
> +        break;
> +    case A_K230_DDR_PHY_TRAINING_MESSAGE:
> +        value = s->training_complete ? 0x07 : 0;
> +        break;
> +    case A_K230_DDR_PHY_TRAINING_ACK:
> +    case A_K230_DDR_PHY_TRAINING_TRIGGER:
> +        break;
> +    case A_K230_DDR_PHY_DFI_INIT_COMPLETE:
> +        value = s->dfi_init_complete;
> +        break;
> +    case A_K230_DDR_PHY_VREF_IN_GLOBAL:
> +        value = s->vref_in_global;
> +        break;
> +    default:
> +        if (k230_ddr_phy_decode_anib(addr, &anib)) {
> +            value = s->atx_impedance[anib];
> +        } else if (k230_ddr_phy_decode_dbyte(addr, 0x049,
> +                                            &dbyte, &nibble)) {
> +            value = s->tx_impedance_ctrl1[dbyte][nibble];
> +        } else if (k230_ddr_phy_decode_dbyte(addr, 0x04d,
> +                                            &dbyte, &nibble)) {
> +            value = s->tx_odt_drv_stren[dbyte][nibble];
> +        }
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +static void k230_ddr_phy_write(void *opaque, hwaddr addr, uint64_t value,
> +                               unsigned int size)
> +{
> +    K230DDRPhyState *s = opaque;
> +    uint16_t val = value;
> +    unsigned int dbyte;
> +    unsigned int nibble;
> +    unsigned int anib;
> +
> +    switch (addr) {
> +    case A_K230_DDR_PHY_MICRO_CONT_MUX_SEL:
> +        s->micro_cont_mux_sel =
> +            val & R_K230_DDR_PHY_MICRO_CONT_MUX_SEL_MICRO_CONT_MUX_SEL_MASK;
> +        return;
> +    case A_K230_DDR_PHY_TRAINING_STATUS:
> +    case A_K230_DDR_PHY_TRAINING_MESSAGE:
> +        return;
> +    case A_K230_DDR_PHY_TRAINING_ACK:
> +        if (val == 0) {
> +            s->mailbox_message_pending = false;
> +        }
> +        return;
> +    case A_K230_DDR_PHY_TRAINING_TRIGGER:
> +        if (val != 0) {
> +            s->training_trigger_seen = true;
> +        } else if (s->training_trigger_seen) {
> +            /* Abstract the loaded firmware run to its final mailbox message. */
> +            s->training_trigger_seen = false;
> +            s->training_complete = true;
> +            s->mailbox_message_pending = true;
> +        }
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    if (FIELD_EX32(s->micro_cont_mux_sel,
> +                   K230_DDR_PHY_MICRO_CONT_MUX_SEL,
> +                   MICRO_CONT_MUX_SEL)) {
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case A_K230_DDR_PHY_DFI_INIT_COMPLETE:
> +        s->dfi_init_complete =
> +            val & R_K230_DDR_PHY_DFI_INIT_COMPLETE_DFI_INIT_COMPLETE_MASK;
> +        return;
> +    case A_K230_DDR_PHY_VREF_IN_GLOBAL:
> +        s->vref_in_global = val & UINT16_C(0x7fff);
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    if (k230_ddr_phy_decode_anib(addr, &anib)) {
> +        s->atx_impedance[anib] = val & UINT16_C(0x03ff);
> +        return;
> +    }
> +
> +    if (k230_ddr_phy_decode_dbyte(addr, 0x049, &dbyte, &nibble)) {
> +        s->tx_impedance_ctrl1[dbyte][nibble] = val & UINT16_C(0x0fff);
> +        return;
> +    }
> +
> +    if (k230_ddr_phy_decode_dbyte(addr, 0x04d, &dbyte, &nibble)) {
> +        s->tx_odt_drv_stren[dbyte][nibble] = val & UINT16_C(0x0fff);
> +    }
> +}
> +
> +static const MemoryRegionOps k230_ddr_cfg_ops = {
> +    .read = k230_ddr_cfg_read,
> +    .write = k230_ddr_cfg_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static const MemoryRegionOps k230_ddr_phy_ops = {
> +    .read = k230_ddr_phy_read,
> +    .write = k230_ddr_phy_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void k230_ddr_cfg_init(Object *obj)
> +{
> +    K230DDRCfgState *s = K230_DDR_CFG(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &k230_ddr_cfg_ops, s,
> +                          "k230-ddr-cfg", K230_DDRC_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void k230_ddr_phy_init(Object *obj)
> +{
> +    K230DDRPhyState *s = K230_DDR_PHY(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &k230_ddr_phy_ops, s,
> +                          "k230-ddr-phy", K230_DDR_PHY_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void k230_ddr_cfg_reset_enter(Object *obj, ResetType type)
> +{
> +    K230DDRCfgState *s = K230_DDR_CFG(obj);
> +
> +    s->initialized = false;
> +    memcpy(s->regs, k230_ddrc_reset_values, sizeof(s->regs));
> +}
> +
> +static void k230_ddr_phy_reset_enter(Object *obj, ResetType type)
> +{
> +    K230DDRPhyState *s = K230_DDR_PHY(obj);
> +    unsigned int dbyte;
> +    unsigned int nibble;
> +    unsigned int anib;
> +
> +    memset(s->tx_odt_drv_stren, 0, sizeof(s->tx_odt_drv_stren));
> +
> +    for (anib = 0; anib < ARRAY_SIZE(s->atx_impedance); anib++) {
> +        s->atx_impedance[anib] = K230_DDR_PHY_ATX_IMPEDANCE_RESET;
> +    }
> +
> +    for (dbyte = 0; dbyte < ARRAY_SIZE(s->tx_impedance_ctrl1); dbyte++) {
> +        for (nibble = 0;
> +             nibble < ARRAY_SIZE(s->tx_impedance_ctrl1[dbyte]); nibble++) {
> +            s->tx_impedance_ctrl1[dbyte][nibble] =
> +                K230_DDR_PHY_TX_IMPEDANCE_CTRL1_RESET;
> +        }
> +    }
> +
> +    s->dfi_init_complete = 0;
> +    s->vref_in_global = K230_DDR_PHY_VREF_IN_GLOBAL_RESET;
> +    s->micro_cont_mux_sel = 0;
> +    s->training_trigger_seen = false;
> +    s->training_complete = false;
> +    s->mailbox_message_pending = false;
> +}
> +
> +static const VMStateDescription vmstate_k230_ddr_cfg = {
> +    .name = "k230-ddr-cfg",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, K230DDRCfgState, K230_DDRC_REG_COUNT),
> +        VMSTATE_BOOL(initialized, K230DDRCfgState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_k230_ddr_phy = {
> +    .name = "k230-ddr-phy",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT16_ARRAY(atx_impedance, K230DDRPhyState,
> +                             K230_DDR_PHY_ANIB_COUNT),
> +        VMSTATE_UINT16_2DARRAY(tx_impedance_ctrl1, K230DDRPhyState,
> +                               K230_DDR_PHY_DBYTE_COUNT,
> +                               K230_DDR_PHY_NIBBLES_PER_DBYTE),
> +        VMSTATE_UINT16_2DARRAY(tx_odt_drv_stren, K230DDRPhyState,
> +                               K230_DDR_PHY_DBYTE_COUNT,
> +                               K230_DDR_PHY_NIBBLES_PER_DBYTE),
> +        VMSTATE_UINT16(dfi_init_complete, K230DDRPhyState),
> +        VMSTATE_UINT16(vref_in_global, K230DDRPhyState),
> +        VMSTATE_UINT16(micro_cont_mux_sel, K230DDRPhyState),
> +        VMSTATE_BOOL(training_trigger_seen, K230DDRPhyState),
> +        VMSTATE_BOOL(training_complete, K230DDRPhyState),
> +        VMSTATE_BOOL(mailbox_message_pending, K230DDRPhyState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void k230_ddr_cfg_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.enter = k230_ddr_cfg_reset_enter;
> +    dc->vmsd = &vmstate_k230_ddr_cfg;
> +}
> +
> +static void k230_ddr_phy_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.enter = k230_ddr_phy_reset_enter;
> +    dc->vmsd = &vmstate_k230_ddr_phy;
> +}
> +
> +static const TypeInfo k230_ddr_types[] = {
> +    {
> +        .name = TYPE_K230_DDR_CFG,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(K230DDRCfgState),
> +        .instance_init = k230_ddr_cfg_init,
> +        .class_init = k230_ddr_cfg_class_init,
> +    },
> +    {
> +        .name = TYPE_K230_DDR_PHY,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(K230DDRPhyState),
> +        .instance_init = k230_ddr_phy_init,
> +        .class_init = k230_ddr_phy_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(k230_ddr_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..6d5e2b2647 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -28,6 +28,7 @@ system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
>  system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
>  
>  # RISC-V devices
> +system_ss.add(when: 'CONFIG_K230', if_true: files('k230_ddr.c'))
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
> diff --git a/include/hw/misc/k230_ddr.h b/include/hw/misc/k230_ddr.h
> new file mode 100644
> index 0000000000..d912e8e1b0
> --- /dev/null
> +++ b/include/hw/misc/k230_ddr.h
> @@ -0,0 +1,59 @@
> +/*
> + * Kendryte K230 DDR controller and PHY models
> + *
> + * Device state and type declarations for the K230 DDRC CFG and K230 DDR PHY
> + * registers.
> + *
> + * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_DDR_H
> +#define HW_MISC_K230_DDR_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define K230_DDRC_MMIO_SIZE    0x02000000
> +#define K230_DDR_PHY_MMIO_SIZE 0x00400000
> +
> +#define K230_DDRC_REG_SIZE  0x328
> +#define K230_DDRC_REG_COUNT (K230_DDRC_REG_SIZE / sizeof(uint32_t))
> +
> +#define K230_DDR_PHY_ANIB_COUNT             10
> +#define K230_DDR_PHY_DBYTE_COUNT             4
> +#define K230_DDR_PHY_NIBBLES_PER_DBYTE       2
> +
> +#define TYPE_K230_DDR_CFG "riscv.k230.ddr-cfg"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230DDRCfgState, K230_DDR_CFG)
> +
> +#define TYPE_K230_DDR_PHY "riscv.k230.ddr-phy"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230DDRPhyState, K230_DDR_PHY)
> +
> +struct K230DDRCfgState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    K230DDRPhyState *phy;
> +    uint32_t regs[K230_DDRC_REG_COUNT];
> +    bool initialized;
> +};
> +
> +struct K230DDRPhyState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint16_t atx_impedance[K230_DDR_PHY_ANIB_COUNT];
> +    uint16_t tx_impedance_ctrl1[K230_DDR_PHY_DBYTE_COUNT]
> +                                [K230_DDR_PHY_NIBBLES_PER_DBYTE];
> +    uint16_t tx_odt_drv_stren[K230_DDR_PHY_DBYTE_COUNT]
> +                             [K230_DDR_PHY_NIBBLES_PER_DBYTE];
> +    uint16_t dfi_init_complete;
> +    uint16_t vref_in_global;
> +    uint16_t micro_cont_mux_sel;
> +    bool training_trigger_seen;
> +    bool training_complete;
> +    bool mailbox_message_pending;
> +};
> +
> +#endif
> -- 
> 2.53.0
> 

