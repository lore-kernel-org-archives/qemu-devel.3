Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2403C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubi2T-0005yr-2W; Tue, 15 Jul 2025 11:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubhab-00056O-9L
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubhaY-00009Q-6R
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752593339;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKDy3efrhe0J40LzuaKh+SohJ0Z00blG7sNZI7sfpxU=;
 b=dt6JJ/PZtxTdHoKmbzPAQeMRj8oMMf+QQ3ZXT+dyZezJokG8Qe8LACPFoL2U1w+J4bz6Ji
 Ue//derUYzAGZBow5zmbnA7bFRXsgjZDoNVdK35ZHu+BOnzwABj7NYNLvtY0hn47sP02HS
 BJvdpEN1k2GPiOw2ll+TNU1Wb0NsE6M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-RDXOmnAGOiKfFPTAD7o6mQ-1; Tue, 15 Jul 2025 11:28:58 -0400
X-MC-Unique: RDXOmnAGOiKfFPTAD7o6mQ-1
X-Mimecast-MFC-AGG-ID: RDXOmnAGOiKfFPTAD7o6mQ_1752593337
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so32559005e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752593337; x=1753198137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKDy3efrhe0J40LzuaKh+SohJ0Z00blG7sNZI7sfpxU=;
 b=FeZOzI35BuDzZU/K3iFwC1SONQd9bACRhEfWrY9JTTxaHFzP/qgJ/7TOPMD/srwJB4
 ZF8WuyvUNMoZ76qAVVzZwTQi48IShThtGHDlddDmmJNnuUHiVWrgmdBrJerQk6FC8n0e
 18baL+MnhXlpUYc6f/Jau4216QxmKIklBIj+iJ1qBl1qdn7k9HufoWjpwhMRCrPtGtxd
 JQXtB6yyY5emIfgLTiUIrmR+z4Di7UCvWlEkJNmOE0uzID7neXVKyB6u3EkCnwj1XIek
 Io14AhjAqAUdB0AMFt7fTSWbUX/ijMZeZ7hDt+822/aIhUPArOhZP+jwbznpkhN4fD8v
 r0GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGa2q9uBU6Nwa06fZ6HoOdjSQwmOp3/LkWMNIsGIzdIcuW6weQJH20NNWiyuNmkQ1a5jAtVV8kSjHT@nongnu.org
X-Gm-Message-State: AOJu0Ywd3dMqyz+ghf83cq7NelFVAxc5tYPmGNqZJbyZisKFHL54HtwT
 bGAeKLef36qvXYBJ3hU3oSDd5TOqnR1AjSKgrsv/IUVp5CTNWu08zVBHL8rexZteda6jPJAA8Sx
 WUyP9ZHIVEJbqHfQvKkJCiyU5X41adPNQzxkPHGqIVimGajKhznTcIL0G
X-Gm-Gg: ASbGncvQg/9vA7tmbwxWipylM81zbVpUp5dvQFVKoxToBinaxcKSZBzQ+/UDvtgeuPv
 /RQ6Nde9QlC2DEIJWqFSj+iRSs9VgXN66A8vSJnHMONIiE06Hme86s/u9PHZ5SFgny34aJQyQbA
 SZgW9pOEmpc/h+4eW+VD3gYMkgyPJs+pRoyrvQSuLmGAJpWnF3pVgRefd0Vp+RPg5cvoFFn2GdM
 E43Y6aaOqnngrsynLMnlvx3zapmHrY3pcgbdHS7YDKYN5Pq9SGq/j9/v4A5DTKOl7QF1Rc2yUZS
 l5iaWEnwqsj8lbjptVdhC2Oj0/mVVgg9sqFBl/JrSve1KUjRs93MueHrqXpdZK90vDwcfFL98Bw
 sfCN+e1FHjCs=
X-Received: by 2002:a05:600c:8b0c:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-45623a67c65mr57101225e9.5.1752593336882; 
 Tue, 15 Jul 2025 08:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVbv95JX5W3Ly+xS7UGkxuBtCFjWzali2O8BFpQdyG92hFVcRpAR78ziVf6CMk8kpEMlBTig==
X-Received: by 2002:a05:600c:8b0c:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-45623a67c65mr57100945e9.5.1752593336462; 
 Tue, 15 Jul 2025 08:28:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45627962384sm12528495e9.2.2025.07.15.08.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:28:55 -0700 (PDT)
Message-ID: <b8c3b228-953f-4364-b78f-2702ae2bd183@redhat.com>
Date: Tue, 15 Jul 2025 17:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: Donald Dutile <ddutile@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
 <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
 <0c99b6aa-440a-44df-b875-a34e64465a04@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0c99b6aa-440a-44df-b875-a34e64465a04@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 7/10/25 3:22 AM, Donald Dutile wrote:
>
>
> On 7/9/25 3:20 PM, Nicolin Chen wrote:
>> On Wed, Jul 09, 2025 at 01:55:46PM -0400, Donald Dutile wrote:
>>>>> +enum {
>>>>> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table
>>>>> supported */
>>>>> +};
>>>>
>>>> Thanks for this work. I am happy to see that we can share the
>>>> common code that allocates a NESTING_PARENT in the core using
>>>> this flag.
>>>>
>>>> Yet on ARM, a STAGE1 page table isn't always a nested S1, the
>>>> hardware accelerated one. More often, it can be just a regular
>>>> 1-stage translation table via emulated translation code and an
>>>> emulated iotlb.
>>>>
>>> Because the user-created smmuv3 started as 'accelerated smmuv3',
>>> and had been 'de-accelerated' to simply 'user created smmuv3',
>>> I'm looking for some clarification in the above statement/request.
>>>
>>> Is the above suppose to reflect that a nested IOMMU has some
>>> hw-acceleration
>>> in its Stage1 implementation?
>>> If so, then call it that: STAGE1_ACCEL.
>>> If it's suppose to represent that an IOMMU has nested/2-stage support,
>>> then the above is a valid cap;  -but-, having a nested/2-stage
>>> support IOMMU
>>> doesn't necessarily mean its accelerated.
>>
>> Well, there are an emulated "nested" mode and an hw-accelerated
>> "nested" mode in the smmuv3 code, so we had to choose something
>> like "accel" over "nested".
>>
>> Here, on the other hand, I think the core using this CAP would
>> unlikely care about an emulated "nested" mode in the individual
>> vIOMMU..
>>
>> So I suggested:
>>       /* hardware-accelerated nested stage-1 page table support */
>>      VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
>>
>> which it should be clear IMHO.
>>
>> If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
>>
>> Thanks
>> Nicolin
>>
> If the distinction is hw-based s1 vs emulated-based s1, than
> I'd prefer the use of VIOMMU_CAP_HW_NESTED_S1, and avoid the use
VIOMMU_CAP_HW_NESTED_S1 or even VIOMMU_CAP_HW_NESTED look good to me too

Thanks

Eric
> of 'accel'/'ACCEL' unless it is an explicitly stated 'acceleration'
> feature/option in the SMMU spec.
>
> Thanks,
> - Don
>


