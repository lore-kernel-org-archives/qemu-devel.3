Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D4DC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXsq-0004aN-0D; Thu, 01 Feb 2024 09:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXsn-0004Zw-R7
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:17:38 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXsm-0000Ko-A8
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:17:37 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55fcceb5f34so385187a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706797054; x=1707401854; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kgMqkwOZL0NhaC+GsUct74xqFdiFXpm6R7KZnq5H5pc=;
 b=FK3RG0bWpk+Og2ZkLAMFoNPU1XzQ///Vhm8ET0+ihjcxoDf5wIqwjKEbIzw3TmJZlJ
 2FIffihTL8HH5ZEZjeU3C0/Z/cgAqVbKRjd+x2EHdRf/5DdP8Z994LmezgCjbldsmQMW
 cBHal4lVFz2Nyk0ZeAjnx7Bx5WY8Ez2UoTGoQAkEaue0bTkArkr/m2Qr5mJGwstsqW/9
 gqSqt7HSzUUoU5tPmb3A8IQ7L5f62exSIhCscFN2KR2XEHNai3A0t0b5MylrNKQtQYSo
 +0gXGkiKgJmu9067sZAJyYi4FFx4sZ27j+InugJuemi74Ld8AqSreeVnUb18VjoMpWH8
 UXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706797054; x=1707401854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgMqkwOZL0NhaC+GsUct74xqFdiFXpm6R7KZnq5H5pc=;
 b=s+wekeDl0EPci6q+WpigNnyxi2FcftUyc+Qodx2Qnh0O7wHB45WWAY36hD8yssryMc
 oPVLtD/SGyPccCavcaY6dHJPy2brDGIAZ+lEmz06I1vg5arEl4qigR9I9aFWsCIAN+4z
 Xed9YTbuV1/5PSGd+mDBUs6NcKPXPyzT+AH3rSq9uhOfaieAPMDqPjwDVY5ayP/V/Pdb
 ML1ik0W3lY2URoJKQlt8GfwFaxx0hYdrnWcmU7fHDGn1Ujc13SBXyYMvKXvrOEh/zU6i
 fkLA1+mnpr3ZZ9vP/TPJ340Of8proBVKT/dp4PIfw4RDB7wWQdqISwWqirrZRaGeVA/1
 xFhg==
X-Gm-Message-State: AOJu0YzuVFcF6x+K8ppjEu5HThxm+UHoqcV5we1isJEZ1G5F2uckrP8Z
 eIXsgUvYp5/J29Imn5Ao+QQ3pz1KDW7YQNvk6RNnVaidP+ir4RI7ePcbfyZFuywfQF4vSLQ3lEU
 aTaFnGXDC1dik0puD3skzerxllvKeezZoPdDYuJxnVdPzrDBd
X-Google-Smtp-Source: AGHT+IEjPHkP0zv1Ec8VoSfwDIMHL4/5e/pv+v+RXEE5iWqdKsvwz+9DANzBmpyBd8hCcHQLKnQaaGycLoB6z6tiiKo=
X-Received: by 2002:aa7:d5c6:0:b0:55e:dcdf:50b0 with SMTP id
 d6-20020aa7d5c6000000b0055edcdf50b0mr3248600eds.15.1706797053934; Thu, 01 Feb
 2024 06:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20240129081835.137726-1-thuth@redhat.com>
 <20240129081835.137726-2-thuth@redhat.com>
In-Reply-To: <20240129081835.137726-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 14:17:22 +0000
Message-ID: <CAFEAcA_mf-iGD_P3DB=dw4n=qpFyNODtAz1jFKUdjFkM1eWVuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/arm: Move v7m-related code from cpu32.c
 into a separate file
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Jan 2024 at 08:18, Thomas Huth <thuth@redhat.com> wrote:
>
> Move the code to a separate file so that we do not have to compile
> it anymore if CONFIG_ARM_V7M is not set.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/tcg/cpu-v7m.c   | 290 +++++++++++++++++++++++++++++++++++++
>  target/arm/tcg/cpu32.c     | 261 ---------------------------------
>  target/arm/meson.build     |   3 +
>  target/arm/tcg/meson.build |   3 +
>  4 files changed, 296 insertions(+), 261 deletions(-)
>  create mode 100644 target/arm/tcg/cpu-v7m.c
>
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> new file mode 100644
> index 0000000000..89a25444a2
> --- /dev/null
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -0,0 +1,290 @@
> +/*
> + * QEMU ARMv7-M TCG-only CPUs.
> + *
> + * Copyright (c) 2012 SUSE LINUX Products GmbH
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/core/tcg-cpu-ops.h"
> +#include "internals.h"
> +
> +#if !defined(CONFIG_USER_ONLY)
> +
> +#include "hw/intc/armv7m_nvic.h"
> +
> +static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    bool ret = false;
> +
> +    /*
> +     * ARMv7-M interrupt masking works differently than -A or -R.
> +     * There is no FIQ/IRQ distinction. Instead of I and F bits
> +     * masking FIQ and IRQ interrupts, an exception is taken only
> +     * if it is higher priority than the current execution priority
> +     * (which depends on state like BASEPRI, FAULTMASK and the
> +     * currently active exception).
> +     */
> +    if (interrupt_request & CPU_INTERRUPT_HARD
> +        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
> +        cs->exception_index = EXCP_IRQ;
> +        cc->tcg_ops->do_interrupt(cs);
> +        ret = true;
> +    }
> +    return ret;
> +}
> +
> +#endif /* !CONFIG_USER_ONLY */

I wonder if this function could go in target/arm/tcg/m_helper.c:
it looks a bit odd in this file, which is mostly initfns for
specific CPU types. But it was in cpu32.c so I'm happy that
we just move it to cpu-v7m.c for now.

> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 46b5a21eb3..2e10464dbb 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -26,6 +26,8 @@ arm_system_ss.add(files(
>    'ptw.c',
>  ))
>
> +arm_user_ss = ss.source_set()
> +
>  subdir('hvf')
>
>  if 'CONFIG_TCG' in config_all_accel
> @@ -36,3 +38,4 @@ endif
>
>  target_arch += {'arm': arm_ss}
>  target_system_arch += {'arm': arm_system_ss}
> +target_user_arch += {'arm': arm_user_ss}
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 6fca38f2cc..3b1a9f0fc5 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -55,3 +55,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>  arm_system_ss.add(files(
>    'psci.c',
>  ))
> +
> +arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
> +arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))

Why do we need to add this new arm_user_ss() sourceset,
when we didn't need it for the A/R profile CPUs?
What goes wrong if we add it to arm_ss() the way we do cpu32.c?

-- PMM

