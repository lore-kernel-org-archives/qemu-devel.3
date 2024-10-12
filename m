Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B376D1A451
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 08:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szXY6-0005gp-2Q; Sat, 12 Oct 2024 04:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1szXY3-0005gF-Ti; Sat, 12 Oct 2024 04:32:28 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1szXY0-0001h0-Kp; Sat, 12 Oct 2024 04:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728721945; x=1760257945;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Eo2N6cMr0HYPF7/uot1pbbgFfNStRfRjo1OJpI095zI=;
 b=GcRG6/oa3CdYklDfP7yrjwr0jSwxuyuE8glJuz7Gj5/Yx+y7gzpn0D4l
 uR+f/Qe05x2uqpV5sgV3SLHMTCwZ00Ot8SEMjMwKKqRqYaozVEd9/wggP
 I3vFnrPF9HkRpQ3STr4qcpUtv92to4/pHQtBfI8z0+7BNXIwO3vXj2mVr
 t5gqJ3vxjZGzis83NQ/VW1MovEvM6Q2iU8gLn6rT/9zJLc22vn7eO3qnf
 xeFm286I7z1MQtNGhUyrYRPnparMUQPE3J4LLtDa3rdio/ejzUO1kKt0N
 2IKqrjFsprO5E0mCIx+V+efDSwWAPEDfW3YJugAgpbaS8qV/5367aV4aa g==;
X-CSE-ConnectionGUID: CbNQKlH4Q0aSJHtEEJ+yCA==
X-CSE-MsgGUID: 5fMdLQMRQ72WJbMcil60jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28227189"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="28227189"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 01:32:21 -0700
X-CSE-ConnectionGUID: HqEGuZpzS7e704e46RDXbw==
X-CSE-MsgGUID: JvEy27tjSt2rHbvg+PaBRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="77036263"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.38])
 ([10.124.224.38])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 01:32:18 -0700
Message-ID: <cfa014eb-d658-4c53-aaf1-086baf22c52a@intel.com>
Date: Sat, 12 Oct 2024 16:32:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <00f25e56-72e4-485a-a6a4-6b0c5563330d@intel.com>
 <ceb6f780-5dc2-4df7-b4f3-70884124d705@bytedance.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ceb6f780-5dc2-4df7-b4f3-70884124d705@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.649, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/12/2024 4:10 PM, Chuang Xu wrote:
> Hi, Xiaoyao
> 
> On 10/12/24 下午3:13, Xiaoyao Li wrote:
>> On 10/9/2024 11:56 AM, Chuang Xu wrote:
>>> When QEMU is started with:
>>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>>
>>> On Intel platform:
>>> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
>>> logical processors in the physical package".
>>>
>>> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 
>>> 90 for
>>> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
>>> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
>>> CPUID.04H.EAX[31:26], which matches the expected result.
>>>
>>> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
>>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>>> integer too. Otherwise we may encounter unexpected results in guest.
>>>
>>> For example, when QEMU is started with CLI above and xtopology is 
>>> disabled,
>>> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/ 
>>> (1+CPUID.04H.EAX[31:26]) to
>>> calculate threads-per-core in detect_ht(). Then guest will get "90/ 
>>> (1+63)=1"
>>> as the result, even though threads-per-core should actually be 2.
>>>
>>> And on AMD platform:
>>> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
>>> result meets our expectation.
>>
>> So for AMD platform, what's result for the same situation with 
>> xtopology disabled? Does AMD uses another algorithm to calculate other 
>> than CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) ?
>>
> For amd platform, CPUID.04H is reserved, so it uses 
> CPUID.8000001E.EAX[15:8] (fied ThreadsPerComputeUnit) to obtain the result.

Does AMD support leaf 8000001E at the beginning when it starts to 
support multi-threads/multi-cores? (just my curiosity)

>>> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 
>>> integer
>>> only for Intel platform to solve the unexpected result.
>>>
>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>>> ---
>>>   target/i386/cpu.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index ff227a8c5c..641d4577b0 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6462,7 +6462,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>>> index, uint32_t count,
>>>           }
>>>           *edx = env->features[FEAT_1_EDX];
>>>           if (threads_per_pkg > 1) {
>>> -            *ebx |= threads_per_pkg << 16;
>>> +            /*
>>> +             * AMD requires logical processor count, but Intel needs 
>>> maximum
>>> +             * number of addressable IDs for logical processors per 
>>> package.
>>> +             */
>>> +            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>>> +                *ebx |= threads_per_pkg << 16;
>>> +            } else {
>>> +                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
>>> +            }
>>
>> you need to handle the overflow case when the number of logical 
>> processors > 255.
>>
> It seems other cpuid cases of bit shifting don't condiser the overflow 
> case too..
> 
> Since intel only reserves 8bits for this field, do you have any 
> suggestions to make sure this field emulated
> 
> correctly?

the usual option can be masking the value to only 8 bits before 
shifting, like

	((1 << apicid_pkg_offset(&topo_info)) & 0xff) << 16

but when the value is greater than 255, it will be truncated, so we need 
something like below to reflect the hardware behavior:

	MIN((1 << apicid_pkg_offset(&topo_info)), 255) << 16

This is what Qian's patch [1] wanted to fix last year, but that patch 
never gets merged.

[1] 
https://lore.kernel.org/qemu-devel/20230829042405.932523-2-qian.wen@intel.com/

>>>               *edx |= CPUID_HT;
>>>           }
>>>           if (!cpu->enable_pmu) {
>>


