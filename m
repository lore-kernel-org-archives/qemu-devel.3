Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F3FCD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 10:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXzXi-0000gE-5g; Fri, 12 Jun 2026 06:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXzXg-0000eM-M9
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 06:55:16 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXzXd-0004v3-EQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 06:55:16 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so1062246eec.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 03:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781261711; cv=none;
 d=google.com; s=arc-20240605;
 b=Pc2ddBsqBDG89d5PnvYhlNhD4A6B3Gp31IrBVGrJ+yAvD5pkF1voaalJYVKswI/vDk
 X0vItnD3r2LQfLGm1bvOZb654M8KbRwiqLI67Pbed/YT1UCdMz13H8M5b9c+IsI0aJ5i
 kP40zRQWEuU+x+sGt7UYcUrOB/XDWmAxVVjR1IVfOEJBemRR2u5VZvm8wazboaiPsuCa
 Z8GzxC2aEqKymOulK2Guex2csPIuVlSOLDDBAuxlVG7MjnLqV6R3HOyKpnxDhoh+t7d/
 nIfEIvYfApIV6l7hd3UkhHHFTuofWQdhcnzDaYRkMOZUvbRV3KkAARcpH3KykBpPD8C7
 OmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ODMwCf71FQqa44jIJu/H1M440+mEdp0RjOvbuzbclw=;
 fh=k1zQqcZIuBvSrbmEz+KUzDMXlXOzM9Ueirzfbp+KxpI=;
 b=TlHSOXNDExMmMW+FdJbil3FevU7jzUXjO4Tl8WWtl5QYcOz2gXuj/7U5etxD//YBvB
 fXoddV7nFEh3kL6RW975R73EC+ihCXn12SUvuOYuHnILSVgEN7XBfAp/ruNchXX25cpp
 GKGu7JbuYU67IewNc4ZjUW8zpmcERSLzRa1n09X1BdNWPrJzEd1VaZIW/Ggr6ij4OXy6
 VOfaiz9f91XlbtCIQsY0AYCSHUzPUuqYzYp9e5N2oZVjxe7Spzr/aRL//feTblRGeKYI
 1euz1izmnIr5DO0G63VhBhe0ssHveUcZf8YfZ3q8idznqrdM53Z3m63KQ4ENDvSesVsF
 rzcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781261711; x=1781866511; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ODMwCf71FQqa44jIJu/H1M440+mEdp0RjOvbuzbclw=;
 b=EMQxBuJU8HgxkQTtDyYoROT3oA3awu9UEsn36NRKjFmVb9ybUoMTwYEVmK6CRQkUVU
 Im1OUlij58SIyR1W5Nkf/LpS6SPGB5LvTxsXtGapIROf/XOp+Pp4e8UsdxTa7huPfaHI
 7hsj/26n4DcRfTuCg//QcFO7puiZa3Xwp1JZlcs+cJCx6/X8SiQW9252vmWHIc3kGugX
 2rex/pBfy0amiLGqeKPmNReSYR76opXJTAVs7ViBLUmXsDY3X5Y3PCpV1dxTSvDxOzpg
 pPcRqRckyyOV4Lib7YswB4EWakZwLmtuGD6SwA/cKYqILUIkWe3/pS+ADZWGDhJt6lVc
 h9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781261711; x=1781866511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ODMwCf71FQqa44jIJu/H1M440+mEdp0RjOvbuzbclw=;
 b=rpkD19NMcp1cOwcDAM7oC8cXpCob9cQKYmsHaV/4QnkB/LPXOiEyiT4nXi3gwARu8c
 DsysoICUQJy8+Yd4atFm90Ko3JaaOJgXzf9sxFrlmm/s9N1S3xjEogs3QJmn0qPVVozy
 sqRL3R4xvYLOyy4lylcfSdx6Nz9oLUXJQiplxHbj9nE5P0ax6NjbmW/oPeYZg6qWf0qI
 1Nt+c++utfLre6VKoMThz11FDm+vMqCTblpF/EZEpzPUlSXXzZ/Mt1vL6MuIgKB+PP6q
 DfFtowylwn17ApBfLWfbdKbyu3kqEKTmieYjE28lX1yVj6U1ne2Dw244Q4yxh4ZVjfKH
 HCwg==
X-Gm-Message-State: AOJu0YzATY8GgrvTdBRRQw7PgbZ1tvSZc5sXGAeG+5MaTH15Ol/avfSW
 fGEeJ6YzJOhviERcqpMKhEF+742gvX8wOsY8/0IWz063E+ArQmsro9vg63JTY6kNxeah5FElhyP
 QUPML+1qldUSbPH28yFQhtkZThPxNWEhaYSMC
X-Gm-Gg: Acq92OG3qunwwPdu2baHH5fhI4ZfCcyQl1sSEs2EFr9bQ57e4lJ6YgIqvzlhad8oXRs
 2vLIlaGlN4LFsvxaQCPeKN+kTSlzMm/fv5Wi0Y4bGWTB/jFiGoi1PP7WCDACkR528dEuqRhlOXs
 Y+ooMZcMSfzcp09E2o9oe1oQVGcWHxeSJWki2SIcNTLChENAq32GElCM/TXfoeowxL4LzjpRaDC
 U+W4Dxn4On5ovBTMrapaT0FtI88jww9hy/SFI5dB0IKqSmKIxMq0UMPd/x5MaMNlw9C4ayv2U88
 H8NqXAsrg1V9/5zzik8FrCDoHp6DWvLb9uxNdcM=
X-Received: by 2002:a05:7300:80c5:b0:304:b14:ec53 with SMTP id
 5a478bee46e88-308200bc57cmr1368659eec.27.1781261711008; Fri, 12 Jun 2026
 03:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-3-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-3-f68452dd6a22@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Jun 2026 14:54:59 +0400
X-Gm-Features: AVVi8CcdZdjmByY568ivZvmJfn-OmPwH2pz6BHwWDc-WiDtswF3jSeQueoR2dlk
Message-ID: <CAJ+F1CLXwmdyksawoiarWARwxyt1AyRRTEbkq1Wi3=wSmeYTcw@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] hw/i386/vmmouse: convert to QemuInputHandler API
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, 
 Thomas Huth <th.huth+qemu@posteo.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
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

Hi

On Wed, Jun 10, 2026 at 2:58=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Replace the legacy QEMUPutMouseEvent callback with a proper
> QemuInputHandler registration. This eliminates one of the two
> remaining users of the legacy input adapter in ui/input-legacy.c.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

One of the 2 patches missing ack/review in this series,
thanks

> ---
>  hw/i386/vmmouse.c    | 115 +++++++++++++++++++++++++++++++++++++--------=
------
>  hw/i386/trace-events |   2 +-
>  2 files changed, 85 insertions(+), 32 deletions(-)
>
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index d54adb34a88..e289bce8e2e 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -68,7 +68,10 @@ struct VMMouseState {
>      uint16_t nb_queue;
>      uint16_t status;
>      uint8_t absolute;
> -    QEMUPutMouseEntry *entry;
> +    QemuInputHandlerState *hs;
> +    int axis[INPUT_AXIS__MAX];
> +    int dz;
> +    bool btns[INPUT_BUTTON__MAX];
>      ISAKBDState *i8042;
>  };
>
> @@ -99,39 +102,78 @@ static uint32_t vmmouse_get_status(VMMouseState *s)
>      return (s->status << 16) | s->nb_queue;
>  }
>
> -static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int =
buttons_state)
> +static void vmmouse_input_event(DeviceState *dev, QemuConsole *src,
> +                                QemuInputEvent *evt)
>  {
> -    VMMouseState *s =3D opaque;
> +    VMMouseState *s =3D VMMOUSE(dev);
> +
> +    switch (evt->type) {
> +    case INPUT_EVENT_KIND_BTN:
> +        if (evt->btn.down) {
> +            if (evt->btn.button =3D=3D INPUT_BUTTON_WHEEL_UP) {
> +                s->dz--;
> +            } else if (evt->btn.button =3D=3D INPUT_BUTTON_WHEEL_DOWN) {
> +                s->dz++;
> +            }
> +        }
> +        s->btns[evt->btn.button] =3D evt->btn.down;
> +        break;
> +    case INPUT_EVENT_KIND_ABS:
> +        if (evt->abs.axis =3D=3D INPUT_AXIS_X) {
> +            s->axis[INPUT_AXIS_X] =3D
> +                qemu_input_scale_axis(evt->abs.value,
> +                                      INPUT_EVENT_ABS_MIN, INPUT_EVENT_A=
BS_MAX,
> +                                      VMMOUSE_MIN_X, VMMOUSE_MAX_X);
> +        } else if (evt->abs.axis =3D=3D INPUT_AXIS_Y) {
> +            s->axis[INPUT_AXIS_Y] =3D
> +                qemu_input_scale_axis(evt->abs.value,
> +                                      INPUT_EVENT_ABS_MIN, INPUT_EVENT_A=
BS_MAX,
> +                                      VMMOUSE_MIN_Y, VMMOUSE_MAX_Y);
> +        }
> +        break;
> +    case INPUT_EVENT_KIND_REL:
> +        s->axis[evt->rel.axis] +=3D evt->rel.value;
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static void vmmouse_input_sync(DeviceState *dev)
> +{
> +    VMMouseState *s =3D VMMOUSE(dev);
>      int buttons =3D 0;
>
> -    if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4))
> +    if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4)) {
>          return;
> +    }
>
> -    trace_vmmouse_mouse_event(x, y, dz, buttons_state);
> -
> -    if ((buttons_state & MOUSE_EVENT_LBUTTON))
> +    if (s->btns[INPUT_BUTTON_LEFT]) {
>          buttons |=3D VMMOUSE_LEFT_BUTTON;
> -    if ((buttons_state & MOUSE_EVENT_RBUTTON))
> +    }
> +    if (s->btns[INPUT_BUTTON_RIGHT]) {
>          buttons |=3D VMMOUSE_RIGHT_BUTTON;
> -    if ((buttons_state & MOUSE_EVENT_MBUTTON))
> +    }
> +    if (s->btns[INPUT_BUTTON_MIDDLE]) {
>          buttons |=3D VMMOUSE_MIDDLE_BUTTON;
> -
> -    if (s->absolute) {
> -        x =3D qemu_input_scale_axis(x,
> -                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_M=
AX,
> -                                  VMMOUSE_MIN_X, VMMOUSE_MAX_X);
> -        y =3D qemu_input_scale_axis(y,
> -                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_M=
AX,
> -                                  VMMOUSE_MIN_Y, VMMOUSE_MAX_Y);
> -    } else{
> -        /* add for guest vmmouse driver to judge this is a relative pack=
et. */
> +    }
> +    if (!s->absolute) {
>          buttons |=3D VMMOUSE_RELATIVE_PACKET;
>      }
>
> +    trace_vmmouse_queue_event(s->axis[INPUT_AXIS_X], s->axis[INPUT_AXIS_=
Y],
> +                              s->dz, buttons);
> +
>      s->queue[s->nb_queue++] =3D buttons;
> -    s->queue[s->nb_queue++] =3D x;
> -    s->queue[s->nb_queue++] =3D y;
> -    s->queue[s->nb_queue++] =3D dz;
> +    s->queue[s->nb_queue++] =3D s->axis[INPUT_AXIS_X];
> +    s->queue[s->nb_queue++] =3D s->axis[INPUT_AXIS_Y];
> +    s->queue[s->nb_queue++] =3D s->dz;
> +    s->dz =3D 0;
> +
> +    if (!s->absolute) {
> +        s->axis[INPUT_AXIS_X] =3D 0;
> +        s->axis[INPUT_AXIS_Y] =3D 0;
> +    }
>
>      /* need to still generate PS2 events to notify driver to
>         read from queue */
> @@ -140,14 +182,25 @@ static void vmmouse_mouse_event(void *opaque, int x=
, int y, int dz, int buttons_
>
>  static void vmmouse_remove_handler(VMMouseState *s)
>  {
> -    if (s->entry) {
> -        qemu_remove_mouse_event_handler(s->entry);
> -        s->entry =3D NULL;
> -    }
> +    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
>  }
>
>  static void vmmouse_update_handler(VMMouseState *s, int absolute)
>  {
> +    static const QemuInputHandler vmmouse_abs_handler =3D {
> +        .name  =3D "vmmouse",
> +        .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
> +        .event =3D vmmouse_input_event,
> +        .sync  =3D vmmouse_input_sync,
> +    };
> +
> +    static const QemuInputHandler vmmouse_rel_handler =3D {
> +        .name  =3D "vmmouse",
> +        .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
> +        .event =3D vmmouse_input_event,
> +        .sync  =3D vmmouse_input_sync,
> +    };
> +
>      if (s->status !=3D 0) {
>          return;
>      }
> @@ -155,11 +208,11 @@ static void vmmouse_update_handler(VMMouseState *s,=
 int absolute)
>          s->absolute =3D absolute;
>          vmmouse_remove_handler(s);
>      }
> -    if (s->entry =3D=3D NULL) {
> -        s->entry =3D qemu_add_mouse_event_handler(vmmouse_mouse_event,
> -                                                s, s->absolute,
> -                                                "vmmouse");
> -        qemu_activate_mouse_event_handler(s->entry);
> +    if (s->hs =3D=3D NULL) {
> +        const QemuInputHandler *h =3D s->absolute ?
> +            &vmmouse_abs_handler : &vmmouse_rel_handler;
> +        s->hs =3D qemu_input_handler_register(DEVICE(s), h);
> +        qemu_input_handler_activate(s->hs);
>      }
>  }
>
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 5fa5e93b68d..1920212332a 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -133,7 +133,7 @@ port92_write(uint8_t val) "port92: write 0x%02x"
>
>  # vmmouse.c
>  vmmouse_get_status(void) ""
> -vmmouse_mouse_event(int x, int y, int dz, int buttons_state) "event: x=
=3D%d y=3D%d dz=3D%d state=3D%d"
> +vmmouse_queue_event(int x, int y, int dz, int buttons_state) "event: x=
=3D%d y=3D%d dz=3D%d state=3D%d"
>  vmmouse_init(void) ""
>  vmmouse_read_id(void) ""
>  vmmouse_request_relative(void) ""
>
> --
> 2.54.0
>
>

