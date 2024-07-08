Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDB4C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpiG-00026n-Gc; Mon, 08 Jul 2024 10:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpi8-0001oR-5P
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:51:27 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpi4-0006tw-O3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:51:22 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58b966b4166so4799827a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720450278; x=1721055078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcWaRLCRcltFzrZD7uyMSRteYZApdqogMNAhv6d5RII=;
 b=yWKqKmkXbrM5X3EwJcWcLJ76xXwp9iVJvBFKAn74v0G02L6LJPWxjJvGTxDtrGB2be
 fh7hyNZTxci+8810mqYeAZGOKmisb+WMN01/RqMZmNdRCLqZg8UQoB/gNGQUa3tMk7Iu
 upFFbA/LIpGuhH+cW4Jtm3cBUWSPNtLOjyTyaLR1GNir6tYztRgVsz5bgwSBE2zy9oWZ
 4fiZNefaO698zmOWjoTn+xZ/mi6uE+3zaJ1Z9Xa6haxo3lw0UlDcxCQtHd2m7AZ1yJGJ
 vu4f+R4hYt3ogHX5cuDvia4Ooau34dE4fPJnUb92oxWXoYjdagiOakoYNjuBWYN7DI+y
 atBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720450278; x=1721055078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lcWaRLCRcltFzrZD7uyMSRteYZApdqogMNAhv6d5RII=;
 b=W9xAWWGH9TBr2+IEnIdClKOk4JeVDHPMq8ejwgyD30829Cuq8FyyW1kAds7Brz7VEg
 h0xnAbynlIky4rKRgGuuez2tA54jigwpaJmWxAViz4FTGBm71ltj9pWmcRLbRnM3f+4z
 5F8VtF5aLr28JH30M0iXKxwOOITXOPQuGIybdT/qmdMzMhv3P93hHCsQcawpOxrV3/iA
 lN8acFHAzEQJukYE54TEBXrimLeAVewwNExnhmrQOGFU1K+kOZTdzK8Fd6eCcawhinZO
 PofiP9j0bBqvYaJSuPQcHJL4y6fTbDWQn7NR7HwWFlvVexf+OyZ816KvAm0jQ3Y1mLeZ
 c93A==
X-Gm-Message-State: AOJu0YzAE0yblxMz2PeNlil6QbvBOYWhoxpI6iDPEmkK8HBfyetvSZZB
 9yieDcr/dJOhLJzWHdzJbyln60F8/reVmt0k0WPjXW1hfjJ/k+XqBQnEzn7nF5IvwUMEF7z4tEC
 OQ7iz4emqhSm19tOrhz3EeeLq1A1fOBFJDrVdNYPvHRI9JYaM
X-Google-Smtp-Source: AGHT+IH+OslzLbYqJR2PY66CX2frVHo8niVZlaJuLr0f8L48TvBYAUkiqD89vSKXS3xfN2tOxwDckWq89Lb/UwGHhBU=
X-Received: by 2002:a05:6402:2803:b0:57c:c10c:eee8 with SMTP id
 4fb4d7f45d1cf-58e59b3f7f4mr9113069a12.19.1720450278145; Mon, 08 Jul 2024
 07:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240707085927.122867-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240707085927.122867-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2024 15:51:06 +0100
Message-ID: <CAFEAcA9MDLPAqQWMADPupSJmheHuCPUnf+9Uebrt9x+ikZmRaA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Connect STM32L4x5 USART devices to the EXTI
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 7 Jul 2024 at 09:59, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> STM32L4x5 EXTI was handling only configurable interrupts
> (such as those coming from STM32L4x5 SYSCFG which was the
> only device connected to the EXTI).
> This patch adds support for direct line interrupts and
> connects the existing STM32L4x5 USART devices to the EXTI.
> The patch also corrects the handling of configurable line
> interrupts in the EXTI.
>
> Changes from v2 (2nd commit):
> - The 2nd commit was split, part of the changes went in
> another patch correcting EXTI configurable interrupts.
> Stayed in the commit only changes relevant to direct interrupts.
>
> Changes from v1 (2nd commit):
> - add STM32L4x5 EXTI status fields `irq_levels` to track
> configurable irq levels and do edge detection
> - use `qemu_set_irq` instead of qemu_irq_raise/lower
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>



Applied to target-arm.next, thanks.

-- PMM

