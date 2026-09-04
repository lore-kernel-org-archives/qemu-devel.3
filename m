Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0354DC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2OKh-00032t-3v; Fri, 04 Sep 2026 03:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x2OKf-00032f-Pc; Fri, 04 Sep 2026 03:27:29 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x2OKd-0007q4-Ms; Fri, 04 Sep 2026 03:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRqz0EEDXf0dsF2FAzI2lvbbcCeokomfauQkVRLTyUS5+AfxpyA7mjrjoU9/wYdQZcoyTgC0dajpIK3DLCEE22ipUIA5mgqgPTTZKVNIxXecEUkLaXMku0G5BKSP8tQi3qkaIbH8eEaHy/xyfIYa90nGpYsLE/FLT+AKsIrV5tUjuFjndR0m6EMV9rfEWVBNL29Ia+MNhE44zjYZaQydG+LA9SzyvOVOZARkzHgfMIKBFI8nwHWBnCc3wy0wxYdxaGqDXK3lKWyMVMYYkXuvLC30SpcujWPaIjEn9bZ+RZIPGXWocCF99H459RqYKYJXx5xJh2mVPdfokBMeW4Y5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31NrxNb8Ah+4KAkyLRC1lrdg59FkM4bsCed8LDaBEms=;
 b=Taqs4uqq5Vq+kI0hGXNsjOJYkq6bTVGU+XlGAiJfOc40TzvSaj1Ih1gnt80LyUyQhmg2XeAZ5sStTQBhSfxYi/VHaExvfyRtcdA9ppiWwmkwoqmWcQAD7/ik3E0JPudbMEqvQOr+qMLt+oAvZ1o/yNMMhtlOF7UZJyaH+kGs6R58JmVhsbyikDxxlUVpcOYcShz3O0IA1yOcSqQSHK1mGdY1olrRh1cSiu/XzzKNs/I9JWJsTuiu9EJmJ0IXh+plb+HplwqKOAeTFiy/MuEqwfDX7MwOMdigO7D9A8WpixX7NZT/sdsj8vFGVOBUZf4Im9sYZ02LuUJxvWetyH3pnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31NrxNb8Ah+4KAkyLRC1lrdg59FkM4bsCed8LDaBEms=;
 b=nWLHbzI19id49qb2DqEGs/tbItz7Vk1PZm/Y7wmxhgpJ0A1kp8nf5xk0nIHjzYsx02es1d0wPH+MJCuxzc38TvN0W/SAdWRNo4/47Xxh7VvUA34LrSIy8HkPPLRbR6aIMyMD6lR7+SyBMnHsI0qhLazToC3cTofBqTXXXkAYmQNzNsU0dL9SCRurcFzWaFYBa4HsagGBbOxl/lpmIudG5nQMv4Lpyx7sLupQFoTIz6Y6gQmumjU0ZpxKdfa9BopF/ZjKM9e12/uA8iDEhfJbN3tfpt0Lu381Z0Y5JypOCXWlMmFELFgCY6Cnu8mliBlR230T1zN2drqRrgjW3lVnkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB6137.apcprd02.prod.outlook.com (2603:1096:400:286::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:27:21 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:27:21 +0000
Date: Fri, 4 Sep 2026 15:27:17 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, Icenowy Zheng <uwu@icenowy.me>, 
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v9 2/5] target/riscv: add riscv-server-ref CPU
Message-ID: <appyqYy0NpfzW9km@ChaodeMacBook-Pro.local>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
 <20260903183125.682865-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903183125.682865-3-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 14becd3c-d08c-4b9b-2c4a-08df0a55f56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 5Ts3KQ8Gm/hILQVur6gAeLRJU/wcMa2rl6pDJm7AODJdrtB1kiGXz0TsxbZkCZQOhxuCNzC3J5n0bITHEEFJytVZefLVl98eu+96dCce0RvJYZwcsZBlKosLJ5447Wz5JsNmMG1ZBL/NmIGHUjd4h8SbxKtqIJC1EDxdBvdsDUsHWCYL9yavc75qhCPRqYQNjL7pZ6UtNX0tDE0NKdbxKJnvNAbUrLob6CF6Mmvz+DH5e4ky+3dZU+dHqBVNaOnTXmVxJisrNGDnWenH9GI5Vb/hSlIeilxazG9c0GrB3TEYhlHMnKBPcVXdFsF+Kbep5t3SmoU+zkkbZifQUFhlBvvPuN8tJezv2ubTnuWbbjXEILVgzeczL+StQLh0KFcERzMEdrJUAvOrrHbrtheiKCmLZG4chKJMeWfc3pr3ZwoeGe3wevE/M6O367J6vQk1ZgDAZweXvA9PUdw5FcSyk6my25qH2hOus5BHkxvhIolKJ3vGtGsgKaUias+gL8DjL1kNi/wcie5t8gP3MuVPZBxaJiB3iqsbksuuEq6RG4/9BcUBOKUwwixKvJRsYmAXCJ1S5DibFQ4BukXaui80OBg+PzsaPdz9yxfRp0vpzXIPM6w7mxNNfHDKkzlLflSlBvGBsluLeATyOg+1DzYcwLolw/0e1buoYJyCukLmhRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5V1MohlAAssRJZXVEAQIt4y3eOg/hre0kaHcR0EuKC042igflhdXKUkFUfkZ?=
 =?us-ascii?Q?sO+KngGGHCI2ey2VXK6dEauVH3uv1XLbN3hVeHlb/vM8Efw0eQ1KVe/HNCCA?=
 =?us-ascii?Q?Z4L0ZQmI7jpc+YieH0d6HVA0BHfL4/ayhLaA1kMX0GWbzkMcXFwCAbJ+OLxK?=
 =?us-ascii?Q?evj/AZHgPyuSLWelwUmbU7GlTxZM+k6lBzJhZTwsr25i4GuBV6cuv/5QwVGc?=
 =?us-ascii?Q?T+wOV64kcvT8zwJGUdk7go6GaB+QkxNWcA08Ti5vSjhmjj7YMvHlSJ5HCDBW?=
 =?us-ascii?Q?p+/a/JngM788GUOKMvbxyTSP7JLllMEMjMEhMsQrCcZKH5wnpfpqHXA3iO2N?=
 =?us-ascii?Q?Ua4femExWQvMvInPwvD+Unb/Oya8jGRyJvrkyeI1XwyfySGJS3cO5E0g5B9m?=
 =?us-ascii?Q?0z6sZkAJEe9lOkZltQYkJ8pISNlk6kTQCBOkIhSLVQzrRDNlxg1SvCRKUL7v?=
 =?us-ascii?Q?mLqt41kD2HturfhAxtjOpkxzE6MWQeleNmlGddV1Z1nhs5qweNc8IuyTofwk?=
 =?us-ascii?Q?axv0l25kWqTPZvRm22Lt5a6eHT+5zihE59pR9l0jtQSAe4Zm7ApBZI5zOvQU?=
 =?us-ascii?Q?3y5VS/8sIvZj+rgPs6gLtcAYT5UI4G2cALDMGpQSj+oP6Ei171QX+6v+9+vN?=
 =?us-ascii?Q?BgxlMDzuusfuYi9xr03NEp+368GxkKakFG1VNacjmX4yU55lHVsGH+eRUu/S?=
 =?us-ascii?Q?21uuRPykxLrV/I7gK4xZPmN9xYmkaHmk7cK9Cxr6BIrT1DdFugvBwJoR38AW?=
 =?us-ascii?Q?ZHYWGwUQtUK56MZOKGYFlO+uqAr59B/fMi1YF4A0B3JPxr33qSEgEqh35b53?=
 =?us-ascii?Q?yr5Aujhzl+w0JUqoQSRm97AgFvRajaNoQb69fdmOUC0Nd/9gsdSf8eOTkj+5?=
 =?us-ascii?Q?jFUUJv7nziS2MzUAHbids4eLPhc6etZWiaS8m7RLuQdWpmZpavYIAkKO+igy?=
 =?us-ascii?Q?5XFriQgY5QCo7m16jmdagzOjbcyU341TEZwSD30ZT2Y7FJ3ECBq0kgdrWqKI?=
 =?us-ascii?Q?EVNrAFt3P9wuahRTVb7LjdGXbbF6V7eDrjvtEZoh+d9KAZArg2KP03rcjvFE?=
 =?us-ascii?Q?iN9PNj6hsgbUMk5tHo1Y7tdFIq5KmIhRi1a8OpbKz6vcMEMBY89Uxw3xOi3l?=
 =?us-ascii?Q?Q7gItJn7Jl5Wsy3sb2J+vAEjUdytDvZEJ0MfDSsmagnzzHzf6O6AkVGJb5XW?=
 =?us-ascii?Q?I6FCoWAuDn/t6Epg99jYNtRIhXO12DerOQjJ/9TFMtOPoy0XNXxZcpWCmofT?=
 =?us-ascii?Q?5X4YsMBJUU5LPzBRhP9KTVQXS+cUFJQhOU3uTkIH/4ddMJmYJUaD9jzNicCI?=
 =?us-ascii?Q?zI4UI+upQGaDtZz3l+DfY9WYS2kj7h4qVkiYhH2PUEipGXT9sBw+WaPxlALo?=
 =?us-ascii?Q?J7bhvFGwv+jH1mbEnaUOj9RMJWCcAxQJV1BtiGiZeHTcXSDHi2pRAcb+70Kz?=
 =?us-ascii?Q?ni/uXo71dVr4P3E7z3KTYfnuS/dasCAbqYQMXMwE7e4AwoYpQtSo6NsRmJKz?=
 =?us-ascii?Q?YkMU0uyNM/BGw8/TO+2221hh631+Hr2HbaTz8RTZCrb1iv07Ra8IR0Hv4p50?=
 =?us-ascii?Q?+V8GyqefTCXrNwJAyKBtVH0JjKeR6lvB4N2is7/wEneXYJb0S7OvTD/6bGgS?=
 =?us-ascii?Q?AY2Xp/WVOLh7XQJIkf36oG0El/4zZy/e7FoGTGa51Elw8vhu5cP80C5izLHm?=
 =?us-ascii?Q?SgIZ9xvX85q4baEUsCk6znSf4xxOjiRK6g6s/AWiaoWdMCI6KTmHUujf7go9?=
 =?us-ascii?Q?5kFfZaXEpFvhOe38eJ2O6h0owsjdPJQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14becd3c-d08c-4b9b-2c4a-08df0a55f56e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:27:21.6506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW4MwcW7e/ksKOIzaXbDpk9gN0COEYEsuUDMXM4/YLqWhmVsEvIO1aJ+mnbLgvtdbbMl9KU+VMnSj7PoYdWz1yPI5bg+V1CLO+RvARvhY0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6137
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

On Thu, Sep 03, 2026 at 03:31:22PM +0800, Daniel Henrique Barboza wrote:
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
> 
> We're going for a profile-based implementation, instead of a regular CPU
> that can inherit RVA23, to allow future CPUs to use it internally as a
> starting base for their own extension sets.  There's also a new
> 'rvserver-ref-1.0' flag that can be used to set the extensions in the
> command line for other CPUs, which can be used for testing/debugging
> purposes.
> 
> Note that for all intents and purposes "riscv-server-ref" is a regular
> CPU and no, we're not trying to set a precedent of calling the riscv
> server platform spec a profile.
> 
> [1] defines in rule SEE_020 that we must support at least 11 debug
> triggers (4 for insn address, 4 for insn load/store, 1 for icount,
> one for int, one for excp).  We're going for the minimum.  If more
> triggers are needed users can set any trigger amount with:
> 
> -cpu riscv-server-ref,trigger-count=N
> 
> Note that N must be <= 128.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Suggested-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1a28f1369c..61234842e3 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4cc73de793..086bc945ba 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2417,11 +2417,35 @@ static RISCVCPUProfile RVA23S64 = {
>      }
>  };
>  
> +/*
> + * The riscv-server-ref spec isn't a profile per se but its
> + * CPU definition can be modelled as a profile that extends
> + * RVA23, with additional things on top of it, and allowing
> + * future CPUs to derive from it via
> + * ".profile = &RVServerRef1_0;".
> + */
> +static RISCVCPUProfile RVServerRef1_0 = {
> +    .s_parent = &RVA23S64,
> +    .name = "rvserver-ref-1.0",
> +    .satp_mode = VM_1_10_SV48,
> +    .ext_offsets = {
> +        CPU_CFG_OFFSET(ext_zkr),
> +        CPU_CFG_OFFSET(ext_sdtrig),
> +        CPU_CFG_OFFSET(ext_ssaia),
> +        CPU_CFG_OFFSET(ext_ssccfg),
> +        /* ssstrict is always enabled for PRIV_VER_1_12 */
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
> +
>  RISCVCPUProfile *riscv_profiles[] = {
>      &RVA22U64,
>      &RVA22S64,
>      &RVA23U64,
>      &RVA23S64,
> +    &RVServerRef1_0,
>      NULL,
>  };
>  
> @@ -3757,6 +3781,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #endif
>      ),
>  
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> +        .profile = &RVServerRef1_0,
> +        .misa_mxl_max = MXL_RV64,
> +        .cfg.max_satp_mode = VM_1_10_SV57,
> +        .num_triggers = 11,
> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode = VM_1_10_SV57,
> -- 
> 2.43.0
> 

