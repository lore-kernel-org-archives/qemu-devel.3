Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271F4CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZRbq-00068s-A2; Tue, 16 Jun 2026 07:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZRbo-00068c-QT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:05:32 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZRbm-0002FX-OY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:05:32 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so4090291d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 04:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781607929; cv=none;
 d=google.com; s=arc-20240605;
 b=WkcdK+PSTXFVQcVK4VVuRk90SCiipkgV8SF6PB7Fi+G6nnQeaCgemjiAwF6E8BATRH
 Ud7+V4DznyO6lggAcuo5R7wRWVzGxxP/TJGAhfT7VgXp417niKstEf9RBGPb9xdeiuBp
 Mm9jHU5JeKxnI9dOCxMDEcq518fPopQlKk7BgyytvwkBRQ7dzdYmekJ5RX8RMKAumwBG
 5QC2KvbwIgMUh24v3e2MljN9nQMDUTl2UzH9lYw6lJLy7LvqwVuNAZhKo8zOmXXHwv+2
 DhaMa8ElQZwh/LReTrUa1RD5i+1eHLs91O97+soCbDfegpLAFYRaV/lCVUADTlcYXcrD
 PxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=01SDBdg7GUgNU/xmWucQOxqr7szYHJmoAyp2g83UZOE=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=CgV4vAFcS5U3GFh8mIP6lri4kW7ulQux07ogzHYBQaiSP4GN67FMCdYAv3L+Q+rtQF
 0OMG8BQkiEDh19qfhL0SSmcYe3vW8mH9SxtAa/4z6CyEqQKtZqOSZmiB/eX5qIrKaOOP
 NNF3/8yTZRg2NepgI2CWOzeSDLexhXAoUmcnW77YooZsyLUfbMSmQyv+ShpIdsa/2hIB
 xZaoUPmN/ob1489+x0yYWOx/iBCdkU6QYDrz+4KIvJhVbjylCZ57ejcNhk1NtPr8xh/w
 aaggtliy2foY8SwFFn7zlDaUDpRbyChmAu9G4GQwWeaefT2LfVGSqLgspBB1RHWzMgN9
 ySoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781607929; x=1782212729; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=01SDBdg7GUgNU/xmWucQOxqr7szYHJmoAyp2g83UZOE=;
 b=WY9CRJiQ3NjMTnWc+12MUKgtQX8XoPBLJj0LVRSm+rO9z+jIlyVG9iKVCnCK2x4Lby
 DM1jJqHP9EHALmt+2ZJm5Hf35zB3Vv1FMDFaAxIuxs2OX+vX9as68x01G04CroGrZ7Th
 Iq8BAgC1dxu4TZsvwFFo1adOWMQqeX1ZqHk7Iwr3sHtTSsASNI/TNI3gGPMktanrsRC8
 cVsAQ7E7XIK7RYogjT4AtMXQ9uOYpsIlT14Ery4bkB4A072jtPpHtMp+/vt825+c8/Hs
 /ax762Qs8/FCoBCQRNuDRova6O1eFS+GyOxiMKD01RZCY0mtj6liIJWVowwsK5qK+fUX
 Vtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781607929; x=1782212729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01SDBdg7GUgNU/xmWucQOxqr7szYHJmoAyp2g83UZOE=;
 b=UWWAbtb28iXZ6n2ZhTqyeePtaKplVuUmbzTafg9zuP3YpgS6E6NYIIfDcwZv+RpsRt
 mTBbKDL5DKhEWbIAJVmrL90JkiHqRpyAbeyG8BRVWhJ3/sQs0PlMzULgR0hk6mHo8sEg
 ypQE6oUPjRK8qC7aMplN+D7d9chmqfUeKMN4tnsaycSMqLwvAxOIjaX9y9ojptw2ilT8
 fv9Iu6nnYR/IxLZ2ehx6M04zNxjpeqHBsC6XoozD227ewtn+x8N37cqT3bSEYG5zq/YZ
 fJhnwsS6gDsY9ZDTegMMfd7z1nh8OoG1EepwckCEQh3+xhRQhZRjTTyWP90Ip2Svwbcz
 9cQg==
X-Gm-Message-State: AOJu0Yx87lk7jjk9PjAKgLVvH4IQo/SottGL8KHXFC94bpapYrWiMPAF
 OUT2xw1B2eMkhjdMc3U9OkJX+31i1IIt3ZaBVRz7Zw9aWjgapOZDutwPwrVfQBkyVeJ/vNumMcG
 iu3zdzDINHQOOA3pwutdeI5tpDFSheyEkT7o+J1cAVFMwtcU/m+4q5Qg=
X-Gm-Gg: Acq92OEMQoYxQwUFUZp1QvfD6BygixgH0pV2Swj7ZPeoPnALwhO7+citJhANJvkaxB6
 BdPLG7f9pTySulHVvWgQLmuP9kYg1X439ippiLgIPjp8tLO5PeXAkZZEP6X+hOzxcEDo2zXXxOh
 LRdFjnAOn9gLC/9BwnVcAJkvTOixzRg5LtCPy4tUaAfTllwbhaocQ2vm41lpUZpiTKcqc5T7uWA
 t6X1KAkpCghQkKvo5eYKL/FwAT/WfU44/PBLNI9dMqOixCrbthwVNsRUl09K6qfTk5bdiDm4Aac
 TPamr+BTtKfHEC8UdcmLqGm4E4FtU1aeD/MirDZBBWX7ZsvagL3VnXuhX5T7+P5TpGw=
X-Received: by 2002:a05:690e:bc1:b0:65c:3597:5fd9 with SMTP id
 956f58d0204a3-66277f601e8mr15021984d50.17.1781607929181; Tue, 16 Jun 2026
 04:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260602063350.3623723-1-kchiu@axiado.com>
 <20260602063350.3623723-6-kchiu@axiado.com>
In-Reply-To: <20260602063350.3623723-6-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 12:05:17 +0100
X-Gm-Features: AVVi8CeBG5mkNKvTDwVvsiFb8ZOEyOpltIj8u4NzBefCHXcJfwdyzbE_FDsUlMc
Message-ID: <CAFEAcA9q8eprA4qKCndkGMaF6KgUv=_NQ5qR6OjUsDAYBRgWMg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] hw/gpio: Add Cadence GPIO controller
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 2 Jun 2026 at 07:34, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patch add a new model for Cadence GPIO controller which
> supports 32 pins and interrupts for level-triggered/edge-triggered type on
> input pins.
>
> Also define new trace functions for analysis purpose and new configuration to
> enable this model.
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>  hw/gpio/Kconfig                |   3 +
>  hw/gpio/cadence_gpio.c         | 307 +++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build            |   1 +
>  hw/gpio/trace-events           |   5 +
>  include/hw/gpio/cadence_gpio.h |  55 ++++++
>  5 files changed, 371 insertions(+)
>  create mode 100644 hw/gpio/cadence_gpio.c
>  create mode 100644 include/hw/gpio/cadence_gpio.h
>
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index a209294c20c..fcc7c70bd50 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -30,3 +30,6 @@ config PCF8574
>
>  config ZAURUS_SCOOP
>      bool
> +
> +config CADENCE_GPIO
> +    bool
> diff --git a/hw/gpio/cadence_gpio.c b/hw/gpio/cadence_gpio.c
> new file mode 100644
> index 00000000000..08a8cf71968
> --- /dev/null
> +++ b/hw/gpio/cadence_gpio.c
> @@ -0,0 +1,307 @@
> +/*
> + * Cadence GPIO emulation.
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/gpio/cadence_gpio.h"
> +#include "hw/core/irq.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +static void cdns_gpio_update_irq(CadenceGPIOState *s)
> +{
> +    qemu_set_irq(s->irq, s->isr ? 1 : 0);
> +}
> +
> +static void cdns_gpio_update_isr_per_line(CadenceGPIOState *s, int line,
> +                                          uint32_t new)

We don't need to do this one line at a time. Because all the
registers involved are 32 bits wide and have one bit per
GPIO line, we can use logical operations to calculate them
all at once, like this:

static void cdns_gpio_write_inpvr(CadenceGPIOState *s, uint32_t new)
{
    /*
     * Update s->inpvr to the specified new value, and recalculate
     * s->isr accordingly.
     * We can calculate the s->isr value for all the GPIO lines
     * at once using bitwise operations.
     */
    uint32_t new_isr = 0;
    uint32_t any_edges, rising_edges, falling_edges, deassert_mask;

    /*
     * If ITR is set, this is level triggered: ISR bit set
     * when IVR matches new invpr value.
     */
    new_isr |= s->itr & ~(s->ivr ^ new);

    /*
     * If ITR is not set, this is edge-triggered. If IOAR bit
     * is set, we trigger on any edge; otherwise we trigger
     * on rising edge if IVR is set, falling if IVR bit is 0.
     */
    any_edges = s->ioar & (s->invpr ^ new);
    rising_edges = s->ivr & ~s->inpvr & new;
    falling_edges = ~s->ivr & s->inpvr & ~new;
    new_isr |= ~s->itr & (any_edges | rising_edges | falling_edges);

    /*
     * In bypass mode or if this isn't an input pin, the ISR
     * bit is forced to zero.
     */
    deassert_mask = s->bmr | ~s->dmr | s->imr;
    new_isr &= ~deassert_mask;

    s->isr = new_isr;
    s->inpvr = new;

    cdns_gpio_update_irq(s);
}

(Untested, but I believe it to be correct.)


> +{
> +    uint32_t old = extract32(s->inpvr, line, 1);
> +    uint32_t ivr = extract32(s->ivr, line, 1);
> +
> +    /* Deassert in bypass mode or not input pin */
> +    if (extract32(s->bmr, line, 1) || !extract32(s->dmr, line, 1) ||
> +        extract32(s->imr, line, 1)) {
> +        s->isr = deposit32(s->isr, line, 1, 0);
> +        return;
> +    }
> +
> +    if (extract32(s->itr, line, 1)) {
> +        /* Level-triggered */
> +        if (ivr && new) {
> +            /* High level */
> +            s->isr = deposit32(s->isr, line, 1, 1);
> +        }
> +        if (!ivr && !new) {
> +            /* Low level */
> +            s->isr = deposit32(s->isr, line, 1, 1);
> +        }
> +    } else {
> +        /* Edge-triggered */
> +        if (extract32(s->ioar, line, 1) && (old != new)) {
> +            /* On any edge */
> +            s->isr = deposit32(s->isr, line, 1, 1);
> +        } else {
> +            if (ivr && !old && new) {
> +                /* Rising edge */
> +                s->isr = deposit32(s->isr, line, 1, 1);
> +            }
> +            if (!ivr && old && !new) {
> +                /* Falling edge */
> +                s->isr = deposit32(s->isr, line, 1, 1);
> +            }
> +        }
> +    }
> +}
> +
> +static void cdns_gpio_update_isr(CadenceGPIOState *s)
> +{
> +    for (int i = 0; i < CDNS_GPIO_NUM; i++) {
> +        uint32_t level = extract32(s->inpvr, i, 1);
> +        cdns_gpio_update_isr_per_line(s, i, level);
> +    }

If you use my suggestion above, this function becomes just

    /* Trigger an update of s->isr */
    cdns_gpio_write_inpvr(s, s->invpr);

and since cdns_gpio_write_inpvr() calls cdns_gpio_update_irq()
at the end, you don't need to have all this function's callsites do:
        cdns_gpio_update_isr(s);
        cdns_gpio_update_irq(s);
-- they can just call cdns_gpio_update_isr() only.


> +}
> +
> +static void cdns_gpio_set(void *opaque, int line, int level)
> +{
> +    CadenceGPIOState *s = CADENCE_GPIO(opaque);
> +    uint32_t new = level ? 1 : 0;
> +
> +    trace_cdns_gpio_set(DEVICE(s)->canonical_path, line, level);
> +
> +    cdns_gpio_update_isr_per_line(s, line, new);
> +
> +    /* Sync INPVR with new value */
> +    s->inpvr = deposit32(s->inpvr, line, 1, new);
> +
> +    cdns_gpio_update_irq(s);

Similarly this function becomes something like

      new_invpr = deposit32(s->inpvr, line, 1, new);
      cdns_gpio_write_invpr(s, new_invpr);

> +}
> +
> +static inline void cdns_gpio_update_output_irq(CadenceGPIOState *s)
> +{
> +    for (int i = 0; i < CDNS_GPIO_NUM; i++) {
> +        /* Forward the output value to corresponding irq */
> +        if (!extract32(s->bmr, i, 1) && !extract32(s->dmr, i, 1) &&
> +            extract32(s->oer, i, 1) && s->output[i]) {
> +            qemu_set_irq(s->output[i], extract32(s->ovr, i, 1));

You don't need to check if s->output[i] is NULL -- qemu_set_irq()
will handle that correctly (this is the "GPIO is not connected to
anything" case, and so it does nothing).

You might as well pre-calculate the outputs outside the loop:

   uint32_t is_output = ~s->bmr & ~s->dmr & s->oer;

so inside the loop you can do if (extract32(is_output, i, 1))
instead of 3 separate extract operations.


> +        }
> +    }
> +}

thanks
-- PMM

