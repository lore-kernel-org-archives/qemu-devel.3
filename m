Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA48FC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAnZp-0007kq-9U; Sun, 27 Sep 2026 08:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnZ3-0007em-8V; Sun, 27 Sep 2026 08:01:05 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnZ0-0008S1-GW; Sun, 27 Sep 2026 08:01:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y26Jkx9CnexzwHz/iWZKXOuVuCTbNQJ5nD0fsg9dVPjMMVcMhaFAkyPQRhXJiAqbgRyMKIEolX+peRbPA1YRcVrE6o8gMFtQJ0Cafcl6m3UyWyKVMdgu9nWzmdb6Rrandq+ltqK55lyGCzbrywDHmS1WD+t+CCQsOMvjVpXA5/h6wOzIyCUuvlXI5CcTyH8mz+yVi4a//Wo72Bg+VGETrhaTmIrtIWYwrZMU0pJ7uLiznfq1uUtKRO9A0LYQu6UpUQFrcrTthTmQ3TdHaFtQupYcfpTPs2539Ihvkv6CmyExM1eUqHWrLiBN5YZHxp2hoDCLVrEjVb8yxmnlzeXX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mgvFbtriFOgzORWsCe5pU0rquhAKqOD5kwFjgUi88s=;
 b=PmaF+2fbVdgfjzmTfSkSr2V5LvE7u3xX1U9eEcb1Payg2rJA8j/l6bKQQNWNUQjp9zBYu0ZUIXdnjuuKH5k8qiuNFbvNypLAd0WuTaxKLdHsH4CqhV+B3pD+9VjYycJ2nmgFBUg0ut9f+OfF4UN+rGFf8Kd2Bk7XqJzGUyOTd0vHfNU2HTAIcvw6HFDuTa2DDDKhYhAfxfw+9rlAUBCMrbBYHywLYmPvBEv9Ycqq1J+bq0rteOj/WRzezjBnH6LKHdlDbqMA1Vnr4fbatD8SX8CNPJeyWwEBmxE9fMhQw6AGaiLAk5562r/yOazKyG9p4gBaa+G2FwmjmLQYpCdVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mgvFbtriFOgzORWsCe5pU0rquhAKqOD5kwFjgUi88s=;
 b=eDGv3F3g+dvqodc6LhY1S8lgy7YXWK+n5tG2IKim8UTWDWBUMaDfx/B4j1SV1XJkyevU5Ul6NFTfN+mdhJsFdq2FFxTLX80VkwkHyr0IU66RbuZGYlM7WNW1dL+qcJPnUIgQ+EUvL4Dp6ZOx60lVFAORd7+EopsJi6gqHAO8TqRZDh+xI/UuB7WM+1fUxj/tuiJjvU+XRHO/zAa3G0cwV8wvBhrrZ7LTOis43N08c4sY/rJcL8NDknaVDROzIuMW5xB4ieKkBlDudep9569bbw1ZKqqMtFdmbpQIrchU53ENIzRt3vGeuJZORg3zsviaLgAAiLr0m5KAxDrn5D3rPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KL1PR02MB7331.apcprd02.prod.outlook.com (2603:1096:820:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 12:00:56 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 12:00:56 +0000
Date: Sun, 27 Sep 2026 20:00:50 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH v4 3/6] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Message-ID: <arkFNUnv2UrkTN-k@MacBook-Pro-4.local>
References: <20260927082534.3228237-1-max.chou@sifive.com>
 <20260927082534.3228237-4-max.chou@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927082534.3228237-4-max.chou@sifive.com>
X-ClientProxiedBy: PH7P220CA0054.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::11) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KL1PR02MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dc1ec8-63b5-4f63-78d3-08df1c8efcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: ez65/6o9MCNeLofd+8d1IoJ7imX11KDJuM+tJjrnPBKl0WjGxhINL+6KSqn7PiC6KD7LLiVWU6HNFoI3TJoDLiya4crGMLgLitAN2L0nFKtj0+NG6Up7cR0KKAYx9u0l92WVsxKEgeUrePzOdpjfg5chRFd9FfFgliFuGNx31gAVWh/6lRrd03TMs/dMGuYULPfKpfCu0ftxa8jyrAFBBtMniWUuPiFjDRLiZGq3NrUikFX986opZZKPHBelYtdJHwZ8660sFFEFVUoeldTzObphoTTtjKz9xMVYOcYmGu3QXKCExe2JZW2UXMFm9gLM+0jg1KDzUxtGVZ+JVk4Unoh4Jct6EgjFC2oIPAoTRcTscmo3rAI+nEXQSTFHXhSX1FCGG8l+JjMYgbAAC/G5dMTfrsNoFcCS0bSH8gCJQ8l1Pl61ssk8wmohnhSyt6wYhydymb9W9r1bJ7Z6SJkM1aUznjjIwFmg2OrSSQClbQFKCU4DfRKwxlcVd+xkNG0wvI7xsOrPUljtPX12TovQ67Nig6/DafJpADbdMFf0Enjm22tu2MZhG8HN3Obgewvlb3bdlQTORq7qGnOxr/RXFwuuZDnwGPNrO8PzpXKM4AW3lA1qKqUELA8LaMsKPvma4NmXJJ/QcLLwUZ4+9qZD/f2BWj49mES7iUT7rB71zR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FiDjNSATTXuZwqYWLtx6GwDkfWfh2dAW/lqWrtXA1NWufAJJZPSgEPbIyLmZ?=
 =?us-ascii?Q?z2P8EJod7Idx7pg+YKUEVc6OBSn2Nv6WEiBR5u+CFTB5fGX7bW2lUV3PF7zw?=
 =?us-ascii?Q?kZubDpN8CYzRVhsmf37sjuElffm6zY7hixldN8XdSxOTjJIKWfvVT82thdMV?=
 =?us-ascii?Q?i+2ZNwsdq5FMExX/VPoTTS5DfBI9Sy/O+oPQIEAIXohXIeg1Y/lNoygH3F0B?=
 =?us-ascii?Q?gwQRiSiaTHOQNNBvsRPY3Eds8Drc/rmi4yAOYmpBe5RYNL3x4MLUd5vDjcEL?=
 =?us-ascii?Q?SfXR1CNIM64Yd+WcuukW0D0GPKpOjyC3XJKugXwdl3XdB0FIp4zjjqh7GBjO?=
 =?us-ascii?Q?VV26I/sBLYzgj5Trh2p9UoTrf7OvuAXGtWq/ez91Eokt+pIkwcM20cmvhLZS?=
 =?us-ascii?Q?HMpYo29duOK+2NL1+qYCQKrx9qQR+0pGu+cD0rbkIeO+8ifxxzt+8yOJA/Dy?=
 =?us-ascii?Q?uBmOJ6m/hSD55PEem030AhTMgHdGwHd39F+F7Q5vz8qmia1vfD0sfrGP5tg4?=
 =?us-ascii?Q?bqrtTsY9mtSs7sZZgdtasroOrBjHC53iwtiM26SxiG8ToH8C8EWUVTXq3NXr?=
 =?us-ascii?Q?uYPy4gmw42C4BGYXKQpLg8jh68W9vm/JLQ7ZjUX5SQwojDRjYJYpa1K/EZlg?=
 =?us-ascii?Q?8xTwAhgEHQQWHNvWkWno3+HDoWgFlTDTv18cl4GG2P6BlBP12cdTdBWbZT1+?=
 =?us-ascii?Q?xrrrObgfZxBACzwcu5Bo2tdWmGpD4oMs9CCTdS3XCCRV9fOc1MdmCEZI5Kzh?=
 =?us-ascii?Q?E8xfpVDCUH9bGodYk4rCFvGpbZsc3rlyz1mgphUmNJQU6JkuQm3jOXZVQQpE?=
 =?us-ascii?Q?FKgaX6q4XleFHiOikuKNjt066lX0ILkQVYR3jqlrJtHoz8PTBY/SEqmYnMc3?=
 =?us-ascii?Q?FPIJMpGSBiV8R1Vcl8xFLhMNr1L+4qBHqgU5h+ZMqadhQGRTGF3wFGBlvGJt?=
 =?us-ascii?Q?7OnQ1kSYNL7BqrJHDdtVwT+zfjtNR4cwXhTDSgm7nuOS4FbGJVG+b0JWl/Zi?=
 =?us-ascii?Q?WKA56b3/8NA+RVOioADT0MqYXa+Xx6n67mGM27jKTXr8b7njLp2BFxelLCgN?=
 =?us-ascii?Q?zb5a76cX2OJjWt//XSjeW7FE0QleA1lIcM9/Yqsg6SDjZ6H5o8n2vAvevVpF?=
 =?us-ascii?Q?LAhU1pscG3QFxOBZYzp//ZLeGeqH5YOvMgDCZpVVNHeRBPtHkoaIkugH0Wyb?=
 =?us-ascii?Q?sWnMK4fMkS6e3RwM/GKWO0xYLJS9wmxDVrPupkeZN/zeWxY5I+78qoEKArur?=
 =?us-ascii?Q?ATtKd6gIGtCKDVVRFkF8Ak2TGHyJN/fSw6ja/2SLY5URamlZiId4WTxH6VSQ?=
 =?us-ascii?Q?qZRi8UOk/0DKHr4+rKCnQ21ZC1dp9ACkIQQ/C0rqJ2pjBiEE1H1oNpYU0OQ/?=
 =?us-ascii?Q?nGrJrTHFVnxkl9rDjfA+RCeTjjrLdKnIcW1PzasdbLZXP7ujm1f3ql42PLrN?=
 =?us-ascii?Q?SQ5Jjrwguww54iOKqgDtkuTmwKyob4gapivzDoq2KlOBa18aBKzynlGAB8QC?=
 =?us-ascii?Q?Jke34+l6e1FoBlEWRv+SDu7nOf4e6jYm/wzz/C5+WzXybJ3pvBj9tT01zP/J?=
 =?us-ascii?Q?gnGcNEw5T7pkoYQn6xm7GhH58k6NCsPvCKzqN4borIkid4qpcUBmIyRvuURD?=
 =?us-ascii?Q?/mg0DE7X73p5toeJ42o63NSSJIdXGaNhrZ5ZfkUKnr3S5cYzoWz6SiHK9Htk?=
 =?us-ascii?Q?nESb3YVv3wohLtqBrolfsbaZ+s4oHWtDUBHpvrDkOuYuV3ikq7q81qKs5joO?=
 =?us-ascii?Q?UNmvkbodwJcBdTljLtwQQISwr4SPeP4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dc1ec8-63b5-4f63-78d3-08df1c8efcdd
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 12:00:56.5464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qarRFBYYuG64H9N3J+czXa/bQoPR70+O9Q6iPkgb2oGmNIrhbxUwwEM2wj5Gaxo/HoaevPw0Sb37yhCGvXPlT+lZlOilJfsu8JCmjvcBZ4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7331
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

On Sun, Sep 27, 2026 at 04:25:31PM +0800, Max Chou wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add SiFive custom int8 matmul extension implied rules to enable the
> implied extensions of SiFive custom int8 matmul extension recursively.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 90fa1d714c7..714697c66cf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2906,6 +2906,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
> @@ -2957,6 +2975,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &SMCTR_IMPLIED,
>      &SSCTR_IMPLIED,
>      &SSSTATEEN_IMPLIED,
> +    &XSFVQMACCDOD_IMPLIED,
> +    &XSFVQMACCQOQ_IMPLIED,
>      NULL
>  };
>  
> -- 
> 2.43.0
> 

