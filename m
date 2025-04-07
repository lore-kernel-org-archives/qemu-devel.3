Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50721C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hv7-0001ys-OH; Mon, 07 Apr 2025 04:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1huo-0001gR-L7
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1huk-0003k1-46
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744014782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TlAa9+DGx+3ergX6N+sAthv8bz73QJV9cSh9h/L7FBc=;
 b=GFwtxX106JG2npE7trVPZTbYcQTRE1MiOl3ajxYC+DxzLctTWEJhu/nQGVyIWMdK70bxbZ
 FLIG7OAbAjwmIoWA6ywLFxYfz7+UPxcXwNfD+AyOp6Sjfi3b9Ms9h0+UrG32lCi7m15DS/
 xFm2GoNr6DwoyOxneSIIBA3hmEspEjc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-J0XYYZPpMPevi6u8DPKgxQ-1; Mon, 07 Apr 2025 04:33:00 -0400
X-MC-Unique: J0XYYZPpMPevi6u8DPKgxQ-1
X-Mimecast-MFC-AGG-ID: J0XYYZPpMPevi6u8DPKgxQ_1744014779
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39979ad285bso2399096f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744014779; x=1744619579;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlAa9+DGx+3ergX6N+sAthv8bz73QJV9cSh9h/L7FBc=;
 b=qg4GgrTp6b5KgfYYU5fx9SeyXBrf6dOd1/XD0o+Wt4eh+4r5deGTqqrjy7huI/hR/U
 XL92xi/aEbzZnncYw3tb0f4zbSakWQMTNb//EqRKyCf5A87eC/456AqOj+X4Fms0iJQs
 xxwjnv2lM6DzjJgkYeTLtirWmVPPdmnqRgfbGP0ELDBEAjQZ+Z2tnJX77e9k5so4d+r1
 LA2eiZjxkB6pkzHab48u2DIa0ou6oOdYw9cl7KobPp/HfNpW553J0ziFiKkNC1Ijf5n9
 YJioNjs1+EBYhJ8uz1XKC9R+sL/i6TI57jboR88PfXhw83RTx3gfVwrW+5HpwnTMP0hi
 sJMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd9Af+b5sh5LM4FbBQExxaKlWoRTDhqthGH++aPmvj42hxgT45B86Uls4TO8FUecgZ9/UDZZKmrerh@nongnu.org
X-Gm-Message-State: AOJu0YzWV1BqRyvmi5n4JSwL6ZuqKx3qy9vVa+nUdLg+jeu6z2tjytC2
 HCW6AHUHAQS2Fph1JvospJE7WrHsjxsBB32D5R55Df0Q057au2yYlmdHdOgQyD85dcXiRwM+JFb
 ph3W6ZxG22SEbe3dTxOg3Q6Rl7aH4xpuU3YcljE1Uh1Vaslp/P/uAZkqASped
X-Gm-Gg: ASbGncvqlTxOhjgv8cMbgOVkNvPXBDTNHGVpwWG4S+jLFtqpfSBEK+N63IOpzBqXXN2
 yCF8K+qzLaMhlrmqr7hZbZYpcsWZCNiQ82Kqa3CYtQalNa5EEtxeyoEXt81RnXPZg1muhL/7wFL
 CO1FM37zHdyM88iCBejz2FFHghL/Qczivl0p3ue2F/hcHnH0q0LphJIb7e08b/f0EOVkRsy/agq
 BGpkJ8L9tpIOKpFOqw+2OEJgiH7+hNFBaUlcF3ccPrbWSPfpepN/ACHAOiPOhXRn/bhVLYt4BXa
 zoIeUy9jR1vVc9f2pOBwgX5J8nDxl1HKLIR/6UGHBFCWaVuisIEdeg==
X-Received: by 2002:a05:6000:40c8:b0:391:139f:61af with SMTP id
 ffacd0b85a97d-39d0de29752mr8002008f8f.32.1744014779056; 
 Mon, 07 Apr 2025 01:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVRABYAl/5Yry4Di8nO/eLGqsvH3mpx9VRJHxUsGjlgMgHrYmgkDVv3g/zd7E3UMwYSy/oDQ==
X-Received: by 2002:a05:6000:40c8:b0:391:139f:61af with SMTP id
 ffacd0b85a97d-39d0de29752mr8001990f8f.32.1744014778673; 
 Mon, 07 Apr 2025 01:32:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6796sm11546773f8f.31.2025.04.07.01.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 01:32:58 -0700 (PDT)
Message-ID: <b072db3d-7143-4452-a13d-c2b926f32dfb@redhat.com>
Date: Mon, 7 Apr 2025 10:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 31/37] vfio: Rename vfio_get_dirty_bitmap()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-32-clg@redhat.com>
 <a42633a4-b8b0-44e8-98cc-35585be8fbba@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a42633a4-b8b0-44e8-98cc-35585be8fbba@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/2/25 15:36, Avihai Horon wrote:
> 
> On 26/03/2025 9:51, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> vfio_container_query_dirty_bitmap() is consistent the VFIO container
>> routine naming scheme and is now free to use.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Since lore didn't receive the email :

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

> A few nits below.

yes. The indentation and 80 chars rule are best effort. Our tool
checkpatch.pl only emits a warning. I prefer to keep the current
layout for readability reasons.



Thanks,

C.






> 
>> ---
>>   include/hw/vfio/vfio-container-base.h | 4 ++--
>>   hw/vfio/common.c                      | 6 +++---
>>   hw/vfio/container-base.c              | 5 +++--
>>   hw/vfio/container.c                   | 2 +-
>>   hw/vfio/trace-events                  | 2 +-
>>   5 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 163d9b3c30b3093d2f40bb3d3ffc0314519ac285..a441932be779e5c6740da78f005ed2c8320e7cb2 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -93,8 +93,8 @@ bool vfio_container_dirty_tracking_is_started(
>>       const VFIOContainerBase *bcontainer);
>>   bool vfio_container_devices_dirty_tracking_is_supported(
>>       const VFIOContainerBase *bcontainer);
>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>> -                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>> +int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> +    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
> 
> Indentation is a bit off.
> 
>>
>>   GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index d063ea03c1cb4f475d421e626c703875fecd97a8..26ced6d4fb04b0dedf399686db40acaca5d85552 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1003,7 +1003,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>           goto out_unlock;
>>       }
>>
>> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>> +    ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> 
> This line is beyond 80 chars.
> 
>>                                   translated_addr, &local_err);
>>       if (ret) {
>>           error_prepend(&local_err,
>> @@ -1040,7 +1040,7 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>>        * Sync the whole mapped region (spanning multiple individual mappings)
>>        * in one go.
>>        */
>> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>> +    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> 
> This line is beyond 80 chars.
> 
>>                                   &local_err);
>>       if (ret) {
>>           error_report_err(local_err);
>> @@ -1134,7 +1134,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>>       ram_addr = memory_region_get_ram_addr(section->mr) +
>>                  section->offset_within_region;
>>
>> -    return vfio_get_dirty_bitmap(bcontainer,
>> +    return vfio_container_query_dirty_bitmap(bcontainer,
>>                      REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
>>                                    int128_get64(section->size), ram_addr, errp);
>>   }
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 648dd25676e5b25a7c414109888b2796f890deac..a2e7a3b2e747d422f7a681fb09b1182e119c6d20 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -237,7 +237,7 @@ static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bc
>>       return 0;
>>   }
>>
>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>> +int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                             uint64_t size, ram_addr_t ram_addr, Error **errp)
> 
> Indentation is a bit off.
> 
>>   {
>>       bool all_device_dirty_tracking =
>> @@ -275,7 +275,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>       dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>>                                                            vbmap.pages);
>>
>> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
>> +    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
>> +                                            dirty_pages);
>>   out:
>>       g_free(vbmap.bitmap);
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 9ea03ed618f6aefe35f966c644cbbc127ce7bf06..c74e08e531a501313cab27c57728a8c940d975be 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -169,7 +169,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>       }
>>
>>       if (need_dirty_sync) {
>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>> +        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
>>                                       iotlb->translated_addr, &local_err);
> 
> Indentation is a bit off.
> 
> Thanks.
> 
>>           if (ret) {
>>               error_report_err(local_err);
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index d4cd09cb0f93485fe06984346f6ac927603c5745..aa0ba695fa38f7767bf506ec604046101186e7d4 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -109,7 +109,7 @@ vfio_legacy_dma_unmap_overflow_workaround(void) ""
>>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>
>>   # container-base.c
>> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>> +vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>
>>   # region.c
>>   vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>> -- 
>> 2.49.0
>>
> 


