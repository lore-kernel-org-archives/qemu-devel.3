Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23578C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDyG-00088t-Gv; Mon, 27 Jul 2026 01:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDy4-00088C-K2; Mon, 27 Jul 2026 01:33:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDy3-0002um-36; Mon, 27 Jul 2026 01:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVo6yjpIaBH66nZ/Id7pEjH5cRClijzxnNcumE1wWSlk8vCkCsVs7uOrn4joBcqnKlNWQX5UqFON/PkADZMDE+sPLDaT+BynbNmoGqf+7ke4XHBMo7OBrhxI/MFdokunhoQjGwekpS1jJyEc1IFn3KGnOOpps/bfW+n2Bh6ugFkezn7z/LzvsZK56bsisjCyASmFM8kdmB9rlnF8Fj2eyNAYSOzUsyF8wdG7VmnpXz7D5p2YIzxAtVVsWV6Idgh18RXBcYBnSCRz8sIBtGdFEp0z4iI2n+ST7ygajyAsFbOpjZ2zXm/tjrI5+OySQck60k6s8QzrHNuh9b9eDh6BbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUc7N0EVF/t/FlXDKo/6rqoMnPmb8XmCeUSjhicN+wc=;
 b=oSgpwo2x6O1YHG6lXFONT1Unz4OUcFr9OsBb7YdKcWWfbOGDoJpqAIHhKVFhUTH7eyoV5maUVr8zjCrVEd+nOil/5/0vt18jeq3Bt4sgi8JGGLxayRQjnlNoSz1Mq5BrSdhKzaK7ddJ9BZwiMGalepF0oMGXKcbmaGsns+Mh6Y9SnVgaAGBrdzBvIijncjyQxJO3Y6+EjS1xJXSRYJvMzxO1eav8NDk4U/TkHE5ysYo3+ZCXfKZqqT5oTIefVyZ6PWhP3DiCMD0Fc+z5xoYKR3YRoszTmeOL1VyKGCZ/94F+n/R7G/nCJXG7LnrJ9fMiyWpYOQfplwTyHvY0Tdq80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUc7N0EVF/t/FlXDKo/6rqoMnPmb8XmCeUSjhicN+wc=;
 b=t8w+ZZVNvRcTEtC/ZvrOsmNDlDQMNdQpzkpoAtYks6tfvXl0mCuUSfxDHPcjZw7RoRfz5tHQDRNdyGh9ACrne+3YKCJW+VOny+Q8B2PmPC3whEisWjC9VdZdZitnE+ne97fM8zec9fChy+rUSvg6SZB4UBwrxYYQnXmynzqqWBuYRRV2tGTOF98Or3d66RQ2rQfq+uxN+xl83ySbneyMxBB1Zq+gQVeHTXbjZh94Q9wby4unF9a1MMZmPhuotnGSnaXZaRvNKMYInlF+2lEY2zcwmAnBCcV4Fya+/E6bQIlM7UYqRtUw7MatcLSrQcU71fKV6+Eg2jYFiJ0BtmF+dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB6022.apcprd02.prod.outlook.com (2603:1096:4:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:33:28 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:33:28 +0000
Date: Mon, 27 Jul 2026 13:33:23 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 20/26] hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
Message-ID: <ambtnOsiai7HZMB-@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-21-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-21-bin.meng@processmission.com>
X-ClientProxiedBy: PH8P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::25) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: bf71de8d-4106-4a73-d5e1-08deeba09625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: RRAMmpz/BLAOzk3X3JMYRqOQYaAn3HYc/q0KF91mZQSEUdyEAwhJIlcac+gdp71IJbsNGuJZCr3C0LoBuqBLVWfFVaYQ6KtUWWOm8lkjoYG1VrC+SCP5irBUzkU305TKuLAdQSTBWJlPRBosEk5dchwQ8ujlCsW6CnEB3RcKmA1URf1hJzIUUm69qMJXEbMhQDDUSpPhG3Aoxa+l335X/FjitwIEggPfqdW/dHFDJYpVKPvR1ngc3PBfUS4/M7Jh4QUGbmECFmGyXRXlsCmL5PQ8nRT9C+AC/a0NWU9xgy3oWIuiI1ICwNv4kG/2d3iHeW7nqC+10UeSr8GV5UoYs4fyAO9q0d6Czmu6aSmK6wHcegxs0jqbdZNiiYvRlCcNeu7/mVnYHHWVqkmG617lAE6ZiPr6xEKLEazKAtkbQHIVq5lgJK3cfZ5y20VxbJZh1ZprSyu7ysa9CBn2rASbhiT+UHnIg7nXvDlz/1cepzd3ZArCcvueAFrb7oap78vIpcsyBS/zjUlxF/AnYvuua3doz1IQq3pv5QFGbseTgyzznnt8u35eAX2escYqVrV0s+Am7R++tWaYglQ+UKqcLF7c1Go+kPF10huLMhqeUl7NUfI3Fo1Ibu+ucIh3QY4H7o81MFlRQjH+a+dJvo63uygd8UZpXt3+hYN4JU58Bgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fnJBHcr/IixZfWsSpu+kxXnW5dcqwi4fbU66JHDhgDJGmAvuxUuRoHEzSZo/?=
 =?us-ascii?Q?C33kemH1waQXNww797iam9OK4z4Th1UF6alX1hVh+nRe1QzIvWdVx3oFZy0f?=
 =?us-ascii?Q?Qr7kdSCnr/YgoLwEUGxYNkKWicrlDmpwX+4gf3XNVOnsf9sODWC8TkXXF6CB?=
 =?us-ascii?Q?mRAksdnmVcozmbGc1GousWkkinDtzyFH4xQyZ1yw+DFt316eYyYmskKSNwLQ?=
 =?us-ascii?Q?t5e6IB6qnxhl1MKgD3EjkLbfZaqraXLguYSmG1Rhom7GCO3f4TPQ84GXt7Ya?=
 =?us-ascii?Q?tcNMzAJ9iO4221StJ8XkGtzdGkyTsZAphE0rU59oXvVPRnsNEVupn+5sxzVc?=
 =?us-ascii?Q?rSsCd9lxZC76HboH/ncagpNTG24OIk/MmINa8RCtSfK/cXzioaddzlkzPOKT?=
 =?us-ascii?Q?p3SN5M8i8zSLfh2Wszq3RoVBm0VO/X498QvOmGxK4lXLln2mBa0GwJIGAqDd?=
 =?us-ascii?Q?Pqo15GWFHaSauKgJ/QzXciY6jAqhLkVG30kH6NyLr3VZOYhLGTzZlN3BYpst?=
 =?us-ascii?Q?AaUomj4E4INECjwI8abkie9nYrl1QJ/sGg9EIj55YXf+u/Iirw4zMEc2vunI?=
 =?us-ascii?Q?V4aWk/zQmRGfzPhnHHep7lFiHCHSBXLSZ31jG77FngBKep1/4nPGc48ENhZ1?=
 =?us-ascii?Q?tIVcsmNoe9vwwAdC2VAV65K0oE7FjTbewOJfSOL51xyWPjlKzrZjKSCYJ7aE?=
 =?us-ascii?Q?iz+DG7Sgrjf4N6d7/yQFm2h4kvmtyjWv1L2rdZzsl39oq7Jjmub2HSeIeTg6?=
 =?us-ascii?Q?zSCRmOOdLeV4/MtT7n/sR0pDRdKvwFvHqaI9j90LLv3SJUAJJR698uB1OhXD?=
 =?us-ascii?Q?mnzQV+q7of9gGuqtkI0twUDfANC/3ct5L7AkxL51VwHdRU4dQrWHB8+C113s?=
 =?us-ascii?Q?7DgtglfmAoMBB+UPSQhgJ/gaWBvvn60U3dYZwbIotQVYj+YF9CRZXsutN7A1?=
 =?us-ascii?Q?3quFL9OHMt7ji8dYYVNL8R/30Gh7RsNKwCugpCcbeXtf4HWNoAZ8+4Be+3oj?=
 =?us-ascii?Q?CqltPKyZMBRkgyklFQuuch74h5OW1dg9COL/uoiz3DeqFH//1MtY7eYdykiw?=
 =?us-ascii?Q?eVajGGeNVbdvDIIkNZzECbKU/vIXpY8tAgGA5Vgrzp/sCBpPYbyrQZOTHA2o?=
 =?us-ascii?Q?Kgb8ADoW5j853X7Bfi5+aGKw0FzHpkv0HrRmWBFnfb0dYDLCQoKMjv9niOxC?=
 =?us-ascii?Q?NO7Tser/xQXbhUNcpkgeCFlGwFXnVtxFe4Jh9tgnFzlKEEiD4r3dt3xsQiKZ?=
 =?us-ascii?Q?npRl1X8FiNYlwNHTyPgEQ+gcMe8mLYOReHVWN+cQT6JWx5MCyVjInnNWa4Ha?=
 =?us-ascii?Q?EP/+WokkEKYA7AUnR5EsBatFDUKeWowrLAGsPUF4rMT0zJtPiQMBEakZOCpu?=
 =?us-ascii?Q?Lk5H25PVi9pV4UdCZaRh/KUH8cQdKpzjZ86ChUdQ9g2pQSo7sSm0xqw5f9xn?=
 =?us-ascii?Q?GctKwrgnUDpJ/8rAD7EwBJLY5sN3oHO8aR0BVqBKIlfyztZr4B7FcGpGF8I5?=
 =?us-ascii?Q?fzIiYNajNfO8DWrQoqD5ONthLEsrdI1hR+WkAyREDZXIJa72Bgj/TXMqjTj9?=
 =?us-ascii?Q?FkPw4ynKL5PKAPT3B1PGgVyEAPyMncxsXb5dCXCtCcQef/kGP9sBFijvUpPj?=
 =?us-ascii?Q?gc0IKXlZ1cQjF1pXdJNXSjJIz+dOXKc40GyB+4CHdn+vutRz3QiDs4nwpf1u?=
 =?us-ascii?Q?BvXJ6B7MVoB4O4B2V4QLLgHdk7sSIMDhrnJDXo4eFdW2cEPWnYdzlJ0FRXue?=
 =?us-ascii?Q?tr0zbNdCdeSlLyQl6gQRMAlEhgSlu+g=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf71de8d-4106-4a73-d5e1-08deeba09625
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:33:28.1030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Z5fagyGAy8OTM/uqdDHNDpaor/UaXeuB7vrjXD+PHvFtRN/K1JH++LiHyUxpHH/qm4FxqwX9nh7PTBWLkRyzZi4v8NVNUra1jpQZByjkSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB6022
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

On Thu, Jul 23, 2026 at 11:18:47PM +0800, Bin Meng wrote:
> The 64-bit cached and non-cached windows alias the complete physical
> DDR from offset zero. Treating them as only the portion above 1 GiB
> leaves valid Icicle Kit memory nodes unbacked with the board's 2 GiB.
> 
> Map both high windows over the full machine RAM.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  hw/riscv/microchip_pfsoc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index f348de6fd4..a2fbc89222 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -570,15 +570,27 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>                              TYPE_MICROCHIP_PFSOC);
>      qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
>  
> -    /* Split RAM into low and high regions using aliases to machine->ram */
> +    /*
> +     * The four CPU-visible windows alias the same physical DDR from offset
> +     * zero. For the Icicle Kit's 2 GiB of DDR, they map as follows:
> +     *
> +     * CPU address     Attribute           Visible size   DDR range
> +     * 0x0080000000    32-bit cached       1 GiB          [0, 1 GiB)
> +     * 0x00c0000000    32-bit non-cached   1 GiB          [0, 1 GiB)
> +     * 0x1000000000    64-bit cached       2 GiB          [0, 2 GiB)
> +     * 0x1400000000    64-bit non-cached   2 GiB          [0, 2 GiB)
> +     *
> +     * "Low" and "high" describe the CPU address windows, not the lower and
> +     * upper portions of physical DDR.
> +     */
>      mem_low_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
> -    mem_high_size = machine->ram_size - mem_low_size;
> +    mem_high_size = machine->ram_size;
>      memory_region_init_alias(mem_low, NULL,
>                               "microchip.icicle.kit.ram_low", machine->ram,
>                               0, mem_low_size);
>      memory_region_init_alias(mem_high, NULL,
>                               "microchip.icicle.kit.ram_high", machine->ram,
> -                             mem_low_size, mem_high_size);
> +                             0, mem_high_size);
>  
>      /* Register RAM */
>      memory_region_add_subregion(system_memory,
> -- 
> 2.34.1
> 

