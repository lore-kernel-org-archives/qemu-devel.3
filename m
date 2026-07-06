Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F529C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgkzZ-0001jh-Hp; Mon, 06 Jul 2026 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgkzX-0001jL-PY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgkzV-0003r7-PY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783350732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lFM0nb4PGuHgwA80Ouv9gZcmm1gluuVCfxg2B6eTyA8=;
 b=fQlQR1FEgrHIB7kCOpkLt9QG/WBJ10nskQt63fFKA6Y2VCiZatTXolV8StkyQXBb7/PKpV
 qjUGflGSs6uUv75bgC+B8WEQgBnqNKq4mlkoHpjHND8CCZJYwSYK2I9lnIaj96FvbtkmgC
 hvV5us6+8hE+kFtNJ9kfBM7xCth3HnA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-j9YfgjnBNkmboQ19MZkrcg-1; Mon, 06 Jul 2026 11:12:11 -0400
X-MC-Unique: j9YfgjnBNkmboQ19MZkrcg-1
X-Mimecast-MFC-AGG-ID: j9YfgjnBNkmboQ19MZkrcg_1783350730
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bf840a69so23134035e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783350730; x=1783955530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lFM0nb4PGuHgwA80Ouv9gZcmm1gluuVCfxg2B6eTyA8=;
 b=f5xqRk0oMkmYUPvWkGXdaWehyKELB63mvDxdhQ2jGZrBcwtVC87tiWFl0La03I8XJn
 qoZmmWcWtzfEGwvsBZfk7EAW4K9RbBw65n8Rqb67yBdsKAu7URLwvmEJvy5zOJiSfGOZ
 1ko6szGM0pFMy55EJhtvzgohr+oDhDKijPoOIW+5glUBW3RAepMPYx5P7D7VxOIJmLbd
 3/Iu1oy3G1AQ4jxvnvtAn6zvwlMzIA4+TK5me1pmNa+k3V16/iyzuv6UwoZf35Eb9AEi
 Ip+YCqpPK2IUy30h1MO9uwvKqLILlNQsSrsFGRdyO7M0OmJmYiPZ/VcNdDBmcnzn9lAn
 nZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350730; x=1783955530;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFM0nb4PGuHgwA80Ouv9gZcmm1gluuVCfxg2B6eTyA8=;
 b=ldRezOE7lxPRMfVAsbEpZll2LoB+IRarDEW8OPM0By3IX6yeL2TPsn9it5pG3wrOF1
 UOvotC35SOWEHafYeOtZ5B5JdbSyiUn18EDwS2s1lfxbB6UZdewOIkw1mAwaYZhpNsSU
 IuBgNXIfiwd6Oxy2o9EZOpcsbZtBusXIcudP6o0vJgP+2QOWlzoYeb5YVKlVb1By4/IX
 AMRGPbQwGNT6T10B8kkcRMLrsTucpF9HusVAIWYIcT44N6sBGyFsEEy3N7FDWsKeKdzL
 OE134PxPJawT6EsQULDZSYHaCsjm/GjALl5RFQ3qOG1nMEHrPbzHMLhc08Inn51TnPqY
 rj1A==
X-Gm-Message-State: AOJu0YwB0aOGP5vk4yaqLlr7IV75+R8RYJSfmg7+c7v35aPbC2I017JY
 gSQNQicRx9fWKFO4axA1LiswfiTh8lM1Wnhl1831H6e37ZMe0a09WV3ktQlJdTOa4DcEUQIkgkq
 lEUO7HhFAsm17ZK9qgqi4umti3XFQNSSJHCe0J16frltCkAq9GSWwe90s
X-Gm-Gg: AfdE7ck5LehIsg4DZXZDdSSrDF/GcQZ3poKmj+I+YDYhlg4XD7t8CnobW/5NwENewIS
 IwzMsZC8+do4+rCNYYP3Wpih/mFVF3/YOlOfqVlomVOtoFB/Qy1isYtr/XvK3nRR9CHvtqeXOBu
 uCZaYD+oi7vDjw07Bl8gKDkGO3Kx0xw5D9vS3KACo8GazpW/KPSTTzJiQlPyvcf1d5DWTiSSyir
 lpX9VoHQVstkXoKMzv3GERZCCV5EDO9sE7Uc+UIFTF0qP+MmKpF566mLEHFgJTnf3w+hV6AfjPr
 otddwCsx43K0pyggHUHVADNdyE5kbWvscqrEo1Sw3FRxiJPbl4f78M1qfwSGD7sRe0VawvPpN9k
 +A8Syx7fS9ndUz/0DRsBFY5ojnuuGMNGBlhpoEX5PsUk5ObPtLw==
X-Received: by 2002:a05:600c:4e8e:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-493df0377e0mr10554395e9.3.1783350729681; 
 Mon, 06 Jul 2026 08:12:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8e:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-493df0377e0mr10553695e9.3.1783350729097; 
 Mon, 06 Jul 2026 08:12:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce1947bsm290925805e9.14.2026.07.06.08.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 08:12:08 -0700 (PDT)
Message-ID: <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
Date: Mon, 6 Jul 2026 17:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
To: Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260702160640.3875666-1-clg@redhat.com>
 <20260706082023.7ee830b8@shazbot.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260706082023.7ee830b8@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/6/26 16:20, Alex Williamson wrote:
> On Thu,  2 Jul 2026 18:06:40 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Any device on the board can have non-page-aligned memory regions. The
>> VFIO listener should not warn about misalignment for regions that are
>> not VFIO-related.
>>
>> Replace the vfio_known_safe_misalignment() whitelist with a
>> vfio_get_vfio_device() ownership check: only warn when a VFIO device's
>> own region is misaligned. For all other regions, emit a trace event
>> and silently skip. Extract the misalignment test into a
>> vfio_section_misaligned() helper for readability.
>>
>> Note: vfio_get_vfio_device() currently only covers VFIO PCI devices,
>> including vfio-user-pci.  Other VFIO backends (AP, CCW) don't expose
>> memory regions through this path so this is sufficient for now.
> 
> I thought the whole point was to warn when there are non-vfio devices
> that we cannot insert into the DMA map.  851d6d1a0ff2 added tpm-crb-cmd
> to an ignore list because it's not a DMA target.  The intention of that
> ignore list was to continue to evaluate devices that are misaligned
> and either add them to the ignore list or determine they could be a
> valid DMA target and correct the alignment.

If the goal was to use the VFIO listener to catch all misaligned regions,
and potentially fix them, we should reconsider that approach :
  
   https://lore.kernel.org/qemu-devel/20260701080843.2418461-1-clg@redhat.com/

As Peter pointed out, regions that are not page-aligned regions are valid :

   https://lore.kernel.org/qemu-devel/CAFEAcA-QHJ=HaBc5WSLLap8NdDw+tty4EFfGt6cmmNOK6e_m7w@mail.gmail.com/

and aligning them would require a machine compat for migration.
Not addressed in :

   https://lore.kernel.org/qemu-devel/20260630173245.2070268-1-clg@redhat.com/

> Can this even legitimately trigger with a vfio-pci device?  

This would be a real error to report. Right ?

Thanks,

C.


> Thanks,
> 
> Alex
> 
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/device.c     |  2 +-
>>   hw/vfio/listener.c   | 33 +++++++++++++++------------------
>>   hw/vfio/trace-events |  2 +-
>>   3 files changed, 17 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 1a7f8088aad9583ee96fc303be917fdb2f100df9..3a47109efb35c6dc28719dcc19acb85bef1d26cd 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -439,7 +439,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
>>   
>>   VFIODevice *vfio_get_vfio_device(Object *obj)
>>   {
>> -    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
>> +    if (object_dynamic_cast(obj, TYPE_VFIO_PCI_DEVICE)) {
>>           return &VFIO_PCI_DEVICE(obj)->vbasedev;
>>       } else {
>>           return NULL;
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..76b9b02f8163f18d20994e4ec1f914a4d148fa92 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -40,7 +40,6 @@
>>   #include "migration/misc.h"
>>   #include "migration/qemu-file.h"
>>   #include "system/tcg.h"
>> -#include "system/tpm.h"
>>   #include "vfio-migration-internal.h"
>>   #include "vfio-helpers.h"
>>   #include "vfio-listener.h"
>> @@ -352,20 +351,10 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
>>       g_free(vrdl);
>>   }
>>   
>> -static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
>> +static bool vfio_section_misaligned(MemoryRegionSection *section)
>>   {
>> -    MemoryRegion *mr = section->mr;
>> -
>> -    if (!TPM_IS_CRB(mr->owner)) {
>> -        return false;
>> -    }
>> -
>> -    /* this is a known safe misaligned region, just trace for debug purpose */
>> -    trace_vfio_known_safe_misalignment(memory_region_name(mr),
>> -                                       section->offset_within_address_space,
>> -                                       section->offset_within_region,
>> -                                       qemu_real_host_page_size());
>> -    return true;
>> +    return (section->offset_within_address_space & ~qemu_real_host_page_mask()) !=
>> +           (section->offset_within_region & ~qemu_real_host_page_mask());
>>   }
>>   
>>   static bool vfio_listener_valid_section(MemoryRegionSection *section,
>> @@ -379,10 +368,12 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
>>           return false;
>>       }
>>   
>> -    if (unlikely((section->offset_within_address_space &
>> -                  ~qemu_real_host_page_mask()) !=
>> -                 (section->offset_within_region & ~qemu_real_host_page_mask()))) {
>> -        if (!vfio_known_safe_misalignment(section)) {
>> +    if (unlikely(vfio_section_misaligned(section))) {
>> +        /*
>> +         * Only warn for VFIO device regions.  Other VFIO backends
>> +         * (AP, CCW) don't expose memory regions through this path.
>> +         */
>> +        if (vfio_get_vfio_device(memory_region_owner(section->mr))) {
>>               error_report("%s received unaligned region %s iova=0x%"PRIx64
>>                            " offset_within_region=0x%"PRIx64
>>                            " qemu_real_host_page_size=0x%"PRIxPTR,
>> @@ -390,6 +381,12 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
>>                            section->offset_within_address_space,
>>                            section->offset_within_region,
>>                            qemu_real_host_page_size());
>> +        } else {
>> +            trace_vfio_listener_region_misaligned(
>> +                         memory_region_name(section->mr),
>> +                         section->offset_within_address_space,
>> +                         section->offset_within_region,
>> +                         qemu_real_host_page_size());
>>           }
>>           return false;
>>       }
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index f71d0bbc0a5440e4ccd374fac4733af08438e7be..5056b9942027938cd6bc832198acc9809739399f 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -98,7 +98,7 @@ vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn
>>   vfio_listener_region_add_iommu(const char* name, uint64_t start, uint64_t end) "region_add [iommu] %s 0x%"PRIx64" - 0x%"PRIx64
>>   vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
>>   vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
>> -vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
>> +vfio_listener_region_misaligned(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
>>   vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>>   vfio_listener_region_skip_dma_map(const char *name, uint64_t iova, uint64_t size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" marked to skip IOMMU mapping"
>>   vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
> 


