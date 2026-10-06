Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8DBCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMKi-0005wt-Kx; Wed, 07 Oct 2026 03:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEGKr-0002eK-Aw
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:20:56 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEGKj-0005Wf-VF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:20:43 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-93e6eb77f0bso240026685a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791335929; cv=none;
 d=google.com; s=arc-20260327;
 b=nXJOzKQuz3K8UPj163Af4cG1dlEnaGfxGZFOqB32VmO8GRgVjX64mUEv8QICorn/T8
 6mTQyYsbkXTS9nJQULu4qojpI4oHv0wg4wo6/bfdlLQl+sGrE0jlOerMlzVkD8dx/jdZ
 LvA0R0OotwcpEu4qBZWsxA8Dky+gYc6vZ400BNeoT2RFejHST0g6Vm+LVXX+RlIhoP5P
 BqFOsR6oiHatHAbsUORBjUgdVETXo8un34iGHLm6BR8ft3cJxmZi2HK6d3thK0qfDKG1
 eqdjeqLjemGXMgiFIATQKnUkD1lIavzeHVWeZYVdymYXPdCUvrboVYZSl/RcFmged07x
 JzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cbBZNg2GP4q9neO4plNWzlnxGVqdJX3YeTw3+TuKgZw=;
 fh=yezQdXMrdWVAkuoITllCrNKDtPeRvDbT088ugBj5u5I=;
 b=auZhoDTi0ZHav3toOL30yh6p95auJqr+ayvVnuC1LTVOAphXpF0an1ykAizaMGnGFt
 O8v74nTlUSR9rjMRAKOxmWSrZqW94JTQU2And5h72hrNH32U+MvFXf0cERlhhFbJb7x2
 /qwlMTIvSD80ulAy1vXLpjVdKBUrJ7l+f2LqU0drvhS1jMp1YLTTlaA4oS/ny+nHfQmi
 HWxe4xbzjEHM/iD9izZvYB+uhfK7hLeBjjSCZw3YvfIYhGnKm5VG8pk+dwx1c+kQpkEa
 gBloSFR4b8oCrGlWXN9hpH8OudPhjpDwgqa+FIPBuqtTtlCN2HK3qan6jfgAHqxO8/+J
 BjRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791335929; x=1791940729; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cbBZNg2GP4q9neO4plNWzlnxGVqdJX3YeTw3+TuKgZw=;
 b=adtgEGlB54mnLgaN6ryxnNOclKPFrdoCAIfqJn2w3xeD8jrX17LBz28kXoOXQnPJVp
 PnOXc1m8hCmi4LnAjjV3CVQBYEdWeDkA0umVFczA0wqr3URBD6+TI8Hpib2zF0Y7gCdR
 VS1vYfpH5whlxcp3bGLDYxduM1C8PXY6XK8eycKkuOxtaTqvs9h4LTVsIH9NW3Px1xLC
 Y1oPIatiN22dw7nSnEtI3ZL7s7rvnkiEheQ4nmQD71Xda8kBjawy3xsDFvaZDAV33Uz1
 L+0YZ1d83vKLzM7xrOTMmzKpB8wQayJPuuSBjMzCPCC+BxR7t9UugdpoSFDQCg+Vdtkg
 oCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791335929; x=1791940729;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cbBZNg2GP4q9neO4plNWzlnxGVqdJX3YeTw3+TuKgZw=;
 b=2gHvKpooOWGbCVNbsLKKuNjdJiAFcB5VjXoEKCTqz8y1Rya4HnZMYQNuLdDfkKfNH4
 9KNpYLSC4RF3Obf0aDtKljthXtWuvyLY5Ug0Z4sCoeEyiNBPIU7GCGxgi29F80RkhtGv
 DJLjp64zgZCiH5oXdfZnstFet3IZYM3Bgh3AMlPBm0H5EFnZuFreBCvP2wkyOfQ7klhm
 Xrtcb6eve0RBXQHyo8+0QMy2ecyjzS41NyQwIRweDuaiQ2MdncFSjcPDv7rTUcjeASf9
 Za1aPZlQbV6/4j+ywEpL7h15/ZUYo+skaJpWdfoL1lkHUcMIYqzAkV5yjc0IzhYmT+W2
 mfuQ==
X-Gm-Message-State: AFuF++nYQS4eQh2kTSZnC6S1ZA2fB9PDNG4I3u4yUAXj0bdUSBKyWVKD
 gai5yLfHysl6PpwvVrGwH8pf3peBnUuiSmWSovFtI7eEhjvfD3eMlhNIWOUJlARrRcVJWBW1TiZ
 UU2cnJ4GAoIjqYVTp9M+CoyoHvxlprb+TUgsw+zJiS6p0BrvQWUhcYAPSDg==
X-Gm-Gg: AYBFou3x1FPL1PUaVuTEkhZjjgo+TIb0H4p2Tb0YgDy4kZ9SReBEDYWo44PMzJqc+Hi
 XK5IgEXd3lxC5TLlIGo/R035wkAxRv8vHc6DvTnR6ajImBZtnTc2o0TpHQV1EkILZ9OngDb8PSm
 cRp9MikPU2A7BxC9VlCrqosIqR3e1U3Ft7ikXIXiXKaFTDEReL/YxYqs/rYTdsQbATT0eR/IenY
 +b3uriOIKyxQVFZiwNda1bRvQ9q7PBexTp8Y7+bKL6eOdaSqg2XbneIT+tmesIv2FBMGHHDJExk
 A43MG7s1kJRWSP6DhaYAVn/1fllAqEXfJZEEpEyzbiqjrf1M+5Zrw6OD3auJpuQXWRGM2Fj00Mi
 X5Qv6FVuvOZvm3RZXgMSwyXyAkdrwmm87U/V8+4I=
X-Received: by 2002:a05:690c:386:b0:8ab:ce6d:e046 with SMTP id
 00721157ae682-8ae95b2f18dmr34920777b3.88.1791291397808; Tue, 06 Oct 2026
 05:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260923214453.45335-1-manuele.conti@archimede-energia.com>
 <20260923214453.45335-2-manuele.conti@archimede-energia.com>
In-Reply-To: <20260923214453.45335-2-manuele.conti@archimede-energia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 13:56:26 +0100
X-Gm-Features: AclHuK-lM07BRf8WhSt3IXmoHd7r1aG2gu7ZtAKD5glKuDhrN6vAk1DWFIfGka4
Message-ID: <CAFEAcA99CSS6RQosZTOuaqeFZ7M0AX_LBduCF0HcHJZLjjfP1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/timer/stm32f2xx_timer: fix periodic mode, CNT wrap
 and CEN handling
To: Manuele Conti <manuele.conti@archimede-energia.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=peter.maydell@linaro.org; helo=mail-qk1-x732.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 23 Sept 2026 at 22:56, Manuele Conti
<manuele.conti@archimede-energia.com> wrote:
>
> RM0090 counters count from 0 to ARR inclusive, with period ARR + 1
> for all ARR values including ARR == 0. Fix set_alarm to wrap CNT,
> arm an absolute expiry and delete the QEMU timer when CEN is cleared.
>
> Freeze CNT while CEN == 0 in stopped_cnt so a TIM_CNT write
> programmed while stopped is preserved and resumed on enable, and
> reset deletes any pending timer event.
>
> VMState goes to version 2 to serialize stopped_cnt. Loading a v1
> stream leaves stopped_cnt at 0, so a timer stopped with CNT != 0
> loads CNT as 0; no post_load workaround. The pre-existing QEMUTimer
> expiry limit is unchanged.
>
> Add qtests covering PSC/ARR/CEN/UIF, CNT <= ARR, CNT preset before
> CEN, ARR == 0, stop freeze on CEN=0, restart, and no spurious IRQ
> after reset.
>
> Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
> ---
>  MAINTAINERS                        |   1 +
>  hw/timer/stm32f2xx_timer.c         | 101 ++++++++++++++++----
>  include/hw/timer/stm32f2xx_timer.h |   7 ++
>  tests/qtest/meson.build            |   4 +
>  tests/qtest/stm32f405-timer-test.c | 142 +++++++++++++++++++++++++++++
>  5 files changed, 236 insertions(+), 19 deletions(-)
>  create mode 100644 tests/qtest/stm32f405-timer-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5bf895732c..f1b3d75cc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1213,6 +1213,7 @@ F: hw/misc/stm32f4xx_syscfg.c
>  F: hw/misc/stm32f4xx_exti.c
>  F: hw/misc/stm32_rcc.c
>  F: include/hw/misc/stm32_rcc.h
> +F: tests/qtest/stm32f405*
>
>  Netduino 2
>  M: Alistair Francis <alistair@alistair23.me>
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index 0442ac64ad..1639037130 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -53,7 +53,8 @@ static void stm32f2xx_timer_interrupt(void *opaque)
>      if (s->tim_dier & TIM_DIER_UIE && s->tim_cr1 & TIM_CR1_CEN) {
>          s->tim_sr |= 1;
>          qemu_irq_pulse(s->irq);
> -        stm32f2xx_timer_set_alarm(s, s->hit_time);
> +        stm32f2xx_timer_set_alarm(s,
> +                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));

This change means that the only uses of s->hit_time are in the
sequence in stm32f2xx_timer_set_alarm():
    s->hit_time = (uint64_t)now + delta_ns;
    timer_mod(s->timer, s->hit_time);
    DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);

That means we can change hit_time to be a simple local variable
in that function; it doesn't need to be a state field any more.

>      }
>
>      if (s->tim_ccmr1 & (TIM_CCMR1_OC2M2 | TIM_CCMR1_OC2M1) &&

>  static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
> @@ -148,8 +172,11 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
>      case TIM_CCER:
>          return s->tim_ccer;
>      case TIM_CNT:
> -        return stm32f2xx_ns_to_ticks(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) -
> -               s->tick_offset;
> +        if (!(s->tim_cr1 & TIM_CR1_CEN)) {
> +            return s->stopped_cnt % ((uint64_t)s->tim_arr + 1);
> +        }

This looks odd -- I wouldn't expect the auto-reload register to have
any effect if the counter is stopped. That is, if you do:
 * set the counter to disabled
 * set ARR to 100
 * set CNT to 200
 * read CNT

I would expect to read back 200 (and then if you enable the counter
it probably rolls back to 0 on the next clock, regardless of
what its value above the auto-reload value is?)

Do you have real hardware to confirm the behaviour against?

> +        return stm32f2xx_timer_get_cnt(s,
> +                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>      case TIM_PSC:
>          return s->tim_psc;
>      case TIM_ARR:

> @@ -272,7 +328,7 @@ static const MemoryRegionOps stm32f2xx_timer_ops = {
>
>  static const VMStateDescription vmstate_stm32f2xx_timer = {
>      .name = TYPE_STM32F2XX_TIMER,
> -    .version_id = 1,
> +    .version_id = 2,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
> @@ -294,6 +350,13 @@ static const VMStateDescription vmstate_stm32f2xx_timer = {
>          VMSTATE_UINT32(tim_dcr, STM32F2XXTimerState),
>          VMSTATE_UINT32(tim_dmar, STM32F2XXTimerState),
>          VMSTATE_UINT32(tim_or, STM32F2XXTimerState),
> +        /*
> +         * New in version 2: frozen CNT while CEN == 0. Pre-existing
> +         * limitation left unchanged: QEMUTimer expiry (hit_time) is
> +         * not migrated and is re-armed by the next register write;
> +         * see stm32f2xx_timer_set_alarm.
> +         */
> +        VMSTATE_UINT32_V(stopped_cnt, STM32F2XXTimerState, 2),

We don't care about migration compatibility on these machine types,
so we could just bump both version_id and minimum_version_id to 2
and define the field as a simple VMSTATE_UINT32().

>          VMSTATE_END_OF_LIST()
>      }
>  };

Otherwise this looks OK, and certainly better than what we have now.

thanks
-- PMM

