Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69F0C531D0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woY47-0000pP-Vh; Mon, 27 Jul 2026 23:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woY46-0000pC-II
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woY44-0003vZ-0c
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785207666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWSHHN/6F57IKmAuhdjRli/I7RzIOFbOhYHDCQ1YlNY=;
 b=JKBB/3yRz5uPlvzViHbNRgDHWRpmpup47cHkXGAOyD6RjUahA+yFdNKDYXhGZDmGj/ZnOu
 POqb4+u0CrBRlWb3f0Aw7rAN09PLCAHK3GqfEgq8Gbikscp1x8SEtJ3/f3VTDP8pKMCTaf
 2POuaAJ1X3/4MgUv6JYYdU4UN1MrO1U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-VoMSrFcvPc65iBPom8FdPw-1; Mon, 27 Jul 2026 23:01:05 -0400
X-MC-Unique: VoMSrFcvPc65iBPom8FdPw-1
X-Mimecast-MFC-AGG-ID: VoMSrFcvPc65iBPom8FdPw_1785207664
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848860def2cso3839567b3a.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 20:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785207664; x=1785812464; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TWSHHN/6F57IKmAuhdjRli/I7RzIOFbOhYHDCQ1YlNY=;
 b=nARG00OKXhCKPEsfghq7k4dKqBQMDoBhk+TRYZvmzuPpTFbl1qySUO9YgT3Wm58+jx
 KIdQYNoPcRhRKMvv5ReXatrrLT7PHfPauDmhEqJ+rMNzuNqqo8hPiTCQG2aEYBjCAw1q
 q8oO0Bp2e5luSsA4mq5c8tstbt25GQJI0RbA0uxfstKSJA0HJ4fnOKHttSAQoyf3cEQM
 xMCq051UZmMIY4WgJO0VYmPABH0W0K3KVGWAsnTJCKjkl67QyCUZW6jv5CYUoA8uXzc/
 S7vmZnCGA1S5ng8nLo/rMPLWgtsiD6PClQHrD0W/JC+DsnJzp0Pl22DCYwJrOm40awjW
 yaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785207664; x=1785812464;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TWSHHN/6F57IKmAuhdjRli/I7RzIOFbOhYHDCQ1YlNY=;
 b=P/kI+3JxgCiOSVd5tw3LyMrSdyT7hX4J7M8on3Ov0VyLTnN2PSfxthhSMHJMdtMFxl
 +Yb/tNlS/szFXT14ZnQyg16JsGLH30t8zsXe/SoDxP7zXxy9JNaTGcCPsFn6Diw/ppWD
 DU8hMzGvwJMPK64HEzvmMB1tbdSyE9QSlzxSpmlRkjxdfRxWoLXPaohkTWdyyBnJJuwp
 S6qksaGL8F9a138sHSmUk0hIT8V2WTo9ZF2BA0YHbbzSSsjW7RkJla1IaLG+2vQmMmgT
 mxYGecbDM7ff4XEQCkJrihq4P1IQUmyrWFUaOkWdKIZ7nq8CqU93Hhoj6ppVUMSc0qdQ
 /JEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYcq9RX3jttaEbRPLh3uk7yWr0lvRduwQLKuM8I3TjyA6S9QtRpgWSKJubq337lOPMDcLD7+uHcQGH@nongnu.org
X-Gm-Message-State: AOJu0Yx+V9wCxYik8v+7oS0q0RFnmtZemqBl5eDOwp0NK1sYisyWkEQB
 NZKBwBArqp+C0yltyc1bhb5Iq4MEAvO6dch81kfYUvIQhdkhNuXMQgEAKACuSQdSprtryQAcWZZ
 pzP40korsGIrLFHESyFms0PjnxTMSDM9geSEJIA/62qY0rxpJ2ZYZbN0r
X-Gm-Gg: AR+sD10URba3mm0uirPM8/xx4xxfABzVYYGhuM0PZfOUKdinIWMv+wQzawbCAp8U2dn
 nG6H/XwFjWewtY/tMKSA1vnvSSzaZo2btvsU9/bElkZ93zQ5GccGkVCuZWNMinDcaGaKENsAxnB
 eI4XB6OYSbuVuiEGlIT0w3/Z8SIn2OkU+a7SmPCcL3Wn4HXOzHU1gAT5+B7bRhqD3KaZGd8khvo
 YBlKnTU2EzQ4vwdgUulswawYTz8ReRiCptejKohCATKr31ww3Z4rZy95UXvV5AfANRjjWIUqvr4
 lv2Ycmx0uD5bH5hR6tMdciWoQ2HdBZyiDc3EI+Q6mgNViSjifZNZKPg5vB8g+wKsuu2ualAy78S
 erQ9vHd/0D9abfnGl0TWn17HP/RnCorQNup6Sw3Q9orM=
X-Received: by 2002:a05:6a00:a21c:b0:847:712d:19ac with SMTP id
 d2e1a72fcca58-84e931ec86dmr510212b3a.8.1785207663789; 
 Mon, 27 Jul 2026 20:01:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:a21c:b0:847:712d:19ac with SMTP id
 d2e1a72fcca58-84e931ec86dmr510175b3a.8.1785207663156; 
 Mon, 27 Jul 2026 20:01:03 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e534694a7sm3767982b3a.59.2026.07.27.20.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 20:01:02 -0700 (PDT)
Message-ID: <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
Date: Tue, 28 Jul 2026 13:00:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 mst@redhat.com, philmd@oss.qualcomm.com, richard.henderson@linaro.org,
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/27/26 10:51 PM, Peter Maydell wrote:
> On Mon, 27 Jul 2026 at 04:27, Gavin Shan <gshan@redhat.com> wrote:
> 
> Initial note: I think this is basically the right thing; I have
> some suggestions for beefing up the doc comment and some minor
> other things below.
> 

Thanks for your review and comments.

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
> 
> I think this commit message should also describe the second category
> of bug that we intend it to fix: the one where a device does e.g.
> address_space_stb() to a data structure in guest memory and requires
> it to write exactly that byte exactly once.
> 

Yes, making sense. I've added below context for (v5), which will be
posted shortly.

---

Besides, this also fixes the issue of the unexpected frozen reception on
e1000 NIC in the scenario of DPDK due to the wrong Rx queue full indication
caused by the following memcpy(), which is turned to 3 consective 'strb'
instructions to the same location by glibc-2.24+ for aarch64. With this
applied, the syntax of one-byte store is strictly ensured by a one-byte
qatomic set.
     
   QEMU
   ====
   e1000_receive_iov
     pci_dma_write
       pci_dma_rw
         dma_memory_rw
           dma_memory_rw_relaxed
             address_space_rw
               address_space_write
                 flatview_write
                   flatview_write_continue
                     flatview_write_continue_step
                       memcpy    # 3 consective 'strb' instructions


>> Reported-by: Julia Graham <jugraham@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -2666,6 +2666,21 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
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
>> + * Move @n bytes from @src to @dst with the assumption that @src and @dst
>> + * can overlap. The access is atomic if the source and destination buffer
>> + * aren't overlapped for a well aligned and small-sized access. Otherwise,
>> + * fall back to the standard memmove().
>> + */
> 
> I think we could usefully expand this comment, because the reasons
> we need it are not immediately obvious. How about:
> 
> ===begin===
> Move @n bytes from @src to @dst; the memory areas may overlap.
> This provides the same semantics as memmove(), plus an additional
> stronger guarantee: if @n is 1, 2 or 4 or 8 bytes, and @src
> and @dst are both naturally aligned for that access size, and
> the memory areas do not overlap, then both the load and the store
> will be done as a single atomic access (with the semantics of
> qatomic_read() and qatomic_set()).
> 
> This is the underlying function that we use to implement accesses
> by a guest vCPU or a device DMA operation to a ram block. The
> atomic guarantee is needed for two major cases:
>   - when the ram block is backed by a PCI BAR passed through
>     from a host device (and so it might be hardware registers
>     that must be accessed exactly once at the right width)
>   - when an emulated device updates a data structure shared in
>     guest memory with guest software (e.g. a network device's
>     set of tx and rx descriptor blocks), if a write to memory
>     is accidentally performed multiple times then it can break
>     the guest code.
> 
> We don't attempt to perform the exact access when it would
> be unaligned, because this can't necessarily be done on
> all host architectures; although this is strictly speaking
> not doing what would happen on real hardware, we don't think
> there are going to be situations where that matters in practice.
> ===endit===
> 
> ?
> 

Thanks for the suggested comments to qemu_ram_move(), which looks much
clearer than what we had. I've integrated this for (v5) with minor format
adjustment.

> (if you take my suggestion below, then delete "and the
> memory areas do not overlap", because the only case
> where the accesses are naturally aligned and they
> overlap is the case of src == dst)
> 

I would keep the check (src == dst), see the explanation below.

> 
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 2c42e365cb..18485f7b08 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3158,6 +3158,41 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
>>       invalidate_and_set_dirty(mr, addr, size);
>>   }
>>
>> +void qemu_ram_move(void *dst, const void *src, size_t n)
>> +{
>> +    uintptr_t test, len;
>> +
>> +    if (src == dst || n == 0) {
> 
> I think we should not bother testing for src == dst. It's
> vanishingly unlikely to actually happen, and if it does
> happen then the code will work fine, and it's probably better
> to actually do the access in that case than to skip it.
> 

We can drop the check of (src == dst), but it will introduce inconsistent
behaviors. For example, qemu_ram_move(0x1, 0x1, 0x2) is finally turned to
memmove(0x1, 0x1,0x2) where no memory movement happens in glibc::memmove(),
but qemu_ram_move(0x0, 0x0, 0x2) is turned to qatomic_set((uint16_t *)dst,
qatomic_read((uint16_t *)src)) where we do have memory movement happening.
So I would like to keep the check of (src == dst) in order for the consistent
behaviors.

>> +        return;
>> +    }
>> +
>> +    test = (uintptr_t)src | (uintptr_t)dst | n;
>> +    len = test & -test;
> 
> What is this doing? I am not a fan of clever bit twiddling
> that isn't commented to explain itself. Readers of the code
> shouldn't have to go off and search for an explanation of what
> is going on.
> 

The following comments will be added for (v5).

     /*
      * Maximal length of aligned access that are determined by @src,
      * @dst and @n
      */

>> +
>> +    /* Overlapping buffers, unaligned or oversized access */
>> +    if (n > 8 || len != n) {
>> +        memmove(dst, src, n);
>> +        return;
>> +    }
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

Thanks,
Gavin


