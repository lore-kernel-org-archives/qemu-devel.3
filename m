Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F79CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckJ7-0003Wb-VS; Thu, 25 Jun 2026 09:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wckJ6-0003WQ-Mj
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wckJ4-0002Gt-ME
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782394789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=98GtfIkq3pMrn971AA7yupH6eU/6oN2hB7jV9j722Ig=;
 b=g/QColMM+pbQD6JoLHzP90P8Rwygyi4UomoT7oF+nkPn0mr3k18a6afi586BfivH8qEVXo
 eySRgMsYUXVETEPaOTSi36Hi508P3vevZk8xtasG6t2rztwR+n0fCSZbAZDYQADSl/lK+8
 cFlPb9spyDV0agnVRqqpcpSmaZlsuQg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-6uh9hQakMKiN4lJGrvNpxA-1; Thu, 25 Jun 2026 09:39:48 -0400
X-MC-Unique: 6uh9hQakMKiN4lJGrvNpxA-1
X-Mimecast-MFC-AGG-ID: 6uh9hQakMKiN4lJGrvNpxA_1782394787
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bfa400102d9so241370666b.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782394787; x=1782999587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=98GtfIkq3pMrn971AA7yupH6eU/6oN2hB7jV9j722Ig=;
 b=S0A7Tspgg2qhGjfkXUrpwzziB0qRKS3tgZyv1Sr+GfUES91DOejZxEwmSTwGd54+6y
 aBYBmMPyn3/FlIhpJ559LnRIjxwEoOkXs9yUlK58Bs49z3MwuRvDxq5U7p8KTQappxaF
 Eothd9A+K+Kt298XgUMDIVbJYx5h+N1B0F0CBRrBjrrY1i/8rQCgu+2MhRs/VuxI5P15
 +lRidrofTiLRXqKB18enW3A4/v+hPxgS+/DrllM8nICz47DrRNGSKwrtqx06S2C6ETLM
 0YZQGU6gYBE4e6kMDZifjkV/KW4eo+kETyzUkZ64v9YRcJbB47KWnV8JwFQV1HJSE2Yh
 8x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394787; x=1782999587;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98GtfIkq3pMrn971AA7yupH6eU/6oN2hB7jV9j722Ig=;
 b=b20EnBLOmbtdOkYxtfFAEqdf3pZ7218y1o1V31GeYl+Vh4qkmG0vhaMMpcaz4J7mYB
 dixq860nOUM8b3lB3bgXjQnIOF+0+TRhB/9Er0n1/z5zz5Jtcpe/bIytxoU2qvcD5//k
 r9Qt+IDUUbC9bDckOK80iNsqbcFYgCsXneAabmCsuoZjit9HFIha9D6LaImlYJ5ylQ3U
 SEqIftH2cqvLzntTq7KISxpUy/oVFxdDgrSmSgF6RfgARoKwWGwxfKE8n30MrxJq9r1v
 jcQPIq1OJxKgpzJxAbu8sfJg9t77IKHiMvhdZbDDvwjIa29/lH7DRzcl0rnna0CtoIAj
 qYPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqt9KyQMq7Zxp/Ej6O+RthGoKKM9nQuYJsL+Y3kRqZ4oTVL47TLVXfWQCBp/Vt4exxcsK0xDY64AnTp@nongnu.org
X-Gm-Message-State: AOJu0YyFAHRbEmufsQJpztslm/bJ+lxv9MQNQ0vB+qWSW+CqiVJ1shN4
 KKAWrbsF73cCcH4KdLL28cl8tdSX2/Jrjkq6vYDqFJYtYY2tyChTzn5A5QkfSFRhlpgRiVLEVKo
 +1+xBhKwDEZP9T7Qi3HxPE0FjQgU+r0d/E/hq/+0uZiT6aiR/95fXU9PO
X-Gm-Gg: AfdE7cknPxHFO+E6m5YTmUH7Kw/709lEDjwThEScuji4Q83KNePXtiHQa+XYHUSDFCE
 43PgUP3KKiUtr/T7N1oBObrR8AbIEK7HOgpmXZ8YpJn85QvX4ioLvPwcaDmUF6oGllf7vhuF+MG
 +W2znxvKPd15w8lOxE/88Aje7VUGxn1aAL7jIhKFo2uuNCFigBeJ1Np9Kahmj3flmosxVji+UuS
 22xQHnHq0NBk5mns67Mbv3OeBTBppGyoAT4RSQvIh+36og35bnsHrKrgoYxK2L49FXDzy+sPRpm
 Hmvj8SNu9Ln0QEtxvvjW/JSTxWDC36CIlv062iW/XbdbeVQBWxMDjaI/NZU73dy3ttFDIFJTnrN
 gzpsAaqUAoAi/yNDQjPtfo8bMVhx1Yt4rSmV54iprgzfrjBbj64vs7IM=
X-Received: by 2002:a17:907:3e28:b0:c11:f5dc:20f with SMTP id
 a640c23a62f3a-c1205e9df16mr204447666b.31.1782394786759; 
 Thu, 25 Jun 2026 06:39:46 -0700 (PDT)
X-Received: by 2002:a17:907:3e28:b0:c11:f5dc:20f with SMTP id
 a640c23a62f3a-c1205e9df16mr204444866b.31.1782394786222; 
 Thu, 25 Jun 2026 06:39:46 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbbe5628sm192649566b.14.2026.06.25.06.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 06:39:45 -0700 (PDT)
Message-ID: <009de110-5ecc-484f-93a4-0107b65229cd@redhat.com>
Date: Thu, 25 Jun 2026 15:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 28/41] vfio/listener: Add missing dirty tracking in
 region_del
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex@shazbot.org>,
 "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
References: <20260113093637.1549214-1-clg@redhat.com>
 <20260113093637.1549214-29-clg@redhat.com>
 <2b70ae68-aee7-4c81-8799-6610a582dcb8@redhat.com>
 <IA3PR11MB9136249C19B0F0108D1C9A1992ED2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <10936003-6199-4cf9-92ba-f648f070d841@redhat.com>
 <IA3PR11MB91368116996B7E1A6785C15C92EC2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91368116996B7E1A6785C15C92EC2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/25/26 13:00, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PULL 28/41] vfio/listener: Add missing dirty tracking in region_del
>>
>> On 6/24/26 10:02, Duan, Zhenzhong wrote:
>>> Hi Cédric,
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: Re: [PULL 28/41] vfio/listener: Add missing dirty tracking in region_del
>>>>
>>>> Hello Zhenzhong,
>>>>
>>>> On 1/13/26 10:36, Cédric Le Goater wrote:
>>>>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>
>>>>> If a VFIO device in guest switches from passthrough(PT) domain to block
>>>>> domain, the whole memory address space is unmapped, but we passed a
>> NULL
>>>>> iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
>>>>> dirty pages.
>>>>>
>>>>> By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
>>>>> set dirty bits correctly.
>>>>>
>>>>> For IOMMU address space, we still send NULL iotlb because VFIO don't know
>>>>> the actual mappings in guest. It's vIOMMU's responsibility to send actual
>>>>> unmapping notifications, e.g., vtd_address_space_unmap_in_dirty_tracking().
>>>>>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-8-
>>>> zhenzhong.duan@intel.com
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>     hw/vfio/listener.c | 22 +++++++++++++++++++++-
>>>>>     1 file changed, 21 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>>>> index
>>>>
>> 62699cb772d786c1510318dff73973ef4d297177..813621f22f8b5ec284388f9c5f71
>>>> 9525ec5f282c 100644
>>>>> --- a/hw/vfio/listener.c
>>>>> +++ b/hw/vfio/listener.c
>>>>> @@ -713,14 +713,34 @@ static void
>> vfio_listener_region_del(MemoryListener
>>>> *listener,
>>>>>
>>>>>         if (try_unmap) {
>>>>>             bool unmap_all = false;
>>>>> +        IOMMUTLBEntry entry = {}, *iotlb = NULL;
>>>>>
>>>>>             if (int128_eq(llsize, int128_2_64())) {
>>>>>                 assert(!iova);
>>>>>                 unmap_all = true;
>>>>>                 llsize = int128_zero();
>>>>>             }
>>>>> +
>>>>> +        /*
>>>>> +         * Fake an IOTLB entry for identity mapping which is needed by dirty
>>>>> +         * tracking when switch out of PT domain. In fact, in unmap_bitmap,
>>>>> +         * only translated_addr field is used to set dirty bitmap.
>>>>> +         *
>>>>> +         * Note: When switch into PT domain from DMA domain, the whole
>>>> IOMMU
>>>>> +         * MR is deleted without iotlb, before that happen, we depend on
>>>>> +         * vIOMMU to send unmap notification with accurate iotlb entry to
>>>>> +         * VFIO. See vtd_address_space_unmap_in_dirty_tracking() for example,
>>>>> +         * it is triggered during switching to block domain because vtd does
>>>>> +         * not support direct switching from DMA to PT domain.
>>>>> +         */
>>>>> +        if (global_dirty_tracking && memory_region_is_ram(section->mr)) {
>>>>> +            entry.iova = iova;
>>>>> +            entry.translated_addr = iova;
>>>>
>>>> In an experiment involving a nested setup with L1 + intel_iommu,
>>>> an L2 VM with an assigned igb VF can trigger the following QEMU
>>>> segv :
>>>>
>>>>     bitmap_set_atomic(map=NULL, start=1, nr=1)
>>>>     physical_memory_set_dirty_range(start=0x380004040000, length=4096)
>>>>     physical_memory_set_dirty_lebitmap(start=0x380004040000, pages=3)
>>>>     vfio_container_query_dirty_bitmap(translated_addr=0x380004040000)
>>>>     vfio_legacy_dma_unmap_one(iova=0x380004040000, size=12288)
>>>>     vfio_listener_region_del()
>>>
>>> Hmm, looks a range in PCI space, I suspect it's a PCI bar but it has 3 pages.
>>
>> It's the nested VT-d interrupt remapping table.
>>
>>> Is igb VF a real hw passthrough to L1, then L1 pass it to L2?
>>
>> Iit's an L1 emulated igb VF assigned to an L2.
>>
>>> Seems L2 crash, not L1?
>> yes. It occured a few times and  I can't reproduce anymore. hmm.
> 
> It can be reproduced with below steps:
> 
> 1. Start guest with VFIO device in legacy iommu mode, then start dirty rate tracking.
> 
> (qemu) calc_dirty_rate -b 60
> 
> 2. disable VFIO device bar region by clear bit1 in COMMAND register in guest.
> # setpci -s 01:00.0 COMMAND=0005
> 
> 3. below trace triggers:
> 
> vfio_listener_region_del region_del 0xe0400020000 - 0xe0400021fff
> 
> Thread 10 "CPU 6/KVM" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7ffde5dfb640 (LWP 217374)]
> 0x000055555613c8a0 in bitmap_set_atomic (map=0x0, start=32, nr=1) at ../util/bitmap.c:213
> 213             qatomic_or(p, mask_to_set);
> (gdb) bt
> #0  0x000055555613c8a0 in bitmap_set_atomic (map=0x0, start=32, nr=1) at ../util/bitmap.c:213
> #1  0x0000555555d6a0e2 in physical_memory_set_dirty_range (start=15410342789120, length=4096, mask=5 '\005') at ../system/physmem.c:1042
> #2  0x0000555555d6b2c9 in physical_memory_set_dirty_lebitmap (bitmap=0x7ffdc80ac690, start=15410342789120, pages=2) at ../system/physmem.c:1305
> #3  0x0000555555ca97ee in vfio_legacy_dma_unmap_get_dirty_bitmap (container=0x5555576fc980, iova=15410342789120, size=8192, iotlb=0x7ffde5df9e20) at ../hw/vfio/container-legacy.c:112
> #4  0x0000555555ca9927 in vfio_legacy_dma_unmap_one (container=0x5555576fc980, iova=15410342789120, size=8192, flags=0, iotlb=0x7ffde5df9e20) at ../hw/vfio/container-legacy.c:145
> #5  0x0000555555ca9aba in vfio_legacy_dma_unmap (bcontainer=0x5555576fc980, iova=15410342789120, size=8192, iotlb=0x7ffde5df9e20, unmap_all=false) at ../hw/vfio/container-legacy.c:196
> #6  0x0000555555ca84b5 in vfio_container_dma_unmap (bcontainer=0x5555576fc980, iova=15410342789120, size=8192, iotlb=0x7ffde5df9e20, unmap_all=false) at ../hw/vfio/container.c:131
> #7  0x0000555555ca68cd in vfio_listener_region_del (listener=0x5555576fc9b0, section=0x7ffde5df9ed0) at ../hw/vfio/listener.c:753
> #8  0x0000555555d5d9a9 in address_space_update_topology_pass (as=0x5555574c1880 <address_space_memory>, old_view=0x7ffd7c001580, new_view=0x7ffdc8000c00, adding=false)
> 
> 
>>
>> That seemed to fix it
>>
>> -            entry.translated_addr = iova;
>> +            entry.translated_addr = memory_region_get_ram_addr(section->mr) +
>> +                                    section->offset_within_region;
> 
> I verified this works.

Thanks,

I will send a patch.

C.


