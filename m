Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F8FCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 05:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slMUh-0001sI-J1; Tue, 03 Sep 2024 01:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slMUX-0001r4-HG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 01:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slMUV-0000ZG-18
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 01:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725342849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r6EdwJFLh1keIRXsEu/QV5G0LcTKANMAmxgApPFiLTg=;
 b=P/+VWn8+XvDmMFvWPNEFubzJOvGP8FcaI7GfTG+UfA09bFHiCv7fMpml521u/Rlx+jz6EK
 13zIzaG+CwvpM9ACIjsPz9wVWb7vOUn9/014odoStgQwpR/80tX1d+w0rS8SLW+OHe9jBJ
 b63f5ZKZsVtP8uF2x0f3hn7TJAyHiPw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Pf0r0pO9O9u1pM56zX0ZNQ-1; Tue, 03 Sep 2024 01:54:03 -0400
X-MC-Unique: Pf0r0pO9O9u1pM56zX0ZNQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42c82d3c7e5so16968335e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 22:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725342842; x=1725947642;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6EdwJFLh1keIRXsEu/QV5G0LcTKANMAmxgApPFiLTg=;
 b=cruwEN8SWydldsdmCB8uPmhgbgyEhxhJW1xikIpUJlgTspYC1Do9WvU7qQEKW7U11d
 4mdUMU10HoBftJNoaMzGqQ/8Jvq4i+iHJjv/Ls12nG1IE6pZ5MSW7KaiRV17XgVVY/YR
 zaPEhuRVtCQgz3dFSOnptbyWFGTLwcVR1UtzVbMg5rMlqH0lPNuz7Krksd4mu4TGyNjC
 um3qI9BBP2aNvfAoqQVNb2PecDB8TokjlfBXi5w3ctllFeqF5gaqnwvBYOg+BvvI1wES
 GexlHJ6YEdUMzuFud+ruvUIEqJMclYRFCJ3gYoe62C2yOzHqeGf+lr+1kw9s0PZKT9AJ
 xMuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4k1XLfu6bd54oikHXV6FWqU8bDmSdvLSK3ubbybo2fw2daV/dH1eiDqum2TkEFhYH7QWH+y9QutkK@nongnu.org
X-Gm-Message-State: AOJu0YyOGQIAo2iKZj/wzi3ra70NQ4qnlV6HiM83xPf/JdyC+RAXfZFs
 jULFSz4vULnMyL2wcDZxxFlWgySri+dPJIujs6C2QAPcCvMyRxcYEBdRuh/FgfOoUbuywtEeiHe
 OPiSdqfCzQJ8p2wVrOyDj9EM6z896EugekiywB4Vo2jfz1zY3j0Jx
X-Received: by 2002:adf:b350:0:b0:368:3751:de3 with SMTP id
 ffacd0b85a97d-374bf16c0d7mr5490627f8f.31.1725342842244; 
 Mon, 02 Sep 2024 22:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXA/dwiqTzWXQvcyReKsH+hkCI94EwfJuomPhWo9EJ/9/6s7LP7TG3b5SxIZBIe9NkwYdK1g==
X-Received: by 2002:adf:b350:0:b0:368:3751:de3 with SMTP id
 ffacd0b85a97d-374bf16c0d7mr5490608f8f.31.1725342841650; 
 Mon, 02 Sep 2024 22:54:01 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-181.web.vodafone.de.
 [109.43.176.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c4059811sm7068783f8f.4.2024.09.02.22.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 22:54:01 -0700 (PDT)
Message-ID: <585e9a05-2ef8-4abf-be7d-a64948e28851@redhat.com>
Date: Tue, 3 Sep 2024 07:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/char: sifive_uart: Print uart charecters async
To: Alistair Francis <alistair23@gmail.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: liwei1518@gmail.com, atishp@rivosinc.com, palmer@dabbelt.com,
 Bin Meng <bmeng.cn@gmail.com>, zhiwei_liu@linux.alibaba.com,
 Paolo Bonzini <pbonzini@redhat.com>, dbarboza@ventanamicro.com,
 qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240819113148.3007047-1-alistair.francis@wdc.com>
 <20240819113148.3007047-3-alistair.francis@wdc.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240819113148.3007047-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 19/08/2024 13.31, Alistair Francis wrote:
> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped charecters [1].

s/charecters/characters/g

(also in the subject of the patch)

> Let's update the SiFive UART to use a async sifive_uart_xmit() function
> to transmit the charecters and apply back preassure to the guest with

s/preassure/pressure/

> the SIFIVE_UART_TXFIFO_FULL status.
> 
> This should avoid dropped charecters and more realisiticly model the

s/realisiticly/realisticly/

> hardware.
> 
> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
>   };
>   
>   SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 7fc6787f69..07730e241c 100644
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
> +    /* Don't pop the FIFO incase the write fails */

s/incase/in case/

> +    charecters = fifo8_peek_bufptr(&s->tx_fifo,
> +                                   fifo8_num_used(&s->tx_fifo), &numptr);
> +    ret = qemu_chr_fe_write(&s->chr, charecters, numptr);
> +
> +    if (ret >= 0) {
> +        /* We wrote the data, actuallly pop the fifo */

s/actuallly/actually/

I recommend running checkpatch.pl with the --codespell flag ;-)

Anyway, this indeed seems to fix the problem with the avocado test, thank 
you very much for tackling this!

Tested-by: Thomas Huth <thuth@redhat.com>


