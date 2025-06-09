Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B3C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 05:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOUhw-0003RL-2g; Mon, 09 Jun 2025 01:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOUhZ-0003Nr-VN; Mon, 09 Jun 2025 01:05:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOUhY-0005Z5-Eh; Mon, 09 Jun 2025 01:05:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6070293103cso6488961a12.0; 
 Sun, 08 Jun 2025 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749445537; x=1750050337; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QweGwBhLfJ0ZJNk8QbWva6oyOljIx9hhKwC9unVjrN8=;
 b=BRzHEVNSaA83skczyDJh23RnCcimNb/iDerIhm9LXFZ7ibIi2qjK3Nh+AVBUg8ezsI
 OW959+LbaKvI1L9kYg8gmfzE5CHHrjtq5X+fNJpgOjR6b2VpTSjZVDFQEgu8C+BXo6Tw
 x6RSTWlRL1v6YHniKs0qvYF84PiSypefWzvLabkiJtAoGQHsXTkNZ23tQs3aMwrzCb+8
 J5qdKlgljHrJ96ASzQvHYUbEd+IvmL0INV1x8kQtNRJalEOoprJfU/6HFeQIq6qzw/pS
 b6fgYDEwVpyDcz6tmfTejaSR01VU0O1iZqkGpDQfw942kCsV5myehojDcSHemqB1Prt3
 mHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749445537; x=1750050337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QweGwBhLfJ0ZJNk8QbWva6oyOljIx9hhKwC9unVjrN8=;
 b=mtRjNoo19QVV2wQ6AVXSEPT770ZQAQU05x3U8RTBP9vXWz9VKp0AvmfN5Y5t6MOu+y
 SAeXF75MWauke1iDMazMJnaH1DVOE4439oVt1CfZBiKtnwWEOg789TUuEjgOtBOWC7mO
 xnU/fNURqbOSFbHLg5auYxZIjKHpfiAcUAiyfCQ2Zj73Cux4QIfqiwR5NfLOClWg2CeU
 IsNum+dWxLLmOo64+QKQWb9hgJdhlKSsbDIVsNYuswl9rGLYs6MRvulUQvxwqkoBog9+
 WH+zumSe2kUCykvspytj8rOuFjsWXY0fqozXip2kra6V6TYsBp5fpm78OahVHUeOCDSZ
 L0hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtIqBn+ucNjtofjpdNSF7/vqtVjnWA5v954ncSj+lgREuln7jAIecKAIPdYhtMQyUvb0eiAiXGuMsF@nongnu.org
X-Gm-Message-State: AOJu0YyV0k4upYHJnMZF9cX1vWu2BiznB93KAjA33C24XV1ASZdzinjg
 VEU2bBPqr5NkUGXTNyhulC6IdoP86mFoTS80CWhCrvIFLme69+CPOD5bn1fYo4xwQJZR2bjWWMN
 bEF610rWzeQlAww5L2w1vxYGq62tVGQmkNg==
X-Gm-Gg: ASbGnctQiBOxG4K0GhWPDpOE9xkvqyM18Q+2LbgmigA+Uoy9NFtgbn6yh/fNovfulSd
 FGPS+rb6GPx32zltEn5BYEsiTCipyTMQG9nTLzCx3WzecWRAUmiWmy5U5L8mleqG3QE4a3IvKRY
 4jsGaEjQxAWdE0WnQRKmnSogvzDAR6SonmEa2+4/TOCBo00eCsASQFGfjMt3TtTjU=
X-Google-Smtp-Source: AGHT+IEOSJY8NGMBNOopsTitieOfng0RQ8PZ3UwfZ0vF/uEKW+TR0+1zW+cKsT/lMIM0UdKCSBO7P2iwCeksbXeurLg=
X-Received: by 2002:a17:907:972a:b0:ad4:d9b2:6ee4 with SMTP id
 a640c23a62f3a-ade1a9e9361mr1085349566b.49.1749445537206; Sun, 08 Jun 2025
 22:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101255.797162-1-florian.lugou@provenrun.com>
In-Reply-To: <20250605101255.797162-1-florian.lugou@provenrun.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 15:05:09 +1000
X-Gm-Features: AX0GCFsGyiAl48q0eiN7DrNGnDfgnz0U4xue-BaP1BXZetH_eIFa-ZPUf0D8XvI
Message-ID: <CAKmqyKNJFojTN77=hcQu__pLaAfcPoG5Tzgm=L7piWUN=wFPpg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

You would hope the guest software doesn't write to the register when
the FIFO is full

>
> This commit fixes the issue by never pushing back the timer, only
> updating it if it is not already active.

The fix looks correct though

>
> Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

