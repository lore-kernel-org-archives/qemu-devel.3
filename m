Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7703FD41C31
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 12:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTgCJ-0003dX-TS; Thu, 11 Dec 2025 07:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTgCF-0003cs-Cn
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 07:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTgCD-0000y9-9b
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 07:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765457699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Pi4KufqSyWa0n+yuGz31t0Bv5IpW6NETI6204wJhig=;
 b=X79Q5Qffo74vo934NMXTHxL22UKlsysRGVRBdqy+qW+hrvHz64SByMuaGYeS8kdig+/B9h
 x0B4xJ0UkLUmQLAb5rkt9V3vwBPrPkT7rgnLcF4xn7ft1hkyptC77vLdcQISby85wITXwq
 qeiAhyhVwxUsXPgT3A7wy/JVh8mMttk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-IOLDxaduOVKtFUT0OtI9_A-1; Thu, 11 Dec 2025 07:54:58 -0500
X-MC-Unique: IOLDxaduOVKtFUT0OtI9_A-1
X-Mimecast-MFC-AGG-ID: IOLDxaduOVKtFUT0OtI9_A_1765457697
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b478551a6so35771f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 04:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765457697; x=1766062497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0Pi4KufqSyWa0n+yuGz31t0Bv5IpW6NETI6204wJhig=;
 b=sV6gpmtdY9jQKFlTEoDzbA0bqQmR5NppPz7BnhwueoZRzDVwOLbBuXQLUEgpUOYP5Q
 m3yowNzppU6m5J6zQbtfr1gNxwkHkzrHcwMnRZ1CZuvBDcqeqWIrAmY74ihDqM3Y/rf4
 VXu+Wdxt3TXIk9be6P8chNYsr9uVOgGAgJImbrpJHjSKE2w18DDki0/x/1uGkY3dtirV
 qEKT3OJI5TGnPC37vcZooG3S8pS1GB4JGToL3JHEmd/TGgTegIaOZk/D7B0WUa3+BOe/
 +Ex8rkgp6Iwv00ETtzPFfGKX+FPa87fd/euTpskP2sPqOk/wyPgGJD1A+No04rSbp/85
 VCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765457697; x=1766062497;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Pi4KufqSyWa0n+yuGz31t0Bv5IpW6NETI6204wJhig=;
 b=YmOBjO8XLoOz5BByTp3cbCi7165uF6m66mGE8os7tZY5cLMty6GUOLaulWk9S7Kpse
 9Op64Iglp5JY1HaQNTFUua5MgQQA8TWyA8gnagStJgnmvS4SyZY0y0OWZn7i9h/rT6Zs
 j8lYKEe2qzF3dXoNfBC5jfq5bbr3i/qgJ75J5TFhStMqZ05rczhi0SjA/TfzM2fAA5YI
 OuwllDo4iqAeIOBegCzGSbbmgOdeJEFEeMtU4ubjwCaFjXhD+kw5UEqVDpo4GCaSqE5U
 8VXYl/idKTx/GHsg6zcM8UUi7QSSF86K+WsxrTr0/pQIBuCvIXANdAoiY+18WnVb1Ubb
 L+Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy241qR8U3f2BXk0HST2t0FQqP9EUmtbHWxZN/ViW2MzyMBz1tdRs0/rGqen83kIKJTyA47uEPCFWv@nongnu.org
X-Gm-Message-State: AOJu0YwIyVR1oNnuBNaq8PZ9oFffevkhAUm3eSOLq49NTE5H2oA8qOFc
 GjTMDTDpkdrHHPC4/dnosxFLbgOycZfecZo53KBsZNJzNHHk1crEw42nUePT3a52u3fD879wGJQ
 9dWOdP3tnK+qzp4+K/OmtRlBjZiWbTZpCoo2BmiajQI/znIPuq8zf3Orm
X-Gm-Gg: AY/fxX7a1K3pFU3yS3Uuy2Fi7SxI+sqm42mIT9OebNwz0zpRh14GGFrlfuqsPECyUS1
 rU84RiRO/pwt1wbz5zQ++Og1v8ghDsZnglNaGfS+HQo7isAnetKmHSiakCC8sg8MybNVQRVmFkE
 R/NcijEdRdzJlauOksXf0BBWxZUWrkZ7teAuLC6t4b7hlVmFaFaDz+B9EE8Wum+vkryNzHX2ipg
 HParDEXVMhg/QzPgC42Jn/ki9y/xCuDYbHBiu+A+YGdc/oVI6sgXhZqOYRqWxG6TNUUqjJ/qPFj
 3lepgfqRzWUp2JsurqMpUo2ebqSOEmd5NvCiYsk+sHgRnMCNVpatNBb5x3QGs287+BmCwaYk6bF
 i7DjBgKly7ChOzh9LoCwUPBJywjV214ICTygCvYbE+5Y8+1hw
X-Received: by 2002:a05:6000:240e:b0:42b:549d:cdfc with SMTP id
 ffacd0b85a97d-42fa3af8978mr7044185f8f.35.1765457697004; 
 Thu, 11 Dec 2025 04:54:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrVIoEBR6anjnFmNeQfBeJR4NSsE/UDiIX02c7wWN5HJIqmXcoukdHt/xkW8dXBASPcXJ8kg==
X-Received: by 2002:a05:6000:240e:b0:42b:549d:cdfc with SMTP id
 ffacd0b85a97d-42fa3af8978mr7044153f8f.35.1765457696563; 
 Thu, 11 Dec 2025 04:54:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a702a1sm6141465f8f.13.2025.12.11.04.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 04:54:56 -0800 (PST)
Message-ID: <6a062129-2b8f-420a-a4b9-87dde7574481@redhat.com>
Date: Thu, 11 Dec 2025 13:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-6-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/20/25 14:21, Shameer Kolothum wrote:
> Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
> different callback handling in upcoming patches. This also adds a
> CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
> at compile time. Because we now include CONFIG_DEVICES in the header to
> check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs to
> be changed to arm_ss.add.
> 
> The “accel” property isn’t user visible yet and it will be introduced in
> a later patch once all the supporting pieces are ready.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/arm/Kconfig          |  5 ++++
>   hw/arm/meson.build      |  3 ++-
>   hw/arm/smmuv3-accel.c   | 59 +++++++++++++++++++++++++++++++++++++++++
>   hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++
>   hw/arm/smmuv3.c         |  5 ++++
>   include/hw/arm/smmuv3.h |  3 +++
>   6 files changed, 101 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/smmuv3-accel.c
>   create mode 100644 hw/arm/smmuv3-accel.h
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 0cdeb60f1f..702b79a02b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -12,6 +12,7 @@ config ARM_VIRT
>       select ARM_GIC
>       select ACPI
>       select ARM_SMMUV3
> +    select ARM_SMMUV3_ACCEL
>       select GPIO_KEY
>       select DEVICE_TREE
>       select FW_CFG_DMA
> @@ -629,6 +630,10 @@ config FSL_IMX8MP_EVK
>   config ARM_SMMUV3
>       bool
>   
> +config ARM_SMMUV3_ACCEL
> +    bool
> +    depends on ARM_SMMUV3 && IOMMUFD
> +
>   config FSL_IMX6UL
>       bool
>       default y
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index aeaf654790..c250487e64 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -84,7 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
> -arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>   arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>   arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> new file mode 100644
> index 0000000000..99ef0db8c4
> --- /dev/null
> +++ b/hw/arm/smmuv3-accel.c
> @@ -0,0 +1,59 @@
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

oh. This is not a QOM object :/

> +    sdev = &accel_dev->sdev;
> +
> +    sbus->pbdev[devfn] = sdev;
> +    smmu_init_sdev(bs, sdev, bus, devfn);
> +    return accel_dev;
> +}
> +
> +/*
> + * Find or add an address space for the given PCI device.
> + *
> + * If a device matching @bus and @devfn already exists, return its
> + * corresponding address space. Otherwise, create a new device entry
> + * and initialize address space for it.
> + */
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

again, I think this should be a sSMMUv3Class attribute.

> +}
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> new file mode 100644
> index 0000000000..0dc6b00d35
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
> +    SMMUDevice sdev;
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
>   #include "qapi/error.h"
>   
>   #include "hw/arm/smmuv3.h"
> +#include "smmuv3-accel.h"
>   #include "smmuv3-internal.h"
>   #include "smmu-internal.h"
>   
> @@ -1882,6 +1883,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       Error *local_err = NULL;
>   
> +    if (s->accel) {
> +        smmuv3_accel_init(s);
> +    }
> +
>       c->parent_realize(d, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..bb7076286b 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,9 @@ struct SMMUv3State {
>       qemu_irq     irq[4];
>       QemuMutex mutex;
>       char *stage;
> +
> +    /* SMMU has HW accelerator support for nested S1 + s2 */
> +    bool accel;

Have you considered modeling with a QOM object instead ?

Thanks,

C.

>   };
>   
>   typedef enum {


