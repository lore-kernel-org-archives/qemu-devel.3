Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5789C83F10
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 02:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZhU7-0005Ce-MU; Wed, 09 Jul 2025 22:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZhU0-0005Aw-NS
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 22:58:00 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZhTx-0005Ac-BV
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 22:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752116278; x=1783652278;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UD7AyJRv2Q23JXKkqMRm90Py0ClGR7am37933AcOywM=;
 b=BaQwNiZ+8gySWLw/ucBihfXpAzbnHP/bUJvnhFZeFx7L69dvyBNvWJ+H
 2EKKPAsR05sYNknC+pYZMp6OaFXNpVz66G6FWq1xnslxnZZ2AbWgD8rbS
 BFHeWMTVgvp1+6jUYAN4MxDC/M6xrNVZENV/54vBjxL5VSHo9V7LnjBp8
 A5UplCXLJrFmiCheFz1NHRJtVHVkoEhFIxeu7ae8wuKoz/d4XYsjF7X4Z
 8t+/i5UmARiaFKmAGeZL1h9Qlc4BmQZOv7ZVi5mD76q24s/1JiJNFMrpB
 iioVJcQ0UihWKWEgDtVnTDPc6wlLG1/zl2kOPYOz9rCE8IZv/EIPom5/v w==;
X-CSE-ConnectionGUID: ZTaJd0jORn2e4/YQPTAigA==
X-CSE-MsgGUID: Qzq6LHwXQbeXB4y/dUp4GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="64647288"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; d="scan'208";a="64647288"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 19:57:53 -0700
X-CSE-ConnectionGUID: skKdKIHQSde7S8GiprDf3Q==
X-CSE-MsgGUID: G1jIt3NyR0SktmKuUqABhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; d="scan'208";a="156055491"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 19:57:51 -0700
Message-ID: <de97d1cc-69c9-4fcf-aa7d-3989475549d5@intel.com>
Date: Thu, 10 Jul 2025 10:57:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Add TSA feature flags
To: babu.moger@amd.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local>
 <8ba851bc-e7b3-461b-9bfb-4d7018771f0c@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <8ba851bc-e7b3-461b-9bfb-4d7018771f0c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/9/2025 11:02 PM, Moger, Babu wrote:
> Hi Boris,
> 
> On 7/9/25 05:49, Borislav Petkov (AMD) wrote:
>> Hi,
>>
>> I *think* this is how it should be done but I might be forgetting something.
>> It seems to work in my testing here.
>>
>> Babu, double-check me pls.
>>
>> Thx.
> 
> 
> Patch looks good. Few comments.
> 
> Is KVM aware of these bits? I didn’t notice any patches adding support for
> them in the kernel.

Hi Boris,

Besides KVM patch, would you please provide the public doc that 
describes the new bits?

> I recommend splitting this into two separate patches:
> a. One patch to introduce the new bit 0021_EAX_VERW_CLEAR.

It also needs to be a separate patch to add it to "EPYC-Genoa" as v3, so 
please make it 3 patches.

> b. Another patch to add the new feature leaf FEAT_8000_0021_ECX.
> Also, don’t forget to define tsa-sq-no and tsa-l1-no in target/i386/cpu.h.
> 
> 
>>
>> ---
>>
>> Add CPUID leaf 0x8000_0021.ECX support and add the TSA CPUID flags.
>>
>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>> ---
>>   target/i386/cpu.c | 20 +++++++++++++++++++-
>>   target/i386/cpu.h |  3 +++
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 0d35e95430fe..b889de61ed9d 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1274,7 +1274,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>           .type = CPUID_FEATURE_WORD,
>>           .feat_names = {
>>               "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
>> -            NULL, NULL, "null-sel-clr-base", NULL,
>> +            NULL, "verw-clear", "null-sel-clr-base", NULL,
>>               "auto-ibrs", NULL, NULL, NULL,
>>               NULL, NULL, NULL, NULL,
>>               NULL, NULL, NULL, NULL,
>> @@ -1308,6 +1308,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>           .tcg_features = 0,
>>           .unmigratable_flags = 0,
>>       },
>> +    [FEAT_8000_0021_ECX] = {
>> +        .type = CPUID_FEATURE_WORD,
>> +        .feat_names = {
>> +            NULL, "tsa-sq-no", "tsa-l1-no", NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +        },
>> +        .cpuid = { .eax = 0x80000021, .reg = R_ECX, },
>> +        .tcg_features = 0,
>> +        .unmigratable_flags = 0,
>> +    },
>>       [FEAT_XSAVE] = {
>>           .type = CPUID_FEATURE_WORD,
>>           .feat_names = {
>> @@ -5835,6 +5851,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>           .features[FEAT_8000_0021_EAX] =
>>               CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
>>               CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
>> +            CPUID_8000_0021_EAX_VERW_CLEAR |
>>               CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
>>               CPUID_8000_0021_EAX_AUTO_IBRS,
>>           .features[FEAT_7_0_EBX] =
>> @@ -7934,6 +7951,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>           *eax = *ebx = *ecx = *edx = 0;
>>           *eax = env->features[FEAT_8000_0021_EAX];
>>           *ebx = env->features[FEAT_8000_0021_EBX];
>> +        *ecx = env->features[FEAT_8000_0021_ECX];
>>           break;
>>       default:
>>           /* reserved values: zero */
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 51e10139dfdf..8b2703f41b73 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -641,6 +641,7 @@ typedef enum FeatureWord {
>>       FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
>>       FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
>>       FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
>> +    FEAT_8000_0021_ECX, /* CPUID[8000_0021].ECX */
>>       FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
>>       FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>>       FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
>> @@ -1101,6 +1102,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>>   #define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
>>   /* LFENCE is always serializing */
>>   #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
>> +/* Memory form of VERW mitigates TSA */
>> +#define CPUID_8000_0021_EAX_VERW_CLEAR                   (1U << 5)
>>   /* Null Selector Clears Base */
>>   #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
>>   /* Automatic IBRS */
> 
> We need to define tsa-sq-no and tsa-l1-no here.
> These definitions can be used later when adding a new CPU model.

Add them later along with the patch introduces the new CPU model is also OK.


