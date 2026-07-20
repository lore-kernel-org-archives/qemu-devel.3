Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE57CC44525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlkWn-0007sZ-GW; Mon, 20 Jul 2026 05:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wlkWh-0007pd-5j; Mon, 20 Jul 2026 05:43:07 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wlkWe-0001s4-BL; Mon, 20 Jul 2026 05:43:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI8Eoo+THxLlSPILXJypgvIbb2PoEW93ieSGNaBdFTSeeGYi9Akg1qf/KlchqVYLz8KAsX5qlZYPxte0FB89Zzpqixaipb7YSk+D+99uNgDeBXJ17b+F5DqND8+Wd9ITLseERDWy84su3Pk2b4IPAnkav8iMZ2kpslUfWNqKEyDtASkilQEahExipT6JHlnoCwg7HInoyh4MW8nCNeDktx9NPQ18iHd57dKxIG+Lcw9iD++rrzY1xN/cZTR08BjGhm05caktCJ7CGlHGV902fKHUuLle1Yh31KLFJpDp+r6LsHGl7rxOnBBXFD/kXceRbplhwPNRGbuhBAQ4hsUwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLGPmM1WJqpJv5PV1ncLkJ4WrhQ6d/4a4AaKzra5Wtk=;
 b=lpXXS5ZzaVNu0zbdMwcK1dpEJ8Cjhl0tSN/DizgorjDA8H7f12jjFUXCGMtNNoRmfAL74Ffo110PpGk1oMOZFIVhvxh4ZzNzfVvhh9L8xHl8eq39wwT6YaHJ76kp75dWJsByWBSJsWZh8LzewzegjStmWzdgz/rc5hMEI6Svl/kuhwOP18l7bX+jsj/AZwCMMRr7Ez0wUnYx7m6GjCe+X70vjdyfGKRytAIV2tTERBMh1xdfjWWLjSYQimC3nmhRn17isOAslKFEZv+pekvu06vrQlgnVBj6uCrAfytHKkb1gjNXP+pTPwKGJgTlm4TJDhGV6B2J7NxaeTdHRenv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLGPmM1WJqpJv5PV1ncLkJ4WrhQ6d/4a4AaKzra5Wtk=;
 b=oaED1dMac9G24Ml2jbm+W0/+4o5v3sNpzTwZ+Bt0QGKOfUD9HynbCNwunyFvrSf1zrl0Hf7nKaXk45f7jLc2S8PGwrQyzRSRhDWReYfSbwjCPQT5F41t+8r9d1Grxf1wCAJ/L2qtq1Pd9p0pvbtL5czaVIHncKbSKTQFs6enblfszhY9lhcuarreArJkuimjt1raW3S5QPy1xGIfOyPTynB7+zZiojpnioniA50hRyEozJBij4EvEQre9LA1U30xneTIvpsM4n1aq/OnplEuFPNy2cu9XM7bzt3VZRkjAclS7yg6Hsgs5WWHfd+tL9Jb1ngKPwFXJi8GhOiVpRaHVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB9612.apcprd02.prod.outlook.com (2603:1096:101:330::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 09:42:56 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:42:55 +0000
Date: Mon, 20 Jul 2026 17:42:50 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Jian Cai <lingqian_gi@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [RFC PATCH 1/3] hw/riscv: add K230 SRAM device model
Message-ID: <al3rA90UyfbNANuG@ChaodeMacBook-Pro.local>
References: <20260720074545.8987-1-lingqian_gi@163.com>
 <20260720074545.8987-2-lingqian_gi@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720074545.8987-2-lingqian_gi@163.com>
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f67b7e-3fe1-43fd-5dbb-08dee64346a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|34096008|376014|1800799024|366016|6133799003|56012099006|4143699003|10067099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HVLT71PKKhwlhX+9Jc4c8W1sO/LMfvFxgm5N0mTr+fvMDr4Yn/wHZu9d8ZcOGO6YibEagRysIHiSiwlUMI4krrhIkEJHBQVk2AveSzubYCNgJk/uK+w4wyPHtx2o+TEwRcX2WghvtGoLIsa+m0AawsWQNV+/kmZsGOOEte6ld9msTR5TMxd45MxA1ETsqpm1X62epAcTdabWTg62WxKhr8JITXwVeTyoOfG3zlZ6cINxvrJi6aj8nwYSU85IMmsTrhfrVKLawMEGChd92bZcCVbWScGimIcF79xhDlErLfuo40nqni4HYax3MAt7VbzcLs88LRFziEe2NBRx3WcE7AGky7rJZdTlFaZf79VdKpEIICljmx5LJd8+3vWbTIi88NlkbmoaG+1uOyFCf5D3g+2bpA3hbF0YGgHpTm2D0RKELgXnXETYl3f+W/eFeZheNgtEZrcOpBFNwRpcwNO4jEGTpD6B0qEEemTIP/GcZ0GNjDBZ6tkmbB9J4tYMSi/8a1w+WOYeeShvZQ31+lHB74aL2U6R4MgWixi4Q/ZNoXLs4Cx4uIAI/lgOd+rMFJpHWMe+4EvTjnDRAvXaCt45dU6fbXsl9tYqIuWoA3Tyyk4Faa5k7hywWyHZhl9SNE3h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(34096008)(376014)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?riYwIXo/gNwwWKLotErKx5v8+DJVG2BTgV30zecYGv6hH4vn2W5bfrnb7cqw?=
 =?us-ascii?Q?/fKIbRvfLpXruhg9cM6HClyN/nkIHucbPWgka3p9ktnX40s1QFLme/PNW6WD?=
 =?us-ascii?Q?5bYba9U8J3fKV3LJWcLliGTZ4cuNmmjkCwVcY8Ssn4V8ETOXVxUdR7H5GjAc?=
 =?us-ascii?Q?ttGqC3uDZ7ptpTM/JOemkgfF6xCy+eRGNnjAnPjQu8iQua5GtjVx5FIc4G0Q?=
 =?us-ascii?Q?E4YKTUOiLVn1VPoBGIqXreg1EDHpB8cggSbtcYdj1iarUSukYE/Af4FDrI6v?=
 =?us-ascii?Q?PM1BJSUsT7RPiTgNdcSdX/JiHegQEfOSTDi/OfXBDaLyNVj5/3GfrXHSZwG2?=
 =?us-ascii?Q?AexxKPGhGNNisVxcRO3QIRgMLYZW6LksOGp9/JPdPAdwC6FC/WActqNWXACf?=
 =?us-ascii?Q?/nZ7RP5YEENTgo3qsD2lG1okiGl6l20UQFTYeFZtjJVwzv6nee2J1x4Jldmc?=
 =?us-ascii?Q?+MEsqFrJQe+Oz7vgAKEfstEQBQCuXuosBdXdvfyc/XxoVBYaGB2+rD+vch2y?=
 =?us-ascii?Q?6GoFCf9Mif+KarxdQXJWpZHyHP84TIyZR7MWNjWtvc8IpxA1sEx9XGWOolGX?=
 =?us-ascii?Q?eboaRLw0jRx7K1rzSycDc2rbm3vq86PxJVoAD5k7E8FUw0gueyryd1DErcfP?=
 =?us-ascii?Q?88fR/PHRhzDd+9hgOWbwOjZXAqVTsJCXs6vdI1nN18q65DVx7kJkwx+/XjV+?=
 =?us-ascii?Q?g4PfiP1aApMdk27F8dmBB2tPtG+gdEp+iTR9o5CNu3u3tF3GANVDj2X1S1Fc?=
 =?us-ascii?Q?Ip+PuNcP7wyE5MlUOdOavuVGJFPJPQiGgN0jzUf2zmBl9nP7CRN3ot1Brs33?=
 =?us-ascii?Q?Jv6MFLA5DZGh9ud00/OkoeQ0t0LuJp7dG3a4GcgerauDZLPT5lwDgecRs+So?=
 =?us-ascii?Q?maC4axffQSw4TGANdS6Av+Nd2s4yphxak7rnIy+dhFHSP6iS1TDsxlcPLJf/?=
 =?us-ascii?Q?dKQovuirxDOV/ecErxZ2xXOkXxVf81xcL9TC9dF9KLpVJK+pbAvJh2W+O0pc?=
 =?us-ascii?Q?JcbBGrlCCmWekskvbDqZCy1p7nOyqr5bg5lfjQhNlxI2QyPlGZRZOxC2/lXI?=
 =?us-ascii?Q?vUJzql1/4g4qvrRKusAx8gA3z4WssqIWqQICp6wFqIO+qdor400S5tkKnJNj?=
 =?us-ascii?Q?xsBHvZQYTAHAm7G7MZ6t5mBCrf1nnOW5+gTpwGLQtZV80vskB0/W/IqNLVQH?=
 =?us-ascii?Q?ncmshOM2GLb3uJ3JvBjiz62AiFFQx0RRRL0iqrKupEK04ZezqBGvoH4DSAIm?=
 =?us-ascii?Q?GuOZoMBr5Izdj3JtGhpjx8EdkrlPmXdIi8byhpkmGRX0U+qU9UActJy7PSHw?=
 =?us-ascii?Q?sVIO6TakawMqJWK0kja0A8nC8wTZpqgEJ/jUv2THGSF7kPv99btZw5CNdPER?=
 =?us-ascii?Q?y1i4a+p+3n1baiUCUEwL3k37k7Hn1k21Qvqtf8erNlzcx0tXOhY3BW6c3W8k?=
 =?us-ascii?Q?AWWsgmSgM4in/OdBMZMNdmpU+K088BHreNGlfKOdJWbb6nyihYOiSa2x4a87?=
 =?us-ascii?Q?89Wlj6GDNe5UzJIB0F7ZoxSxVgMn9eJchRR5A30J4XVBiG5oGxHB6aqlywxJ?=
 =?us-ascii?Q?xikDQeisXrTkHG9wSBBglXEYSpe9VXq+21O23gqYBZ7VjOnXFTdqG9vK+uPN?=
 =?us-ascii?Q?3jSge4NdXRWQZX100n4ug9BAbTqdDLFUNdfAZgLwqaCrSHr3m3pfkqgMRph4?=
 =?us-ascii?Q?01WRdPNOXfPGEas20IgukyoEqrngZglNdeYZzNtpeK66ul5Sv1j5QPUT20S0?=
 =?us-ascii?Q?tDgcMX4OnfC/WXHDqMAdM5PUFgNWggo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f67b7e-3fe1-43fd-5dbb-08dee64346a1
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 09:42:55.7118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+KGw2wTpac/wTHuzUaLB0IKEgUBgMsnNfKYPk0WyevyBhTOPpbE8Lc2eL1tv18istYIuRwPxFtEA3DjlvK7iaAHViUM7A7dAWEVvdNEwiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB9612
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
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

Hi Jian,
On Mon, Jul 20, 2026 at 03:45:43PM +0800, Jian Cai wrote:
> The K230 shared SRAM (2 MB at 0x80200000) has no software-visible
> controller registers: it is a pure on-chip RAM block accessed via
> the AXI bus. This patch wraps it as a SysBusDevice so that it appears
> in the QOM tree, supports VMState migration, and can be introspected
> by management tools.
> 
> Clock gating (CMU at 0x91100000, offset 0x5c) and reset control
> (RMU at 0x91101000, offsets 0x60/0x64) are handled by separate
> system-controller peripherals and are not modelled here.
> 
> Reference:
> K230 TRM V0.3.1 (2024-11-18), Section 5.2 Sram
Thanks for the contribution!

But I didn't receive the cover letter for this patch set. Please check if you
prepared one, or if it might have been lost during transmission.

Could you please include a cover letter when you send the next revision
of this series? It should briefly explain what the series does as a
whole and what problem it is intended to solve.

Here are two ways to generate one:

1. Store the cover letter in the branch description:

   git branch --edit-description
   git format-patch --cover-letter --cover-from-description=subject \
       -o outgoing

2. Generate a cover letter template and edit it manually:

   git format-patch --cover-letter -o k230-patches
   $EDITOR k230-patches/0000-cover-letter.patch

In general, a single-patch submission does not need a separate cover
letter. For a multi-patch series like this one, however, we prefer a
cover letter that provides an overview of the whole series.

> 
> Signed-off-by: Jian Cai <lingqian_gi@163.com>
> ---
>  MAINTAINERS                  |  5 +++
>  hw/riscv/k230_sram.c         | 81 ++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/k230_sram.h | 35 ++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 hw/riscv/k230_sram.c
>  create mode 100644 include/hw/riscv/k230_sram.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..3567563ba6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1825,6 +1825,11 @@ L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: docs/system/riscv/k230.rst
>  F: hw/riscv/k230.c
> +F: hw/riscv/k230_sram.c
> +F: include/hw/riscv/k230_sram.h
> +F: hw/riscv/k230_sram.c
> +F: include/hw/riscv/k230_sram.h
> +F: tests/qtest/k230-sram-test.c
>  F: hw/watchdog/k230_wdt.c
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
> diff --git a/hw/riscv/k230_sram.c b/hw/riscv/k230_sram.c
> new file mode 100644
> index 0000000000..1d960e733e
> --- /dev/null
> +++ b/hw/riscv/k230_sram.c
> @@ -0,0 +1,81 @@
> +/*
> + * K230 SRAM Controller
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * The K230 shared SRAM (2 MB at 0x80200000) has no software-visible
> + * controller registers.  This device wraps the SRAM as a SysBusDevice
> + * so that it appears in the QOM tree, supports migration (VMState),
> + * and can be introspected by management tools.
> + *
> + * Clock gating is controlled by the CMU at 0x91100000 (shrm_CLK_CFG,
> + * offset 0x5c, bit 10: sram_aclk_enable).  Reset is controlled by the
> + * RMU at 0x91101000 (SRAM_RST_TIM/SRAM_RST_CTL, offsets 0x60/0x64).
> + * Those peripherals are not modelled yet, so SRAM is always enabled
> + * in the current QEMU implementation.
> + *
> + * Copyright (c) 2026 Jian Cai <lingqian_gi@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
We probably don't need to create a dedicated device model for SRAM.
It can actually be replaced directly by using a QEMU memory region RAM.

A simpler approach would be to keep this code in k230.c, perhaps in a
helper function such as k230_sram_create().

Thanks,
Chao
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "hw/core/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "hw/riscv/k230_sram.h"
> +
> +static void k230_sram_realize(DeviceState *dev, Error **errp)
> +{
> +    K230SramState *s = K230_SRAM(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_ram(&s->sram, OBJECT(dev), "k230.sram",
> +                           2 * MiB, &error_fatal);
> +    sysbus_init_mmio(sbd, &s->sram);
> +}
> +
> +static void k230_sram_reset_hold(Object *obj, ResetType type)
> +{
> +    /*
> +     * No software-visible registers to reset.  SRAM content is preserved
> +     * across warm reset on real hardware; a cold reset would clear it,
> +     * but QEMU memory_region_init_ram already zeroes the region on init.
> +     */
> +}
> +
> +static const VMStateDescription vmstate_k230_sram = {
> +    .name = "k230.sram",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void k230_sram_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = k230_sram_realize;
> +    rc->phases.hold = k230_sram_reset_hold;
> +    dc->vmsd = &vmstate_k230_sram;
> +    dc->desc = "K230 SRAM";
> +}
> +
> +static const TypeInfo k230_sram_info = {
> +    .name          = TYPE_K230_SRAM,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230SramState),
> +    .class_init    = k230_sram_class_init,
> +};
> +
> +static void k230_sram_register_type(void)
> +{
> +    type_register_static(&k230_sram_info);
> +}
> +
> +type_init(k230_sram_register_type)
> diff --git a/include/hw/riscv/k230_sram.h b/include/hw/riscv/k230_sram.h
> new file mode 100644
> index 0000000000..6d15970ab9
> --- /dev/null
> +++ b/include/hw/riscv/k230_sram.h
> @@ -0,0 +1,35 @@
> +/*
> + * K230 SRAM Controller
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * The K230 shared SRAM (2 MB at 0x80200000) has no software-visible
> + * controller registers: it is a pure on-chip RAM block accessed directly
> + * via the AXI bus.  Clock gating (CMU at 0x91100000, offset 0x5c) and
> + * reset control (RMU at 0x91101000, offsets 0x60/0x64) are handled by
> + * separate system-controller peripherals and are not modelled here yet.
> + *
> + * Copyright (c) 2026 Jian Cai <lingqian_gi@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef K230_SRAM_H
> +#define K230_SRAM_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_SRAM "riscv.k230.sram"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230SramState, K230_SRAM)
> +
> +struct K230SramState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion sram;          /* 2 MB SRAM storage */
> +};
> +
> +#endif /* K230_SRAM_H */
> -- 
> 2.43.0
> 

