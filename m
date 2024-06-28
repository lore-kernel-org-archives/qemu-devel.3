Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B20C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6w8-0004to-B0; Fri, 28 Jun 2024 04:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sN6w6-0004tW-Us
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:26:26 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sN6w5-0003vV-1f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719563185; x=1751099185;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AxngDi/BF28G/cnGg9jFCycZ0ac3zX0cBZrYCHU9I3o=;
 b=kkOgJdJh68tdn+Q1xyBH+imWEzf+OR5j3unms1WI4WvU/UjD9VpeQOOo
 spux5TFQg59MSyHkIHoXIO87lu30WBFWV7xCmayKjAObKDQ4/joCBzAze
 H9cbcVSkt2aSwzkZwqxp02o0vhsldO4jaKrSUTJdZMS9qPMkZRPk1JUcm
 dYohfSJi7n3zTfzBntGhLWLMh3G8ODifb3BLXNFaNTsVIZQ3SyqBMDYsM
 vHXqdWqvz+QQE2dgBKreMy/Pf7QBo6mN805kyAKTFqjwXu2V5lj/KhAfQ
 3kUExHnatFTVCZg2P+ZSKN2sE8CCambur+DOK7kbCj1J80VmYRN6a/S/O w==;
X-CSE-ConnectionGUID: FXI7k2+kQwiYRO1wt5X6sA==
X-CSE-MsgGUID: 0sWnj0wKRoKRncCTgz0c8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16867131"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="16867131"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 01:26:19 -0700
X-CSE-ConnectionGUID: KGzATud1QmCgjH1ydCTs/A==
X-CSE-MsgGUID: C9TRRNUySnmmJAy1ZVO7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="44776318"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 01:26:19 -0700
Message-ID: <0c7a10c6-c222-4677-9c34-fc9b5600d8e6@intel.com>
Date: Fri, 28 Jun 2024 16:26:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/i386: pass X86CPU to
 x86_cpu_get_supported_feature_word
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: John Allen <john.allen@amd.com>
References: <20240627140628.1025317-1-pbonzini@redhat.com>
 <20240627140628.1025317-2-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240627140628.1025317-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.505, HK_RANDOM_FROM=0.457, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/27/2024 10:06 PM, Paolo Bonzini wrote:
> This allows modifying the bits in "-cpu max"/"-cpu host" depending on
> the guest CPU vendor (which, at least by default, is the host vendor in
> the case of KVM).
> 
> For example, machine check architecture differs between Intel and AMD,
> and bits from AMD should be dropped when configuring the guest for
> an Intel model.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: John Allen <john.allen@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.h         |  3 +--
>   target/i386/cpu.c         | 13 ++++++-------
>   target/i386/kvm/kvm-cpu.c |  2 +-
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 29daf370485..9bea7142bf4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -666,8 +666,7 @@ typedef enum FeatureWord {
>   } FeatureWord;
>   
>   typedef uint64_t FeatureWordArray[FEATURE_WORDS];
> -uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
> -                                            bool migratable_only);
> +uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   
>   /* cpuid_features bits */
>   #define CPUID_FP87 (1U << 0)
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4c2e6f3a71e..deb58670651 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6035,8 +6035,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>   
>   #endif /* !CONFIG_USER_ONLY */
>   
> -uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
> -                                            bool migratable_only)
> +uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
>   {
>       FeatureWordInfo *wi = &feature_word_info[w];
>       uint64_t r = 0;
> @@ -6076,9 +6075,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>               ? CPUID_EXT2_LM & ~CPUID_EXT2_KERNEL_FEATURES
>               : CPUID_EXT2_LM;
>           r &= ~unavail;
> -    }
> +        break;

It seems some leftover when spliting from next patch. Need to remove it.

Other than it,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

>   #endif
> -    if (migratable_only) {
> +    if (cpu && cpu->migratable) {
>           r &= x86_cpu_get_migratable_flags(w);
>       }
>       return r;
> @@ -7371,7 +7370,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>                * by the user.
>                */
>               env->features[w] |=
> -                x86_cpu_get_supported_feature_word(w, cpu->migratable) &
> +                x86_cpu_get_supported_feature_word(cpu, w) &
>                   ~env->user_features[w] &
>                   ~feature_word_info[w].no_autoenable_flags;
>           }
> @@ -7497,7 +7496,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>   
>       for (w = 0; w < FEATURE_WORDS; w++) {
>           uint64_t host_feat =
> -            x86_cpu_get_supported_feature_word(w, false);
> +            x86_cpu_get_supported_feature_word(NULL, w);
>           uint64_t requested_features = env->features[w];
>           uint64_t unavailable_features = requested_features & ~host_feat;
>           mark_unavailable_features(cpu, w, unavailable_features, prefix);
> @@ -7617,7 +7616,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>           env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
>       if (requested_lbr_fmt && kvm_enabled()) {
>           uint64_t host_perf_cap =
> -            x86_cpu_get_supported_feature_word(FEAT_PERF_CAPABILITIES, false);
> +            x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
>           unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
>   
>           if (!cpu->enable_pmu) {
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index f9b99b5f50d..b2735d6efee 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -136,7 +136,7 @@ static void kvm_cpu_xsave_init(void)
>           if (!esa->size) {
>               continue;
>           }
> -        if ((x86_cpu_get_supported_feature_word(esa->feature, false) & esa->bits)
> +        if ((x86_cpu_get_supported_feature_word(NULL, esa->feature) & esa->bits)
>               != esa->bits) {
>               continue;
>           }


