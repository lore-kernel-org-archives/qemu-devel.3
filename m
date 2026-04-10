Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22C5F36B9F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 02:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB1bs-00069E-PV; Thu, 09 Apr 2026 22:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB1br-00068o-7G
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:28:39 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB1bo-0002nX-F6
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:28:38 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso213706866b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 19:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775788114; cv=none;
 d=google.com; s=arc-20240605;
 b=T5Rj0x3Tt3HaVMfzdGhA7EYvX2wor4CVSY9Kq/RZ/2pSP/ZPlfYTURYQHu72/H029B
 SxX1FXqjS5Ht2CZjewfDNN+AzC5ho7Nc6oYzB6HquVdQf9gknNVEkyZfYhVkQZTrOeVT
 ERUqbluD4SLjtB6xrKp3B4AgNuCwxxX6gB4WB8GbWNA6OF+FaNTGHKGTz6CNaB08Czzo
 dSRrtIw51KQl13g0IsWSb4emNBtpgmFKCBlvtRVQw9CVRWTHZkyNLt2kUgukWPUW6367
 O6otiEiPi+K4LxUYDKEuOUe8NODARAyupqC/dGb8GE+wl+LN6v01ZQuWqXrYFQ3U/ubO
 FGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=97Q9wfsu1Li/Vt/TngIdvn6KdqSpeuI+rrRQtR3Dl0M=;
 fh=5lY+JP3zSor/7ZjU77gplzEaNRISnU2EdVABqj2Frww=;
 b=Xan1L/GZXhqHtqo7rq9Y4Zx6ciFzei/G0D4lzKUV6dkx82w9BJhfqzNVuQxPSB22Vh
 ontcgwAFcsmiwRdmIx1dJGQvpEgNw6cTVLkittVDtoZ4aUXm1nfJchIK0VhkKeEYsf9K
 OEY+dpKpYhlaD1WPP93iOv1m64jQxG8iLsq83CqFRCYHMuLhs7wy+rC1J9krjngotyRt
 8DZ32KseJNVyuunyyw/TxUPLhjdnUiVpsw4kMRSmpx1RRs3B4cykq1c686OktG/uqKcC
 V5VBjN9OSye0QHKORHeIk/I/6IdWq0TBCdrtpQo9ig+xn7IHGLrltEv4IR2ql88bxNQm
 k3SQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775788114; x=1776392914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97Q9wfsu1Li/Vt/TngIdvn6KdqSpeuI+rrRQtR3Dl0M=;
 b=K+CLB4WM+ihYrPJNJbpWCbR3L8OmKwp5CZRRz423npqcXSnVUYkO+yD9FdX4EUs5jD
 DAvcOMbcm7ZcMJZpkiMkFwSB5rbfZG2g5FAwB5uIM55fOfBf0guLXfaRQLkmp+mKnYP1
 pqtXdw81pGGroHee2MxdbO2IMCaqu4tqDlkdr9f2fGWmdbb6rCWTKbrId2QN7Mchuc0Y
 N3kvgfrTFM/jpfSU38UJhpV4/udHhYLhTGNrf1ff+Fl9PznSHftxwTV3rz+v7DT7chNv
 XSxqICciLqu+iYniw8SugPmwxoGYmnlwTKzNjcMu3p5HknapmynoHXXM3ly5TygU1uHS
 Nm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775788114; x=1776392914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=97Q9wfsu1Li/Vt/TngIdvn6KdqSpeuI+rrRQtR3Dl0M=;
 b=JJu3483DtbfU0mdlO8b8OSobaOZ8pw+n/K/Lz4XuWxPEZ+S3S0nryGHzYEwaPsx+Nw
 4d+mzFON0utamQBm2iNxF3v07zYQzpqBjeDwGQafEtem1lTX3ktKLvhhzEO8D38O2UWn
 ULJxM07NzG4d9r4HKojqG4e1A3blM1jg05dwS+QYob22SJLnbLz/aC4qsteg0vq+pSzA
 AxYbbk9+ORx8Vj13P1Ukd0yCsiqLyc5awCp64sg5GYRNEI8CTLmd0EYql3DpaW3oPWdU
 AFqCdhCFIPOcrubZrRfoS1C2HMyaPOuVw+gSzYl+gZw7Xjx2k/t2s6QlYeAI/JVMK8Xa
 GXqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDdPcEa/FB5z2TEi1uYsa0BEjGc43DHOOrq+DmJMmm+4J/p5nL361G0FhHI2D18GdIz7i2D2hJ3SoP@nongnu.org
X-Gm-Message-State: AOJu0YxWJT+CvQcJ/Wm/AZB/HEmo/4/oCXhP9oSq1Vkyg6nmU6IO/VWg
 4DtyJqZnQ33ndVdqojL4w/l+He56zKUfK5nbrJjNxg0Ug0RciLAC7yoM68fy6W8JvVC6uSpQeYC
 QXVVcGL7qW2KVYz7LAdotsW9jlKf8UuY=
X-Gm-Gg: AeBDieuyk3sLIgpwNz8uBlHZwHocEHTifAWCOcdwQfe4HLwSO4VHSsnOEUrUF2QAux5
 17sfQQ0S0T1LB0vxkujqlmW0TsThTJ5rmdpitvp+3lr1w0fjSav7QmFGkdQqPSgiOoR/ZNd6wMK
 q7nF7g7Segu+H0U7civlVRMpVjCRxMNvoaSsApFL8URyMb5XCwvMIMlfygBFT5IvixSDNGXqDNl
 L2UCGdAYLNJMpjrwYtQMy1Oqt3zpaX4TVjMDF4mGruokUJJT4muiLvLy6Xb0RYMIeJstS6KnrBZ
 Fv0jVZM7cdNRBOz264H05oKm+Uu3WQE9eyLmlQ==
X-Received: by 2002:a17:907:1582:b0:b9b:ddb2:b1c1 with SMTP id
 a640c23a62f3a-b9d727ac7cbmr55890066b.21.1775788114238; Thu, 09 Apr 2026
 19:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <177564643888.23414.7922925369077631439-0@git.sr.ht>
 <177564643888.23414.7922925369077631439-1@git.sr.ht>
In-Reply-To: <177564643888.23414.7922925369077631439-1@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 12:28:07 +1000
X-Gm-Features: AQROBzArh01YRSEr2mLXccSttGfDyaoU36HCXFCvwlv8dcxkC6NQF2bF2WWsuys
Message-ID: <CAKmqyKNje558mVKrDVKuC3j5tOkZkBJKyBcG7GSYWm+y8fo2HA@mail.gmail.com>
Subject: Re: [PATCH qemu v2 1/7] Rename ibex_uart to ot_uart
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
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

On Thu, Apr 9, 2026 at 5:37=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> This UART device is not specifically tied to ibex. Currently it is only u=
sed in the
> opentitan machine, which does use an ibex core, but an opentitan machine =
with a
> different core would still use this UART, hence it should be considered a=
 part of
> opentitan more than a part of ibex.
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                                |   1 +
>  hw/char/Kconfig                            |   3 +
>  hw/char/meson.build                        |   2 +-
>  hw/char/{ibex_uart.c =3D> ot_uart.c}         | 177 ++++++++++-----------
>  hw/riscv/Kconfig                           |   1 +
>  hw/riscv/opentitan.c                       |   2 +-
>  include/hw/char/{ibex_uart.h =3D> ot_uart.h} |  20 +--
>  include/hw/riscv/opentitan.h               |   4 +-
>  8 files changed, 107 insertions(+), 103 deletions(-)
>  rename hw/char/{ibex_uart.c =3D> ot_uart.c} (75%)
>  rename include/hw/char/{ibex_uart.h =3D> ot_uart.h} (84%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced8..9bd0b98f09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1719,6 +1719,7 @@ L: qemu-riscv@nongnu.org
>  S: Supported
>  F: hw/riscv/opentitan.c
>  F: hw/*/ibex_*.c
> +F: hw/*/ot_*.c
>  F: include/hw/riscv/opentitan.h
>  F: include/hw/*/ibex_*.h
>
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 020c0a84bb..23ddab6b78 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -95,3 +95,6 @@ config IP_OCTAL_232
>      bool
>      default y
>      depends on IPACK
> +
> +config OT_UART
> +    bool
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index fc3d7ee506..056153085f 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -2,7 +2,7 @@ system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cad=
ence_uart.c'))
>  system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-u=
art.c'))
>  system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
>  system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
> -system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
> +system_ss.add(when: 'CONFIG_OT_UART', if_true: files('ot_uart.c'))
>  system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
>  system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'=
))
>  system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
> diff --git a/hw/char/ibex_uart.c b/hw/char/ot_uart.c
> similarity index 75%
> rename from hw/char/ibex_uart.c
> rename to hw/char/ot_uart.c
> index 26ed1aea14..b3eb619641 100644
> --- a/hw/char/ibex_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU lowRISC Ibex UART device
> + * QEMU OpenTitan UART device
>   *
>   * Copyright (c) 2020 Western Digital
>   *
> @@ -26,7 +26,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/char/ibex_uart.h"
> +#include "hw/char/ot_uart.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/qdev-clock.h"
>  #include "hw/core/qdev-properties.h"
> @@ -74,7 +74,7 @@ REG32(OVRD, 0x28)
>  REG32(VAL, 0x2C)
>  REG32(TIMEOUT_CTRL, 0x30)
>
> -static void ibex_uart_update_irqs(IbexUartState *s)
> +static void ot_uart_update_irqs(OtUARTState *s)
>  {
>      if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_WATER=
MARK_MASK) {
>          qemu_set_irq(s->tx_watermark, 1);
> @@ -101,9 +101,9 @@ static void ibex_uart_update_irqs(IbexUartState *s)
>      }
>  }
>
> -static int ibex_uart_can_receive(void *opaque)
> +static int ot_uart_can_receive(void *opaque)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>
>      if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK)
>             && !(s->uart_status & R_STATUS_RXFULL_MASK)) {
> @@ -113,9 +113,9 @@ static int ibex_uart_can_receive(void *opaque)
>      return 0;
>  }
>
> -static void ibex_uart_receive(void *opaque, const uint8_t *buf, int size=
)
> +static void ot_uart_receive(void *opaque, const uint8_t *buf, int size)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>      uint8_t rx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_RXILVL_MA=
SK)
>                              >> R_FIFO_CTRL_RXILVL_SHIFT;
>
> @@ -133,13 +133,13 @@ static void ibex_uart_receive(void *opaque, const u=
int8_t *buf, int size)
>          s->uart_intr_state |=3D R_INTR_STATE_RX_WATERMARK_MASK;
>      }
>
> -    ibex_uart_update_irqs(s);
> +    ot_uart_update_irqs(s);
>  }
>
> -static gboolean ibex_uart_xmit(void *do_not_use, GIOCondition cond,
> -                               void *opaque)
> +static gboolean ot_uart_xmit(void *do_not_use, GIOCondition cond,
> +                             void *opaque)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>      uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MA=
SK)
>                              >> R_FIFO_CTRL_TXILVL_SHIFT;
>      int ret;
> @@ -155,7 +155,7 @@ static gboolean ibex_uart_xmit(void *do_not_use, GIOC=
ondition cond,
>          s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
>          s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
>          s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
> -        ibex_uart_update_irqs(s);
> +        ot_uart_update_irqs(s);
>          return G_SOURCE_REMOVE;
>      }
>
> @@ -168,7 +168,7 @@ static gboolean ibex_uart_xmit(void *do_not_use, GIOC=
ondition cond,
>
>      if (s->tx_level) {
>          guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> -                                        ibex_uart_xmit, s);
> +                                        ot_uart_xmit, s);
>          if (!r) {
>              s->tx_level =3D 0;
>              return G_SOURCE_REMOVE;
> @@ -176,7 +176,7 @@ static gboolean ibex_uart_xmit(void *do_not_use, GIOC=
ondition cond,
>      }
>
>      /* Clear the TX Full bit */
> -    if (s->tx_level !=3D IBEX_UART_TX_FIFO_SIZE) {
> +    if (s->tx_level !=3D OT_UART_TX_FIFO_SIZE) {
>          s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
>      }
>
> @@ -191,20 +191,20 @@ static gboolean ibex_uart_xmit(void *do_not_use, GI=
OCondition cond,
>          s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
>      }
>
> -    ibex_uart_update_irqs(s);
> +    ot_uart_update_irqs(s);
>      return G_SOURCE_REMOVE;
>  }
>
> -static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,
> +static void uart_write_tx_fifo(OtUARTState *s, const uint8_t *buf,
>                                 int size)
>  {
>      uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MA=
SK)
>                              >> R_FIFO_CTRL_TXILVL_SHIFT;
>
> -    if (size > IBEX_UART_TX_FIFO_SIZE - s->tx_level) {
> -        size =3D IBEX_UART_TX_FIFO_SIZE - s->tx_level;
> -        qemu_log_mask(LOG_GUEST_ERROR, "ibex_uart: TX FIFO overflow");
> +    if (size > OT_UART_TX_FIFO_SIZE - s->tx_level) {
> +        size =3D OT_UART_TX_FIFO_SIZE - s->tx_level;
> +        qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
>      }
>
>      memcpy(s->tx_fifo + s->tx_level, buf, size);
> @@ -216,10 +216,10 @@ static void uart_write_tx_fifo(IbexUartState *s, co=
nst uint8_t *buf,
>
>      if (s->tx_level >=3D tx_fifo_level) {
>          s->uart_intr_state |=3D R_INTR_STATE_TX_WATERMARK_MASK;
> -        ibex_uart_update_irqs(s);
> +        ot_uart_update_irqs(s);
>      }
>
> -    if (s->tx_level =3D=3D IBEX_UART_TX_FIFO_SIZE) {
> +    if (s->tx_level =3D=3D OT_UART_TX_FIFO_SIZE) {
>          s->uart_status |=3D R_STATUS_TXFULL_MASK;
>      }
>
> @@ -227,9 +227,9 @@ static void uart_write_tx_fifo(IbexUartState *s, cons=
t uint8_t *buf,
>                (s->char_tx_time * 4));
>  }
>
> -static void ibex_uart_reset(DeviceState *dev)
> +static void ot_uart_reset(DeviceState *dev)
>  {
> -    IbexUartState *s =3D IBEX_UART(dev);
> +    OtUARTState *s =3D OT_UART(dev);
>
>      s->uart_intr_state =3D 0x00000000;
>      s->uart_intr_state =3D 0x00000000;
> @@ -248,10 +248,10 @@ static void ibex_uart_reset(DeviceState *dev)
>
>      s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
>
> -    ibex_uart_update_irqs(s);
> +    ot_uart_update_irqs(s);
>  }
>
> -static uint64_t ibex_uart_get_baud(IbexUartState *s)
> +static uint64_t ot_uart_get_baud(OtUARTState *s)
>  {
>      uint64_t baud;
>
> @@ -262,10 +262,9 @@ static uint64_t ibex_uart_get_baud(IbexUartState *s)
>      return baud;
>  }
>
> -static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
> -                                       unsigned int size)
> +static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned int siz=
e)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>      uint64_t retvalue =3D 0;
>
>      switch (addr >> 2) {
> @@ -342,25 +341,25 @@ static uint64_t ibex_uart_read(void *opaque, hwaddr=
 addr,
>      return retvalue;
>  }
>
> -static void ibex_uart_write(void *opaque, hwaddr addr,
> -                                  uint64_t val64, unsigned int size)
> +static void ot_uart_write(void *opaque, hwaddr addr, uint64_t val64,
> +                          unsigned int size)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>      uint32_t value =3D val64;
>
>      switch (addr >> 2) {
>      case R_INTR_STATE:
>          /* Write 1 clear */
>          s->uart_intr_state &=3D ~value;
> -        ibex_uart_update_irqs(s);
> +        ot_uart_update_irqs(s);
>          break;
>      case R_INTR_ENABLE:
>          s->uart_intr_enable =3D value;
> -        ibex_uart_update_irqs(s);
> +        ot_uart_update_irqs(s);
>          break;
>      case R_INTR_TEST:
>          s->uart_intr_state |=3D value;
> -        ibex_uart_update_irqs(s);
> +        ot_uart_update_irqs(s);
>          break;
>
>      case R_CTRL:
> @@ -393,7 +392,7 @@ static void ibex_uart_write(void *opaque, hwaddr addr=
,
>                            "%s: UART_CTRL_RXBLVL is not supported\n", __f=
unc__);
>          }
>          if (value & R_CTRL_NCO_MASK) {
> -            uint64_t baud =3D ibex_uart_get_baud(s);
> +            uint64_t baud =3D ot_uart_get_baud(s);
>
>              s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
>          }
> @@ -448,122 +447,122 @@ static void ibex_uart_write(void *opaque, hwaddr =
addr,
>      }
>  }
>
> -static void ibex_uart_clk_update(void *opaque, ClockEvent event)
> +static void ot_uart_clk_update(void *opaque, ClockEvent event)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>
>      /* recompute uart's speed on clock change */
> -    uint64_t baud =3D ibex_uart_get_baud(s);
> +    uint64_t baud =3D ot_uart_get_baud(s);
>
>      s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
>  }
>
>  static void fifo_trigger_update(void *opaque)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>
>      if (s->uart_ctrl & R_CTRL_TX_ENABLE_MASK) {
> -        ibex_uart_xmit(NULL, G_IO_OUT, s);
> +        ot_uart_xmit(NULL, G_IO_OUT, s);
>      }
>  }
>
> -static const MemoryRegionOps ibex_uart_ops =3D {
> -    .read =3D ibex_uart_read,
> -    .write =3D ibex_uart_write,
> +static const MemoryRegionOps ot_uart_ops =3D {
> +    .read =3D ot_uart_read,
> +    .write =3D ot_uart_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl.min_access_size =3D 4,
>      .impl.max_access_size =3D 4,
>  };
>
> -static int ibex_uart_post_load(void *opaque, int version_id)
> +static int ot_uart_post_load(void *opaque, int version_id)
>  {
> -    IbexUartState *s =3D opaque;
> +    OtUARTState *s =3D opaque;
>
> -    ibex_uart_update_irqs(s);
> +    ot_uart_update_irqs(s);
>      return 0;
>  }
>
> -static const VMStateDescription vmstate_ibex_uart =3D {
> -    .name =3D TYPE_IBEX_UART,
> +static const VMStateDescription vmstate_ot_uart =3D {
> +    .name =3D TYPE_OT_UART,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .post_load =3D ibex_uart_post_load,
> +    .post_load =3D ot_uart_post_load,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINT8_ARRAY(tx_fifo, IbexUartState,
> -                            IBEX_UART_TX_FIFO_SIZE),
> -        VMSTATE_UINT32(tx_level, IbexUartState),
> -        VMSTATE_UINT64(char_tx_time, IbexUartState),
> -        VMSTATE_TIMER_PTR(fifo_trigger_handle, IbexUartState),
> -        VMSTATE_UINT32(uart_intr_state, IbexUartState),
> -        VMSTATE_UINT32(uart_intr_enable, IbexUartState),
> -        VMSTATE_UINT32(uart_ctrl, IbexUartState),
> -        VMSTATE_UINT32(uart_status, IbexUartState),
> -        VMSTATE_UINT32(uart_rdata, IbexUartState),
> -        VMSTATE_UINT32(uart_fifo_ctrl, IbexUartState),
> -        VMSTATE_UINT32(uart_fifo_status, IbexUartState),
> -        VMSTATE_UINT32(uart_ovrd, IbexUartState),
> -        VMSTATE_UINT32(uart_val, IbexUartState),
> -        VMSTATE_UINT32(uart_timeout_ctrl, IbexUartState),
> +        VMSTATE_UINT8_ARRAY(tx_fifo, OtUARTState,
> +                            OT_UART_TX_FIFO_SIZE),
> +        VMSTATE_UINT32(tx_level, OtUARTState),
> +        VMSTATE_UINT64(char_tx_time, OtUARTState),
> +        VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
> +        VMSTATE_UINT32(uart_intr_state, OtUARTState),
> +        VMSTATE_UINT32(uart_intr_enable, OtUARTState),
> +        VMSTATE_UINT32(uart_ctrl, OtUARTState),
> +        VMSTATE_UINT32(uart_status, OtUARTState),
> +        VMSTATE_UINT32(uart_rdata, OtUARTState),
> +        VMSTATE_UINT32(uart_fifo_ctrl, OtUARTState),
> +        VMSTATE_UINT32(uart_fifo_status, OtUARTState),
> +        VMSTATE_UINT32(uart_ovrd, OtUARTState),
> +        VMSTATE_UINT32(uart_val, OtUARTState),
> +        VMSTATE_UINT32(uart_timeout_ctrl, OtUARTState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>
> -static const Property ibex_uart_properties[] =3D {
> -    DEFINE_PROP_CHR("chardev", IbexUartState, chr),
> +static const Property ot_uart_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev", OtUARTState, chr),
>  };
>
> -static void ibex_uart_init(Object *obj)
> +static void ot_uart_init(Object *obj)
>  {
> -    IbexUartState *s =3D IBEX_UART(obj);
> +    OtUARTState *s =3D OT_UART(obj);
>
>      s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
> -                                  ibex_uart_clk_update, s, ClockUpdate);
> -    clock_set_hz(s->f_clk, IBEX_UART_CLOCK);
> +                                  ot_uart_clk_update, s, ClockUpdate);
> +    clock_set_hz(s->f_clk, OT_UART_CLOCK);
>
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
>
> -    memory_region_init_io(&s->mmio, obj, &ibex_uart_ops, s,
> -                          TYPE_IBEX_UART, 0x400);
> +    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s,
> +                          TYPE_OT_UART, 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>  }
>
> -static void ibex_uart_realize(DeviceState *dev, Error **errp)
> +static void ot_uart_realize(DeviceState *dev, Error **errp)
>  {
> -    IbexUartState *s =3D IBEX_UART(dev);
> +    OtUARTState *s =3D OT_UART(dev);
>
>      s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                            fifo_trigger_update, s);
>
> -    qemu_chr_fe_set_handlers(&s->chr, ibex_uart_can_receive,
> -                             ibex_uart_receive, NULL, NULL,
> +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
> +                             ot_uart_receive, NULL, NULL,
>                               s, NULL, true);
>  }
>
> -static void ibex_uart_class_init(ObjectClass *klass, const void *data)
> +static void ot_uart_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    device_class_set_legacy_reset(dc, ibex_uart_reset);
> -    dc->realize =3D ibex_uart_realize;
> -    dc->vmsd =3D &vmstate_ibex_uart;
> -    device_class_set_props(dc, ibex_uart_properties);
> +    device_class_set_legacy_reset(dc, ot_uart_reset);
> +    dc->realize =3D ot_uart_realize;
> +    dc->vmsd =3D &vmstate_ot_uart;
> +    device_class_set_props(dc, ot_uart_properties);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>
> -static const TypeInfo ibex_uart_info =3D {
> -    .name          =3D TYPE_IBEX_UART,
> +static const TypeInfo ot_uart_info =3D {
> +    .name          =3D TYPE_OT_UART,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
> -    .instance_size =3D sizeof(IbexUartState),
> -    .instance_init =3D ibex_uart_init,
> -    .class_init    =3D ibex_uart_class_init,
> +    .instance_size =3D sizeof(OtUARTState),
> +    .instance_init =3D ot_uart_init,
> +    .class_init    =3D ot_uart_class_init,
>  };
>
> -static void ibex_uart_register_types(void)
> +static void ot_uart_register_types(void)
>  {
> -    type_register_static(&ibex_uart_info);
> +    type_register_static(&ot_uart_info);
>  }
>
> -type_init(ibex_uart_register_types)
> +type_init(ot_uart_register_types)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 0222c93f87..cb4bb5f442 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -38,6 +38,7 @@ config OPENTITAN
>      default y
>      depends on RISCV32
>      select IBEX
> +    select OT_UART
>      select SIFIVE_PLIC
>      select UNIMP
>
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 309125e854..97c33d1b53 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -132,7 +132,7 @@ static void lowrisc_ibex_soc_init(Object *obj)
>
>      object_initialize_child(obj, "plic", &s->plic, TYPE_SIFIVE_PLIC);
>
> -    object_initialize_child(obj, "uart", &s->uart, TYPE_IBEX_UART);
> +    object_initialize_child(obj, "uart", &s->uart, TYPE_OT_UART);
>
>      object_initialize_child(obj, "timer", &s->timer, TYPE_IBEX_TIMER);
>
> diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ot_uart.h
> similarity index 84%
> rename from include/hw/char/ibex_uart.h
> rename to include/hw/char/ot_uart.h
> index 882796e0c6..517324b65d 100644
> --- a/include/hw/char/ibex_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU lowRISC Ibex UART device
> + * QEMU OpenTitan UART device
>   *
>   * Copyright (c) 2020 Western Digital
>   *
> @@ -22,28 +22,28 @@
>   * THE SOFTWARE.
>   */
>
> -#ifndef HW_IBEX_UART_H
> -#define HW_IBEX_UART_H
> +#ifndef HW_OT_UART_H
> +#define HW_OT_UART_H
>
>  #include "hw/core/sysbus.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/timer.h"
>  #include "qom/object.h"
>
> -#define IBEX_UART_TX_FIFO_SIZE 16
> -#define IBEX_UART_CLOCK 50000000 /* 50MHz clock */
> +#define OT_UART_TX_FIFO_SIZE 16
> +#define OT_UART_CLOCK 50000000 /* 50MHz clock */
>
> -#define TYPE_IBEX_UART "ibex-uart"
> -OBJECT_DECLARE_SIMPLE_TYPE(IbexUartState, IBEX_UART)
> +#define TYPE_OT_UART "ot-uart"
> +OBJECT_DECLARE_SIMPLE_TYPE(OtUARTState, OT_UART)
>
> -struct IbexUartState {
> +struct OtUARTState {
>      /* <private> */
>      SysBusDevice parent_obj;
>
>      /* <public> */
>      MemoryRegion mmio;
>
> -    uint8_t tx_fifo[IBEX_UART_TX_FIFO_SIZE];
> +    uint8_t tx_fifo[OT_UART_TX_FIFO_SIZE];
>      uint32_t tx_level;
>
>      uint32_t rx_level;
> @@ -70,4 +70,4 @@ struct IbexUartState {
>      qemu_irq tx_empty;
>      qemu_irq rx_overflow;
>  };
> -#endif /* HW_IBEX_UART_H */
> +#endif /* HW_OT_UART_H */
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index 5b9016e1d8..f2b4bf3814 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -21,7 +21,7 @@
>
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/intc/sifive_plic.h"
> -#include "hw/char/ibex_uart.h"
> +#include "hw/char/ot_uart.h"
>  #include "hw/timer/ibex_timer.h"
>  #include "hw/ssi/ibex_spi_host.h"
>  #include "hw/core/boards.h"
> @@ -43,7 +43,7 @@ struct LowRISCIbexSoCState {
>      /*< public >*/
>      RISCVHartArrayState cpus;
>      SiFivePLICState plic;
> -    IbexUartState uart;
> +    OtUARTState uart;
>      IbexTimerState timer;
>      IbexSPIHostState spi_host[OPENTITAN_NUM_SPI_HOSTS];
>
> --
> 2.49.1
>
>

