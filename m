Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2F8C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 04:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4t71-0001C1-T9; Fri, 11 Sep 2026 00:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4t6z-0001Bf-Kf; Fri, 11 Sep 2026 00:43:41 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4t6x-0004iQ-28; Fri, 11 Sep 2026 00:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPc7/suNqitRjQ2VFJ11HCkHtzHe6r9ec5Sp9oAtprD+GBNQZI8lPape3pEAU+SFsD8AGEX/0amZnF8fobGQXaE3RZKRtaJA9CgIHljn3cdzk33VbeVHiDA6ZJkM98USB1yyaRgBRKqZDux4J0wsuGsFqi15H1Zed8M9u+BkLqSSj9GHXeXA600BOAS4IF6Hxz2xLnffWHnZNZ0sMgjOqZtFvLMTqPlPTPaYGL41tLKY6ytsZxyyZNTQTsrVOaCknxz+C3HFqlJTiRw45OyzaurXzyonjnuGilFzQh9NpW74MeUV+3a1ynHwE4Y5XFekgPfOdyzc+8IeV8Hw8h2G2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBt18XPy3OFsKtpRtmp3ecu5gIkf8XmYGfhNpYyLY90=;
 b=n27LpaWgHbDqDZQYlA9xPswztmgKlARXCaQAXn4JWzQQ4ZwYBpHK/afDYAlLpUY66Fgj3TQI7zn6HzoVIu2YSw2UZIBkGth5VA0GhG4NqEBOqVV3lYawyOVvK3Jp2peYN1wemF6IaQbiEci1+kPQHQls7FqRbWaHxfnXdJEz00RvMkCfxMtpHaaePM3JS14CLWDe3hI4bd6kU4EEUc8G3DSD/1Jjf4Lq2PMGiJOpddvAgKc6aFhyQUrfaCQwFSazHJgws5BFiaJy9b5jArSSBuy0weoEnmQ/RqrExj+WKl+gnAX9UDSyXAuY53B05moQ43+JwiNEchmLuzJKP86AkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBt18XPy3OFsKtpRtmp3ecu5gIkf8XmYGfhNpYyLY90=;
 b=GpHzcyTKKzZf3f9Zpclz55hlkNz4KSUVL6Tks9Q46F4w0Wsf6JIPA+xvkfSmfZFK46IQUo8JWDoWVdQO7bRtRnWsqE64Pb2wXEXXZzRAd/Tm1b3DlY7olZALLS1Z+j6rDX/ideRKuSCrCxubl9kqfezC+AG2fvlM/50gHgtxIFcWvE9bcEgGbMRMemNcedkuSJ/Ne4tALbCpo259URp3HWJcpzqA1qF3p29KUnHaJoLV6co7zCeKeanhdM5YlQwb6Frest9DPYO71nF3rlajK1uOYMdK25EeZ7Oj7WKvsuQ4kCWm/zOz+bQ1vWPB7D3Ky26d0EcMj8X/5ljZjKTrxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6848.apcprd02.prod.outlook.com (2603:1096:820:115::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 04:43:32 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 04:43:31 +0000
Date: Fri, 11 Sep 2026 12:43:26 +0800
From: Chao Liu <chao.liu@processmission.com>
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/14] target/riscv: Preserve minstretcfgh on RV32
 minstretcfg writes
Message-ID: <aqOG5sePFTXOswKg@MacBook-Pro-4.local>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-5-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-riscv-pmu-correctness-v2-5-5da5159a0c64@linux.alibaba.com>
X-ClientProxiedBy: PH3PEPF000040A7.namprd05.prod.outlook.com
 (2603:10b6:518:1::49) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f1c1f8-cdc0-40c9-2cbd-08df0fbf3b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9kbHIAAPSNyX5WNlDQOU3GlfICSRX+YwP8rf6T1gj9Em90VN1+a5V1GhN8KtaX/DJ7nM8zMwY7AxNe0GporTAyfFyNJXOZOPzD7RPTSRAdjwztr4kn5QdOXOUJ2Ul4ZYybCeJZpjad/BldjHcD1t9fxwJaTtGop09GzIt6GYjnDARXs9FWiP3WEzM2Kl5dozKWYMA/GewGxQ9kWrnItQqcfYDMtDrcUTADN0VG9DQHyrNPsiGQNuZCNJKU+wNlUdM9tfJZVFZrAZwlNm6YYg4zd+zdo3D7mkapfXRbca6RrNimkDx51N0ze6dsv45Wvxj0RDdN8/wYvsRTTKh/56CbELLQHTaEtdteTq5RnioHeUkiEUfXrn5fHk7vvFoyxP51rHdI1kzf4c6vFKQ6aaZ42u1IeM16X6C7a7WW6MSAkTNB9Oj3pZJafVvB+EHbGP2qeMb+rgyLzLALWiITMchcMXM/+TCHEZc1n3OsQWaUUw4dzHeYeJfjuFGNOFIXiyoYSoTky9Jc6cfEBZg5U9sAheazfqCsaaqSDfurZhVJZzEX2K1X11oGcNCqAkdS6pE35pgOm0+AEgCfZqiD4KPyzOCqPXZWjHchzzPLfU6zDI7ht6Ko+jJ/iNJxGB3jsV7kUVrh4oxhybKG9cQ6zGAqMcl4dmsFs0k3mYmm6HFaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Flyw/TFFKpjYZCKWzOuo9DGOQZKkCgctTrrvS3COPY5awJsYOE/Bzo2ObTlW?=
 =?us-ascii?Q?zUyeoAoHnnCf/90N5fENh66u1Ef/WfPFYm2tU99YJox8YJB51dyUjQ7GtVwg?=
 =?us-ascii?Q?RTX81iovTS+hMMU9v9wVmC+SimpTDwzh4PeUWJNuS1Lh21I8FPpo27L3dMiF?=
 =?us-ascii?Q?3ZcwRM61rBwyUi6nPXVSubJBdfHDKGOQG2a1CFFG2yjGeYQjy8QHuMznclKi?=
 =?us-ascii?Q?7Bx4rxL/dbyUIrpzRNQUX0K43QudFut2qPkMi/ObO5CyR2nQD3nShMf3r4dV?=
 =?us-ascii?Q?s/VP98tS741sepZq/3Vr/HKi/v1TmLRYNbBiRQ5dsH9AjFS0dJfze87wqbli?=
 =?us-ascii?Q?4cZsZRuR+XenzkP6DpeqqlwFhYwrlb+dkdolSGOV/wUZDowkIIhisr+t/CQb?=
 =?us-ascii?Q?8Ylz5Aq/nLrzsdhgULPS1sGnEaLEVHl8pziteKrGyP1bF3snapojOr0xrkmg?=
 =?us-ascii?Q?Yu3KSNEcCWo1gz69eFY/N3qyy8kR9Sknco345pEktTtso8nXQQPKl4Zz64bP?=
 =?us-ascii?Q?gOaMrE9mAvREBMKaUWHequGvcN4EQ9xu/iHE/eaa96lQQ4dolXGGk/zopULf?=
 =?us-ascii?Q?GHdwsUxVa/e9VLQeiZlOApWymMLrNc3rbndH9nhzRV1+GyciOaIzLZezQL/j?=
 =?us-ascii?Q?DAoNiY1ba85x+ppx/ysqMRl92aYyIvwkGFQ0X3u5/E2n5jhGp9pN8FDfQ7B/?=
 =?us-ascii?Q?X/wg7t0B2yuYrQgkUssNv4BelYPJrmPrg0ydAfsWbwN2Aa4fb+qNPfysjA48?=
 =?us-ascii?Q?56nm2CWoNKlQtxLJqyuwLyJbmGh219WO6UoRUY35xm09fSwwdeoGFqs/kxq6?=
 =?us-ascii?Q?0BWuK9A+X1ebATnXKZVMIUEe/AB02uN5T6ck+kPvHMZimKEPuouytBPsy8K8?=
 =?us-ascii?Q?m44aCRVRVFMMh87qLSVgxbArStsplJr1pwtnGgCFwOC0fX68Afp7/InZj8QB?=
 =?us-ascii?Q?JAQY2vbaWDsag2dNa7pxyDR2Hgv9d2+N5FLcltEtT2yfHVXP8BV7Fgxkh1oU?=
 =?us-ascii?Q?kUaSmuUbWKDciy/l1twZtDwlC4wj+d9VWe9Iqp8RYs8BxGPa3vm3GPLmn7v5?=
 =?us-ascii?Q?VKS1pr2AE1CRFY2oKpDJZAzmWzSGFrcX9PB2N9cLNp00JveVBeZMB6gg76n7?=
 =?us-ascii?Q?6tqsPnUdtqOzwIlRPdfvNOZaRliAUxL5V7SizBeW6WtVBWDfnIDkJklSKbgD?=
 =?us-ascii?Q?6m5BGMiNMbkQxZX63xP1/im6W4xG3VPkQuP+bYOiuPV2nllKIPTwf72BpUPW?=
 =?us-ascii?Q?53LfjVFZrftrMUYe3Vz0uDC/aAjwslWPLauwkxgSoCE7hUrfdNmewHjjUZ1e?=
 =?us-ascii?Q?dK7JsuiQjCK7E4YR55EbWYSJMKO/cpG7ZxufPtOrTczX0JwuD+pOngQsSm73?=
 =?us-ascii?Q?+jP2sgAjU8c+FoqqtrlcGpRW1KYsZTdXuvR1yT3XHHCwil6RTpLO7Gexfp8I?=
 =?us-ascii?Q?yhNmH6uW3LjbveypvKrC+qglK+wrRaz0T+q/uT1x8pHXLrn6Dzy+x83VcL8c?=
 =?us-ascii?Q?2TBZgExkIGlqyKsgk0FeTNlQmnW6g1MtALQ3HUAVBg7or6mI2NqrEu1WhzuI?=
 =?us-ascii?Q?TAgvy7sSdzjbWnNGqB+yYJzyVbPtNeWj0MXnMkY4ZdQiJIYeK0BlJEos4fyM?=
 =?us-ascii?Q?tN1n/rc6n2c+EjcEV05QXtKac2GKH9+DDkxB9djfFBPBOOYgMqpvSsJog1Ci?=
 =?us-ascii?Q?TCb2wzop3+FLRikKSB4lBCT08wDOKOT94ng67YVo3Bc1ooWDtkydWOad+R/5?=
 =?us-ascii?Q?yjlTngr1xtbi0MXd6ou0EEvzhn0iqg4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f1c1f8-cdc0-40c9-2cbd-08df0fbf3b4d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 04:43:31.8806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbwlczD0kePjUsk3PRYlFg4kJlvg0Ojc4nXPrPSsjXHAfxXP36HPG8xHQ3QXEfvf/QlxuApZI6432hmTb1Q7H+SE2G+MtmQftxt6GUhznSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6848
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

On Thu, Sep 10, 2026 at 10:39:42PM +0800, TANG Tiancheng wrote:
> RV32 write_minstretcfg() replaces the full 64-bit register, clearing
> minstretcfgh and its privilege-inhibit bits.
> 
> Replace only bits 31:0, as write_mcyclecfg() does. Test that a low-half
> write preserves both set and clear xINH bits in minstretcfgh.
> 
> Fixes: b54a84c15e38 ("target/riscv: Add cycle & instret privilege mode filtering support")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/csr.c                   |  2 +-
>  tests/tcg/riscv32/pmu-minstretcfg-rv32.S | 52 ++++++++++++++++++++++++++++++++
>  tests/tcg/riscv32/system/meson.build     |  7 +++++
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 57030724f85a897e21e5082b9857411b50f932ac..f9f43a9c12e1afdbdf6c7202c167988389963c10 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1167,7 +1167,7 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
>      uint64_t inh_avail_mask;
>  
>      if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        env->minstretcfg = val;
> +        env->minstretcfg = deposit64(env->minstretcfg, 0, 32, val);
>      } else {
>          inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH;
>          inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UINH : 0;
> diff --git a/tests/tcg/riscv32/pmu-minstretcfg-rv32.S b/tests/tcg/riscv32/pmu-minstretcfg-rv32.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..59ee516cea9d09d0945033a77e788e4387cd684f
> --- /dev/null
> +++ b/tests/tcg/riscv32/pmu-minstretcfg-rv32.S
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* CSR numbers for older assemblers. */
> +#define CSR_MINSTRETCFG      0x322
> +#define CSR_MINSTRETCFGH     0x722
> +
> +/* RV32 writes to minstretcfg must preserve minstretcfgh. */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/*
> +	 * Use complementary patterns to check both set and clear xINH bits.
> +	 * All fields in the low half are WPRI, so write zero there.
> +	 * Exit status 1 or 2 identifies the pattern that was not preserved.
> +	 */
> +	li	t4, 1
> +	li	t0, 0x54000000		/* MINH, UINH, VUINH */
> +	csrw	CSR_MINSTRETCFGH, t0
> +	csrw	CSR_MINSTRETCFG, zero
> +	csrr	t1, CSR_MINSTRETCFGH
> +	bne	t0, t1, exit
> +
> +	li	t4, 2
> +	li	t0, 0x28000000		/* SINH, VSINH */
> +	csrw	CSR_MINSTRETCFGH, t0
> +	csrw	CSR_MINSTRETCFG, zero
> +	csrr	t1, CSR_MINSTRETCFGH
> +	bne	t0, t1, exit
> +	li	t4, 0
> +
> +exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sw	t0, 0(a1)
> +	sw	t4, 4(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence. */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	8
> diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
> index cfe2d854b729a8dfdbce2373e73b91b470db6b4e..5f417c0c51e17840072104812f5854dfb65d1d06 100644
> --- a/tests/tcg/riscv32/system/meson.build
> +++ b/tests/tcg/riscv32/system/meson.build
> @@ -29,6 +29,13 @@ tests += {
>    },
>  }
>  
> +tests += {
> +  'pmu-minstretcfg-rv32.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', qemu_args],
> +  },
> +}
> +
>  if 'qemu-system-riscv32' in emulators
>    tcg_tests += {
>      'riscv32-softmmu': {
> 
> -- 
> 2.43.0
> 

