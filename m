Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C426C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDoU-0004BY-8Q; Mon, 27 Jul 2026 01:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDoO-0004AN-EL; Mon, 27 Jul 2026 01:23:39 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDoM-0001hZ-O9; Mon, 27 Jul 2026 01:23:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZle2anD5hd5++GAfPAzUBwpCUM1rTNXa+Nb0oPnYAtFZorbst9/hk6q9rx/0Lh3qAI6ccVyQmaJR0pt/Kg++1AkrRylOgrRvrRDCF2vsyBIZq23L4JAil8HccKI7dXbBkeZf+tCjmNeXvFdq9RzgLHSMMQoNkNg9b9t5HIzfWxDWHIOtbI07odyQxDXZuI/AZHCMN76NfZSHu7UwwowpqXsCVK0Cw3SiorSTw7trUgK5Cw6zCGFDCWnzei7pQ9LhNhq0UbfpTW4aOsv6ymiCF7waZrbqzcioz7fNxUVR1EKAiiNAV51H4xxofL5K3mGDqYEJWFvN9z4cJsFeBP9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ytz5v6kg2VQCW6kAJiQcIXm/aU7O1AGk3p70kPsYwUk=;
 b=fS+GOnbgRbblMjo5uJXdepopOvQsKXqUxP7KyRGNr4SLPbM1PjJ6uo2fYLHpG+6eMv/v6FJZFOiLl15PHJtQQaTpaNqfYbUwyxCCJDShZ+bwA7HYI5YglIE7OmM7W36nKvkcw4WrNyqb1PxwZAdQzMH7a1tDWzfchablvNdvq4mRM99ZJXzu03GzRiHQqXrU2cPIOmkeY4uajOtIxJW8uhT1Y3DZp4fMkCt1yZg/zGgfsoGAGw8ft5ukCqmOAaVfJr9EDDLx5cCndfz8f4G9hbD14YDQ+9MCJkyfIe0h1m44AyssQ+vTPac6ywR5owTLoDKQtiYNmgAPI4fDhDksSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytz5v6kg2VQCW6kAJiQcIXm/aU7O1AGk3p70kPsYwUk=;
 b=ccI8BkbZLhFGyLKVm1tsgqeOAL018r8cBVd5UYgGqvVs/LcPg63xUEWEQKHjVmrY5HtALhclyojgkyns8/55URzm/QajrrsvG+OH2SdlEOi6D0fKLWONuHJBHXqAj9vmTF9vXvXZh2b/rv31IjJyow3P36qU9wXybkpTVUUVWTsj8YG9/Tb8fjM4AAlGvR2KqS7PN0hkxrtOVOzj4UKcHdq3N6QkEtkQ63Kakqcr1hL/y0ie9FtctofFF1n4XG6jbRebGZX+AuDY1lvkcQwKQI4xFVZQV/0ZbmCzZmCyWZuzJbhGK0cWMJAoT46jqu+Gp2emkRgh6QaPgXwcIdbH4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB7594.apcprd02.prod.outlook.com (2603:1096:990:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:23:25 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:23:24 +0000
Date: Mon, 27 Jul 2026 13:23:19 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 01/26] hw/riscv: pfsoc: Correct the L2LIM maximum mapped
 size
Message-ID: <ambrO2_sf80l7-en@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-2-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-2-bin.meng@processmission.com>
X-ClientProxiedBy: PH8PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::18) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d955a43-44d3-44e0-012a-08deeb9f2e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|376014|1800799024|23010399003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vfmHzUazy0URPEPVkSAvQq7+o+ouTGR3nzWWVJuGIBX1fjvfWBAnb9Gl+H9xFf16x937fZfNKqZ1ImERlyySVy5XNbkdDCJdwBzAM2ZA5vOFyRd52yNhPoTyRvZMzEkA3vsGPKmZ8diCoTh71j7s1Mgf9nHheU4qLJE7ifmsUDZbM3vSh1OEDyrJSN6oYf39/CG3rKojZlKrDS979M0McuM0MSu/hqVDjA6RHc9pCQKLLmCTILzXyHuAKAESuIdcRXBqZz88SGCG71r98oIFGz1NUXU/JgTiDK+sawfimsgYRfbIrZyzMouWSld6n4I469dAyEFfyIHVzt6LH8lo/MJYMH2lp4cfeU3lrJ7rzQWkIXHjGanH7AxnOYuHluuYZk2JqqIb5TvzCwiVl8/Gq3UowjvES0fVdf9hG1lSE/rhADFS930Q3X+thT7yJLv//a8TgE9MGn0AFYM3+Cmkh4ZGqZLPWz0M1c1iI80DgfwU7B4z/aTE4zqkg2DkgwsCsfo99IiWlQLaCrVZDkZWgAmdEUpMKBp7ltbjlmzbapF0my6WWEvGJ8V40OpsWGWPeMlh9xbJVN3kuBvcjOYCVtsdttixiRO78FmJ7o4l96L2qISXhyM70Sp9k+GbsppXREB5qGSDFrxsn3MR6BsZQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXm7jri8n4wfHgrwsf+WNdvxiMaMjFaGIGErlMLWChEfWnn4S87m4h8plH8O?=
 =?us-ascii?Q?R84aaapj0pi2i14NNoNiiVnk0JkMmXixE7i+aMfEVNDlfXsKv75+DAJK0iig?=
 =?us-ascii?Q?uQqGUJvBkXIS3/WFTRMFnXj4nC4DlPL+PRskB4w9mCeR1vyASYu8QThbCJxE?=
 =?us-ascii?Q?SsOi0oLA2LrW+laGCOGx5iKd9yINURFfQiPYdVDsaRl6URmiK0SJ93Gh9I1y?=
 =?us-ascii?Q?F0qSFEcJmHYwZMkPg+JuRJWpt961r9SVwq17nOWyvwQrhoW/WIHAAaLMnKRH?=
 =?us-ascii?Q?HFArqldPZSUQgIyqcSOfvpoVhpJeq5VrFyeciC1UAC5vPezRstu7TAPuBrYP?=
 =?us-ascii?Q?2karM4g1cvteRVAQLT0AkhrqgS16kzH7QHadgayJ9L1nFou3feRsqPa+H+fB?=
 =?us-ascii?Q?peV2rdJ1fn6lDWMTna7iRDcDTm6KCDOvGN1zSoPwAzzA+sUWFu2oe+WfKNmT?=
 =?us-ascii?Q?IodhEODCKkHUvgh7jQT+FXui+j9Hq3a8Dw9/ZKPOiWPkrjD3iEGZoUUwXOch?=
 =?us-ascii?Q?vLoG0CeF8f+W7sqy0euq12vD/LpwbwJkjORfffm6ZdoR5xGIwpbYwHMbwsd+?=
 =?us-ascii?Q?YJnan9E2K30WRGj9+JJaTG5S1KriItbLdJTVl5qQfGGHqrxN3KQfFGYKtGPR?=
 =?us-ascii?Q?j8NWZbej61JTUOcpZ9LuT9rfli1d/u5tcM0XhqjFnXHa1xMqewF3bLyzw26J?=
 =?us-ascii?Q?L4Yl2zEwTFVNl0bbIwT54tvISryIENC++3y8z5WOxr5izMMKg8Bad/sx7trf?=
 =?us-ascii?Q?i0PElv8recSIocNbUSagnnN7ddHbW00WVJUSaPsfU2kSS6nWAymANiVxSr9c?=
 =?us-ascii?Q?qZlckV8xTlabe25/cNoCNn3EUIlcjOnbeztEAD8YC3/7HBL90ZPgmVIE54Vz?=
 =?us-ascii?Q?6Oi9BbPIi9sRYEYBXFtt3zvAlR9qLgq7B4msR7Hlit4DI+sq3pdazkCc/szo?=
 =?us-ascii?Q?KDYW2nYX7ySErCaGTHPTl7MXB3A+6Ce2Jh5YbnalX+9amNTdyUw+ZXaj8Xga?=
 =?us-ascii?Q?KlOIQV2IQMKEx9r6L/KL6/Sk0b+BgdnwQ5ChhICHP/pZCB4fySexq5eXSeGF?=
 =?us-ascii?Q?COm7loC7pEthkjzPxAWZ+KWOM+gkya+VDAtIJ2y17yF6doAX0NLnflq+yPrk?=
 =?us-ascii?Q?coig3SRUHxE1LA3LZyog+Sr+ggcaEV9EP55phKbZ0BHkg2r7Tpu7w/NAquOV?=
 =?us-ascii?Q?rH8ERkmMjSVrofpmG/k7ytJRTZex8Amr1sumk95DRx8fF4RDwXvGkw8DskJ6?=
 =?us-ascii?Q?MJeD+p6BzFl2Fsf0YM0z07J5UPXz5i2wX8O3eqAxhc++yq7SVyciTKideCtw?=
 =?us-ascii?Q?Us6uEwtjvDgft1Bk1XpRgS1jM9SV1e5d4MbTP5jJiB1RWJ/ti2hkwsFjD9Wy?=
 =?us-ascii?Q?kwKs6F2DGE01P82G/0wP1ExDAyrnKarNEJkgxZYZ1bmdtbUVvT8rCKf6DJO0?=
 =?us-ascii?Q?5dGubyIThWO7j4tifzUT8gDE1UQaZIbAQ3VKV07J9kg01jQDI30/7LUu2YI3?=
 =?us-ascii?Q?BiMam+Qmsxqo32DD6ZHj+LR0zaSgNK+VlUP5k7N6Yx7GNo8XsC2n3NJtt/zc?=
 =?us-ascii?Q?Y3oz5jXgFHulPq5A2kIVC7z+LC94rzyAXKvlEbFXQqUJHkoSZMelJbIZEnK5?=
 =?us-ascii?Q?HtBrkzO/+2f4Vo3wdxn0SIHV/Glofe4GQnHzsVgFKz2oYNnZoEof9DocsJVG?=
 =?us-ascii?Q?eREfLFlvR7Nu0F5gBMVqTRio+B0cw7NdHLwcV+L8GCrJTpg2ewyQqwr0jq3c?=
 =?us-ascii?Q?W9F70yscv+gC0fahEMa9EPzTkNO/yJs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d955a43-44d3-44e0-012a-08deeb9f2e6d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:23:24.6812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3aavrK7mqmjWfTv30RQY16MEZDnnqA59mZmtZIY1zmt19A98ZJkT6z2ByvAo5GdNLi8m7V/GdMK0rUHm418Y6i4dOwIHFI3WZFU6qlixTM=
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

On Thu, Jul 23, 2026 at 11:18:28PM +0800, Bin Meng wrote:
> PolarFire SoC has a 2MiB L2 cache, so the maximum mapped size of
> L2LIM should be set to 2MiB too.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  hw/riscv/microchip_pfsoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 4017129c83..218cccab69 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -96,7 +96,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
>      [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,      0x10000 },
>      [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
>      [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
> -    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,    0x2000000 },
> +    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
>      [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
>      [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
> -- 
> 2.34.1
> 

