Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E56BF53D81
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CVb-0000G7-9g; Mon, 16 Mar 2026 14:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w2CVV-0000FC-0p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:17:37 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w2CVS-0004O4-53
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773685054; x=1805221054;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=72hT51VxRJyxkK0JYHMV74Zb0BaPjnY4ymN1gjKZSIo=;
 b=FAY3o/vgDywUB19iZfcIq5yIyIS5P4xGKQPzhPpDoDAtbjb+w9GUIVX0
 djuWJPczEvC7RhiIe8Z1LQqh5JbU/9hnzaTUM/nt4AklOenIn2s4GGQcq
 e0VqutZJLdpX9T2XCbEVZ7+3SjFvc+dFEnOhK+VDEE7J1bAx0LpIkFLmy
 cOn/8JfBFPPlKYf5A5lDhQsxzjUxJAq/OUUKjlDghJrD68Zvs+Ilbp+Lu
 3iYxUnNGQjCVLSDyPy597wAPFx++SgAA8ac5zYfnSMEbJ9+PUcH8cxrb4
 Oo9K1VRYt0eJecDHLqI+uPkGJ6efItP9DwyLGsximCA+9cSR29e3me7Ey A==;
X-CSE-ConnectionGUID: MG37m6LMQxyUVhYcgJ8TKA==
X-CSE-MsgGUID: J2q3UoF8RjWCnYDeDD92jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85793259"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85793259"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 11:17:29 -0700
X-CSE-ConnectionGUID: FEqglwq+RFm7JEAodbB96Q==
X-CSE-MsgGUID: gJEul5DvQymRKgJ3rOGn7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="216482156"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.35])
 ([10.241.241.35])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 11:17:28 -0700
Message-ID: <12ea3e8f-a88e-48fe-9b5c-c41b9f220829@intel.com>
Date: Mon, 16 Mar 2026 11:17:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
To: Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Hector Cao <hector.cao@canonical.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-13-zide.chen@intel.com>
 <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
 <73e47641-d3ca-4b4e-b403-20cf786adf4d@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <73e47641-d3ca-4b4e-b403-20cf786adf4d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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



On 3/15/2026 11:57 PM, Xiaoyao Li wrote:
> On 3/16/2026 11:21 AM, Chenyi Qiang wrote:
>>
>>
>> On 3/5/2026 2:07 AM, Zide Chen wrote:
>>> - 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
>>> - When PMU is disabled, Debug Store must not be exposed to the guest,
>>>    which implicitly disables legacy DS-based PEBS.
>>>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> V3:
>>> - Update title to be more accurate.
>>> - Make DTES64 depend on DS.
>>> - Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
>>> - Clean up the commit message.
>>>
>>> V2: New patch.
>>> ---
>>>   target/i386/cpu.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 2e1dea65d708..3ff9f76cf7da 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
>>>           .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
>>>           .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
>>>       },
>>> +    {
>>> +        .from = { FEAT_1_EDX,               CPUID_DTS},
>>> +        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
>>> +    },
>>>       {
>>>           .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
>>>           .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
>>> @@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error
>>> **errp)
>>>               env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>>           }
>>>   +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>>>           env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>>
>> This change, along with the original CPUID_7_0_EDX_ARCH_LBR clear,
>> will also affect the configuration for TD VMs.
>> For a TD VM, enable_pmu controls TDX_TD_ATTRIBUTES_PERFMON, CPUID_DTS
>> is fixed to 1, and arch_lbr is controlled by XFAM[15].
>> These features' configuration do not have dependencies on each other.
>> So how about skipping the TD VM case like:
> 
> I think the dependency between enable_pmu and ARCH_LBR still applies to
> TDX. This dependency is defined by QEMU that enable_pmu controls all the
> PMU features, including ARCH_LBR. So we can enforce the rule of
> "XFAM[15] cannot be 1 when enable_pmu == 0"

Yes, when !enable_pmu, XSTATE_ARCH_LBR_MASK will be cleared in
FEAT_XSAVE_XSS_LO, and therefore the ARCH_LBR bit in XFAM will also be
cleared. As a result, CPUID_7_0_EDX_ARCH_LBR will ultimately be cleared
from the guest CPUID. However, it is better to follow the spec and leave
it unchanged here.

> For CPUID_DTS, it seems OK to expose it even when PMU is disabled?
> I sort of disagree with the statement in the changelog:
> 
>   - When PMU is disabled, Debug Store must not be exposed to the guest,
>     which implicitly disables legacy DS-based PEBS

As you mentioned, the dependencies of enable_pmu are defined by QEMU.
If the DS bit remains set when !enable_pmu, it looks inconsistent.

> If I read SDM correctly, the availability of legacy PEBS can be
> enumerated by MSR_IA32_MISC_ENABLE.PEBS_UNAVAILABLE bit. And from the
> linux code, it also proves that DTS can be 1 while PEBS is 0:
> 
>     if (boot_cpu_has(X86_FEATURE_DS)) {
>         unsigned int l1, l2;
> 
>         rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
>         if (!(l1 & MSR_IA32_MISC_ENABLE_BTS_UNAVAIL))
>             set_cpu_cap(c, X86_FEATURE_BTS);
>         if (!(l1 & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL))
>             set_cpu_cap(c, X86_FEATURE_PEBS);
>     }

MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL are sufficient to prevent the
guest from enumerating the PEBS feature.

However, keeping CPUID_DTS set has some negative impacts. For example,
it may incorrectly determine the availability of IA32_DS_AREA.


> Since it will need nasty handling for TDX case, I would vote not
> clearing CPUID_DTS here when !PMU, unless a strong reason is provided.

The "nasty handling for TDX" code already there, adding CPUID_DTS may
not make it worse. :) Accepting Chenyi's suggested code seems reasonable
and clean.


> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 98e95d0842..458bfb07b9 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -9736,8 +9736,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error
>> **errp)
>>               env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>           }
>>
>> -        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>> -        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>> +        if (!is_tdx_vm()) {
>> +            env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>> +            env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>> +        }
>>       }
>>
>>       for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
>>
>>
>>
>>>       }
>>>   
>>
> 


