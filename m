Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D611DD3399E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SmV-0002Xc-Gj; Mon, 28 Oct 2024 12:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SmU-0002XL-2A
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:39:50 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SmN-00017H-Fy
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:39:48 -0400
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so6071935a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730133582; x=1730738382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRveW/H/n3S4ShMAZIpYqY6o6Sr+e8SgEav6mP2pZyg=;
 b=GV0xMsK09LdY+pFgzy3/JdbOvQ7hglUHq+uImUdxqci7m6QexZGFvEC7XkE8k6gFJh
 uz9UWr4SGlZ6aaZ3HzC5fOsiDzpRKB+A6favMrfiwssTcEXQDQT0kCAa/+GbyObpPgMW
 hHdEz7xPfIsuxitj/O7dQoEzFlCPxqr5HDeT+qFzurNHtxdnuK9ZEtSvXSl/0Aa+semJ
 TR3975NBDEOUk7iV/+BD4oUwHhRYKLiJPrHJiHHPAbWp5rlziw6EiSjiacCh6whIXr1q
 w2kcj+PaPEshQcyXR3v9i0j0MgsTqp38kbRgPoT9fCakDUl5XWcgXAYRO3365JsMdonK
 Slww==
X-Gm-Message-State: AOJu0YwPYkFOqsM9NHzgKIRb054yGqIXpTZbS7F4In8cKPm1S6Di4VKm
 zoi1Pui+7hpDSIs/TcdzbmbZK6A/UcR1LlLh3EnM/NnnG9ovKY7c
X-Google-Smtp-Source: AGHT+IFrLjTTTb3NAYyYlJsdSo44u7JYTONX6aBYt7/SikrH+Gt4UEjLwuGRqOe3wdFfs9OLR88cOQ==
X-Received: by 2002:a17:907:9449:b0:a99:f92a:7a66 with SMTP id
 a640c23a62f3a-a9de5d783e5mr847020966b.30.1730133581475; 
 Mon, 28 Oct 2024 09:39:41 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f2982c4sm392267766b.102.2024.10.28.09.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:39:41 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:39:39 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/36] next-cube: move ESCC to be QOM child of next-pc
 device
Message-ID: <20241028173939.6fada306@tpx1>
In-Reply-To: <20241023085852.1061031-14-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.41; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:29 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Since the ESCC is part of the next-pc device, move the ESCC to be a QOM child
> of the next-pc device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 54 ++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 7f714640da..915dd80f6f 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -124,6 +124,8 @@ struct NeXTPC {
>      qemu_irq scsi_reset;
>      qemu_irq scsi_dma;
>  
> +    ESCCState escc;
> +
>      NextRtc rtc;
>  };
>  
> @@ -978,31 +980,6 @@ static const MemoryRegionOps next_floppy_ops = {
>      .endianness = DEVICE_BIG_ENDIAN,
>  };
>  
> -static void next_escc_init(DeviceState *pcdev)
> -{
> -    NeXTPC *next_pc = NEXT_PC(pcdev);
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -
> -    dev = qdev_new(TYPE_ESCC);
> -    qdev_prop_set_uint32(dev, "disabled", 0);
> -    qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
> -    qdev_prop_set_uint32(dev, "it_shift", 0);
> -    qdev_prop_set_bit(dev, "bit_swap", true);
> -    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
> -    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
> -    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> -    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> -
> -    s = SYS_BUS_DEVICE(dev);
> -    sysbus_realize_and_unref(s, &error_fatal);
> -    sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
> -    sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
> -
> -    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
> -                                sysbus_mmio_get_region(s, 0));
> -}
> -
>  static void next_pc_reset(DeviceState *dev)
>  {
>      NeXTPC *s = NEXT_PC(dev);
> @@ -1043,6 +1020,28 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>      /* Floppy */
>      memory_region_add_subregion(&s->scrmem, 0x14108,
>                                  &s->floppy_mem);
> +
> +    /* ESCC */
> +    d = DEVICE(object_resolve_path_component(OBJECT(dev), "escc"));
> +    qdev_prop_set_uint32(d, "disabled", 0);
> +    qdev_prop_set_uint32(d, "frequency", 9600 * 384);
> +    qdev_prop_set_uint32(d, "it_shift", 0);
> +    qdev_prop_set_bit(d, "bit_swap", true);
> +    qdev_prop_set_chr(d, "chrB", serial_hd(1));
> +    qdev_prop_set_chr(d, "chrA", serial_hd(0));
> +    qdev_prop_set_uint32(d, "chnBtype", escc_serial);
> +    qdev_prop_set_uint32(d, "chnAtype", escc_serial);
> +
> +    sbd = SYS_BUS_DEVICE(d);
> +    if (!sysbus_realize(sbd, errp)) {
> +        return;
> +    }
> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
> +    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
> +
> +    memory_region_add_subregion(&s->scrmem, 0x18000,
> +                                sysbus_mmio_get_region(sbd, 0));

You could also keep the next_escc_init() function, and call next_escc_init()
here?

 Thomas


>  }
>  
>  static void next_pc_init(Object *obj)
> @@ -1064,6 +1063,8 @@ static void next_pc_init(Object *obj)
>  
>      memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
>                            "next.floppy", 4);
> +
> +    object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
>  }
>  
>  /*
> @@ -1201,9 +1202,6 @@ static void next_cube_init(MachineState *machine)
>          }
>      }
>  
> -    /* Serial */
> -    next_escc_init(pcdev);
> -
>      /* TODO: */
>      /* Network */
>  

