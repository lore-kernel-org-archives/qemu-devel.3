Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0207C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 10:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh3oJ-0001sL-Av; Wed, 30 Jul 2025 06:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3o4-0001nY-4P
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:13:09 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3o1-00027b-Cx
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753870385; x=1785406385;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RYrGqdD5gtT/vNlBog31qHa56pTYrT23pZhk4GB2z5I=;
 b=GhhIqO6QY2DyJNLGLWPH2WH8HGRDnR7nR+e0KJmh3eUZzO9dVz1ynzDA
 AKD/rtAPyGZRMgeMPyv1Z97bLxXYH8mVPh/1sB7t4Zxfmk7ZEO41GZPsz
 4Dvx5xv7mTFJ53zpaB1YSwxjd+1uVmrVT/Ijr1S9cmzBi4+sggDOE4RGA
 SQ9ZsJlojRaeTvg/NxS/u078m8rlKcZnfQeQ4n3CT5bNtV+KbxzQww6Ap
 BykbcfEiZXgUAcEaaYnLRErXbum/SDAzsQqJb7bfVBlquiMcp4d9c+90m
 zMf+Qkf6QAQcr5zFivRgHrwAK0fiG8vw+WQv8teqN1d2SLgPPYlFBXz9L A==;
X-CSE-ConnectionGUID: t8zPwsZ+QwekCjFxih2S3Q==
X-CSE-MsgGUID: 1RebRnCUQGeCo5Drpwumhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="55235617"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="55235617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:13:02 -0700
X-CSE-ConnectionGUID: Jl2ufmdZTa2BvX5ZsxzjtA==
X-CSE-MsgGUID: MumN0OspSYCStx+Ydx0KaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="163397934"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:13:00 -0700
Message-ID: <75a28dcb-88b2-4a7e-a782-a06d915e1654@intel.com>
Date: Wed, 30 Jul 2025 18:12:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com> <aInTujVM5hr6/cJw@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aInTujVM5hr6/cJw@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.244, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/30/2025 4:11 PM, Zhao Liu wrote:
>> @@ -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>>           kvm_set_guest_phys_bits(cs);
>>       }
>>   
>> +    /*
>> +     * When SMM is enabled, there is 2 address spaces. Otherwise only 1.
>> +     *
>> +     * Only init address space 0 here, the second one for SMM is initialized at
>                 ^^^^
> 	       initialize
> 
>> +     * register_smram_listener() after machine init done.
>> +     */
>> +    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
>> +    cpu_address_space_init(cs, 0, "cpu-mmeory", cs->memory);
>> +
>>       return true;
>>   }
>>   
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 369626f8c8d7..47fb5c673c8e 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2704,6 +2704,7 @@ static MemoryRegion smram_as_mem;
>>   
>>   static void register_smram_listener(Notifier *n, void *unused)
>>   {
>> +    CPUState *cpu;
>>       MemoryRegion *smram =
>>           (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
>>   
>> @@ -2728,6 +2729,10 @@ static void register_smram_listener(Notifier *n, void *unused)
>>       address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
>>       kvm_memory_listener_register(kvm_state, &smram_listener,
>>                                    &smram_address_space, 1, "kvm-smram");
>> +
>> +    CPU_FOREACH(cpu) {
>> +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
> 
> It is worth mentioning in the commit message that directly sharing
> MemoryRegion in CPUAddressSpace is safe.

It's unnecessary to me. It's common that different Address space share 
the same (root) memory region. e.g., for address space 0 for the cpu, 
though what passed in is cpu->memory, they all point to system_memory.

>> +    }
> 
> I still think such CPU_FOREACH in machine_done callback is not the
> best approach - it's better to initialize all the address spaces in
> kvm_cpu_realizefn(), and not to go far away from cs->num_ases, as I
> said in the previous discussion.
> 
> But it's still good to fix this bug. So, with other comments
> addressed,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 


