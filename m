Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBDCCCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU8b-000507-TN; Wed, 25 Sep 2024 11:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8a-0004vA-3q
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8Y-0004i9-Lf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71YjHR4i2fvey4RbfvJyjNfHj65NPTQlL+9sHdiEob4=;
 b=Wj291OmECdi7+BXCc0tTM6ldmumpK/zdYpcZkzgP2NxnysJR9du3z+eaeKaTRiPNhcUtdp
 yYRz8ldCzVW69kUEUY2ltXuUbgT+VqkuYB8637O7bxveaoU0gXsEizJsHZ/sl0tZUp/91x
 fHH++KOrINCQ9CF8E0OFU8j9jmwiIAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-45IOxlAxPw2Kkc5yRKf6ig-1; Wed, 25 Sep 2024 11:41:04 -0400
X-MC-Unique: 45IOxlAxPw2Kkc5yRKf6ig-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb6dc3365so52733515e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278862; x=1727883662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=71YjHR4i2fvey4RbfvJyjNfHj65NPTQlL+9sHdiEob4=;
 b=rntP0Y9EPJABf68fmHSpOIS93eilvc/igVo81ihnPtHpluYZwHuPxyQjQy6MiXn6B2
 nBfBkpeCG2FnhpmpwMFCrhdwlzr+vQ9mTuMd/Blw4AisHpwVzOd5jKzFDNCq4uMIZJ0j
 +V78Upcy6aMMG6p3TVs4bZf4x2PiJ2l7DZAGakxnJF4FnjicTYBnsPFia2KEsLAn5ScA
 jWUK2gQlDA8LH/tDi7z6lkt52FrOws/rrlG8idJOCkxEV3R0Sq00ETu5rNZ8++eWVa3e
 bZAqHGvvFeIc3iMAbPOLDx66dZj3NAJZIPtqK+Km9A/pRDEa35gT0ys5e6l8wLj15Fy5
 /IPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXeJjBhhE3Gbk001QNmFuWHB9OrfyNVBI/BbOlqsx/LkilhXVRArEGONQHe4LFzj5ApofS2u9x7ktb@nongnu.org
X-Gm-Message-State: AOJu0YwYUN71WECdXlxjjO/JyVdsH2KNFQbV8jZlXfY8IVnngeHwE2nu
 goWRjaqUtcIyC8bVTJ4xQwHXyNjeMvTXv3gF2ounxPcqOeCQe3YvR28C89mOtKF0fbU9pn5DjSW
 9cO8pypOFRglxOD4cTfZEsv4mh+xJBitaW1ZAVMAw7Uun38Jr0Gdo
X-Received: by 2002:a05:600c:35c3:b0:42c:b309:8d1a with SMTP id
 5b1f17b1804b1-42e9610ba91mr20193305e9.13.1727278862185; 
 Wed, 25 Sep 2024 08:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjxJonAfgZOc2Zr6dOt9dsAP6C7ykMgMquXxmeeVB60NKSiMuortBAa/Dz9a/3lHKgOCXKbg==
X-Received: by 2002:a05:600c:35c3:b0:42c:b309:8d1a with SMTP id
 5b1f17b1804b1-42e9610ba91mr20193185e9.13.1727278861786; 
 Wed, 25 Sep 2024 08:41:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2a8b7esm4298988f8f.12.2024.09.25.08.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:41:01 -0700 (PDT)
Message-ID: <a5147398-8caf-4887-a9ce-f7c0eefcdb66@redhat.com>
Date: Wed, 25 Sep 2024 17:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-14-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-14-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/23/24 11:30, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/pci-host/ppce500.c | 42 ++++++++++++++++++------------------------
>   1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index d7ff2ba778..1ce79ea20c 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -21,7 +21,6 @@
>   #include "hw/pci/pci_device.h"
>   #include "hw/pci/pci_host.h"
>   #include "qemu/bswap.h"
> -#include "qemu/module.h"
>   #include "hw/pci-host/ppce500.h"
>   #include "qom/object.h"
>   
> @@ -508,17 +507,6 @@ static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo e500_host_bridge_info = {
> -    .name          = TYPE_PPC_E500_PCI_BRIDGE,
> -    .parent        = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(PPCE500PCIBridgeState),
> -    .class_init    = e500_host_bridge_class_init,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    },
> -};
> -
>   static Property pcihost_properties[] = {
>       DEFINE_PROP_UINT32("first_slot", PPCE500PCIState, first_slot, 0x11),
>       DEFINE_PROP_UINT32("first_pin_irq", PPCE500PCIState, first_pin_irq, 0x1),
> @@ -535,17 +523,23 @@ static void e500_pcihost_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_ppce500_pci;
>   }
>   
> -static const TypeInfo e500_pcihost_info = {
> -    .name          = TYPE_PPC_E500_PCI_HOST_BRIDGE,
> -    .parent        = TYPE_PCI_HOST_BRIDGE,
> -    .instance_size = sizeof(PPCE500PCIState),
> -    .class_init    = e500_pcihost_class_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_PPC_E500_PCI_BRIDGE,
> +        .parent        = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(PPCE500PCIBridgeState),
> +        .class_init    = e500_host_bridge_class_init,
> +        .interfaces    = (InterfaceInfo[]) {
> +            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +            { },
> +        },
> +    },
> +    {
> +        .name          = TYPE_PPC_E500_PCI_HOST_BRIDGE,
> +        .parent        = TYPE_PCI_HOST_BRIDGE,
> +        .instance_size = sizeof(PPCE500PCIState),
> +        .class_init    = e500_pcihost_class_init,
> +    },
>   };
>   
> -static void e500_pci_register_types(void)
> -{
> -    type_register_static(&e500_pcihost_info);
> -    type_register_static(&e500_host_bridge_info);
> -}
> -
> -type_init(e500_pci_register_types)
> +DEFINE_TYPES(types)


