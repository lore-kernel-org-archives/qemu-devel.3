Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4B0C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKEx-0007tP-4r; Thu, 30 Jul 2026 02:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wpKEg-0007sd-KW
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 02:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wpKEd-000116-7a
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 02:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785392833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rAGSM+2wuwfv2h6+NFbhwdMvL5oh1gU5cWjQMFGOOc=;
 b=graFtrX5xoxLJilPwh6hD3BF6cjeGnN1gUWq9UUQMVb7JyQN3fSyWWl4G72hTbYowJmzzp
 uho3vSfZ9oWXHA5WaSqz/3OM5xNiE5qZB+VUN5TyQB69nSrvD/TI18W/TKNfDd+6/ug7N+
 8eBaD4F+JYEEAmCxbcK/KDzM4ILLoHk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-VE1vZI9OO1Oh-4OTyZbFjA-1; Thu, 30 Jul 2026 02:27:11 -0400
X-MC-Unique: VE1vZI9OO1Oh-4OTyZbFjA-1
X-Mimecast-MFC-AGG-ID: VE1vZI9OO1Oh-4OTyZbFjA_1785392831
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso2071640a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785392830; x=1785997630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7rAGSM+2wuwfv2h6+NFbhwdMvL5oh1gU5cWjQMFGOOc=;
 b=n2zWBJhe5r3D2/Es0wRqf8De+XaRCXah7d7pzPGYWTssJS5hm0k3/7sXdZV31Txdxw
 YO9BgxNXDtoCLgkKwtPjeMHu97hL3FvBdDnpJN8nP/D8Y3XkGBZrmuzbTtt+v57u9Iz5
 c6muBd84J/0GvY+zwu1nGTte8nvFM4SIo6C51VVFZuJ/VxF/tTTfBjTfTkQgS4+Eya8H
 BzSVN2V1/2p5Ojxgj2npLd0wzewMnWb/HFAj7cJjoKcUEXnaJkyGaJzgY/LLcEyWUr1w
 7Lq6mF45Iftv21IYJoKvhBDHG5tke+5E4QEpVPHraBTe/bpP4YK+1zqN6sOpUVc2LQS1
 Nz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392830; x=1785997630;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7rAGSM+2wuwfv2h6+NFbhwdMvL5oh1gU5cWjQMFGOOc=;
 b=eXTGDuMm/MDWRvbEyOoocCJ+9te3/+uD5FTP/9ymEqjajVL5fhQdlyaPM77SP6u6IE
 dnG2HQl7eQB1q1iRkTOTRZGabE+u2ANdxjPhpeK0kLezVhEyorBzw5+cMH4SrIEYQNkB
 MOLYY8gHoRAreo+8U6kEGxK37bOfyoIZ9RYP0R/JrgaqLPV0Dos3ZnVVHiY5sXOKZk+v
 rt+YzboM8Y7sYrZ3eKUtRNCSrl2Fy4xlItPdoFvX2cXCr8tZDfjUbSo7W3XO1kTeLdl/
 KBnH2yDPMXmtQPsaLbDDDpVjyAsQ7Yk1dVx2Jvp043T1UlTQbLfNxGi8byWzGnS8mryn
 muJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2fswIWBfQQWZrNjP2AbI0Euhk4m1wQmOdZyEjowH7yPr5TUf6Y8f4/e2HTeJdZtkQ1YCYoWcEiKgG@nongnu.org
X-Gm-Message-State: AOJu0YyPb/lfgF2DWlBI5IRJJbnABHPbeCHqJZITk3PePdaheK4DNPV4
 HgkhfY2WC1GnFx4bqSydpMiIJgnm/tnb/BSoWmcD/BE8a2qsnKf1ZCby+v7GQeJs6OS+3UL3cfE
 RCBF3ANX5A768M57FZ5odObaMqnfQsnnLZbZMu1S6aVosageM5QelHRHC
X-Gm-Gg: AR+sD13sKp5wEJSUEIAyiI1KQaRsC9vGvfAayaCJbJ6LuglhyG9m93N8bxsQ0IpIjHf
 o/MqJxt+lFlQY0kulq3vQQDkKU40140A8nkSVpdMznf496zpQapL5M+PO7kMKenTz9cKWN5k25t
 /FbmxQdOpHoGGKz01K+gNKwSGwOh2yJJvliy1TUZrdpKR4dP8ii2XyaFLLsana+3OlBj5ZdWWp6
 nICOdgSECFrYZWrVFI6Af2chnkDrRTISwcz4xqfLfK7x8ZEgQou2zEBL/M85BRduQw1DLwb9SuW
 xK1ZW02cYH6aHNoFgaPySDDevXA2D9yaLKDvXj75CZGqH2CB5RqSQNWvDcdMbykJufAzLvr8QEh
 qO/rhyg/x8aviO+onKowGkBX1FlB1YkJOogl9XZW6eIc=
X-Received: by 2002:a17:90b:1b45:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-38f9be2b44dmr1210515a91.2.1785392830409; 
 Wed, 29 Jul 2026 23:27:10 -0700 (PDT)
X-Received: by 2002:a17:90b:1b45:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-38f9be2b44dmr1210469a91.2.1785392829858; 
 Wed, 29 Jul 2026 23:27:09 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f9b994ed1sm471127a91.10.2026.07.29.23.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 23:27:09 -0700 (PDT)
Message-ID: <bd660ca5-5d39-4a5d-ab5e-90317ccb9b5d@redhat.com>
Date: Thu, 30 Jul 2026 16:26:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260728031731.286666-1-gshan@redhat.com>
 <20260728031731.286666-3-gshan@redhat.com>
 <20260729182316-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260729182316-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/30/26 8:35 AM, Michael S. Tsirkin wrote:
> On Tue, Jul 28, 2026 at 01:17:30PM +1000, Gavin Shan wrote:
>> All ram device regions were turned to be indirectly accessible by commit
>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
>> guest is started by the following command lines, with GH100 GPU card passed
>> from the host.
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
>> the memory blocks residing in the PCI BAR#4 of the GH100 GPU card can
>> be presented to the guest through memory hot-add. The page cache can
>> then be allocated from the hot added memory blocks when cuda-samples
>> is being built. Afterwards, the page cache is sent to QEMU's virtio-blk
>> device as part of the DMA request, the bounce buffer has to be used to
>> accomodate the request as the corresponding memory region (MemoryRegion)
>> is an indirectly accessible ram device region in qemu. However, the max
>> bounce bufer size is only 4096 bytes by default and that is exhausted
>> quickly, leading to a reset on the virtio-blk device and frozen guest
>> eventually.
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
>> This adds qemu_ram_move() where the aligned and small-sized accesses are
>> handled by qatomics, and fall back to memmove() otherwise. The memove()
>> for the directly accessible regions is replaced by qemu_ram_move() so that
>> the issue covered by commit 4a2e242bbb (MMIO access instructions were
>> optimized to SSE instructions) is fixed. This makes 'ram_device_mem_ops'
>> redundant, paving the way to revert that commit to make the ram device
>> region directly accessible again in the next patch.
>>
>> Besides, this also fixes the issue of the unexpected frozen reception on
>> e1000 NIC in the scenario of DPDK due to the wrong Rx queue full indication
>> caused by the following memcpy(), which is turned to 3 consective 'strb'
>> instructions to the same location by glibc-2.24+ for aarch64. With this
>> applied, the syntax of one-byte store is strictly ensured by a one-byte
>> qatomic set.
>>
>>    QEMU
>>    ====
>>    e1000_receive_iov
>>      pci_dma_write
>>        pci_dma_rw
>>          dma_memory_rw
>>            dma_memory_rw_relaxed
>>              address_space_rw
>>                address_space_write
>>                  flatview_write
>>                    flatview_write_continue
>>                      flatview_write_continue_step
>>                        memcpy    # 3 consective 'strb' instructions
>>
>> Reported-by: Julia Graham <jugraham@redhat.com>
>> Reported-by: Liu Gang <liugang24219@sangfor.com.cn>
>> Reported-by: Ding Hui <dinghui@sangfor.com.cn>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v5: Improved commit log and comments to qemu_ram_move()
>> ---
>>   hw/remote/vfio-user-obj.c |  4 ++--
>>   include/system/memory.h   | 35 ++++++++++++++++++++++++++++++-
>>   system/physmem.c          | 43 +++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 77 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
>> index ea50270628..a0498d218f 100644
>> --- a/hw/remote/vfio-user-obj.c
>> +++ b/hw/remote/vfio-user-obj.c
>> @@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
>>           ram_ptr = memory_region_get_ram_ptr(mr);
>>   
>>           if (is_write) {
>> -            memmove((ram_ptr + offset), buf, size);
>> +            qemu_ram_move((ram_ptr + offset), buf, size);
>>           } else {
>> -            memmove(buf, (ram_ptr + offset), size);
>> +            qemu_ram_move(buf, (ram_ptr + offset), size);
>>           }
>>   
>>           return 0;
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index 336d4e84a6..2965d922de 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -2668,6 +2668,39 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
>>   void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>>   
>>   /* Internal functions, part of the implementation of address_space_read.  */
>> +
>> +/**
>> + * qemu_ram_move: move data from or to ramblock
>> + *
>> + * @dst: destination where the data is moved to
>> + * @src: source where the data is moved from
>> + * @n: length of data to be moved
>> + *
>> + * Move @n bytes from @src to @dst, the memory areas may overlap. This
>> + * provides the same semantics as memmove(), plus an additional stronger
>> + * guarantee: if @n is 1, 2 or 4 or 8 bytes, and @src and @dst are both
>> + * naturally aligned for that access size, and the memory areas do not
>> + * overlap, then both the load and the store will be done as a single
>> + * atomic access (with the semantics of qatomic_read() and qatomic_set()).
>> + *
>> + * This is the underlying function that we use to implement accesses by
>> + * a guest vCPU or a device DMA operation to a ram block. The atomic
>> + * guarantee is needed for two major cases: (A) When the ram block is
>> + * backed by a PCI BAR passed through from a host device (and so it might
>> + * be hardware registers that must be accessed exactly once at the right
>> + * width); (B) When an emulated device updates a data structure shared in
>> + * guest memory with guest software (e.g. a network device's set of tx and
>> + * rx descriptor blocks), if a write to memory is accidentally performed
>> + * multiple times then it can break the guest code when it busy polls the
>> + * guest memory.
>> + *
>> + * We don't attempt to perform the exact access when it would be unaligned
>> + * because this can't be done on all host architectures. Although this is
>> + * strictly speaking not doing what would happen on real hardware, we don't
>> + * think there are going to be situations where that matters in practice.
>> + */
>> +void qemu_ram_move(void *dst, const void *src, size_t n);
>> +
>>   MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
>>                                       MemTxAttrs attrs, void *buf, hwaddr len);
>>   MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>> @@ -2741,7 +2774,7 @@ MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
>>               mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
>>               if (len == l && memory_access_is_direct(mr, false, attrs)) {
>>                   ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>> -                memmove(buf, ptr, len);
>> +                qemu_ram_move(buf, ptr, len);
>>               } else {
>>                   result = flatview_read_continue(fv, addr, attrs, buf, len,
>>                                                   addr1, l, mr);
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 2c42e365cb..fbe7df2391 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3158,6 +3158,45 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
>>       invalidate_and_set_dirty(mr, addr, size);
>>   }
>>   
>> +void qemu_ram_move(void *dst, const void *src, size_t n)
>> +{
>> +    uintptr_t test, len;
>> +
>> +    if (src == dst || n == 0) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Maximal length of aligned access that are determined by @src,
>> +     * @dst and @n
>> +     */
>> +    test = (uintptr_t)src | (uintptr_t)dst | n;
>> +    len = test & -test;
>> +
>> +    /* Overlapping buffers, unaligned or oversized access */
>> +    if (n > 8 || len != n) {
>> +        memmove(dst, src, n);
>> +        return;
>> +    }
> 
> 
> This part I don't get exactly. It's fine on most arches I think.
> x86, power...
> 
> But here is aarch64 for example:
> https://codebrowser.dev/glibc/glibc/sysdeps/aarch64/memcpy.S.html
> 
> it says
>     It uses unaligned accesses and branchless sequences to keep the code small,
>     simple and improve performance.
> 
> so if the point is to get rid of unaligned accesses to BARs, are you sure
> it achieves this?
> 

No, we don't intend to avoid the unaligned accesses to BARs if they're
existing, even on aarch64. The behavior is consistent to that introduced
by 'ram_device_mem_ops'. When 'ram_device_mem_ops' is in place of upstream
'master' branch, the unaligned access is put through, without splitting
it to aligned accesses because 'ram_device_mem_ops::{valid, impl}.unaligned'
have been set to true.

> 
>> +
>> +    switch (len) {
>> +    case 1:
>> +        qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
>> +        break;
>> +    case 2:
>> +        qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
>> +        break;
>> +    case 4:
>> +        qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
>> +        break;
>> +    case 8:
>> +        qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>>   int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>>   {
>>       unsigned access_size_max = mr->ops->valid.max_access_size;
>> @@ -3270,7 +3309,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>>                                                  false, true);
>>   
>> -        memmove(ram_ptr, buf, *l);
>> +        qemu_ram_move(ram_ptr, buf, *l);
>>           invalidate_and_set_dirty(mr, mr_addr, *l);
>>   
>>           return MEMTX_OK;
>> @@ -3363,7 +3402,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>>                                                  false, false);
>>   
>> -        memmove(buf, ram_ptr, *l);
>> +        qemu_ram_move(buf, ram_ptr, *l);
>>   
>>           return MEMTX_OK;
>>       }

Thanks,
Gavin



