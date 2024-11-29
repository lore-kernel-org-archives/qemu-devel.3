Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994B5D6EBE3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvAv-0007wu-VR; Fri, 29 Nov 2024 02:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tGvAt-0007vh-0b
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:12:23 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tGvAp-0007F1-Ip
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732864340; x=1764400340;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4zy2YgeHwLzgBxDu7sgMp1KlHEPRhpCAYrs6KwPdezE=;
 b=TSpnfLKgx+Ba+bGDcfD7tPnP1LPH/YXe5H0SoM3Lljeu+0+sue3gFs/C
 QY6q5SvuyCJ6qELgTblKIbo6Z9A2cFYQS14n2HLXOkrrSYyeh+LCCfjhs
 GLTbXNoX1XK4VZ7usJH4wbkrM3NpMVsxbAqZgLb+Lw6O4QUCYI7c4yPG0
 hmnQY13ibBNi0GjMa975XvuWO/8usfYo7cFCaFC35Pwjco7fIZmMSNR1X
 CuiBvUmjtmo9C6cixcz+qMilmEzdHKxW81cRnFwej9hBejgYjxrYmQRL6
 +QEBXxwmZHc+SzHuPYApKdfTzK3zTQtEBUPgthBtEQJG0zX5SleCNgeWp Q==;
X-CSE-ConnectionGUID: dztBUDlDTCyccxOK11hp3A==
X-CSE-MsgGUID: ZPC4IV4pS2ezroCJhgoDoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33246648"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; d="scan'208";a="33246648"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2024 23:12:15 -0800
X-CSE-ConnectionGUID: 3cdGFDR0TpSHRwQSGpwBlg==
X-CSE-MsgGUID: EAnw96W/TBOgFiaYPAC7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; d="scan'208";a="92040034"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2024 23:12:12 -0800
Message-ID: <f370a74f-9153-4d22-b101-71c3e37c1d20@intel.com>
Date: Fri, 29 Nov 2024 15:12:08 +0800
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
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.783, RCVD_IN_DNSWL_MED=-2.3,
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
 >    2. then add pre_plug() handlers to those machines to set them.> 
3. In the end get rid of initializing them in cpu_common_initfn().

It looks sane to me.

I'm wondering how to audit usage of cpu->nr_cores/cpu->nr_threads for 
other target than x86. I haven't played with them.

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


