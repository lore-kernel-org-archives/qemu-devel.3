Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D845C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsCTn-000374-Fw; Fri, 07 Aug 2026 00:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wsCTm-00036r-8C; Fri, 07 Aug 2026 00:46:46 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wsCTi-0002y4-AP; Fri, 07 Aug 2026 00:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn2Udqqb+BVEJPr5pBEdfn3j4Ll3VjLQ7tYDN2EgFG+rfbOVnBDvSbaeoSOhJ7AcX7xQhB49gO8P20nP8U3jv8W4c0YLG1/58trQaxoGWTuXk935hNHJKsUyaxiF0t7njqXegC9rKAQbkdRpe43kgckIG0zkP8PgA9iEGzk8Htnqq5minsOds9J95b90Fw/DOigl/gWQeN/px4NCAn8TZ1pvlfi2cWGe8xuo+OxM9JkoY0i/8/wjZQeMHVXcqOwlDbffvaflg4kbmGPfP2GpW6LWS7cLXkOE8CCwHNXaC1crjOpRuY/Bwab2rk0z5LucPMAI78RAW2lNNPEsUXv/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsMDOTOMdQZmFc3dCt5gu3cYlJjPc6xRXGhXcFnPzMg=;
 b=uLjgp8tRHQTnHqE7P0mgcHJXWiP17VSKLzLykMZQxBdp0NHKAKNPLVz/aHRASc4zGVuuH2s0E6G/d1q/K6w+lvf4RUbTxxtZA/7Gnc2pBa+kZWlFb94/2Kfe38WvzPxTDWI8Be+FEutdQ7nsqni/8hiz/pVWV5E/oipNdS6vV3W7k5X+son3SaAxGE0Gx5tTJKlt/WvyZCBfCMGmsOR0jNLdNDH4hVPk4Wbg0c/GRK287h9puB7FVAxbyUawywQtMDrN8JB+jCj7r9jv1Fd2eeBtwxTM/qIREkzmpE2I70Db5IS9Y0g86Nym8EQZtLuDlFxYQpHNUI0hhM74qJ4QQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsMDOTOMdQZmFc3dCt5gu3cYlJjPc6xRXGhXcFnPzMg=;
 b=QpBVtOdiRxY+cfd7i9yEJJstC4rI16zJVyAYsO3tvwWj6d/OvZQMsKa0K1gl4crsMY4eQSejys7LTxLzMNOGaz0uS2BF5UWqyL+YgxPk59ZqbmsKYbOB+DtuT8ZJu2X5UY6DmL1NBdxnnZme8e92E5f6MHnYw8PXjGHxNfugOzhXM3DWqC7pMoX6OsasPkm2FwzoW9IuRpzw6i4UuwwUuXSgDpWKOD9myQ23KwER0rfxdeyEjNTHKRsvelT2DpcHOebIJzPDCaA4+S7WT4OcGeVhpScXZm/LDIx+cFe97TjBVoVSkJW1M3tCPl+X06BSJpnSq7F58SppWX/dNn+P4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB7526.apcprd02.prod.outlook.com (2603:1096:405:32::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 04:46:32 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 04:46:31 +0000
Date: Fri, 7 Aug 2026 12:46:26 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, farosas@suse.de,
 lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com
Subject: Re: [PATCH v2 1/7] hw/dma: add K230 gsdma
Message-ID: <anViwt5s3g16eCKG@ChaodeMacBook-Pro.local>
References: <20260727155702.36484-1-dingtao0430@163.com>
 <20260727155702.36484-2-dingtao0430@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727155702.36484-2-dingtao0430@163.com>
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4d1a0e-6394-4952-eba3-08def43ed9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|10067099003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ZNnN45p54qhsCrIgiO6gHbyLfvko6aCWOqODzUlbuhzsG24DclGMqRr//y82Dn8i8oL4G560jOfHUKtDmXhYIhPFfmfmju2tMfzxTCuER2F2ALEptRk4GJM96paqZpWR76c7UNgW3Pr9KjeJmUSkiHy1YyxXrYMg9YYDDEoy1DwfbZvsQMdZBLFQVZwOPbxGLwjkGr3xHsCgmevl7yNUPhFFJtIaoeL79+9tzGIcbV7ciiImV6TisaH4Pg/YycGvwtQDTxdG2haWPT/7hbt835nZihro15qzT6Y1qS5p/YYUCsPJyE6RLcx7obWFVeyUwecHwe1EBhifB2Mw28BWVrRtz1dL7TBBhuZF7E6Vs/D4rqa8NdxcDRFD8KuoTtMJ8ugiGa5mFeyi8DuDdbyjg0+FqhA0V01WjOuoPbR2sxJt72X+NRCokjhFgUvYOKnj825N+s5EV7HhJhb8NDbrSb8nxrEuzWFwkzT4AOq0rro2pqccGQfPXczPDkCZkaenk8CYjU8XC37eyx1safEwcGEMOZ0/60gAs2N7TRmQHaOCO43turRFXgezBDY+y8jgL4qM5mJ7mabVc4WoBaCqu4YWmGRqrmKuR9SvUUtcioXaMiQP+DeHC07vlHb54TqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VoDC9PoxL3V/gVsXNlhbczVsrlMFZ9Z9b6r89pSALTb1vXa07xj3f1LGz3Rz?=
 =?us-ascii?Q?vK4hWH4M42V8FfRhLT/X8/cGHWN/M8xiddw7AhT+W+VKrnqSrRXbzBRC87GC?=
 =?us-ascii?Q?A03L3Rc7SyAvuskrm4ouq/vq++4muTOMYam2+lb1V88iGYRQGIxKzySnaLwR?=
 =?us-ascii?Q?c4TsUiQ/3NX8CpTrWEEzFvtxvlzCAKYO/rMuDfRQpSObd7caPE0aCn+pc9U1?=
 =?us-ascii?Q?0GyXCG6vn37cJr638CFUMOOw2Jk+IPx7wJB6gIYBxUPGxY7J788C9yPvECO3?=
 =?us-ascii?Q?HJr3siDGaq4qUu5XIv9NGkxxKGDU8n2CjrcrXTqSdlvQ8Eqxe7RqLohzzt0N?=
 =?us-ascii?Q?HY4N/ULGj2y6cs5FvzqoPhlvnm6BvUU9HFCWnCX9F13bBWbkAhPuITvoCANv?=
 =?us-ascii?Q?lt7pG5c4OBLi1FXVZmV+e0NhGxxVTGemdiw2ZFXsis/wyGoe8UnFoPJsaNn4?=
 =?us-ascii?Q?7azhxQSyYyn+6g3H/o0xtjJa2v3Iz0o3FtpUDQ3+BirnBanpxA7na9Qa9iuS?=
 =?us-ascii?Q?ET0HUR1F+fe71UXjRIp+eEoWE4VU/26CzuPIjO9p/j7SYCuQk3P53GGXt335?=
 =?us-ascii?Q?cmI6s9mChD5CpV3kwp+Bk+bzbbTW8MdChcbyA5Ua5/pqYitg4ki/Gu+IZ3Ji?=
 =?us-ascii?Q?pL4wAJRz5HpQuP1gmQBBHUZWaGN7VJX/SzB28ATWfJzc+gbit2oxD3WNgUNl?=
 =?us-ascii?Q?Kjt7Z+VKqD0Tq1hbUUV6eDGzEDPAVIX1wBEUw44la3U2SVGH/7b+DRignDeh?=
 =?us-ascii?Q?E/sL2ghJp/IN0X7u7UQypam1HiWVudCACxO85WtiJZTMKhYmVbgQXvfPprjz?=
 =?us-ascii?Q?PA0nEDKOSYRI2XJ1totSm2VjxB9APvKPWAGODub2pZbPIPfTTDhCV2nooraH?=
 =?us-ascii?Q?TnWxFMPDe+MWhgG3+CopDHIwKgj3/2t+BfHkFB2pY7YHqYiVXgibXG2ZdaX/?=
 =?us-ascii?Q?4VvxPSoxndXVlhlIKjwfn3GF8iWXnsNIT/oPNewazxV6AwJ6MKI6zQ1YelT5?=
 =?us-ascii?Q?8seZatgXjhc69A0ETNGThxJ56Sp6sIyduR6rn83kpHkLYpO9Iim+LCnV2Tib?=
 =?us-ascii?Q?Un8mr7toTnpPBbKZAnJtUeNjJ4h2JwWlZenEZeNGtX/WPT/YivxEf83e1Zaf?=
 =?us-ascii?Q?o/s7eo28hWAnc0ANYnytoke0s1W1rp1Q0aJel1yy0wtr3koqdCBaEdnyUFKL?=
 =?us-ascii?Q?84ZH7KeOnqFL+qeW0AcwJ1vCafeVe0nJwrRUPu3UhCLJKpP52l6LSI4GvObe?=
 =?us-ascii?Q?MhBxs96ekDGNYDr7YI4KxYybKcwX/rmX7JedP22T88SB5quw0gJvmRMGchiu?=
 =?us-ascii?Q?8VD2MpfIzxYrLa/yDoPqMYSWoTJJVypcixxzt2PGACCvMlVo8W8b1gh9olbm?=
 =?us-ascii?Q?oa5SCkSKGZQkRZro1fd7b++Zj+Uhe0X5eHHxh10C+25k8ViCOwxAe4v6PyQ1?=
 =?us-ascii?Q?nt4xpi4NzYha70KMDKdjU9JeHn806RCqjr9Wng9VV6mNmDWG5GSSlz64ZczC?=
 =?us-ascii?Q?QtBgTwB+zONSaZi2OYuqTaboSC6j9aDu17z4R+yoTWXzFQ41GsUJB81Ier3D?=
 =?us-ascii?Q?3rFBHwxNIsaZnQKamJBTOpBOKfxXSLSZuTolm3qFmfkczguDfOh326mi07xD?=
 =?us-ascii?Q?df252sgk/Afv+HhvZOqAQEo8ZmMvvPBMZ1EGh5hid6kXIoi36tJBzvZISXlS?=
 =?us-ascii?Q?RMQQNt61bwcxoSXuzxWntBnLZOId1D/HSY9JiyxfxMVorN6RCh7suCQVwgB9?=
 =?us-ascii?Q?PWnUwvPRtFsGi5GKsZdjhYSAmd/O/5Y=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4d1a0e-6394-4952-eba3-08def43ed9bb
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 04:46:31.6127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSqgjzL4MUuCSj8Ev06WEtk4IPLbbEcYSkLayMMwSUMbgWepFHv1CFvKHALkHVESYEoR5R2+G6ml5JhMcn5KCPmdw5JuGZEf+MUOxDkc9U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7526
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

On Mon, Jul 27, 2026 at 11:56:56PM +0800, Tao Ding wrote:
> K230 GSDMA includes SDMA (System Direct Memory Access) and GDMA (Graphic Direct Memory Access).
line length exceeds 76 characters.

> SDMA for k230 board. The following features have not been implemented:
> 1. axi protocol related
> 2. channel arbitration
> 3. lower power mode
> 
> SDMA supports transfer data between memory, in which case SDMA is the controller.
> It also supports transfer data to decomp_gzip and caching it through SRAM. 
> In this case, decomp_gzip is the controller, which controls SDMA through handshake signals.
> 
> According to "K230 Technical Reference Manual v0.3.1" section 2.5.2.
> https://download.kendryte.com/developer/k230/HDK/K230%E7%A1%AC%E4%BB%B6%E6%96%87%E6%A1%A3/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> 
> This commit includes:
> - K230 SDMA (System Direct Memory Access) model (k230_gsdma.c, k230_gsdma.h)
> - GSDMA trace log (trace-events)
> - Kconfig and meson.build
> - update MAINTAINERS
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
> In patchv1, the reviewer identified some missing features and bugs, which have been fixed.
> bug: 
>     src_addr should not increment in 2d-mode and src_fixed
> feature:
>     data endian conversion
> enhance:
>     use new reset interface
> 
>  MAINTAINERS                 |   2 +
>  hw/dma/Kconfig              |   3 +
>  hw/dma/k230_gsdma.c         | 562 ++++++++++++++++++++++++++++++++++++
>  hw/dma/meson.build          |   1 +
>  hw/dma/trace-events         |   6 +
>  include/hw/dma/k230_gsdma.h | 130 +++++++++
>  6 files changed, 704 insertions(+)
>  create mode 100644 hw/dma/k230_gsdma.c
>  create mode 100644 include/hw/dma/k230_gsdma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a28935c898..49c8013d5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1829,8 +1829,10 @@ S: Maintained
>  F: docs/system/riscv/k230.rst
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
> +F: hw/dma/k230_gsdma.c
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
> +F: include/hw/dma/k230_gsdma.h
>  F: tests/functional/riscv64/test_k230.py
>  F: tests/qtest/k230-wdt-test.c
>  
> diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
> index 98fbb1bb04..0a23e7d7b8 100644
> --- a/hw/dma/Kconfig
> +++ b/hw/dma/Kconfig
> @@ -30,3 +30,6 @@ config SIFIVE_PDMA
>  config XLNX_CSU_DMA
>      bool
>      select REGISTER
> +
> +config K230_GSDMA
> +    bool
> \ No newline at end of file
> diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
> new file mode 100644
> index 0000000000..032733047c
> --- /dev/null
> +++ b/hw/dma/k230_gsdma.c
> @@ -0,0 +1,562 @@
> +/*
> + * Kendryte K230 GSDMA
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * GSDMA includes SDMA (System Direct Memory Access, K230 TRM section 10.2) and
> + * GDMA (Graphic Direct Memory Access, K230 TRM section 2.5.2).
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "migration/vmstate.h"
> +#include "system/address-spaces.h"
> +#include "hw/dma/k230_gsdma.h"
> +#include "hw/core/irq.h"
> +#include "trace.h"
> +
> +static void k230_gsdma_update_irq(K230GSDMAState *s)
> +{
> +    qemu_set_irq(s->irq, !!(s->dma_int_stat & ~s->dma_int_mask));
> +}
> +
> +static bool k230_gsdma_decomp_enabled(K230GSDMAState *s)
> +{
> +    /* Only sdma channel 0 has decomp enable flag */
> +    return !!(s->channels[0].cfg & K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN);
> +}
> +
> +static bool k230_gsdma_read_sdma_llt(hwaddr addr, K230GSDMALLT *llt)
> +{
> +    bool ok = address_space_read(&address_space_memory, addr,
> +                                 MEMTXATTRS_UNSPECIFIED, llt,
> +                                 sizeof(*llt)) == MEMTX_OK;
> +
> +    if (ok) {
> +        trace_k230_gsdma_read_sdma_llt(addr, le32_to_cpu(llt->cfg),
> +                                       le32_to_cpu(llt->src_addr),
> +                                       le32_to_cpu(llt->line_size),
> +                                       le32_to_cpu(llt->line_cfg),
> +                                       le32_to_cpu(llt->dst_addr),
> +                                       le32_to_cpu(llt->next_llt_addr));
> +    } else {
> +        trace_k230_gsdma_read_sdma_llt_failed(addr);
> +    }
> +
> +    return ok;
> +}
> +
> +static unsigned int k230_gsdma_usr_data_size(uint32_t cfg)
> +{
> +    /* decode usr_dat_size in CH_CFG register */
> +    switch (extract32(cfg, K230_GSDMA_CH_CFG_USR_DATA_SIZE_SHIFT, 2)) {
> +    case 0:
> +        return 1;
> +    case 1:
> +        return 2;
> +    default:
> +        return 4;
> +    }
> +}
> +
> +static void k230_gsdma_convert_endian(uint8_t *buf, uint32_t len, uint32_t cfg)
> +{
> +    unsigned int mode = extract32(cfg,
> +                                  K230_GSDMA_CH_CFG_DAT_ENDIAN_SHIFT, 2);
> +    unsigned int unit_size;
> +    unsigned int offset;
> +
> +    if (mode == 0) {
> +        return;
> +    }
> +
> +    unit_size = 1U << mode;
> +    for (offset = 0; offset + unit_size <= len; offset += unit_size) {
> +        unsigned int i;
> +
> +        for (i = 0; i < unit_size / 2; i++) {
> +            uint8_t tmp = buf[offset + i];
> +
> +            buf[offset + i] = buf[offset + unit_size - i - 1];
> +            buf[offset + unit_size - i - 1] = tmp;
> +        }
> +    }
> +}
> +
> +static bool k230_gsdma_transfer_llt(K230GSDMAChannel *c, const K230GSDMALLT *llt)
> +{
> +    uint32_t llt_cfg = le32_to_cpu(llt->cfg);
> +    hwaddr src = le32_to_cpu(llt->src_addr);
> +    hwaddr dst = le32_to_cpu(llt->dst_addr);
> +    uint32_t line_size = le32_to_cpu(llt->line_size);
> +    uint32_t line_cfg = le32_to_cpu(llt->line_cfg);
> +    /* Number of lines required for 2d mode */
> +    uint32_t line_num =
> +            (llt_cfg & K230_GSDMA_LLT_2D_MODE) ? extract32(line_cfg, 0, 16) : 1;
> +    /* Stride line size required for 2d mode */
> +    uint32_t line_space = extract32(line_cfg, 16, 16);
> +
> +    bool dat_mode = c->cfg & K230_GSDMA_CH_CFG_DAT_MODE;
> +    bool src_fixed = c->cfg & K230_GSDMA_CH_CFG_SRC_FIXED;
> +    bool dst_fixed = c->cfg & K230_GSDMA_CH_CFG_DST_FIXED;
> +
> +    uint8_t buf[8]; /* K230 sdma axi data width is 64-bit */
> +    uint8_t fill[4];    /* Usr data is 32-bit*/
> +    unsigned int fill_len = k230_gsdma_usr_data_size(c->cfg);
> +    uint32_t i;
> +
> +    memcpy(fill, &c->usr_data, sizeof(fill));
> +
> +    for (i = 0; i < line_num; i++) {
> +        uint32_t remaining = line_size;
> +        hwaddr line_src = src;
> +        hwaddr line_dst = dst;
> +
> +        while (remaining) {
> +            uint32_t chunk = MIN(remaining, (uint32_t)sizeof(buf));
> +
> +            if (dat_mode) {
> +                uint32_t j;
> +
> +                for (j = 0; j < chunk; j++) {
> +                    buf[j] = fill[j % fill_len];
> +                }
> +            } else if (address_space_read(&address_space_memory, line_src,
> +                                          MEMTXATTRS_UNSPECIFIED, buf,
> +                                          chunk) != MEMTX_OK) {
> +                return false;
> +            }
> +
> +            k230_gsdma_convert_endian(buf, chunk, c->cfg);
> +
> +            if (address_space_write(&address_space_memory, line_dst,
> +                                    MEMTXATTRS_UNSPECIFIED, buf,
> +                                    chunk) != MEMTX_OK) {
> +                return false;
> +            }
> +
> +            if (!dat_mode && !src_fixed) {
> +                line_src += chunk;
> +            }
> +            if (!dst_fixed) {
> +                line_dst += chunk;
> +            }
> +            remaining -= chunk;
> +        }
> +
> +        if (!dat_mode && !src_fixed) {
> +            if (llt_cfg & K230_GSDMA_LLT_2D_MODE) { /* 2d mode */
> +                src += line_size + line_space;
> +            } else {
> +                src += line_size;
> +            }
> +        }
> +
> +        if (!dst_fixed) {
> +            dst += line_size;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static void k230_gsdma_sdma_set_idle(K230GSDMAChannel *c)
> +{
> +    c->status &= ~(K230_GSDMA_SDMA_STATUS_BUSY | K230_GSDMA_SDMA_STATUS_PAUSE);
> +    c->next_llt = 0;
> +}
> +
> +static void k230_gsdma_sdma_set_paused(K230GSDMAChannel *c, hwaddr next_llt)
> +{
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->status |= K230_GSDMA_SDMA_STATUS_PAUSE;
> +    c->next_llt = next_llt;
> +}
> +
> +static void k230_gsdma_run_sdma(K230GSDMAState *s, unsigned int ch, hwaddr addr)
> +{
> +    K230GSDMAChannel *c = &s->channels[ch];
> +
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_PAUSE;
> +    c->status |= K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->next_llt = 0;
> +    c->current_llt = addr;
> +
> +    while (addr) {
> +        K230GSDMALLT llt;
> +        uint32_t cfg;
> +        hwaddr next;
> +
> +        if (!k230_gsdma_read_sdma_llt(addr, &llt)) {
> +            k230_gsdma_sdma_set_idle(c);
> +            return;
> +        }
> +
> +        cfg = le32_to_cpu(llt.cfg);
> +        next = le32_to_cpu(llt.next_llt_addr);
> +        c->current_llt = addr;
> +
> +        if (!k230_gsdma_transfer_llt(c, &llt)) {
> +            k230_gsdma_sdma_set_idle(c);
> +            return;
> +        }
> +
> +        if (cfg & K230_GSDMA_LLT_NODE_INTR) {
> +            s->dma_int_stat |= K230_GSDMA_SDMA_ITEM_INT(ch);
> +        }
> +
> +        if (cfg & K230_GSDMA_LLT_PAUSE) {
> +            s->dma_int_stat |= K230_GSDMA_SDMA_PAUSE_INT(ch);
> +            k230_gsdma_sdma_set_paused(c, next);
> +            k230_gsdma_update_irq(s);
> +            return;
> +        }
> +
> +        addr = next;
> +    }
> +
> +    s->dma_int_stat |= K230_GSDMA_SDMA_DONE_INT(ch);
> +    s->dma_ch_en &= ~BIT(ch);
> +    k230_gsdma_sdma_set_idle(c);
> +    k230_gsdma_update_irq(s);
> +}
> +
> +/* Decomp gzip request step sdma */
> +static void k230_gsdma_step_sdma(K230GSDMAState *s, unsigned int ch, hwaddr addr)
> +{
> +    K230GSDMAChannel *c = &s->channels[ch];
> +    K230GSDMALLT llt;
> +    uint32_t cfg;
> +    hwaddr next;
> +
> +    if (!addr || !k230_gsdma_read_sdma_llt(addr, &llt)) {
> +        k230_gsdma_sdma_set_idle(c);
> +        return;
> +    }
> +
> +    cfg = le32_to_cpu(llt.cfg);
> +    next = le32_to_cpu(llt.next_llt_addr);
> +
> +    c->status |= K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_PAUSE;
> +    c->current_llt = addr;
> +
> +    if (!k230_gsdma_transfer_llt(c, &llt)) {
> +        k230_gsdma_sdma_set_idle(c);
> +        return;
> +    }
> +
> +    if (cfg & K230_GSDMA_LLT_NODE_INTR) {
> +        s->dma_int_stat |= K230_GSDMA_SDMA_ITEM_INT(ch);
> +    }
> +
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->next_llt = next;
> +    if (next == 0) {
> +        s->dma_int_stat |= K230_GSDMA_SDMA_DONE_INT(ch);
> +        s->dma_ch_en &= ~BIT(ch);
> +    }
> +
> +    k230_gsdma_update_irq(s);
> +}
> +
> +static const VMStateDescription vmstate_k230_gsdma_channel = {
> +    .name = "k230.gsdma.channel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(ctl, K230GSDMAChannel),
> +        VMSTATE_UINT32(status, K230GSDMAChannel),
> +        VMSTATE_UINT32(cfg, K230GSDMAChannel),
> +        VMSTATE_UINT32(usr_data, K230GSDMAChannel),
> +        VMSTATE_UINT32(llt_saddr, K230GSDMAChannel),
> +        VMSTATE_UINT32(current_llt, K230GSDMAChannel),
> +        VMSTATE_UINT32(next_llt, K230GSDMAChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_k230_gsdma = {
> +    .name = "k230.gsdma",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(dma_ch_en, K230GSDMAState),
> +        VMSTATE_UINT32(dma_int_mask, K230GSDMAState),
> +        VMSTATE_UINT32(dma_int_stat, K230GSDMAState),
> +        VMSTATE_UINT32(dma_cfg, K230GSDMAState),
> +        VMSTATE_UINT32(dma_weight, K230GSDMAState),
> +        VMSTATE_STRUCT_ARRAY(channels, K230GSDMAState,
> +                             K230_GSDMA_NUM_SDMA_CHANNELS, 2,
> +                             vmstate_k230_gsdma_channel, K230GSDMAChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    K230GSDMAState *s = K230_GSDMA(opaque);
> +    unsigned int ch;
> +    hwaddr ch_off;
> +    uint64_t ret = 0;
> +
> +    switch (addr) {
> +    case K230_GSDMA_DMA_CH_EN:
> +        ret = s->dma_ch_en;
> +        break;
> +    case K230_GSDMA_DMA_INT_MASK:
> +        ret = s->dma_int_mask;
> +        break;
> +    case K230_GSDMA_DMA_INT_STAT:
> +        ret = s->dma_int_stat;
> +        break;
> +    case K230_GSDMA_DMA_CFG:
> +        ret = s->dma_cfg;
> +        break;
> +    case K230_GSDMA_GDMA_CTRL:
> +    case K230_GSDMA_GDMA_LLI_BASE:
> +    case K230_GSDMA_GDMA_CURRENT_LLT:
> +    case K230_GSDMA_GDMA_CH_CNT0 ... K230_GSDMA_GDMA_CH_CNT_LAST:
> +        break;
> +    case K230_GSDMA_DMA_WEIGHT:
> +        ret = s->dma_weight;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
> +    ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
> +    if (ch < K230_GSDMA_NUM_SDMA_CHANNELS) {
> +        switch (ch_off) {
> +        case K230_GSDMA_CH_CTL:
> +            break;
> +        case K230_GSDMA_CH_STATUS:
> +            ret = s->channels[ch].status;
> +            break;
> +        case K230_GSDMA_CH_CFG:
> +            ret = s->channels[ch].cfg;
> +            break;
> +        case K230_GSDMA_CH_USR_DATA:
> +            ret = s->channels[ch].usr_data;
> +            break;
> +        case K230_GSDMA_CH_LLT_SADDR:
> +            ret = s->channels[ch].llt_saddr;
> +            break;
> +        case K230_GSDMA_CH_CURRENT_LLT:
> +            ret = s->channels[ch].current_llt;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    trace_k230_gsdma_read(addr, size, ret);
> +    return ret;
> +}
> +
> +static void k230_gsdma_write_gdma(K230GSDMAState *s, hwaddr addr, uint32_t value)
> +{
> +    switch (addr) {
> +    case K230_GSDMA_GDMA_CTRL:
> +    case K230_GSDMA_GDMA_LLI_BASE:
> +    case K230_GSDMA_GDMA_CURRENT_LLT:
> +    case K230_GSDMA_GDMA_CH_CNT0 ... K230_GSDMA_GDMA_CH_CNT_LAST:
> +        return;
> +    default:
> +        return;
> +    }
> +}
> +
> +static void k230_gsdma_write_channel(K230GSDMAState *s, unsigned int ch,
> +                                     hwaddr ch_off, uint32_t value)
> +{
> +    K230GSDMAChannel *c = &s->channels[ch];
> +    bool handshake_mode = ch < 2 && k230_gsdma_decomp_enabled(s);
> +
> +    switch (ch_off) {
> +    case K230_GSDMA_CH_CTL:
> +        c->ctl = value;
> +        if ((value & K230_GSDMA_CTL_STOP) != 0) {
> +            c->started = false;
> +            k230_gsdma_sdma_set_idle(c);
> +            break;
> +        }
> +        if ((value & K230_GSDMA_CTL_RESUME) != 0 &&
> +            (c->status & K230_GSDMA_SDMA_STATUS_PAUSE) && c->next_llt != 0) {
> +            k230_gsdma_run_sdma(s, ch, c->next_llt);
> +            break;
> +        }
> +        if (handshake_mode && (value & K230_GSDMA_CTL_START) != 0) {
> +            c->started = true;
> +            c->status &= ~(K230_GSDMA_SDMA_STATUS_BUSY |
> +                           K230_GSDMA_SDMA_STATUS_PAUSE);
> +            c->current_llt = 0;
> +            c->next_llt = 0;
> +            break;
> +        }
> +        if ((value & K230_GSDMA_CTL_START) != 0 &&
> +            (s->dma_ch_en & BIT(ch)) && c->llt_saddr != 0) {
> +            c->started = true;
> +            k230_gsdma_run_sdma(s, ch, c->llt_saddr);
> +        }
> +        break;
> +    case K230_GSDMA_CH_CFG:
> +        c->cfg = value;
> +        break;
> +    case K230_GSDMA_CH_USR_DATA:
> +        c->usr_data = value;
> +        break;
> +    case K230_GSDMA_CH_LLT_SADDR:
> +        c->llt_saddr = value;
> +        break;
> +    case K230_GSDMA_CH_CURRENT_LLT:
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static void k230_gsdma_write(void *opaque, hwaddr addr,
> +                             uint64_t value, unsigned int size)
> +{
> +    K230GSDMAState *s = K230_GSDMA(opaque);
> +    unsigned int ch;
> +    hwaddr ch_off;
> +    uint32_t v = value;
> +
> +    trace_k230_gsdma_write(addr, size, value);
> +
> +    switch (addr) {
> +    case K230_GSDMA_DMA_CH_EN:
> +        s->dma_ch_en = v & K230_GSDMA_DMA_CH_EN_MASK;
> +        return;
> +    case K230_GSDMA_DMA_INT_MASK:
> +        s->dma_int_mask = v;
> +        k230_gsdma_update_irq(s);
> +        return;
> +    case K230_GSDMA_DMA_INT_STAT:
> +        s->dma_int_stat &= ~v;
> +        k230_gsdma_update_irq(s);
> +        return;
> +    case K230_GSDMA_DMA_CFG:
> +        s->dma_cfg = v;
> +        return;
> +    case K230_GSDMA_DMA_WEIGHT:
> +        s->dma_weight = v & 0x00ffffff;
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    if (addr < K230_GSDMA_CH_BASE) {
> +        k230_gsdma_write_gdma(s, addr, v);
> +        return;
> +    }
> +
> +    ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
> +    ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
> +    if (ch >= K230_GSDMA_NUM_SDMA_CHANNELS) {
> +        return;
> +    }
> +
> +    k230_gsdma_write_channel(s, ch, ch_off, v);
> +}
> +
> +static void k230_gsdma_handle_signal(void *opaque, int n, int level)
> +{
> +    K230GSDMAState *s = opaque;
> +    K230GSDMAChannel *c;
> +    hwaddr addr;
> +    unsigned int ch;
> +
> +    if (!level || n == K230_GSDMA_GPIO_DECOMP_CTRL_EN) {
> +        return;
> +    }
> +
> +    ch = n - 1;
> +
> +    c = &s->channels[ch];
> +    if (!k230_gsdma_decomp_enabled(s) || !(s->dma_ch_en & BIT(ch)) || !c->started) {
> +        return;
> +    }
> +
> +    if (c->current_llt == 0) {
> +        addr = c->llt_saddr;
> +    } else {
> +        addr = c->next_llt;
> +    }
> +    if (!addr) {
> +        return;
> +    }
> +
> +    k230_gsdma_step_sdma(s, ch, addr);
> +    qemu_set_irq(s->handshake_out[n - 1], 1);
> +    qemu_set_irq(s->handshake_out[n - 1], 0);
> +}
> +
> +static const MemoryRegionOps k230_gsdma_ops = {
> +    .read = k230_gsdma_read,
> +    .write = k230_gsdma_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void k230_gsdma_reset_hold(Object *obj, ResetType type)
> +{
> +    K230GSDMAState *s = K230_GSDMA(obj);
> +
> +    memset(s->channels, 0, sizeof(s->channels));
> +    s->dma_ch_en = 0;
> +    s->dma_int_mask = 0;
> +    s->dma_int_stat = 0;
> +    s->dma_cfg = K230_GSDMA_DMA_CFG_RESET;
> +    s->dma_weight = 0;
> +}
> +
> +static void k230_gsdma_realize(DeviceState *dev, Error **errp)
> +{
> +    K230GSDMAState *s = K230_GSDMA(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &k230_gsdma_ops, s,
> +                          TYPE_K230_GSDMA, K230_GSDMA_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +    qdev_init_gpio_in(DEVICE(dev), k230_gsdma_handle_signal,
> +                      K230_GSDMA_NUM_GPIOS_IN);
> +    qdev_init_gpio_out(DEVICE(dev), s->handshake_out,
> +                       K230_GSDMA_NUM_GPIOS_OUT);
> +}
> +
> +static void k230_gsdma_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = k230_gsdma_realize;
> +    rc->phases.hold = k230_gsdma_reset_hold;
> +    dc->vmsd = &vmstate_k230_gsdma;
> +    dc->desc = "Kendryte K230 GSDMA";
> +}
> +
> +static const TypeInfo k230_gsdma_info = {
> +    .name = TYPE_K230_GSDMA,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230GSDMAState),
> +    .class_init = k230_gsdma_class_init,
> +};
> +
> +static void k230_gsdma_register_types(void)
> +{
> +    type_register_static(&k230_gsdma_info);
> +}
> +
> +type_init(k230_gsdma_register_types)
> diff --git a/hw/dma/meson.build b/hw/dma/meson.build
> index cc7810beb8..45db5e7357 100644
> --- a/hw/dma/meson.build
> +++ b/hw/dma/meson.build
> @@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
>  system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
>  system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
> +system_ss.add(when: 'CONFIG_K230_GSDMA', if_true: files('k230_gsdma.c'))
> diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> index 4c09790f9a..a494755b5a 100644
> --- a/hw/dma/trace-events
> +++ b/hw/dma/trace-events
> @@ -47,3 +47,9 @@ pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"
>  
>  # xilinx_axidma.c
>  xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
> +
> +# k230_gsdma.c
> +k230_gsdma_read(uint64_t addr, unsigned int size, uint64_t data) "K230 GSDMA read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
> +k230_gsdma_write(uint64_t addr, unsigned int size, uint64_t data) "K230 GSDMA write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
> +k230_gsdma_read_sdma_llt(uint64_t addr, uint32_t cfg, uint32_t src_addr, uint32_t line_size, uint32_t line_cfg, uint32_t dst_addr, uint32_t next_llt_addr) "K230 GSDMA read SDMA LLT: addr=0x%"PRIx64" cfg=0x%"PRIx32" src=0x%"PRIx32" line_size=0x%"PRIx32" line_cfg=0x%"PRIx32" dst=0x%"PRIx32" next=0x%"PRIx32
> +k230_gsdma_read_sdma_llt_failed(uint64_t addr) "K230 GSDMA read SDMA LLT failed: addr=0x%"PRIx64
> diff --git a/include/hw/dma/k230_gsdma.h b/include/hw/dma/k230_gsdma.h
> new file mode 100644
> index 0000000000..629cce29f8
> --- /dev/null
> +++ b/include/hw/dma/k230_gsdma.h
> @@ -0,0 +1,130 @@
> +/*
> + * K230 GSDMA
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_DMA_K230_GSDMA_H
> +#define HW_DMA_K230_GSDMA_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_K230_GSDMA "riscv.k230.gsdma"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230GSDMAState, K230_GSDMA)
> +
> +#define K230_GSDMA_MMIO_SIZE          0x4000
> +#define K230_GSDMA_NUM_SDMA_CHANNELS  4
> +
> +#define K230_GSDMA_CH_STRIDE          0x30
> +#define K230_GSDMA_CH_BASE            0x50
> +
> +/* K230 SDMA request input */
> +enum {
> +    K230_GSDMA_GPIO_DECOMP_CTRL_EN,
> +    K230_GSDMA_GPIO_DMA_WRITE_REQ,
> +    K230_GSDMA_GPIO_DMA_READ_REQ,
> +    K230_GSDMA_NUM_GPIOS_IN,
> +};
> +
> +/* K230 SDMA ACK output */
> +enum {
> +    K230_GSDMA_GPIO_DMA_WRITE_ACK,
> +    K230_GSDMA_GPIO_DMA_READ_ACK,
> +    K230_GSDMA_NUM_GPIOS_OUT,
> +};
> +
> +/* K230 GSDMA Registers Map */
> +#define K230_GSDMA_DMA_CH_EN          0x00
> +#define K230_GSDMA_DMA_INT_MASK       0x04
> +#define K230_GSDMA_DMA_INT_STAT       0x08
> +#define K230_GSDMA_DMA_CFG            0x0c
> +#define K230_GSDMA_GDMA_CTRL          0x10
> +#define K230_GSDMA_GDMA_LLI_BASE      0x14
> +#define K230_GSDMA_GDMA_CH_CNT0       0x18
> +#define K230_GSDMA_GDMA_CH_CNT_LAST   0x34
> +#define K230_GSDMA_GDMA_CURRENT_LLT   0x38
> +#define K230_GSDMA_DMA_WEIGHT         0x48
> +
> +/* K230 GSDMA SDMA Channel Register Map */
> +#define K230_GSDMA_CH_CTL             0x00
> +#define K230_GSDMA_CH_STATUS          0x04
> +#define K230_GSDMA_CH_CFG             0x08
> +#define K230_GSDMA_CH_USR_DATA        0x0c
> +#define K230_GSDMA_CH_LLT_SADDR       0x10
> +#define K230_GSDMA_CH_CURRENT_LLT     0x14
> +
> +/* K230 SDMA Control bit */
> +#define K230_GSDMA_CTL_START          BIT(0)
> +#define K230_GSDMA_CTL_STOP           BIT(1)
> +#define K230_GSDMA_CTL_RESUME         BIT(2)
> +
> +/* K230 SDMA States bit */
> +#define K230_GSDMA_SDMA_STATUS_BUSY   BIT(0)
> +#define K230_GSDMA_SDMA_STATUS_PAUSE  BIT(1)
> +
> +/* K230 SDMA Interrupt bit */
> +#define K230_GSDMA_SDMA_DONE_INT(ch)  BIT(ch)
> +#define K230_GSDMA_SDMA_ITEM_INT(ch)  BIT((ch) + 4)
> +#define K230_GSDMA_SDMA_PAUSE_INT(ch) BIT((ch) + 8)
> +
> +
> +#define K230_GSDMA_DMA_CH_EN_MASK     MAKE_64BIT_MASK(0, 5)
> +#define K230_GSDMA_DMA_CFG_RESET      0x000007ff
> +
> +/* K230 SDMA Linked List bit */
> +#define K230_GSDMA_LLT_2D_MODE        BIT(28)
> +#define K230_GSDMA_LLT_PAUSE          BIT(29)
> +#define K230_GSDMA_LLT_NODE_INTR      BIT(30)
> +#define K230_GSDMA_GDMA_LLT_GCH_SHIFT 16
> +#define K230_GSDMA_GDMA_LLT_GCH_MASK  0x7
> +#define K230_GSDMA_CH_CFG_DAT_MODE    BIT(0)
> +#define K230_GSDMA_CH_CFG_USR_DATA_SIZE_SHIFT 1
> +#define K230_GSDMA_CH_CFG_USR_DATA_SIZE_MASK  0x3
> +#define K230_GSDMA_CH_CFG_DAT_ENDIAN_SHIFT 4
> +#define K230_GSDMA_CH_CFG_DAT_ENDIAN_MASK  0x3
> +#define K230_GSDMA_CH_CFG_SRC_FIXED   BIT(8)
> +#define K230_GSDMA_CH_CFG_DST_FIXED   BIT(9)
> +#define K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN BIT(10)
> +
> +/* K230 SDMA channel state */
> +typedef struct K230GSDMAChannel {
> +    uint32_t ctl;
> +    uint32_t status;
> +    uint32_t cfg;
> +    uint32_t usr_data;
> +    uint32_t llt_saddr;
> +    uint32_t current_llt;
> +    uint32_t next_llt;
> +    bool started;
> +} K230GSDMAChannel;
> +
> +/* K230 SDMA Linked List */
> +typedef struct K230GSDMALLT {
> +    uint32_t cfg;
> +    uint32_t src_addr;
> +    uint32_t line_size;
> +    uint32_t line_cfg;
> +    uint32_t dst_addr;
> +    uint32_t next_llt_addr;
> +} K230GSDMALLT;
> +
> +/* K230 GSDMA state */
> +struct K230GSDMAState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +    qemu_irq handshake_out[K230_GSDMA_NUM_GPIOS_OUT];
> +
> +    uint32_t dma_ch_en;
> +    uint32_t dma_int_mask;
> +    uint32_t dma_int_stat;
> +    uint32_t dma_cfg;
> +    uint32_t dma_weight;
> +
> +    K230GSDMAChannel channels[K230_GSDMA_NUM_SDMA_CHANNELS];
> +};
> +
> +#endif
> -- 
> 2.43.0
> 

