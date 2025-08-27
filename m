Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C01BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEF5-0002fT-NY; Wed, 27 Aug 2025 07:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEF1-0002eB-Km
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEEw-00021d-Te
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756293769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2Fxf9peX814PA2XMUdhS+SfmogWaIyKfIi+lCgGA3I=;
 b=abpMe+bPiez5VQw0agJCxwKOhSFrEzwH6oOBvLfOZtzj9ZQPL7tbeS2YL1qQlvX7xRZD0E
 7Yot39wwRe+KEvpufSUkyFUkSJEQWZYizgzbu63aRNfz34Tb8edLZqrHC6GgRT/U9qQ4gD
 R6XkloNje8p7hnZbUHCIzQzMB6v24DI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-xYkXAbqzN-6qiq9KNMzEOg-1; Wed, 27 Aug 2025 07:22:47 -0400
X-MC-Unique: xYkXAbqzN-6qiq9KNMzEOg-1
X-Mimecast-MFC-AGG-ID: xYkXAbqzN-6qiq9KNMzEOg_1756293766
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b51411839so34322665e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 04:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756293766; x=1756898566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2Fxf9peX814PA2XMUdhS+SfmogWaIyKfIi+lCgGA3I=;
 b=SnfAk8X9cob6x6a4TsJhIX4nT30y8vwonMkt4duYz72R80zhWFJFjio4X/UyJWJLeN
 W6Tck3vo5dhOiPQHHQgZKIPYjPBGombo1hAcELuI3vKVIjVmTJmnEmnWaszCneENBGox
 z+A0OPUcFQBfPYne8I5T+9joFk447W48SwRT/0V5n43LMZZIbG7dvOxXCrDkXwcNhlNF
 WwnjFaZXpmdFHi7aJWl+61o8Kif1C/6eM3GlN1WT5TvaT1GaXR572KiXB3KR/iOzIlKF
 IbbtRxhHkSJz13UilAB6ZUz6NbyuYglcVY5TWUOQlMtnIhIGZuzIL8vPdZqW6j6z4/Og
 pxFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr7DAaoCOjvVs03B7gwr9ZjEAdHdyY2L41qpTIG0yf76JJcKe09mnKtqadS69bQGXE2h1FG0ALWuM9@nongnu.org
X-Gm-Message-State: AOJu0YzqlHFPbwudgz0SCS38J4zkZcPUWZtQgTp0TO5IRXlRWnznGP3R
 +2VIn+8PcNHN3ZUFiFNvB0OmEdjhgCBrOuft8eS0OaDMqYmUfmCz7f0gqka9q/u6/IcDR6ZMMld
 IncNsB4OvGD/iX/7BDLUEyBZXd0WwTmnRn+HzdBCKfKdSb8Ol2P5aRmo8
X-Gm-Gg: ASbGncurEfmZAGtWXEZaDjhDEeoakvg0OOxR3l1HZN9lBw4M14GLgKmVKrOpgRZrRSu
 EipPQ3ycyANdem+TNXunpkAh262x9r7uUs5HYZjQtuA0Tb4vCyk9IshzAzba4rWxjeKJAAzKY4S
 DftVM3RS0YJZyBXULLAcXzIUkMZdAJdTWJl40jthHQCU/+5XgbVEVfNTWv0NGZLY92ppbh/J2uL
 RcW/M6HTIDiIoFz/aB4S89LyEcWYKkUlFTyimK9wYAVuqpJk/q+cIZz7KjH0nAccWSZ23GGyGce
 c0GfSEvVACt+LIhJRiROI5XX6EN47h4Q8DZLAnzNtgAyNmCVftHWzt0awPEI0D1xPnrhixHZYJN
 9ycZ6D0Sso5k=
X-Received: by 2002:a05:600c:1f12:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-45b72e0ed54mr13995595e9.11.1756293765943; 
 Wed, 27 Aug 2025 04:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPMc61SwOcNpUuSbttPlCICVpVHenRqFp/kHlLPxcW03nRWtY2t8ZRA410zqTbjBGsMkT4uw==
X-Received: by 2002:a05:600c:1f12:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-45b72e0ed54mr13995345e9.11.1756293765494; 
 Wed, 27 Aug 2025 04:22:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b69b7529asm23230415e9.0.2025.08.27.04.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 04:22:44 -0700 (PDT)
Message-ID: <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
Date: Wed, 27 Aug 2025 13:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On 8/27/25 1:13 PM, Yi Liu wrote:
> On 2025/8/22 14:40, Zhenzhong Duan wrote:
>> Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
>> allows to retrieve capabilities exposed by a vIOMMU. The first planned
>> vIOMMU device capability is VIOMMU_CAP_HW_NESTED that advertises the
>> support of HW nested stage translation scheme. pci_device_get_viommu_cap
>> is a wrapper that can be called on a PCI device potentially protected by
>> a vIOMMU.
>>
>> get_viommu_cap() is designed to return 64bit bitmap of purely emulated
>> capabilities which are only determined by user's configuration, no host
>> capabilities involved. Reasons are:
>>
>> 1. host may has heterogeneous IOMMUs, each with different capabilities
>> 2. this is migration friendly, return value is consistent between source
>>     and target.
>> 3. host IOMMU capabilities are passed to vIOMMU through
>> set_iommu_device()
>>     interface which have to be after attach_device(), when
>> get_viommu_cap()
>>     is called in attach_device(), there is no way for vIOMMU to get host
>>     IOMMU capabilities yet, so only emulated capabilities can be
>> returned.
>>     See below sequence:
>>
>>       vfio_device_attach():
>>           iommufd_cdev_attach():
>>               pci_device_get_viommu_cap() for HW nesting cap
>>               create a nesting parent hwpt
>>               attach device to the hwpt
>>               vfio_device_hiod_create_and_realize() creating hiod
>>       ...
>>       pci_device_set_iommu_device(hiod)
>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   MAINTAINERS          |  1 +
>>   include/hw/iommu.h   | 19 +++++++++++++++++++
>>   include/hw/pci/pci.h | 25 +++++++++++++++++++++++++
>>   hw/pci/pci.c         | 11 +++++++++++
>>   4 files changed, 56 insertions(+)
>>   create mode 100644 include/hw/iommu.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a07086ed76..54fb878128 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2305,6 +2305,7 @@ F: include/system/iommufd.h
>>   F: backends/host_iommu_device.c
>>   F: include/system/host_iommu_device.h
>>   F: include/qemu/chardev_open.h
>> +F: include/hw/iommu.h
>>   F: util/chardev_open.c
>>   F: docs/devel/vfio-iommufd.rst
>>   diff --git a/include/hw/iommu.h b/include/hw/iommu.h
>> new file mode 100644
>> index 0000000000..7dd0c11b16
>> --- /dev/null
>> +++ b/include/hw/iommu.h
>> @@ -0,0 +1,19 @@
>> +/*
>> + * General vIOMMU capabilities, flags, etc
>> + *
>> + * Copyright (C) 2025 Intel Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_IOMMU_H
>> +#define HW_IOMMU_H
>> +
>> +#include "qemu/bitops.h"
>> +
>> +enum {
>> +    /* hardware nested stage-1 page table support */
>> +    VIOMMU_CAP_HW_NESTED = BIT_ULL(0),
>
> This naming is a bit confusing. get_viommu_cap indicates it will return
> the viommu's capability while this naming is HW_NESTED. It's conflict
> with the commit message which claims only emulated capability will be
> returned.

it actually means the viommu has the code to handle HW nested case,
independently on the actual HW support.
maybe remove the "emulation" wording.

Otherwise we may also use the virtio has_feature naming?


>
> TBH. I'm hesitating to name it as get_viommu_cap. The scope is a little
> larger than what we want so far. So I'm wondering if it can be done in a
> more straightforward way. e.g. just a bool op named
> iommu_nested_wanted(). Just an example, maybe better naming. We can
> extend the op to be returning a u64 value in the future when we see
> another request on VFIO from vIOMMU.
personnally I am fine with the bitmask which looks more future proof.

besides,

Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Regards,
> Yi Liu
>


