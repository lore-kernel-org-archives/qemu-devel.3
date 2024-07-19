Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3124CC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 21:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUv6i-0005lF-Fr; Fri, 19 Jul 2024 17:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUv6g-0005gY-Dj; Fri, 19 Jul 2024 17:25:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUv6e-0001fO-D2; Fri, 19 Jul 2024 17:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=8XYBJwUoqgclEuv4hcBZLNekYaOfrq+MlZwBxidzTao=; b=JCdiH8DMzWFV6KzpcbG9T+xcTe
 7ITGVFtzrtgK8n7/giGU9bsWjrnLIB8TjodwLeo8vVIz953ZSSB9t+5zwwSSmfPt2Wn0gXdPajg90
 ENEb/ihfGcZ7vA4FuCGXFgTctl+0hY+RkFAlwCcWRDXSYmKcKpwO6immAP8TbX/xJozDyvRtoRJ1P
 C5Da2BpuWbcqAq8C+9uKyR2pNZg8FG0eVeBSeijz9to2jynMB3W8UbpUfwuDK0C3SIEigoDLVTlt2
 SucEl5Z3SlRuAQDd64tClJhoEPi+frTi8xxIy4dael50Ks6WpiLAqQfPuhF9YSE8lGH27Gw+L3b3L
 ATgariPGuNtbUergHex+SzChAeFtW8Dq3kSVwYofXzuSV4C9J0Ei4Obqb5eLteRa+SPealSCUThJf
 JkduQBJjF6nP2dEgIetFxPn/Zhk4hAG74aVdwMhxM9tVe1Ti/+4OW4G3pRXGcus3BWPQ82+tacrAa
 hLFqFD84t3mHmk57SwDxIIYBIMZsZLhg0vtZvV2apVJLGlW9vlAY29SbivOjAWzFKQcwNuBxHGnhn
 9XiSX5uAEvekbrtF8h7a8ZGx9YiuIHivyU6s2Utc+7zGmSauXnUOqyZgkJyS7yueJyJIOc5Tb/PAY
 TNiLdJQUesVca00XL5n1mGy3jjwV+5FgisK1Qh2F4=;
Received: from [2a00:23c4:8bb4:4000:502:30b7:7825:e35a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUv53-0002yI-AW; Fri, 19 Jul 2024 22:24:01 +0100
Message-ID: <4e6b616f-3acc-4130-9b92-1af7fed540da@ilande.co.uk>
Date: Fri, 19 Jul 2024 22:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-17-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240719181041.49545-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:502:30b7:7825:e35a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [RFC PATCH v5 16/16] hw/char/pl011: Implement TX FIFO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 19/07/2024 19:10, Philippe Mathieu-Daudé wrote:

> If the UART back-end chardev doesn't drain data as fast as stdout
> does or blocks, buffer in the TX FIFO to try again later.
> 
> This avoids having the IO-thread busy waiting on chardev back-ends,
> reported recently when testing the Trusted Reference Stack and
> using the socket backend.
> 
> Implement registering a front-end 'watch' callback on back-end
> events, so we can resume transmitting when the back-end is writable
> again, not blocking the main loop.
> 
> Similarly to the RX FIFO path, FIFO level selection is not
> implemented (interrupt is triggered when a single byte is available
> in the FIFO).
> 
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Something is still broken, some characters are emitted async...
> ---
>   hw/char/pl011.c      | 60 ++++++++++++++++++++++++++++++++++++--------
>   hw/char/trace-events |  1 +
>   2 files changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index cfa3fd3da4..9f72b6a765 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -240,7 +240,9 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
>   {
>       PL011State *s = opaque;
>       int bytes_consumed;
> -    uint8_t data;
> +    const uint8_t *buf;
> +    uint32_t buflen;
> +    uint32_t count;
>   
>       if (!(s->cr & CR_UARTEN)) {
>           qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled UART\n");
> @@ -249,25 +251,40 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
>           qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
>       }
>   
> +    count = fifo8_num_used(&s->xmit_fifo);
> +    if (count < 1) {
> +        /* FIFO empty */
> +        return G_SOURCE_REMOVE;
> +    }
> +
>       if (!qemu_chr_fe_backend_connected(&s->chr)) {
>           /* Instant drain the fifo when there's no back-end. */
>           pl011_drain_tx(s);
>           return G_SOURCE_REMOVE;
>       }
>   
> -    data = fifo8_pop(&s->xmit_fifo);
> -    bytes_consumed = 1;
> +    buf = fifo8_peek_buf(&s->xmit_fifo, count, &buflen);
>   
> -    /*
> -     * XXX this blocks entire thread. Rewrite to use
> -     * qemu_chr_fe_write and background I/O callbacks
> -     */
> -    qemu_chr_fe_write_all(&s->chr, &data, bytes_consumed);
> +    /* Transmit as much data as we can. */
> +    bytes_consumed = qemu_chr_fe_write(&s->chr, buf, buflen);
>       trace_pl011_fifo_tx_xmit(bytes_consumed);
> +    if (bytes_consumed < 0) {
> +        /* Error in back-end: drain the fifo. */
> +        pl011_drain_tx(s);
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    /* Pop the data we could transmit. */
> +    fifo8_pop_buf(&s->xmit_fifo, bytes_consumed, NULL);
>       s->int_level |= INT_TX;
>   
>       pl011_update(s);

One of the gotchas with Fifo8 is that whilst fifo8_push(), fifo8_pop() and 
fifo8_push_all() will wrap the FIFO buffer, fifo8_{peek,pop}_buf() do not. For 
example fifo8_num_used() could return 15, but if xmit_fifo->head is set to 15 then 
fifo8_{peek_pop}_buf() would return 1 leaving 14 characters in the FIFO at the end of 
pl011_xmit().

Possible solutions could be to use a loop to send one character at a time similar to:

     while (fifo8_num_used(&s->xmit_fifo)) {
         uint8_t c = fifo8_pop(&s->xmit_fifo);

         if (qemu_chr_fe_write(&s->chr, &c, 1) == -1) {
             fifo8_push(&s->xmit_fifo, c);
             break;
         }
     }

Or else use a solution similar to the one I used for ESP at 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/esp.c?ref_type=heads#L200. 
I did think about whether it was worth adding a function similar to the one used for 
ESP to the Fifo8 API, but wasn't sure it was worth it at the time.

> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
> +        /* Reschedule another transmission if we couldn't transmit all. */
> +        return G_SOURCE_CONTINUE;
> +    }
> +
>       return G_SOURCE_REMOVE;
>   }
>   
> @@ -290,6 +307,10 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
>       trace_pl011_fifo_tx_put(data);
>       pl011_loopback_tx(s, data);
>       fifo8_push(&s->xmit_fifo, data);
> +    if (fifo8_is_full(&s->xmit_fifo)) {
> +        s->flags |= PL011_FLAG_TXFF;
> +    }
> +
>       pl011_xmit(NULL, G_IO_OUT, s);
>   }
>   
> @@ -488,10 +509,24 @@ static void pl011_write(void *opaque, hwaddr offset,
>           pl011_trace_baudrate_change(s);
>           break;
>       case 11: /* UARTLCR_H */
> -        /* Reset the FIFO state on FIFO enable or disable */
>           if ((s->lcr ^ value) & LCR_FEN) {
> -            pl011_reset_rx_fifo(s);
> +            bool fifo_enabled = value & LCR_FEN;
> +
> +            trace_pl011_fifo_enable(fifo_enabled);
> +            if (fifo_enabled) {
> +                /* Transmit and receive FIFO buffers are enabled (FIFO mode). */
> +                fifo8_change_capacity(&s->xmit_fifo, PL011_FIFO_DEPTH);
> +            } else {
> +                /*
> +                 * FIFOs are disabled (character mode) that is, the FIFOs
> +                 * become 1-byte-deep holding registers.
> +                 */
> +                pl011_drain_tx(s);
> +                fifo8_change_capacity(&s->xmit_fifo, 1);
> +            }

Presumably this is the part where fifo8_change_capacity() is required: what does 
changing the FIFO size to 1 do here? Is it possible to move the fifo_enabled check 
into pl011_read() and pop/clear the buffer there instead of changing the FIFO size?

> +            /* Reset the FIFO state on FIFO enable or disable */
>               pl011_reset_tx_fifo(s);
> +            pl011_reset_rx_fifo(s);
>           }
>           if ((s->lcr ^ value) & LCR_BRK) {
>               int break_enable = value & LCR_BRK;
> @@ -636,6 +671,11 @@ static int pl011_post_load(void *opaque, int version_id)
>           s->read_pos = 0;
>       }
>   
> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
> +        /* Reschedule another transmission */
> +        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, pl011_xmit, s);
> +    }
> +
>       s->ibrd &= IBRD_MASK;
>       s->fbrd &= FBRD_MASK;
>   
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index bf586ba664..2405819812 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -58,6 +58,7 @@ pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x valu
>   pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
>   pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
>   pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
> +pl011_fifo_enable(bool enable) "enable:%u"
>   pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
>   pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
>   pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"


ATB,

Mark.


