Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A34C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrfe-0001DK-1r; Tue, 25 Feb 2025 04:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tmrfb-0001D5-Cy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:56:08 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tmrfY-00079h-TH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740477365; x=1772013365;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jDDPZgTYh2ucTSEU02Q+0XVKfJmHM7vvajnT3JsASxY=;
 b=I9SQN1EYHJG4TEBOwiNhmTL2PdCMUy9kyEzyG0MbJh9WizBXFNfGrUbA
 tGt27GjsF5W0xnZ0vNh5M0tlh8RQ3dCPl90QmzCHwV+RM0Wvzz0Mh0DV0
 qeIDNvbYPV8kBxaNzHcBOfNNylx/WVQPBbR01n6TuTgkOKQEIr3noiRB/
 406U0h0DjXQ0Z1emEaE2xp758YrlN22UPKw2UfJu4dk5S0/mLVp6hk6Bd
 Fa1TBbfLBIektrTBwErCdpyZdB9LUbXW7boZQoM9qrpumDNQ75R9CMkKC
 jxsASdvYFsycK2PvhBIBWrtwJaJD0j4mNE0r5bxntzsYrwJdN5DGxNdQl w==;
X-CSE-ConnectionGUID: xsRqd+EXScmE5Z6DENoyBQ==
X-CSE-MsgGUID: 7FNc/0UYR1Sz8dx9/4oVDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66644666"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="66644666"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:56:02 -0800
X-CSE-ConnectionGUID: Jel9C8EYQySLBbMWybqPdA==
X-CSE-MsgGUID: m/EPt7kvRJSqgnGXSuIsWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="121283339"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:55:56 -0800
Message-ID: <77e3769b-7f79-42d0-8eaa-18e916800fa0@intel.com>
Date: Tue, 25 Feb 2025 17:55:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/52] i386/tdx: Initialize TDX before creating TD vcpus
To: Francesco Lavra <francescolavra.fl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-9-xiaoyao.li@intel.com>
 <6571727841685f4276aa7c814776ff1fdd162a0a.camel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <6571727841685f4276aa7c814776ff1fdd162a0a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 2/19/2025 6:14 PM, Francesco Lavra wrote:
> On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 45867dbe0839..e35a9fbd687e 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -540,8 +540,15 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>   
>>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   
>> +    /*
>> +     * tdx_pre_create_vcpu() may call cpu_x86_cpuid(). It in turn
>> may call
>> +     * kvm_vm_ioctl(). Set cpu->kvm_state in advance to avoid NULL
>> pointer
>> +     * dereference.
>> +     */
>> +    cpu->kvm_state = s;
> 
> This assignment should be removed from kvm_create_vcpu(), as now it's
> redundant there.

I'll just drop the change in this patch since there is no dependency in 
cpu_x86_cpuid() in current upstream QEMU.

>>       ret = kvm_arch_pre_create_vcpu(cpu, errp);
>>       if (ret < 0) {
>> +        cpu->kvm_state = NULL;
> 
> No need to reset cpu->kvm_state to NULL, there already are other error
> conditions under which cpu->kvm_state remains initialized.
> 
>>           goto err;
>>       }
>>   
>> @@ -550,6 +557,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>           error_setg_errno(errp, -ret,
>>                            "kvm_init_vcpu: kvm_create_vcpu failed
>> (%lu)",
>>                            kvm_arch_vcpu_id(cpu));
>> +        cpu->kvm_state = NULL;
> 
> Same here.


