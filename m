Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41998C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDag-0004FC-FP; Thu, 06 Mar 2025 10:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqDaO-0003N4-JU
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:56:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqDaM-0007Ff-Su
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741276593;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjM6zY5Yik7Qo+JU7LFR+LTH6lh/qDgoKWL6ATnBGkc=;
 b=E03nECidP0wmpmPwbcm0XS7rSIPkitywUDezU+gJDELThr3T1c0/guR0/lne3jTWNJDUKH
 IGJPEzZXPyPGErn0KQV/Jb7q00JWSsLqDhpRFv5l+4ZxJwPPm1QI1Pwja9UeL8YrJGAcsL
 CJ+CO6SZLHkLVQN5FGeOG+maOKfQOCo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-JK1hHK03O2ednaqrg5Zuwg-1; Thu, 06 Mar 2025 10:56:30 -0500
X-MC-Unique: JK1hHK03O2ednaqrg5Zuwg-1
X-Mimecast-MFC-AGG-ID: JK1hHK03O2ednaqrg5Zuwg_1741276588
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so10667245e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276588; x=1741881388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjM6zY5Yik7Qo+JU7LFR+LTH6lh/qDgoKWL6ATnBGkc=;
 b=JMy5VY/Ij2Bj66x3vjQY81Uz6V1873SyY9B2fugdlBmdfxR3UhTTRZ4V4t4mCYBuZK
 GrYSnJLRGpkacWucchSHPb5OjMZywlJOlIO8+W47Q/OlVGSeKuQXjFQH/2BJnaA9iqyl
 P4tcKc9GVNEhJnKqTl5QT6waIqol8PhQ5fAoIpS+ZK9yPlplcwHwlIICcu7Wldjr+I+j
 W8YQAgemz2Au3V3NoMuh2ORPDJyYblmyylffEBN00abi4arqKKOhYPZMj0IPiPb98i9v
 /1LZEGiy2koq0TPEB5x8M99grobrca3BUxdOLn+h2cA66+2HhOHnw+FJn6ZxJSYoTPcq
 QkFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYFEULxEf6jpPh9lHs6nBb45KppC1UYaKGMLuD8VCiQ+F273Grni1TZDWnxBUwEy0/spyflff/orcU@nongnu.org
X-Gm-Message-State: AOJu0YwwBPT8Av+NlGMpFJLdKkraYVSvPMSXsxeQELLbQq6DcFAwukY2
 LfiWID0j8xGk2cJVeQOaWeve4kWhl30sF/08kcH+ojG7uA+k1DFzSEX58T+MQQwwl9/IXXYXN0h
 MRMgtstwPqW6AFAONtwyWwTsuYDi8gokVGnWf3y2aXshimoHoHzYb
X-Gm-Gg: ASbGncuDeE/JiT7LDmjgZmpXc7GVMD+CruG3NMWFLqExcLasdS1VZLhdwqZJis4xG6l
 SMvYIUtwAd5IX0pPn1J6dkd/hfeB1zNVidVYoYlhj2ePQbalquhIjPvPLWIqVM8coz6HC/WThqY
 WJ5ix9csECY/1k3zAAB6r41jFuTfdju5bCdhrC1rzsbWkNuW6R47bHfPchU5mL/YF3D1ESwKoRA
 Mys4uosTTRPUy6gguBnFbByMrXx561pLvwGIBVCUVQzL2idLUsIagCOLQzyDH+yz7eaqLjt1VXi
 7DdILqWvODVm3fCYue9BQKiSgGSXE4oppL7usHEETUpeiXuBWskZ26ba3lVB7hY=
X-Received: by 2002:a05:600c:458f:b0:439:91c7:895a with SMTP id
 5b1f17b1804b1-43bdb38dd94mr30742725e9.7.1741276587995; 
 Thu, 06 Mar 2025 07:56:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEXZtC3h1HxHZp5QLqSWMCM/WBI97psT+YZ5fi8+s++1dWsKn6/ymprw7Qm1Q609DT/Q46mg==
X-Received: by 2002:a05:600c:458f:b0:439:91c7:895a with SMTP id
 5b1f17b1804b1-43bdb38dd94mr30742505e9.7.1741276587566; 
 Thu, 06 Mar 2025 07:56:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba87csm2478466f8f.17.2025.03.06.07.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 07:56:26 -0800 (PST)
Message-ID: <3f200adc-13fc-44e8-ba86-04508a2c44e8@redhat.com>
Date: Thu, 6 Mar 2025 16:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 05/20] vfio/iommufd: Implement [at|de]tach_hwpt
 handlers
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-6-zhenzhong.duan@intel.com>
 <65c7bf72-10d2-4183-b548-f0f842083c49@redhat.com>
 <SJ0PR11MB6744DB4CF84B062FF62022B992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744DB4CF84B062FF62022B992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/28/25 9:24 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH rfcv2 05/20] vfio/iommufd: Implement [at|de]tach_hwpt
>> handlers
>>
>>
>>
>>
>> On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>>> Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
>>> utilizes them to attach to or detach from hwpt on host side.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 53639bf88b..175c4fe1f4 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -802,6 +802,24 @@ static void
>> vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>>      vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>>>  };
>>>
>>> +static bool
>> can't we return an integer instead. This looks more standard to me
> I can do that, but I remember VFIO honors bool return value
> whenever possible. We had ever cleanup patches to make all functions
> return bool when possible. Do we really want to return int for only these
> two functions?
I now remember those patches from Cédric. As I mentionned realier I have
not found in the errp doc that this was a requirement but nevertheless
ignore this comment then ;-)

Eric
>
> Thanks
> Zhenzhong
>
>> Eric
>> +host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD
>> *idev,
>>> +                                           uint32_t hwpt_id, Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
>>> +
>>> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
>>> +}
>>> +
>>> +static bool
>>>
>> +host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUF
>> D *idev,
>>> +                                           Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
>>> +
>>> +    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
>>> +}
>>> +
>>>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void
>> *opaque,
>>>                                        Error **errp)
>>>  {
>>> @@ -863,11 +881,15 @@
>> hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>>>  static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>>>  {
>>>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>>> +    HostIOMMUDeviceIOMMUFDClass *idevc =
>> HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
>>>      hiodc->realize = hiod_iommufd_vfio_realize;
>>>      hiodc->realize_late = hiod_iommufd_vfio_realize_late;
>>>      hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>>>      hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
>>> +
>>> +    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
>>> +    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
>>>  };
>>>
>>>  static const TypeInfo types[] = {


