Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A44C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWpp-0000mg-On; Fri, 20 Jun 2025 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSWpo-0000mC-9N
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSWpm-0005o5-GF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750407049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCZyKUO5fNEAjLpiAYObv+gkZZ6++dQ4tg6bkFdMBLY=;
 b=eOHNntEkDg0aF4nh2D+QZjfg6tXT9lXwX9P1ndS+j7IgwfQ2+GVK8zNsWabPbqNaggLJ6K
 k18B7SnQHRTIpNn5d63el/767sKogDVQXO5YagA0he0OXjcidFg6vbGX6bHZFfF9nr+I4T
 emuIf2yYcD9i8M0ePDujEll+cncuF4g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-TbKVVdqlNp2aEyJHRzljdg-1; Fri, 20 Jun 2025 04:10:47 -0400
X-MC-Unique: TbKVVdqlNp2aEyJHRzljdg-1
X-Mimecast-MFC-AGG-ID: TbKVVdqlNp2aEyJHRzljdg_1750407046
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso10935285e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 01:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750407046; x=1751011846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UCZyKUO5fNEAjLpiAYObv+gkZZ6++dQ4tg6bkFdMBLY=;
 b=lzt58E1tyenNBRkhPau8FJvB9ajhA90yeXgC21CjcDjsl/4ppeMs25NKllkXPBQ5wC
 iAYB1v0ARk+oMF5NBaW78gu25qtZ+4XLnB5g5fykldsTLYa4H2522hUg9/0GVaIbMjSo
 v7MgwWroxYSATNg+x+zkyuzGB0JB0BniHsRLRRi8+HrVSvhjB762dRgzncqdEPupeEE5
 KVqE+cWvzyR+M2f2BTSRZJZlHLttkCs4+Crc8cYL6Xf7/WLT2r3v7di8ZzBFxQonFli4
 O76EmnBd0o1hQLsuAzJUl5bFw3Y2qR7vGgWjlIUcUMgEfJGKo6lkYZ1h3HqUTTq4FqV/
 mcOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvjNFSbp/09Zmr885TSsEP/N7dPIRYTSf/Wnl+UINPd9K9fwV/f9mJeryry9r9Qu6RVz2f05KxlGpb@nongnu.org
X-Gm-Message-State: AOJu0YwuHpOIU7hYI9QXDpSjq7wlIG6gQW4u0AWX8lWyi2TEottTN/4W
 D3+4pJlv1adsiENIM/ubZTaCiiBpp86g2BKn4ZD1nlUxAPbqdsSkLhXlKVkW2gBTG0h1164nfk5
 VCxDik0JE1y+f7KS+LIE9CRVgFY1NuxLYFfY8nbMDc9fdqLJRfTJhNMOo
X-Gm-Gg: ASbGncuUUsRXp9mVePQLP6T8vXFzpY1CuGRO9tgCpFnSYxShLzyAVRNlG2UI0m/v2Fg
 nscrJp+6Ej5tTbjst54WO9EaArdkFH4c/E6Ao/R5MwTVRoN+DbRnk+LzcUCUjxyg/tEhBCqeHJg
 EHt8TnAEFMfp1TmdYgVay158w5h3ZCCMw/6tlivcFdBKP91mheDL7AzXErJO6FPWldpj/VFYfQI
 fHN23COxGKC45sVXMq31FeSZtMZFrKqLn7+vGA4ThAvZyaCLuq74lrnF+7W3tIySfJrTb7rc/na
 ulMPXhpMrxgfEAouIMNjcKe2A2BCSwLxiG+F095TIYFKKpUfwD3W5t7MAs0mr7FUenoVuA==
X-Received: by 2002:a05:600c:81c8:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-453659f6a8cmr15722905e9.29.1750407045857; 
 Fri, 20 Jun 2025 01:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxu7ZFwcLIOecwGfQQU/2Yj99sf+BCWhezOO7x+Ki/MfqTXfgJfMiUXbZmhntVCy5WJEnZNg==
X-Received: by 2002:a05:600c:81c8:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-453659f6a8cmr15722505e9.29.1750407045464; 
 Fri, 20 Jun 2025 01:10:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c40dsm1387660f8f.65.2025.06.20.01.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:10:44 -0700 (PDT)
Message-ID: <2478ff00-a09d-4904-89b3-bdcebbcb7fbe@redhat.com>
Date: Fri, 20 Jun 2025 10:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] intel_iommu: Implement get_viommu_cap() callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/20/25 9:17 AM, Zhenzhong Duan wrote:
> Implement get_viommu_cap() callback and expose stage-1 capability for now.
>
> VFIO uses it to create nested parent domain which is further used to create
> nested domain in vIOMMU. All these will be implemented in following patches.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS           |  1 +
>  include/hw/iommu.h    | 14 ++++++++++++++
>  hw/i386/intel_iommu.c | 12 ++++++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 include/hw/iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94c4076127..27817974a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2277,6 +2277,7 @@ F: include/system/iommufd.h
>  F: backends/host_iommu_device.c
>  F: include/system/host_iommu_device.h
>  F: include/qemu/chardev_open.h
> +F: include/hw/iommu.h
>  F: util/chardev_open.c
>  F: docs/devel/vfio-iommufd.rst
>  
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> new file mode 100644
> index 0000000000..3c1c08f05d
> --- /dev/null
> +++ b/include/hw/iommu.h
> @@ -0,0 +1,14 @@
> +/*
> + * General vIOMMU capabilities, flags, etc
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_IOMMU_H
> +#define HW_IOMMU_H
> +
> +#define VIOMMU_CAP_STAGE1    BIT_ULL(0)
I think you shall rather introduce the header and the first enum value
in the previous patch.

Eric
> +
> +#endif /* HW_IOMMU_H */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f0b1f90eff..702973da5c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -24,6 +24,7 @@
>  #include "qemu/main-loop.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
> +#include "hw/iommu.h"
>  #include "intel_iommu_internal.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> @@ -4412,6 +4413,16 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>      vtd_iommu_unlock(s);
>  }
>  
> +static uint64_t vtd_get_viommu_cap(void *opaque)
> +{
> +    IntelIOMMUState *s = opaque;
> +    uint64_t caps;
> +
> +    caps = s->flts ? VIOMMU_CAP_STAGE1 : 0;
> +
> +    return caps;
> +}
> +
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> @@ -4734,6 +4745,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
>      .get_address_space = vtd_host_dma_iommu,
>      .set_iommu_device = vtd_dev_set_iommu_device,
>      .unset_iommu_device = vtd_dev_unset_iommu_device,
> +    .get_viommu_cap = vtd_get_viommu_cap,
>  };
>  
>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)


