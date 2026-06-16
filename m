Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89E5CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQmy-0000Fj-U0; Tue, 16 Jun 2026 06:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQmw-0000F0-Ol
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:12:58 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQmv-00050M-1q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:12:58 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6607e80a846so4417023d50.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781604776; cv=none;
 d=google.com; s=arc-20240605;
 b=ZDSmbIGJSVgvQDzaZVU1tMZwGbya0xNh4YDqRBICmS38YCIC8NdMCtxJGjhHTBerkb
 4AQoaT+6BxjR2jQxUYCHXilSHFmNIQX+CcCOkABPOAPvvdX/PU6/1PxDqBxK2fXjAViZ
 wnr8ji9Xsh63zeDjsIr/el+ucN1AXznpev8X2glyf1rklcueMpg1WHs5i2kqRT4WPnxJ
 yYOY90R3UiabnSK9SuWhyGWwqTkz/cjEQi9M7e6ICV7f2U2qDFEFvBhVlE3Qpsl+Xcri
 uMMntSFyUBKVodbYGEIo83FNjT8Pb2cls94o2/poJyN4njFvl7mLFQHW1F5xd+JNyi7y
 IYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oK9n3s61IMjZLguj+38Cg09gtwbZnlhASl0rfBb0sAE=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=O20jSQnodf0y4iZN1VwhvbiajI+zVa6wu+7j54MwYtPorQHQ/kYCg7fJVodQkw0xG2
 fSijeYSHXzTyHetpRgmieeo15nBc9IhWMRsZKemskgjAJ5oveKyjgN7dKPaU2EoQcqC6
 i4HHYW9PVfFnyuBi0jA515MTUqTWRYh/or3sbHTn+wNyOCImRBy2gNXjgnhfoV7PIW/R
 CDt3azjfoFXKqAitk1WRcWDs8hVG3Z2xOaH5Fr1DCUc8sm56C/WAs4UqZSKbkNO5ZG8e
 GF4y9qju43UDydnRiiivvrL+VLbdEhLf7341bnCw/mmMsHeew3vdW7I8wornykpfeBc3
 /GyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781604776; x=1782209576; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oK9n3s61IMjZLguj+38Cg09gtwbZnlhASl0rfBb0sAE=;
 b=cHpwxS/PnmvczqhGwfsLaiiZ8F2li1h3yrJ2IaGRYgb3XZLcxKgRwvB+FHK5l8FgH3
 5K2yZTuGssxV/lXlM04QqppdTnz0Ctf9MGAt0EU7ARZLOJbGuWrpdjisjZ65QDEY22jD
 Gr4YAGCgvVt9niRgIkuyRxKOnWCq9DdguEZcVgHVIL4ZfW0C4Agsjq67VuY1js3vN0SA
 AUFwnuMWcHYnQ6A3QFvfmbHdlk+HHkbeDF+JzR5wOlXuiHjtqWf74o7JzueUSojY4uAZ
 w+VkRKp5B6nJCHr7kJdBqtaKzXEG2GI7egElf2yrLb8nkplLi8x88SxAhQ6uB7sTlSiU
 aynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604776; x=1782209576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oK9n3s61IMjZLguj+38Cg09gtwbZnlhASl0rfBb0sAE=;
 b=cbjch/3bc6CYa72/n6P9qaJ4lpjQjuBw+C9MqeXKPLqoNYszr73T0+2NWS5g8xdiJU
 TXwzxJNKCKEvTw2ZEYbQxAPI1S9UVvyMKvi3CpbCKbmgNh/1UeoPvZsRvhexLUwf+vyR
 YNZgMEXl3jcsNbGVVBq6VbfiQOl2vG+7Lkl+uv5YLxgpxD/QF7qkNo+Kfatp9nqqipGR
 EEsy18UKqoP0lNWi0nxVY/cYS8eHejSnM6qKoB8+zDgy24ONdk7tEAqybhleGcHeMY5k
 vNBo5CEyca0fXm6vzLgBteBsdimfdmo2+OCuH1EwXAn+kxK+VASAQe3dzutQ5DcCYVvd
 UVaA==
X-Gm-Message-State: AOJu0Yw6DGIqg6Xm0/BirA6zpBiOGYwR2oqomnrfDYksuc1+iEy9H3Xe
 1PEIFAEu6l9P76wK0ksvyy/zrNFjVQ+A5ck0uIjhb1yacrf1Wt5KgXTjJcXKOBFMaAJsHOIJMqX
 jrKBklaLJ3ZZbpm3LQ3Lq8V4yzolyD8p3b+sZAnhUGlaTDHltQu3W
X-Gm-Gg: Acq92OHnLgojUQP0WgejYue4/dBMTtwlCrXyuvllI05ZQ5nLNhP07uBb5qjCdjP8MEY
 6qezlMSxVq0EZGEfd+vwUU66+9izsJkWrPQm5ePdXrUEJyJewIsuLPrYZ1b+QwxCJcKt0f+H9pP
 9tOKmL/ES9j3Iu39y6dwfN59NviXyYGXh2G4m1639WiYcFuqUapJirSknKWiTxe3WqDp+xsGUfk
 vulYif5/sb3iIutkzxUiMknyOmmzZ8w0xwyPhdCPqhNDK2Q1aLyBETQTpSKFPKK7BcgrLzCAc9W
 Hm/NRUoV6n6R2B9aqMQoW+zwRCvjxLwj1SfbCE/DQQg88zBBENUFNP7oGZPsbJwfwzw=
X-Received: by 2002:a05:690e:168d:b0:662:c3ac:6921 with SMTP id
 956f58d0204a3-662c3ac75dbmr235903d50.59.1781604775776; Tue, 16 Jun 2026
 03:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260602063350.3623723-1-kchiu@axiado.com>
 <20260602063350.3623723-2-kchiu@axiado.com>
In-Reply-To: <20260602063350.3623723-2-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 11:12:43 +0100
X-Gm-Features: AVVi8Cep7VhtGG673ibd-Yx6kAdRQbYO2d_6CCJogFEIKrl98N6Y6_vykdOfgSs
Message-ID: <CAFEAcA-p045unJK-nx0VdcUEdOfo73tmL5QQQT6M-5NK6pivsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] hw/arm: Add Axiado SoC AX3000
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
> This patch adds new model for Axiado SoC AX3000 which supports
>     4 Cortex-A53 ARM64 CPUs
>     Arm Generic Interrupt Controller v3
>     4 Cadence UARTs
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>  MAINTAINERS                 |   7 ++
>  hw/arm/Kconfig              |   7 ++
>  hw/arm/ax3000-soc.c         | 218 ++++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build          |   3 +
>  include/hw/arm/ax3000-soc.h |  71 ++++++++++++
>  5 files changed, 306 insertions(+)
>  create mode 100644 hw/arm/ax3000-soc.c
>  create mode 100644 include/hw/arm/ax3000-soc.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd5c4831e27..3782c83738a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1298,6 +1298,13 @@ M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>  S: Maintained
>  F: rust/hw/char/pl011/
>
> +Axiado SoCs and EVKs
> +M: Kuan-Jui Chiu <kchiu@axiado.com>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/ax3000*.c
> +F: include/hw/arm/ax3000*.h
> +
>  AVR Machines
>  -------------
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 5b198402d5e..39f0b652a0f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -716,3 +716,10 @@ config ARMSSE
>      select UNIMP
>      select SSE_COUNTER
>      select SSE_TIMER
> +
> +config AXIADO_SOC
> +    bool
> +    depends on ARM
> +    select ARM_GIC
> +    select CADENCE # UART
> +    select UNIMP
> diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
> new file mode 100644
> index 00000000000..517cc6f52d5
> --- /dev/null
> +++ b/hw/arm/ax3000-soc.c
> @@ -0,0 +1,218 @@
> +/*
> + * Axiado SoC AX3000
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/address-spaces.h"
> +#include "hw/arm/bsa.h"
> +#include "hw/arm/ax3000-soc.h"
> +#include "hw/misc/unimp.h"
> +#include "system/system.h"
> +#include "qobject/qlist.h"
> +#include "qom/object.h"
> +#include "hw/core/boards.h"
> +
> +static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    switch (offset) {
> +    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
> +        return 0x20891b;
> +    case CLKRST_CPU_PLL_STS_OFFSET:
> +        return 0x01;
> +    default:
> +        return 0x00;
> +    }
> +}
> +
> +static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps pll_ops = {
> +    .read = pll_read,
> +    .write = pll_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }
> +};

This needs to be its own device model. Don't set up and map
a MemoryRegionOps directly in this SoC object.

thanks
-- PMM

