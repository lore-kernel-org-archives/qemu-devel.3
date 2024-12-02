Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2128D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI898-0002BK-1t; Mon, 02 Dec 2024 10:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI88u-0002A6-8n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:15:27 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI88r-000469-M0
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:15:19 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ffc380b1d0so43857991fa.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733152515; x=1733757315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+MBm1wHp5A9AeIADyPGUWK4+PzdtwNSv7VTt465rdg=;
 b=Kw9PG+O6Co3FGH6Ed47xUjMw7F1KIIH7a4w/Yo6n6AIaRSJhcYHmSYB8AAoBiIo0zQ
 8+M9D3EpDNRRsn9UE9G48d1wNfsYLa/CHaY6WjXxGgTYZmG4FGfWcEW2UCVZXZLzS0K7
 BXtIOy6ydzXXHbagVt2he/b1aI3cU14qWbwp8cu2H2PAAD/W2nQrS265ko/hFaKkzi02
 5wZApGQQtxaKIvlk8ASVSjquasK28TQv94XDRCQOG10URqHoruxb/+cXM4Y9XT/Qr7jc
 NXiotE+KXefr+JnhTRpLITfx6TnWnPX1twzv+DwNmn1r6d+mbnQ7q5CsaM1J6jwkeAKn
 7Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733152515; x=1733757315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+MBm1wHp5A9AeIADyPGUWK4+PzdtwNSv7VTt465rdg=;
 b=HM8LwFL+9ue3FPy6kYIrIjiyyuMctzrpg5IJ1GY6kmkudJzJvbfV2Jkisej9nxAPXC
 whA/ckwymZkYgjNXYfnrrW0WHcSuxXtmjEOInP9wGf52hA18bBEYFApg30r3c9aq6kTY
 G3tDhqVYvqkqsXs2Fj1/SqqrPm0mOITSBF1+9kMaXGkkT7ZYH4p7fvn9fWUC7T5WMJSp
 MrCZG1P9W5OQBNEdhBqGFTEgAFwLmpcRbh8FaV2qiNDN7pAB2GIpbEhT1PpxwlmbndZN
 SJvbKVTrNrKUK53RiPuJHmNvl8No5+AGVoLU3ZoMACzBGcu0hV+A0qYKq+Ivk+MqY7ut
 QlrA==
X-Gm-Message-State: AOJu0YzI+5pnZc67Uq0pFpwDFq9+GbcoPc+znEYzZ0rbodhfBN1nq+8f
 TAgaKnpqrcAq8VAwxymAiAReFW/YpHJv/6WP7lPVMrzgAw9AKhR4e0c3MTiIUr5VSK1nBjii5LD
 mysafTSIWYr40THDqplFPs19uPNm1b5/u6Ac1hQ==
X-Gm-Gg: ASbGncs2xWfrHO08jrEGKpkndDxFLiVk9atH252b6ZLChEY/m43x8s3kiwKV9jhQdFF
 lV3VXEjLeDGYXiRibeSbzUn8EOoG+sLm3
X-Google-Smtp-Source: AGHT+IFWCTHJmdhHEgsU3SWmj7JxuTU8rkQUYU0JmetSekz1LfbEFg8QYZS0HnATs5BEbRg4/rGy6I/pIV/i/iJZ4zs=
X-Received: by 2002:a2e:bcc1:0:b0:2fb:3960:9657 with SMTP id
 38308e7fff4ca-2ffde203deamr59278161fa.12.1733152513459; Mon, 02 Dec 2024
 07:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
 <20241117225643.768322-2-ioan-cristian.cirstea@tutanota.com>
In-Reply-To: <20241117225643.768322-2-ioan-cristian.cirstea@tutanota.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 15:15:02 +0000
Message-ID: <CAFEAcA-HsACBVp5L3FVLnebYOos6QPVc9o1HbnVuQL_0XJ0+gQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] [BCM2835 AUX 2/7] Add basic support for CNTL register
To: =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <ioan-cristian.cirstea@tutanota.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Sun, 17 Nov 2024 at 23:02, Ioan-Cristian C=C3=8ERSTEA
<jean.christian.cirstea@gmail.com> wrote:
>
> This commit allows software to enable/disable both the receiver and the
> transmitter through the CNTL register.
>
> Signed-off-by: Ioan-Cristian C=C3=8ERSTEA <ioan-cristian.cirstea@tutanota=
.com>
> ---
>  hw/char/bcm2835_aux.c         | 50 +++++++++++++++++++++++++++++------
>  include/hw/char/bcm2835_aux.h |  3 ++-
>  2 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index 540cb30872..ebc7f5ade5 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -29,6 +29,7 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>
> +/* TODO: These constants need to be unsigned */

Why? They're register offset values, and we don't use
them in any context where the sign matters.

>  #define AUX_IRQ         0x0
>  #define AUX_ENABLES     0x4
>  #define AUX_MU_IO_REG   0x40
> @@ -43,10 +44,17 @@
>  #define AUX_MU_STAT_REG 0x64
>  #define AUX_MU_BAUD_REG 0x68
>
> +/* Register masks */
> +#define MASK_AUX_MU_CNTL_REG 0x3
> +
>  /* bits in IER/IIR registers */
>  #define RX_INT  0x1
>  #define TX_INT  0x2
>
> +/* bits in CNTL register */
> +#define RX_ENABLE 0x1
> +#define TX_ENABLE 0x2
> +
>  /* FIFOs length */
>  #define BCM2835_AUX_RX_FIFO_LEN 8
>  #define BCM2835_AUX_TX_FIOF_LEN 8
> @@ -72,13 +80,27 @@ static void bcm2835_aux_update(BCM2835AuxState *s)
>      qemu_set_irq(s->irq, s->iir !=3D 0);
>  }
>
> +static bool bcm2835_aux_is_tx_enabled(BCM2835AuxState *s)
> +{
> +    return (s->cntl & TX_ENABLE) !=3D 0;
> +}
> +
> +static bool bcm2835_aux_is_rx_enabled(BCM2835AuxState *s)
> +{
> +    return (s->cntl & RX_ENABLE) !=3D 0;
> +}
> +
>  static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned s=
ize)
>  {
>      BCM2835AuxState *s =3D opaque;
>      Fifo8 *rx_fifo =3D &s->rx_fifo;
>      const bool is_rx_fifo_not_empty =3D !fifo8_is_empty(rx_fifo);
>      const uint32_t rx_fifo_fill_level =3D fifo8_num_used(rx_fifo);
> -    uint32_t c =3D 0, res;
> +    /*
> +     * 0xFF trashes terminal output, so device driver bugs can be found =
quickly
> +     * in case the RX_FIFO is read while empty
> +     */
> +    uint32_t c =3D 0xFF, res;

What does the hardware spec say happens in this situation?

Also, this change isn't related to the CNTL register, so if
you want to make it it should be in a patch of its own.

>      switch (offset) {
>      case AUX_IRQ:
> @@ -140,7 +162,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr=
 offset, unsigned size)
>          return 0;
>
>      case AUX_MU_CNTL_REG:
> -        return 0x3; /* tx, rx enabled */
> +        return s->cntl;
>
>      case AUX_MU_STAT_REG:
>          res =3D 0x30e; /* space in the output buffer, empty tx fifo, idl=
e tx/rx */
> @@ -183,7 +205,9 @@ static void bcm2835_aux_write(void *opaque, hwaddr of=
fset, uint64_t value,
>          ch =3D value;
>          /* XXX this blocks entire thread. Rewrite to use
>           * qemu_chr_fe_write and background I/O callbacks */
> -        qemu_chr_fe_write_all(&s->chr, &ch, 1);
> +        if (bcm2835_aux_is_tx_enabled(s)) {
> +            qemu_chr_fe_write_all(&s->chr, &ch, 1);
> +        }
>          break;
>
>      case AUX_MU_IER_REG:
> @@ -211,7 +235,12 @@ static void bcm2835_aux_write(void *opaque, hwaddr o=
ffset, uint64_t value,
>          break;
>
>      case AUX_MU_CNTL_REG:
> -        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_CNTL_REG unsupported\n", __=
func__);
> +        if (value & ~MASK_AUX_MU_CNTL_REG) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: auto flow control not supported\n",
> +                          __func__);
> +        }
> +        s->cntl =3D value & MASK_AUX_MU_CNTL_REG;
>          break;
>
>      case AUX_MU_BAUD_REG:
> @@ -233,7 +262,7 @@ static int bcm2835_aux_can_receive(void *opaque)
>      return !fifo8_is_full(&s->rx_fifo);
>  }
>
> -static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
> +static void bcm2835_aux_put_fifo(BCM2835AuxState *s, uint8_t value)
>  {
>      BCM2835AuxState *s =3D opaque;
>      Fifo8 *rx_fifo =3D &s->rx_fifo;
> @@ -246,7 +275,11 @@ static void bcm2835_aux_put_fifo(void *opaque, uint8=
_t value)
>
>  static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int si=
ze)
>  {
> -    bcm2835_aux_put_fifo(opaque, *buf);
> +    BCM2835AuxState *s =3D opaque;
> +
> +    if (bcm2835_aux_is_rx_enabled(s)) {
> +        bcm2835_aux_put_fifo(opaque, *buf);
> +    }

The right place to put an "is RX enabled" check is in
the can_receive function, not here. (can_receive is
where we tell the QEMU chardev code how many bytes we
can take from it. In this function we're supposed to
guarantee to handle all the data we're given; otherwise
we'll drop characters.)

>  }
>
>  static const MemoryRegionOps bcm2835_aux_ops =3D {
> @@ -266,8 +299,9 @@ static const VMStateDescription vmstate_bcm2835_aux =
=3D {
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_FIFO8(rx_fifo, BCM2835AuxState),
>          VMSTATE_FIFO8(_tx_fifo, BCM2835AuxState),
> -        VMSTATE_UINT8(ier, BCM2835AuxState),
> -        VMSTATE_UINT8(iir, BCM2835AuxState),
> +        VMSTATE_UINT32(ier, BCM2835AuxState),
> +        VMSTATE_UINT32(iir, BCM2835AuxState),
> +        VMSTATE_UINT32(cntl, BCM2835AuxState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.=
h
> index cb1a824994..feaedc9e2f 100644
> --- a/include/hw/char/bcm2835_aux.h
> +++ b/include/hw/char/bcm2835_aux.h
> @@ -29,7 +29,8 @@ struct BCM2835AuxState {
>      Fifo8 rx_fifo;
>      /* Unused for now */
>      Fifo8 _tx_fifo;
> -    uint8_t ier, iir;
> +    /* Registers */
> +    uint32_t ier, iir, cntl;
>  };

Why widen IER and IIR to uint32_t ? That's not related to adding
the CNTL register, so if you want to do it it should be a
separate patch with its own commit message saying why.
(General rule: each patch should do one thing only.)

thanks
-- PMM

