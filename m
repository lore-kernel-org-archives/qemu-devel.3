Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B34C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUWp-0001lA-C7; Tue, 01 Jul 2025 02:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUWm-0001kP-LB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUWk-0001sb-6S
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751351489;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LR7ZO0C+TGNIDz+GF9OqXAtZE8ZVPkH1n+UdZpH5KA=;
 b=dy4n8VrjeXLZTWmp7X3BNgNlX/fr74mP7MAtv2XjMUY5bkdztdIojvwWfaGTelm7KCiffm
 iqqdwytHaZwElUJuhkcdYuPI/5McnlCHF/PTH/nNhm2eANn1c93hnKRglaDp1GXle5eHTY
 GZwop3cg0SOBiWFL3ln7c5Wd8HpDUMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-572LzsZ5NeephqZah7ybDQ-1; Tue, 01 Jul 2025 02:31:28 -0400
X-MC-Unique: 572LzsZ5NeephqZah7ybDQ-1
X-Mimecast-MFC-AGG-ID: 572LzsZ5NeephqZah7ybDQ_1751351487
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so20720465e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 23:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751351487; x=1751956287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6LR7ZO0C+TGNIDz+GF9OqXAtZE8ZVPkH1n+UdZpH5KA=;
 b=maQRb+IDSe7oGMcAlLi3L6Kbt72TRwvONEQfmSt9VKwJuRx+csqlot6P+5MLfj8dGB
 ahuyTnFo66pY/9arb0rrBRj9nsngFk6xJZQZ1bGcA0E7XIuKSFDOZLgyqykk6XieBz+4
 hW967xFcy0ypDAK8BVjAnftC0iAYLEpk7Ql8mtfkoA8+CCaR1ls5GcoclVWbLuevfliQ
 WISaeN8dLGWRhMRCjVWRAFCuR8Ru0dniw+VSvvFNqEf4PCRmDyVLxTrTtGzBypQYqT9/
 8Rq0WMm/eCTKz4rjTeHsfwzJmYd5Q+sOyTRbqD+b8d582Otiqk1Mad05egJsH4OJ9oGA
 JH4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl8SSAT3pBisXCzw8L3b72shrZNpF5ccB9nhET2KlITfeD0zkh4MhK/onZnoPRjRvUsbjcTELRj6eC@nongnu.org
X-Gm-Message-State: AOJu0Yw+AEHkb5kg8cEFdMYfCpd+M9elTFJWT4Aqq2sQ7vxwQXBpOoLS
 jnM8VwkgjjBpBOg0UqqPHc5VIyUIVfI7bk7ko8NZ2zyrKppil6FZ2Rf/NKGDTkjHu7/COi2uBGv
 EuIXZCkKNPyg3N+MEkS0OI0i+/7v/rICLp56pJevWA2JV7Ds4dDFFkhPW
X-Gm-Gg: ASbGnct1bxlVztty/7WKjVmLOgSdKRFP2eU0bIbsMHfZF1xdqoR0DcaoxP6FdzZzz8S
 W0qkrYrnUVpkj+KPNS525c8h/kCwWhUf6uJnLGhD4C/9tTkd9HEJqUeuXX4RPki82mkKMaZZi44
 y34/FHk2Jq2C1SSP/2LRRFPzFrwTgXJAiUv8HuWDRopcUxXf3eN+HyT6IK5nn6M3SfgU0IUM2VI
 FqvCgsc8uMxgzyTeL1C40ss3XgTKv05k7J8uhTJhaNE8pYlp6vg4/qFHxAJx52Qev+ujMk2WeMw
 K37vy+qaOqlEerOvbPGaYbsmqEEjzK2r2wZlL2FL3/hxwV9+Xd+CV76UoKm7q3/GaPhojw==
X-Received: by 2002:a05:600c:a009:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-453902d3100mr146674295e9.12.1751351487028; 
 Mon, 30 Jun 2025 23:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhjTLsVW0x5lyIrQ/CT3ruHe90xnHbEA6+jRqX46KgiVXyxtbdlQa22Iqh/+0YVKT8dq6ikw==
X-Received: by 2002:a05:600c:a009:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-453902d3100mr146673715e9.12.1751351486515; 
 Mon, 30 Jun 2025 23:31:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59736sm12227960f8f.74.2025.06.30.23.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 23:31:25 -0700 (PDT)
Message-ID: <90fc6fd8-fe67-4a16-b287-69da9861f180@redhat.com>
Date: Tue, 1 Jul 2025 08:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-2-shameerali.kolothum.thodi@huawei.com>
 <ce1d4b22-d613-4143-9b50-bd3e8047bff8@redhat.com>
 <5a0ee9d2e27e47e6a4b443ef6e645b52@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5a0ee9d2e27e47e6a4b443ef6e645b52@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/30/25 9:01 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Friday, June 27, 2025 12:52 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; imammedo@redhat.com;
>> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
>> gustavo.romero@linaro.org; Linuxarm <linuxarm@huawei.com>; Wangzhou
>> (B) <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v5 01/11] hw/arm/smmu-common: Check SMMU has
>> PCIe Root Complex association
>>
>> Hi Shameer,
>>
>> On 6/23/25 11:42 AM, Shameer Kolothum wrote:
>>> We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>>> root complexes to be associated with SMMU.
>>>
>>> Although this change does not affect functionality at present, it is
>>> required when we add support for user-creatable SMMUv3 devices in
>>> future patches.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/smmu-common.c                | 29 ++++++++++++++++++++++++++---
>>>  hw/pci-bridge/pci_expander_bridge.c |  1 -
>>>  include/hw/pci/pci_bridge.h         |  1 +
>>>  3 files changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index f39b99e526..b15e7fd0e4 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -20,6 +20,7 @@
>>>  #include "trace.h"
>>>  #include "exec/target_page.h"
>>>  #include "hw/core/cpu.h"
>>> +#include "hw/pci/pci_bridge.h"
>>>  #include "hw/qdev-properties.h"
>>>  #include "qapi/error.h"
>>>  #include "qemu/jhash.h"
>>> @@ -925,6 +926,7 @@ static void smmu_base_realize(DeviceState *dev,
>> Error **errp)
>>>  {
>>>      SMMUState *s = ARM_SMMU(dev);
>>>      SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
>>> +    PCIBus *pci_bus = s->primary_bus;
>>>      Error *local_err = NULL;
>>>
>>>      sbc->parent_realize(dev, &local_err);
>>> @@ -937,11 +939,32 @@ static void smmu_base_realize(DeviceState
>> *dev, Error **errp)
>>>                                       g_free, g_free);
>>>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>>>
>>> -    if (s->primary_bus) {
>>> -        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
>>> -    } else {
>>> +    if (!pci_bus) {
>>>          error_setg(errp, "SMMU is not attached to any PCI bus!");
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based
>> extra
>>> +     * root complexes to be associated with SMMU.
>>> +     */
>>> +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
>>> +        object_dynamic_cast(OBJECT(pci_bus)->parent,
>> TYPE_PCI_HOST_BRIDGE)) {
>>> +        /*
>>> +         * For pxb-pcie, parent_dev will be set. Make sure it is
>>> +         * pxb-pcie indeed.
>>> +         */
>>> +        if (pci_bus->parent_dev) {
>>> +            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
>>> +                goto out_err;
>>> +            }
>> I still wonder whether the above check was mandated as it works for what
>> it is meant:
> Added that check to make sure we don't support pxb-cxl which is of type
> PCI_HOST_BRIDGE. Once the cxl support for ARM is up streamed and tested
> with SMMUv3, we can relax this if required.
agreed. I would add this in the commit msg while rebasing.

Eric
>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Thanks,
> Shameer
>


