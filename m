Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2923CCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU92-0007xc-4r; Wed, 25 Sep 2024 11:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8z-0007nq-PM
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8y-0004lW-8U
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yTzruQEkh6jOtymJ06ArZ3DRgx5zXLZegcd7qLVicQ=;
 b=XI4K+nrymvCBHdnVM2HkcVpu0vFpu21rpmTLNG/X7ax9PN3qlOEtA3O4JvJB2oHJSJ4zMQ
 kVbE/OX/cZ56EZShUhyo5dUbXDpq4i9Dq27z3Q1woNBHSmRVs2C7XFoQGItQbs42FIaLbS
 NhqKX8AobmVzXHTm3BBg2Y1rfZJMKNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-d-GMl4jQPNmNoI3Mo_e07Q-1; Wed, 25 Sep 2024 11:41:30 -0400
X-MC-Unique: d-GMl4jQPNmNoI3Mo_e07Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb857fc7dso52848685e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278889; x=1727883689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1yTzruQEkh6jOtymJ06ArZ3DRgx5zXLZegcd7qLVicQ=;
 b=dZo9Ie9zBY/slVOjUKrXgfrsc5SIrRkoj6ns0k3zKA/asHiW7KuVQzX/4Y4hSWcxaP
 S0z9rONmTpk6olwSVaq3b9qztCbcZrIApU6lCyc1Nx+4cWh0SzZzkPt0Roxio6YZk9Sn
 X5pVS0jdym2PkOXxLLV6zUeUEE0h1zPxKy8YhU5lHXubE3lN1P+Az9oD8xqTo6UEOlkN
 SBhvCl4+3TrgMDwX8lfD+gYwfyCyQ1oZwPZWaUsuB5OrAOXGJ8fg11pu1o2kS+Ui0kzh
 rmlL7expKurBvpzDV5SdeDiMI2NIzMrIaxhpviiolvpqZzoxvKJHt8yNx94Ee3yrEOQR
 l9tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpbfIO36pjZxZDfI70ULatvVR4WX3bpz9om97UKJ9Fov2meTj1MSuNXCwxJQqq14jyf79jXdleXzxS@nongnu.org
X-Gm-Message-State: AOJu0Yxj91kfwdGOKlswXWgPxyiF6JQ5Ei1IbPJwF72fIDgwXgAC48Z7
 7dn7gCrx01TxsyEOrCgx0r6NcSKsbeRf4NIewsnZue5WaOJML9LhsLmVI0PWv8cGtY9HrOOq8NX
 /+fb5TV5terl6FpgYN3T4Fx21Z+0KdBTXeytLg7HdUziZbw7zs96t
X-Received: by 2002:a05:600c:6a95:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42e96144c8bmr21858165e9.26.1727278889072; 
 Wed, 25 Sep 2024 08:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz8bML52LZzY7MCisuDB4KyrUJtHG3taLrr5Vgk0m8Nr4GW8qFWRElAPci6v0qdm9sYefNtw==
X-Received: by 2002:a05:600c:6a95:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42e96144c8bmr21857915e9.26.1727278888643; 
 Wed, 25 Sep 2024 08:41:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a17d30sm22421305e9.40.2024.09.25.08.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:41:28 -0700 (PDT)
Message-ID: <1018d0f6-deb1-4178-bac4-32e477413ca3@redhat.com>
Date: Wed, 25 Sep 2024 17:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/23] hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-17-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-17-shentey@gmail.com>
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
>   hw/net/fsl_etsec/etsec.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index 3fdd16ef2e..9bd886b996 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -36,7 +36,6 @@
>   #include "registers.h"
>   #include "qapi/error.h"
>   #include "qemu/log.h"
> -#include "qemu/module.h"
>   
>   /* #define HEX_DUMP */
>   /* #define DEBUG_REGISTER */
> @@ -431,17 +430,14 @@ static void etsec_class_init(ObjectClass *klass, void *data)
>       dc->user_creatable = true;
>   }
>   
> -static const TypeInfo etsec_info = {
> -    .name                  = TYPE_ETSEC_COMMON,
> -    .parent                = TYPE_SYS_BUS_DEVICE,
> -    .instance_size         = sizeof(eTSEC),
> -    .class_init            = etsec_class_init,
> -    .instance_init         = etsec_instance_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_ETSEC_COMMON,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(eTSEC),
> +        .class_init    = etsec_class_init,
> +        .instance_init = etsec_instance_init,
> +    },
>   };
>   
> -static void etsec_register_types(void)
> -{
> -    type_register_static(&etsec_info);
> -}
> -
> -type_init(etsec_register_types)
> +DEFINE_TYPES(types)


