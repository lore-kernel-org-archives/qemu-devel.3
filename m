Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4046D10C16
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 10:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t50Sx-0002IX-Ot; Sun, 27 Oct 2024 06:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t50Su-0002IG-Ib
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 06:25:44 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t50Ss-0003YI-OF
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 06:25:44 -0400
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-5ec1ee25504so666319eaf.3
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 03:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730024741; x=1730629541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyvR9QAUL9q1MqrZ6V1/n4eHMd0qose9TrWGI90P8+M=;
 b=dsq2KidpbpxHkoCIN/AoDU0CfCAtb66B7c/iwhi2TSOMJ/tuek9rQn+lVUUBE/V1SQ
 Sh6oDBpxK7FfYKRrv3YjWrDr76oYkYhikRLoyPbekCw2sz9P6WReJ1EB1c+JOrgmW/PA
 uohCNvNdTwcJ0bY2Sq7G7AhjzeBi/u67cIlDHXOcV6Djh9TxaFC/1TAtR6qbFezH0a0W
 IAkMjCQHUyRG1GdL05IiszdJJwfym9CfQaSDBQI+Di8YmL72Crpzv/4gU68GbiCyxfh3
 H7XGeIR9w30TIH3zOKwaqIYcX4EslW0ZQUaaXxPNAwogNcsrbms2JfxMP1TKETXvo20y
 J66g==
X-Gm-Message-State: AOJu0YwOCm0vY7/Cu+7+DHP331/Pxu5S1qpBh3TKy3SYtlfnGf3MDpyO
 ApM6DAPjZtz7v43e6wYD7KJ5NwbHuXt9Y6rxIbl+5X31wADua9Eo
X-Google-Smtp-Source: AGHT+IF0xkG6r1QqhGeC0MwVLBA7hVk5d/cvjoMu1sPOMkBcnh8vJtWE8st0cbGM2vxZRzAFMkd23Q==
X-Received: by 2002:a05:6820:1b8f:b0:5eb:d1ac:21c6 with SMTP id
 006d021491bc7-5ec23a66c3bmr2551524eaf.5.1730024740973; 
 Sun, 27 Oct 2024 03:25:40 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ec186fcf2fsm1147513eaf.36.2024.10.27.03.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 03:25:40 -0700 (PDT)
Date: Sun, 27 Oct 2024 11:25:36 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 07/36] next-cube: introduce next_pc_init() object init
 function
Message-ID: <20241027112536.66bb97b7@tpx1>
In-Reply-To: <20241023085852.1061031-8-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.161.54; envelope-from=th.huth@gmail.com;
 helo=mail-oo1-f54.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:23 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move initialisation of the memory regions and GPIOs from next_pc_realize() to
> the new next_pc_init() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 0c3f8780a1..3b4c361156 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -897,20 +897,24 @@ static void next_pc_reset(DeviceState *dev)
>  
>  static void next_pc_realize(DeviceState *dev, Error **errp)
>  {
> -    NeXTPC *s = NEXT_PC(dev);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    /* SCSI */
> +    next_scsi_init(dev);
> +}
> +
> +static void next_pc_init(Object *obj)
> +{
> +    NeXTPC *s = NEXT_PC(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>  
> -    qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
> +    qdev_init_gpio_in(DEVICE(obj), next_irq, NEXT_NUM_IRQS);
>  
>      memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
>                            "next.mmio", 0x9000);
>      memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
>                            "next.scr", 0x20000);
> +
>      sysbus_init_mmio(sbd, &s->mmiomem);
>      sysbus_init_mmio(sbd, &s->scrmem);
> -
> -    /* SCSI */
> -    next_scsi_init(dev);
>  }
>  
>  /*
> @@ -972,6 +976,7 @@ static void next_pc_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo next_pc_info = {
>      .name = TYPE_NEXT_PC,
>      .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = next_pc_init,
>      .instance_size = sizeof(NeXTPC),
>      .class_init = next_pc_class_init,
>  };

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

