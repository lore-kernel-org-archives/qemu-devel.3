Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A209CCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU9j-0004Sr-7H; Wed, 25 Sep 2024 11:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU9g-00046o-HQ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU9f-0004qf-24
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3alnVEW9Z4arU5WHM7ypVPvSHQZZJqMh+Z5tstK1KM=;
 b=hqL+7Rl3kmDbuHmA4lELjgcuTTFuwdORPB3oJ2WpUFITJyuepMRXTuEwc8mAvu3g9s9qOV
 wQlgGUVFwBkab4Ag7LQft2IAuuUb2APfx2T23BS5hwjDtwnPbXFeB7hP7YzlGxGcNQp4G/
 a9M3C4EiWGEqhCEkmjlWEbS1YX1AsFk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-iDTBKBUMO9qjxLiypgF9FQ-1; Wed, 25 Sep 2024 11:42:12 -0400
X-MC-Unique: iDTBKBUMO9qjxLiypgF9FQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb998fd32so48159625e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278930; x=1727883730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C3alnVEW9Z4arU5WHM7ypVPvSHQZZJqMh+Z5tstK1KM=;
 b=Hlp2+0tMUXKtriKoWQaHP3pFntRKEix6c1ZOxB4k2suF8yLunOHYBTqxhHCVRwQpiK
 QurEUpeHeGZ5STDqnQY3SOyQei5oz3tDQJ91FwsEXfWO7Myhxczl7yoA5TQ9S87pPJGA
 4pFNEV1v8SrNw0/E+Q8PxCbPy4g38zv4zVWSh2OjlWJXa0kWg0Iaew6WObdmhpQ64KQ3
 Dae+tFpzUc8f+KKnAA+0W1DkUhhCuvRz/8BNrp/JAd6QSMIIxBArW1V/ZJ5xKhFViQNZ
 oE17AbxeJe/EufgXeZmXxdKwgtl7ii023MWhh6bzzdCPxmc1NrRt1IkUqBru17Ze+QCO
 R7oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVH9Ql5YTz0swvsEJsvhLpgp3lk5b9EDzVDZoDsOdJghxUT4GITIzML1zk60geBTXE1vjMFTfL4eMp@nongnu.org
X-Gm-Message-State: AOJu0Yxkmw9+Yqs3qifFZAA10NZXwQ2SqVwf6tHXNYi/p1/Hs2OsgPtw
 vQPaVoKm6J7sw+4+S8l41DFgEyN56BGCGGr6bKA7sqRcaksyP5GhTNS+VMXFI1O3Z9Kq1Y1Agja
 SjRY970qpbIVl2GGMrVq0hy7dR/fxzy+DRj8hBuHZxVffu1ZheJfmCJ6wwjukyuo=
X-Received: by 2002:a05:600c:6003:b0:42c:a574:6362 with SMTP id
 5b1f17b1804b1-42f50b68f6bmr13529625e9.11.1727278929907; 
 Wed, 25 Sep 2024 08:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGavW+/UVAOEbU7tgfuEdPA3CMHdMweLEbJfijoxibMNH5hTdJlXDT+JOWOK9gSch5ssGenbw==
X-Received: by 2002:a05:600c:6003:b0:42c:a574:6362 with SMTP id
 5b1f17b1804b1-42f50b68f6bmr13529355e9.11.1727278929538; 
 Wed, 25 Sep 2024 08:42:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2c1acasm4290469f8f.32.2024.09.25.08.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:42:09 -0700 (PDT)
Message-ID: <12030c30-ec65-4514-bbac-45cdadba24f2@redhat.com>
Date: Wed, 25 Sep 2024 17:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-20-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-20-shentey@gmail.com>
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
>   hw/block/pflash_cfi01.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 7b6ec64442..cf11dada29 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -47,7 +47,6 @@
>   #include "qemu/bitops.h"
>   #include "qemu/host-utils.h"
>   #include "qemu/log.h"
> -#include "qemu/module.h"
>   #include "qemu/option.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
> @@ -947,20 +946,16 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>   }
>   
> -
> -static const TypeInfo pflash_cfi01_info = {
> -    .name           = TYPE_PFLASH_CFI01,
> -    .parent         = TYPE_SYS_BUS_DEVICE,
> -    .instance_size  = sizeof(PFlashCFI01),
> -    .class_init     = pflash_cfi01_class_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name           = TYPE_PFLASH_CFI01,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(PFlashCFI01),
> +        .class_init     = pflash_cfi01_class_init,
> +    },
>   };
>   
> -static void pflash_cfi01_register_types(void)
> -{
> -    type_register_static(&pflash_cfi01_info);
> -}
> -
> -type_init(pflash_cfi01_register_types)
> +DEFINE_TYPES(types)
>   
>   PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>                                      const char *name,


