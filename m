Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1085DC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDoy-0004Jx-Bo; Mon, 27 Jul 2026 01:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDox-0004Hc-6G; Mon, 27 Jul 2026 01:24:11 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDov-0001jb-N0; Mon, 27 Jul 2026 01:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrjstxsqR2t57AGGu8VQp8b0K99HM3ZFUAiFqv15UZ64N13O3JkUme+U2d2frQkcLpuUw51wKPW3S2MYDP0mQncl1ArogJiN2qMFQl8AAt0OM/LuS7J2dXHhlyFngxu4exwfBX1moRHM3a9IEwkok3Xcc+uAkPoTTSIGxBq5dY5LcrsqW5w9nKwbhoGAaHXJw70vhcFVBrEG6tQueD+acazzYqiAfvluOOpVRQMH7wJuml9XDhXDo49QJej8UmNh89sj1am1gbakYL1IrSPSDSXBNkBjiVucqWiicZEyrUBHvZunCLXC8AJfYuRfqHS0KH8tvofrmZMkfoUTT6cVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSgiqIfK9XGSxkC6Manp3ijUoj04nESnRrPlRQ/a4Ps=;
 b=eK7weAKQYi4w8FaapjzRBWLHObwgJae87slA8iMkytCTyQvjKPwCnRWioPg99CgXrYIHBYxpGwtvMWZc9Hs9GBh/bBFMRv600Ozcxcj9xVkguwLV6MoQRe2930ylRE9wUXunTSg4Hem8isG88hS4zjs0Qeh1AdwaDwR5ReVfn03MAYAx9/CljODail3Xy2rhkD0M7GjVOqCTy+wo7rTh9hy2IkchJzPPo09umMSCoB9boZYYeWPRsIYr6xjDxAmmXt5wiHQnO0FsRdkm/p1YIo3U/Fp95xeXT1JGfkAGkZvqg+972qnWubRoTCr8nfMR/JY4PUfTBaQtrPiXbEiobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSgiqIfK9XGSxkC6Manp3ijUoj04nESnRrPlRQ/a4Ps=;
 b=im/u7G5s9cSmumtKZ/J1oIOwDxqkkQriVZkf8ar20FX0YpHWRKuHHECKQUNvpHKuzn0Y19FqP9UgA3vwku3pTSnqADPl4ojIzt1S8BoSp/2mxLZvRzTTzaD3igNkpZcQLRDXB/fFpy3JrpOcbjh3i4yeQaXI51j2gGWRgaS2itC1aAqCnZIxUV6fR9AGvjsqJz0mMLA2VHHDQw5fb6aEx6OWCvQaD1j2JqllMCNSCiyTSw7vCWo+phvc3sHuXcqc6u2ZyeDV5TJjVuouYLs33Z5nttARLmt8ABqHVUw60IMAkeS7h9NdnN/449oXrp4x1eVLdjcL11L+UYOlLCbo3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB7594.apcprd02.prod.outlook.com (2603:1096:990:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:24:05 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:24:05 +0000
Date: Mon, 27 Jul 2026 13:24:00 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 02/26] hw/riscv: pfsoc: Map the L2 zero device window
Message-ID: <ambrZ5BsrYjIAUcP@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-3-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-3-bin.meng@processmission.com>
X-ClientProxiedBy: PH7P220CA0080.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::23) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a48a13d-f04d-4459-3f0d-08deeb9f46e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|376014|1800799024|23010399003|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jWeVkD5ZFwyNWoFC6M631b7SxbBSXp5PUX65ttSSKMwng93Y8rSpjJM3OvFhI6U+NyFc9q7R+xbb5lnSCqpW3+js0qgmTDDrDfWeZmBvYRDN4WApmU0/j8ZLYZcFLqeAIWrOu26OTCNdSNyRbbRkdW7ZdAe+GvrPwqhpbyNHZtM2X4yJnCQz+NDaYql3tTJDaeDxroR+hgWRJ+GifU/GHYI0yGHe4+8cGWBpoyKbonp5Q4sA3ec+4fxjfO1wpywUYinH+LC3g1ksvJLORnSrE7/t2ZKXkcVAh8qROBigJLjsFLyr+mbnpDXEw/dDh+bvt0zcZm0sm1c1errtHgmGBzMrwj4Bfkxt0Fi7wb4z+3B1Fe4H/LiFVpT4aApBoFONPMu4S4gWUmY3vA66M/zJsQuWCjFrqnOXMAqNDOIqHAJSEgfPAbMXinE9j9cjRwBHst0+6jvMt7IYyQJ7A9AById4n1aTF/tswpIjEWMIceYML0GzSBNlnA+yP767MhY1cE3SGNybBtyYmedoxbi3T+D88uyMWY3nuZO6GeXhDBWWpDPVx4QrAxsKSv1Hr2zvdbgQaDDecHdui0zPrDsUEokUxr9y63zt16UiYh286GEnTZXECcU9FOEXcLNaJTfusi3JDBGAWA7kWPCGsptcK+EesAsqYCDEE4PkTsP14Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFaOAQ8vbhU1pw8H8jNxQcqWKDGuterCms8Npxv0wOdnXzNi4UlSZ5wE5Y8t?=
 =?us-ascii?Q?kbuO57sw33wOCp8xi50lG6UZLhm2BRv4ssZmjcIRudxYOLvma0u5hIDhCrQY?=
 =?us-ascii?Q?7mR+VZGxe0TTjO7T7JrulmlKihULSX/9f1Rp0RLm9Ey8HLPtNE5sGNhdp1be?=
 =?us-ascii?Q?tZ+dJXqIUE2iExJPE/VV4n4gKcFyJxZ31X4AB36HbcQlEgH5JH+lfPhvgMg+?=
 =?us-ascii?Q?ZeTFBDlCPtJnQqclQ4UFWVHxqGxYMGYMYqjaP1/Lv05/Y7g4g4Q+47U0dlGj?=
 =?us-ascii?Q?QpiQzQ9yqh0TsF/zBWGZlhXgwHZkXfdUHIpTrsJPcAkeYotLTUVLSdCfpV2K?=
 =?us-ascii?Q?R5BBwCnLYGmzD10+CTH3TAPnq6/zQK1WdqxTQLBZABXKwfg3HBcXZGhlulDd?=
 =?us-ascii?Q?bJyVAol/zOQWiNoYGoxOcIdnOcVShnI6L9+SB8UJgXV/LyRuZKC8FuUnXRWy?=
 =?us-ascii?Q?jZEa3RaGz1EKRiDKyDdu2BMLp3048qXqpnm2YDd/kr0aqfpzqxaeOcpIRGwN?=
 =?us-ascii?Q?q0VVc804Iq2TIrMA4YdB2QiOy5CkyyUN3WDnJN3Qe89ehnj5/I9WTafBY02i?=
 =?us-ascii?Q?/H8P48saA4Dyae9KftQa1JhMwTy0oIau47shDVXYk7cTVifpxSdqJ/yCQnDf?=
 =?us-ascii?Q?DA2H7e+pAdVfjcKLW61+pcXTKQ0fr9GiQ1Xt4JZE0FbxtT79bI/ZJm4w1/gx?=
 =?us-ascii?Q?1r5ffK4JxpXclk3YqxKSAYcrJJAtzaVL024nA7FskMJZRdhF1ldzCxKnIPzH?=
 =?us-ascii?Q?Ep/jEs7r+MakcWF/IO1dPUF3wMv2I8LQmBOhXJ0qwfb3D87Q6O2XnT4ImVNl?=
 =?us-ascii?Q?ztR7JTkBm1SNDCNQhL01Kiz7vFQ04uu6NSp21qF80syRpSZ5t+UqRIY0f0py?=
 =?us-ascii?Q?B/Gz6NDLxwqUKnsV01xn/QgFgS7wXrqCGGQLKQbLEUrsPya63AmwiCsn01CA?=
 =?us-ascii?Q?ACiUy6YkoYF7f4wpeTE4rTlFO8xO6k05QMUwaCLU4/h+Ym0BjTxCvWFm//+d?=
 =?us-ascii?Q?gssf6OFMyXC1oIBM0MFhx9+P6DclOfAgoMfvVVl2yr2okKCLHS5IboUrTWOB?=
 =?us-ascii?Q?bzmkneeUmlcrDb/XRho8GCVuEfu5WlymSCiuarssXS9Qrah3wzOpyb6A57My?=
 =?us-ascii?Q?eJNal+o9OIhdx/nB64TikzPp6f05QVg5HiXNldoFqZVtt620ct4r1hNgEAmi?=
 =?us-ascii?Q?P7AheYQGH/Zu/0paQdKRBYw5AGdSZoWTb74CET1zAL3az/hgNy+zjdXLk4XZ?=
 =?us-ascii?Q?2MDICdnEoKr8cZCPvgDbURLVXtlqG0pWzEYsjrYLGjg2UI1t1jh9kpi9sdBw?=
 =?us-ascii?Q?ysrCnh9usqHMgiJvQCRkVRoWA63/mzjDLQ1BVBoCnag77Tns//El4qsqWmyh?=
 =?us-ascii?Q?zigfRTg94l5N8CTDayBM0NXb0AIQboTTLMXHQtyjvfyiuWQw3caYf/MyT6Hv?=
 =?us-ascii?Q?QhhfJmrAOIEyx99vYDBdSpCp0l3Lx3SUDlj0HXn5fpSKvRUQBCcQ4T5hdUeV?=
 =?us-ascii?Q?YQVEm/cyg8f04V63/oPFniaJ65NPIL98fyiBPaqH7NeXf1qoRkJSrZBdJ/ok?=
 =?us-ascii?Q?UNz7IEIbvv9DEr2zvUYvJeoArEzD0kikUfrot4IRBToHTDRK/r5CseFAGp6C?=
 =?us-ascii?Q?ThyjWLZiOXLLC385AoLvdguio7z0VnFRxg7gmATwqj4r1arTe+hWfZ1RnkXw?=
 =?us-ascii?Q?B4sDKGPXO3JcDogx0PoSGii+lu4B3Z0hsSarv1xcI52dOl0V9DM2nr3gHAjw?=
 =?us-ascii?Q?hF/WAmuy/VpTTbAMddTWZTMij3GbYlM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a48a13d-f04d-4459-3f0d-08deeb9f46e7
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:24:05.6637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzwY+qNTDybSCPDUUTH0xYB1HwKws4YU890AXs/99b9yONQl/weo9tz/SIthbBHTyloaZYdjYfvSBIOFot2qWMxtnjF6F/cXe5YnQ/9E71c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7594
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

On Thu, Jul 23, 2026 at 11:18:29PM +0800, Bin Meng wrote:
> HSS uses a window at 0x0a000000 while setting up the L2 cache,
> decompressing its runtime image, and executing that image.
> The missing mapping causes the E51 to trap before firmware can
> initialize its UART.
> 
> Represent the window with RAM to provide its persistent read,
> write, and execute effects without claiming to model the L2
> cache itself.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  include/hw/riscv/microchip_pfsoc.h |  1 +
>  hw/riscv/microchip_pfsoc.c         | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index a30b944afa..612fd2b69c 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -90,6 +90,7 @@ enum {
>      MICROCHIP_PFSOC_L2CC,
>      MICROCHIP_PFSOC_DMA,
>      MICROCHIP_PFSOC_L2LIM,
> +    MICROCHIP_PFSOC_L2ZERO,
>      MICROCHIP_PFSOC_PLIC,
>      MICROCHIP_PFSOC_MMUART0,
>      MICROCHIP_PFSOC_WDOG0,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 218cccab69..fd28ee75fe 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -97,6 +97,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
>      [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
>      [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
>      [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
> +    [MICROCHIP_PFSOC_L2ZERO] =          {  0xa000000,     0x200000 },
>      [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
>      [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
> @@ -201,6 +202,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
> +    MemoryRegion *l2zero_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *envm_data = g_new(MemoryRegion, 1);
>      MemoryRegion *qspi_xip_mem = g_new(MemoryRegion, 1);
>      char *plic_hart_config;
> @@ -277,6 +279,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>                                  memmap[MICROCHIP_PFSOC_L2LIM].base,
>                                  l2lim_mem);
>  
> +    /*
> +     * HSS decompresses into the L2 zero-device window and executes there.
> +     * Model it as RAM because QEMU does not model the backing L2 cache.
> +     */
> +    memory_region_init_ram(l2zero_mem, NULL, "microchip.pfsoc.l2zero",
> +                           memmap[MICROCHIP_PFSOC_L2ZERO].size,
> +                           &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_L2ZERO].base,
> +                                l2zero_mem);
> +
>      /* create PLIC hart topology configuration string */
>      plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
>  
> -- 
> 2.34.1
> 

