Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD92CD37B2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLRwQ-0008CX-2f; Fri, 08 May 2026 16:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRwO-0008C9-12
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:36:56 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRwL-0000fP-Pn
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:36:55 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so1058155fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778272612; x=1778877412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lQtn/aKs3Mms5VyCylqMqnNtvxHkJf/I4O7HNVOFCoA=;
 b=qZOe4CNcoWGXXx1l1NVlv+kO/+L8zATo6pdJMU+NddqA5rt5jn7FTbfOkRNdgAziqO
 tHW1+wETfpZgu5bim+G3o5BCKvREN0wwUDyyhChdxOoHl+eMdAQG2iQh2vPRZVbpITT9
 7S2G8wttZ84Netgf+KWplM3u5RQeAU/3e+G/xMKpoWUsSsmvBV67eDavoPgJ1gZ8och6
 tdWjxe3t5F88oIuksD/ZB57GfghBsEEj23M/BX6uIhlF4WRZdVne6szLtN3Wyl07LCZB
 OHZh0fK3I6VQrMzO5P8RY63PZRR8QfL8GE2k0UgZJgqBz66wwNAzHrxJuQanjoCxc3CX
 QOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272612; x=1778877412;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQtn/aKs3Mms5VyCylqMqnNtvxHkJf/I4O7HNVOFCoA=;
 b=P6oqM7FDt/4zNDtTcZD3kr2XK5fBU9S0o4+Pm2uucxYjkt5jJwMx36s6N6HvVc4mtX
 DXk5MdRo0W/QO4VEvoX2SOGLOGG77NrBV94Zwgs/qAwjMglf826Sm6mCj5ZNeSHd9xad
 LDkXNv0rAmvcGwRsIkRP1zjU+uqGr0E7uxo4ktQ5/bcycfhEMnyl215un3dt6WvRuL1+
 5YyZUAfeDG1KnGdwPAhd68KdzQhTcTSbSb+sDoy/SUGG6uAF5X+T4NYn2hSiqqnT0UEP
 IC5MMvUcd0CCYGUZWv/VLgZsaHs2+DCbdsuUquCv5cgU0j5EZyT01NtKKUkS9fPm8hgv
 bIzQ==
X-Gm-Message-State: AOJu0YytTLYXD17954A52ixbIx1rjTzLZf+njndGX24JV1yGH1wDKDse
 /VhMa2e+pn3jvL6QQw86tHf4VAJZwW9bDWZlu5Z2T2Zszwv1hBamHJ45MTnlKY81jpYVOLXyW1s
 sRxBe
X-Gm-Gg: AeBDietXzyWh5O0+d+AZCjxEZx/5sNOJwwagayxQFt+Sw/dTlH83rxeXUFEOVEHPQeA
 8dRIsbX/s9LNrpL9HCU4k13kL6tiWSxnpR2Pwf210PQEgJzF2eWMpddryHPVlpvK14j6Gm8vA+E
 X1orOKPbt7ZRcpcKemlwk1SDTTx6jgR5lhv+4pqdhUufrH9Sqrr/4J4QUGEuQH7576hI6rtvh5L
 cNQ/Mi7Jk8jDhdFMw5bqzjhd3mnnRF4l4kcr0w+vAfwdb4FXFKCVfkkrSeD3ST/sGRrlbJpLYYA
 WRA/XU6RImY6GTR06S/Ltht00QR3doN8SqBGmWDVcz58/xwDrjTPuc1vBVmwxZuK8KCrcvU7ijX
 5ZsgIBF+fMp6jicqNBIpQuQ7DuZtZFOz7N3kOqhrWoA4M8y/qSacx2BXgAEpvr0hyv1kG7jj7eF
 ZMpleH2PE+b+gFlvyC0SXsqA4w/ojXsdTayKPpHeGzudUfIAwFKFLpXPLcusr7lgOr7LEZ529gP
 h02rb9ZwWsVUmKLzA==
X-Received: by 2002:a05:6820:883:b0:696:29bf:894e with SMTP id
 006d021491bc7-69998d4893emr8100233eaf.45.1778272612009; 
 Fri, 08 May 2026 13:36:52 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c1a58asm1721190eaf.1.2026.05.08.13.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:36:51 -0700 (PDT)
Message-ID: <2f736c44-47dd-4573-b3c0-1bf5d9de475b@linaro.org>
Date: Fri, 8 May 2026 15:36:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/misc/bcm2835_control.c: Don't assert on local
 timer zero reload value
To: qemu-devel@nongnu.org
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
 <20260508162013.2751001-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508162013.2751001-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 5/8/26 11:20, Peter Maydell wrote:
> The bcm2836 local timer has a basic "counts down, fires at zero,
> and reloads to programmed value to count down again" functionality,
> as documented in
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf
> 
> The documentation is very sparse and doesn't say what actually
> happens if the guest programs the reload value to zero.  Currently we
> trip an assert in this case.
> 
> Instead, log this as a guest error and disable the timer (which seems
> a reasonable guess -- effectively the timer will stop counting).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3395
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/bcm2836_control.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

The alternate interpretation is that the timer continually raises interrupts, in which 
case logging a guest error would be doubly appropriate.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
> index f1deafaf7a..d6c6057cd2 100644
> --- a/hw/intc/bcm2836_control.c
> +++ b/hw/intc/bcm2836_control.c
> @@ -197,12 +197,21 @@ static void bcm2836_control_local_timer_set_next(void *opaque)
>   {
>       BCM2836ControlState *s = opaque;
>       uint64_t next_event;
> +    uint64_t reload_value = LOCALTIMER_VALUE(s->local_timer_control);
>   
> -    assert(LOCALTIMER_VALUE(s->local_timer_control) > 0);
> +    if (reload_value == 0) {
> +        /*
> +         * Spec doesn't say what happens in this case; treat as a
> +         * guest error and stop the timer running.
> +         */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: local timer reload value is 0\n",
> +                      __func__);
> +        timer_del(&s->timer);
> +        return;
> +    }
>   
>       next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -        muldiv64(LOCALTIMER_VALUE(s->local_timer_control),
> -            NANOSECONDS_PER_SECOND, LOCALTIMER_FREQ);
> +        muldiv64(reload_value, NANOSECONDS_PER_SECOND, LOCALTIMER_FREQ);
>       timer_mod(&s->timer, next_event);
>   }
>   


