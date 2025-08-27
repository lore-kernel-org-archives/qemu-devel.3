Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58B9CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEhL-0004y4-Kb; Wed, 27 Aug 2025 07:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEhG-0004w1-6W
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEh6-0006R7-6O
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756295515;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGaNHstPSuEY9yOpcN5jnwHyjt5RLQ4acydDYOY1Eao=;
 b=Gyum1KaAd0IKp7OvxhRapyDnQP/2zopUi3JDb+r9DAnwXLJD0nZhiUBeqLSugCJ6lg8oUZ
 7HzG986h7ONHCwL6HWMflzjF8cWPJIhLB2uGExxR7Y8yRblvdQLV7bCyuyBsNP1iM70S+7
 yvpfhOF5kDjFP7CKUsm0hXLparGKdw8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-HrQv-xKoMnm5M1a9M631NA-1; Wed, 27 Aug 2025 07:51:54 -0400
X-MC-Unique: HrQv-xKoMnm5M1a9M631NA-1
X-Mimecast-MFC-AGG-ID: HrQv-xKoMnm5M1a9M631NA_1756295513
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cccba2f06bso177460f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 04:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756295513; x=1756900313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGaNHstPSuEY9yOpcN5jnwHyjt5RLQ4acydDYOY1Eao=;
 b=aCsWtCXMPjyVOnxC75cWHhkzdMM+OEhhAv6oNO9hTnDx0+ttXFR/osV4XHsqkHAhn/
 dC11sM52Ivg/AgbDQ+iuID2iwEQVW2BDpEbOBzGtf1LgzbN9GFgNtTv6FEsyjGfY72N4
 kXHMaNerwHR5qw0MOyhhD5sF9/MAPisOCuwYGirtN7D3kSduKan+FsIBnwsvtPr4GVtR
 ls9RFGgY/uxAnLCVHT9eTR2BJr0v8gcSnseMK/SKhdIM6F/R43lF4tW4lpAMaHBw81je
 20X9kgDIvhcxvGyTel2oCuFkbNoS7LGivZRCA3gt/VaZQ7y+xXhrGFb+KTAWaF8oNKMG
 6RbQ==
X-Gm-Message-State: AOJu0YwiYGFCImpm6sD5/eAMfwBC2G52fTbvc6ZOMZPnRUUssTwsJ2VU
 gNmfFXRi4fHRvTNKDPZA1bu72Mr0Rekj7reaD3fQJGhWNwPfYAWFIoPMkm6UFYGxPhuKU69ck7k
 TOQE5407/oU7GeofE3uZxr1KEH0tSUQXidpws7Qwz/Ulu5KqR1rrxRBzf
X-Gm-Gg: ASbGncuh4VvOL7FTEluG59xrZKl/8xuzzY8s3RRKLtHegyvD+TIHbs6cvIIaqIT/fLj
 ggRlC3Ofybih7fAcgOVsn/095trlFDq8S7CCyLlmta4QuNpZvKHGNy/RN1CYC6bh8HkmfJscCAM
 ldpcLhtgRAcIDbiDPT8/F0+F0FsJ/XCHjIOI9WRrTP2sgj4iMesRm9tclEHzA3J2zOvELBNN5DI
 suP5h7vihSPCgT4Jre0YNYh3hzDW0jAc868kmdtwgqJgIo7yXrhIAEJxOkH474BjiEf/F2RI4RA
 7+YL8Z5uh2Hm2n+qibhOxQ+CDY/HUCwVwKop4olT3xdrIJwPAwBxbQ4keYmIyvg4C9CdoHqOcKz
 OG1pm4wo7Ho8=
X-Received: by 2002:a05:6000:2404:b0:3c0:7e02:67b4 with SMTP id
 ffacd0b85a97d-3c5dd0ec263mr14750726f8f.60.1756295513038; 
 Wed, 27 Aug 2025 04:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+c7UZHlhLHG1FxMjxiux2Hmi06cXrrwISt5yn3ziOOAsUKDAjcsIkXXlqLrtInhCLyS4cwQ==
X-Received: by 2002:a05:6000:2404:b0:3c0:7e02:67b4 with SMTP id
 ffacd0b85a97d-3c5dd0ec263mr14750709f8f.60.1756295512566; 
 Wed, 27 Aug 2025 04:51:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd157b0046sm1460720f8f.50.2025.08.27.04.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 04:51:51 -0700 (PDT)
Message-ID: <400b87a8-7e02-4ade-b5cd-ac7c30aeb218@redhat.com>
Date: Wed, 27 Aug 2025 13:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
 <aKj5Xcg4476do8Cs@Asurada-Nvidia>
 <IA3PR11MB9136B0C89BE79666DD1B40E7923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136B0C89BE79666DD1B40E7923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/25/25 10:28 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent
>> domain
>>
>> On Fri, Aug 22, 2025 at 02:40:43AM -0400, Zhenzhong Duan wrote:
>>> Call pci_device_get_viommu_cap() to get if vIOMMU supports
>> VIOMMU_CAP_HW_NESTED,
>>> if yes, create nested parent domain which could be reused by vIOMMU to
>> create
>>> nested domain.
>>>
>>> Introduce helper vfio_device_viommu_get_nested to facilitate this
>>> implementation.
>> It'd be nicer to slightly mention the benefit of having it. Assuming
>> that QEMU commit message can be as long as 80 characters:
>>
>> -------------------------
>> Call pci_device_get_viommu_cap() to get if vIOMMU supports
>> VIOMMU_CAP_HW_NESTED.
>>
>> If yes, create a nesting parent domain and add it to the container's hwpt_list,
>> letting this parent domain cover the entire stage-2 mappings (gPA=>PA).
>>
>> This allows a VFIO passthrough device to directly attach to this default
>> domain
>> and then to use the system address space and its listener.
>>
>> Introduce a vfio_device_viommu_get_nested() helper to facilitate this
>> implementation.
>> -------------------------
> Thanks, will do.
>
>>> It is safe because even if VIOMMU_CAP_HW_NESTED is returned, s->flts is
>>> forbidden and VFIO device fails in set_iommu_device() call, until we support
>>> passthrough device with x-flts=on.
>> I think this is too vendor specific to be mentioned here. Likely
>> the previous VTD patch is the place to have this.
>>
>> Or you could say:
>>
>> --------------------------
>> It is safe to do so because a vIOMMU will be able to fail in
>> set_iommu_device()
>> call, if something else related to the VFIO device or vIOMMU isn't compatible.
>> --------------------------
> Will do.
I would say: it is safe to add the flags |=
IOMMU_HWPT_ALLOC_NEST_PARENT; at this stage, despite the whole
functionality is not in place because HW_NESTED is currently forced off in

set_iommu_device()

Eric

>
>>> +bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
>>> +
>>> +    if (vdev) {
>>> +        return !!(pci_device_get_viommu_cap(&vdev->pdev) &
>>> +                  VIOMMU_CAP_HW_NESTED);
>> "get_nested" feels too general. Here it particularly means the cap:
>>
>> bool vfio_device_get_viommu_cap_hw_nested(VFIODevice *vbasedev)
> Will use vfio_device_get_viommu_cap_hw_nested()
>
>>> @@ -379,6 +379,14 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>      }
>>>
>>> +    /*
>>> +     * If vIOMMU supports stage-1 translation, force to create nested
>> parent
>>
>> "nested parent" is a contradictory phrase. Parent is a container
>> holding some nested items. A nested parent sounds like a "parent"
>> item that lives inside another parent container.
>>
>> In kernel kdoc/uAPI, we use:
>> - "nesting parent" for stage-2 object
>> - "nested hwpt", "nested domain" for stage-1 object
> Thanks for sharing this info, I didn't notice that. I will fix the whole series to use 'nesting parent'.
>
> BRs,
> Zhenzhong
>


