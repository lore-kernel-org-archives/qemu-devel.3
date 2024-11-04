Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4D6D1CA07
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 23:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8636-0002wK-Ti; Mon, 04 Nov 2024 17:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8635-0002vl-Hz; Mon, 04 Nov 2024 17:59:51 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8634-0007av-6m; Mon, 04 Nov 2024 17:59:51 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-84fc9005dccso1442212241.3; 
 Mon, 04 Nov 2024 14:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730761188; x=1731365988; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zvd9wShwo7OQ5/3OA47T4DwiJoGFqiTKeuO/fhc4yoE=;
 b=KZWDjck4Xuro+6NJf2QyYqz8MhzMKbxxrcvMxvbst33So0Y1r7WwRgF3Ca7ams7UXQ
 SFyCSXk70fLbwLy9YjDCIAJcOqf+YqAu3DGpoo/JI7jHbsrM1iuT6n+nGzy09MpQF1mi
 vqlbtAJ8Nesujxv7xJwYmCxCvWAhwMqL/PUMXBvH6i4vP0kRmxGIEie5Rutngj3HJywb
 n/0fBKx82/i/9J/wg2uCiDpejbIVvjby+OHUQj+Xb5VXsBEJp2zMN4+IEU/R9lZRbJxw
 9S+sCDc4rXTpmwquruHZPKkbFt0Oo0QuC23WkfhEDa3UHuEFi+22z804ROI+gR2eacFM
 Sg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761188; x=1731365988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zvd9wShwo7OQ5/3OA47T4DwiJoGFqiTKeuO/fhc4yoE=;
 b=J39zrZaiI1r3PThR7Es8k/L+W2lccTEnugqlqz9Bhg53TinxI4TBm24fHVkwnGYObF
 MMG27fR0Nv2ebpWeyrTr4XECKSKwo0yNjqLq/GhhqqLZTMgmDZfRHyzWp5jQtoJ2Yf90
 zvU0OiX8Y20HaJ5lH75Bu8CxEALtvhQJsThoFE0EJSS5Vqn3NWLuDbmmN0ak5dzpZePj
 uiZ70ul8TRYCBiT5Lh4KL1gJF+8taEqX9Q7OBNuS6GHJi6Ofkm2OUScWzBhgYTEsOXlY
 bk2KbzMub7rBgOKQ5ZDLVmk5F05yPaFBXeiY5JNLfWvtKZJsJCtvAWMWlC9aMqlNUiQg
 qQhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU61TDXwenjgMY2M5EG2wB7AJ/jlShSeV9aiwZhVGNghl06IVNijFr0ZnWcmCyuOt7GLifstWjCwX1o@nongnu.org,
 AJvYcCWnNSAtdtZbVNfDdl85iALkZUpWeRA37Th+XMcMhVe2+WijnT2L88dzrLoZ5JgRhZQXn4wpPVTlquaH2GS+@nongnu.org,
 AJvYcCXdyAOdGcF3RYipsLNuzxPeuG+/UcU5ZL4fILpZ22Smr5Dn5vCUl5rhmoDJjT+9ZzPp6EyulEtWrB7KLw==@nongnu.org
X-Gm-Message-State: AOJu0YzOjIJah9T7/NnhSE4XgmbLAD/hqbBh7J18EKPBUxY8dT1OO12V
 KVQ+nCDiV9MtucTIcWDszVloKboD78urSWnbSg/2q4BLc6uwqfva7Vq9F0i4735jW74EjcwQam5
 XuyfQE3JvHVPGDbzQVP5YbTUq0yg=
X-Google-Smtp-Source: AGHT+IFQ8X6U6m5Y/1OuUVZ+kDiGisJbrxbBtyKG3y/ZDBPGQdBP9gUWyFRRvCZ3AUQ8JhR2nBzQU8MZ/KXxZhLHPEg=
X-Received: by 2002:a05:6102:3595:b0:4a4:841f:bb98 with SMTP id
 ada2fe7eead31-4a9543a418bmr15786318137.24.1730761188628; Mon, 04 Nov 2024
 14:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20241104163504.305955-1-thuth@redhat.com>
In-Reply-To: <20241104163504.305955-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 08:59:22 +1000
Message-ID: <CAKmqyKMR0yJph-iF0WKzqFu6rGZy9CPjhBOKCdkG7JnF2ONWHQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/sifive_uart: Fix broken UART on big endian hosts
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Tue, Nov 5, 2024 at 2:35=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> Casting a "uint32_t *" to a "uint8_t *" to get to the lowest 8-bit
> part of the value does not work on big endian hosts. We've got to
> take the proper detour through an 8-bit variable.
>
> Fixes: 53c1557b23 ("hw/char: sifive_uart: Print uart characters async")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Urgh!

Thanks for the fix

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index aeb45d3601..5ae2a29ed6 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -174,10 +174,11 @@ sifive_uart_write(void *opaque, hwaddr addr,
>  {
>      SiFiveUARTState *s =3D opaque;
>      uint32_t value =3D val64;
> +    uint8_t ch =3D value;
>
>      switch (addr) {
>      case SIFIVE_UART_TXFIFO:
> -        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> +        sifive_uart_write_tx_fifo(s, &ch, 1);
>          return;
>      case SIFIVE_UART_IE:
>          s->ie =3D val64;
> --
> 2.47.0
>
>

