Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47B7D637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHdz-0004Pn-Bp; Wed, 13 Nov 2024 12:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBHdw-0004PW-9T
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBHdu-0008Jz-CY
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731520739;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVrqIYGS7NdD6eeIG6USycWyaacM+KCIZBbybQp0F2Q=;
 b=iPZkZ6IvU9I0bfpIuv3c+wdEA017+VjDjFxmkn35z/Pgyz4RKdz87G6XcS8VKvXkqN5MQy
 lP2kej37fQ8K3qhhGUANiF0fSFswI8Kve9Txumshbp7QgRHIeEUpZ+cPrewQueeQ3PP+zy
 N7pAGn9kaFk1pb9jbJOrdsFWxAlvo2Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-p5vh_b2fPDeYmrBdOv_gPw-1; Wed, 13 Nov 2024 12:58:58 -0500
X-MC-Unique: p5vh_b2fPDeYmrBdOv_gPw-1
X-Mimecast-MFC-AGG-ID: p5vh_b2fPDeYmrBdOv_gPw
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fb50351d18so43999331fa.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520736; x=1732125536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OVrqIYGS7NdD6eeIG6USycWyaacM+KCIZBbybQp0F2Q=;
 b=FhQnfnFJO4To7D+5N6HPd2sDdx6PSzTt2UpIHGfa9Xf58TOW4Sns5jbfy1ypQQ0EDQ
 68SqAzmLERk79QyGIMfDZ8pRu+5i7sHfq3JQosjxxfuWONuZnH9ereO872mZqIu1exgr
 pvZzT99cqjqBgc1cQ1JSF6Xn8IUevxieDnPvVt9rht2BkOWuFZnVmAMSKQThpn6+BgU1
 qVgFsZH4qllE3YxQbMs9LZg8HdJCHXN2ogmgb86XBcI4toPg12aIVREWtEXRNANRDis6
 eawDu704E/BCZsgD7nK/77TRYiEtFyAMtE5kHRxHhxsOimXyQ/OD9GIg/KqXGrVvS0OK
 Qo1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/pfeh5GdVlD9AFm7lL7aJQRCt5s5F+q23l8vVwYCfVWxZP/WzYSXfQcVpgBpwlIC5X6NtGHNqShyh@nongnu.org
X-Gm-Message-State: AOJu0Yz1t3DSCQr5wOuqdtItLfgp1FVRxyK0r2qv6YSvEbX7qfLcMKaV
 QRwWcwRPEsYolm3JI2HT1uEZvDH/dlp60QbYW3fIXlO/7nTCuIXeOYbEu4WgFeovCaRSt0eP0G/
 Z4ApCdPviPtgVeOX98Yy3uL2OAdEWQ6vpgZU0puS6alxy//QEtbGz
X-Received: by 2002:a05:6512:12d1:b0:53d:a422:e826 with SMTP id
 2adb3069b0e04-53da422e940mr657667e87.2.1731520736430; 
 Wed, 13 Nov 2024 09:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsJIOUsnujXr9fAZRgYAqJsGUo0cw7OFvash6t18RIum34A81RVHhDsDT80Y8QH7XSBG/mHw==
X-Received: by 2002:a05:6512:12d1:b0:53d:a422:e826 with SMTP id
 2adb3069b0e04-53da422e940mr657643e87.2.1731520736010; 
 Wed, 13 Nov 2024 09:58:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d4788c2asm26150885e9.0.2024.11.13.09.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 09:58:54 -0800 (PST)
Message-ID: <a1edc7ec-6450-4409-b8b2-b4026baee242@redhat.com>
Date: Wed, 13 Nov 2024 18:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] hw/arm/smmuv3: Associate a pci bus with a SMMUv3
 Nested device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-4-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241108125242.60136-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 11/8/24 13:52, Shameer Kolothum wrote:
> Subsequent patches will add IORT modifications to get this working.
add a proper commit msg once non RFC ;-)
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3.c         | 27 +++++++++++++++++++++++++++
>  include/hw/arm/smmuv3.h |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0033eb8125..9b0a776769 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -24,6 +24,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-core.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "cpu.h"
>  #include "trace.h"
>  #include "qemu/log.h"
> @@ -2201,12 +2202,32 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      smmu_init_irq(s, dev);
>  }
>  
> +static int smmuv3_nested_pci_host_bridge(Object *obj, void *opaque)
> +{
> +    DeviceState *d = opaque;
> +    SMMUv3NestedState *s_nested = ARM_SMMUV3_NESTED(d);
> +
> +    if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
> +        PCIBus *bus = PCI_HOST_BRIDGE(obj)->bus;
> +        if (s_nested->pci_bus && !strcmp(bus->qbus.name, s_nested->pci_bus)) {
> +            object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
> +                                     &error_abort);
> +        }
> +    }
> +    return 0;
> +}
> +
>  static void smmu_nested_realize(DeviceState *d, Error **errp)
>  {
>      SMMUv3NestedState *s_nested = ARM_SMMUV3_NESTED(d);
>      SMMUv3NestedClass *c = ARM_SMMUV3_NESTED_GET_CLASS(s_nested);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(d);
>      Error *local_err = NULL;
>  
> +    object_child_foreach_recursive(object_get_root(),
> +                                   smmuv3_nested_pci_host_bridge, d);
Using a different opaque struct pointer you may properly use the errp
and nicely fail if the bus is not found (avoid using error_abort).
> +    object_property_set_bool(OBJECT(dev), "nested", true, &error_abort);
why do you need that nested property as the SMMU is already type'd
differently.
> +
>      c->parent_realize(d, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -2293,6 +2314,11 @@ static Property smmuv3_properties[] = {
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> +static Property smmuv3_nested_properties[] = {
> +    DEFINE_PROP_STRING("pci-bus", SMMUv3NestedState, pci_bus),
nit: maybe we can use the "bus" name instead of pci-bus
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  static void smmuv3_instance_init(Object *obj)
>  {
>      /* Nothing much to do here as of now */
> @@ -2320,6 +2346,7 @@ static void smmuv3_nested_class_init(ObjectClass *klass, void *data)
>      dc->vmsd = &vmstate_smmuv3;
>      device_class_set_parent_realize(dc, smmu_nested_realize,
>                                      &c->parent_realize);
> +    device_class_set_props(dc, smmuv3_nested_properties);
>      dc->user_creatable = true;
>      dc->hotpluggable = false;
>  }
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 87e628be7a..96513fce56 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -89,6 +89,8 @@ OBJECT_DECLARE_TYPE(SMMUv3NestedState, SMMUv3NestedClass, ARM_SMMUV3_NESTED)
>  
>  struct SMMUv3NestedState {
>      SMMUv3State smmuv3_state;
> +
> +    char *pci_bus;
>  };
>  
>  struct SMMUv3NestedClass {
Thanks

Eric


