Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5251CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlWs-00073w-EH; Sun, 17 May 2026 20:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlWk-00073K-FR
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:08:11 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlWh-0003fw-Aj
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:08:09 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67929ff6dbfso2856370a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779062885; cv=none;
 d=google.com; s=arc-20240605;
 b=c/UFPq6kwc7E+vxy51DZ1yiHDl9cCKnnW5t+d1wNDTxjqJfd+49ucybDasmhzTI1Ph
 0XKoBqFnnJDzdqNLhOuynf8cUdTXdsy9dygZPo/AY5Ka4rr9z3EXmF+YTmwR/Z3w/s6m
 7MSDO+Y/aNfdKZDkeMQAPMw92rgboEdH1tS8404pxzH+oAUsvcvUrU+wQuzu8HDyEPdg
 bpODvrPEQhNfXBwzEyhjroHe2dp5fPpmnD0eYDJgG00D6zh3nH1JJ07GFOBLGrzcHUkQ
 MoRJcrQ7eWE+bfrqIjS8sX+q8j+6KP42n2eaq8S56+z0k0H1V9wNnAJO8rgJ8gPY8yYE
 YS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SRh3W7NEPixp5eWlgij8j2O+YcuiGupzzGNGl7oMHjQ=;
 fh=xUPK3WmcXSXmYUNRz6cyBi7fUwKP4bpURxe/wNyWmQo=;
 b=CHhpuObDLHv37z5+uPpI8kkRdaiDmWg0g+PaTAFQhEgQSBgTPXZamGO9ad/TBFmght
 99OEVclTSREyYvOcWhnZX8LcZZrUdxDyIUUsFDLOuWQYi5BjDiDrS+dhxpJlkwQS7207
 dy1mjfVhevuwe2W4U+MHRuTJPFtkErLuiYcwykMh6uSDfdVAtlvJr7bLbwumm6GNHqAt
 I6s9x/OJGc8/9FxToeEit8ZsGnGEHD3cx7prQgojyStSiy8lb3eGDrE9LiKWhPXstB2t
 ngz+iZv294ocYB8zgGopnFHKDdElqkadIsKeZmZft0FOVLq6IhTMBgOtdFtZ4BHn0JVU
 o7og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779062885; x=1779667685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRh3W7NEPixp5eWlgij8j2O+YcuiGupzzGNGl7oMHjQ=;
 b=RZK8IloXvCGii1hzs7rTd+0Ftnoef6+GFJ0aBbevJji4y/ddK6HcLdd9DjqiykhHYi
 mMQ6RNgkhwF6Ke1itrIDn6Cir5oPvoL4kN0uKwS693M9N4MtTLKrnmrjnbQPzYRtzii+
 RvEDIeb97Rxpl5QxCr5rBbUXuj2FTZdg+qtuCn5fpG+kKz5IRW7C2iZ1irjNb8E7HpXW
 UcdzDuRI4lU7UGLYrXP6u4+YUiun46fO9VSO7jQyX96yKW8zztM/unRQMppzGlQFXEMz
 Ew+LQfwmAHOcrf9PvVlzgQ8+UFQhpHGObKc6mz39EIFEDE/IiGwrrshUrxljz6Hc9NFu
 QW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062885; x=1779667685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRh3W7NEPixp5eWlgij8j2O+YcuiGupzzGNGl7oMHjQ=;
 b=Ord34NutaeiEy+9hMepVysrlEnjaptzTtFFcTeRtpSYvA/GH1wPhasL8ye2Rstc3Kf
 3a4LcAQHu480dIqbFYv1kR6yVYwmaXxfZF40UOuKOk5mTbUBTI25O3uPsxSS1AiWogtZ
 z3O0RP+XBQwdKML8eP/bahWg2iM0IXqJ62FfUKjNdh9nb1LiUv8DzbCwaiaNy1Whh4fK
 SwXGfKPObN7btP3lk6V529Rwek5cTenMdbjgGLiAL+4dTi4WyWXsln1JLJVGJaUiLcWM
 nKWZxOt0D+dvb1dRpTmwann/kBQLx1NhLzX/WVDDch2Kpaamdp/eR3FD4Vo8kTXX4PVt
 4Hvw==
X-Gm-Message-State: AOJu0Yw6wBFun7zQ0JvfWi7JKtU7qJgG0p/wzaLT2cb3A39VMsUjaboj
 Dr8Zk8k+xuCQdcPjcZg83jcwWtsROrOkFgJ0tjAUMkX9OGd8FE6lpQJ+U0qq/G3h/TuzpnJMsrm
 Q5t5BiME3qlbmZom0Audd/ay71xCahZw=
X-Gm-Gg: Acq92OFFfiAn6pw/VaIgVzCfcPWyUPE8DVojFMvWgKAAnxlNR6sbuubE4jJ6Fb6/PFG
 S0//ZkBbwc8i837N9rfQAbExJAmXNnVk9nrxOWMIpVIxzxIacbOHjwpHS9NwSksf2y7u3Tb3xDW
 Vu+IMEOk+DJQdNH8yTSUcmAaT9jJijs3ijq/bX8Ua8d4TttZtd4z2Tneokw8nRBmvgxfNmBnadj
 HDtpaYpfThqu1mFz0K+q8/uX2GMSt0MffeWXOSYWmCG2uVOjbHUVgL9zIhKUiJxAczI7iM3MkSl
 a+QpDSnwBRZ3VBwJihrIxOGtANgJVg7JJvuFbTjxrM7YsvVi
X-Received: by 2002:a17:907:3cc7:b0:bd5:18e8:1ad8 with SMTP id
 a640c23a62f3a-bd518e82334mr611399366b.4.1779062884946; Sun, 17 May 2026
 17:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260513030503.3665414-1-frank.chang@sifive.com>
In-Reply-To: <20260513030503.3665414-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:07:38 +1000
X-Gm-Features: AVHnY4LohafFGImQCUEU5jTY9_g9E0d89XNMN7fK9czZLtE11AA6UgXiBB44iI4
Message-ID: <CAKmqyKPs9kd_4=6kW25suJcPPCy9kFUM9CkgMOjNAJezfY2NWg@mail.gmail.com>
Subject: Re: [PATCH] hw/char: Check interrupt after txctrl register is written
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, May 13, 2026 at 1:06=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> It's possible that the transmit watermark level (txctrl.txcnt) is
> updated when the user writes to txctrl register, which may decrease the
> transmit watermark level to less than the number of entries in the
> transmit FIFO. In such a case, the interrupt should be raised so we need =
to
> call sifive_uart_update_irq() to check and update interrupt when txctrl
> register is written. Otherwise, the interrupt will have to be delayed
> until next TX FIFO transmission is processed.
>
> Suggested-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/char/sifive_uart.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index b4de662d616..b9bbaaef595 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -213,6 +213,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
>          if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo))=
 {
>              sifive_uart_trigger_tx_fifo(s);
>          }
> +        sifive_uart_update_irq(s);
>          return;
>      case SIFIVE_UART_RXCTRL:
>          s->rxctrl =3D val64;
> --
> 2.43.0
>
>

