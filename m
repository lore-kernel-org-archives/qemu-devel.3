Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189CFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOG9h-0006ek-Ek; Mon, 01 Jul 2024 08:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOG9f-0006dq-NN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:29:11 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOG9b-0004y1-IY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:29:10 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5854ac8168fso205992a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719836946; x=1720441746; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MzDh3WELYAqnPjOgFol2sHjG+aIvVmLDwXGfVlwOuAI=;
 b=JkkVm9YxO0ppwvwAQrki3s6u0v6yZJyVqS4mRMFEShBp9TRjmqgS2vdAU46L+ks0AE
 QMDtRrotolEb4OO3E/AGK+30fKflxlkyYhRKdfXB1SVQ/5JtDg0+T01AIST8bnBGv/6N
 9qMJ4QD9P95hbFGthEkWpIR48gVABrlRhNvFdw0PzmmrO0qap/5+QFXMtjT0XpoMSrl6
 68EeSaFSDK+K1/J79doPKZ/vaPKJMdgQwbuDdlfSuxKgTT6qj/htEh2NwjjlwRyb7roZ
 6952lijMCofmPOEI19/nWRLVQ7tuj+TjvzX9nZXq8D8rI3lAjusHmjwvPn6uRVkPMLt1
 mOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719836946; x=1720441746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MzDh3WELYAqnPjOgFol2sHjG+aIvVmLDwXGfVlwOuAI=;
 b=SgplKWpaS0jYvLgoyOkdtfGxQahMa6MSJlBF2BmzIZZZPn2W2re6t2TTjGKxp6vah3
 TZDF9UGpdwKTWoqGO4/KkibfW3u9tUAokRckMRv/4l3BF7/XUBKKuGzVILtETDzB2lCA
 90b63Dp0OeOt5UpDJvtRA9uo2E2D1RFlStH6giepdzkPFIm5LC33CrN+dj9HG+5W2OyA
 bpYrViNQUBQ6PMwOoMoP86xV81AaJdQAzPqOt0effe2YCjvC/vMUObfwY6Hvv+YqWXME
 wCEEr9LLoGVQff6886U7+WP6hT+GfPru5YalfpKfYfVEgdfI3iFiLkdsfzXDBJYCVkRo
 TzUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXacSEPNAqSDXzeUVZ5A5LGfvROxQRkcXaCyA9dtVGRwdClPulZ/rAp9Uwik2kPHeF5+QvRtnAdWV8AjJxvGSyd9qnukiw=
X-Gm-Message-State: AOJu0Yxq3cHl489iPhZcOtVhfMw0jcOaT7IGj9mwyu5IW29zDt+g38+K
 TpXRZAX1pc53ALrP7qV4bp8GpC4xGFOtt01SwvQPluT1MynZWmMTTLahMKJ/npqk8kOHRms8I6y
 GYfUQPkUJzFPDn7k7C6mROh6bCxn/4Hk2EKxNHg==
X-Google-Smtp-Source: AGHT+IF/dnVnzUIrVGb88AliCqTv7eMCVSRiKn3Fbgsc/mS5JWNUZi36LPr2jVPUSwMZojBF9inu/4BCbGvFn+t6D/c=
X-Received: by 2002:aa7:cd78:0:b0:57d:10d2:23ef with SMTP id
 4fb4d7f45d1cf-587a0fdc8c9mr2855001a12.42.1719836945796; Mon, 01 Jul 2024
 05:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240630165947.2975457-1-zheyuma97@gmail.com>
In-Reply-To: <20240630165947.2975457-1-zheyuma97@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 13:28:54 +0100
Message-ID: <CAFEAcA8Osq0g2=0LriqA4P6V6TYK5dQTVumxakBRYkJjMyB9Vw@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: ensure UARTIBRD register is 16-bit
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sun, 30 Jun 2024 at 18:00, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> The PL011 TRM says that "The 16-bit integer is written to the Integer Baud Rate
> Register, UARTIBRD". Updated the handling of the UARTIBRD register to ensure
> only 16-bit values are written to it.

Thanks for this patch.

I think we could improve the patch commit message:
Have the subject state the problem we're fixing rather than
the solution:
 hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()

and then have the commit message say why this happens
and why we make the change we do:

 In pl011_get_baudrate(), when we calculate the baudrate
 we can accidentally divide by zero. This happens because
 although (as the specification requires) we treat UARTIBRD = 0
 as invalid, we aren't correctly limiting UARTIBRD and UARTFBRD
 values to the 16-bit and 5-bit ranges the hardware allows,
 and so some non-zero values of UARTIBRD can result in
 a zero divisor.

 Enforce the correct register field widths on guest writes
 and on inbound migration to avoid the division by zero.

(I mention here a few things which I'm about to comment on below.)

> ASAN log:
> ==2973125==ERROR: AddressSanitizer: FPE on unknown address 0x55f72629b348 (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
>     #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
>     #1 0x55f726298d94 in pl011_trace_baudrate_change hw/char/pl011.c:260:33
>     #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9
>
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine realview-pb-a8 -qtest stdio
> writeq 0x1000b024 0xf8000000
> EOF
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/char/pl011.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 8753b84a84..f962786e2a 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -374,7 +374,7 @@ static void pl011_write(void *opaque, hwaddr offset,
>          s->ilpr = value;
>          break;
>      case 9: /* UARTIBRD */
> -        s->ibrd = value;
> +        s->ibrd = value & 0xFFFF;

This is necessary but not sufficient:
 * we also need to mask the write to s->fbrd (which is 6 bits);
   otherwise you can arrange a combination of s->ibrd
   and s->fbrd such that the addition in the divisor
   exactly overflows to 0
 * we should mask these also in pl011_post_load(), to prevent
   the division-by-zero in the "malicious inbound migration
   state" case.

Also, this source file (like most in QEMU) uses lower case
in hex numbers, i.e. 0xffff .

>          pl011_trace_baudrate_change(s);
>          break;
>      case 10: /* UARTFBRD */
> --
> 2.34.1

thanks
-- PMM

