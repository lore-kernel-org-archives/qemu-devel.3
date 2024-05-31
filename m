Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7ACC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 10:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCzeq-0005Of-8B; Fri, 31 May 2024 06:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCzeo-0005O8-Pp
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:38:46 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCzem-0003pC-AV
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:38:46 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a2406f951so1757169a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717151922; x=1717756722; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AkI2FS62x+Dhu1IK0lIKypdx1eV3OekuMiHqJQ6CMuA=;
 b=tR1n6uCB0YLnExY7+0bvjPitC7tYtt6NmWwCNbQwcwxy/wCYJ7e56eliYkqRo1Gp+P
 S4bXY3lNoiNmm+w4tbKO74qx3PYgIX5h+dEy0KiDfa6avqU9TR9+dqbXU1XFZLuaXAwG
 2w+Lm6NdXsf77/4x1mdZaUHtqwY3XxLSZKNi8Q43LRRqPY3AsX1mXt74BqkqlikZIFHa
 c2fG2VukjYB5p0AKmvADun4piIR52aKVTW2zvDrIVJ1wPrHTKOuCefuceKJT2pGNc//6
 kkVl2n50mv8YMNm38RGa/izVda48l/4StiTj1v6t+xw/3TzD6l1gdHkkHN3Im5K15IXI
 eAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717151922; x=1717756722;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AkI2FS62x+Dhu1IK0lIKypdx1eV3OekuMiHqJQ6CMuA=;
 b=eMGvywdECtsIZ/ChimcbydEHA/kmQKIvF/njLap1zpARx2HBQnbp0NjsTUIGGZn/3x
 be+ZE62LTT5r1qdcnIc7HNw7YcikIWVzXyRnxJHP7tnRY1cvWddkq3jU+Mp7HLln3W+I
 /OeAZX5Cu1x3Ie9eKFsSqDxCq3aPaDrpUFWG6H4PbR/9ynrKVg224w1SsPBlyMBE/HeA
 Zwx/hu5pqnNFNPO7hbXOBM+qrKbjCBsjhHXzHbfsC+08MaqwgY3Anlb4vI3Li6zNk2zH
 xM7N1kGIG9/Qv6nuRH2pQmjiu6J5Bl6a3/7SEfVD1tdAZ6vqgHN8+NLRKCaUiYpmPGSP
 HlJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO1SkB8QhHHpwskuyeoS/qmztmEbTLhN9W+WMqJpZGPaZuEVrjkdjUDAZsKnMnBLqGwLIKAOqXr1q1rISuNiMltepkBrs=
X-Gm-Message-State: AOJu0YyUbVPJZEAyATzYUSTOx98VKMfwR6MY7jQOJEgqSqfRisdar6EK
 4RcR1Yd/RaMAI0ASHlfd8XTpnMYG9dozcaLt3I3mwwWYz1b3S8/pOcq2KHKUEt+8nvA2qpOu195
 rAU6zxdG7xZUu6fq0QXsZf/k9uHMQwB3W8Yx1Uw==
X-Google-Smtp-Source: AGHT+IH8I0c39w6lFYoLPf/Gsn+SOl9iUOdoGb+ScOnB1onDOH9NUP/HsvKOb/cvs3B6rSeuHQSubrxcPpUtjMmZQ5A=
X-Received: by 2002:a50:f682:0:b0:57a:2f7f:4800 with SMTP id
 4fb4d7f45d1cf-57a364ac02amr1020794a12.34.1717151922311; Fri, 31 May 2024
 03:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-3-peter.maydell@linaro.org>
In-Reply-To: <20240430140035.3889879-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 11:38:30 +0100
Message-ID: <CAFEAcA_745eAvDv+ZPq4gE7fyBxVvmB3M-jymTA-XB2UmDnYVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Implement FEAT WFxT and enable for '-cpu
 max'
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Tue, 30 Apr 2024 at 15:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> FEAT_WFxT introduces new instructions WFIT and WFET, which are like
> the existing WFI and WFE but allow the guest to pass a timeout value
> in a register.  The instructions will wait for an interrupt/event as
> usual, but will also stop waiting when the value of CNTVCT_EL0 is
> greater than or equal to the specified timeout value.
>
> We implement WFIT by setting up a timer to expire at the right
> point; when the timer expires it sets the EXITTB interrupt, which
> will cause the CPU to leave the halted state. If we come out of
> halt for some other reason, we unset the pending timer.
>
> We implement WFET as a nop, which is architecturally permitted and
> matches the way we currently make WFE a nop.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a152def2413..006092a6b12 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1132,6 +1132,33 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
>      return arm_cpu_data_is_big_endian(env);
>  }
>
> +static bool arm_cpu_exec_halt(CPUState *cs)
> +{
> +    bool leave_halt = cpu_has_work(cs);
> +
> +    if (leave_halt) {
> +        /* We're about to come out of WFI/WFE: disable the WFxT timer */
> +        ARMCPU *cpu = ARM_CPU(cs);
> +        if (cpu->wfxt_timer) {
> +            timer_del(cpu->wfxt_timer);
> +        }
> +    }
> +    return leave_halt;
> +}

I noticed in my pre-pullreq testing that this function needs
an #ifdef CONFIG_TCG around it, since otherwise the compiler
complains that it is defined but never used if we're building
only-Xen or only-KVM. I'll add that when I put this in
target-arm.next, rather than respinning.

thanks
-- PMM

