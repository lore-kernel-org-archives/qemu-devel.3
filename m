Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E530FC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4sEx-0001dE-SV; Thu, 10 Sep 2026 23:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sEc-0001at-Mp; Thu, 10 Sep 2026 23:47:31 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sEZ-0006tU-Eg; Thu, 10 Sep 2026 23:47:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkJZQViEREkUeYhEMplGWL9FkKZCJeKpSU9zQwpkxIziFbU1sgArK8+bUivsySRFwjR2WfjW/eAqXp4iDV3+SyzdJSzmX/+vggIrR1vokmIVHgZ9cbKm6N6X7Pt3FfQlFQE0bgdMZ76v7jolZRwHKvjslUMP4AD0EXMyVciqHER0Zh2eH416XzGM6n2VumouTxiny5DR5BweVnKSUdsKX0zKLMS6AyX6YmzdF+eu9kKLm1Fc9Jd1Sldl4F4dmBg02c5yGK+AY9a5QeyV2FwR1h/uZx7AAbk9cFbzpSVuR3EldMiaGq8R5grb9/aHcEYTn6IkBmjVD7h6dOiEAyix2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QweelUNYYpXNTKpfQD2yKmA2CvzFPffQnivV5raUIVI=;
 b=BJ3r8cHNaVQK02IG4lzBvkDYj6bnnxbv6ZL00y4mFRqkd4R21Wh1rdgYkQi8DX7nNSmDOmjjBH1Q9Z6KgbTVOjtrGYcOOTEsRWIwCUWn+baMHWIdGTKyC8vnc5hiy0b+73UtoLRkgeJ3mzy5MJerq1K/PK1cKn0u/Uy3K40/rzrStWymQ9HZXNtWWGHXvV8tWLuYS5SOMK0h41AdxuyYmli4e5MrPHyc6Ql2UdyoC7L03EuoXhq7edgbOUeERsUjVFFq4OjYYjqbW1Ki+ZSbHXAXk8xe6XIP1wzJvHN+f1zJNtJ5nECBnlGSBE5+odMUgnj9nLjuM4owU/lY5u6IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QweelUNYYpXNTKpfQD2yKmA2CvzFPffQnivV5raUIVI=;
 b=Fzy0g1RKW0kNn7YA/wfwM4FuTX4Wo3a/l928PVq3Xcr0CRuFx+I8vRqWW2f2Ffh9/ZsprL6kCAquBnbqgiPQWQ2J38paqJ33PwW5AQgYarIMoMGkGg38C5ZuY8jPeYqJdtBS7nE6Or3ziGy3/3Kt2so/nQDKXsTVmC4m39Az0jSH1Edx9Iqg6uDtDM7qEl2Dz7qsJXlpzZSjMM6P/AnInaLzPMUvtSxu30zZX2xqjg2Ig6PRLCNuHQ57xyBTvjIZljNH4BvdiEnpVKdbPqzTwkM7z2m2Kt9TwUBzTcjXg5TeTwm9tuBFe15I7oUdPZbVonq7ARyDSU3ADe0mKXmo6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KU2PPFE5AC5AFB7.apcprd02.prod.outlook.com (2603:1096:d18::46e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 03:47:15 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 03:47:15 +0000
Date: Fri, 11 Sep 2026 11:47:07 +0800
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
Subject: Re: [PATCH v2 01/14] target/riscv: Preserve PMU state across event
 selector writes
Message-ID: <aqN3Q-7jqKPyt9Nn@MacBook-Pro-4.local>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-1-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-riscv-pmu-correctness-v2-1-5da5159a0c64@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KU2PPFE5AC5AFB7:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d4b117-7d8c-4d04-3e42-08df0fb75e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|3023799007|10067099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eJ0V7NW4VNf9yHUQfAKUC1aTaYCt0MwaWZtOEbw4vVCcowJyuUseqXVQgldMiTPHH+NlXArsN0pg39138QvGOG4lsRTcDQ43eQRM5igK7II48Tjh7zUWS7qZTxOVldgFsEZQachILQSl/nPKBdggmtyXimKtw9lXF1P2DDGtNXORud+lhDk5QW6v7bes5b5GPLAdOYA5rWSdFm0yl+ZsmkCuIRsns0/wLlUlONJeAoD3rqxfXjrWI00oJXRULzcXL2NttOdWmVn222oxM1/Mr16ln7v3ZHI/DRgVufVtD7vZa4cRwL8kNt9+koWtrulRTBy56T6XjcliA83qcUFejVmcKptcG9my/IAIh7zSJee5FUDlYVFrvGHxlnalj6zT8jikhaalBSHAn1TwA37pKdwHVt9YX9PS1n0MGSe/c+pnMhwOvM/qEvf2mFbI0ux3FamdaDr3R4uW8ZGWXuzXFd4JQ0rLPO2C6aCUFzcYK89Re2HvE/2pUNtdUOQWupMv+djFyj25e7smJtY3CnhaXsuSL77bITMkavr9vJkUtNnJxy7Y+sNe6bhp6X7oGZoIS//bDrhG9B8s0lucSa8Aiel6VWiQ/ad71XqnbDZHObHiR5xtuNWZ3ZWh0B2F9gdNilHuiRutMNQV3DQxaJ0lZLHySzAobQ9uKVV/Q16utxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(3023799007)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKN4QulV1R9V3rTruHKjdsbaPuc8AgVt+Z0Wtu+wDKR/rZqRiF5cdB4Nk6TC?=
 =?us-ascii?Q?z1z3vVqqfMZVouWrOPIN/G5Ulz6Vo4bbU+LmvkQtyY88gn3RQm/27h2mnWAz?=
 =?us-ascii?Q?c1iYkOyxdDecjGbyV11EOS1ISbrw79Mde90wjnLhJoWdgIfczZs40XdqW1Iy?=
 =?us-ascii?Q?sTbpDTPLhlcNqNEE9pBcDS2vcTwGGzBn9n2FxXLJ1KBZAQhclaSHlRduiRoz?=
 =?us-ascii?Q?TQoKNSmN+De5HquufsbKgCfHONGGDRSJkCkrh+YI+enYheArcHWS4t6MumhQ?=
 =?us-ascii?Q?l0MeQjUpieK0yDVk+gPieMq0hGJIYS1D9zSoMeGdT8IaEmISGV1TVyWqVgrT?=
 =?us-ascii?Q?JW+rbpLYeR1yNbQAUK1A2m+x0kMwq9QLaYWTPApAVmPGtN8nl9QZcIuxyd5l?=
 =?us-ascii?Q?jeL8AybZLD/gGaseVsYvelIAL1YPnyiIQTrnSeLPr4zNnKz0g9nMPoEVA5Z8?=
 =?us-ascii?Q?wAQ447L/SzqJWsS3hYWkTuFCK1iEhYvmvxLbmbn21mSj2Omba1VffhKlLcLr?=
 =?us-ascii?Q?Lt3wBpV0/jZmXRO6QslbLN7peplwHYHt21pVk8Anel3c9XzvD9WcS1gcgPh1?=
 =?us-ascii?Q?L3fXpmpQfXtvv8Uw3kBRqV3AJB2cSYlFcpHlh66zUXrKrps9uCMM0+lU2Wrc?=
 =?us-ascii?Q?4bYqpLzL6zYx7ftheybmI0/ZWopGuwrmSwdua37ZYsGDE0E0sGvmlLj21FiM?=
 =?us-ascii?Q?MY4pjx6gfC+hFF4FhlYOPa9Cu7iUcrHe+x8J+N+QiDUixdX3I6MV/pA2nyyQ?=
 =?us-ascii?Q?7UPDL/pmgvaSazSlSNdzi+bUVgSgRqxJenlsNBO068mMlBhX4a7pT8ipDFGZ?=
 =?us-ascii?Q?caQnEdYZJ3Bm9sNa++bGwrtnJDC2I25prRYfBlqEQXq4mnhhjeXQy+RQ4BlD?=
 =?us-ascii?Q?RyydKcOWhZ/DqK7AWFP5TElTbu0gcQBKUFAuuhV7G9s+s2Imu/t8B6mf4bFL?=
 =?us-ascii?Q?S5VvRNXcXUvEHLCLHn5FRmZmGnJyDXPdm0T4aUl+8YsuQFaA+cxzrXaoaLcK?=
 =?us-ascii?Q?zqbVjYwqqgL0/qI+vW8c4QGX9nVLazztHWUUznzZ/PDsQzuESL1ypdY3eXOc?=
 =?us-ascii?Q?VAGdNxii/wFJpxalOgZBbVB+lR6XyrVqwRK8XNC+RaEi9d5zlPPnp4/gaGnG?=
 =?us-ascii?Q?6X068+kuGVua/RZ84q39Elr57UvupT3B6ER7E0RGWfWxCoUatHI9hEtfSt1E?=
 =?us-ascii?Q?KPfPLVT6coOkpr2Ybg/eIcHNWKPrKkIuGzCMeRFGQJ0QiRcv8C4Ji7OzhmG7?=
 =?us-ascii?Q?JE+qkNGhIrA3zuYHaPxW7x19+3ng+gOETOidXKwb7W09l/cpsgod82yM8A6k?=
 =?us-ascii?Q?41s3Z6kiORtblKse0+4wFNVeYZGEbzUWplMIXMTvdxbB8n10RWflDH8Ul5oy?=
 =?us-ascii?Q?6UaTF8xtPvAd0ZR77NM8ziyDhvVH546pqM/zdUXHQyabcn3dEDBmxU2o+w9p?=
 =?us-ascii?Q?L+dDFEn0mx8nJ3U6/+WvaADshW6PcYKy4coxxvlQfKpZOOm/LP4NMZ1Pqq0V?=
 =?us-ascii?Q?pVFLWtp0OoCVVORr5Ah2Dw7huIvh1nKN/Kykek/Aa/G67R7Rvvowdt7frlOs?=
 =?us-ascii?Q?7wkxRgAdDfLRGd/Ic4U54i2xgUVRYFsefeqJL1uUVT8Jl4Zyrd4VUIAnA351?=
 =?us-ascii?Q?VdJ0ACgXDZQxKvDtwd8Iiivj7PsGBDCCUU6CwdH6r0BZvWW0lXdCA9r1Y7gw?=
 =?us-ascii?Q?fCKLFLA5tBaB9ePryZW4pb5/tHtqhQyfssu7+KYMPkc5Mm8pjUKDKk5i/WB6?=
 =?us-ascii?Q?xCEmMnnsRgkOCUQPGPHV7mlhEDN6Q9s=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d4b117-7d8c-4d04-3e42-08df0fb75e87
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 03:47:15.1246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViVQbdwMbSMo8bCRxWPe6oip+BCewexPhoXwvALkaOEXOLOtadRIhtAa5zA5e4AvKOlwbd9Z+Olm9pLw6e8OAfmW3oGt+WQvPVUTDn2e4vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE5AC5AFB7
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

On Thu, Sep 10, 2026 at 10:39:38PM +0800, TANG Tiancheng wrote:
> Changing mhpmevent can lose pending cycle/instruction counts or leave a
> new fixed source without a baseline and overflow timer.
> 
> Account for the old source before replacing the selector, then establish
> the enabled counter's new baseline and timer. Apply this to direct and
> indirect writes.
> 
> Test overflow after initializing a counter with event zero and then
> selecting instructions.
> 
> Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/csr.c                | 73 +++++++++++++++++++++++++----------
>  tests/tcg/riscv64/sscofpmf-overflow.S | 60 ++++++++++++++++++++++++++++
>  tests/tcg/riscv64/system/meson.build  |  7 ++++
>  3 files changed, 119 insertions(+), 21 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 65985efb220c80023cfd9d08e1878a19342aa879..52664a26f5a97a5dc8ff37abf99b4d10927fb120 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1209,23 +1209,58 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
>  static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
>                                       target_ulong *val)
>  {
> -    int evt_index = csrno - CSR_MCOUNTINHIBIT;
> +    int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
>      bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
>  
> -    *val = extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : 64);
> +    *val = extract64(env->mhpmevent_val[ctr_idx], 0, rv32 ? 32 : 64);
>  
>      return RISCV_EXCP_NONE;
>  }
>  
> +static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
> +                                                     int counter_idx);
> +
> +static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
> +                                      uint32_t ctr_idx, uint64_t value)
> +{
> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> +    bool enabled = !get_field(env->mcountinhibit, BIT(ctr_idx));
> +
> +    /*
> +     * A programmable counter backed by a fixed source uses mhpmcounter_val
> +     * as its base and mhpmcounter_prev as the source snapshot.  Preserve the
> +     * visible value before changing the source or its privilege filters.
> +     */
> +    if (enabled &&
> +        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> +        uint64_t source = riscv_pmu_ctr_get_fixed_counters_val(env,
> +                                                               ctr_idx);
> +
> +        counter->mhpmcounter_val += source - counter->mhpmcounter_prev;
> +    }
> +
> +    env->mhpmevent_val[ctr_idx] = value;
> +    riscv_pmu_update_event_map(env, value, ctr_idx);
> +
> +    if (enabled &&
> +        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> +        counter->mhpmcounter_prev =
> +            riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> +        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> +    }
> +}
> +
>  static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>                                        target_ulong val, uintptr_t ra)
>  {
> -    int evt_index = csrno - CSR_MCOUNTINHIBIT;
> +    int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
>      uint64_t mhpmevt_val;
>      uint64_t inh_avail_mask;
>  
>      if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
> +        mhpmevt_val = deposit64(env->mhpmevent_val[ctr_idx], 0, 32, val);
>      } else {
>          inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
>          inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
> @@ -1237,8 +1272,7 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>          mhpmevt_val = val & inh_avail_mask;
>      }
>  
> -    env->mhpmevent_val[evt_index] = mhpmevt_val;
> -    riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +    riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
>  
>      return RISCV_EXCP_NONE;
>  }
> @@ -1246,9 +1280,9 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>  static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>  {
> -    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
> +    int ctr_idx = csrno - CSR_MHPMEVENT3H + 3;
>  
> -    *val = extract64(env->mhpmevent_val[evt_index], 32, 32);
> +    *val = extract64(env->mhpmevent_val[ctr_idx], 32, 32);
>  
>      return RISCV_EXCP_NONE;
>  }
> @@ -1256,7 +1290,7 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
>  static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>                                         target_ulong val, uintptr_t ra)
>  {
> -    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
> +    int ctr_idx = csrno - CSR_MHPMEVENT3H + 3;
>      target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
>                                                    MHPMEVENTH_BIT_MINH);
>  
> @@ -1267,10 +1301,9 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>      inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                         riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
>  
> -    env->mhpmevent_val[evt_index] = deposit64(env->mhpmevent_val[evt_index],
> -                                              32, 32, val & inh_avail_mask);
> -
> -    riscv_pmu_update_event_map(env, env->mhpmevent_val[evt_index], evt_index);
> +    riscv_pmu_write_mhpmevent(env, ctr_idx,
> +                              deposit64(env->mhpmevent_val[ctr_idx], 32, 32,
> +                                        val & inh_avail_mask));
>  
>      return RISCV_EXCP_NONE;
>  }
> @@ -1512,11 +1545,11 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
>      return 0;
>  }
>  
> -static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
> +static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
>                              target_ulong *val, target_ulong new_val,
>                              uint64_t wr_mask)
>  {
> -    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
> +    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
>  
>      if (wr_mask != 0 && wr_mask != -1) {
>          return -EINVAL;
> @@ -1531,8 +1564,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
>          wr_mask &= ~MHPMEVENT_BIT_MINH;
>          /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
>          mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
> -        env->mhpmevent_val[evt_index] = mhpmevt_val;
> -        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
>      } else {
>          return -EINVAL;
>      }
> @@ -1540,11 +1572,11 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
>      return 0;
>  }
>  
> -static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
> +static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
>                               target_ulong *val, target_ulong new_val,
>                               target_ulong wr_mask)
>  {
> -    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
> +    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
>      uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
>  
>      if (wr_mask != 0 && wr_mask != -1) {
> @@ -1560,8 +1592,7 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
>          wr_mask &= ~MHPMEVENTH_BIT_MINH;
>          mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
>          mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
> -        env->mhpmevent_val[evt_index] = mhpmevt_val;
> -        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
>      } else {
>          return -EINVAL;
>      }
> diff --git a/tests/tcg/riscv64/sscofpmf-overflow.S b/tests/tcg/riscv64/sscofpmf-overflow.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..97f03037bbfdd44f2288b257afb91499e4534f13
> --- /dev/null
> +++ b/tests/tcg/riscv64/sscofpmf-overflow.S
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/* Program hpmcounter3 while no event is selected. */
> +	csrw	mhpmevent3, zero
> +	li	t0, -256
> +	csrw	mhpmcounter3, t0
> +
> +	/* Start counting retired instructions with overflow enabled. */
> +	li	t0, 2
> +	csrw	mhpmevent3, t0
> +
> +	/* Cross the 64-bit unsigned overflow boundary. */
> +	.rept	1024
> +	nop
> +	.endr
> +
> +	/* OF must be sticky and LCOFIP must pend even with LCOFIE clear. */
> +	li	t4, 0
> +	csrr	t0, mhpmevent3
> +	srli	t1, t0, 63
> +	xori	t1, t1, 1
> +	or	t4, t4, t1
> +
> +	csrr	t0, mip
> +	li	t1, 1 << 13
> +	and	t0, t0, t1
> +	sltu	t0, zero, t0
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
> +
> +	/* The counter wraps and continues counting after overflow. */
> +	csrr	t0, mhpmcounter3
> +	li	t1, -256
> +	sltu	t0, t0, t1
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
> +
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	t4, 8(a1)
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
> +	.space	16
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 8604c2a45a9ad6bf8589f90d5b0d8fd1b2736db4..ebe78200fd551b42d3c99ae19ca03803797f803d 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -61,6 +61,13 @@ tests += {
>    }
>  }
>  
> +tests += {
> +  'sscofpmf-overflow.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
> +  },
> +}
> +
>  if 'qemu-system-riscv64' in emulators
>    tcg_tests += {
>      'riscv64-softmmu': {
> 
> -- 
> 2.43.0
> 

