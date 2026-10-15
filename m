Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1898CCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKz8-00039g-5M; Thu, 15 Oct 2026 08:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHKz5-00038d-1L
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:54:59 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHKz0-0001fj-7p
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:54:56 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6774639a8a4so1423461d50.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792068892; cv=none;
 d=google.com; s=arc-20260327;
 b=heU7rznuqH+3jm3s1E+ILsdb3DoEgHBPDplKN7ZJRn5cyyPyYC95iadrCjsV6qEXkJ
 3ByV1mdI/d7Bo8sZBy6uW3q6KTMKz2XZo4FJjdaVKboT9M+S4j+64HkYhW+mmudrP6m8
 txjFbK1NlZRHKAwSa3lAxW5SLxyyfsH9Zq+W9i+m/VVVw96sUoHR+uCc3MjXRj708GR/
 Fj5JRzEj+v4e5WztJxcZZJEiO6GSLmDLz/XAGNglKxT2FbvTWIqHR1IFte6Kxmwnd6KU
 vwi8qZswD0gJEFFlfbkVb4Q4vh7sG8y4MuUR5WnPdmJuFcqaGhdOwbJy44cHMzy8Jpi+
 ET+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EzHAMvP9BxKQxCHJGe87zu+8IsD+1Q9fbM0xhQ1SsW8=;
 fh=VE+fSPwns4P0qLilbUMaglgxe5Il5vV69hoBMwU8/p0=;
 b=LHrSIQw8IfZvi3kE1e49sLNcqvbS3z+3mYqZdRpa1gJIlqUthu8GbgKpZRYjfpRm+e
 5W8UHsfEoPC9FKPB51qtmdXJ59TWfQbJFhF9TFKXWdIjIVCIFZb55Xz/epMJAxXufll5
 MHoc3ktSaZUwuM8kvjppBM7I+YdOMJ+dR8WF0J8cdrtVynPxWrriI7bYbesT+k8AADKR
 YO5DJ2SI37adPssN98aHy1hjpYTVnOQPFIJh/VebRFgtTm7whKft3nXtquBIEyQu3lFh
 pnVMttaAbqPKbU7v2d7TygDJv5hpJwqmzjEv0S2RAvfyUOUzENg6aY96EQFpRXLPATGb
 Xzlg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792068892; x=1792673692; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EzHAMvP9BxKQxCHJGe87zu+8IsD+1Q9fbM0xhQ1SsW8=;
 b=L5LvsI8bxBji7Xvq+grAcNACyREZj5vSTRZwfnTVR7ZGCBlGeIFMUpdistFmwZ31DY
 nIamRTgZEWRzBxJTDCviKe/FIWI5iuRRY4q4x1VfTiejUXN+BL5YgAbKRbw1yDl4zLln
 657hy7XrV7vfgK+7jxEikCg8nuQ07u/qC+PtBBnzn0kqm3ScpqGlSkJ69OMG9iJqevsj
 fXniTiX5B3gX5duoLPkQiKyq2RPMn7bkqkwaUCgJKsg/1RL8R9dMtCqAaaPI8wAzmJkC
 zk58YyZMHeik1v4g2uyGP3egnos0aO05drUPRsPl4nh1qeiwpdoSg2ENr3FB8YKkaeC5
 mtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792068892; x=1792673692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EzHAMvP9BxKQxCHJGe87zu+8IsD+1Q9fbM0xhQ1SsW8=;
 b=s36KJ08lf5j62OJIQP0WwfS6woQAoodu1yC3U5xSjtgLDy6ONezJooKFRzrDNILLxt
 nhnLfM13QtC+2VGN6X5JRoQlUzcIvCXeU56nHMOTPemal9f1dAW4okyNUnSboE45XMDh
 tLvw1FgS6qGwwESnooUSjOzSt35f9IOkZ6/n0EKWAJ0CYRGxE6vZqgVmY9BsHmsXRmbr
 RvJnqUKUOX6BXthPYOQyec2Vh8LTxqMVr6a4Q/I1DiNqVpi79MFaNVT71m040a3QdHWA
 gV4hHTbQp4K5YY/NOFzKEmDYiwWdNpNuodt0nUhFgZqZumyZabh4grVrRSM7IL1fbD6a
 pDGA==
X-Gm-Message-State: AFq9FYKvuNEhHYQ1OhAJ9Ji8+mm0FdfU1xcp6sS7Fo30swQQvJeggIjn
 RY1w8ZUlqrUTzSEDKPOoJXhITt0qTqhRQ/22tRoPdGXaQJ/6AIO1LfBV9bYfadakdHz+dh+q5WG
 IOhO73NmEkHsXZ4x3tVHAOY2aH/hOOF1zgDbOvRVJNw==
X-Gm-Gg: AYBFou3HoUOlbbWAvnWe5r3rejv8Cd6srFoEQAcpiduLvJ8GPmauCoIKoRdk18LdiX7
 WoQmbpj0QF+b2jkjFYzinBpWvLYJPB0RlTz7+9g0kDuye2ljsv+rwJUUSIH7AUg4kB6urwbmv0S
 Wy7EKr97cgEv0ZPCwRrdNAeGcjy+LP3hV0c6BB+Bl0SfLqr7P326/sLzgzYEYYpJiS5pkLO71SX
 YVkm3+HJ6utr9euLtpJZKn7EWMQQKTB2onyoTZ9orDtL1dmj6M7DqXGwLDWrpV49brSrBztdlBS
 oBfCYFoP4l/bmiYGC6KhmpY+Qsccx/azF6dGUQLBYYHY84ldXUAcqhQVh3dwFBt9cEFxsOTPKvp
 uxbGGvCqX/rl2QAVYXdMAHMbTEo5V4xUut2IHbNA=
X-Received: by 2002:a05:690c:f8d:b0:8b0:df71:44d1 with SMTP id
 00721157ae682-8b0df71509emr1685087b3.6.1792068891512; Thu, 15 Oct 2026
 05:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
 <20260725012635.4925-2-marcelomanzo@gmail.com>
In-Reply-To: <20260725012635.4925-2-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 13:54:39 +0100
X-Gm-Features: AclHuK9BQS61E8q2PCnlho8Nn1K7oVpfy1_mNMXy_HbmrCnrQCo9yrWfUGcvvl8
Message-ID: <CAFEAcA8H0iD5ps-CigPxyOBLE_hLCekrzmP_ySEs5uqLGLHsyQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/misc/bcm2838_rng200: add BCM2838 RNG200
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Sat, 25 Jul 2026 at 02:26, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Add the BCM2838 (BCM2711/Raspberry Pi 4B) hardware random number
> generator: register model (control, FIFO data/count, int
> mask/status), a Fifo8-backed entropy buffer refilled from a
> qemu_rng backend on a ptimer tick, and interrupt generation once the
> FIFO crosses its configured threshold.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B series (patchwork
> series 829638, posted to qemu-devel in 2024, never merged). Ported
> to current master by Marcelo Manzo: header paths moved under
> hw/core/, class_init()'s const void *data, the Resettable phases
> API, Property[] losing its DEFINE_PROP_END_OF_LIST() sentinel, and
> fifo8_pop_buf() gaining a caller-supplied destination buffer instead
> of returning an internal pointer (adapted bcm2838_rng200_read_fifo_data()
> to the new copying API, which QEMU's own fifo8.h now recommends over
> the old fifo8_pop_bufptr() this code originally used). No functional
> change otherwise.
>
> Boot-tested: guest probes it ("iproc-rng200 fe104000.rng: hwrng
> registered"), /dev/hwrng exists, and reading it returns real random
> bytes.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

This patch mostly looks good, so the below is all minor stuff.

> +static const VMStateDescription vmstate_bcm2838_rng200 = {
> +    .name = "bcm2838_rng200",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
> +        VMSTATE_ARRAY(regs, BCM2838Rng200State, N_BCM2838_RNG200_REGS, 0,
> +                      vmstate_info_uint32, uint32_t),

There's a VMSTATE_UINT32_ARRAY(), which is the simpler way to do this.

> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool is_rbg_enabled(BCM2838Rng200State *s)
> +{
> +    return FIELD_EX32(s->regs[R_RNG_CTRL], RNG_CTRL, RBG_ENABLE);
> +}
> +
> +static void increment_bit_counter_by(BCM2838Rng200State *s, uint32_t inc_val)
> +{
> +    s->regs[R_RNG_TOTAL_BIT_COUNT] += inc_val;
> +}

This function doesn't seem like it's really adding anything
compared to opencoding the addition in the one place we use it,
especially since that function's style otherwise is to open-code
s->regs[] accesses.

> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3..90e178ed 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -442,3 +442,13 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
>  iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
>  iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
>  iommu_testdev_dma_armed(bool armed) "armed=%d"
> +
> +# bcm2838_rng200.c
> +bcm2838_rng200_rng_soft_reset(void) "RNumG soft reset"
> +bcm2838_rng200_rbg_soft_reset(void) "RBitG soft reset"
> +bcm2838_rng200_enable_rbg(void)     "RBitG enabled"
> +bcm2838_rng200_disable_rbg(void)    "RBitG disabled"

We don't generally try to line the start of format strings up in trace-events
files (it doesn't work if you need to add something else later as you end up
either breaking the line-up or else having to edit more lines than just
the one you needed to change).

> +bcm2838_rng200_update_fifo(uint32_t len, uint32_t fifo_len)    "len %u, fifo_len %u"
> +bcm2838_rng200_fifo_full(void) "RNumG FIFO full"
> +bcm2838_rng200_write(uint64_t addr, uint64_t value, unsigned size) "addr: 0x%"PRIx64" value: 0x%016" PRIx64 " size: %u"
> +bcm2838_rng200_read(uint64_t addr, unsigned size, uint64_t value) "addr: 0x%"PRIx64" size: %u value: 0x%016" PRIx64
> diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
> new file mode 100644
> index 00000000..05bc87fa
> --- /dev/null
> +++ b/include/hw/misc/bcm2838_rng200.h
> @@ -0,0 +1,42 @@
> +/*
> + * BCM2838 Random Number Generator emulation
> + *
> + * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef BCM2838_RNG200_H
> +#define BCM2838_RNG200_H
> +
> +#include <stdbool.h>

Don't include standard headers -- osdep.h pulls them in for you, and
every .c file starts with including osdep.h, so every .h file has
them available too.

> +#include "qom/object.h"
> +#include "qemu/fifo8.h"
> +#include "system/rng.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/ptimer.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/irq.h"
> +
> +#define TYPE_BCM2838_RNG200 "bcm2838-rng200"
> +OBJECT_DECLARE_SIMPLE_TYPE(BCM2838Rng200State, BCM2838_RNG200)
> +
> +#define N_BCM2838_RNG200_REGS 10
> +
> +struct BCM2838Rng200State {
> +    SysBusDevice busdev;
> +    MemoryRegion iomem;
> +
> +    ptimer_state *ptimer;
> +    RngBackend *rng;
> +    Clock *clock;
> +
> +    uint32_t rng_fifo_cap;
> +    Fifo8    fifo;
> +
> +    qemu_irq irq;
> +
> +    uint32_t regs[N_BCM2838_RNG200_REGS];
> +};
> +
> +#endif /* BCM2838_RNG200_H */
> --
> 2.47.1

thanks
-- PMM

