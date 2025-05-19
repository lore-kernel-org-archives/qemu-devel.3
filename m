Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A960C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGvrT-0004q5-Un; Mon, 19 May 2025 04:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uGvrR-0004pm-3F
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uGvrO-0003Md-Dm
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747643311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JLEcvOOezo4aBzXLp/ZnbVSB2qt8TFjpk5rTbSxwz40=;
 b=houAxQwUZm+qtE5DmjcwHx1TNfKC3VRToqQQcTfnuckATdmMT/v8ICMRBkB6P7RsfKzD12
 DMJ/qsrJSTsyzZGvNRgDdfQeiTFWyfWRpotGJKY0ENs8Tfiz+jDEk8JCuVnP9po6b/sS09
 r6fpwfHsQ464TwQY0Mrh5wgRbHLgBWQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-fu7NNNpXPl2jWK125NAkGQ-1; Mon, 19 May 2025 04:28:27 -0400
X-MC-Unique: fu7NNNpXPl2jWK125NAkGQ-1
X-Mimecast-MFC-AGG-ID: fu7NNNpXPl2jWK125NAkGQ_1747643307
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so1539809f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 01:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747643307; x=1748248107;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JLEcvOOezo4aBzXLp/ZnbVSB2qt8TFjpk5rTbSxwz40=;
 b=baQ0jHKHZDyGZI5RlkSTQQBWPFF9xxfTZ7s0U8Cs7b94E8ScgVslMyD8eImt98Xjgn
 uATePSRDx3kqKTjjLBlcKJH3akXbzFksrQVCI0lv3GbrV+jNIndPmX1kBaEuhMx9GzWR
 ku0KzltkIRci42F44GnAnzFQiBRna+VjdVVFV10DBlFhj7trtwWrR8LV1LNGX7UkwlEQ
 oD8M/N2RxRKo0UoceceEFl0E7HqyrgARPvBjlXrVpnqqCWWL6A/MUWPQjUVw5MCjvNY8
 zACNWxqm9olizpI3ZtIE5mhtSimLwHQzpyvg7MPC43XAIrmnHF852VlPOza+wcKqQTyC
 XVEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZXQw7eNCWhpRq8VpoXA0hi2fLbiwESifs9opBNG6BzjJFv2N5QK3RmFwRZRF5sty9ThVVkEMW5yKO@nongnu.org
X-Gm-Message-State: AOJu0Yzhlo2G0wsaIv+v0nr8BdmB955BOVOPqpkgesAG9lWUsQpqWH/4
 pZ1/K6k+3BWZF0t2R+eNURUtZyCEagAnb5VZ+f3n9jyhxfdO+k8TKwjsZFIBNCIic43VkAb1uEW
 FBZVlx7cUP2jvXb1PkeFzAtGVRVjluLe7gqoRVVSEQEhDdDfZizkWa1dJ
X-Gm-Gg: ASbGncsZGxiTTTZooAc6FND6ZbcAZiswTsjU05UPxzJbNxMVX+7VBI+4IVqYMQUD6CC
 AZ9FqvBK6xEhozrWLGkJCeF1fwWprSGnYZgJ2Pv5gS11JfhvEtP2PTMd3bDrKVHY2HGnmpP0sqV
 4BoWIrwV1GA6l1m1j40v+nj788FTqPjIrww9zcYgyNh2z20mf3RcC/qA/dWU9d7WCfIISGDaJhy
 IoqAQKQZEc9C17VzDCThqrw5J9hTMAfGrriU+xbBqcNrFSopBrtllkFSxpsip3gvURhbWEolRjt
 pfsBi1wnLbAs4l6GxyFJh2eot9DzUKehglNdkgx02nb+1reEBfuRBsDyIS3PXTuBIhr18O25Rpf
 1irXRjh7Klo72P5x34EE3MBpNEIjpuANdsgMDaKk=
X-Received: by 2002:a05:6000:18a4:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-3a3601dbea5mr9410645f8f.52.1747643306677; 
 Mon, 19 May 2025 01:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRypZgSQ2DcwtH81aK/9AFfJ1V2c9Iu32MsYRGvDCQZOScN9MSIfyqXVYTQjKM4ZFIO84oYA==
X-Received: by 2002:a05:6000:18a4:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-3a3601dbea5mr9410617f8f.52.1747643306261; 
 Mon, 19 May 2025 01:28:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e?
 (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de.
 [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a368136014sm7671141f8f.92.2025.05.19.01.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 01:28:25 -0700 (PDT)
Message-ID: <d901a598-26cb-4f55-8019-b6966e96200a@redhat.com>
Date: Mon, 19 May 2025 10:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] vfio: return mr from vfio_get_xlat_addr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747415599-131553-1-git-send-email-steven.sistare@oracle.com>
 <e6b1e5ee-f8d3-40b5-a608-67469a8b599b@redhat.com>
 <717acf0a-bdeb-45ed-bd44-7c054247836e@oracle.com>
 <31cf87f6-94a4-4801-bbe9-882043cd88f2@redhat.com>
 <5a2a1347-5a98-49fb-8416-4f8d43250491@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5a2a1347-5a98-49fb-8416-4f8d43250491@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 17.05.25 15:55, Steven Sistare wrote:
> On 5/16/2025 4:50 PM, David Hildenbrand wrote:
>> On 16.05.25 21:26, Steven Sistare wrote:
>>> On 5/16/2025 2:58 PM, David Hildenbrand wrote:
>>>> On 16.05.25 19:13, Steve Sistare wrote:
>>>>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>>>>> region that the translated address is found in.  This will be needed by
>>>>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>>>>
>>>>> Also return the xlat offset, so we can simplify the interface by removing
>>>>> the out parameters that can be trivially derived from mr and xlat.
>>>>>
>>>>> Lastly, rename the functions to  to memory_translate_iotlb() and
>>>>> vfio_translate_iotlb().
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>     hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
>>>>>     hw/virtio/vhost-vdpa.c  |  9 +++++++--
>>>>>     include/system/memory.h | 19 +++++++++----------
>>>>>     system/memory.c         | 32 +++++++-------------------------
>>>>>     4 files changed, 45 insertions(+), 48 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>>>> index bfacb3d..a4931f1 100644
>>>>> --- a/hw/vfio/listener.c
>>>>> +++ b/hw/vfio/listener.c
>>>>> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>>>>                section->offset_within_address_space & (1ULL << 63);
>>>>>     }
>>>>> -/* Called with rcu_read_lock held.  */
>>>>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>>>> -                               ram_addr_t *ram_addr, bool *read_only,
>>>>> -                               Error **errp)
>>>>> +/*
>>>>> + * Called with rcu_read_lock held.
>>>>> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>>>>> + */
>>>>> +static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>>>>> +                                          Error **errp)
>>>>>     {
>>>>> -    bool ret, mr_has_discard_manager;
>>>>> +    MemoryRegion *mr;
>>>>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>>>>> -                               &mr_has_discard_manager, errp);
>>>>> -    if (ret && mr_has_discard_manager) {
>>>>> +    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
>>>>> +    if (!mr && memory_region_has_ram_discard_manager(mr)) {
>>>>
>>>> Pretty sue this should be if (mr && ...)
>>>>
>>>> otherwise we'd be dereferencing NULL :)
>>>
>>> Hmmmm.
>>> That is why we cannot return mr as the function return value.
>>> There are cases where the function can return error, but the mr is
>>> valid.  We want to take the branch in that case.  From the original
>>> code:
>>>        if (ret && mr_has_discard_manager) {
>>
>> It's late in Germany, but didn't we return "ret = true" when we would now return mr != NULL?
>>
>> I mean, there is no reason to warn about mr_has_discard_manager if ... there is nothing to translate to?
> 
> The issue is that mr_has_discard_manager has been replaced by
> memory_region_has_ram_discard_manager(mr), hence mr must be returned to
> evaluate memory_region_has_ram_discard_manager(), hence we cannot return
> mr == NULL as the error indication.

Let's try to understand what the code wants to achieve.


If *our translation was successful* and we have a RAMDiscardManager, we 
want to print a warning, stating that this *successful* translation is 
problematic.

memory_get_xlat_addr() currently returns true *if the translation was 
successful*. Now we return "mr" when the translation is successful.


if (mr && memory_region_has_ram_discard_manager(mr))

Checks the exact same thing? I really don't see the problem you see.

-- 
Cheers,

David / dhildenb


