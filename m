Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C48CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQqY-0001GU-Ps; Tue, 16 Jun 2026 06:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQqO-0001Fx-2y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:16:33 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQqM-0005oi-Hf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:16:31 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-662bf1dab83so336988d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781604989; cv=none;
 d=google.com; s=arc-20240605;
 b=f/zEtJK4TRTMRyVsXU32waZkV5DDHKsvl+dbraoF+m9Ymmy4/shFrzenGf5u1Jewin
 uPHVn4dYK4C+obSWfX8iDADUmu37OqArmFprSByL1CjEbMc5I398s0CEPzDE6YCXWxbQ
 sW+ByW3COD6nu+hKXn9JoiMhoSqKN89f7xSVdIn9a48cMPlSpTLLLc4Fst6iWRiC5Sg4
 R38CtLuC41mJzF9LAT25SgYCCDep6VCBMx6hUkswYWqBLRELHUEpNtzpgz1PyW+tbqMv
 CnjcJdZtlM1hPNaXe40UK8wN6OiNlH6CrA/QlqaLZmbTOdRlTE9VVVY1i8SUNRg6mOJN
 6A7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=67VwDOiF6z7LrA5/2mk+m9oj5/5e+S+/mWvEl3MY2Tg=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=A2Q6dWXtGK8uzhN4H4W8NG5aTqx+0d2lIvzdCCWHN5Db5OVbgmb/g/yDrZGNMtlbaW
 di69tAiroUD0Mv0KDmcT5nJKt57yxgFxCeWge09/vuoEJC7+tN8V7ijbHKUvTGi8zC8j
 SlbjsTbo9tgttrwfwa3EpwokCpXc1OJa2cZO+6xbv9MGEpBIabuMVdQIc0hYYE0agVrO
 FcCDS9A2Q53oBpEsGuNDmewz+AXWG4yh+EFwTJvezcnGtOH6pDlqgVGfTppTnTVSiWca
 4m/d9WJWuC0AQf/8vtiXz2wWrUM2T5yaL7GH9LvlY2EmQ4TUJcOX9vnIsvsEn7+zSiT0
 Oyvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781604989; x=1782209789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=67VwDOiF6z7LrA5/2mk+m9oj5/5e+S+/mWvEl3MY2Tg=;
 b=SDMUCVByJHZBBclptS80EbhtiNjxi+TVjk47BiU+oBZNsKhdE98lgRPyZUbLu0O0y2
 rbLkitPgTG0KHn7FOUg5c/SYErRJLC58rr4RzKdTUdi8Pg90ouOxkWLrnbJmb4UjkRi/
 yr4qQvahZrXA0RjZ7Gp9IlKancznegdcbDfquDI5S2VS3dFfS/N3E8yVVnJbgUihkjQT
 JkE5oW6UF7TTMT0XR1uyqmKbzUL4B7OEdTLGlRFBhrRPNeWAQU3cPHjUAGKujhVLySAD
 DGH3siJpUGZCGMKMgU8dAQN0MuCzzgDKt5uxX1AzS9PtleOKGvL5rcb5Xs9datWkEzVz
 8D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604989; x=1782209789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67VwDOiF6z7LrA5/2mk+m9oj5/5e+S+/mWvEl3MY2Tg=;
 b=SKV5mLVWX/B1P7Kq8pcGRxNnHQZPI9Ky5fsHkmIv/MUpX7fh41G/lLu0QGT0JdMgGZ
 61OjehVwY+2WDUKw4Dnw4a2QhcRwjWfHR2SmDVCkJjPBtnO3MGHjX7oQrxd1r8yNltqr
 oQd5U2nwYPnupa53lSLxTA7UymqWUDqX0JDIDYD9aOR9QGpF7PN3fWGc0fyJQ20R4mEY
 ODXfREFk/MpffjILamQOOt9qnqseMX4vEJalpOdvpdROK3IzmQA5fkhFN3AVVoqc9+Gm
 F/DLPpZ8ZCA7PA71dmIWy/FY/vcj90rSOgN0SFS4Mu/L7dH7diW1LeAN4DKFqJlwvXz0
 JFZQ==
X-Gm-Message-State: AOJu0YyFnV3py7oQ4/zj1Ar68b0rKYmOmamaMTg9EFg/EJKXidZfpDM/
 P90Omh/ioEAqsEJv0AmcCPW9iQkqlL6NuT/A/EQzlYxc3vI1UYxFk6l5B0woazA6XGVGoMLCZj1
 VEfRmXXHbp4/gSXRJsPhKVOzZTwzuQrejKUk40JbsiQ==
X-Gm-Gg: Acq92OEELCWHp+d5nBegfdix1ITLTXGKndWHWrrKyEY+bjB0Yu7IwLddrOni+Y5GIWD
 kjVafmWNnB+ShUWP1Jk2MxxGS1iA9ZbEPToAMYXwmiI74mU9VqsXVerFNfnn3Fj77cqDMWwostO
 vcwjVU+Ves5ooh+5+w/zsXlFzXRLq44O3UDPNg7Cx5++RiwtMEi3wT6xI7LYUrxUVRAPnXDeg4y
 lZHiwk+ObxVJnYd/YJgjzIvIwpQOyLK5hBI/JSiLRmcS+llTt+APjucAc4EtZ1OQCERE1nkVa3H
 X4OT6aq70hXC4pp6MAsvkHPt1R9AhTZt1UkOM81KxJVZUaKsiOqOlrQkxur6zqUKm8Q=
X-Received: by 2002:a05:690e:e85:b0:654:1261:8b3f with SMTP id
 956f58d0204a3-66284f86d8cmr13310243d50.16.1781604989128; Tue, 16 Jun 2026
 03:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260602063350.3623723-1-kchiu@axiado.com>
 <20260602063350.3623723-5-kchiu@axiado.com>
In-Reply-To: <20260602063350.3623723-5-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 11:16:17 +0100
X-Gm-Features: AVVi8CeolL_SMIHZ048sFR08zrKklswYzNPOSHvuccHlXTxIKfzhJj94E_Yn3zM
Message-ID: <CAFEAcA-7dJoapxe3ZvGSOozpNj7=i9LVdzPh1TGJnZVG6BzUAA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] hw/arm: Add Axiado EVK SCM3003
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2 Jun 2026 at 07:34, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Add EVK axiado-scm3003 built with AX3000 SoC
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>  hw/arm/Kconfig                 |  5 ++++
>  hw/arm/ax3000-boards.c         | 47 ++++++++++++++++++++++++++++++++++
>  hw/arm/ax3000-evk.c            | 27 +++++++++++++++++++
>  hw/arm/meson.build             |  3 +++
>  include/hw/arm/ax3000-boards.h | 28 ++++++++++++++++++++
>  5 files changed, 110 insertions(+)
>  create mode 100644 hw/arm/ax3000-boards.c
>  create mode 100644 hw/arm/ax3000-evk.c
>  create mode 100644 include/hw/arm/ax3000-boards.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 5b9cf25dd31..175e6c7985b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -724,3 +724,8 @@ config AXIADO_SOC
>      select CADENCE # UART
>      select AXIADO_SDHCI
>      select UNIMP
> +
> +config AXIADO_EVK
> +    bool
> +    default y
> +    select AXIADO_SOC
> diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
> new file mode 100644
> index 00000000000..ad3dd963656
> --- /dev/null
> +++ b/hw/arm/ax3000-boards.c
> @@ -0,0 +1,47 @@
> +/*
> + * Axiado Boards
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/ax3000-boards.h"
> +#include "hw/arm/machines-qom.h"
> +#include "qemu/error-report.h"
> +#include "qom/object.h"
> +
> +static void ax3000_machine_init(MachineState *machine)
> +{
> +    Ax3000MachineState *ams = AX3000_MACHINE(machine);
> +
> +    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
> +}

You *must* call arm_load_kernel() in your machine init function.
This is not an optional step -- that function does work that
must be done for things like reset to work correctly, even
if the user is not using "-kernel". Also, even if you don't
typically want to use "-kernel", other people might. This is
standard functionality all boards need to provide.

thanks
-- PMM

