Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5562D33994
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RI3-00040O-Ia; Mon, 28 Oct 2024 11:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RI2-00040B-03
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:04:18 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RI0-0007Kj-3y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730127856; x=1761663856;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qx9SVCajdLTz8S81QXmNIF3I/bU3fxREmwfySjzT1uk=;
 b=WtbsE84H6vkDC6Cc2wJDn+DAQzHyWBHnNGxBi4oSA8j8HcEKofO9K2nm
 Ipfw4PgbCilg7DfYoBFqQWb6pG3faia/NToIUiOjAr9bEX4mYLrmtamw3
 BeIDgatX37QokCfU3X5cNnD2bBCrj7vZlzE87aEo8r7N1/y18vAw0gylO
 zioVjYg6bKZIX2O7evLjjFVxpVLxVyZlf+gdgYbg2sb2Jue1cx//8eZ45
 YyuPnxfzGKAvh29n09CVuMnBMCxlEsczx9JeWkUvvqglENGT67yIEAK1L
 ZTlO0r93mySfM77sLoEyjTxuxOb1R2L+PwSndIrW1fmpqkxfX4YfC3J4x g==;
X-CSE-ConnectionGUID: nhDx8UR1Qn2bkCpnTLionA==
X-CSE-MsgGUID: Lbhfs3SfRFKo2KtTn9h72A==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29158521"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="29158521"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:04:12 -0700
X-CSE-ConnectionGUID: PBlL2weyQYiFCTorvBgDig==
X-CSE-MsgGUID: IIO81g+OQt2eVmE6HQd2pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="81539501"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.172])
 ([10.124.227.172])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:04:09 -0700
Message-ID: <c9d9414c-41aa-4ee5-be23-9a12b9bb768d@intel.com>
Date: Mon, 28 Oct 2024 23:04:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/i386: Add CPUID.24 leaf for AVX10
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-4-tao1.su@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241028024512.156724-4-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
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
> When AVX10 enable bit is set, the 0x24 leaf will be present as "AVX10
> Converged Vector ISA leaf" containing fields for the version number and
> the supported vector bit lengths.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>   target/i386/cpu.c     | 40 ++++++++++++++++++++++++++++++++++++++++
>   target/i386/cpu.h     |  8 ++++++++
>   target/i386/kvm/kvm.c |  3 ++-
>   3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5b434a107a..91fae0dcb7 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -898,6 +898,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>   #define TCG_SGX_12_0_EAX_FEATURES 0
>   #define TCG_SGX_12_0_EBX_FEATURES 0
>   #define TCG_SGX_12_1_EAX_FEATURES 0
> +#define TCG_24_0_EBX_FEATURES 0
>   
>   #if defined CONFIG_USER_ONLY
>   #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
> @@ -1163,6 +1164,20 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           },
>           .tcg_features = TCG_7_2_EDX_FEATURES,
>       },
> +    [FEAT_24_0_EBX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            [16] = "avx10-128",
> +            [17] = "avx10-256",
> +            [18] = "avx10-512",
> +        },
> +        .cpuid = {
> +            .eax = 0x24,
> +            .needs_ecx = true, .ecx = 0,
> +            .reg = R_EBX,
> +        },
> +        .tcg_features = TCG_24_0_EBX_FEATURES,
> +    },
>       [FEAT_8000_0007_EDX] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
> @@ -6835,6 +6850,26 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           }
>           break;
>       }
> +    case 0x24: {
> +        *eax = 0;
> +        *ebx = 0;
> +        *ecx = 0;
> +        *edx = 0;
> +        if (!(env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
> +            break;
> +        }
> +
> +        if (count == 0) {
> +            uint8_t v = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x24,
> +                                                     0, R_EBX);
> +            if (env->avx10_version && env->avx10_version < v) {
> +                v = env->avx10_version;
> +            }

Here, if user specified avx10_version is >= kvm reported value, it uses 
KVM's reported value silently.

I think it's not good. It'd better to validate if user specified value 
can be satisfied or not, and emit a warning when not. e.g., in 
x86_cpu_filter_features() or in kvm_cpu_realizefn(). Also we can put the 
behavior along with it that "use KVM reported maximum value when 
avx10_version is 0 "

then, here we can simply do

	*ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;

> +            *ebx = env->features[FEAT_24_0_EBX] | v;
> +        }
> +        break;
> +    }
>       case 0x40000000:
>           /*
>            * CPUID code in kvm_arch_init_vcpu() ignores stuff
> @@ -7483,6 +7518,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>               x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
>           }
>   
> +        /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
> +        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
> +        }
> +
>           /* SVM requires CPUID[0x8000000A] */
>           if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>               x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d845384dcd..5566a13f4f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -662,6 +662,7 @@ typedef enum FeatureWord {
>       FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
>       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
> +    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
>       FEATURE_WORDS,
>   } FeatureWord;
>   
> @@ -990,6 +991,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   /* Packets which contain IP payload have LIP values */
>   #define CPUID_14_0_ECX_LIP              (1U << 31)
>   
> +/* AVX10 128-bit vector support is present */
> +#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
> +/* AVX10 256-bit vector support is present */
> +#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
> +/* AVX10 512-bit vector support is present */
> +#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
> +
>   /* RAS Features */
>   #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
>   #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index fd9f198892..8e17942c3b 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1923,7 +1923,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>           case 0x7:
>           case 0x14:
>           case 0x1d:
> -        case 0x1e: {
> +        case 0x1e:
> +        case 0x24: {
>               uint32_t times;
>   
>               c->function = i;


