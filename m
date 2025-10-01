Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27875CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zeD-0001kx-QA; Wed, 01 Oct 2025 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3ze8-0001kG-KG
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3ze2-0006Ce-7g
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759335929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=451ofA1mqmEEQNSKFV2BxE045rqyo3qnKF1sK4cAmVA=;
 b=bgQL+XYmjQLFL60Ixod/Dnpla67L1UyojB34RnfigDTavhoHzm8MWVF52aM9WS653zcUe2
 aNBVMlO+PsHGl7f6JzUjzltQvXdVkvLg0APFVMPq+oNetnvqYIvcofvh+odB/RTnBIEe/r
 RGfXlT1MPl/NiqTOmkr3eDClIwXxl5c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-EdOEpgL_OP2GitXiNQz9Qw-1; Wed, 01 Oct 2025 12:25:27 -0400
X-MC-Unique: EdOEpgL_OP2GitXiNQz9Qw-1
X-Mimecast-MFC-AGG-ID: EdOEpgL_OP2GitXiNQz9Qw_1759335926
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42558f501adso414f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759335926; x=1759940726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=451ofA1mqmEEQNSKFV2BxE045rqyo3qnKF1sK4cAmVA=;
 b=qIyswn1mIlK6yTY8KFgat5ajpFH9J5BWISX0UbX93X2g9vi/9J4nZIlzyL1Yctf3+E
 FkunViy6Zf9Hn3C28koUx0RTJwk+iDwBbKfBNe/GgP9cMD73iod+BmvQYUTxMKyUaZaY
 b3BAPxi7DyEUDkxixZrZad4rkNyyZ3NfYNqWR+DL0jNWziarCG/GOTy94SBQonQSfAUR
 kwiTG4wx16pLGvAQdJT0aMSaghWUhNFgbNr2akaz/R8T9Y+i7QMIkoNKL4ReCKbdVroK
 5p+TlVWPDxhQplOs/EINowNRClpsmZsisGlX7JCo/GlevxjVnJSnH/F4QLgidPQRiS87
 7r9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSVr394jY8JBBrrt3kthzVwqbwWEdZSF/afzEAs3NleXIs5zCHwz40T1tHvO5WHoYDr1qC0OgKCS1n@nongnu.org
X-Gm-Message-State: AOJu0Yzqv/f3PQ/drz/mmzpiQQ/4SpnxkTfKkZWQkiva389ikOf4XnTF
 f4CpPpk8W8wNG/8tfBsYCF2gxu//N6ksySbFZYnVApViuBEtOUS2BpZFCBmCWS9KQKq5SdUoRij
 o98W/skCZwHC7Q7IGV6BqI5G8moxDUP2oSwHJVSGw8tWJzDv6VZ+bN0fgyCfWRVQQ
X-Gm-Gg: ASbGncuOGhVOoaCQOW8jYIZYOFIFU3Ckj0QZhwyprKYVFXaHJoSkSg0drWegEQ10Api
 wzhjPPmMqpcixJx9myHqiAegHdq+X7C3EWnuOhwbsnZb8j1MR9rRzvEdT6JethQBbVXQPY2uQ7t
 n/R/8u8Idc2IjqBs7OUVG/7hbbOZwQ9VcJrbslAAxaoIqBhEwzrnTNBJW2rajyE6hA2VNTfb04F
 iBjW0Zeg3XaGsUWiwSUAL00rySZPf5xrHxMEnvihYLkGDTt/zQWp9ieHW7tvKcHVi5LgwGpnsWq
 DYxrXXXBhpMcnQG1ywuqzYTqwvZfbMOUKLJ15faeIjrzIMMpl5SvApVPOVPEtUseLy7uRxGOZ0B
 mW+bS3PjSx0C7Ohgf
X-Received: by 2002:a05:6000:2910:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-42557816d76mr2910248f8f.32.1759335926077; 
 Wed, 01 Oct 2025 09:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1rr+ZoKLEqTdSuKl3u6YTjvdJwXC3VPBvwBaYlIe1OUEzXQHWRTE7Jf3VrpxW5o6gyPNnwA==
X-Received: by 2002:a05:6000:2910:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-42557816d76mr2910226f8f.32.1759335925600; 
 Wed, 01 Oct 2025 09:25:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72facf9sm28472904f8f.13.2025.10.01.09.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 09:25:25 -0700 (PDT)
Message-ID: <b36b05e2-3453-4655-b060-7259624feb08@redhat.com>
Date: Wed, 1 Oct 2025 18:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/27] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-6-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Shameer,

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
> different callback handling in upcoming patches. This also adds a
> CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
> at compile time. Because we now include CONFIG_DEVICES in the header to
> check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs to
> be changed as well.
>
> The “accel” property isn’t user visible yet, it will be introduced in
> a later patch once all the supporting pieces are ready.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/Kconfig          |  5 ++++
>  hw/arm/meson.build      |  3 ++-
>  hw/arm/smmuv3-accel.c   | 52 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++++
>  hw/arm/smmuv3.c         |  5 ++++
>  include/hw/arm/smmuv3.h |  3 +++
>  6 files changed, 94 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/smmuv3-accel.c
>  create mode 100644 hw/arm/smmuv3-accel.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3baa6c6c74..157c0f3517 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -12,6 +12,7 @@ config ARM_VIRT
>      select ARM_GIC
>      select ACPI
>      select ARM_SMMUV3
> +    select ARM_SMMUV3_ACCEL
>      select GPIO_KEY
>      select DEVICE_TREE
>      select FW_CFG_DMA
> @@ -625,6 +626,10 @@ config FSL_IMX8MP_EVK
>  config ARM_SMMUV3
>      bool
>  
> +config ARM_SMMUV3_ACCEL
> +    bool
> +    depends on ARM_SMMUV3 && IOMMUFD
> +
>  config FSL_IMX6UL
>      bool
>      default y
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index dc68391305..bcb27c0bf6 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -61,7 +61,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
> -arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>  arm_ss.add(when: 'CONFIG_XEN', if_true: files(
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> new file mode 100644
> index 0000000000..79f1713be6
> --- /dev/null
> +++ b/hw/arm/smmuv3-accel.c
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
> + * Copyright (C) 2025 NVIDIA
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/arm/smmuv3.h"
> +#include "smmuv3-accel.h"
> +
> +static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
> +                                               PCIBus *bus, int devfn)
> +{
> +    SMMUDevice *sdev = sbus->pbdev[devfn];
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (sdev) {
> +        return container_of(sdev, SMMUv3AccelDevice, sdev);
> +    }
> +
> +    accel_dev = g_new0(SMMUv3AccelDevice, 1);
> +    sdev = &accel_dev->sdev;
> +
> +    sbus->pbdev[devfn] = sdev;
> +    smmu_init_sdev(bs, sdev, bus, devfn);
> +    return accel_dev;
> +}
> +
> +static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
> +                                              int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    return &sdev->as;
> +}
> +
> +static const PCIIOMMUOps smmuv3_accel_ops = {
> +    .get_address_space = smmuv3_accel_find_add_as,
> +};
> +
> +void smmuv3_accel_init(SMMUv3State *s)
> +{
> +    SMMUState *bs = ARM_SMMU(s);
> +
> +    bs->iommu_ops = &smmuv3_accel_ops;
> +}
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> new file mode 100644
> index 0000000000..70da16960f
> --- /dev/null
> +++ b/hw/arm/smmuv3-accel.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
> + * Copyright (C) 2025 NVIDIA
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_SMMUV3_ACCEL_H
> +#define HW_ARM_SMMUV3_ACCEL_H
> +
> +#include "hw/arm/smmu-common.h"
> +#include CONFIG_DEVICES
> +
> +typedef struct SMMUv3AccelDevice {
> +    SMMUDevice  sdev;
> +} SMMUv3AccelDevice;
> +
> +#ifdef CONFIG_ARM_SMMUV3_ACCEL
> +void smmuv3_accel_init(SMMUv3State *s);
> +#else
> +static inline void smmuv3_accel_init(SMMUv3State *s)
> +{
> +}
> +#endif
> +
> +#endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index bcf8af8dc7..ef991cb7d8 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -32,6 +32,7 @@
>  #include "qapi/error.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "smmuv3-accel.h"
>  #include "smmuv3-internal.h"
>  #include "smmu-internal.h"
>  
> @@ -1882,6 +1883,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
>      Error *local_err = NULL;
>  
> +    if (s->accel) {
> +        smmuv3_accel_init(s);
> +    }
> +
>      c->parent_realize(d, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..bb7076286b 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,9 @@ struct SMMUv3State {
>      qemu_irq     irq[4];
>      QemuMutex mutex;
>      char *stage;
> +
> +    /* SMMU has HW accelerator support for nested S1 + s2 */
> +    bool accel;
>  };
>  
>  typedef enum {


