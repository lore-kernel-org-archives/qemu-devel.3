Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B94CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v63e0-0003pE-Fy; Tue, 07 Oct 2025 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v63dz-0003oq-72
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v63dx-0007Af-Lv
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759827959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Mfu4JRC4tLjtN+E35kf6ixj1T+uheKVBQY5NL9420Q=;
 b=e4V6U/H/bwFqwZzvxh3WIaXdQpla1f5ZFNCLfgtZktHNR2cCCfE9XzmJT5O9jkCPd6sv5J
 ZPY2PAS8iN7J70dtd551gNuO97rO6eYW7BvOxYRGqJLt09tfsPwoRBk0eGKMA63X2sFGC5
 PJHa46fDz4+5Y7xrIRjgHKSDl8K86OY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-dmo646soN4-OtnTebhL4OQ-1; Tue, 07 Oct 2025 05:05:57 -0400
X-MC-Unique: dmo646soN4-OtnTebhL4OQ-1
X-Mimecast-MFC-AGG-ID: dmo646soN4-OtnTebhL4OQ_1759827957
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso4337728f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759827956; x=1760432756;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Mfu4JRC4tLjtN+E35kf6ixj1T+uheKVBQY5NL9420Q=;
 b=fvW5HR7nj6lJISz5VxVEEsSmkIRI1rSQDmiZL+b7ccl4kXwm5CIcLLDJz+WIv45w2P
 4UJiyMJdxtr9ZZDpCWmMahyY9iUl2Ukucm41IEtl1WdJKMBTvHM0rMTJPOaGjCv4PFJ8
 TXygk5DAKDq68Ff1KYv5QoceJ/ehv17hMH227VVCRwdXqC2omhxlxlq/ksk5yvZ6Afu5
 3iZAWNd4V18d34a7T84Oj6USZqEUaDKdTjezrxdZIAITiZ2o9hztScrMSVYNOTZmRLk3
 JumCj/J2FDlKAPmZ8YyolpwuDZhBPM+e0nutpnj9TrveYNAGZpJMiDfn9Rr75nagOhmX
 THGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOphTLsX/xg6SVNYO05STQ1f+T/Mj7HBY1Uxrr0OrDAjWyjqUxs+ALS4rBUmyGDJwvJ7i1M/dhNbuk@nongnu.org
X-Gm-Message-State: AOJu0Yyj8sLBJ5w2stZX4cRk4XXyCt+viWiqT3sVf6SZJf3FZcb0jrxt
 OBOXpBLhC8ZL1HJ/FqD5e+7/LI8pItJkOqm8E6JNblG8x4WHCIlYaCrYappBm1gfwzmFeWprH0d
 uJhs2bSK3UF17q4E9C8UwwxQ8n46sU6+xoMXrQ18wGirMj0zFvzP9zS42
X-Gm-Gg: ASbGncuTCOtrW09PcC2MjjnDHAsgk5z4yBh3k8fWk2pMwshr/fE9xKWU1W3PrKyc0oP
 b+From18hjWf677hKQ03FudbShz+qhVCUnHj6DcDFo8sX9+FtsGh9JlTZy8D2GYiaAqYGCIYCu1
 UxuWoRR084W6T9eOC9IKU+yRETzBgnFVbzDwvQJ/E1ZMeh379vMheobaYjRwcxokyckzvRfldIw
 46gbs7Vse51izNqwTemn6FT6nNe+BlDkfPF2fTns2oJuqixlwAZaYNef1JDky6n8aqiMieq7MTt
 A3XG6RuWyPysILuhwG3mmM/q/dxYec6T3Lnj0/aWyhB31em/tujjsqg7wEv0GMuuiFGv/mbyvdT
 HGvu433LO
X-Received: by 2002:a05:6000:40da:b0:3d8:3eca:a978 with SMTP id
 ffacd0b85a97d-425671534d0mr8959848f8f.21.1759827956600; 
 Tue, 07 Oct 2025 02:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqJkk+FxWzpF2xv3PxQKHLmqhuXA2uF4iOBI7Tkm/MEbxjOexPjQ1TNkDdS8hD0fiHG15a0g==
X-Received: by 2002:a05:6000:40da:b0:3d8:3eca:a978 with SMTP id
 ffacd0b85a97d-425671534d0mr8959826f8f.21.1759827956112; 
 Tue, 07 Oct 2025 02:05:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm24437606f8f.17.2025.10.07.02.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 02:05:55 -0700 (PDT)
Message-ID: <614cf061-9c5d-4f52-9eb5-df2c26892a96@redhat.com>
Date: Tue, 7 Oct 2025 11:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] vfio/region: Add a helper to get region index from
 memory region
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-5-vivek.kasireddy@intel.com>
 <4b738e3e-6788-4b28-8bc3-d656d3d4db58@redhat.com>
 <IA0PR11MB7185538792F4A2D3BDB3A810F8E0A@IA0PR11MB7185.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA0PR11MB7185538792F4A2D3BDB3A810F8E0A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/7/25 06:50, Kasireddy, Vivek wrote:
> Hi Cedric,
> 
>> Subject: Re: [PATCH v1 4/7] vfio/region: Add a helper to get region index from
>> memory region
>>
>> Hello Vivek,
>>
>> On 10/4/25 01:35, Vivek Kasireddy wrote:
>>> Having a way to figure out the region index (or bar) associated
>>> with a memory region is helpful in various scenarios. For example,
>>> this capability can be useful in retrieving the region info needed
>>> for mapping a part of a VFIO region or creating a dmabuf.
>>>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/vfio/region.c              | 14 ++++++++++++++
>>>    include/hw/vfio/vfio-device.h |  2 ++
>>>    2 files changed, 16 insertions(+)
>>>
>>> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
>>> index b165ab0b93..8837afc97f 100644
>>> --- a/hw/vfio/region.c
>>> +++ b/hw/vfio/region.c
>>> @@ -398,3 +398,17 @@ void vfio_region_mmaps_set_enabled(VFIORegion
>> *region, bool enabled)
>>>        trace_vfio_region_mmaps_set_enabled(memory_region_name(region-
>>> mem),
>>>                                            enabled);
>>>    }
>>> +
>>> +int vfio_get_region_index_from_mr(MemoryRegion *mr)
>>> +{
>>> +    VFIORegion *region = mr->opaque;
>>> +
>>> +    if (mr->ops != &vfio_region_ops) {
>>> +        mr = mr->container;
>>
>> May be start the routine with :
>>
>>       while (mr->container) {
>>           mr = mr->container;
>>       }
> Ok, makes sense.
> 
>>
>>> +        if (mr->ops != &vfio_region_ops) {
>>> +            return -1;
>>
>> I think I would prefer returning a 'VFIORegion *' which should be
>> NULL in case of error. Looks cleaner.
> Given that VFIORegion type is no longer exposed to other subsystems,
> I am guessing you meant adding two helpers: internal helper that would
> return VFIORegion * and an external routine that would call the internal
> helper and return region->nr?


After seeing how vfio_get_region_index_from_mr() was used in
vfio_dmabuf_mmap(), I think it is fine to keep your proposal
unchanged. we can refine it later.


Thanks,

C.


> 
>>
>>
>>> +        }
>>> +	region = mr->opaque;
>>> +    }
>>> +    return region->nr;
>>> +}
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index 7e9aed6d3c..bdb106c937 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -277,6 +277,8 @@ bool vfio_device_has_region_cap(VFIODevice
>> *vbasedev, int region, uint16_t cap_t
>>>
>>>    int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>>>                                    struct vfio_irq_info *info);
>>> +
>>> +int vfio_get_region_index_from_mr(MemoryRegion *mr);
>> Please add documentation.
> Sure, will do.
> 
> Thanks,
> Vivek
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>>    #endif
>>>
>>>    /* Returns 0 on success, or a negative errno. */
> 


