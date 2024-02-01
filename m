Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63553C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZm9-0004Jq-Vx; Thu, 01 Feb 2024 11:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZlg-0004Gx-MU
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:18:24 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZlf-0003KX-5c
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:18:24 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55a90a0a1a1so1661232a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706804300; x=1707409100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/odLJmMeHyuqRUqzmdAcU+qyr3LEbWvoXulvRLZ69w=;
 b=rlLzP4LfhEsHCrYS/sMf8cnGwK08UT9Ri+SmBZAtP0BApkBTnvRG5qrjE/DY4yNcJS
 D215t4FN2yTXfoNMIVFH5EttxUYxSt5fjZCMZhu+EltlOp2fGe/JYqW7tpN9/2cZZ5M4
 Ko2VIGjGivzndUAc8YSygUnDCVC6NE84DPvQ9n1UWw9xuPj4Y5PPcH9gVfavU4XQ+QWa
 3X09Monzj9wTi2dvblzCUdbO1ex7t2XuOlmowCDU9qsXEAaHxGAfQYwxhwIFFzVaWsAT
 NeKxyWUtBFEldpOXgklfifpIQgtq5NHqBWUfoGYnI3drYvwhnfS/Hw+fGfbBtRCw2lL+
 ZCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706804300; x=1707409100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/odLJmMeHyuqRUqzmdAcU+qyr3LEbWvoXulvRLZ69w=;
 b=Wn3hqimZibp0tMwKX25u37dQSEVqYOgalYpEMeWzRh4gCzWFgXV9OsSPsHKTz5RErh
 V2xSTtqspBAd+dXNlIjn/B0uPOjJxw7Dn6U0wTLMbF79GRlU6964ft4G1LnzeE+dbeeD
 lpxZluLL4gdBVsyteOsGBrVoB2yXljMKUOc23At3ooPfUUKaMioPxBS39Qrkj7jTPPx/
 xIz7ZALruim5010Dm6IJu5x1h4toEYOg2+hRqtRTkGyEiuQZ3KCBFlMZ1U0Oyna1QFYy
 RpQoqGOsAim19vRVnkstFIedySbQVOyu0rFB4KmPYfw4U1U6HG86WYtxJqK3W268BrAZ
 JqCw==
X-Gm-Message-State: AOJu0YwYei9L6DtxLOvbLJlcE8OmdAkdnu0LiBGiCy5XfkzlIpy/S0EI
 rdEyg/bEmJ6Bs3TTDYM+k6w9WvYwRINpiMhDXMtK8WCNJ9UG99gp6vpIrwLzPO+dwVVJjU2wfFv
 66sveLDGl+BQeGusof/5UUL9zAcW82bga61ddBg==
X-Google-Smtp-Source: AGHT+IHIfbfdx+wBpHt+B0kRrVMBDpNPQ6O0osw9lwKIOw9o6Xd3mXC1zaV5obugAropGrqW6qF06cw7lhIqMnJtxlw=
X-Received: by 2002:a50:e606:0:b0:55e:fcfa:607b with SMTP id
 y6-20020a50e606000000b0055efcfa607bmr4153847edm.32.1706804300171; Thu, 01 Feb
 2024 08:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-2-philmd@linaro.org>
In-Reply-To: <20240130190317.25692-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:18:09 +0000
Message-ID: <CAFEAcA9+HHFsE9KX_54aFwSAp_GKKHX6s+O4thMQ2K_n9FuRMw@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/arm/stellaris: Convert ADC controller to
 Resettable interface
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

