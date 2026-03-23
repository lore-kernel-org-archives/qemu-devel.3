Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62159EC01DC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dhO-0004Cz-CL; Mon, 23 Mar 2026 07:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dhN-0004Ci-GC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:43:57 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dhL-0001FT-Tv
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:43:57 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79ab0e9c6a9so7109637b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774266234; cv=none;
 d=google.com; s=arc-20240605;
 b=EDitDk3UfNwUZGbaYVa+T6qj9+eEv5A5JWusjycQkepyLj36zvsTaIwrdVJvJSs5zG
 7ju0No5RkmBqBIth9Qq0KB84r74oDDCqzT2slhmX8qPT1dwxwLI89e5x09evtB93A39G
 N1JAl+zQ8NSSavCy1W1ofyg0LeDItSg813RK8U9V7NHmOo/G2HXu7B8AVt50ULM62Sym
 4VOya0Q5AgeDi5B+oZKyQxasM3+1heN913SJnUrwCA34xPW43OCvwc5Pp75y5pitZmZg
 5bGRqEKtDWvLGZnhKVAS7maX3r/Dzphjfsdmo5DxaDrGlsK2K7Qx25bMqfvTberc8i5G
 eh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SNMcaEOH+SNnRbIYCSj4mp9uQnJ7AvR5jOnbX1A1R9E=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=WNUzPvVmchwpo0o/lCjCJydHMXA0PnPYxM1+lxRyUvFwrNfeCRODW0vi4yvgqiKJ76
 1Ed/1t8JXZef8H8y3c3rnCAmeklgFY2K3L+9vDQzDUTkgHvNIQ9GytBGs84k6iJAbc1a
 U0/g8zokDmOfB4Z4YqYtZWY9sAYc14V/T3+cEdv4YOji1vGDUBzHwH+RkidRjsYizTtq
 cahGlLJIEtdm2ulu2PnlB2OgEZKpXhGQ1zWcCBZLOfHw0MgwOHCmwtIpD82ICvgygRnv
 HZ6R9ZmoXhQRJaQ6Zl89UrLQTl0zKHk5EWVsEEiSyCwgo9A5QCBkyHBm1nA1Uk/zCi6z
 CWZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774266234; x=1774871034; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SNMcaEOH+SNnRbIYCSj4mp9uQnJ7AvR5jOnbX1A1R9E=;
 b=zlg5GA22zmCd/dQX+RkHbR1IWwPDJJvFnublUE+6h403Ha6yrLbaeNVGxjNfO1cPhS
 1mFpUSN7JbFqbZAvXcSljLGZcgHwxw8bZPfI2cMyIiOy7/OmW0BDU3KjyGHtoUv+ZAhV
 QrHoEOgHhqMNKw+WsZ5ElQAEpYUZrcnUJG1C2f9j1CLLEH533LjOcMCBadA/Hp7Jhv2X
 WFn7ROoJyl5Kp6lPgtwoT1fFQ5h8aoQ6vxZnXlvlZYpzCsRW/GoD/e9nP4WxyZvczmPV
 +Ymxvy5NQ/DBkMm2UHOmIh8q6jl5gveakdP7dcbS68yKEUMkdiJm6hQjud12CZZRavG7
 Hgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774266234; x=1774871034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNMcaEOH+SNnRbIYCSj4mp9uQnJ7AvR5jOnbX1A1R9E=;
 b=mSUJtv1AhHtmpvfLeL12JcCnQ38uAtLVKHKkgoznpjpl24sJgMcSewL5e2eUP587tt
 sCV/DK841Q541BuTC4RnOS7byqqjOj/EC/fovNqTnlOnMsTfQQxX44LuCU+mBp1vEwvf
 +z1CUXymSJctfQOV+pNRIKnGAX5D0U5eLlukK2Vxg3YyNi7cMaz6EbUHu6XRxRVc+jrA
 bGPE5odidOd4AkDgxzF/FBbr8hDVJTkELzcDdy2++hVdJhJr4+RvQZVKNjBUOr1ILztE
 M8IGN4dapVhLqyaZiDa+IBzjnXs4Xff8ITJdTMQhsOPKy3wtD3ee2v0uLs3TfEhuhoyD
 M6Uw==
X-Gm-Message-State: AOJu0YwWlmg5PUytlHj+bWsJyrxyTUEW4GlnJIItrtWkT9dFXsLy7pC/
 xNKsiagxfTIt1qTdbMcbQQt5FU8EJvmJO/9HChZ4PhkFC9bpLnwrowu4Mq8ImOKGLHgdCEuxRhk
 D1vdGPo0LPQUNSCdclLl8cXDAZFmqHqi+I7+MJ2b/3A==
X-Gm-Gg: ATEYQzx/z06ORi6RB8mrgtpzb2631noAcfe+WSOHzocWuLK5a9LA23wb9QCnd3HK/yZ
 9S3ZS+BUThi1veUzvUReN00Ofti41Q2iUURE9b2O4DnZVeWBatFERIEsY87iSLyd4gjR4nkEsjt
 EVnvEDPEpQ6CpSaETFejtl4DYtYOKOzs88Lrzi0opzOLxh7njm4MtAcZLXCWIuqtn1K+uUUg+2N
 bw1VGHpLkloJeLiIvU7SsGdBBYUoLN0enYAGRkC0wKQPfdksbCaiP4MSYMCe5dS0lpgc2xWXJBA
 jx0JgrFEx568MvKovCjXO0cEX+oSppzmUT+kp7mqrnsr9m1296+HFMSrpNaF1kwCmbuVZurLjU3
 Bdw==
X-Received: by 2002:a05:690c:82:b0:798:da7a:1ef0 with SMTP id
 00721157ae682-79a90b7ba82mr123984397b3.29.1774266234364; Mon, 23 Mar 2026
 04:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774099044.git.dingtao0430@163.com>
 <53bae159845bae966f620b42e7873b7f24404284.1774099044.git.dingtao0430@163.com>
In-Reply-To: <53bae159845bae966f620b42e7873b7f24404284.1774099044.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 11:43:43 +0000
X-Gm-Features: AaiRm50XOeVJ7iowjOG63kaaqJtqJsVgWS_yMBGBXvHA1ywP0PnfwzT36HH0rdE
Message-ID: <CAFEAcA8FpEWCKQK5_jDQ0MjvGqHC-vmYT37WxyxhLMhUBxqg7A@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] Fixed the PL011 FIFO level bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sat, 21 Mar 2026 at 15:47, Tao Ding <dingtao0430@163.com> wrote:
>
> According to TRM, PL011 generate a burst or a single DMA request based on the FIFO level
>
> The FlowCntrl field description is as follows:
>      Receive interrupt FIFO level select.
>      b000 = Receive FIFO becomes >= 1/8 full
>      b001 = Receive FIFO becomes >= 1/4 full
>      b010 = Receive FIFO becomes >= 1/2 full
>      b011 = Receive FIFO becomes >= 3/4 full
>      b100 = Receive FIFO becomes >= 7/8 full
>      b101-b111 = reserved
>
> Only the read_trigger of rx has been changed, and there is no need to set a trigger for tx
> because write tx data always completes in a blocking manner. That means tx FIFO is empty.
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
>  hw/char/pl011.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index cb12c3e224..c96a706da1 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -129,6 +129,14 @@ static const uint32_t irqmask[] = {
>      INT_E,
>  };
>
> +static const uint32_t fifo_level[] = {
> +    PL011_FIFO_DEPTH / 8,
> +    PL011_FIFO_DEPTH / 4,
> +    PL011_FIFO_DEPTH / 2,
> +    PL011_FIFO_DEPTH * 3 / 4,
> +    PL011_FIFO_DEPTH * 7 / 8,
> +};
> +
>  static void pl011_update(PL011State *s)
>  {
>      uint32_t flags;
> @@ -344,17 +352,24 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
>      return r;
>  }
>
> +static uint32_t pl011_decode_fifo_level(uint32_t val)
> +{
> +    if (val > 4) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "pl011: invalid fifo level field\n");
> +        return 1;
> +    }
> +    return fifo_level[val];
> +}
> +
>  static void pl011_set_read_trigger(PL011State *s)
>  {
> -#if 0
>      /* The docs say the RX interrupt is triggered when the FIFO exceeds
>         the threshold.  However linux only reads the FIFO in response to an
>         interrupt.  Triggering the interrupt when the FIFO is non-empty seems
>         to make things work.  */
>      if (s->lcr & LCR_FEN)
> -        s->read_trigger = (s->ifl >> 1) & 0x1c;
> +        s->read_trigger = pl011_decode_fifo_level(extract32(s->ifl, 3, 3));
>      else
> -#endif
>          s->read_trigger = 1;
>  }

I'm always a bit nervous about this kind of change, where we have had
something in the device for decades which was obviously working around
some kind of problem with a really common guest. The #if 0-d out code
gets the wrong answer for RXIFLSEL == 0b100, but otherwise it is the
same behaviour as the code you're putting in here. So I worry that
maybe this re-introduces the problem that the comment is describing.

thanks
-- PMM

