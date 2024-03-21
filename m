Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F383C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 11:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnGoK-0003gD-1C; Thu, 21 Mar 2024 07:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnGoI-0003fV-1M
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 07:42:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnGoE-00010T-PQ
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 07:42:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso885495a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711021327; x=1711626127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5V2/xo6EUH/gTfa/P+YyHccBepo+EMc0rFYNGI3xJa8=;
 b=Z6HTW3Eq+CGMHcap28pF3VD1h9PWXcixpOxzlS+ws4oGjhYm7cluqiNXaFFFBUW1D7
 aTzaV2Rp4gM6DGA5ePe9VpYHtN46nsGfDJH8ohB8MxFL2wXFUJ+QJGfIuRELh4S8Ztnd
 G2EUxbpE/CNRxK2b89IJvGnzADSVLZLWAiczZ6ATQ5itxkGIIf/J0qVc4nouhzdPC6Yl
 CoibdHeFZKO04q0OGwrgFbb4DqbnegbjdfP5dnh4C5b7NnBMoeMHXNnWGqcY8iUFjxjI
 ATrt4+VeN9lUkZhZQ47WKiot5IP/VB5nR567xrVd+PyqAtFw3I/mcI0pkUNgI3RViSus
 e+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711021327; x=1711626127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5V2/xo6EUH/gTfa/P+YyHccBepo+EMc0rFYNGI3xJa8=;
 b=NormaatoCOQXFtb2ZO6y7lKtkqsmiMTti3AggVUrVYv8T2nt7T6nMpYt4DPU8d83ub
 IakI0Ic+0hgXKGq0cq+jNaU/gkbWtHDtBQML6758zQYO/4cgmvfZKRZufxMn7c0eO3l0
 KoRPVLbB3LHgP0QdHl481HU25XWC7gAm/98a+GFgww5O41CgvCo4GWHww2HDQB3WfrCz
 aVKCOZIgGNDMhalKq+IyU3oKNnwl1gqEaKBAiXeod6E+HtXb0LhIXLwSn8dRB3RZk0vP
 qasKYz6Q8gs7z+ZdpzKMzGhMnwswZtVHbI1Cv/UDkZeyD7/xxcnHFqn13sIEreDhRr1V
 ZTHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ7ThnG3+ZGKr9sYt/rOSsYZnsQr1+sP4iKsQVHUOpV1BwXulBZLLjdBWocN4gcBKv54jO5XTBN1lQ0kjNXrnsol6NV4Q=
X-Gm-Message-State: AOJu0YyrRfvG9Q02g+zx8KCoDtJKeI+VyEvkKQywbcSq8hh083fKMERW
 xA3I5NZDghiYbbqapy5I6cTagoGApU1l4VUl2SYRYt+eA/I1gAqalzpDPR0/MK+vSpTjiICg1lp
 5QrdfAafX7Vuq0Rb42ri4lYdmbDqQGr9hnoT1cA==
X-Google-Smtp-Source: AGHT+IEfSnqhE0E6mNwMyhEWBR/ghcxnL7lXKma4SSf7nj842K9mY7WRGfYgER98wCAtd3HfF9ikdZZBXDaX4UnzU/Y=
X-Received: by 2002:a05:6402:3986:b0:568:223e:f2b0 with SMTP id
 fk6-20020a056402398600b00568223ef2b0mr16976307edb.21.1711021326887; Thu, 21
 Mar 2024 04:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-7-ruanjinjie@huawei.com>
In-Reply-To: <20240318093546.2786144-7-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 11:41:55 +0000
Message-ID: <CAFEAcA9m6tfAkZueuu4nOxG9dDQRYB3sHP-N-8B2Jx5CUZQeyA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This only implements the external delivery method via the GICv3.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -692,13 +719,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>              /* VFIQs are only taken when hypervized.  */
>              return false;
>          }
> -        return !(env->daif & PSTATE_F);
> +        return !(env->daif & PSTATE_F) && (!allIntMask);
>      case EXCP_VIRQ:
>          if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
>              /* VIRQs are only taken when hypervized.  */
>              return false;
>          }
> -        return !(env->daif & PSTATE_I);
> +        return !(env->daif & PSTATE_I) && (!allIntMask);
>      case EXCP_VSERR:
>          if (!(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
>              /* VIRQs are only taken when hypervized.  */
> @@ -804,6 +831,24 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>
>      /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
>
> +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
> +        if (interrupt_request & CPU_INTERRUPT_NMI) {
> +            excp_idx = EXCP_NMI;
> +            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                                  cur_el, secure, hcr_el2)) {
> +                goto found;
> +            }
> +        }
> +        if (interrupt_request & CPU_INTERRUPT_VNMI) {
> +            excp_idx = EXCP_VNMI;
> +            target_el = 1;
> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                                  cur_el, secure, hcr_el2)) {
> +                goto found;
> +            }
> +        }
> +    }
>      if (interrupt_request & CPU_INTERRUPT_FIQ) {
>          excp_idx = EXCP_FIQ;
>          target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);

This part adds handling for taking IRQNMI and VIRQNMI, but not
VFIQNMI. So because at the moment we merge VFIQNMI and VFIQ
they both come out as interrupt_request having CPU_INTERRUPT_VFIQ
set. But we don't handle that in this function or in
arm_excp_unmasked(), so we treat it exactly the same as VFIQ, which
means that if PSTATE.F is 1 then we will incorrectly fail to take
the VFIQNMI.

I think the code is going to be a lot more straightforward
if we keep all of these things separate. Compare how we handle
VSError, which is also (for QEMU) something where only the
virtual version exists and which is only triggered via the
HCR bits.

thanks
-- PMM

