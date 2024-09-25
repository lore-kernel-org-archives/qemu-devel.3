Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A6DCCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU8t-000763-2A; Wed, 25 Sep 2024 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8s-00073m-Cy
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8q-0004kH-Uq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+W507HK+TN/yLbXeGPQlvKC89l6inVmHIJBSeli4OY=;
 b=bkOBMgF6wRkrRLnut1ZvGN19o39lqWl5dHMJ7VcugESbAFMYcv+gHvuurp7QwNpEeD+RYU
 M/8JzXYoUWA0fWFyq3k/oAs4Q6PcuVfE/CN8c2rZccKxm7enEgBgdYQ0JpFYbgvKy1abvS
 DcHfU+BNeHAuWVYSlMN+n5LT9a7aHzQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-J7dqg3ssNkOwcKNi349BfA-1; Wed, 25 Sep 2024 11:41:22 -0400
X-MC-Unique: J7dqg3ssNkOwcKNi349BfA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cdeac2da6so57160395e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278881; x=1727883681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p+W507HK+TN/yLbXeGPQlvKC89l6inVmHIJBSeli4OY=;
 b=CDzviBfEA5F9w9ib6RYhz0Im9r7TrhuqU8chuOuziLoSkU0sWk1TjatQX918++7cSp
 k2mxUrQQ1EjSjuOomQsNje/h2dyw4m664dufQvCDl+wspAqrHJJe7/W5PC/O6jNQkjRV
 7IEO2tYuqwjYtK8+yMC2JDEFidSd4q2wMS+n/zkLAH/Zr9n/p4D38AtZFW3c8qLrtrXZ
 lCYXD3zMiCWIxOmYhMulxAEvmpuws31L80WN/8bH1TmZXvCevn5azy2Olj8Jl3DowrBR
 HdA0H8tN+fwJofz6f80hP49FQYX7kaypgTbjPzjIpgNx02JFhf1ZppL5ZuEP5Zn09uqC
 ErNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7b5NrvfWmCcpcWq8pE3c+k0jvi60eLRTQQ5QWiWAieOOS0rg+lFYMifgjjJP1m+9VPSDB8hcXYzsx@nongnu.org
X-Gm-Message-State: AOJu0Yy9xf7rZORtCE6uenCj2xO0jkWhOzYMUBlGJoAUJmYeVhgEFCga
 x/IWEgkORcmc3e2H/5AYvadJtRuTJkdCw6yBkJr6QRvuy4yLxTgQshqeyDlzDrmCEnzyMeFj68D
 1Uyc6kAIn+SiPchMxu+7/3SH15foEFX8Vn9QFG36reEhLw7UieVVW
X-Received: by 2002:a05:600c:2251:b0:42e:d4a2:ce67 with SMTP id
 5b1f17b1804b1-42ed4a2cf87mr17797195e9.17.1727278881556; 
 Wed, 25 Sep 2024 08:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEe/HalbbiBNUCSl4pj0vkdcG4tNGA35QTUv85VbwAoM3Hfi/PdREkv1R0HsAM1t2EKh95yw==
X-Received: by 2002:a05:600c:2251:b0:42e:d4a2:ce67 with SMTP id
 5b1f17b1804b1-42ed4a2cf87mr17796885e9.17.1727278881149; 
 Wed, 25 Sep 2024 08:41:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e90cc28c5sm40472275e9.1.2024.09.25.08.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:41:20 -0700 (PDT)
Message-ID: <d46bfeba-937a-435d-a804-c17cdfee4a88@redhat.com>
Date: Wed, 25 Sep 2024 17:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/23] hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-16-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-16-shentey@gmail.com>
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
>   hw/ppc/mpc8544_guts.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
> index 6688fd44c3..cbb1e3adda 100644
> --- a/hw/ppc/mpc8544_guts.c
> +++ b/hw/ppc/mpc8544_guts.c
> @@ -18,7 +18,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "qemu/module.h"
>   #include "qemu/log.h"
>   #include "sysemu/runstate.h"
>   #include "cpu.h"
> @@ -141,16 +140,13 @@ static void mpc8544_guts_initfn(Object *obj)
>       sysbus_init_mmio(d, &s->iomem);
>   }
>   
> -static const TypeInfo mpc8544_guts_info = {
> -    .name          = TYPE_MPC8544_GUTS,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(GutsState),
> -    .instance_init = mpc8544_guts_initfn,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_MPC8544_GUTS,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(GutsState),
> +        .instance_init = mpc8544_guts_initfn,
> +    },
>   };
>   
> -static void mpc8544_guts_register_types(void)
> -{
> -    type_register_static(&mpc8544_guts_info);
> -}
> -
> -type_init(mpc8544_guts_register_types)
> +DEFINE_TYPES(types)


