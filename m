Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB4DCD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjOb-0006B6-Ix; Tue, 26 May 2026 00:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRjOa-0006Aa-DS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:28:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRjOY-0006MX-1z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:28:00 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bdbac72ac1fso917758066b.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779769676; cv=none;
 d=google.com; s=arc-20240605;
 b=knN7Vj/0iR4Ivf/DIU4WPx5ymk9hVx+UX348O20k2gI4UNbl/2oowpVIT5d5bAQm/J
 9BQrm10OBxsN0CPKfrL88Mw+NulVpaNhcjguZPTvjc0QAydzU6OdqZk1xldSKzOc5uC7
 /porMqUaQrLQ8XCx2jt+Msrp+LokE7VMrZRnel79IVhBstXN1EFg/CHv7ZdfEwUVn/9C
 1kDXjJnNeDrfEUYpAcl/RW7DKMyA3am2StWUr/zscK8mcGS77Fl739hc6FOYsMCxR/Pi
 s6nq2vsncqSORbpS39FA0VMl565wP537a8aU7yPoKDGk296Kp1WpzUD7Rz7GUP7oZfeq
 9vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ePS9319Ld18MjSOXMiF/kpWjWE595WWO+OesX3qR6Lo=;
 fh=vqhj9gNyj3r48x+Jqh0wFVcQVAhsxG1j/bhU6rKsPEk=;
 b=JzlnRcmJ1myQqFrdMGVyOCGq6RVSSWAHCx1HgD7IoHf2QUGvTUjwkOLBWvKbmwvgWN
 9VlYKUERi1FFnPb2ZzB6XOGOm+gIsD/1r5BTNs8YVXCU9IlSXjUjxVHShqD4J051Kuik
 N2bwYN6+X3/TIIvnZdMR5YBPQpwHev6YvzHJugboG4mbZoaTIDCuUY6GQy54wbrbbgiK
 xEQTyLYshC+S/9tCsHerOP84hfF9UlklXJ9VlLGIMisVfBG5YeLBpFK3PoAp1r0UAAhV
 VIV8BsoI0InkXm9arNs7cLFV98PXjz2VTchUDxkA0twBpp3oMPUaOOQ94grWiCawmCcr
 dZbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769676; x=1780374476; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePS9319Ld18MjSOXMiF/kpWjWE595WWO+OesX3qR6Lo=;
 b=oYeJMSSXBor6X/yJ1Q//yKYFD6BVeKtM1qdasECdkwtg4Q9uneQJq94QmPlSqtNX+l
 PLNagI+eDfkwz+ubhUVd64n6hJkF/8qasBGUWmxMMwcP20qyvEchPbRCspiI0twx2IQm
 /HfzUrmNqo5GFjRGfypCYzjHzmrrQYwbDDINv2UV5/39pZyAXHENSwTCVpHMCKZfSdxJ
 gTam7CkPfWkyJ1BB0bU+8Q2opro/wrKrLo9H3/uCTPCYGXoTh3GpZ/b/YQ8rKrsrk8wQ
 9SfMIdZulBkpyGEXzGKJAHYZH+fGJ9eA3dI2Cw6nHfbR24nQdbbokfj45JTnrR61KCNY
 g4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769676; x=1780374476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ePS9319Ld18MjSOXMiF/kpWjWE595WWO+OesX3qR6Lo=;
 b=OMmpYgNSIizKJdgasZJcR1yx11x9zNoUT6PdDx7Ms2IiofDEX9WWCEg4ICQy11AJaC
 +NxKl8aOZjtb3jRxbVz4iaLABKkCMem5ZwFHJAy3pRu9X579mUg3v0gaT64PB1x8CyvK
 6yQqVqc5KXFT1JLU/58R/1AAeI+djaDyGBEM5yzlgcz/YdE92Z67HwaXxAjXuwU8oFFe
 L7mzpuYZjOe8ANtElngiz3b4XnXME4QESmFP4BCR7luH/L5Gh9bygbxCoeUmglDjqsKt
 0lLRyk6iMbcfrEJPkzlBD/tkjjGqVnkn5F4zlaURjlHcgMNX7rAvZ+jpQHjEvlbsL9D4
 Pzbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KYMNoqWqy7jxUUM3ZRTZTJDDAdPMMKIMCQ/PZnNAotw1QYmMtLFNz9ANBFTbYPnWyHPlgN2iky9v9@nongnu.org
X-Gm-Message-State: AOJu0Yx6v3trkXDQjlhGuAhwLvF6RaapI6qCqsY0dyi/DQgzuuHG091I
 fFWg3IOpCLWETGaQLaI1oBBzoKpzPATX+8ztYmGN65Fumsv0ZnZd909cJbJokH5urk0VXqu18js
 PFu5Gu6HrgW1IIQT80uqOYngjwyu3TJo=
X-Gm-Gg: Acq92OG1aLDQ8zy/amIpaIIJC7mAvfNb4cDtKgPuNlQzt6Dv4sIDIRZ61cYZNKEIcgu
 ZW7G/xjjwHENsJ6fNoxbeBG4tU0xQw4XuL+sbnL+E5lrDQ3FtEVyrJw6RcwLIIhdlBNcec9lQhp
 J8wBmbpdju4SdlPk0F6S2d+BQxwOcVNUVh5iwy/DcjvXTSczcBlvmCmZewQVMCPQ0R02aiZ/Y+t
 IBDVdkKS5PR2DzFZcqCswx+SYF0iQar2HcXu++U69xzzR2Ma+sOkyF+fwzre0wgAP9Bt8AK8MtW
 ET9SLSoL4aodrR0qeQi603ah0uBsg4qWKzxMDw==
X-Received: by 2002:a17:907:7750:b0:bc4:b9f5:fe27 with SMTP id
 a640c23a62f3a-bdd22a3f5abmr678002766b.10.1779769676188; Mon, 25 May 2026
 21:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-7@git.sr.ht>
In-Reply-To: <177756498815.8917.12449488721849651971-7@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 14:27:29 +1000
X-Gm-Features: AVHnY4KVTyrrqH9xYdP9pDqxF9kZKmRCmLKW4v93zfr9hSAUv-GgL-_EzM4Zs1w
Message-ID: <CAKmqyKMP_wOVV1yAeGeuT2vnGGB=2DuTgZo0dWr6F5uHt4TwpA@mail.gmail.com>
Subject: Re: [PATCH qemu v4 7/9] ot_uart: handle break condition
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Fri, May 1, 2026 at 2:04=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> What is a break event:
> Normally, a UART wire is held high by the transmitting device any time th=
e
> communication channel is idle (nothing to transmit). If a receiver does n=
ot see
> that its receive line is high, this means one of two things:
>     1. there is a transmission happening now
>     2. there is no transmitter connected, and the line is floating or pul=
led
>        low, or the transmitting device is in a bad state or reset state a=
nd so
>        it has not yet asserted its TX output.
>
> In case 1, the line will go high again very soon.
> In case 2, it is sometimes useful to detect that this is the case and sig=
nal to
> the software that this has happened (normally by means of an interrupt)
>
> The ot_uart device does exactly this in case 2. It detects that this is
> happening by detecting when the RX pin stays low for an extended period. =
This
> period can be configured to be 2, 4, 8, or 16 times a character period. T=
he
> character period itself depends on the configuration of the device (baud =
rate,
> and parity bit)
>
> for more details about how this works, there is documentation about the U=
ART
> break detection on this page:
> https://opentitan.org/book/hw/ip/uart/doc/theory_of_operation.html#rx_bre=
ak_err
>
> This commit adds a handler for the UART break event, and logic to emulate=
 a
> break when oversampling is enabled and there is a break event.
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  docs/system/riscv/opentitan-uart.rst | 43 +++++++++++++
>  hw/char/ot_uart.c                    | 92 +++++++++++++++++++++++++++-
>  include/hw/char/ot_uart.h            |  4 ++
>  3 files changed, 136 insertions(+), 3 deletions(-)
>  create mode 100644 docs/system/riscv/opentitan-uart.rst
>
> diff --git a/docs/system/riscv/opentitan-uart.rst b/docs/system/riscv/ope=
ntitan-uart.rst
> new file mode 100644
> index 0000000000..7ca596712d
> --- /dev/null
> +++ b/docs/system/riscv/opentitan-uart.rst

We should just add an OpenTitan Machine documentation here and include
the UART there.

> @@ -0,0 +1,43 @@
> +# OpenTitan UART Support
> +
> +## Connecting to the UART
> +
> +* `-serial mon:stdio`, used as the first `-serial` option, redirects the=
 virtual UART0 to the
> +  current console/shell.
> +
> +* `-chardev socket,id=3Dserial1,host=3Dlocalhost,port=3D8001,server=3Don=
,wait=3Doff` and
> +  `-serial chardev:serial1` can be used to redirect UART1 (in this examp=
le) to a TCP socket. These
> +  options are not specific to OpenTitan emulation, but are useful to com=
municate over a UART.
> +  Note that QEMU offers many `chardev` backends, please check QEMU docum=
entation for details.
> +
> +## Sending Break Conditions
> +
> +Break conditions can be sent to the UART on select supported CharDev bac=
kends (telnet, mux)
> +or by sending the `chardev-send-break` command with the CharDev ID via t=
he QEMU Monitor.
> +Break conditions are treated as transient events and the length of time =
of a break condition
> +is not considered.
> +
> +## Oversampling
> +
> +OpenTitan's UART has a `VAL` register which oversamples the RX pin 16 ti=
mes per bit.
> +This cannot be emulated by QEMU which uses a CharDev backend and does no=
t have a notion of
> +accurate sampling times.
> +
> +If software wishes to poll the `VAL` register to determine break conditi=
ons, there are
> +some properties available to help with emulating this use case:
> +
> +* `-global ot-uart.oversample-break=3Dtrue` is used to enable UART break=
 oversampling.
> +  This will attempt to display 16 samples of the last bit received in th=
e `VAL` register,
> +  which will be 16 high bits after any UART frame is transmitted (as the=
se end with a stop
> +  bit, which is high), or 16 low bits if the UART previously received a =
break condition
> +  and has not received any frames since. That is, enabling this property=
 assumes that
> +  transmitted break conditions are "held" until the next UART transfer i=
n terms of what
> +  is being shown in the oversampled `VAL` register.
> +
> +* `-global ot-uart.toggle-break=3Dtrue` is used to provide more control =
over "holding"
> +  the UART RX break condition like a GPIO strap, and changes the behavio=
r of a UART
> +  such that received break condition events now *toggle* the break condi=
tion state
> +  rather than keeping it asserted until the next transfer. This allows a=
ny device talking
> +  to OpenTitan via UART to have more precise control over when the UART =
VAL register
> +  displays idle and when it displays a break condition, as it can precis=
ely toggle the
> +  break condition on or off like a GPIO strapping being held down.
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 3511a42fbe..cdf02da62b 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -179,6 +179,11 @@ static void ot_uart_receive(void *opaque, const uint=
8_t *buf, int size)
>      uint32_t rx_watermark_level;
>      size_t count =3D MIN(fifo8_num_free(&s->rx_fifo), (size_t)size);
>
> +    if (size && !s->toggle_break) {
> +        /* no longer breaking, so emulate idle in oversampled VAL regist=
er */
> +        s->in_break =3D false;
> +    }
> +
>      for (int index =3D 0; index < size; index++) {
>          fifo8_push(&s->rx_fifo, buf[index]);
>      }
> @@ -331,9 +336,40 @@ static void ot_uart_reset_enter(Object *obj, ResetTy=
pe type)
>
>      s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
>
> +    /*
> +     * do not reset `s->in_break`, as that tracks whether we are current=
ly
> +     * receiving a break condition over UART RX from some device talking
> +     * to OpenTitan, which should survive resets. The QEMU CharDev only
> +     * supports transient break events and not the notion of holding the
> +     * UART in break, so remembering breaks like this is required to
> +     * support mocking of break conditions in the oversampled `VAL` reg.
> +     */
> +    if (s->in_break) {
> +        /* ignore CTRL.RXBLVL as we have no notion of break "time" */
> +        s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> +    }
> +
>      ot_uart_update_irqs(s);
>  }
>
> +static void ot_uart_event_handler(void *opaque, QEMUChrEvent event)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    if (event =3D=3D CHR_EVENT_BREAK) {
> +        if (!s->in_break || !s->oversample_break) {
> +            /* ignore CTRL.RXBLVL as we have no notion of break "time" *=
/
> +            s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> +            ot_uart_update_irqs(s);
> +            /* emulate break in the oversampled VAL register */
> +            s->in_break =3D true;
> +        } else if (s->toggle_break) {
> +            /* emulate toggling break off in the oversampled VAL registe=
r */
> +            s->in_break =3D false;
> +        }
> +    }
> +}
> +
>  static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
>  {
>      uint8_t val;
> @@ -355,6 +391,17 @@ static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
>      return val;
>  }
>
> +static gboolean ot_uart_watch_cb(void *do_not_use, GIOCondition cond,
> +                                 void *opaque)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    s->watch_tag =3D 0;
> +    ot_uart_xmit(s);
> +
> +    return FALSE;
> +}
> +
>  static uint64_t ot_uart_get_baud(OtUARTState *s)
>  {
>      uint64_t baud;
> @@ -424,6 +471,26 @@ static uint64_t ot_uart_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>          break;
>
>      case R_VAL:
> +        /*
> +         * This is not trivially implemented due to the QEMU UART
> +         * interface. There is no way to reliably sample or oversample
> +         * given our emulated interface, but some software might poll th=
e
> +         * value of this register to determine break conditions.
> +         *
> +         * As such, default to reporting 16 of the last sample received
> +         * instead. This defaults to 16 idle high samples (as a stop bit=
 is
> +         * always the last received), except for when the `oversample-br=
eak`
> +         * property is set and a break condition is received over UART R=
X,
> +         * where we then show 16 low samples until the next valid UART
> +         * transmission is received (or break is toggled off with the
> +         * `toggle-break` property enabled). This will not be accurate, =
but
> +         * should be sufficient to support basic software flows that
> +         * essentially use UART break as a strapping mechanism.
> +         */
> +        retvalue =3D (s->in_break && s->oversample_break) ? 0u : UINT16_=
MAX;
> +        qemu_log_mask(LOG_UNIMP, "%s: VAL only shows idle%s\n", __func__=
,
> +                      (s->oversample_break ? "/break" : ""));
> +        break;
>      case R_OVRD:
>      case R_TIMEOUT_CTRL:
>          retvalue =3D s->regs[reg];
> @@ -607,8 +674,27 @@ static const VMStateDescription vmstate_ot_uart =3D =
{
>
>  static const Property ot_uart_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", OtUARTState, chr),
> +    DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break, =
false),
> +    DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false),

Why have these disabled by default?

Alistair

