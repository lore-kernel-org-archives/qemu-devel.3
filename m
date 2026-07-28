Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB2AC531D0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woYCh-0002DO-H9; Mon, 27 Jul 2026 23:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woYCe-0002Cd-D8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woYCc-0004XH-Fw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785208197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7atVvkESJiyubkdX4WuRrIlDRsr5miLdI9X8mc3BjU=;
 b=BrldHwKL1432zklC5ZMNE1Ff5hUVWPkyN2e78VH/M2a9OQuH7eeU90N59xGrGsbpvDgjTJ
 /y/bIgp1C12TtaCvJtgUCaNAjszhhA5618tZ4HPwm2NKLMvmziSc+5lHEZnTrJTfYLcb9E
 jb3sVPHIL4hxoOUYVqNDSgZwxQ9AYRA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-yuIyomFsN_qRATXa9Yp9Yg-1; Mon, 27 Jul 2026 23:09:56 -0400
X-MC-Unique: yuIyomFsN_qRATXa9Yp9Yg-1
X-Mimecast-MFC-AGG-ID: yuIyomFsN_qRATXa9Yp9Yg_1785208195
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84a3514f912so5955230b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785208195; x=1785812995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U7atVvkESJiyubkdX4WuRrIlDRsr5miLdI9X8mc3BjU=;
 b=GHjv1C59c26cg6nTZY/JAyen845iWSnXd7vJNMJh0zKY3n3MwKCiG36phEcoUP2wYb
 99Z9O2CprqYbppCGMZJtZTBoexZ2KLTaxKcYiA7vMrj9Ik203ezG5nJK6GE2Zo21cVsp
 FhVj8MWVTNQ0ilofQFg8VHsZmTV+UvXm5BBoEYdG68Fd2XezAeeBMDson+ScZYRuRH+E
 o3zbNHHmnfwxQP2ofkO039E5OnMSxS6zEWnKnUv1vJAuACaZRyhIHEIYpLp5m8EaT9GA
 F9OrvCQC7layavggqr3vC6HpQLRL7oPcsgY4bauNAz+cW0GXrddfl+p16eJjn5+bG4vS
 Etgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785208195; x=1785812995;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U7atVvkESJiyubkdX4WuRrIlDRsr5miLdI9X8mc3BjU=;
 b=gnRcliRL1PRdFIMsEk025miBv1hVPxOKmQR/IBqpcOk3cpSCzoyaoNQC0BsSRkRxEd
 3KZAgFhvZENC4OxaQNvcmjnJkDq5XeBx226wWTcUZhTVzSwz2yZieJYm2EIq2GQMosrK
 0aAqquJxwhhuOzwLydh4W+qwnd6SCFqXsp4eD8nr3W2lqm+KME13nvsjpoyLyglXIwru
 Yxeorr6W+csggRNWOgEKy6R0pil/VmlYFFzelFiOKVX8wyudpMYxxEOaqIqADL2SKsaN
 73InY3SEejcM9Nst+53q3Lnd+4NPj5ge+z5DVGF/hHl0uC9pVu9soZ3zCkhmfbIsCRlY
 0P2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqC7l4E3eTirk3cW5ld1YUnWZCBbwEZxYYjzDRi5zt4WU2dQvdyOSATl/352Z7nrCcAXYKXo7J4eLx@nongnu.org
X-Gm-Message-State: AOJu0YxgPZWdT2aRmKBX/cvETXlDmLutPZKbhRuEbHr7suawT4OjZkaX
 k4miKgUwY/JY8/YxPC/egR0c2TCxw5VvwSubofquFqFH840A6VsLFev4Tl5bNF90YtT5UVUD5HC
 BxxOH8iNs26F4mIkbFbbYxsDz2AMkUBqwN9zmvaEUfSUgcpEUCx+zd2o8
X-Gm-Gg: AR+sD100fVdXjEzZNYHN9HL2ylrE2B6S2xMYB1a1TFzzswEEvkg0uYePSRjE+5Axy4U
 HHBzLV53rQqlrPY5hnMm9s9bmrCuTzIpW1RSRwM5FNZuFxuulX8elKMRQ5rOqhFWMtnC98yOVop
 B/8HGcbThOKUvudbS/9GTt3yqEyysE1sMHyXVmnkmFyk2NyI+t9Xv9czE/VIQlBVZq0tQCkqdNW
 mu/6RlDa//dMtNUXlYTNhNZOr8C53L48n9dpQkwJcZrKd3BDPbYVMK2rVFaEnZfXQkyukU8g/B2
 a5sxCHy0ZX4F7ejVFiOjYWiK253gziKdsNlRB7jlC+P4+h040x9L/cawAZbBPfzzMpQCOliiR+6
 fsRQbZ+DpeVQGU2FPw9+Uq7uwWuYekormmGKaQL+cG6g=
X-Received: by 2002:a05:6a00:986:b0:848:7835:bbac with SMTP id
 d2e1a72fcca58-84e93356506mr531558b3a.65.1785208195049; 
 Mon, 27 Jul 2026 20:09:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:986:b0:848:7835:bbac with SMTP id
 d2e1a72fcca58-84e93356506mr531534b3a.65.1785208194537; 
 Mon, 27 Jul 2026 20:09:54 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5342471dsm3692067b3a.47.2026.07.27.20.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 20:09:54 -0700 (PDT)
Message-ID: <6b1d14f9-f6f9-4737-8369-8b32656d7efb@redhat.com>
Date: Tue, 28 Jul 2026 13:09:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 mst@redhat.com, richard.henderson@linaro.org, alex@shazbot.org,
 berrange@redhat.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <0f29e87a-b544-4e48-a4d6-a079696196a5@oss.qualcomm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <0f29e87a-b544-4e48-a4d6-a079696196a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On 7/27/26 11:52 PM, Philippe Mathieu-Daudé wrote:
> On 27/7/26 14:51, Peter Maydell wrote:
>> On Mon, 27 Jul 2026 at 04:27, Gavin Shan <gshan@redhat.com> wrote:
>>
>> Initial note: I think this is basically the right thing; I have
>> some suggestions for beefing up the doc comment and some minor
>> other things below.
>>
>>> All ram device regions were turned to be indirectly accessible by commit
>>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>>> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
>>> guest is started by the following command lines, with GH100 GPU card passed
>>> from the host.
>>>
>>>     host$ lspci | grep GH100
>>>     0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>>>     host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
>>>           -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>>>           -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
>>>           -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>>>           -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>>>           -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>>>             :
>>>     guest$ cd cuda-samples/build
>>>     guest$ make -j 20 clean
>>>     guest$ make -j 20
>>>             :
>>>     [ 54%] Linking CUDA executable graphMemoryNodes
>>>     [ 54%] Built target graphMemoryNodes
>>>     <no more output afterwards, guest becomes frozen here>
>>>
>>>     guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>>     [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
>>>
>>> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
>>> the memory blocks residing in the PCI BAR#4 of the GH100 GPU card can
>>> be presented to the guest through memory hot-add. The page cache can
>>> then be allocated from the hot added memory blocks when cuda-samples
>>> is being built. Afterwards, the page cache is sent to QEMU's virtio-blk
>>> device as part of the DMA request, the bounce buffer has to be used to
>>> accomodate the request as the corresponding memory region (MemoryRegion)
>>> is an indirectly accessible ram device region in qemu. However, the max
>>> bounce bufer size is only 4096 bytes by default and that is exhausted
>>> quickly, leading to a reset on the virtio-blk device and frozen guest
>>> eventually.
>>>
>>>    QEMU
>>>    ====
>>>    virtio_blk_handle_output
>>>      virtio_blk_handle_vq
>>>        virtio_blk_get_request
>>>          virtqueue_pop
>>>            virtqueue_split_pop
>>>              virtqueue_map_desc
>>>                address_space_map
>>>                  memory_access_is_direct         # Return false
>>>                    memory_region_supports_direct_access
>>>
>>>    (qemu) info mtree
>>>    memory-region: pci_bridge_pci
>>>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>>>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>>>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>>>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
>>>
>>> This adds qemu_ram_move() where the aligned and small-sized accesses are
>>> handled by qatomics, and fall back to memmove() otherwise. The memove()
>>> for the directly accessible regions is replaced by qemu_ram_move() so that
>>> the issue covered by commit 4a2e242bbb (MMIO access instructions were
>>> optimized to SSE instructions) is fixed. This makes 'ram_device_mem_ops'
>>> redundant, paving the way to revert that commit to make the ram device
>>> region directly accessible again in the next patch.
>>
>> I think this commit message should also describe the second category
>> of bug that we intend it to fix: the one where a device does e.g.
>> address_space_stb() to a data structure in guest memory and requires
>> it to write exactly that byte exactly once.
>>
>>
>>> Reported-by: Julia Graham <jugraham@redhat.com>
>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> 
>>> +void qemu_ram_move(void *dst, const void *src, size_t n)
>>> +{
>>> +    uintptr_t test, len;
>>> +
>>> +    if (src == dst || n == 0) {
>>
>> I think we should not bother testing for src == dst. It's
>> vanishingly unlikely to actually happen, and if it does
>> happen then the code will work fine, and it's probably better
>> to actually do the access in that case than to skip it.
>>
>>> +        return;
>>> +    }
>>> +
>>> +    test = (uintptr_t)src | (uintptr_t)dst | n;
>>> +    len = test & -test;
>>
>> What is this doing? I am not a fan of clever bit twiddling
>> that isn't commented to explain itself. Readers of the code
>> shouldn't have to go off and search for an explanation of what
>> is going on.
> 
> "max alignment of the 3 values"?
> 

Yes, it's the maximal length of the aligned access that is determined
by @src, @dst and @n. I've put a comments for (v5).

     /*
      * Maximal length of aligned access that are determined by @src,
      * @dst and @n
      */

>>
>>> +
>>> +    /* Overlapping buffers, unaligned or oversized access */
>>> +    if (n > 8 || len != n) {
>>> +        memmove(dst, src, n);
>>> +        return;
>>> +    }
>>> +
>>> +    switch (len) {
>>> +    case 1:
>>> +        qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
>>> +        break;
>>> +    case 2:
>>> +        qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
>>> +        break;
>>> +    case 4:
>>> +        qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
>>> +        break;
>>> +    case 8:
>>> +        qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
>>> +        break;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
> 
> Maybe more readable (untested):
> 
> -- >8 --
>   void qemu_ram_move(void *dst, const void *src, size_t len)
>   {
>       if (unlikely(n == 0)) {
>           return;
>       }
>       if (len == 1) {
>           qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
>           return;
>       } else if (QEMU_PTR_IS_ALIGNED(dst, len) && QEMU_PTR_IS_ALIGNED(src, len)) {
>           switch (len) {
>           case 2:
>               qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
>               return;
>           case 4:
>               qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
>             return;
>           case 8:
>               qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
>               return;
>           default:
>               break;
>         }
>      }
>      /* Overlapping buffers, unaligned or oversized access */
>      memmove(dst, src, len);
>   }
> ---
> 

Thanks for the proposed code, but I'd like to keep what we already had. One thing
I try to avoid from the beginning is the unnecessary nested if statements. Besides,
one irrelevant question is that QEMU_PTR_IS_ALIGNED() looks a bit strange as it
uses % operator, meaning it works even the operand isn't power of 2.

#define QEMU_IS_ALIGNED(n, m) (((n) % (m)) == 0)
#define QEMU_PTR_IS_ALIGNED(p, n) QEMU_IS_ALIGNED((uintptr_t)(p), (n))

QEMU_PTR_IS_ALIGNED(3, 3) => true

Thanks,
Gavin


