Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD9EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdro-0001i7-Rs; Fri, 21 Jun 2024 08:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdrn-0001XP-Bh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:59:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdrl-00019h-MG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:59:47 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso2321862a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718974784; x=1719579584; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+drZjJzYbee3AGMGFwQ0cOXoH69Amp2mQAD/LCIzUzk=;
 b=QsVDVackZANKU+LXoQG+OsXIiFAKB8qh2RcD+Uco5XSGHBl5wBBxsXdB4JUzz8664R
 NZVU02VZdbcTvJF2YrAo0HeIXiTUhWVumIeS/IuIWvNlJ5rci8oIjZplefXw6HOXDR35
 df+t8J6893LzUVmpP+uD4wbU1neYILowHbpaKXtm0BTy8h4bVVG/GCQFkGDH5d0D/swJ
 yD4VREqGQGHoTfXFQKBlNU47jgVUkVtBEPk/5uPcJ71NEmurD9jPqA8N6j1dqdWhy1DG
 cSxqkPaYswTLxqg3c6ewGSnGYXg/eiTohLvpKMWEJIAYiX9Ec1jnBI/aFfmMINrqjsjW
 +ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718974784; x=1719579584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+drZjJzYbee3AGMGFwQ0cOXoH69Amp2mQAD/LCIzUzk=;
 b=DDQM7mTham6g2v4ARRvjFzuc6taK3QZ2tRprxQqoJaKpNqB7UlAy73TBBE6yd22oYY
 zsNCbgKD+qhjYn1nZVAry8cNkRAhRkWuL99pOiQLwyYGeow1TBrKf+/DV533SpldrAHi
 fu2bwnvDMYvEF5wLyln1pl+ht/5+wR9mh52BL01U9ehSTpT9T3Ud2sU4SjlVMZl7Xb0x
 i3vECycpV7+0l/mowKXSw7XK8d+4VBOYewoPv1x0MjnSizG4JTQ2Ri3IkAQsLFrksAV7
 kP3NXEPH4NO/0SFMW9mXifolQEdaUVfGnbo93pYYWMUNwk8mIo+VvRRHlZOuzBCZhl5z
 SK1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM7xZ6JPdqkAB/hdZ8MwgVQIqJhiRNBfZ9bttdiuNswk39Fm8uwZvoAwxJG+SBeeJgRqU8bylPHffnVX7NPwVomsbD+vY=
X-Gm-Message-State: AOJu0YwKhqHnVtPEo/ciXDtLarbbKyKpi3+SbqyIjW8AY3vaC/IXGfGL
 kz49awDugq1pVlAey9MMoyxyXgEUvHBKj2zKsVMaOrj6qx7rRwbrtp5IcPWs+KB/XnqpBcxJFRi
 K6yKgNKOMZXgpPXTQOoeQTrf6zZcjEHqxz7fLjg==
X-Google-Smtp-Source: AGHT+IFMfp1RgSDM+Td0TqwRiWqCfdw5UMql5HtQ5zm5HlKYKXKHbLvka1J69X9Oqq8Vdc0NR25bX3r/eScHq3BlohA=
X-Received: by 2002:a50:8711:0:b0:57c:da58:51e7 with SMTP id
 4fb4d7f45d1cf-57d07e18fa9mr5445522a12.1.1718974783830; Fri, 21 Jun 2024
 05:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240618135550.3108739-1-zheyuma97@gmail.com>
In-Reply-To: <20240618135550.3108739-1-zheyuma97@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 13:59:32 +0100
Message-ID: <CAFEAcA8uf-hSP7=w3om6XX7u+v_bQs_qvR1k=XhBp2bzF40Z3g@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and
 MCOSEL values
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 18 Jun 2024 at 14:56, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> This commit adds validation checks for the MCOPRE and MCOSEL values in
> the rcc_update_cfgr_register function. If the MCOPRE value exceeds
> 0b100 or the MCOSEL value exceeds 0b111, an error is logged and the
> corresponding clock mux is disabled. This helps in identifying and
> handling invalid configurations in the RCC registers.
>
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine b-l475e-iot01a -qtest \
> stdio
> writeq 0x40021008 0xffffffff
> EOF
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/misc/stm32l4x5_rcc.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)


Applied to target-arm.next, thanks. (I added a line
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2356
to the commit message.)

-- PMM

