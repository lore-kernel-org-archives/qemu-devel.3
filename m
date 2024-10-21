Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A8ED15D8A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 12:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2rzX-0006cy-Lr; Mon, 21 Oct 2024 08:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2rzV-0006bz-GI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:58:33 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2rzT-000577-K4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:58:33 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so894799a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729515510; x=1730120310; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3aZFIo5hfSpWXFAvY/Ia2orS+55ORfi5yK3W5zNxbug=;
 b=JAlnq1PViEuRxBKxC0ku8Zy0fycJ3kAV4Bx2JqU3UNyzMG9tCzawFu+6hn4ToBxesh
 t1ZUTDFmvyjuzOMXfNTyfr7K1Kb1NAvCNryi/qI74qUiSUtxTX1qu5AdzvsIRfKefA6d
 P4u/xNlg8oxFSVNESB3gg/lT4blcV+fayYrNYwC2EXa0NZ/OwgWb7mj27wE5K9EtfzAf
 e77hPV7BQNTxm9lAOWdpvuGuA1JrI8p6mZdgGhYEZz5mXpZr1HZWLfiCDndBINHe5AIS
 hRY7BiT5Jbt1oxxK+TlB/1Ck7BDT11YL1q9UQfVViaGJkdl+kRMNrYM4SrDETgnwjpc1
 nH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729515510; x=1730120310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3aZFIo5hfSpWXFAvY/Ia2orS+55ORfi5yK3W5zNxbug=;
 b=hVzHQh01IoYwOLD07TTZ0Dn44W741NtVa5S1a1FVILOvk5HyDT65fzbrUp6LCeSi8I
 B0WXiulO1pkyz1ou6LW5B5H8M1wzNsp+vz3HkHd2I2cq3+s/fOD5odIaWX6WxcTBKGpq
 +Xj5QfrqgD9Qgxu6jmbIZw2fAjvfkop0KUh6Fsb8RM3iEqlO4sI0In49JBfHx0E8BjGD
 IStfdlrjhw8ItAI2g0FzIqMbop+MU94c8izc6f7KVfZO05kfFlrUozRitpT47Y2ELHvv
 wcHFovFpWpmL8UgHSXN0asMMnYsnKMdD9oj+VE5LifCx5qWiYuwwtOFXuhcpHrYR4RPR
 6GBg==
X-Gm-Message-State: AOJu0Yw+f7xeAq7Gx7NK8GVG9qASIysGeNoB29VuMbO7ZMw8X3Jj5DBw
 gbgAcWM89htTvi44+9C3/0JL9xM/4lTi8JwQF3TKfYGa5cRZ/9o55ozYB5v78bP2HpK2UsYo5+r
 B3Is0pVzaAVn1MpEQtiGHe4/yDtz82hqVKnMwAvQsbu+TqM1I
X-Google-Smtp-Source: AGHT+IEm5fA0y2iMPP6Yj3xYnbsLwFARLGqL49zdd91DZ+kfJ0vt8K/c6122jS46ihONGlmnH3hg7nAbtLBXxUnhPYA=
X-Received: by 2002:a05:6402:4410:b0:5c5:c4b9:e68f with SMTP id
 4fb4d7f45d1cf-5ca0ac459b1mr13004117a12.5.1729515509735; Mon, 21 Oct 2024
 05:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <be4c64f56a4a7f25a2769c0eccd2ed6e1d8cb9ee.1729355735.git.neither@nut.email>
In-Reply-To: <be4c64f56a4a7f25a2769c0eccd2ed6e1d8cb9ee.1729355735.git.neither@nut.email>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 13:58:18 +0100
Message-ID: <CAFEAcA8iiYG2kw=tpMiLUsN+ZB-f6aN5eb-aAOhhc7nZyjA0+A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/7] target/arm: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Sat, 19 Oct 2024 at 17:39, Julian Ganz <neither@nut.email> wrote:
>
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for ARM (and Aarch64) targets. We decided to
> treat the (V)IRQ, (VI/VF)NMI, (V)FIQ and VSERR exceptions as interrupts
> since they are, presumably, async in nature.
>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  target/arm/helper.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

This omits M-profile Arm CPUs (whose interrupt/exception
handling is rather more complicated, and lives in
m_helper.c.)

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0a731a38e8..f636e216c8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -31,6 +31,7 @@
>  #endif
>  #include "cpregs.h"
>  #include "target/arm/gtimer.h"
> +#include "qemu/plugin.h"
>
>  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
>
> @@ -11147,6 +11148,24 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>      }
>  }
>
> +static void arm_do_plugin_vcpu_interrupt_cb(CPUState *cs)
> +{
> +    switch (cs->exception_index) {
> +    case EXCP_IRQ:
> +    case EXCP_VIRQ:
> +    case EXCP_NMI:
> +    case EXCP_VINMI:
> +    case EXCP_FIQ:
> +    case EXCP_VFIQ:
> +    case EXCP_VFNMI:
> +    case EXCP_VSERR:
> +        qemu_plugin_vcpu_interrupt_cb(cs);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_exception_cb(cs);
> +    }
> +}
> +
>  static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
>  {
>      /*
> @@ -11819,6 +11838,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>      if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
>          arm_handle_psci_call(cpu);
>          qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
> +        arm_do_plugin_vcpu_interrupt_cb(cs);

This isn't really an interrupt or exception -- it's
more like the semihosting, where the guest does an HVC
or SMC instruction and QEMU handles it by emulating it
as if it were firmware. Maybe it would be better to
name the "semihosting" plugin callbacks something more
generic and include this kind of case in them ?

>          return;
>      }
>
> @@ -11830,6 +11850,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>  #ifdef CONFIG_TCG
>      if (cs->exception_index == EXCP_SEMIHOST) {
>          tcg_handle_semihosting(cs);
> +        qemu_plugin_vcpu_semihosting_cb(cs);
>          return;
>      }
>  #endif
> @@ -11855,6 +11876,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
>      if (!kvm_enabled()) {
>          cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
>      }
> +
> +    arm_do_plugin_vcpu_interrupt_cb(cs);

thanks
-- PMM

