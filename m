Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB7D12690
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Htt-0000he-E5; Tue, 05 Nov 2024 06:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8Htr-0000dX-Bq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:39:07 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8Hto-0000hL-TZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730806745; x=1762342745;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2p0qqrZXhnJnX7t+XGnwdl5Wk1Q0mCbjfRdTlG/C5Ds=;
 b=gFGtmpHt6MI2ywWdUe6or49HBaM78E8+Bv4j/Ri7sve7e87SJByVbH2a
 g80x0bHNtOrjT16rhcNmLIZUlUS/NfUxSBGHeLqqhnvC9ErcuokEJjLXM
 Y+hCJsFAq+pxp9YXqMnMMYyx9Yxx4mTmdfwTRCPCh7Le22tebw6Z+N5Jf
 D7dW7gIToTrMO20VLLwy0PtYSm+ECreJHT8li/o+UniE/cc9NRPc83lO5
 w5jsxgepyeUprBPYO/xaZZMnpDiDLsTXVlqKm28Pu+9zNqEb7llPrLTfT
 xwj4UqI9xS3LsIMuhjQjxmobnzPf2+ecDZWC/WBxelimhzIWmXNAvzld7 A==;
X-CSE-ConnectionGUID: Fn/X/EAZRGS4QS92hLX+QQ==
X-CSE-MsgGUID: DjBoEUxRRUSD0c14Aj3AEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34331938"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="34331938"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:39:02 -0800
X-CSE-ConnectionGUID: RbFMi+25QlyixGO3X3+4yA==
X-CSE-MsgGUID: LvrbLg2sRYOMCDLqbdN59w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="83879565"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:38:57 -0800
Message-ID: <2bedfcda-c2e7-4e5b-87a7-9352dfe28286@intel.com>
Date: Tue, 5 Nov 2024 19:38:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/60] i386/tdx: implement tdx_cpu_realizefn()
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
 <20241105062408.3533704-35-xiaoyao.li@intel.com>
 <82b74218-f790-4300-ab3b-9c41de1f96b8@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <82b74218-f790-4300-ab3b-9c41de1f96b8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
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

On 11/5/2024 6:06 PM, Paolo Bonzini wrote:
> On 11/5/24 07:23, Xiaoyao Li wrote:
>> +static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
>> +                              Error **errp)
>> +{
>> +    X86CPU *cpu = X86_CPU(cs);
>> +    uint32_t host_phys_bits = host_cpu_phys_bits();
>> +
>> +    if (!cpu->phys_bits) {
>> +        cpu->phys_bits = host_phys_bits;
>> +    } else if (cpu->phys_bits != host_phys_bits) {
>> +        error_setg(errp, "TDX only supports host physical bits (%u)",
>> +                   host_phys_bits);
>> +    }
>> +}
> 
> This should be already handled by host_cpu_realizefn(), which is reached 
> via cpu_exec_realizefn().
> 
> Why is it needed earlier, but not as early as instance_init?  If 
> absolutely needed I would do the assignment in patch 33, but I don't 
> understand why it's necessary.

It's not called earlier but right after cpu_exec_realizefn().

Patch 33 adds x86_confidenetial_guest_cpu_realizefn() right after 
ecpu_exec_realizefn(). This patch implements the callback and gets 
called in x86_confidenetial_guest_cpu_realizefn() so it's called after
cpu_exec_realizefn().

The reason why host_cpu_realizefn() cannot satisfy is that for normal 
VMs, the check in cpu_exec_realizefn() is just a warning and QEMU does 
allow the user to configure the physical address bit other than host's 
value, and the configured value will be seen inside guest. i.e., "-cpu 
phys-bits=xx" where xx != host_value works for normal VMs.

But for TDX, KVM doesn't allow it and the value seen in TD guest is 
always the host value.  i.e., "-cpu phys-bits=xx" where xx != host_value 
doesn't work for TDX.

> Either way, the check should be in tdx_check_features.

Good idea. I will try to implement it in tdx_check_features()

> Paolo
> 
>>   static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
>>   {
>>       if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
>> @@ -733,4 +749,5 @@ static void tdx_guest_class_init(ObjectClass *oc, 
>> void *data)
>>       klass->kvm_init = tdx_kvm_init;
>>       x86_klass->kvm_type = tdx_kvm_type;
>>       x86_klass->cpu_instance_init = tdx_cpu_instance_init;
>> +    x86_klass->cpu_realizefn = tdx_cpu_realizefn;
>>   }
> 


