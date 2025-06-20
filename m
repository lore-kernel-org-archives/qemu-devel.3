Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B35C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeBE-0004c2-0x; Fri, 20 Jun 2025 12:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSeB9-0004aq-DM
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSeB7-0003hx-E3
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750435277;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpWHwc4W/lF1pbw83vZzmhSUuU8x1nmApfO+BKnMHOU=;
 b=FGS00p2bnqns4gy21y7tO5jJsTVeTf+3N8Y0KeUPLb1Dz4T5qLGadbVH9iuDw2ucLwFGfV
 rt4kvatgCgHAJbocTdpqQB7wt13obtAkpCfnzv7t458lvtHKjhp0KsEsl+FXUmNvjSh8Bz
 9+QobcMineyGTnd2PnJY9dG8Kk0zNfw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-tQcoGavBNpGfCfY2pIZ86g-1; Fri, 20 Jun 2025 12:01:14 -0400
X-MC-Unique: tQcoGavBNpGfCfY2pIZ86g-1
X-Mimecast-MFC-AGG-ID: tQcoGavBNpGfCfY2pIZ86g_1750435273
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so1067302f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750435273; x=1751040073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZpWHwc4W/lF1pbw83vZzmhSUuU8x1nmApfO+BKnMHOU=;
 b=I611saZXYx+/ypAvaJd/6Cuy2Exocx2HaXrd/dqPhPfgD748eneL5D5oHZNL/UdlGZ
 fAWy1GWYdHcO8moK9L86ZCZrXnIm7t22N2eW7fJXrB2vHJ5197avAW7ydQw38K3AXqWe
 KB1Cry3CtQytujNhjL0xh9YzYiNM1ffIZhmLJzf+Gf2BN+AmYl2ihRmhrrXwlcn+lm6x
 G60X0QaGoughG+LHICEcq1A1ZKyoPeE+l1bCnbJe0mSu9h3u5xxUG+21SRCQYj46cc4A
 CoZSsJhqopsDKS2hGWvu+5Q1xWhbsKSfqfOIzcRFAV3xeKKW795xk0skJ8T2Crrz66ym
 UQyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyfbms2Eq1/UHdpjiTaO3OdZs2bQOrstq3YAqySCK4IJ/60s8XrRBCDR4e/E2AtErUjMIsD9R2ndf5@nongnu.org
X-Gm-Message-State: AOJu0YwfKMoJooH5r8wYjWa5SumlGhUMKJJcwr5vxCSYbdaioZkwizCu
 le1jwZc/dfYWczJCj5ZCttrmnAQDV8pr7B7Dd9cSzFvVVpHJ7S2ks+ZNXpDkMpoGL7d8wtoDVmF
 /ra4cPSJfDr/oezkTs9QIfpcysDpU1FzhMgdrAZkoWzeuq7WudM0v6J+W
X-Gm-Gg: ASbGncuyiMmugHrZUmerYEfggP44SGkYUDtteKz1br1bBETsNiEuGE8YH9D/EO/QiML
 E+BMkHgn2n71VAYr2vbKBREmuMnbVi0+Smj25nhyrIHmvyAE6vaAYimtSp221qVkfveqoxQO4n/
 oaRZ63tANvfSIEoKdzGljyX8/WL+sl4OoBMroaN1euI6oqTWyx2+zSZGBraOyG4LMNBTz/oc5rP
 i80p9UUdq4P2Q+fyDYlxlDT3zJn0KVMlNY6nN7zv+9qBaxQSmmquN1b/VnNYtW8Dgcs2Kyqzpgo
 t6605c9vvi9tjQulbWZQVMwnAgtjQ7QbdLNDGZcmm2SsVVM539mXlQQ3vvrKd31eMBN0GA==
X-Received: by 2002:a05:6000:40cb:b0:3a5:8a68:b815 with SMTP id
 ffacd0b85a97d-3a6d12e68ccmr2950044f8f.46.1750435272598; 
 Fri, 20 Jun 2025 09:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7WHRU87ad9JjyayASLTxsPeVW8bbQntGHsCToKNWeSbpEE5IIq4mP1Ph2igReVvJd6MaMtw==
X-Received: by 2002:a05:6000:40cb:b0:3a5:8a68:b815 with SMTP id
 ffacd0b85a97d-3a6d12e68ccmr2949857f8f.46.1750435270334; 
 Fri, 20 Jun 2025 09:01:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187e5fsm2413053f8f.70.2025.06.20.09.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 09:01:09 -0700 (PDT)
Message-ID: <ec96eb95-f0d7-4d9e-986c-46367afef7fa@redhat.com>
Date: Fri, 20 Jun 2025 18:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/19] Workaround for ERRATA_772415_SPR17
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-19-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Zhenzhong,

On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
> is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
> range mapped on stage-2 page table could still be written.

I would split this patch into a vfio only patch and an iommu one that
sets bcontainer->readonly according to the fetched info.
>
> Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
> Update, Errata Details, SPR17.
> https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
the link does not work for me.

Please could you explain in english what the errata is about and what
actions need to be taken care in VFIO?

Sorry I failed to understand "

Due to this errata, even the readonly
range mapped on stage-2 page table could still be written.

"
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-container-base.h |  1 +
>  hw/vfio/iommufd.c                     |  8 +++++++-
>  hw/vfio/listener.c                    | 13 +++++++++----
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index f0232654ee..e5c51a51ac 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -51,6 +51,7 @@ typedef struct VFIOContainerBase {
>      QLIST_HEAD(, VFIODevice) device_list;
>      GList *iova_ranges;
>      NotifierWithReturn cpr_reboot_notifier;
> +    bool bypass_ro;
>  } VFIOContainerBase;
>  
>  typedef struct VFIOGuestIOMMU {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 83a632bdee..23839a511a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -306,6 +306,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>  {
>      ERRP_GUARD();
>      IOMMUFDBackend *iommufd = vbasedev->iommufd;
> +    struct iommu_hw_info_vtd vtd;
= {}; ?
>      uint32_t type, flags = 0;
>      uint64_t hw_caps;
>      VFIOIOASHwpt *hwpt;
> @@ -345,10 +346,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * instead.
>       */
>      if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> -                                         &type, NULL, 0, &hw_caps, errp)) {
> +                                         &type, &vtd, sizeof(vtd), &hw_caps,
> +                                         errp)) {
>          return false;
>      }
>  
> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> +        container->bcontainer.bypass_ro = true;
> +    }
> +
>      if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index f498e23a93..c64aa4539e 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -364,7 +364,8 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
>      return true;
>  }
>  
> -static bool vfio_listener_valid_section(MemoryRegionSection *section,
> +static bool vfio_listener_valid_section(VFIOContainerBase *bcontainer,
> +                                        MemoryRegionSection *section,
>                                          const char *name)
>  {
>      if (vfio_listener_skipped_section(section)) {
> @@ -375,6 +376,10 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
>          return false;
>      }
>  
> +    if (bcontainer && bcontainer->bypass_ro && section->readonly) {
> +        return false;
> +    }
> +
>      if (unlikely((section->offset_within_address_space &
>                    ~qemu_real_host_page_mask()) !=
>                   (section->offset_within_region & ~qemu_real_host_page_mask()))) {
> @@ -494,7 +499,7 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>      int ret;
>      Error *err = NULL;
>  
> -    if (!vfio_listener_valid_section(section, "region_add")) {
> +    if (!vfio_listener_valid_section(bcontainer, section, "region_add")) {
>          return;
>      }
>  
> @@ -655,7 +660,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      int ret;
>      bool try_unmap = true;
>  
> -    if (!vfio_listener_valid_section(section, "region_del")) {
> +    if (!vfio_listener_valid_section(bcontainer, section, "region_del")) {
>          return;
>      }
>  
> @@ -812,7 +817,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>          container_of(listener, VFIODirtyRangesListener, listener);
>      hwaddr iova, end;
>  
> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
> +    if (!vfio_listener_valid_section(NULL, section, "tracking_update") ||
>          !vfio_get_section_iova_range(dirty->bcontainer, section,
>                                       &iova, &end, NULL)) {
>          return;
Thanks

Eric


