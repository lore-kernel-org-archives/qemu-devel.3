Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F34FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0bR-0001so-OV; Mon, 19 May 2025 09:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uH0bK-0001rz-Up
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uH0bI-0006bV-9k
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747661533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E9bYno2kxueG0raqXKXBLfhS51ngmqnzx8qes0+NT+c=;
 b=Sfzr/6M08PWb4utyANfOzTrYkGRXNG5h0HIAxqJVSh+luBrwsvN6zn/2XfOaX6cPgs+UfW
 xGe0Lq37ZjOu+ODxYgl8oHptnvUju/paeAi89eUjQb8cAFuJsO4tkSvF4lT0eiW14HsdYf
 KMveu2VoIC1IlZP1mRnNk/S3dk5wEok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-mqE-5-hcNj-u4660lkPIjg-1; Mon, 19 May 2025 09:32:12 -0400
X-MC-Unique: mqE-5-hcNj-u4660lkPIjg-1
X-Mimecast-MFC-AGG-ID: mqE-5-hcNj-u4660lkPIjg_1747661531
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so31672675e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747661531; x=1748266331;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9bYno2kxueG0raqXKXBLfhS51ngmqnzx8qes0+NT+c=;
 b=u8Qs6e8V3qLcFukBwfuZb2yEZPMdESWaEl3QwLm9EH6e3OZY7pbmnobftc9saafCJc
 k+hyoEsnxCu/Q9cSk0Pva12d0GHnZzfSqgkINAzAFA575m0A3gckynUiJPquwJ1qyPQb
 HcMkIjWE5jACXLHWicGxFCvPGQrVvbqPig7mPf/uG09ynQjasERkaie3vT9piSoqS6fO
 mRCxfL6+T0q3RfzyTyYLmAPZQjjvEjhFDQJKmyr84tqeuSEJL2sK2Upmfl/5KqpLF53M
 A98G0ql1k7fsU+BxQjzy6mLZ2MIUFj/chm9zZMRehhEKyqgdl78asSvRqNwHoaZtbffY
 yKhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcK8056MYUpLHfsi4m2o9rGk/zCbqrQF8BXjuj9SyfFcNKRtkrH4DIOQFHwILretLvHS7TbcDIM9zM@nongnu.org
X-Gm-Message-State: AOJu0YzU2/RP/qdnsrGMNQCkUFOOZBYZJ2EVyq3WTYvWUTiHFJ/5dryZ
 wjV2q5jwCa5WjK0iEcYS1suLNCOEqMlpF7cN4N8uxgP91+1PwOoXm7KxqAI1qbB05BXKbVCAvvq
 mi8aJ5IgQI+LI1X7EU2xujlEecObztrv/U1aciBfYzlW1SQaDJLrzQcqv
X-Gm-Gg: ASbGncuOAq/gj1QlpVi4c7dC//pQy01T86rF0nQXq4d1BbLk2F9Oo+EQTfHwq+62jEN
 2EMjCBejDDae7t7I1wHQ97Foqg/iwLelgO/ImjkTTMok4Y+XBcEQMrbubqyqvEMWJ3i/KqRLSgN
 6k3DORZtEV5xD8vpBg/XxDtYIBB2d+bkxaDQczx/XdqwH5aIfBS0+YzCoGnlBoTTuE6W0CnjsQ2
 w6cMVyo3YKFi+J7ummhW4MsWNYTbwZTEFxEpBY0XiRVBG6BmQyzbaUvxhrB9oJuZ/2V1QW6Fjx8
 z696mcWN92QytmZO5kdG0E9TwRAn5tlA6XskGxPBv7uMthu/nQ==
X-Received: by 2002:a05:600c:8487:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-442fefd77c6mr110017865e9.1.1747661531344; 
 Mon, 19 May 2025 06:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsBSbBg98dMJLBVBmToc3YrtOUOMv1gs5tliinZuNG5RTOzAeeQE3tXkfvYrC6iEqm8VFTZg==
X-Received: by 2002:a05:600c:8487:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-442fefd77c6mr110017455e9.1.1747661530948; 
 Mon, 19 May 2025 06:32:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd594707sm142937445e9.33.2025.05.19.06.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 06:32:09 -0700 (PDT)
Message-ID: <2e53aa41-30a4-4912-9919-4048a51828a8@redhat.com>
Date: Mon, 19 May 2025 15:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/42] vfio/container: restore DMA vaddr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-11-git-send-email-steven.sistare@oracle.com>
 <0501dd8f-7cae-456e-b4d7-e80b8aaaa5b2@redhat.com>
 <8a5c86ea-f0aa-4b84-9efd-1ce0edb2e7fc@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8a5c86ea-f0aa-4b84-9efd-1ce0edb2e7fc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/15/25 21:08, Steven Sistare wrote:
> On 5/15/2025 9:42 AM, Cédric Le Goater wrote:
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> In new QEMU, do not register the memory listener at device creation time.
>>> Register it later, in the container post_load handler, after all vmstate
>>> that may affect regions and mapping boundaries has been loaded.  The
>>> post_load registration will cause the listener to invoke its callback on
>>> each flat section, and the calls will match the mappings remembered by the
>>> kernel.
>>>
>>> The listener calls a special dma_map handler that passes the new VA of each
>>> section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
>>> handler at the end.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   hw/vfio/container.c  | 15 +++++++++++++--
>>>   hw/vfio/cpr-legacy.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 61 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index a554683..0e02726 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
>>>       int ret;
>>>       Error *local_err = NULL;
>>> +    assert(!container->cpr.reused);
>>> +
>>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>               bcontainer->dirty_pages_supported) {
>>> @@ -691,8 +693,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>       }
>>>       group_was_added = true;
>>> -    if (!vfio_listener_register(bcontainer, errp)) {
>>> -        goto fail;
>>> +    /*
>>> +     * If reused, register the listener later, after all state that may
>>> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
>>> +     * the listener will invoke its callback on each flat section and call
>>> +     * dma_map to supply the new vaddr, and the calls will match the mappings
>>> +     * remembered by the kernel.
>>> +     */
>>> +    if (!cpr_reused) {
>>> +        if (!vfio_listener_register(bcontainer, errp)) {
>>> +            goto fail;
>>> +        }
>>
>> hmm, I am starting to think we should have a vfio_cpr_container_connect
>> routine too.
> 
> I think that would obscure rather than clarify the code, since the normal
> non-cpr action of calling vfio_listener_register would be buried in a
> cpr flavored function name.
> 
>>>       }
>>>       bcontainer->initialized = true;
>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>> index 519d772..bbcf71e 100644
>>> --- a/hw/vfio/cpr-legacy.c
>>> +++ b/hw/vfio/cpr-legacy.c
>>> @@ -11,11 +11,13 @@
>>>   #include "hw/vfio/vfio-container.h"
>>>   #include "hw/vfio/vfio-cpr.h"
>>>   #include "hw/vfio/vfio-device.h"
>>> +#include "hw/vfio/vfio-listener.h"
>>>   #include "migration/blocker.h"
>>>   #include "migration/cpr.h"
>>>   #include "migration/migration.h"
>>>   #include "migration/vmstate.h"
>>>   #include "qapi/error.h"
>>> +#include "qemu/error-report.h"
>>>   static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>>   {
>>> @@ -32,6 +34,34 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>>       return true;
>>>   }
>>> +/*
>>> + * Set the new @vaddr for any mappings registered during cpr load.
>>> + * Reused is cleared thereafter.
>>> + */
>>> +static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>>> +                                   hwaddr iova, ram_addr_t size, void *vaddr,
>>> +                                   bool readonly)
>>> +{
>>> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>> +                                                  bcontainer);
>>> +    struct vfio_iommu_type1_dma_map map = {
>>> +        .argsz = sizeof(map),
>>> +        .flags = VFIO_DMA_MAP_FLAG_VADDR,
>>> +        .vaddr = (__u64)(uintptr_t)vaddr,
>>> +        .iova = iova,
>>> +        .size = size,
>>> +    };
>>> +
>>> +    assert(container->cpr.reused);
>>> +
>>> +    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
>>> +        error_report("vfio_legacy_cpr_dma_map (iova %lu, size %ld, va %p): %s",
>>> +                     iova, size, vaddr, strerror(errno));
>>
>> Callers should also report the error. No need to do it here.
> 
> This function has the same signature as the dma_map class method,
> which does not return an error message.  It's existing implementations
> use error_report.


backends .dma_map handlers : vfio_legacy_dma_map(), iommufd_backend_map_dma()
don't report errors. vfio_container_dma_map() doesn't either.

callers of vfio_container_dma_map() : vfio_iommu_map_notify(),
vfio_listener_region_add() report errors.


Thanks,

C.


> 
>>> +        return -errno;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>>   {
>>> @@ -63,12 +93,24 @@ static int vfio_container_pre_save(void *opaque)
>>>   static int vfio_container_post_load(void *opaque, int version_id)
>>>   {
>>>       VFIOContainer *container = opaque;
>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>>       VFIOGroup *group;
>>>       VFIODevice *vbasedev;
>>> +    Error *err = NULL;
>>> +
>>> +    if (!vfio_listener_register(bcontainer, &err)) {
>>> +        error_report_err(err);
>>> +        return -1;
>>> +    }
>>>       container->cpr.reused = false;
>>>       QLIST_FOREACH(group, &container->group_list, container_next) {
>>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>> +
>>> +        /* Restore original dma_map function */
>>> +        vioc->dma_map = vfio_legacy_dma_map;
>>> +
>>>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>               vbasedev->cpr.reused = false;
>>>           }
>>> @@ -80,6 +122,7 @@ static const VMStateDescription vfio_container_vmstate = {
>>>       .name = "vfio-container",
>>>       .version_id = 0,
>>>       .minimum_version_id = 0,
>>> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
>>>       .pre_save = vfio_container_pre_save,
>>>       .post_load = vfio_container_post_load,
>>>       .needed = cpr_needed_for_reuse,
>>> @@ -104,6 +147,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>>> +    /* During incoming CPR, divert calls to dma_map. */
>>> +    if (container->cpr.reused) {
>>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
>>
>> You could backup the previous dma_map() handler in a static variable or,
>> better, under container->cpr.
> 
> OK.
> 
> - Steve


