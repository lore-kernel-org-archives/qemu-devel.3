Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E181C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4uh-0008Rt-TX; Wed, 17 Jul 2024 09:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4ud-00085Q-3q
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4uZ-0007vR-Uh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721223698;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0O8Sv5nh3HFR8wOWebwvlmNmfhHz4N9/OoMiaJ1mrQ=;
 b=ZiPZ4kEiVYHqMcmLb8f0MGhxNVNUWw8hFaSfUx8ZXaCPvvJG+1MmLIQYo0KC7wxOQuF8Wh
 s+5dvaRb8JkWws8Qt1s/X9x6MSQnzYomN3u52bprVzbdMfibAeQ46fTkBQDPNNGqPL7Lnl
 LtYXDDkg5zV+v2fIO5RjWCVAb9lAWNM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-RmZoKFU2OzKgNGIKEIwlFQ-1; Wed, 17 Jul 2024 09:41:35 -0400
X-MC-Unique: RmZoKFU2OzKgNGIKEIwlFQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3679ed08797so4399623f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223694; x=1721828494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0O8Sv5nh3HFR8wOWebwvlmNmfhHz4N9/OoMiaJ1mrQ=;
 b=erM0LO2QU6NfTUwszi+VXJoTOOJBpZnv2jVxPJJaqYBglHSBu7AWO3v58WepRAypkf
 wcvMDayJ60S/KSa+ZQMAHRYlIcf3ejST62m5LExRETnejTlZo6RAiLRg/zDlR5y0RGwg
 5oWNHIY9POk82wDzl0NW3i/mS2SmutBrTA/rFtfLDT8/pju++aV9Vx4/onYEuhQtbR3c
 mBXHZwdDpod5PnFnusYfmu6EGAOWFaoUBE4HFCBRNq+awS4bS7iZTKaC39AvIhCwV47Q
 U+Pzd8+yZs03ddjyRTeu8Cz6mAVKPV6g/bzNEY2F45SWbDEFvyqM8uDIqjFo42DpTAUi
 Ekzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKeBq9Y57XH/57btv9LKONtLK09dUL0O8+poE32f4YlJm545dZCZvxSlTRO99bOhbPQguVBUZCkz7G0JsTTBYGNJTl/BM=
X-Gm-Message-State: AOJu0Yy4Jfzx0Dp6vmH/g5LSEHGRlbMqHZlukukVjsQaIAQT68/Et9nE
 WNmy7CB1RGF34BrOgLZb0GZZHERYquIoNWrgUR+qYCUPFBa8r3XR4/JUt8vUb8PKiJMHljB6PLV
 WP5jvYf+qMLdR69NkjNX+OB5of6jguUQMy5+Cd/Tx5TdD9ye8x36v
X-Received: by 2002:adf:ff8f:0:b0:35f:2366:12c5 with SMTP id
 ffacd0b85a97d-368315fbfe5mr1203361f8f.23.1721223694485; 
 Wed, 17 Jul 2024 06:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJlxcoYlOuEhvpUGuN3ZA534JBNbEeqAwA7PDv7cjx7vvGONgq0Folnbgk+gpCp8A6UZ39Q==
X-Received: by 2002:adf:ff8f:0:b0:35f:2366:12c5 with SMTP id
 ffacd0b85a97d-368315fbfe5mr1203339f8f.23.1721223693979; 
 Wed, 17 Jul 2024 06:41:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm11803380f8f.69.2024.07.17.06.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:41:33 -0700 (PDT)
Message-ID: <61849951-cc63-4ea3-8934-100e13964419@redhat.com>
Date: Wed, 17 Jul 2024 15:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
 <6b67c303-774a-44cb-bbe0-24df973ab889@redhat.com>
 <5be3fb70-e4bd-420b-b229-d8f8356cc2cd@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5be3fb70-e4bd-420b-b229-d8f8356cc2cd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/17/24 14:33, Joao Martins wrote:
> On 17/07/2024 13:19, Eric Auger wrote:
>> Hi Joao,
>>
>> On 7/12/24 13:46, Joao Martins wrote:
>>> Fetch IOMMU hw raw caps behind the device and thus move the
>> what does mean "Fetch IOMMU hw raw caps behind the device'"
> Fetching the out_capabilities field from GET_HW_INFO which essentially tell us
> if the IOMMU behind the device supports dirty tracking.
that's much clearer than the 1st sentence
>
>>> HostIOMMUDevice::realize() to be done during the attach of the device. It
>>> allows it to cache the information obtained from IOMMU_GET_HW_INFO from
>> what do you mean by " It allows it to cache the information obtained
>> from IOMMU_GET_HW_INFO from iommufd early on"
> /me nods
?
>
>>> iommufd early on. However, while legacy HostIOMMUDevice caps
>> what does mean "legacy HostIOMMUDevice caps always return true"?
> That means that it can't fail, and the data in there is synthetic:
>
>     VFIODevice *vdev = opaque;
>
>     hiod->name = g_strdup(vdev->name);
>     hiod->agent = opaque;
>
>     return true;
>
> The IOMMUFD one might fail if GET_HW_INFO fails.
so you talk about hiod_legacy_vfio_realize() and not "

legacy HostIOMMUDevice caps"!

>
>>> always return true and doesn't have dependency on other things, the IOMMUFD
>>> backend requires the iommufd FD to be connected and having a devid to be
>>> able to query capabilities. Hence when exactly is HostIOMMUDevice
>>> initialized inside backend ::attach_device() implementation is backend
>>> specific.
>>>
>>> This is in preparation to fetch parse hw capabilities and understand if
>> fetch parse?
>>> dirty tracking is supported by device backing IOMMU without necessarily
>>> duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
>> But we move code from generic place to BE specific place?
>>
> No because in IOMMUFD needs the backend connected, while the legacy backend
> doesn't. Otherwise this patch wouldn't be needed to be backend specific.
>
>> Sorry I feel really hard to understand the commit msg in general
>>
> How about this:
>
>     Fetch IOMMU hw raw caps behind the device and thus move the
You need to tell what the patch does and why.

"Fetch IOMMU hw raw caps behind the device" sentence does not clearly fit in any.

>     HostIOMMUDevice::realize() to be done during the attach of the device.
>
>     This is in preparation to fetch parse hw capabilities and understand if
>     dirty tracking is supported by device backing IOMMU without necessarily
>     duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
>
>     Note that the HostIOMMUDevice data with legacy backend is synthetic
>     and doesn't need any information from the (type1-iommu) backend. While the
>     IOMMUFD backend requires the iommufd FD to be connected and having a devid
>     to be able to query device capabilities seeded in HostIOMMUDevice. This
>     means that HostIOMMUDevice initialization (i.e. ::realized() is invoked) is
>     container backend specific.
>
>
>
>
>> Eric
>>
>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  include/sysemu/host_iommu_device.h |  1 +
>>>  hw/vfio/common.c                   | 16 ++++++----------
>>>  hw/vfio/container.c                |  6 ++++++
>>>  hw/vfio/iommufd.c                  |  7 +++++++
>>>  4 files changed, 20 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
>>> index 20e77cf54568..b1e5f4b8ac3e 100644
>>> --- a/include/sysemu/host_iommu_device.h
>>> +++ b/include/sysemu/host_iommu_device.h
>>> @@ -24,6 +24,7 @@
>>>   */
>>>  typedef struct HostIOMMUDeviceCaps {
>>>      uint32_t type;
>>> +    uint64_t hw_caps;
>> please also update the doc comment
> OK
>
>>>  } HostIOMMUDeviceCaps;
>>>  
>>>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index b0beed44116e..cc14f0e3fe24 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1544,7 +1544,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>  {
>>>      const VFIOIOMMUClass *ops =
>>>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>> -    HostIOMMUDevice *hiod;
>>> +    HostIOMMUDevice *hiod = NULL;
>>>  
>>>      if (vbasedev->iommufd) {
>>>          ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>> @@ -1552,21 +1552,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>  
>>>      assert(ops);
>>>  
>>> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>> -        return false;
>>> -    }
>>>  
>>> -    if (vbasedev->mdev) {
>>> -        return true;
>>> +    if (!vbasedev->mdev) {
>>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>> +        vbasedev->hiod = hiod;
>>>      }
>>>  
>>> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>          object_unref(hiod);
>>> -        ops->detach_device(vbasedev);
>>> +        vbasedev->hiod = NULL;
>>>          return false;
>>>      }
>>> -    vbasedev->hiod = hiod;
>>>  
>>>      return true;
>>>  }
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index c27f448ba26e..29da261bbf3e 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -907,6 +907,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>>                                        AddressSpace *as, Error **errp)
>>>  {
>>>      int groupid = vfio_device_groupid(vbasedev, errp);
>>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>>      VFIODevice *vbasedev_iter;
>>>      VFIOGroup *group;
>>>      VFIOContainerBase *bcontainer;
>>> @@ -917,6 +918,11 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>>  
>>>      trace_vfio_attach_device(vbasedev->name, groupid);
>>>  
>>> +    if (hiod &&
>>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>>> +        return false;
>>> +    }
>>> +
>>>      group = vfio_get_group(groupid, as, errp);
>>>      if (!group) {
>>>          return false;
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 873c919e319c..d34dc88231ec 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -384,6 +384,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>>      Error *err = NULL;
>>>      const VFIOIOMMUClass *iommufd_vioc =
>>>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>>  
>>>      if (vbasedev->fd < 0) {
>>>          devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>>> @@ -401,6 +402,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>>  
>>>      space = vfio_get_address_space(as);
>>>  
>>> +    if (hiod &&
>>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>>> +        return false;
>>> +    }
>>> +
>>>      /* try to attach to an existing container in this space */
>>>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>>>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>>> @@ -722,6 +728,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>  
>>>      hiod->name = g_strdup(vdev->name);
>>>      caps->type = type;
>>> +    caps->hw_caps = hw_caps;
>>>  
>>>      return true;
>>>  }


