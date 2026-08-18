Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72FFC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCW4-0003cD-4a; Tue, 18 Aug 2026 01:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wwCW2-0003bs-Db; Tue, 18 Aug 2026 01:37:38 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wwCVy-0001Zp-N4; Tue, 18 Aug 2026 01:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIXcZmDARdDTOvEepz0oUmYs1Yd73Osag6Z9NJ6OuU2dp6IDmc/bCCxBC6fTcINHB5x+DBfYRO+XjBaaGyP6Lc+JT8Il+S/OTbAjJ+4XcpoI7bt6vjcGuxRS4BSZUj0ECXSASlPvDlf8tSwTAlk8Q+coH2uYFk7Cz+N5SY3B2DbviLaQmdOlJ4VvnEVr8cz7qStf16KyOVuftYLy5alMxaSkl82xiw8deUQdtaoBpjEMtJlCD5IegjDbHyCV3Kf6DcU+yVDnpUrUnt+DRRoVmL5FfgVKYk1EDb1L5EA9mylDPgAuzeNN/h8uKmGDbO1WgZnKTR6kz4aCNui1i5/TlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bskjZvW7e/MXbSstBSRL04dh6rt8yNAVVu4HzDYuQwA=;
 b=iCuQ+EyCUzxwjSD2scnFhB7thXY9O5LCEgWBoGGzOi3a8LE5v7BUxi71tO31YDvlWqXgrdXMNDYYOAYXWLkGhy6XfqZ6i6a1qWKGbBZ7aCXi/ZIRv4gBDVT0gm/GwH16rHFHjdbgVNNHk7LrdC4gg7k6NVqwvs3/uq3hguwFxDD1H1u31bP+ibSb/agf7zabtErxKMoFInSaBSIBAVzuw3gkzNEr27uI8JnyVttQyF+sTMQ6+ajvDwRQbhPWCej5KFBKbNYgyERtiLOPNwEqRgttTLuUlt1eyzKo+sW57n5+J8YwaHooUavJp6XHFDqp59HxZuTkKHSwimA6MLGQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bskjZvW7e/MXbSstBSRL04dh6rt8yNAVVu4HzDYuQwA=;
 b=PwQdOzWuCj3prACroa+eIE49Py6ctLzO67suGTJQiy6WRzUXUIH0QxpKN3s2UXUPbYin47WiIy8xD3gbpiKxDZhC678jdwlNGr9dVG6HM8z6i5qtQeAIph8oUO96f1oWUi4matgPZqI+xAr/X8AX11V6IhL5PjqDYMLAu/nZD9TLBtqg+0b43M1Az/TkMNkfDfHHKVVUPU8OZw8UrL+kb4fQHzFIkpvVyjHdMSLPU0uz48AHXc289pVHdWRVzqKEeycpWHgU3u2fxo5PLLHNcUYdwp+PJTHzf9Iy24xGJqBpka3jBCWJZUXLVQMZSHbJ7V/YS/CxrnY9+OyemIeQGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB7287.apcprd02.prod.outlook.com (2603:1096:820:11c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 05:37:24 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 05:37:23 +0000
Date: Tue, 18 Aug 2026 13:37:17 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Simon Law <0860734llx@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 1/4] hw/misc: model K230 CMU registers
Message-ID: <aoPV06elI1pvi3tk@ChaodeMacBook-Pro.local>
References: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
 <20260809-feat-k230-cmu-v1-1-8792982c446c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-feat-k230-cmu-v1-1-8792982c446c@gmail.com>
X-ClientProxiedBy: PH7P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::30) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9284d9c7-0696-4300-5039-08defceac77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|3023799007|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: G86823UlWgvJYPwvVb0Syl7pijrdslJT4kNrxEBX5sDDa60VHIa/Qzkd8A/aiH+zWRXVO0QNj24sY/RlTJ4B4MlXF3jDxESq9a80xvYHikmpKLh9fcPpXnzVR7JOpUm5rQeJDkheVFw3S9T1YIylINtDZZcUafyXXe5Idm2JCHaAm9a7e8SYxwm5zQg1pOo+wt1uUYmYEZIRDd2k2bi/yE3n8T9l8SQr2FrC70+iYJfCi4vtSLxU19BD1dW7/oQoXTohsDOAZ022tILV7bE0fPpzj2kR3xPUHoCVNGBslrENW46Hp48fkgdJlfmtUSFhHHLxFgvhpTWXSaB/Udxk4NFbmNkpQ3z3mYq4KgOq9Z809MgYsNuxEnPX6PpduwJSE6asMpOXmOF6kKMyIQVVIYjLl7/1iRm2tRyFEhgrR9/reuyeX7H+qMyfXSbk8pyC+OhzkjNcyPk89Yro6XQ9u+Y3cCaus0rDqPVk2H4UOqjNq7CifgewXWHtgPBMs8KrtoCMrN5jm053OhJWNtphFeGi0DGe3uCyHrjUq4DcrFF7u1vYZBT6fRka3+k194CZyowWrEW6ZO2hh7asdn89Bw6LrlGD3J041IRqILI47g8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FjTGrcKMqjDfHNeRJxGyJyieYKpapyfYAGBg5AS1gi9C9484l/iHGHKK7X4?=
 =?us-ascii?Q?Al050hRsRWPiuaKV/3lHOKEo4H9x7KmNGbQOt+AcVY85VKJUu8cBo4+XoPRR?=
 =?us-ascii?Q?bPsSalC14+zB+ZQC+4r3zDTPqs3GwEp6FzpxK8sGZMIBur8u3DihfJ2qRac6?=
 =?us-ascii?Q?9HG/pIr5xs3JmmPnI0v7ripmucs/sXz4Bg4Zrp4dzawT6OdLF0GKnj9cuI7g?=
 =?us-ascii?Q?buY8flZELWa1FB2tfj2cmDQ9skGJd/72M42SOETXuI1JqhUrztrVbSw0rUor?=
 =?us-ascii?Q?QVsH9cXg00nJtQjM07hLla+K79mTE1taVwBA3PFpYiljIoIm0B8yVq+bM/S5?=
 =?us-ascii?Q?NnNkUqvbdT/sZQsh/Ot0MTjCemoW9wjcRGvKU6L4LHc3zugHXFLbO3FAguOX?=
 =?us-ascii?Q?Y/3z8UN1rVSBhFhtjRrKfne3DAH0GsVAXPs8Ce3qhY/bMI1s+2y+as/zOiSO?=
 =?us-ascii?Q?+UJMl0+/aO8gTXg1q4V0vDZAnJdV3UIFPgJAfwjJW+CdsoZeAcAW8w4wG16M?=
 =?us-ascii?Q?nQFJHtQCa7k/07/h3E4B4ZFaC/t+n5+qa12qpXzbSd8rEzKzS6XXiwpWHMsi?=
 =?us-ascii?Q?ByH0y+rovppeO6QcFjE49BYROZxhDCwm1o7fwv8I7xT11hut+strPgyRG2pn?=
 =?us-ascii?Q?u9DKbQ8dBASuvIjeLALDn3Ohv1rLgEz8IjCVVCnn8XPpxVA5QY26PVUs4x0r?=
 =?us-ascii?Q?pCjimTdDebJtM1zZp+wwFKhHslpCPeD6S4KKsAAT0XIiawnMTZNQksnuLIl5?=
 =?us-ascii?Q?JwgZWkdbDp8sDx2R6Pl0nnsyW80aBnfdQ9YZgGJMhlUaw77nXEmLP0Suql/w?=
 =?us-ascii?Q?56k4oT8t0216flkyaLBwW2X678CU7HDMx40RXS0Y3bn2JPa8Jnb9IGCem1hE?=
 =?us-ascii?Q?od+l1+/NjBdVU75qFJfkFAd6KBoZc0c2ynseJZqIFwBWtz0dl44MxDP3ETKv?=
 =?us-ascii?Q?V1x18TT64/oRWJ/Mbi3HnBTP1NQ2zDZsn6DmFpW8J7UOHkDn3MAw7pctZUbM?=
 =?us-ascii?Q?vnBfjxGyuE9B+gBrdyfFcV/X+UrqPSjd+a/WEQbPauSvQSNahJyL2TSCgSVl?=
 =?us-ascii?Q?qGFbUXipE4l75zpYATR7PXroXf7XkItKCAC22fQnDDVWvZ7U5tUvoxFOWRUM?=
 =?us-ascii?Q?L5zGZ8ja1TCK0BB5WxXcahcXJ5tYCJOHTwsyMNRGvOr+yHRvHE4RghsEhc79?=
 =?us-ascii?Q?Uut71kCs43Ksl8SdmqbGIH1o+0WbjyZnfwQXjaAfBxGPmsGhLLn1l5QOBaXy?=
 =?us-ascii?Q?Lr9UAMyTuufcN0tQsoNDNnYTCEL2Gm2ip/GyBfyf0XEfK+vWYQ+H8W7C0X8g?=
 =?us-ascii?Q?nHBqlV8YpXQHEOxahw99NqTiAft2KuMeRyEtdLyftnO/ljYyYVUN40RIGcqJ?=
 =?us-ascii?Q?ADF1idgwX0aQEUccHoQ+Im3/SOgryydAR9miL986eZPosVwcMbTKL8TK8GZb?=
 =?us-ascii?Q?qmrSDQJxBqFkBKC5GcjRL9hnUDS074yIf62oywxQvqNnJ3pje5jf7/q9EJ9l?=
 =?us-ascii?Q?qQKZOh8F4BA/C2zmPcSNoAJi+3BR7dFcmi4J+itvuIWJhY6eqL68J+69LeX6?=
 =?us-ascii?Q?FoZ7Nk6dObpNk/8ZP5cBgflRuv25hst7ubeA5+LLgqvfxYR0aOyUpCNg++aV?=
 =?us-ascii?Q?bt+ruJ+Lwm47IsxB9l9U4A+9fQBokbjbUBqtbrQqnTAkjYp4Uw6HjDOwfxyL?=
 =?us-ascii?Q?720a28eZj7PotS2U7viEIU5VDfFwERi2MhOypb88sxZ/1ndreHHIuYH91dvJ?=
 =?us-ascii?Q?y51Qqu94NHAkvk2qzqub88pQFlBsImo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9284d9c7-0696-4300-5039-08defceac77a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 05:37:23.8440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ke5euHlVIJkw+ocSjj4NmQUOWtPV8eNcmjLl4mJBYnDFIBk3SeB/RVx58nnu2j0lGPCUkjUv9nnD+5Sc8O5vjN4tB0UJq0YtWSnKVucV49s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7287
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Sun, Aug 09, 2026 at 02:20:41PM +0800, Simon Law wrote:
> Signed-off-by: Simon Law <0860734llx@gmail.com>
> ---
>  MAINTAINERS                |   4 +
>  hw/misc/Kconfig            |   3 +
>  hw/misc/k230_cmu.c         | 881 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build        |   1 +
>  hw/misc/trace-events       |   9 +
>  hw/riscv/Kconfig           |   1 +
>  include/hw/misc/k230_cmu.h |  58 +++
>  7 files changed, 957 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..d46e90cdc5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1820,14 +1820,18 @@ F: hw/riscv/xiangshan_kmh.c
>  F: include/hw/riscv/xiangshan_kmh.h
>  
>  K230 Machines
> +M: Simon Law <0860734llx@gmail.com>
Thanks for helping maintain the K230 machine module. I suggest starting with
patch reviews on the upstream mailing list, like Junze Cao.

>  M: Chao Liu <chao.liu@processmission.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: docs/system/riscv/k230.rst
>  F: hw/riscv/k230.c
> +F: hw/misc/k230_cmu.c
>  F: hw/watchdog/k230_wdt.c
> +F: include/hw/misc/k230_cmu.h
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
> +F: tests/qtest/k230-cmu-test.c
>  F: tests/qtest/k230-wdt-test.c
>  
>  RX Machines
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1543ee6653..58a0421e84 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -101,6 +101,9 @@ config FSL_IMX8MP_ANALOG
>  config FSL_IMX8MP_CCM
>      bool
>  
> +config K230_CMU
> +    bool
> +
>  config STM32_RCC
>      bool
>  
> diff --git a/hw/misc/k230_cmu.c b/hw/misc/k230_cmu.c
> new file mode 100644
> index 0000000000..6af19d2a06
> --- /dev/null
> +++ b/hw/misc/k230_cmu.c
> @@ -0,0 +1,881 @@
> +/*
> + * Kendryte K230 Clock Management Unit
> + *
> + * Copyright (c) 2026 Simon Law <0860734llx@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Emulates the K230 PLL and system-clock register protocol.  It models
> + * software-visible reset values, masks, write strobes, and PLL lock state,
> + * but does not provide cycle-accurate clocks or propagate QEMU Clock signals.
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/registerfields.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +
> +#include "hw/misc/k230_cmu.h"
> +#include "trace.h"
> +
> +REG32(CMU_CFG0, 0x00)
> +    FIELD(CMU_CFG0, PLL_OUT_DIV, 24, 4)
> +    FIELD(CMU_CFG0, PLL_REF_DIV, 16, 6)
> +    FIELD(CMU_CFG0, PLL_FB_DIV, 0, 13)
> +
> +REG32(CMU_CFG1, 0x04)
> +    FIELD(CMU_CFG1, PLL_BYPASS, 19, 1)
> +    FIELD(CMU_CFG1, PLL_TEST, 18, 1)
> +    FIELD(CMU_CFG1, PLL_ENSAT, 17, 1)
> +    FIELD(CMU_CFG1, PLL_FASTEN, 16, 1)
> +    FIELD(CMU_CFG1, PLL_BWADJ, 0, 12)
> +
> +REG32(CMU_CTL, 0x08)
> +    FIELD(CMU_CTL, PLL_LOCK_TIM, 4, 8)
> +    FIELD(CMU_CTL, PLL_CLK_OE, 2, 1)
> +    FIELD(CMU_CTL, PLL_INIT, 1, 1)
> +    FIELD(CMU_CTL, PLL_PWRDWN, 0, 1)
> +
> +REG32(CMU_STAT, 0x0c)
> +    FIELD(CMU_STAT, PLL_FSM_STAT, 4, 2)
> +    FIELD(CMU_STAT, PLL_RESERVED, 3, 1)
> +    FIELD(CMU_STAT, PLL_FB_SLIP, 2, 1)
> +    FIELD(CMU_STAT, PLL_REF_SLIP, 1, 1)
> +    FIELD(CMU_STAT, PLL_LOCK, 0, 1)
> +
> +#define PLL_CFG0_RW_MASK       (R_CMU_CFG0_PLL_OUT_DIV_MASK | \
> +                                R_CMU_CFG0_PLL_REF_DIV_MASK | \
> +                                R_CMU_CFG0_PLL_FB_DIV_MASK)
> +#define PLL_CFG1_RW_MASK       (R_CMU_CFG1_PLL_BYPASS_MASK | \
> +                                R_CMU_CFG1_PLL_TEST_MASK | \
> +                                R_CMU_CFG1_PLL_ENSAT_MASK | \
> +                                R_CMU_CFG1_PLL_FASTEN_MASK | \
> +                                R_CMU_CFG1_PLL_BWADJ_MASK)
> +#define PLL_CTL_RW_MASK        (R_CMU_CTL_PLL_LOCK_TIM_MASK | \
> +                                R_CMU_CTL_PLL_CLK_OE_MASK)
> +#define PLL_CTL_W1T_MASK       (R_CMU_CTL_PLL_INIT_MASK | \
> +                                R_CMU_CTL_PLL_PWRDWN_MASK)
> +#define PLL_CTL_LOW_MASK       (PLL_CTL_RW_MASK | PLL_CTL_W1T_MASK)
> +#define PLL_STAT_RO_MASK       (R_CMU_STAT_PLL_FSM_STAT_MASK | \
> +                                R_CMU_STAT_PLL_RESERVED_MASK | \
> +                                R_CMU_STAT_PLL_FB_SLIP_MASK | \
> +                                R_CMU_STAT_PLL_REF_SLIP_MASK | \
> +                                R_CMU_STAT_PLL_LOCK_MASK)
> +
> +REG32(SYSCLK_CPU0_CLK_CFG, 0x000)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, CORE_CLK_ROOT_GDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, PCLK_DIV, 15, 3)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, TDI_PCLK_EN, 14, 1)
> +    /* FIXME: SDK get_leaf_en() reads bit 7 for this gate; */
> +    /* TRM says bit 13. */
> +    FIELD(SYSCLK_CPU0_CLK_CFG, PCLK_ENABLE, 13, 1)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, PLICLK_DIV, 10, 3)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, PLICLK_ENABLE, 9, 1)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, ACLK_DIV, 6, 3)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, CORE_CLK_ROOT_DIV, 1, 4)
> +    FIELD(SYSCLK_CPU0_CLK_CFG, CORE_CLK_ENABLE, 0, 1)
> +REG32(SYSCLK_CPU1_CLK_CFG, 0x004)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_DIV_UPD, 31, 1)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, PCLK_ENABLE, 19, 1)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, PLICLK_DIV, 16, 3)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, PLICLK_ENABLE, 15, 1)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, ACLK_DIV, 12, 3)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_ROOT_DIV, 3, 3)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_SEL, 1, 2)
> +    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_ENABLE, 0, 1)
> +REG32(SYSCLK_AI_CLK_CFG, 0x008)
> +    FIELD(SYSCLK_AI_CLK_CFG, CLK_DIV_UPD, 31, 1)
> +    FIELD(SYSCLK_AI_CLK_CFG, ACLK_ENABLE, 10, 1)
> +    FIELD(SYSCLK_AI_CLK_CFG, CLK_CDIV, 3, 3)
> +    FIELD(SYSCLK_AI_CLK_CFG, CLK_SEL, 2, 1)
> +    FIELD(SYSCLK_AI_CLK_CFG, CLK_ENABLE, 0, 1)
> +REG32(SYSCLK_VPU_CLK_CFG, 0x00c)
> +    FIELD(SYSCLK_VPU_CLK_CFG, CLK_GDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_VPU_CLK_CFG, CFGCLK_ROOT_DIV, 11, 4)
> +    FIELD(SYSCLK_VPU_CLK_CFG, CFGCLK_ENABLE, 10, 1)
> +    FIELD(SYSCLK_VPU_CLK_CFG, ACLK_ROOT_DIV, 6, 4)
> +    FIELD(SYSCLK_VPU_CLK_CFG, ACLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_VPU_CLK_CFG, CLK_DIV, 1, 4)
> +    FIELD(SYSCLK_VPU_CLK_CFG, CLK_EN, 0, 1)
> +REG32(SYSCLK_PMU_CLK_CFG, 0x010)
> +    FIELD(SYSCLK_PMU_CLK_CFG, CLK_EN, 0, 1)
> +REG32(SYSCLK_HS_CLKEN_CFG, 0x018)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI2_ACLK_ENABLE, 30, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI1_ACLK_ENABLE, 29, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, QSPI_ACLK_ENABLE, 28, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI0_ACLK_ENABLE, 27, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI2_CLK_ENABLE, 26, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI1_CLK_ENABLE, 25, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI0_CLK_ENABLE, 24, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, USB_REFCLK_SEL, 23, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, USB1_REFCLK_ENABLE, 22, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, USB0_REFCLK_ENABLE, 21, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_TMCLK_ENABLE, 20, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_CCLK_ENABLE, 19, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_BCLK_ENABLE, 18, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_ACLK_ENABLE, 17, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_TMCLK_ENABLE, 16, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_CCLK_ENABLE, 15, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_BCLK_ENABLE, 14, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_ACLK_ENABLE, 13, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD_TMCLK_ENABLE, 12, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD_CCLK_ENABLE, 11, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD_BCLK_ENABLE, 10, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD_ACLK_ENABLE, 9, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI2_HCLK_ENABLE, 8, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI1_HCLK_ENABLE, 7, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SSI0_HCLK_ENABLE, 6, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, USB1_HCLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, USB0_HCLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_HCLK_ENABLE, 3, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_HCLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, HCLK_HIGH_ENABLE, 1, 1)
> +    FIELD(SYSCLK_HS_CLKEN_CFG, HCLK_ENABLE, 0, 1)
> +REG32(SYSCLK_HS_SDCLK_CFG, 0x01c)
> +    FIELD(SYSCLK_HS_SDCLK_CFG, ACLK_ROOT_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_HS_SDCLK_CFG, TMCLK_DIV, 15, 5)
> +    /* FIXME: SDK get_leaf_rate() uses ACLK_ROOT_DIV for SD CCLK, */
> +    /* not bits 14:12. */
> +    FIELD(SYSCLK_HS_SDCLK_CFG, CCLK_DIV, 12, 3)
> +    FIELD(SYSCLK_HS_SDCLK_CFG, BCLK_DIV, 9, 3)
> +    FIELD(SYSCLK_HS_SDCLK_CFG, ACLK_ROOT_DIV, 6, 3)
> +    FIELD(SYSCLK_HS_SDCLK_CFG, HCLK_DIV, 3, 3)
> +    FIELD(SYSCLK_HS_SDCLK_CFG, HCLK_HIGH_ROOT_DIV, 0, 3)
> +REG32(SYSCLK_HS_SPI_CFG, 0x020)
> +    FIELD(SYSCLK_HS_SPI_CFG, SSI0_ACLK_ROOT_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_HS_SPI_CFG, SSI0_CLK_SEL, 18, 1)
> +    FIELD(SYSCLK_HS_SPI_CFG, USB_REFCLK_50M_DIV, 15, 3)
> +    FIELD(SYSCLK_HS_SPI_CFG, QSPI_ACLK_ROOT_DIV, 12, 3)
> +    FIELD(SYSCLK_HS_SPI_CFG, SSI0_ACLK_DIV, 9, 3)
> +    FIELD(SYSCLK_HS_SPI_CFG, SSI2_CLK_DIV, 6, 3)
> +    FIELD(SYSCLK_HS_SPI_CFG, SSI1_CLK_DIV, 3, 3)
> +REG32(SYSCLK_LS_CLKEN_CFG0, 0x024)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, PDM_CLK_ENABLE, 31, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, CODEC_MCLK_DAC_ENABLE, 30, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, CODEC_MCLK_ADC_ENABLE, 29, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, AUD_DEV_CLK_ENABLE, 28, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, GPIO_DBCLK_ENABLE, 27, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, ADC_CLK_ENABLE, 26, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C4_CLK_ENABLE, 25, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C3_CLK_ENABLE, 24, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C2_CLK_ENABLE, 23, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C1_CLK_ENABLE, 22, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C0_CLK_ENABLE, 21, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART4_CLK_ENABLE, 20, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART3_CLK_ENABLE, 19, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART2_CLK_ENABLE, 18, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART1_CLK_ENABLE, 17, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART0_CLK_ENABLE, 16, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, ADC_PCLK_ENABLE, 15, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, CODEC_PCLK_ENABLE, 14, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, AUD_DEV_PCLK_ENABLE, 13, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, PWM_PCLK_ENABLE, 12, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, GPIO_PCLK_ENABLE, 11, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C4_PCLK_ENABLE, 10, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C3_PCLK_ENABLE, 9, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C2_PCLK_ENABLE, 8, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C1_PCLK_ENABLE, 7, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C0_PCLK_ENABLE, 6, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART4_PCLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART3_PCLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART2_PCLK_ENABLE, 3, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART1_PCLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, UART0_PCLK_ENABLE, 1, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG0, PCLK_ENABLE, 0, 1)
> +REG32(SYSCLK_LS_CLKEN_CFG1, 0x028)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK3_PCLK_ENABLE, 7, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK2_PCLK_ENABLE, 6, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK1_PCLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK0_PCLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK3_CO_ENABLE, 3, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK2_CO_ENABLE, 2, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK1_CO_ENABLE, 1, 1)
> +    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK0_CO_ENABLE, 0, 1)
> +REG32(SYSCLK_UART_I2C_CLKDIV_CFG, 0x02c)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C0_CLK_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C4_CLK_DIV, 27, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C3_CLK_DIV, 24, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C2_CLK_DIV, 21, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C1_CLK_DIV, 18, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C0_CLK_DIV, 15, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART4_SCLK_DIV, 12, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART3_SCLK_DIV, 9, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART2_SCLK_DIV, 6, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART1_SCLK_DIV, 3, 3)
> +    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART0_SCLK_DIV, 0, 3)
> +REG32(SYSCLK_LS_CLKDIV_CFG, 0x030)
> +    FIELD(SYSCLK_LS_CLKDIV_CFG, JAMLINK_CO_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_LS_CLKDIV_CFG, JAMLINK_CO_DIV, 23, 8)
> +    FIELD(SYSCLK_LS_CLKDIV_CFG, GPIO_DBCLK_DIV, 13, 10)
> +    FIELD(SYSCLK_LS_CLKDIV_CFG, ADC_CLK_DIV, 3, 10)
> +    FIELD(SYSCLK_LS_CLKDIV_CFG, PCLK_DIV, 0, 3)
> +/*
> + * SDK sysctl_clk_t marks offsets 0x034..0x044 reserved; the TRM defines
> + * these registers, so the TRM layout is authoritative for the v1 model.
> + */
> +REG32(SYSCLK_AUDIO_CLKDIV_CFG, 0x034)
> +    FIELD(SYSCLK_AUDIO_CLKDIV_CFG, AUD_DEV_CLK_FDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_AUDIO_CLKDIV_CFG, AUDIO_CLK_STEP, 16, 15)
> +    FIELD(SYSCLK_AUDIO_CLKDIV_CFG, AUDIO_CLK_SUM, 0, 16)
> +REG32(SYSCLK_CODEC_ADC_MCLKDIV_CFG, 0x038)
> +    FIELD(SYSCLK_CODEC_ADC_MCLKDIV_CFG, MCLK_ADC_FDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_CODEC_ADC_MCLKDIV_CFG, MCLK_ADC_STEP, 14, 13)
> +    FIELD(SYSCLK_CODEC_ADC_MCLKDIV_CFG, MCLK_ADC_SUM, 0, 14)
> +REG32(SYSCLK_CODEC_DAC_MCLKDIV_CFG, 0x03c)
> +    FIELD(SYSCLK_CODEC_DAC_MCLKDIV_CFG, MCLK_DAC_FDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_CODEC_DAC_MCLKDIV_CFG, MCLK_DAC_STEP, 14, 13)
> +    FIELD(SYSCLK_CODEC_DAC_MCLKDIV_CFG, MCLK_DAC_SUM, 0, 14)
> +REG32(SYSCLK_PDM_CLKDIV_CFG0, 0x040)
> +    FIELD(SYSCLK_PDM_CLKDIV_CFG0, CLK_SUM, 0, 17)
> +REG32(SYSCLK_PDM_CLKDIV_CFG1, 0x044)
> +    FIELD(SYSCLK_PDM_CLKDIV_CFG1, CLK_FDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_PDM_CLKDIV_CFG1, CLK_STEP, 0, 16)
> +REG32(SYSCLK_SYSCTL_CLKEN_CFG, 0x050)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, HDI_CLK_ENABLE, 21, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, IOMUX_PCLK_ENABLE, 20, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, STC_CLK_EN, 19, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER5_CLK_ENABLE, 18, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER4_CLK_ENABLE, 17, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER3_CLK_ENABLE, 16, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER2_CLK_ENABLE, 15, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER1_CLK_ENABLE, 14, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER0_CLK_ENABLE, 13, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER5_CLK_SEL, 12, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER4_CLK_SEL, 11, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER3_CLK_SEL, 10, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER2_CLK_SEL, 9, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER1_CLK_SEL, 8, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER0_CLK_SEL, 7, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT1_CLK_ENABLE, 6, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT0_CLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, MAILBOX_PCLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER_PCLK_ENABLE, 3, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT1_PCLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT0_PCLK_ENABLE, 1, 1)
> +REG32(SYSCLK_TIMER_CLK_CFG, 0x054)
> +    FIELD(SYSCLK_TIMER_CLK_CFG, CLK0_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_TIMER_CLK_CFG, CLK5_DIV, 15, 3)
> +    FIELD(SYSCLK_TIMER_CLK_CFG, CLK4_DIV, 12, 3)
> +    FIELD(SYSCLK_TIMER_CLK_CFG, CLK3_DIV, 9, 3)
> +    FIELD(SYSCLK_TIMER_CLK_CFG, CLK2_DIV, 6, 3)
> +    FIELD(SYSCLK_TIMER_CLK_CFG, CLK1_DIV, 3, 3)
> +    FIELD(SYSCLK_TIMER_CLK_CFG, CLK0_DIV, 0, 3)
> +REG32(SYSCLK_SYSCTL_CLK_DIV_CFG, 0x058)
> +    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, PCLK_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, HDI_CLK_DIV, 28, 3)
> +    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, TS_CLK_DIV, 20, 8)
> +    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, STC_CLK_DIV, 15, 5)
> +    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, WDT1_CLK_DIV, 9, 6)
> +    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, WDT0_CLK_DIV, 3, 6)
> +REG32(SYSCLK_SHRM_CLK_CFG, 0x05c)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, PCLK_ROOT_DIV_UPD, 31, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, PCLK_ROOT_DIV, 18, 3)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, SRAM_CLK_SEL, 14, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, AXIM_BRIDGE_CLK_EN, 13, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, AXIM_CLK_EN, 12, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, AXIS_CLK_EN, 11, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, SRAM_ACLK_ENABLE, 10, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, NONAI2D_ACLK_ENABLE, 9, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, NONAI2D_PCLK_ENABLE, 8, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, DECOMPRESS_ACLK_ENABLE, 7, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, DECOMPRESS_PCLK_ENABLE, 6, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, GSDMA_ACLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, GSDMA_PCLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, PERI_DMA_ACLK_ENABLE, 3, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, PERI_DMA_PCLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_SHRM_CLK_CFG, PCLK_ENABLE, 0, 1)
> +REG32(SYSCLK_DDR_CLK_CFG, 0x060)
> +    FIELD(SYSCLK_DDR_CLK_CFG, CORE_CLK_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, PCLK_DIV, 14, 4)
> +    FIELD(SYSCLK_DDR_CLK_CFG, CORE_CLK_DIV, 10, 4)
> +    FIELD(SYSCLK_DDR_CLK_CFG, PCLK_ENABLE, 9, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, BYPASSPCLK_ENABLE, 8, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, AXI4CLK_ENABLE, 7, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, AXI3CLK_ENABLE, 6, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, AXI2CLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, AXI1CLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, AXI0CLK_ENABLE, 3, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, CLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_DDR_CLK_CFG, CLK_SEL, 0, 2)
> +/*
> + * SDK sysctl_clk_t marks offsets 0x064..0x078 reserved; the TRM defines
> + * these registers, so the TRM layout is authoritative for the v1 model.
> + */
> +REG32(SYSCLK_ISP_CLKEN_CFG, 0x064)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, DW_ACLK_ENABLE, 19, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, DW_HCLK_ENABLE, 18, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, MCM_CLK_ENABLE, 17, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, VSE_CLK_ENABLE, 16, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, DWE_CLK_ENABLE, 15, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, ACLK_ENABLE, 14, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, HCLK_ENABLE, 13, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CLK_ENABLE, 12, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI2_PCLK_ENABLE, 11, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI1_PCLK_ENABLE, 10, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI0_PCLK_ENABLE, 9, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI2_PIXELCLK_ENABLE, 8, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI1_PIXELCLK_ENABLE, 7, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI0_PIXELCLK_ENABLE, 6, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, DPHY_PCLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CFG2_CLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CFG1_CLK_ENABLE, 3, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CFG0_CLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, PCLK_ENABLE, 1, 1)
> +    FIELD(SYSCLK_ISP_CLKEN_CFG, CSIPHY_CFGCLK_ENABLE, 0, 1)
> +REG32(SYSCLK_ISP_CLKDIV_CFG, 0x068)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, CFG_CLK_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, CLK_SEL, 29, 1)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, CLK_DIV, 26, 3)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, PCLK_DIV, 23, 3)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, CSI2_PIXEL_CLK_DIV, 17, 6)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, CSI1_PIXEL_CLK_DIV, 11, 6)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, CSI0_PIXEL_CLK_DIV, 5, 6)
> +    FIELD(SYSCLK_ISP_CLKDIV_CFG, CFG_CLK_DIV, 0, 5)
> +REG32(SYSCLK_MCLK_CFG, 0x06c)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK0_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK2_DIV, 19, 5)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK2_SEL, 17, 2)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK1_DIV, 12, 5)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK1_SEL, 10, 2)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK0_DIV, 5, 5)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK0_SEL, 3, 2)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK2_ENABLE, 2, 1)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK1_ENABLE, 1, 1)
> +    FIELD(SYSCLK_MCLK_CFG, MCLK0_ENABLE, 0, 1)
> +REG32(SYSCLK_DPU_CLK_CFG, 0x070)
> +    FIELD(SYSCLK_DPU_CLK_CFG, CLK_DIV_UPD, 31, 1)
> +    FIELD(SYSCLK_DPU_CLK_CFG, PCLK_DIV, 7, 3)
> +    FIELD(SYSCLK_DPU_CLK_CFG, CLK_DIV, 3, 4)
> +    FIELD(SYSCLK_DPU_CLK_CFG, PCLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_DPU_CLK_CFG, ACLK_ENABLE, 1, 1)
> +    FIELD(SYSCLK_DPU_CLK_CFG, CLK_ENABLE, 0, 1)
> +REG32(SYSCLK_VO_CLK_CFG, 0x074)
> +    FIELD(SYSCLK_VO_CLK_CFG, ACLK_GPU_EN, 12, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, ACLK_VO_EN, 11, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, HCLK_GPU_EN, 10, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, PCLK_DSI_PHY_EN, 9, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, PCLK_DSI_ENABLE, 8, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, PCLK_VO_ENABLE, 7, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, CLK_GPU_ENABLE, 6, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, CLKEXT_ENABLE, 5, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, CFGCLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, REFCLK_ENABLE, 3, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, DPIPCLK_ENABLE, 2, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, ACLK_ENABLE, 1, 1)
> +    FIELD(SYSCLK_VO_CLK_CFG, HCLK_ENABLE, 0, 1)
> +REG32(SYSCLK_DISP_CLK_DIV, 0x078)
> +    FIELD(SYSCLK_DISP_CLK_DIV, HCLK_ROOT_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_DISP_CLK_DIV, CLK_GPU_DIV, 20, 4)
> +    FIELD(SYSCLK_DISP_CLK_DIV, CLKEXT_DIV, 16, 4)
> +    FIELD(SYSCLK_DISP_CLK_DIV, CFGCLK_DIV, 11, 5)
> +    FIELD(SYSCLK_DISP_CLK_DIV, DPIPCLK_DIV, 3, 8)
> +    FIELD(SYSCLK_DISP_CLK_DIV, HCLK_ROOT_DIV, 0, 3)
> +REG32(SYSCLK_SEC_CLK_DIV, 0x080)
> +    FIELD(SYSCLK_SEC_CLK_DIV, PCLK_DIV_UPD, 31, 1)
> +    FIELD(SYSCLK_SEC_CLK_DIV, ACLK_DIV, 11, 3)
> +    FIELD(SYSCLK_SEC_CLK_DIV, FIXCLK_DIV, 6, 5)
> +    FIELD(SYSCLK_SEC_CLK_DIV, FIXCLK_ENABLE, 5, 1)
> +    FIELD(SYSCLK_SEC_CLK_DIV, ACLK_ENABLE, 4, 1)
> +    FIELD(SYSCLK_SEC_CLK_DIV, PCLK_DIV, 1, 3)
> +    FIELD(SYSCLK_SEC_CLK_DIV, PCLK_ENABLE, 0, 1)
> +REG32(SYSCLK_USB_TEST_CLK_DIV, 0x100)
> +    FIELD(SYSCLK_USB_TEST_CLK_DIV, CLK480_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_USB_TEST_CLK_DIV, CLK100_DIV, 4, 3)
> +    FIELD(SYSCLK_USB_TEST_CLK_DIV, CLK480_DIV, 1, 3)
> +    FIELD(SYSCLK_USB_TEST_CLK_DIV, TEST_CLK_ENABLE, 0, 1)
> +REG32(SYSCLK_DPHY_TEST_CLK_DIV, 0x104)
> +    FIELD(SYSCLK_DPHY_TEST_CLK_DIV, TEST_CLK_CDIV_UPD, 31, 1)
> +    FIELD(SYSCLK_DPHY_TEST_CLK_DIV, TEST_CLK_DIV, 1, 4)
> +    FIELD(SYSCLK_DPHY_TEST_CLK_DIV, TEST_CLK_ENABLE, 0, 1)
> +/*
> + * The TRM v0.3.1 sysclk summary ends at 0x104. Linux and the SDK both
> + * access SPI2AXI_CLK_DIV at 0x108, so v1 preserves this software ABI
> + * exception.
> + */
> +REG32(SYSCLK_SPI2AXI_CLK_DIV, 0x108)
> +    FIELD(SYSCLK_SPI2AXI_CLK_DIV, CLK_DIV_UPD, 31, 1)
> +    FIELD(SYSCLK_SPI2AXI_CLK_DIV, CLK_DIV, 1, 3)
> +    FIELD(SYSCLK_SPI2AXI_CLK_DIV, CLK_ENABLE, 0, 1)
> +
> +typedef struct K230PllRegDesc {
> +    hwaddr offset;
> +    const char *name;
> +    uint32_t reset[K230_PLL_COUNT];
> +    uint32_t rw_mask;
> +    uint32_t ro_mask;
> +    uint32_t w1t_mask;
> +    uint8_t write_enable_shift;
> +    uint32_t write_enable_mask;
> +} K230PllRegDesc;
> +
> +typedef struct K230SysclkRegDesc {
> +    hwaddr offset;
> +    const char *name;
> +    uint32_t reset;
> +    uint32_t rw_mask;
> +    uint32_t w1t_mask;
> +} K230SysclkRegDesc;
> +
> +static const K230PllRegDesc k230_pll_regs[] = {
> +    {
> +        .offset = A_CMU_CFG0,
> +        .name = "PLLx_CFG0",
> +        .reset = {
> +            0x0102018f, 0x00000062, 0x00070378, 0x0102018f,
> +        },
> +        .rw_mask = PLL_CFG0_RW_MASK,
> +    },
> +    {
> +        .offset = A_CMU_CFG1,
> +        .name = "PLLx_CFG1",
> +        .reset = {
> +            0x000200c7, 0x00020031, 0x000201bb, 0x000200c7,
> +        },
> +        .rw_mask = PLL_CFG1_RW_MASK,
> +    },
> +    {
> +        .offset = A_CMU_CTL,
> +        .name = "PLLx_CTL",
> +        .reset = {
> +            0x00000034, 0x00000034, 0x00000034, 0x00000074,
> +        },
> +        .rw_mask = PLL_CTL_RW_MASK,
> +        .w1t_mask = PLL_CTL_W1T_MASK,
Where is w1t_mask actually used?

> +        .write_enable_shift = 16,
> +        .write_enable_mask = PLL_CTL_LOW_MASK,
> +    },
> +    {
> +        .offset = A_CMU_STAT,
> +        .name = "PLLx_STAT",
> +        .reset = {
> +            0x00000021, 0x00000021, 0x00000021, 0x00000021,
> +        },
> +        .ro_mask = PLL_STAT_RO_MASK,
> +    },
> +};
> +
> +#define SYSCLK_REG(_reg, _name, _reset, _rw, _w1t) \
> +    { .offset = A_ ## _reg, .name = _name, .reset = _reset, \
> +      .rw_mask = (_rw), .w1t_mask = (_w1t) }
> +
> +static const K230SysclkRegDesc k230_sysclk_regs[] = {
> +    SYSCLK_REG(SYSCLK_CPU0_CLK_CFG, "CPU0_CLK_CFG", 0x0000e65f,
> +               0x0003ffdf, R_SYSCLK_CPU0_CLK_CFG_CORE_CLK_ROOT_GDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_CPU1_CLK_CFG, "CPU1_CLK_CFG", 0x0009900d,
> +               0x000f803f, R_SYSCLK_CPU1_CLK_CFG_CORE_CLK_DIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_AI_CLK_CFG, "AI_CLK_CFG", 0x0000043d,
> +               0x0000043d, R_SYSCLK_AI_CLK_CFG_CLK_DIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_VPU_CLK_CFG, "VPU_CLK_CFG", 0x00000c7f,
> +               0x00007fff, R_SYSCLK_VPU_CLK_CFG_CLK_GDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_PMU_CLK_CFG, "PMU_CLK_CFG", 0x00000001,
> +               0x00000001, 0),
> +    SYSCLK_REG(SYSCLK_HS_CLKEN_CFG, "HS_CLKEN_CFG", 0x7f7fffff,
> +               0x7fffffff, 0),
> +    SYSCLK_REG(SYSCLK_HS_SDCLK_CFG, "HS_SDCLK_CFG", 0x000b9248,
> +               0x000fffff, R_SYSCLK_HS_SDCLK_CFG_ACLK_ROOT_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_HS_SPI_CFG, "HS_SPI_CFG", 0x00039048,
> +               0x0007fff8, R_SYSCLK_HS_SPI_CFG_SSI0_ACLK_ROOT_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_LS_CLKEN_CFG0, "LS_CLKEN_CFG0", 0xffffffff,
> +               0xffffffff, 0),
> +    SYSCLK_REG(SYSCLK_LS_CLKEN_CFG1, "LS_CLKEN_CFG1", 0x000000ff,
> +               0x000000ff, 0),
> +    SYSCLK_REG(SYSCLK_UART_I2C_CLKDIV_CFG, "UART_I2C_CLKDIV_CFG",
> +               0x1b6d9249, 0x3fffffff,
> +               R_SYSCLK_UART_I2C_CLKDIV_CFG_I2C0_CLK_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_LS_CLKDIV_CFG, "LS_CLKDIV_CFG", 0x01dda0c3,
> +               0x7fffffff, R_SYSCLK_LS_CLKDIV_CFG_JAMLINK_CO_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_AUDIO_CLKDIV_CFG, "AUDIO_CLKDIV_CFG", 0x01b9f424,
> +               0x7fffffff, R_SYSCLK_AUDIO_CLKDIV_CFG_AUD_DEV_CLK_FDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_CODEC_ADC_MCLKDIV_CFG, "CODEC_ADC_MCLKDIV_CFG",
> +               0x006e7d09, 0x07ffffff,
> +               R_SYSCLK_CODEC_ADC_MCLKDIV_CFG_MCLK_ADC_FDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_CODEC_DAC_MCLKDIV_CFG, "CODEC_DAC_MCLKDIV_CFG",
> +               0x006e7d09, 0x07ffffff,
> +               R_SYSCLK_CODEC_DAC_MCLKDIV_CFG_MCLK_DAC_FDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_PDM_CLKDIV_CFG0, "PDM_CLKDIV_CFG0", 0x0000f424,
> +               0x0001ffff, 0),
> +    SYSCLK_REG(SYSCLK_PDM_CLKDIV_CFG1, "PDM_CLKDIV_CFG1", 0x000001b9,
> +               0x0000ffff, R_SYSCLK_PDM_CLKDIV_CFG1_CLK_FDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_SYSCTL_CLKEN_CFG, "SYSCTL_CLKEN_CFG", 0x003ffffe,
> +               0x003ffffe, 0),
> +    SYSCLK_REG(SYSCLK_TIMER_CLK_CFG, "TIMER_CLK_CFG", 0x0003ffff,
> +               0x0003ffff, R_SYSCLK_TIMER_CLK_CFG_CLK0_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_SYSCTL_CLK_DIV_CFG, "SYSCTL_CLK_DIV_CFG", 0x1efabef9,
> +               0x7ffffff8, R_SYSCLK_SYSCTL_CLK_DIV_CFG_PCLK_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_SHRM_CLK_CFG, "SHRM_CLK_CFG", 0x000c7ffd,
> +               0x001c7ffd, R_SYSCLK_SHRM_CLK_CFG_PCLK_ROOT_DIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_DDR_CLK_CFG, "DDR_CLK_CFG", 0x000043fd,
> +               0x0003ffff, R_SYSCLK_DDR_CLK_CFG_CORE_CLK_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_ISP_CLKEN_CFG, "ISP_CLKEN_CFG", 0x000fffff,
> +               0x000fffff, 0),
> +    SYSCLK_REG(SYSCLK_ISP_CLKDIV_CFG, "ISP_CLKDIV_CFG", 0x00820835,
> +               0x3fffffff, R_SYSCLK_ISP_CLKDIV_CFG_CFG_CLK_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_MCLK_CFG, "MCLK_CFG", 0x003a74ef,
> +               0x00ffffff, R_SYSCLK_MCLK_CFG_MCLK0_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_DPU_CLK_CFG, "DPU_CLK_CFG", 0x000001ff,
> +               0x000003ff, R_SYSCLK_DPU_CLK_CFG_CLK_DIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_VO_CLK_CFG, "VO_CLK_CFG", 0x00001fff,
> +               0x00001fff, 0),
> +    SYSCLK_REG(SYSCLK_DISP_CLK_DIV, "DISP_CLK_DIV", 0x0000a83b,
> +               0x00ffffff, R_SYSCLK_DISP_CLK_DIV_HCLK_ROOT_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_SEC_CLK_DIV, "SEC_CLK_DIV", 0x000002f3,
> +               0x00003fff, R_SYSCLK_SEC_CLK_DIV_PCLK_DIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_USB_TEST_CLK_DIV, "USB_TEST_CLK_DIV", 0x00000039,
> +               0x0000007f, R_SYSCLK_USB_TEST_CLK_DIV_CLK480_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_DPHY_TEST_CLK_DIV, "DPHY_TEST_CLK_DIV", 0x00000009,
> +               0x0000001f,
> +               R_SYSCLK_DPHY_TEST_CLK_DIV_TEST_CLK_CDIV_UPD_MASK),
> +    SYSCLK_REG(SYSCLK_SPI2AXI_CLK_DIV, "SPI2AXI_CLK_DIV", 0x00000007,
> +               0x0000000f,
> +               R_SYSCLK_SPI2AXI_CLK_DIV_CLK_DIV_UPD_MASK),
> +};
> +
> +#undef SYSCLK_REG
> +
> +static const K230PllRegDesc *k230_pll_desc(hwaddr addr,
> +                                            unsigned *pll_index)
Please align it with the first parameter after the line break.

Thanks,
Chao

