Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820D7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAaP-0004h1-WD; Tue, 23 Jul 2024 04:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAaN-0004Ym-2W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAaK-0005qS-O8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721722162;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jP8uwunWmSmVeVAUrQ97enG+K92ZmNif+KnYjksLYc=;
 b=K3PeWDOBT0GY/2MT1MkkC0m/w2rF4WqUzVLNiYOAsxr/n7H0H/98JnIoS78rjfTDtHaGx1
 1mkJiyre4QW83TTu2/LqcfU9+Hj8Wr6iWT8Qhqq7Y8K/NmvBa5lQRNKXjFWWKRKze6kyrD
 SMS4RdPNy/62pCTA5Sn+ZbxPhnkChg8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-l_AKM7uQMaaRsjUJx3Lx1Q-1; Tue, 23 Jul 2024 04:09:19 -0400
X-MC-Unique: l_AKM7uQMaaRsjUJx3Lx1Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79f18746082so745051885a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721722158; x=1722326958;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+jP8uwunWmSmVeVAUrQ97enG+K92ZmNif+KnYjksLYc=;
 b=KCqCQd9WRJ/MtuuqlMMo5COEkmct1f08rr0Q/KJc3TyFhbU7OvciiG4mFBP2kJHOzl
 7DRmTr4yQgv3QjXCnUiGqmGEvte+SfD9mUVLpa85+crUg3mYOThm0Q/KiOGs6F53tNic
 lDdi/lAE1Y+5SmgKH2u964qgtO6TpRYmrUGAJK7VEtOxfJlpqrGo5XMaDZG10kachfPj
 Lcr8cuKQK65glLjjdNdZ5aE2hb67GPyFYYwMFsu+7HjTt3PiVL2+e5rzD8crnB4O6OSO
 NQ9asmKdIgVOhEOk0Qo4PEZZ8Yxq83HszsrKMkWeCwg6PmRjNYhlEMJccGX3jk+CjDh6
 DjCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeOVUwC94j638uQeiShYD6fnjK5qmz8GnQf1G/jCJwoUboh3HGGgd9RebZk8v/NpgWc0Uw+uRiMUUpFZdbztgXBbBAbQ4=
X-Gm-Message-State: AOJu0YzlbIgIb8+BPKX5wdSZ4F/dmYNrcgYpVj8HzGA0XMtApQerJzYO
 X0RDAmjPZV9NqMBT4oCySgBeitmwEknVwrdJqjhwD0r+RfoAztJMIQJj7BLhZN448v8iRaWtmju
 km9EBWEBXOsk53lVtHLj70YaXfu+YdmZnjvYwEQAardof/ldgr8iz
X-Received: by 2002:a05:6214:f2d:b0:6b0:90d8:b698 with SMTP id
 6a1803df08f44-6b95a6e9b14mr145750026d6.45.1721722158569; 
 Tue, 23 Jul 2024 01:09:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvfBIcmrXTE76TdpiRPU0mWRQ/eaDTPlhvLVYrQkDrDFNaN8Yqo5wbXYNTvLfRtdPfwJOA2Q==
X-Received: by 2002:a05:6214:f2d:b0:6b0:90d8:b698 with SMTP id
 6a1803df08f44-6b95a6e9b14mr145749816d6.45.1721722158115; 
 Tue, 23 Jul 2024 01:09:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7b467ff80sm41153226d6.124.2024.07.23.01.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:09:17 -0700 (PDT)
Message-ID: <9245593d-4347-422d-8cd1-d1e694e93562@redhat.com>
Date: Tue, 23 Jul 2024 10:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
 <2fd72e9b-c3b1-488c-a532-546ddf3612e0@redhat.com>
 <832a6eab-1f63-411c-a827-018b12264513@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <832a6eab-1f63-411c-a827-018b12264513@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/23/24 10:00, Joao Martins wrote:
> On 23/07/2024 08:50, Eric Auger wrote:
>> Hi Joao,
>>
>> On 7/22/24 23:13, Joao Martins wrote:
>>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>>> supports dirty tracking. This is done via the data stored in
>>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>>
>>> Qemu doesn't know if VF dirty tracking is supported when allocating
>>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>>> dirty tracking it always creates HWPTs with IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>>> even if later on VFIOMigration decides to use VF dirty tracking instead.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  include/hw/vfio/vfio-common.h |  2 ++
>>>  hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
>>>  2 files changed, 22 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 4e44b26d3c45..1e02c98b09ba 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>  
>>>  typedef struct VFIOIOASHwpt {
>>>      uint32_t hwpt_id;
>>> +    uint32_t hwpt_flags;
>>>      QLIST_HEAD(, VFIODevice) device_list;
>>>      QLIST_ENTRY(VFIOIOASHwpt) next;
>>>  } VFIOIOASHwpt;
>>> @@ -139,6 +140,7 @@ typedef struct VFIODevice {
>>>      OnOffAuto pre_copy_dirty_page_tracking;
>>>      bool dirty_pages_supported;
>>>      bool dirty_tracking;
>>> +    bool iommu_dirty_tracking;
>>>      HostIOMMUDevice *hiod;
>>>      int devid;
>>>      IOMMUFDBackend *iommufd;
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 2324bf892c56..7afea0b041ed 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -110,6 +110,11 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>>      iommufd_backend_disconnect(vbasedev->iommufd);
>>>  }
>>>  
>>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>> +{
>>> +    return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +}
>>> +
>>>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>>  {
>>>      ERRP_GUARD();
>>> @@ -246,6 +251,17 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>          }
>>>      }
>>>  
>>> +    /*
>>> +     * This is quite early and VFIO Migration state isn't yet fully
>>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>>> +     * whether IOMMU dirty tracking is going to be requested. Later
>>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>>> +     * instead.
>>> +     */
>>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +    }
>>> +
>>>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>                                      container->ioas_id, flags,
>>>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> @@ -255,6 +271,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>  
>>>      hwpt = g_malloc0(sizeof(*hwpt));
>>>      hwpt->hwpt_id = hwpt_id;
>>> +    hwpt->hwpt_flags = flags;
>>>      QLIST_INIT(&hwpt->device_list);
>>>  
>>>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> @@ -265,8 +282,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>      }
>>>  
>>>      vbasedev->hwpt = hwpt;
>>> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> +    container->bcontainer.dirty_pages_supported |=
>>> +                                vbasedev->iommu_dirty_tracking;
>> Is it possible to have several devices with different
>>
>> iommu_dirty_tracking value in the same container? In other words would they be attached to different container/ioas?
>>
> In theory, yes, they can be in the same container/ioas. But I guess with IOMMUFD
> it's possible that we can allocate different containers for different devices
> given that we can manipulate/pass a different IOMMUFD object.
Yes I would have suspected they would end up in different
containers/ioas but I am not sure.
>
> In pratice I don't know if such HW platforms even exist where different IOMMU
> instances present different value of dirty tracking, given that this is a IOMMU
> feature, rather than endpoint dependent. In x86 it's homogeneous, and likely on
> smmuv3 server too. There are indeed endpoint related features which may be
on ARM you may have several SMMU instances. I do agree that the
likelyhood of those instances having heterogeneous dirty page tracking
support is low but well I don't know. Maybe we should add a wanrning at
least, later on if this case arises.

Eric
> different in IOMMU instances, but those only reflect on logic that the device
> needs to implement (e.g. PCIe PRS).
>
> Having said that I can only think of mdevs, where the realize() will block
> migration because the vbasedev->iommu_dirty_tracking is 0 should the mdev not
> support dma-logging vfio (but it doesn't go via this codepath above anyhow).
>


