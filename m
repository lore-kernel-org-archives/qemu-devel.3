Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EACDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 03:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJOo6-00023u-Ke; Sun, 25 May 2025 23:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJOo5-00023Y-OD
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:47:21 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJOo3-0006ip-V2
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748231240; x=1779767240;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=M8fd+7H+SSosSL6WN4aVt/90iL0KMKW1xgfwT7ne6us=;
 b=MGeCa6Oh+h50vQ/Q/Njn9KhDbYhze4k4thTu+dELKpQCnWQoDcgxxqjJ
 SG4i0vWIk1faANDkRC6CeVzYfr47IZm4ZPHcAC8tsFTM5Mpwa+1DD/Leo
 +WiRSOrQZQ/q/OEIDStmit1Bc9YitM5DXXiVfIY39tPOh/gIqseXKkx1J
 uA7HuaeZiAF+7uNVxFmod0odO73XNQDLYVdy3d4QQuQ5SLM0Hkwlkfymd
 2FlptH4ImVlP8IPfZsEDYc0xkXo1NnZXVjg+BlgLE7/gyk+MvOCzxJSJp
 9Z/n85LtRaEhXOGR+Xp/NLUs/7Cjtvj8tOiwafalbjYOjCBYucbon+qhS w==;
X-CSE-ConnectionGUID: vYLuo2MaTimj2WQke+477Q==
X-CSE-MsgGUID: P7KdYj64QDmkz0CVPJ+naw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="60855579"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="60855579"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:47:18 -0700
X-CSE-ConnectionGUID: 43mypmiNQ76ObrrdGDolCQ==
X-CSE-MsgGUID: 2nK+3kTKT3m5FW6GN+iSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="147034492"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:47:15 -0700
Message-ID: <859d17d7-2f5f-456c-887e-7a50134a205d@intel.com>
Date: Mon, 26 May 2025 11:47:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] target/i386: Add a new CPU feature word for
 CPUID.7.1.ECX
To: "Xin Li (Intel)" <xin@zytor.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xin3.li@intel.com
References: <20250103084827.1820007-1-xin@zytor.com>
 <20250103084827.1820007-3-xin@zytor.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250103084827.1820007-3-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/3/2025 4:48 PM, Xin Li (Intel) wrote:
> The immediate form of MSR access instructions will use this new CPU
> feature word.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>   target/i386/cpu.c | 23 ++++++++++++++++++++++-
>   target/i386/cpu.h |  1 +
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 8a1223acb3..2fb05879c3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -894,6 +894,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>   
>   #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
>             CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
> +#define TCG_7_1_ECX_FEATURES 0
>   #define TCG_7_1_EDX_FEATURES 0
>   #define TCG_7_2_EDX_FEATURES 0
>   #define TCG_APM_FEATURES 0
> @@ -1133,6 +1134,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           },
>           .tcg_features = TCG_7_1_EAX_FEATURES,
>       },
> +    [FEAT_7_1_ECX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,

This looks silly, and the size of feat_names[] was changed from 32 to 
64. Just explicitly assign the first 32 entries with NULL doesn't make 
any sense after the size change.

We can just merge the next patch into this one and make it,

	.feat_names = {
	    [5] = "msr-imm",
	},

> +        },
> +        .cpuid = {
> +            .eax = 7,
> +            .needs_ecx = true, .ecx = 1,
> +            .reg = R_ECX,
> +        },
> +        .tcg_features = TCG_7_1_ECX_FEATURES,
> +    },
>       [FEAT_7_1_EDX] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
> @@ -6659,9 +6679,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
>           } else if (count == 1) {
>               *eax = env->features[FEAT_7_1_EAX];
> +            *ecx = env->features[FEAT_7_1_ECX];
>               *edx = env->features[FEAT_7_1_EDX];
>               *ebx = 0;
> -            *ecx = 0;
>           } else if (count == 2) {
>               *edx = env->features[FEAT_7_2_EDX];
>               *eax = 0;
> @@ -7563,6 +7583,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
>           x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
>           x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
> +        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
>           x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
>           x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
>           x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index dbd8f1ffc7..d23fa96549 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -667,6 +667,7 @@ typedef enum FeatureWord {
>       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
>       FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
> +    FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */

I would prefer the newly added leaf being ordered at least in the same 
leaf. i.e.,

@@ -661,6 +661,7 @@ typedef enum FeatureWord {
      FEAT_SGX_12_1_EAX,  /* CPUID[EAX=0x12,ECX=1].EAX (SGX 
ATTRIBUTES[31:0]) */
      FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
      FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
+    FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
      FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
      FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
      FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */

They are QEMU internally data, injecting a new one instead of putting it 
at the end is OK to me.

>       FEATURE_WORDS,
>   } FeatureWord;
>   


