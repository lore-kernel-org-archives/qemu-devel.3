Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF1FC55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrYCW-0001z4-Tb; Wed, 05 Aug 2026 05:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wrYCR-0001yP-KO
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wrYCP-0006I4-Ko
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785923168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rk/l8Cm5Q44JDIR3dcGZTEfXr24/oa8sM2dR7oM0zMc=;
 b=GJQoS1qTro8j/JAYdgvDI0DRVxGSfNBQe9MQs3gh7IXXRgkLuucECWyC/SWHZiAyLad7gF
 qNhMOMNAjsexjSz9LM94EEKmyJp9xPiL9LkdccXRkSW+E23cY63VRQ4Cm8l0p2oiVq0tx3
 JNzNlF0jL61mTeL8wDCsSjFjt4ELarY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-uEuXeBRHOsmUh0dPHhjQMw-1; Wed, 05 Aug 2026 05:46:07 -0400
X-MC-Unique: uEuXeBRHOsmUh0dPHhjQMw-1
X-Mimecast-MFC-AGG-ID: uEuXeBRHOsmUh0dPHhjQMw_1785923166
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb5bdd8450dso535194a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785923166; x=1786527966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rk/l8Cm5Q44JDIR3dcGZTEfXr24/oa8sM2dR7oM0zMc=;
 b=g1j1Z6av0Gw+odctVcIG8qWHRr4VhZya6ZNCZjAVSOzk5Ec/zPuqvfbiNgRWAQxXpP
 tYxjuOEMn2zDC4BPtIf5obco5XiEUo5U90CkBRiA6kLAbXgLsHS4PbhAgkUcbTo8mm5f
 hnfPDf9GzqDhJezw9viZ3bNy+1cfmLmJZVb5KQpyaXIxDHBZEt7ovGn85tKCWCPZL4h4
 e3pJIdq2ke4wm1GjwJujqrdW+MNHTb9eGu73CQwWGGCI428uK2ivQlNSVNZ400F4QS39
 i9kdN3/UjZVipzf/x7TTN1wl6GshVeFgy2Y7lPq3RJorxRxjI4XgP0MeuFwfLAk9bVjW
 Cyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785923166; x=1786527966;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rk/l8Cm5Q44JDIR3dcGZTEfXr24/oa8sM2dR7oM0zMc=;
 b=Zkld1xM8V+/g226uAWmEQgkpG6zJCfdrdDBbl5kFi2xAsxW3c4u310XBj7BuhXFrP0
 C8GCNod28huam+X10hqphFo6mVTdBlzguRCHl0CY/7jumB8OV9iGLYJF+7EzCYXg8CJt
 N/65aCtBa293WaIwrZUwo4WGA+MIbO01ZcLh+X8nlrE1qxoVWe0OVcM0vGYojDPthT0w
 rn382N8Om1apq6vJPWKMqPerTAHP8po0P/si2eUzQESN6BIWC2FLxsArTaCQ9Aq2hOj/
 l+jW7b9Ns2Mhn3CegUCsYkmYnSr6Tx4ONsm/MiHfaFr3EnsupH6GepKpKvzk/xYZUI3L
 f29w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/GcS8a0y9aQHOS5jATvBWvhCksv947EjmHe/KD45YgltBWjJMHHIJTF/J+GqhQl9dkhaqicR+WP+i@nongnu.org
X-Gm-Message-State: AOJu0YyaIupwffg8oJxSubhIMwANVNY50nrXzciy2L7MWwPSuewGVyaC
 ZMGn/ljpPasb9SLxtonfSuBiDYOGX/lsfKcpr2TnWAFTS2nAvKXmljVV5kMcV4w7wxODWJTVS8E
 GhkH0oGN9qhxVihfTImNzcXTDhmYdDrR5h5S0ISqGEn8dNXLgC84T5HSEHRiDYZPF
X-Gm-Gg: AR+sD138jUhdGwheZpzkww69BQUjSljdBdRDmIf3McDTWPeMXagy7aITzvl9s03U/8g
 VmmO4dngt/qXOW1h/wMUbuDFWQQeyzlH5FAAMbVNe1h9z/bGztfurDZB2xmm19UNWK86Dm6YbML
 hD+zBp6rNj8w6IkscIl7TfO0SrTYeQizywQKGpssFfdpAMTig4rXYFefochR8A8BeMMl99oKveY
 /zhAOvhwctC/OGktS9CC4y+VOuFWurw1mZlAGWXr2/SY57o/nrg5tDdvSzqhWLXdSficVCq90CH
 W5RUwreiQ3/puxt+SAjF99WabU/tcSqxb3UfcgN3F5+Irx9SBkjWFCAFc2rQW7jl5kisKMwh3uL
 HjsluKslUxUuwpa3Xy3kJvevjYGq/laBQQVP+tYDS//Q=
X-Received: by 2002:a05:6a21:999d:b0:3bf:63af:85d with SMTP id
 adf61e73a8af0-3cb85e736f8mr6075201637.18.1785923166036; 
 Wed, 05 Aug 2026 02:46:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:999d:b0:3bf:63af:85d with SMTP id
 adf61e73a8af0-3cb85e736f8mr6075135637.18.1785923165536; 
 Wed, 05 Aug 2026 02:46:05 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe7092b9c6sm1203725a12.31.2026.08.05.02.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 02:46:04 -0700 (PDT)
Message-ID: <d96b2e3a-f566-4819-8671-c3c99397a8d9@redhat.com>
Date: Wed, 5 Aug 2026 19:45:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/vfio/region: Create dmabuf for PCI BAR per
 region
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 vivek.kasireddy@intel.com, kjaju@nvidia.com, meshetty@redhat.com
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
 <20260121114111.34045-4-skolothumtho@nvidia.com>
 <aa45597c-aed8-49a0-b9bd-3c637c154ee5@redhat.com>
 <5a71ad53-5c4e-4a06-8d31-59b1329d20bc@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <5a71ad53-5c4e-4a06-8d31-59b1329d20bc@redhat.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/26 6:49 PM, Cédric Le Goater wrote:
> On 8/5/26 03:09, Gavin Shan wrote:
>> Hi Nicolin and Shameer,
>>
>> On 1/21/26 9:41 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
>>> use cases. Create a dmabuf for each mapped BAR region after the mmap is set
>>> up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
>>> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
>>> the BAR correctly in the host IOMMU page table.
>>>
>>> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
>>> and continues with normal mmap handling.
>>>
>>> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>   hw/vfio/region.c     | 65 +++++++++++++++++++++++++++++++++++++++++++-
>>>   hw/vfio/trace-events |  1 +
>>>   2 files changed, 65 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
>>> index ca75ab1be4..ab39d77574 100644
>>> --- a/hw/vfio/region.c
>>> +++ b/hw/vfio/region.c
>>> @@ -29,6 +29,7 @@
>>>   #include "qemu/error-report.h"
>>>   #include "qemu/units.h"
>>>   #include "monitor/monitor.h"
>>> +#include "system/ramblock.h"
>>>   #include "vfio-helpers.h"
>>>   /*
>>> @@ -238,13 +239,71 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
>>>       region->mmaps[index].mmap = NULL;
>>>   }
>>> +static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
>>> +{
>>> +    g_autofree struct vfio_device_feature *feature = NULL;
>>> +    VFIODevice *vbasedev = region->vbasedev;
>>> +    struct vfio_device_feature_dma_buf *dma_buf;
>>> +    size_t total_size;
>>> +    int i, ret;
>>> +
>>> +    total_size = sizeof(*feature) + sizeof(*dma_buf) +
>>> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
>>> +    feature = g_malloc0(total_size);
>>> +    *feature = (struct vfio_device_feature) {
>>> +        .argsz = total_size,
>>> +        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
>>> +    };
>>> +
>>> +    dma_buf = (void *)feature->data;
>>> +    *dma_buf = (struct vfio_device_feature_dma_buf) {
>>> +        .region_index = region->nr,
>>> +        .open_flags = O_RDWR,
>>> +        .nr_ranges = region->nr_mmaps,
>>> +    };
>>> +
>>> +    for (i = 0; i < region->nr_mmaps; i++) {
>>> +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
>>> +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
>>> +    }
>>> +
>>
>> Shall we check if @offset and @size is aligned to PAGE_SIZE? If they're not,
>> I guess we need to skip populating DMA buffer instead of preventing the
>> device from being passed through to the guest.
>>
>> Meghana <meshetty@redhat.com> runs into issue when passing through an NVMe
>> card. The only memory BAR on the NVMe card is 16K, which is not aligned to
>> 64KB (host page size).
>>
>>    -device vfio-pci,id=nvme,host=0004:01:00.0,addr=0x2.0x1,bus=pcie.0
>>
>>    host$ sh vfio.sh
>>    QEMU 10.1.0 monitor - type 'help' for more information
>>    (qemu) qemu-kvm: -device vfio-pci,id=nvme,host=0004:01:00.0,addr=0x2.0x1,bus=pcie.0: \
>>                     0004:01:00.0 BAR 0: failed to create dma-buf: PCI BAR IOMMU  mappings may fail: Invalid argument
> 
> To avoid confusion, the reported error message was slightly
> improved in :
> 
>    https://lore.kernel.org/qemu-devel/20260721170518.4160785-3-clg@redhat.com/
> 

Yeah, the warning message was reported from our downstream QEMU where this
commit (for the improved messages) isn't there yet.

> Thanks,
> 
> C.
> 

Thanks,
Gavin


