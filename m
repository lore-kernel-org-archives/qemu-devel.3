Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD2DC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 07:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRR55-0004in-2i; Tue, 17 Jun 2025 03:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRR52-0004hc-L7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 03:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRR50-0003KR-3s
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 03:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750146600;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMI/nkicUrh3VBJ2IJcpJuKkeLPcORCoa2mUd2yabwk=;
 b=MeF3t/6tQPt/4kzHLFn2L0C0UWrZCFvT4HmTLX1YULuHHPIPNv7ymNeIYuWiUY6mSNL9cp
 wKO/VQCNerOpGoO70dy7bFueeUM/pW5p7Twhg/O5+t2mEEP+uO2wrITbFWfhNrMv8DuJCa
 tZ0W66nCjltEfw67sDvuvskYUiH5yek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-TAPoX5nINj-dYroQ27TXtA-1; Tue, 17 Jun 2025 03:49:58 -0400
X-MC-Unique: TAPoX5nINj-dYroQ27TXtA-1
X-Mimecast-MFC-AGG-ID: TAPoX5nINj-dYroQ27TXtA_1750146597
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2172669f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 00:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750146597; x=1750751397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RMI/nkicUrh3VBJ2IJcpJuKkeLPcORCoa2mUd2yabwk=;
 b=kcfIhLWnh9ExpvDbDMqRxWQddTPibynt1NSJ0YdkcblWmXtvwB6KGJbr9kz/r5tIZB
 +cPydGWasbN0nr0FjmbCrAGMs+QZM+GGQBAUifqE7kflFFe7Yj1qmMchVS1k3iK3h5ex
 HD+fvIbHu8Oy0/5/BZ8gIRLziewu3M3O40d8c57O0TQVycUJp+vF7h4xqbfzvng+s4zI
 NGKQHoyVVWSEw2jjJOoPzKFy+jARVl0ZfaA2lJ61pbqfXdcaaOjIITfZkCJp9TPfSTZX
 tWVeZRlul8Fqx9OaQlrb7ElKTheqyvZRhVXLvKIllpSNxAJ4oiaMZ4D6HnnmCXjz4KbD
 AFSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWviXJDZN4rXqwsXanROiACu9DbtkZfqs0zAFQM4RQ6FFbGuyiVKk6hyF47kC7QlbGUPJAa9gDhfSIM@nongnu.org
X-Gm-Message-State: AOJu0YzVRQ9Rbgbs90H3gtgiJJWY1/zkpoqxf0rPfCx6844yzSX2qpkW
 FvLp4sQYNEm7nzjogcKmDZNxO4Y9G4QGh4qRlVoGR4YHaEpdIA0wR7KRNKmJxCQYXGTIjyKIlC0
 c7TH8rP1KYCAyARXpT+LMpy76Vp86FebSrKIEu9mUW8mXZ3ZQBJRD/Rqu
X-Gm-Gg: ASbGncsRMIqT2922fc1OziVYxYIypAk2srN2/26oKEF3GRBjv5a7hb4zv+CVSpc17gr
 C1GF6YF5cq93mMVyuvJTGcrxJR/HTz4Ay5iAFnS4jLIx1FFqAP7vakHzsy4f1sX1Y3PUIBx1dts
 QhnjzQzH2+UcimZD637LgSNyqqTI0uiGPj3ecKizjFTbMvxFg15cebgmutCcs2QkYkBhAazNYqL
 A4laBCSQJem2EpZLAFOP5nNquO3OpeE5Heuy2BNmvxkljZWfEaKJBqCcU7TJzL2xXsWud3IFRmD
 ZlO8yFfHRq3UEHloJ7b65mho0sOXPaxWY3oCLgrx4qm4TKVyP5POd0REH5NPyGt6ta6MAA==
X-Received: by 2002:adf:9c83:0:b0:3a5:7944:c9b with SMTP id
 ffacd0b85a97d-3a579440d3cmr7255456f8f.16.1750146597176; 
 Tue, 17 Jun 2025 00:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7/2M6EJ5+4nOM/7D+K1A1AUqPEeGPR8ZC/0cD09KsncqNcx3uBJ7TiY7chAxvGNMu9+DAtw==
X-Received: by 2002:adf:9c83:0:b0:3a5:7944:c9b with SMTP id
 ffacd0b85a97d-3a579440d3cmr7255437f8f.16.1750146596770; 
 Tue, 17 Jun 2025 00:49:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54a63sm13290135f8f.11.2025.06.17.00.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 00:49:55 -0700 (PDT)
Message-ID: <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
Date: Tue, 17 Jun 2025 09:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, linuxarm@huawei.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, nicolinc@nvidia.com, ddutile@redhat.com,
 berrange@redhat.com, imammedo@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, zhangfei.gao@linaro.org
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250616112019.00003bce@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 6/16/25 12:20 PM, Jonathan Cameron wrote:
> On Fri, 13 Jun 2025 15:44:43 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>
>> Although this change does not affect functionality at present, it is
> Patch title says PCIe.  This check is vs PCI host bridge.
>
> No idea which one you wanted, but if it is PCIe needs to be
> TYPC_PCIE_HOST_BRIDGE from pcie_host.h not the pci_host.h one
> I think.
I think we need TYPE_PCI_HOST_BRIDGE as we want to check against pxb

pci-bridge/pci_expander_bridge.c:    .parent        = TYPE_PCI_HOST_BRIDGE,

Besides the commit title/desc suggested by Jonathan you may also refine
the error msg which can stem now from 2 different causes

Thanks

Eric
>
>> required when we add support for user-creatable SMMUv3 devices in
>> future patches.
>>
>> Tested-by: Nathan Chen <nathanc@nvidia.com>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>>  hw/arm/smmu-common.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index f39b99e526..7890aa12c1 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -20,6 +20,7 @@
>>  #include "trace.h"
>>  #include "exec/target_page.h"
>>  #include "hw/core/cpu.h"
>> +#include "hw/pci/pci_bridge.h"
>>  #include "hw/qdev-properties.h"
>>  #include "qapi/error.h"
>>  #include "qemu/jhash.h"
>> @@ -937,7 +938,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>>                                       g_free, g_free);
>>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>>  
>> -    if (s->primary_bus) {
>> +    if (s->primary_bus && object_dynamic_cast(OBJECT(s->primary_bus)->parent,
>> +                                              TYPE_PCI_HOST_BRIDGE)) {
>>          pci_setup_iommu(s->primary_bus, &smmu_ops, s);
>>      } else {
>>          error_setg(errp, "SMMU is not attached to any PCI bus!");


