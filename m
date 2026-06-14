Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5823FCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhlS-0001hO-CV; Sun, 14 Jun 2026 06:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYhlL-0001gw-6p
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYhlI-0005Se-VM
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781431694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afVhQtgT0jEJr2fWN17WKpUFztLGmPccOa+7wVlKhKg=;
 b=XlhJZBbR+1QhQTvW7P5s2pWkJh4liHJeJLzX9N1223xoqs71ajteXun7yZ1FO1xqxb+Adn
 87FVxB4mVmSklZI0rbzERZVWPp7PNdFuSV/MLP8C03mspSwRdyOUbq+hPrZt+Ak4VJkf4R
 ZP4oYVL9vGdn6s+2gBL/lNnpGHh+Fv0=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-8NFZYSI7P4KfdHxZPYXcew-1; Sun, 14 Jun 2026 06:08:12 -0400
X-MC-Unique: 8NFZYSI7P4KfdHxZPYXcew-1
X-Mimecast-MFC-AGG-ID: 8NFZYSI7P4KfdHxZPYXcew_1781431692
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-13967c19ac6so2196677c88.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781431692; x=1782036492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afVhQtgT0jEJr2fWN17WKpUFztLGmPccOa+7wVlKhKg=;
 b=JcZteJ686dfq+INmeGK+uozwuUWNzpAxPJWsFLpizeMp3komiqDC+HIYDF8Gpr7Qga
 SD/72uFhIr+BiPYavhMVsXQDA0Dfs9fpcM724sT7AmHdi8eVC9i2IuwxFlXYsYv9fpJw
 q0KtMKJiYjHbKaTIwZfdBSJrWmldumpqNmmARTLT0akVyoSWFnncWxvWw6MeklV/Ll+/
 8AQNsFLP4wzFoBdVSeQnSkj3D5EAZl389jYT1HbtLEIV2bObpRUOI5dny7Ua8Xwr1IyB
 A46aCBE99Yebec058Md452KA9il26In0cj+jSr7d0Gl8xE5LhWHFkMx0Q3GhdSEWloUm
 kEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781431692; x=1782036492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=afVhQtgT0jEJr2fWN17WKpUFztLGmPccOa+7wVlKhKg=;
 b=ZVSrZBk/BHV21tDUgndhYvtUDp2Qx9r0p+kns4CWTPtbne5npepDkCGow/Esc1yLSW
 p44+lv6rcll2Hs+kCiRk4kifWU7DlebVZ78USzrUHvtpj3lJUKqrtDHYBQIw4XUs5rkk
 +eXUuNPswqXLx9Nbm+5mocBDJSy8qO+jvp6b7NRql+kaA82HyAopyf/c+RquKgKA0XZk
 JhvhnTfKiuokqE8AXW8Fa+FQ77vGfhjAvmpQjW3vMFpoH8Krm84xhvgdqdYKGS1XMuKY
 wGBvIX9/BkjwWxH0KQh3dF83fCwSnLpXSmi6ZF8ZrppP3rvh6t4WZlSDerwyPa9ckMek
 H7CQ==
X-Gm-Message-State: AOJu0YzzIOnT7mdXh+OfhH/EHSAE00opbApg9ZQCCDS5OdRdtHj0OBvG
 ob7fjVMHKm78ZaaBzQgdiBBKDzHPecKrFQCbfLp8CmdbwIemN/uMTfZG927GwEfPSkp9kv6b5Nk
 mWUKuaEGNNkbCuoNYeEwGSJ4cxMOJYFppYn2PzA2SBvKI3RijLDPrlV4t
X-Gm-Gg: Acq92OGwbcfigSRujk+5juxDAlsVgIhcNpAUtLnipbx0n79XakMjFxOJGJ+QFgPYC2O
 o+apvt5s4rycdhDjgD0cGiGax4hqlWFu8IwrpI6I32WbohqYXV6kXOK5OqdjHpKiV7Gq5f7X+Ne
 nQ3NRUuZs5NNZKjyGOL59IqhuQ1MGn8QtT7jf9HvwDymhthAMaWgqTSBdWeGGysE0mnPEGaszGY
 TYqkVlZMexHntjs/mB1e7xM9k8tTWrnhhUEnq0lcQWU9ufzsIiTBNs0FPz3ZSiohvlNB7yjdzK5
 rPO80QL7I0fr+Db8el4iCEnRJ7rF+3kVOeWeGZX9A66ntlxF7D+N1F96M/ziO0k8M9VAUGwqnpD
 K1rcIxzktuQvvqXo74Rv3bETAQGQq/7wbkRUFt3bxvP3tgU/Asc6bNCH14l6AnGNT
X-Received: by 2002:a05:7022:684:b0:132:1de0:1295 with SMTP id
 a92af1059eb24-1386f37ee84mr3047322c88.17.1781431691572; 
 Sun, 14 Jun 2026 03:08:11 -0700 (PDT)
X-Received: by 2002:a05:7022:684:b0:132:1de0:1295 with SMTP id
 a92af1059eb24-1386f37ee84mr3047308c88.17.1781431691069; 
 Sun, 14 Jun 2026 03:08:11 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm10488195eec.9.2026.06.14.03.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2026 03:08:10 -0700 (PDT)
Message-ID: <be8680c9-b654-4369-8813-1a3d0325d82b@redhat.com>
Date: Sun, 14 Jun 2026 20:08:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 peter.maydell@linaro.org, berrange@redhat.com, david@kernel.org,
 alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, shan.gavin@gmail.com
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <aa8b97e2-14da-4df1-9b61-33e01b5cffce@oss.qualcomm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <aa8b97e2-14da-4df1-9b61-33e01b5cffce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On 6/13/26 12:05 AM, Philippe Mathieu-Daudé wrote:
> Hi Gavin,
> 
> On 12/6/26 13:03, Gavin Shan wrote:
>> All ram device regions was turned to be indirectly accessible by commit
>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>> to guest hang on compiling 'cuda-samples' as reported by Julia. The guest
>> is started by the following command lines, with a GH100 GPU card.
>>
>>     host$ lspci | grep GH100
>>     0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>>     host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
>>           -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>>           -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
>>           -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>>           -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>>           -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>>             :
>>     guest$ cd cuda-samples/build
>>     guest$ make -j 20 clean
>>     guest$ make -j 20
>>             :
>>     [ 54%] Linking CUDA executable graphMemoryNodes
>>     [ 54%] Built target graphMemoryNodes
>>     <no more output afterwards, guest becomes frozen here>
>>
>>     guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>     [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
>>
>> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
>> the memory blocks residing in the PCI BAR#4 can be presented to the
>> guest through memory hot-add. The page cache can be allocated from the
>> hot added memory blocks when cuda-samples is being compiled. Afterwards,
>> the page cache is sent to QEMU's virtio-blk device as part of the DMA
>> request, the bounce buffer has to be used to accomodate the request as
>> the corresponding memory region (MemoryRegion) is a RAM DEVICE region
>> and indirectly accessible in qemu. However, the max bounce bufer size
>> is only 4096 bytes by default. We're running out of that space quickly.
>>
>>    QEMU
>>    ====
>>    virtio_blk_handle_output
>>      virtio_blk_handle_vq
>>        virtio_blk_get_request
>>          virtqueue_pop
>>            virtqueue_split_pop
>>              virtqueue_map_desc
>>                address_space_map
>>                  memory_access_is_direct         # Return false
>>                    memory_region_supports_direct_access
>>
>>    (qemu) info mtree
>>    memory-region: pci_bridge_pci
>>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
>>
>> This replaces mem{cpy, move} with __builtin_mem{cpy, move} in the memory
>> accessors to ram device memory region, preparatory work to make ram device
>> region directly accessible and bypass the bounce buffer in the DMA path
>> in next patch.
>>
>> Reported-by: Julia Graham <jugraham@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/remote/vfio-user-obj.c |  4 ++--
>>   include/system/memory.h   | 42 ++++++++++++++++++++++++++++++++++++++-
>>   system/physmem.c          |  8 ++++----
>>   3 files changed, 47 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
>> index 87fa7b6572..fe6f661fe2 100644
>> --- a/hw/remote/vfio-user-obj.c
>> +++ b/hw/remote/vfio-user-obj.c
>> @@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
>>           ram_ptr = memory_region_get_ram_ptr(mr);
>>           if (is_write) {
>> -            memcpy((ram_ptr + offset), buf, size);
>> +            address_space_memcpy(ram_ptr + offset, buf, size);
>>           } else {
>> -            memcpy(buf, (ram_ptr + offset), size);
>> +            address_space_memcpy(buf, ram_ptr + offset, size);
>>           }
>>           return 0;
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index 1417132f6d..6bb2e13eea 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -2938,6 +2938,46 @@ static inline bool memory_access_is_direct(const MemoryRegion *mr,
>>       return true;
>>   }
>> +static inline void address_space_memcpy(void *dest, const void *src, size_t n)
> 
> 'address_space_' prefix for something that doesn't use neither
> AddressSpace nor MemoryRegion is odd.
> 
> Maybe prefix 'qemu_ram_' or 'qemu_ram_ptr_' instead? (since the
> address is returned by memory_region_get_ram_ptr)
> Add the definitions in "system/ramblock.h" with that declaration?
> 

Yes, they have been renamed to qemu_ram_{copy, move}() and moved to
system/ramblock.h in local repo. The changes will be seen in the next
revision.

>> +{
>> +    switch (n) {
>> +    case 1:
>> +        __builtin_memcpy(dest, src, 1);
>> +        break;
>> +    case 2:
>> +        __builtin_memcpy(dest, src, 2);
>> +        break;
>> +    case 4:
>> +        __builtin_memcpy(dest, src, 4);
>> +        break;
>> +    case 8:
>> +        __builtin_memcpy(dest, src, 8);
>> +        break;
>> +    default:
>> +        __builtin_memcpy(dest, src, n);
>> +    }
>> +}
>> +
>> +static inline void address_space_memmove(void *dest, const void *src, size_t n)
>> +{
>> +    switch (n) {
>> +    case 1:
>> +        __builtin_memmove(dest, src, 1);
>> +        break;
>> +    case 2:
>> +        __builtin_memmove(dest, src, 2);
>> +        break;
>> +    case 4:
>> +        __builtin_memmove(dest, src, 4);
>> +        break;
>> +    case 8:
>> +        __builtin_memmove(dest, src, 8);
>> +        break;
>> +    default:
>> +        __builtin_memmove(dest, src, n);
>> +    }
>> +}
>> +
>>   /**
>>    * address_space_read: read from an address space.
>>    *
>> @@ -2970,7 +3010,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>>               mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
>>               if (len == l && memory_access_is_direct(mr, false, attrs)) {
>>                   ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>> -                memcpy(buf, ptr, len);
>> +                __builtin_memcpy(buf, ptr, len);
>>               } else {
>>                   result = flatview_read_continue(fv, addr, attrs, buf, len,
>>                                                   addr1, l, mr);
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 7bcbf87573..5f46a9d676 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3272,7 +3272,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>>                                                  false, true);
>> -        memmove(ram_ptr, buf, *l);
>> +        address_space_memmove(ram_ptr, buf, *l);
>>           invalidate_and_set_dirty(mr, mr_addr, *l);
>>           return MEMTX_OK;
>> @@ -3365,7 +3365,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>>                                                  false, false);
>> -        memcpy(buf, ram_ptr, *l);
>> +        address_space_memcpy(buf, ram_ptr, *l);
>>           return MEMTX_OK;
>>       }
>> @@ -3503,8 +3503,8 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>>               l = memory_access_size(mr, l, addr1);
>>           } else {
>>               /* ROM/RAM case */
>> -            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>> -            memcpy(ram_ptr, buf, l);
>> +            address_space_memcpy(qemu_map_ram_ptr(mr->ram_block, addr1),
>> +                                 buf, l);
>>               invalidate_and_set_dirty(mr, addr1, l);
>>           }
>>           len -= l;
> 

Thanks,
Gavin


