Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD1BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDj6J-00027Z-Cb; Tue, 28 Oct 2025 08:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDj6G-000279-J4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:46:56 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDj6A-0006e7-BL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:46:56 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63e0c6f0adfso6030685d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761655606; x=1762260406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D3RH6UsMdMy87c5o+TRKGSs4DdkK1RyRgMopjF4kntY=;
 b=b5m96n2KyS2Bv/RVjdimjbhuwE4Hv2nt4lrqqQdxGbr3V6wSiHTd8J5Fp4j9eBBLV8
 r0DXJrCubyQyNdVqbXEDZdRqStIxVKCNutVNWAHnsWJqkFtdh1sfdf/T2XaVnPQEc4B1
 OzTpJ1/ZOj+rsBhOloO2M7JTT3b+CKD5k0dfdYlQSZ2IVn83y7nxsqsdqLa4NwREAW5g
 xP2fdvY7Q9KoEUlJ1x2dDkTgHxH2RzhgSQzewo3ybgMS2UC71X4ZYKB9/yTEAlqBQq9+
 C+8wDuQ7skYTsYhiRuV1BLAySxIUbekUdPjVc0VTlfCpc2EBgNr8Fh4vlGzoJQ4hUINy
 akDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761655606; x=1762260406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D3RH6UsMdMy87c5o+TRKGSs4DdkK1RyRgMopjF4kntY=;
 b=pzJWMpagwlR6/QTAqwSx1A7GIkRBlkz2bF9iZfAstJ/cGv+lHAqh+k6+P0nMpZ2kGl
 p3CIZqkcyDWzd+QDLJUg/WFgLRrjN9gKdX+cUGpY+/sw6JVrSftEXBIizzdocasHPEDO
 G9B1qaf2PRHePS1lKjNBFg3KbXmiL54LzXyd9tZq9mkGN4no6SPQEbFlBKBimSVJIaVx
 src+iSQn30ycUqgKehxS0eW7l07wT1NfObk3H1+etbUYFlZ9uJO/jBf3qb48fqDS6P3J
 H3cky7IJYn1UokpgI9FnFx5giWYnC8Iew6f6oQR4vcmWqiyZ20Gn1VzXVlJ749S2BbG0
 Y/jw==
X-Gm-Message-State: AOJu0Yy2G6FZvXN9mm8Ww7YTqDL621PMWnd318jcbda+YQhPa15qbKZE
 o+reCsYlo+4/9e75dcdzEyF1m8pI6lN/lO85r3CHkCVusklPBQWTuC4JX/rbDqoNrvdsqnprA7H
 Ylz9ChAJyVXguWvt/aFpZRg56tuutdOM0nFqJALRE6g==
X-Gm-Gg: ASbGnctgTK/uCdcFOlOmy9ZBUycy8v3IGkGdd1sAOgcWf9fHPRFHK24niJCa796zKdw
 XFJAO7EPq4L6ZF0rAhPELfebdXdIgqIiPE9U7Wyz5GoiIQcF9sZj+Rd+LhGZNnJPxB7ctvkzKTs
 M4U1uJMl68+xq36asTZO5H7qHYVN3zgMLORCmrvxouEaVsdseX3gBYYRpwh0hVYdUt6EntfNp/K
 uUNA2IPhhwhzYoeis4vp1WaAxvzH9WSOU6fGirngm860VwF0PKlMh8ef5nW/A==
X-Google-Smtp-Source: AGHT+IH1O6i8hecTj4l2aLo4OldJkWtQ8u8T0RQCgB8Hp4HMRcRLb8koFsgd74eAE4goa26cuPqJKqRaKkrJ4RO1PuE=
X-Received: by 2002:a53:c64d:0:b0:63e:1395:1951 with SMTP id
 956f58d0204a3-63f6ba92260mr2329214d50.54.1761655606083; Tue, 28 Oct 2025
 05:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
In-Reply-To: <20250629204851.1778-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 12:46:34 +0000
X-Gm-Features: AWmQ_bkMhIpPncgf5hD9mm751gVd8CuTkkix0pY9v1Zm67Q2MKeXiO5odTkC_cg
Message-ID: <CAFEAcA9Rvvymu7oS0pPx00v9SdXzwr27vy1VmnZmwQ7ayZK+yQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Allows the imx8mp-evk machine to be run with KVM acceleration as a guest.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  7 +++++++
>  hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
>  hw/arm/imx8mp-evk.c            | 11 +++++++++++
>  hw/arm/Kconfig                 |  3 ++-
>  hw/arm/meson.build             |  2 +-
>  5 files changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
> index b2f7d29ade..1399820163 100644
> --- a/docs/system/arm/imx8mp-evk.rst
> +++ b/docs/system/arm/imx8mp-evk.rst
> @@ -60,3 +60,10 @@ Now that everything is prepared the machine can be started as follows:
>        -dtb imx8mp-evk.dtb \
>        -append "root=/dev/mmcblk2p2" \
>        -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
> +
> +
> +KVM Virtualization
> +------------------
> +
> +To enable hardware-assisted acceleration via KVM, append
> +``-accel kvm -cpu host`` to the command line.

Coming back to this now we've resolved the "does this put
things inside our security-promises that we don't want"
question...

I think we should be a bit clearer in the documentation
about what tradeoffs the user is making here when they select
KVM. Specifically:

 * we should note that this is intended only to improve
   performance, and is not covered by QEMU's security policy
 * we should say that you will not get a Cortex-A53, so any
   guest code with tight dependencies on the host CPU type
   might not work correctly
 * we should say that the guest will only be able to run
   at EL1, and (unlike TCG) there is no EL2 or EL3

> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 866f4d1d74..7e61392abb 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -12,11 +12,13 @@
>  #include "system/address-spaces.h"
>  #include "hw/arm/bsa.h"
>  #include "hw/arm/fsl-imx8mp.h"
> -#include "hw/intc/arm_gicv3.h"

Why does this include get removed ?

>  #include "hw/misc/unimp.h"
>  #include "hw/boards.h"
> +#include "system/kvm.h"
>  #include "system/system.h"
> +#include "target/arm/cpu.h"
>  #include "target/arm/cpu-qom.h"
> +#include "target/arm/kvm_arm.h"
>  #include "qapi/error.h"
>  #include "qobject/qlist.h"

> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index d90be8f4c9..a4212a6ab2 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -59,7 +59,7 @@ arm_common_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
>  arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
> -arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
> +arm_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>  arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))

Philippe, Pierrick: is it OK that this moves the
fsl-imx8p.c file from arm_common to arm_ss, or is there
a preferable way to do this from a single-binary point
of view?

thanks
-- PMM

