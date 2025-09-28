Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A862CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 06:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2lFp-00050K-AI; Sun, 28 Sep 2025 02:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v2lFn-0004zZ-Jg
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 02:51:27 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v2lFh-0002ON-M9
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 02:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759042282; x=1790578282;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=atjQUSWKxNesZyofnmW2Btr5UXnOuB35bG8VoQi2Fdw=;
 b=YC6bLsXVmd2PSJ5425zaN0Pzm4LrYzL2VlCkxNEVlhRYirPlCuwMLwAg
 Vn5V9deK2CUNpeDMC44iCHdniDNEGEa/DlhmMcZil25sa+SOrUgc0rUFj
 2F1N+cBELQaju6mPs3lm+wakDKL07HewVDo/9lkXm2Dwrx6J/8dWycpBX
 BU6JAGGkruwHQftUDNzcAqlGrNCO7Cg0IiItrXaEayzK4oK09aF60zm55
 f5SvDxY7Pkw49TkiJQkR5OufCMHawHqne0T6dCDMGGsU0GiPO2EGFOeNT
 0vZvRMTpfTVB4VFholJSWPasA/xw+MAwvnnUlBi5k1h71ZT8bpdkwsS0I w==;
X-CSE-ConnectionGUID: jc8Vsl3vQ+uP4iSWDD5VBg==
X-CSE-MsgGUID: NV7wPJi0TgCyEAybq/kcqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="61234718"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="61234718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2025 23:51:09 -0700
X-CSE-ConnectionGUID: WaD64kEFQ9qPGRLrQI+geg==
X-CSE-MsgGUID: ZKAyQLieRkO5bF/tauZ/VQ==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2025 23:51:07 -0700
Message-ID: <0dd69e59-7484-4a63-af81-f70f7f2457d9@intel.com>
Date: Sun, 28 Sep 2025 14:51:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 54/61] i386/cpu: Enable SMM cpu address space under KVM
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <20250913080943.11710-55-pbonzini@redhat.com>
 <CAFEAcA_3kkZ+a5rTZGmK8W5K6J7qpYD31HkvjBnxWr-fGT2h_A@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAFEAcA_3kkZ+a5rTZGmK8W5K6J7qpYD31HkvjBnxWr-fGT2h_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 9/27/2025 1:48 AM, Peter Maydell wrote:
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 34e74f24470..d191d7177f1 100644
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
>> +    }
>>   }
> However, this code is in a machine_init_done notifier, so it
> runs only once when QEMU starts up. So the CPUs initially
> present on QEMU startup get their AS 1 initialized, but
> any CPU hot-plugged later on while QEMU is running will
> not ever call cpu_address_space_init() for AS 1.
> 
> I saw this with some work-in-progress patches I have that
> try to free the AddressSpaces of the CPU (which crash
> because the hot-plugged CPU claims to have 2 ASes but
> the second one is NULL). You can probably also get a
> crash for a variation of the reported crash that this
> commit is trying to fix, if the CPU that we try to
> x86_cpu_dump_state() for is a hot-plugged one in SMM state.
> 
> Where should we be initing the AS for hot-plugged CPUs?

I think we can do it inside x86_cpu_plug(). Let me try to cook a patch 
for it.

