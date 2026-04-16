Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C6F433D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 02:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDCMo-0002Ph-Aj; Wed, 15 Apr 2026 22:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDCMn-0002PK-9R
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:22:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDCMl-0003o9-3I
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:22:04 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ba25fd27571so84208466b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 19:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776306120; cv=none;
 d=google.com; s=arc-20240605;
 b=A9JzF3y7xL19/Gjwo/PWxd0Uwc4pTBWrF/AJf4ZefYm8lqJyBDBIJ9IOa8MMRJZa/A
 DXRwK1r79URNIh8BkIx+3GOY6rj/SEo3kMzJofig+JD/LvxdGJobMIAJwhxWK49TlZCv
 HnoAr6AG1bOlOR9gVPQ7KZ7tdVDQ/Gi38HZORopIAAtq2RISSYs1HDo/qVNhSyFTTf1R
 qXtQkxa827FZ0txTUzEQ7M1YWW4EaTQPCLzEt3RZ1FSWzQCfELekx2IvhissTsVcjRCh
 h4DkDYCJjRX5J0ihn3QW9PolnynCtqsC9KHOlYq57TNZeE4fUPNcrMZfoxSuWefw+LI3
 5Upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oZTqef3ICKaVBionxvpyfMHothOzv5xzUQU/T4TnSL0=;
 fh=0EJ/GPDekDoQcPGCWG34/QtQi7icIvKHCk7zJKYyK+0=;
 b=dhSsCL2h3EzEgBWnQkuZh0/QqvEIC2xhk+Y/ULdM2mdpnPA3cicazY0fNQA88wvw6b
 h6zenSA4g2DFwlF1DFI2B0iQo8fNsnI67lDUOn7soOUtqTurajVE9Hj0PvXNqTOe9ffZ
 NmXwTZfQF35ImF16RwVY5NlAE08/DTh/q0943cE+fJ8f++JjZFyQfojW+eReBvjbEVhD
 dcrpFwOGTvoF8X8WUQQPIZgi5C93HmD9x6yB5A5dK6J8N0RZPKewCyUIOxlBGf4rLtf2
 Z0Bd6FMRGc1ZgetkuDXypAdzNzZpOrFYQRb6ek5tiFtr+MmBRTPX85YQiINjs6NTmaAY
 X5LQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776306120; x=1776910920; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZTqef3ICKaVBionxvpyfMHothOzv5xzUQU/T4TnSL0=;
 b=XYp3Mw/yfh1qsPFROyelhLHpRhN+eOV9zTD/ljKPnHw1V3gJ5CcxH9KiJld1kEAc+Z
 7PreYKfsf7+dLvM0gAFextx1szm8ptyl0XRqFcQdg3vc1PtOQSYt5ScSJfLQCDjgzthn
 sQhHwD/hpnsogrFQFswAb/Lri4dAejsHBWGYgPIzDqEuEWm7O+jCXs/Nd4Gf5XBYiIeU
 wUeDdgoa5pTYnRk9Qy8mL2D1XCWT128X6RSnqIx5UqCLdRvU559itoouTLyfT2Aus1Sd
 jQdrqZJgkXpIJTGRBw6Gf1KXhS9Gosds9A1fIOrxuS54oRmd13Nx6z78JG2f1aW/hsQX
 Kv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776306120; x=1776910920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oZTqef3ICKaVBionxvpyfMHothOzv5xzUQU/T4TnSL0=;
 b=MqKq9IPPAUMo4RSZMyvEPKiTOhh8WYT4uCfTo+7zfjswhxSBRCMOUyljAq9+96iPyj
 yRVdeROFwqt6dYS8cKOpXAPo9lbdKWVl0hileRCQD0SytRvWech84S+AnTPLOOZAFJ8N
 haRDC+e7KXMA0efkSf8EQVCLFvdhpVRoqG1MGcaaXfCz+/G21vBKtH4zWSFcBwjDAeuB
 nkISPo5uyDJGCbb6w45aR0sbO00bikjWRte8pYcdc7ypAA2p+cOgvCC+D1ztzKkV3Wff
 HYnBbaKD8uyCRXPPC35nEOekMWJyi0WWtzvANdCDksafNlGrSAnwM215k4dM1iUSdZEv
 Nl9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BGybGBDAIhvglv743ibFGuUNBTT0qReaUdzPZeXE57tP5hqvMKQyPWJUyh4sSD3NL1U4s1QWgBuqj@nongnu.org
X-Gm-Message-State: AOJu0YyOBeCAvyv7V5Po60VyWbBmNut4KaPDPhxAaKO1XfDku2V8eCdm
 EXVZGc+DuL6C7q1DIs6AYV55Pbb/GMxIcuNBvNtklW3KbApOb+xQ4f5hTDXK2nhKdN2Q9etYiB4
 dpbmi45y1+mPWPlxPs0ZxkLb2hcs1zm4=
X-Gm-Gg: AeBDietcSWrBMxRJEULD91vyC/4nWkhiAmRyD1GqF2NkXvFK+s3w3FnLBzroIo1xxi/
 yB00mKmRDt0aB+iu3bvVWHQhoVeGI9Dy3aczKUZBGS/i9IH7ZZhz8CZb/6wDN1r1Ci8NE9R3Chl
 veb8Mq+unDXV40h7Te1eP9gaF5hHM3vLMR9sjO1pK+obF2BQTmK3tbfjDNUZlLuJsxCrVxcfe7t
 CpQy8pxOAzg7HBENeYeMQ+UpB/Bz0xivU1lG4vozh1UyAyal4Ll4IbGFhiOeiC9v3UrTtd7VWYf
 0iOv9+68WzFDh6Zo2MhhwH3yQNys7Nsn1hcF0w==
X-Received: by 2002:a17:907:2687:b0:b9e:618:6d66 with SMTP id
 a640c23a62f3a-b9e06188016mr623160766b.44.1776306119899; Wed, 15 Apr 2026
 19:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-10@git.sr.ht>
In-Reply-To: <177618728515.4917.14466194789826252277-10@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 12:21:33 +1000
X-Gm-Features: AQROBzAmluYjdpFK9ofoDokcRUQVyqpnP0VkWaCLV16hhIuMPxiOrlBGoI8vNos
Message-ID: <CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=8Wd+8ZM06Q@mail.gmail.com>
Subject: Re: [PATCH qemu v3 10/10] ot_uart: switch from clock driven
 transmission to reg R/W driven transmission
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 15, 2026 at 3:22=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> this commit removes the need for the timer by instead transmitting from t=
he TX
> fifo any time it has data in it and it is enabled. This case can only ari=
se
> from a write to one of the registers in the UART, so the device will stil=
l work
> fully without the timer.

From memory the timer was included to more accurately model real
hardware, which doesn't write instantly and instead has a delay.

I also remember that if we don't have the timer and delay the UART in
Tock wouldn't work, as Tock expected a delay between writing the
buffers and the interrupt occurring. Have you tested that Tock still
works after this change?

Alistair

>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c         | 91 ++++++++++++++++-----------------------
>  hw/char/trace-events      |  2 +-
>  include/hw/char/ot_uart.h | 15 ++-----
>  3 files changed, 40 insertions(+), 68 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 910bef00f2..af0cf9ee1a 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -20,9 +20,10 @@
>  #include "qemu/osdep.h"
>  #include "hw/char/ot_uart.h"
>  #include "qemu/fifo8.h"
> +#include "qapi/error.h"
> +#include "chardev/char-fe.h"
>  #include "hw/core/cpu.h"
>  #include "hw/core/irq.h"
> -#include "hw/core/qdev-clock.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/qdev-properties-system.h"
>  #include "hw/core/registerfields.h"
> @@ -152,6 +153,18 @@ static bool ot_uart_is_rx_enabled(const OtUARTState =
*s)
>      return FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
>  }
>
> +static void ot_uart_check_baudrate(const OtUARTState *s)
> +{
> +    uint32_t nco =3D FIELD_EX32(s->regs[R_CTRL], CTRL, NCO);
> +
> +    unsigned baudrate =3D (unsigned)(((uint64_t)nco * (uint64_t)s->pclk)=
 >>
> +                                   (R_CTRL_NCO_LENGTH + 4));
> +
> +    if (baudrate) {
> +        trace_ot_uart_check_baudrate(s->ot_id, s->pclk, baudrate);
> +    }
> +}
> +
>  static int ot_uart_can_receive(void *opaque)
>  {
>      OtUARTState *s =3D opaque;
> @@ -284,7 +297,6 @@ static void ot_uart_xmit(OtUARTState *s)
>
>  static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
>  {
> -    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      if (fifo8_is_full(&s->tx_fifo)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
>          return;
> @@ -305,9 +317,6 @@ static void uart_write_tx_fifo(OtUARTState *s, uint8_=
t val)
>      if (ot_uart_is_tx_enabled(s)) {
>          ot_uart_xmit(s);
>      }
> -
> -    timer_mod(s->fifo_trigger_handle, current_time +
> -              (s->char_tx_time * 4));
>  }
>
>  static void ot_uart_reset_enter(Object *obj, ResetType type)
> @@ -328,11 +337,6 @@ static void ot_uart_reset_enter(Object *obj, ResetTy=
pe type)
>      ot_uart_reset_tx_fifo(s);
>      ot_uart_reset_rx_fifo(s);
>
> -    s->tx_level =3D 0;
> -    s->rx_level =3D 0;
> -
> -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
> -
>      /*
>       * do not reset `s->in_break`, as that tracks whether we are current=
ly
>       * receiving a break condition over UART RX from some device talking
> @@ -399,19 +403,16 @@ static gboolean ot_uart_watch_cb(void *do_not_use, =
GIOCondition cond,
>      return FALSE;
>  }
>
> -static uint64_t ot_uart_get_baud(OtUARTState *s)
> +static void ot_uart_clock_input(void *opaque, int irq, int level)
>  {
> -    uint64_t baud;
> +    OtUARTState *s =3D opaque;
>
> -    baud =3D ((s->regs[R_CTRL] & R_CTRL_NCO_MASK) >> 16);
> -    baud *=3D clock_get_hz(s->f_clk);
> -    baud >>=3D 20;
> +    g_assert(irq =3D=3D 0);
>
> -    if (baud) {
> -        trace_ot_uart_check_baudrate(s->ot_id, baud);
> -    }
> +    s->pclk =3D (unsigned)level;
>
> -    return baud;
> +    /* TODO: disable UART transfer when PCLK is 0 */
> +    ot_uart_check_baudrate(s);
>  }
>
>  static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned int siz=
e)
> @@ -553,8 +554,6 @@ static void ot_uart_write(void *opaque, hwaddr addr, =
uint64_t val64,
>          /* This will also set an IRQ once the alert handler is added */
>          break;
>      case R_CTRL:
> -        s->regs[R_CTRL] =3D value;
> -
>          if (value & R_CTRL_NF_MASK) {
>              qemu_log_mask(LOG_UNIMP,
>                            "%s: UART_CTRL_NF is not supported\n", __func_=
_);
> @@ -577,10 +576,19 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
>              qemu_log_mask(LOG_UNIMP,
>                            "%s: UART_CTRL_RXBLVL is not supported\n", __f=
unc__);
>          }
> -        if (value & R_CTRL_NCO_MASK) {
> -            uint64_t baud =3D ot_uart_get_baud(s);
> -
> -            s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> +        uint32_t prev =3D s->regs[R_CTRL];
> +        s->regs[R_CTRL] =3D value & CTRL_MASK;
> +        uint32_t change =3D prev ^ s->regs[R_CTRL];
> +        if (change & R_CTRL_NCO_MASK) {
> +            ot_uart_check_baudrate(s);
> +        }
> +        if ((change & R_CTRL_RX_MASK) && ot_uart_is_rx_enabled(s) &&
> +            !ot_uart_is_sys_loopack_enabled(s)) {
> +            qemu_chr_fe_accept_input(&s->chr);
> +        }
> +        if ((change & R_CTRL_TX_MASK) && ot_uart_is_tx_enabled(s)) {
> +            /* try sending pending data from TX FIFO if any */
> +            ot_uart_xmit(s);
>          }
>          break;
>      case R_WDATA:
> @@ -628,25 +636,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>      }
>  }
>
> -static void ot_uart_clk_update(void *opaque, ClockEvent event)
> -{
> -    OtUARTState *s =3D opaque;
> -
> -    /* recompute uart's speed on clock change */
> -    uint64_t baud =3D ot_uart_get_baud(s);
> -
> -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> -}
> -
> -static void fifo_trigger_update(void *opaque)
> -{
> -    OtUARTState *s =3D opaque;
> -
> -    if (s->regs[R_CTRL] & R_CTRL_TX_MASK) {
> -        ot_uart_xmit(s);
> -    }
> -}
> -
>  static const MemoryRegionOps ot_uart_ops =3D {
>      .read =3D ot_uart_read,
>      .write =3D ot_uart_write,
> @@ -665,15 +654,12 @@ static int ot_uart_post_load(void *opaque, int vers=
ion_id)
>
>  static const VMStateDescription vmstate_ot_uart =3D {
>      .name =3D TYPE_OT_UART,
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .post_load =3D ot_uart_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_STRUCT(tx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
>          VMSTATE_STRUCT(rx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
> -        VMSTATE_UINT32(tx_level, OtUARTState),
> -        VMSTATE_UINT64(char_tx_time, OtUARTState),
> -        VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
>          VMSTATE_ARRAY(regs, OtUARTState, REGS_COUNT, 1, vmstate_info_uin=
t32,
>                        uint32_t),
>          VMSTATE_END_OF_LIST()
> @@ -708,10 +694,6 @@ static void ot_uart_init(Object *obj)
>  {
>      OtUARTState *s =3D OT_UART(obj);
>
> -    s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
> -                                  ot_uart_clk_update, s, ClockUpdate);
> -    clock_set_hz(s->f_clk, OT_UART_CLOCK);
> -
>      for (unsigned index =3D 0; index < OT_UART_IRQ_NUM; index++) {
>          sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[index]);
>      }
> @@ -735,8 +717,7 @@ static void ot_uart_realize(DeviceState *dev, Error *=
*errp)
>
>      g_assert(s->ot_id);
>
> -    s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                          fifo_trigger_update, s);
> +    qdev_init_gpio_in_named(DEVICE(s), &ot_uart_clock_input, "clock-in",=
 1);
>
>      fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
>      fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 17cc9ad2d5..c859d8af4e 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -143,7 +143,7 @@ htif_uart_write_to_host(uint8_t device, uint8_t cmd, =
uint64_t payload) "device:
>  htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t p=
ayload) "device: %u cmd: %02u payload: %016" PRIx64
>
>  # ot_uart.c
> -ot_uart_check_baudrate(const char *id, unsigned baud) "%s: %u bps"
> +ot_uart_check_baudrate(const char *id, unsigned pclk, unsigned baud) "%s=
: @ %u Hz: %u bps"
>  ot_uart_connect_input_clock(const char *id, const char * srcname) "%s: %=
s"
>  ot_uart_debug(const char *id, const char *msg) "%s: %s"
>  ot_uart_io_read_out(const char *id, uint32_t addr, const char *regname, =
uint32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> index 2f538e1f6f..7c2b5f3457 100644
> --- a/include/hw/char/ot_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -23,11 +23,8 @@
>  #include "hw/core/sysbus.h"
>  #include "qemu/fifo8.h"
>  #include "chardev/char-fe.h"
> -#include "qemu/timer.h"
>  #include "qom/object.h"
>
> -#define OT_UART_CLOCK 50000000 /* 50MHz clock */
> -
>  #define TYPE_OT_UART "ot-uart"
>  OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)
>
> @@ -39,13 +36,6 @@ struct OtUARTState {
>      MemoryRegion mmio;
>      qemu_irq irqs[9];
>
> -    uint32_t tx_level;
> -
> -    uint32_t rx_level;
> -
> -    QEMUTimer *fifo_trigger_handle;
> -    uint64_t char_tx_time;
> -
>      uint32_t regs[13]; /* Length must be updated if regs added or remove=
d */
>
>      Fifo8 tx_fifo;
> @@ -53,10 +43,11 @@ struct OtUARTState {
>      uint32_t tx_watermark_level;
>      bool in_break;
>      guint watch_tag;
> +    unsigned pclk; /* Current input clock */
> +    const char *clock_src_name; /* IRQ name once connected */
>
>      char *ot_id;
> -    Clock *f_clk;
> -
> +    DeviceState *clock_src;
>      CharFrontend chr;
>      bool oversample_break; /* Should mock break in the oversampled VAL r=
eg? */
>      bool toggle_break; /* Are incoming breaks temporary or toggled? */
> --
> 2.49.1
>

