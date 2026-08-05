Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAADC55838
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrQ8p-0006C1-A8; Tue, 04 Aug 2026 21:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wrQ8o-0006Bn-Fi
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 21:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wrQ8m-0006EW-99
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 21:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785892190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O95sk965+33X4jt+p73c1wfEipoWMgHhGCzJ1w256i0=;
 b=cgWH+JW7jSuLWB5ewWqwcuHtFnWtQADG17rgTeiXPbcfuVx7jgwRKcLS7Sg8Qw8kegSqMh
 iErZuxPEI6TuZPadmZSzeacAruyoARF8v72PGGeaEXj7J7ehxch92phULBHHbnJDB8g+YZ
 ym7oAL4E0xrtvDBPF5/MYaJvMyrxMyU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-8WSLicy6NA6_rXOZdPk8yQ-1; Tue, 04 Aug 2026 21:09:48 -0400
X-MC-Unique: 8WSLicy6NA6_rXOZdPk8yQ-1
X-Mimecast-MFC-AGG-ID: 8WSLicy6NA6_rXOZdPk8yQ_1785892188
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso7538165ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 18:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785892187; x=1786496987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O95sk965+33X4jt+p73c1wfEipoWMgHhGCzJ1w256i0=;
 b=IiapD2nO22xoutRKL+HXhYfyf2IKEM3EE3h9CRQrsaE0/I7mVxT0cjuuE94pmDmLEE
 cojN9lh9625jJVcfodST8iBlaVgDMFIyu+ulR+h982A7OOlUcfwEOAOJXTRjVZE+rR5n
 aEq/4SlTwPXOSHjH3YwkFt6uOU6fwJ/OdQiCZs+nMoFRIb37vLYBXtZ59HruPisXnPqi
 ul80PW+kQulHX+HxToTYuC53wn/AoLWzN3GKsParAZeT+j8UGtbgmyXFXNd7gum4K6M9
 XDW2tz48NnIxCheLxJaz7sZ2QPHeEpofQzzyYYsw7dSpo9DPQ2EsUxnYfNo+Phcj7dpZ
 oUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785892187; x=1786496987;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O95sk965+33X4jt+p73c1wfEipoWMgHhGCzJ1w256i0=;
 b=Vojk/1861KZsRmkX2L4AH0f6Rq/PDfl60kVKxTlvGVCp+KlOAoWoH5/cl6N+MR01Ii
 /obr+RVkXqjnH2AwZSXP6/0r2DSKl+MLJRKTC7nv38fPd19YiFWmpo/Mx1bnzCn59B07
 IxDKm19Q56zMXcBHRtP3/Fy7sXT6BYSiGXyjZJGMPIN17Yiwral8nMHrt8osrBNn21rv
 MXpdgSKx+K+czubjkPansqWRZIcSJ4sgnz+TauptlmCHZm67eJnaf8QP5w7Na5BB66jC
 5mQo3tGlzszVzLA3fu6xvVPsNOMu//DOQ3xo4ub+xuCboEOfMCPPOfhtHIYhw3QGps6A
 kQaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4QtPHYYh7Nl7QTKhjlyLFwzLuKXrsoCzyuz0T4unV6rL2DAfbhuTDmlcDbZEnYdT3cA4o1vWG3k3Z@nongnu.org
X-Gm-Message-State: AOJu0YztOVv3hut1oSobtxbHZaSE4eRzvzdQK/MHH4WwA+/I3AQXWi3A
 3PwrtXg9wPxy55i0QsaAJPrnTRPFx8nDeEfYe5mL99sp2MyAvyFRzpAYCnp/nDUh8tRh+EsHbFE
 gMjnTpnSDl1FGL+2/A2c9WmwqxsYXOvR2Hba/pnxkP3FioYXflWTAqaNO
X-Gm-Gg: AR+sD13nG7RVhHfxeafgZdPC3dQOmsUyr1usSsNRpH2bg3Qvfu1NnStLp6wjHqnkfHG
 Py/8X4FQaZi71CFhZSBmwvk1e6uN7y6x7uIl4weMt3QD6i7ULBDuzTcsw4QwcuJUuAd6YmyWx1X
 OSknq4Ie7TGGBo1LeIQSMpqV52MpS3vTpevHE+OopXcWXOU3lVZtXxpDOl/z9EItS4n3Ca5R4M+
 1EtqWz9pPufaZ7SpZio9zq2vPLbRvKIIXQrCqNYqeC2yd9yQ4T8OQyq7IeKSuNw5YKVh7x3+HQN
 cp77QkR8/P5i8Mu3U7TjzkEDO9gondY/zmg3TM01yWUUqNEh5bhowt72eDHFdcUtaJyFQld5Oh9
 izcoXW/2BKDHDbsf9Mf/cSs9N9OaTi7+9Mloe0cpRdyI=
X-Received: by 2002:a17:90b:3f47:b0:381:5a08:6291 with SMTP id
 98e67ed59e1d1-3903c68fcdemr2831182a91.20.1785892187364; 
 Tue, 04 Aug 2026 18:09:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3f47:b0:381:5a08:6291 with SMTP id
 98e67ed59e1d1-3903c68fcdemr2831118a91.20.1785892186781; 
 Tue, 04 Aug 2026 18:09:46 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fee066b9fsm2517918a91.17.2026.08.04.18.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 18:09:45 -0700 (PDT)
Message-ID: <aa45597c-aed8-49a0-b9bd-3c637c154ee5@redhat.com>
Date: Wed, 5 Aug 2026 11:09:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/vfio/region: Create dmabuf for PCI BAR per
 region
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, clg@redhat.com,
 cohuck@redhat.com, mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhenzhong.duan@intel.com, vivek.kasireddy@intel.com, kjaju@nvidia.com,
 meshetty@redhat.com
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
 <20260121114111.34045-4-skolothumtho@nvidia.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260121114111.34045-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin and Shameer,

On 1/21/26 9:41 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. Create a dmabuf for each mapped BAR region after the mmap is set
> up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
> the BAR correctly in the host IOMMU page table.
> 
> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
> and continues with normal mmap handling.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/vfio/region.c     | 65 +++++++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/trace-events |  1 +
>   2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index ca75ab1be4..ab39d77574 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -29,6 +29,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/units.h"
>   #include "monitor/monitor.h"
> +#include "system/ramblock.h"
>   #include "vfio-helpers.h"
>   
>   /*
> @@ -238,13 +239,71 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
>       region->mmaps[index].mmap = NULL;
>   }
>   
> +static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
> +{
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +    VFIODevice *vbasedev = region->vbasedev;
> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    size_t total_size;
> +    int i, ret;
> +
> +    total_size = sizeof(*feature) + sizeof(*dma_buf) +
> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
> +    feature = g_malloc0(total_size);
> +    *feature = (struct vfio_device_feature) {
> +        .argsz = total_size,
> +        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
> +    };
> +
> +    dma_buf = (void *)feature->data;
> +    *dma_buf = (struct vfio_device_feature_dma_buf) {
> +        .region_index = region->nr,
> +        .open_flags = O_RDWR,
> +        .nr_ranges = region->nr_mmaps,
> +    };
> +
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
> +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
> +    }
> +

Shall we check if @offset and @size is aligned to PAGE_SIZE? If they're not,
I guess we need to skip populating DMA buffer instead of preventing the
device from being passed through to the guest.

Meghana <meshetty@redhat.com> runs into issue when passing through an NVMe
card. The only memory BAR on the NVMe card is 16K, which is not aligned to
64KB (host page size).

   -device vfio-pci,id=nvme,host=0004:01:00.0,addr=0x2.0x1,bus=pcie.0

   host$ sh vfio.sh
   QEMU 10.1.0 monitor - type 'help' for more information
   (qemu) qemu-kvm: -device vfio-pci,id=nvme,host=0004:01:00.0,addr=0x2.0x1,bus=pcie.0: \
                    0004:01:00.0 BAR 0: failed to create dma-buf: PCI BAR IOMMU  mappings may fail: Invalid argument

   host$ lspci -vvvs 0004:01:00.0 | grep Region.*Memory
   Region 0: Memory at 620040010000 (64-bit, non-prefetchable) [size=16K]

   host kernel
   ===========
   vfio_device_fops_unl_ioctl
     vfio_ioctl_device_feature
       vfio_pci_core_ioctl_feature
         vfio_pci_core_feature_dma_buf
           validate_dmabuf_input          // Return -EINVAL for !PAGE_ALIGNED(len)


> +    ret = vfio_device_get_feature(vbasedev, feature);
> +    if (ret < 0) {
> +        if (ret == -ENOTTY) {
> +            warn_report_once("VFIO dma-buf not supported in kernel: "
> +                             "PCI BAR IOMMU mappings may fail");
> +            return true;
> +        }
> +        /* P2P DMA or exposing device memory use cases are not supported. */
> +        error_setg_errno(errp, -ret, "%s: failed to create dma-buf: "
> +                         "PCI BAR IOMMU mappings may fail",
> +                         memory_region_name(region->mem));
> +        return false;
> +    }
> +
> +    /* Assign the dmabuf fd to associated RAMBlock */
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        MemoryRegion *mr = &region->mmaps[i].mem;
> +        RAMBlock *ram_block = mr->ram_block;
> +
> +        ram_block->fd = ret;
> +        ram_block->fd_offset = region->mmaps[i].offset;
> +        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
> +                                 memory_region_name(region->mem),
> +                                 region->mmaps[i].offset,
> +                                 region->mmaps[i].size);
> +    }
> +    return true;
> +}
> +
>   int vfio_region_mmap(VFIORegion *region)
>   {
>       int i, ret, prot = 0;
> +    Error *local_err = NULL;
>       char *name;
>       int fd;
>   
> -    if (!region->mem) {
> +    if (!region->mem || !region->nr_mmaps) {
>           return 0;
>       }
>   
> @@ -305,6 +364,10 @@ int vfio_region_mmap(VFIORegion *region)
>                                  region->mmaps[i].size - 1);
>       }
>   
> +    if (!vfio_region_create_dma_buf(region, &local_err)) {
> +        error_report_err(local_err);
> +    }
> +
>       return 0;
>   
>   no_mmap:
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 180e3d526b..466695507b 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -118,6 +118,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
>   vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>   vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
>   vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
> +vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
>   vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
>   vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
>   vfio_region_exit(const char *name, int index) "Device %s, region %d"

Thanks,
Gavin


