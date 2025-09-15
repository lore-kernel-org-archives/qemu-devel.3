Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8788CA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0Bf-00055n-RV; Sun, 14 Sep 2025 23:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0Be-00055H-EF
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:47:30 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0BW-0000zS-6M
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:47:29 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b07e3a77b72so226401066b.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757908037; x=1758512837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLBfSRubhbN9WyMaOuxIZltAuqluOkaeA1nF2WlSRgs=;
 b=WutWXstKmp0wn1whp/l3abK5637aTy++4atAjpWEoueyKsDTxDStn9gBo+IMzxmQTy
 gSOrFvCv1IH47QSRQCJbe3OzvKcq+G9UQp10aghcpjE17fAOQRsrydlC35RDvmqTUw3J
 5VD1LFNPe8AMsfgk8WryUpLjiqAsSK2pAOOyUlJordUlmmVYZrdW/Nx1OCQrnS6RNDXW
 3UY74LBjw44hXdahIGZElLEjrcR0GgJY7sR3G3ZEHhXJZEXTAUH4drfycnhqhqZ8ZGHd
 mIQDldoaLXSO1+5f8L64y9zzXq2P0MgjrZPbzoJLyNmbSL0cixyz7f3DaqFAxEydq5hJ
 TTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757908037; x=1758512837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLBfSRubhbN9WyMaOuxIZltAuqluOkaeA1nF2WlSRgs=;
 b=wAT714WtVB/bpPv5iST0iiwav/mGV/f0w7e1sgdc9bqeXYlbGjB/M2T1UvB5WELJPC
 8gYK42DV1tPhaXX/fC+4pxk95fi2aVav41FwORC1EK+VV1ZJMq3lM9+n2Ov9Xbyolf+5
 QnuNf4F9sBsTF2xUXBsufXC4mLbWFmJ33MAFcE9tKD5bvaAei1LvfJ7NNZ8+1we2MySa
 +WpFHuojTz2yOB2IAG8bZT3y+1lnPkD+K3bRTCbr4E8rZgGDKzTFnXwAFHzdLVKFEXVB
 RgXkDTe9DOegdG4jfl14i8NhwZiAEIdsfj3Dw9zs2i3JRGpzNlQCtvnSXPl4j9JlsVie
 TD2g==
X-Gm-Message-State: AOJu0YwNnpE4Xlaun/wSBi1N8QL2IVeQ6a53aI4CtUDerYBvPEQ0ySDW
 L7V1/3BZDodIa5akXFXlhE8xmRmBT7yp4iJ1AxCjNeBvP2Z17cNDooqoDNJpz96TJUyQ5ggQwUT
 1NPsKL61AJayxmCVIYg7iHcsobhLVKuo=
X-Gm-Gg: ASbGnctjCwWXvWcreQQIUCD+wZ/UpYlPrg+nZhu32e9GvRnECXkg+cKTilMV8qt+dY2
 IL7Cy38NM0b0qjJ935ztuy3A2CnpYvgzi7royp+KS3NepJBUgwOvglkAXrriNFnAlxPmtbgZWd0
 0DdYvCRf+4GMNL41kqrOyASZ6D5m+S134AP1CIvoUnuniuMGbaM1b+lZK2YtuebfLv3A14yEcsW
 4ZYE1SifIEpLzBbjQnzufDe2GF4SQPRUD2wOdKeUCZdkqu8
X-Google-Smtp-Source: AGHT+IHj3v0ZniuKqqBSRXpL6LlMwMSi7G+4ORYZqYS445OqjuZBOhEWMuFU2TJfMGLD2Mxg+n92u8K9EkUzX8r70/Y=
X-Received: by 2002:a17:906:9f8c:b0:b0e:d477:4978 with SMTP id
 a640c23a62f3a-b0ed47773f7mr287904066b.32.1757908036817; Sun, 14 Sep 2025
 20:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250911160647.5710-1-frank.chang@sifive.com>
 <20250911160647.5710-3-frank.chang@sifive.com>
In-Reply-To: <20250911160647.5710-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 13:46:49 +1000
X-Gm-Features: Ac12FXyfTDmXLzDrqQSLIUSySrfc2rXrqG3-E-lp1NFRMpmb1YLMYUkQ8FzoOXk
Message-ID: <CAKmqyKMs2kKrjOWoOnQ_WnQM835hKY8txAMUG0TFRAaA0jWoSQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/char: sifive_uart: Avoid pushing Tx FIFO when size
 is zero
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Fri, Sep 12, 2025 at 2:08=E2=80=AFAM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> There's no need to call fifo8_push_all() when size is zero.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 138c31fcabf..401f869680d 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -122,7 +122,9 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState=
 *s, const uint8_t *buf,
>          qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
>      }
>
> -    fifo8_push_all(&s->tx_fifo, buf, size);
> +    if (size > 0) {
> +        fifo8_push_all(&s->tx_fifo, buf, size);
> +    }
>
>      if (fifo8_is_full(&s->tx_fifo)) {
>          s->txfifo |=3D SIFIVE_UART_TXFIFO_FULL;
> --
> 2.49.0
>
>

