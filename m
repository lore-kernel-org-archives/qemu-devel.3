Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE14C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdb36-00005d-4V; Fri, 23 Feb 2024 14:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdakX-00026g-U2
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:58:22 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdakQ-0001qQ-U9
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:58:20 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d1094b5568so8446761fa.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708714692; x=1709319492; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/bB188QSPtliY19D0owRMygWLnL7OHeb/8O0+Oo0OQ=;
 b=jjcKoFf8o96vphokXzTEuN8jp8ZYtUZGkFbyoxwUIyNsVN1W6mZ3/XWJWwQa+GQ4E8
 lxGtZIhfECGXqJ+bVCToBpHQfERqc6h0OBzgO7LpSPGJI71iIBn821aYSpwZxQkDzQ79
 nAqN5rthjdO7qdSm6kuRCRX4gxy8k/TZ/QT0mvuhvU0QUU1NvI2HGtPLf9chKSGe8D5r
 HD/aO9oCPlzCjuclWrPk5ArpbFQsIBVQEUPHR4OPGnvA/zzDWZkVAFwyeQnXtggRz8jZ
 NaIySfFg2YjeRWCI1HC1PbIaY9rsfVDnJfwYzxhkHJHl9IbFSUYp3f9u7+X8WITDr97D
 Vchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708714692; x=1709319492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/bB188QSPtliY19D0owRMygWLnL7OHeb/8O0+Oo0OQ=;
 b=M2AciPIiqbXIT1f84DdNxZhvCy7RU6NlQbOpijX5bNK2XUr+57AkSAKZL5KaehRj98
 twZ2DbCSjrnvwjOhSL+p/eyTdXB5w5naQpjs1lriVRzmNqoj1oqzUJAh2QjnAsthffqW
 Ca3K12GJMUcA9EdCusGED+J+l1AeKe7lv3TBj6p9tFNk+zmFGw6jMkSYaB2qx42u7aFW
 NegS1OZHAlWgvUoZULaQX7ieoUomApNuhsLJMA3LeFV82ZSKkuIXKo6X0ce9850XN7ea
 yQJDEq63yB43poxqNeKuJQAUiySs+MIw3fvrWk9m9eUqd7LKcXLoeT2nkoN4xxsZUPnV
 z15A==
X-Gm-Message-State: AOJu0YwT9ZiWszEBz0DIXJpxDBnOcQOG6igQ++D2gN4eznQQWP6q1p0a
 P9RLFqQ/AqDivvDliYcKeulU+Utj/QOLy8C2cXcI35KeIGel1rSotrHAlYpJVz0qV68Ng1D8PuX
 I4arpVMtQPDguGYemHtgNL4ABUYiLmI34Bs1kOg==
X-Google-Smtp-Source: AGHT+IFrHqs28swwi6lU3mj45bxy0zZUBWwCCy4WuVHG1N1Z2HtSRXagySQsB+6UaAebPBGhiLArHXYO1joGQxNc9pE=
X-Received: by 2002:a2e:9003:0:b0:2d2:5275:b40d with SMTP id
 h3-20020a2e9003000000b002d25275b40dmr21878ljg.31.1708714691772; Fri, 23 Feb
 2024 10:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20240220192625.17944-1-philmd@linaro.org>
 <20240220192625.17944-2-philmd@linaro.org>
In-Reply-To: <20240220192625.17944-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 18:58:01 +0000
Message-ID: <CAFEAcA-i2e+MNiwkPyqOjFXJjBOW2WX-=Sz10YR9YQ2Lpm0ARQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] target/alpha: Expose TMR and SMP IRQ lines via
 QDev
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024 at 19:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In order to remove calls to cpu_interrupt() from hw/ code,
> expose the TMR and SMP interrupts via QDev as named GPIOs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/alpha/cpu.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index bf70173a25..619cd54593 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -25,6 +25,31 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>
> +#ifndef CONFIG_USER_ONLY
> +static void alpha_cpu_tmr_irq(void *opaque, int irq, int level)
> +{
> +    DeviceState *dev =3D opaque;
> +    CPUState *cs =3D CPU(dev);
> +
> +    if (level) {
> +        cs->interrupt_request |=3D CPU_INTERRUPT_TIMER;
> +    } else {
> +        cs->interrupt_request &=3D ~CPU_INTERRUPT_TIMER;
> +    }

These should call cpu_interrupt(), because otherwise you
lose the logic that does a cpu-kick if one CPU triggers
an interrupt on another. (Also you lose the handling for
non-TCG accelerators, not that that's an issue for Alpha.)
Compare arm_cpu_set_irq().

thanks
-- PMM

