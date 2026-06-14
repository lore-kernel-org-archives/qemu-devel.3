Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E6CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhi4-0000u1-SE; Sun, 14 Jun 2026 06:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYhi3-0000sf-4J
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYhi0-0003d2-TP
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781431490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4R8G+o9zCfTrKQp5PbdL8L6nzHQZMz3WByySAYZdbg=;
 b=iCmzYcLNSWFPtj9ubNF1xgybDOp8GIAMhXkFB1Dfh1h9gvz+bwtwNMs5xO+PThAj5o7pvD
 RqFjQCbE8Oa180nPk3dN6wCgAROxxMHdB6mfmTbffHcaAQkWL7Oz+cNZ6uYZtUrI2dDvZL
 hymeRfEgzot/zQ0IyYyv2qcoKxWW87o=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-51sqC2uNMa-SWHQP7jWWWg-1; Sun, 14 Jun 2026 06:04:49 -0400
X-MC-Unique: 51sqC2uNMa-SWHQP7jWWWg-1
X-Mimecast-MFC-AGG-ID: 51sqC2uNMa-SWHQP7jWWWg_1781431488
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso2076544eec.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781431488; x=1782036288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4R8G+o9zCfTrKQp5PbdL8L6nzHQZMz3WByySAYZdbg=;
 b=pTYKMHsPljpxlV+o9m/cT2a5pFUGqbnscU24KDha7lBa8flrEFDPzvdEewSqblOzXv
 TYVJZJZ03yoXHiPddYJy8Ff2BqeydRt0VTaic8u8FH/FEuKu+4SqzXnAI98kmjyxopCD
 kGLy6RaEjyVwUBkOk83VTP6ltZcTOqKCh5QKUdCGwB3yaJNx9BBJyXfhZUIw9QY2ewP0
 bJgu7zqQBxW1/NIXMhHNlNe4YWPAOOJwHhZ0+ThihF3k5A8j4wn7+m+xz1qNmK/slG0+
 JZFbZ3SWIHvonT0p7tCvHfhatHZV1ZNoAV5K47UG1E8pOuGyQppoL/QYdVrf8zc7oyyO
 loUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781431488; x=1782036288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4R8G+o9zCfTrKQp5PbdL8L6nzHQZMz3WByySAYZdbg=;
 b=YWsLcJie0cCq0+q27Pl/nrClkwy/TXpn/8Vk1RhwL1v9OztsCGOS57QvUgD+oDHTu0
 y3QpCJVhNi4HSDuZsTD6UVcNsnfLSB/aieRV1aXzaPn7gDO27pSZPR23gpZBAlF9vY90
 eBYkJIc0Klt6prB9lcQUEEGyPFXOICxKTzCFKymbru6yoXkwlmL0dYa7x7YYRUw+7KSs
 UPSQ9RNAoPZT/PlPCEUiB5z8gYsfeEgFBNokB8xvXLjo5836EE4GFwbtiJi8vHEhPUKu
 Pyv3V8wgOusjf4ulrGbEcsunde64MFSZ8WNMjqZFMwk3EjI5p6vc2x/WWiYWCK8gJMwa
 5FEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sQW8VV0n9ktSZUf2f2a4uftHKDpiTwR4w88ve913X2H9hj0oCd9jDyE9FayHpp1o5Z97YnobpNBCm@nongnu.org
X-Gm-Message-State: AOJu0YzR17SG6PpHaQe3XK1Qk+495zmSIMqwaYQ5qrciRAAYAES5IVe0
 +4eV/59cUIsGJpzMaq7ROGSt+ITXp6ly9wJ4BgpAMmocy0sdM0taWl/RxzPyIop3KZVzNpqtSOW
 1Rty8zXQ89Fs6RVZeHA1fPwdfb7aPuyjIfMP1iW4G19uIOeact4FunzjD
X-Gm-Gg: Acq92OHvbSD5FidWsGpE7kUmA0VhzQUMO5bz51G3CQN4KtQKHCdSorAp0h4kp4hDnlV
 DiQk/Wneu9IWYD+F2hdNPApMsD68I5ylsyijGqSZH+3oWziK01ZD4vKVJEpjbKdZzUQJSbM8Luc
 /7oHMwbuZmVYi1+DajM0bQnwLZpCap5sf1lQ/f1TcoLpiWx7RhsVuJqN/V47vNhGLmtfZKVnlvr
 oAsTy9sETx3xoaNQZNWQNhC19gk/JpEy5R4xs7B23WTtZ8d6Ab54+U5llMxc5NG9GMTWugdR4Pi
 t0bl9V7ck8Jmqs7129aar4xvlZbMDqBPd10UoZf615Jfg94G72TOz6itqUMiHdhE07Fo9R5qoAQ
 eIUHo06L9nVXvIjyDM4wsNujdtgnt0bXzxPkr1Kk2YhJJKdMyajKK/vUTOz1eqcEu
X-Received: by 2002:a05:7300:818c:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-3093816c7cemr3586662eec.3.1781431487771; 
 Sun, 14 Jun 2026 03:04:47 -0700 (PDT)
X-Received: by 2002:a05:7300:818c:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-3093816c7cemr3586649eec.3.1781431487071; 
 Sun, 14 Jun 2026 03:04:47 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e489536sm10721263eec.2.2026.06.14.03.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2026 03:04:46 -0700 (PDT)
Message-ID: <b0675436-4d6c-43ae-8cd5-bca97939a832@redhat.com>
Date: Sun, 14 Jun 2026 20:04:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 peter.maydell@linaro.org, berrange@redhat.com, david@kernel.org,
 alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <20260612072144-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260612072144-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/12/26 9:22 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 12, 2026 at 09:03:06PM +1000, Gavin Shan wrote:
>> All ram device regions was turned to be indirectly accessible by commit
>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>> to guest hang on compiling 'cuda-samples' as reported by Julia. The guest
>> is started by the following command lines, with a GH100 GPU card.
>>
>>     host$ lspci | grep GH100
>>     0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>>     host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
>>           -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>>           -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
>>           -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>>           -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>>           -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>>             :
>>     guest$ cd cuda-samples/build
>>     guest$ make -j 20 clean
>>     guest$ make -j 20
>>             :
>>     [ 54%] Linking CUDA executable graphMemoryNodes
>>     [ 54%] Built target graphMemoryNodes
>>     <no more output afterwards, guest becomes frozen here>
>>
>>     guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>     [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
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
>>    QEMU
>>    ====
>>    virtio_blk_handle_output
>>      virtio_blk_handle_vq
>>        virtio_blk_get_request
>>          virtqueue_pop
>>            virtqueue_split_pop
>>              virtqueue_map_desc
>>                address_space_map
>>                  memory_access_is_direct         # Return false
>>                    memory_region_supports_direct_access
>>
>>    (qemu) info mtree
>>    memory-region: pci_bridge_pci
>>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
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
>>   hw/remote/vfio-user-obj.c |  4 ++--
>>   include/system/memory.h   | 42 ++++++++++++++++++++++++++++++++++++++-
>>   system/physmem.c          |  8 ++++----
>>   3 files changed, 47 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
>> index 87fa7b6572..fe6f661fe2 100644
>> --- a/hw/remote/vfio-user-obj.c
>> +++ b/hw/remote/vfio-user-obj.c
>> @@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
>>           ram_ptr = memory_region_get_ram_ptr(mr);
>>   
>>           if (is_write) {
>> -            memcpy((ram_ptr + offset), buf, size);
>> +            address_space_memcpy(ram_ptr + offset, buf, size);
>>           } else {
>> -            memcpy(buf, (ram_ptr + offset), size);
>> +            address_space_memcpy(buf, ram_ptr + offset, size);
>>           }
>>   
>>           return 0;
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index 1417132f6d..6bb2e13eea 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -2938,6 +2938,46 @@ static inline bool memory_access_is_direct(const MemoryRegion *mr,
>>       return true;
>>   }
>>   
>> +static inline void address_space_memcpy(void *dest, const void *src, size_t n)
>> +{
>> +    switch (n) {
>> +    case 1:
>> +        __builtin_memcpy(dest, src, 1);
>> +        break;
>> +    case 2:
>> +        __builtin_memcpy(dest, src, 2);
>> +        break;
>> +    case 4:
>> +        __builtin_memcpy(dest, src, 4);
>> +        break;
>> +    case 8:
>> +        __builtin_memcpy(dest, src, 8);
>> +        break;
>> +    default:
>> +        __builtin_memcpy(dest, src, n);
>> +    }
>> +}
>> +
>> +static inline void address_space_memmove(void *dest, const void *src, size_t n)
>> +{
>> +    switch (n) {
>> +    case 1:
>> +        __builtin_memmove(dest, src, 1);
>> +        break;
>> +    case 2:
>> +        __builtin_memmove(dest, src, 2);
>> +        break;
>> +    case 4:
>> +        __builtin_memmove(dest, src, 4);
>> +        break;
>> +    case 8:
>> +        __builtin_memmove(dest, src, 8);
>> +        break;
>> +    default:
>> +        __builtin_memmove(dest, src, n);
>> +    }
>> +}
>> +
>>   /**
>>    * address_space_read: read from an address space.
>>    *
> 
> 
> The variable length probably should use the regular memcpy/memmove -
> no reason to bypass fortification for these.
> 

Fixed locally and the changes will be included in next revision.

> 
>> @@ -2970,7 +3010,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>>               mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
>>               if (len == l && memory_access_is_direct(mr, false, attrs)) {
>>                   ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>> -                memcpy(buf, ptr, len);
>> +                __builtin_memcpy(buf, ptr, len);
>>               } else {
>>                   result = flatview_read_continue(fv, addr, attrs, buf, len,
>>                                                   addr1, l, mr);
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 7bcbf87573..5f46a9d676 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3272,7 +3272,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>>                                                  false, true);
>>   
>> -        memmove(ram_ptr, buf, *l);
>> +        address_space_memmove(ram_ptr, buf, *l);
>>           invalidate_and_set_dirty(mr, mr_addr, *l);
>>   
>>           return MEMTX_OK;
>> @@ -3365,7 +3365,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>>                                                  false, false);
>>   
>> -        memcpy(buf, ram_ptr, *l);
>> +        address_space_memcpy(buf, ram_ptr, *l);
>>   
>>           return MEMTX_OK;
>>       }
>> @@ -3503,8 +3503,8 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>>               l = memory_access_size(mr, l, addr1);
>>           } else {
>>               /* ROM/RAM case */
>> -            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>> -            memcpy(ram_ptr, buf, l);
>> +            address_space_memcpy(qemu_map_ram_ptr(mr->ram_block, addr1),
>> +                                 buf, l);
>>               invalidate_and_set_dirty(mr, addr1, l);
>>           }
>>           len -= l;
>> -- 
>> 2.54.0
> 

Thanks,
Gavin


