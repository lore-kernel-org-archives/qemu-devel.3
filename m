Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A9EC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPAL-0007Ud-HT; Fri, 09 Feb 2024 06:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYPAG-0007Ip-Nz
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:35:30 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYPAC-0007IX-75
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:35:27 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55fe4534e9bso1157410a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478518; x=1708083318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCj76xeqcuL9VHe+LuMZKriAX/h0XIiUAX0uyIDYO/w=;
 b=BUlXAEcAjKkQkCv/s9ecYue+WQDz8Lk7JaY81DazC74MoryQSmDc5+YPZahxObqNu1
 48rr8TPosjjVs4bdZ8qN9XbmjSHHayBGn9mF/DU4e+s7pLWjhNTzsMQNFhzuQALU9hdw
 LvQIiT9UzBEKPb28KKJVesZnfCzPEZPvujtWxYvNPvTeaShDXp8v3qZHCRlsmlYVh2xm
 U3bwdAqVcvVSb3Qvtq9ugBxgd9jmQEc8YqfVb/QXVjejbDXfjknSFEP+7YrgUBneBrBY
 RdrpD0A1jORXz0a0Zq397HpCOGZouF/OJQsgCpKxdiRt3KKsAPTm+apM7kk8BiJJq65A
 1LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478518; x=1708083318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCj76xeqcuL9VHe+LuMZKriAX/h0XIiUAX0uyIDYO/w=;
 b=uhn0EonR2Suj/NbAkqJeyiIoNx110hV8jzMDV5bBhtjj0cLh8qi0v57FNyjeYo+ohJ
 HUqbVMdQAxjKeIrlbhYvSE6veH7OA1dGLgP1FmbUEvt6JCs+tfmDLXWixCQzu5vHeSqw
 4ttnkqx9Ukf8k9ONhqk3AJ2DKgG9yDciHGNpd+DFgoMjywooToRzr7exu9Bi3fzDjkoD
 FX3UCyDxtplBD4fowr0/1hJ/JHSeMa5tPlEnJZbDLfs0uH9SOIJyyfDx5uG+yS+LUw+J
 CqHkiK5bzxZbvGGKRhZDX6c5K5An4aVWEL3MEseO2o7vpEjwSOmjCM/cP+hFrD74x3z6
 zigg==
X-Gm-Message-State: AOJu0Ywe2bpZBOCVMdWrff1/Dd3pR5IhmE2auPTpgktA/onY0yVYxW6y
 8FEciBYEHXpoj7CauGz9meoSJemdwnnRji2WQMgfIVlS9In5CwD113BPvSWyEakNKlnaM5P087M
 jwb/fHJ9wDie18fmi/KwKrUBVdAJzIyZvZxzeww==
X-Google-Smtp-Source: AGHT+IHDzGIznmZSKi4QKpztDiKdRgTQ1z7HX/kuLa72oEWtkIBueLTnrsYe5wZD7zlADZVavbxakKIXrGYv3/zxvXw=
X-Received: by 2002:a05:6402:514f:b0:55f:e147:2524 with SMTP id
 n15-20020a056402514f00b0055fe1472524mr1011955edd.38.1707478518633; Fri, 09
 Feb 2024 03:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-11-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-11-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:35:07 +0000
Message-ID: <CAFEAcA-WyHyJqfnbqptvE2YzMWnZJHV9brearcgqGMYY9O6XkA@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] hw/sparc/leon3: Initialize GPIO before realizing
 CPU devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Inline cpu_create() in order to call
> qdev_init_gpio_in_named_with_opaque()
> before the CPU is realized.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sparc/leon3.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 0df5fc949d..0e1d749306 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -234,8 +234,11 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
>      APBPnp *apb_pnp;
>
>      /* Init CPU */
> -    cpu =3D SPARC_CPU(cpu_create(machine->cpu_type));
> +    cpu =3D SPARC_CPU(object_new(machine->cpu_type));
>      env =3D &cpu->env;
> +    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
> +                                        env, "pil", 1);
> +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
with a similar caveat as with the sparc64.c patch.

thanks
-- PMM

