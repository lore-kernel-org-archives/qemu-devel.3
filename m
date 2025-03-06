Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9893C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0C5-0002lJ-AC; Wed, 05 Mar 2025 20:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tq0Bp-0002hO-Ii
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:38:22 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tq0Bn-0007Y7-Kt
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741225100; x=1772761100;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BRkvITwqC9ljJKuED1Pmo+9BOHS4JoP2CXPCODhn8v8=;
 b=SNX1BFD88ZCXkaJLj0AP6xgTbaf9glNpgqUgBz+DlejTbpGIxiwLHciw
 qzI8bHtbhxtuej3Ri4Zf5ehw1GmuOVCOb+WkYrZHntbgwpmQyMCV0rRDd
 R/eVLJ4ir22eaxORSpmajN78ZivZH/UUullpBXQAhkxNJju7SrlR1nXXF
 elFH1qcAX13on1wKz1mGRDiCWeK7y+y9c6ssjdfMQjr9GtCH9zlgyt/K/
 Sm0w3wOPKP1H3EDZc7J/OB3vMmB9AA/oSwsPaI1JyXidXQzo8jslUr1Pv
 9Tt91xW1ox04P9DIy3RU9L9JO9QlLYFoEjbQLGXJhn6GNIiiG4thmai8U Q==;
X-CSE-ConnectionGUID: SByJZqPiRmCVjMx/9rPeyw==
X-CSE-MsgGUID: 717rqv8JQWmnoDx9F9+Ijg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52428589"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; d="scan'208";a="52428589"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 17:38:15 -0800
X-CSE-ConnectionGUID: hnAjISE5RfuGECn9t5GiOQ==
X-CSE-MsgGUID: WuST7SpYTACCbpeSzFx/3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; d="scan'208";a="119375901"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128])
 ([10.124.245.128])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 17:38:10 -0800
Message-ID: <2f018bf8-9561-4cde-8ee7-a4365f0abce1@linux.intel.com>
Date: Thu, 6 Mar 2025 09:38:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] target/i386/kvm: don't stop Intel PMU counters
To: dongli.zhang@oracle.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-11-dongli.zhang@oracle.com>
 <5f76ce8f-5f69-4a95-8c27-011a7d713fc3@linux.intel.com>
 <3bfa6447-5724-43d7-8176-3dc13cbb0657@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <3bfa6447-5724-43d7-8176-3dc13cbb0657@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 3/6/2025 3:00 AM, dongli.zhang@oracle.com wrote:
> Hi Dapeng,
>
> On 3/4/25 11:35 PM, Mi, Dapeng wrote:
>> On 3/3/2025 6:00 AM, Dongli Zhang wrote:
>>> The kvm_put_msrs() sets the MSRs using KVM_SET_MSRS. The x86 KVM processes
>>> these MSRs one by one in a loop, only saving the config and triggering the
>>> KVM_REQ_PMU request. This approach does not immediately stop the event
>>> before updating PMC.
>>>
>>> In additional, PMU MSRs are set only at levels >= KVM_PUT_RESET_STATE,
>>> excluding runtime. Therefore, updating these MSRs without stopping events
>>> should be acceptable.
>> Suppose this works for upcoming mediated vPMU as well? If so, please
>> mention it here. Thanks.
> TBH I am not sure if it works for mediated vPMU. The entire patchset is
> based the current implementation in mainline linux kernel.
>
> Otherwise, it is also required to modify the AMD's implementation ... that
> is, to stop AMD general PMCs or global registers (PerfMonV2).
>
> How about only consider the case without mediated vPMU so far?
>
> 1. For user without PerfMonV2 servers, they only need the patchset to reset
> general PMCs.
>
> 2. For user with PerfMonV2 servers, they need extra patch to reset global
> registers.
>
> 3. For mediated vPMU, we may add extra patch in the future.

I suppose it should be fine for mediated vPMU but I have no bandwidth to
thoroughly test it.

Ok, I think it's fine not to consider mediated vPMU in this patch series,
we can look at it later. Thanks.


>
> Thank you very much!
>
> Dongli Zhang
>
>>
>>> Finally, KVM creates kernel perf events with host mode excluded
>>> (exclude_host = 1). While the events remain active, they don't increment
>>> the counter during QEMU vCPU userspace mode.
>>>
>>> No Fixed tag is going to be added for the commit 0d89436786b0 ("kvm:
>>> migrate vPMU state"), because this isn't a bugfix.
>>>
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> ---
>>>  target/i386/kvm/kvm.c | 9 ---------
>>>  1 file changed, 9 deletions(-)
>>>
>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>> index c5911baef0..4902694129 100644
>>> --- a/target/i386/kvm/kvm.c
>>> +++ b/target/i386/kvm/kvm.c
>>> @@ -4160,13 +4160,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>>          }
>>>  
>>>          if (IS_INTEL_CPU(env) && has_pmu_version > 0) {
>>> -            if (has_pmu_version > 1) {
>>> -                /* Stop the counter.  */
>>> -                kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>>> -                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
>>> -            }
>>> -
>>> -            /* Set the counter values.  */
>>>              for (i = 0; i < num_pmu_fixed_counters; i++) {
>>>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>>>                                    env->msr_fixed_counters[i]);
>>> @@ -4182,8 +4175,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>>                                    env->msr_global_status);
>>>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>>>                                    env->msr_global_ovf_ctrl);
>>> -
>>> -                /* Now start the PMU.  */
>>>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
>>>                                    env->msr_fixed_ctr_ctrl);
>>>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,

