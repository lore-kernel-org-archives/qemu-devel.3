Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CCFC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYjX-0004qu-RG; Fri, 21 Mar 2025 05:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvYjT-0004d1-81
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvYjR-0000r9-AM
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742549520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BESk/McuKINamU0JmL248xDhh8Bu7Mzrr9eqdei3/jk=;
 b=JVCaB8PUySFHd14j1vS1lF4FXSXGQLuMV3ebL0DfNL41EQbmpYysQy4QIoMJzuIq6Uvw1v
 k/kiIUTSZVWsN+uk/uGh9Y0ajN6kgenxmIqvWF39iFrxgXjwO1Rq1mepCnZk9+e+TxF8CA
 p6TM/+Xb1p9The5eWAKaovuDvvp/kW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Rs8RB7I0NWGNmDYslHtbBQ-1; Fri, 21 Mar 2025 05:31:58 -0400
X-MC-Unique: Rs8RB7I0NWGNmDYslHtbBQ-1
X-Mimecast-MFC-AGG-ID: Rs8RB7I0NWGNmDYslHtbBQ_1742549518
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913d8d7c3eso927949f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 02:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742549517; x=1743154317;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BESk/McuKINamU0JmL248xDhh8Bu7Mzrr9eqdei3/jk=;
 b=coCTFaPb8D6OiDbV5vqofC8aQ/6GCN3Eu5zzaaBHqcPLJ6e2NzA7kTvjxzEvKH/MSp
 Km92mW/aE/nsvCPOYVVakn0xxMvrhe6klbPugDKfOPOLKX/Jyjmcj5qUKOSmLIlTyvX+
 e14G0cbYY9hby8DV+7E5T/RUQX8yI9LvrwpHrbYSG8Ej+ljBLZbykMq0L1KD8Cys3UeO
 Hkr5ZDCKpHZg74IdA1MIxZRMm1lVJWD/j1qQ2zsdDqOc0jwsFjJ5/gHVzfIEzps53kP+
 BtlM3p5R6U6W56fV6F1hxtO/N/FQcaqxs1SHSxVcja90z3M+X8tCLjsVqzaTNUjdGT8W
 JZsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoT/BabLLbK5bBPKNbSWb2FQiKgBTpq6ZuSK04tnDRGCPNqcE7PDm3w+lgKqe/hoj2PdlaZHa4OmBV@nongnu.org
X-Gm-Message-State: AOJu0Yz/X6WFrhGz9uXoCeQsUfRrDCUh+m7s42AU9Jx9+Y7s7emjLJ5a
 toZ/LS1vFETFJoba0kLlS2lXDJ9BNBDVrfrFUjr6qkl/yEiCpOxFSKXFZoHJgYLkEj39EmH4bV1
 ieWQdk09yzXyy3/rBitDYHVib3lMZYwoQXWYhMV0X17/8S+fdquO+
X-Gm-Gg: ASbGncuIhqVtmkWY/XaaY9HdG7JrdHM1qmDLrn+yaZyx2HlSE/OiUuMDzocKix/mYHq
 +yUr+Fa2dB/tXkFyFBWsAPrFSqmsHv2BHNrpDucxAyKAcIOeLAjIa5VWBrv3cpzPsilaFSaMlXn
 22KdK7J/wypiGpiK1qJlTbnqSgMn0inWTFhith8LL9gxEdNrETkJwIt7fGpaDO4Bj3KrIwyGg5I
 DWvK/6ygex+Iv9PwcUZy8Wi5IYBtBBQtpnwyqtE0yUJ02+Pcy9ptPucYBOtCTsfcILwX5PrGqfs
 PK1jirvNL/kqI+Dqw0+j/zqWng1Q2cvLt8/jBx0WU5I0JZqpk0y1JQ==
X-Received: by 2002:a05:6000:1fa5:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-3997f937d1fmr2747579f8f.38.1742549517488; 
 Fri, 21 Mar 2025 02:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI3VZD9Y3URrbW1pJfxMh+LafMhQM8qm39FWcpahgO/uzrbFW1C5Vxz38v1ijPQNJkIHzQRg==
X-Received: by 2002:a05:6000:1fa5:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-3997f937d1fmr2747546f8f.38.1742549517053; 
 Fri, 21 Mar 2025 02:31:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3a10sm1843650f8f.28.2025.03.21.02.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 02:31:56 -0700 (PDT)
Message-ID: <92f58be0-1ebe-417d-9921-5749d0eb9f10@redhat.com>
Date: Fri, 21 Mar 2025 10:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-25-clg@redhat.com>
 <SJ0PR11MB6744B94364FA17801C4C451592D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB6744B94364FA17801C4C451592D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On 3/20/25 10:52, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty tracking
>> definitions and declarations
>>
>> File "common.c" has been emptied of most of its definitions by the
>> previous changes and the only definitions left are related to dirty
>> tracking. Rename it to "dirty-tracking.c" and introduce its associated
>> "dirty-tracking.h" header file for the declarations.
>>
>> Cleanup a little the includes while at it.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> hw/vfio/dirty-tracking.h               | 22 ++++++++++++++++++++++
>> include/hw/vfio/vfio-common.h          | 10 ----------
>> hw/vfio/container.c                    |  1 +
>> hw/vfio/{common.c => dirty-tracking.c} |  5 +----
>> hw/vfio/iommufd.c                      |  1 +
>> hw/vfio/meson.build                    |  2 +-
>> hw/vfio/trace-events                   |  2 +-
>> 7 files changed, 27 insertions(+), 16 deletions(-)
>> create mode 100644 hw/vfio/dirty-tracking.h
>> rename hw/vfio/{common.c => dirty-tracking.c} (99%)
>>
>> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..4b83dc54ab50dabfff040d7cc3
>> db27b80bfe2d3a
>> --- /dev/null
>> +++ b/hw/vfio/dirty-tracking.h
>> @@ -0,0 +1,22 @@
>> +/*
>> + * VFIO dirty page tracking routines
>> + *
>> + * Copyright Red Hat, Inc. 2025
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_VFIO_DIRTY_TRACKING_H
>> +#define HW_VFIO_DIRTY_TRACKING_H
>> +
>> +extern const MemoryListener vfio_memory_listener;
>> +
>> +bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase
>> *bcontainer);
>> +bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>> *bcontainer);
>> +int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> +                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
>> +                                    Error **errp);
>> +int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>> +                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>> +
>> +#endif /* HW_VFIO_DIRTY_TRACKING_H */
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index
>> 184a422916f62259158e8759efc473a5efb2b2f7..cc20110d9de8ac173b67e6e878
>> d4d61818497426 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -130,7 +130,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
>>
>> typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>> extern VFIODeviceList vfio_device_list;
>> -extern const MemoryListener vfio_memory_listener;
>>
>> #ifdef CONFIG_LINUX
>> int vfio_get_region_info(VFIODevice *vbasedev, int index,
>> @@ -140,15 +139,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev,
>> uint32_t type,
>> bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
>> #endif
>>
>> -bool vfio_devices_all_dirty_tracking_started(
>> -    const VFIOContainerBase *bcontainer);
>> -bool
>> -vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> -                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>> -                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>> -
>> /* Returns 0 on success, or a negative errno. */
>> bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index
>> 4e41a7476549a0c5e464e499d059db5aca6e3470..e88dfe12edd6dee469c06ee2e
>> 46ab9c8b5019ae7 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -35,6 +35,7 @@
>> #include "hw/vfio/vfio-container.h"
>> #include "helpers.h"
>> #include "cpr.h"
>> +#include "dirty-tracking.h"
>>
>> #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO
>> TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/dirty-tracking.c
>> similarity index 99%
>> rename from hw/vfio/common.c
>> rename to hw/vfio/dirty-tracking.c
>> index
>> ed2f2ed8839caaf40fabb0cbbcaa1df2c5b70d67..441f9d9a08c06a88dda44ef143d
>> cee5f0a89a900 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/dirty-tracking.c
>> @@ -20,14 +20,10 @@
>>
>> #include "qemu/osdep.h"
>> #include <sys/ioctl.h>
>> -#ifdef CONFIG_KVM
>> -#include <linux/kvm.h>
>> -#endif
> 
> It looks this change unrelated to this patch?
> 
>> #include <linux/vfio.h>
>>
>> #include "hw/vfio/vfio-common.h"
>> #include "hw/vfio/pci.h"
>> -#include "exec/address-spaces.h"
> 
> Same here.

yes and no. Commit log says :

   Cleanup a little the includes while at it.

but if you prefer we can address the include proliferation in a patch
of its own ?


Thanks,

C.



