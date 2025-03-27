Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A90C36008
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 00:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txbMq-0002Rq-4z; Wed, 26 Mar 2025 20:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1txbMk-0002Ra-TF
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 20:45:03 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1txbMi-0006p5-Fk
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 20:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743036301; x=1774572301;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1E4OhdxDCA+uUeKjgwsdCTwJzIJ0Qula+rwvE/bkIEY=;
 b=bdww+fC6F/L3gVGidFKpJ6vbs3q/tzRkm7WdO/iIhAEpn4kreyPzLypY
 w8i8H4HlcnYf9aIlxhTY9R3l9D2+zdMelu/PRRyNHdfne8Tlv+H2RWlM3
 sFQhEPhz5P6cRCUkRf6HknI2HduNu0wY9d3fUPsv/2TIYNYfdGmci3Lhi
 7QfV9Qfl8nv/phyMn4YoeM91d0gY39/YtBt4JM1juORmDf5b702gRyj68
 rFjh+vMcQMBfzXuz+0fxC9SlKJxZJExR6MBgtA6lCbFe1BF6w2uhMByl0
 cro3RhU7cN149lmZRBaXHjQFqrfGufkVfRgD9Q9GihfyxARH8M9ns3o2Z g==;
X-CSE-ConnectionGUID: cQwl1GkIQKO2LrpuVIGtRA==
X-CSE-MsgGUID: 2T6MM7fkStyX3FP4agX8Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55716620"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; d="scan'208";a="55716620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 17:44:52 -0700
X-CSE-ConnectionGUID: YIbrI9zcR7KAaP4Tjq0uDA==
X-CSE-MsgGUID: MQK7FOH/RfO2gqkRsn9DOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; d="scan'208";a="130014402"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128])
 ([10.124.245.128])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 17:44:48 -0700
Message-ID: <a8e4649d-5402-4c3a-bc86-1d1b76122541@linux.intel.com>
Date: Thu, 27 Mar 2025 08:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Call KVM_CAP_PMU_CAPABILITY iotcl to
 enable/disable PMU
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu
 <zhao1.liu@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>, Das Sandipan
 <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
 <20250324123712.34096-3-dapeng1.mi@linux.intel.com>
 <3a01b0d8-8f0b-4068-8176-37f61295f87f@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <3a01b0d8-8f0b-4068-8176-37f61295f87f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, LONG_TERM_PRICE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 3/26/2025 2:46 PM, Dongli Zhang wrote:
> Hi Dapeng,
>
> PATCH 1-4 from the below patchset are already reviewed. (PATCH 5-10 are for PMU
> registers reset).
>
> https://lore.kernel.org/all/20250302220112.17653-1-dongli.zhang@oracle.com/
>
> They require only trivial modification. i.e.:
>
> https://github.com/finallyjustice/patchset/tree/master/qemu-amd-pmu-mid/v03
>
> Therefore, since PATCH 5-10 are for another topic, any chance if I re-send 1-4
> as a prerequisite for the patch to explicitly call KVM_CAP_PMU_CAPABILITY?

any option is fine for me, spiting it into two separated ones or still keep
in a whole patch series. I would rebase this this patchset on top of your
v3 patches.


>
> In addition, I have a silly question. Can mediated vPMU coexist with legacy
> perf-based vPMU, that is, something like tdp and tdp_mmu? Or the legacy
> perf-based vPMU is going to be purged from the most recent kernel?

No, they can't. As long as mediated vPMU is enabled, it would totally
replace the legacy perf-based vPMU. The legacy perf-based vPMU code would
still be kept in the kernel in near future, but the long-term target is to
totally remove the perf-based vPMU once mediated vPMU is mature.


>
> If they can coexist, how about add property to QEMU control between
> legacy/modern? i.e. by default use legacy and change to modern as default in the
> future once the feature is stable.
>
> Thank you very much!
>
> Dongli Zhang
>
> On 3/24/25 5:37 AM, Dapeng Mi wrote:
>> After introducing mediated vPMU, mediated vPMU must be enabled by
>> explicitly calling KVM_CAP_PMU_CAPABILITY to enable. Thus call
>> KVM_CAP_PMU_CAPABILITY to enable/disable PMU base on user configuration.
>>
>> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  target/i386/kvm/kvm.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index f41e190fb8..d3e6984844 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2051,8 +2051,25 @@ full:
>>      abort();
>>  }
>>  
>> +static bool pmu_cap_set = false;
>>  int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>>  {
>> +    KVMState *s = kvm_state;
>> +    X86CPU *x86_cpu = X86_CPU(cpu);
>> +
>> +    if (!pmu_cap_set && kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY)) {
>> +        int r = kvm_vm_enable_cap(s, KVM_CAP_PMU_CAPABILITY, 0,
>> +                                  KVM_PMU_CAP_DISABLE & !x86_cpu->enable_pmu);
>> +        if (r < 0) {
>> +            error_report("kvm: Failed to %s pmu cap: %s",
>> +                         x86_cpu->enable_pmu ? "enable" : "disable",
>> +                         strerror(-r));
>> +            return r;
>> +        }
>> +
>> +        pmu_cap_set = true;
>> +    }
>> +
>>      return 0;
>>  }
>>  

