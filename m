Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61EBCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 17:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux7PG-0003yD-Ua; Fri, 12 Sep 2025 13:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7PC-0003xh-HF; Fri, 12 Sep 2025 13:17:50 -0400
Received: from mail-bn8nam12on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2418::605]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7P9-00043a-3X; Fri, 12 Sep 2025 13:17:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fF8n+4dVmrKojjj7sB8n1Nl38qG8vrJDaznhVdKssMvgRemy7BK5iggVgJfHB8yPy2WHr1A60uvgKC25806UjzweEBYU6Z4r4QOMFn8BzCuxjhpeb5D2SwXoFd4aLNtQ6+DZi4wegF3fXh1r0v3kWorKzf0MpTGIgmkmKSGb41zo+LM0uc830tAYHbAswTjfmm8T7FzuRRlENSOXtHtnCQSr16YolzZlvt+FjQjsnZoiUnnwjbJT1zns50gqKJjjDJTLHTvZmdGcJMWHevZatMdOOlNJs8+TMCSD4s3jUZOBSBbH245T0i06TzcfPBqbaK0b9vRQKVypFOpz6vmu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGcOXY+FrQ4RA/x7SLi9w6uk62xmwctrWLR7lYFg3oU=;
 b=qRfFYh0mbS1EcalbQ9yVoTOLfhZP5uGup9MMyteE7BqjnN006SdbP5e70pPXCNzk2Gm3tCg++jmJb2iZwHa7JG1BFvLRCHau6jACeIe7OQ+rev4qXFh4/4kK+Azi3YqSRuxKOUjVBMHT3cg0mZe+s1Mej6GunJy7yGArxWJ3+Bej1Knpswz68i1r8q4ojjewOWSVsvMqLIdM7i0zNVqGAWaSRwtmI2BU4eHRW75l4w8xQndzkHcWFZR23/nf+CKZ6NEFURJD2tU7U8i6PdAKuCypdpHNN2Bk7ELGLdA0vv2kAY/qCT/V6B/Nniu4u0yWDE6E7knQGKrGEVutKfgRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGcOXY+FrQ4RA/x7SLi9w6uk62xmwctrWLR7lYFg3oU=;
 b=guVzSJDob4bZRjxgdkrDU+7TlwlU7JGLbVeVYriaM4jfxDjgWsRbpW8eHZSX/xUjFsYjOFA8EgXZudGOBQyxZQf8ilIMlZXZADPP8vJoZ4bBBAxfZjC69cqlJ7JcRmnNPrC5TGasKAyT7/+2sje9Y3O1fDcfu7aUmBJvCYifTc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 17:17:41 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 17:17:41 +0000
Date: Fri, 12 Sep 2025 19:17:38 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Message-ID: <aMRVsn6cbN7fjPuq@zapote>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-3-luc.michel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912100059.103997-3-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BN8PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:408:ac::25) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 79700838-b646-4e69-29b8-08ddf220476d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aCLVSrmOT0KEeRJzAuPnjkE8U6RqPyXHqFYh/fd1pP0QgrLPA2/dI1np5UpL?=
 =?us-ascii?Q?n9SGl6sfPGoGx280fyq6fGnv1qAossOcAbv1IMD6+xFCZ7g7rAayBVhR4dIr?=
 =?us-ascii?Q?DdgzPmyBoG79kFGmIHFTwk2oAx0CT8iPLUnPih1dYSs8ewaMxFVbvDeUNEia?=
 =?us-ascii?Q?uj3sK73I5Z5BHwHvBty/h93vQASnD3rsd8oQt/hDIVwwbr7k/ZdliIdVNrhJ?=
 =?us-ascii?Q?iciCMxYjSvjYaRRjkFE1iGpvXvEwuSnsR7161gHmKF/sn5lw/v2ERu7Tb5qh?=
 =?us-ascii?Q?k2qL+Uc528HyLSoZ9DhrB1sgfaIrV1bdVIxwboB4tpGIir3YUIwSU0yUbmpe?=
 =?us-ascii?Q?yFeloL4+XRhnsa2dS5qZa8bfh2YytNvbAyYxsJRdgrn2lZHMYpzS/yFLwcOn?=
 =?us-ascii?Q?Nh3R+SsqnKYYUB4fiD0qpb0iuIDacBI1st5V8KC6BWTeXVti5diTBaLfd/Qd?=
 =?us-ascii?Q?diaBiipSLaUPPketQmhFn8HSPTved82wgukAlgoZwh38Mgcqo+uirOgMZjy3?=
 =?us-ascii?Q?+f9NDXI2OHwChHg4n3knMoJz4octnOngsQmY3tpAUYQDZ7A/vRSM+SHqn/gp?=
 =?us-ascii?Q?EfqQglPK6pJLXFVHvKKIrYDnB8VwRquJswwleCHyvSpCOG5giGIJUTVlfev0?=
 =?us-ascii?Q?uig7ooQz2vZ67KaGQ3IkzqzWMXvycRu6wqLbaaKNKdA/I+HagvVgfC8xNMPY?=
 =?us-ascii?Q?mIaKp7r65aRrB2q1CGNE9+VJDlDzSFbIQ8SBbpTVtaxyDF8yVkX1PCv5K+n6?=
 =?us-ascii?Q?YAa1a5bvSRQewzX7tsI4oFKH8UOBrqsCFVohqps/5XqGceAPdZlHhQXWKvYD?=
 =?us-ascii?Q?XO3eP1dIh2Uqk3hw7k26rS/bh2MBXAbQJsb8JNBPe8OT2+mslejPgtetgctW?=
 =?us-ascii?Q?0lPTS1x7a5F/fMgDQObeDizh3MCOh5JkdTjCuqvIsB/9PXivy1LWpyqhrzMQ?=
 =?us-ascii?Q?P16g0pbinyovj4jhe5HCDbeRQys41o/G+1JXHDR6eRHc1sJiVzdEI3JH3LOa?=
 =?us-ascii?Q?/qoh/g5KD20cQDlVh2/ztkbLdUR3Cu6LqDfD1qHwxDb4OujSWKBVC7YhjAg4?=
 =?us-ascii?Q?eIqG1lBXJT8AbWlCjYp1puR5EfkrT/b4mz4kRsRRxT5Psd1hytIzbxFYb4/9?=
 =?us-ascii?Q?lwY1WQMODKQRGWtXDFLsPaM0kP+luTbWFVSENNXbemcYMo1zziEMIyFo3Jl2?=
 =?us-ascii?Q?zm26n+tDZi0WksXFh4O702Z5YL0iVdxQGDSWZUxr1B8AelFOTrblH/Yyg1pS?=
 =?us-ascii?Q?eUxK5n5QEPWOFk24NAnxmEkc2CJtKEoaF77UipESgFsbhcd2abNctOXtdkiZ?=
 =?us-ascii?Q?DrUpf7UeEam9chgkVSL2V4awUV+XeS0cf9q5Pn5Rzji762TNMM2VDjjLKn2K?=
 =?us-ascii?Q?RnvUwcehKv/PDlDoEtaqh5ckBdzWnUGMuDspN759d8mC8KpGnb3nQ161gOD+?=
 =?us-ascii?Q?cRon3KpYTno=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JUsp8f3g16m8AOscUzxpBFZ2yqdgRDv+2HVuAD/9AVE9u0bLVCHTdObUJPhJ?=
 =?us-ascii?Q?I8C7Q1JVqW30Bci4JDQnAvxjSy+VUSIKIp/vtBkRxZBa8MWNk1AuHI7fT35R?=
 =?us-ascii?Q?yn6EajMamY43YYFJSjcojNE/C+rFyGiU68bPhdVOXPmqgNtNoccmzAsKrSIx?=
 =?us-ascii?Q?pgMRL6FhiVr1DMdxv1yA4B49OqsJivuCmDiKhcVqzhYRMNSNji675CsyJzLa?=
 =?us-ascii?Q?7k85/VtRQ1zQDgA2gUF2T9QzRTRahXJaAVEwHe40PMkPMfCuSMIvZbWcaNrR?=
 =?us-ascii?Q?HIvkpYPmNhOYUQEeouLlLzqZGLu1cRFVnJM2fULx/299CZkvpAHERcj9vVGx?=
 =?us-ascii?Q?ttiTZdRt6sWiZhVUb2kgqoj6LG//QZV1aK+Q1hlyeAao96n+ti1t/7+L0Ich?=
 =?us-ascii?Q?TvzO7vR56sSAEOryMgd0fap0/5dh3a7k7WE1t/JnjXjLukd04tVO7koBz9/E?=
 =?us-ascii?Q?jlaCqEkrvfq0wrbDTySLI8FkQii9O/frPnRwEerwjSK7qRKZOEDwrW5cv5CX?=
 =?us-ascii?Q?XZIlCIR0sulsBoYIMJYk0GXaP8L4Iv4tfm91/7bvrzz68DmofHIHZDu21jiM?=
 =?us-ascii?Q?xe/myeQhPIAe56P7cWqoBokX/z1W+AITxKAg0yeqBQlfAFBc0qgQGUa5oRUv?=
 =?us-ascii?Q?AjIUQmSK9da41QoXBUPY6erNddMq/wN3ln8LKAodwBUsUkZQPuba1xDdKQL1?=
 =?us-ascii?Q?+IwtwoQ+BOldCH0zsV9zl+KCcJvsS29aRSOLwiDtFtCESarJD+v5bUhw8How?=
 =?us-ascii?Q?3hP2X3rAyQx1/cZkyjDUjpHrE+Pn/36yj9+2ijmlWLhmyO3g7j1eqQtdyknd?=
 =?us-ascii?Q?KKzqjsqI5q7j9jrcEskmPLJwrd5E7xM/t/cU+wlPd8y+GpO2BHKMPSMkUNrc?=
 =?us-ascii?Q?Kjw2py7OA4nUFsj8JRgaFS9YvV7FzleoH5T62P2A5fYO5IIneWl3cNJQKSNh?=
 =?us-ascii?Q?eGLBF72rQKPXxHaHZx2YreUQUhADhNBYnYlsftwT4pU9nWgkpeg31Mx8BbHI?=
 =?us-ascii?Q?hYQjkQLase01iXHD1ULqNND1QhJy4az0Iwv3ZHD0eNEeifsJ3YBdvzWMlxlP?=
 =?us-ascii?Q?36LOfwOPQhvloJ5zoQNwGfinoCoEupnnd6DO/XcJWObHgFq9uU8H3n5PxyKY?=
 =?us-ascii?Q?if46TqOqwfpYjhO7BHNAMHH8tVI1pRgQQpvt3FQznT/X/Zt707U5QruBP9lm?=
 =?us-ascii?Q?P3wgyTU4OgU62Y72MwbIWx0ROopKQKwcCBnMqi/rIpsgOiTN/MtAOjFWkE0e?=
 =?us-ascii?Q?i4/8n2DuLDO5lYIwkynW3gItdatF9JkoZYZUAQ6XSDWLiTyUVFf/0Mm+aMxK?=
 =?us-ascii?Q?W3glnDIc3Gy5O8e1mHUm6rehm5YdzQQVGupp00uYHKUkVjWR0pzgHFi5JNE+?=
 =?us-ascii?Q?IS6pPGIz3WnEZqN7V0EiMEnDyzT3SeVloQSWTT5tqiRLEl93tTgz70mmiezq?=
 =?us-ascii?Q?FlJL4ITPZznZsI7c3Ho3MMUkwwo6ezHdkakMR40dKSHObSGqUyHGoVW72Cfj?=
 =?us-ascii?Q?reTF+jfVTDdRkD413xy5AE0Jv7dChXWKn95nJdZKLHXHwVaDgRAtxeDpKZrX?=
 =?us-ascii?Q?dylW+PGmYRLaMSg6my67JVrlkQ/BcqCXPn+qZvHZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79700838-b646-4e69-29b8-08ddf220476d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 17:17:40.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeDXLTjiKLnFy44K6JVT0mFxvuCGFUtl7T3z8/EWxwYoNAP1dnXme4nNWaaoQ5Ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
Received-SPF: permerror client-ip=2a01:111:f403:2418::605;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 12, 2025 at 12:00:11PM +0200, Luc Michel wrote:
> The following commits will move FDT creation logic from the
> xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
> passing the FDT handle to the SoC before it is realized. If no FDT is
> passed, a dummy one is created internally as a stub to the fdt function
> calls.
> 
> For now the SoC only creates the two clock nodes. The ones from the
> xlnx-versal virt machine are renamed with a `old-' prefix and will be
> removed once they are not referenced anymore.


Hi Luc,



> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  include/hw/arm/xlnx-versal.h | 12 ++++++++++++
>  hw/arm/xlnx-versal-virt.c    |  9 ++++++---
>  hw/arm/xlnx-versal.c         | 28 ++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 1f92e314d6c..f2a62b43552 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -134,21 +134,33 @@ struct Versal {
>          XlnxVersalCFrameBcastReg cframe_bcast;
>  
>          OrIRQState apb_irq_orgate;
>      } pmc;
>  
> +    struct {
> +        uint32_t clk_25mhz;
> +        uint32_t clk_125mhz;
> +    } phandle;
> +
>      struct {
>          MemoryRegion *mr_ddr;
> +        void *fdt;
>      } cfg;
>  };
>  
>  struct VersalClass {
>      SysBusDeviceClass parent;
>  
>      VersalVersion version;
>  };
>  
> +static inline void versal_set_fdt(Versal *s, void *fdt)
> +{
> +    g_assert(!qdev_is_realized(DEVICE(s)));
> +    s->cfg.fdt = fdt;
> +}
> +

Should this be a property of some sort? it looks a little odd to bypass QOM..






>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
>  #define VERSAL_GIC_MAINT_IRQ        9
>  #define VERSAL_TIMER_VIRT_IRQ       11
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index adadbb72902..d1c65afa2ac 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -1,9 +1,10 @@
>  /*
>   * Xilinx Versal Virtual board.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 or
>   * (at your option) any later version.
> @@ -695,14 +696,16 @@ static void versal_virt_init(MachineState *machine)
>                               &error_abort);
>      object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
>                               &error_abort);
>      object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
>                               &error_abort);
> -    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>  
>      fdt_create(s);
> +    versal_set_fdt(&s->soc, s->fdt);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>      create_virtio_regions(s);
> +
>      fdt_add_gem_nodes(s);
>      fdt_add_uart_nodes(s);
>      fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
> @@ -712,12 +715,12 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_rtc_node(s);
>      fdt_add_bbram_node(s);
>      fdt_add_efuse_ctrl_node(s);
>      fdt_add_efuse_cache_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> -    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
> -    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
> +    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
> +    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
>  
>      /* Make the APU cpu address space visible to virtio and other
>       * modules unaware of multiple address-spaces.  */
>      memory_region_add_subregion_overlap(get_system_memory(),
>                                          0, &s->soc.fpd.apu.mr, 0);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 4da656318f6..fda8fdf786a 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -22,10 +22,12 @@
>  #include "hw/misc/unimp.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "qemu/log.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
> +#include "system/device_tree.h"
> +#include "hw/arm/fdt.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -917,15 +919,41 @@ static void versal_unimp(Versal *s)
>      qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
>                                  SYSBUS_DEVICE_GPIO_IRQ, 0,
>                                  gpio_in);
>  }
>  
> +static uint32_t fdt_add_clk_node(Versal *s, const char *name,
> +                                 unsigned int freq_hz)
> +{
> +    uint32_t phandle;
> +
> +    phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
> +
> +    qemu_fdt_add_subnode(s->cfg.fdt, name);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "phandle", phandle);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "clock-frequency", freq_hz);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "#clock-cells", 0x0);
> +    qemu_fdt_setprop_string(s->cfg.fdt, name, "compatible", "fixed-clock");
> +    qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
> +
> +    return phandle;
> +}
> +
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
>  
> +    if (s->cfg.fdt == NULL) {
> +        int fdt_size;
> +
> +        s->cfg.fdt = create_device_tree(&fdt_size);
> +    }
> +
> +    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
> +    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
> +

Should we be adding nodes if s->cfg.fdt wasn't created by us?
If the user passes a dtb, I wonder if we should just assume the user
knows what they are doing and use it as is...

Or do you have use-cases where it makes sense?




>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
>      versal_create_uarts(s, pic);
>      versal_create_canfds(s, pic);
> -- 
> 2.50.1
> 

