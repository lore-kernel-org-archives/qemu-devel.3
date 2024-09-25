Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0683ECCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU8n-0006Rw-6e; Wed, 25 Sep 2024 11:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8l-0006D1-7M
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU8j-0004jG-MY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysRQIWvzyFqOtedCk0dqe6mf2jKhXL5/dQPJvzBbMB8=;
 b=OFxZ1GBqy3ARpBJSpT9xeeKAnBvza1Ljt1fgThTLjPBfdRrtL0kwSv59C3eOdyiUPiV1wd
 p1NOm+/zk8C3bzPcTlyQ/rYIHpzBUoO/XoOADBhlkNyQ2cxDJ2u1XF794C/kd+FyOZeIJM
 hGybOBIpnK6BucoZgxwAwCZm2vSxLwU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Eek7Smv1PMWU7wj3Q_CH5w-1; Wed, 25 Sep 2024 11:41:15 -0400
X-MC-Unique: Eek7Smv1PMWU7wj3Q_CH5w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb6f3c476so53151685e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278874; x=1727883674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysRQIWvzyFqOtedCk0dqe6mf2jKhXL5/dQPJvzBbMB8=;
 b=MLGNN2PScAmZpSGVQYBrGqOZIFGmb0pNVrFUbLkdRem6N83XZMbbaGXbVPcCVoLSO6
 ENKud4pd8sB/gnu4fql8qzNxM6vtvpFgnM4egwwLHWtT/qJ909j5R0WmHT8iqN3VmgL1
 rFA+kFsk6q69h5/jIjTuVf+Ls2mkFH1pygVUvaSncgyP3H6kekGpgS/drr9rxmQNhAqE
 dV66vU0863ps0Rss+BhTEjUqM6mMfzILiDiBN/kjtPZtk2zcML3s4z/NOZsXjY5B6/V1
 AQbolqmRXisCtYyzlrDpW95Xwufh+YAhGsVFGtLjCsUJN/OZ+ohaybIGa2DQpAx2vAGO
 7KLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkUaLqh/trPQtvaeRZn/bWs9vo61EGCSZ1J4AShl2c1Y384oE8ploYYFCq1uRfDVM4sZvUcvx91Xuj@nongnu.org
X-Gm-Message-State: AOJu0YzAQougNRH0djiewZQ1p/Fs5Ef/8aXW7O4acxLNe6FllAOE2y52
 miQn4NnhPRLWLB1x5e8JZhmCjjZD+t2mySEyhUArB6AEoixJOClBye1jWgiOzPNL548NsLqkLHP
 xLaapasaBECmD+ul62mFhSodOCidyQCuHV+wRaHXdbZwFge6ZmtFm
X-Received: by 2002:a05:600c:510f:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42e96113c15mr19624905e9.15.1727278873940; 
 Wed, 25 Sep 2024 08:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSlO4z/cOv8Y+z1CN1qkEu3vlm1wYJq9i8a75lkfbumwMrVOCvgI4KQwslkG7PhjAd0x5wvQ==
X-Received: by 2002:a05:600c:510f:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42e96113c15mr19624665e9.15.1727278873535; 
 Wed, 25 Sep 2024 08:41:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddcc4sm22254895e9.10.2024.09.25.08.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:41:13 -0700 (PDT)
Message-ID: <28288bc1-1f2e-4689-8551-6f62822c2f7d@redhat.com>
Date: Wed, 25 Sep 2024 17:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/23] hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-15-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-15-shentey@gmail.com>
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
>   hw/gpio/mpc8xxx.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
> index 63b7a5c881..de183c3be5 100644
> --- a/hw/gpio/mpc8xxx.c
> +++ b/hw/gpio/mpc8xxx.c
> @@ -23,7 +23,6 @@
>   #include "hw/irq.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
> -#include "qemu/module.h"
>   #include "qom/object.h"
>   
>   #define TYPE_MPC8XXX_GPIO "mpc8xxx_gpio"
> @@ -208,17 +207,14 @@ static void mpc8xxx_gpio_class_init(ObjectClass *klass, void *data)
>       device_class_set_legacy_reset(dc, mpc8xxx_gpio_reset);
>   }
>   
> -static const TypeInfo mpc8xxx_gpio_info = {
> -    .name          = TYPE_MPC8XXX_GPIO,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(MPC8XXXGPIOState),
> -    .instance_init = mpc8xxx_gpio_initfn,
> -    .class_init    = mpc8xxx_gpio_class_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_MPC8XXX_GPIO,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(MPC8XXXGPIOState),
> +        .instance_init = mpc8xxx_gpio_initfn,
> +        .class_init    = mpc8xxx_gpio_class_init,
> +    },
>   };
>   
> -static void mpc8xxx_gpio_register_types(void)
> -{
> -    type_register_static(&mpc8xxx_gpio_info);
> -}
> -
> -type_init(mpc8xxx_gpio_register_types)
> +DEFINE_TYPES(types)


