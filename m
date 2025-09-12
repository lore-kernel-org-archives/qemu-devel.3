Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F26CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 17:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux7FK-0000n4-JM; Fri, 12 Sep 2025 13:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7FI-0000mk-J5; Fri, 12 Sep 2025 13:07:36 -0400
Received: from mail-bn8nam12on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61c]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7FD-0002jV-Uo; Fri, 12 Sep 2025 13:07:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDPyJkl+IKvfiquOHjd6pzs4Lxub9I/sdumAmOHSNVSv+LBIu3P/g+6VD166GWQ4NchbJy2kTYEJquYzRC4fo62MY7PwYh2yYr3lMOROhRAHiPWxQfCLyNICn/N3+FLcCaGS9dVbIrGFAqhmZ3wniyNSypqZCHDgBkWrRP22OwuqSTAoo43UYoMWubtyCDusEmAxpKCZPCyamDkngKx3EaMPiNQr8L+ctIfbpvUZ87QyYziBs0TafKooXZ0LS1n4boZEMiqdKMc6UwgGA6CYntFL30XhcAsnLkw+JoAwINNoIEPx8n6NQEXAX9lk3SJSO5Yz5Nf4EQMAry/hq9dilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rG8CGfnlnKy7YXLEhDJkWwOk7lHC2o73ltK8SwJB2w=;
 b=bbdZmeWWNocIlaQMAcI1Vz830DYhZJ5OEFvRHE8DdjKM0S7EqWO15voGnZJ9GnmRPtvNFSJBWAbZkI6RaSrU7d6XuDiJx8ivlM0XmJjvgHsI5R2tHgROQGe9EWE5hel2/3cnEHxwXFATlEvsr9rpNV+CpWUfr2QSixobTtfXWe/pVP3DgszMXX95pByR7A5562TfjXJav5/8DkXpEv/7NZLnUUmcgXCkEaW2hA4ZJztO/4wIQRi73nMrqZFMifSQhF5k/Wna5OUQ5DKft1FooM82STtY0Q44golRWDqunXMDwmw0RMEMuuhO32vXWwLkgYZt+l3efGi4SLm2024W7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rG8CGfnlnKy7YXLEhDJkWwOk7lHC2o73ltK8SwJB2w=;
 b=Wh39mfDGpWa2w5ZY6NdovygQPdN8xkdRpinNatY9FmL7K5iIgxb9c/IFNGPg94IroFtJym2S52RVf8ZvmbHekoTGl4VlTimDq6pORhXfm6bX86GdJZzt0ZQuIGnBT5CMrmIxIHOjwKtCZok38DFNEwL88lVIJ6J8+Ofu0jNkvGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 17:07:23 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 17:07:23 +0000
Date: Fri, 12 Sep 2025 19:07:18 +0200
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 01/47] hw/arm/xlnx-versal: split the xlnx-versal type
Message-ID: <aMRTRuUYUlll6SIu@zapote>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-2-luc.michel@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912100059.103997-2-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::16) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: fae66626-77a9-459e-aa33-08ddf21ed72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Jk/D7kAyzROL20f45n9npCyapjgTDYKKl2rYNryFITFNdwyvsXAaLAg/v+?=
 =?iso-8859-1?Q?nM2EIGeHZ4nV8LNzkJP1kvXfZxNV9Zs6aRSplybyowaspWOpfWXPzc///C?=
 =?iso-8859-1?Q?NcZclLJ0oWNGToIakIizCONSNklNAZvWC2ZafgiPvThda5iQSQzB6DMSKF?=
 =?iso-8859-1?Q?1sy49md7c8T8Y0kIJxRpcfFeBu/gl/rtEkmqfUyNsnm3ZM/TZPaV8rp1y0?=
 =?iso-8859-1?Q?IIh1KyHNyRHSo4lMJlKU9oJjp2b1n4R/ZbVHiLDKkjzBKBsM81MtfinCWK?=
 =?iso-8859-1?Q?H7Tj+2yMjM8fDv7ePQmE9kBmJuSrfphPUrz2wKp2+/g86yJBfyCs8VCK+C?=
 =?iso-8859-1?Q?io1lrAQPNNd98g168Lz46ebty7bhItKBhurnf8oHR/J3UzPl3qV1dKuu8z?=
 =?iso-8859-1?Q?j49ZRs8RCBG7Y06x8jbPl3d2+H/HCPQvh9UkOmy5VH/8/vEmCitKXha8jc?=
 =?iso-8859-1?Q?GVN0odaUQSBKY8xB2mcK8TX1rTGOkTaMo/Fyqo/zHLvY5SNFRKX7E901xJ?=
 =?iso-8859-1?Q?ZPAH8vNj1QDdLH+wTlK3g3nplwP2zizEz3Qk7fZ4BTUIm9DlnxV7o8cPxy?=
 =?iso-8859-1?Q?+mWrOUph6Wnpq55b9e6LsxtqDKcSUJUYRG4ydIRDtAdNbPBxohms5dYyW2?=
 =?iso-8859-1?Q?H4yRdVwbiKovuyO6nsxLs1LbocKFeafqrgHBy9woQ/q7yZawURELmUEQ5x?=
 =?iso-8859-1?Q?j6MiS1HvOOtbyEJcHVIvIuq5lcD/SQh8LMRetJ4UcpJPR3HmCUqBv/ChC7?=
 =?iso-8859-1?Q?yOC+TD6pexSRze+ytt8iNNsboh6KxCm6GQIc/GBw2SDlQs/V25/h3nCPud?=
 =?iso-8859-1?Q?0H33D6XXYcEEkNMLErHDGF0qimmzNfFs5H2WTEKp8dhbKYhzfxPapyylYU?=
 =?iso-8859-1?Q?0/8VY6Ht3eejBnrcJQZOf1l9IUkvP4UiahA7pBFaDOf5Nhc6XVq4S9UH+K?=
 =?iso-8859-1?Q?wGk/Jfi2CDt2qJoKX9R0XflQfeXP2LO9fU+mgWwBnm+M2FHdBNkFBAkKIm?=
 =?iso-8859-1?Q?qoFIikKUeaabsQg9j9a8KaOLiEOJBBPgWqaG0nYaAT6845GiWsvgWeMwcv?=
 =?iso-8859-1?Q?orV4zKu7uGiWXsba5X9O0OG1uZFMvR3BtSPkFoj3Io+vmxEiJfHE2EhCYk?=
 =?iso-8859-1?Q?bYb0rBXOQicDbT+iTGBMQey6oVRCX8ClUTQ+A7FWcFAZbHuSHOq6NaGFnW?=
 =?iso-8859-1?Q?W+ttZwA8AanihwOXFU7Qpr7optk7a7SuCAvn6LcwqOZ1wZZptHavXxzYSO?=
 =?iso-8859-1?Q?1F1jrWdmgwESYV/xxw5NFG5KoeogHsu0Gt1d5e4os6fkjaTEMVJeAw4doP?=
 =?iso-8859-1?Q?zxPSMiCwyXZjmig9kFx/pBh6rNA0MZDvSdAHjt6494+gvA0xdQgt1+lefX?=
 =?iso-8859-1?Q?Ie5Ba8mUj8W3buGkK5mNs+dNG3xsxrFXzQrPkcf/nm066aXL/Nhos3H56W?=
 =?iso-8859-1?Q?y/WvgfYBH2o8KE7oFONzNtRnEiS+EdsTHO8dMBD368+AyQbICTFsHjOyHQ?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0SnL0xaL5EEOQYF64HLGbtFo19GitXYZQGxP++lIBhdO6zh60EocDqVu1y?=
 =?iso-8859-1?Q?ESGm6Fa7FIFBRaf3AW3hylw84fpdAOiiRAE43FFZcCPqZNQwGoAEvJrZF3?=
 =?iso-8859-1?Q?o+h241Obs/CIpAzDyBClfYyaVrP6M6Y74lp4qIsYUwnFU+257tmRlG2+27?=
 =?iso-8859-1?Q?fhl5yHD8rmKxI3a9v6NJxQQt/OVHVyIpmyPRFnbRPcW3PMAtCBwAsRSt/S?=
 =?iso-8859-1?Q?NwyemWHnuugjzJQ6tn8AMSlFsjR22ke5STktef5ygYvNOZgpc/Lvv9oIO3?=
 =?iso-8859-1?Q?EepNF+oF6YCl5uKWESTB6g2zhWONy0/0/IhoSI2+dq2hWxMN6cQZjteA7c?=
 =?iso-8859-1?Q?xPuJXYn4D6p826JwNyz3rHsJ0YIALHI6kaRirD3cASZfrgDnv7A+7uGSel?=
 =?iso-8859-1?Q?xY28EW6ailIYygQHQFwY0oXEo4MslgaKQ7U0VY5GMYR80sUE+2criXISDm?=
 =?iso-8859-1?Q?IfBD6pTlQPsj1IhukjXE72NsBkhgPdtFrrihCCEiT9xptL1tnO8mPwwp9B?=
 =?iso-8859-1?Q?0aqVjVEJVoPj1thEIaKU0lzXuZDXOPKKd2PQZkOqC3vjrccg3+BbfEAWCk?=
 =?iso-8859-1?Q?jqLJ3+WGx+4i9Nywhg/av0WRKtQ7AOmL/yBbeL7DSe90FoNczEHFcqnelP?=
 =?iso-8859-1?Q?Vnou0pETCD75rqszLHsiq1tLBlmA04MqTFJdfyfPSvz8FnBv0XDpLYfdo1?=
 =?iso-8859-1?Q?JNDa4xQn9ZEw6h6nYgS0XXQfPoLY2b0ru3smnLkZmWRPsApIRKCPeut6/T?=
 =?iso-8859-1?Q?NIbhbAbzUVV741iibfZsIqxv9TzObKDQ9iesyOEdj2zpnqAx6LuyMaNEkL?=
 =?iso-8859-1?Q?fV/Qu9OnqvBg/jk4yii+F26GuXohM9KeO/H1qpVP+Nc74IKTSW/CUWmemP?=
 =?iso-8859-1?Q?NY2v7YcMNUCVYB0I5UOUlgUAqMAcLOfI4rU4L/WY+4SvSRfhkZUv7M7Aji?=
 =?iso-8859-1?Q?VNxdGWN2OeIylGcQ89QhCR7OMSlWbyM+G9gsLzlyaz7NCngW8Cd2/3xEUX?=
 =?iso-8859-1?Q?UULhxAaRhQQYvGh+uf17CvU0PUj03Kv8PbF7WBfmGBu9mTHauhDMMZeCG1?=
 =?iso-8859-1?Q?x2tzgypVaiHI8rMhnlXyitBrTeookDDJ9/vjL9MkKVQFlaZqUxMQdy7v8I?=
 =?iso-8859-1?Q?yDz0AaKIegtQZg5fCXGF1SeVfksyr/YENdK1bsXF6+TUIPNvU3Hn5KrBLn?=
 =?iso-8859-1?Q?NykCOG0cXl9XFd35wm0ogUH4gtQaTfIIt0f3SougJ4D2WKb4UD15bULLqO?=
 =?iso-8859-1?Q?mre94lDsFBsbIHjbgh9k+Su6PVCaFpv1wZOgW2TLC9EC40G30HIxmUqj6p?=
 =?iso-8859-1?Q?SbkeTbcVtf8UO5+80HR44Y4zNbC75Fx4NlgAw1xMMlKE1qFPBDQj0GzTuN?=
 =?iso-8859-1?Q?zD50C5q4OF9Sj9U44YpQ9g2vvUVHf9jDtQKyZAWvYm1BK4Q7ioZ2aD7mjQ?=
 =?iso-8859-1?Q?U7/tdsbzvEAprRFE00tUO89WdM5aN09ZR6OFFKnP0wuFsxAtZAwtELXIUX?=
 =?iso-8859-1?Q?lYK3FwtJHU+KKqegyeYVFATtxAx2YM8OZMe48sgxM+Z5/jb/jSXUItxQ5R?=
 =?iso-8859-1?Q?CpvX/zNswyRmfMbsY7wxBjaIFxvCCUyd2e2Kpk8zbfhPTDyAk8U8zcPzmh?=
 =?iso-8859-1?Q?naXha1W3fGfgAGyfa/4r0ReEVPzvjQGPfH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae66626-77a9-459e-aa33-08ddf21ed72b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 17:07:23.3896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKeIKlAqRiMQMnbY3vDwddR2T9iq1q9UXGRJlk/2+LywMYu2xUDaGbsFKD2v3mLg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
Received-SPF: permerror client-ip=2a01:111:f403:2418::61c;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Edgar E. Iglesias" <edgar.iglesias@amd.com>
From:  "Edgar E. Iglesias" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 12, 2025 at 12:00:10PM +0200, Luc Michel wrote:
> Split the xlnx-versal device into two classes, a base, abstract class
> and the existing concrete one. Introduce a VersalVersion type that will
> be used across several device models when versal2 implementation is
> added.
> 
> This is in preparation for versal2 implementation.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  include/hw/arm/xlnx-versal-version.h | 15 ++++++++++++++
>  include/hw/arm/xlnx-versal.h         | 12 ++++++++++-
>  hw/arm/xlnx-versal.c                 | 31 +++++++++++++++++++++-------
>  3 files changed, 50 insertions(+), 8 deletions(-)
>  create mode 100644 include/hw/arm/xlnx-versal-version.h
> 
> diff --git a/include/hw/arm/xlnx-versal-version.h b/include/hw/arm/xlnx-versal-version.h
> new file mode 100644
> index 00000000000..c4307d1304a
> --- /dev/null
> +++ b/include/hw/arm/xlnx-versal-version.h
> @@ -0,0 +1,15 @@
> +/*
> + * AMD Versal versions
> + *
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_XLNX_VERSAL_VERSION_H
> +#define HW_ARM_XLNX_VERSAL_VERSION_H
> +
> +typedef enum VersalVersion {
> +    VERSAL_VER_VERSAL,
> +} VersalVersion;
> +
> +#endif
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 05ed641b6b6..1f92e314d6c 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -1,9 +1,10 @@
>  /*
>   * Model of the Xilinx Versal
>   *
>   * Copyright (c) 2018 Xilinx Inc.
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 or
>   * (at your option) any later version.
> @@ -33,13 +34,16 @@
>  #include "hw/misc/xlnx-versal-trng.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "target/arm/cpu.h"
> +#include "hw/arm/xlnx-versal-version.h"
> +
> +#define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
> +OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
> -OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
>  
>  #define XLNX_VERSAL_NR_ACPUS   2
>  #define XLNX_VERSAL_NR_RCPUS   2
>  #define XLNX_VERSAL_NR_UARTS   2
>  #define XLNX_VERSAL_NR_GEMS    2
> @@ -135,10 +139,16 @@ struct Versal {
>      struct {
>          MemoryRegion *mr_ddr;
>      } cfg;
>  };
>  
> +struct VersalClass {
> +    SysBusDeviceClass parent;
> +
> +    VersalVersion version;
> +};
> +
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
>  #define VERSAL_GIC_MAINT_IRQ        9
>  #define VERSAL_TIMER_VIRT_IRQ       11
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index a42b9e7140b..4da656318f6 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -1,9 +1,10 @@
>  /*
>   * Xilinx Versal SoC model.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 or
>   * (at your option) any later version.
> @@ -918,11 +919,11 @@ static void versal_unimp(Versal *s)
>                                  gpio_in);
>  }
>  
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
> -    Versal *s = XLNX_VERSAL(dev);
> +    Versal *s = XLNX_VERSAL_BASE(dev);
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
> @@ -953,13 +954,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
>      memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
>                                          &s->lpd.rpu.mr_ps_alias, 0);
>  }
>  
> -static void versal_init(Object *obj)
> +static void versal_base_init(Object *obj)
>  {
> -    Versal *s = XLNX_VERSAL(obj);
> +    Versal *s = XLNX_VERSAL_BASE(obj);
>  
>      memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
>      memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
>      memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
>      memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
> @@ -973,28 +974,44 @@ static const Property versal_properties[] = {
>                        TYPE_CAN_BUS, CanBusState *),
>      DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
>                        TYPE_CAN_BUS, CanBusState *),
>  };
>  
> -static void versal_class_init(ObjectClass *klass, const void *data)
> +static void versal_base_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->realize = versal_realize;
>      device_class_set_props(dc, versal_properties);
>      /* No VMSD since we haven't got any top-level SoC state to save.  */
>  }
>  
> -static const TypeInfo versal_info = {
> -    .name = TYPE_XLNX_VERSAL,
> +static void versal_class_init(ObjectClass *klass, const void *data)
> +{
> +    VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
> +
> +    vc->version = VERSAL_VER_VERSAL;
> +}
> +
> +static const TypeInfo versal_base_info = {
> +    .name = TYPE_XLNX_VERSAL_BASE,
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(Versal),
> -    .instance_init = versal_init,
> +    .instance_init = versal_base_init,
> +    .class_init = versal_base_class_init,
> +    .class_size = sizeof(VersalClass),
> +    .abstract = true,
> +};
> +
> +static const TypeInfo versal_info = {
> +    .name = TYPE_XLNX_VERSAL,
> +    .parent = TYPE_XLNX_VERSAL_BASE,
>      .class_init = versal_class_init,
>  };
>  
>  static void versal_register_types(void)
>  {
> +    type_register_static(&versal_base_info);
>      type_register_static(&versal_info);
>  }
>  
>  type_init(versal_register_types);
> -- 
> 2.50.1
> 

