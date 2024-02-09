Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807BCC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYP9L-0006al-Mu; Fri, 09 Feb 2024 06:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP9G-0006Zy-0h
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:34:26 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP9D-00072l-MF
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:34:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-561519f8698so59256a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478461; x=1708083261; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73iO4c+i9wnBB96XwVHe+I47pyjo1KSVQ1dMP1mpyFQ=;
 b=oH04UQ1F9f7gYjADO8ScX8/yXBJjZ5FQez+2TQB1fCUJOnW6SQCBQ/k4g76KY0M01A
 GDVMfqwmcqI0/coQ3F8sWcitI90p0T6NWU5huJSp734usl5OX0Hvy6QPhYT1bkIBOsT+
 DH5jRrhe9mLOqn6NttqYjvdYz9bQNJVIG3xpE+y5v4D2BUtF1r34n3kEHwQRNShGv4HO
 SPBjN+NW29HZNeekoo/wSI5Xz8DzSaOxTPQ4PKr455k18O7J1E43LM274HlyqVJdZjpz
 3HTQejcgObQ4jtbtDCeRy+NBC2pvSiTya1EVNyBlGEmmE4rxrAo1bnmQ5zsNgB+J/zM1
 1Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478461; x=1708083261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73iO4c+i9wnBB96XwVHe+I47pyjo1KSVQ1dMP1mpyFQ=;
 b=V8cB7KrBlBftSj7FgDqLUTRWGp9NWlJnxxZEx6pTtX63RV/AZmZylXN6tC9uaCKmJD
 yamvOT8ctNUii58RuKQjAJktyGSL0p60jfFlphzLCAlMjff/YchDNgG091BCWA4yWMZI
 Mge0GD/aRT87PUuZB8IoJIoXiqNYX7ceR2wsMS5TTq70U7WcA6nSyupGYlOSlkw6IcPh
 qrMm6nwpZsRlxugFu+BsD2x/sDVg8BpN+E5kq9GLV1D13gDLvwEV9unJK4jC8YSAYtP6
 pbZnSYGkgDxWh/jHLVRXdcEN7PxZ38H7Gvy1bSM0QEyvAd66uBANxNZoF8mud61AySre
 j8YA==
X-Gm-Message-State: AOJu0Yw1uIYvrAqghuCiFxO4qjIeRd4kd7cf1gwsSTO4IrwOsi8yE2V1
 HpyorEgmp1h3ZCIo2nyA0s9cHIKFxLj2o3XpRTRb75DuU8k9qKC2pNe6UcJNRIfGtP8E57Y31l0
 YJgZj5kdWzyjYQxm5oAE8ARO+uUK7EZzsBGnQUQ==
X-Google-Smtp-Source: AGHT+IEXhDYMtXFZegdJf6cc7C07e9wzKcREENIRK9X9xal5aNJh4A+5Jwr7NY3sgHI6Dk/mtKuXOv/XYWxARoh+DTU=
X-Received: by 2002:a05:6402:2902:b0:561:3dcd:3e09 with SMTP id
 ee2-20020a056402290200b005613dcd3e09mr1302227edb.31.1707478461675; Fri, 09
 Feb 2024 03:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-12-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-12-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:34:10 +0000
Message-ID: <CAFEAcA8XF4i7qNWRAO2PjiNxecLY8qfGzYK-ZDE8fvy7mpf-4Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] hw/sparc64/cpu: Initialize GPIO before realizing
 CPU devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>  hw/sparc64/sparc64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 72f0849f50..3091cde586 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -24,6 +24,7 @@
>
>
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "cpu.h"
>  #include "hw/boards.h"
>  #include "hw/sparc/sparc64.h"
> @@ -271,9 +272,10 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, =
uint64_t prom_addr)
>      uint32_t  stick_frequency =3D 100 * 1000000;
>      uint32_t hstick_frequency =3D 100 * 1000000;
>
> -    cpu =3D SPARC_CPU(cpu_create(cpu_type));
> +    cpu =3D SPARC_CPU(object_new(cpu_type));
>      qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
>                              "ivec-irq", IVEC_MAX);
> +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>      env =3D &cpu->env;
>
>      env->tick =3D cpu_timer_create("tick", cpu, tick_irq,
> --
> 2.41.0

For the purposes of letting us enforce the "init GPIOs
before realize, not after" rule,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but it looks like this code is adding a GPIO to a
device from code that's not actually part of the
implementation of the device. Ideally most of the code in
this file should be rolled into the CPU itself in target/sparc.

thanks
-- PMM

