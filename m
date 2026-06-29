Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D97BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0rR-000086-Kg; Sun, 28 Jun 2026 21:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0rO-00007o-5E
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:32:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0rL-00059J-Be
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:32:29 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6982e71dfb0so2995175a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782696745; cv=none;
 d=google.com; s=arc-20260327;
 b=cjvoOD8nbF1pp8lO1rRYgSyf2D8fAOCbdZSMG7QWrWf66cFpSzttVyQqVwIPMtxHmY
 N8891sXmIii1u2lcP+8dy8lDZsNZSLHrcqDrZRUyx5U8eghFbJ2YehtOefE9nLXvpVRn
 10BJ1DtEJs2FN6cOp39zAKDc2wUSwHw5Xvd+YZqDirJ356P33ljjzTZF/r+pkBPZ+INn
 o8DBTyRx3fs+BRp0vexLcgB70ov5wAtFJ4SE3VO37xrkxWBn+6BvLysxLH1Exb2nukGA
 PdfxhdCZST1A8rySWrB1/eInFp9Co3u9lLeaPR84+yZCZ2Tmd4b89j/jYYMTPF+s4cwU
 mydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J2vBpbyMRIBq9e+9arIKqGYww0AUlvFwJBS5bTWeAIA=;
 fh=pMbvjXJ0iXj0ywzGSd8fVykkPXeC7PfyfR2TbwSOYs0=;
 b=WGiTOYUx+IlskRDJaJRzvETZUkQbsncI1pH7J0Dl7h1tkePDTKc/jip9zi0snGlwGw
 yN2fbf/9EB1cVebaYvCSu1jK6FWI1uN+MlRCuNjuQZA3sIp7JqZuM/VhLWxBCMBKrTEy
 SpL4Cf1NVkV+0NJPEgimoO7sk15intbIETAnm3oX2AFPZ5/akyOmGiGU5Pg1frfCzLiv
 khCbyzPw2vMPsgzSpRSivEmP49cMjr6dWATMZy2FHzohiE8OTnDvnq6ib0bC/pgXJE7b
 XxI72mj1MtsT4SRhEXyedj+pS0Ufszb59V//rvyhnqb5eKWrCgQcaI7ck5B0qHZINn1z
 Zh/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782696745; x=1783301545; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2vBpbyMRIBq9e+9arIKqGYww0AUlvFwJBS5bTWeAIA=;
 b=MImfi37ks7aKP/F/Ye9yOA/qxHclMOX2FH0ACfIpNoU3JitNNqnJUu996Nzs3whUnN
 eWnptDsdGRyVieKp0sFJ9ibomHTuyIxTcO63qvoLdIuezW0XwOP+XPKg9hdp2Ws9HLrO
 zEDQ/vdhReOqhEK0z94SPOghDyjjN6TzQ2SbGu1/wGWM8ZRbPKMnW6jN2iwu1IASM97e
 Zd36+a+UVtMB8IihEM5a73FIJUJtqw3IvFVcltboVDdoLLH9Amw7jzB7trrPXxUIHf7B
 hImBxWtJTUh2G2+CvLBjS8lM93CuDBpGk0GI7P9yOa5lPf6Zeh1UX8kZUblIfG6mNMSb
 Tt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782696745; x=1783301545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J2vBpbyMRIBq9e+9arIKqGYww0AUlvFwJBS5bTWeAIA=;
 b=PWZbeWvRV2tl1LxoOBDdRPYyxtQtLX1QDnlCy0MU+7EeEAID1mfZEYplZHr0xZhhGe
 Ow3EEuheQwB2ZOz3BHBWPhmYvJxtrkXNjKcue6y7YnLrUW9VlyOibSHvT/fmuCOu3Ulo
 eU4Ns/ikYABT7uix0dlzGm6TXGhVWCWBwQzTZugy3l4NFH0cW2whEiyQ15YqM0S7P/qm
 WKSTwUTH8aL+XLet+1+YnKrk32BojFgfwOfYIHr2zhNgMz+hDR5G8TEzbe1XHMHocCwA
 D1Q9KVNXkDnEZstO4q9KgehdMmg5Qm5/ikovnx+TC3WCcTI/zJL4nbMIYyWiOiXyOaMW
 8KMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rrRm737My5iKAp1TioJjNNpfblWx7NmgiJ2aCP4FsKrdnZN0hnjTBNpeOLckNvXQxn4EAxsvivz4+@nongnu.org
X-Gm-Message-State: AOJu0Yw9KmFnGJfW3eRqvRGDN+aD49a07lospiK53XybToq35Vy8sHVK
 zyrEIwIEG+WnqnoMrNn6rIfR/62TIGs2YPcKZsmsHU3slQNs2qb1c+ope1MvFQVJacNFecQ4Mhq
 DJv8tKUpwl8MkBd2C5ZHrIg5jPqzjiok=
X-Gm-Gg: AfdE7clo2HHVAlQ0Xvmx88wjrxQ+DOlENWEu9cgZk3hz5aGS1bE5WNf9KLSGNNh4a4O
 AwSQwLrVTsSkeCSW9d8nRFtRUgvStVvdNxkKNJBJrhq3OKSh4QPdhFDDErFsFaxMOt6QqrQptUy
 3wOhxzHf09bHMM+sDGlb5ISC6C2pJQ7204Oh1BQa/iVe44Imxh/xAiCINxcRA9/Xddaf4tlD1M1
 kDvEJD/UYOQdjbw23SPsz03JhYsrbg+bHhSLfwN7XZlZGyAh5CmYuSkgU1JUOxdMHuO860Wof0h
 HbcOaUF0OQ5n50VSv72vgMoNtTs=
X-Received: by 2002:a17:907:6d1e:b0:bf1:a59e:653f with SMTP id
 a640c23a62f3a-c12335f0ea3mr369872066b.28.1782696745393; Sun, 28 Jun 2026
 18:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-2-visitorckw@gmail.com>
In-Reply-To: <20260616190147.1286316-2-visitorckw@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 11:31:58 +1000
X-Gm-Features: AVVi8Cd2qaHui8u-qzscsXPVxWMkXx72DMrXz1HKn26HR0MY7ylCphUU41A5HAA
Message-ID: <CAKmqyKPjO2SNFDs_tYi9TqsTYNj6frYJn_ro6jvuUwYUTCfzCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] hw/char: Add dw8250 UART
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 17, 2026 at 5:04=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Add the dw8250 uart support. This hardware is a widely used 16550A
> derivative that includes additional registers.
>
> Without this specific device support, the Linux 8250_dw driver fails to
> probe the extended registers (UCV, CPR, etc.), which are essential for
> correct feature detection:
>
> [    0.293566] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.306929] Oops - store (or AMO) access fault [#1]
> [    0.307020] Modules linked in:
> [    0.307192] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0 #1 =
PREEMPTLAZY
> [    0.307250] Hardware name: Milk-V Duo (DT)
> [    0.307294] epc : dw8250_setup_port+0x22/0x520
> [    0.307504]  ra : dw8250_probe+0x57e/0x5b8
> [    0.307518] epc : ffffffff80708dd6 ra : ffffffff8070a49e sp : ffffffc6=
0000b820
> [    0.307525]  gp : ffffffff81a32ba8 tp : ffffffd602180cc0 t0 : 00000000=
00000073
> [    0.307533]  t1 : 000000000000006c t2 : 0000000000000000 s0 : ffffffc6=
0000b830
> [    0.307539]  s1 : ffffffd6028c8640 a0 : ffffffc60000b848 a1 : ffffffff=
813162c1
> [    0.307546]  a2 : ffffffff813162c0 a3 : ffffffd6028c8640 a4 : ffffffc6=
0002d0b4
> [    0.307552]  a5 : 0000000000000001 a6 : 0000000000000094 a7 : 00000000=
00000060
> [    0.307558]  s2 : ffffffd60225d410 s3 : ffffffd60225d400 s4 : 00000000=
00000000
> [    0.307573]  s5 : ffffffff80e31a48 s6 : 0000000000000008 s7 : 00000000=
00000000
> [    0.307584]  s8 : 0000000000000149 s9 : 0000000000000000 s10: 00000000=
00000000
> [    0.307590]  s11: 0000000000000000 t3 : ffffffd602007c00 t4 : ffffffff=
81601540
> [    0.307604]  t5 : 0000000000000003 t6 : ffffffd602a42f82 ssp : 0000000=
000000000
> [    0.307611] status: 0000000200000120 badaddr: ffffffc60002d0b4 cause: =
0000000000000007
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
> [    0.307914] Code: 3683 2085 0b63 32f7 000f 0140 6918 4785 0713 0b47 (c=
31c) 2583
> [    0.308041] ---[ end trace 0000000000000000 ]---
> [    0.308180] Kernel panic - not syncing: Fatal exception in interrupt
> [    0.315760] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>  hw/char/Kconfig          |   4 ++
>  hw/char/dw8250.c         | 118 +++++++++++++++++++++++++++++++++++++++
>  hw/char/meson.build      |   1 +
>  include/hw/char/dw8250.h |  27 +++++++++
>  4 files changed, 150 insertions(+)
>  create mode 100644 hw/char/dw8250.c
>  create mode 100644 include/hw/char/dw8250.h
>
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 020c0a84bb..418d99b757 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -95,3 +95,7 @@ config IP_OCTAL_232
>      bool
>      default y
>      depends on IPACK
> +
> +config DW8250
> +    bool
> +    select SERIAL
> diff --git a/hw/char/dw8250.c b/hw/char/dw8250.c
> new file mode 100644
> index 0000000000..4ec829ceaf
> --- /dev/null
> +++ b/hw/char/dw8250.c
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Synopsys DesignWare APB UART (DW 8250)
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/char/dw8250.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev-properties-system.h"
> +
> +#define DW_UART_REGION_SIZE 0x100
> +
> +#define DW_UART_RE_EN 0xB4 /* Receiver Output Enable Register */
> +#define DW_UART_DLF   0xC0 /* Divisor Latch Fraction Register */
> +#define DW_UART_CPR   0xF4 /* Component Parameter Register */
> +#define DW_UART_UCV   0xF8 /* UART Component Version */
> +#define DW_UART_CTR   0xFC /* Component Type Register */
> +
> +#define DW_UART_UCV_VALUE 0x3332332A /* "323*" -> v3.23a */
> +#define DW_UART_CTR_VALUE 0x44570110 /* "DW" */
> +
> +static uint64_t dw8250_ext_read(void *opaque, hwaddr addr, unsigned int =
size)
> +{
> +    switch (addr) {
> +    case DW_UART_UCV:
> +        return DW_UART_UCV_VALUE;
> +    case DW_UART_CPR:
> +        return 0x00000000; /* No advanced features (DMA, extra FIFOs) */
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
> +static void dw8250_ext_write(void *opaque, hwaddr addr, uint64_t val, un=
signed int size)
> +{

Should we log this as unimplemented, using `qemu_log_mask(LOG_UNIMP...` ?

Otherwise

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +}
> +
> +static const MemoryRegionOps dw8250_ext_ops =3D {
> +    .read =3D dw8250_ext_read,
> +    .write =3D dw8250_ext_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +};
> +
> +static void dw8250_instance_init(Object *obj)
> +{
> +    DW8250State *s =3D DW8250(obj);
> +
> +    s->serial_mm =3D qdev_new("serial-mm");
> +    object_property_add_child(obj, "serial-mm", OBJECT(s->serial_mm));
> +    object_property_add_alias(obj, "chardev", OBJECT(s->serial_mm), "cha=
rdev");
> +}
> +
> +static void dw8250_realize(DeviceState *dev, Error **errp)
> +{
> +    DW8250State *s =3D DW8250(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    SysBusDevice *serial_sbd =3D SYS_BUS_DEVICE(s->serial_mm);
> +
> +    memory_region_init(&s->container, OBJECT(dev), "dw8250-container",
> +                       DW_UART_REGION_SIZE);
> +    sysbus_init_mmio(sbd, &s->container);
> +
> +    qdev_prop_set_uint8(s->serial_mm, "regshift", s->regshift);
> +    qdev_prop_set_uint8(s->serial_mm, "endianness", DEVICE_LITTLE_ENDIAN=
);
> +    sysbus_realize(serial_sbd, errp);
> +
> +    memory_region_init_io(&s->ext_iomem, OBJECT(dev), &dw8250_ext_ops, s=
,
> +                          "dw8250-ext", DW_UART_REGION_SIZE);
> +    memory_region_add_subregion(&s->container, 0, &s->ext_iomem);
> +
> +    memory_region_add_subregion_overlap(&s->container, 0,
> +                                        sysbus_mmio_get_region(serial_sb=
d, 0), 1);
> +
> +    sysbus_pass_irq(sbd, serial_sbd);
> +}
> +
> +static const Property dw8250_properties[] =3D {
> +    DEFINE_PROP_UINT8("regshift", DW8250State, regshift, 2),
> +};
> +
> +static void dw8250_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D dw8250_realize;
> +    device_class_set_props(dc, dw8250_properties);
> +}
> +
> +static const TypeInfo dw8250_info =3D {
> +    .name          =3D TYPE_DW8250,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(DW8250State),
> +    .instance_init =3D dw8250_instance_init,
> +    .class_init    =3D dw8250_class_init,
> +};
> +
> +static void dw8250_register_types(void)
> +{
> +    type_register_static(&dw8250_info);
> +}
> +
> +type_init(dw8250_register_types)
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index fc3d7ee506..b2250ee6ae 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: =
files('stm32l4x5_usart.c'
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfs=
oc_mmuart.c'))
>  system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
>  system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.=
c'))
> +system_ss.add(when: 'CONFIG_DW8250', if_true: files('dw8250.c'))
>
>  specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal327=
0.c'))
>  specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
> diff --git a/include/hw/char/dw8250.h b/include/hw/char/dw8250.h
> new file mode 100644
> index 0000000000..59396ad202
> --- /dev/null
> +++ b/include/hw/char/dw8250.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Synopsys DesignWare APB UART (DW 8250)
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef HW_CHAR_DW8250_H
> +#define HW_CHAR_DW8250_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_DW8250 "dw8250"
> +OBJECT_DECLARE_SIMPLE_TYPE(DW8250State, DW8250)
> +
> +struct DW8250State {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion container;
> +    MemoryRegion ext_iomem;
> +    DeviceState *serial_mm;
> +
> +    uint8_t regshift;
> +};
> +
> +#endif
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
>

