Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79C2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBy8i-0004Jl-WE; Tue, 28 May 2024 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBy8h-0004JW-7b
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:49:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBy8e-0005K8-Ja
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:49:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so1670326a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716907757; x=1717512557; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxUt6ACqDbtaBlBD2z5cdjz/trusH42rWRMcsDpvaFY=;
 b=wM6+YYCvjP3b4r6oQzm5scGpvW5Y9IBin9GNykt/L5nqjHcrXy3Zddk7kYcsUkqtEW
 3qI/zVPLRaNDMA7ykfv0bg2hAmmCav8kNDz5uSRvWhiQ/Z/1oYM2bqwXqUkwLWCdfKB5
 W7+T8e4BciQtV46bqsF2NySr09eS8DIKRO49yjB8mvChoKc9eYD700u2xMzQ2rMkI4g8
 RCCFhDWgFFX4tqzSEkstvHMYiHEneOI7OKLjXE7yScXUwdZhcbVK6CMRavcUsMFs8oZV
 55XPDagj5CYDDdACwucrwux2z5EPNJ16j7gIVua0/dDeLnN8phQI1mS8I8McQwpX7MyJ
 bSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907757; x=1717512557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxUt6ACqDbtaBlBD2z5cdjz/trusH42rWRMcsDpvaFY=;
 b=MtRRjKoXsYxBsxI8LlG+qjeZapdUqxeM1fHuGJO5XW3ccRLLBRlvJfO8GvgopVu5jk
 BbeYcVmInfBL3LtiYnPVWvDs4s7eElsDy2RG6os8nUTh6eRNqgX05Rj/ayr31cM0A9/0
 cpsalelEFL7eHOsxGECKLPlHjeNJFdr0j31P0U1AL3XOQQnlf4FKTMSuWJcSJUeBnjaO
 2DgxD7lTxotZwKhm2hNcq6DY2LNrmqlKeo+L9yxVRhsFqZgvNyfWPLO8sLvDD60xcrA6
 6hRDE1lwNnuhCivh3a8Sz/HZHdO5wXHABv2DeJZdJ0v75jjRds9m4Ui7lHJE3n3geURb
 /e1g==
X-Gm-Message-State: AOJu0YxKOkCQBlweXSEAk8MM85N83PCqmpZYsl/K4jfpw4jKuAma677W
 6pQKPCi2oEmFJrRF/V3gX/nW+/Kft33t3ShuO0VZ1I6skDKx8KZsdyFPk8BJFNlA8Va1M0EijW2
 s3nCMA9NJH/QAFl3akAk0ainzic8HmqXEGOtCZwLipVrq5QAY
X-Google-Smtp-Source: AGHT+IF9RxCZdQDiRmc27akKJQbQJEgk0jxIb9JFl8/RjjBhsEBSJoDfeBsWIg6NEk1sS0Kw1bj1bGK7Xay72lf3Wtc=
X-Received: by 2002:a50:c051:0:b0:578:6481:584b with SMTP id
 4fb4d7f45d1cf-5786481588dmr9113447a12.14.1716907757070; Tue, 28 May 2024
 07:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240523194441.21036-1-ines.varhol@telecom-paris.fr>
 <20240523194441.21036-5-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240523194441.21036-5-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 15:49:06 +0100
Message-ID: <CAFEAcA-30JquShwj8BH0Yt6hTdgGjRvdMgooBwmGDtOygjLWsg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tests/qtest: Check STM32L4x5 clock connections
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Damien Hedde <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc@lmichel.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 23 May 2024 at 20:44, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> For USART, GPIO and SYSCFG devices, check that clock frequency before
> and after enabling the peripheral clock in RCC is correct.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  tests/qtest/stm32l4x5.h             | 43 +++++++++++++++++++++++++++++
>  tests/qtest/stm32l4x5_gpio-test.c   | 23 +++++++++++++++
>  tests/qtest/stm32l4x5_syscfg-test.c | 20 ++++++++++++--
>  tests/qtest/stm32l4x5_usart-test.c  | 26 +++++++++++++++++
>  4 files changed, 110 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/stm32l4x5.h
>
> diff --git a/tests/qtest/stm32l4x5.h b/tests/qtest/stm32l4x5.h
> new file mode 100644
> index 0000000000..cf59aeb019
> --- /dev/null
> +++ b/tests/qtest/stm32l4x5.h
> @@ -0,0 +1,43 @@
> +/*
> + * QTest testcase header for STM32L4X5 :
> + * used for consolidating common objects in stm32l4x5_*-test.c
> + *
> + * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"

Header files must never include osdep.h. The rules for
osdep.h are:
 * never included in a .h file
 * always included as the first include in every .c file

> +#include "libqtest.h"
> +
> +/*
> + * MSI (4 MHz) is used as system clock source after startup
> + * from Reset.
> + * AHB, APB1 and APB2 prescalers are set to 1 at reset.
> + *
> + * A clock period is stored in units of 2^-32 ns :
> + * 10^9 * 2^32 / 4000000 =3D 1073741824000
> + */
> +#define SYSCLK_PERIOD 1073741824000UL

Rather than doing the calculation by hand, it would be
clearer to use the CLOCK_PERIOD_FROM_HZ() macro from hw/clock.h.
(If #including clock.h from the test C file doesn't work for
some reason, you can copy the macro definition; it's a one-liner).

#define SYSCLK_PERIOD CLOCK_PERIOD_FROM_HZ(4000000)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

