Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBF2C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYhv-000172-O3; Tue, 01 Jul 2025 06:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWYhj-000115-5H
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:59:14 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWYhc-0003Ms-KV
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751367544; x=1782903544;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fknzLbMjMZokE2JgMEqIFqfz52WLEBUJ6Qc5fUWu7JI=;
 b=ACJNNdsb5SteJL8xaqhEplamCklfEIPHzRYosVTclqvb696MIAHJNYEd
 IzYMwBREvpnyzoy77oYMv3LivX+2ikHCLYd9zH+YU1mBQFhzgGkw/O5UJ
 dDPDlzU+yC9OvUkXC/0KS4FP4QvVjSfGLJ55PvKKybTLuxmdzRjzgplPD
 uHuXJKDwQntdpA0q0HpzyThH+rijjsOJQidSw+6LFTABMwPyaD7D+n92h
 AmCx+5zPA7+P/7TaTGRzAQ5WjPNJ1np6z/l+ZbJi++96mVhU13akg13/q
 lIGtKOwlMm+NOOtYhJOFkePZHICyXsajNt6DAuzddK+X7fsL0nsAJWPmr g==;
X-CSE-ConnectionGUID: 3+khCJZqSlOVP1a8HBG1wA==
X-CSE-MsgGUID: 4iW/y5VKRcKZtDcNiV1hxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53348468"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="53348468"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 03:59:01 -0700
X-CSE-ConnectionGUID: dYcccyEdSJi3rJw6KtgpEA==
X-CSE-MsgGUID: 0qdtGGu8TpqP49HAtCdjMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="153903612"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 03:59:00 -0700
Message-ID: <136d3b8c-9701-4141-8d5c-59121d136c9c@intel.com>
Date: Tue, 1 Jul 2025 18:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Rename host_cpu_instance_init() to
 apply_host_vendor()
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
References: <20250701075738.3451873-1-xiaoyao.li@intel.com>
 <20250701075738.3451873-2-xiaoyao.li@intel.com>
 <46c39b19-f92f-4f20-9390-35d84291715f@suse.de>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <46c39b19-f92f-4f20-9390-35d84291715f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/1/2025 6:29 PM, Claudio Fontana wrote:
> Hello Xiaoyao,
> 
> I did not find a better name at the time. The meaning of 'host' there has nothing to do with the cpu type called "host",
> but rather identifies common code between kvm and hvf, which both use the host cpuid(), See accel_uses_host_cpuid(), host_cpuid(), host_cpu_vendor_fms().

yeah. I konw this.

> Maybe the right way is to split the code in two files,
> 
> one dealing with these functions common between hvf and kvm,
> and one file that implements the "host" cpu type.

It can help, but the confusion doesn't disappear.

> I am concerned that "apply_host_vendor" would need to be renamed again if more code will need to be added that is common in the initialization of hvf and kvm.

At that time, we can introduce another specific function instead of 
putting everything in one function.

> I am not sure what could be a better name for the function host_cpu_instance_init(),
> but maybe its name would not confuse so much anymore if it is contained in a file that specifically includes this common code,
> excluding all "host" cpu type related code.

It can help, but it doesn't stop me from trying to associate it with 
"host" cpu type.

Anyway, if most people leans towards separating the files, I'm also OK.

> Bye,
> 
> Claudio
> 
> 
> On 7/1/25 09:57, Xiaoyao Li wrote:
>> The name of host_cpu_instance_init is really confusing. It misleads
>> people to think it as the .instance_init() callback of "host" x86 cpu
>> type.
>>
>> Rename it to match what it does and move the xcc->model check to
>> callers since it's better to let host-cpu.c concentrate only on the host
>> related functionalities.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/host-cpu.c    | 12 ++++--------
>>   target/i386/host-cpu.h    |  2 +-
>>   target/i386/hvf/hvf-cpu.c |  5 ++++-
>>   target/i386/kvm/kvm-cpu.c |  4 ++--
>>   4 files changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
>> index 383c42d4ae3d..c86b8227b974 100644
>> --- a/target/i386/host-cpu.c
>> +++ b/target/i386/host-cpu.c
>> @@ -127,16 +127,12 @@ void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
>>       }
>>   }
>>   
>> -void host_cpu_instance_init(X86CPU *cpu)
>> +void apply_host_vendor(X86CPU *cpu)
>>   {
>> -    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>> +    char vendor[CPUID_VENDOR_SZ + 1];
>>   
>> -    if (xcc->model) {
>> -        char vendor[CPUID_VENDOR_SZ + 1];
>> -
>> -        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
>> -        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
>> -    }
>> +    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
>> +    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
>>   }
>>   
>>   void host_cpu_max_instance_init(X86CPU *cpu)
>> diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
>> index b97ec01c9bec..779f0f2f4123 100644
>> --- a/target/i386/host-cpu.h
>> +++ b/target/i386/host-cpu.h
>> @@ -11,7 +11,7 @@
>>   #define HOST_CPU_H
>>   
>>   uint32_t host_cpu_phys_bits(void);
>> -void host_cpu_instance_init(X86CPU *cpu);
>> +void apply_host_vendor(X86CPU *cpu);
>>   void host_cpu_max_instance_init(X86CPU *cpu);
>>   bool host_cpu_realizefn(CPUState *cs, Error **errp);
>>   
>> diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
>> index dfdda701268e..16647482aba0 100644
>> --- a/target/i386/hvf/hvf-cpu.c
>> +++ b/target/i386/hvf/hvf-cpu.c
>> @@ -61,8 +61,11 @@ static void hvf_cpu_xsave_init(void)
>>   static void hvf_cpu_instance_init(CPUState *cs)
>>   {
>>       X86CPU *cpu = X86_CPU(cs);
>> +    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>>   
>> -    host_cpu_instance_init(cpu);
>> +    if (xcc->model) {
>> +        apply_host_vendor(cpu);
>> +    }
>>   
>>       /* Special cases not set in the X86CPUDefinition structs: */
>>       /* TODO: in-kernel irqchip for hvf */
>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>> index 6df92dc6d703..99e4357d5efe 100644
>> --- a/target/i386/kvm/kvm-cpu.c
>> +++ b/target/i386/kvm/kvm-cpu.c
>> @@ -202,9 +202,9 @@ static void kvm_cpu_instance_init(CPUState *cs)
>>       X86CPU *cpu = X86_CPU(cs);
>>       X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>>   
>> -    host_cpu_instance_init(cpu);
>> -
>>       if (xcc->model) {
>> +        apply_host_vendor(cpu);
>> +
>>           /* only applies to builtin_x86_defs cpus */
>>           if (!kvm_irqchip_in_kernel()) {
>>               x86_cpu_change_kvm_default("x2apic", "off");
> 


