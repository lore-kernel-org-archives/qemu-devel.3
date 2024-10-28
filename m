Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622E0D33994
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RQa-0006A6-5D; Mon, 28 Oct 2024 11:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RQZ-00066Q-1w
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:13:07 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RQW-0008RY-Dp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730128385; x=1761664385;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fiSwUPIP/8AlXzfm1vfSSZGDFP1glHe0XbJjhW0k/PU=;
 b=nxaJ5NJh6OkfvLhaU6Xo5mSZZt7WGrvWF8RfhuYBByZ/JS5tVHp3TIzH
 e+6VGO7VhCYW+ezJSDZXjdkCpUujev0BanjI8D4aIKRKRjey8KOolXSa8
 SExc/aDA1zaqGNZK5COUbqis59nwzYi0mLb0wGy/vAsLI48pJZvKpK8cl
 5S6djjvVVlA9TkG6PIgIqfCDDJ45y6yFZxHGHC2uIuEdInFiMPAmHagRo
 IquzkuBNbJm0t4MFPUsKAcqaLHlWAIk71xSGYFqEDENyfDzPyakQVTbxe
 d+JwdI73+JXzzdjXy5HddnM4Yswc+sv+OKh4HqXrpwwQWOaEKeXPNBDdC Q==;
X-CSE-ConnectionGUID: UdkpcE9PQWGJ9zELXp54kQ==
X-CSE-MsgGUID: tUzd8BoxQX+rZ5tyYXsOEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501522"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29501522"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:13:03 -0700
X-CSE-ConnectionGUID: vqqp+i5PTC6u+1bq8dWWBA==
X-CSE-MsgGUID: CP5bL9lISVie99CLzTglvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="81808399"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.172])
 ([10.124.227.172])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:13:01 -0700
Message-ID: <dfeedc51-7dc1-4a36-a790-7c2863c9d4c7@intel.com>
Date: Mon, 28 Oct 2024 23:12:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/i386: Add AVX512 state when AVX10 is supported
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-2-tao1.su@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241028024512.156724-2-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.782, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/28/2024 10:45 AM, Tao Su wrote:
> AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
> are identical to AVX512 state regardless of the supported vector lengths.
> 
> Given that some E-cores will support AVX10 but not support AVX512, add
> AVX512 state components to guest when AVX10 is enabled.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 14 ++++++++++++++
>   target/i386/cpu.h |  2 ++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1ff1af032e..d845ff5e4e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7177,6 +7177,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>           }
>           if (env->features[esa->feature] & esa->bits) {
>               xcr0 |= 1ull << i;
> +            continue;
> +        }
> +        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
> +            i == XSTATE_Hi16_ZMM_BIT) {
> +            if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +                xcr0 |= 1ull << i;
> +            }
>           }
>       }
>   
> @@ -7315,6 +7322,13 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>           const ExtSaveArea *esa = &x86_ext_save_areas[i];
>           if (env->features[esa->feature] & esa->bits) {
>               mask |= (1ULL << i);
> +            continue;
> +        }
> +        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
> +            i == XSTATE_Hi16_ZMM_BIT) {
> +            if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +                mask |= (1ULL << i);
> +            }
>           }
>       }
>   
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 74886d1580..280bec701c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -972,6 +972,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
>   /* PREFETCHIT0/1 Instructions */
>   #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
> +/* Support for Advanced Vector Extensions 10 */
> +#define CPUID_7_1_EDX_AVX10             (1U << 19)
>   /* Flexible return and event delivery (FRED) */
>   #define CPUID_7_1_EAX_FRED              (1U << 17)
>   /* Load into IA32_KERNEL_GS_BASE (LKGS) */


