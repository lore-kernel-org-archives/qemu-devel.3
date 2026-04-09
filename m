Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEEBEA3C4E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoUP-0005YU-Fo; Thu, 09 Apr 2026 08:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAoUF-0005Xy-9T
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAoUC-00057C-Bn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775737668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y9KBjG5PN3ETRn0BxM7ENCEk9WSSzPJcVVEDwROfFDU=;
 b=Z5pvOlpRwFyDpZ17HLYPR9q5fLWFALvgT82tX4Z+WFB+qjYgvxE/O6Kd3LHFJ7zDoeP1Ry
 ibxwcTfmuqP/rLyRYIBgOs6TNJXmztyMHGSUG/yhE6P94zyr9SZXE7/1RQJCiHcdKAbEOc
 0ZN00ZdsMBPGbJa7JuIW7CbZgYZGk6w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-uLD4rx_QMnucr-510N8oOA-1; Thu, 09 Apr 2026 08:27:47 -0400
X-MC-Unique: uLD4rx_QMnucr-510N8oOA-1
X-Mimecast-MFC-AGG-ID: uLD4rx_QMnucr-510N8oOA_1775737666
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d1fec59c9so467025f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775737666; x=1776342466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9KBjG5PN3ETRn0BxM7ENCEk9WSSzPJcVVEDwROfFDU=;
 b=MZxvKep3ivpCJzk6YLncAfi8j4+zMdjObN72oVxfZnByEYzFtCWuKaLA3eVPBhEmPX
 I1Rgi6WLldduJamnaC8DFNwl+E59bKRefPDGzu7Y77NDfwjgptJLsckB+8bZsqa6ViQ9
 EwsVX7zSjUsaHudigskU+aMbybwNibxdtcTox9+fKND1Nc/WudJQuowhKTrCKJl729bA
 JYSEv8MQOeHoNb3sT9l+Gf5ZvSg7AyKbzOdFnaeTaRCn+Jm7O9elHbuJrLUeYKsbGmdL
 wxLMRpBQVScu3nKCHio6WlYyO0n2nD26ZTITccoyYdrctdC6+h+hX4GjIQRXezTmVodh
 4Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775737666; x=1776342466;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9KBjG5PN3ETRn0BxM7ENCEk9WSSzPJcVVEDwROfFDU=;
 b=TQ+gZSLRqLJUmreDmn7UEKQmMn6FNeyxiLNDaaFn7K/A+ZuxAAebzd9XgNjD3/LroB
 PH8ec/gOHuhsOKKalasXajBkzzKXclVoSMNPWHoBGHF69WGlvmFxmrH239ilW3feHj2S
 xMPN/cgYLLZnQfK7AsBMHIvJAd/z3or9CTyNxGuVZoocABzC2N/sw0wZOOszoMWdn2t2
 dWDZm/soWYdGV5G6JsolQ0bNbB1lpuQRqgWwsuKJ+n4uTi988l2elWyfYkRke3BNk4wJ
 6vuW+sT5eErFM1/EMWe4KvfGHKVfY+C2yo2lquEizoAm4Y4E5l1CxDv1L2nTcL5sinPF
 d+mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBI9uhT2YGdupxWT/dUoNJbGvSP8FJQZdL09NeD/6xXBMsNSs7TaTJT+RZQSU0OvWP9iJHYhNaJ7T0@nongnu.org
X-Gm-Message-State: AOJu0YxaiRvnLGtYukU/qSg1SlwB6agB4/Pov9bYs0d8Fl2S80g+nWu1
 +06y16RXwh25jHEF7nYpUs3wHkcQojCI3cwqVASxTD1oUmA+HHqlkgULMBAEP4eyH4D8OrsM6nc
 gT97AMqNxW8d55L8vMmd+MoX0UmqUWTo8lFMnw6e7mdw3mF9loH/gg5bc
X-Gm-Gg: AeBDiev9o9CLHKL+pdQBfNw86ypUsI5iDd1EEIXDczSmEvXBBbHaaxR5Z6MEFY8xZyC
 +WE8J5NzicOa+xCzGfXnTv8EgHu0AIr+5ez0+oKjWt/fjnFu8tGXHuHt+h4ow1Yk04nIvxGI3Rm
 pBzmb9tqS8KK/rXnv/0RTcgSujUVUCAIMkxSQRo8/MkyOAR+E0HUTcZrQ/koVYS3CY8ALEnNSgA
 cIBXzFLkakAGryw9ZDi+OfEtcSqEVnbZ112xztQnpbyXSftS1gGRfRJEKaZnDugYDzRRGIpqOpe
 Y9w7cGHQGP9DwCbETI79iUkKOd4J5qOX7hOflzDlJNGA1j91mlWHeZfyzyiW3ujnQ7xcg9gByQF
 Nf5ztNKLT85RdpIY/3Mn1O0OwxQwz0R6TCOTi6+RaLnW5aDtPYXkv9Wq2+A==
X-Received: by 2002:a05:6000:25c1:b0:43d:1c21:ecb0 with SMTP id
 ffacd0b85a97d-43d5959d90cmr5338992f8f.15.1775737666059; 
 Thu, 09 Apr 2026 05:27:46 -0700 (PDT)
X-Received: by 2002:a05:6000:25c1:b0:43d:1c21:ecb0 with SMTP id
 ffacd0b85a97d-43d5959d90cmr5338918f8f.15.1775737665581; 
 Thu, 09 Apr 2026 05:27:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e6224sm67532550f8f.25.2026.04.09.05.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 05:27:44 -0700 (PDT)
Message-ID: <8e592b66-5192-43c3-981a-c99cdc3dac60@redhat.com>
Date: Thu, 9 Apr 2026 14:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] intel_iommu: Expose flag
 VIOMMU_FLAG_PASID_SUPPORTED when configured
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Hao, Xudong" <xudong.hao@intel.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-15-zhenzhong.duan@intel.com>
 <4567f32a-2a4f-43a4-aa09-fb669cd9e78e@redhat.com>
 <IA3PR11MB91365C3158521D1D985B7464925AA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91365C3158521D1D985B7464925AA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/7/26 04:18, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v3 14/14] intel_iommu: Expose flag
>> VIOMMU_FLAG_PASID_SUPPORTED when configured
>>
>> On 4/3/26 05:55, Zhenzhong Duan wrote:
>>> VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose
>> PASID
>>> capability, or else guest could not enable PASID of this device even if
>>> vIOMMU's pasid is configured.
>>>
>>> This is the final knob to enable PASID.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index abcb0df5d9..3cb8a547c7 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -4794,6 +4794,7 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
>>>        uint64_t flags;
>>>
>>>        flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
>>> +    flags |= s->pasid ? VIOMMU_FLAG_PASID_SUPPORTED : 0;
>>
>> The '|=' operator is unexpected.
> 
> Not get, do you see any issue here?
> 
> The flags is firstly assigned to VIOMMU_FLAG_WANT_NESTING_PARENT if s->fsts=true,
> Then VIOMMU_FLAG_PASID_SUPPORTED is appended if s->pasid=true.

My eyes/brain tricked me. I was "seeing" a line removal just
above this additional line ...  sorry for the noise.

Thank,

C.


