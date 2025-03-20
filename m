Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33DEC35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 13:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvG5L-0005Mc-B2; Thu, 20 Mar 2025 09:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvG5J-0005Jm-5S
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvG5E-0004BZ-BO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742477833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eMmdb3CafBI7vgmrTcIlpou40hpOJWagCjQipsArdBo=;
 b=PsUoz7LTYay9srxjxWJAIa604AIa4uqJFmlsoUrSCA3UkWi9mmnNV94tn0IGtqb6MFbjVA
 Au6Zo+7Ct77sB/PsGhY1S9wS5pq/yBbYfxWkmj/ik8NCXL2ni24wTRMINQqKvrpA221M26
 xc3Q/sZf/4ixR9ZsyN+zCUDCt768uT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-zqEvYDh-NKCIRYt76iatHw-1; Thu, 20 Mar 2025 09:37:11 -0400
X-MC-Unique: zqEvYDh-NKCIRYt76iatHw-1
X-Mimecast-MFC-AGG-ID: zqEvYDh-NKCIRYt76iatHw_1742477830
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so4845005e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 06:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742477830; x=1743082630;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMmdb3CafBI7vgmrTcIlpou40hpOJWagCjQipsArdBo=;
 b=uFH3xvel3l1nZJcepXCmxgjROt8OrZ/BuLJYcePGyvbJPYnaRs3DW0FLD5w3125a2g
 H9NbnhkJl8yV1zUOPho1YHpTottUk23UUb3qfmaIdZyJKowDRh0h6m2Hdvz4lIH7N+VC
 FqONpJxHopDrY3CNSRXSDlNkQEkmNyxP43Z97C0bH0oICbb8aMx+132BZrc/feURwwNp
 A3XmXMHSrffsNgm3w0wJytt8t3LfqjZdxgEEU8hHE5UIlydVbnmTMAaLx9CW7iiahc+N
 qYGugBipDj96Cq36sjBalS9Qff1wWf4tJFOOM/KMKEo7f3cF50SbHS3TxM481HJQ21nc
 lNDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsUKiZzIcSWuvfQmQvyM/K+Hcqfttp4YA9Z3VTy/3yUiaOQi0dhwkLQ2OJhxuTnlTY3ADg8TudQdnf@nongnu.org
X-Gm-Message-State: AOJu0YzutPkYhwWedXpOs4XQ04yP3jvZIAJMQ8EmXY+VJ3eJhF26zqC4
 7/y/34mLzIQdMMlx2WQlSuhWMldVsNoThrKPmFGm23DYrRmuwj7BJSFE7dy4iHCuOZTvZo1NJeT
 mAmza8tsu/kiUfEKQdLF0O7L0TLPAEKq5eHJZcCYN+SF3cOFJ5STj
X-Gm-Gg: ASbGnctePd8XE35exrkU/w3zKpsmqD5/D76An2M73EZ3xizdNzqwnafTz4HXgH8shfx
 UN723M+9rBLsYSwZT9pfet7DP1xZlSNpX+CCdItYpq3jWoJ4vKJm2y7UFDN/O2MDRIjHBj4MfdI
 DdHP0JQSZqO7wMMM1Mf38BrlGLMwO4FfkHFvhUvvsQ4LkvOHsso4xEDloApvr4BZzm3vCC/j+s8
 6wYwOVv+G2nOpRpVXrJmdiBLzjfXH3CKu8pt0EquaOphf3hiQ4RqE6pNxxT7dexEhpSqyLP3+YC
 5WALto0Mxvw788RNAxDHimShDO+BJE7hSK8TnVUIc/qlhylJioW9aQ==
X-Received: by 2002:a05:600c:4503:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-43d437c32a0mr80689385e9.17.1742477829900; 
 Thu, 20 Mar 2025 06:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcZeYB5b3MNVRo/w9MjHxkGXBiTbk0l7j2ew0svx+vPEeNmaRFhbtt4Dyrzva47wwV/n3ytQ==
X-Received: by 2002:a05:600c:4503:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-43d437c32a0mr80689015e9.17.1742477829409; 
 Thu, 20 Mar 2025 06:37:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4453227dsm50513875e9.40.2025.03.20.06.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 06:37:08 -0700 (PDT)
Message-ID: <6891b2ca-83db-4279-97c1-6a8f4ab3983b@redhat.com>
Date: Thu, 20 Mar 2025 14:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 09/32] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-10-clg@redhat.com>
 <SJ0PR11MB6744FA99CAB466E2D89F987E92D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB6744FA99CAB466E2D89F987E92D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/20/25 10:18, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH for-10.1 09/32] vfio: Introduce a new header file for
>> VFIOIOMMUFD declarations
>>
>> Gather all VFIOIOMMUFD related declarations into "iommufd.h" to
>> reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> hw/vfio/iommufd.h             | 29 +++++++++++++++++++++++++++++
>> include/hw/vfio/vfio-common.h | 21 +++------------------
>> hw/vfio/iommufd.c             |  1 +
>> 3 files changed, 33 insertions(+), 18 deletions(-)
>> create mode 100644 hw/vfio/iommufd.h
>>
>> diff --git a/hw/vfio/iommufd.h b/hw/vfio/iommufd.h
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..7d87994c4fadbc328b6ac7f9ae
>> e00469dd8808b0
>> --- /dev/null
>> +++ b/hw/vfio/iommufd.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * VFIO iommufd
>> + *
>> + * Copyright Red Hat, Inc. 2025
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_VFIO_IOMMUFD_H
>> +#define HW_VFIO_IOMMUFD_H
>> +
>> +
>> +typedef struct VFIOIOASHwpt {
>> +    uint32_t hwpt_id;
>> +    uint32_t hwpt_flags;
>> +    QLIST_HEAD(, VFIODevice) device_list;
>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>> +} VFIOIOASHwpt;
>> +
>> +typedef struct VFIOIOMMUFDContainer {
>> +    VFIOContainerBase bcontainer;
>> +    IOMMUFDBackend *be;
> 
> Do we need to add 'typedef struct IOMMUFDBackend IOMMUFDBackend;' for above line?

yes and we need a few more includes too (VFIODevice , VFIOContainerBase).


Thanks,

C.



> 
> Thanks
> Zhenzhong
> 
>> +    uint32_t ioas_id;
>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>> +} VFIOIOMMUFDContainer;
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>> VFIO_IOMMU_IOMMUFD);
>> +
>> +#endif /* HW_VFIO_IOMMUFD_H */
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index
>> 3355c2d4e57569d7bb01b4d9378fb49a807335e8..8d48f5300a791d8858fe29d1bb
>> 905f814ef11990 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -69,27 +69,12 @@ typedef struct VFIOContainer {
>>
>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>>
>> -typedef struct IOMMUFDBackend IOMMUFDBackend;
>> -
>> -typedef struct VFIOIOASHwpt {
>> -    uint32_t hwpt_id;
>> -    uint32_t hwpt_flags;
>> -    QLIST_HEAD(, VFIODevice) device_list;
>> -    QLIST_ENTRY(VFIOIOASHwpt) next;
>> -} VFIOIOASHwpt;
>> -
>> -typedef struct VFIOIOMMUFDContainer {
>> -    VFIOContainerBase bcontainer;
>> -    IOMMUFDBackend *be;
>> -    uint32_t ioas_id;
>> -    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>> -} VFIOIOMMUFDContainer;
>> -
>> -OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>> VFIO_IOMMU_IOMMUFD);
>> -
>> typedef struct VFIODeviceOps VFIODeviceOps;
>> typedef struct VFIOMigration VFIOMigration;
>>
>> +typedef struct IOMMUFDBackend IOMMUFDBackend;
>> +typedef struct VFIOIOASHwpt VFIOIOASHwpt;
>> +
>> typedef struct VFIODevice {
>>      QLIST_ENTRY(VFIODevice) next;
>>      QLIST_ENTRY(VFIODevice) container_next;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index
>> 2fb2a01ec6d29dbc284cfd9830c24e78ce560dd0..a219b6453037e2d4e0d12800ea
>> 25678885af98f8 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -26,6 +26,7 @@
>> #include "qemu/chardev_open.h"
>> #include "pci.h"
>> #include "migration.h"
>> +#include "iommufd.h"
>>
>> static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr
>> iova,
>>                              ram_addr_t size, void *vaddr, bool readonly)
>> --
>> 2.48.1
> 


