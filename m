Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6C5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAbW-0000KC-0E; Tue, 23 Jul 2024 04:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAbV-0000GZ-64
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAbP-0006DT-A9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721722230;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7I5F9iM/Upxm5GQhGDtAiuUoLIRrA1Ko1Oij4y+/6I=;
 b=YS1GO3Yc0Q4TQfdQDGB3Rbceaaywo8TIRgPi2mEFssvIpl01oDZxrxOH1o4IltpakBhkBH
 m7UwR40Ekpfp4aBbxqPnU24pEt7g9nHmdZtPDL8kmpLkWl2aPI9x4fq5WRX8MJ83AEUiCf
 vJ43XpTAMdJDHbqm3D2KCzemlmjZ9A8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-S11mfXK5NbKltcBarWSzPA-1; Tue, 23 Jul 2024 04:10:28 -0400
X-MC-Unique: S11mfXK5NbKltcBarWSzPA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5d5545ca462so3121033eaf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721722227; x=1722327027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L7I5F9iM/Upxm5GQhGDtAiuUoLIRrA1Ko1Oij4y+/6I=;
 b=A2L77Rv/pTQ/yez4UYDmoZz+7U+TiLM1EgPa4+ycyVc8/lhin7pcWOv79ULsPnaybh
 jcwlMUYblVEkYbIpeH2SPT9OHp44cbbfb1VR1uQVEjJrBfYDv2liYfzi1tXqVh6nyxrH
 P2zWqD7TDMBcxO/SfGDZnFg+VwUWgl7+YACcdUWGTiqkYVBZx5fO4MGZv5w4K8TkS871
 uDUZ8tR/y3H1eQWEiLRZnV1xmmBbaEWYdycIaUtIhI/vPgxdXEx04DgpHx8K3jyI0A+L
 exKhbjPxI1U03wfCwgvw81O3X24SfAjAZOfjY2IgbKIVb8Gql6u1Mddu/Jq61FDmxkWK
 KNdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmidosbpGNmLIyw/K6rf28LhAQFUDGYf7hzvZMnRWau+nNCmqP+iwZfy2AOfCDNK5vN85l7ZNwpvUDU38W43gL4G6xteU=
X-Gm-Message-State: AOJu0YyhnkRzFkj2yj/xxR8/MpvSnuEDTCUSbdBEy8FS4ZS/WtQ4Dkqu
 wC+TurNEc67i08ZQStNY7p1fYXWtw3WnkwX3KcZhBynAfoRsji4oUUWgZyNy9Q8Ec4bhXf0P+dD
 hbe45uUvCUSspaL3/5l7AMsqSPIBvm42oFTaIm+CzohRdY/nNKM+X
X-Received: by 2002:a4a:e90a:0:b0:5c6:9293:ed9d with SMTP id
 006d021491bc7-5d564f774c8mr14372986eaf.4.1721722227572; 
 Tue, 23 Jul 2024 01:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe8FTKdlIAZObcEIfJOA5sgMtT+D27zXEPzZOXn2NeglMlVhv2cyIOeRbbz5LxnTeEjv/ZwA==
X-Received: by 2002:a4a:e90a:0:b0:5c6:9293:ed9d with SMTP id
 006d021491bc7-5d564f774c8mr14372964eaf.4.1721722227142; 
 Tue, 23 Jul 2024 01:10:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7b467ff80sm41153226d6.124.2024.07.23.01.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:10:26 -0700 (PDT)
Message-ID: <bdcf91a8-7d3c-4b5d-bd41-3b74df88aaa4@redhat.com>
Date: Tue, 23 Jul 2024 10:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
 <eae669f6-f24f-4573-9934-2c6fb5b364ad@redhat.com>
 <8405600f-ffa2-43c2-8e51-7b6674de11ae@redhat.com>
 <e0ad88d2-c78d-4d28-9655-08fd5a92fe2b@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e0ad88d2-c78d-4d28-9655-08fd5a92fe2b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/23/24 10:05, Joao Martins wrote:
> On 23/07/2024 08:55, Eric Auger wrote:
>>
>> On 7/23/24 09:44, Cédric Le Goater wrote:
>>> On 7/23/24 09:38, Eric Auger wrote:
>>>> Hi Joao,
>>>>
>>>> On 7/22/24 23:13, Joao Martins wrote:
>>>>> Move the HostIOMMUDevice::realize() to be invoked during the attach
>>>>> of the device
>>>>> before we allocate IOMMUFD hardware pagetable objects (HWPT). This
>>>>> allows the use
>>>>> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell
>>>>> if the IOMMU
>>>>> behind the device supports dirty tracking.
>>>>>
>>>>> Note: The HostIOMMUDevice data from legacy backend is static and
>>>>> doesn't
>>>>> need any information from the (type1-iommu) backend to be initialized.
>>>>> In contrast however, the IOMMUFD HostIOMMUDevice data requires the
>>>>> iommufd FD to be connected and having a devid to be able to
>>>>> successfully
>>>> Nit: maybe this comment shall be also added in iommufd.c before the call
>>>> to vfio_device_hiod_realize() to avoid someone else to move that call
>>>> earlier at some point
>>>>> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
>>>>> different places within the backend .attach_device() implementation.
>>>>>
>>>>> Suggested-by: Cédric Le Goater <clg@redhat.cm>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>>   hw/vfio/common.c              | 16 ++++++----------
>>>>>   hw/vfio/container.c           |  4 ++++
>>>>>   hw/vfio/helpers.c             | 11 +++++++++++
>>>>>   hw/vfio/iommufd.c             |  4 ++++
>>>>>   5 files changed, 26 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-common.h
>>>>> b/include/hw/vfio/vfio-common.h
>>>>> index 1a96678f8c38..4e44b26d3c45 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>>>>>   void vfio_reset_handler(void *opaque);
>>>>>   struct vfio_device_info *vfio_get_device_info(int fd);
>>>>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>>>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>>>                           AddressSpace *as, Error **errp);
>>>>>   void vfio_detach_device(VFIODevice *vbasedev);
>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>> index 784e266e6aab..da12cbd56408 100644
>>>>> --- a/hw/vfio/common.c
>>>>> +++ b/hw/vfio/common.c
>>>>> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name, VFIODevice
>>>>> *vbasedev,
>>>>>   {
>>>>>       const VFIOIOMMUClass *ops =
>>>>>          
>>>>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>>>> -    HostIOMMUDevice *hiod;
>>>>> +    HostIOMMUDevice *hiod = NULL;
>>>>>         if (vbasedev->iommufd) {
>>>>>           ops =
>>>>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>>>> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name,
>>>>> VFIODevice *vbasedev,
>>>>>         assert(ops);
>>>>>   -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>>> -        return false;
>>>>> -    }
>>>>>   -    if (vbasedev->mdev) {
>>>>> -        return true;
>>>>> +    if (!vbasedev->mdev) {
>>>>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>>>> +        vbasedev->hiod = hiod;
>>>>>       }
>>>>>   -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>>>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>>>>> errp)) {
>>>>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>>>           object_unref(hiod);
>>>>> -        ops->detach_device(vbasedev);
>>>>> +        vbasedev->hiod = NULL;
>>>>>           return false;
>>>>>       }
>>>>> -    vbasedev->hiod = hiod;
>>>>>         return true;
>>>>>   }
>>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>>> index 10cb4b4320ac..9ccdb639ac84 100644
>>>>> --- a/hw/vfio/container.c
>>>>> +++ b/hw/vfio/container.c
>>>>> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const
>>>>> char *name, VFIODevice *vbasedev,
>>>>>         trace_vfio_attach_device(vbasedev->name, groupid);
>>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>>> +        return false;
>>>> don't you want to go to err_alloc_ioas instead?
>>> hmm, the err_alloc_ioas label is in a different function
>>> iommufd_cdev_attach().
>>>
>>> may be you meant the comment for routine iommufd_cdev_attach() and
>>> label err_connect_bind ?
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>>> +    }
>>>>> +
>>>>>       group = vfio_get_group(groupid, as, errp);
>>>>>       if (!group) {
>>>>>           return false;
>>>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>>>> index 7e23e9080c9d..ea15c79db0a3 100644
>>>>> --- a/hw/vfio/helpers.c
>>>>> +++ b/hw/vfio/helpers.c
>>>>> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>>>>>       subsys = realpath(tmp, NULL);
>>>>>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>>>>>   }
>>>>> +
>>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>>>>> +{
>>>>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>>>> +
>>>>> +    if (!hiod) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod,
>>>>> vbasedev, errp);
>>>>> +}
>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>> index 5e2fc1ce089d..2324bf892c56 100644
>>>>> --- a/hw/vfio/iommufd.c
>>>>> +++ b/hw/vfio/iommufd.c
>>>>> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char
>>>>> *name, VFIODevice *vbasedev,
>>>>>         space = vfio_get_address_space(as);
>>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>>> +        return false;
>> Hum sorry my previous comment was targetting that place. I think
>> unrolling is needed up to put_address_space
>>
>> so effectively this does not match err_alloc_ioas but I guess we would
>> need another label
>>
> You're right. We haven't yet attached rthe device and that's what err_alloc_ioas
> would do. Adding another label not sure would make things cleaner given the
> ordering requirement. So maybe this instead?
>
> @@ -482,7 +483,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice
> *vbasedev,
>      space = vfio_get_address_space(as);
>
>      if (!vfio_device_hiod_realize(vbasedev, errp)) {
> -        return false;
> +        vfio_put_address_space(space);
> +        goto err_connect_bind;
>      }
>
>      /* try to attach to an existing container in this space */
>
With that addition
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


