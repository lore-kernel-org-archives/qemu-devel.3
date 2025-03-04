Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8071EC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 06:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpLVL-0008QC-FD; Tue, 04 Mar 2025 01:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLVH-0008Q1-RQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:11:43 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLVE-0004ez-Ew
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741068701; x=1772604701;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HHhKVtxadplL5mKHcw+YWQLXuPPV+DKKFP7OBci2gWQ=;
 b=Es/TsmPazteUeAAQkd9I6sXBY7oevC0uod1JDivhUY3hv8dRaPXpapui
 P+AuyGyUFQsHk3VaI3wZdV+OAGjbtc/9M4Nd4qtDUKnjNtSf84jaRRlEm
 6b04Wxyxg67bHmuMXvTGhoXxqtTQeCsr6jdnP45/N78G5Tzmijcp2NpO5
 7tc63OuLNZPSYMtwqYfd4Sh8Cp9Oeu8wQ9yIhF9Jdlc72yu0aIG6WcBGw
 ggjbYqZB13YmMmHvThdVV5MCLlwf6jiUCQPQTqDAoG2tJ8KUK6eGGqv/4
 XRT6+uVss60bHVGQ4bc1rm6KeDlld01yq377K8z/4+eK5Wv5T5IafdWLY g==;
X-CSE-ConnectionGUID: IG8n8vqsQ82M9TNlwGMy+w==
X-CSE-MsgGUID: 8vXGbn5hRNqYY5YM5rmfaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45619428"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="45619428"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 22:11:35 -0800
X-CSE-ConnectionGUID: QAJh1PKgSEGQGeotrcQ+8w==
X-CSE-MsgGUID: sEGnnyB9Sz2ZQAW7wcSnSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="141500769"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 22:11:29 -0800
Message-ID: <addd4bf3-af4c-446d-b586-62c89ab37d26@intel.com>
Date: Tue, 4 Mar 2025 14:11:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] target/i386: disable PERFCORE when "-pmu" is
 configured
To: dongli.zhang@oracle.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-3-dongli.zhang@oracle.com>
 <99810e4f-f41d-4905-ae6d-1080b14fc8fd@intel.com>
 <0dcdd9c1-35e5-4cee-be0b-59113e01e73c@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <0dcdd9c1-35e5-4cee-be0b-59113e01e73c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/4/2025 2:45 AM, dongli.zhang@oracle.com wrote:
> Hi Xiaoyao,
> 
> On 3/2/25 5:59 PM, Xiaoyao Li wrote:
>> On 3/3/2025 6:00 AM, Dongli Zhang wrote:
>>> Currently, AMD PMU support isn't determined based on CPUID, that is, the
>>> "-pmu" option does not fully disable KVM AMD PMU virtualization.
>>>
>>> To minimize AMD PMU features, remove PERFCORE when "-pmu" is configured.
>>>
>>> To completely disable AMD PMU virtualization will be implemented via
>>> KVM_CAP_PMU_CAPABILITY in upcoming patches.
>>>
>>> As a reminder, neither CPUID_EXT3_PERFCORE nor
>>> CPUID_8000_0022_EAX_PERFMON_V2 is removed from env->features[] when "-pmu"
>>> is configured. Developers should query whether they are supported via
>>> cpu_x86_cpuid() rather than relying on env->features[] in future patches.
>>
>> I don't think it is the correct direction to go.
>>
>> env->features[] should be finalized before cpu_x86_cpuid() and env-
>>> features[] needs to be able to be exposed to guest directly. This ensures
>> guest and QEMU have the same view of CPUIDs and it simplifies things.
>>
>> We can adjust env->features[] by filtering all PMU related CPUIDs based on
>> cpu->enable_pmu in x86_cpu_realizefn().
> 
> Thank you very much for suggestion.
> 
> I see  code like below in x86_cpu_realizefn() to edit env->features[].
> 
> 7982     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
> 7983      * CPUID[1].EDX.
> 7984      */
> 7985     if (IS_AMD_CPU(env)) {
> 7986         env->features[FEAT_8000_0001_EDX] &= ~CPUID_EXT2_AMD_ALIASES;
> 7987         env->features[FEAT_8000_0001_EDX] |= (env->features[FEAT_1_EDX]
> 7988            & CPUID_EXT2_AMD_ALIASES);
> 7989     }
> 
> I may do something similar to them for CPUID_EXT3_PERFCORE and
> CPUID_8000_0022_EAX_PERFMON_V2.

I just sent a series for CPUID_EXT_PDCM[1]. I think you can put 
CPUID_EXT3_PERFCORE and CPUID_8000_0022_EAX_PERFMON_V2 at the same place.

[1] 
https://lore.kernel.org/qemu-devel/20250304052450.465445-1-xiaoyao.li@intel.com/T/#m31c6777131b6361d7c3af22b09532bdc785dbc06

> Dongli Zhang
> 
> 
> 
>>
>>> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> ---
>>>    target/i386/cpu.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index b6d6167910..61a671028a 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -7115,6 +7115,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
>>> index, uint32_t count,
>>>                !(env->hflags & HF_LMA_MASK)) {
>>>                *edx &= ~CPUID_EXT2_SYSCALL;
>>>            }
>>> +
>>> +        if (kvm_enabled() && IS_AMD_CPU(env) && !cpu->enable_pmu) {
>>> +            *ecx &= ~CPUID_EXT3_PERFCORE;
>>> +        }
>>>            break;
>>>        case 0x80000002:
>>>        case 0x80000003:
>>
> 


