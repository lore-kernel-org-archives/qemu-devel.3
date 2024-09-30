Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B774CF64B6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFy6-0007hR-E1; Mon, 30 Sep 2024 08:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svFy4-0007Yx-4r
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:57:36 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svFxz-0006s3-Qr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:57:34 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c883459b19so3645289a12.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727701049; x=1728305849; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RJaI5SK5VvVN/3U0o+ob6Z1YSyfENJJm/WYJimU5npg=;
 b=Efxuk1M5eJ7VsyFb8AreV4WWSREbzrnKjkB4GpPV4wylKkGzKcz9wsVyr9AzuiOtti
 END9AF/LlgMpCWl3p5+Jb6+x2C9lvPb9MOwy9d789i/r3XyD4ugR/bzsDr23e2ATyQiQ
 tR+A6Q+OBCnRblVkD9fzoCXKhao5XyRCndIAKgutn4vTL5ITPrTPr5jiWAnZmK6Vh6tu
 lUHGUTNfLXWWwG3WdwjhJjAOfB+PHH4cSIN1ylTV4aAUXDmShu1btqnyjlKIrPuv+dbK
 t6DVNfgKn7ZbtkE+JRKJs1OvivBAQFjb5OXBzD80iU9QZhLzJM3hkUJo3XucP1CtB1c0
 3L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727701049; x=1728305849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJaI5SK5VvVN/3U0o+ob6Z1YSyfENJJm/WYJimU5npg=;
 b=c1pON0nmx2DGHk/xgrzCMPLCuj3GzAmqj2v0xKjhXcdOQcZmV6+x8hFPvVLfmFL0mF
 MC3t1dnev97g/fw3Pom/90taPsutzX4T7YKLyy6flS8MPN3k/l/ir15p6jYPNBAibcgU
 s7rSJGoezi3jbQDLpk5vi+mW1/Wc85952WoBKDpU6I0iH83GWcfY1JZ09QIK5gWK0s9l
 xLK9kEyewDZUgBWpsvRTpyvFBUIAeXVeTXNrl3VhqZrfduWS14eXkY0E1w5tM0QD+3K3
 7RQPIxOH6ubdllN3dccqMjMmHsarbyhow+j3b+z0yfMaOS/E9yWKHIPFmp+gd0IJNkHm
 An6Q==
X-Gm-Message-State: AOJu0YyQmgjffbb9buwmV1zcjvdQMorPzrdEobF5Z91HwiFUD+OnX4fL
 jk+2ENe/kyRXpL/+EE08p04L5Jgfjf9EcDB/niIGQ2+yMvpq+7Rm9By9wJrGaeBz9DIOwc3FFzZ
 kdcaNXLKyOc3fYtf9yV2ptwiEjHKqACB0/Gya6g==
X-Google-Smtp-Source: AGHT+IH66oD3oqN9HHFQFg/9hTQsfBlUBCmp2m7LCdYYmXaqEcswtOIkjoDmOKPa+UCoi98oSAcB3+Uew7Ry5NgVea8=
X-Received: by 2002:a05:6402:26d3:b0:5c8:a0b1:b60 with SMTP id
 4fb4d7f45d1cf-5c8a0b10bedmr417956a12.4.1727701049139; Mon, 30 Sep 2024
 05:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240923101554.12900-1-shentey@gmail.com>
In-Reply-To: <20240923101554.12900-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 13:57:17 +0100
Message-ID: <CAFEAcA-69b=MJtqpOss97erRH8v01GdUEGLNydQaz3bVxbUQkg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Split TYPE_GPIOPWR and reuse in E500 machines
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 23 Sept 2024 at 11:16, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series is part of a bigger series exploring data-driven machine creation
> using device tree blobs on top of the e500 machines [1]. The idea is to
> instantiate a QEMU device model for each device tree node containing a
> compatible property. [1] achieves feature-parity with the hardcoded machines
> when supplied the same device tree blob that the hardcoded machine would
> generate.

FWIW, on Arm I have generally pushed back against the idea
of "create a QEMU machine from a device tree", because the
device tree does not in general contain sufficient information
to create a QEMU machine. It only has the information that
Linux needs to use the devices, which is a subset of the
total "how do all these devices exist and get wired together".
(There are some special cases like some Xilinx FPGA systems,
where both the device tree and the hardware were autogenerated
from a common source definition, and so there's enough of
a constraint on what the hardware can be to make it workable.)

> Just like the ARM virt machine, the ppce500 machine implements a
> "gpio-poweroff"-compatible device tree node. Unfortunately, the implementation
> isn't shared which this series fixes. In order to reflect device tree which has
> separate bindings for gpio-poweroff and gpio-reset, and to prepare for the
> above, the gpio-pwr device model is split.
>
> Note: If the split seems too fine-grained, the existing gpio-pwr device model
> could probably be reused in ppce500, too.

I definitely like getting rid of the hand-coded
qemu_allocate_irq() in e500.c. But I don't really see
the benefit of splitting gpio_pwr into two devices.
If you only need the power-off behaviour, you can
leave the restart gpio input not connected to anything.

thanks
-- PMM

