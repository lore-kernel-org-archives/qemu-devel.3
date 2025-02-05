Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D77BC02196
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfcf0-0001Pl-AH; Wed, 05 Feb 2025 05:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfcew-0001PF-Lx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:29:32 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfceu-0002ur-R9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738751369; x=1770287369;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XTPxn9WRGlrKBXY4J7ul9HEN574LaZ3V1oKkkycRmZQ=;
 b=hasZRsX5UznNCcCFvXu/BCOanbs6gdeKj3Ap86EwJJNGfcaM3LZRroLc
 /mL2NaptvhwJX3pcDrbY5FD8CYgVvPROpJzlzkHmp+jvGzLoreP8M1fU1
 1P/HCJnHRTcHjUE7anZE4exGn4vlWpN7I0Z670naKQkQuzRLmzSA3v787
 /Xoz1GAguhxd23pfqKXyAT8WKUfvI/EKXoah0qdeJ8IzIUh/KF5t73twP
 TPK0KSw/c9cv8RbQ037k+rLsEhZH711xJPlLddTpXYouAlPY0M8QiINmj
 UR624koxuAI1licjBXHimI7Nbpse8J3TIWErHqycJS+5Er4jH0WCGo3Ou g==;
X-CSE-ConnectionGUID: WDgb7cuxRFOu47T2fldpzg==
X-CSE-MsgGUID: 9bvu+tYCQL2P7DvOL1/MtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49561801"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49561801"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:29:27 -0800
X-CSE-ConnectionGUID: 0eTPcpoOR5C+FjvqLlBKmg==
X-CSE-MsgGUID: FTmLxHUGSa2Wf0Otyey+dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="110758770"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:29:22 -0800
Message-ID: <3633ee44-1e16-4e87-8f6d-4fed9e1f3a29@intel.com>
Date: Wed, 5 Feb 2025 18:29:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 48/52] i386/tdx: Fetch and validate CPUID of TD guest
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-49-xiaoyao.li@intel.com>
 <87o6zg3fl2.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87o6zg3fl2.fsf@pond.sub.org>
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

On 2/5/2025 5:28 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Use KVM_TDX_GET_CPUID to get the CPUIDs that are managed and enfored
>> by TDX module for TD guest. Check QEMU's configuration against the
>> fetched data.
>>
>> Print wanring  message when 1. a feature is not supported but requested
>> by QEMU or 2. QEMU doesn't want to expose a feature while it is enforced
>> enabled.
>>
>> - If cpu->enforced_cpuid is not set, prints the warning message of both
>> 1) and 2) and tweak QEMU's configuration.
>>
>> - If cpu->enforced_cpuid is set, quit if any case of 1) or 2).
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/cpu.c     | 33 ++++++++++++++-
>>   target/i386/cpu.h     |  7 +++
>>   target/i386/kvm/tdx.c | 99 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 137 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index f1330627adbb..a948fd0bd674 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -5482,8 +5482,8 @@ static bool x86_cpu_have_filtered_features(X86CPU *cpu)
>>       return false;
>>   }
>>   
>> -static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
>> -                                      const char *verbose_prefix)
>> +void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
>> +                               const char *verbose_prefix)
>>   {
>>       CPUX86State *env = &cpu->env;
>>       FeatureWordInfo *f = &feature_word_info[w];
>> @@ -5510,6 +5510,35 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
>>       }
>>   }
>>   
>> +void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
>> +                             const char *verbose_prefix)
>> +{
>> +    CPUX86State *env = &cpu->env;
>> +    FeatureWordInfo *f = &feature_word_info[w];
>> +    int i;
>> +
>> +    if (!cpu->force_features) {
>> +        env->features[w] |= mask;
>> +    }
>> +
>> +    cpu->forced_on_features[w] |= mask;
>> +
>> +    if (!verbose_prefix) {
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i < 64; ++i) {
>> +        if ((1ULL << i) & mask) {
>> +            g_autofree char *feat_word_str = feature_word_description(f);
> 
> Does not compile for me:
> 
>      ../target/i386/cpu.c: In function ‘mark_forced_on_features’:
>      ../target/i386/cpu.c:5531:46: error: too few arguments to function ‘feature_word_description’
>       5531 |             g_autofree char *feat_word_str = feature_word_description(f);
>            |                                              ^~~~~~~~~~~~~~~~~~~~~~~~
>      ../target/i386/cpu.c:5451:14: note: declared here
>       5451 | static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
>            |              ^~~~~~~~~~~~~~~~~~~~~~~~

As mentioned in the cover letter, this series depends on a minor one:

https://lore.kernel.org/qemu-devel/20241217123932.948789-1-xiaoyao.li@intel.com/

>> +            warn_report("%s: %s%s%s [bit %d]",
>> +                        verbose_prefix,
>> +                        feat_word_str,
>> +                        f->feat_names[i] ? "." : "",
>> +                        f->feat_names[i] ? f->feat_names[i] : "", i);
>> +        }
>> +    }
>> +}
>> +
>>   static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
>>                                            const char *name, void *opaque,
>>                                            Error **errp)
> 
> [...]
> 


