Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206BFC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5pS-0000PC-SZ; Fri, 31 May 2024 13:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sD5pQ-0000Ne-Eo; Fri, 31 May 2024 13:14:08 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sD5pO-0002Lq-8a; Fri, 31 May 2024 13:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717175647; x=1748711647;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QQr0p0ePBlmEbkmaxw6RHzl/RVGNuQ6qsFICWHNdhGM=;
 b=YQTfNRWF4ZC6DUdUf8vS9H7b/gc4/dSaUlH53zrwZ3ZZyXlzsqvBEFIa
 mhCwwQsvboZM7DDKqYNXoapJGPD4KLZU25CSdbDqT4JHo7pYMKugHjuLu
 ckTPZZDrIIywBs2Sn/rxbhSMzwOqucAyDWNt/zNrLlg91DI7uQQBn0Yze
 7xUOaXDrGtPzeznKxrGshq/eBBaOaccXC/ePwb0fHElyL1NOuTpsnhDv4
 m2HedzqtPgmTU+a49t6EYsnBPWOEwS4LKS43d2LezGa1Q2sOTl/L/8Fjv
 mo/Z0/nP77/r6V8wa0pXD6xervBoUpyilg4lBnfjLu8qnaommmNSuBWtC w==;
X-CSE-ConnectionGUID: 0/+jx+aDQIuL/6jp4LwtEw==
X-CSE-MsgGUID: zADnnGYcRZe4ANT3NsyJ8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13897102"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="13897102"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 10:13:51 -0700
X-CSE-ConnectionGUID: +Z2IjAw6QwekM3sxAreiQA==
X-CSE-MsgGUID: F/E0D6MET8WW35u3K8io4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="36215606"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.49]) ([10.24.10.49])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 10:13:50 -0700
Message-ID: <55bfe786-3015-4dd0-9bc5-6905276b2e32@intel.com>
Date: Fri, 31 May 2024 10:13:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] target/i386: Move host_cpu_enable_cpu_pm into
 kvm_cpu_realizefn()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-4-zide.chen@intel.com> <Zllz4qFpVqrLJXXt@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <Zllz4qFpVqrLJXXt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 5/30/2024 11:53 PM, Zhao Liu wrote:
> On Fri, May 24, 2024 at 01:00:17PM -0700, Zide Chen wrote:
>> Date: Fri, 24 May 2024 13:00:17 -0700
>> From: Zide Chen <zide.chen@intel.com>
>> Subject: [PATCH V2 3/3] target/i386: Move host_cpu_enable_cpu_pm into
>>  kvm_cpu_realizefn()
>> X-Mailer: git-send-email 2.34.1
>>
>> It seems not a good idea to expand features in host_cpu_realizefn,
>> which is for host CPU only. 
> 
> It is restricted by max_features and should be part of the "max" CPU,
> and the current target/i386/host-cpu.c should only serve the “host” CPU.

Yes, since this file only serves for "host" CPU, that's why I proposed
to move this code to kvm_cpu_realizefn().

> 
>> Additionally, cpu-pm option is KVM
>> specific, and it's cleaner to put it in kvm_cpu_realizefn(), together
>> with the WAITPKG code.
>>
>> Fixes: f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  target/i386/host-cpu.c    | 12 ------------
>>  target/i386/kvm/kvm-cpu.c | 11 +++++++++--
>>  2 files changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
>> index 280e427c017c..8b8bf5afeccf 100644
>> --- a/target/i386/host-cpu.c
>> +++ b/target/i386/host-cpu.c
>> @@ -42,15 +42,6 @@ static uint32_t host_cpu_phys_bits(void)
>>      return host_phys_bits;
>>  }
>>  
>> -static void host_cpu_enable_cpu_pm(X86CPU *cpu)
>> -{
>> -    CPUX86State *env = &cpu->env;
>> -
>> -    host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
>> -               &cpu->mwait.ecx, &cpu->mwait.edx);
>> -    env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>> -}
>> -
>>  static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>>  {
>>      uint32_t host_phys_bits = host_cpu_phys_bits();
>> @@ -83,9 +74,6 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
>>      X86CPU *cpu = X86_CPU(cs);
>>      CPUX86State *env = &cpu->env;
>>  
>> -    if (cpu->max_features && enable_cpu_pm) {
>> -        host_cpu_enable_cpu_pm(cpu);
>> -    }
>>      if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>>          uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
>>  
>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>> index 3adcedf0dbc3..197c892da89a 100644
>> --- a/target/i386/kvm/kvm-cpu.c
>> +++ b/target/i386/kvm/kvm-cpu.c
>> @@ -64,9 +64,16 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>>       *   cpu_common_realizefn() (via xcc->parent_realize)
>>       */
>>      if (cpu->max_features) {
>> -        if (enable_cpu_pm && kvm_has_waitpkg()) {
>> -            env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
>> +        if (enable_cpu_pm) {
>> +            if (kvm_has_waitpkg()) {
>> +                env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
>> +            }
> 
> If you agree with my comment in patch 2, here we need a mwait bit check.

I still think that take advantaged of x86_cpu_filter_features() to check
host availability is a better choice.

> 
>> +            host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
>> +                       &cpu->mwait.ecx, &cpu->mwait.edx);
>> +            env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>>          }
>> +
>>          if (cpu->ucode_rev == 0) {
>>              cpu->ucode_rev =
>>                  kvm_arch_get_supported_msr_feature(kvm_state,
>> -- 
>> 2.34.1
>>
>>

