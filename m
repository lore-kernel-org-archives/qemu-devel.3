Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E548CCF9E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU9d-0003gd-LX; Wed, 25 Sep 2024 11:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU9b-0003N9-6f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU9V-0004pV-Tr
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+Bx+g7tu0jbadT0OuCdSZQCOMHHx8sA/BFOOQwho+E=;
 b=ALdGbHtmwHRN3YRrwzXh1YF/gyleWAddjtdgzh9LHoj/w4iLhJ71hpbnAob+dqpOHnkubQ
 nxMqsCqxWalyYebD4gIj6wiQeD+OTHss49oGDCTeiBs46fIor9k97jKjlUH7G8moJwoCED
 L81jehtppgykEsdrZ91Q1m4A072DCLY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-8caILevvMgalt2w-BkaO6Q-1; Wed, 25 Sep 2024 11:42:04 -0400
X-MC-Unique: 8caILevvMgalt2w-BkaO6Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb830ea86so48092965e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278923; x=1727883723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+Bx+g7tu0jbadT0OuCdSZQCOMHHx8sA/BFOOQwho+E=;
 b=qoIaxBLlls+27VxYVzLpIl7TmK/sGHagnQ1ZsdnNRsbHP2YvEIwUbgymijuu9eugzf
 kL1/9til/qg9KgJbY1lgC552azSQsHo5WRier7wnq3gis+xA3g9MOrTMljgZqC7h0pWx
 2Rmna/mcTkBGw/xjrc2eIeaRyI9CuSsocxYL/TRlQvhZX4TCOzPSwbHn7WT6j3SLUZNQ
 FfWFv57McglFxkgepOaklVJig9xnSl+X0koLHY/xxUyzTPZ4w6lOofqrAlgrJxMM9jI2
 MvkFfJRlynzL2Y5Ixg7b+nNVak6E7VItrZ1FKCnXKqyvJWZ03BslWrazXckB4M8P07JI
 Fedg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwcgxHHJmG9umQI3PFcSTNz3kQcP9CyrHjybHfpU8FD2MxRvzSo8kd/tuzNsFmmxqxFY9hDHCt/eSl@nongnu.org
X-Gm-Message-State: AOJu0YzoW8dL71iTzDeKC3ZCk1Gd78QLcYBgOXSzQMz5vWKeTJVDjTdj
 VTsLWPI8ra1H3UNwHB1AFFvyjg8Gfz/ZGN6ceok/f/SLs8atCrDuiJx+JtvbdVwxLyzyhBtITl/
 wbScS/ZNlR0jVXF8VnDEoYF0JsPz4fbJsu+YH3+34BzKQuNSlBWci
X-Received: by 2002:a5d:456e:0:b0:35f:122e:bd8c with SMTP id
 ffacd0b85a97d-37cc247395dmr1971592f8f.17.1727278920871; 
 Wed, 25 Sep 2024 08:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLAkMPk/FqWlY6WpAKSR4kwWHcgsTPhEMA4e18uq74cTzeRRGK+0FhAD+RYaYKvCAve46Dug==
X-Received: by 2002:a5d:456e:0:b0:35f:122e:bd8c with SMTP id
 ffacd0b85a97d-37cc247395dmr1971528f8f.17.1727278918287; 
 Wed, 25 Sep 2024 08:41:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cc62855eesm1565569f8f.67.2024.09.25.08.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:41:57 -0700 (PDT)
Message-ID: <a9478828-e8c8-4b5f-8120-1f4c692aa8b0@redhat.com>
Date: Wed, 25 Sep 2024 17:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] hw/sd/sdhci: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-19-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-19-shentey@gmail.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
>   hw/sd/sdhci.c | 62 +++++++++++++++++++++------------------------------
>   1 file changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 87122e4245..3ed2d8658a 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -37,7 +37,6 @@
>   #include "migration/vmstate.h"
>   #include "sdhci-internal.h"
>   #include "qemu/log.h"
> -#include "qemu/module.h"
>   #include "trace.h"
>   #include "qom/object.h"
>   
> @@ -1598,15 +1597,6 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
>       sdhci_common_class_init(klass, data);
>   }
>   
> -static const TypeInfo sdhci_sysbus_info = {
> -    .name = TYPE_SYSBUS_SDHCI,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(SDHCIState),
> -    .instance_init = sdhci_sysbus_init,
> -    .instance_finalize = sdhci_sysbus_finalize,
> -    .class_init = sdhci_sysbus_class_init,
> -};
> -
>   /* --- qdev bus master --- */
>   
>   static void sdhci_bus_class_init(ObjectClass *klass, void *data)
> @@ -1617,13 +1607,6 @@ static void sdhci_bus_class_init(ObjectClass *klass, void *data)
>       sbc->set_readonly = sdhci_set_readonly;
>   }
>   
> -static const TypeInfo sdhci_bus_info = {
> -    .name = TYPE_SDHCI_BUS,
> -    .parent = TYPE_SD_BUS,
> -    .instance_size = sizeof(SDBus),
> -    .class_init = sdhci_bus_class_init,
> -};
> -
>   /* --- qdev i.MX eSDHC --- */
>   
>   #define USDHC_MIX_CTRL                  0x48
> @@ -1882,12 +1865,6 @@ static void imx_usdhc_init(Object *obj)
>       s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
>   }
>   
> -static const TypeInfo imx_usdhc_info = {
> -    .name = TYPE_IMX_USDHC,
> -    .parent = TYPE_SYSBUS_SDHCI,
> -    .instance_init = imx_usdhc_init,
> -};
> -
>   /* --- qdev Samsung s3c --- */
>   
>   #define S3C_SDHCI_CONTROL2      0x80
> @@ -1946,18 +1923,31 @@ static void sdhci_s3c_init(Object *obj)
>       s->io_ops = &sdhci_s3c_mmio_ops;
>   }
>   
> -static const TypeInfo sdhci_s3c_info = {
> -    .name = TYPE_S3C_SDHCI  ,
> -    .parent = TYPE_SYSBUS_SDHCI,
> -    .instance_init = sdhci_s3c_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name = TYPE_SDHCI_BUS,
> +        .parent = TYPE_SD_BUS,
> +        .instance_size = sizeof(SDBus),
> +        .class_init = sdhci_bus_class_init,
> +    },
> +    {
> +        .name = TYPE_SYSBUS_SDHCI,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(SDHCIState),
> +        .instance_init = sdhci_sysbus_init,
> +        .instance_finalize = sdhci_sysbus_finalize,
> +        .class_init = sdhci_sysbus_class_init,
> +    },
> +    {
> +        .name = TYPE_IMX_USDHC,
> +        .parent = TYPE_SYSBUS_SDHCI,
> +        .instance_init = imx_usdhc_init,
> +    },
> +    {
> +        .name = TYPE_S3C_SDHCI,
> +        .parent = TYPE_SYSBUS_SDHCI,
> +        .instance_init = sdhci_s3c_init,
> +    },
>   };
>   
> -static void sdhci_register_types(void)
> -{
> -    type_register_static(&sdhci_sysbus_info);
> -    type_register_static(&sdhci_bus_info);
> -    type_register_static(&imx_usdhc_info);
> -    type_register_static(&sdhci_s3c_info);
> -}
> -
> -type_init(sdhci_register_types)
> +DEFINE_TYPES(types)


