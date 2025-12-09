Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAB2D3B980
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0Tv-0003fI-GN; Tue, 09 Dec 2025 11:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT0Tr-0003ef-SY
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:22:27 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT0Tp-0000fn-Vp
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:22:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b9215e55e6so3870136b3a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765297344; x=1765902144; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5DWZjYBfb0iJmfEF096ijLI2x9gjPjttDv+nPl/fbs=;
 b=kh09cDMcZL2fDl/3CIrrdxtyhE7bzaV8HFZmOrIPmJpwCs0sMdEY06FISAw8n5Cg3r
 q57ZNCe9CwZAe95/JYQWweGTQIA0JfjEzKipOeEO3cXCNLcvoFeTioihg9RLQm4YHBRO
 RdmAY9WikzZLhBjWLv0Ma3MpFbkdTEZ7RNsK46dBPR5AeK/ZXWjLRhBEUjR9MQENxnuz
 tMMHYhXkEXt5/+MjVf1EjEWgArDZDGrte7ekFxMH0SayRm4/DdhoSc/ApsKj1ut9HF6e
 oy25bF7Qzqhfabqcv67myiyUxgwP3lkooByloPyztGJxpr6lhxzojTIm0ubQPHNmrSVC
 dOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297344; x=1765902144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N5DWZjYBfb0iJmfEF096ijLI2x9gjPjttDv+nPl/fbs=;
 b=HljIz1+RFPfrd6QBVggBQBUs01iQNWN51t4gzIDmngGibGOil+x6ei3BsIvyD7iS1e
 WPo3Cr3MwIzxfJbLhRpWYrb3U2jMP1y/qZFw3cdrAsIaKGr/OVU8NnAYqIo8AQA1IQGS
 2NY3pUZmAL1zmapVov0xWy9q/Hj8vvoENn0trBz0uZU2CrThpmKJeXubdebISaH9uNtl
 NLKepR4akNs51S9DdLe4HwWKG/oIKn8GW+Ipmt/w+XlXp2FUwHpROyiGnB+dkO3dIZ93
 L634n9qseSd/OqO625Fj3dgeNSLlI3624X7CbYzzSm1bWDMzwtfkbjECiFK+5ih9GJiw
 BiUQ==
X-Gm-Message-State: AOJu0YyrvJ/qQ1JKdhOvsJ2JZZ2oB5loO1KAtMqz5Yv0tf5ovrX1oYG2
 ngKljkT/Awc75SWvIarKIfrdh7JhduRAbDVwwcOppyXcyxmNlOnEn9zlpQEWuy8hJ5w8qUmstyU
 pkx8DchzPB3U7tXKpv/rqjjm2I7jvzADGBQuI7rFoA4ITSn6r44W/dswYweYMMLWAQjLDHChbzg
 KebWQbEZZly+KXu5XtG41lto/3FJHskApuZGGGdpbMMZI=
X-Gm-Gg: ASbGncvPAjLLu7B3NjAjrXLtBgXSLsKCh6if3pobUlKRzKjKR274hpUzLBjCcSsBrB1
 Rg4l4vO1/7j+DC8XS1DxotOADtnOQbsY9TlaucG0UPRsdMzKZhL9A3a6RCdoypGr7E/87coAv3o
 Ui4fllOolnxrY3V1j9iKaTTTlKgKuhSNyfiH5i1SKwERd6OdAI2OU/2NBT5REHFAixJhvps/+vs
 UyMGsYXIUnYyiRawcaBlQvRr9YacCGcWonOtPd2311DV5R+LSqzz09DdLoIzW1li6nyl6PPEgKh
 pWIreA4w4MYi2EqX3nt5bq6bb1RkYuOz4Y4VnBGvoe+5mJyV0yPY1qKOwYxpOTl/savTJYc7fUF
 kJJQaPU3efx+RViq7OS6jDLzox28xwKS6C9/VQNhdY7Z7X8dsP5xswoWh74Rw8XSyL7wxC+8Q6O
 QrdDeKihJu3P5B9Zu576fx6eRuaJg+xtm1TGiPwcFIx34q3aCbUFvA0Z4=
X-Google-Smtp-Source: AGHT+IF1Iwdsvr+tCFmVDjOwswOW/G2yoKq54P63t7K5xl6tdqVM5MUOYl6Brgvrd9W6dU6YepS2Hw==
X-Received: by 2002:a05:7022:e0d:b0:11b:998d:bded with SMTP id
 a92af1059eb24-11e032aa392mr7738958c88.28.1765297343760; 
 Tue, 09 Dec 2025 08:22:23 -0800 (PST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com.
 [209.85.215.172]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11df7552211sm76602475c88.1.2025.12.09.08.22.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 08:22:23 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ba2450aba80so3357650a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:22:22 -0800 (PST)
X-Received: by 2002:a05:7301:5044:b0:2a4:6b6d:90ae with SMTP id
 5a478bee46e88-2abc711b63dmr6420513eec.9.1765297342262; Tue, 09 Dec 2025
 08:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20251114084343.1094486-1-frank.chang@sifive.com>
In-Reply-To: <20251114084343.1094486-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 10 Dec 2025 00:22:11 +0800
X-Gmail-Original-Message-ID: <CANzO1D0jEdFAAF9VmrXHSC9WTSoCM3hYA2MxaZV8q9ex6BroAA@mail.gmail.com>
X-Gm-Features: AQt7F2q5Z8thRkIjKYiXrToypl0ojKDdS04Ovc9z7CoXpl7YPTvKFBV2l9t6x4o
Message-ID: <CANzO1D0jEdFAAF9VmrXHSC9WTSoCM3hYA2MxaZV8q9ex6BroAA@mail.gmail.com>
Subject: Re: [PATCH] hw/char: sifive_uart: Implement txctrl.txen and
 rxctrl.rxen
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
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

I found other SiFive UART bugs that need to be fixed.
This commit is squashed and replaced by another patchset:
https://patchew.org/QEMU/20251209160117.1239596-1-frank.chang@sifive.com/

Regards,
Frank Chang

<frank.chang@sifive.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8814=E6=97=A5=E9=
=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:44=E5=AF=AB=E9=81=93=EF=BC=9A
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
> ---
>  hw/char/sifive_uart.c         | 27 ++++++++++++++++++++-------
>  include/hw/char/sifive_uart.h |  2 ++
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index e7357d585a1..4a54dd52a1e 100644
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
> index 6486c3f4a5d..e216cacf693 100644
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

