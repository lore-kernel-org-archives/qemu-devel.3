Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC217C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4sM9-0002mn-6P; Thu, 10 Sep 2026 23:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sM5-0002mF-OW; Thu, 10 Sep 2026 23:55:13 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sM3-0008Ky-8e; Thu, 10 Sep 2026 23:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Glstzgqtk6Skck2Sp2E+TUH2M+ML39ztNz872vxuABPpJLMm79Qg8P5Tdoua7kXwmRS27Y0l3cvjItPw8PplAky0lLBVfPlOV2I83p7FF6q3imMIJPifg5lU3e4hMwSHY/V/t5D1i1AhCI4v8Wzuqnv9tETfmtjmtSM5+VpueL+/ASh2TnpPUsI732ih5zsao06nksVY0pbg1vz36G1ppltL5+uym0lDE9q2tiu1DoIeJK/rNuexOa4YORjYdwg87uyZOXMUrcd+ftNplzvQCcrhTOXSQWQUioT5fTltqMx94abePFxpK1v8ws9ktb/t//cSZ6NyC7Fqa+kPbzryRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOF82Bv/RYoJLKRVdAvFObCmZf67Z9GMupVfuV+4mi0=;
 b=GWWSvYJwHC7cbulupJG02LIuH6wSoLdX44mmGLMZyysqrSQ0UALKDTSlFKVq9ZN3IwbzzB0m53yPQZhd/XuI0QIANCKkV+HSQADV7YoJBvdHju8iLilbaSvKKRuvl7FVsY9nVuHuKn3CqHIJSurFthfguSdhIEbCUaITB/JC5Mp7sk03jVBuJzQKhc0oaOTeWRogjseX4+Xmu6CAULsUNaHUIzlMd/6lMV3hWG9Ingjvpht9+TM85X+q+GSePXslBgG7N5Ik/l9UD+HkjdTB4K5S7Y2O8ph0lidsd5q2qnkQ2CepYPMqnW4D4WZnGyOOTmWmaKvX/KjMbjRyvxEqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOF82Bv/RYoJLKRVdAvFObCmZf67Z9GMupVfuV+4mi0=;
 b=ryD/LVUZo78quT05IAeAseoFD22SdCJp8MF9qpuF4BE74IcbMs71Zdx9D/M1fMq9RGL3wipznuqNt6zwJTW8cK+yGxxRPA7icu2ujX6lDZ3znOW+4elaHbHPMJJpllJDluPywyQz4dzsQtUgBZF+Y7RuknYCdUUGCrQZwvwacsIKD6Cen+ULV1oWZlo3IJ6Hw+yJwucLnQUo+Qaz+j6r1kJHGzmx0vhdXkZuBKi6kadBucxVDCklXAdhdpxXwoUMw8tEUXZWgvooDgh0snfIiKNB0RM7YVBJhf+RmkuyfrdVcsMQbVwdzTTQ2N+2mjSb2UgBcn7e+/B8EeYh3yHzZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6454.apcprd02.prod.outlook.com (2603:1096:820:cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 03:55:01 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 03:55:01 +0000
Date: Fri, 11 Sep 2026 11:54:56 +0800
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
Subject: Re: [PATCH v2 02/14] target/riscv: Support multiple counters per PMU
 event
Message-ID: <aqN7gylyOvsQxNRy@MacBook-Pro-4.local>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-2-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-riscv-pmu-correctness-v2-2-5da5159a0c64@linux.alibaba.com>
X-ClientProxiedBy: PH7PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:510:339::23) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7b4986-80b8-40d4-8821-08df0fb87473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|6133799003|3023799007|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 82ioNPPRQHD6G0ZGWv0wbo7/39oqUD5hBNAk9vVT+fMq0SFH63/mHHPvyzWTdh5aaNZwdONDeWLb9piQiU2GZ/ZDeKNc6dC/oRaz2fKvdn8YelsmCD7GLif2diFwYGpT8r4A+Anox+20pSjXqcD2sFEgftElpexM38rxcTGv5vZNX5M5+wL/92VTDWF0SOwY6f24myLa3RCTiyBL5dWDB3nwv7HPiWMNsYdA10ZbMFJlynWOFS2lWCckPDAxwJSEbESdBG5PAsmPCP8G/ms0FWSTWOunbhjXI/8UjL9TfQzxU4JpSxSjp6i89i4XP/81Bo6rgw7QaevLC05bIumIRk1O8AfJP3rYpqttPtU52FC8eUnzYmDMh7Snl2dtwS+Zd56dd5mA8G7+IKLLtFjw+qbqHzje4tE9745YQhZjKURyERCq9vh0d2Ix75u+vUzANaP+Qxkv1JQ+Fu35zCCYUXBUNUh5UojibseUmOL6KG8gQwEd20CU8k5mR27Pk2p59GZkgjXkir0w0HG3sURvC82/3p3C3sDobdnbo8vDmyM88gtVUMZ3Nii3Cb0pPwC+wtTslZVXioezERB/XtHdI6UVya1An3VuXXPQGGmdDK7bHc5yJJigkCnX4gaAlEHGmUwjYwWQiZYrvaZ78lfqZirpNYSWA09YPCDNAB9fP8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1X4zmNzJaCm+wL+3Azv11r2UFMT72X34Dvi0IbBQ+lBy7kwA9OGEnv0ce92G?=
 =?us-ascii?Q?YdH7OVvXyKrIP0d4E2LYm7J0l43mOaVYEn5isT65ULete3kZiHY25sXp7yoT?=
 =?us-ascii?Q?nVHHONjR776MMH5XocX1Rbm6NgcpXKZpNyNucchi/FCNrGfLeNpySJbEhCUP?=
 =?us-ascii?Q?mLP5VyvM5AaGO82L9EDY7GhggHIwOmkgjqKqtdSA5N3SgMLyglOfFr1F2j0l?=
 =?us-ascii?Q?zXvq0jofk6YnInFNuoxpnD91tMjPhYCPxOkgvJcKnlkdDqRZOmcTGFieNrkX?=
 =?us-ascii?Q?fNNi3TvQK2FqRRIvo7pbWNCa4+nFZNNEKSiIF467CoDxrFFiVX1zXIPylS7J?=
 =?us-ascii?Q?ovDgFwyTzEn115gQuv0PnBzQGZtctA8fqCJ+BA8AWOrJys5W8bXZZnWh/hKq?=
 =?us-ascii?Q?ArNvzHEeY3n6FiQsOc6umbVkpo++oqmjjgS+O25bjGvvJ/MRkG5LpzhOUTde?=
 =?us-ascii?Q?SZM09217IwJyUMes6HuyCwn4VCpu8oV3wwImVEDsTgjOZJDSGu1oB7anWwH5?=
 =?us-ascii?Q?kOUJ1Bnc53TO6HEavJw5rGuQTTq95Cf4kZCwLq70k3AOqed/JGetlmClWSLT?=
 =?us-ascii?Q?MElUFhfnMAm8y5roLLQfeVZFts9sulkBDmW8w6g8p1egd9DbJdzIwDAUbcnD?=
 =?us-ascii?Q?X1dYxWvSEV9yXvCdaGsL0akXgiRP8ZxFqeIJEJCE5k6Wv02fdjSEEFlO0IVK?=
 =?us-ascii?Q?V+6d0rs6EPMneXJjsIQdf8Y8bo+Fo5O2M3VUZ3bzWrUkCGzNR+iFGpvvZ7mz?=
 =?us-ascii?Q?pr0n08zYFf1b56+MQrZFudn/qh1jvd/wJ+Y6aCGqPsZy6g4Ttp7whLUEft6j?=
 =?us-ascii?Q?6E5Nqd3EMgQ1V23OsNlXde9RVH7rof91qoB/LBiRxkqDWlQBPq9YEHBMMHia?=
 =?us-ascii?Q?AhX/ipgafToCe1mkyEVFoWFuLbtpkfTEeJDXZn+eWQj7+0Vkt8YuvtwkiHwK?=
 =?us-ascii?Q?7Bhx8kXY1maQdJxHPSZnerFb/fxII4V6kKL81EDEnJ39p6FhJ6JTxMIiilze?=
 =?us-ascii?Q?vilJarGR6D/8yN+/7ptYTXMkoxset7a+bu3/Rs78qTQ+Z01HYdI/xLtQhusP?=
 =?us-ascii?Q?acOF8aRGON2iMKzxX0RREvVn2wE1b4bbroDSGC9ybNgwLy9O1BrSyr770FDP?=
 =?us-ascii?Q?I5UxwH3JBGyUBUzmfSR+1N1WkGc49J3Bvn8zpPf6soQy8FxcPRNmkIGAwoPU?=
 =?us-ascii?Q?u/ZLpCScMjYChopIW9j/xUa/RNFLjRhQ7KgFW3I0+Gh5QypFmimZTID6wcDt?=
 =?us-ascii?Q?igt7E0rB57g7B2Myvkma3w0zmjJLfxISXWtSdG5z0cYnGfG9dbSHm3TTWo5D?=
 =?us-ascii?Q?xkHTAu5jk4RhLlZRD3o3IUywU9VbATXJ8HBz9Bezf+KjI/gRl/X5my2GNqbk?=
 =?us-ascii?Q?2lWkHg9KwHyUgI0TZE+EwjS2jQF+tOMJza6/4VDfn4EvjFQboDT0/erPIF7D?=
 =?us-ascii?Q?nAR2ttDNanmCPJxQy7qp87x+DAVaUK8ijbmKp2wvQf1252c3dhiyo6D4GLnu?=
 =?us-ascii?Q?/8rlBxjGB6zsZEkmMRoBVizf3UtmLrtIDBmxW3OBkCsyhFvkfhorocIVsJB+?=
 =?us-ascii?Q?whY1f59cxLaNxQLLWPvhN2/CP8kv1NSjZg7YtmOedVqN8TIRRE0F5G74d3Ag?=
 =?us-ascii?Q?DooaewLfpN87cTCxgXxKlhJSqdwDHc8xeCw600HsDd0f3wo0EKSFHnUPX8Ut?=
 =?us-ascii?Q?qIggR4O3AdqBqaPfuMsRMEV0rZtIFGPkDGSQAIJuYA764WEyWa68xQn3PuVD?=
 =?us-ascii?Q?yOuOV2UDJKScb5IiuDXdR1AuWUxuf3Y=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7b4986-80b8-40d4-8821-08df0fb87473
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 03:55:01.7285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xQwI7xsb//+LeooBsveCdYLUPX+Pjj3TtRzze5pvkATrVqqbd0b4SclrCGSVVAuYy/lakFnMYMGxSwDNcyAyyb2QP1vRqD41c6e2Fdl5+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6454
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

On Thu, Sep 10, 2026 at 10:39:39PM +0800, TANG Tiancheng wrote:
> The PMU FDT lists multiple eligible counters for each event, but the
> event map stores only one counter per event. A second selector for the
> same event is accepted by the CSR but ignored by the map, so its counter
> does not count or overflow. Changing a selector between nonzero events
> also leaves the old mapping.
> 
> Store a counter mask per event and rebuild the map from mhpmevent CSRs
> after selector writes and migration. Update event delivery, fixed-source
> accounting and overflow handling to cover every mapped counter.
> 
> Test selector replacement and multiple counters selecting instructions
> or DTLB misses.
> 
> Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/machine.c                |   6 ++
>  target/riscv/tcg/csr.c                |   2 +-
>  target/riscv/tcg/pmu.c                | 182 +++++++++++++++++-----------------
>  target/riscv/tcg/pmu.h                |   3 +-
>  tests/tcg/riscv64/sscofpmf-overflow.S |  80 ++++++++++++++-
>  5 files changed, 176 insertions(+), 97 deletions(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index bf203bffcefb32710ed0f2af4d4f4595e122d1d9..b0ff2fc7f2ac10fab1f2ff845a953649091e1f43 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -24,6 +24,9 @@
>  #include "migration/cpu.h"
>  #include "exec/icount.h"
>  #include "target/riscv/tcg/debug.h"
> +#ifdef CONFIG_TCG
> +#include "target/riscv/tcg/pmu.h"
> +#endif
>  #ifdef CONFIG_KVM
>  #include "kvm/kvm_riscv.h"
>  #endif
> @@ -311,6 +314,9 @@ static int riscv_cpu_post_load(void *opaque, int version_id)
>      CPURISCVState *env = &cpu->env;
>  
>      env->xl = cpu_recompute_xl(env);
> +#ifdef CONFIG_TCG
> +    riscv_pmu_rebuild_event_map(env);
> +#endif
>      return 0;
>  }
>  
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 52664a26f5a97a5dc8ff37abf99b4d10927fb120..d15a2d096cb6e13cd123ff9ae82ee7c643c2a961 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1241,7 +1241,7 @@ static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
>      }
>  
>      env->mhpmevent_val[ctr_idx] = value;
> -    riscv_pmu_update_event_map(env, value, ctr_idx);
> +    riscv_pmu_rebuild_event_map(env);
>  
>      if (enabled &&
>          (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 1a4658319b11a9a8a0edef18fc8a5abd0027eb31..f19f417e90e33a94d00007ef132ef4e154175b19 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -49,6 +49,17 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
>      }
>  }
>  
> +static uint32_t riscv_pmu_event_counter_mask(RISCVCPU *cpu,
> +                                             uint32_t event_idx)
> +{
> +    if (!cpu->pmu_event_ctr_map) {
> +        return 0;
> +    }
> +
> +    return GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> +                                                GUINT_TO_POINTER(event_idx)));
> +}
> +
>  static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
>  {
>      bool virt_on = env->virt_enabled;
> @@ -180,41 +191,41 @@ void riscv_pmu_decr_instret(CPURISCVState *env)
>  
>  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>  {
> -    uint32_t ctr_idx;
> +    uint32_t ctr_idx, ctr_mask;
>      CPURISCVState *env = &cpu->env;
>      uint64_t max_val = UINT64_MAX;
>      PMUCTRState *counter;
> -    gpointer value;
>  
>      if (!cpu->cfg.pmu_mask) {
>          return 0;
>      }
> -    value = g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                                GUINT_TO_POINTER(event_idx));
> -    if (!value) {
> -        return -1;
> -    }
>  
> -    ctr_idx = GPOINTER_TO_UINT(value);
> -    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu, event_idx);
> +    if (!ctr_mask) {
>          return -1;
>      }
>  
> -    if (riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
> -        return 0;
> -    }
> +    while (ctr_mask) {
> +        ctr_idx = ctz32(ctr_mask);
> +        ctr_mask &= ~BIT(ctr_idx);
>  
> -    /* Handle the overflow scenario */
> -    counter = &env->pmu_ctrs[ctr_idx];
> -    if (counter->mhpmcounter_val == max_val) {
> -        counter->mhpmcounter_val = 0;
> -        /* Generate interrupt only if OF bit is clear */
> -        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> -            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> -            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> +        if (!riscv_pmu_counter_enabled(cpu, ctr_idx) ||
> +            riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
> +            continue;
> +        }
> +
> +        /* Handle the overflow scenario */
> +        counter = &env->pmu_ctrs[ctr_idx];
> +        if (counter->mhpmcounter_val == max_val) {
> +            counter->mhpmcounter_val = 0;
> +            /* Generate interrupt only if OF bit is clear */
> +            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> +                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> +                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> +            }
> +        } else {
> +            counter->mhpmcounter_val++;
>          }
> -    } else {
> -        counter->mhpmcounter_val++;
>      }
>  
>      return 0;
> @@ -224,8 +235,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>                                          uint32_t target_ctr)
>  {
>      RISCVCPU *cpu;
> -    uint32_t event_idx;
> -    uint32_t ctr_idx;
> +    uint32_t ctr_mask;
>  
>      /* Fixed instret counter */
>      if (target_ctr == 2) {
> @@ -237,21 +247,15 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>          return false;
>      }
>  
> -    event_idx = RISCV_PMU_EVENT_HW_INSTRUCTIONS;
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(event_idx)));
> -    if (!ctr_idx) {
> -        return false;
> -    }
> -
> -    return target_ctr == ctr_idx ? true : false;
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu,
> +                                            RISCV_PMU_EVENT_HW_INSTRUCTIONS);
> +    return (ctr_mask & BIT(target_ctr)) != 0;
>  }
>  
>  bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>  {
>      RISCVCPU *cpu;
> -    uint32_t event_idx;
> -    uint32_t ctr_idx;
> +    uint32_t ctr_mask;
>  
>      /* Fixed mcycle counter */
>      if (target_ctr == 0) {
> @@ -263,22 +267,23 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>          return false;
>      }
>  
> -    event_idx = RISCV_PMU_EVENT_HW_CPU_CYCLES;
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(event_idx)));
> -
> -    /* Counter zero is not used for event_ctr_map */
> -    if (!ctr_idx) {
> -        return false;
> -    }
> -
> -    return (target_ctr == ctr_idx) ? true : false;
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu,
> +                                            RISCV_PMU_EVENT_HW_CPU_CYCLES);
> +    return (ctr_mask & BIT(target_ctr)) != 0;
>  }
>  
> -static gboolean pmu_remove_event_map(gpointer key, gpointer value,
> -                                     gpointer udata)
> +static bool riscv_pmu_event_supported(uint32_t event_idx)
>  {
> -    return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? true : false;
> +    switch (event_idx) {
> +    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
> +    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
> +    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
> +    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> +    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
> +        return true;
> +    default:
> +        return false;
> +    }
>  }
>  
>  static int64_t pmu_icount_ticks_to_ns(int64_t value)
> @@ -294,48 +299,32 @@ static int64_t pmu_icount_ticks_to_ns(int64_t value)
>      return ret;
>  }
>  
> -int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
> -                               uint32_t ctr_idx)
> +void riscv_pmu_rebuild_event_map(CPURISCVState *env)
>  {
> -    uint32_t event_idx;
> +    uint32_t ctr_idx, ctr_mask, event_idx;
>      RISCVCPU *cpu = env_archcpu(env);
>  
> -    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
> -        return -1;
> +    if (!cpu->pmu_event_ctr_map) {
> +        return;
>      }
>  
> -    /*
> -     * Expected mhpmevent value is zero for reset case. Remove the current
> -     * mapping.
> -     */
> -    if (!(value & MHPMEVENT_IDX_MASK)) {
> -        g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
> -                                    pmu_remove_event_map,
> -                                    GUINT_TO_POINTER(ctr_idx));
> -        return 0;
> -    }
> +    g_hash_table_remove_all(cpu->pmu_event_ctr_map);
> +    for (ctr_idx = 3; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
> +        if (!riscv_pmu_counter_valid(cpu, ctr_idx)) {
> +            continue;
> +        }
>  
> -    event_idx = value & MHPMEVENT_IDX_MASK;
> -    if (g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                            GUINT_TO_POINTER(event_idx))) {
> -        return 0;
> -    }
> +        event_idx = env->mhpmevent_val[ctr_idx] & MHPMEVENT_IDX_MASK;
> +        if (!event_idx || !riscv_pmu_event_supported(event_idx)) {
> +            continue;
> +        }
>  
> -    switch (event_idx) {
> -    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
> -    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
> -    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
> -    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> -    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
> -        break;
> -    default:
> -        /* We don't support any raw events right now */
> -        return -1;
> +        ctr_mask = riscv_pmu_event_counter_mask(cpu, event_idx);
> +        ctr_mask |= BIT(ctr_idx);
> +        g_hash_table_insert(cpu->pmu_event_ctr_map,
> +                            GUINT_TO_POINTER(event_idx),
> +                            GUINT_TO_POINTER(ctr_mask));
>      }
> -    g_hash_table_insert(cpu->pmu_event_ctr_map, GUINT_TO_POINTER(event_idx),
> -                        GUINT_TO_POINTER(ctr_idx));
> -
> -    return 0;
>  }
>  
>  static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
> @@ -348,23 +337,14 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
>      }
>  }
>  
> -static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> -                                  enum riscv_pmu_event_idx evt_idx)
> +static void pmu_timer_trigger_irq_counter(RISCVCPU *cpu, uint32_t ctr_idx)
>  {
> -    uint32_t ctr_idx;
>      CPURISCVState *env = &cpu->env;
>      PMUCTRState *counter;
>      int64_t irq_trigger_at;
>      uint64_t curr_ctr_val, curr_ctrh_val;
>      uint64_t ctr_val;
>  
> -    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
> -        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> -        return;
> -    }
> -
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(evt_idx)));
>      if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
>          return;
>      }
> @@ -408,6 +388,26 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>      }
>  }
>  
> +static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> +                                  enum riscv_pmu_event_idx evt_idx)
> +{
> +    uint32_t ctr_idx;
> +    uint32_t ctr_mask;
> +
> +    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
> +        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> +        return;
> +    }
> +
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu, evt_idx);
> +
> +    while (ctr_mask) {
> +        ctr_idx = ctz32(ctr_mask);
> +        ctr_mask &= ~BIT(ctr_idx);
> +        pmu_timer_trigger_irq_counter(cpu, ctr_idx);
> +    }
> +}
> +
>  /* Timer callback for instret and cycle counter overflow */
>  void riscv_pmu_timer_cb(void *priv)
>  {
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index 2429c01b776693ebb324ed63fee1feb56c821c21..910091690290cac9f77855f479bb9d90b2762efe 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -28,8 +28,7 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
>                                    uint32_t target_ctr);
>  void riscv_pmu_timer_cb(void *priv);
>  void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
> -int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
> -                               uint32_t ctr_idx);
> +void riscv_pmu_rebuild_event_map(CPURISCVState *env);
>  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
>  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>  int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
> diff --git a/tests/tcg/riscv64/sscofpmf-overflow.S b/tests/tcg/riscv64/sscofpmf-overflow.S
> index 97f03037bbfdd44f2288b257afb91499e4534f13..69626831344fe78317c3ca4b743c15ccf11b44b5 100644
> --- a/tests/tcg/riscv64/sscofpmf-overflow.S
> +++ b/tests/tcg/riscv64/sscofpmf-overflow.S
> @@ -6,14 +6,18 @@
>  	.text
>  	.global _start
>  _start:
> -	/* Program hpmcounter3 while no event is selected. */
> +	/* Program counters 3 and 4 while no event is selected. */
>  	csrw	mhpmevent3, zero
>  	li	t0, -256
>  	csrw	mhpmcounter3, t0
> +	csrw	mhpmevent4, zero
> +	li	t0, -512
> +	csrw	mhpmcounter4, t0
>  
> -	/* Start counting retired instructions with overflow enabled. */
> +	/* Count the same event in both counters with overflow enabled. */
>  	li	t0, 2
>  	csrw	mhpmevent3, t0
> +	csrw	mhpmevent4, t0
>  
>  	/* Cross the 64-bit unsigned overflow boundary. */
>  	.rept	1024
> @@ -26,6 +30,10 @@ _start:
>  	srli	t1, t0, 63
>  	xori	t1, t1, 1
>  	or	t4, t4, t1
> +	csrr	t0, mhpmevent4
> +	srli	t1, t0, 63
> +	xori	t1, t1, 1
> +	or	t4, t4, t1
>  
>  	csrr	t0, mip
>  	li	t1, 1 << 13
> @@ -34,12 +42,68 @@ _start:
>  	xori	t0, t0, 1
>  	or	t4, t4, t0
>  
> -	/* The counter wraps and continues counting after overflow. */
> +	/* Both counters wrap and continue counting after overflow. */
>  	csrr	t0, mhpmcounter3
>  	li	t1, -256
>  	sltu	t0, t0, t1
>  	xori	t0, t0, 1
>  	or	t4, t4, t0
> +	csrr	t0, mhpmcounter4
> +	li	t1, -512
> +	sltu	t0, t0, t1
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
> +
> +	/* After selecting write misses, read misses must not increment HPM3. */
> +	csrw	mhpmevent3, zero
> +	csrw	mhpmcounter3, zero
> +	li	t0, 0x10019		/* DTLB read miss */
> +	csrw	mhpmevent3, t0
> +	li	t0, 0x1001b		/* DTLB write miss */
> +	csrw	mhpmevent3, t0
> +	sfence.vma
> +	lla	t2, stale_probe
> +	lw	t3, 0(t2)
> +	csrr	t0, mhpmcounter3
> +	or	t4, t4, t0
> +
> +	/* Both counters must count a DTLB read miss. */
> +	csrw	mhpmevent3, zero
> +	csrw	mhpmevent4, zero
> +	csrw	mhpmcounter3, zero
> +	csrw	mhpmcounter4, zero
> +	li	t0, 0x10019		/* DTLB read miss */
> +	csrw	mhpmevent3, t0
> +	csrw	mhpmevent4, t0
> +	sfence.vma
> +	lla	t2, tlb_probe
> +	lw	t3, 0(t2)
> +	csrr	t0, mhpmcounter3
> +	csrr	t1, mhpmcounter4
> +	sltu	t2, zero, t0
> +	xori	t2, t2, 1
> +	or	t4, t4, t2
> +	sltu	t2, zero, t1
> +	xori	t2, t2, 1
> +	or	t4, t4, t2
> +	xor	t0, t0, t1
> +	sltu	t0, zero, t0
> +	or	t4, t4, t0
> +
> +	/* Disabling HPM3 must leave HPM4 counting the same event. */
> +	csrr	t5, mhpmcounter3
> +	csrr	t6, mhpmcounter4
> +	csrw	mhpmevent3, zero
> +	sfence.vma
> +	lla	t2, tlb_probe2
> +	lw	t3, 0(t2)
> +	csrr	t0, mhpmcounter3
> +	xor	t0, t0, t5
> +	or	t4, t4, t0
> +	csrr	t0, mhpmcounter4
> +	sltu	t0, t6, t0
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
>  
>  	lla	a1, semiargs
>  	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> @@ -55,6 +119,16 @@ _start:
>  	j	.
>  
>  	.data
> +	/* Give each DTLB probe a separate page. */
> +	.balign	4096
> +stale_probe:
> +	.word	0
> +	.balign	4096
> +tlb_probe:
> +	.word	0
> +	.balign	4096
> +tlb_probe2:
> +	.word	0
>  	.balign	16
>  semiargs:
>  	.space	16
> 
> -- 
> 2.43.0
> 

