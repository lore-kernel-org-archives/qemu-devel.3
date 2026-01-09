Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4442D26D77
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFvc-0005wp-Rb; Fri, 09 Jan 2026 12:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veFvY-0005vW-AJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veFvU-0003PM-HD
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767978326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UJnHNRlzjoXSJnvBIJEf1dtyGessMC3YA2MYiA5d2yM=;
 b=cz1uOJe/dcXOX3rDiCgubv/NJetUUZXDv78Sf3OizkfgD2rGO59Z3WLw+lxbKcmOvPY6mH
 2B9VEWHBjFNpEIsD6VwZvlCj4GYQ5kwfq9v7jxK0dDMq+rxaIqF7CiqOB0rYmjV87S+Vxm
 x/KCWkuipiMANcwUDv2wz2ZJJlHL1Do=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-NBVDviW4ObCtM-zZHHotvA-1; Fri, 09 Jan 2026 12:05:25 -0500
X-MC-Unique: NBVDviW4ObCtM-zZHHotvA-1
X-Mimecast-MFC-AGG-ID: NBVDviW4ObCtM-zZHHotvA_1767978324
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so44542215e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767978324; x=1768583124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UJnHNRlzjoXSJnvBIJEf1dtyGessMC3YA2MYiA5d2yM=;
 b=lIzpXddnsMDzO2Rnt1Z6iT0weW1ag54Y68hFjhRNTijrg2OrQB1DQlgsxnCk2W6/P8
 asd+3wRB2fG1ccMaVsSjQ0soluLCudsDv7ZFweLfgUDFWjeWLjplTcodVF7yWhzUJx/G
 LWHVfwMm/vbMKLym68y18z2Kit/jn3me5qxvoFE3ELfKDyiPFge8FYTN15mC81gCcnTm
 901KOkZeJkLjN4PHFkfYc4SJ0LFoGbG0uZZcYv278swcG8PrPBcdzJa76GaEopx09HsR
 nsmkDTCFlyilWhCmFNrCZTHOudWp3Oua0FyT9c/kRfegfzdkNhQ+7I1vDfQ8TuPJJucp
 BfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767978324; x=1768583124;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJnHNRlzjoXSJnvBIJEf1dtyGessMC3YA2MYiA5d2yM=;
 b=JhbVslkb3d/qR84pAqXfoM+M38A8mzTdabBHVV4Rez2RLmtekSHy6cXgp8ij3NHbfE
 jZTtvKMXaxkZcWT9YO4oFpd+HGRz2GvEPfeJvSia4Y8SguvE5PqY+bP3jSQJyvugqDmj
 jaqOQ1rbr4pq0dPEBDHh3Vdt9gaZf4Gkr9LIQwOHdDXkvQNY9cpVoT/6pDBj9ipONSKQ
 rjLd4WRUwJ0twZ5TGWT9Edr4Q2UtDDXBeqqgqnZ7dLpPY6NW1Au2W1AEXyMnGmTET58E
 MhoYT9jy909/jWEBOQWz6u8jIpoYhkuCt7shL7dVU3JJFP+T50yeL0cUCblLhfv1TEZT
 8YcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXweCR9JFtdHdJN8+tAQoxeCITrnJL3zhmND+UUBeEuxHr4sLaaUZLQyXokIkYY/Ra/Zokq+Zz4cVAu@nongnu.org
X-Gm-Message-State: AOJu0YyftTDqNwXFQVugaAK9XQ/IjtdZ5whzCO1U/d6dMsaFTh5XQzhB
 AIMPk3V6Wr9zv0DXLVmhaAKGi31i4DbXPsaEtSwnL36NtOKmpG8E93A6SHhvgZ2aHuCyx03NRwO
 lq61MYAIQistOq8E2wI+OjUC017nFxAhoJLcC3vqcLQCGBfxQpOH71Wr/RKMCH8R/
X-Gm-Gg: AY/fxX4+3PNUOmJ+RNCEYgm1EkWcLthbwCVL1DW5z8oJuDiZytrmpn8eBNEo/bQRFE0
 a7VSwCVmrnjlxfN4UfoJ52uRSozb7K81aLiCPfJ7PMsNBHl1/hWTC0U90JxpiRQ5uNiFMUUjoVM
 hOaTFeyqaEavWGPSEJ5JxtH8qx6vOw0QLZN/70b4N5XVH0PIkDRJcuAnwL+6knN/4H8pOo4zRpD
 C0xVFEg9OPMQz+guV01Jv4ck55FxTKQNOKTcYJFeL4gOufADvJ7ceZaTGNX4fQj7CBxb6Dzddnk
 qhNE2wattTftu9bn1rnshR/dKE2ZhqkD9wEQWtBwKLYJfhFneWjLAbBScDuT86DkZ/6d1EfNFe3
 8EOZz/03YAvZN1Q8RnOgtAjM9xQvGBnmWgtD94WZXhizvjxbJ
X-Received: by 2002:a05:600c:190e:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47d84b3f21fmr123010065e9.35.1767978323615; 
 Fri, 09 Jan 2026 09:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUJmEzhZrofmKrGVVurwf2jTtwPJEM4qHiTME7Y1D5b1s6RmMM5p3lb1dOc+DGVcnRtLK5kw==
X-Received: by 2002:a05:600c:190e:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47d84b3f21fmr123009655e9.35.1767978323167; 
 Fri, 09 Jan 2026 09:05:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm229701005e9.1.2026.01.09.09.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 09:05:20 -0800 (PST)
Message-ID: <d40cc8da-4003-4a40-b0de-32c79cbe6faa@redhat.com>
Date: Fri, 9 Jan 2026 18:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/8/26 12:04, Shameer Kolothum wrote:
> 
> 
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: 08 January 2026 09:41
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; alex@shazbot.org; clg@redhat.com;
>> cohuck@redhat.com; mst@redhat.com; Nicolin Chen <nicolinc@nvidia.com>;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> Jason Gunthorpe <jgg@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per
>> region
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 12/22/2025 9:53 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for
>>> P2P use cases. Create a dmabuf for each mapped BAR region after the
>>> mmap is set up, and store the returned fd in the region’s RAMBlock.
>>> This allows QEMU to pass the fd to dma_map_file(), enabling iommufd to
>>> import the dmabuf and map the BAR correctly in the host IOMMU page
>> table.
>>>
>>> If the kernel lacks support or dmabuf setup fails, QEMU skips the
>>> setup and continues with normal mmap handling.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>    hw/vfio/region.c     | 57
>> +++++++++++++++++++++++++++++++++++++++++++-
>>>    hw/vfio/trace-events |  1 +
>>>    2 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/region.c b/hw/vfio/region.c index
>>> b165ab0b93..6949f6779c 100644
>>> --- a/hw/vfio/region.c
>>> +++ b/hw/vfio/region.c
>>> @@ -29,6 +29,7 @@
>>>    #include "qemu/error-report.h"
>>>    #include "qemu/units.h"
>>>    #include "monitor/monitor.h"
>>> +#include "system/ramblock.h"
>>>    #include "vfio-helpers.h"
>>>
>>>    /*
>>> @@ -238,13 +239,52 @@ static void vfio_subregion_unmap(VFIORegion
>> *region, int index)
>>>        region->mmaps[index].mmap = NULL;
>>>    }
>>>
>>> +static int vfio_region_create_dma_buf(VFIORegion *region) {
>>> +    g_autofree struct vfio_device_feature *feature = NULL;
>>> +    VFIODevice *vbasedev = region->vbasedev;
>>> +    struct vfio_device_feature_dma_buf *dma_buf;
>>> +    size_t total_size;
>>> +    int i, ret;
>>> +
>>> +    g_assert(region->nr_mmaps);
>>> +
>>> +    total_size = sizeof(*feature) + sizeof(*dma_buf) +
>>> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
>>> +    feature = g_malloc0(total_size);
>>> +    *feature = (struct vfio_device_feature) {
>>> +        .argsz = total_size,
>>> +        .flags = VFIO_DEVICE_FEATURE_GET |
>> VFIO_DEVICE_FEATURE_DMA_BUF,
>>> +    };
>>> +
>>> +    dma_buf = (void *)feature->data;
>>> +    *dma_buf = (struct vfio_device_feature_dma_buf) {
>>> +        .region_index = region->nr,
>>> +        .open_flags = O_RDWR,
>>> +        .nr_ranges = region->nr_mmaps,
>>> +    };
>>> +
>>> +    for (i = 0; i < region->nr_mmaps; i++) {
>>> +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
>>> +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
>>> +    }
>>> +
>>> +    ret = vbasedev->io_ops->device_feature(vbasedev, feature);
>>
>> vbasedev->io_ops->device_feature may be NULL for other backend like vfio-
>> user.
> 
> Ah..Ok. I will add a check.

Could you please add a global routine :

   int vfio_device_get_feature(VFIODevice *vbasedev, struct vfio_device_feature *feature)



> 
>>
>>> +    for (i = 0; i < region->nr_mmaps; i++) {
>>> +        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
>>> +                                 region->mem->name, region->mmaps[i].offset,
>>> +                                 region->mmaps[i].size);
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>>    int vfio_region_mmap(VFIORegion *region)
>>>    {
>>>        int i, ret, prot = 0;
>>>        char *name;
>>>        int fd;
>>>
>>> -    if (!region->mem) {
>>> +    if (!region->mem || !region->nr_mmaps) {
>>
>> Just curious, when will above check return true?
> I think `!region->mem` covers cases where no MemoryRegion was created
> (e.g. zero sized regions).  And nr_mmaps checks regions with mmap
> support exists (VFIO_REGION_INFO_FLAG_MMAP/ _CAP_SPARSE_MMAP).
> 
>>
>>>            return 0;
>>>        }
>>>
>>> @@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
>>>                                   region->mmaps[i].size - 1);
>>>        }
>>>
>>> +    ret = vfio_region_create_dma_buf(region);
>>> +    if (ret < 0) {
>>> +        if (ret == -ENOTTY) {
>>> +            warn_report_once("VFIO dmabuf not supported in kernel");
>>> +        } else {
>>> +            error_report("%s: failed to create dmabuf: %s",
>>> +                         memory_region_name(region->mem), strerror(errno));

Shouldn't we return 'ret' in this case ?

Thanks,

C.

>>> +        }
>>> +    } else {
>>> +        MemoryRegion *mr = &region->mmaps[0].mem;
>>
>> Do we need to support region->mmaps[1]?
> 
> My understanding is all region->mmaps[] entries for a VFIO region share
> the same RAMBlock. And the kernel returns a single dmabuf fd per region,
> not per subrange.
> 
> Thanks,
> Shameer
>>
>> Thanks
>>
>> Zhenzhong
>>
>>> +        RAMBlock *ram_block = mr->ram_block;
>>> +
>>> +        ram_block->fd = ret;
>>> +    }
>>> +
>>>        return 0;
>>>
>>>    no_mmap:
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events index
>>> 1e895448cd..592a0349d4 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -117,6 +117,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
>>>    vfio_region_write(const char *name, int index, uint64_t addr, uint64_t
>> data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>>>    vfio_region_read(char *name, int index, uint64_t addr, unsigned size,
>> uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
>>>    vfio_region_setup(const char *dev, int index, const char *name, unsigned
>> long flags, unsigned long offset, unsigned long size) "Device %s, region %d
>> \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
>>> +vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name,
>> unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d
>> \"%s\", offset: 0x%lx, size: 0x%lx"
>>>    vfio_region_mmap_fault(const char *name, int index, unsigned long offset,
>> unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault:
>> %d"
>>>    vfio_region_mmap(const char *name, unsigned long offset, unsigned long
>> end) "Region %s [0x%lx - 0x%lx]"
>>>    vfio_region_exit(const char *name, int index) "Device %s, region %d"


