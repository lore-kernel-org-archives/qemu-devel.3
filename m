Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE86C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLnM-0004ox-JE; Tue, 04 Feb 2025 11:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLnK-0004oU-FO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:29:02 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLnI-0003Az-NA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:29:02 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so5227986276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738686539; x=1739291339; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T6tpi2uNOPvRexxdyaBtzwIggAYq464uVyRYbQr+Bl4=;
 b=O9ylUzZAJom8yG0mHyEaV0A8x9qFBH9G8+u9UGr99li/vhqGfEHD2Y9I2SoIERMo8U
 v7PGuOIdVdAY3yX8u1G1yGbESpTGwB+6eqLMqV7HqZqNG/mi7W0QUIZEud9JTo463ZOD
 FSVKVBbQL56CSSjm/Dekm+JMiWosR7Csb7UwQ2Y9biK2rfyDj6KDX/hcBw0zFRr6ERzG
 bz7rPMETzOeVaR372ibrXerN48A8byjOy7/Eab1VMwP+xq2NCE4SREy29t3Grtgh3SuK
 DS27BEagwUyRKC1w6B2cPD6Flb0ZvOVpbp/7z58IcsjoRU6mfb7F9MPlyGqv6J2Pa196
 n6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738686539; x=1739291339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T6tpi2uNOPvRexxdyaBtzwIggAYq464uVyRYbQr+Bl4=;
 b=O5Knc2ZK2xmj6B7pVSRmjZJTbpbVoBfFA1BuB0gbii2qMm0CJChJVi3dDFhEPHTmzu
 ZK51CXGChWCvi7o0p2xbInZQeLi4LX8K36zvbA1owHYNsNN5wKUO6LHs2Pc/BbcQI/dk
 qEdkN14LD1EKg5Xv75M4QI8eoZLSYCvaaErP3oVUnLXYP/bCRwmDwaZkG7b4RegvutXp
 nf8POyHbcFHxHTBR62rW7uRmVp78duwIHor8vLpiIvk95U69HKenJORJav52pkM+hT5i
 1l/CKUOXaeS+g75bmD/tcp3kstDuYoAhDTGNfbK0GHuutJV5+1kHoB56H3sj+7YaTql2
 l5iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSbZ4YFJSls2jIx32+sa3fW8vLHeKVlzwmGqb4Tbh5RuMWUQZJn89Fy4fRCyOpZkaFqjwuo7uttTGF@nongnu.org
X-Gm-Message-State: AOJu0Yx1U5SRqTqGP6YxfNFA3uZxJmpDlIrkpYQm0ZuE8KAg7FQVnIYg
 woUrp6TVGhgpZeFzItWFQ736CUE9KO2qWCtWyexEA16CyfU4wDOVxzOKHBrtJoHdPpTDMxDgQfH
 hryrCCRo+i+CIorQ8JmfSjQxqPd9/Kw/cHQGDKA==
X-Gm-Gg: ASbGncufa0Ygm/5IcClCh6z2JmQZRIUW6CKJDQwIjzUUS7WKShG4HqeUq0YU0VphHX5
 cewZDAl8Cn2FI/GF0cp2+ah293m7IXLSAixJ6DG6EqJb1lSTjvU1ppsR8cOGw/JFzADorGMc2+A
 ==
X-Google-Smtp-Source: AGHT+IHZeKT6Gxi8xIkhJFHIpLvQ6uw0aeuoENXdWIY2YuAVn9rsmhju9yqWSFCQWvdfCI0gwYS1wlgU5R3ebnlR1+U=
X-Received: by 2002:a05:6902:2689:b0:e57:87b3:d2e0 with SMTP id
 3f1490d57ef6-e58a4a9c29cmr20412651276.3.1738686539428; Tue, 04 Feb 2025
 08:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-17-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-17-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:28:47 +0000
X-Gm-Features: AWEUYZknXSczvb1F1N6wwI9XXKDYcHuTBITkgb2WGBdKDJU1gx0_CRssaZt1z8U
Message-ID: <CAFEAcA_0N6hWSxvVRxy476R8qtoBOqT2Nque5Kq9gK8gG_YJ3g@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] hw/arm: Add NPCM8XX SoC
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 26 Dec 2024 at 08:29, Hao Wu <wuhaotsh@google.com> wrote:
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  configs/devices/aarch64-softmmu/default.mak |   1 +
>  hw/arm/Kconfig                              |  11 +
>  hw/arm/meson.build                          |   1 +
>  hw/arm/npcm8xx.c                            | 810 ++++++++++++++++++++
>  include/hw/arm/npcm8xx.h                    | 107 +++
>  5 files changed, 930 insertions(+)
>  create mode 100644 hw/arm/npcm8xx.c
>  create mode 100644 include/hw/arm/npcm8xx.h
>
> diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
> index f82a04c27d..5ea1cc2dd1 100644
> --- a/configs/devices/aarch64-softmmu/default.mak
> +++ b/configs/devices/aarch64-softmmu/default.mak
> @@ -8,3 +8,4 @@ include ../arm-softmmu/default.mak
>  # CONFIG_XLNX_ZYNQMP_ARM=n
>  # CONFIG_XLNX_VERSAL=n
>  # CONFIG_SBSA_REF=n
> +CONFIG_NPCM8XX=y

This should be a commented-out "n" (the way we arrange
this has flipped around since you originally wrote
the board support).

> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index e779b5af95..4fd5a41739 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -481,6 +481,17 @@ config NPCM7XX
>      select PCA954X
>      select USB_OHCI_SYSBUS
>
> +config NPCM8XX
> +    bool
> +    select ARM_GIC
> +    select SMBUS
> +    select PL310  # cache controller
> +    select NPCM7XX
> +    select SERIAL
> +    select SSI
> +    select UNIMP

You want a "depends on TCG && ARM" clause: compare the
other stanzas in the file.
(This is the other half of the flipping-around noted above).

>  config FSL_IMX25
>      bool
>      default y
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 490234b3b8..d7813c089c 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -12,6 +12,7 @@ arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
>  arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
>  arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
>  arm_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
> +arm_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c'))
>  arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
>  arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
>  arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
> diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
> new file mode 100644
> index 0000000000..ed4185f37d
> --- /dev/null
> +++ b/hw/arm/npcm8xx.c
> @@ -0,0 +1,810 @@
> +/*
> + * Nuvoton NPCM8xx SoC family.
> + *
> + * Copyright 2022 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/arm/boot.h"
> +#include "hw/arm/npcm8xx.h"
> +#include "hw/char/serial-mm.h"
> +#include "hw/intc/arm_gic.h"
> +#include "hw/loader.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/units.h"
> +#include "system/system.h"
> +
> +#define ARM_PHYS_TIMER_PPI  30
> +#define ARM_VIRT_TIMER_PPI  27
> +#define ARM_HYP_TIMER_PPI   26
> +#define ARM_SEC_TIMER_PPI   29

We have defines for these basically-standardized IRQ
numbers in include/hw/arm/bsa.h now.

> +
> +/*
> + * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
> + * that aren't handled by a device.
> + */
> +#define NPCM8XX_MMIO_BA         (0x80000000)
> +#define NPCM8XX_MMIO_SZ         (0x7ffd0000)

You don't need brackets around simple constants in a #define.


> +/* Total number of GIC interrupts, including internal Cortex-A35 interrupts. */
> +#define NPCM8XX_NUM_IRQ         (288)
> +#define NPCM8XX_PPI_BASE(cpu)   ((NPCM8XX_NUM_IRQ - 32) + (cpu) * 32)

These "32"s should probably be "GIC_INTERNAL"s.

> +        /* IRQ for watchdogs */
> +        sysbus_connect_irq(sbd, NPCM7XX_TIMERS_PER_CTRL,
> +                npcm8xx_irq(s, NPCM8XX_WDG0_IRQ + i));
> +        /* GPIO that connects clk module with watchdog */
> +        /* TODO: Check this.*/

Good idea :-)

> +        qdev_connect_gpio_out_named(DEVICE(&s->tim[i]),
> +                NPCM7XX_WATCHDOG_RESET_GPIO_OUT, 0,
> +                qdev_get_gpio_in_named(DEVICE(&s->clk),
> +                        NPCM7XX_WATCHDOG_RESET_GPIO_IN, i));
> +    }

Otherwise looks OK, but again, review by somebody who
knows the hardware would be nice.

thanks
-- PMM

