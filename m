Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9325EC61DD3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09SZ-0005UM-VL; Fri, 28 Aug 2026 23:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09SY-0005Rl-Av; Fri, 28 Aug 2026 23:10:22 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09SW-00069Q-FY; Fri, 28 Aug 2026 23:10:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwOIaIhg+tU3FjH7w1Y6dYZxB6rOHhjd47v4Yonlarf3fR4oBPjm2OxaapB/LntrL8OhT2hJ2ElmJaY6h4b/z5naFOjYjtz/iyX8qUG5KIGFQOyUL1IUB/pEbKS8fNsxLjMruKZrPZFZJay/6yoOH9VCqz9hQu9Q0hryse1iWnz9RYugebFfT/MH7l1goMCkaPGwBu52Jj3bpGqbWgA1C/1D0feZvqgx6nnsghsRgo2FBFgmm5AqOKyrpXJOpT+rW1iHdWzIFkfUKglwH1BI1NWrvJWGr/SkntUOiVv9gGX5Q1Nnlk1I4VH1PxmQS/uaY8kA509Ricpl31WB5DxPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TaFmwdnrDteR09pCRqQDS7B8/X+0XpOwgXOC+ObVSw=;
 b=vHJ1rVLhuhQbBxywcpjkFh+xW4L0Y1mK+9chVlxurljEjDagWN78H9dZMW2fUUw+vZ+3srBzRIK6Pf75FCCVeVAoPxeN+e38q+ccmsSzJiEJygDgsCogPnM/TiHk6Pe8PR5YFURYkS6b1iFz4hAwlDSZBpklKgvNJEsx1X8GiLydntiLzXhqCKX9Q+3yL2a36fd6IsTHlx7fDl5z8Ho/xPdR7kyznSwdlvMVFFBjyYZcjPq+0Q3cLIgLOg0YNTTIfkhz4VRR0Oh07wRZWm2d6NKg6gncagw0dmq6ATyIm9GBHgXaRIZjwH51vM5LE/XCxeHCrmcykXFtqNvwL6imqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TaFmwdnrDteR09pCRqQDS7B8/X+0XpOwgXOC+ObVSw=;
 b=v3G0REV9So98POkfPwqRI8wJ9NQwn+DC5OaxH/DUjPYdZKTkxg97LZLyMrAlc989LA156zKaE1O+GAPScC9hmXiZnOwNroW8ZR+BABXNw2hOrHxf8N5W8Z0138SvTeM+h69llfwfqY7KZzrd9USnR4haMmjwnwck9RBJtnOBbB+P5FOKePj1OZa7qswqhcelOJF7X0KHyLrAal43bAXbbqrc7HvtMl0mq2v5nGgmrSYy/aqO7r6QBOGo9yQl6xXNIa0joR4GFhoL6KYuFLiKNFMexl4PAtVxvZ0e6VBMp0nvAz8cjdB8vkrb8z1tcPLQB7OfBVcU/fblatLAljjgJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:10:15 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:10:15 +0000
Date: Sat, 29 Aug 2026 11:10:11 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
Message-ID: <apJNiclKVDKkNmEI@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 1326079e-a35f-4738-02c1-08df057b0c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q5romwXHhZ+jluQLsgMaiQMVMCkc9d07uwgdWDbPaatzAS6YAc7Pn25Lebrg3jgjk8zjq3IyC/XVs693lSAetX5Ujxz11s6/Bk0BbU6Rk+DmBGzlHZvZn3rlWV5DMpFFEP34J/ytyjjKQEo7LaFHUekj4whQoU91BZnpAIMLxWgnl7/DbifAfUrahBU3ql9t9fjuRzbZBrVPNXnCH/7eHEnx0Nj13WR6ammePuCzBiuPe0ovFGySggeY9l5Ghf0YmFO+7dS1Sso2aTWyCq6rt5rE7elZpBQXJTfPwgeZ2XV8wiUAK9rXoC8WZk1W0K9RKmof/2aL0g4+nXYYlmwEmH1b1hJEo82F0ploeWT9Di07AqmYYIEKjfSQnota4ABau/g6OTZoM+BMksBVTY5rl38zhiaOBJ7VOI9WPJZHPloZ3HoTdxILm3uqJVm3zCODVGTqVptO3UM5626Q1IlkV8UEabrFu2VvYN1vdCue326p2K+sTCFguozDASGJfIMmoNX/OiNjuMWedEr7eyJcED7aVUtLfY9FRwRv+HAOVMwEZiqAFpSg360f/Eh51Dwd1U/ASZVr+Dxoce4qPZvcee3goB55MTDDzf0wwWMk43m+cBLJ/5PY8o+mC0HnA16euqWjpLAaQnAK8BkkQRjoc6ycR3SPbYYivEOc2KoJZws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CBPnMDH3rwKhmtJD7PlNmGxLuC1JhBAL4SIYOiG5d8gNrpXx9srM6S6MtRVN?=
 =?us-ascii?Q?bmRp1NoWeHBMQULZ+8NS23B6oxauZIZyEJK/PyA49dMuoPuL5GcG+WaRJjAE?=
 =?us-ascii?Q?liOKo+kbxCzYvjVYUH+pDvJ6cn7LzHRk8euUqBoyWERevFu2PdUGeMXK93Fu?=
 =?us-ascii?Q?4h7EmiQF85EF2h7aMRd+IEdnj3GstM/7yO57ktTwCF1OdCxJ1cJtV+WAJght?=
 =?us-ascii?Q?xoKpwN5MwYCvNEcWHIDruI4qPcGoYPmayGWBdQYK+veAYONjpyQ4Is0BUvj9?=
 =?us-ascii?Q?Gs1HrIn4RCN1a5TtSJM48b9iVNDg3cyjvK2MxZX5wDuVHAJo69X7kslt2q55?=
 =?us-ascii?Q?GYBpGT2MXOlsCKIckBNTAla3Xx1MlGgBebXBDqTEcUEJMLi8sc2FjfVfSilL?=
 =?us-ascii?Q?QZ+wM5Jp0iqDjLymk2cEEu/arvA0v2nS+GAoiAhd4/M3LRlIT9VjzllyaeIf?=
 =?us-ascii?Q?fITjpNM5Pu/Gt/oij2xpOL/R7sEY639wvMWfqMPLKwjKZXP8DobZmKET7X3Y?=
 =?us-ascii?Q?rLcO/oFoCB0TNinjo5ixW12n12RRARGOeSOwhCZP5wovgNeexftpC7liGhMG?=
 =?us-ascii?Q?4I9c3wu3J2y2N7LNHA66yfXQvCMe15g+1J517Akf8WjpKCGm1v7qq2vdTfVc?=
 =?us-ascii?Q?DoZHjbqKcPSI3G/NMDXsOcbUdN0D+MXKRifrq3PVVsVJMILvntHmqCBCMMGZ?=
 =?us-ascii?Q?DlR7e8Xpd1FSx69IG+ziCWs0RzVepRgsiWuwN/WDGZsY4stCNJQgYG9jo1nH?=
 =?us-ascii?Q?cczDGQEI6xEp7g1knszqgzhVrMtXpB7JAvIY8I4QPaMubW6JoV5tg+iRPuj/?=
 =?us-ascii?Q?ZJP+B/tkwlPF6wgTmW5cjVhdgSR39FtLpjiNQxxQJwKZllGZRBUNju3pMu8M?=
 =?us-ascii?Q?A4fvS0wTDS00EHuhBEi6ZfqnyI5ZbSo5I+ySc0OUCFpgFVtL3EFy9wkX5CV1?=
 =?us-ascii?Q?50z02uHkJdTrXEuL3fCbK2GuF4rvAw+bFz/ywyQJSzB6b2PrYXPOen36z5d+?=
 =?us-ascii?Q?XPhh2uNgYwrxOfIiggwgqLVl5rxLV663S33ju/2BTh8TeROebcuemHg/c1Ac?=
 =?us-ascii?Q?KLgE0PDHIftZfZBbAPpNvU0EL4o0P0io8MMOOtCyvavP8tZFAlN5Wd2qSvU+?=
 =?us-ascii?Q?ZXiXHDw1IhIju7zDqI5c6KnrqmEwU1vU2XXsFoheQ5KwSS/EFSWMulY6DNEi?=
 =?us-ascii?Q?tK9JRxYA53RwdLt5EAsMgx+jAquhYWXH665z/HixeeZCqli/EL1OXbQzOLjR?=
 =?us-ascii?Q?7LsJeZVxmBxDo1Md7fz8fE9fcMvwHm/wMO8GqlhIXKX4CN09iGkTIfdxBDla?=
 =?us-ascii?Q?9beALGK+Z9E+xweza8J7e+WstWHgkcEwwk+zQTxyMt9/Q4kH7WxiCM7qMAPs?=
 =?us-ascii?Q?S09aBDFhpezDaSW5ob26aWxkF+a7+HlkZ2ininKbgnvo3aqDS5oesB4j/mTz?=
 =?us-ascii?Q?MtYGxoOsAJGab5SRi0wd10rK6ZKLToFv6vygYWaaDbyhThe5oiuE0niE4Z81?=
 =?us-ascii?Q?86riv46jIOMWHuqqOA3O98MUYJrFiAxwd6s4iLJTl8CIxUXeihlpMlpkzzYo?=
 =?us-ascii?Q?Aa3po4GrvgiZ7LsaeJ5On31eyzB1XiqUXZ5SDrZ/ofZxan5M0d+80lEcsHT4?=
 =?us-ascii?Q?WOg6oxI23fhR9JzQSgOguKMreEQyRCHZcwqArDO4ahO/5P2S6iiKkFYZVSqk?=
 =?us-ascii?Q?lAn0lFVY2uEtdkAt1ehkNE8Q1erGTJw47jhxK6KiOP76o88gxJ9lAl/CqB/1?=
 =?us-ascii?Q?sfvhrUJDYtIH+ZIFOO9cd4Hxc90oULk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1326079e-a35f-4738-02c1-08df057b0c3b
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:10:15.5715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kqNCi//KZxRW4CsatLzPatHefjbxjVCSe0nhFFywRQ2u2zJmgYBwO70e7FIh11EIR3pEFtm8uVVO+tzm8G9YG88vH1PVQT+hYlftM7aMGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5574
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 28, 2026 at 05:39:10PM +0800, Daniel Henrique Barboza wrote:
> Running 'dtc' to generate a readable fdt for the virt machine produce
> warnings:
> 
>  $ dtc -I dtb -O dts virt.dtb > virt.dts
> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"
> 
> This happens because the 'reg' field does not match the address in the
> nodename.  The right fix, pointed out by Chao in [1], is to make the
> nodename match the reg value:
> 
> "In the current QEMU implement, `addr` is the MTIMECMP base address,
> while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."
> 
> In other words, the 'reg' value is correct but the nodename isn't.
> 
> We'll make the fix now, allowing the next patch to move the fixed version
> of aclint FDT to fdt-common.
> 
> [1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Chao Liu <chao.liu@processmission.com>
> Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a6ec9def16..83a4b7710d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -234,7 +234,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
>                 (s->memmap[VIRT_CLINT].size * socket);
>          size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
>      }
> -    name = g_strdup_printf("/soc/mtimer@%lx", addr);
> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
> +                           addr + RISCV_ACLINT_DEFAULT_MTIME);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>          "riscv,aclint-mtimer");
> -- 
> 2.43.0
> 

