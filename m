Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA6FECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbYL-00078u-MS; Mon, 09 Sep 2024 06:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snbYK-00077w-Nl
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:23:24 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snbYI-0001Wm-Os
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:23:24 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so5570133a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725877401; x=1726482201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J/HMTZVwB52D14P1e7i1YYF4JF97NTzpew1Q+6Ef6Q8=;
 b=JoSMAZvFjjh13w5DY9Z9Ymn2pE28vkAFYWzcYnB28ixj1fvE593Fr5cvtOpjp+BNuj
 O8McXF0ZoN1Bhlpl00aKlBwQwTB5mnVwEPM7UhVnJe4UuvXtCB6EA8CE9eQnw5NSO3BT
 a2ig7dbyk0nPnImaHf1tsO5WlYLoKf07U6HlL/khoJeGQ7ROy90clZobgwOdeuUF4Mfz
 90eWZdWvxO9Ueq7+UALTS+YbdjJvz/lgYyeU9aKjJOa0FR2phdT3KPuXZ7rQXIepK6p4
 haBu/Sl7ot13snhU2kL/uULoh79FAEQjv/cji2zacf0h4gw9j1a9oH1xQb9gkIHoIHCe
 aRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725877401; x=1726482201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/HMTZVwB52D14P1e7i1YYF4JF97NTzpew1Q+6Ef6Q8=;
 b=TTofov2BO+lDQRaEzddcSlqseQozJ+IasD0MtvptJCgY7BfVo63cRjk7/cKAFSDphi
 lI20bxA+Vq3LylVz8SLvGpWAaW6NxjfO7WPljMQ8Pc8jRpJ51FtFI2KIojNDugqDp1am
 /zNLrzbA/aW8XmQXO5d4Sqkgo31Rz5TCfxAIdbOUrAWY6Z1SMkNNn5+oqw710J5J/GMv
 rFvH2P+uiQq0xckSIx83KoTDEI6O1QDTjs5MmJTY/CzbX/+TyxU0Wy8Z2xx7dg4s63Jo
 I7ZPM8Q2N1VjxlJVj2bSGpg3g6YGzuqQwRwcrJWTFWLUb9BipGa2CfLNpeudMkuvMoka
 DSgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxCQZw0sCSDA60EDtMvnathM75EgR84VinVV4Xhzh4+z34f5jXhbqGErLMefAxSdjYcaL9I3NLiAiZ@nongnu.org
X-Gm-Message-State: AOJu0YyYZStndFnCZZKt/w3BIQ4Ie7I9ISnxSceOin1vLGLEBezuurqF
 0ezx79JMNipZWAUE/Ux5GB4QjSyrLrr19ym+1DpgRzHeIHNN6pIab1Q6tPb/ilY=
X-Google-Smtp-Source: AGHT+IE6de0mXBeVNxd7cWjpTavK1imW/dVqoylXXEVX4zHY9NqI/8H2HXpLDOmda1W1ru2m4c808Q==
X-Received: by 2002:a05:6402:518b:b0:5bf:f1:908 with SMTP id
 4fb4d7f45d1cf-5c3dc7bd6e3mr8145717a12.24.1725877400385; 
 Mon, 09 Sep 2024 03:23:20 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41bd4sm2823942a12.11.2024.09.09.03.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 03:23:19 -0700 (PDT)
Message-ID: <3ef8aa99-86b3-4c2d-8914-b4a59a2066ac@linaro.org>
Date: Mon, 9 Sep 2024 12:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/char: sifive_uart: Print uart characters async
To: Alistair Francis <alistair23@gmail.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 liwei1518@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240909021317.58192-1-alistair.francis@wdc.com>
 <20240909021317.58192-3-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909021317.58192-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alistair,

On 9/9/24 04:13, Alistair Francis wrote:
> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped characters [1].
> 
> Let's update the SiFive UART to use a async sifive_uart_xmit() function
> to transmit the characters and apply back pressure to the guest with
> the SIFIVE_UART_TXFIFO_FULL status.
> 
> This should avoid dropped characters and more realisticly model the
> hardware.
> 
> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/char/sifive_uart.h | 17 ++++++-
>   hw/char/sifive_uart.c         | 88 +++++++++++++++++++++++++++++++++--
>   2 files changed, 99 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
> index 7f6c79f8bd..b43109bb8b 100644
> --- a/include/hw/char/sifive_uart.h
> +++ b/include/hw/char/sifive_uart.h
> @@ -24,6 +24,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/sysbus.h"
>   #include "qom/object.h"
> +#include "qemu/fifo8.h"
>   
>   enum {
>       SIFIVE_UART_TXFIFO        = 0,
> @@ -48,9 +49,13 @@ enum {
>       SIFIVE_UART_IP_RXWM       = 2  /* Receive watermark interrupt pending */
>   };
>   
> +#define SIFIVE_UART_TXFIFO_FULL    0x80000000
> +
>   #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
>   #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
> +
>   #define SIFIVE_UART_RX_FIFO_SIZE 8
> +#define SIFIVE_UART_TX_FIFO_SIZE 8
>   
>   #define TYPE_SIFIVE_UART "riscv.sifive.uart"
>   OBJECT_DECLARE_SIMPLE_TYPE(SiFiveUARTState, SIFIVE_UART)
> @@ -63,13 +68,21 @@ struct SiFiveUARTState {
>       qemu_irq irq;
>       MemoryRegion mmio;
>       CharBackend chr;
> -    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
> -    uint8_t rx_fifo_len;
> +
> +    uint32_t txfifo;
>       uint32_t ie;
>       uint32_t ip;
>       uint32_t txctrl;
>       uint32_t rxctrl;
>       uint32_t div;
> +
> +    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
> +    uint8_t rx_fifo_len;
> +
> +    Fifo8 tx_fifo;
> +
> +    QEMUTimer *fifo_trigger_handle;
> +    uint64_t char_tx_time;

Unfortunately some fields now need to be migrated and
tracked in vmstate_sifive_uart[].

>   };
>   
>   SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 7fc6787f69..ab899b60d6 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -64,6 +64,72 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
>       }
>   }
>   
> +static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
> +                                 void *opaque)
> +{
> +    SiFiveUARTState *s = opaque;
> +    int ret;
> +    const uint8_t *charecters;

"characters" ;)

> +    uint32_t numptr = 0;
> +
> +    /* instant drain the fifo when there's no back-end */
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        fifo8_reset(&s->tx_fifo);
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    if (fifo8_is_empty(&s->tx_fifo)) {
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    /* Don't pop the FIFO in case the write fails */
> +    charecters = fifo8_peek_bufptr(&s->tx_fifo,
> +                                   fifo8_num_used(&s->tx_fifo), &numptr);
> +    ret = qemu_chr_fe_write(&s->chr, charecters, numptr);
> +
> +    if (ret >= 0) {
> +        /* We wrote the data, actually pop the fifo */
> +        fifo8_pop_bufptr(&s->tx_fifo, ret, NULL);
> +    }
> +
> +    if (!fifo8_is_empty(&s->tx_fifo)) {
> +        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                        sifive_uart_xmit, s);
> +        if (!r) {
> +            fifo8_reset(&s->tx_fifo);
> +            return G_SOURCE_REMOVE;
> +        }
> +    }
> +
> +    /* Clear the TX Full bit */
> +    if (!fifo8_is_full(&s->tx_fifo)) {
> +        s->txfifo &= ~SIFIVE_UART_TXFIFO_FULL;
> +    }
> +
> +    sifive_uart_update_irq(s);
> +    return G_SOURCE_REMOVE;

Alex suggested to see if we can have a generic (abstract?) FIFO char
implementation. I might have a look later when I get the PL011 series
in.

> +}
> +
> +static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
> +                                      int size)
> +{
> +    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    if (size > fifo8_num_free(&s->tx_fifo)) {
> +        size = fifo8_num_free(&s->tx_fifo);
> +        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
> +    }
> +
> +    fifo8_push_all(&s->tx_fifo, buf, size);
> +
> +    if (fifo8_is_full(&s->tx_fifo)) {
> +        s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
> +    }
> +
> +    timer_mod(s->fifo_trigger_handle, current_time +
> +              (s->char_tx_time * 4));
> +}
> +
>   static uint64_t
>   sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> @@ -82,7 +148,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
>           return 0x80000000;
>   
>       case SIFIVE_UART_TXFIFO:
> -        return 0; /* Should check tx fifo */
> +        return s->txfifo;
>       case SIFIVE_UART_IE:
>           return s->ie;
>       case SIFIVE_UART_IP:
> @@ -106,12 +172,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
>   {
>       SiFiveUARTState *s = opaque;
>       uint32_t value = val64;
> -    unsigned char ch = value;
>   
>       switch (addr) {
>       case SIFIVE_UART_TXFIFO:
> -        qemu_chr_fe_write(&s->chr, &ch, 1);
> -        sifive_uart_update_irq(s);
> +        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
>           return;
>       case SIFIVE_UART_IE:
>           s->ie = val64;
> @@ -131,6 +195,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
>                     __func__, (int)addr, (int)value);
>   }
>   
> +static void fifo_trigger_update(void *opaque)
> +{
> +    SiFiveUARTState *s = opaque;
> +
> +    sifive_uart_xmit(NULL, G_IO_OUT, s);
> +}
> +
>   static const MemoryRegionOps sifive_uart_ops = {
>       .read = sifive_uart_read,
>       .write = sifive_uart_write,
> @@ -197,6 +268,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
>   {
>       SiFiveUARTState *s = SIFIVE_UART(dev);
>   
> +    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          fifo_trigger_update, s);
> +
>       qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
>                                sifive_uart_event, sifive_uart_be_change, s,
>                                NULL, true);
> @@ -206,12 +280,18 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
>   static void sifive_uart_reset_enter(Object *obj, ResetType type)
>   {
>       SiFiveUARTState *s = SIFIVE_UART(obj);
> +
> +    s->txfifo = 0;
>       s->ie = 0;
>       s->ip = 0;
>       s->txctrl = 0;
>       s->rxctrl = 0;
>       s->div = 0;
> +
>       s->rx_fifo_len = 0;
> +
> +    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
> +    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
>   }
>   
>   static void sifive_uart_reset_hold(Object *obj, ResetType type)


