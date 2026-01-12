Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D477CF45C5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMjG-0004QL-H6; Mon, 12 Jan 2026 13:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfMhe-0003fM-Qj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfMhc-0003vh-Pg
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768242702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KIf4utul7OBEPrpbSYrYMxo2rKquWIJTt0+kwliNsZU=;
 b=heLwhV3f/ZFjd5Y8wO/vakunp/gskTNLkW5zNNiKHyrkq99dR/cLpA+/qSR0DSNix5TFRF
 tGZ35DztdOH+vb8VMF/dhLwZVRrrKKmoQZuz6tl0xfjqQ1lKkOm/uU8WRfaEQ3iUfuqXd5
 K5qHiyaM3g6IRWw7pTTMLHiYVMRPrHA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-BEvp9hpEPnKqwjJAdnwgdA-1; Mon, 12 Jan 2026 13:31:41 -0500
X-MC-Unique: BEvp9hpEPnKqwjJAdnwgdA-1
X-Mimecast-MFC-AGG-ID: BEvp9hpEPnKqwjJAdnwgdA_1768242700
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso45330355e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768242700; x=1768847500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KIf4utul7OBEPrpbSYrYMxo2rKquWIJTt0+kwliNsZU=;
 b=YXzPBnOKllLd8IqA6TjdjUF9oYVqcIr9G3D+A5cuNkXpsC37cyT8O1x7RmhMW5sokz
 7STbHHdTLhbJXdhSvf26+lw6nPgpfVHL5UnBx3ExvAl7WBFHjQG8PqfjhP04LwrsKGry
 mbvh8x9HoS0Cx9EgaKULn5VA4RYiQD3eIZg1A7TZYbxv/i+0+8RVlnVBymB6B7scC6Qm
 sprvi5nb4u5shJ4KKYJNJ246KGCVIoykcxI78D1E0HbXzxmyHnYheDYr4KyIDVJscR2o
 E+dV6D5XEHTkpF/40grbhUMEs8pUeiDFsedYoLkC0nKe1IhazIajMF2rnYQ1OWsDQQYz
 aXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768242700; x=1768847500;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIf4utul7OBEPrpbSYrYMxo2rKquWIJTt0+kwliNsZU=;
 b=dTbYJ9xuoK5+KLd153NQmvz/ooqv2CnDG/O8mPi3ZwOA7/SaKqcZClo2pIaj6Uds0Y
 IOUkRWZxkut2vZ7jqgoj0a1VS8YB4arwzZBM1lk2tECqnLhJxS8D+7LoQxAsTPGLcqlQ
 shQ7ixv6EXz/8P0I9BIkJ4eKVPxlX1OaeGl26Ib3PnoVLOICLQYCWtGU+6+opjB4b37v
 emgd8IhzdRyeZ0Yb1YfQ2OrfosOmKaaSMpZNiIYEMaPYE/m4RF7D6+7lQCi380tNTL/D
 dcsj0O9kb8eK8tq0odEd6GZDSfBdLc8l6sSxInbpc+FVeBDqo/iCAQQApee5VvSlsJuL
 e2gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX10G0IdkoTMzdiyBBbknH3X5jXbJ9rgpGTQPcVGYnZnLaxiZeuJ88+kl+dHSldd2cOiB8qGTZFySA@nongnu.org
X-Gm-Message-State: AOJu0YxS5TE6tkvce509I4WqhxJSsfX4z/M1va4qe6DrIX7lJxNS/wYF
 5peUT/m3+RKHsz2ouMO9CtUv/6msUHYNgxn+7IL1U7KCwGufqqm+YJO7sqtxwGy/tePEvcQbrIO
 LY8jo1w1valqGRE2qI1Yr8rR6EKs0wwmT7ff11nAznii1mVHsDYf6682B
X-Gm-Gg: AY/fxX6w3cqHkJEpKNTmtKmZUGRdXKCv3ESxkWowmRreULlOEVDxy/uHHV64nH2xj11
 U6I3J5Aut7Qeje5ICUuV7bLrIG9TBAgYNufzrzzBj7n6AtQKme0GWrbHM6d2iCNAsurJvayEGxH
 AjelTx2BIZb96TB/mA6LQQkK78YujyON/kp4IWx38hVsoB0DOMGQJIudSepxo5Z6X+oM5RHQn7s
 JRgkVUzvHf8y1EvIbPlrBb0pJdiOhxXQX17jpPeQJ4TeUkF6DXvMzbsgy5qhH8Qmcc/PWqdhOoc
 GJFEjAN9u/a81PJ7F9ufDiZ8LUuTXXZDgYjmJJEb9fzk4DM44G8ET/ObSX9pqESPOk76IVuFUB6
 LS7QwIOYMn7vF2QK7woXEpti0jTOPNbCLBOlnaoLe9pQVLAn4
X-Received: by 2002:a05:6000:24c6:b0:430:f182:788f with SMTP id
 ffacd0b85a97d-432c377c603mr20498889f8f.21.1768242700064; 
 Mon, 12 Jan 2026 10:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8rL0RzWTfKHdZV5HtqDuUQqoOixrSvnhnAFqA8/rX0e4WUowk/Icfp0ZV4KXiBrnXEsNn7Q==
X-Received: by 2002:a05:6000:24c6:b0:430:f182:788f with SMTP id
 ffacd0b85a97d-432c377c603mr20498853f8f.21.1768242699550; 
 Mon, 12 Jan 2026 10:31:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm41337542f8f.13.2026.01.12.10.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 10:31:38 -0800 (PST)
Message-ID: <cdc371ba-d347-44f9-ab38-1f60f8f88ad6@redhat.com>
Date: Mon, 12 Jan 2026 19:31:37 +0100
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
 <d40cc8da-4003-4a40-b0de-32c79cbe6faa@redhat.com>
 <CH3PR12MB75482D2914436617438F2522AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR12MB75482D2914436617438F2522AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/12/26 17:16, Shameer Kolothum wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: 09 January 2026 17:05
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; Duan, Zhenzhong
>> <zhenzhong.duan@intel.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org
>> Cc: eric.auger@redhat.com; alex@shazbot.org; cohuck@redhat.com;
>> mst@redhat.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per
>> region
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 1/8/26 12:04, Shameer Kolothum wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>> Sent: 08 January 2026 09:41
>>>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org;
>>>> qemu-devel@nongnu.org
>>>> Cc: eric.auger@redhat.com; alex@shazbot.org; clg@redhat.com;
>>>> cohuck@redhat.com; mst@redhat.com; Nicolin Chen
>>>> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>>>> <mochs@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Krishnakant
>>>> Jaju <kjaju@nvidia.com>
>>>> Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR
>>>> per region
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 12/22/2025 9:53 PM, Shameer Kolothum wrote:
>>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>>
>>>>> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory
>>>>> for P2P use cases. Create a dmabuf for each mapped BAR region after
>>>>> the mmap is set up, and store the returned fd in the region’s RAMBlock.
>>>>> This allows QEMU to pass the fd to dma_map_file(), enabling iommufd
>>>>> to import the dmabuf and map the BAR correctly in the host IOMMU
>>>>> page
>>>> table.
>>>>>
>>>>> If the kernel lacks support or dmabuf setup fails, QEMU skips the
>>>>> setup and continues with normal mmap handling.
>>>>>
>>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>>>> ---
>>>>>     hw/vfio/region.c     | 57
>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>>     hw/vfio/trace-events |  1 +
>>>>>     2 files changed, 57 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/vfio/region.c b/hw/vfio/region.c index
>>>>> b165ab0b93..6949f6779c 100644
>>>>> --- a/hw/vfio/region.c
>>>>> +++ b/hw/vfio/region.c
>>>>> @@ -29,6 +29,7 @@
>>>>>     #include "qemu/error-report.h"
>>>>>     #include "qemu/units.h"
>>>>>     #include "monitor/monitor.h"
>>>>> +#include "system/ramblock.h"
>>>>>     #include "vfio-helpers.h"
>>>>>
>>>>>     /*
>>>>> @@ -238,13 +239,52 @@ static void vfio_subregion_unmap(VFIORegion
>>>> *region, int index)
>>>>>         region->mmaps[index].mmap = NULL;
>>>>>     }
>>>>>
>>>>> +static int vfio_region_create_dma_buf(VFIORegion *region) {
>>>>> +    g_autofree struct vfio_device_feature *feature = NULL;
>>>>> +    VFIODevice *vbasedev = region->vbasedev;
>>>>> +    struct vfio_device_feature_dma_buf *dma_buf;
>>>>> +    size_t total_size;
>>>>> +    int i, ret;
>>>>> +
>>>>> +    g_assert(region->nr_mmaps);
>>>>> +
>>>>> +    total_size = sizeof(*feature) + sizeof(*dma_buf) +
>>>>> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
>>>>> +    feature = g_malloc0(total_size);
>>>>> +    *feature = (struct vfio_device_feature) {
>>>>> +        .argsz = total_size,
>>>>> +        .flags = VFIO_DEVICE_FEATURE_GET |
>>>> VFIO_DEVICE_FEATURE_DMA_BUF,
>>>>> +    };
>>>>> +
>>>>> +    dma_buf = (void *)feature->data;
>>>>> +    *dma_buf = (struct vfio_device_feature_dma_buf) {
>>>>> +        .region_index = region->nr,
>>>>> +        .open_flags = O_RDWR,
>>>>> +        .nr_ranges = region->nr_mmaps,
>>>>> +    };
>>>>> +
>>>>> +    for (i = 0; i < region->nr_mmaps; i++) {
>>>>> +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
>>>>> +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
>>>>> +    }
>>>>> +
>>>>> +    ret = vbasedev->io_ops->device_feature(vbasedev, feature);
>>>>
>>>> vbasedev->io_ops->device_feature may be NULL for other backend like
>>>> vbasedev->vfio-
>>>> user.
>>>
>>> Ah..Ok. I will add a check.
>>
>> Could you please add a global routine :
>>
>>     int vfio_device_get_feature(VFIODevice *vbasedev, struct
>> vfio_device_feature *feature)
> 
> Ok.
> 
>>
>>
>>>
>>>>
>>>>> +    for (i = 0; i < region->nr_mmaps; i++) {
>>>>> +        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
>>>>> +                                 region->mem->name, region->mmaps[i].offset,
>>>>> +                                 region->mmaps[i].size);
>>>>> +    }
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>     int vfio_region_mmap(VFIORegion *region)
>>>>>     {
>>>>>         int i, ret, prot = 0;
>>>>>         char *name;
>>>>>         int fd;
>>>>>
>>>>> -    if (!region->mem) {
>>>>> +    if (!region->mem || !region->nr_mmaps) {
>>>>
>>>> Just curious, when will above check return true?
>>> I think `!region->mem` covers cases where no MemoryRegion was created
>>> (e.g. zero sized regions).  And nr_mmaps checks regions with mmap
>>> support exists (VFIO_REGION_INFO_FLAG_MMAP/ _CAP_SPARSE_MMAP).
>>>
>>>>
>>>>>             return 0;
>>>>>         }
>>>>>
>>>>> @@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
>>>>>                                    region->mmaps[i].size - 1);
>>>>>         }
>>>>>
>>>>> +    ret = vfio_region_create_dma_buf(region);
>>>>> +    if (ret < 0) {
>>>>> +        if (ret == -ENOTTY) {
>>>>> +            warn_report_once("VFIO dmabuf not supported in kernel");
>>>>> +        } else {
>>>>> +            error_report("%s: failed to create dmabuf: %s",
>>>>> +                         memory_region_name(region->mem),
>>>>> + strerror(errno));
>>
>> Shouldn't we return 'ret' in this case ?
> 
> That would result in:
> 
> Failed to mmap 0018:06:00.0 BAR 0. Performance may be slow
> 
> Not sure that error msg is correct in this context. 

Agree. It would be a step backwards from the current situation.

> If we don't return 'ret' here
> vfio_container_dma_map() will eventually report the warning:
> 
> qemu-system-aarch64: warning: vfio_container_dma_map(0xaaaaff67ad40, 0x58000000000, 0xb90000, 0xffff64000000) = -14 (Bad address)
> 0018:06:00.0: PCI peer-to-peer transactions on BARs are not supported.
> qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?

Yes that's what we have today.
  
> I think the above is good enough for this. Please let me know.

Given that, with this change, QEMU will now always request a
DMABUF fd, the question is to what extent a failure should
be considered critical.

Would there be reasons to fail to realize the vfio-pci device
and stop the machine ?

Thanks,

C.


