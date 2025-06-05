Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E218AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7QR-0000pp-3F; Thu, 05 Jun 2025 06:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN7QL-0000oz-V8
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN7QK-0004aB-6O
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749117729;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HEoOMSqXtdi0Q51L1Ph5UeJyMg5C6Ya+67lIbUsoJY=;
 b=MUu2mK2hnbL8FW9sSSBo9v+nyUaqmo87R4yLYm0fLNkmvObi9cmVN+pyYFlwMw4EFgEEdG
 dWtgw+G1vGdtQBj1HrYMM+m5L40Iq04vkiW4kt572QHK3VN3QZ7v2Ie8vGYsE79ngjmP+W
 MCrC0M1BP4pW0h6zO7iu/7HlR6/6FBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-6dQlZC6_O5iXI6qT57fD7Q-1; Thu, 05 Jun 2025 06:02:08 -0400
X-MC-Unique: 6dQlZC6_O5iXI6qT57fD7Q-1
X-Mimecast-MFC-AGG-ID: 6dQlZC6_O5iXI6qT57fD7Q_1749117727
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso4622485e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749117727; x=1749722527;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/HEoOMSqXtdi0Q51L1Ph5UeJyMg5C6Ya+67lIbUsoJY=;
 b=lqUcE2Jg3xVbn3HMkM8ItB1fVr8PwM9CTlaoDNyH7esBoiitCuWN4c02WFezg/dSw6
 bIM9tH63Pl9Y+B1Aj8RAdRwRWuWjrCYv1YW0kAGYtuTCCQukxd2ZvtjF5CmhWYSao32a
 2AyrleqGT9A3O8d8pR5YlRdyhew2LGIMl5tDIfyfBuJ9U0+sTMz2gwNK6GJZ9UfHDKxN
 /t+j9LHftiomX+0I1lIgBhKCZe7Gmfu3zR5t7Lf1iGLjTFM4uJ3f/Ix83HLeV4ON/APM
 UmLgB6baaDBsoo5yczoJ0+LEhDoeB8JTPVnV5gi74vttI/+P3F3Kj0hmo0R/sAoUXzan
 ruZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL6G8c8WfmN1McS1MnY6N0sCUfSZrW+OfNYm4rwTYdxVRatxwgH0s4n7+bssYJszytgtYeeJXVT6U4@nongnu.org
X-Gm-Message-State: AOJu0YxnNyoO0ojja0hM3l00F13zUEJuiyvEw55RW28RqqAhv5nHpf32
 e2qGleDCCDQgG6PGG/lRttYCGYcDRISXtZSWV6iukD+dZqisxCjwfzEcdMOChV2a6xuQvtkjrDq
 Z2HyrQt9IzqrwxfppHc5Z3ns4067v21u9nSpIgMRxrOXwXy9bnSn+PvqX
X-Gm-Gg: ASbGncvL/dbaOGfE7QZGTe0pmx1emeSOfzf3nXrUafN4m8+hWP8UVCd+/Ane1tVcpYu
 o9n4uTTQSkDb23ap5sEd9hgCJQ/vzdx/GPyd2fkOKV3+fF019+uvTi20a+h75Oc+9jVR9FqVDHN
 ZJz6zn3wESNx1L2GE61O6QmJSJ1FmDAf7Gj0jD2+2gtOLuelBpIR/+dwRUF9RJd6dNlz/IlWD8n
 bJ5+0NmYP6OxdC+scDqkYTgMXQnBaNXN56QeqaDwpQoVlsDlQWMN1mM8w9xKqiqzIdrewBJE9L1
 NwBuDi5EIEJsst40VUnEKqbhTuMazouhtisbRc3ME+FWQaQK44oE1JiZtJk=
X-Received: by 2002:a05:600c:1c97:b0:450:d3b9:4ba4 with SMTP id
 5b1f17b1804b1-451f0a6073fmr56892525e9.2.1749117727086; 
 Thu, 05 Jun 2025 03:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiA0BbJ/+M95XitwyYDsL+toQfTVT8QzO9r7bwKeBgpymVTvE40I4D06ZFUSI0HCxjom1lpw==
X-Received: by 2002:a05:600c:1c97:b0:450:d3b9:4ba4 with SMTP id
 5b1f17b1804b1-451f0a6073fmr56891785e9.2.1749117726422; 
 Thu, 05 Jun 2025 03:02:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f9924a6esm18909195e9.38.2025.06.05.03.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 03:02:05 -0700 (PDT)
Message-ID: <cb2a688d-fbf2-497e-8baf-f28352766105@redhat.com>
Date: Thu, 5 Jun 2025 12:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root Complex
 association
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-2-shameerali.kolothum.thodi@huawei.com>
 <15b1fd04-2dd0-4191-8958-9d8db8dff7c9@redhat.com>
In-Reply-To: <15b1fd04-2dd0-4191-8958-9d8db8dff7c9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  eric.auger@redhat.com
X-ACL-Warn: ,  Eric Auger <eric.auger@redhat.com>
From:  Eric Auger via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/5/25 11:53 AM, Eric Auger wrote:
> 
> 
> On 6/2/25 5:41 PM, Shameer Kolothum wrote:
>> Although this change does not affect functionality at present, it is
>> required when we add support for user-creatable SMMUv3 devices in
>> future patches.
>>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>>  hw/arm/smmuv3.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index ab67972353..7e934336c2 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -24,6 +24,7 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/qdev-core.h"
>>  #include "hw/pci/pci.h"
>> +#include "hw/pci/pci_bridge.h"
>>  #include "cpu.h"
>>  #include "exec/target_page.h"
>>  #include "trace.h"
>> @@ -1881,6 +1882,13 @@ static void smmu_realize(DeviceState *d, Error **errp)
>>      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
>>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>      Error *local_err = NULL;
>> +    Object *bus;
>> +
>> +    bus = object_property_get_link(OBJECT(d), "primary-bus", &error_abort);
>> +    if (!bus || !object_dynamic_cast(bus->parent, TYPE_PCI_HOST_BRIDGE)) {
>> +        error_setg(errp, "SMMUv3 is not attached to any PCIe Root Complex!");
>> +        return;
>> +    }
> shouldn't you check as well that !pci_bus_bypass_iommu(bus)?

I see you do the check in 6/6 and I think this is the correct way
because in case of legacy SMMU it is allowed to have
pci_bus_bypass_iommu set on the root bus to let the SMMU apply only on
pxb buses only. So please ignore this comment.

Eric
> 
> Eric
>>  
>>      c->parent_realize(d, &local_err);
>>      if (local_err) {
> 


