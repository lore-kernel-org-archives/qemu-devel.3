Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C67DC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp74F-00078J-Q4; Mon, 03 Mar 2025 09:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tp74E-00075i-I3
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:46:50 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tp74C-0005X1-Mk
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:46:50 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e4ebc78da5so5827797a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1741013206; x=1741618006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEsCkJCO92Uhpe8NcsbaVWng72KRhe2mDUc3KEa8z50=;
 b=k6AmgH3uVgpUU9BFZbW6ER3LPdlp2JwsutbxUQXxBSlZZ88j7z1bUHa5T5ZHZFBuYK
 YlEoIB7rjBbbr7pKj7Bw20OO3utA2t10foAiFMkKUS/tuWZjROIirUGLPo1XBWsj+L/O
 3yjf0rPboaztn+sFzJgBIv1j74fwke6wGoA3+RqlKkQ7kft3EA2zkuXzGr05y09je8Lc
 7UHtwAsKWupLezrHRxQOkycG9lOAq3YTE9IFQgpNV8rdPElhHNAKmAO0JxJJ0QRf2ccb
 hfgcB29kgka50wZll9ADxRR2AdkdaXrk0pBbGpDSHiN3vy5fvLtP3WPMEdjUyvQfgPpm
 LztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741013206; x=1741618006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEsCkJCO92Uhpe8NcsbaVWng72KRhe2mDUc3KEa8z50=;
 b=Nvm9Bi6bbiVbF/IanTWTyxfEowGcFhRLQdy3I8U5V5wcHCj8g6JyCafBUV2N2xJ5vu
 ktv++F/QsevkzW/8/yZIBTithmChsc56DddLveLEmD8VUL3Vxf43AwUXfN8Jq5pjMBVZ
 c8pxuVKZNjdFROqq2YMeuCIjj8UDvevjX6He1HGRT3ksXWmM6TZBCPKrawE+0mHwDL6f
 0jGAzsSjfuKxXzvoLpYBGzednt/a87Iou8MaGm6DD/nHtVvT2iD9Hm0SPGDZ0iXGVgBm
 I6KDw9m5PgLhV8FK/CB8GVrsswtpzYTC+kh5stfgzLw7X87tRT0k72q2Ocr5mmnzVkYk
 RQeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpkMSSEdOU9Y/sHIU9qB3JAzyO2mMQUtT28+bXHK4l7vOS4wgt+DNxoEAOPxd1s9zGWn3CPXyjcHxT@nongnu.org
X-Gm-Message-State: AOJu0YxvJ5zaWGZLSAtOqEYLYjZLAg1qcWViN7Eb3YAhG6vKU/G45SlT
 x6wxXVcA6OBosbwN7LnXmQ5A9QSUspV85r9Hs+54GalZuZifK3CG5Lxa98Jw/nOYFRAC7SkwvmV
 G0Qm5UXQkyeRGkfJIkv4L2qdmV82Y1082QW6g
X-Gm-Gg: ASbGncsqLjeOuPoLyBm3nfl3F60nOK+mJBRr6qfAjqabRcB/LioeJWhDSPiPh8MGcr1
 rZ7l5/AkAlIzEEPimEUr+u4IqVNFLP+B3QhO/5cBYJlTMXVb8NEES124cFymqyCmrIG++/3mX2C
 AbLUp/DqJck5FRgHYt5gCtAsFB+w==
X-Google-Smtp-Source: AGHT+IEKzY93VBMaIlShrPqZyYCVREnRUeGcApiTend2ouCXi8Tbs0cgTkm2f6h6sad7V5u6vF1ZND83BiFXIgAC+lU=
X-Received: by 2002:a17:907:6d20:b0:ac1:e1a7:9445 with SMTP id
 a640c23a62f3a-ac1e1a7ac33mr194302366b.12.1741013206405; Mon, 03 Mar 2025
 06:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20250303023120.157221-1-alistair.francis@wdc.com>
In-Reply-To: <20250303023120.157221-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 3 Mar 2025 15:46:35 +0100
X-Gm-Features: AQ5f1JrAZNLgmYcv5py3eEsgMfLIOn8qB7gvMk8YPpSEBSR2yYQpaygHdj6nu3s
Message-ID: <CAJ307EiCgR83H2C0U69_x8nikjERtoHiODK8T9udtAKvST793Q@mail.gmail.com>
Subject: Re: [PATCH] hw/char: sifive_uart: Free fifo on unrealize
To: Alistair Francis <alistair23@gmail.com>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, philmd@linaro.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x536.google.com
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

On Mon, Mar 3, 2025 at 3:31=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> We previously allocate the fifo on reset and never free it, which means
> we are leaking memory.
>
> Instead let's allocate on realize and free on unrealize.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/char/sifive_uart.c | 44 +++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 4bc5767284..b45e6c098c 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -251,6 +251,23 @@ static int sifive_uart_be_change(void *opaque)
>      return 0;
>  }
>
> +static void sifive_uart_reset_enter(Object *obj, ResetType type)
> +{
> +    SiFiveUARTState *s =3D SIFIVE_UART(obj);
> +
> +    s->txfifo =3D 0;
> +    s->ie =3D 0;
> +    s->ip =3D 0;
> +    s->txctrl =3D 0;
> +    s->rxctrl =3D 0;
> +    s->div =3D 0;
> +
> +    s->rx_fifo_len =3D 0;
> +
> +    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
> +    fifo8_reset(&s->tx_fifo);
> +}
> +
>  static const Property sifive_uart_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SiFiveUARTState, chr),
>  };
> @@ -270,30 +287,24 @@ static void sifive_uart_realize(DeviceState *dev, E=
rror **errp)
>  {
>      SiFiveUARTState *s =3D SIFIVE_UART(dev);
>
> +    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
> +
>      s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                            fifo_trigger_update, s);
>
> -    qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx=
,
> -                             sifive_uart_event, sifive_uart_be_change, s=
,
> -                             NULL, true);
> +    if (qemu_chr_fe_backend_connected(&s->chr)) {
> +        qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uar=
t_rx,
> +                                 sifive_uart_event, sifive_uart_be_chang=
e, s,
> +                                 NULL, true);
> +    }
>
>  }
>
> -static void sifive_uart_reset_enter(Object *obj, ResetType type)
> +static void sifive_uart_unrealize(DeviceState *dev)
>  {
> -    SiFiveUARTState *s =3D SIFIVE_UART(obj);
> -
> -    s->txfifo =3D 0;
> -    s->ie =3D 0;
> -    s->ip =3D 0;
> -    s->txctrl =3D 0;
> -    s->rxctrl =3D 0;
> -    s->div =3D 0;
> -
> -    s->rx_fifo_len =3D 0;
> +    SiFiveUARTState *s =3D SIFIVE_UART(dev);
>
> -    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
> -    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
> +    fifo8_destroy(&s->tx_fifo);
>  }
>
>  static void sifive_uart_reset_hold(Object *obj, ResetType type)
> @@ -329,6 +340,7 @@ static void sifive_uart_class_init(ObjectClass *oc, v=
oid *data)
>      ResettableClass *rc =3D RESETTABLE_CLASS(oc);
>
>      dc->realize =3D sifive_uart_realize;
> +    dc->unrealize =3D sifive_uart_unrealize;
>      dc->vmsd =3D &vmstate_sifive_uart;
>      rc->phases.enter =3D sifive_uart_reset_enter;
>      rc->phases.hold  =3D sifive_uart_reset_hold;
> --
> 2.48.1
>

Thanks for the patch.

Tested-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

