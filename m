Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45247C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdZ3-0002ow-1m; Mon, 23 Jun 2025 05:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTdZ1-0002oY-Qo
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTdYy-0001DE-Hn
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750671243;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9fYRQSvbOhgYrjZc60FJtL49g6dy5/w7D39+7XpydY=;
 b=FHZ8WeBSe6Rv7v1kBRGLU1w3PTEjChP4n0MODfhJVdonrd8NmdJDDJgMI4TsoJtbyPMMAc
 2Krlk1haSEdbS/g94yfu6vaTpFGxMaOXOl7Kh39QeKJn28Ftq9Ukfe5huNwBQWBZkiKgAE
 aMwP2MzizSFrXzZHNiaOM+qb2dcKgO0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-vQRIzxPFNbuVp9a6P-kqNw-1; Mon, 23 Jun 2025 05:34:00 -0400
X-MC-Unique: vQRIzxPFNbuVp9a6P-kqNw-1
X-Mimecast-MFC-AGG-ID: vQRIzxPFNbuVp9a6P-kqNw_1750671239
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4535d300d2dso30872595e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 02:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750671239; x=1751276039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9fYRQSvbOhgYrjZc60FJtL49g6dy5/w7D39+7XpydY=;
 b=wL8jp3YcSpQ2xCNvfW4GRscxW8YAGI9Y7m8FuSJ5Lf79uoVrlxe15gX852DueSAJlP
 QRTW8jOw3T57fVmcCVOpy38bUSdmveDTf+3A31imcwc7JdDrXIhPYB/+v9v0JbKPoife
 u/HNMLPKQksLf5Hl9IBuCnMSN946oQ71Ag7WTwr5sVovdjWjdoixx0I6LiJ7EsyYpYuM
 3vgP+MEQ97YvAZJcFX7opOLpfi06XEta/81koJpfNJAWYeQ97c5EtpS/4zYmu24c0d0o
 D2lwqhzOozevUTlToFs7R8aMz0v0y/wnACDLbBjk/dhEY/1HYqYXKvUyKbJl1y7VxgCh
 7zLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtEyW0fO1E31c2qmzYnkIoyd1TKj1zXnbrIlKKaD4ThHfwLSHq9wXThMlsIvcnen3HpAd3qQwUNSA+@nongnu.org
X-Gm-Message-State: AOJu0Yz9EJcqcOcFAvh0S8oIH0SVlR2PycZMuNMgNNM1XuJVACIPfoC+
 p8shY6udIjwKF5HFRfvp6IW/UIeZEVsovuDhOH6Gdwkb8XIlS5Fn2ffjCcMI8tllrGx4D+srNf7
 YYnaW02QRJ+83enNXO/wN0JnI4V0mmJxfnBNilblABEHmU1lM8bVv4eyR
X-Gm-Gg: ASbGncsjoW7cSTNLCNBcohNSihI0/Lk7NYyNlFL2qEpqaLnPn6wAez/lbtRFwAAratq
 uM23cANkWSEqGameI7nwGD1XWPIrOR7fQtumS+s9MSpZ9InLVVXuoBPpDT++hW+hV6OzZWiygoo
 gZlOEVxq1Ka6mDQ7Mpx2l/kUQ6sQtawkr/bIiidAt3Kn6btfctBiHXDTp6fS15fz7fgrIukb+cq
 ckBGKAgLcKv1xsB0k43Jm3MH3n36sHNAmod3AYqi+oufSkqAd3Rm7oOEeM69ySMXqO5prG/BoSE
 DBarqJlfH/EBH6FQihs0nIPETcpDdElQpsudjnZ4JW8jgw/Wk+LCA0gOfw0EE94BYDtoJA==
X-Received: by 2002:a05:600c:1da0:b0:451:833f:483c with SMTP id
 5b1f17b1804b1-453653d4544mr102886375e9.7.1750671239315; 
 Mon, 23 Jun 2025 02:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRpLj37EO78ufF10z5GLzphmoDFxtE2zgGZtgepOagfuMmgYVUueaQo31eaP5WpshYg2n7rQ==
X-Received: by 2002:a05:600c:1da0:b0:451:833f:483c with SMTP id
 5b1f17b1804b1-453653d4544mr102885975e9.7.1750671238787; 
 Mon, 23 Jun 2025 02:33:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45374582452sm29336945e9.31.2025.06.23.02.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 02:33:58 -0700 (PDT)
Message-ID: <64ed418b-3e9e-4f8b-b513-874fc71f6873@redhat.com>
Date: Mon, 23 Jun 2025 11:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/19] Workaround for ERRATA_772415_SPR17
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-19-zhenzhong.duan@intel.com>
 <ec96eb95-f0d7-4d9e-986c-46367afef7fa@redhat.com>
 <IA3PR11MB91366EF1B3F2D45D1EEC1D859279A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB91366EF1B3F2D45D1EEC1D859279A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



On 6/23/25 5:29 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v2 18/19] Workaround for ERRATA_772415_SPR17
>>
>> Hi Zhenzhong,
>>
>> On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
>>> On a system influenced by ERRATA_772415,
>> IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
>>> is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the
>> readonly
>>> range mapped on stage-2 page table could still be written.
>> I would split this patch into a vfio only patch and an iommu one that
>> sets bcontainer->readonly according to the fetched info.
> Will do.
>
>>> Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
>>> Update, Errata Details, SPR17.
>>> https://www.intel.com/content/www/us/en/content-details/772415/content-
>> details.html
>> the link does not work for me.
> That's strange, what about:
>
> https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
yes this link works for me.
>
>> Please could you explain in english what the errata is about and what
>> actions need to be taken care in VFIO?
>>
>> Sorry I failed to understand "
>>
>> Due to this errata, even the readonly
>> range mapped on stage-2 page table could still be written.
> Copy the explanation in above link:
>
> "SPR17. Remapping Hardware May Set Access/Dirty Bits in a First-stage
> Page-table Entry
>
> Problem: When remapping hardware is configured by system software in
> scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
> PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
> Access bit if enabled) in first-stage page-table entries even when
> second-stage mappings indicate that corresponding first-stage page-table
> is Read-Only.
>
> Implication: Due to this erratum, pages mapped as Read-only in second-stage
> page-tables may be modified by remapping hardware Access/Dirty bit updates.
>
> Workaround: None identified. System software enabling nested translations
> for a VM should ensure that there are no read-only pages in the
> corresponding second-stage mappings."
OK this definitively helps. I will further look at the patch with that
background

Eric
>
>> "
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/vfio/vfio-container-base.h |  1 +
>>>  hw/vfio/iommufd.c                     |  8 +++++++-
>>>  hw/vfio/listener.c                    | 13 +++++++++----
>>>  3 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>>> index f0232654ee..e5c51a51ac 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -51,6 +51,7 @@ typedef struct VFIOContainerBase {
>>>      QLIST_HEAD(, VFIODevice) device_list;
>>>      GList *iova_ranges;
>>>      NotifierWithReturn cpr_reboot_notifier;
>>> +    bool bypass_ro;
>>>  } VFIOContainerBase;
>>>
>>>  typedef struct VFIOGuestIOMMU {
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 83a632bdee..23839a511a 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -306,6 +306,7 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>  {
>>>      ERRP_GUARD();
>>>      IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>> +    struct iommu_hw_info_vtd vtd;
>> = {}; ?
> Will do.
>
>>>      uint32_t type, flags = 0;
>>>      uint64_t hw_caps;
>>>      VFIOIOASHwpt *hwpt;
>>> @@ -345,10 +346,15 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>       * instead.
>>>       */
>>>      if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev-
>>> devid,
>>> -                                         &type, NULL, 0, &hw_caps, errp)) {
>>> +                                         &type, &vtd, sizeof(vtd), &hw_caps,
>>> +                                         errp)) {
>>>          return false;
>>>      }
>>>
>>> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>>> +        container->bcontainer.bypass_ro = true;
>>> +    }
>>> +
>>>      if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>      }
>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>> index f498e23a93..c64aa4539e 100644
>>> --- a/hw/vfio/listener.c
>>> +++ b/hw/vfio/listener.c
>>> @@ -364,7 +364,8 @@ static bool
>> vfio_known_safe_misalignment(MemoryRegionSection *section)
>>>      return true;
>>>  }
>>>
>>> -static bool vfio_listener_valid_section(MemoryRegionSection *section,
>>> +static bool vfio_listener_valid_section(VFIOContainerBase *bcontainer,
>>> +                                        MemoryRegionSection *section,
>>>                                          const char *name)
>>>  {
>>>      if (vfio_listener_skipped_section(section)) {
>>> @@ -375,6 +376,10 @@ static bool
>> vfio_listener_valid_section(MemoryRegionSection *section,
>>>          return false;
>>>      }
>>>
>>> +    if (bcontainer && bcontainer->bypass_ro && section->readonly) {
>>> +        return false;
>>> +    }
>>> +
>>>      if (unlikely((section->offset_within_address_space &
>>>                    ~qemu_real_host_page_mask()) !=
>>>                   (section->offset_within_region & ~qemu_real_host_page_mask()))) {
>>> @@ -494,7 +499,7 @@ void vfio_container_region_add(VFIOContainerBase
>> *bcontainer,
>>>      int ret;
>>>      Error *err = NULL;
>>>
>>> -    if (!vfio_listener_valid_section(section, "region_add")) {
>>> +    if (!vfio_listener_valid_section(bcontainer, section, "region_add")) {
>>>          return;
>>>      }
>>>
>>> @@ -655,7 +660,7 @@ static void vfio_listener_region_del(MemoryListener
>> *listener,
>>>      int ret;
>>>      bool try_unmap = true;
>>>
>>> -    if (!vfio_listener_valid_section(section, "region_del")) {
>>> +    if (!vfio_listener_valid_section(bcontainer, section, "region_del")) {
>>>          return;
>>>      }
>>>
>>> @@ -812,7 +817,7 @@ static void vfio_dirty_tracking_update(MemoryListener
>> *listener,
>>>          container_of(listener, VFIODirtyRangesListener, listener);
>>>      hwaddr iova, end;
>>>
>>> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
>>> +    if (!vfio_listener_valid_section(NULL, section, "tracking_update") ||
>>>          !vfio_get_section_iova_range(dirty->bcontainer, section,
>>>                                       &iova, &end, NULL)) {
>>>          return;
>> Thanks
>>
>> Eric


