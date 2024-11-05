Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEAED2B925
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jdh-0000x8-FY; Tue, 05 Nov 2024 08:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JdX-0000rD-A2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:30:29 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JdS-0007Ds-Hn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:30:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso43096075e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730813415; x=1731418215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Sss8rKk7Z6a7rjC/2C5ln/J+KjDoS++adVNtsROyxw=;
 b=MkRBm/lcl7rnmercMiawqUst6kZ3f8DcWAF9Z0ACPZCeHbkoWE7quAx+f6xYo7/pob
 5qnRaQngfyUdvUpT9+vheHbw172JOBim/k8jRbLDrMWdJwM051Knjt0IOatfKhbovZ5L
 DGNVoFx9xave16gpOISws+GdEWYRanIWpuguiIxy/xF4h3eVGMpYZWYvVyHGLnTelRIM
 EtolBCCPwvnoPparMdhesZfjqZ4hOr2d8i0kl7ODwYu4qGqMFy7iYlTwlDJ9qTtvuAeC
 UGfQ6yHAffcFqQMR8ZA5Qg9WrFgtu7S2XBjnHxmi8NKi9zJgkVAyqhep34KR3ZPBYIZZ
 FN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813415; x=1731418215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Sss8rKk7Z6a7rjC/2C5ln/J+KjDoS++adVNtsROyxw=;
 b=gORol3WTRP/vIKKmIc2A8qiGTKoTTBoVc0zfxTKy9OvR1dNgxgPwItveI6rcMtPGIN
 XhkNFNISelyn+VTmM/zoe+3iSoOm5lNLAFvlEAJeygwRBBNQdenCYUs3ISMsm86roztW
 j0sehf4eAQ2gjAmpAwhF9fNW3gKYAIvgU+a4g0sB8uijiv2E7hW3ERQDJS0oo+Bic2DY
 klnVrJa/J6wgSdNj45bhDsaSgWmlbA7doqjjDsaUgKfv9G8HFDof05s+VoCfSh65Pp1l
 d7tg36Bm26oI6X9eZRiV2xqdp+ovTbF5/eYmLuzCJyl/O79wJzttuI9iKITN2FLGIe6R
 bC5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSDHUPC2Y3ZFoHI9yzKvthZwxW5Fcy8vdJJe5SGiuN5gt6AUcmRrQLlzlaDCM3x9a48g1+LernnBG/@nongnu.org
X-Gm-Message-State: AOJu0YzULwErFd2Yr1rMPUUHnbyTY2FqbWzPrvsyAvlsaN0Xhm4eaaXM
 h0pqVWhJQhUGGxnzzIcknSewCDFSnGLT6QdKXH5nAiTLBeHTUy3/6bizuQ2fmbA=
X-Google-Smtp-Source: AGHT+IFZc24pmt1V56Jtb16Y4WTKNsiX0dpnPuCPusBBuC9mNudF9Kv+GvOqR5vEaapqvvW9bCrH2g==
X-Received: by 2002:a05:600c:3b93:b0:431:5ab3:d28d with SMTP id
 5b1f17b1804b1-4319ac9a6c9mr326871625e9.9.1730813414598; 
 Tue, 05 Nov 2024 05:30:14 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e8549sm224611245e9.10.2024.11.05.05.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:30:14 -0800 (PST)
Message-ID: <5f3a4435-dfd2-48cc-8b95-35b8bdd07810@linaro.org>
Date: Tue, 5 Nov 2024 13:30:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] hw/net/xilinx_ethlite: Only expect big-endian
 accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> The Xilinx 'ethlite' device was added in commit b43848a100
> ("xilinx: Add ethlite emulation"), being only built back
> then for a big-endian MicroBlaze target (see commit 72b675caac
> "microblaze: Hook into the build-system").
> 
> I/O endianness access was then clarified in commit d48751ed4f
> ("xilinx-ethlite: Simplify byteswapping to/from brams"). Here
> the 'fix' was to use tswap32(). Since the machine was built as
> big-endian target, tswap32() use means the fix was for a little
> endian host. While the datasheet (reference added in file header)
> is not precise about it, we interpret such change as the device
> expects accesses in big-endian order. Besides, this is what other
> Xilinx/MicroBlaze devices use (see the 3 previous commits).
> 
> Correct the MemoryRegionOps endianness. Add a 'access-little-endian'
> property, so if the bus access expect little-endian order we swap
> the values. Replace the tswap32() calls accordingly.
> 
> Set the property on the single machine using this device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/net/xilinx_ethlite.c                  | 20 ++++++++++++++++----
>   2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 8110be83715..8407dbee12a 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -123,6 +123,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>       qemu_configure_nic_device(dev, true, NULL);
>       qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
>       qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> +    qdev_prop_set_bit(dev, "access-little-endian", !TARGET_BIG_ENDIAN);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index ede7c172748..44ef11ebf89 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -3,6 +3,9 @@
>    *
>    * Copyright (c) 2009 Edgar E. Iglesias.
>    *
> + * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
> + * LogiCORE IP XPS Ethernet Lite Media Access Controller
> + *
>    * Permission is hereby granted, free of charge, to any person obtaining a copy
>    * of this software and associated documentation files (the "Software"), to deal
>    * in the Software without restriction, including without limitation the rights
> @@ -25,7 +28,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qom/object.h"
> -#include "exec/tswap.h"
>   #include "hw/sysbus.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
> @@ -65,6 +67,7 @@ struct xlx_ethlite
>       NICState *nic;
>       NICConf conf;
>   
> +    bool access_little_endian;
>       uint32_t c_tx_pingpong;
>       uint32_t c_rx_pingpong;
>       unsigned int txbuf;
> @@ -103,9 +106,12 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>               break;
>   
>           default:
> -            r = tswap32(s->regs[addr]);
> +            r = s->regs[addr];
>               break;
>       }
> +    if (s->access_little_endian) {
> +        bswap32s(&r);
> +    }
>       return r;
>   }
>   
> @@ -117,6 +123,10 @@ eth_write(void *opaque, hwaddr addr,
>       unsigned int base = 0;
>       uint32_t value = val64;
>   
> +    if (s->access_little_endian) {
> +        bswap32s(&value);
> +    }
> +
>       addr >>= 2;
>       switch (addr)
>       {
> @@ -161,7 +171,7 @@ eth_write(void *opaque, hwaddr addr,
>               break;
>   
>           default:
> -            s->regs[addr] = tswap32(value);
> +            s->regs[addr] = value;
>               break;
>       }
>   }
> @@ -169,7 +179,7 @@ eth_write(void *opaque, hwaddr addr,
>   static const MemoryRegionOps eth_ops = {
>       .read = eth_read,
>       .write = eth_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_BIG_ENDIAN,
>       .impl = {
>           .min_access_size = 4,
>           .max_access_size = 4,
> @@ -256,6 +266,8 @@ static void xilinx_ethlite_init(Object *obj)
>   }
>   
>   static Property xilinx_ethlite_properties[] = {
> +    DEFINE_PROP_BOOL("access-little-endian", struct xlx_ethlite,
> +                     access_little_endian, false),

I'm not a fan of performing any swapping within device code.
The memory subsystem should do all of it.

A better solution is two tables, eth_ops_{be,le}, which differ only in the setting of 
.endianness.  Handle the property by registering the correct MemoryRegionOps during init.


r~

