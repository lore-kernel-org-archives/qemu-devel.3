Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFFBD5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 08:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gc8-0002r1-Gw; Sat, 09 Nov 2024 03:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gc5-0002qb-Kq
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:14:33 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gc3-0002jo-Gc
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:14:33 -0500
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so4942561a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 00:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731140070; x=1731744870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFwG4YkUOmu5teG642vX6v5tfAtVMgKfNQCZ1ZNaw0o=;
 b=Sk1+oUxBqmI92jue1+wNbBb81YtGfpZwRWLO7R7WtmXtWXf+XwR+egzPgq5B4G+MiW
 wtF2PKdAk42YX8s/Hd843kRMElPlDhmbygTXvSh1whlchFW3iCDZgl5jsBMSj9iER+pg
 qKz14ejFqMrs48+Jejk3ZeOdx2ku9n/QmMRv71VUWFiGZy4zVsfu6IueJSZBt8ltT4+1
 EiGqOhbENs9XhgsYF04HvQ/5hPvhtw6Ztnty/J5hqnM4xfoaeTxzGYkkPFyrLwEy1Sm1
 3rZ9tJg8GCZ7raFhgVt869U3u3+CxV8aHIH/TKDjYB1jP1Spri7wkpIYz9OUlurk2IH4
 FKaw==
X-Gm-Message-State: AOJu0YxrjiHt5k4NiOL6dJn5QIvBRzP5z69IfKHia0qc7GuSFuhg+5v8
 AF7MIvvvyb18cVoXkWydGRuY37Sv5sVFoH1l/EOaBGDoPOlN8NyG
X-Google-Smtp-Source: AGHT+IHu5aMk2ASKBBAGFF2PGIUzBEHJ5130AFjuyqiUfnO4JG9/0v9lhPiLU44tjAmE0Zye6fAcOQ==
X-Received: by 2002:a05:6402:2552:b0:5ce:c7b1:e052 with SMTP id
 4fb4d7f45d1cf-5cf0a49307cmr5297405a12.9.1731140069790; 
 Sat, 09 Nov 2024 00:14:29 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03bb6dd4sm2763695a12.41.2024.11.09.00.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 00:14:28 -0800 (PST)
Date: Sat, 9 Nov 2024 09:14:26 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 27/36] next-cube: QOMify NeXTRTC
Message-ID: <20241109091426.0f636645@tpx1>
In-Reply-To: <20241023085852.1061031-28-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-28-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.43; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f43.google.com
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

Am Wed, 23 Oct 2024 09:58:43 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This is to allow the RTC functionality to be maintained within its own separate
> device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 66 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index e4d0083eb0..6b574d39cf 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -42,7 +42,13 @@
>  #define RAM_SIZE    0x4000000
>  #define ROM_FILE    "Rev_2.5_v66.bin"
>  
> -typedef struct NeXTRTC {
> +
> +#define TYPE_NEXT_RTC "next-rtc"
> +OBJECT_DECLARE_SIMPLE_TYPE(NeXTRTC, NEXT_RTC)
> +
> +struct NeXTRTC {
> +    SysBusDevice parent_obj;
> +
>      int8_t phase;
>      uint8_t ram[32];
>      uint8_t command;
> @@ -50,7 +56,7 @@ typedef struct NeXTRTC {
>      uint8_t status;
>      uint8_t control;
>      uint8_t retval;
> -} NeXTRTC;
> +};
>  
>  #define TYPE_NEXT_SCSI "next-scsi"
>  OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
> @@ -1012,6 +1018,37 @@ static const MemoryRegionOps next_dummy_en_ops = {
>      .endianness = DEVICE_BIG_ENDIAN,
>  };
>  
> +static const VMStateDescription next_rtc_vmstate = {
> +    .name = "next-rtc",
> +    .version_id = 3,
> +    .minimum_version_id = 3,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_INT8(phase, NeXTRTC),
> +        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
> +        VMSTATE_UINT8(command, NeXTRTC),
> +        VMSTATE_UINT8(value, NeXTRTC),
> +        VMSTATE_UINT8(status, NeXTRTC),
> +        VMSTATE_UINT8(control, NeXTRTC),
> +        VMSTATE_UINT8(retval, NeXTRTC),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void next_rtc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "NeXT RTC";
> +    dc->vmsd = &next_rtc_vmstate;
> +}
> +
> +static const TypeInfo next_rtc_info = {
> +    .name = TYPE_NEXT_RTC,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(NeXTRTC),
> +    .class_init = next_rtc_class_init,
> +};
> +
>  static void next_pc_rtc_data_in_irq(void *opaque, int n, int level)
>  {
>      NeXTPC *s = NEXT_PC(opaque);
> @@ -1078,6 +1115,12 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
>      sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
> +
> +    /* RTC */
> +    d = DEVICE(object_resolve_path_component(OBJECT(dev), "rtc"));
> +    if (!sysbus_realize(SYS_BUS_DEVICE(d), errp)) {
> +        return;
> +    }
>  }
>  
>  static void next_pc_init(Object *obj)
> @@ -1111,6 +1154,8 @@ static void next_pc_init(Object *obj)
>                            "next.timer", 4);
>      sysbus_init_mmio(sbd, &s->timer_mem);
>  
> +    object_initialize_child(obj, "rtc", &s->rtc, TYPE_NEXT_RTC);
> +
>      s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
>      qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
>                              "pc-rtc-data-in", 1);
> @@ -1129,22 +1174,6 @@ static Property next_pc_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static const VMStateDescription next_rtc_vmstate = {
> -    .name = "next-rtc",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_INT8(phase, NeXTRTC),
> -        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
> -        VMSTATE_UINT8(command, NeXTRTC),
> -        VMSTATE_UINT8(value, NeXTRTC),
> -        VMSTATE_UINT8(status, NeXTRTC),
> -        VMSTATE_UINT8(control, NeXTRTC),
> -        VMSTATE_UINT8(retval, NeXTRTC),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
>  static const VMStateDescription next_pc_vmstate = {
>      .name = "next-pc",
>      .version_id = 3,
> @@ -1297,6 +1326,7 @@ static void next_register_type(void)
>      type_register_static(&next_typeinfo);
>      type_register_static(&next_pc_info);
>      type_register_static(&next_scsi_info);
> +    type_register_static(&next_rtc_info);
>  }
>  
>  type_init(next_register_type)

Shouldn't the next_rtc_vmstate get removed from next_pc_vmstate now?

Also, should we finally move the RTC code to a separate file?

 Thomas

