Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107CBD1CA0C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 23:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8692-0005kM-Oi; Mon, 04 Nov 2024 18:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8690-0005jm-LI; Mon, 04 Nov 2024 18:05:58 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t868z-0008Sa-9g; Mon, 04 Nov 2024 18:05:58 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b1488fde46so386564285a.2; 
 Mon, 04 Nov 2024 15:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730761555; x=1731366355; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7MANB0FoRxyVUOM9dZ2lrwnBCg67tKUbgcXwtlfdw4=;
 b=I+knGR+av4584AioYP5aCtgF5DgqO2va1D9ibs2hd5856drd+CHV3cWpCeQkQLkQBz
 lf1TtzD2OtptwVOPWbGqM+Covo+FKqpwKsu1D7eX1D9Z9Qui5WZtzxV2vB950uIZSZDt
 L7D9jiI0IXuj1smEBdBm3RWQmQDV3/naCnBqSY4HXipzhkomVGanzFSEZltxTC7KGBFV
 IMK6NdvyQtYBzRw2TPafbSd6QbeXpbGBSn7v1lQdgntiIkM8cH/ysVJ3IFzSf9n8vxnb
 ekAkDCH+yqv1x1CU5bUas3r4Dtr6FJYm5uYQaa0kkOI3CiUuqFbVZbYRdYaDgT2k6kXy
 Si8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761555; x=1731366355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7MANB0FoRxyVUOM9dZ2lrwnBCg67tKUbgcXwtlfdw4=;
 b=W53vUtGi0NKDARNx+cbBdNJJSVIVnDI/5nP2Q0QeywPKFKA1qqfABPEU860BOuEISx
 bekb0nhemCOtXWajI0yzCE/uSs8yAPT7K1pXQzDWPzprLBoxQOLzjlpnW8MUADRdglo+
 S8q81ZNU6a4H/PVnRl6enhnLwHhAe41dyJDx1x6tc8sQwkyGDBetF2kyifBG+iTPAvkF
 kHTzQmGnejEKogp71r1OsPazKB+nkBLGwcnEkKCTk/gozrB+I9B/bditxiwiRbhz7GOR
 0jkkBCa0R1T+heKCsuolAAg9Xu/oeaxNhs61tmEhjAi4OE4I0imNe+3lf2N3BOlFMg7t
 tvxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZL7VhZADByQ5UnuCpPQsVKcMI2oDf7L4fIJK3oEYbuJDJlv7qjg9WZklFN4cP/Ma7zLNBh4m/gibv@nongnu.org,
 AJvYcCW1EJ6WBf9/0wTN8wAd8y+5v8UXsz6KJArUctYkUnG/+VFJSP49YshlM1xjSydags4UPU7C/XT2jEdg/A5g@nongnu.org,
 AJvYcCWO+qwH27OaaFg07+j+uAGo+b/vGCZGPdWMM08d+iq0Cl8LWjEBC3H/84Aem/A4B3VSfxoRRSURezkoHA==@nongnu.org
X-Gm-Message-State: AOJu0Yw5woqof++lz518fhNUOr+jA8eXXUQ+mT03jmwexWOG/11BvLo9
 QX4MBkaNWyovtW3TKoTmGfDdiYY/uWNzc/xFMeLBciLrCs0HOoHv1Oc3R79+gV6KHd3puCMw6xE
 wAi4eTwuwtOLAgI9IJC0WCPEPET8=
X-Google-Smtp-Source: AGHT+IFIfaTheuuvcvF0vo7sFE5da7dv6arCXGGGI6OdGggk5wPsifYEg3Mw3AkBrT7nQHikIYIWHp4Fe9V9/haj1Mg=
X-Received: by 2002:a05:620a:2904:b0:7a9:a991:f6d7 with SMTP id
 af79cd13be357-7b193f4dcb4mr4731034485a.48.1730761555561; Mon, 04 Nov 2024
 15:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20241104163504.305955-1-thuth@redhat.com>
In-Reply-To: <20241104163504.305955-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 09:05:29 +1000
Message-ID: <CAKmqyKPYmv1VfMQKMa+fTzaSmwpbwGAUSvhdZTAPYfmPpc+zUQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x733.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

