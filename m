Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8A5C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYcy-0005p4-Fg; Wed, 23 Jul 2025 08:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueYbc-0005Px-JC
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:29:58 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueYbZ-0001tT-Iq
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753273794; x=1784809794;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3scQuP3ImpY5lJ/rU1VAPYBJPJ8Gewp1+YCn/6EhgSo=;
 b=cqQlTMJsIJQLFqbENv4gPsuf6sP2RMO7avUk43UQIcj2lVjqkB47ItD7
 XXUKL0u5pORcHlZl7LEuwIptQxveiWHpiRJSqePZIDStqmew/BVDYeYa5
 4+ez38RowRr/1ItN0aJWxIDfpLt5kF0k40oG6t0Lu6KuHJbkk7GRbVMP7
 BRAKLq1BXaGpr4o1JTaM7G8rwjJMDOfG9vxsmgzGeIcodFzJzG3q4OK8G
 r4B0CEBe/FVrVXIMUHLT/AJSHNE5UeDvM2v0H+Nh3GNnp8aZiJSAki9Dp
 zRiIGkTRVJk5ZgCcMKfEdCd7HMbmiGg1iPX9NRV3JY+K5zvDp0JWS1pay A==;
X-CSE-ConnectionGUID: /EbfjTdlSyybFMoKL8w3ng==
X-CSE-MsgGUID: fytvn9DPTcq2Ifa+iOjbqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43173706"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="43173706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 05:29:48 -0700
X-CSE-ConnectionGUID: /QxGZCqqRkOynngGpif9Wg==
X-CSE-MsgGUID: yMcphhBzTJ+0xRnoldvg5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="190440284"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 05:29:47 -0700
Message-ID: <1f116e59-e375-4347-8fe6-982d79c79b46@intel.com>
Date: Wed, 23 Jul 2025 20:29:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/kvm: Set mem.guest_memfd_offset only when
 guest_memfd is valid
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250723070951.1134374-1-xiaoyao.li@intel.com>
 <20250723070951.1134374-4-xiaoyao.li@intel.com>
 <c149b1b3-1b28-452e-91ee-e4f8efb8f24e@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <c149b1b3-1b28-452e-91ee-e4f8efb8f24e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/23/2025 8:06 PM, Philippe Mathieu-Daudé wrote:
> On 23/7/25 09:09, Xiaoyao Li wrote:
>> Current QEMU unconditionally sets the mmem.guest_memfd_offset in
>> kvm_set_user_memory_region(), which leads to the trace of 
>> kvm_set_user_memory
>> look as:
>>
>> kvm_set_user_memory AddrSpace#0 Slot#4 flags=0x2 gpa=0xe0000 
>> size=0x20000 ua=0x7f5840de0000 guest_memfd=-1 
>> guest_memfd_offset=0x3e0000 ret=0
>>
>> It's confusing that the guest_memfd_offset has a non-zero value while
>> the guest_memfd is invalid (-1).
>>
>> Change to only set guest_memfd_offset when guest_memfd is valid.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   accel/kvm/kvm-all.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 4f4c30fc84b2..2b6fbf58a127 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -367,7 +367,9 @@ static int 
>> kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
>>       mem.userspace_addr = (unsigned long)slot->ram;
>>       mem.flags = slot->flags;
>>       mem.guest_memfd = slot->guest_memfd;
>> -    mem.guest_memfd_offset = slot->guest_memfd_offset;
>> +    if (slot->guest_memfd >= 0) {
>> +        mem.guest_memfd_offset = slot->guest_memfd_offset;
>> +    }
> 
> IMHO the issue is in when the KVMSlot is filled in kvm_set_phys_mem():

Agreed, fix it in the origin。

> -- >8 --
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 890d5ea9f86..631f14b996a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1595,7 +1595,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>           mem->ram = ram;
>           mem->flags = kvm_mem_flags(mr);
>           mem->guest_memfd = mr->ram_block->guest_memfd;
> -        mem->guest_memfd_offset = (uint8_t*)ram - mr->ram_block->host;
> +        mem->guest_memfd_offset = mr->ram_block->guest_memfd
> +                                ? (uint8_t*)ram - mr->ram_block->host : 0;

it should be

	mr->ram_block->guest_memfd >= 0 ? (uint8_t*)ram - mr->ram_block->host : 0;

I will use the fixed version in v2.

Thanks!

>           kvm_slot_init_dirty_bitmap(mem);
>           err = kvm_set_user_memory_region(kml, mem, true);
> ---


