Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76AEC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 05:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOV2p-0007f4-V1; Mon, 09 Jun 2025 01:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOV2Y-0007dm-It; Mon, 09 Jun 2025 01:27:22 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOV2X-0007tv-1Q; Mon, 09 Jun 2025 01:27:22 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so2926147fac.0; 
 Sun, 08 Jun 2025 22:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749446839; x=1750051639; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/6qbjkWbO/i365IDyoZgWyUSWgaRgybc8iWD05/6sI=;
 b=OFPxtBmXpz5tdvUt5pN6vVLdlb7IL/n+uAeKCtydprHmH2Oraq+tC6Eof7NE2RN2Y1
 yOdCAGxzGmXyT5C/kQpBph2HCwT+ViEPszVQYuLvD+h3MQ9ZppSz1AFvasXJmDtLqhie
 TOHoisL4fEQsLQI+tS+eabK929wHiHoMk5peDCWKpRfTJ7dql6dJ2ShlXFopLJuFwykD
 a8YpKQ0FvU8dtsgmZPWx2F2hrZ2ut/XPQjq0kDUPAAJuUqLvyazbGEdZyFt0OsGQnj6i
 ImgmRS2vO88tOIrehfjBwhyXHxnbaLH7Awicv/bc4mYXyZ39ZWPpQfUST8dpfWWTHoVB
 uKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749446839; x=1750051639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/6qbjkWbO/i365IDyoZgWyUSWgaRgybc8iWD05/6sI=;
 b=aBBNfV00vqYRFJOGi6DgtstpTcSkHr5PbGVvDG0sZ03zjLVx7Woui0zc6yrAfnaKDr
 zQeCahFiuNn48A38BGIoTH8y+V82808DKs4mEzU1uWGNUfoOz1ksBHCdwPpuZl//DhSw
 clrKR24QBd6MdLX2ENxcPVdNLjUnBeey3zTB0vtqp+Zmo1cj+gUVoU0F/sBYNBShWCU6
 w+2gueLsz0GZN0Szbqw7J+2NkhdfBBUlJcZFx4tST0VjLuLu+4HpIEBOEkBIxCRoymoq
 MV5wWzwYPpIYibtSeOqjr1139CHOEfMYYsEAmUyvjGnTw8oD6c9IIDJl8QThI5DfzQdM
 cSOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVli68wkkSY08wl+lALxzfWIrehb12amJT95H84VX0/M/qcs6wh4vEItIOn28yX550eBj+1YEa3j7vg@nongnu.org
X-Gm-Message-State: AOJu0YzTDmh9S0zZ0NFgIiGKusQN3jODkm4p0lvt4xjOkEQiYPdwu+db
 PwU58W1unra+ByzF9HY7oytXuV1tJESiCgs6gMm8/dNCxiLngCAU88KtacwkCEF/hEdAKHxyJJy
 al/KRFuNjtj+E/+RkL/p6UnIFj0iteGlE0Q==
X-Gm-Gg: ASbGncsA9ik664agY23/kW9QAFvIW1MvwEPC5BtqK2CKbHSN2VWXo90fcXzhw7MfoW7
 AzU4h2EQkMxco7ZAoIV1aQ27nXCZYpyuUsc8mM/g/QStdf0bMz8bWyY80JLDpwMp6DXYn6NvytN
 atgYTCfqYPHw9ZpodrnUqY9oQHGzYSDRGnwy3w0aB3Oj+9+77oiyctJ5RQKDF2xqs=
X-Google-Smtp-Source: AGHT+IFyCqgvXUvSttpToZxZ85CfK+vzT3vCNtb/L3438aaa1H448tRIUopHOBc59e+OBoA9LKgjTekQc7BOiw0+Qws=
X-Received: by 2002:a05:6102:54aa:b0:4e5:5c14:5937 with SMTP id
 ada2fe7eead31-4e772b8c453mr9924628137.1.1749446827872; Sun, 08 Jun 2025
 22:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101255.797162-1-florian.lugou@provenrun.com>
In-Reply-To: <20250605101255.797162-1-florian.lugou@provenrun.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 15:26:42 +1000
X-Gm-Features: AX0GCFt3Lz4G6Aepn_XqURsUGewQQQd2C75paDZtMoZVsTE6MbE-lRqDZ2Z4DwM
Message-ID: <CAKmqyKM4YsNantoUA7vEmt-+VpmtiF-US+LFC0sSbY_K49KRqg@mail.gmail.com>
Subject: Re: [PATCH] hw/char: sifive_uart: Avoid infinite delay of async xmit
 function
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x34.google.com
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

On Thu, Jun 5, 2025 at 8:14=E2=80=AFPM Florian Lugou
<florian.lugou@provenrun.com> wrote:
>
> The current handler for TXFIFO writes schedules an async callback to
> pop characters from the queue. When software writes to TXFIFO faster
> than the async callback delay (100ns), the timer may be pushed back
> while the previous character has not be dequeued yet. This happens in
> particular when using -icount with small shift values. This is
> especially worrysome when software repetitively issues amoor.w
> instructions (as suggested by SiFive specification) and the FIFO is
> full, leading to the callback being infinitly pushed back.
>
> This commit fixes the issue by never pushing back the timer, only
> updating it if it is not already active.
>
> Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/char/sifive_uart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 0fc89e76d1..9bc697a67b 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -128,8 +128,10 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTStat=
e *s, const uint8_t *buf,
>          s->txfifo |=3D SIFIVE_UART_TXFIFO_FULL;
>      }
>
> -    timer_mod(s->fifo_trigger_handle, current_time +
> -                  TX_INTERRUPT_TRIGGER_DELAY_NS);
> +    if (!timer_pending(s->fifo_trigger_handle)) {
> +        timer_mod(s->fifo_trigger_handle, current_time +
> +                      TX_INTERRUPT_TRIGGER_DELAY_NS);
> +    }
>  }
>
>  static uint64_t
> --
> 2.43.0
>
>

