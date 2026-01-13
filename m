Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A2DD2D10E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffI1-00072K-0N; Tue, 13 Jan 2026 09:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vffHy-000718-Ko
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:22:30 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vffHx-000549-23
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:22:30 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6467c5acb7dso7242787d50.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 06:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768314145; x=1768918945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jX/g6IK0D7xz2jiAxhGaAuWhBdvtQpzR0olmMjI60I0=;
 b=r4+k4Dsd11JLGipRGt36DG25fNw1wJMlY7nb/eQ8J4XBzVTmDJEIxOrzF4agSoFRMO
 5fTfl9leV2kNJvth2b+7EnGcOYloawdGu6VSG+/MI9eaSC3rzjh6nlTdByHip5GE8/KP
 49R1OUDssNIvNkZVSPJJ6SnjL6hVOi5LKjeY9ZaDGJN4WoLorpUNMVGTnuf7/6BzFhWO
 y5/DYBEPHc19CbcT6C6F70Boc+EY/jLj1JnLpLzfz6LnRy9lOJTEv4YHpPkukgYkGWcV
 xKOY3rBwrGIOqHsSYgx9kTa+BxAa4ethU0rJlSgNYvSXA7Ru8U+qGMxpDurWfp/lYRo2
 jpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768314145; x=1768918945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jX/g6IK0D7xz2jiAxhGaAuWhBdvtQpzR0olmMjI60I0=;
 b=CK+wcpTgIvmnjN4+3V/Ru+luvdiESM3ykVIrnGPWEfNtVO+Nr28MLIOzroJu6eCSdC
 D3FaO01A87UreZ3J6+5DOqHMOsgAZEms1tm2SjPe+ofnxjD+WLne7Y1+ztWpxhccK5n8
 JpoHq0dIdwRbc1SB6tQfKT5MZvm19X3CcN/yEQFFezMteZEn1nDTdD0WTB8rRjDRy+xq
 1jF21U9lelnm3WfQ3WYaDTzQgDAxrHzi47gfM/HcGU8/q3eoM9l/JFAoZ0QlJ5Xxc72e
 Dm0zHkv2o6Emcm8ycr9CVpuqVcQlf1TGSr6+KC7Nnnz0vBfaN6v9+pc19sgWVjnW/Lp5
 GfWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSPb2dlU01ZJ43X1VBGwOsVrdB4InXNBU28Y9NK077oOU2ifLl7ITsWE7kIC+sxNjQ6W+gxK5hyW5b@nongnu.org
X-Gm-Message-State: AOJu0YxAHytmJ8ySUvMwfMeZtPbcjtUUK5NTXr1ekqUtVhwv1Q4dsfdC
 awg00S92+gOz6uRx4SwtXH55a1UwWpqMMORIoTDyWxzsHrrIGzEPyKU3qGQTjSTB9lRrOkuyAeW
 v0NwwNeWlzfA1wikedMCtGje/V8SvBQo79AP4ZxTJiQ==
X-Gm-Gg: AY/fxX4NlnEV8xA1nS1jQ7rmlFRtj7pII51RbmuY62qd81d/n+VMwK7y6vSEhAOMsvD
 ldpH4v3i49hCo8uUqwdKiUZa8ZrB6w6tzVQrEsmx3ZWIuaGZv11Y+/Rx2MU37DlVZmqDPm8o5zn
 6vZwy7vinv94OOevn4zBZ8jf91x/opNYes8g4/QMh30kgm7k+kuhw1k7w1EU5xOzbQ0ftYM5av1
 1BvWNVyVY7dHLCbdUxQ7g5tCjlh1+MdmA2lkw4dF8mv0FMcmf2g8wA2ogJu7lPSRgqCqJDTd/Fu
 quzb0GYMSi/e9WqjLyQftJw=
X-Google-Smtp-Source: AGHT+IEhYLOyIAm5ZjH4d3M1fspheHXuPTHyJakRJuGrzyCEJ7q0h1PsAN3X8jQxlboCJ1Zt1MgXK1e31juuNDAJM+Q=
X-Received: by 2002:a05:690e:1305:b0:645:5bfc:8be4 with SMTP id
 956f58d0204a3-64716c75018mr17820044d50.66.1768314145343; Tue, 13 Jan 2026
 06:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20260106062145.151760-1-ruanjinjie@huawei.com>
In-Reply-To: <20260106062145.151760-1-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 14:22:13 +0000
X-Gm-Features: AZwV_Qgx5oFioZ9G0d1vSQtUGiY8_4AN72nVJvzI7loBopmDgQnzICkqTWhZmSw
Message-ID: <CAFEAcA-gztPHR=Pe743n-tCYuBK4KuXx5JsEdR4vqL33Kb50kg@mail.gmail.com>
Subject: Re: [PATCH] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 6 Jan 2026 at 06:22, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
> "NANOSECONDS_PER_SECOND" may overflow the uint64_t type.
>
> Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
> because get_guest_rtc_ns() is used either take the remainder of
> NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.
>
> Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/rtc/mc146818rtc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 8631386b9f..78bdfab8bd 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -79,10 +79,7 @@ static inline bool rtc_running(MC146818RtcState *s)
>
>  static uint64_t get_guest_rtc_ns(MC146818RtcState *s)
>  {
> -    uint64_t guest_clock = qemu_clock_get_ns(rtc_clock);
> -
> -    return s->base_rtc * NANOSECONDS_PER_SECOND +
> -        guest_clock - s->last_update + s->offset;
> +    return qemu_clock_get_ns(rtc_clock) - s->last_update + s->offset;
>  }

This is all logically correct and avoids the overflow, but I
do wonder if this is setting us up for future bugs, because
now the function get_guest_rtc_ns() doesn't actually return
you the guest RTC value in nanoseconds...

I think at minimum it would be useful to have a comment noting
that this doesn't include the base_rtc seconds value and the
caller needs to handle that themselves.

(Maybe there's a neater function/set of functions that would
abstract things more obviously, but I can't think of one
right now.)

thanks
-- PMM

