Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9E3C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhL5x-0006Gc-A1; Mon, 04 Mar 2024 22:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rhL5p-0006Fm-D1
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:03:52 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rhL5m-0002Ch-59
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709607826; x=1741143826;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mp+ol3XwG06p9glsFnLYwqdxgHrJDYRhiNjw+YkZF1A=;
 b=YSd9zavmxStS378F9zZbMDrB/eBHVbRrFAcGHcIyxf3Y/sIilTqkurGt
 MF2k3aTVLLINmhtW/LnpoOexFJ647V8whGcgIgbsN47ZG/rFQRO28EOEb
 PZQK8wH0hTcNcpk/S5Ca9o97urLVPzumEA89Oz+Dz/q6GgmLwjD4akUYj
 UwdOZ2xqDPY1nCeCJ22JdF3IhuguKNl/Ug80JKYoBeMkPLrAojGmr6xqG
 BYE54JFWR5Fj6fs/HVtf14Ir/w3ATyKfhL0uIJtwGpK2kg/WTLG0D4ACk
 y3WeXXsJraiLwzmH0Qyn9PnvgGPtsE7oDna7LQ3uzbqWE0iNmXIUX5jw+ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4059143"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4059143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 19:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9325010"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 19:03:39 -0800
Message-ID: <7a77eb25-2287-4e30-813d-c3b0e9bae4a6@intel.com>
Date: Tue, 5 Mar 2024 11:03:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] kvm: add support for guest physical bits
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20240301101713.356759-1-kraxel@redhat.com>
 <20240301101713.356759-2-kraxel@redhat.com>
 <3ab64c0f-7387-4738-b78c-cf798528d5f4@intel.com>
 <z4di6tev2kdeddclskhl5xhrlpseykgukfwit6ickrh57zscyv@bkjtbyj3enjx>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <z4di6tev2kdeddclskhl5xhrlpseykgukfwit6ickrh57zscyv@bkjtbyj3enjx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.273, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/4/2024 10:58 PM, Gerd Hoffmann wrote:
> On Mon, Mar 04, 2024 at 09:54:40AM +0800, Xiaoyao Li wrote:
>> On 3/1/2024 6:17 PM, Gerd Hoffmann wrote:
>>> query kvm for supported guest physical address bits using
>>> KVM_CAP_VM_GPA_BITS.  Expose the value to the guest via cpuid
>>> (leaf 0x80000008, eax, bits 16-23).
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>    target/i386/cpu.h     | 1 +
>>>    target/i386/cpu.c     | 1 +
>>>    target/i386/kvm/kvm.c | 8 ++++++++
>>>    3 files changed, 10 insertions(+)
>>>
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>> index 952174bb6f52..d427218827f6 100644
>>> --- a/target/i386/cpu.h
>>> +++ b/target/i386/cpu.h
>>> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>>>        /* Number of physical address bits supported */
>>>        uint32_t phys_bits;
>>> +    uint32_t guest_phys_bits;
>>>        /* in order to simplify APIC support, we leave this pointer to the
>>>           user */
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 2666ef380891..1a6cfc75951e 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>>>                /* 64 bit processor */
>>>                 *eax |= (cpu_x86_virtual_addr_width(env) << 8);
>>> +             *eax |= (cpu->guest_phys_bits << 16);
>>
>> I think you misunderstand this field.
>>
>> If you expose this field to guest, it's the information for nested guest.
>> i.e., the guest itself runs as a hypervisor will know its nested guest can
>> have guest_phys_bits for physical addr.
> 
> I think those limits (l1 + l2 guest phys-bits) are identical, no?

Sorry, I didn't know this patch was based on the off-list proposal made 
by Paolo that changing the definition of CPUID.0x80000008:EAX[23:16] to 
advertise the "maximum usable physical address bits".

If you call out this in the change log, it can avoid the misunderstanding.

As I replied to KVM series, I think the info is better to setup by KVM 
and reported by GET_SUPPORTED_CPUID.

> The problem this tries to solve is that making the guest phys-bits
> smaller than the host phys-bits is problematic (which why we have
> allow_smaller_maxphyaddr), but nevertheless there are cases where
> the usable guest physical address space is smaller than the host
> physical address space.  One case is intel processors with phys-bits
> larger than 48 and 4-level EPT.  Another case is amd processors with
> phys-bits larger than 48 and the l0 hypervisor using 4-level paging.
> 
> The guest needs to know that limit, specifically the guest firmware
> so it knows where it can map PCI bars.
> 
> take care,
>    Gerd
> 


