Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19540CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEQh-00044f-7t; Wed, 27 Aug 2025 07:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEQX-0003xI-7E
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEQP-0003kG-VC
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756294482;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPsqsLvBil4Vg082+BPeuZFrmpGh9X4CRnLTQFfVcvU=;
 b=bPDecAa5K6cd1B05ZRv3+0RjoR3WhiWA25Y2fp65T14zyP9JEY58X+QfxUoRYVPJOMDWyK
 VU06Z6Y9u9Zj8SgFiO5qzMA6nmrHpKqLRzamiIyILUxtrjaK4pYn8bHPJoVmElxis4+Xyf
 I9N1DlVCbH9Om++fRu9cvl7Mgyhv2qY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-9_dhUIYjPDakRvkTJGS2Ag-1; Wed, 27 Aug 2025 07:34:40 -0400
X-MC-Unique: 9_dhUIYjPDakRvkTJGS2Ag-1
X-Mimecast-MFC-AGG-ID: 9_dhUIYjPDakRvkTJGS2Ag_1756294480
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0cfbafso42195125e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 04:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756294478; x=1756899278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JPsqsLvBil4Vg082+BPeuZFrmpGh9X4CRnLTQFfVcvU=;
 b=s6mbt5uxK/xJiqn/Y0PF38v/QKG/VDaK6QBRenuI2IGcgNr80wML10eTUayB/kQO6q
 /LIxdlJvXeyeHMbW/YC7IVdR77pnD/VIjuaqrDjfqMSkKAun2n/zP+E2YGBVcuPsFQTq
 aHYa59j6YO59OPB9m+4lBdfmSV+ecgZb8saYrMITXBfgVNQAI2jsWxxoLVGwW1cdSOcs
 IyY+kO4ad6fWDt3rOtcdfxd4ErXuM191g/fWGXlAHpkOumoj6ZpY+bd2GYEGF4zUJn6/
 GIM2U0Whedg0BrjNaN6Qu+xh+YKVnduZ4bMNxQQwT1lYIQhBf8dukMsKmS7awPiduWc7
 sDIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMM0UVWyR2kLsXbGKBgHjNfYiB/DfqhmP37McdD/miWwArq2P+za2u2JqotTbDpqYiWrjqzJCdec+H@nongnu.org
X-Gm-Message-State: AOJu0Yyim3gL8QDUPI4v3pAd5Q9xabnVx/s0/zVvpJ03njg5aY1yAgH1
 z6Fj5P5PMXD8oE0wgSLCjmdbo/Fdwtbk8A2L3DpeaH3LRugWKgy6O9yUqLP5a7f6S67/wMgBmXt
 BmVGJyI2/2rffW5PvIXsgy8jokHTKs+sVo4PZBDrCmNLgB/qsBepIuWGX0tgsZURKn0c=
X-Gm-Gg: ASbGncvWE5hap/WGmJ9cG1xiXWG9JrYHEpt0W4bFPaNiad/L2JONPNjdJW1v8Zkz8tZ
 c8Fxus7lB87dbkU83+HFgQPZ7SWNNIiOiQPz9RHivkud+veat48wgLfV5u2St9z6zS4qoTk4Juc
 M0RlDC1rg+vz8//Pkm1hy+/lkv1eC5JJQgBD/Bp5tQtJKqwrp8e+BBSxvx2DAVn0Gi+ETaQkzwP
 uILVilmCDb5238YvGRKEw+uuvTzKsQu85q8VhplPuZfnwS2xOhkM59vmsW9jj8TvstKo4cVclQx
 dzb1flweI4jHW/MW1Y225TPjHWDHTjXFJo4Tgq+bOHXBFcEdoo4rAE3kzlhJZPKortNEA85LXwZ
 hMPXy1Ve7IAg=
X-Received: by 2002:a05:600c:4f91:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-45b517c5de5mr149857595e9.19.1756294478601; 
 Wed, 27 Aug 2025 04:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyhzIj9+GAyVnhyN3jMFmHq3WL/70LeZq/AbzZ2gjjeyBdNQaJrDS0g+tflNiPAbqAM7GRgg==
X-Received: by 2002:a05:600c:4f91:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-45b517c5de5mr149857265e9.19.1756294478089; 
 Wed, 27 Aug 2025 04:34:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f2eab0csm26905715e9.20.2025.08.27.04.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 04:34:36 -0700 (PDT)
Message-ID: <809029fc-c9d8-459c-8477-f7931d11623c@redhat.com>
Date: Wed, 27 Aug 2025 13:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-5-zhenzhong.duan@intel.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250801023533.1458644-1-zhenzhong.duan@intel.com
> [ clg: Added documentation ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/pci.h       | 12 ++++++++++++
>  hw/vfio/container.c |  4 ++--
>  hw/vfio/device.c    |  2 +-
>  hw/vfio/iommufd.c   |  4 ++--
>  hw/vfio/listener.c  |  4 ++--
>  hw/vfio/pci.c       |  9 +++++++++
>  6 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 810a842f4a..beb8fb9ee7 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -221,6 +221,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
>  uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>  void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
>  
> +/**
> + * vfio_pci_from_vfio_device: Transform from VFIODevice to
> + * VFIOPCIDevice
> + *
> + * This function checks if the given @vbasedev is a VFIO PCI device.
> + * If it is, it returns the containing VFIOPCIDevice.
> + *
> + * @vbasedev: The VFIODevice to transform
> + *
> + * Return: The VFIOPCIDevice on success, NULL on failure.
> + */
> +VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev);
>  void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
>  bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
>  bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3e13feaa74..134ddccc52 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1087,7 +1087,7 @@ static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
>          /* Prep dependent devices for reset and clear our marker. */
>          QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>              if (!vbasedev_iter->dev->realized ||
> -                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
> +                !vfio_pci_from_vfio_device(vbasedev_iter)) {
>                  continue;
>              }
>              tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
> @@ -1172,7 +1172,7 @@ out:
>  
>          QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>              if (!vbasedev_iter->dev->realized ||
> -                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
> +                !vfio_pci_from_vfio_device(vbasedev_iter)) {
>                  continue;
>              }
>              tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 52a1996dc4..08f12ac31f 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -129,7 +129,7 @@ static inline const char *action_to_str(int action)
>  
>  static const char *index_to_str(VFIODevice *vbasedev, int index)
>  {
> -    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +    if (!vfio_pci_from_vfio_device(vbasedev)) {
>          return NULL;
>      }
>  
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48c590b6a9..8c27222f75 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -737,8 +737,8 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
>      }
>  
>      vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
> -    if (!vbasedev_tmp || !vbasedev_tmp->dev->realized ||
> -        vbasedev_tmp->type != VFIO_DEVICE_TYPE_PCI) {
> +    if (!vfio_pci_from_vfio_device(vbasedev_tmp) ||
> +        !vbasedev_tmp->dev->realized) {
>          return NULL;
>      }
>  
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index f498e23a93..903dfd8bf2 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -450,7 +450,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
>       * MMIO region mapping failures are not fatal but in this case PCI
>       * peer-to-peer transactions are broken.
>       */
> -    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +    if (vfio_pci_from_vfio_device(vbasedev)) {
>          error_append_hint(errp, "%s: PCI peer-to-peer transactions "
>                            "on BARs are not supported.\n", vbasedev->name);
>      }
> @@ -751,7 +751,7 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>      owner = memory_region_owner(section->mr);
>  
>      QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +        if (!vfio_pci_from_vfio_device(vbasedev)) {
>              continue;
>          }
>          pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 07257d0fa0..3fe5b03eb1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2833,6 +2833,15 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>      return ret;
>  }
>  
> +/* Transform from VFIODevice to VFIOPCIDevice. Return NULL if fails. */
> +VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev)
> +{
> +    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        return container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    }
> +    return NULL;
> +}
> +
>  void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
>  {
>      PCIDevice *pdev = &vdev->pdev;


