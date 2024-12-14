Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DDFE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 06:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMLMp-0000Vc-RQ; Sat, 14 Dec 2024 01:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMLMn-0000V8-PN
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:11:05 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMLMm-0000cW-5o
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:11:05 -0500
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso4371090a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 22:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734156662; x=1734761462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8RJ6vJ/3zNUftyI/sZZLgeInvlBKWTAqCIEodYSWh0=;
 b=JkloV6P+ClVF9bO1ERTuzOUAKnaflLZSbntexAoy6rcGfsQSgaKwtmHAlGSFJGcoGs
 VCeyNf0oA7nltxxSZq6R4jDiIahExsSJ0CYfh4gfJZKGgh5hOhJg1rhxf9RlG+Ufp1n2
 mAqlOqLky8COACY6ZSA/O1wi/PxzcOInMyTfVGmOIN7zR/o5xcE1o2FDIr/rQuOXQQkR
 pjCa5ZTLx6tK6SyXiqbYx90lAGCDNyrbsUohwlGRArB0C2u6ec0scyitPEA2iNBL5vDF
 uSBCKs4OBH7/lnqJzKlklGuUiCdZZ9OQ/Xl6vOFKUiHkI74IQexsQKeW8+z+QMxYCR9B
 FdPw==
X-Gm-Message-State: AOJu0Yz6VAtA4iXrahArt8wAHXNi1ALHx6Drp44hcF9zzPESNTmm9mrh
 krPsZYwk9GNZbMQ0Mn4fLjPqJ/5mlIXmBHhRMV8UeKeD+QnnjO8f
X-Gm-Gg: ASbGncuNE5riDRcD7I7Yn8zRc/xWxR3LfU/kq+YEimJSWRGA2DB7wqJRGNEE1EHe0V5
 3tPHwa/Lh1j8HUnqtRByNMy1VW7052xKy1ZzQtB9yFA3vySUvhsmqxzXjkD6LFrkGdTJrRQ0qX6
 7VFhC3/hN9gRPyPTvFDO56KPA46wzNimZM4wMvZiwLqBwPgPpTj/tmifMRL5YAwiqbIoL+0qBAR
 iRkYVKhYJDDnDa397z4ZEyBUALCNu+JG8vFxfBIdyFbrZTypTUAdg4NNSsBu6fGWwhsKxQNsR1Z
X-Google-Smtp-Source: AGHT+IGYzMi/jx7mkTXhwWjJvQu0bmGs1YvWC0bbT9uVYnbKlDPYqpqNIhpe6wpaCEoir7l7DIk5QA==
X-Received: by 2002:a05:6402:40c8:b0:5d3:bc1d:e56b with SMTP id
 4fb4d7f45d1cf-5d63c33b318mr4591095a12.16.1734156662394; 
 Fri, 13 Dec 2024 22:11:02 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652f270bfsm611842a12.61.2024.12.13.22.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 22:11:01 -0800 (PST)
Date: Sat, 14 Dec 2024 07:10:58 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/34] next-cube: move ESCC to be QOM child of
 next-pc device
Message-ID: <20241214071058.7097e28d@tpx1>
In-Reply-To: <20241212114620.549285-12-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.45; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f45.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Thu, 12 Dec 2024 11:45:57 +0000
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
> index efbb11e74b..20a0b073e1 100644
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

Can't you use s->escc directly here instead of taking the detour via
object_resolve_path_component() ?

 Thomas

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
> +
>  }

