Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F73AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj9XU-0006yh-BA; Mon, 13 Jul 2026 01:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wj9XT-0006yP-5A; Mon, 13 Jul 2026 01:49:11 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wj9XP-0002J7-CH; Mon, 13 Jul 2026 01:49:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIOe7ag2RWKjw/s1YZxhb5hBVPAPW5dK2RfsngXeJ8i8T6oQkbiLxKQEP+AH1g8XrqQEgbzWvDfqanFsxpLBQ+G1FuiDFHgPDxK9eKNgqdIW37JQj+lAyZxSEcpq/5ynIubMhC9hzOZlDElW6n2TXwDXZFXqr1Iy+fh9qqEFRM+Rsy/99TrmG8KwnQ+CWFrYBmGfnWoi+ICALhuJ28wh5nFB1AoJfd+1vnudxihJbMvnGZXnaSLGoa1koBvnk/vMNUHHyOyjHfmf9mIUDPiCWQj6KOL04AiVroa6FtQW86CbCoPe/8DF+57Imyx/AjtISEeSI5jQDJEOhVC85rQa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT4VQhxfxdBUMA1rF3S2AlPdafTEEC70yg5WWzVCVMg=;
 b=a+RH/1MkcTwO6W371mYNZ7SuM0LD2puMPCWKjjVu3jWxcVS7/FUj6jiYXdSqIu6IC2O45XdvpnafBfJUWXYd/fQbGk4G/MutIyOBQnxg0TaRL1rvlYr+ZmkAv/rFH3UEM6ciB+AsfjCtchbmyHFD1J7V8dOHDAqBiGTXNUMvsnsAqk45cfn42FmdNMduVMYjvrn6Crly4Rl7fiP0RAH9+AgYR7fPpL56oZZFlGNBn9Hof/fwx25wLgXFknn/T/IC434nNWr3GQ42suTiRV/97/lwA97nEPsXIkYdKYrufaDIJYIEScs93ZaM1en3CfYqL4RJ/D0Ua3rgsTDX0z1sMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT4VQhxfxdBUMA1rF3S2AlPdafTEEC70yg5WWzVCVMg=;
 b=u7McMr8pNYE422XLituV1x1MMWqqJv1euDDzFG5J60VfG0EvKSAwdZQBm74+7UWIO2/AM+m1f5sHWj77TiuDvCFsyWF664h0/mn2R3qUz0hRVlVCBTNeIrPLLw/PPFihxrevAAqzXhlGri2hwbNRmkMd9GZYzvKhFufudmvEKYHVOIS/E3hJuGzpLopxmc2hp7fNq81Yw7NEwXG3ulYwI0/C36rJTZ2whFPQoxjiep0x6+Mmn94IbtEEFsA0p23ekgcCydQ+OTfk7vADwdMGGuQ5qLFgX0ZTKLGf2sJZpgZCSXkUgqu2vrZzxaL3aGzwlWQgIgNsZVx8vEgd20dRQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUXPR02MB9333.apcprd02.prod.outlook.com (2603:1096:d10:a5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 05:48:59 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 05:48:59 +0000
Date: Mon, 13 Jul 2026 13:48:53 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>,
 "open list:K230 Machines" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH RFC 1/1] hw/riscv/k230: add IOMUX register block model
Message-ID: <alR6OFg6u2KirUII@ChaodeMacBook-Pro.local>
References: <20260710041845.67170-1-flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710041845.67170-1-flamboyant.h.01@gmail.com>
X-ClientProxiedBy: PH8PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUXPR02MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 178b80c2-48d2-4c66-80ac-08dee0a26f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|34096008|7416014|376014|23010399003|22082099003|18002099003|3023799007|13003099007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: nkpxGEa7WJFEKgNWbA6RGr9Lci2MOqCzkLH5OPmBNYdoj/NXbY9Z/Qs/olRPjBDEjovxNbkmw5hLT888XhbySkJilr1zP7G8tFK22wFuSv02x9H+VfEpk8LzJ3DiPBRRCvB329f38pZCR8Iqhom1eWq2dYAgkpBars8YDwW4Us78Th59WPNIoCu0rhuaSBpXTjqZAmF+6+A90VsmnAEVKD3ZvsGa/uourcP8HLy82Y3ac9YDVigmXaW0dG2HobsTfq0xVdvnswlLbVNaaw39bGLvYasuoiW+4DYjnKrnPMu3jMYuk+Mu4+bzV2WBbDhcTeeZsXm/plOT1DQJkfk29aIF5yyC1I/7Kl7UWI6uzb7uJQ1BF5dZJqC8lw3jS+04ftMGEb0CIreWX9HO/i+tURysETd5br2916u4XXXQaLMiDk7Wx/fxRS3kZrAhoCDS4F1UzXsUG9G/FbidpvP/3UBzRF5Di1YCwSuWpwMuuMlOzx4wK2I90i89pRnXaZqXMwSQCx+32FT9ce/d51ZYi+TNvFQ93cv/AmO1SUa/7nNwGxnlHgUAS2PJK7BwG3Wg1M9z2LduzYHAUJrScnqGCpCUlHvkBlVLTpjQ9cWIl8NyHcVEhffyyoRWOnbfWuA7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(34096008)(7416014)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(13003099007)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YDAFTGnx6Jj/xJd+RXpKeqUEG9kYKHyERPJ80uUGZ1eLQyE0LFWc1VhkrKVw?=
 =?us-ascii?Q?sWoh46zomjtx4ysyNuBDJ3eWRtKY8EfyFVfvEsCS11OqBFy21oOVpNCF0UVU?=
 =?us-ascii?Q?Y2JVa7UzUhftSRG0gHdmyzGHKl6DMXeK2oR+Vc4YdxFJuD4/7PyDZDdYPHmP?=
 =?us-ascii?Q?ETb0GgoexAvC94jWROMpW5QCsw4WnCIgpa1ssniXl3V+SE73FETAfIfvnCKo?=
 =?us-ascii?Q?qNmHcwnU8LZUh5Bb6ISvb6iXpSwMdI0AabhrJ3mJkyOPzcULUthyQcNmZlyV?=
 =?us-ascii?Q?ODACDHcugj9uIN9ErIRPtcdzWpMsIl0IAV27qs5eF0Yrv3S7YdL/u8tTqJRR?=
 =?us-ascii?Q?SHlnETASWjUcfnJ+YkN9ZXpPfGE7BnVjmjZJzCLCO1S83/bkUzW/SpRx0rm9?=
 =?us-ascii?Q?7lttkIBANDmCM4Gp2ge4rX6iPeF2/FViIlEt1hmmy4lbhIlZlNb8PL+IsAGS?=
 =?us-ascii?Q?IMlr18szKeZOZgXq05CihpkOAxtWaDoTTj4ptTdwi+DefOrYPsjg/bQfWBrE?=
 =?us-ascii?Q?nxRhDoTj8pdU0GxICLK6jx+WbS/2UQ0xtcMRuk6uAh+758h5O/UG2SDFMcv8?=
 =?us-ascii?Q?0Q0xYAwyNHJbmUIjxuNZ6nFa0r6DPbglu6OnVAxz/AoCIp/j1a/liH2jgAd2?=
 =?us-ascii?Q?YGGk8RUeFsZe/yXB8aZ5yZskrk2u1CEytWZXwcEnmd92OfPwMc7XGVUBuh2Y?=
 =?us-ascii?Q?d3csaPferGe46x+hWk99izfm8qt9i33u3jJXJEdKPv2f/zJFW4EqDOWczFuk?=
 =?us-ascii?Q?JECQ+/O99AaPs3GeJaZV7mFI7/KH4whevtVvarhuOHoPIu5ZI0hYcneD1B2f?=
 =?us-ascii?Q?TEhiG3QSHtQk7wp4Z2YZJSxhpiR//nr79KMw+QVZ8lSwZlxt5vBsYwyD8LZH?=
 =?us-ascii?Q?7nG2jonDqYYONX62H8KCZtNDb5e7ZaHvpO+B5+1VWo2cX+A3hTe211MIWVd0?=
 =?us-ascii?Q?uL6mcPchQQFYP4SgbHAdFVok1KWzdolMxLVb3khQKAJq/rS9RLZzRm4inuFz?=
 =?us-ascii?Q?7o9Q48YT1GukmI64fXZGvqUY8IzQSSz/zR7M80RiXb8I/sMJDRJfqazGXbdc?=
 =?us-ascii?Q?kJhd0C4tbMbRaSv8CHcEL6JQQNoqEOoO5E6QxMo4LX3+0D59I4b7jhWy0gfd?=
 =?us-ascii?Q?aFgD5ndulkujh4CWktTEZJqZPiDdzYrIWsFOZz7W785KGTxjKYQYGrdy4VF+?=
 =?us-ascii?Q?LPTCfbXaOyeIJz9ug7028Teph1YYScxOSqoKugwOTqCmAsh0nTCOZ22egVma?=
 =?us-ascii?Q?req/R5ygN7MscUC9kjoN7ba5NFh1JEorgs2B48pvqQ2syTi+a7HXIxt1SuUQ?=
 =?us-ascii?Q?VwQh1ZUGhuZW6SvXZ9A0s992FxiqrB39N3UhuwOVYSn7U95ya44J3qtivfsL?=
 =?us-ascii?Q?w4BdyOJxaM4F5slJjUCY5zm4hGyPsma/0oQ0DdDnkp+ca4fq7/vRDxiP7rtv?=
 =?us-ascii?Q?AcQWtfNYVyVa9+knnUX21cwC/J6kG9pkfW9pTLBjvFSnzg3WzwjaC2sfYfum?=
 =?us-ascii?Q?CuFtEu2R58oGK7ihZkVUpdnmhf9sP8FYgs7Wzh1BIihUIwFnYoUDyMaT8Xb+?=
 =?us-ascii?Q?WroTqRAalmpRgp6wubD4hR087LeC6zyaBrNBrWSyhXZortej7odhZtmWC7bH?=
 =?us-ascii?Q?y+vtV4SjMrkpiSmNKAGuiL3DRsF111UZy/XJMufhEbN1/WwVq6/qyPWG+BAj?=
 =?us-ascii?Q?w3duvgYXhHZsM1upuQGuk/n/peLzPIOnHVDtRa7Rlxg6Apc1EZvWQXhbruiE?=
 =?us-ascii?Q?cKfr9JhtpbpRY7aDEJd1kFyIxYaj5Sc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178b80c2-48d2-4c66-80ac-08dee0a26f69
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 05:48:59.4207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +E/O1U0s/B5z4gpU3chBnd2nAZ/abplJi9qEjeyxzd/serFfp+FWowN2rLJ1cxIq1jhgRZY4aaKlXFmAwcd5pmKPzTHZFl3BKgySUp04INM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9333
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

On Fri, Jul 10, 2026 at 12:18:44PM +0800, Kangjie Huang wrote:
> Add a sysbus model for the K230 IOMUX MMIO range at
> 0x91105000-0x911057ff. The model exposes the Function IO registers with
> the reset defaults documented by the K230 Technical Reference Manual and
> keeps 32-bit guest writes visible to firmware and the operating system.
> 
> This is enough for SDK U-Boot's pinctrl-single driver, which programs
> the board pin configuration with 32-bit read-modify-write accesses.
> 
> Wire the device into the K230 SoC and add qtest coverage for reset
> values, read/write storage and system reset.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
> RFC notes:
> - This is my first QEMU upstream submission; feedback on patch structure
>   and modelling boundaries would be appreciated.
> - The model covers the IOMUX MMIO range 0x91105000-0x911057ff.
> - It is intended to satisfy SDK U-Boot pinctrl-single register accesses.
> - PMU IOMUX and physical pin routing are intentionally not modeled.
> - Tested with qtest and SDK U-Boot smoke test.
> 
>  docs/system/riscv/k230.rst    |   1 +
>  hw/misc/Kconfig               |   3 +
>  hw/misc/k230_iomux.c          | 138 ++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build           |   2 +
>  hw/misc/trace-events          |   4 +
>  hw/riscv/Kconfig              |   1 +
>  hw/riscv/k230.c               |  11 ++-
>  include/hw/misc/k230_iomux.h  |  34 +++++++++
>  include/hw/riscv/k230.h       |   2 +
>  tests/qtest/k230-iomux-test.c | 107 ++++++++++++++++++++++++++
>  tests/qtest/meson.build       |   5 +-
>  11 files changed, 304 insertions(+), 4 deletions(-)
>  create mode 100644 hw/misc/k230_iomux.c
>  create mode 100644 include/hw/misc/k230_iomux.h
>  create mode 100644 tests/qtest/k230-iomux-test.c
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..b160c401fd 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
>  * Platform-Level Interrupt Controller (PLIC)
>  * 2 K230 Watchdog Timer
>  * 5 UART
> +* K230 IOMUX register block
>  
>  Boot options
>  ------------
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1543ee6653..573d24a9df 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
>  config XLNX_ZYNQ_DDRC
>      bool
>  
> +config K230_IOMUX
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/k230_iomux.c b/hw/misc/k230_iomux.c
> new file mode 100644
> index 0000000000..5f5e2aac51
> --- /dev/null
> +++ b/hw/misc/k230_iomux.c
> @@ -0,0 +1,138 @@
> +/*
> + * K230 IOMUX register block compatible with Kendryte K230 SDK
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides the low IOMUX register block at 0x91105000 with the reset
> + * defaults documented by the K230 Technical Reference Manual. The model keeps
> + * guest 32-bit register writes visible to firmware and the operating system,
> + * but does not model physical pin routing, pad electrical effects, or the
> + * separate PMU IOMUX block.
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/k230_iomux.h"
> +#include "migration/vmstate.h"
> +#include "qemu/module.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +/* TRM V0.3.1 section 12.9.2.1 Function IO register list. */
> +static const uint32_t k230_iomux_reset_values[] = {
> +    0x944, 0x944, 0x929, 0x908, 0x888, 0x908, 0x948, 0x890,
> +    0x890, 0x890, 0x910, 0x890, 0x890, 0x8a9, 0xa9e, 0xabf,
> +    0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
> +    0xb1e, 0xa90, 0xabf, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
> +    0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0x890, 0x910,
> +    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x890, 0x910,
> +    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x89e, 0x89f,
> +    0x99e, 0x99e, 0x99e, 0x99e, 0x890, 0x890, 0x8a9, 0x8a9,
> +};
> +
> +static void k230_iomux_reset(DeviceState *dev)
> +{
> +    K230IomuxState *s = K230_IOMUX(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    memcpy(s->regs, k230_iomux_reset_values,
> +           sizeof(k230_iomux_reset_values));
> +}
> +
> +static uint64_t k230_iomux_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    K230IomuxState *s = K230_IOMUX(opaque);
> +    uint32_t value;
> +
> +    if (offset + size > K230_IOMUX_MMIO_SIZE || (offset & 3)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid access offset 0x%" HWADDR_PRIx
> +                      " size %u\n", __func__, offset, size);
> +        return 0;
> +    }
> +
> +    value = s->regs[offset >> 2];
> +    trace_k230_iomux_read(offset, value);
> +    return value;
> +}
> +
> +static void k230_iomux_write(void *opaque, hwaddr offset,
> +                             uint64_t value, unsigned size)
> +{
> +    K230IomuxState *s = K230_IOMUX(opaque);
> +
> +    if (offset + size > K230_IOMUX_MMIO_SIZE || (offset & 3)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid access offset 0x%" HWADDR_PRIx
> +                      " size %u\n", __func__, offset, size);
> +        return;
> +    }
> +
> +    trace_k230_iomux_write(offset, value);
> +    s->regs[offset >> 2] = value;
The IOMUX register only allows access to bit 31 and bits 0 through 13.

Please see the link provided below. Additionally, you should pay attention to the read/write
permissions for every bit within each register.

https://www.kendryte.com/k230_linux/en/main/app_develop_guide/driver/iomux.html#registers
> +}
> +
> +static const MemoryRegionOps k230_iomux_ops = {
> +    .read = k230_iomux_read,
> +    .write = k230_iomux_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void k230_iomux_init(Object *obj)
> +{
> +    K230IomuxState *s = K230_IOMUX(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &k230_iomux_ops, s,
> +                          TYPE_K230_IOMUX, K230_IOMUX_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static const VMStateDescription vmstate_k230_iomux = {
> +    .name = "k230.iomux",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, K230IomuxState, K230_IOMUX_NUM_REGS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void k230_iomux_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "Kendryte K230 IOMUX";
> +    dc->vmsd = &vmstate_k230_iomux;
> +    device_class_set_legacy_reset(dc, k230_iomux_reset);
> +}
> +
> +static const TypeInfo k230_iomux_info = {
> +    .name          = TYPE_K230_IOMUX,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230IomuxState),
> +    .instance_init = k230_iomux_init,
> +    .class_init    = k230_iomux_class_init,
> +};
> +
> +static void k230_iomux_register_types(void)
> +{
> +    type_register_static(&k230_iomux_info);
> +}
> +
> +type_init(k230_iomux_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..31e5145a35 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -168,3 +168,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>  
>  # HPPA devices
>  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
> +
> +system_ss.add(when: 'CONFIG_K230_IOMUX', if_true: files('k230_iomux.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..388967c9e1 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -405,6 +405,10 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
>  iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
>  iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
>  
> +# k230_iomux.c
> +k230_iomux_read(uint64_t offset, uint32_t value) "offset=0x%" PRIx64 " value=0x%" PRIx32
> +k230_iomux_write(uint64_t offset, uint64_t value) "offset=0x%" PRIx64 " value=0x%" PRIx64
> +
>  # aspeed_sli.c
>  aspeed_sli_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
>  aspeed_sli_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..4c9fc3e7ad 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>      select SERIAL_MM
>      select UNIMP
>      select K230_WDT
> +    select K230_IOMUX
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..430c1646b5 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
>      object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>      object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>      object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-iomux", &s->iomux, TYPE_K230_IOMUX);
>  
>      qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>      qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -198,6 +199,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    /* IOMUX */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->iomux), errp)) {
> +        return;
> +    }
> +
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
> @@ -206,6 +212,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
>  
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->iomux), 0, memmap[K230_DEV_IOMUX].base);
> +
>      /* unimplemented devices */
>      create_unimplemented_device("kpu.l2-cache",
>                                  memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -280,9 +288,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
>                                  memmap[K230_DEV_MAILBOX].size);
>  
> -    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
> -                                memmap[K230_DEV_IOMUX].size);
> -
>      create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
>                                  memmap[K230_DEV_TIMER].size);
>  
> diff --git a/include/hw/misc/k230_iomux.h b/include/hw/misc/k230_iomux.h
> new file mode 100644
> index 0000000000..15e4bb339d
> --- /dev/null
> +++ b/include/hw/misc/k230_iomux.h
> @@ -0,0 +1,34 @@
> +/*
> + * Kendryte K230 IOMUX register block
> + *
> + * This models the low IOMUX register block. Physical pin routing, pad
> + * electrical effects, and the separate PMU IOMUX block are out of scope.
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_IOMUX_H
> +#define HW_MISC_K230_IOMUX_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_IOMUX "riscv.k230.iomux"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230IomuxState, K230_IOMUX)
> +
> +#define K230_IOMUX_MMIO_SIZE 0x800
> +#define K230_IOMUX_NUM_REGS (K230_IOMUX_MMIO_SIZE / sizeof(uint32_t))
> +
> +struct K230IomuxState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t regs[K230_IOMUX_NUM_REGS];
> +};
> +
> +#endif /* HW_MISC_K230_IOMUX_H */
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..223e76b420 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/watchdog/k230_wdt.h"
> +#include "hw/misc/k230_iomux.h"
>  
>  #define C908_CPU_HARTID   (0)
>  
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>      RISCVHartArrayState c908_cpu; /* Small core */
>  
>      K230WdtState wdt[2];
> +    K230IomuxState iomux;
>      MemoryRegion sram;
>      MemoryRegion bootrom;
>  
> diff --git a/tests/qtest/k230-iomux-test.c b/tests/qtest/k230-iomux-test.c
> new file mode 100644
> index 0000000000..ca2d557955
> --- /dev/null
> +++ b/tests/qtest/k230-iomux-test.c
> @@ -0,0 +1,107 @@
> +/*
> + * QTest testcase for K230 IOMUX
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides test coverage for the low IOMUX register block compatible with the
> + * Kendryte K230 SDK.
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/misc/k230_iomux.h"
> +
> +#define K230_IOMUX_BASE 0x91105000
> +#define K230_IOMUX_IO0  (K230_IOMUX_BASE + 0x00)
> +#define K230_IOMUX_IO1  (K230_IOMUX_BASE + 0x04)
> +#define K230_IOMUX_LAST (K230_IOMUX_BASE + K230_IOMUX_MMIO_SIZE - 4)
> +
> +static const uint32_t k230_iomux_reset_values[] = {
> +    0x944, 0x944, 0x929, 0x908, 0x888, 0x908, 0x948, 0x890,
> +    0x890, 0x890, 0x910, 0x890, 0x890, 0x8a9, 0xa9e, 0xabf,
> +    0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
> +    0xb1e, 0xa90, 0xabf, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
> +    0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0x890, 0x910,
> +    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x890, 0x910,
> +    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x89e, 0x89f,
> +    0x99e, 0x99e, 0x99e, 0x99e, 0x890, 0x890, 0x8a9, 0x8a9,
> +};
> +
> +static void test_reset_values(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    for (size_t i = 0; i < G_N_ELEMENTS(k230_iomux_reset_values); i++) {
> +        g_assert_cmphex(qtest_readl(qts, K230_IOMUX_BASE +
> +                                    i * sizeof(uint32_t)), ==,
> +                        k230_iomux_reset_values[i]);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rw(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_IO0, 0x12345678);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x12345678);
> +
> +    qtest_writel(qts, K230_IOMUX_IO1, 0xa5a5a5a5);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0xa5a5a5a5);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x12345678);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_last_reg_rw(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_LAST, 0x00000abc);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_LAST), ==, 0x00000abc);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_reset_after_write(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_IO0, 0x12345678);
> +    qtest_writel(qts, K230_IOMUX_IO1, 0xa5a5a5a5);
> +    qtest_writel(qts, K230_IOMUX_LAST, 0x00000abc);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x12345678);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0xa5a5a5a5);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_LAST), ==, 0x00000abc);
> +
> +    qtest_system_reset(qts);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
> +                    k230_iomux_reset_values[0]);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==,
> +                    k230_iomux_reset_values[1]);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_LAST), ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-iomux/reset", test_reset_values);
> +    qtest_add_func("/k230-iomux/rw", test_rw);
> +    qtest_add_func("/k230-iomux/last-reg-rw", test_last_reg_rw);
> +    qtest_add_func("/k230-iomux/reset-after-write", test_reset_after_write);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..cb8001ecbf 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,10 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? [
> +    'k230-wdt-test',
> +    'k230-iomux-test',
> +  ] : [])
>  
>  qtests_hexagon = ['boot-serial-test']
>  
> -- 
> 2.43.0
> 

