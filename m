Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F3CC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razY6-0002nB-Us; Fri, 16 Feb 2024 09:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1razY5-0002mj-Br
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:50:45 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1razY3-0006M2-Jf
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:50:45 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51299e0cb8fso406521e87.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708095041; x=1708699841; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MDiqs+U5t0NptwhkjBiPyr3hzIQRm866Qe5lQWxu8Gs=;
 b=EfTrkOlUeZRHXRfQnF5sX//QC4O0EVw8lE9GVdtBf1a82FqYcRnppSLawN79LBoVGb
 j40rthDn6sdAxyx5+4qr/OJwlXokHlek3LQoJu3vcDovHZeiqQBPgIPYFGmHxY7GWpLi
 OARlQh6uaWXj+XupKnpwL+2eR0RUhfdBUouEcfXrDa0BbLSN2aDuVk7qdIwjLcW2BMb3
 ELtm0YJo8SvSN+8yZ7dbprAqUlR3ITTIZK7l8n/Et8jI5e3cHHwsu+zFG/Rf6H8GfPaC
 aj3OM4VFfDHOXMmxoiaeVWgxM46nt7nejfNrCxSe2f7BHk9qW9K2yOtepkCzHHl7zn5o
 vkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708095041; x=1708699841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDiqs+U5t0NptwhkjBiPyr3hzIQRm866Qe5lQWxu8Gs=;
 b=AcQ1s58mWMPGCZ4Zj7vVyjPTlO4wn1jL0F6Oz8f2poZGJd1jndvNE9V7KbdAo7gpdO
 K1mYY2jiRA0RgPY8NxQwbYpNX6rrluDcCnP0XGhUBWnDc8IXo7rrW8VL6pCFD1iyoVVY
 BhBCDbsWqTc3QCo8rF2KA90U1BHWXoZpsVBDfpwsps20TRwgfi2Lfc90we8DbC6ks3kA
 ut7hAyvYXZuPD275Ao6227IeEt4ExdiiLiEKN+i2HR3AmoS9FSxJw1O2oyL7hdQv9xAI
 049SfvdonYMX5qRRz8oVNniWr5M0+I4jZSSQro40AoSqtKrhrL1oZeWmhEyqNb/I539s
 jXcw==
X-Gm-Message-State: AOJu0Yzx5QWxztDH4GthCExiHFeHgD8LewLksRQahjqFUMV9CbzBeUsj
 ryC2YdOyNc0TbB+/zwaYcjhIt9KJBfNRyc/6KOkFn+k2++ezxqXnKWmpmvXzsrXMYcAg4IwDzCN
 nse6pn031B5sHetmu1BnWxDgYiNqfbIJFgrkbAw==
X-Google-Smtp-Source: AGHT+IFiHbqsP5Mu2ffABz8wJW0YB/R4HkODSix39M8LQ4tNdei1gde3oUSrGaNEDAuMgS3uj9JAqmp4n0qVw1FK9GA=
X-Received: by 2002:ac2:4c13:0:b0:511:19bf:fa0c with SMTP id
 t19-20020ac24c13000000b0051119bffa0cmr3879076lfq.56.1708095041542; Fri, 16
 Feb 2024 06:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20240216135137.8668-3-atp.exp@gmail.com>
 <20240216135137.8668-5-atp.exp@gmail.com>
In-Reply-To: <20240216135137.8668-5-atp.exp@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2024 14:50:30 +0000
Message-ID: <CAFEAcA-FzZTT9twzPP7KAvqvkV5GAjYGM0cfV35jYa26R3cKLQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] misc: pxa2xx_timer: replace
 qemu_system_reset_request() call with watchdog_perform_action()
To: Abhiram Tilak <atp.exp@gmail.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Fri, 16 Feb 2024 at 13:56, Abhiram Tilak <atp.exp@gmail.com> wrote:
>
> A few watchdog devices use qemu_system_reset_request(). This is not ideal since
> behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
> As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
> to reset when a watchdog timer expires, let watchdog_perform_action() decide
> what to do.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
> Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
> ---
>  hw/timer/pxa2xx_timer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index 6a7d5551f4..6479ab1a8b 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -18,6 +18,7 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qom/object.h"
> +#include "sysemu/watchdog.h"
>
>  #define OSMR0  0x00
>  #define OSMR1  0x04
> @@ -417,7 +418,7 @@ static void pxa2xx_timer_tick(void *opaque)
>      if (t->num == 3)
>          if (i->reset3 & 1) {
>              i->reset3 = 0;
> -            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            watchdog_perform_action();
>          }
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

