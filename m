Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575F5CCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stUAi-0001v4-Md; Wed, 25 Sep 2024 11:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stUAc-0001Ou-FO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stUAZ-0004xY-J5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O3JdkXx2zgOMq4W3KD7LSBPr/QRNHVHfa8p6vD6PQU=;
 b=YWPzHphhrQR3Y4fGl0EKf7l8Uol31T9p31PM7oaZ5kPVhxXG+SpiqT8IFE/JV81+hR5/5u
 kEdswA4L4gF6igXHG2looIPE1EXpKaqlTtDwjPJjLq68y4sPDVxbH+47mfcce/tLCuwb2i
 qaLSwPNzIq98EcCJMHKrCdBGqlg0FTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-o3h1GrC3MYWY_id0N4sEyQ-1; Wed, 25 Sep 2024 11:43:09 -0400
X-MC-Unique: o3h1GrC3MYWY_id0N4sEyQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37ccd7c3080so61917f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278988; x=1727883788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4O3JdkXx2zgOMq4W3KD7LSBPr/QRNHVHfa8p6vD6PQU=;
 b=OpCeY00UHL9EEf/q3zf+RkOd2uSK2ltRcJjSr1QnkqwR9joWPo0oYfyma2Cwy8u63K
 D+YecCbtwke600L9UBAlPRw1j/GXQGlIvgrYVrJFv3WicbpD5sKfKbhAtXQPxWwlyqgN
 j4ETLwIxdAaUh1xSozJfXXwbz+h4KmE0Q6RKtKs7pfKYepPtllvm65ipKKvAI3O+Mnsx
 jyOmVASNlHxO6jgWBvnUx0rch0rmm4xtuams3UdKJIYJOf1nW4ILYo4aGYc4EqhJ9r8s
 ynRC9G4uluYlAMPX/wJOmJHaF+ddgSxXs4diRwTwmjeXYhn83xWkWR5W3kQUFE8bFDXl
 TkuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuelaBdTjHg7kheAaWVEzre6XfPiRS4o/a4SzOr7ADJX4mAMbmYbcw2DaUZEwNf11iIYdQU0mnrZe3@nongnu.org
X-Gm-Message-State: AOJu0YyvdPNRKHZyd4FFWXAY4Kwurizrd/iI8kU3/BrX9yy9c6Dxybv3
 oWcAPD8fjmqLJoQtVuFDH2qHXk2jmE3JDEvJGc0nwR9soKjHkIzLIYPCEuRjuYNPfhsQGiiyTRY
 msXbFGIJWdzYH7eGYUIsR3I6R6QMGXxvZrQLtqDVMx+u4fNiAP5HVZ4+i5KmBjpk=
X-Received: by 2002:a5d:690c:0:b0:374:ba7a:7d46 with SMTP id
 ffacd0b85a97d-37cc24c2869mr2080736f8f.43.1727278988129; 
 Wed, 25 Sep 2024 08:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqXizq3RYSY+9t9t/PetGnxgmglEY7cuM9pN3GCMGGidYLuQKAUgIpDWs5ncTkia4DvWfUrQ==
X-Received: by 2002:a5d:690c:0:b0:374:ba7a:7d46 with SMTP id
 ffacd0b85a97d-37cc24c2869mr2080710f8f.43.1727278987645; 
 Wed, 25 Sep 2024 08:43:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc31f829sm4309561f8f.112.2024.09.25.08.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:43:07 -0700 (PDT)
Message-ID: <e81b5856-5396-4362-b3a3-a39ea1128be6@redhat.com>
Date: Wed, 25 Sep 2024 17:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/23] hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-23-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-23-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/23/24 11:30, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/usb/hcd-ehci-sysbus.c | 118 +++++++++++++++++----------------------
>   1 file changed, 50 insertions(+), 68 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index 2b1652f7a8..87a3bebe3e 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -19,7 +19,6 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/usb/hcd-ehci.h"
>   #include "migration/vmstate.h"
> -#include "qemu/module.h"
>   
>   static const VMStateDescription vmstate_ehci_sysbus = {
>       .name        = "ehci-sysbus",
> @@ -97,17 +96,6 @@ static void ehci_sysbus_class_init(ObjectClass *klass, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_type_info = {
> -    .name          = TYPE_SYS_BUS_EHCI,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(EHCISysBusState),
> -    .instance_init = ehci_sysbus_init,
> -    .instance_finalize = ehci_sysbus_finalize,
> -    .abstract      = true,
> -    .class_init    = ehci_sysbus_class_init,
> -    .class_size    = sizeof(SysBusEHCIClass),
> -};
> -
>   static void ehci_platform_class_init(ObjectClass *oc, void *data)
>   {
>       SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> @@ -118,12 +106,6 @@ static void ehci_platform_class_init(ObjectClass *oc, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_platform_type_info = {
> -    .name          = TYPE_PLATFORM_EHCI,
> -    .parent        = TYPE_SYS_BUS_EHCI,
> -    .class_init    = ehci_platform_class_init,
> -};
> -
>   static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
>   {
>       SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> @@ -134,12 +116,6 @@ static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_exynos4210_type_info = {
> -    .name          = TYPE_EXYNOS4210_EHCI,
> -    .parent        = TYPE_SYS_BUS_EHCI,
> -    .class_init    = ehci_exynos4210_class_init,
> -};
> -
>   static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
>   {
>       SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> @@ -150,12 +126,6 @@ static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_aw_h3_type_info = {
> -    .name          = TYPE_AW_H3_EHCI,
> -    .parent        = TYPE_SYS_BUS_EHCI,
> -    .class_init    = ehci_aw_h3_class_init,
> -};
> -
>   static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
>   {
>       SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> @@ -168,12 +138,6 @@ static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_npcm7xx_type_info = {
> -    .name          = TYPE_NPCM7XX_EHCI,
> -    .parent        = TYPE_SYS_BUS_EHCI,
> -    .class_init    = ehci_npcm7xx_class_init,
> -};
> -
>   static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
>   {
>       SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> @@ -184,12 +148,6 @@ static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_tegra2_type_info = {
> -    .name          = TYPE_TEGRA2_EHCI,
> -    .parent        = TYPE_SYS_BUS_EHCI,
> -    .class_init    = ehci_tegra2_class_init,
> -};
> -
>   static void ehci_ppc4xx_init(Object *o)
>   {
>       EHCISysBusState *s = SYS_BUS_EHCI(o);
> @@ -207,13 +165,6 @@ static void ehci_ppc4xx_class_init(ObjectClass *oc, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_ppc4xx_type_info = {
> -    .name          = TYPE_PPC4xx_EHCI,
> -    .parent        = TYPE_SYS_BUS_EHCI,
> -    .class_init    = ehci_ppc4xx_class_init,
> -    .instance_init = ehci_ppc4xx_init,
> -};
> -
>   /*
>    * Faraday FUSBH200 USB 2.0 EHCI
>    */
> @@ -282,24 +233,55 @@ static void fusbh200_ehci_class_init(ObjectClass *oc, void *data)
>       set_bit(DEVICE_CATEGORY_USB, dc->categories);
>   }
>   
> -static const TypeInfo ehci_fusbh200_type_info = {
> -    .name          = TYPE_FUSBH200_EHCI,
> -    .parent        = TYPE_SYS_BUS_EHCI,
> -    .instance_size = sizeof(FUSBH200EHCIState),
> -    .instance_init = fusbh200_ehci_init,
> -    .class_init    = fusbh200_ehci_class_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_SYS_BUS_EHCI,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(EHCISysBusState),
> +        .instance_init = ehci_sysbus_init,
> +        .instance_finalize = ehci_sysbus_finalize,
> +        .abstract      = true,
> +        .class_init    = ehci_sysbus_class_init,
> +        .class_size    = sizeof(SysBusEHCIClass),
> +    },
> +    {
> +        .name          = TYPE_PLATFORM_EHCI,
> +        .parent        = TYPE_SYS_BUS_EHCI,
> +        .class_init    = ehci_platform_class_init,
> +    },
> +    {
> +        .name          = TYPE_EXYNOS4210_EHCI,
> +        .parent        = TYPE_SYS_BUS_EHCI,
> +        .class_init    = ehci_exynos4210_class_init,
> +    },
> +    {
> +        .name          = TYPE_AW_H3_EHCI,
> +        .parent        = TYPE_SYS_BUS_EHCI,
> +        .class_init    = ehci_aw_h3_class_init,
> +    },
> +    {
> +        .name          = TYPE_NPCM7XX_EHCI,
> +        .parent        = TYPE_SYS_BUS_EHCI,
> +        .class_init    = ehci_npcm7xx_class_init,
> +    },
> +    {
> +        .name          = TYPE_TEGRA2_EHCI,
> +        .parent        = TYPE_SYS_BUS_EHCI,
> +        .class_init    = ehci_tegra2_class_init,
> +    },
> +    {
> +        .name          = TYPE_PPC4xx_EHCI,
> +        .parent        = TYPE_SYS_BUS_EHCI,
> +        .class_init    = ehci_ppc4xx_class_init,
> +        .instance_init = ehci_ppc4xx_init,
> +    },
> +    {
> +        .name          = TYPE_FUSBH200_EHCI,
> +        .parent        = TYPE_SYS_BUS_EHCI,
> +        .instance_size = sizeof(FUSBH200EHCIState),
> +        .instance_init = fusbh200_ehci_init,
> +        .class_init    = fusbh200_ehci_class_init,
> +    },
>   };
>   
> -static void ehci_sysbus_register_types(void)
> -{
> -    type_register_static(&ehci_type_info);
> -    type_register_static(&ehci_platform_type_info);
> -    type_register_static(&ehci_exynos4210_type_info);
> -    type_register_static(&ehci_aw_h3_type_info);
> -    type_register_static(&ehci_npcm7xx_type_info);
> -    type_register_static(&ehci_tegra2_type_info);
> -    type_register_static(&ehci_ppc4xx_type_info);
> -    type_register_static(&ehci_fusbh200_type_info);
> -}
> -
> -type_init(ehci_sysbus_register_types)
> +DEFINE_TYPES(types)


