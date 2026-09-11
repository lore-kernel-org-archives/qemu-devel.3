Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E26C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4sMk-0002vS-G4; Thu, 10 Sep 2026 23:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sMO-0002ol-36; Thu, 10 Sep 2026 23:55:34 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sMK-0008PA-47; Thu, 10 Sep 2026 23:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxoigvvjGvzPrJQHoERmAhl4t8hSQbxtwd2UGNAYdsdFVtkRwQptHg50ibIvdvfTrHGOQs1QiMMUoARCbUntguPbd2oiucUwClOfQTatxytOSEgmHriUQaYXWbSeL9We0/1fw4nAhG5N7ojptFuOES1/mWr2ANBzOEio5wvV5rRjL/zKdmpkWUi2lxIcft57iYKVMfz2Poh5p0tstJwhwJIPbsd+TWviK6JGCNjREWpXt3ZiFzLm2T7ltCRvxcgthY/fosU0xNFAAXD3/jVc5rs3gY/qn9TXQ5V7dOkJUdiJNHkwhrHdjvnuetILgc32XZSKke5JJ1jvIrtBTSAF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzJJHHAwO7fLJl2P8j4V6T7ZJ0RsNAzzNT8Id0fyY6s=;
 b=ZHsISEDe++O3dlf8RPYyvCiOg+ElzGkjKjyuSvT0nW9UthvK/ZXJv2rl3IuS+44raToZ/TGdgD3UJudsnO9ZWTmgb7a4pL8vaSRM82EvfppyQzUY2fLq8/dM7XgODJJ199XtDZRLjHllSBH0klOIZ3S31ZnOuZf/bxVUnIjGFH7A9UYI2n7sREAxAzXXz59AGAKGF4fkceu8kZBexsLf1cRwUje4UPrdDvpNsDdc89biyPT60T5H7i/sSf7ZbG/HZ4VL0iwJyhkwXk8ZVMK4SJJNB8gebPRZpBsA5mBvVFHAt1OgDvMp12PJLkbpOQYc5RDlRllR5ibhivXWfOyC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzJJHHAwO7fLJl2P8j4V6T7ZJ0RsNAzzNT8Id0fyY6s=;
 b=JRpb5CqaINrvXXizgf3kyLuTX8JHAzSCQi/uN/dUgBtVS2X2MEp+4sJ319x5fNXgtmOmlfcr/zZa9oof4ODrzYEKTGLe+qN6tDeN4LOvgH2x/ozHiVzBxZDDmRj7xwxsO+4xkBT5mqDU/UfSsf4GMmlAVpuIzZnuom61I84h5rT6NEQp6XWC/RUseDgTxFPDSAsGJfgjWK5rDYzJUu0epz5pQ6ZaBYZrbAZqo0D1TReJ35aRKhwzRiNzzN872QfFHW3kaxcMOE64XEVGOf8HIUJ63v9eUc1jf/z5tp+Vqcbo+1rzBsDY0M/3RGbNZjIFNPA0njzj6UWj8PyUE6JlsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6454.apcprd02.prod.outlook.com (2603:1096:820:cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 03:55:22 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 03:55:22 +0000
Date: Fri, 11 Sep 2026 11:55:16 +0800
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
Subject: Re: [PATCH v2 03/14] target/riscv: Use VM-elapsed sources for fixed
 PMU events
Message-ID: <aqN7nJh8RdKYNte6@MacBook-Pro-4.local>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-3-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-riscv-pmu-correctness-v2-3-5da5159a0c64@linux.alibaba.com>
X-ClientProxiedBy: PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ef7fc7-10cf-4ff7-e9a8-08df0fb880eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|6133799003|3023799007|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 70ieb/ZP+ybAL7fef8nSZ7ukhIT7BWe+slqf+IM/yc2Uc8ZKf/c0T9MvpwN/P3HdyAOL5wjMk/VBB2E7km43QMK4OJvrktgUMQnoHYhY1TjcYBFs7OhzfN1H8OXdLpR6LTJgeiEZB89mPcggmWspJtWahsClLM9LFWauklcyok5TxlHjgsfrMGJO05dEatAbieOXBZTL2i5HQzmKiRVH+vOz5Bl37/5rVzmXgWvI4bsilIgv8AFwLTBshwa4L/TrOqz6pW35nT10uJVbTH/C2lVLnEsiII19WdS+XgIyIOhCNk07Oms1oBuSSiFahZaMSGGGXVYPQ9hoRpyQq3d58LUpjmYqJi2666iQ29jRsvAgqdMaaHtlZ3nEuyAtxOgtKv3mlELecJ00XgD3jxuqD+/SWZkL+m3uaMP7FW41UPr89E38iPmHk/dY1hC8wxf6vj9mO2Ah9zD318SrWTar60Fp5IVvWRvBckbhCuArJmK2G+3c858Ojv6XijhKy8XPmZHS4bmYODhdSPmKoNX8RiTXwnSgz0KEI2puNNVsK7RaUxoRg+LaMG1AujXPfCdLrngoBX1KlO4NVo3eAWQJ2GTeRrH3sPKPGmTIepIq6XY/s4CdITCyrm3fDdhzBYElSVStOFQzl+EB2BxaY1n+gbLre9CrikTzGKqF2u/6WDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzjJLdWpifn52M8g289K2rmsP3AB2XPcF4BliTEGuPrfKHCb4BAQFBzdUIEj?=
 =?us-ascii?Q?BWS3mu+oHy3EZo2tX2bELrN9sXa5P+OkqI936Yp9EXmQ4zGPjXq2kZmmHr04?=
 =?us-ascii?Q?0bGKiJXicInTKrXzUJ3sLfQs3z3gHG6pJ2uIh0ig/o8buq7vpMK7L/aKP7Wu?=
 =?us-ascii?Q?eP7jjnRlqVXHBMKt6lDG+Q6adYVMzAntjLYfc8LZSg6Ged1RTC04jpXF/1l1?=
 =?us-ascii?Q?sovzgHyaEhDeMAz4S4HtPpSKlZuOahm8LphGMbOdpKYlqz5l4f8KkRgeh6Ns?=
 =?us-ascii?Q?sAGqj4IKZoVwHfmbwgUzqvSeoFAml00C0M9PvFhL4mHGhenIoQsb3NMNVN4J?=
 =?us-ascii?Q?D0HFREXhONMoeRCHnPTyx0wWbasY+RKV+BaxYjDs9o7W2CX7V0wiDN8WTJ5F?=
 =?us-ascii?Q?T7HMsxq5CMcNfM/IuhI3qm2270QnLJyKr/tJdOE8T9tSHDvrh6hasEcaCkd+?=
 =?us-ascii?Q?+bg0VWPrEnjMSQbtg8R3MErCjzSSMKpxy/WKeraYtTzj0GboXbKJZPzWJ9Vd?=
 =?us-ascii?Q?RmB+roeRdtl26U2cBDPSYXqMi2JKFOtIw7AIBaiz7Mfwl1dfY2EI4OkFPnsI?=
 =?us-ascii?Q?sGbfbB9TsPPGwUIh0mU/nxLggMMx1D83iAhtfR5G+w+KYmVDO40951cf+ihN?=
 =?us-ascii?Q?MdjMeOwKWCZuFPEHQLP3g3Q/MnmJp9RMjb3DSrcTfdJ92fjBiXJoBeFtODu4?=
 =?us-ascii?Q?Yt5UPZud7S0PJwzTNEDX4sR2z03HTGQ6idwuwPIMe3/9Pgm+U8jsAbkv3WDZ?=
 =?us-ascii?Q?kBpWyfp0Y6gxEUt6H3G5L3ScugdgBGI0ggNfGlBdirMaYuaZ47KU12A5SlhS?=
 =?us-ascii?Q?KI/jgEtKLAa6aU6sO5dhCfz5o32K4TXd8ArQdzsiuhOE96BXUxBZz/CDkgFq?=
 =?us-ascii?Q?EYGOeh6ERV8uRDvWySQgjvsKmBq/z7esrrp0VFmNXfiRRRk0bfK0xKp5txxe?=
 =?us-ascii?Q?2iB0c+k3wki/N0+AlRUBsuTPrGkAxhbvhvd2CvoVe58JM0pw+/tTix+uatY7?=
 =?us-ascii?Q?YYc/ZJaDVpabqdrerldxTdJoRC9keIVwDIrxmvS6gUHmYX2tcdKUhbBmcUrT?=
 =?us-ascii?Q?eRVy94PReCWvbAUeEYNjQOCdIjJLoGE0/FShsEXT4/2BYK7Jo24A9Pbu827j?=
 =?us-ascii?Q?ODuWFKkU7Og6CY5qfDV1Vj4f5AnhGHRo2b9yIaqVHgTmyhGNgzQZ/bdH3vBl?=
 =?us-ascii?Q?1eq90T54DGYFc2HFexzWJ2wl7BZfEbVptfuY6b5Y7IefsYEPjfSmQrK0ZAnK?=
 =?us-ascii?Q?6G66q5tmFx+hrptH8qEl46sO8q0Mr3spOPebmT6t4CAIIzy+BuATCTy2wnad?=
 =?us-ascii?Q?vCrmPDF0lEYKjzQSinFp7L5i+lHAsnApYfGlS4Y1v3o9T+HJ4A7avCcZA3DC?=
 =?us-ascii?Q?FgOVVRUer4M9rIBfuux88tFt9PkTuqp4pCziWID2JbWPyhpQRyjyeDMH1Qra?=
 =?us-ascii?Q?4Rcpq06gInaQ2Zym6yGiu90USuYVQ2EIlAJukyhWBgD7UpDW19TniX4B4O60?=
 =?us-ascii?Q?HQPfdTPVEsh9U3xRbefAy5zH2q9qshNyXt37LDs0LUD9+hP+D9wgEX3UQKNr?=
 =?us-ascii?Q?1r5WbXMovA8B3Kx3YfNiwwnA5VpzF5xUcJunNmjH7jH6nlWqWNoc93RxPvhh?=
 =?us-ascii?Q?Xj2SZF1y4U/Y5lNRQZyIitVqgykXTL3mms5Ygl9Mb+Hl0InN9bYZTsvDxtnO?=
 =?us-ascii?Q?rnazXlLx8EKsg94TmVQL4rnsEx/bV0Vw4G8Gh15RnGgX6JfXSCcPxhe6zfsk?=
 =?us-ascii?Q?M8pxJ6pesWCwefrNs7dboPV5ththeLY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ef7fc7-10cf-4ff7-e9a8-08df0fb880eb
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 03:55:22.4745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMufE9RZzBhx+1gEF81h2gfhfOnHcy17N72uJlqdN37lM9AhGCGjRLOYxZMdnYTDFDNFQpt6OVhNPqOaj7ugG28INSO5wo3d25Kad6FEc0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6454
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

On Thu, Sep 10, 2026 at 10:39:40PM +0800, TANG Tiancheng wrote:
> Raw host ticks keep advancing while the VM is stopped. Use
> cpus_get_elapsed_ticks() for cycles and non-icount instruction counting,
> and retain icount_get_raw() for instructions under icount. Document that
> cpu_get_ticks() returns its stored value while VM ticks are disabled.
> 
> Under icount, cycles are already virtual nanoseconds. Convert only raw
> instruction counts when scheduling overflow, avoiding a second scaling
> of cycle distances. Add a cycle-overflow regression with icount shift=3.
> 
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg00668.html
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  system/cpu-timers.c                         |  4 +-
>  system/cpus.c                               |  6 +--
>  target/riscv/tcg/csr.c                      |  8 +---
>  target/riscv/tcg/pmu.c                      | 52 +++++++++++++++-----------
>  target/riscv/tcg/pmu.h                      |  1 +
>  tests/tcg/riscv64/sscofpmf-cycle-overflow.S | 58 +++++++++++++++++++++++++++++
>  tests/tcg/riscv64/system/meson.build        |  7 ++++
>  7 files changed, 103 insertions(+), 33 deletions(-)
> 
> diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> index 9919b46230f1caf8be1a1b6ef00acd94678437ce..0415636aff3f774f0de61fdac3969f5b45ae6993 100644
> --- a/system/cpu-timers.c
> +++ b/system/cpu-timers.c
> @@ -118,8 +118,8 @@ void cpu_enable_ticks(void)
>  }
>  
>  /*
> - * disable cpu_get_ticks() : the clock is stopped. You must not call
> - * cpu_get_ticks() after that.
> + * Freeze VM ticks. While disabled, cpu_get_ticks() returns the stored tick
> + * value instead of sampling the advancing host counter.
>   * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
>   */
>  void cpu_disable_ticks(void)
> diff --git a/system/cpus.c b/system/cpus.c
> index e11a5aab6a696962d94ad30ac38acd8867b1bf88..f61639ae78277fd90cbddb0b9f75b134e3cc1a17 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -237,9 +237,9 @@ void cpus_set_virtual_clock(int64_t new_time)
>  }
>  
>  /*
> - * return the time elapsed in VM between vm_start and vm_stop.  Unless
> - * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle
> - * counter.
> + * Return VM-elapsed ticks. While VM ticks are disabled, passage of host time
> + * does not advance the returned value. Unless icount is active, the units are
> + * those of the host CPU cycle counter.
>   */
>  int64_t cpus_get_elapsed_ticks(void)
>  {
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index d15a2d096cb6e13cd123ff9ae82ee7c643c2a961..60caee32dc0cf5b6a8492e0cf8ff15f71acc2087 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1327,13 +1327,7 @@ static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
>      }
>  
>      if (!cfg_val) {
> -        if (icount_enabled()) {
> -                curr_val = inst ? icount_get_raw() : icount_get();
> -        } else {
> -            curr_val = cpu_get_host_ticks();
> -        }
> -
> -        return curr_val;
> +        return riscv_pmu_read_fixed_source(env, inst);
>      }
>  
>      /* Update counter before reading. */
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index f19f417e90e33a94d00007ef132ef4e154175b19..ea0ffe41258d4dbef9dc952655e6301c14ba1d23 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -24,8 +24,14 @@
>  #include "pmu.h"
>  #include "exec/icount.h"
>  #include "system/device_tree.h"
> +#include "system/cpu-timers.h"
>  
> -#define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
> +/*
> + * cpu_get_ticks() does not expose the host tick frequency.  Use a 1 GHz
> + * approximation only when scheduling non-icount overflow checks; fixed
> + * counter values remain in host-tick units.
> + */
> +#define RISCV_PMU_HOST_TICK_HZ_ASSUMED 1000000000
>  
>  static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
>  {
> @@ -75,6 +81,19 @@ static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
>              (cfg & MHPMEVENT_BIT_UINH));
>  }
>  
> +/*
> + * VM-elapsed ticks stop advancing while VM ticks are disabled.  Under
> + * icount, instruction events retain raw instruction-count units.
> + */
> +uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret)
> +{
> +    if (instret && icount_enabled()) {
> +        return icount_get_raw();
> +    }
> +
> +    return cpus_get_elapsed_ticks();
> +}
> +
>  /*
>   * Information needed to update counters:
>   *  new_priv, new_virt: To correctly save starting snapshot for the newly
> @@ -96,11 +115,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVState *env,
>      uint64_t *counter_arr;
>      uint64_t delta;
>  
> -    if (icount_enabled()) {
> -        current_icount = icount_get_raw();
> -    } else {
> -        current_icount = cpu_get_host_ticks();
> -    }
> +    current_icount = riscv_pmu_read_fixed_source(env, true);
>  
>      if (env->virt_enabled) {
>          g_assert(env->priv <= PRV_S);
> @@ -137,11 +152,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
>      uint64_t *counter_arr;
>      uint64_t delta;
>  
> -    if (icount_enabled()) {
> -        current_ticks = icount_get();
> -    } else {
> -        current_ticks = cpu_get_host_ticks();
> -    }
> +    current_ticks = riscv_pmu_read_fixed_source(env, false);
>  
>      if (env->virt_enabled) {
>          g_assert(env->priv <= PRV_S);
> @@ -286,17 +297,15 @@ static bool riscv_pmu_event_supported(uint32_t event_idx)
>      }
>  }
>  
> -static int64_t pmu_icount_ticks_to_ns(int64_t value)
> +static int64_t pmu_ticks_to_ns(CPURISCVState *env, uint32_t ctr_idx,
> +                               int64_t value)
>  {
> -    int64_t ret = 0;
> -
> -    if (icount_enabled()) {
> -        ret = icount_to_ns(value);
> -    } else {
> -        ret = (NANOSECONDS_PER_SECOND / RISCV_TIMEBASE_FREQ) * value;
> +    if (icount_enabled() &&
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        return icount_to_ns(value);
>      }
>  
> -    return ret;
> +    return (NANOSECONDS_PER_SECOND / RISCV_PMU_HOST_TICK_HZ_ASSUMED) * value;
>  }
>  
>  void riscv_pmu_rebuild_event_map(CPURISCVState *env)
> @@ -448,8 +457,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
>  
>      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
> -        overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
> +        overflow_ns = pmu_ticks_to_ns(env, ctr_idx,
> +                                      (int64_t)overflow_delta);
> +        overflow_left = pmu_ticks_to_ns(env, ctr_idx, overflow_left);
>      } else {
>          return -1;
>      }
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index 910091690290cac9f77855f479bb9d90b2762efe..339a4b3ac09c4a91cddd9250824284203b16b4fa 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -26,6 +26,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>                                          uint32_t target_ctr);
>  bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
>                                    uint32_t target_ctr);
> +uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret);
>  void riscv_pmu_timer_cb(void *priv);
>  void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
>  void riscv_pmu_rebuild_event_map(CPURISCVState *env);
> diff --git a/tests/tcg/riscv64/sscofpmf-cycle-overflow.S b/tests/tcg/riscv64/sscofpmf-cycle-overflow.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..846d4651c4ee8f06df83bed85512ab9794552c28
> --- /dev/null
> +++ b/tests/tcg/riscv64/sscofpmf-cycle-overflow.S
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/* UINT64_MAX - 4095 leaves 4096 cycle increments until overflow. */
> +	csrw	mhpmevent3, zero
> +	li	t0, -4096
> +	csrw	mhpmcounter3, t0
> +	li	t0, 1
> +	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
> +	csrr	t1, mcycle
> +
> +1:
> +	csrr	t0, mhpmevent3
> +	beqz	t0, fail
> +	li	t2, 1
> +	slli	t2, t2, 63
> +	and	t0, t0, t2
> +	bnez	t0, pass
> +
> +	/*
> +	 * Allow 16384 cycles for OF to become visible. With shift=3, scaling
> +	 * the 4096-cycle distance twice would delay it to about 32768 cycles.
> +	 */
> +	csrr	t0, mcycle
> +	sub	t0, t0, t1
> +	li	t2, 16384
> +	bltu	t0, t2, 1b
> +
> +fail:
> +	li	a0, 1
> +	j	exit
> +
> +pass:
> +	li	a0, 0
> +
> +exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
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
> index ebe78200fd551b42d3c99ae19ca03803797f803d..668a9a76070b6f16087b08ea84683d883312e951 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -68,6 +68,13 @@ tests += {
>    },
>  }
>  
> +tests += {
> +  'sscofpmf-cycle-overflow.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', '-icount', 'shift=3', qemu_args],
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

