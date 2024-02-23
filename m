Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265FFC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXLw-0002Tt-7l; Fri, 23 Feb 2024 10:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdX9d-00043I-02
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:08:02 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdX9X-000091-Aw
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:08:00 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so1179871a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 07:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708700872; x=1709305672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIv1Gk06z9tD/JisRcZsFGEjcZYehPqjDSC/Xnt5HDE=;
 b=Qoe//JRjwV6wk5fUAyiqD5ayaZDoLHEec8lq43e+5yBAWlAIewzhP6a7KAYcyo4HvZ
 oz8Xq3P7LPzV7WA2MPrThZHWsNw6JV+S0sSkeX2C5xx2MpOHvwYJHX7agWTsZKB6CubE
 MN93nM1G1tQOHsubpcmAYhu1eeLaqiJ+3hqW3Cx0JTQ2Igt0IjLq7/Z4/l36snT+Y74r
 zGy5IYX28UQx1QVRrQw8vttgdVQVHsy5kNbYsJ+Y7ITCH0Ud/Sh5j+ysCwVeEZN2WSOK
 XS+GdqDo303qqz/acaR8E7xIRqVtwW0yDSDbyRMKBtrp/B9KiodS4LtmXeGKPTQOeXy5
 CEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708700872; x=1709305672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIv1Gk06z9tD/JisRcZsFGEjcZYehPqjDSC/Xnt5HDE=;
 b=YgmHWqv+CKF6Ir1QbixNYmbT17PV6VWXsLPezwjSZPMK+Yw5mUXH4AaImvcC3tunjt
 yVXIO6P1km8MMNyBAnMIQwmqI78vYQqor41+I57SdKEegtk/yihTbnPmAj6V+aSrJLAZ
 MYmUHvgDjRhDu1YgaJjsbr9xZfqrMzg05/s/1GOzzJAgFYDjso9vUwJzs2VFyPMz87Dx
 iYVA7saMKb7YqJVqAnT9n9evAiYOnWBtdt6tmBtSwK2miw1nvZ5kW+2v7yiIJl5hostz
 CuRzfPyp+wjUy1YsJ4wZKtrmD37JzNo5swkkn6Tc0/Ln6M785fgZz88dlJhRPwJLUaQW
 o6GA==
X-Gm-Message-State: AOJu0YwOwI3c84zImgUHtpmS4WU7r72roEA74RZbD2zO5IcIarUaHMP4
 coHhyOFqp1HlVrTMdjp0PpGmA9kkIKuPbeeUYhJnuy4+oUnNBGlNdhr2be7bVui7+o64eZQNty1
 q7i9F6TFAPbDIf6vSKgTuUFT2KCKme/EaJE+LQQ==
X-Google-Smtp-Source: AGHT+IEdXSLypu3BBsI7G1VNCkZwMFrDMF4KClpNbM4D6DySkJMllARArp6r/BF5+W0CpbqBarogDJLG0sJ/dtXhHW8=
X-Received: by 2002:aa7:d912:0:b0:565:6c31:9a47 with SMTP id
 a18-20020aa7d912000000b005656c319a47mr88048edr.39.1708700872202; Fri, 23 Feb
 2024 07:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 15:07:40 +0000
Message-ID: <CAFEAcA9Lhw3KLEKwra86JskDrNgvi8N91efTH1aZO=YTHUknAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add device STM32L4x5 RCC
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 19 Feb 2024 at 20:09, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> This patch adds the STM32L4x5 RCC (Reset and Clock Control) device and is=
 part
> of a series implementing the STM32L4x5 with a few peripherals.
>
> Due to the high number of lines, I tried to split the patch into several =
independent commits.
> Each commit compiles on its own but I had to add temporary workarounds in=
 intermediary commits to allow them to compile even if some functions are n=
ot used. However, they have been removed once the functions were used. Tell=
 me if this is ok or if I should remove them.
>
> Also, the tests are not very exhaustive for the moment. I have not found =
a way to test the clocks' frequency from the qtests, which limits severely =
the exhaustiveness of the tests.

Where you have a device connected to an output clock that produces some
useful behaviour dependent on the clock frequency it is given (eg if
it is a timer device that has a timer count register you can read or
which will fire an interrupt or set a status bit after a certain time),
you can do something like:
 * configure the RCC for a given frequency
 * advance the simulation time with clock_step()
 * check that the device connected to that clock has changed
   in the way you expect it to

But you're right that we don't have any handy way to look specifically
at the outputs of a clock-controller to check the frequency they're set to.
It would probably be possible to add one, but we'd need to enhance
the qtest protocol to add a "for the Clock specified by this QOM path,
return the period it's currently set to".

-- PMM

