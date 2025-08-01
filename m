Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10F7C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 02:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhfaq-00028D-DI; Thu, 31 Jul 2025 22:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uhfaZ-00025y-3t
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 22:33:45 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uhfaW-0004Vf-Ir
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 22:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754015620; x=1785551620;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=s+b9jgv+ngCHAPKv9RfLdn9VS8JG6ah2Nh8KSNqdcXs=;
 b=OOhoED3RZKnN0snzI4MJ9MSwpFd/e981udd48TI4JdXi0+Ormnd/trve
 o5NvblM7MC1mE2LyRbiftuZmBeaeSSisTBgT74XtaTO2FNzYkIDjvpnB5
 grzwYUMk236wyOW6YHYsXNbxQSjZcZXLz4Py73Kj1nn6UwpRWh5eH87rv
 dqbbS4JTyUFTuG0tXgVkRHwUiL3mX63RmC1qpr6beAU02bY71SioG4p4K
 D64ITImjEOCY1z1pU2prpKhAfP0Ims8LmD7XuOoSGPwoH3rS1jmwj0bxU
 LuS+BTuNzLiVRBzkKSNvVEDChMK3YvHNqv6cxKg8Gx9dsm5cgBCowDrGv Q==;
X-CSE-ConnectionGUID: 6LGIuSFtR8Svfj2e+Q/Z2w==
X-CSE-MsgGUID: FXlcCIzUSBi2TYcuSdsDcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="66925676"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="66925676"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 19:33:35 -0700
X-CSE-ConnectionGUID: X2EQj6lZQk2e3cEvudfdMw==
X-CSE-MsgGUID: 6K9SvX7TTsGEP9jfB6sBOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="163796949"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 19:33:30 -0700
Message-ID: <b87c937e-4bcc-4c76-a968-c66332fa611d@intel.com>
Date: Fri, 1 Aug 2025 10:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC PATCH 3/5] memory/guest_memfd: Enable in-place conversion
 when available
To: Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 ackerleytng@google.com, seanjc@google.com
Cc: Fuad Tabba <tabba@google.com>, Vishal Annapurve <vannapurve@google.com>,
 rick.p.edgecombe@intel.com, Kai Huang <kai.huang@intel.com>,
 binbin.wu@linux.intel.com, yan.y.zhao@intel.com, ira.weiny@intel.com,
 michael.roth@amd.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <cover.1747264138.git.ackerleytng@google.com>
 <20250715033141.517457-1-xiaoyao.li@intel.com>
 <20250715033141.517457-4-xiaoyao.li@intel.com>
 <18f64464-2ead-42d4-aeaa-f781020dca05@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <18f64464-2ead-42d4-aeaa-f781020dca05@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.236, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/17/2025 10:02 AM, Chenyi Qiang wrote:
> 
> 
> On 7/15/2025 11:31 AM, Xiaoyao Li wrote:
>> From: Yan Zhao <yan.y.zhao@intel.com>
>>
>> (This is just the POC code to use in-place conversion gmem.)
>>
>> Try to use in-place conversion gmem when it is supported.
>>
>> When in-place conversion is enabled, there is no need to discard memory
>> since it still needs to be used as the memory of opposite attribute
>> after conversion.
>>
>> For a upstreamable solution, we can introduce memory-backend-guestmemfd
>> for in-place conversion. With the non in-place conversion, it needs
>> seperate non-gmem memory to back the shared memory and gmem is created
>> implicitly and internally based on vm type. While with in-place
>> conversion, there is no need for seperate non-gmem memory because gmem
>> itself can be served as shared memory. So that we can introduce
>> memory-backend-guestmemfd as the specific backend for in-place
>> conversion gmem.
>>
>> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>> Co-developed-by Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   accel/kvm/kvm-all.c       | 79 ++++++++++++++++++++++++++++-----------
>>   accel/stubs/kvm-stub.c    |  1 +
>>   include/system/kvm.h      |  1 +
>>   include/system/memory.h   |  2 +
>>   include/system/ramblock.h |  1 +
>>   system/memory.c           |  7 ++++
>>   system/physmem.c          | 21 ++++++++++-
>>   7 files changed, 90 insertions(+), 22 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index a106d1ba0f0b..609537738d38 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -105,6 +105,7 @@ static int kvm_sstep_flags;
>>   static bool kvm_immediate_exit;
>>   static uint64_t kvm_supported_memory_attributes;
>>   static bool kvm_guest_memfd_supported;
>> +bool kvm_guest_memfd_inplace_supported;
>>   static hwaddr kvm_max_slot_size = ~0;
>>   
>>   static const KVMCapabilityInfo kvm_required_capabilites[] = {
>> @@ -1487,6 +1488,30 @@ static int kvm_set_memory_attributes(hwaddr start, uint64_t size, uint64_t attr)
>>       return r;
>>   }
>>   
>> +static int kvm_set_guest_memfd_shareability(MemoryRegion *mr, ram_addr_t offset,
>> +                                            uint64_t size, bool shared)
>> +{
>> +    int guest_memfd = mr->ram_block->guest_memfd;
>> +    struct kvm_gmem_convert param = {
>> +                .offset = offset,
>> +                .size = size,
>> +                .error_offset = 0,
>> +    };
>> +    unsigned long op;
>> +    int r;
>> +
>> +    op = shared ? KVM_GMEM_CONVERT_SHARED : KVM_GMEM_CONVERT_PRIVATE;
>> +
>> +    r = ioctl(guest_memfd, op, &param);
>> +    if (r) {
>> +        error_report("failed to set guest_memfd offset 0x%lx size 0x%lx to %s  "
>> +                     "error '%s' error offset 0x%llx",
>> +                     offset, size, shared ? "shared" : "private",
>> +                     strerror(errno), param.error_offset);
>> +    }
>> +    return r;
>> +}
>> +
>>   int kvm_set_memory_attributes_private(hwaddr start, uint64_t size)
>>   {
>>       return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> @@ -1604,7 +1629,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>>               abort();
>>           }
>>   
>> -        if (memory_region_has_guest_memfd(mr)) {
>> +        if (memory_region_has_guest_memfd(mr) &&
>> +            !memory_region_guest_memfd_in_place_conversion(mr)) {
>>               err = kvm_set_memory_attributes_private(start_addr, slot_size);
>>               if (err) {
>>                   error_report("%s: failed to set memory attribute private: %s",
>> @@ -2779,6 +2805,9 @@ static int kvm_init(AccelState *as, MachineState *ms)
>>           kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
>>           kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
>>           (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +    kvm_guest_memfd_inplace_supported =
>> +        kvm_check_extension(s, KVM_CAP_GMEM_SHARED_MEM) &&
>> +        kvm_check_extension(s, KVM_CAP_GMEM_CONVERSION);
>>       kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>>   
>>       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
>> @@ -3056,6 +3085,7 @@ static void kvm_eat_signals(CPUState *cpu)
>>   
>>   int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>>   {
>> +    bool in_place_conversion = false;
>>       MemoryRegionSection section;
>>       ram_addr_t offset;
>>       MemoryRegion *mr;
>> @@ -3112,18 +3142,23 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>>           goto out_unref;
>>       }
>>   
>> -    if (to_private) {
>> -        ret = kvm_set_memory_attributes_private(start, size);
>> -    } else {
>> -        ret = kvm_set_memory_attributes_shared(start, size);
>> -    }
>> -    if (ret) {
>> -        goto out_unref;
>> -    }
>> -
>>       addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
>>       rb = qemu_ram_block_from_host(addr, false, &offset);
>>   
>> +    in_place_conversion = memory_region_guest_memfd_in_place_conversion(mr);
>> +    if (in_place_conversion) {
>> +        ret = kvm_set_guest_memfd_shareability(mr, offset, size, !to_private);
>> +    } else {
>> +        if (to_private) {
>> +            ret = kvm_set_memory_attributes_private(start, size);
>> +        } else {
>> +            ret = kvm_set_memory_attributes_shared(start, size);
>> +        }
>> +    }
>> +    if (ret) {
>> +        goto out_unref;
>> +    }
>> +
>>       ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
>>                                               offset, size, to_private);
>>       if (ret) {
> 
> There's one thing required for shared device assignment with in-place conversion, we need to follow the
> sequence of unmap-before-conversion-to-private and map-after-conversion-to-shared. Maybe change it like:
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index a54e68e769..e9e62ae8f2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3146,6 +3146,17 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>       addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
>       rb = qemu_ram_block_from_host(addr, false, &offset);
>   
> +    if (to_private) {
> +        ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
> +                                                offset, size, to_private);
> +        if (ret) {
> +            error_report("Failed to notify the listener the state change of "
> +                         "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
> +                         start, size, to_private ? "private" : "shared");
> +            goto out_unref;
> +        }
> +    }
> +
>       in_place_conversion = memory_region_guest_memfd_in_place_conversion(mr);
>       if (in_place_conversion) {
>           ret = kvm_set_guest_memfd_shareability(mr, offset, size, !to_private);
> @@ -3160,13 +3171,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>           goto out_unref;
>       }
>   
> -    ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
> -                                            offset, size, to_private);
> -    if (ret) {
> -        error_report("Failed to notify the listener the state change of "
> -                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
> -                     start, size, to_private ? "private" : "shared");
> -        goto out_unref;
> +    if (!to_private) {
> +        ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
> +                                                offset, size, to_private);
> +        if (ret) {
> +            error_report("Failed to notify the listener the state change of "
> +                         "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
> +                         start, size, to_private ? "private" : "shared");
> +            goto out_unref;
> +        }
>       }

(Sorry for forgetting to reply in the community)

Thanks for catching and reporting it. I have incorporated it to the 
internal branch.

