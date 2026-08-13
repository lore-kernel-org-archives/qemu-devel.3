Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAB3C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 03:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuLxn-0000Hh-S5; Wed, 12 Aug 2026 23:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuLxl-0000HD-Nl; Wed, 12 Aug 2026 23:18:37 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuLxj-0004rL-42; Wed, 12 Aug 2026 23:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OREEWwnzjLN4RacFy3Cd/M2QsP/z+0xURWjmEZdRRlGo12HVhUJnZQ4QCuf4Et87N3IfPfmWOemvqbb/P2z2yaIPV9A9WXAxfaRPSlBuutz22LW2wngHH5PsPmaJ6lhSovR0dkbC0hDmAEn2F/gPLUNDqILaWYUnZjXKsuSCm75WOHH5gGYzOQFU2rInwbrS8fmxD91T2wk+fvizpr9jctsBu6QcGd3v7GvgWxsGzldq8ao3s4m5yQZ4+5aZifDlNg1Bj0xoipdNFcS0kcRqyuZbOT1FpG+eiqhr1jxGV+DX79UOffd5UHODJRRQhS3HhRCikkdlBVar3MpEBSc4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT47sLzF0NbmJOICyePw73iLCbeN4PTF9j5zqUt2uaM=;
 b=acZFqR/4cvDYcMhC6uHcbgc9qOL0WqRCRbWLE/rh8N71jBbTKmadeEm8vGywyqi3+ZE4wgenM9/5BgaWtqtywiGBZcTMaH7HvR+Ayh/GEuDJPj0DoJC4y0r4XXF8YM+XEoLt/5O9NLul2QrYfjb8Rkj4Qu6JdPG3Pl10014dFdZUPfOrV7fjRuk/f4aUJ/sh960dhS4TerZ/5Yb9hkd4ToUaFwHuaukXhmvDz0vhOgjv4sAkwBLyhjNQdDlpqWT+Vycsx90Rh/bNXitBNccihOMdMfhLMc4J7uKrj0PItKHVK2nZbC1jawWiKgOdnU6Qj7c1QXj/EI50OgtwaxdSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT47sLzF0NbmJOICyePw73iLCbeN4PTF9j5zqUt2uaM=;
 b=Iqr1xSRDDUmMZdCTNgqP/Bgs1qLTL0Pmv+6KD4E4Sgmr0XeqvjGhGgKRunHLEiX+rH0OLelOGJGeriBaEgjHSwCm6ujFHHuSOPlFZn0cYb0OR9GltVD4Nwm8XZpp5b16d45q7TzdVjVmWuVLK9YvcIkUK5FziV1MTaHx7lqBPJtpqMvWdlvPMMo67ycnZzC6np0JyXoiFSrLT7gWrfJUpVk7gYq6OLAn1QdQPm20/HfV55l0X+tdje1FbhSX43u5lu9OXTi5BmrNx+0y9PsP5RA5xkwIYV3dmqqdCqOmJuJH8LkIPBvLKRzt3pATOCyTMjwNRintWxD/VOQNET4nOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB9709.apcprd02.prod.outlook.com (2603:1096:101:338::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 03:18:24 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 03:18:24 +0000
Date: Thu, 13 Aug 2026 11:18:18 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
Message-ID: <an0wcQahXAB6UCCB@ChaodeMacBook-Pro.local>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
 <42d005d6e530e2cf2c7df8634e8b82c0f77d1702.1784022244.git.flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42d005d6e530e2cf2c7df8634e8b82c0f77d1702.1784022244.git.flamboyant.h.01@gmail.com>
X-ClientProxiedBy: PH7P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::18) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b66be41-4949-47a9-b614-08def8e988c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|13003099007|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HU3SSbu19bbSPwdhEMtuVUQcUcMhZsapJJWeM70/w0S542keBa7fQhw8YXZ0czPUTs3I4X2JsDbUHue0RVF2kt+WIisE+lexEUe7uPvV7uIXHgj8NJ+I4O/8t0Tg5AvslCNuAiyM3NltXd1ahVcIzRDBiflJVFJG+kkhNtohhtMgXHKhemooCjVk/5h8uztl+I9ZKzvg2sg93gXLYOHTaRnAYZVQzfjkh5q7OZJhzZ3lv9Q1cnIbKakyDxt1gbdtbrHqihD/QdRHtaIB9h58RTL/+jyqIVO88DGG18+m3zRaLuM/InI6gi6xMfZY6/ml6QEf0H7gMWA9s8oiQ034PzK9rn90KhGZVLFcs4Pl0A62/8/UmlUqcNQQUFuqOr0VQJx4fEoyelVLOQck2v0bpftw3bIc7gPFvBn80bd/LxmJ/SsW4DQomXyE8DoVONZTE9nDaESiUYYw+LGHfI+9mZkSylCXOMLuMziGNq0sVf6qeu0MA6xBY42V45mjJVdDWOZZEAvc9Es+ZddQSc9+T4xAw2eTEwYMRPuS1xmcewQAQmozRQ3SXIMvbFsK1gvDuq14W9Lp9yzCoIyUaRwEDNuDgNhEvtgidUV3aJFdIZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(13003099007)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdqeTFFbXdlcEEwVXhLbkRsbEtkOVUrS1E4MGNSNWszNnEzNHowSEV3eDJB?=
 =?utf-8?B?dDNCSWoyS292bERNeGowdVpTSmZJZWZnYy8vK0lHOTB2VUNST2I5WG5xWW90?=
 =?utf-8?B?SVYwNEFjVDJmMVFieUYxQlU5WXhYdHd1cDh4MVA4UEZrckNlbnJvRTQzaEx0?=
 =?utf-8?B?RDM0Nlh5bWRjTC84RDl2TE5TbVh1Z2F4UmdWb0ljTVgwZHdGYmNNNjU4ck9Q?=
 =?utf-8?B?M051UWllVmQ3eEdjNDE1eEVLY2x4WWxIRm41OTlranB2dlpUd1JEbnowRjRG?=
 =?utf-8?B?U01WRVQvM00wRTZNL0gzRlNDZW9nT3ZHOG1ZT256T3laWFMvckJtVWp2MCsv?=
 =?utf-8?B?WkQrQTdFL3Y5dUFBZjI3bmxTRlI0OUNhMFpUaGtOMkV5WFhEZXVMbGMyMUtI?=
 =?utf-8?B?MW5aakVCTEN3UDNOSjdWa0FsQmM3b1pTVEN4UWowZFdnSzRBTG5SZWdpUHM0?=
 =?utf-8?B?MFNDcDBpaUdya1lMVVN0ak5Kd1RoVnRUNzlsY1RQUm1WT0dRRUIwcWdNN3F3?=
 =?utf-8?B?WTArZ2d0bXdhVkNGdXNrUjhSdnFzcUFJZ1p0YTgvU3VqMVg3NWRyVHVMZXNC?=
 =?utf-8?B?L3BadjVxY01sMlRyL28vdWZqV3Nwbjl5bjVOZTRNb2hHZEpoSk1hM1ExOVZj?=
 =?utf-8?B?Zy9CaDhsNVhSdGZaZ2N3Ny8yMTJSM3pERVFReUVZZE92eG1VUkVaN202MUh5?=
 =?utf-8?B?TVFtZzNVd3pVbjlHd1F5cHBIWkk0cEFBRU1vaEIyQTZUcjJ1emw3TlBYd3ZM?=
 =?utf-8?B?b1NtTGxCdVYvdGhZMlhRY1o2ZXF5ZFFlN2FGWEVJejlYN01heFhnV3JPeU9Q?=
 =?utf-8?B?S2dlZUZ2VkprL3JMMTRScGYzSTJkY0Uvam5nTytxMmpZSUFrd29tbXF3RFVm?=
 =?utf-8?B?L3Z4MngzZGJFOVpEWFd4SUpNZU81OXhsSFJjK0pJT05XRjhWL1k5TUdteDMz?=
 =?utf-8?B?NGZHSzBNMytJT3plZ25Md1RnMWlBZ1MvT1dLWng5T05NbjJMUWZ0OHJNNUV4?=
 =?utf-8?B?WkoyZTQ4cFFRSEYyNEgyeEhxSnV0WjBaa0VUcXlSL1J4enlmYmNra2pZUFY2?=
 =?utf-8?B?cVVLZ3RtaGFZaFdEZkJtSXpFN3lLdDRCRGgySWtSRUp5TzNKSXUyaWNpU1ZU?=
 =?utf-8?B?bUUvZjViMnoxMi82aTE2c3BBa015Qk9nZG4veFQvbWlGU2JiL3hoL2k4cnlz?=
 =?utf-8?B?YkoyRzIyVDF5QUR5cjNuVkE4dm5BS0NyMU02a2M2bzhtNVNSdWtZQUFDbWxT?=
 =?utf-8?B?b0NCcG5ROEUxV2FPTWtQOUhZRDc4UVJaVkhCaE1IVEI5S3plRURiR3dVQmFp?=
 =?utf-8?B?WFpSSEwxYk05ZlBTekF4bXdIaHBzRys5eEl0ZlJGekpOd2ZFcUlETWRVKytW?=
 =?utf-8?B?dlZLeWhGZlRLRkd5SlltTFkwK1NjalhYaXBjVGoyTmVrN1JyOHV1V1VMR1Bk?=
 =?utf-8?B?RW9BRnNxaWEwTTdidUpQZ2JtNWlMMXRtYzJSdWpRcXZuT0Y2aU5pUEJSSHZI?=
 =?utf-8?B?UXdYVmpSU3hNN3ovZTFsLy8vd1lPeHNnbUgwb0wvYmFTNkNQNVBhWnB3YnF1?=
 =?utf-8?B?M3BXYUhFU0hGdi9ZMU9xc2N2ekozSHdHQmhIMWFqdGlycW5OMGE2TTYwQzJm?=
 =?utf-8?B?Nlpobk1hZElhQjhIQUFvQnVJTVFyMlQ4R3ZsZUtFejZYMFpoTERPTkhTTW1O?=
 =?utf-8?B?enZlNDF1bGxubFVCem9BOGFZaTNucWs0dElHMlE0RXI2Vjd0dUtvSytsUVJ0?=
 =?utf-8?B?OHNLbGhrTWRmc0tTOUdmYU9EL2lrNGlaZ1NhWVJSQmhxVkFhelpkaFV5V1Yr?=
 =?utf-8?B?N2hvTjZuQXNGeDlTNGdTcDB2SXlsU3ZMSkt1S2l2ZVkzYnNHbVpiaURGOFJj?=
 =?utf-8?B?V3YzY2czTjdTTmhROHRTK2FNOS9YS1lHSDJ1UTk3WWlUQ1lpaXc3dlJGQ2tT?=
 =?utf-8?B?TnYrTTFxbWh3dmN3QXdCbkNUeEZBaVMzaTdJNUhLTThreXBFcFdCalp6YTNt?=
 =?utf-8?B?NE1sYTdRMjZKcXRGalRteERIMVdvdXcwSmpZVTNzSkMybzZhdTlKWlg2VmZ6?=
 =?utf-8?B?eVg5TTFQaGdhTmQwUU9VU0FUMjIzamNmZlc0VHMvZi9VNHNMUEFHWS8wNmRZ?=
 =?utf-8?B?YlBvcnoxekw5eVBqT1dvZ25QaUFKbGh3Mk1NUGZ4eE1scHlublBiODFjZU94?=
 =?utf-8?B?T2V6TkVoRHV2bTdHaStzSlBJVFVwb0g0YjNmRXptUUdXTGhJMjBucHhpWjJ0?=
 =?utf-8?B?TWRUdEJLMWM4RmpsUHF4bk5iTjA4akUwMjZ4bTFIMjhNdU1GWEs2N2Ryakd4?=
 =?utf-8?B?MjlBSHJqbHZrN29adEt0WWVteFh5bUp5L2dXSVd1T1U3QWpYc3pYOTJtRnMw?=
 =?utf-8?Q?U/71I8TR9SRleXHY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b66be41-4949-47a9-b614-08def8e988c8
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:18:24.2885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+Ufku7aLRZbp0RgMIIDbEm04yE+WVnCSA7AOO98dDw+9hmBUgUB6xxcbD/wu+eUrUcJZoST5IYNHXY5GP1GLzbvspEwDZzGZhw/w0Pq+Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB9709
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

On Tue, Jul 14, 2026 at 06:22:00PM +0800, Kangjie Huang wrote:
> Add a SysBus model for the 64 K230 Function IO configuration
> registers documented by the K230 Technical Reference Manual.
> 
> Preserve the writable configuration fields across aligned 32-bit
> accesses, apply the documented reset values, and ignore writes to
> read-only and reserved fields. Offsets outside the documented register
> list read as zero and ignore writes.
> 
> This provides the register behavior used by the Kendryte SDK U-Boot
> pinctrl-single driver and Linux IOMUX configuration code.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>  hw/misc/Kconfig              |   3 +
>  hw/misc/k230_iomux.c         | 124 +++++++++++++++++++++++++++++++++++
hw/misc/k230_iomux.c needs to be added to MAINTAINERS.

>  hw/misc/meson.build          |   2 +
>  hw/misc/trace-events         |   4 ++
>  include/hw/misc/k230_iomux.h |  34 ++++++++++
>  5 files changed, 167 insertions(+)
>  create mode 100644 hw/misc/k230_iomux.c
>  create mode 100644 include/hw/misc/k230_iomux.h
> 
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
> index 0000000000..cc40dc8ae4
> --- /dev/null
> +++ b/hw/misc/k230_iomux.c
> @@ -0,0 +1,124 @@
> +/*
> + * Kendryte K230 IOMUX
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides the Function IO configuration registers documented by the K230
> + * Technical Reference Manual.
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
> +#include "trace.h"
> +
> +/* TRM V0.3.1 section 12.9.2.1 Function IO register list. */
> +static const uint32_t k230_iomux_reset_values[K230_IOMUX_NUM_REGS] = {
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
> +    memcpy(s->regs, k230_iomux_reset_values,
> +           sizeof(k230_iomux_reset_values));
> +}
> +
> +static uint64_t k230_iomux_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    K230IomuxState *s = K230_IOMUX(opaque);
> +    uint32_t value = 0;
> +
> +    if (offset < K230_IOMUX_REGS_SIZE) {
> +        value = s->regs[offset >> 2];
> +    }
> +
> +    trace_k230_iomux_read(offset, value);
> +    return value;
> +}
> +
> +static void k230_iomux_write(void *opaque, hwaddr offset,
> +                             uint64_t value, unsigned size)
> +{
> +    K230IomuxState *s = K230_IOMUX(opaque);
> +
> +    trace_k230_iomux_write(offset, value);
> +    if (offset < K230_IOMUX_REGS_SIZE) {
> +        s->regs[offset >> 2] = value & K230_IOMUX_WRITABLE_MASK;
According to the K230 Manual, Section 12.9.2.2, IOMUX register bit 31 (DI)
is a read-only field described as “Input data from outside the Chip to the PAD”:

  > bits: 31
  > Field Name: DI
  > Access: RO
  > Field Description: Input data from outside the Chip to the PAD

We don't need to simulate external input here, but I suggest adding a
comment explaining that this is set to zero.

I checked the K230 SDK and there are no dependencies on this part,
but from the standpoint of modeling completeness, it's worth noting.

Thanks,
Chao
> +    }
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
> diff --git a/include/hw/misc/k230_iomux.h b/include/hw/misc/k230_iomux.h
> new file mode 100644
> index 0000000000..15a16ef4de
> --- /dev/null
> +++ b/include/hw/misc/k230_iomux.h
> @@ -0,0 +1,34 @@
> +/*
> + * Kendryte K230 IOMUX
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
> +#define K230_IOMUX_NUM_REGS 64
> +#define K230_IOMUX_REGS_SIZE \
> +    (K230_IOMUX_NUM_REGS * sizeof(uint32_t))
> +#define K230_IOMUX_WRITABLE_MASK 0x00003fff
> +
> +struct K230IomuxState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t regs[K230_IOMUX_NUM_REGS];
> +};
> +
> +#endif /* HW_MISC_K230_IOMUX_H */
> -- 
> 2.43.0
> 

