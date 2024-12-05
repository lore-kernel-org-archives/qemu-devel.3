Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70166E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAQL-0000Sq-4W; Thu, 05 Dec 2024 06:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJAQJ-0000SY-12
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:53:35 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJAQF-0007CD-9S
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733399611; x=1764935611;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rCHr8iMhjVmuuA4npZrDNp6INSomdxjV8y8N+nsc3ns=;
 b=UPGHH7o+z7X1ZQ9dvWnXhtWDG035VEGE3ZrOP/Y0hYfgrBswNQNHRxTa
 Xp4hKGviJBo9vUvFLX9Teb4J0hyb5QHjP3DYAWuTfeaeeyK0Jj/I82YJX
 5luDqjr5iF1wvo8dxKKbn+NqrQ30MrGswg9DahhflBjqG2346CDhVr70S
 QpprBj+Ypl3e0wtW/vurHv2ATRynG0NdAHOLhKI2RhcqwCW5DatkBL4cA
 v1Ew8FV/cJpSkL3IuCJKCuzMwJlQgnAre17O2h/UDeXXjnVWXuJw/LtXI
 ymXHSYOGynncb59qyxblA/cLX8H2jfc6L0b1ay1NU1+Ndvmdrr5rG9IhK Q==;
X-CSE-ConnectionGUID: mEXHpOAeT52nzd+EcIRHVg==
X-CSE-MsgGUID: qzovoUnwTOGj12IXwCwTLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33038711"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="33038711"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 03:53:28 -0800
X-CSE-ConnectionGUID: Fcw4LBHLQAeV7T9Z0ZfZew==
X-CSE-MsgGUID: 0uHIluE5SWGN8JpKVAZuqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="93943497"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 03:53:26 -0800
Message-ID: <045f9cb1-2b17-4b2c-985f-3c34e3626b36@intel.com>
Date: Thu, 5 Dec 2024 19:53:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpu: Initialize nr_cores and nr_threads in
 cpu_common_initfn()
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-2-xiaoyao.li@intel.com>
 <20241122160317.4070177-1-xiaoyao.li@intel.com>
 <20241125103857.78a23715@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241125103857.78a23715@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.827, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/25/2024 5:38 PM, Igor Mammedov wrote:
> On Fri, 22 Nov 2024 11:03:17 -0500
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> Currently cpu->nr_cores and cpu->nr_threads are initialized in
>> qemu_init_vcpu(), which is called a bit late in *cpu_realizefn() for
>> each ARCHes.
>>
>> x86 arch would like to use nr_cores and nr_threads earlier in its
>> realizefn(). To serve this purpose, initialize nr_cores and nr_threads
>> in cpu_common_initfn(), which is earlier than *cpu_realizefn().
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   hw/core/cpu-common.c | 10 +++++++++-
>>   system/cpus.c        |  4 ----
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>> index 09c79035949b..6de92ed854bc 100644
>> --- a/hw/core/cpu-common.c
>> +++ b/hw/core/cpu-common.c
>> @@ -237,14 +237,22 @@ static void cpu_common_unrealizefn(DeviceState *dev)
>>   static void cpu_common_initfn(Object *obj)
>>   {
>>       CPUState *cpu = CPU(obj);
>> +    Object *machine = qdev_get_machine();
>> +    MachineState *ms;
>>   
>>       gdb_init_cpu(cpu);
>>       cpu->cpu_index = UNASSIGNED_CPU_INDEX;
>>       cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
>>       /* user-mode doesn't have configurable SMP topology */
>> -    /* the default value is changed by qemu_init_vcpu() for system-mode */
>>       cpu->nr_cores = 1;
>>       cpu->nr_threads = 1;
>> +#ifndef CONFIG_USER_ONLY
>> +    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
>> +        ms = MACHINE(machine);
>> +        cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
>> +        cpu->nr_threads = ms->smp.threads;
>> +    }
>> +#endif
> 
> Can't say, that I'm fond of adding/moving hack to access MachineState
> from CPU context. Granted we did/still do it elsewhere, But I'd rather
> prefer getting rid of those remnants that access globals.
> It's basically technical debt we are carrying since 2009 (dc6b1c09849).
> Moving that around doesn't help with getting rid of arbitrary access to globals.
> 
> As Paolo've noted there are other ways to set cores/threads,
> albeit at expense of adding more code. And that could be fine
> if it's done within expected cpu initialization flow.
> 
> Instead of accessing MachineState directly from CPU code (which is
> essentially a layer violation), I'd suggest to set cores_nr/threads_nr
> from pre_plug handler (which is machine code).
> We do similar thing for nr_dies/nr_modules already, and we should do
> same for cores/trheads.
> 
> Quick hack would be do the same for cores/threads in x86_cpu_pre_plug(),
> and make qemu_init_vcpu() conditional to avoid touching other targets/machines.
> 
> I'd even ack that, however that's just leaves us with the same
> old technical debt. So I'd like to coax a promise to fix it properly
> (i.e. get rid of access to machine from CPU code).
> 
> (here goes typical ask to rewrite whole QEMU before doing thing you
> actually need)
> 
> To do that we would need to:
>    1. audit usage of cpu->nr_cores/cpu->nr_threads across QEMU, to figure out
>       what targets/machines need them
>    2. then add pre_plug() handlers to those machines to set them.
>    3. In the end get rid of initializing them in cpu_common_initfn().

here is the update:

For cpu->nr_cores, it's only used by x86 ARCH. We can remove it and 
maintain one for x86 separately.

For cpu->nr_threads, besides x86, it's also used by

1) hw/mips/malta.c

     env->mvp->CP0_MVPConf0 = deposit32(env->mvp->CP0_MVPConf0,
                                        CP0MVPC0_PTC, 8,
                                        smp_cpus * cs->nr_threads - 1);

2) target/mips/tcg/sysemu

     vpe_idx = tc_idx / cs->nr_threads;
     *tc = tc_idx % cs->nr_threads;

3) target/ppc/compat.c

     int n_threads = CPU(cpu)->nr_threads;

There are no existing CPU pre_plug() function for above cases, and I 
don't know how to add it because I know nothing about MIPS/PPC at all.

If desire is still to go with direction, I need someone else to help 
MIPS/PPC. Or is it OK that only change the X86 implementation to 
initialize cpu->nr_threads earlier in  x86_cpu_pre_plug() and leave 
other ARCHes as todo?
	

> With that done we can then add a common helper to generalize topo config
> based on -smp from pre_plug() handlers to reduce duplication caused by
> per machine pre_plug handlers.
> 
> Or introduce a generic cpu_pre_plug() handler at Machine level and make
> _pre_plug call chain to call it (sort of what we do with nested realize calls);
> 
> I'd prefer the 1st option (#2) as it explicitly documents what
> targets/machines care about cores/threads at expense of some boiler plate code
> duplication, instead of blanket generic fallback like we have now (regardless of
> if it's actually needed).
> 
>>       cpu->cflags_next_tb = -1;
>>   
>>       /* allocate storage for thread info, initialise condition variables */
>> diff --git a/system/cpus.c b/system/cpus.c
>> index 1c818ff6828c..c1547fbfd39b 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -664,10 +664,6 @@ const AccelOpsClass *cpus_get_accel(void)
>>   
>>   void qemu_init_vcpu(CPUState *cpu)
>>   {
>> -    MachineState *ms = MACHINE(qdev_get_machine());
>> -
>> -    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
>> -    cpu->nr_threads =  ms->smp.threads;
>>       cpu->stopped = true;
>>       cpu->random_seed = qemu_guest_random_seed_thread_part1();
>>   
> 


