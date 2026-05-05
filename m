Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478F0CD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 04:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK7LY-0000F9-7H; Tue, 05 May 2026 00:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wK7LW-0000Eh-VU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:25:23 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wK7LV-0001Rb-7R
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:25:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67c566cb519so4065767a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 21:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777955119; cv=none;
 d=google.com; s=arc-20240605;
 b=LEzG6fCnZbmWckCAmlNwzQ+HwTNFUf5QQPtRvg05VLwI0s73U0CfBu4TrNkGYmzfg7
 gQA2lA1AGn8/4aw/3KZas75UgaAE40olO39DgGfgGByj8kp9FLM3pfyJqpm0dhkx8FHV
 eUziormW6YHMsa9B19goSPuhNzup9MyXeV4jx2qJLKOsxJbWA31PW8THJKZ+rk+QSaTN
 eNYJFuT8dJ1N11jLCQEBbWZ/mQlrGapvlbDJHSCJtZxp/UXlsmLPUVq/nElnNbZ/36Z2
 9bWp92fMP744g/vyoxXGT/qkOoK3SdBqwby+jLzxg+2isddcQfGiAKdZQH0QQkrBBHMD
 1dJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ikY+QNpklsT3dxqAJRF91HO+q5eIUsOaIpZIivxGMzA=;
 fh=RhPjeycVO8kE0D1suYErhF2L6JG1h5r7WMju5gE5DUg=;
 b=QIney/5cemRoBHIagwhhhSmrxiX01+70C9cKPKqC46yUSgNMkyyjy24423WGhj7XVO
 ahqWbdeqBA0eZVK6Zb80upSg61aSvDVMCzFVYIN0xsQR8MktBvJ1ERWFr+Sk6kOPiilA
 sDkZrDSPl3uq5SVJ739GXOMo/jfM9Zy0ANUYiiidc3yM0nmfUo+l3iyyfWhxfGy3akj/
 z7dxkePpBNfnXJaPQLiT+yG2LwK9luAXZkDPPAwrMSxVTC7LS6+3AzRBTKklZ1Q98Hh6
 9BlwJFNc8m00LQ0dVTJcI3hxDJnKW75OE8y/ZcQ+IwAGsS/z2MtzOjTV5E3/h2RBNtlq
 7Giw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777955119; x=1778559919; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikY+QNpklsT3dxqAJRF91HO+q5eIUsOaIpZIivxGMzA=;
 b=nA1c8bAVMa41fwbHqd5Oa1z1Awpma/75ns214obKcPF0Ww0ECVQ1vfoCA2aYQDaJWL
 5PbqJEDqdeVNI5c+i4Bhu2wikQ7JxvJ4r5Bz0GhBaQH5mc/mbwkypIHg1yzeRzg2lVk5
 H6mwuPSf4IA4o38VqH/J1ZFBLmzKxlJFprKZd+3yLBSXEGUNdh4j/Y5GPmFhAgkw+eC1
 J0prK6GXNn0ia6qIY7YZzu3RR42GebQfjG+rBu7rZie4KObcRQZ6V9rZenxCJLSW11G/
 yRSiA0M5a8XitGzLdFytdB0ctMOC2kw3NgKcDSAIwEbS6OWhcJGOZi5+FUjgDdzayTZq
 YNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777955119; x=1778559919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ikY+QNpklsT3dxqAJRF91HO+q5eIUsOaIpZIivxGMzA=;
 b=Gob+cUKW/UHKCuqXiI2pV1nf/s9im81T/wdVf0k7L1p/Qk0eT82bnqRLXT2iAtBIf7
 gv4Ar4HpHPAFy6Jln0yZ5/MW7lb1H9Zxg9ssSyxHnF888fQmO9pkZKRJzVQ+99bWUoq/
 TDNJeFB1i/8YrRyKnbhZSDgcExNi6svJwipBO/7cFUCedGUNwxvogd3/99Vsik9JSeSa
 igEXedNcQL5EqBwIfeQMfUyk26+QGleZzpIQa+Xo7kuyCsMxm9jbxmwqCsUaBcQMgLDf
 hGmLsrtMd24iJkOIatrjvifyqIxJs+yWbyE+8OJANj9TiCpoY5ySLR4E7gLrUvqXnbdT
 IVng==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OL/f0HJ3kxDyeJuVSncOEllrNLpeHG7cE2IBkuWAv09ufD/XqvERDbT+N7GAKunLIwqAsKGFm2REY@nongnu.org
X-Gm-Message-State: AOJu0Yxi/cDSyY5WbvXTT9dWNmBL/fakmGGGmuc0plVCkWrlXXeLIl2/
 3zRjTG7GXhl3kpHCDuhPzlTVUTzuItnPQPxUMaYnTrBlzdDj0f75PR24NjRiJ1jMAl6XzN5UZf8
 NHf80QN+2SJuHBkiavbrm6do4fGqGur4=
X-Gm-Gg: AeBDiesXkR7Lye4bJ5vXayBiCQeXhUuLVxSBKZ5jbI/oio5bFh5TZSj+aFwyzquTRUc
 GyEcxs2g/DlKWYWOSWnTIswMdMU69Sj21N9HcOw+ZqNXyoaP0RIRGRopgcJs0XO3Lj8ENLPSao0
 oBVHsWc2XeXCd3+eOVCdaTAHJjULbK6OFcK3n0P2ZpJmuvx7Ap6cGpyvGdPLprqPcYo9HTatkPA
 sNiV+tKjAnpO0vqZHlRQ1C3GbsjgZGExQApG8YsjfjUSzvCefaOgS+gKGhPS/BK+MCL6BLNNuI4
 x5/rC2r8Xso1xeaH77JRH6nGTPGa9Y9r8IS3xr9lx+L4FJrYKAoHtCGRkdI=
X-Received: by 2002:a17:907:9604:b0:ba3:8a04:7688 with SMTP id
 a640c23a62f3a-bc411d262c1mr60571766b.36.1777955118484; Mon, 04 May 2026
 21:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-2@git.sr.ht>
In-Reply-To: <177756498815.8917.12449488721849651971-2@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2026 14:24:51 +1000
X-Gm-Features: AVHnY4IPRVdBkFZ4_IdynWRfGzwWcB91GUxRU_ZW4p1shG4h4CxIt-FuU1689gE
Message-ID: <CAKmqyKP_BjngLxMUmgEk9t2bmyz9LXe8UYbzmvTs3Ope039kwQ@mail.gmail.com>
Subject: Re: [PATCH qemu v4 2/9] ot_uart: move to new reset API
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Fri, May 1, 2026 at 2:06=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> switch from legacy_reset to new ResettableClass for OpenTitan UART device
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/ot_uart.c         | 16 +++++++++++++---
>  include/hw/char/ot_uart.h |  8 +++++++-
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index b3eb619641..9478af40f9 100644
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
> @@ -544,12 +549,16 @@ static void ot_uart_realize(DeviceState *dev, Error=
 **errp)
>  static void ot_uart_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    OtUARTClass *uc =3D OT_UART_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>
> -    device_class_set_legacy_reset(dc, ot_uart_reset);
>      dc->realize =3D ot_uart_realize;
>      dc->vmsd =3D &vmstate_ot_uart;
>      device_class_set_props(dc, ot_uart_properties);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +
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

