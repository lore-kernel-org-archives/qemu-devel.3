Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EC6FCD0DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mIT-0008Hx-5H; Wed, 18 Mar 2026 04:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2mIQ-0008HR-4v
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2mIM-0008UC-Ch
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sUyjVWNjK5xD/pgsjqtucUhg3T5SdXP97zMCxzAN68M=;
 b=EBHnjAseHzMOTlhpR2M3Hsb0zaqm2mVJ5sq4JNM45yhwIK12gaH+wEjo7cwGsSxfmb8QCo
 V7HpZ+ykcoH0YicbUD1//5BOWZyC56bV9K5IVP2Bmu+k1JyUplirqmK4qonWBNLSZb1Oem
 syNOr+9lxtdkZH2Ib+Fc6yFWmm+7xow=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-9aExbs9GMMiscHE5Cly4tA-1; Wed, 18 Mar 2026 04:30:22 -0400
X-MC-Unique: 9aExbs9GMMiscHE5Cly4tA-1
X-Mimecast-MFC-AGG-ID: 9aExbs9GMMiscHE5Cly4tA_1773822621
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4852d27f473so34898725e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822621; x=1774427421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sUyjVWNjK5xD/pgsjqtucUhg3T5SdXP97zMCxzAN68M=;
 b=DJ0o3o8AH68QDc9yEiit5DwBwsQQR18dktJmRHDtNwwjohpTcJrWRcFWr6X0l4S82J
 xmjEv2+A07PHsldbxR1ByKq/oLThFczeFWnzCFHxnHqInVVRkBYQBHoyhKXkabx/Vddw
 EzUuganhfSGCyMJ+3CGvBTk4C1BcTSWHGdOBVPY8Qo/8fzxyvhuBnan5b0PL8YFg06am
 ywcGeKOmfTaQx2dyRFbpP4KvUUsgDrxbN5C8BEZkchLyH3pIy7wjhYdFeSVDmJMM5Bf1
 WENE1+sLG0XKWOTFHKmUYJe2shfa3c7KmNdJ7SiApm4CpFrpFWHJuB4f94KI6yz/Y+86
 Jkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822621; x=1774427421;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUyjVWNjK5xD/pgsjqtucUhg3T5SdXP97zMCxzAN68M=;
 b=NmW8ccdbHIaGsJ6Rwdou0N2E9y4ryouMgYimYuMKQpenC27Z+noBqpayJhtiFasbN6
 bGNdWA13tc8PwTT2W5HczrmQhKaUNBjSX/CT3VagZ23QHmDkFI9QXM62igvraTDuEhI6
 PluMBqp5WqAdeemZwdta3LBs5OfKWhfrzxF/IqV8oC/G7dN14YRGNx+B5dDm4KZd0JuG
 zKxkb8pvxOUEB/FqfCDTgNByGnPEiHtDOu8q2bCsVkveOJAZYo6oeCWgRmoEO69CvxvH
 AMrnqpCvT74s3Zae1Hj+8J1RMWt7C2fzkuG4+BgRh475tXa2/NqJFT52JY5MfFUlIdIK
 GpFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwmtxXdtaPjL6+SaTxzJsmVmftM2KygQ8n6/+yF8eH7SOJjN3a/qmJMUte8v4yjHtPTjllDTf+NKe2@nongnu.org
X-Gm-Message-State: AOJu0YyylOLjKpWzoOWMmwC0cvmsUKw+1F7txBxplKi8za8AbRpjjxpY
 yqMysL/cu/m8uaAVaJyQQteVCpcCGu00HYCgSKB1qhntX0JYnHCSdN35bgbytt+RZErKfj41cY1
 preg5It5QVtT2gjtHxd/gYNvbSfC9e+l0dRHciJlx7jZQtv/Cyy/9U36d
X-Gm-Gg: ATEYQzwH5TycQmhFTE2TNR9vd/+dsuI7fb0d647bkEs1CKskClQ1bjmieKkDc0S6EIy
 pr2bdLAIgP7H2h2G96oC5aAjN5jLxb05THWSB38003SreJUAjyOJln4YpybEqKRY7aU48wx0TPQ
 6sSHERhy+v8dBQl6Hd6+pVKPXGm1atMsZjXXjKCGg6WF+lWT9rfmtlA8aeo2K2DKDAAItBE/osq
 lEIdKIMpnEyhziRvReijo5lt4y4iKfBFzpbx43cH3ZlG8pVVaw8WqF8OabjnWDszeEYMTpVGX1R
 j0xJfoK6DVym2smVI2f9reeoTRG/085eJyEiwpYld0qhmmB2nO83izLp2SiAAwup5YVPUJQrNzD
 HNMwyzitd5Wfm0wAsAbAoTYdGnt5sS1Jpg35bBKWgeUFgIBXKJ70cuM/1OUvk
X-Received: by 2002:a05:600c:8b85:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-486f41ffff7mr40939035e9.0.1773822621167; 
 Wed, 18 Mar 2026 01:30:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8b85:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-486f41ffff7mr40938445e9.0.1773822620503; 
 Wed, 18 Mar 2026 01:30:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4bc96c6sm21312115e9.5.2026.03.18.01.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 01:30:20 -0700 (PDT)
Message-ID: <9f1aafb3-b731-40fe-86da-70cb594b4f7b@redhat.com>
Date: Wed, 18 Mar 2026 09:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce
 to hw/vfio/kvm-spapr.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <20260317194241.869568-8-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260317194241.869568-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/17/26 20:42, Pierrick Bouvier wrote:
> Since this function needs kvm specific types, we need to extract in
> another file and link it only for KVM builds.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/kvm-spapr.h | 12 ++++++++++++
>   hw/vfio/kvm-spapr.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-stubs.c |  8 ++++++++
>   hw/vfio/spapr.c     | 30 ++++-------------------------

Next step (or prereq step I wonder) would be to move all the pseries
stuff under hw/ppc/spapr_pci_vfio.c.

I will take a look.

C.



>   hw/vfio/meson.build |  1 +
>   5 files changed, 72 insertions(+), 26 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/kvm-spapr.c
> 
> diff --git a/hw/vfio/kvm-spapr.h b/hw/vfio/kvm-spapr.h
> new file mode 100644
> index 00000000000..b1f68c686a7
> --- /dev/null
> +++ b/hw/vfio/kvm-spapr.h
> @@ -0,0 +1,12 @@
> +/*
> + * VFIO sPAPR KVM specific functions
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hw/vfio/vfio-container.h"
> +#include "qapi/error.h"
> +
> +bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section,
> +                               Error **errp);
> diff --git a/hw/vfio/kvm-spapr.c b/hw/vfio/kvm-spapr.c
> new file mode 100644
> index 00000000000..ad71c5a85e2
> --- /dev/null
> +++ b/hw/vfio/kvm-spapr.c
> @@ -0,0 +1,47 @@
> +/*
> + * VFIO sPAPR KVM specific functions
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include <linux/kvm.h>
> +
> +#include "hw/vfio/vfio-container-legacy.h"
> +#include "hw/vfio/kvm-spapr.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "vfio-helpers.h"
> +
> +bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section,
> +                               Error **errp)
> +{
> +    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
> +    VFIOGroup *group;
> +    IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> +    struct kvm_vfio_spapr_tce param;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_DEV_VFIO_GROUP,
> +        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> +        .addr = (uint64_t)(unsigned long)&param,
> +    };
> +
> +    if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> +                &param.tablefd)) {
> +        QLIST_FOREACH(group, &container->group_list, container_next) {
> +            param.groupfd = group->fd;
> +            if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +                error_setg_errno(errp, errno,
> +                        "vfio: failed GROUP_SET_SPAPR_TCE for "
> +                        "KVM VFIO device %d and group fd %d",
> +                        param.tablefd, param.groupfd);
> +                return false;
> +            }
> +            trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> +        }
> +    }
> +    return true;
> +}
> diff --git a/hw/vfio/kvm-stubs.c b/hw/vfio/kvm-stubs.c
> index 5a489d1b711..78c51b99155 100644
> --- a/hw/vfio/kvm-stubs.c
> +++ b/hw/vfio/kvm-stubs.c
> @@ -6,6 +6,7 @@
>   
>   #include "qemu/osdep.h"
>   
> +#include "hw/vfio/kvm-spapr.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "qapi/error.h"
>   #include "vfio-helpers.h"
> @@ -24,3 +25,10 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>   {
>       return 0;
>   }
> +
> +bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section,
> +                               Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index a9f093c3570..42690e4323d 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -16,6 +16,7 @@
>   #include "system/address-spaces.h"
>   
>   #include "hw/vfio/vfio-container-legacy.h"
> +#include "hw/vfio/kvm-spapr.h"
>   #include "hw/core/hw-error.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> @@ -406,33 +407,10 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
>       vfio_host_win_add(scontainer, section->offset_within_address_space,
>                         section->offset_within_address_space +
>                         int128_get64(section->size) - 1, pgsize);
> -#ifdef CONFIG_KVM
> -    if (kvm_enabled()) {
> -        VFIOGroup *group;
> -        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -        struct kvm_vfio_spapr_tce param;
> -        struct kvm_device_attr attr = {
> -            .group = KVM_DEV_VFIO_GROUP,
> -            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> -            .addr = (uint64_t)(unsigned long)&param,
> -        };
> -
> -        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> -                                          &param.tablefd)) {
> -            QLIST_FOREACH(group, &container->group_list, container_next) {
> -                param.groupfd = group->fd;
> -                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -                    error_setg_errno(errp, errno,
> -                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
> -                                     "KVM VFIO device %d and group fd %d",
> -                                     param.tablefd, param.groupfd);
> -                    return false;
> -                }
> -                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> -            }
> -        }
> +    if (kvm_enabled() && !vfio_spapr_kvm_attach_tce(bcontainer, section, errp)) {
> +        return false;
>       }
> -#endif
> +
>       return true;
>   }
>   
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 6c00a7f51bb..bab5f2b7f15 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -10,6 +10,7 @@ vfio_ss.add(files(
>   vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'))
>   stub_ss.add(files('kvm-stubs.c'))
>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
> +vfio_ss.add(when: ['CONFIG_KVM', 'CONFIG_PSERIES'], if_true: files('kvm-spapr.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'pci-quirks.c',
>     'pci.c',


