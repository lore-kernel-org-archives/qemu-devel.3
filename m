Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAE9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0Pp-0006Am-W2; Mon, 19 May 2025 09:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uH0Pd-000678-5k
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uH0PZ-0005IM-39
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747660806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=acOsY1Kwuo3yA0TzqMyob9QC+YxcsuEXGBG7gtAHXMM=;
 b=hN+KgLHzM8yD+7FUWHFCc57RcjHaWGYbczu4DkyZfHEqS6wsnYn+D8BPY3jvvGEWFvJyIC
 6F++JwUU84k19xk/wrX5FkcFyNPGG0h1jGNbeYhDtvbRLtAmSaWJxPio7fsoj+AX3YIdcA
 vHX3W6pKB6JcX3MvjBhm/m0/AHrVZNQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-4yLLlAlUPeCs7RwKiAIVQQ-1; Mon, 19 May 2025 09:20:05 -0400
X-MC-Unique: 4yLLlAlUPeCs7RwKiAIVQQ-1
X-Mimecast-MFC-AGG-ID: 4yLLlAlUPeCs7RwKiAIVQQ_1747660804
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a35bf8377fso2974441f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747660804; x=1748265604;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acOsY1Kwuo3yA0TzqMyob9QC+YxcsuEXGBG7gtAHXMM=;
 b=tcTUQnKvrjEdJVsjMsA0N0W6SkxgLUoGcohZcl1Oohzk3E9Rv30IhawzkUjgTasvzg
 8aNMkeP0cbu7VrCpnwFSFMfPt/6Nbwtk9fGaWggiICm3GLiVTdliw3Oh2KWg8WtK97xB
 whKyLq7LtjlK4XR18B/vZ4Z+a8LP20fTAkfVk4+MvyCl0YdHa1TPzILLP79/Zjq+CT+T
 26l+0l/hCUZ0Xz1GEWwJnuTbEoCrgXxrBT7NixCR7OM26y6ej8ynH+LWhe9FDOhOoOuZ
 fu7AXjw79G28XT1WxXZB+QMst0VDgaC9f4oU/OsTVoEozS6xhRv2epLnm0khqgVuISZm
 M/cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWHbf55SfgvG0PYJUmvVcLTqLZdpGfDJH15lBRS95isGB9m3aDajdCSMmuygUzSvqugNb9KV27bw2K@nongnu.org
X-Gm-Message-State: AOJu0YzV/zl6LXTtHvu/HtuQtenghAoLp/ySO2eHdlDaovdLpPyFEu94
 xN5uDvlpHToWFaP/226DPPLRg9V6lYy9UcAe97BaPqSrVk3t3Biondei+hjGviozXX9nMx8rb3H
 RfJ95OMQRriNI5RCnqNzGF4SCsESfEtaq7xsG4g5urehsLkNj07PWd2NK
X-Gm-Gg: ASbGncscsvnmksJDcigfV4RQxizoMuZeGyezC0Lvvo3AWMlag82+CvKGj6MqyRSGx0q
 tGlvLYDJO2eaepWI3HqHb8F9pWZLRDoYsQdN2GSoxBSC2HvGSCYQl7DYBz/0zk116NmXlLdWS72
 Wdat5ZmFfVu75q2DnUWNn7J0veAbZhkIA9uQPmY7YMbDRIyTdmkr7HcFXGq8naoUZBb3yMHJFyx
 GuC+1KEvH5S+sbK+K/5BOvfaclVdjWRg15akkE2XNhxaHV2d/bjsnID+Wm395lr4cLPmLNAhaMn
 y1Es2s+1YMMMrQkWED7UQxPGUdkWNXBa3/MFhUaWdNwX71aMcA==
X-Received: by 2002:a05:6000:2212:b0:3a0:b9a4:e516 with SMTP id
 ffacd0b85a97d-3a35fe677b0mr10383193f8f.17.1747660803624; 
 Mon, 19 May 2025 06:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjMUVNcHdqAeDXMFKQx67kEVil96+Hd0xaOZsFCWjbu3FcAM7WU5IXcn7yv6jm8ebpbjUrUw==
X-Received: by 2002:a05:6000:2212:b0:3a0:b9a4:e516 with SMTP id
 ffacd0b85a97d-3a35fe677b0mr10383174f8f.17.1747660803105; 
 Mon, 19 May 2025 06:20:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d0fasm12902445f8f.8.2025.05.19.06.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 06:20:02 -0700 (PDT)
Message-ID: <535df78b-0574-406f-a514-b10bafa57ba9@redhat.com>
Date: Mon, 19 May 2025 15:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/42] vfio/container: preserve descriptors
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-8-git-send-email-steven.sistare@oracle.com>
 <90ee0578-44f7-4e42-b69e-934833199eaf@redhat.com>
 <8a2d690b-c49f-4ee0-8887-b0f7c438c3a0@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8a2d690b-c49f-4ee0-8887-b0f7c438c3a0@oracle.com>
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
> On 5/15/2025 8:59 AM, Cédric Le Goater wrote:
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> At vfio creation time, save the value of vfio container, group, and device
>>> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
>>> the saved descriptors, and remembers the reused status for subsequent
>>> patches.  The reused status is cleared when vmstate load finishes.
>>>
>>> During reuse, device and iommu state is already configured, so operations
>>> in vfio_realize that would modify the configuration, such as vfio ioctl's,
>>> are skipped.  The result is that vfio_realize constructs qemu data
>>> structures that reflect the current state of the device.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   hw/vfio/container.c           | 65 ++++++++++++++++++++++++++++++++++++-------
>>>   hw/vfio/cpr-legacy.c          | 46 ++++++++++++++++++++++++++++++
>>>   include/hw/vfio/vfio-cpr.h    |  9 ++++++
>>>   include/hw/vfio/vfio-device.h |  2 ++
>>>   4 files changed, 112 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 85c76da..278a220 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -31,6 +31,8 @@
>>>   #include "system/reset.h"
>>>   #include "trace.h"
>>>   #include "qapi/error.h"
>>> +#include "migration/cpr.h"
>>> +#include "migration/blocker.h"
>>>   #include "pci.h"
>>>   #include "hw/vfio/vfio-container.h"
>>>   #include "hw/vfio/vfio-cpr.h"
>>> @@ -414,7 +416,7 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
>>>   }
>>>   static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>> -                                            Error **errp)
>>> +                                            bool cpr_reused, Error **errp)
>>>   {
>>>       int iommu_type;
>>>       const char *vioc_name;
>>> @@ -425,7 +427,11 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>>           return NULL;
>>>       }
>>> -    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>>> +    /*
>>> +     * If container is reused, just set its type and skip the ioctls, as the
>>> +     * container and group are already configured in the kernel.
>>> +     */
>>> +    if (!cpr_reused && !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>>>           return NULL;
>>>       }
>>> @@ -433,6 +439,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>>       container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>>>       container->fd = fd;
>>> +    container->cpr.reused = cpr_reused;
>>>       container->iommu_type = iommu_type;
>>>       return container;
>>>   }
>>> @@ -584,7 +591,7 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
>>>   }
>>>   static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>>> -                                     Error **errp)
>>> +                                     bool cpr_reused, Error **errp)
>>>   {
>>>       if (!vfio_container_attach_discard_disable(container, group, errp)) {
>>>           return false;
>>> @@ -592,6 +599,9 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>>>       group->container = container;
>>>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>>>       vfio_group_add_kvm_device(group);
>>> +    if (!cpr_reused) {
>>> +        cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>>> +    }
>>
>> Could we avoid the test on cpr_reused always call cpr_save_fd() ?
> 
> No.  If cpr_reused is true, then the fd is already on cpr's save list.
> We don't want to save duplicates of the same entry.

Can't we call cpr_find_fd() like in cpr_open_fd() ?

> 
>>>       return true;
>>>   }
>>> @@ -601,6 +611,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
>>>       group->container = NULL;
>>>       vfio_group_del_kvm_device(group);
>>>       vfio_ram_block_discard_disable(container, false);
>>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>>   }
>>>   static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>> @@ -613,17 +624,37 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>       VFIOIOMMUClass *vioc = NULL;
>>>       bool new_container = false;
>>>       bool group_was_added = false;
>>> +    bool cpr_reused;
>>>       space = vfio_address_space_get(as);
>>> +    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
>>> +    cpr_reused = (fd > 0);
>>
>>
>> The code above is doing 2 things : it grabs a restored fd and
>> deduces from the fd value that the VM is doing are doing a CPR
>> reboot.
>>
>> Instead of adding this cpr_reused flag, I would prefer to duplicate
>> the code into something like:
>>
>> if (!cpr_reboot) {
>>     QLIST_FOREACH(bcontainer, &space->containers, next) {
>>          container = container_of(bcontainer, VFIOContainer, bcontainer);
>>          if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>>              return vfio_container_group_add(container, group, errp);
>>          }
>>      }
>>
>>      fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>      if (fd < 0) {
>>          goto fail;
>>      }
>>
>>      ret = ioctl(fd, VFIO_GET_API_VERSION);
>>      if (ret != VFIO_API_VERSION) {
>>          error_setg(errp, "supported vfio version: %d, "
>>                     "reported version: %d", VFIO_API_VERSION, ret);
>>          goto fail;
>>      }
>>
>>      container = vfio_create_container(fd, group, errp);
>> } else {
>>     /* ... */
>> }
>>
> 
> OK, but there is no sense in duplicating the identical code for
> VFIO_GET_API_VERSION and vfio_create_container.  If you want me to
> simplify the loop, I suggest:
> 
> if (!cpr_reused) {
>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>           if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>               return vfio_container_group_add(container, group, false, errp);
>           }
>       }
> 
>       fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>       if (fd < 0) {
>           goto fail;
>       }
> } else {
>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>          container = container_of(bcontainer, VFIOContainer, bcontainer);
>          if (vfio_cpr_container_match(container, group, &fd)) {
>              return vfio_container_group_add(container, group, true, errp);
>          }
>      }
> }
> 
> ret = ioctl(fd, VFIO_GET_API_VERSION);
> ...

OK. Let's do that. I find it easier to read.


>>> +    /*
>>> +     * If the container is reused, then the group is already attached in the
>>> +     * kernel.  If a container with matching fd is found, then update the
>>> +     * userland group list and return.  If not, then after the loop, create
>>> +     * the container struct and group list.
>>> +     */
>>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>>> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>>> -            return vfio_container_group_add(container, group, errp);
>>> +
>>> +        if (cpr_reused) {
>>> +            if (!vfio_cpr_container_match(container, group, &fd)) {
>>
>> why do we need to modify fd ?
> 
> That is explained by the comments inside vfio_cpr_container_match, where the
> explanation is more easily understood.

I haven't been able to see what a modified fd was useful for before because
we test cpr_reused and in other places !cpr_reused :

         if (cpr_reused) {
             if (!vfio_cpr_container_match(container, group, &fd)) {
                 continue;
             }

and later

     if (!cpr_reused) {
         fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     }

I think I got it now. This was a bit confusing.

> 
>>> +                continue;
>>> +            }
>>> +        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>>> +            continue;
>>>           }
>>> +        return vfio_container_group_add(container, group, cpr_reused, errp);
>>> +    }
>>> +
>>> +    if (!cpr_reused) {
>>> +        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>>       }
>>> -    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>>       if (fd < 0) {>           goto fail;
>>>       }
>>> @@ -635,7 +666,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>           goto fail;
>>>       }
>>> -    container = vfio_create_container(fd, group, errp);
>>> +    container = vfio_create_container(fd, group, cpr_reused, errp);
>>>       if (!container) {
>>>           goto fail;
>>>       }
>>> @@ -655,7 +686,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>       vfio_address_space_insert(space, bcontainer);
>>> -    if (!vfio_container_group_add(container, group, errp)) {
>>> +    if (!vfio_container_group_add(container, group, cpr_reused, errp)) {
>>>           goto fail;
>>>       }
>>>       group_was_added = true;
>>> @@ -697,6 +728,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>>       QLIST_REMOVE(group, container_next);
>>>       group->container = NULL;
>>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>>       /*
>>>        * Explicitly release the listener first before unset container,
>>> @@ -750,7 +782,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>>       group = g_malloc0(sizeof(*group));
>>>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>>> -    group->fd = qemu_open(path, O_RDWR, errp);
>>> +    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, NULL, errp);
>>>       if (group->fd < 0) {
>>>           goto free_group_exit;
>>>       }
>>> @@ -782,6 +814,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>>       return group;
>>>   close_fd_exit:
>>> +    cpr_delete_fd("vfio_group", groupid);
>>>       close(group->fd);
>>>   free_group_exit:
>>> @@ -803,6 +836,7 @@ static void vfio_group_put(VFIOGroup *group)
>>>       vfio_container_disconnect(group);
>>>       QLIST_REMOVE(group, next);
>>>       trace_vfio_group_put(group->fd);
>>> +    cpr_delete_fd("vfio_group", group->groupid);
>>>       close(group->fd);
>>>       g_free(group);
>>>   }
>>> @@ -812,8 +846,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>>   {
>>>       g_autofree struct vfio_device_info *info = NULL;
>>>       int fd;
>>> +    bool cpr_reused;
>>> +
>>> +    fd = cpr_find_fd(name, 0);
>>> +    cpr_reused = (fd >= 0);
>>> +    if (!cpr_reused) {
>>> +        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>>> +    }
>>
>> Could we introduce an helper routine to open this file,  like we have
>> cpr_open_fd() ?
> 
> OK, but this would be the only use of the helper, and it would bury
> generic vfio functionality -- VFIO_GROUP_GET_DEVICE_FD -- inside a cpr
> flavored helper.  IMO not an improvement.

VFIO_GROUP_GET_DEVICE_FD would still be passed as a parameter and
so it won't be buried IMO. I don't dislike it that much.

However, I don't like the "if (cpr_reused)" statements scattered
throughout the code, so I'm looking for ways to bury them.


Thanks,

C.



> 
>>> -    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>>>       if (fd < 0) {
>>>           error_setg_errno(errp, errno, "error getting device from group %d",
>>>                            group->groupid);
>>> @@ -857,6 +897,10 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>>       vbasedev->group = group;
>>>       QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
>>> +    vbasedev->cpr.reused = cpr_reused;
>>> +    if (!cpr_reused) {
>>> +        cpr_save_fd(name, 0, fd);
>>
>> Could we avoid the test on cpr_reused always call cpr_save_fd() ?
> 
> No.  Must avoid adding duplicate entries.
> 
>>> +    }
>>>       trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
>>>       return true;
>>> @@ -870,6 +914,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
>>>       QLIST_REMOVE(vbasedev, next);
>>>       vbasedev->group = NULL;
>>>       trace_vfio_device_put(vbasedev->fd);
>>> +    cpr_delete_fd(vbasedev->name, 0);
>>>       close(vbasedev->fd);
>>>   }
>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>> index fac323c..638a8e0 100644
>>> --- a/hw/vfio/cpr-legacy.c
>>> +++ b/hw/vfio/cpr-legacy.c
>>> @@ -10,6 +10,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "hw/vfio/vfio-container.h"
>>>   #include "hw/vfio/vfio-cpr.h"
>>> +#include "hw/vfio/vfio-device.h"
>>>   #include "migration/blocker.h"
>>>   #include "migration/cpr.h"
>>>   #include "migration/migration.h"
>>> @@ -31,10 +32,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>>       }
>>>   }
>>> +static int vfio_container_post_load(void *opaque, int version_id)
>>> +{
>>> +    VFIOContainer *container = opaque;
>>> +    VFIOGroup *group;
>>> +    VFIODevice *vbasedev;
>>> +
>>> +    container->cpr.reused = false;
>>> +
>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>> +            vbasedev->cpr.reused = false;
>>> +        }
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>>   static const VMStateDescription vfio_container_vmstate = {
>>>       .name = "vfio-container",
>>>       .version_id = 0,
>>>       .minimum_version_id = 0,
>>> +    .post_load = vfio_container_post_load,
>>>       .needed = cpr_needed_for_reuse,
>>>       .fields = (VMStateField[]) {
>>>           VMSTATE_END_OF_LIST()
>>> @@ -68,3 +86,31 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>>       migrate_del_blocker(&container->cpr.blocker);
>>>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
>>>   }
>>> +
>>> +static bool same_device(int fd1, int fd2)
>>> +{
>>> +    struct stat st1, st2;
>>> +
>>> +    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
>>> +}
>>> +
>>> +bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
>>> +                              int *pfd)
>>> +{
>>> +    if (container->fd == *pfd) {
>>> +        return true;
>>> +    }
>>> +    if (!same_device(container->fd, *pfd)) {
>>> +        return false;
>>> +    }
>>> +    /*
>>> +     * Same device, different fd.  This occurs when the container fd is
>>> +     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
>>> +     * produces duplicates.  De-dup it.
>>> +     */
>>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>> +    close(*pfd);
>>> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>>> +    *pfd = container->fd;
>>
>> I am not sure 'pfd' is used afterwards. Is it ?
> 
> True, good eye.  I will change it to "int fd" and stop returning the new value.
> 
> - Steve
> 
>>
>>> +    return true;
>>> +}
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index f864547..1c4f070 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -13,10 +13,16 @@
>>>   typedef struct VFIOContainerCPR {
>>>       Error *blocker;
>>> +    bool reused;
>>>   } VFIOContainerCPR;
>>> +typedef struct VFIODeviceCPR {
>>> +    bool reused;
>>> +} VFIODeviceCPR;
>>> +
>>>   struct VFIOContainer;
>>>   struct VFIOContainerBase;
>>> +struct VFIOGroup;
>>>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>>                                           Error **errp);
>>> @@ -29,4 +35,7 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>>                                    Error **errp);
>>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>> +bool vfio_cpr_container_match(struct VFIOContainer *container,
>>> +                              struct VFIOGroup *group, int *fd);
>>> +
>>>   #endif /* HW_VFIO_VFIO_CPR_H */
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index 8bcb3c1..4e4d0b6 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -28,6 +28,7 @@
>>>   #endif
>>>   #include "system/system.h"
>>>   #include "hw/vfio/vfio-container-base.h"
>>> +#include "hw/vfio/vfio-cpr.h"
>>>   #include "system/host_iommu_device.h"
>>>   #include "system/iommufd.h"
>>> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>>>       VFIOIOASHwpt *hwpt;
>>>       QLIST_ENTRY(VFIODevice) hwpt_next;
>>>       struct vfio_region_info **reginfo;
>>> +    VFIODeviceCPR cpr;
>>>   } VFIODevice;
>>>   struct VFIODeviceOps {
>>
>>
>> Thanks,
>>
>> C.
>>
>>
> 


