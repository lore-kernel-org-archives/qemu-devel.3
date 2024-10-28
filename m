Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383A3D33998
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SUn-0002Tg-Ev; Mon, 28 Oct 2024 12:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SUk-0002TK-G3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:21:30 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SUg-0007Oj-Ua
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:21:29 -0400
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so649697966b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730132485; x=1730737285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujCgznPAvfOqwxYYGTh+Jxc6ru/OpPIevaYe1xo7iVI=;
 b=SdGePoYAopCmSZNEMsgI0519P0piz1mws99HCe3UpkL1s1NRdbwECz5KqpJLv1HQyM
 peGNLxyysNEWyW2XhmgSvVOgRktlfLH8U/3bhknhZ5tHWn0/XFzdrRWD6z5KB6TQIsF7
 hWrgmg3TUbFqecMmcDew0PqfDtTJd50zCwwIAbHDZhcMC46LKGNTM4HD8uTPozG7bAYI
 UAk/Nph5jEc1X0xow8EmuAwhZindf039Bn0B7GRGm+bg1hJKtWR68NeR9wtyDe0j1iXb
 VW1b42o7AndZBl5Y+MI3AhVef6yi5hrP60QJ8gJJRjHvUc9vgSmJe59qchUzO20Vx/w3
 tFrw==
X-Gm-Message-State: AOJu0Yzh8FGJFIPC4Bfl7Tqk5P4Q1ukNciF6hyAZcx4UasHK346HTnFS
 dfVvb2i1ho72rLukobfySGE/V8OWn9eJ+KnjMYidqRyRd/SE4Xzn
X-Google-Smtp-Source: AGHT+IHKAkJFvcssWzNCv8ySmO+ia/FvVdGVWKHE/9vO+Tx+z9JiklS5TARIq4WlNJDl93pExdb6Ig==
X-Received: by 2002:a17:907:970a:b0:a9a:14fc:9868 with SMTP id
 a640c23a62f3a-a9de5c9225fmr805690666b.4.1730132484508; 
 Mon, 28 Oct 2024 09:21:24 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1dec7fdbsm388981066b.39.2024.10.28.09.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:21:23 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:21:22 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 09/36] next-cube: move SCSI CSRs from next-pc to the
 next-scsi device
Message-ID: <20241028172122.23bcb98c@tpx1>
In-Reply-To: <20241023085852.1061031-10-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.52; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am Wed, 23 Oct 2024 09:58:25 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The SCSI CSRs are located within the SCSI subsystem of the NeXT PC (Peripheral
> Contoller) which is now modelled as a separate QEMU device.
> 
> Add a new VMStateDescription for the next-scsi device to enable the SCSI CSRs
> to be migrated.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 88 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 266f57ac63..32466a425f 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -93,6 +93,10 @@ struct NeXTSCSI {
>      MemoryRegion scsi_mem;
>  
>      SysBusESPState sysbus_esp;
> +
> +    MemoryRegion scsi_csr_mem;
> +    uint8_t scsi_csr_1;
> +    uint8_t scsi_csr_2;
>  };
>  
>  #define TYPE_NEXT_PC "next-pc"
> @@ -115,8 +119,6 @@ struct NeXTPC {
>      uint32_t led;
>  
>      NeXTSCSI next_scsi;
> -    uint8_t scsi_csr_1;
> -    uint8_t scsi_csr_2;
>  
>      qemu_irq scsi_reset;
>      qemu_irq scsi_dma;
> @@ -364,6 +366,7 @@ static const MemoryRegionOps next_mmio_ops = {
>  static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>  {
>      NeXTPC *s = NEXT_PC(opaque);
> +    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
>      uint64_t val;
>  
>      switch (addr) {
> @@ -373,12 +376,12 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>          break;
>  
>      case 0x14020:
> -        DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
> -        val = s->scsi_csr_1;
> +        DPRINTF("SCSI 4020  STATUS READ %X\n", ns->scsi_csr_1);
> +        val = ns->scsi_csr_1;
>          break;
>  
>      case 0x14021:
> -        DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
> +        DPRINTF("SCSI 4021 STATUS READ %X\n", ns->scsi_csr_2);
>          val = 0x40;
>          break;
>  
> @@ -411,6 +414,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>                               unsigned size)
>  {
>      NeXTPC *s = NEXT_PC(opaque);
> +    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
>  
>      switch (addr) {
>      case 0x14108:
> @@ -445,7 +449,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>              DPRINTF("SCSICSR Reset\n");
>              /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
>              qemu_irq_raise(s->scsi_reset);
> -            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
> +            ns->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
>              qemu_irq_lower(s->scsi_reset);
>          }
>          if (val & SCSICSR_DMADIR) {
> @@ -838,6 +842,54 @@ static void nextscsi_write(void *opaque, uint8_t *buf, int size)
>      nextdma_write(opaque, buf, size, NEXTDMA_SCSI);
>  }
>  
> +static void next_scsi_csr_write(void *opaque, hwaddr addr, uint64_t val,
> +                                unsigned size)
> +{
> +    NeXTSCSI *s = NEXT_SCSI(opaque);
> +
> +    switch (addr) {
> +    case 0:
> +        s->scsi_csr_1 = val;
> +        break;
> +
> +    case 1:
> +        s->scsi_csr_2 = val;
> +        break;

The old code never set the scsi_csr_x directly like this, so I'm not sure
whether this is right?

Also, maybe best squash this patch together with the next patch, otherwise
this is temporary change in behaviour, isn't it?

 Thomas


> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static uint64_t next_scsi_csr_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    NeXTSCSI *s = NEXT_SCSI(opaque);
> +    uint64_t val;
> +
> +    switch (addr) {
> +    case 0:
> +        val = s->scsi_csr_1;
> +        break;
> +
> +    case 1:
> +        val = s->scsi_csr_2;
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps next_scsi_csr_ops = {
> +    .read = next_scsi_csr_read,
> +    .write = next_scsi_csr_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 1,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
>  static void next_scsi_init(Object *obj)
>  {
>      NeXTSCSI *s = NEXT_SCSI(obj);
> @@ -845,6 +897,9 @@ static void next_scsi_init(Object *obj)
>  
>      object_initialize_child(obj, "esp", &s->sysbus_esp, TYPE_SYSBUS_ESP);
>  
> +    memory_region_init_io(&s->scsi_csr_mem, obj, &next_scsi_csr_ops,
> +                          s, "csrs", 2);
> +
>      memory_region_init(&s->scsi_mem, obj, "next.scsi", 0x40);
>      sysbus_init_mmio(sbd, &s->scsi_mem);
>  }
> @@ -874,15 +929,30 @@ static void next_scsi_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(&s->scsi_mem, 0x0,
>                                  sysbus_mmio_get_region(sbd, 0));
>  
> +    /* SCSI CSRs */
> +    memory_region_add_subregion(&s->scsi_mem, 0x20, &s->scsi_csr_mem);
> +
>      scsi_bus_legacy_handle_cmdline(&s->sysbus_esp.esp.bus);
>  }
>  
> +static const VMStateDescription next_scsi_vmstate = {
> +    .name = "next-scsi",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(scsi_csr_1, NeXTSCSI),
> +        VMSTATE_UINT8(scsi_csr_2, NeXTSCSI),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static void next_scsi_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->desc = "NeXT SCSI Controller";
>      dc->realize = next_scsi_realize;
> +    dc->vmsd = &next_scsi_vmstate;
>  }
>  
>  static const TypeInfo next_scsi_info = {
> @@ -1000,8 +1070,8 @@ static const VMStateDescription next_rtc_vmstate = {
>  
>  static const VMStateDescription next_pc_vmstate = {
>      .name = "next-pc",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(scr1, NeXTPC),
>          VMSTATE_UINT32(scr2, NeXTPC),
> @@ -1009,8 +1079,6 @@ static const VMStateDescription next_pc_vmstate = {
>          VMSTATE_UINT32(int_mask, NeXTPC),
>          VMSTATE_UINT32(int_status, NeXTPC),
>          VMSTATE_UINT32(led, NeXTPC),
> -        VMSTATE_UINT8(scsi_csr_1, NeXTPC),
> -        VMSTATE_UINT8(scsi_csr_2, NeXTPC),
>          VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
>          VMSTATE_END_OF_LIST()
>      },

