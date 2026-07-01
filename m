Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30928C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemBn-00083k-Lf; Wed, 01 Jul 2026 00:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wemBm-00083U-2K
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:04:42 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wemBk-0004bl-3P
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:04:41 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664de279fadso245510d50.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 21:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782878679; cv=none;
 d=google.com; s=arc-20260327;
 b=KCr8ItLRIIAFouyQZTgMZSRIFNdeyN1PpMSSZrnsAqGkdQYpMHp0Q+RXvM9l470T9W
 sT7ScQCMpMjeoVcnuto9/wqIwxSg2HTVFR2a/kM51y8pf7XTdVQes7KSk1eje9YnPBjx
 XJj7M+WOL0+XYNP5mo99MF+ETFLrsNQCNNu8gBWUDI2xVBOD2WqrhTdbSUglBN94SRO7
 ZNENTtMljG+ZO5TblhHc0c254IwFee0KOgYr9bpCkroES6zJUcXsGphUQqEbP2DUE65+
 oRu0+szX8YSL4z7ZQ7J1u+QYh7DczzAbQ1QRArzcGdgz7U+EkNLsGsLwk+9vSbAvYXmK
 n6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DIBdzQY6sxUM6BrayKIdWEh7ptRv+y4YFf2kvz45YG0=;
 fh=Nq5jtMPLtwZkrnHPJ1cyTmQj/mmXdGTa25fZKTXT0n4=;
 b=HBRZQt01QcwmBGjC9YaoT5Ja1+g402/ahC5hkN0tQY28olTGDEuAbpbIjtiCt1c5ER
 a2iH1d8moX9YB9Zq83IVX8QDqfq9fspV584tm0dJnERDP38tuMU4dokNT972CiAhl/ax
 vKKoJS26ySJA/36Y8mx/hHdUupJYjN8tsoK20mOAlTVdti9jGvmFs+agwl0F4NMGu1Up
 NYrmGgZXw5iGPfrIr9FHAmPlH4zx2T+s7Cg4nZwLTexMNW3Cm96aWBkCpIyGoc9xGAKn
 CkhBx7C5qvfKLkzH4NvSXGehjDXyGjznwZDDIGcK/FLtVmQAbrhtSjUcaUR8cUDjpsQ3
 sw5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1782878679; x=1783483479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DIBdzQY6sxUM6BrayKIdWEh7ptRv+y4YFf2kvz45YG0=;
 b=f1fz0qQ37taqsOIq9l7ELe25gCQ+DvDN/TPV41m0tTlZzO0sB1e2+PIMhoP0X7+EPm
 4dcytZTbIQCQk6u524iMhXMddl58ZR08Bm+cluMCxbpoObQsO4bEjX1fZQj2anjf/hRO
 0Hs+V60HtB00xC334IS1co9HS+900CqrI0Hq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782878679; x=1783483479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIBdzQY6sxUM6BrayKIdWEh7ptRv+y4YFf2kvz45YG0=;
 b=kBpKdw1ceuxKoQVKL9KbOHJ+gdNIy1mLHo7HbcVV0/rm+7nxn0XJ0JWaC0Ntt0xPMf
 ePA6tJfMHFuBZyGkmqGzL6ttFAyEQEWgTB3LJMtNuh2jp1uiUbHSPd3hzEfihv4iYoZy
 Pjjy13MxJ9D3ImrmtEXvFrO81W0aq1tOUzQyeIXg7DjvQSq0it/kUNF1/RmWdHRKudD/
 bJCJb46vx2wefVZARY4DXHgxtMb4xes1wAeURisOimd+TT3kolqxp2H5wASg950u320A
 BC/cQ00hSsS63V/Vracri8AX3qFqXOH9SS7Cwu6YrEqT5L0jVUKOPfgd7jfMHAtqLJ4N
 XvdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpP2RfhFpjQiVW0uLPatd6xCBK5IQNGdn2z7w/9NYiGvov4XK+8La+LIXcoUVLTYyqwy6z51SBLXjG3@nongnu.org
X-Gm-Message-State: AOJu0YwAao0RPF7g9nyyB28jqSHXDtAv+4f6rpmT2SqzgGYLHFv9MKln
 SXFrZau3xm1f9kefL+6b5VKxCZrzMOoKZ8HweNbCaHlC7Tk0spoGKVUh7nmEx1oGbcK1gmN0cit
 BqoxuMqNfyFuof97aWzO5p3t7HLXpBH0=
X-Gm-Gg: AfdE7ckC6eHpOChRMxOlkDTXYzSLawJLOLugYJM/cmPZ5wwN6cSvsIySvuSLw8lmupq
 pdGcI0J0/+F05G/McoeB3sfazZ1J0gQAQg2CmB+PLx0PPIqxENFs/VwMfLmujFjg5jwyjR2nCbo
 uCENNWAx+90oHBmtWDBT37eEsClgJO1dK6G50EXZ3HqwYLthHgWgfvDlQnxbvdTLz/he9DoZp73
 1eCx6aopn98W/t/cfc3uHZLeib50iGalWFCvdl0OiG39bsuFaugDUFCHldyKeNph5FBORwfeH2q
 D28Yoq9gdHtAQB4cFYx+gi50bSnYNbajS/ZlGNsT4WMeLD6D47+qSijo5QHCuwEMMk9FZcyPYiR
 FxXhyrUC78DK7Qw==
X-Received: by 2002:a05:690e:d47:b0:660:48f6:89a3 with SMTP id
 956f58d0204a3-664f98adf0fmr5366131d50.41.1782878678816; Tue, 30 Jun 2026
 21:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-2-visitorckw@gmail.com>
In-Reply-To: <20260616190147.1286316-2-visitorckw@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Jul 2026 13:34:27 +0930
X-Gm-Features: AVVi8CeWoqXgNaUGI2_4tLyAH_2SGzOer3IITzHNPX3AkzXEOa5z9c5MiVnwXo4
Message-ID: <CACPK8Xc+AZyt9VJzvOCus4sGXEFT3VBmwLwLbsuaY2+CN_6oPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] hw/char: Add dw8250 UART
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 17 Jun 2026 at 04:31, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add the dw8250 uart support. This hardware is a widely used 16550A
> derivative that includes additional registers.
>
> Without this specific device support, the Linux 8250_dw driver fails to
> probe the extended registers (UCV, CPR, etc.), which are essential for
> correct feature detection:

Nice. The atlantis board works around this by adding an uimp region,
but having a real model is even better.

Some minor comments below.

> [    0.293566] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.306929] Oops - store (or AMO) access fault [#1]
> [    0.307020] Modules linked in:
> [    0.307192] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0 #1 PREEMPTLAZY
> [    0.307250] Hardware name: Milk-V Duo (DT)
> [    0.307294] epc : dw8250_setup_port+0x22/0x520
> [    0.307504]  ra : dw8250_probe+0x57e/0x5b8
> [    0.307518] epc : ffffffff80708dd6 ra : ffffffff8070a49e sp : ffffffc60000b820
> [    0.307525]  gp : ffffffff81a32ba8 tp : ffffffd602180cc0 t0 : 0000000000000073
> [    0.307533]  t1 : 000000000000006c t2 : 0000000000000000 s0 : ffffffc60000b830
> [    0.307539]  s1 : ffffffd6028c8640 a0 : ffffffc60000b848 a1 : ffffffff813162c1
> [    0.307546]  a2 : ffffffff813162c0 a3 : ffffffd6028c8640 a4 : ffffffc60002d0b4
> [    0.307552]  a5 : 0000000000000001 a6 : 0000000000000094 a7 : 0000000000000060
> [    0.307558]  s2 : ffffffd60225d410 s3 : ffffffd60225d400 s4 : 0000000000000000
> [    0.307573]  s5 : ffffffff80e31a48 s6 : 0000000000000008 s7 : 0000000000000000
> [    0.307584]  s8 : 0000000000000149 s9 : 0000000000000000 s10: 0000000000000000
> [    0.307590]  s11: 0000000000000000 t3 : ffffffd602007c00 t4 : ffffffff81601540
> [    0.307604]  t5 : 0000000000000003 t6 : ffffffd602a42f82 ssp : 0000000000000000
> [    0.307611] status: 0000000200000120 badaddr: ffffffc60002d0b4 cause: 0000000000000007
> [    0.307652] [<ffffffff80708dd6>] dw8250_setup_port+0x22/0x520
> [    0.307695] [<ffffffff8070a49e>] dw8250_probe+0x57e/0x5b8
> [    0.307702] [<ffffffff80731f0e>] platform_probe+0x46/0x80
> [    0.307708] [<ffffffff8072f67c>] really_probe+0x84/0x22c
> [    0.307715] [<ffffffff8072f880>] __driver_probe_device+0x5c/0xd4
> [    0.307721] [<ffffffff8072f9be>] driver_probe_device+0x2e/0xf4
> [    0.307727] [<ffffffff8072fbe6>] __driver_attach+0x6e/0x14c
> [    0.307734] [<ffffffff8072d5f0>] bus_for_each_dev+0x60/0xb0
> [    0.307740] [<ffffffff8072f1b2>] driver_attach+0x1a/0x24
> [    0.307746] [<ffffffff8072e8da>] bus_add_driver+0xca/0x1d8
> [    0.307752] [<ffffffff80730aaa>] driver_register+0x3e/0xdc
> [    0.307757] [<ffffffff80731c54>] __platform_driver_register+0x1c/0x24
> [    0.307779] [<ffffffff80c334f6>] dw8250_platform_driver_init+0x1a/0x24
> [    0.307793] [<ffffffff80011992>] do_one_initcall+0x4e/0x2a4
> [    0.307800] [<ffffffff80c01362>] kernel_init_freeable+0x226/0x2b0
> [    0.307807] [<ffffffff80bc3798>] kernel_init+0x1c/0x144
> [    0.307813] [<ffffffff8001361c>] ret_from_fork_kernel+0x18/0x164
> [    0.307820] [<ffffffff80bcefb6>] ret_from_fork_kernel_asm+0x16/0x18
> [    0.307914] Code: 3683 2085 0b63 32f7 000f 0140 6918 4785 0713 0b47 (c31c) 2583
> [    0.308041] ---[ end trace 0000000000000000 ]---
> [    0.308180] Kernel panic - not syncing: Fatal exception in interrupt
> [    0.315760] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

The kernel oops doesn't add much; I'd drop it from the commit message.
But your call if you want to keep it.

> --- /dev/null
> +++ b/hw/char/dw8250.c

> +#define DW_UART_RE_EN 0xB4 /* Receiver Output Enable Register */
> +#define DW_UART_DLF   0xC0 /* Divisor Latch Fraction Register */
> +#define DW_UART_CPR   0xF4 /* Component Parameter Register */
> +#define DW_UART_UCV   0xF8 /* UART Component Version */
> +#define DW_UART_CTR   0xFC /* Component Type Register */
> +
> +#define DW_UART_UCV_VALUE 0x3332332A /* "323*" -> v3.23a */

I was curious  what this was used for, and it seems Linux has a
dev_dbg but otherwise it's not important. The values here should be
fine.

> +#define DW_UART_CTR_VALUE 0x44570110 /* "DW" */
> +
> +static uint64_t dw8250_ext_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    switch (addr) {
> +    case DW_UART_UCV:
> +        return DW_UART_UCV_VALUE;
> +    case DW_UART_CPR:
> +        return 0x00000000; /* No advanced features (DMA, extra FIFOs) */

Linux will detect zero and use a value from the platform data, but
this is only to support a quirk on renesas rzn1, so again this should
be fine.

> +    case DW_UART_CTR:
> +        return DW_UART_CTR_VALUE;
> +
> +    case DW_UART_RE_EN:
> +    case DW_UART_DLF:
> +        /*
> +         * Return 0 to indicate these optional features
> +         * (RS485 and Fractional Divisor) are not implemented.
> +         */
> +        return 0x00000000;
> +
> +    default:
> +        return 0;
> +    }
> +}
> +
> +static void dw8250_ext_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
> +{

LOG_UNIMP (or LOG_GUEST_ERROR)?


> +static void dw8250_realize(DeviceState *dev, Error **errp)
> +{
> +    DW8250State *s = DW8250(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    SysBusDevice *serial_sbd = SYS_BUS_DEVICE(s->serial_mm);
> +
> +    memory_region_init(&s->container, OBJECT(dev), "dw8250-container",
> +                       DW_UART_REGION_SIZE);
> +    sysbus_init_mmio(sbd, &s->container);
> +
> +    qdev_prop_set_uint8(s->serial_mm, "regshift", s->regshift);
> +    qdev_prop_set_uint8(s->serial_mm, "endianness", DEVICE_LITTLE_ENDIAN);
> +    sysbus_realize(serial_sbd, errp);

Return on error?

> +
> +    memory_region_init_io(&s->ext_iomem, OBJECT(dev), &dw8250_ext_ops, s,
> +                          "dw8250-ext", DW_UART_REGION_SIZE);
> +    memory_region_add_subregion(&s->container, 0, &s->ext_iomem);
> +
> +    memory_region_add_subregion_overlap(&s->container, 0,
> +                                        sysbus_mmio_get_region(serial_sbd, 0), 1);
> +
> +    sysbus_pass_irq(sbd, serial_sbd);
> +}
> +
> +static const Property dw8250_properties[] = {
> +    DEFINE_PROP_UINT8("regshift", DW8250State, regshift, 2),

When boards have a value other than 2, does this affect the DW
extension registers too? Or only the 8250 ones?

