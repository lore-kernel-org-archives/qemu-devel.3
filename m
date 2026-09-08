Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B11C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 01:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3l7B-00051Q-Pc; Mon, 07 Sep 2026 21:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x3l79-00051D-NT; Mon, 07 Sep 2026 21:59:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x3l76-0001U6-Bz; Mon, 07 Sep 2026 21:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaVQcMkG2GY6NNE3HBpkylMtWYgYyyULGp3pE80ZnrcGtStKhJHhM+oGxyRCIXbbXc0FvAFL5N2OEkRdVbgMR6iwgjl2BQSd1/Tafrl0u9ghNi4INay1E5t+NJSkhEl72YsuCDpmkbuVxcGFfg9gH5GTMtyXOffa8xNve8QVrBPxpIvJ145We4JROLIZWsngTZrA/GPZ43CmFyTrwW+11tzsBgMpy6RG3IHSsh3sKjbdfQgq99ywXdmOP/4O8S/fEiJMSnZ2vuJDsD64PEBfCyV30CXeekNCyQoI4B+DQZYPnhZTxl9LEPh6Bth9zHzZVW9m1pxGj+c1gZdoUEzg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdxM1lr7mYX3c37NEnKc4rlYHVoZQboiV4aVN9qG1tg=;
 b=qlV0zUB+kQV2VV2h0wvTB7sqDnb5l2Dix47ZjkQy+zm7YBjd6MbwLFIr301uZZvGZMZby09gXfvr2BOfLU1dVCWFCcX0HkVz5DuqJI/1rQn7tJF5recRHDvOjM55bZIQfgJ93wHaJ26nkZVIHLPYqmjbdR3VrJit7hX0jqnOnp8PLMoz1g8yiFdPJi6q/TkRu2bupqNfyBgUb4wpU2/XAYK47lvQwm1TjD+wEOe9I1/QoJeBVKX4tPZly8CKnGNB5QlOVwtD+MVPQv/y7fVHl0szuimTfZOSIBKk+ValKhp5qjbNfEKqKeikNNWz0oDvnSFTcaca5nvku3xrL+jl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdxM1lr7mYX3c37NEnKc4rlYHVoZQboiV4aVN9qG1tg=;
 b=RBncmKJyGDidZRVxvs1V5RkYOFuNO0DqCx0O3SOu1w8ANGQNfwt/mGykT5UiS5uLJ2xSRpY6ojlS+CVJRgQJtje9X4DbTZzNwJtRXZEx3UpRRrwbo/sYJfAMXNSUjSSS+UuXJmC3jktp8XxibOnn8SVQjZ3Fh4nhrOn/FFky9AQ/MMu25t6q3gEk5AyHp549PrueCet/UcYx2GuZEZ/IxPuPCPu6MWJdO79MSoW32NnM82GyV6rRxWE+HEU8vqSRGsk3dMnLrk46tUppeHdcGQEssV8nQD8owaKlK63BrgOaRQGAHM7gqsj9kLJwQOvvhPwEi5dG2Pdmxfqeh9LTmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by OSNPR02MB9009.apcprd02.prod.outlook.com (2603:1096:604:45d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 01:58:59 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 01:58:59 +0000
Date: Tue, 8 Sep 2026 09:58:53 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Mingliang Liu <liumingliang.dev@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, Zhibo Hong <hongzhibo@bytedance.com>, 
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 1/3] target/riscv: Add support for the Zvabd extension
Message-ID: <ap9rzl3m0zfhc_5p@MacBook-Pro-4.local>
References: <20260907152301.1701394-1-liumingliang.dev@bytedance.com>
 <20260907152301.1701394-2-liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907152301.1701394-2-liumingliang.dev@bytedance.com>
X-ClientProxiedBy: PH7P220CA0177.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::25) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|OSNPR02MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0641dc-6837-4249-b3a3-08df0d4cbfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r8VD0FBQpS/nzjNZi5AhRkt0dO9PirEmQ9gYcppA7L1GduGHKnPzGyi2Sc6BqfWX/cn7JWPqEVY2bKGEwu4zlSvfW9A2lkMVBzJRsCg034BwdkwpUKIdArRrKtwWRtkPPXJrK977YaNUJxD2zrHSFHLndHc2I997jW7aGPSIMKz7ty+dj24USl/6AGWuPj3rkg9nuh03N2Pt0zfFm7X1BO8JWTeG9JkoEzLQkzS6mKFbvkHhBcLDfPUS37yNfFDzljqWEi3PSGx8aSSYjGmu3ZbSrRAz6V3T9z2LcbaoooIatyaJ+3rnjwrc45F49WYPzPATDabEncyIPtVLx+WGEKmyRHr1V1HmfjONMewEbI60jhdVoEur0Vi/zo3Yn7/kUL7omv/xKgPNvV3bjKIe4Z8HfkYU1ydLj/4cYFYgZMXTG3z5fMjooGKsvK69wzPtWC9WTQ6kayLKk8MwvgVZMCxyRMAIKO0PMJpWiNMl2FlVyy2+nu7VaGwcC5EbBO/gbXmerU2ueNtr8sE1vzpxSy0g3il6F1okydpx9d2LDWk/yArcqSvCscIvHq5glDehbgN57s7lUU2kExJ9tmJarXdYWOPIeHAd1ONTY5BgEtfbq/Hu6NvR1ZBGUKrIv3Fsw/m/+nbZCQ3uoDsCiWzNr6n7GcaEsKVVn2iPVzm9r3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkdIREYklIZ3seyFQhQAPpCe1dp+oNeRRNcsXs8GzZG7vxG1+4xlOK6Zh566?=
 =?us-ascii?Q?f7HX5PTsbU+yTE+jN3nhdE90DIJW49TfvYjnU6t2uqcJAduqTh9KKUl/G/Vl?=
 =?us-ascii?Q?Jsp5Wl7QrC9xupBKV7UALZqsSDcAi86AkNhK7KR5XQ2xyjY5yDUkI3lm70+V?=
 =?us-ascii?Q?MVyhqclEVFKciuICQ3mDwZsNt4qXvcx/EFT9MqueyLYSEKo5VA+9bJ6A/hmT?=
 =?us-ascii?Q?aWSigCp5Xz9z/VOhMKr7GrsAEU0Dsyzk09TQeDgSJ8ZICrNxiblDLnpKqPBg?=
 =?us-ascii?Q?rotcMzYAbnkuRCn9EVZPvqJSDDbqmWlGj1vN7TvLLvljSgusnTutOwpIa2rL?=
 =?us-ascii?Q?tgt5znpYvCratoQbTfPWBI99gQjDZ07xinTRGQxEuT8rOESY00lGyFsKHCuC?=
 =?us-ascii?Q?G7cKWO+j2wMKY1aH+RhhilIItScWaG2qBjruCN9uAtnJ2aHP1oLd5/R0Hfty?=
 =?us-ascii?Q?q9iBPDZbRb3REUWRb5zv+iNxI2lvZrKwMi2paOP4e8CJxDWfkkjvfiWbOlQJ?=
 =?us-ascii?Q?jA+Y7C7JIJYzvMuA964saewMufJN9pse/NAPu9spn9gkEjvfRkxAf93RkUDT?=
 =?us-ascii?Q?KwXL8fHAiqhXLafQQ7DL3jusNOKV0lL+K9qsqmIqzmHmq20scN2HnCbtlpNc?=
 =?us-ascii?Q?jssJ/MRulKD4O3CGQUiv8DW6vwcbfVvA16sKFewjILDRv//s8xxzeqrg37rt?=
 =?us-ascii?Q?a2G2GKZ9L1erSyXgKodiPJHgfwdFOsvAelnZziogVpaWHfYgk/283ElBZcHF?=
 =?us-ascii?Q?0tHrc5NLf3jhnJ4QIH/Ry/WcXdgXpCXj8HZijv/5q+65FPi9WhHRPlQbk2e0?=
 =?us-ascii?Q?gWKtGs27cJzs9o3nguD+UUo8GqeY/8csk9/JCVKXC8afrsy77vY4mqvwtP9o?=
 =?us-ascii?Q?88wyNn/ZIUEkdXuHfUwxvgZCLtOAVva5xB459607muz00ykJsPUgbR4s90t5?=
 =?us-ascii?Q?8+gDbh/Z74Iyaq+9wDAlvl+y+7cRkPZRzonKO3zhXevnwnqoyK7KEqge9d4Z?=
 =?us-ascii?Q?M5sqNBEkhXYXPDRMPvGnDCM3vt6jN+JOBKs/Q73XrZlzFTBT1G2t5ZjWOUaB?=
 =?us-ascii?Q?Wwg+7gyok96oua6ulREEytjJdXhOoFkOA76uM9pq4W9YM9p2lEIfrdypfjfz?=
 =?us-ascii?Q?teb/6Wuslf5rQ5EYf86e2JZi1Cx6o7M27F5XPIAqtGKKOCebM8TnWpRmBkEl?=
 =?us-ascii?Q?Fu2yYdS4COS2yQFpyfVCdYvnZmmFKx2qrZkzs1lQ3Xcx7e6clEnlHa7g7UtC?=
 =?us-ascii?Q?lsatE4NkwLw4h7DkooGii5mj9Y9YmFvDZs05ipHpfXoYjJSwWQ35/IzhvL2Y?=
 =?us-ascii?Q?2VXX8egSLCo1i7zRHMHbOhyABwPr02lIhywC6LCbd/BKZunmXz5yA16X4c6O?=
 =?us-ascii?Q?8CDwrbnAgCNzg/mPOp5GCd1zcB3qd1wyjoXuwStjJjlyEwwGBBslzMdi2Nz3?=
 =?us-ascii?Q?NTo4lvSZoMvhmAGIfeEwNjan9osXm3W2dMr4IDBbv7WyPezFSzfmSVgoHwyX?=
 =?us-ascii?Q?ivhwqsBKsH/u5rXFpoWGR9o3bx3pymQGav4xttASBMLCBezET3PC+a2GnnI4?=
 =?us-ascii?Q?doydEgaXMTkdE41k1AvrNQlinfHjWM1qt6yZP59+AyLqStlGGeCzu9FV3H9o?=
 =?us-ascii?Q?mtaXAZ25dVTbJhX/cqlQ1tk/uRYEEKWFasGpFgkD48d6eTLPlGp5zMmKnzMV?=
 =?us-ascii?Q?jLG0uHjUHv7YP7gMBU4ms/HWchbzk681tMs6KUD5iOYaLDHtaMxqAspf55kR?=
 =?us-ascii?Q?Ah45bUWtshHLXwIjwBWLma/hPGZgbg4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0641dc-6837-4249-b3a3-08df0d4cbfb9
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 01:58:59.7185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjC92nCM2M2tlbsD57rJ4ekjK3qjjTXm2ZG+wGK2rPPSkoJXLA/a4YSBczYvZx6dIQLsk3gCAN/B4B5qq4f51YZ9L+/4d79MBmitmtd38L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB9009
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

On Mon, Sep 07, 2026 at 11:22:59PM +0800, Mingliang Liu wrote:
> From: Zhibo Hong <hongzhibo@bytedance.com>
> 
> The draft Zvabd extension version 0.9 provides vector integer
> absolute-difference operations for image, video, and other
> data-processing workloads. It introduces eight new instructions:
> 
>   - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
>     8 through ELEN, with SEW 64 requiring Zve64x.
>   - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
>     and 16 and accumulate into a double-width destination.
> 
> This patch implements the extension, including instruction decoding,
> TCG translation, and helper functions. This implementation targets
> version 0.9, whose instruction encodings differ from version 0.7.
> 
> The specification is under review at:
> https://github.com/riscv/riscv-isa-manual/pull/3279
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Zhibo Hong <hongzhibo@bytedance.com>
> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  disas/riscv-op.c.inc                        |  8 +++
>  disas/riscv.c                               |  8 +++
>  target/riscv/cpu.c                          |  1 +
>  target/riscv/cpu_cfg_fields.h.inc           |  1 +
>  target/riscv/helper.h                       | 26 ++++++++++
>  target/riscv/insn32.decode                  | 10 ++++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 45 +++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                  |  6 +++
>  target/riscv/tcg/vector_helper.c            | 56 +++++++++++++++++++++
>  9 files changed, 161 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 1d334e4857..07b56f5d52 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -490,6 +490,10 @@ OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
>  OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
>  OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> @@ -861,6 +865,10 @@ OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>  OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>  OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>  OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vwabda_vv, "vwabda.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwabda_vx, "vwabda.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwabdau_vv, "vwabdau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwabdau_vx, "vwabdau.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index b8099cbdf8..410ec1e565 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2022,6 +2022,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 48: return &op_vwredsumu_vs;
>                  case 49: return &op_vwredsum_vs;
>                  case 53: return &op_vwsll_vv;
> +                case 61: return &op_vwabda_vv;
> +                case 62: return &op_vwabdau_vv;
>                  }
>                  break;
>              case 1:
> @@ -2164,6 +2166,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                          break;
>                      }
>                      break;
> +                case 21: return &op_vabd_vv;
> +                case 22: return &op_vabdu_vv;
>                  case 23:
>                      if ((inst >> 25) & 1) {
>                          return &op_vcompress_vm;
> @@ -2349,6 +2353,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 46: return &op_vnclipu_wx;
>                  case 47: return &op_vnclip_wx;
>                  case 53: return &op_vwsll_vx;
> +                case 61: return &op_vwabda_vx;
> +                case 62: return &op_vwabdau_vx;
>                  }
>                  break;
>              case 5:
> @@ -2425,6 +2431,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                          }
>                      }
>                      break;
> +                case 21: return &op_vabd_vx;
> +                case 22: return &op_vabdu_vx;
>                  case 32: return &op_vdivu_vx;
>                  case 33: return &op_vdiv_vx;
>                  case 34: return &op_vremu_vx;
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a13177b7b7..4b8944b051 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -220,6 +220,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
>      ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
>      ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvabd, PRIV_VERSION_1_13_0, ext_zvabd),
>      ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>      ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>      ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index f8c27a574f..6018e58195 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -83,6 +83,7 @@ BOOL_FIELD(ext_zve32x)
>  BOOL_FIELD(ext_zve64f)
>  BOOL_FIELD(ext_zve64d)
>  BOOL_FIELD(ext_zve64x)
> +BOOL_FIELD(ext_zvabd)
>  BOOL_FIELD(ext_zvbb)
>  BOOL_FIELD(ext_zvbc)
>  BOOL_FIELD(ext_zvkb)
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 4fc2d3a155..3aef6e0e3e 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1350,6 +1350,32 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
>  DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
>  DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>  
> +/* Zvabd Extension */
> +DEF_HELPER_6(vabd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +
>  /* CFI (zicfiss) helpers */
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(ssamoswap_disabled, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 21272fdb50..1c991a6f42 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1084,3 +1084,13 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
>  sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
>  sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
>  sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> +
> +# *** Zvabd Extension ***
> +vabd_vv       010101 . ..... ..... 010 ..... 1010111 @r_vm
> +vabd_vx       010101 . ..... ..... 110 ..... 1010111 @r_vm
> +vabdu_vv      010110 . ..... ..... 010 ..... 1010111 @r_vm
> +vabdu_vx      010110 . ..... ..... 110 ..... 1010111 @r_vm
> +vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
> +vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
> +vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
> +vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index a22e2cae6c..14ef961607 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4091,3 +4091,48 @@ GEN_INT_EXT_TRANS(vzext_vf8, 3, 2)
>  GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)
>  GEN_INT_EXT_TRANS(vsext_vf4, 2, 4)
>  GEN_INT_EXT_TRANS(vsext_vf8, 3, 5)
> +
> +/* Zvabd Extension */
> +#define GEN_ABD_CHECK(NAME, CHECK_FN, MAX_SEW)                       \
> +static bool NAME(DisasContext *s, arg_rmrr *a)                       \
> +{                                                                    \
> +    return CHECK_FN(s, a) && s->cfg_ptr->ext_zvabd &&                \
> +           s->sew <= MAX_SEW &&                                      \
> +           (s->sew != MO_64 || s->cfg_ptr->ext_zve64x);              \
> +}
> +GEN_ABD_CHECK(vabd_vv_check, opivv_check, MO_64)
> +GEN_ABD_CHECK(vabd_vx_check, opivx_check, MO_64)
> +GEN_ABD_CHECK(vwabd_vv_check, opivv_overwrite_widen_check, MO_16)
> +GEN_ABD_CHECK(vwabd_vx_check, opivx_overwrite_widen_check, MO_16)
> +
> +GEN_OPIVV_TRANS(vabd_vv, vabd_vv_check)
> +GEN_OPIVX_TRANS(vabd_vx, vabd_vx_check)
> +GEN_OPIVV_TRANS(vabdu_vv, vabd_vv_check)
> +GEN_OPIVX_TRANS(vabdu_vx, vabd_vx_check)
> +
> +#define GEN_ABD_OPIVV_WIDEN_TRANS(NAME, CHECK)                          \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    static gen_helper_gvec_4_ptr * const fns[2] = {                     \
> +        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
> +    };                                                                  \
> +    return s->sew <= MO_16 && do_opivv_widen(s, a, fns[s->sew], CHECK); \
> +}
> +
> +#define GEN_ABD_OPIVX_WIDEN_TRANS(NAME, CHECK)                          \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    if (CHECK(s, a)) {                                                  \
> +        static gen_helper_opivx * const fns[2] = {                      \
> +            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
> +        };                                                              \
> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm,                \
> +                           fns[s->sew], s);                             \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 9e3cc87f8a..4c2fb6f063 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -732,6 +732,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if ((cpu->cfg.ext_zvabd) && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp,
> +                   "Zvabd extensions require V or Zve* extensions");
> +        return;
> +    }
> +
>      if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
>          if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicntr))) {
>              error_setg(errp, "zicntr requires zicsr");
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index e28d8a3d9f..bdb1efcebc 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -5906,3 +5906,59 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
>  GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
>  GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
>  GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
> +
> +/* Zvabd Extension */
> +#define DO_ABD(N, M)  (N > M ? N - M : M - N)
> +#define DO_ABDACC(N, M, D) (DO_ABD(N, M) + D)
> +
> +RVVCALL(OPIVV2, vabd_vv_b, OP_SSS_B, H1, H1, H1, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_h, OP_SSS_H, H2, H2, H2, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_w, OP_SSS_W, H4, H4, H4, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_d, OP_SSS_D, H8, H8, H8, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_b, OP_SSS_B, H1, H1, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_h, OP_SSS_H, H2, H2, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_w, OP_SSS_W, H4, H4, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_d, OP_SSS_D, H8, H8, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_b, OP_UUU_B, H1, H1, H1, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_h, OP_UUU_H, H2, H2, H2, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_w, OP_UUU_W, H4, H4, H4, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_d, OP_UUU_D, H8, H8, H8, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_b, OP_UUU_B, H1, H1, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_h, OP_UUU_H, H2, H2, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_w, OP_UUU_W, H4, H4, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_d, OP_UUU_D, H8, H8, DO_ABD)
> +
> +RVVCALL(OPIVV3, vwabda_vv_b, WOP_SSS_B, H2, H1, H1, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabda_vv_h, WOP_SSS_H, H4, H2, H2, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabda_vx_b, WOP_SSS_B, H2, H1, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabda_vx_h, WOP_SSS_H, H4, H2, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabdau_vv_b, WOP_UUU_B, H2, H1, H1, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabdau_vv_h, WOP_UUU_H, H4, H2, H2, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabdau_vx_b, WOP_UUU_B, H2, H1, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabdau_vx_h, WOP_UUU_H, H4, H2, DO_ABDACC)
> +
> +GEN_VEXT_VV(vabd_vv_b, 1)
> +GEN_VEXT_VV(vabd_vv_h, 2)
> +GEN_VEXT_VV(vabd_vv_w, 4)
> +GEN_VEXT_VV(vabd_vv_d, 8)
> +GEN_VEXT_VX(vabd_vx_b, 1)
> +GEN_VEXT_VX(vabd_vx_h, 2)
> +GEN_VEXT_VX(vabd_vx_w, 4)
> +GEN_VEXT_VX(vabd_vx_d, 8)
> +GEN_VEXT_VV(vabdu_vv_b, 1)
> +GEN_VEXT_VV(vabdu_vv_h, 2)
> +GEN_VEXT_VV(vabdu_vv_w, 4)
> +GEN_VEXT_VV(vabdu_vv_d, 8)
> +GEN_VEXT_VX(vabdu_vx_b, 1)
> +GEN_VEXT_VX(vabdu_vx_h, 2)
> +GEN_VEXT_VX(vabdu_vx_w, 4)
> +GEN_VEXT_VX(vabdu_vx_d, 8)
> +
> +GEN_VEXT_VV(vwabda_vv_b, 2)
> +GEN_VEXT_VV(vwabda_vv_h, 4)
> +GEN_VEXT_VX(vwabda_vx_b, 2)
> +GEN_VEXT_VX(vwabda_vx_h, 4)
> +GEN_VEXT_VV(vwabdau_vv_b, 2)
> +GEN_VEXT_VV(vwabdau_vv_h, 4)
> +GEN_VEXT_VX(vwabdau_vx_b, 2)
> +GEN_VEXT_VX(vwabdau_vx_h, 4)
> -- 
> 2.39.5

