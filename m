Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86271CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFxSO-00047M-K7; Mon, 03 Nov 2025 11:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxSN-00047B-Qp
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxS7-0007OY-GC
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762187438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AMOfvYfaYou6zeuCdAKRJlXrsqctEUARD6uEDmcr3sA=;
 b=fi0qng+NZ42siEz2uUjtcHjZbS08gdoPSWl8UPrlwaITpsumLaumr/PlG+0XSqXYiqs4hU
 Z1xJvarhGv5TEyXlZ7Mebn1KSWYhgAnY+Y8ZKg9aR2o+DI12Oo5GbtdkMqo6paTy6D3ev/
 zOCm5UtT2X6r38flnSQ+/2TJkxvot1w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-NVJAY7o-MA-0uw5MtaHq5Q-1; Mon, 03 Nov 2025 11:30:37 -0500
X-MC-Unique: NVJAY7o-MA-0uw5MtaHq5Q-1
X-Mimecast-MFC-AGG-ID: NVJAY7o-MA-0uw5MtaHq5Q_1762187437
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429be5aeea2so1895346f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 08:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762187436; x=1762792236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMOfvYfaYou6zeuCdAKRJlXrsqctEUARD6uEDmcr3sA=;
 b=O7cggHhXnk2wtxg3Rf0VwbDP4PCRNjAG/A4AjcWFi7pPwy1oLnzGP5GiyxmgqqZAMC
 oUgfQE1A2Ow7XNsmpE+Uf2IAKTVns0hcwv6MyxVTuxlLPHP2t0rzmLsgn5J+VG4EV5bP
 DmWIjzujtw2x91Vi9YQN+/jCuhu5UuZ1ySeUKyH7IyqyrSYTuOR4Lzp7zwyTP6jS43ul
 Eu6OK34NFtW6dQW6BMPsBfW+0hrQ8s/4nje7vRADTFCD/NRq5tX9aVXteKfKYGEmh1hl
 lKC6A8GO9c53b6hyjIZD8qvqoYnYloEwgXD44VpY7mlRHL/xfulhtKXhE9bHDiPiZs83
 90hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB/oPpRfmJ0EgHdIgW6Ntt5UbD+fVtfOoFemxHTt5naEow6izBhoXutJuSz+Z6bJdmDzT70PjtTlSS@nongnu.org
X-Gm-Message-State: AOJu0YxpZ2cIkYDtevhDMwFVCXBvNlSO8NohCOK4MNxDtLml1RVacuG/
 NX7j42ozO63XvziCWutJpZ4kwtxPZYyRiwX70Oq/BZX907vtO++t1qRX59w39NSVHEEVr2jpt1d
 P8+J8grjlJ9bq160pom/8TKvvLplOaRJ2pYwD4X+QFEsghKxEavB/ttKc
X-Gm-Gg: ASbGncsUzIqYSi5fnulYXAiKBgCQvdQx3xIapd4EthOr6bT9WkPAo8biow4wqMKEOyy
 nyTYsgw5fPMHP+BGcopRidHXFYJbK+ohrw19vo70gmWsM6VMXne/0BiPssIaUlehVolN2IZzgcu
 IhAK4LiZxQJdmfntLjIbRRXav7DNlTPKk8PLPL27Lyopd4oHrZSknwEqa0yqJkRiHiJikyNKWNf
 NKkYlBZkxIeevwsnxFD59YKo0DsomapMUZitDVpkHqg6ztk2oAZoktwLpnkhgehP/zhdw4GCHks
 ZOxC3KraOFIn47SI5md/2ceqftCIZEARafZd+Swe9rrMYG93GWu5WQGJ3BVOVp5TATTkyXmn2EA
 svlapE0D2+84oBYeKvQmAHP7rh0nZ48zEKvDWyIFPcytJSA==
X-Received: by 2002:a05:6000:2387:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-429bd6b1fbemr11615931f8f.56.1762187436492; 
 Mon, 03 Nov 2025 08:30:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPB7L4RnPIaLDr20ydsswmq05dPX7C+uIKYMYA7+0CXCfUAlrAuaclnEPhp7aVaGqcJbCwOA==
X-Received: by 2002:a05:6000:2387:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-429bd6b1fbemr11615889f8f.56.1762187436060; 
 Mon, 03 Nov 2025 08:30:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2e677csm163887905e9.3.2025.11.03.08.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 08:30:35 -0800 (PST)
Message-ID: <1d2570cc-02f4-41c5-ba5a-0ceca8a732e5@redhat.com>
Date: Mon, 3 Nov 2025 17:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared system
 address space
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com, Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-7-skolothumtho@nvidia.com>
 <ea91137e-e5af-414b-86e2-2de7373bcb05@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ea91137e-e5af-414b-86e2-2de7373bcb05@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 11/3/25 2:39 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 31/10/25 11:49, Shameer Kolothum wrote:
>> To support accelerated SMMUv3 instances, introduce a shared system-wide
>> AddressSpace (shared_as_sysmem) that aliases the global system memory.
>> This shared AddressSpace will be used in a subsequent patch for all
>> vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
>>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 99ef0db8c4..f62b6cf2c9 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -11,6 +11,15 @@
>>   #include "hw/arm/smmuv3.h"
>>   #include "smmuv3-accel.h"
>>   +/*
>> + * The root region aliases the global system memory, and
>> shared_as_sysmem
>> + * provides a shared Address Space referencing it. This Address
>> Space is used
>> + * by all vfio-pci devices behind all accelerated SMMUv3 instances
>> within a VM.
>> + */
>> +MemoryRegion root;
>> +MemoryRegion sysmem;
>
> Why can't we store that in SMMUv3State?
>
>> +static AddressSpace *shared_as_sysmem;

We will have several instances of SMMUv3State which all share the same
as, hence the choice of having a global.

Eric
>
> FYI we have object_resolve_type_unambiguous() to check whether an
> instance exists only once (singleton).
>
>> +
>>   static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs,
>> SMMUPciBus *sbus,
>>                                                  PCIBus *bus, int devfn)
>>   {
>> @@ -51,9 +60,27 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>>       .get_address_space = smmuv3_accel_find_add_as,
>>   };
>>   +static void smmuv3_accel_as_init(SMMUv3State *s)
>> +{
>> +
>> +    if (shared_as_sysmem) {
>> +        return;
>> +    }
>> +
>> +    memory_region_init(&root, OBJECT(s), "root", UINT64_MAX);
>> +    memory_region_init_alias(&sysmem, OBJECT(s), "smmuv3-accel-sysmem",
>> +                             get_system_memory(), 0,
>> +                             memory_region_size(get_system_memory()));
>> +    memory_region_add_subregion(&root, 0, &sysmem);
>> +
>> +    shared_as_sysmem = g_new0(AddressSpace, 1);
>> +    address_space_init(shared_as_sysmem, &root,
>> "smmuv3-accel-as-sysmem");
>> +}
>> +
>>   void smmuv3_accel_init(SMMUv3State *s)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>>         bs->iommu_ops = &smmuv3_accel_ops;
>> +    smmuv3_accel_as_init(s);
>>   }
>


