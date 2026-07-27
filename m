Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971DBC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woElt-0003Ea-RC; Mon, 27 Jul 2026 02:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEls-0003D3-E1; Mon, 27 Jul 2026 02:25:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woElq-0007tH-Qw; Mon, 27 Jul 2026 02:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHNRBRx9qq6EUSaY6+ZeVBKilTFvZFK7kTXwNmXYUJT5YayGWeQ/YSGnpro3Ma88ya2v8L3SqcU4VK5rIHSwT7xCxYpvLTlWueXhucsqndm2b3DsV8xLv+S7JElV6H8OCcZR9AaGFCNnDpq6MXh7ygN1TnRPEQZARPJmNGlCZMylP9S2h4tZtAJ5axeJ+ZH1EVnqsVy36CVOaIJRGe+2P6oER5r0pjdtOpr6jdoT7H7EIlDugO596R4BxedCa0iil6CoEMzZ3AELdBP5g01Oj93YRe/cH6VmYOjAxoEkx7XBAoqtrppsgFyaz5qbZHVZKPEmru7YRjC6juj5AZ+tsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LQ4M7GPHG5pVkF+tSJd6evYJmHtjQlVGh/nothZuPE=;
 b=ll/igqXruE9EURTFjxU2Wz2tw8CSPt1W/5fz5g7bwYiQ4hYZzS9rfJpw+MdwLD2SI3YUwxmBgEMMeIxsjWbrJLzwfpz50hSN+fAGiNv5EVVfSi54ruJOPZy1d+XPbssZwXHkdftwKeNQAf99gwCtVY2Dgedgm3dLkMySKePEIo+BJHgUhce2/NRa+q67P5Ag1MBMfuCuSN42FLLSi3nBO3FiZuOArNjdOQmezzVtkA2vrVIOfUMZsp/7oKX2sodW/nfb3Emq5Mzl1+phfbcgVKLqMmA5fgwZNFQqJuZAmiElOsAj0PJy6V0Xyhqu/D444OWtmHASd9kXbjDVb3gyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LQ4M7GPHG5pVkF+tSJd6evYJmHtjQlVGh/nothZuPE=;
 b=HgDhuj5sZGJ2L93ZYntynOm9Ypff8dtl+Zl7YQtLMGvala+9vdOfD2dS/T77UDa2Rko4ahFPTtjgUBcUgZh6WWdylAbN+vKDY1bkWaMZhT2Xc1PQMe5jxaiese5zrZvbJfTAI0Dg6TKjWse+9Hk/50yHeMSyU60dHxPqUlJrcKfZSelUlUs9kRiszQ/cZ3QDdokKI+aunbAxElhFQgDhhwUMlDw7AQkq/+z+6Line2GFE6XMxN0fh6V1rKEYUCiQ51g7AAyYNI/iPuLcfN8aiyazrgXplMHNYRBlW2UIMva0ywXO4okBghLm1pUkaSfYeGHr/TIT7SndqEYrR8kFJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5624.apcprd02.prod.outlook.com (2603:1096:400:1b0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:24:56 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:24:56 +0000
Date: Mon, 27 Jul 2026 14:24:50 +0800
From: Chao Liu <chao.liu@processmission.com>
To: flavien.solt97@gmail.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-stable@nongnu.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
Message-ID: <amb5qPU3oPI9bF9u@ChaodeMacBook-Pro.local>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
 <CANVUYGvtuMbxE6TCkO98G1rCadb0psdn8HQM+6T8v0KE+QVr5g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANVUYGvtuMbxE6TCkO98G1rCadb0psdn8HQM+6T8v0KE+QVr5g@mail.gmail.com>
X-ClientProxiedBy: PH8P220CA0056.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::35) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f7fbe4-31ea-481a-9743-08deeba7c6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|7416014|366016|23010399003|1800799024|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7GsGk0I6F54kYAxiG72FP0XpkeoqFfXnYkQ3bYi2bCsuJOMyq2RmMG/9h59VovhrzkqZj0vfypgCJMeAtSk1fjq6jbEM6mxgmk2TJn8QW6Lr4XmB2WNJMLY3UMCcg243fq6hRNq+UIiblpn+Wmv7w+0DDnn5Y7xgkZMqQn5hUZ9PMk7bvdmVG+wZCcMGNcMD59MY4TK1e5hhNdvOrDVWlJagXQJHbvahDnte4srifKZu3m+NF7DxBJtpAxni6QnSRm3nO70jTUoyl2m9aUNgOqu16I6x1iTntLGGKgUvpJKzbP8lCTTVLmf+3+qBj08f8yU8Zy8Hvo5wvLCTAEewxbCZnwXgbjaNM0lBpv/708RWkMueZ69X7Do6H7lxdTivizsbwkr5FbcqI/bwhiJQ0BsywrDPALlBgF8UPhIB0Q+sy/lgAWFHiB2fzBTfQxfFZGa3/bC0EXkCO7g4cUq6eCJ5QwgYksOBB+27eIuJsWWcc5ytOpNwaUI9SvgruR/vOolt/iPvshT0M18XloaQAXPVl4m6GGmni+Ehbgi6joZvtuwY8ZRw7YpYOVfVE6q7COA7eIXQb84iXoVgqODClzmjmw4/LYQNJDVyBwAOYn8czdRbb2HD/hx5LhgE5xiC/3xx6z/xiWN5ZuSBf6ZUZRaM11L2Zq0NMFOHQZtV19I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(7416014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5DOogG0UDB+IjZs+aMFFV4KyZyUJN4fvA/GYB28WSd4vtBo82alkWM/tvTml?=
 =?us-ascii?Q?BmgybB/FhGFnc88X7rawI3XKnXy522DO7KGxl5Fxaylm8ZSXE3cdSehi+uB/?=
 =?us-ascii?Q?5oTw1M2NGk4L8z7kEBsUFS8HkTj7PGJ/xUSoFLdzTpsKhiHg3rtk9ZOP/gGD?=
 =?us-ascii?Q?OJbZx4p1s1O96Cip/5Imgx3/JJh0eugx+vMQQfD8ds2Ltw7Nv9tjzrLkw23T?=
 =?us-ascii?Q?gKfhCWw4w9a0T7+rG9BFqjjgG3KocUZg7leYXuPcRwzVFIELuGyR8hk8tNYa?=
 =?us-ascii?Q?p5pi6gE57LaE6fI9mX/5gYoV4F+PCxW+6FZa7SRsMauiRoJZYfONddQO4OcI?=
 =?us-ascii?Q?dpiGDS5jSlnRnj5zYjnggHPvO88RA19ZiI3HlyDJ8NTdRmhxJ4Asw/B8jqSS?=
 =?us-ascii?Q?UHiPOmfSbTV50AhpBkM9hkEcvgqyLaUwXtbN5atkhLWmKYbk+GSc63MNQ6OQ?=
 =?us-ascii?Q?l+yqhjDD+veMiGKHSUAMqU1praGc7JFGV3TtrhmvSjxhVqTyZJwEuwSlC+Hz?=
 =?us-ascii?Q?CvTT2r3stm3jB907U8ZAN0LHYnSHmD7XZLge8xe92DOS1y8DmOzEK56+islw?=
 =?us-ascii?Q?l8bgNc+X9THtVeveUjHd9YuPNwqrwLXyRAQHTSTSiRkGeXBEGoimI5YPcRBu?=
 =?us-ascii?Q?4Njaz7/wInNl+OjfJhT5n7myfUPPlAgUYxDLhsQ4PO98+KwB55C4nlg0Sp0R?=
 =?us-ascii?Q?0z4RiDH4RpKaCIDTrCnoUyBTwX9X4qqZUwvzwgcpSvtWyFO27QykRhSyqz+x?=
 =?us-ascii?Q?dIYDfpYgogdpkRMnjrSRsEYFb0tXHc8ZjFTpvYN5/ct6XQA0Qo2WIr1Lwdvw?=
 =?us-ascii?Q?nOnsYEtCBXguxDSrlNFPuZwNiW/A6a+H4Ae7+YUw7PVe1NOdphGXsqW7atPt?=
 =?us-ascii?Q?LCY1fUUee1H3MTckDohR6XZONPOqxQkggoKAp5JtObKjTsiugv/jynyZyQiw?=
 =?us-ascii?Q?JQtOOWPk36Q9Y/SQNiXUgrDPd7J1GMfxxr+SYs06a2VxPX7I+HxtUt5zorJH?=
 =?us-ascii?Q?ewJ+s6Rjhu6c/zMPnAqxGjU93YCZ7RpyKOD0fuvGgSwNRPCzuhMv1+mc69W0?=
 =?us-ascii?Q?CynDsXJ3wV/KlQD/yNHwwzz9R5TR62282FSpTNhIiLmPHZMjNg+XiwesiUt0?=
 =?us-ascii?Q?ElZADjUrQT1TA+UFhXhXN5g54XD179MQ6OB2kogxrDxQDcOJWshcNsEsuF68?=
 =?us-ascii?Q?kX9famFl3MCCtjvWKsbuWnGtCPG5Txc07Nwiuukaw+VYwGn18OxI9k/77Xcv?=
 =?us-ascii?Q?eX82iW7QCSeKbj9QEHie+bG63nZ9T4o5mqMae7W1EtytCvqR/YujKtNL1dQZ?=
 =?us-ascii?Q?nCKYDRvfUeotMvUGpgeCgtC+SLVO6lB/yNe0voFReQ/SILkR8HW2gld64i8x?=
 =?us-ascii?Q?n8OqONl3++Io6v///ETFSXGO1AKUEJb8D1/F5jsOjRD0ykY8sYOnS2mVq5gQ?=
 =?us-ascii?Q?tK2Mr0jBQdfYQBGpq8BJ6vcoyGg9hDaf1DiU2n0OuHI3TOLlDf9ncldb0v5i?=
 =?us-ascii?Q?RFMpjIwnrEPTcCmJAsNc+2kJsc2g9Bv7ljq9vDoRmid/3ty9c3A7XRLDQH18?=
 =?us-ascii?Q?3AbyxpG0n9LXI6CZGhV7DMloR5IIrwBIY7wESdQOTD99+DPUbtdRqFNTHFLD?=
 =?us-ascii?Q?28HaI8YZKv1fLId/OWvHmZwZDHQktymTZvBPmHfCK6VidLJUQUry7FPSGlP2?=
 =?us-ascii?Q?mYx3Q8OfSBeF66YIl5QhQmiiIV3pebwdIPlx6jb2GcefCGrW5vq/yTLCpQ4s?=
 =?us-ascii?Q?mVkZS3S7/Jgah8cQiZCznRxkfFm9UdQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f7fbe4-31ea-481a-9743-08deeba7c6e1
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:24:56.3421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MP4dm17RQxflbIrcb8yvXjQksNI1xvP9SbWHMgYTR6RoflS6DcA+wnYY2nnxsCe/LOv9rwm5pQnbrxUzsxXQjNrBWyWRaIXUVsTk796/84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5624
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

On Sun, Jul 26, 2026 at 07:28:21PM +0800, flavien.solt97@gmail.com wrote:
> From 42f759d7e7f4eca064638622d52aa38be11b956b Mon Sep 17 00:00:00 2001
> From: Flavien Solt <flavien.solt97@gmail.com>
> Date: Sun, 26 Jul 2026 17:52:03 +0800
> Subject: [PATCH v3 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
> 
> The AIA specification requires an IOMMU to send the configured notice
> MSI after storing an MSI to an MRIF, even when the corresponding
> interrupt-enable bit is clear.
> 
> riscv_iommu_msi_write() currently reads the MRIF interrupt-enable
> doubleword and suppresses the notice MSI when the matching bit is zero.
> This makes notice delivery depend on a bit that AIA requires the IOMMU
> to ignore.
> 
> Remove the enable-word read and send the notice MSI unconditionally
> after updating the MRIF pending bit.
> 
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/riscv-iommu.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index f6865d1..2bbac30 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -788,19 +788,6 @@ static MemTxResult
> riscv_iommu_msi_write(RISCVIOMMUState *s,
>          goto err;
>      }
> 
> -    /* Get MRIF enable bits */
> -    addr = addr + sizeof(intn);
> -    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
> -    if (res != MEMTX_OK) {
> -        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> -        goto err;
> -    }
> -
> -    if (!(intn & data)) {
> -        /* notification disabled, MRIF update completed. */
> -        return MEMTX_OK;
> -    }
> -
>      /* Send notification message */
>      addr = PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
>      n190 = get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
> -- 
> 2.54.0

