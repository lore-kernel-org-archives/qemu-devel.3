Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1D4C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNvy-0006Bn-Um; Wed, 12 Mar 2025 11:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsNvw-00067Y-Fn
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsNvs-0000iE-C1
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741793020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QERvyYhYB+2oQkqCtVctitqp2mOQxeiJezvgVXmaPZE=;
 b=GUy6YGxXYCT7kQFTN89jjJirr+95Dcxn/Nddgi64r8ts1wRBbNVllPh+Is7uOMa5RZV+iX
 VHH0XGEKMx4zrUQaeYDwgdEO8HPS01htak1zNPM4bnDZgHhQpA8ZiOPVsxqD9r7eSeo/Uy
 uPYyrUzPx8+ukJljS9zQrKWr6DHb/Vs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-yV82AvrgOhu6uEjEkqdamQ-1; Wed, 12 Mar 2025 11:15:15 -0400
X-MC-Unique: yV82AvrgOhu6uEjEkqdamQ-1
X-Mimecast-MFC-AGG-ID: yV82AvrgOhu6uEjEkqdamQ_1741792515
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c53d552e52so662360785a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 08:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741792515; x=1742397315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QERvyYhYB+2oQkqCtVctitqp2mOQxeiJezvgVXmaPZE=;
 b=irGdu4JVoLLp/joFTZNimk3b5ilnVfO9/SJ7bcI+O4q1XTVJTbvcsS9rs3fFSHC9sG
 I10iLBgpfugq2ejXuuiv1SClR9msvkiH3yTBhS75mQNVP1jcG5fGkWxfKVZO98hV5/+l
 Jj6cZ0cbjiuMnbMLfd/+KYK+B4msUoF155UlOxfze+D+QSCTyI1/Uqp/Fc2i2FViLetS
 kPzBSEX6fo0jmyTybEuspgA2VahqwX6+9LT57kspcp32nGaUVxdkf6cNLVXyqSy3SVsv
 dy4gkEdjsbETtO/FuztuMeWfFggQkeyltIEUFCgyyyhjm+bPnLJTtWgjl+anA0AQmDUH
 CAaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDD68hyhtza/vRJQIMx5bl/5+q4Gih6PEQd7YJYSmGikR/vmRnIvWQsFi5aMCD0rZMmTNz7V1NIu99@nongnu.org
X-Gm-Message-State: AOJu0YyQEdttrXPpKmta+EaUFlLRvv7dq5YV1GNt/ahdWFDI3bBWSGdb
 YgVRmPy1As5TlJk3KbEJnYekkBAO1YSBa3UHFMwMVrQ/m8AJ93kIpvtjZlRFk9YYKl76ezSutpn
 SJXf4Viw0uFGvFrGdDjVgl7OKBoztbXOUpm7r2ZNNPSdTAWoDBBPk
X-Gm-Gg: ASbGncvT/pQ1XMeL/iZ3GSa1GrofAo67I0CrD1e5/9NyPRQG9kGYRjQ7gAYz7qF4gc+
 tovFYzHVO0ZK/xf6x75A1+8t72XguJxlqROVV57x9gD8W+3PuNu0xSLBXjjsGPmWgbN0qX/XcHA
 IeTQTlt7bqlGRelgnqAHqxDO6qqanTVoOhlfGpshsKKtMae1eKx2pqCSVM2aPIpMT59FQhULbq0
 7qOA45z0UF5q08YnYec6eBbQb5t0JsSsnaqE8JPEebfDWGGZtOJzQKvOuBXRNwAMzCRAYpUEW//
 ItKg6YM23m4pqrFAIfG7TZy4pyaTW1/17/lZ7Tsu8q6Y3yOQXTSLZkjYjcJCRxY=
X-Received: by 2002:a05:620a:800f:b0:7c5:4b91:6a42 with SMTP id
 af79cd13be357-7c54b9170e1mr2046540485a.17.1741792515267; 
 Wed, 12 Mar 2025 08:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHth+fEfGf4bEgVm8rQRJOodhY0Hti74CWBcs6eE/51lqVIQrMuYke3RqyhHF77K8HlioVniA==
X-Received: by 2002:a05:620a:800f:b0:7c5:4b91:6a42 with SMTP id
 af79cd13be357-7c54b9170e1mr2046532885a.17.1741792514817; 
 Wed, 12 Mar 2025 08:15:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c56453475esm216461985a.22.2025.03.12.08.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 08:15:14 -0700 (PDT)
Message-ID: <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
Date: Wed, 12 Mar 2025 16:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Shameer,


On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
> device. In order to support vfio-pci dev assignment with a Guest
guest
> SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
nested (s1+s2)
> mode, with Guest owning the S1 page tables. Subsequent patches will
the guest
> add support for smmuv3-accel to provide this.
Can't this -accel smmu also works with emulated devices? Do we want an
exclusive usage?

I would also document in the commit msg that a new property is added in
the parent SMMU (accel).
Will this device be migratable? Do we need a migration blocker?
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/Kconfig                |  5 ++++
>  hw/arm/meson.build            |  1 +
>  hw/arm/smmu-common.c          |  1 +
>  hw/arm/smmuv3-accel.c         | 51 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmu-common.h  |  3 +++
>  include/hw/arm/smmuv3-accel.h | 31 +++++++++++++++++++++
>  6 files changed, 92 insertions(+)
>  create mode 100644 hw/arm/smmuv3-accel.c
>  create mode 100644 include/hw/arm/smmuv3-accel.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 504841ccab..f889842dd8 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -14,6 +14,7 @@ config ARM_VIRT
>      select ARM_GIC
>      select ACPI
>      select ARM_SMMUV3
> +    select ARM_SMMUV3_ACCEL
>      select GPIO_KEY
>      select DEVICE_TREE
>      select FW_CFG_DMA
> @@ -596,6 +597,10 @@ config FSL_IMX7
>  config ARM_SMMUV3
>      bool
>  
> +config ARM_SMMUV3_ACCEL
> +    select ARM_SMMUV3
> +    bool
> +
>  config FSL_IMX6UL
>      bool
>      default y
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 465c757f97..e8593363b0 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -55,6 +55,7 @@ arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
>  arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>  arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
>  arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>  arm_ss.add(when: 'CONFIG_XEN', if_true: files(
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 8c1b407b82..f5caf1665c 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -943,6 +943,7 @@ static const Property smmu_dev_properties[] = {
>      DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
>      DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
>                       TYPE_PCI_BUS, PCIBus *),
> +    DEFINE_PROP_BOOL("accel", SMMUState, accel, false),
>  };
>  
>  static void smmu_base_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> new file mode 100644
> index 0000000000..c327661636
> --- /dev/null
> +++ b/hw/arm/smmuv3-accel.c
> @@ -0,0 +1,51 @@
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
> +#include "hw/arm/smmuv3-accel.h"
> +
> +static void smmu_accel_realize(DeviceState *d, Error **errp)
> +{
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(d);
> +    SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_GET_CLASS(s_accel);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(d);
> +    Error *local_err = NULL;
> +
> +    object_property_set_bool(OBJECT(dev), "accel", true, &error_abort);
you shouldn't need dev and simply use OBJECT(d)
> +    c->parent_realize(d, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
> +static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_CLASS(klass);
> +
> +    device_class_set_parent_realize(dc, smmu_accel_realize,
> +                                    &c->parent_realize);
> +    dc->hotpluggable = false;
> +}
> +
> +static const TypeInfo smmuv3_accel_type_info = {
> +    .name          = TYPE_ARM_SMMUV3_ACCEL,
> +    .parent        = TYPE_ARM_SMMUV3,
> +    .instance_size = sizeof(SMMUv3AccelState),
> +    .class_size    = sizeof(SMMUv3AccelClass),
> +    .class_init    = smmuv3_accel_class_init,
> +};
> +
> +static void smmuv3_accel_register_types(void)
> +{
> +    type_register_static(&smmuv3_accel_type_info);
> +}
> +
> +type_init(smmuv3_accel_register_types)
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index d1a4a64551..b5c63cfd5d 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -157,6 +157,9 @@ struct SMMUState {
>      QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
>      uint8_t bus_num;
>      PCIBus *primary_bus;
> +
> +    /* For smmuv3-accel */
> +    bool accel;
>  };
>  
>  struct SMMUBaseClass {
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> new file mode 100644
> index 0000000000..56fe376bf4
> --- /dev/null
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -0,0 +1,31 @@
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
> +#include "hw/arm/smmuv3.h"
> +#include "qom/object.h"
> +
> +#define TYPE_ARM_SMMUV3_ACCEL   "arm-smmuv3-accel"
> +OBJECT_DECLARE_TYPE(SMMUv3AccelState, SMMUv3AccelClass, ARM_SMMUV3_ACCEL)
> +
> +struct SMMUv3AccelState {
> +    SMMUv3State smmuv3_state;
> +};
> +
> +struct SMMUv3AccelClass {
> +    /*< private >*/
> +    SMMUv3Class smmuv3_class;
> +    /*< public >*/
> +
> +    DeviceRealize parent_realize;
> +};
> +
> +#endif /* HW_ARM_SMMUV3_ACCEL_H */
Thanks

Eric


