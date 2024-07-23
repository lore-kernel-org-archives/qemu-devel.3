Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B181EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAiG-0002DP-BA; Tue, 23 Jul 2024 04:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAiE-0002Cu-Fa
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAi8-00082T-WF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721722648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FzyOrxXk+459hPGRbCpPZhwJR9zT7+iIdMYi1n7jgs=;
 b=dzyoQBlcGtYMcKh4Y0FZ/IeKe5BecGDy1yVSIoRAYCzdmzi9hiLOj4HfWT9kBtUEYwT1u/
 lYuYJuFcJKorGSb0C8rMoNZcV8KWHIkV1HP40RyqrXWbGTgJ1dMahIXwT5L8ePlHdudiQm
 Ngv/go05zF7+th7vvLWaXm4V7CMBjWg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-lKn6VhkfMfiqelKBzQCljA-1; Tue, 23 Jul 2024 04:17:26 -0400
X-MC-Unique: lKn6VhkfMfiqelKBzQCljA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426624f4ce3so35637685e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721722645; x=1722327445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7FzyOrxXk+459hPGRbCpPZhwJR9zT7+iIdMYi1n7jgs=;
 b=YbjiPbYapJSEIkUizKnhGVKUMVYdK13vSeoGkjyVZ/wEqwyh8jTNOPMkKqOlRFnGsW
 U6msi2JjCHPX+IRy33tD2f+9ucFz1J/xCLXSKROIVS06BlEkFSGqlHIaUm8EhpvyxXSS
 W+zCyMDLkKiDnb8FF1J8lA/XGGl4jXyNxZI1y8wOaoKsV27h4wWdi6ixI+GMrAutdRE5
 0bXbv4c1KUEjPrP4j02VE4072oN8UGD46ulMt1P7yU92UutWYEgQFotNQEhjLKKpVCpj
 3xbbfCaqZ3+LWIKiqwveq7pDQGUyZDlKO1TyHRwKvyVpamoxpQo6aOYkMYGFUOuW0O3q
 JbEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg9O0p3oxzu0fUJIDfgcLXWIU/ywcWZIB+PpuKPIlwerMCNBP+/uS50G50ZmZHzk4Ngw6sedL+ELxc5gLVcsxxSP6sB0w=
X-Gm-Message-State: AOJu0Yz1nmYKl2o1FPpMfX+F+MWaGQPj6vD5VgBWEANrts32Hjp+lG7h
 M8gtsYSk0ZQKh7oXHZT/bNyYBSVP0iz18ED8ssf0wRF+JDcR8owDVej+uaHL93g8YKXMmKKA7Fl
 qLmcTZjhG0cpRlRubrw01hiszfD4vIctdSetVOi8omg8o9bLle4KV
X-Received: by 2002:a05:600c:4f4d:b0:425:7796:8e2c with SMTP id
 5b1f17b1804b1-427dc520498mr53558735e9.12.1721722645159; 
 Tue, 23 Jul 2024 01:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK5s1mKJCQqXKe+q8Z3buPOdpjBgccFmJyVSfJceQ4e5/I54DsKFXeAR3cbZ93VvcOJcepHQ==
X-Received: by 2002:a05:600c:4f4d:b0:425:7796:8e2c with SMTP id
 5b1f17b1804b1-427dc520498mr53558605e9.12.1721722644765; 
 Tue, 23 Jul 2024 01:17:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e2a1sm186455435e9.31.2024.07.23.01.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:17:24 -0700 (PDT)
Message-ID: <f69184e5-bdf3-4d22-adff-d4646f59e1ec@redhat.com>
Date: Tue, 23 Jul 2024 10:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-7-joao.m.martins@oracle.com>
 <0a1aada1-ad2f-4e4b-b690-b78ef55c849c@redhat.com>
 <17085e0a-3145-4be9-9670-cb9a9292cfc6@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <17085e0a-3145-4be9-9670-cb9a9292cfc6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 7/23/24 10:14, Joao Martins wrote:
> On 23/07/2024 09:03, Eric Auger wrote:
>> Hi Joao,
>>
>> On 7/22/24 23:13, Joao Martins wrote:
>>> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>>> enables or disables dirty page tracking. The ioctl is used if the hwpt
>>> has been created with dirty tracking supported domain (stored in
>>> hwpt::flags) and it is called on the whole list of iommu domains.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/sysemu/iommufd.h |  2 ++
>>>  backends/iommufd.c       | 23 +++++++++++++++++++++++
>>>  hw/vfio/iommufd.c        | 32 ++++++++++++++++++++++++++++++++
>>>  backends/trace-events    |  1 +
>>>  4 files changed, 58 insertions(+)
>>>
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> index e917e7591d05..6fb412f61144 100644
>>> --- a/include/sysemu/iommufd.h
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -55,6 +55,8 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>>                                  uint32_t data_type, uint32_t data_len,
>>>                                  void *data_ptr, uint32_t *out_hwpt,
>>>                                  Error **errp);
>>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>>> +                                        bool start, Error **errp);
>>>  
>>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>  #endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 06b135111f30..b97883503884 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -238,6 +238,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>>      return true;
>>>  }
>>>  
>>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>>> +                                        uint32_t hwpt_id, bool start,
>>> +                                        Error **errp)
>>> +{
>>> +    int ret;
>>> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
>>> +            .size = sizeof(set_dirty),
>>> +            .hwpt_id = hwpt_id,
>>> +            .flags = start ? IOMMU_HWPT_DIRTY_TRACKING_ENABLE : 0,
>>> +    };
>>> +
>>> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>>> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno : 0);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno,
>>> +                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
>>> +                         hwpt_id);
>>> +        return false;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>                                       uint32_t *type, void *data, uint32_t len,
>>>                                       uint64_t *caps, Error **errp)
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 7afea0b041ed..b882a3f59a6e 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -115,6 +115,37 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>      return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>  }
>>>  
>>> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>> +                                           bool start, Error **errp)
>>> +{
>>> +    const VFIOIOMMUFDContainer *container =
>>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>>> +    VFIOIOASHwpt *hwpt;
>>> +
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>>> +            continue;
>>> +        }
>> so here I see you handle the case where we have hwpts with and without
>> support for dirty tracking within the same container so I guess this
>> answers my previous question. So do you want to tag a container as
>> dirty_pages_supported = true as soon as one device is backed up with a
>> dirty tracking hwpt within that container? I think I miss the high level
>> view of when this case may happen and why the devices do not end up in
>> different containers/ioas. But maybe I completely mix up things &
>> objects. Eric
> I think the only gap I have in this series that I don't catch exactly right in
> all this logic, is when the IOMMU dirty tracking is not homogeneous, which
> remains to be seen in pratice (from h/w perspective). That's where we currently
> have a gap here. Other than that, either we do 'all VFs do dirty tracking' or
> 'all devices are backed by IOMMU'.
>
> A container may have different hwpt with different capabilities e.g. systems
> where IOMMU instances have different dirty tracking ability (again I don't know
> if these exist). Which, on hwpt without dirty tracking, on which the devices
> attached to it that lack VF dirty tracking should be added an LM blocker.
>
> These checks were added from the previous cycles, but I was actually thinking in
> making these g_assert() to make sure this is not exercised like that. But
> considering I plan on improve a mixed usage of VF dirty tracking with IOMMU I
> left them as simply checks.

OK fair enough. Keeping that in mind for future consolidations

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
>>> +
>>> +        if (!iommufd_backend_set_dirty_tracking(container->be,
>>> +                                                hwpt->hwpt_id, start, errp)) {
>>> +            goto err;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +err:
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>>> +            continue;
>>> +        }
>>> +        iommufd_backend_set_dirty_tracking(container->be,
>>> +                                           hwpt->hwpt_id, !start, NULL);
>>> +    }
>>> +    return -EINVAL;
>>> +}
>>> +
>>>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>>  {
>>>      ERRP_GUARD();
>>> @@ -725,6 +756,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>>      vioc->attach_device = iommufd_cdev_attach;
>>>      vioc->detach_device = iommufd_cdev_detach;
>>>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>>> +    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>>>  };
>>>  
>>>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index 4d8ac02fe7d6..28aca3b859d4 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
>>>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>>>  iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>>> +iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"


