Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A61BC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 11:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY2hw-0001Kg-Hq; Thu, 08 Feb 2024 06:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY2hu-0001KB-Nf
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 06:36:42 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY2hr-0006Z9-SC
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 06:36:41 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5600c43caddso1813057a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 03:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707392198; x=1707996998; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8x/YgZw1AGkDrc//lQ1l/l9Zb/CYBXjpvIK5sQ8j7Mg=;
 b=v4DA128wj1T8bPBX98MzWJSMDWWkcRbSVKo8bkGltMgfZVKXaq43oLHRCLUxO6TFpy
 b2MYzDsi5F6UbguLXevoNG1jl0/bCHxgv3XO4GE9CR/lL2v+IdSbHykG9oUHA/UXtueH
 LcgP0HfhOoKCvacxjWAx07iWM0BzvxeV+bEION2K9AaZ7HOobZnfIiiUfIZz6qVvTDVe
 +4SopAlRwYnmar7IBiNMc2zOFZS7beBq70XEX+6TKXirzxy29E+345Wb6jxH6HjOLu/U
 YSODt7H3RfIG9RgZnEqjpkipj3//XOJtbk0aOt8+cR4+/SwnHJ2OYksPB3XLYDBSfJbo
 GDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707392198; x=1707996998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8x/YgZw1AGkDrc//lQ1l/l9Zb/CYBXjpvIK5sQ8j7Mg=;
 b=fguGjbIXrP23UTynNS3VqmJkLB5SuRNKArPv7pzcfQ7lWxb2AZaMC7L09wJ3+C8RdH
 8YkoV1GoiN2uZFQVuIVBykFgyLQx3ymlL9xe2A429u3wZEOGs/AsWdXaCcJQlyIutIpc
 SxAyasQ3Tcob54FXIThl+/h5GMgrasffkgyvO4fW9hSrZMqld516j73Q/ynVTaplAp2F
 M82IS3saSSsq/vMhCCrnw8WuHQtr79HfFRsdvDizasEh+HSz6YWoLNyAd5Lb1Am3Qs1f
 ktK8NmRKppfdZN591IYqdlPdirEj80jx4/qGyvKQSptrawP8gD9i8hYT47T9MMEH3BLe
 Z38Q==
X-Gm-Message-State: AOJu0YyC7gu6XUN1ojSn9yxhCXW3U0N6597cNPNsfh1ovbbgFrNFAhps
 PSvosALZ5T8h+1RhS3A6Cn7bek9j7RB3p5p+2tlzm/9p/GbbrC66lbnHROQNoMy6pgshrD2VVUG
 BrOE/YAtQGGwBwzO6ZMO9Xs21pfhNM4x5lbrOug==
X-Google-Smtp-Source: AGHT+IEby3JCci+anHsUw2GEOm5RffDDlsjBlcNpVKMiZRFY9taXkgqpM/w3J5wkj6ptJ6pQm3w7R/nQjD3so8w6VOk=
X-Received: by 2002:a05:6402:1b1c:b0:55f:99:c895 with SMTP id
 by28-20020a0564021b1c00b0055f0099c895mr5580279edb.20.1707392197849; Thu, 08
 Feb 2024 03:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20240207050308.3221396-1-tong.ho@amd.com>
In-Reply-To: <20240207050308.3221396-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 11:36:26 +0000
Message-ID: <CAFEAcA-JnKM9TCbp5=_Ogsnz+GSO96CcP1T-_5jTrSEXAyXc2Q@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: Add support for loopback
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 7 Feb 2024 at 05:03, Tong Ho <tong.ho@amd.com> wrote:
>
> This patch adds loopback for sent characters as well as
> modem-control signals.
>
> Loopback of send and modem-control is often used for uart
> self tests in real hardware but missing from current pl011
> model, resulting in self-test failures when running in QEMU.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>

Hi; thanks for this patch.

> ---
>  hw/char/pl011.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 855cb82d08..3c0e07aa35 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -121,6 +121,51 @@ static void pl011_update(PL011State *s)
>      }
>  }
>
> +static void pl011_put_fifo(void *opaque, uint32_t value);
> +
> +static bool pl011_is_loopback(PL011State *s)
> +{
> +    return !!(s->cr & (1U << 7));
> +}
> +
> +static void pl011_tx_loopback(PL011State *s, uint32_t value)
> +{
> +    if (pl011_is_loopback(s)) {
> +        pl011_put_fifo(s, value);
> +    }
> +}
> +
> +static uint32_t pl011_cr_loopback(PL011State *s, bool update)
> +{
> +    uint32_t cr = s->cr;
> +    uint32_t fr = s->flags;
> +    uint32_t ri = 1 << 8, dcd = 1 << 2, dsr = 1 << 1, cts = 0;
> +    uint32_t out2 = 1 << 13, out1 = 1 << 12, rts = 1 << 11, dtr = 1 << 10;

Please don't use local variables for these -- define some
CR_whatever constants at the top of the file for the CR bits,
as we already do for eg LCR bits.

We already have some PL011_FLAG_* constants for FR bit values;
you can extend those to cover the new bits you want to set here.

> +
> +    if (!pl011_is_loopback(s)) {
> +        return fr;
> +    }
> +
> +    fr &= ~(ri | dcd | dsr | cts);
> +    fr |= (cr & out2) ?  ri : 0;   /* FR.RI  <= CR.Out2 */
> +    fr |= (cr & out1) ? dcd : 0;   /* FR.DCD <= CR.Out1 */
> +    fr |= (cr &  rts) ? cts : 0;   /* FR.CTS <= CR.RTS */
> +    fr |= (cr &  dtr) ? dsr : 0;   /* FR.DSR <= CR.DTR */
> +
> +    if (!update) {
> +        return fr;
> +    }
> +
> +    s->int_level &= ~(INT_DSR | INT_DCD | INT_CTS | INT_RI);
> +    s->int_level |= (fr & dsr) ? INT_DSR : 0;
> +    s->int_level |= (fr & dcd) ? INT_DCD : 0;
> +    s->int_level |= (fr & cts) ? INT_CTS : 0;
> +    s->int_level |= (fr &  ri) ? INT_RI  : 0;
> +    pl011_update(s);
> +
> +    return fr;
> +}

I think we should not call this function "pl011_cr_loopback()",
because it handles all cases, not merely the "loopback enabled"
case. It also seems to be doing double duty as both
"return the flags register value" and "handle a write to
the cr register" -- I think it wolud be clearer to separate
those two out.

> +
>  static bool pl011_is_fifo_enabled(PL011State *s)
>  {
>      return (s->lcr & LCR_FEN) != 0;
> @@ -172,7 +217,7 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
>          r = s->rsr;
>          break;
>      case 6: /* UARTFR */
> -        r = s->flags;
> +        r = pl011_cr_loopback(s, false);
>          break;
>      case 8: /* UARTILPR */
>          r = s->ilpr;
> @@ -267,6 +312,7 @@ static void pl011_write(void *opaque, hwaddr offset,
>           * qemu_chr_fe_write and background I/O callbacks */
>          qemu_chr_fe_write_all(&s->chr, &ch, 1);
>          s->int_level |= INT_TX;
> +        pl011_tx_loopback(s, ch);

This implementation will send the transmitted characters
to the QEMU chardev and also loop them back into the UART
when loopback is enabled. Similarly if we receive a character
from the real input we will put it into the FIFO still, so
the FIFO will get both looped-back and real input together.

I think we only have one other UART where loopback is implemented,
and that is hw/char/serial.c. In that device we make loopback not
send transmitted characters out when in loopback mode, because
the 16550 datasheet explicitly says that's how its loopback
mode works. The PL011 datasheet is unfortunately silent on
this question. Do you have a real hardware PL011 that you
can check to see whether when it is in loopback mode
transmitted data is also sent to the output port as well
as looped back? Similarly for input: we should check whether
the UART continues to accept real input or if the real input
is completely disconnected while in loopback mode.

>          pl011_update(s);
>          break;
>      case 1: /* UARTRSR/UARTECR */
> @@ -300,8 +346,9 @@ static void pl011_write(void *opaque, hwaddr offset,
>          pl011_set_read_trigger(s);
>          break;
>      case 12: /* UARTCR */
> -        /* ??? Need to implement the enable and loopback bits.  */
> +        /* ??? Need to implement the enable bit.  */
>          s->cr = value;
> +        pl011_cr_loopback(s, true);
>          break;
>      case 13: /* UARTIFS */
>          s->ifl = value;
> --

thanks
-- PMM

