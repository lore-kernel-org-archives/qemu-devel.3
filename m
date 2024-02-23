Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6A1C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZR9-0003qF-Ty; Fri, 23 Feb 2024 12:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdZ0f-0006ZV-8f
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:06:53 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdZ0d-0006LK-JE
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:06:52 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5640fef9fa6so1375194a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708708008; x=1709312808; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bCMMo86psNeJZCuJrJCFsnR1RQQH5tGN/zrD06/nxDc=;
 b=CRyrim6dR/7FM1OyVnrVpXHoBDhYY4yBmFfu9/nPI+k3oY+eQUYZ+LDtZcLGxMWLYA
 ts5rQ2lk4SROKw6JM1wuSAmVSXwOEV61s5UUT/JJRhloBCSFegt2Fnob8LMyTlytHPkW
 vhohL0GTg2MORQLbCnkf1wPEQYjjk0sjIYGzpV5J9YkB0nI1vzxwct+P9umuSeWOx6Yg
 jVk9W7KVsA7NEVvV9lTYyWyaQsXnjXWTysXwfS/DFtsXuIluLFicC2oky3F5CO8Ima3g
 doCW9RHgt45Sf7BWMbswgr2RhBwzW93NYEUdC+FGoUQCk7Cl5lsu3YFsQRiwHo6U61fl
 mLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708708008; x=1709312808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bCMMo86psNeJZCuJrJCFsnR1RQQH5tGN/zrD06/nxDc=;
 b=Z8OuY/fIayKyT2roPxs7ZQdtKaSFsFlnvkeH5uQxPV7xlbpJFhwZXmKET9WwU/9wsC
 kSmw0hT+dBm/Ia3kJCI0tgDJHdjjOdVHVptMIK24VI96r8MKgitjtpCP5DMGG+HhKhFe
 17FwUb7obPQJq1zZccbcAq9gxs3XxL1ZhTkcFc4zTwx0/ezYRUGiSCkANQMiqBUWgAqe
 fnz74T/xaEeIAM4DdrmIW66/rZnzEIvGn8STm+xUZJKPzokl5FnN/mNNEo4AHn3aSdzu
 b7Ex+U0md+e03fk6zJlIuRqlGI9Hcms9AylC73AvPMgfrztQvGnRZkAH7gZ/mZE1Hpi3
 j5PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7UmalXmlmwi9LFVXl8Z0naAlf9PsRlNPjt5RjenCe4Ux4BWJUjbYX/Y7sOaRmnJX75bOVmT2eMMzIPhK8Uvwrbaokl9g=
X-Gm-Message-State: AOJu0Yw7jvVIgSpAmLz1xOgjgpii/ksT48gr6/ZV8Why1JCYqlJx0q4J
 /IwHITSTZaBWbbPkZAfwcw6zzsl6PxB/XonPDmOt0+kBZifzvYRe5+7c/tcRM7qspgbOLeNgZH8
 07ERh/9efbnQ7ugNFsVZhbtRncB5GgAOGvtg/nA==
X-Google-Smtp-Source: AGHT+IG9/1MNprwtUJ4+fQS+8YeUXLXOjgGP6e+Nn4p4zPllpkRbwvbDb5velgF5FCMIADDKEo0pQ87KtoyTxESSgjQ=
X-Received: by 2002:aa7:cf19:0:b0:565:3907:be45 with SMTP id
 a25-20020aa7cf19000000b005653907be45mr319772edy.37.1708708008689; Fri, 23 Feb
 2024 09:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-17-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-17-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 17:06:37 +0000
Message-ID: <CAFEAcA9-yfxyvOsk=5Yv8WbEi8rvrRHfybiAw164u8HsKyN8SQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/41] Add RPi4 RNG200
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 19 Feb 2024 at 01:20, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     |   4 +
>  hw/arm/bcm2838_peripherals.c         |  14 +
>  hw/arm/raspi4b.c                     |   1 -
>  hw/misc/bcm2838_rng200.c             | 405 +++++++++++++++++++++++++++
>  hw/misc/meson.build                  |   1 +
>  hw/misc/trace-events                 |   9 +
>  include/hw/arm/bcm2838_peripherals.h |   2 +
>  include/hw/misc/bcm2838_rng200.h     |  43 +++
>  8 files changed, 478 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/bcm2838_rng200.c
>  create mode 100644 include/hw/misc/bcm2838_rng200.h

Compiling with clang detects an off-by-one-error in this patch:

../../hw/misc/bcm2838_rng200.c:119:32: error: array index 9 is past
the end of the array (which contains 9 elements)
[-Werror,-Warray-bounds]
        fifo_thld = FIELD_EX32(s->regs[R_RNG_FIFO_COUNT],
                               ^       ~~~~~~~~~~~~~~~~

This is because N_BCM2838_RNG200_REGS is 9, but
R_RNG_FIFO_COUNT is 0x24 / 4 == 9.

N_BCM2838_RNG200_REGS should be 10. (The regs[] array has
an empty slot for the 0x14 offset.)

thanks
-- PMM

