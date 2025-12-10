Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B52D3C90B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKj0-00048N-Rq; Wed, 10 Dec 2025 08:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTKiz-00047x-8u
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTKix-0006E6-98
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765375162;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOkB7c3fVoenzc6wz2REUnhJnx+7kq3i3QN71mvocCY=;
 b=fUm3G68VHBilo2OG4Rv+xysoozgQfaj/cF0wQNCnD7FO4FvWpPiqFYue7Rq6eis9tIsddO
 ZyNIuxj7KJFvlQSU1GbnRxFk85Gd97m8PsXhZrF9zN/YLGhs9BLlSCoGJMmlpxa1lAEy4q
 TDjoM7WfwFTRAOoLR8erKA1nSWavuNk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-GXax0qyhPjaKO_y6onQy2w-1; Wed, 10 Dec 2025 08:59:20 -0500
X-MC-Unique: GXax0qyhPjaKO_y6onQy2w-1
X-Mimecast-MFC-AGG-ID: GXax0qyhPjaKO_y6onQy2w_1765375160
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b6ce1b57b9cso8063916a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375160; x=1765979960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOkB7c3fVoenzc6wz2REUnhJnx+7kq3i3QN71mvocCY=;
 b=HiyDRYrJvA6HHvM4F5vTwn965o46zkTryr06oyb+iosWSe/G9UVAARC9JSKBxLqyll
 BCVmOnL7mD3qbZxMx/1qLQoznPUV34C7NhBzO4VFD++Pr00j09EoW0suDJNp/Qg7VprR
 7ZWaxDyWxsZCdx2Z5WExm+oeJVsGOon0XCbYPO6xSzKeQ6UZIZjtpbQW3mzApGpG8SzS
 vGk1rM4Mbt9c9y6DZXusVpQUGfu8GtxmFRkvNbqIdBWdERkUzvXj4mX4P8tx3gZHLpGq
 qhYYgozDLBtWXuSznu6oOG5MQhOqX3zrnM4fl9xfAPOyUW/e3Xljfhjse9qzNNy7LUFH
 ulfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw6ZiGLW8jJrdeXNF4lXnXQZMkZZkaNJrOZgVVNBFA3XLwdD2UD2b4d4GoRa4Y+wbgImbb4kiEa6Y4@nongnu.org
X-Gm-Message-State: AOJu0YwNfV80Ip2B4qgkz3L+MvSX5AmXfbtlXXmNDDwHdGrLZD35Wff1
 T9AzbF1gKcwQ0MhdyhPfEBdT0WpCoKVJMxWf9QcpTXJN3PMC6NAIo6pkFK0C+xBrXMo/NP+IVJW
 z+hAvrrDtc5xpE1p1yYk4d1cuBJv0bhZ+UWQZzPvoOSKlLmrqLmEuVwF2
X-Gm-Gg: ASbGncsWFNvGcptpU0MmjxiYfVbjFubC/k/2j5dno3nH3ZtqEbHKrq8ft989yaqTAgQ
 PZq4TtIguq1WYIh3Q6HfDXbSJ3CivXK9JE8bVV+PF0HOFzvRdGGtg4WEPinT8e8epATjh032HeV
 HSj3ONUY2yg2Y8+ZdZOK+AGbJU3NPPAz3w9hd2LDnPWy8xcS2uOlLCpMx9mh9Ml8HE02Ld4v/ki
 5veUjS64F2+1oX91Ztharp2YELQG48BJJZGQKQCpipMFmIBgJQMyLegfyRaJLYmoPDgDQqgvCcG
 3I32MS0LgSv/BDJ8A1WylcRWv4lhO0Mt1UfkTRVoXVK+sRKARvzfOo9ZTvIsz86jg4w/868l4Ic
 cxfayRgQAoVtmtTSbS0EwLJ15xqWuqP7vTeAq/EbPCx0Usn+JLVOSSqTVtQ==
X-Received: by 2002:a05:7022:2484:b0:11b:99a2:9082 with SMTP id
 a92af1059eb24-11f296548a0mr1766176c88.15.1765375159591; 
 Wed, 10 Dec 2025 05:59:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWRvPlO8s0uBHVGKBqmvZ0qmCpmmSJh7Hm3hawk6VF2rMMxzLmtmI+OV1S3xHSsluHhHpjAQ==
X-Received: by 2002:a05:7022:2484:b0:11b:99a2:9082 with SMTP id
 a92af1059eb24-11f296548a0mr1766133c88.15.1765375159089; 
 Wed, 10 Dec 2025 05:59:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f283d4811sm8620499c88.11.2025.12.10.05.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 05:59:18 -0800 (PST)
Message-ID: <52074045-fe32-4fbf-b8a3-5037438649f7@redhat.com>
Date: Wed, 10 Dec 2025 14:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251117093729.1121324-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Zhenzhong,
On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, first stage page table
> is passed to host to construct nested page table for passthrough devices.
>
> We need to check compatibility of some critical IOMMU capabilities between
> vIOMMU and host IOMMU to ensure guest first stage page table could be used by
> host.
>
> For instance, vIOMMU supports first stage 1GB large page mapping, but host does
> not, then this IOMMUFD backed device should fail.
>
> Even of the checks pass, for now we willingly reject the association because
> all the bits are not there yet, it will be relaxed in the end of this series.
>
> Note vIOMMU has exposed IOMMU_HWPT_ALLOC_NEST_PARENT flag to force VFIO core to
> create nesting parent HWPT, if host doesn't support nested translation, the
> creation will fail. So no need to check nested capability here.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS                 |  1 +
>  hw/i386/intel_iommu_accel.h | 28 +++++++++++++++++++++++++
>  hw/i386/intel_iommu.c       |  5 ++---
>  hw/i386/intel_iommu_accel.c | 42 +++++++++++++++++++++++++++++++++++++
>  hw/i386/Kconfig             |  5 +++++
>  hw/i386/meson.build         |  1 +
>  6 files changed, 79 insertions(+), 3 deletions(-)
>  create mode 100644 hw/i386/intel_iommu_accel.h
>  create mode 100644 hw/i386/intel_iommu_accel.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4a30c126b..bc1d2b6261 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3929,6 +3929,7 @@ R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>  S: Supported
>  F: hw/i386/intel_iommu.c
>  F: hw/i386/intel_iommu_internal.h
> +F: hw/i386/intel_iommu_accel.*
>  F: include/hw/i386/intel_iommu.h
>  F: tests/functional/x86_64/test_intel_iommu.py
>  F: tests/qtest/intel-iommu-test.c
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> new file mode 100644
> index 0000000000..c5274e342c
> --- /dev/null
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -0,0 +1,28 @@
> +/*
> + * Intel IOMMU acceleration with nested translation
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_I386_INTEL_IOMMU_ACCEL_H
> +#define HW_I386_INTEL_IOMMU_ACCEL_H
> +#include CONFIG_DEVICES
> +
> +#ifdef CONFIG_VTD_ACCEL
> +bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +                          Error **errp);
> +#else
> +static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> +                                        HostIOMMUDevice *hiod,
> +                                        Error **errp)
> +{
> +    error_setg(errp,
> +               "host IOMMU is incompatible with guest first stage translation");
I would rather change the error msg to

host IOMMU cannot be checked!
+ append a hint through error_append_hint, 
CONFIG_VTD_ACCEL is not enabled or smthg alike

> +    return false;
> +}
> +#endif
> +#endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3095d78321..d3c8a75878 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -26,6 +26,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/iommu.h"
>  #include "intel_iommu_internal.h"
> +#include "intel_iommu_accel.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/qdev-properties.h"
> @@ -4596,9 +4597,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return true;
>      }
>  
> -    error_setg(errp,
> -               "host device is uncompatible with first stage translation");
> -    return false;
> +    return vtd_check_hiod_accel(s, hiod, errp);
>  }
>  
>  static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> new file mode 100644
> index 0000000000..6846c6ec4d
> --- /dev/null
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -0,0 +1,42 @@
> +/*
> + * Intel IOMMU acceleration with nested translation
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/iommufd.h"
> +#include "intel_iommu_internal.h"
> +#include "intel_iommu_accel.h"
> +
> +bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +                          Error **errp)
> +{
> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +
> +    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
> +        return false;
> +    }
> +
> +    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
> +        error_setg(errp, "Incompatible host platform IOMMU type %d",
> +                   caps->type);
> +        return false;
> +    }
> +
> +    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
> +        error_setg(errp,
> +                   "First stage 1GB large page is unsupported by host IOMMU");
> +        return false;
> +    }
> +
> +    error_setg(errp,
> +               "host IOMMU is incompatible with guest first stage translation");
> +    return false;
> +}
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 6a0ab54bea..12473acaa7 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -150,8 +150,13 @@ config X86_IOMMU
>  
>  config VTD
>      bool
> +    imply VTD_ACCEL
>      select X86_IOMMU
>  
> +config VTD_ACCEL
> +    bool
> +    depends on VTD && IOMMUFD
> +
>  config AMD_IOMMU
>      bool
>      select X86_IOMMU
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 436b3ce52d..63ae57baa5 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
>  i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
>  i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
>  i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
> +i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
>  i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>                                  if_false: files('sgx-stub.c'))
>  
wrt comments made by Cédric in
https://lore.kernel.org/all/IA3PR11MB9136B13C0C48EF293D3B599D92FAA@IA3PR11MB9136.namprd11.prod.outlook.com/
I see you kept the original approach. I have no strong opinion on that.
I let Cédric's comment if he strongly disagrees.

With my comment taken into account feel free to grab my

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


