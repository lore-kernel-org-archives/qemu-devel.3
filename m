Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F405CE9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqY7-0000rs-Gl; Tue, 24 Feb 2026 06:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqY6-0000qc-Fr
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:25:54 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqY4-0004Ix-96
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:25:54 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ca09f2056so295285d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:25:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932350; cv=none;
 d=google.com; s=arc-20240605;
 b=iKk5y+AP+aUImmchVQtkDnFYkRvxiU7ZpxegmrUhzc8K14xUWS6wDXGjlOBKJRBzxj
 JCYFDwHFqeXIEzZQsCh+fr7xRvWVvvyywdiKJDPBQM71F3xZ928CpMHm/7bVMnRj+Tfx
 Wy9zEO4GNpkvKFaroV0usfT/8vKB2lFEXP4etnFsT8Fiw5B4Swc7XlR69o3MODN9EYgj
 msfHNbB7VW3R4+WHVdDcTX5lWePYZcU3swn1n9fl4ilbmehLxq6nGKho1xBE0iz5nntq
 qdRgiBqXsLMEts3X3dM06TtfNUP2SpXo4KImb1a6Qn6VwCKYfnFeDFHUxkCyE1p+/qRP
 JWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=anqVlmblhXoqErTrjBU1z0bUl/NdAXado1i7fdBY8Fk=;
 fh=x+CshndmYsJJJOivPAv4FgsTZnciEOGb2FO79afWEn8=;
 b=DNnkGgQWdSyAXgP9ZGc7l8YlYOX12saaX9ngJTIl5JqTWXuyNdRnERoKpAKx+At4ai
 WcK9dpgysR0IFe0lPand18rJS/FbtlqLRYB/8KH+sAFocC5sVohZAGSPN0fNr1T3/mP3
 OkDhImjz/FKX3HOLxzCWy0B6xrRfClZwxw3Q72mpq2cUcg3cKFqihsKt2M3MLl46t06R
 spHBgyH1tEBgD0mLPU/oQ7nJThpdJXHbokKh7KQk8mxFPueUbBPESHIJ/ZBwLgUFir/K
 ICVH3YnjpTydLhq/++qGB6ua/0Can6iMf7TZBwTTLtRlOfFL1P2NeMpBR2/vwTi8SHwg
 yOQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771932350; x=1772537150; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=anqVlmblhXoqErTrjBU1z0bUl/NdAXado1i7fdBY8Fk=;
 b=RCFMloXifjXIpgfg0yQMkRK0Fuj6QcfbaEg/kvpIglOJqE73SJtEbP/GiqcojoEAOv
 bxpOnNRM4GWFgJ5lj+jy4hxyIo21z92b8X1yDzyJ9ElWCOSX4BFYd2j3zVv9gak9l7mQ
 49y3hz90bEdwukQF5oekWCRpjkbJP/vIQ/HFg6vh8vsotoHSDBmEjIg2up9SjqGkCUoj
 g2oWjjjHfbMcpJHKRgfqqJVWDxp29ApoAr8QHbnaMM6T8d9fixzIr3mtihZSamD4vuSh
 nnjbgPLhq5DNV1fTJOQJ/bdC32oofF5xY0Z1sSfDJCAnmLFyQf/T5Obw9syvoy/lk8lL
 2qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771932350; x=1772537150;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anqVlmblhXoqErTrjBU1z0bUl/NdAXado1i7fdBY8Fk=;
 b=Xci306tfjTZhvGVj4O/uYEowinhMLAhyLcaQf33/b+Qk0+JfmAuttBeI+Ct34/lPay
 doW4PL/BnnzlINqPz+3jP8+JeU7s+K2H46siCPKlJ/5yCRebzY+qKfZLboYVmTs84Ufq
 7YJvhQ1IZh1y/E06zKw/jo+UBr7Va5bW0OfLgUJdS9i60Kd3LUZZZrYxPBU8yPN5g3MV
 ZX7x1l4cXK1eazfatIwGQfAACppDNMBiVxNjFewx2DcuFZLjWDw7UcZYw2afFU1AGrIq
 H56UtvAsyNG3pVrAlKxISI2ACYR/Ybz6C7IPSOp5DfFqHUnKYM0SjSZt18Abbu1KOoaD
 TKAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmUT3iy3/HRrXcD6tQ1V698lrtTeXO1FMTt0mE/buNTS3ZPNjEYprFHf83fYd1aKa1XGeDs839VPDM@nongnu.org
X-Gm-Message-State: AOJu0Yy3X+9AaaHhIE8SYw82BVgkqthdpa4NW/bj6IV5QWd73kwxtmTt
 qbBBOil4VpA4scN3pk7zxek+rIBJDn3onDftLmwab5z16BNL2+6wJJEglETpmlpwp8fLhfuB4pW
 7sKip3ppBqP0RNw/3UPhbgIUfWxztrJE+b4T94mZAFCeopr6dTwfC
X-Gm-Gg: ATEYQzwfGafsZhkoeNYHhaPRTtYJffwxxLueBQbfwOgjfxs9GlxCyUy7S0LRYZ4DAaC
 AToCnn/z4GTQ/bZApB6aDBErbMWHN1NY6OhfXMSv0tlXyKcexV/zCUzSOtZbllYdogUbgwGYiub
 LWnfn8NW/GwJhVeQDxdO6KihGSDIXIp7MxWLNGh7W6cJFhyGVu3FdRq0TQRodq6dY8w+gEBtRST
 7sPzZrbJXXPMFsyTYV7DFc19EfjM1Ce6L8r1ZDnQQyWPXHO+DDzn8hC2HJeI7X6WoKSushXuApi
 SEeJDcfzda8KsIavCQu+GYI/YBbnu0SdcVkN9GFEdPcB2S8IzbhsHMe4VserVdvinF4=
X-Received: by 2002:a05:690e:134c:b0:649:e501:21af with SMTP id
 956f58d0204a3-64c787d4d6fmr8758791d50.14.1771932349733; Tue, 24 Feb 2026
 03:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20260210101702.3980804-1-peter.maydell@linaro.org>
In-Reply-To: <20260210101702.3980804-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:25:38 +0000
X-Gm-Features: AaiRm511caSeVEUCDy_bF5wcOKNK09wyU0rVeClWQjHN8x60RNjpA910bB5vX54
Message-ID: <CAFEAcA_fNFEov+etidkWVqTV4j-Br_rZX7SPdqLQeOwS-77Nrw@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: Only log "data written to disabled UART"
 once
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

Ping for review?

thanks
-- PMM

On Tue, 10 Feb 2026 at 10:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We log a GUEST_ERROR message "PL011 data written to disabled UART" if
> the guest writes data to the TX FIFO when it has not set the enable
> bit in the UART.  The idea is to note that the guest has done
> something dubious but let it work anyway.  However, since we print
> this message for every output character, it floods the logs when
> running a guest that does this.
>
> Keep a note of whether we've printed the log message or not, so we
> only output it once.  If the guest actively disables the UART, we
> re-arm the log message.
>
> Notably, the Linux kernel does not bother to enable the UART if it is
> used for earlycon, relying on the firmware having already done that.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The log messages here were getting in my way trying to debug something
> else, but I didn't want to just delete them completely.
>
>  hw/char/pl011.c         | 24 ++++++++++++++++++++++--
>  include/hw/char/pl011.h |  1 +
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index b2ca68e3e8..cb12c3e224 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -227,10 +227,25 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
>  static void pl011_write_txdata(PL011State *s, uint8_t data)
>  {
>      if (!(s->cr & CR_UARTEN)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "PL011 data written to disabled UART\n");
> +        /*
> +         * Only log this message once, not every time the guest outputs:
> +         * otherwise we would flood the logs with this message, making
> +         * harder to debug guests. (Some very popular guests like Linux
> +         * don't actively enable the UART.)
> +         */
> +        if (!s->logged_disabled_uart) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "PL011 data written to disabled UART\n");
> +            s->logged_disabled_uart = true;
> +        }
>      }
>      if (!(s->cr & CR_TXE)) {
> +        /*
> +         * We don't bother with the only-log-once machinery for this check
> +         * because TXE is enabled by default from PL011 reset, so there
> +         * isn't likely to be existing in-the-wild guest code that trips
> +         * over this one.
> +         */
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "PL011 data written to disabled TX UART\n");
>      }
> @@ -457,6 +472,10 @@ static void pl011_write(void *opaque, hwaddr offset,
>          break;
>      case 12: /* UARTCR */
>          /* ??? Need to implement the enable bit.  */
> +        if ((s->cr ^ value) & CR_UARTEN) {
> +            /* Re-arm the log warning when the guest toggles UARTEN */
> +            s->logged_disabled_uart = false;
> +        }
>          s->cr = value;
>          pl011_loopback_mdmctrl(s);
>          break;
> @@ -665,6 +684,7 @@ static void pl011_reset(DeviceState *dev)
>      s->ifl = 0x12;
>      s->cr = 0x300;
>      s->flags = 0;
> +    s->logged_disabled_uart = false;
>      pl011_reset_rx_fifo(s);
>      pl011_reset_tx_fifo(s);
>  }
> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
> index ff735b5234..5695787650 100644
> --- a/include/hw/char/pl011.h
> +++ b/include/hw/char/pl011.h
> @@ -51,6 +51,7 @@ struct PL011State {
>      qemu_irq irq[6];
>      Clock *clk;
>      bool migrate_clk;
> +    bool logged_disabled_uart;
>      const unsigned char *id;
>      /*
>       * Since some users embed this struct directly, we must
> --
> 2.43.0

