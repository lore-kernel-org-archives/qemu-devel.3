Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB0106FD60
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0rKd-0000Hg-Fv; Thu, 12 Mar 2026 21:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rKa-0000E1-Us
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:28:49 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rKZ-0000aN-EW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:28:48 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-662b5bf4b10so2748466a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 18:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773365325; cv=none;
 d=google.com; s=arc-20240605;
 b=XOPHlDhJkvrpDZ9LILvz7pN3Q8i85t+hfumNrW5BbupTIjvcIdzs39SLSWAeebHjrO
 gW5N8jT+TB74Ai9aQh8OSZgkAjSoGcEeZ6uG8Jw0wHngowsoGoezruJ1AXrTcNkh67hr
 0qw/FnkaZLNB5J9x6w/GVTXNHLqRGOVag8zlRiDl6Xo7UrzF8msS5S7/QtRCVucVFFBe
 2ywElF6hl6DDER14nEXetYdJWZ29lY6j9Ftz610Uh9gZyhkOt2RHtzczjsahF1WQ0jOI
 2p3n13hbK6Aj2/f7qGvrtkxLm/EyH/P94qehwsmsfYEsDI7S0izXtRKYLwNNYXQDtLGV
 n/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=giQLkQ5ofNuA4Zj9Vgqxj4zW0+0DeO0WUfbGyA+ddSs=;
 fh=Yugyz5SJJub7nbOEKVoR++9O2Yndc4n+VrwAcNFbVYM=;
 b=MRZmH2CGOsQekPmBpPtiD+RnUJgFGkBLbF7k+y4ZXvNQhMJbKb4K/OtKrgsLtWjoyt
 l817N5QSY8wn4X+vWzqqquBWsI3Xb4pL9vAv24+ILzdZZZp/LUGdrvZk74ZfGeJGDUW8
 cBTiq5BRx8xyiMkS1p4BVSwbjzh2kKC+JgBB2Jzc3So6W7HBj67NLMqaETiyLXRN/Fwm
 4rXZ9aWw/0hnM7Tk/YAg7ehGh3yIlb4HgGrs0D04ZRa+MknwY2xizwzgiy+4sqgKf2kh
 SXt93syBIGqzUDt5hkAHGSBSRebkB8ciBVtYcU4/G2C/6tL/y6veEfcyKErLvRNdGzCV
 9S2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773365325; x=1773970125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giQLkQ5ofNuA4Zj9Vgqxj4zW0+0DeO0WUfbGyA+ddSs=;
 b=PimRm4H1GQv35yjenWbxMOF3AbTbOfvWzlARwGUwJyK2gsvTMlVUOJOFU/CRuf2H3d
 UFEe1tk0nGmohhqGvOimqHP4XeezQBcRAEXbCwczI3JGe/3YArwsbO5xetxU3Lo/HxjY
 4jnOFljPkkAlRUPZTIbG4HYTFQy3UkAgnUvuFoot2+4LoUq68GUYOk0rJGeYIqj+KAAy
 p9o7Myr/x+21LbBNQTk//GIby3dqcnSvV1tcov1WiH5EAk5qmTZR7jyZDq+TEECbqsks
 G8KmtiRG6qzo6EKRwA9yQNaXvXOYa4V6q5IS++Scgu+sxVOKD/LruIKU1u4Z65YMhzuC
 JcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773365325; x=1773970125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=giQLkQ5ofNuA4Zj9Vgqxj4zW0+0DeO0WUfbGyA+ddSs=;
 b=sVH6kJpGi9B8GJdh0l/7UeTM8TLxtArzAxuAYRWu8u8sm60KOIN1CeBxom3e0ANshQ
 nWjlvA08ocuv4SZj4rxPWFRinjzDelmpf9bFiFC9+IifP91i94Rugknr3N2k+SCv4+lK
 34HLnJ7pY4idvxgCrGCsO/OqilFVr/7jfPtTiYWIJ8BiWxdVipyKisrkG6lf8Sq4dv1L
 fEN6S5pHMpR+DdbEXTDeqs8Y/QwCjviUPUOypHR7xdl00xaPFX7o8EOkrFvqOs5daS6S
 2XjR5dJM3K+kwWSpppkTRg2EAKsi+EuO+IQ9lg1GyTJF6dqI9e+YPATGLUR7feXPkdsU
 puYQ==
X-Gm-Message-State: AOJu0YxSv8Uu3PrsTirH3ZkYoykKlkqYgMDQL/dYvcJlGtjpYEf+lNZB
 ra3LcX0yy2TBJhdiQtx2mvgqQv33m+eK2svRLExp5FSlmcs5e/s56xS2oOYyOwnfS/2n44f0iuo
 H+BApF6LBtcLx/Eo/Skc8miQJLerLjhU=
X-Gm-Gg: ATEYQzxsrdLy7aPd6AShaRG9UYqO0YpHYsisUA0ZptE+YfJLjfzhI7TP7KRWScYS+FB
 SmmqXc8G3vB2HGt0W0sypiu5z89RCftLm4jchPtLWO6oNnRwuzr786grex1AItM3mpuskFWIFGH
 ZvfWUQzRRWZm4Ogonap1j6uHOmwT0IAPGVf65xNQokSxdMBrdFkTG4VvboS5P9MoJ4YUtWAMFET
 dD02XwGVCsVTKRM7I7OJNUNIpAzdwil04+5WIrlS9EeuEJK0DoYGH4ffOaqUgvaw3Ltx7Tr4rzK
 s/G7zIJZM3TpBy8mUTakg/FSgGNAemTwxEWlNQ==
X-Received: by 2002:a05:6402:35cf:b0:663:4461:ad8d with SMTP id
 4fb4d7f45d1cf-663ba9bb272mr826374a12.4.1773365325428; Thu, 12 Mar 2026
 18:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-5-frank.chang@sifive.com>
In-Reply-To: <20260312033201.1619554-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 11:28:18 +1000
X-Gm-Features: AaiRm501JilXvibjRBDnJnZgVmwTqNyPp2vM6chFwrmVx0ZIOlVSs7t5nhyEzNI
Message-ID: <CAKmqyKMV9kzOrKzDxginbBm_5d7UbcTcMbaJdkNAz7+He8_5qQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] hw/char: sifive_uart: Remove ip variable
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Thu, Mar 12, 2026 at 1:33=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> The ip variable is no longer used in the code. Remove it from the
> codebase.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c         | 6 ++----
>  include/hw/char/sifive_uart.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index f255cca960d..4c30fbf5685 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -285,7 +285,6 @@ static void sifive_uart_reset_enter(Object *obj, Rese=
tType type)
>
>      s->txfifo =3D 0;
>      s->ie =3D 0;
> -    s->ip =3D 0;
>      s->txctrl =3D 0;
>      s->rxctrl =3D 0;
>      s->div =3D 0;
> @@ -343,14 +342,13 @@ static void sifive_uart_reset_hold(Object *obj, Res=
etType type)
>
>  static const VMStateDescription vmstate_sifive_uart =3D {
>      .name =3D TYPE_SIFIVE_UART,
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
>                              SIFIVE_UART_RX_FIFO_SIZE),
>          VMSTATE_UINT8(rx_fifo_len, SiFiveUARTState),
>          VMSTATE_UINT32(ie, SiFiveUARTState),
> -        VMSTATE_UINT32(ip, SiFiveUARTState),
>          VMSTATE_UINT32(txctrl, SiFiveUARTState),
>          VMSTATE_UINT32(rxctrl, SiFiveUARTState),
>          VMSTATE_UINT32(div, SiFiveUARTState),
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.=
h
> index c78d9bd1fc6..5f3b1327de0 100644
> --- a/include/hw/char/sifive_uart.h
> +++ b/include/hw/char/sifive_uart.h
> @@ -73,7 +73,6 @@ struct SiFiveUARTState {
>
>      uint32_t txfifo;
>      uint32_t ie;
> -    uint32_t ip;
>      uint32_t txctrl;
>      uint32_t rxctrl;
>      uint32_t div;
> --
> 2.43.0
>
>

