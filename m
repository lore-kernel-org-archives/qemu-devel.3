Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268ADF36BA0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 02:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB1ed-000735-EG; Thu, 09 Apr 2026 22:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB1ec-00072p-Ln
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:31:30 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB1ea-0003sO-Oz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:31:30 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9c6680aaf8so276821066b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 19:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775788287; cv=none;
 d=google.com; s=arc-20240605;
 b=PQKS26b0pAmt+w+dSfgGMislxkpFI7Wcq6bY1AcLjbPymEJWxmb7HNlj5YkveNGj6M
 3hX0onB8Ex9O5hYouBMThXqZwCoCwDp03O39bgK9/tkMN4YcxeAb4k8ibN/LiRwwVdOd
 gbzgdofnmoLruorRWm+J1aj19MlY5R7xtcLEp6aOVS2hCUFVEFSGnOWbNN6ZfaqZjqJf
 E1cAhnm37Jk4Wh2OSeatNSdVhTjBovuGp4dQZ4sAaYg/g5YVkpZRa4/R4rar8WjUKrz5
 w+mWpMy7ki79BhAxOi+fok91ur0HKN+58vFZedOLppN4ya6kXGEdqTN6K0Gf1Y1prnER
 vhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3/21UvvO9MdYyve3WyY4fMrFfsuCfOEeHAv3MzJltdE=;
 fh=nHYu2bbFcBp4p/R+Jf0YC0yaNlRc1NVy95yctbCi8iE=;
 b=HqthizPmKNIReOBKCBRosVq6r/vtKnZbLPm6IwO76lljY0Tq7PLyzQcNX7ej33WO1C
 uizTew4z8T0ZDlC7wlAewitNmbI613KjSZoxGpUFpbwMmQqBZo+EqTjdnWuLGgzE0LtC
 06naY157ArmhuWuEI6XW0HSROh3Z7zWKf9iw+5wmU195uZuZ3vFgyYYd26AGYUMPE/PK
 SeGMaAC2YULmPhYoonQqt3i2SMPKOMYadBqnCpAI7cN+TA0V+ny/NDfmdtnJcmztQ6gG
 GK5xTnGJjj3RNaZ1E7cdyNMG7s7D8BZomQm5bcw8OmnF6FurQ5adzcf+4WIDJL6Fp71o
 vgBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775788287; x=1776393087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/21UvvO9MdYyve3WyY4fMrFfsuCfOEeHAv3MzJltdE=;
 b=s2bT+3KjNmB7KJwhv1WtSq2957cx5WeCo3AmXFoWE4Dl7iRxDXeTYqDsk4gj1ADZjT
 VR01q1vJR6Glt/OAtbh8BxrYW1CWe/1+jGmnv3VsZf2SokPHRDZk01/dCx6m30lai7Sz
 7jEGlo/zN1tTxLij9TK07ToRkiziTVecPsUshVEnf2pBucKGlJjLUhrcgsC//ijZz0Db
 1ell8qPfgNR8+nMxozLzkmh56B1vRfYmwEVZH9qg3aFMrBWaEhcL0vqUc4Hie7hhzBm1
 NZ355K6Q+ZkVzMkQU5txHoWsEpmG/5hn5bmRMcybOxmkIsMzzSS9OUvV13CDeAFCVyiv
 XnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775788287; x=1776393087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3/21UvvO9MdYyve3WyY4fMrFfsuCfOEeHAv3MzJltdE=;
 b=fTpw/Dka0FOGXObwo5ie+OcuPN5prLvd8b1Sp2VgFBtdsNEsCXqGaa2KCsR2im97Fm
 krR4zDxz6zFwgVrsPANZa2FEw+X+m7pPO4kgpDff3Cxj0anhON18+vA9S9wMxOJkNhFN
 dLHN11hLVwzF+x4GibnJIbxLq/HWRpWvv5/oz4v+v+enb31bpkfX6EAatdJLIrfprQd+
 jnxGYC/X9Jb8ggx22PHnUM8mNDhRsNq7EVO9kVgcus3lENz7yj0y4nnFZ8V4n+mcClgt
 n1Y2noeP80i+6SkexUChQ94gVazFdnrfDGTCj6RspHaPXrwyBsnidPobMYHF7Hux0XVK
 08wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnx8CruQ9dnjJj4EfNzKLtAA0k5wx5sFu8lN2X1jdVmOlSSPtK2r9+qLecz53MDuJXEKRS8m0Q4yaE@nongnu.org
X-Gm-Message-State: AOJu0Yx4Ly0J+jkbWu5zX/IVbjADaK4YdA+MnaSoD3XBAtvQuI6pj/GF
 FHyw702fr1Z2AD2l4AxyfD03R6IvMg7jXesMp3lralbFBaMHnrb1EgS/a1Q8H7gH6xo2Pnv7/12
 jaFQ/8eBBpZ1X9Ps1/bDbEHlaDaQ4Uqw=
X-Gm-Gg: AeBDieuO7N8OlWeS0O3xKQ61cwIvGfVZHac6gnolY2/nxh1cfOf2mSn7rR9xPpx0gxF
 umfLrf4x2VTpdIzvZGjHAJNpexrAu+FNiIP2fV3N6nQATrBsQEUIDt0uzh0qgSKaujwkF1e/UlG
 iULb2XybZzXIp0GI0ZAkNJ66mya09WTMgLgz1bVJaiqFcFU8od+WPwtMaLjzowLEaLaTGoam+bu
 +uSfHYwjmNGD7pGzQ48XGTTI8USmflV1WYRQQcoYbJgPItOLPtm2CpdFzJPfXFz5Cm3dU6Pg8ai
 0A8VLRcK9wQ0Hh5P8yb4VAzY4JvKMvwejg4tRg==
X-Received: by 2002:a17:907:d06:b0:b97:ce8f:b9db with SMTP id
 a640c23a62f3a-b9d7243ee6cmr82390766b.10.1775788286597; Thu, 09 Apr 2026
 19:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <177564643888.23414.7922925369077631439-0@git.sr.ht>
 <177564643888.23414.7922925369077631439-2@git.sr.ht>
In-Reply-To: <177564643888.23414.7922925369077631439-2@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 12:30:59 +1000
X-Gm-Features: AQROBzAL7CIt6-uaSSckwaX_4F0kTwgHVS0Bp-ddypQ5EpbVvB0OORHySxlki-w
Message-ID: <CAKmqyKNm+sfmP03ppX=KYpFkAxUtWNsd=aC6vYCxSwcCtY2WfQ@mail.gmail.com>
Subject: Re: [PATCH qemu v2 2/7] ot_uart: move to new reset API
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
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Thu, Apr 9, 2026 at 5:42=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> switch from legacy_reset to new ResettableClass for OpenTitan UART device
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c         | 16 +++++++++++++---
>  include/hw/char/ot_uart.h |  8 +++++++-
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index b3eb619641..2cf0d73cf5 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -227,9 +227,14 @@ static void uart_write_tx_fifo(OtUARTState *s, const=
 uint8_t *buf,
>                (s->char_tx_time * 4));
>  }
>
> -static void ot_uart_reset(DeviceState *dev)
> +static void ot_uart_reset_enter(Object *obj, ResetType type)
>  {
> -    OtUARTState *s =3D OT_UART(dev);
> +    OtUARTClass *c =3D OT_UART_GET_CLASS(obj);
> +    OtUARTState *s =3D OT_UART(obj);
> +
> +    if (c->parent_phases.enter) {
> +        c->parent_phases.enter(obj, type);
> +    }
>
>      s->uart_intr_state =3D 0x00000000;
>      s->uart_intr_state =3D 0x00000000;
> @@ -545,11 +550,15 @@ static void ot_uart_class_init(ObjectClass *klass, =
const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    device_class_set_legacy_reset(dc, ot_uart_reset);
>      dc->realize =3D ot_uart_realize;
>      dc->vmsd =3D &vmstate_ot_uart;
>      device_class_set_props(dc, ot_uart_properties);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +    OtUARTClass *uc =3D OT_UART_CLASS(klass);

Please don't mix statements and declarations within blocks [1],
checkpatch should catch this

1: https://qemu-project.gitlab.io/qemu/devel/style.html#declarations

Alistair

> +    resettable_class_set_parent_phases(rc, &ot_uart_reset_enter, NULL, N=
ULL,
> +                                       &uc->parent_phases);
>  }
>
>  static const TypeInfo ot_uart_info =3D {
> @@ -557,6 +566,7 @@ static const TypeInfo ot_uart_info =3D {
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(OtUARTState),
>      .instance_init =3D ot_uart_init,
> +    .class_size    =3D sizeof(OtUARTClass),
>      .class_init    =3D ot_uart_class_init,
>  };
>
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> index 517324b65d..fee2128f90 100644
> --- a/include/hw/char/ot_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -34,7 +34,7 @@
>  #define OT_UART_CLOCK 50000000 /* 50MHz clock */
>
>  #define TYPE_OT_UART "ot-uart"
> -OBJECT_DECLARE_SIMPLE_TYPE(OtUARTState, OT_UART)
> +OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)
>
>  struct OtUARTState {
>      /* <private> */
> @@ -70,4 +70,10 @@ struct OtUARTState {
>      qemu_irq tx_empty;
>      qemu_irq rx_overflow;
>  };
> +
> +struct OtUARTClass {
> +    SysBusDeviceClass parent_class;
> +    ResettablePhases parent_phases;
> +};
> +
>  #endif /* HW_OT_UART_H */
> --
> 2.49.1
>
>

