Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25A2C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdBbH-0000H3-Fx; Thu, 22 Feb 2024 11:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdBbD-0000Fw-QE
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:07:04 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdBb0-0002B5-MF
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:07:03 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso10386784a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708618007; x=1709222807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRFafmZ5F11WhBARmug4Tv7dviM8f7AwVodDaKGt/bw=;
 b=lhmZ+OUuLl7uBoe+l8Fxs2XuFuyiOXlj5k/8qSVvJZYj8x/tpFCDZSa42z8LAdeT9j
 cvim4wnuvPtXQpu4CV/6uwqmqo61KnJhx8kuZA3BznPle5x7y2rx/fHTHTPrq0Blo0il
 77Bp4LX9qwHt5khilJ6CQ5oYNhenGyCrLMj95hzWoRBSnPUXmWOPr6aeDEi3/t/zu1M5
 XWgSwlf4nseW0vq4eXoj8X1ykrAysw5km9BmGnRYCYNz9JabS1NNhgPMF6b82obQu9Ns
 fGtS6NR6A0yN7tnO67idW8Wp+vTrgnf78nHLARk3nJo9fnAsytAZarQ8AMdPkjKkc+a1
 IWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708618007; x=1709222807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRFafmZ5F11WhBARmug4Tv7dviM8f7AwVodDaKGt/bw=;
 b=wT+54Dv3IXI6jXjSZ+CBvivfSpvgRwlJJJkBu6WWpBfbCJ9aU3jpDSUhJBo63pm1Bm
 ogZsXHkiQv6yo5G609BXQO4RWslefP59D0uw9TXISjSKLT2LVoa5cjz9RXnwgNVd3SsG
 PJOr9odWc6Qc03cJiqgIN1KLkE8L71Pq0gK4vNLJL0wJqW63shvjOg1eROK5z3IHktF3
 ChkRZXbAFDiYNWLY8WW9OGw0hL42E6gF9iDML3w1Aj1KEUzV0MXnu/QNbsXy/pvIPF//
 eenlX9HNoFbB4Fi1MTPVBBhqKmqeMDVPVQoJpTowfrifI4xHTJqIf+QlwGYTkkxqxYtJ
 UOAg==
X-Gm-Message-State: AOJu0YxneTZa2GK9/+VyI/PNYnvlZTqUKHYE7W/NgrqIq6vDSiULY8cC
 Ne43q2zZen6Zb/sNvcpF3C3ih58V5VajLy0qhJnhLljuScm63xdEW0B0cTrQCaMr7VuKst6N2Le
 gSadXiXKdHaulDpglFt7KHUWpy15g/nIBqYnnqA==
X-Google-Smtp-Source: AGHT+IGrdFe2TskJtuAY5VKsf+FdZgEfktUkMmiAWEr8jM17IJnlh81ZLMrMl7u1SqipPS2OqKy7YCv82Ruqq+SjZcA=
X-Received: by 2002:aa7:d595:0:b0:564:405c:dfa with SMTP id
 r21-20020aa7d595000000b00564405c0dfamr10701416edq.17.1708618007524; Thu, 22
 Feb 2024 08:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20240220184145.106107-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240220184145.106107-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:06:36 +0000
Message-ID: <CAFEAcA-m1vtGZJWeMWsYnjJKK=jrxWj_AXcmO43kG=_ZCqPdYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/arm: Fix STM32L4x5 EXTI to CPU irq fan-in
 connections
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Tue, 20 Feb 2024 at 18:41, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> The original code was connecting several outbounds qemu_irqs to the
> same qemu_irq without using a TYPE_OR_IRQ.
>
> This patch fixes the issue by using OR gates when necessary (1st commit).
>
> I attempted to check that the problem is fixed by using a QTest (2nd comm=
it)
> but actually the test is passing even before the fix :
> when any fan-in input line is raised, the output is raised too.
>
> Changes from v1 :
> - using SoC State fields for EXTI OR gates
> - correcting length of array `exti_or_gates_num_lines_in`
> - using a for loop in the test for more clarity
> - correcting typo in test comment
>
> Fixes: 52671f69f7a4 ("[PATCH v8 0/3] Add device STM32L4x5 EXTI")
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>
> In=C3=A8s Varhol (2):
>   hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5 EXTI fan-in IRQs
>   tests/qtest: Check that EXTI fan-in irqs are correctly connected



Applied to target-arm.next, thanks.

-- PMM

