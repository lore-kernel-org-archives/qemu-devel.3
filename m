Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221D2CCF9E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU83-0002cu-1a; Wed, 25 Sep 2024 11:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU81-0002Xr-HR
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU80-0004e4-18
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0AC++zNxn19gufWT1YMeDR1ogYVOFl7G4S5cy94/Tw=;
 b=CoVLpNNyJ69xznb6PGUkBWF4Hs/3WC+vo330vyhlHWNjJZM6Z63mkam5faemlRUXP4PZww
 QOv4RR5EkHWO5nWdUga68ivx3jM6NDQjuG0kB0HqjvL1/nbBqUSkNGDbEhtqgxU1bQv3OD
 N6agLdjbpR1sYzDOXOG1k+FGLfl2THM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-J9NoqjLhPxa7E230OwycvA-1; Wed, 25 Sep 2024 11:40:29 -0400
X-MC-Unique: J9NoqjLhPxa7E230OwycvA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso57194445e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278828; x=1727883628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0AC++zNxn19gufWT1YMeDR1ogYVOFl7G4S5cy94/Tw=;
 b=t3nWBx5JHiyN3XFH/pa156H7JsfwxsvPVKMqxBNfOJR8rfEOQoJwzWiP48m624OfE4
 AOIcssci7V6kFRlJh+OOZFI+tOU0jWvLG9rtM424qz8Reu6WIqJCAFpmktBO50cIYPZE
 T96X+MUGG8d3T8AIBiiPz7AkQpa59moIFu4Cp7/eQ9ASyoO3k77eJpoe7hZCWX2zI0uL
 URzcX/HSG7UZ6mBYA385L99idB8kN94bCE9sSI4CA5Uq8ZPWm9DqNvKXLVzHHewRozSr
 743a0R/K2/e4qs27Evi/7CFAWKUnQFxUlLXBPL246wYMJrmsuqFbNEXuLnobgKsuwoKg
 lFmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuNcl2yzTLpvTV6UOu3fcMoSAvQUzopw2u0tnhnrEiRKqUKCcefmw1rHC8VuUv/neUpgLb6Co9TJNH@nongnu.org
X-Gm-Message-State: AOJu0YxqEzfsoV3F3qzdGz91t2RPUfK6q/lSrdsQykLx6chtBtILBt6K
 2C+fTS5EmJr12tR2+7dodzk4fNx9/JMPwK5uulQvybxmSdAwGSaw6c2wyq16tp0DtoHtFaGg9JX
 nUIh34k1KtnC7m6aO1mOvLZWGQPJ2/ztNNNMcO61+hDLPP0ul3JiP
X-Received: by 2002:a05:600c:1986:b0:42c:cd88:d0f4 with SMTP id
 5b1f17b1804b1-42e96ab6604mr20366975e9.22.1727278827901; 
 Wed, 25 Sep 2024 08:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEig3B0/DZ24dOG4x8CU/wzwXIBT4ZTMku7tqhAE6mNVmVnUsT14IQsbdomS7cqmH6uhyTkPw==
X-Received: by 2002:a05:600c:1986:b0:42c:cd88:d0f4 with SMTP id
 5b1f17b1804b1-42e96ab6604mr20366825e9.22.1727278827468; 
 Wed, 25 Sep 2024 08:40:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a56fddsm22339085e9.46.2024.09.25.08.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:40:26 -0700 (PDT)
Message-ID: <2a62e3d0-2ac1-4001-bf5f-2373cf240b3a@redhat.com>
Date: Wed, 25 Sep 2024 17:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/23] hw/i2c/mpc_i2c: Convert DPRINTF to trace events for
 register access
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
 <20240923093016.66437-11-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-11-shentey@gmail.com>
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
>   hw/i2c/mpc_i2c.c    | 9 +++++----
>   hw/i2c/trace-events | 5 +++++
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 2467d1a9aa..3d79c15653 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -24,6 +24,7 @@
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
>   #include "qom/object.h"
> +#include "trace.h"
>   
>   /* #define DEBUG_I2C */
>   
> @@ -224,8 +225,8 @@ static uint64_t mpc_i2c_read(void *opaque, hwaddr addr, unsigned size)
>           break;
>       }
>   
> -    DPRINTF("%s: addr " HWADDR_FMT_plx " %02" PRIx32 "\n", __func__,
> -                                         addr, value);
> +    trace_mpc_i2c_read(addr, value);
> +
>       return (uint64_t)value;
>   }
>   
> @@ -234,8 +235,8 @@ static void mpc_i2c_write(void *opaque, hwaddr addr,
>   {
>       MPCI2CState *s = opaque;
>   
> -    DPRINTF("%s: addr " HWADDR_FMT_plx " val %08" PRIx64 "\n", __func__,
> -                                             addr, value);
> +    trace_mpc_i2c_write(addr, value);
> +
>       switch (addr) {
>       case MPC_I2C_ADR:
>           s->adr = value & CADR_MASK;
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index 6900e06eda..f708a7ace1 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -35,6 +35,11 @@ aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, uint64_t va
>   aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte) "%s send %d/%d 0x%02x"
>   aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte) "%s recv %d/%d 0x%02x"
>   
> +# mpc_i2c.c
> +
> +mpc_i2c_read(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] -> 0x%02" PRIx32
> +mpc_i2c_write(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] <- 0x%02" PRIx32
> +
>   # npcm7xx_smbus.c
>   
>   npcm7xx_smbus_read(const char *id, uint64_t offset, uint64_t value, unsigned size) "%s offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"


