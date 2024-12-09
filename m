Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E74E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 03:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKUad-0001oS-Nz; Sun, 08 Dec 2024 22:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tKUab-0001oB-HB
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 22:37:41 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tKUaY-0004Xg-VS
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 22:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733715459; x=1765251459;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EAyRheK5nB8umnuy+TRGE4FKR9ahxBxN6eDqj0C1fbc=;
 b=Eyeq2N4LuZYP3xDsCpLf6ajP/h0brFuxXLAhpLJmPcrdlzCbh9ro6a/v
 9NyAqG75pW1QhmcNOQkqHAYmfafC+1Z+82XMLM9jjHrkqZVyy9qFis3QE
 NlDaGegwvQ4Tk+Dj34CBOEDkWa/SJArt3EOIejU6IuKd0q54qgeu5G3lE
 sWA5o8xXapieOpERWlBC21FviMOAS1GsHHIaB9VgqNx3kosKOt+eGr/gH
 /C+nrGgORAVSL+GX92o2cbvN/GM0K6Ou7jfEbTN4Du6hJteU30JhNnxNj
 aYXwEFfpxnHtSONBBD3He3ruTdhHslQUCts2IfEzn738leCG4G6sCNYJ0 Q==;
X-CSE-ConnectionGUID: QmPPVVmcRey1BaYWuAM3/g==
X-CSE-MsgGUID: 9lbW2W8MSq+sS0fUY8o84Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="51413019"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; d="scan'208";a="51413019"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2024 19:37:34 -0800
X-CSE-ConnectionGUID: qe3xPZhVRkG5LN0t8c7aGA==
X-CSE-MsgGUID: Pd1WQzG2QQKdImekzOXagQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; d="scan'208";a="95422784"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2024 19:37:32 -0800
Message-ID: <b1bb0122-b738-4ecb-a40e-29b9a0646da2@intel.com>
Date: Mon, 9 Dec 2024 11:37:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] i386: Add RDT feature flags.
To: Hendrik Wuethrich <whendrik@google.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, richard.henderson@linaro.org,
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com
References: <20241205200025.2081863-1-whendrik@google.com>
 <20241205200025.2081863-7-whendrik@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241205200025.2081863-7-whendrik@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/6/2024 4:00 AM, Hendrik Wuethrich wrote:
> From: ‪Hendrik Wüthrich <whendrik@google.com>
> 
> Add RDT features to feature word / TCG.
> 
> Signed-off-by: Hendrik Wüthrich <whendrik@google.com>
> ---
>   target/i386/cpu.c | 30 ++++++++++++++++++++++++++++--
>   target/i386/cpu.h |  2 ++
>   2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index bbe2da8ebb..5e29bf341c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -869,7 +869,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>             CPUID_7_0_EBX_CLFLUSHOPT |            \
>             CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
>             CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED | \
> -          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
> +          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES | \
> +          CPUID_7_0_EBX_PQM | CPUID_7_0_EBX_PQE)
>             /* missing:
>             CPUID_7_0_EBX_HLE
>             CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
> @@ -906,6 +907,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>   #define TCG_SGX_12_0_EBX_FEATURES 0
>   #define TCG_SGX_12_1_EAX_FEATURES 0
>   #define TCG_24_0_EBX_FEATURES 0
> +#define TCG_RDT_15_0_EDX_FEATURES CPUID_15_0_EDX_L3
>   
>   #if defined CONFIG_USER_ONLY
>   #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
> @@ -1063,7 +1065,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "fsgsbase", "tsc-adjust", "sgx", "bmi1",
>               "hle", "avx2", "fdp-excptn-only", "smep",
>               "bmi2", "erms", "invpcid", "rtm",
> -            NULL, "zero-fcs-fds", "mpx", NULL,
> +            "rdt-m", "zero-fcs-fds", "mpx", "rdt-a",
>               "avx512f", "avx512dq", "rdseed", "adx",
>               "smap", "avx512ifma", "pcommit", "clflushopt",
>               "clwb", "intel-pt", "avx512pf", "avx512er",
> @@ -1651,6 +1653,30 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           },
>           .tcg_features = TCG_SGX_12_1_EAX_FEATURES,
>       },
> +
> +    [FEAT_RDT_10_0_EBX] = {

Here 10 is hexadecimal, while ...

> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, "l3-cat", "l2-cat", "mba"
> +        },
> +        .cpuid = {
> +            .eax = 0x10,
> +            .needs_ecx = true, .ecx = 0,
> +            .reg = R_EBX,
> +        }
> +    },
> +    [FEAT_RDT_15_0_EDX] = {

... 15 is decimal, please make them consistent.

> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            [1] = "l3-cmt"
> +        },
> +        .cpuid = {
> +            .eax = 0xf,
> +            .needs_ecx = true, .ecx = 0,
> +            .reg = R_EDX,
> +        },
> +        .tcg_features = TCG_RDT_15_0_EDX_FEATURES,
> +    },
>   };
>   
>   typedef struct FeatureMask {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 98407c8e18..37dc451e39 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -678,7 +678,9 @@ typedef enum FeatureWord {
>       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
>       FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
> +    FEAT_RDT_15_0_EBX,  /* CPUID[EAX=0xf,ECX=0].EBX (RDT CMT/MBM) */
>       FEAT_RDT_15_0_EDX,  /* CPUID[EAX=0xf,ECX=0].EDX (RDT CMT/MBM) */
> +    FEAT_RDT_10_0_EBX,  /* CPUID[EAX=0x10,ECX=0].EBX (RDT CAT/MBA) */
>       FEATURE_WORDS,
>   } FeatureWord;
>   


