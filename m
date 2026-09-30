Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9B0CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoIa-0000RA-6J; Wed, 30 Sep 2026 03:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1xBoI9-0000Nk-BT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:59:56 -0400
Received: from mail-pj2-x2a.google.com ([2607:f8b0:4864:39::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1xBoI5-0006Bo-B2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:59:49 -0400
Received: by mail-pj2-x2a.google.com with SMTP id
 d9443c01a7336-2e2d9fdf798so3554635ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 23:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790751584; cv=none;
 d=google.com; s=arc-20260327;
 b=PjS/vzHCkpqgpUG62rp4ElgoSRBSq7YScfkN4XI+CZ4E4Jx5mFBslJtjxpwK8sds+/
 TMSEbMuTIUntZl8Siwvr13k6MO9SSn8oHywuqhz7jgK3FCj/8fkOXZf9abX7S6muTBWh
 H7zOhB3CPeSgqJNJT6157QjxGa3t1JrMWjRrtAKvd5HP01h3+6UDQwqaOqaOIpH+SDAw
 ha4uVexmpvRjA6zkPsHojdRtfJjCuwL2hA3HSdPA541DlcrMxnA+wNcfdF0XL6Ktatq0
 VSaakdtlMCRgqOj1HcXtp6yE9O9M/EYbeEBnl7Zl51iKfdHsdmDGV/35HcI1zY+2rkPx
 x/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nIM2U5tDbXICcE4Xo+Y/po2Qr6rt7OaAGo/K6r1Ga1g=;
 fh=8ik9FFMGHL0a2axiY+q6nxkXql+LJ2KzvU2UfxPrZlE=;
 b=dWTgpGRWk5uOrZHWyTLWFVmwxtatKUrN8iJiIGkCMj6C+9dWxb5xp51+YFdfm0dJ9M
 eLu9gKw0Zg4FSSVdybbKMv+phlxdLrIjOoGjbYAMg1MTTtE6fv1frWOsfQXYVVOVu0XF
 aQJKmParQr/iNgcTVRQPtYZMu2r5vreUuSvK2ZfS3pTTN5yw7En1sN1LSZB2VScQrEx+
 rW6cENHs/vJ4k1KmnsLHVt8vwgMnxftpP2Z3tJgs2uHVTA/OScDmWjyLlIz69RBvzlaS
 anuncmyb86DsyC3wk5YDl+SzbJQXEZ5v54CfHmC9pCBg8wQDSuv0eF3oZCqVyGasV+oi
 xv5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1790751584; x=1791356384; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIM2U5tDbXICcE4Xo+Y/po2Qr6rt7OaAGo/K6r1Ga1g=;
 b=DZZU0dJwWXyyl3LEadOFhbvZU6h4/uxXr7wuJg6eyg7WjzLg8IZfCAh5nVhWm9KyQz
 VrVlzKr4y+97s+Usouz+5zO1YNQl4KXU83XKiG2V1hWE0Mp3g4qNVMquwIfpK4gRWD8D
 83Yb+kEZ9sH8IVVVZ00DHUaEXvAdsuQpLZNzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751584; x=1791356384;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIM2U5tDbXICcE4Xo+Y/po2Qr6rt7OaAGo/K6r1Ga1g=;
 b=MUgd0F1uzy3//nbZEbfs8Eu4R42itweSxuhf2sabm7G/VWt6Q/UM+NEEQ08YPeBvJa
 2FYPtxTl6l/bXq8QXnqbu3jXxFPPPIqUt7aeXzrRBjvEP7cQqWV9fFT84ejhMuoj1JIZ
 CvC1MdjGbbbCeJ+PeRuTx7DNF4O0ySARWgWE8gh7SM9ydevvf2I/IL2xSX1KzqkNbaqG
 Y3IJmKpbVvxQnLSbhUgZv6MRb4btPcztM+GfqFisbDhtOSuyclQDp7LsmNkISZ/isql4
 O+lmiMbhkmHlKfacEGTc8IHNSObHYXrMwKeKUb7j+BG/0rU8myHwBOuhuILZvcvZEKJQ
 bYzQ==
X-Gm-Message-State: AFq9FYIPxrJ5w/dq7xShNprcgdpCC3USqAx5/18WPfnwprKg6mPNplgC
 Y4j0BdUv20p8SluPe98BvJQpga4awUsq6+rcJU34omb+icwOcRnvcfhZbwkGpzq7o2qRM+hhj3k
 HI3bN6B462DtfzH75eOikTfNlQPzwG0w=
X-Gm-Gg: AYBFou0eEvsy44nBqJMZrb9fvKURTIz5bDBju0WUpVcsa7eCgBk6dP0Qm2HbzuHYhAl
 y32xDq6oMczlbeh0jiJ9xGlhQiSB1ZMuxOBrfVtqOKZtTvF9kEbaVTVnY56+UdxRF38ms/6JPyP
 wiOYn6ZkCcNeps7fmlp8mT/qh6HkvS0TYP5omi91JW8WcXlba5l1kHPMiGfXW+DMMqdIN05kjgl
 lfTwi+lA4Lvv1grLE4Q4LtGD8PjPLlpD9ZzZ3ZVq+BqwuTT7EaCySLhPZEUhQUv73YFpogCLrz3
 iM6d8QIkFb8TciNPg64TgqML6vi429cyG6bWcKjNeNelANsKPXvXDzhigTHBx3zRkSF4C1b0aRj
 gdx7GHP5Ul4ZwgT0u4YJpPfxC4eysHBAekTZH18bAhB7dSRiSXs5R+tbvC9TKSXnyd2WmNcg0M1
 dASZgmfAbiV2r5+raDkbttUB1IP4w=
X-Received: by 2002:a17:903:2410:b0:2e2:cf7a:2dc8 with SMTP id
 d9443c01a7336-2e2e49e0e61mr4173985ad.39.1790751583706; Tue, 29 Sep 2026
 23:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
 <20260904-atlantis_prcm-v3-1-8bf20795a381@oss.tenstorrent.com>
In-Reply-To: <20260904-atlantis_prcm-v3-1-8bf20795a381@oss.tenstorrent.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Sep 2026 16:29:30 +0930
X-Gm-Features: AclHuK_Y08pPn7ISbFpwTuKhrLBPZ8VhYWJumG9prdZMNa__OM1ptbsbn47xcsE
Message-ID: <CACPK8Xdfq5_tTqCfQfwi3tLimbG5YNO8_H39TY67TArPV1Ls1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:39::2a;
 envelope-from=joel.stan@gmail.com; helo=mail-pj2-x2a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, 5 Sept 2026 at 00:18, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> This device present in Tenstorrent Atlantis has registers that control
> clocks, reset and other misc functionality in the SoC. This commit adds
> models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
>
> Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  MAINTAINERS                        |   2 +
>  hw/misc/meson.build                |   1 +
>  hw/misc/trace-events               |   4 +
>  hw/misc/tt_atlantis_prcm.c         | 446 +++++++++++++++++++++++++++++++++++++
>  include/hw/misc/tt_atlantis_prcm.h |  51 +++++
>  5 files changed, 504 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f524d90523..b6cc077602 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1830,7 +1830,9 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: docs/system/riscv/tt_*.rst
> +F: hw/misc/tt_*.c
>  F: hw/riscv/tt_*.c
> +F: include/hw/misc/tt_*.h
>  F: include/hw/riscv/tt_*.h
>  F: tests/functional/riscv64/test_tt_*.py
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 54e07aacda..11b9593e03 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -39,6 +39,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
>  system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_decomp_gzip.c'))
> +system_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis_prcm.c'))
>
>  subdir('macio')
>
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 0b8be3d0f2..8b80b71107 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -452,3 +452,7 @@ launch_update_write(void) ""
>  vmlaunch_reset_enter(void) ""
>  vm_launchupdate_finalize(void) ""
>  restore_host_x86_igvm(void) ""
> +
> +# tt_atlantis_prcm.c
> +tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> +tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
> new file mode 100644
> index 0000000000..392d7da7f4
> --- /dev/null
> +++ b/hw/misc/tt_atlantis_prcm.c
> @@ -0,0 +1,446 @@
> +/*
> + * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2026 Tenstorrent
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/irq.h"

The three above are unused.

> +#include "trace.h"
> +
> +#define TO_REG(offset) ((offset) >> 2)
> +
> +#define PLL_LOCK_BIT        31
> +#define PLL_FBDIV_LSB       14
> +#define PLL_POSTDIV2_LSB    11
> +#define PLL_POSTDIV1_LSB    8
> +#define PLL_REFDIV_LSB      2
> +#define PLL_BYPASS_BIT      1
> +
> +#define PLL_RESET_VAL(BYPASS, REFDIV, POSTDIV1, POSTDIV2, FBDIV, LOCK)         \
> +  ((LOCK << PLL_LOCK_BIT) | (FBDIV << PLL_FBDIV_LSB) |                         \
> +   (POSTDIV2 << PLL_POSTDIV2_LSB) | (POSTDIV1 << PLL_POSTDIV1_LSB) |           \
> +   (REFDIV << PLL_REFDIV_LSB) | (BYPASS << PLL_BYPASS_BIT))
> +
> +#define RCPU_PLL_RCPU_CFG   TO_REG(0)
> +#define RCPU_PLL_NOCC_CFG   TO_REG(0x4)
> +#define RCPU_NOCC_CLK_CFG   TO_REG(0x8)
> +#define RCPU_RCPU_DIV_CFG   TO_REG(0xc)
> +#define RCPU_RCPU_BLK_CG    TO_REG(0x14)
> +#define RCPU_LSIO_BLK_CG    TO_REG(0x18)
> +#define RCPU_RCPU_BLK_RST   TO_REG(0x1c)
> +#define RCPU_LSIO_BLK_RST   TO_REG(0x20)
> +#define RCPU_PLL_RCPU_EN    TO_REG(0x11c)
> +#define RCPU_PLL_NOCC_EN    TO_REG(0x120)
> +#define RCPU_PLL_MM_EN      TO_REG(0x0124)
> +#define RCPU_PLL1_MM_EN     TO_REG(0x0128)
> +#define RCPU_PLL_HSIO_EN    TO_REG(0x12c)
> +#define RCPU_PLL_PCIE_EN    TO_REG(0x138)
> +#define RCPU_PLL_I2S_EN     TO_REG(0x13C)

Nit: make the 0x case and leading zeros uniform.

> +#define RCPU_PLL_MM_CFG     TO_REG(0x19c)
> +#define RCPU_PLL_HSIO_CFG   TO_REG(0x1a0)
> +#define RCPU_PLL_PCIE_CFG   TO_REG(0x1ac)
> +#define RCPU_BOOT_MODE_CFG  TO_REG(0x1b0)
> +#define RCPU_PLL_I2S_CFG    TO_REG(0x1f4)
> +#define RCPU_I2S_DIV_CFG    TO_REG(0x1f8)
> +#define RCPU_BUS_CFG        TO_REG(0x1fc)
> +#define RCPU_PLL1_MM_CFG    TO_REG(0x2a4)

> +
> +static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
> +                                   uint64_t data, unsigned size)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    if (offset >= c->regs_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    trace_tt_atlantis_prcm_write(c->domain, offset, data);
> +
> +    s->regs[TO_REG(offset)] = data;

Are there any fields that should be read only? The PLL lock bits?

>
> +    }
> +
> +    if (data & PLL_EN) {
> +        s->regs[pll_reg_offset] |= BIT(PLL_LOCK_BIT);
> +    } else {
> +        s->regs[pll_reg_offset] &= ~BIT(PLL_LOCK_BIT);
> +    }
> +}
> +
> +static const MemoryRegionOps tt_atlantis_prcm_ops = {
> +    .read = tt_atlantis_prcm_read,
> +    .write = tt_atlantis_prcm_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops = {
> +    .read = tt_atlantis_prcm_read,
> +    .write = tt_atlantis_prcm_rcpu_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,

Are we sure? Do byte accesses trap on hardware?

> +    .valid.max_access_size = 4,
> +};
> +
> +static void tt_atlantis_prcm_realize(DeviceState *dev, Error **errp)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    if (c->domain >= PRCM_DOMAIN_COUNT) {

This is set in this file, so it's not going to change at runtime. Do
we make it an assert?

> +        error_setg(errp,
> +                   "domain %d is larger than max number of possible domains %d",
> +                   c->domain, PRCM_DOMAIN_COUNT);
> +        return;
> +    }
> +    s->regs = g_new0(uint32_t, TO_REG(c->regs_size));
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), c->ops, s,
> +                          TYPE_TT_ATLANTIS_PRCM, c->regs_size);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void tt_atlantis_prcm_reset_hold(Object *obj, ResetType type)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(obj);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    memset(s->regs, 0, c->regs_size);
> +}

> +static void tt_atlantis_prcm_class_init(ObjectClass *klass,
> +                                        const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    dc->unrealize = tt_atlantis_prcm_unrealize;
> +    dc->desc = "Tenstorrent Atlantis PRCM Controller";
> +    rc->phases.hold = tt_atlantis_prcm_reset_hold;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_rcpu_class_init(ObjectClass *klass,
> +                                             const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;

The parent has already set this, so I think you can drop it from all
of the tt_atlantis_prcm_*_class_init

> +    dc->desc = "Tenstorrent Atlantis RCPU PRCM Controller";
> +    rc->phases.hold = tt_atlantis_prcm_rcpu_reset_hold;
> +    c->domain = PRCM_DOMAIN_RCPU;
> +    c->regs_size = RCPU_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_rcpu_ops;
> +}
> +
> +static void tt_atlantis_prcm_hsio_class_init(ObjectClass *klass,
> +                                             const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;

Same.

> +    dc->desc = "Tenstorrent Atlantis HSIO PRCM Controller";
> +    rc->phases.hold = tt_atlantis_prcm_hsio_reset_hold;
> +    c->domain = PRCM_DOMAIN_HSIO;
> +    c->regs_size = HSIO_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;

These are the same for all but the rpcu too. I wonder if we should set
it in tt_atlantis_prcm_class_init and only override in
tt_atlantis_prcm_rcpu_class_init?

> +}
> +
> +static void tt_atlantis_prcm_pcie_class_init(ObjectClass *klass,
> +                                             const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;

Same.

> +    dc->desc = "Tenstorrent Atlantis PCIE PRCM Controller";
> +    rc->phases.hold = tt_atlantis_prcm_pcie_reset_hold;
> +    c->domain = PRCM_DOMAIN_PCIE;
> +    c->regs_size = PCIE_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_mm_class_init(ObjectClass *klass,
> +                                           const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;

Same.

> +    dc->desc = "Tenstorrent Atlantis MM PRCM Controller";
> +    rc->phases.hold = tt_atlantis_prcm_mm_reset_hold;
> +    c->domain = PRCM_DOMAIN_MM;
> +    c->regs_size = MM_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_ddrc0_class_init(ObjectClass *klass,
> +                                              const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;

Same.

> +    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 0 PRCM";
> +    rc->phases.hold = tt_atlantis_prcm_ddrc_reset_hold;
> +    c->domain = PRCM_DOMAIN_DDRC0;
> +    c->regs_size = DDRC0_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_ddrc1_class_init(ObjectClass *klass,
> +                                              const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;

Same.

> +    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 1 PRCM";
> +    rc->phases.hold = tt_atlantis_prcm_ddrc_reset_hold;
> +    c->domain = PRCM_DOMAIN_DDRC1;
> +    c->regs_size = DDRC1_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}

> diff --git a/include/hw/misc/tt_atlantis_prcm.h b/include/hw/misc/tt_atlantis_prcm.h
> new file mode 100644
> index 0000000000..dc7938433a
> --- /dev/null
> +++ b/include/hw/misc/tt_atlantis_prcm.h

> +
> +enum {
> +    PRCM_DOMAIN_RCPU = 0,
> +    PRCM_DOMAIN_HSIO = 1,
> +    PRCM_DOMAIN_PCIE = 2,
> +    PRCM_DOMAIN_MM = 3,
> +    PRCM_DOMAIN_DDRC0 = 4,
> +    PRCM_DOMAIN_DDRC1 = 5,
> +    PRCM_DOMAIN_COUNT = 6
> +};

Given these are in the "public" header, give them a prefix. TT_,
TT_ATLANTIS_PRCM_, whatever you think is sensible.

Or move them out. I think they are only used by the machine to index
into it's array of devices, so they're not really part of the model,
and could live in tt_atlantis.c.



> +
> +struct TTAtlantisPRCMState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t *regs;
> +};
> +
> +struct TTAtlantisPRCMClass {
> +    SysBusDeviceClass parent_class;
> +
> +    uint32_t domain;
> +    uint32_t regs_size;
> +    const MemoryRegionOps *ops;
> +};
> +
> +#endif
>
> --
> 2.43.0
>

