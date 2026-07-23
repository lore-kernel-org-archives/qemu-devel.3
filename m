Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C6C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmp0c-0007Tv-2v; Thu, 23 Jul 2026 04:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmp0Y-0007Sh-3b; Thu, 23 Jul 2026 04:42:22 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmp0W-0008Ep-71; Thu, 23 Jul 2026 04:42:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQ22HfRXMYr3mUCGPsArPAsMQ/aS3EKer6VnG9ZbaD0Ufr5axMQ9In00yiJ36tTEQ3qQF23qrcEhVMXZ+VGSeNVFmdu3o6k+utDYjBYK7L7642pgGfSn5WVeqzJI/nXu3GMrz+7bD1iUJpjx3077jyIfRi9LSNj2r1VHk4fGTp0tXGxKsa9WQlTi3zd0uOzu5Gk5JrpXpeFV9aXiEDreEqWmiTvL5iN8yZ6g10j9PFoYfJAF2VRm4xCnP4kPIEpsrE1UlcT42+cdcH12aGZ/SEjfV2g2eWg5F8lUH0Rru0yahadWnRYKhLF5vg2GCfRAhLGR55D2fiJ83aJws/HMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgtgsCYDr3HvGcJPfwXEJts7D8rovo89I5ZmlO8uhHU=;
 b=WMMPyhajXalMvV3oOYnGV234g2kggXEfoF1XCOZneFUYXdhsQU5sGFfDLsBdr+6me4kyRklu68NN0QvJonkyFz0walV94NSKlFBo05GB33pMSLyhh60praaRLdhCDs6Jx8Azym0fdxu+dU/wZ2VlkSqhZ6HHBilvTgoP0OMA8JQ2a1B9qNtTwF8qq4RxcFloVF49csHxMhbfmQX2W9b3j8vi3xkbGD8Tu0YuFiPtBI/tYn5L/aWGrydBu0v/k2eSFgyqFePuIBm4lse1C7nltnp8upF1NJ0sL+4Ms7U7lryUtm3CRpyArq7vjstVYcyfJG0PYLcy2dKhCrqstuwsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgtgsCYDr3HvGcJPfwXEJts7D8rovo89I5ZmlO8uhHU=;
 b=enhQB1oV2HqN+FrfIwISg4LFvsyaUr5LJg0jiLvA3HeAJjS1Q9OGWabryqk7lkDt26dg61fIcZsDrjurm3M1PIwOJddAVhmeSk1fZYrICz1HidclvaMzJbWqKe7LXuH1WcIXJ5ldzUIVJZbo8FGVqobGUThlgixa2yg2Pj8bC5wPDtM0W8CBA1VzszRY9E0oXwg4hv47Kqdx+xVu1iLIx1GETR/Sr7636IliJLSPVQ9Nbl45WhpznaNN1D5xl85tP3aiUS1K9CpS7QxnMb8VqEhjIzVexwYMaCZOWTO0yjEH38DJ+GNxIIFZXHtbbHZtupTI1Jh+huI6HfEh+5fIgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KUXPR02MB9071.apcprd02.prod.outlook.com (2603:1096:d10:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:42:12 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:42:12 +0000
Date: Thu, 23 Jul 2026 16:42:05 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Junze Cao <caojunze424@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 2/3] hw/riscv: Connect K230 DDR controller and PHY models
Message-ID: <amHTzdDJUVGpfzCw@ChaodeMacBook-Pro.local>
References: <20260716132423.931427-1-caojunze424@gmail.com>
 <20260716132423.931427-3-caojunze424@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716132423.931427-3-caojunze424@gmail.com>
X-ClientProxiedBy: PH8PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::17) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KUXPR02MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 3803b062-7294-4099-6b60-08dee8964a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|1800799024|366016|7416014|376014|23010399003|4143699003|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +Z0I72FsiynwGDqYUPXuKRTRp9zL36//a3K0XFFhY/ey8oRA7di/wue0jaLGbZ0yyIe6y1SDQ+I3u4fO3OAS3+A7MMQY4ghSjpDfEpTTj/9qg66kTLZDds/OKcNNm/i4LZLa12fFpfnmndX5WUi3qLSRHnLZRl+IZZNOJtDvyZCpv1eWxlYVdfaQLf/TA45/+6yalgtQJjgTzEDgfiejgg1k3IQUy4eRezkDD+6qKI10RX8LvtOLMkUuWwyuvcCoUYsbeVIZS0KFPFUcd0q1lDvpd7xPvbs033FVoMNZdUiIw0hGQRSkMW1/bfs/1l8HPWmAAU0SjsLGbbylsSpPM/pw7BsozlickG3ZZ3oqld+K1hpqBOVq+sNfMGzGLRWEa17mmVPBm8Eq8WO8AdLoh9x5kizHVc+wRUfyP9JRSKnpJ1KY39Uo+FQzRn44K4Cvk4YE77fR9HR5X2NWIzZ+9kT5prDxNdNAbEI8E7oT3uLOpwkF0F6sEqviWciieUDlAoLv2CAtP/0QYHsEHIqZ439XNIJsJ0px0tQG4f1IN+DzXmTJ5nazbRvTKNtXmYuodSeWcAYA+g/9bMfLnX1MvRtPs8Er0T949Iohr/RJhKRu2WpAqtexlJCFpskob8QVICRO82Ca8/h6UOm98Jpt7pGoXo+E8CcTwXk5sBQLeow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(1800799024)(366016)(7416014)(376014)(23010399003)(4143699003)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BhfgiIJbxHmuPs181NO5ZkT/QDcltNaCNSWTfhk1hC/EyET1amaNBkKMVcC?=
 =?us-ascii?Q?icElRG8KXS/tZAhyivuimroBvQIrMWt/hMRlaxqu5ZgEMKLuOipga9ln2oXU?=
 =?us-ascii?Q?mj5gK1vaE1VdbumEVEgtFqrA4oCJcvweTm963Frqh7z06LhNRTdbfANMQ51j?=
 =?us-ascii?Q?yc1KeKN+voCYDqlYxXZ4CxPQdtazjCxI18oGork61+Y5hJGZc4PH1kVn7RcY?=
 =?us-ascii?Q?iHDh+nbkNIiigqCR1DTB2oRmsxcdxHRrPHNu3pLVkWZkDAZTAKr5zEcqhtWn?=
 =?us-ascii?Q?tFy8XKLqxDuWNwWhc8nXNVQ1kchxSKMGu5wGz6766mm8uG5iGd6+T3r5MfOe?=
 =?us-ascii?Q?bbdTsrVlz2JrWtxauL3jh6FC9DRccFX6dgvJbPAalz02ZB02RBW8Hai7sTcQ?=
 =?us-ascii?Q?ADMJ4aW2JC/xaUbF/ASw4x/KKEt2mVgQV8bk27cO2x6nHgSE0A9e44Bqewhm?=
 =?us-ascii?Q?YKtjMDgFncXtBbwVhAn564N21JeSNEa1JupY0o7kNjHUtAnDCEz3+4+nugtc?=
 =?us-ascii?Q?gvp2HjVXl7CU63g2LGV/lXM69wTTTJnqQxdfIBROnhw0YsLdqAofrcMi0kpT?=
 =?us-ascii?Q?B5iQ5JtFSKtWcq67z4PboDJhJy+yBAHRo1NHkU0Jxoqt5D5K2wjRWn21PMdH?=
 =?us-ascii?Q?yGXdYURvXbD44T3VSkowEPip68NRpKdCaC+CKnzBvKr28sQuoFgth8/5KDKd?=
 =?us-ascii?Q?7evRZPRy10eIf0OJB9nG4SBdvlsJ1X/DF1aWDFIVN3mZpvxNFAw6q4iMcn67?=
 =?us-ascii?Q?yeNpZ8wInoBuUnaUksPWzk3EI1cl3ElT7parIL3ReOWU6f3RfWBpk53s50Fe?=
 =?us-ascii?Q?uYspzTbb7GBH/+kVmdoavmsvVj9oLUh493+7cugut6ZsA47FnFWFs1t/hVTY?=
 =?us-ascii?Q?hxs4QYyMlXwjUhsdljTyGcfv9K80Brl9dhW64C0tDq5StOEPAN9sfP/H6Z8R?=
 =?us-ascii?Q?6ZNNxWh5NwD1urzW0oxc8l43jyS7XZyuI63+lEhmY7G6BI45LDWjNXewe3tj?=
 =?us-ascii?Q?UXkqsoEr+uyjgflQ49ANeXeQZZeiGnwjiR96miOaVilv5huvpH0SRqBZZljx?=
 =?us-ascii?Q?IirPQerP7pYg5a2GMD0gVhyDQehV21H2BK+HiL/Idtxwmq6x+a8HonxYl/56?=
 =?us-ascii?Q?dle7HaN0bsuqKpXSagHyhOu0tDvz67ILP1I7r4nTBqB8kiFDcX4oXtVmvsZR?=
 =?us-ascii?Q?zaDBTuasJZZPZ2XJdzurvve0i1+Q2FUaFFfi7qc0Ze1N/l/pi51uTIfTOtCu?=
 =?us-ascii?Q?vPpPpcu7n4Z7efPqSCa6qR5EgVyZZpb4oJfPLZJIKK96kXlcaOp0H9ecSKNm?=
 =?us-ascii?Q?ydr8Xaso6w9DETQCXfKZAD8TlIsfMBV0XVHNv7Wzj/3a9/dKtOAhmZzkCDsg?=
 =?us-ascii?Q?24dORkaRwdMd3iJ9yR6Z4LuWisNl5hAEWK00tng+h8PnE4f1moF9HpAgeJqi?=
 =?us-ascii?Q?pcO8a5iyO2+UDPfpCZOCRrJJnow0DjVtfcyQEbIvLawnUyem5LZAGV/kqByg?=
 =?us-ascii?Q?nvcHwqMpEnRMd7JtxLek9XoBjLfvyzpCQWd/dFdLBnmB7ylP3Pe2tAJgezLI?=
 =?us-ascii?Q?XSMT5UdPDk8tCWPjl0/ur5gePwKzHWU+M4HDexCRGNnzhivGPnpKRYpoS9WD?=
 =?us-ascii?Q?P9eZcyfz2YUKqOW0zYOco8HONtYuRQVLUpvvoNLBq6b/YhRP4dabmmUG4u41?=
 =?us-ascii?Q?ZKBzR6KVqy5in44N8Aft86Td3ZoyOGkQ6fVLBOsp3OAr/dT5G7WXxCWDOatJ?=
 =?us-ascii?Q?7xGuVyGW3SZ0eXrPgwDmzgfDdxEvH5U=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3803b062-7294-4099-6b60-08dee8964a64
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:42:12.6258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNKDD+6iXMoYQ8VX2KQcJJDDVIcpTGemQAopvEbqS82L25BS74jKDPhSdxFdbLYA8OEJ1W1HM0mWZduHT+hjsuCqaW/tt/fkWhHS3mYRCgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9071
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 16, 2026 at 09:24:22PM +0800, Junze Cao wrote:
> Replace the unimplemented K230 DDR configuration region with the DDRC
> model and map the PHY model at 0x9a000000.
> 
> Connect the controller to the PHY so DFI status reflects PHY training and
> initialization state.
> 
> Signed-off-by: Junze Cao <caojunze424@gmail.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  docs/system/riscv/k230.rst |  4 ++++
>  hw/riscv/k230.c            | 19 ++++++++++++++++---
>  include/hw/riscv/k230.h    |  4 ++++
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..06a819fbdb 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -20,12 +20,16 @@ The ``k230`` machine supports the following devices:
>  * Platform-Level Interrupt Controller (PLIC)
>  * 2 K230 Watchdog Timer
>  * 5 UART
> +* K230 DDRC CFG and DDR PHY
>  
>  Boot options
>  ------------
>  The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then
>  starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
>  
> +The DDRC CFG and DDR PHY models allow the K230 SDK U-Boot SPL to complete DDR
> +initialization before loading the next boot stage.
> +
>  K230 SDK Linux kernels use T-HEAD C9xx private MAEE page table attributes. QEMU
>  does not implement MAEE in the generic RISC-V MMU, so such kernels need to be
>  built with standard RISC-V PTE bits before they can boot under QEMU.
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..627150b463 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -97,6 +97,7 @@ static const MemMapEntry memmap[] = {
>      [K230_DEV_SPI] =          { 0x91584000,  0x00001000 },
>      [K230_DEV_HI_SYS_CFG] =   { 0x91585000,  0x00000400 },
>      [K230_DEV_DDRC_CFG] =     { 0x98000000,  0x02000000 },
> +    [K230_DEV_DDR_PHY] =      { 0x9A000000,  0x00400000 },
>      [K230_DEV_FLASH] =        { 0xC0000000,  0x08000000 },
>      [K230_DEV_PLIC] =         { 0xF00000000, 0x00400000 },
>      [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
> @@ -108,6 +109,11 @@ static void k230_soc_init(Object *obj)
>      RISCVHartArrayState *cpu0 = &s->c908_cpu;
>  
>      object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
> +    object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
> +                            TYPE_K230_DDR_CFG);
> +    object_initialize_child(obj, "ddr-phy", &s->ddr_phy,
> +                            TYPE_K230_DDR_PHY);
> +    s->ddr_cfg.phy = &s->ddr_phy;
>      object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>      object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
>  
> @@ -158,6 +164,16 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      int c908_cpus;
>  
>      sysbus_realize(SYS_BUS_DEVICE(&s->c908_cpu), &error_fatal);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ddr_cfg), errp)) {
> +        return;
> +    }
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ddr_phy), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_cfg), 0,
> +                    memmap[K230_DEV_DDRC_CFG].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_phy), 0,
> +                    memmap[K230_DEV_DDR_PHY].base);
>  
>      c908_cpus = s->c908_cpu.num_harts;
>  
> @@ -361,9 +377,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
>                                  memmap[K230_DEV_HI_SYS_CFG].size);
>  
> -    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
> -                                memmap[K230_DEV_DDRC_CFG].size);
> -
>      create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
>                                  memmap[K230_DEV_FLASH].size);
>  }
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..80ca16338c 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -16,6 +16,7 @@
>  #define HW_K230_H
>  
>  #include "hw/core/boards.h"
> +#include "hw/misc/k230_ddr.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/watchdog/k230_wdt.h"
>  
> @@ -32,6 +33,8 @@ typedef struct K230SoCState {
>      /*< public >*/
>      RISCVHartArrayState c908_cpu; /* Small core */
>  
> +    K230DDRCfgState ddr_cfg;
> +    K230DDRPhyState ddr_phy;
>      K230WdtState wdt[2];
>      MemoryRegion sram;
>      MemoryRegion bootrom;
> @@ -112,6 +115,7 @@ enum {
>      K230_DEV_SPI,
>      K230_DEV_HI_SYS_CFG,
>      K230_DEV_DDRC_CFG,
> +    K230_DEV_DDR_PHY,
>      K230_DEV_FLASH,
>      K230_DEV_PLIC,
>      K230_DEV_CLINT,
> -- 
> 2.53.0
> 

