Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691B3D1268C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hh3-0003NT-5H; Tue, 05 Nov 2024 06:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8Hgy-00033p-ON
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:25:50 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8Hgl-0007vZ-04
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730805935; x=1762341935;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=s1wswE6/InO1G4xUqdts8qxxRWQM31X334rkUkdhdgU=;
 b=IHqnDDScRkhwTCeeT0sr/2SqXJTtMR9hRd4JPIDsB/4GNj9NJC5m/LLt
 9PXInqrtphBj8yskQMgPQcBYLFRKz5BElmswicdDBltSTgtctVsZLzAhC
 YeMDowkuX6gc3jQzN1N6RtDVQ5DklNApLUCfIZnoLgBMOlrd/CFcCqAdx
 lrWqayGDfjRZ68QRRuwT+Ie5sf03QYar1dOnOXgiXKa062bq6cdPH0lgZ
 XEg20qqvlOZZKJbbLXdB74TBZ++27+pMhb9NgIUg5U6IZQ0Pg/NZU7MWI
 nZWqur0N9cTNSGKqKTlKZhtphxfqV3nYHwdFZnKcqjF67yBvDaE7dOLeu A==;
X-CSE-ConnectionGUID: 95VwWKIUQdmRvCy9MzP8YQ==
X-CSE-MsgGUID: ONw8q8yBSvWSt3kW95e2pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30503044"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30503044"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:25:23 -0800
X-CSE-ConnectionGUID: DKTS63VqThuubrGE6o9gdg==
X-CSE-MsgGUID: vLe/cltnQ9e0hJSfCrxoqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="84092452"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:25:20 -0800
Message-ID: <e5d02d7f-a989-4484-b0c1-3d7ac804ec73@intel.com>
Date: Tue, 5 Nov 2024 19:25:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 45/60] i386/tdx: Don't get/put guest state for TDX VMs
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-46-xiaoyao.li@intel.com>
 <8cd78103-5f49-4cbd-814d-a03a82a59231@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <8cd78103-5f49-4cbd-814d-a03a82a59231@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/5/2024 5:55 PM, Paolo Bonzini wrote:
> On 11/5/24 07:23, Xiaoyao Li wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> Don't get/put state of TDX VMs since accessing/mutating guest state of
>> production TDs is not supported.
>>
>> Note, it will be allowed for a debug TD. Corresponding support will be
>> introduced when debug TD support is implemented in the future.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> This should be unnecessary now that QEMU has 
> kvm_mark_guest_state_protected().

Reverting this patch, we get:

tdx: tdx: error: failed to set MSR 0x174 to 0x0
tdx: ../../../go/src/tdx/tdx-qemu/target/i386/kvm/kvm.c:3859: 
kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
error: failed to set MSR 0x174 to 0x0
tdx: ../../../go/src/tdx/tdx-qemu/target/i386/kvm/kvm.c:3859: 
kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.

> Paolo
> 
>> ---
>>   target/i386/kvm/kvm.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index c39e879a77e9..e47aa32233e6 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -5254,6 +5254,11 @@ int kvm_arch_put_registers(CPUState *cpu, int 
>> level, Error **errp)
>>       assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>> +    /* TODO: Allow accessing guest state for debug TDs. */
>> +    if (is_tdx_vm()) {
>> +        return 0;
>> +    }
>> +
>>       /*
>>        * Put MSR_IA32_FEATURE_CONTROL first, this ensures the VM gets 
>> out of VMX
>>        * root operation upon vCPU reset. kvm_put_msr_feature_control() 
>> should also
>> @@ -5368,6 +5373,12 @@ int kvm_arch_get_registers(CPUState *cs, Error 
>> **errp)
>>           error_setg_errno(errp, -ret, "Failed to get MP state");
>>           goto out;
>>       }
>> +
>> +    /* TODO: Allow accessing guest state for debug TDs. */
>> +    if (is_tdx_vm()) {
>> +        return 0;
>> +    }
>> +
>>       ret = kvm_getput_regs(cpu, 0);
>>       if (ret < 0) {
>>           error_setg_errno(errp, -ret, "Failed to get general purpose 
>> registers");
> 


