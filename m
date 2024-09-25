Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6554BCCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU8M-0003u3-Bq; Wed, 25 Sep 2024 11:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8B-0003ED-VV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU89-0004ez-DF
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLBUvpY2V+/VYHmWgWkZYlebHvXXqsekzIkCdTaBPrs=;
 b=bhPDVVjAS/x/4XOLBn8jKqvl2DRUUzS7o7ZOy7gMZSaPmzOgBcGfnJ8bz+L445+ETx0mbr
 CRFC7sIOH12OYImFi+Za3/RuWN401Ray01rCKbq/EreVKC+RJJSF2a+G+BlP0KkQ8wXHE0
 rT5e2bc+2BPuTIjbvf3sxeCtATHE8iM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-_9ek-4ndOH6PKFbAPlcHag-1; Wed, 25 Sep 2024 11:40:38 -0400
X-MC-Unique: _9ek-4ndOH6PKFbAPlcHag-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb9e14ab6so45976095e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278837; x=1727883637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jLBUvpY2V+/VYHmWgWkZYlebHvXXqsekzIkCdTaBPrs=;
 b=CikVZwQX8VjD9rUxVYaGlkHqLQePT1kc1rFvsjfgOKwYsF+FAxY8huRou2wFs52jvH
 UwFBXruqNcMTy8BnCz3vuzoxdEggYI4SgSkXTX6VOIpu2t52uXDLt9SZWpsHDqp3ILbo
 4dc+87IXIc/VAAq688tHiPzgAYTWi6w2M8GSu+byM6whKPScWXEkLphHVJJkGary761j
 bzz90vH80KuM6/GsX+QIWgzUPIw3l4jQlJuzNvJRWgrv1Uom+eQGZ4fu3+QQafi3IjFO
 5aN/uqalNgHIXkGqE7VTEU6wIbv7l3C1uDAvmTBciulpT4oGxNkPXGE1EvzX0Q2tUfKn
 1JtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXMecYQqSVuMm9eJQeBONmEBZmQgw6DXDwfvYrx6Ulc8VYDNbuXtF1QIyzlk0xrzcjHGBPFCkQMl3Y@nongnu.org
X-Gm-Message-State: AOJu0YxUPZL6s/5KYmX7RYRtfhcHxQowEE0+VGApmF9uYBlyBy00apeC
 a+kSnB6rIdIyJoQMMkj/nmA8/+SRrWgrou1pVhCpEUlVM3ANEd0e/lDzPeIpOf/1ZLOcRZNBlHc
 rbk1+pya4196xMbYO0lP86PX5j/NEyeN/zfdN8LmDUiLSKh5rnf70
X-Received: by 2002:adf:f1ca:0:b0:374:c8cc:1bb1 with SMTP id
 ffacd0b85a97d-37cc24b575bmr2221426f8f.39.1727278836707; 
 Wed, 25 Sep 2024 08:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwiAnwsKjmfMVLuslhix0c/BZGNocD9o78nO9El99d2FH+ZD8nfGFMG7d5L9pnXuJ+cfL6sw==
X-Received: by 2002:adf:f1ca:0:b0:374:c8cc:1bb1 with SMTP id
 ffacd0b85a97d-37cc24b575bmr2221402f8f.39.1727278836308; 
 Wed, 25 Sep 2024 08:40:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc31f348sm4262635f8f.95.2024.09.25.08.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:40:35 -0700 (PDT)
Message-ID: <e09810de-e744-43df-b193-aacfc4c0dcd6@redhat.com>
Date: Wed, 25 Sep 2024 17:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/23] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-12-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-12-shentey@gmail.com>
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
>   hw/i2c/mpc_i2c.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 3d79c15653..16f4309ea9 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "hw/i2c/i2c.h"
>   #include "hw/irq.h"
> -#include "qemu/module.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
>   #include "qom/object.h"
> @@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
>       dc->desc = "MPC I2C Controller";
>   }
>   
> -static const TypeInfo mpc_i2c_type_info = {
> -    .name          = TYPE_MPC_I2C,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(MPCI2CState),
> -    .class_init    = mpc_i2c_class_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_MPC_I2C,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(MPCI2CState),
> +        .class_init    = mpc_i2c_class_init,
> +    },
>   };
>   
> -static void mpc_i2c_register_types(void)
> -{
> -    type_register_static(&mpc_i2c_type_info);
> -}
> -
> -type_init(mpc_i2c_register_types)
> +DEFINE_TYPES(types)


