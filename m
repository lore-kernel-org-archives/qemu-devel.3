Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE45F433D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBma-0006hs-HA; Wed, 15 Apr 2026 21:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBmY-0006hW-Mf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:44:38 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBmV-0005XQ-Ex
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:44:38 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9c01854477so1234899666b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776303873; cv=none;
 d=google.com; s=arc-20240605;
 b=PZW+sD5q6VBbxvm/zIlI66zAqxTyQO7M64V7zeHJOTuwzgxGEsioQbAE3jBv0e0ROE
 +HMGIy8g0+SPwrYYMV6rvdJbp8tip25q7xFgAK9a6XAinSJvFwRBGcLBgGKRvtodZhZz
 2w89WRQTMtndfVpf8lvMOEJysig0VFO5mZT/cMqPH4eP0rKs7lawS+IZRBpid2ulWE5h
 NyVZV9IChjZEyC11DzbCsP7dHq6/lde57WJxjv81HGf4rzoxkrQdg+WizZSpkGJFv7bx
 j6hfvAM2+unTVHqv+lqqALFSxTCAIlzSv4H7qegV+rS17wErUSrdvb6pQXjmAxOXEkqq
 tc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5A1if7fDg5Z0Sy3YQoKlOD+tXMurPc3JHSGzyN1IXCg=;
 fh=IQxp+w2EzNLZG5F8Bclkxy6p5E/alfALRHBntq2HxOo=;
 b=NG0AQNolD9HwMSIgbKiyZ6KWvbwROllgCdCZZP1ITG+nV6w/i7b0K3iNc5/T4iEwmJ
 xsFFPFxHGeS9P5aDgZunL2kszKAHWqVIJtWFPOoTTTHW2XUKmiNd4cJLpGVOs7F8/NDh
 hp9HgBFB42wjlmlofnuOcT4EGdjDpP7CB25d24u70E+vKhE5f/dR7d/27NFJHoCMF4AH
 b6Pq6l693ywIe+ynB5KD05Shc12O+9E9v+UNNIbkkM5GkSy9mRc1ToRYOXo4AA5XHD1H
 ao49n+aLR4D3j2I0rMTbho7yjbwLDcij3a8CBiyWgMrITyRTpkINIHcVwgzfMEjn8u5Z
 ymdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776303873; x=1776908673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5A1if7fDg5Z0Sy3YQoKlOD+tXMurPc3JHSGzyN1IXCg=;
 b=XTHXCKHH963i+jf85LH7I1D6D946zJ0QYWFYpYUU0aiahqEz/LfJfjDxwXd/Imbord
 FYcX1lobu4E8L0vSea571cKTdlXI3kvnc+zu4u3h30FD9BrVq2S6C6ZfF9dsUDL4wBxW
 YFKtgCwgNpxK6w2KtVlt9TSkycZv8z7dH7oRsfNaEixDmW39RmQ+kodsj9pbDFlqTdnq
 ozgtWk8R4so6Iaw1dWIe+9X3eup1oNThZNMiPgl/rH0dSqB9m7O5g6eFXDsimOJiBzmv
 Ju0X5WKPFnxpOZ20PQ9syWaXZRUkx0rtSRKIFfHMKU7wfhdQisFM/yU3M61qzeEKdIpH
 KeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776303873; x=1776908673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5A1if7fDg5Z0Sy3YQoKlOD+tXMurPc3JHSGzyN1IXCg=;
 b=QK+/IASVjz7ROreuQ94/ujf+7T5LZRBiFd77IzWPhzdAGabg20uuv5Womw7M3dvsTn
 QfcaS9f5NU38G+YMwtYr+L7B9wQO6aNioYo4q+z7KXrkaAsxw5qdvQSWfqwVviLQcQKa
 kW0Yp1bkGt1oAa/ziIaj7Zwt8eHGj39KrVXAmgDvRRcSojzGLNtyfpuS65iYvtPVIZ65
 rR6Om0dgb+txbZ5PGT1eQsBY10PKhzfqmeuRXrJJ73QOk8GZ6Ap3/QyrtKe7llqH9Kw/
 JBItPO8KvfdlX3+E0Izfst13iNZsfMbjO+d6htBLSrw0juWsbttp2c7EvRoyxZRWrik5
 h2Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ezitr1nHYAHTm+Ku9+RDLtx8peKi4CurfsMJXM3DqxMR09O+nLkjab6RDYQeU7qJwb3OMCrldG33m@nongnu.org
X-Gm-Message-State: AOJu0YyAlGu7zvA0DorRbtWSNHQQXmnaoKrzHGYerwrcaZDiq9cxzImM
 g3pHdqiVP3W2RNo2eGN2P40JgtqoWEhoPfNOOksPrhEHSRgFz7CCgvRK6mkN31c1mV38UPKn5x+
 MEFwgoE2CFSWCuXxOa5Tlq9w4M7RiCwM=
X-Gm-Gg: AeBDietxR9TtUGGN4TMJhPpYtDspfZFVs8kQPMVaqMGVIEgf2Uk24HsGbeKJPIvs6t3
 8G3nDXQPUce6keDdYWJl1z2OWDUuRSgEXoOmo7ZTFbSXOdgnkklnmos8V4atMb+ozkDhAeKu2mA
 UBpQByrGJhmKkN4vPzwBHRBxtG244WFAOMDD4V08Mjl6HE0f/Jvk96IFOIr3EnNimbgHNHtTlhv
 xLvdiZmNg2AUgTJ3p91ux8ad8k/yubGGtvV6p5JPOVBz76M7MUG+HLdMfa8YENhgnJPvxnGI4pi
 +TCAiSV0pqfXeAPSqizbpxv4+SIIT/NItNYfYAiE0L4vt1Im
X-Received: by 2002:a17:907:788:b0:b9c:2a5f:41c4 with SMTP id
 a640c23a62f3a-b9d72683456mr1355479766b.40.1776303873190; Wed, 15 Apr 2026
 18:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-7@git.sr.ht>
In-Reply-To: <177618728515.4917.14466194789826252277-7@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 11:44:06 +1000
X-Gm-Features: AQROBzDOd-LI14eDBiezsrFN_qnauj9MKt-PUgM5Z32u6F_AswIEBOYVvZstwrc
Message-ID: <CAKmqyKPcbJA1aiFE29oraWCNrtOS3sUp1YT3-O69BxLNppUA9w@mail.gmail.com>
Subject: Re: [PATCH qemu v3 07/10] ot_uart: handle break condition
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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
> This adds a handler for the UART break event, and logic to emulate a brea=
k
> when oversampling is enabled and there is a break event.

I'm not clear why we need to model break events. Can you explain what
a break event is (I assume holding the line low) and why you are
modelling it in the commit message?

Also we need some documentation of the new properties, as it isn't
clear what they are and when they should be set. Maybe add that to the
OT machine docs?


Alistair

>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c         | 92 +++++++++++++++++++++++++++++++++++++--
>  include/hw/char/ot_uart.h |  4 ++
>  2 files changed, 93 insertions(+), 3 deletions(-)
>
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
>  };
>
> +static int ot_uart_fe_change(void *opaque)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_recei=
ve,
> +                             ot_uart_event_handler, ot_uart_fe_change, s=
, NULL,
> +                             true);
> +
> +    if (s->watch_tag > 0) {
> +        g_source_remove(s->watch_tag);
> +        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_=
HUP,
> +                                             ot_uart_watch_cb, s);
> +    }
> +
> +    return 0;
> +}
> +
>  static void ot_uart_init(Object *obj)
>  {
>      OtUARTState *s =3D OT_UART(obj);
> @@ -644,9 +730,9 @@ static void ot_uart_realize(DeviceState *dev, Error *=
*errp)
>      fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
>      fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
>
> -    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
> -                             ot_uart_receive, NULL, NULL,
> -                             s, NULL, true);
> +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_recei=
ve,
> +                             ot_uart_event_handler, ot_uart_fe_change, s=
, NULL,
> +                             true);
>  }
>
>  static void ot_uart_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> index a2c5ff8b33..997bf2f367 100644
> --- a/include/hw/char/ot_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -56,10 +56,14 @@ struct OtUARTState {
>      Fifo8 tx_fifo;
>      Fifo8 rx_fifo;
>      uint32_t tx_watermark_level;
> +    bool in_break;
> +    guint watch_tag;
>
>      Clock *f_clk;
>
>      CharFrontend chr;
> +    bool oversample_break; /* Should mock break in the oversampled VAL r=
eg? */
> +    bool toggle_break; /* Are incoming breaks temporary or toggled? */
>  };
>
>  struct OtUARTClass {
> --
> 2.49.1
>
>

