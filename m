Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06BCC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLdh-0006qd-Fq; Thu, 16 Jan 2025 03:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tYLdf-0006qL-UJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:54:07 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tYLdc-0008Fs-W9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737017646; x=1768553646;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yZw1YWix7/0v17N1NyNVK3/J2P5q4Pb8NI/rZF51DAI=;
 b=HDaynqYQn/+7EmFg4bS65jx3AWKY3l7vo0eqDbrDcrKfsgRNRYQdu9Ps
 ztg2HxF2n4a9nHw6RSu3qRPZ2NEeef9SJkehPoQ0q+OOsv57I5IHVfpZS
 OR3dGL6wwf1FxKDn4vhkSapXw1fSfGpe2gQhDYXLxSPuZcgr2cQjvj1Fi
 cHb6DyYmhEA9u1YSGBExAnWNZsdbFjvpT1UES1EKz4kRX3UJIhseYitgu
 12Hw+bWLlTUMb+X+Eg4vhKthcqQoKC4s8IK3XLevdiPypJwarWRs7mXKq
 LGNLlGqrs7bRCg7JQ7m2TclGvNKCO9PtikJ2uuDNdm+tzi3DCbCaR/XzS Q==;
X-CSE-ConnectionGUID: UnqHbNBSRmyGvzkJvqIapQ==
X-CSE-MsgGUID: Nu0jbO7bT1iE+PzhtxWlhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="41069506"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="41069506"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 00:54:01 -0800
X-CSE-ConnectionGUID: JcpwkuKERM6AP3SrjlcAZA==
X-CSE-MsgGUID: wvbgJKILTuSSIhHdUD1R+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="105471015"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 00:53:55 -0800
Message-ID: <3345330e-c111-4d08-9852-9dede46957d2@intel.com>
Date: Thu, 16 Jan 2025 16:53:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 56/60] i386/tdx: Don't treat SYSCALL as unavailable
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
 <20241105062408.3533704-57-xiaoyao.li@intel.com>
 <f1c7bba2-7b21-4e10-a245-36673e93f8b7@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <f1c7bba2-7b21-4e10-a245-36673e93f8b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/5/2024 5:59 PM, Paolo Bonzini wrote:
> On 11/5/24 07:24, Xiaoyao Li wrote:
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/kvm/tdx.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 9cb099e160e4..05475edf72bd 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -734,6 +734,13 @@ static int 
>> tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>>           requested = env->features[w];
>>           unavailable = requested & ~actual;
>> +        /*
>> +         * Intel enumerates SYSCALL bit as 1 only when processor in 
>> 64-bit
>> +         * mode and before vcpu running it's not in 64-bit mode.
>> +         */
>> +        if (w == FEAT_8000_0001_EDX && unavailable & 
>> CPUID_EXT2_SYSCALL) {
>> +            unavailable &= ~CPUID_EXT2_SYSCALL;
>> +        }
>>           mark_unavailable_features(cpu, w, unavailable, unav_prefix);
>>           if (unavailable) {
>>               mismatch = true;
> 
> This seems like a TDX module bug?  

I don't think so. The value of CPUID_EXT2_SYSCALL depends on the mode of 
the vcpu. Per SDM, it's 0 outside 64-bit mode.

The initial state of TDX vcpu is 32-bit protected mode. At the time of 
calling KVM_TDX_GET_CPUID, vcpu hasn't started running. So the value 
should be 0.

There indeed is a TDX module. After vcpu starts running and TD guest 
switches to 64-bit mode. The value of this bit returned by TDX module 
via global metadata CPUID value still remains 0.

Off the topic, for me, it's really a bad API to return TDX's CPUID value 
via TD-scope metadata. It fits better with TD VCPU scope metadata.

> It's the kind of thing that I guess 
> could be worked around in KVM.
> 
> If we do it in QEMU, I'd rather see it as
> 
>              actual = cpuid_entry_get_reg(entry, wi->cpuid.reg);
>              switch (w) {
>              case FEAT_8000_0001_EDX:
>                  actual |= CPUID_EXT2_SYSCALL;
>                  break;
>              }
>              break;

I'll change to this way.


> Paolo
> 


