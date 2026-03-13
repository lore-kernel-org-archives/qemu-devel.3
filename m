Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFF9106FD65
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0rFP-0007Eu-2N; Thu, 12 Mar 2026 21:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rFN-0007EE-0Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:23:25 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rFL-00088P-6k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:23:24 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-661d20c9787so2431223a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 18:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773365001; cv=none;
 d=google.com; s=arc-20240605;
 b=Svk0ye0pz/Or9d+e+TfpL2r2tIlgl1sTxmhF/cNQBxevZ4yrxHP0Cvg1ASGTJWxiYE
 D1aQ8j+bAPAOT8xufghd1IwRve0iv5F3zMu1uBQLxTgyaHsrLVdkeFCc5f64NXDMuttT
 MzS+VmGBgTN+a0vf6Gwa20vZq3WSc8DWmoC3iyf58TAofn41/ehckYU4g7jV32x1U/ht
 CQ6aqUPqF0z1cXgMjvuwPuD0RpU4KqQBFl/9qpgQ232kkol8XmNepwGOPXhozpVmlLrn
 YUyh0e97JQM3iLjCODEZt5UrSKLixvDBR1V+bvkS09R8GuHo8bJ+mqwI8yz9qWcR6+/s
 LhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cjb3+nu3HpvlRxFTPM1bhn9xjlmHqsVENhfhtkI8+so=;
 fh=Yugyz5SJJub7nbOEKVoR++9O2Yndc4n+VrwAcNFbVYM=;
 b=Jje6TWFbHFrQjHRWtnV28EgtM1zb8PFQ76HyuEUmsCO3HXsqUCTrFHbAkeCiEfzJ3C
 1Xllo8tCr0TzGtbhKGdIqzBJpJXpZimwmH+mJhl3ongZmckTaW/vztz9C9LoBEgetkA2
 PKceZ0qUKFBAPiFcPlqgXtl/RD9jzuJXQ5fJnHNItFjbiXysx4yhRxxqmhEM9UQNDDUX
 CQ7hxGvEsdCqGD1VlZ2GXZjWjFRZilKC6x5ad7blUyxOkJMDvSHKWi+H0+OaG7IIj8Ew
 rMA+oZoYqOGXv41xsZ12yXsYdS0GCoS3Xp+pBULkzvoK7Icpic2+vyhRz/aSH8cGobPy
 z6Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773365001; x=1773969801; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cjb3+nu3HpvlRxFTPM1bhn9xjlmHqsVENhfhtkI8+so=;
 b=KRWzg5eug/7k6iFF9QghRRUxJCjj2XytFvWxnrJASTigr3Scgv9e1QrMC6NyEJKoyt
 GHuzLHIRpX3Nx25qHQh0SXS+TvhXzaZWTNYdOVg0oUJaobObUWo41wTZmkkoqLPmHNbL
 i5+d7rfKzNcfueqLF3d0nzmDavdNe6XD6Q5T25o5B1TuU+LgQJyfk7yArPiovomm3dDp
 PhBewWw5isICDqWJL+QMmN0DfqJHDNuEKEs5mXTWCN3bX4C7pXhVUwz7ZBSXVdRM7H9z
 8rpbcGc8V2uoFl8pticfJyVDmyem1T/g6Ni2QWBE0kBaLyqe/P9RuYCR+1QengcfKWAB
 bYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773365001; x=1773969801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cjb3+nu3HpvlRxFTPM1bhn9xjlmHqsVENhfhtkI8+so=;
 b=kFnrNIkw4XN8IzpxS5lPX5Fu5ejh/axxuJKweMs2zk5wpNR8X9vMyYd7uwBJE7MoVN
 rbbdKbjcLjctGkuZplo+LZGcnJAX5zAurtpVawI3mID6tbf7DYBbHxqb0r7lShYl1gEK
 sC1De6R92yrr6W0sIntRM7L4X6IQJM6dtu3nW7EANzCyObtDvTxn3cSzXpm5dfDehZ5C
 0LLEargAnX/Kv+15YBwlZXyNi3YtcCkYYwq2KJs/SJgAS/VVjH8XH/5192u97LwoMka9
 laeGPebe2wuxqL3dOLfV7PQX3dQf6/BfunKPKUYU9p9r/3Vyz+tTTDP5CKkxlABOe45W
 M3jQ==
X-Gm-Message-State: AOJu0YzsnSKCybfXS/RCjmOJg0magx+Y35nra2Bgqb16RVM9si1dqt40
 pAbwC1r94k1TWLgW7A529y2oLnRNb4ah7ZCsv//YUjfHsvhFD8L9BxFcMnfVKa2//goFZFjgNhj
 BjXMNoT0wFSZgORS2h+YiAKtndBw543M=
X-Gm-Gg: ATEYQzxX53N0lzYqL3NAc9fik2Kxuq44QqCKqHEa8xz1DSPj2ieb65Wai6js9NLNS8j
 MLO186OTTfPGHic3kQHwwInjeLd4EIBtqe7iln+SQPDSbZ4uuqxu57Sncr4VEoS4gVnolkft5Jm
 Z1Xq0ywbnLddwQ4ee9zfUDIFFg4su2lkg1k1NG3QHZekkNGVLP1XM5+Bvs++uNjE1pwDuaH24yN
 tNKTu+isBkHhpx+Xz8mU4vWXHEXGL3HhaFE4u/RulFgxMiTMskgliiwuy02tsCr/OGEq4d6Q78y
 qc7s6ny7cDEOsev0FhvkbBkAdcolE2XZElCcqw==
X-Received: by 2002:a05:6402:34c6:b0:663:552e:4a8f with SMTP id
 4fb4d7f45d1cf-663babbee54mr741039a12.17.1773365000931; Thu, 12 Mar 2026
 18:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-2-frank.chang@sifive.com>
In-Reply-To: <20260312033201.1619554-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 11:22:54 +1000
X-Gm-Features: AaiRm512dytQNwIK66I2vpDyvD1r8dHqnvAMa3sqrG4aIuklEhog9rZkejCvCMI
Message-ID: <CAKmqyKN_D19ow9myLe35F-es=k+FwuV13W-7ZZPzfmzY57TUpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] hw/char: sifive_uart: Implement txctrl.txen and
 rxctrl.rxen
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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
> Implement txctrl.txen and rxctrl.rxen as follows:
>
> * txctrl.txen
>   The txen bit controls whether the Tx channel is active. When cleared,
>   transmission of Tx FIFO contents is suppressed, and the txd pin is
>   driven high.
>
> * rxctrl.rxen:
>   The rxen bit controls whether the Rx channel is active. When cleared,
>   the state of the rxd pin is ignored, and no characters will be
>   enqueued into the Rx FIFO.
>
> Therefore, the Tx FIFO should not be dequeued when txctrl.txen is
> cleared, and the Rx FIFO should not be enqueued when rxctrl.rxen is
> cleared.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c         | 27 ++++++++++++++++++++-------
>  include/hw/char/sifive_uart.h |  2 ++
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index af17cf9a6ce..3ce6a4ee76a 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -78,6 +78,11 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIO=
Condition cond,
>          return G_SOURCE_REMOVE;
>      }
>
> +    /* Don't pop the FIFO if transmit is disabled. */
> +    if (!SIFIVE_UART_TXEN(s->txctrl)) {
> +        return G_SOURCE_REMOVE;
> +    }
> +
>      /* Don't pop the FIFO in case the write fails */
>      characters =3D fifo8_peek_bufptr(&s->tx_fifo,
>                                     fifo8_num_used(&s->tx_fifo), &numptr)=
;
> @@ -106,11 +111,19 @@ static gboolean sifive_uart_xmit(void *do_not_use, =
GIOCondition cond,
>      return G_SOURCE_REMOVE;
>  }
>
> -static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t =
*buf,
> -                                      int size)
> +static void sifive_uart_trigger_tx_fifo(SiFiveUARTState *s)
>  {
>      uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>
> +    if (!timer_pending(s->fifo_trigger_handle)) {
> +        timer_mod(s->fifo_trigger_handle, current_time +
> +            TX_INTERRUPT_TRIGGER_DELAY_NS);
> +    }
> +}
> +
> +static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t =
*buf,
> +                                      int size)
> +{
>      if (size > fifo8_num_free(&s->tx_fifo)) {
>          size =3D fifo8_num_free(&s->tx_fifo);
>          qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n=
");
> @@ -124,10 +137,7 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTStat=
e *s, const uint8_t *buf,
>          s->txfifo |=3D SIFIVE_UART_TXFIFO_FULL;
>      }
>
> -    if (!timer_pending(s->fifo_trigger_handle)) {
> -        timer_mod(s->fifo_trigger_handle, current_time +
> -                      TX_INTERRUPT_TRIGGER_DELAY_NS);
> -    }
> +    sifive_uart_trigger_tx_fifo(s);
>  }
>
>  static uint64_t
> @@ -184,6 +194,9 @@ sifive_uart_write(void *opaque, hwaddr addr,
>          return;
>      case SIFIVE_UART_TXCTRL:
>          s->txctrl =3D val64;
> +        if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo))=
 {
> +            sifive_uart_trigger_tx_fifo(s);
> +        }
>          return;
>      case SIFIVE_UART_RXCTRL:
>          s->rxctrl =3D val64;
> @@ -231,7 +244,7 @@ static int sifive_uart_can_rx(void *opaque)
>  {
>      SiFiveUARTState *s =3D opaque;
>
> -    return s->rx_fifo_len < sizeof(s->rx_fifo);
> +    return SIFIVE_UART_RXEN(s->rxctrl) && (s->rx_fifo_len < sizeof(s->rx=
_fifo));
>  }
>
>  static void sifive_uart_event(void *opaque, QEMUChrEvent event)
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.=
h
> index 414564b0266..c78d9bd1fc6 100644
> --- a/include/hw/char/sifive_uart.h
> +++ b/include/hw/char/sifive_uart.h
> @@ -51,6 +51,8 @@ enum {
>
>  #define SIFIVE_UART_TXFIFO_FULL    0x80000000
>
> +#define SIFIVE_UART_TXEN(txctrl)        (txctrl & 0x1)
> +#define SIFIVE_UART_RXEN(rxctrl)        (rxctrl & 0x1)
>  #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
>  #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
>
> --
> 2.43.0
>
>

