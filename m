Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D3FCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBzFI-00089D-4T; Wed, 30 Sep 2026 14:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xBzF8-00088P-JR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:41:26 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xBzF5-0007JC-OZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:41:26 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab3fa8a788so28431387b3.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790793682; cv=none;
 d=google.com; s=arc-20260327;
 b=beYdRyqbHWtE7WO/ZT4SizZn42AynrFABCy6hMJb4AdvdGjpQ+64mxdDu6vZF99uNS
 TR/lVoS2ZQwVPHnAU8iIBpbhIRUqMZaxvHUsY46hUZNDGqaXnxp11lWEp6a51hixMe6j
 76m1CAfw6KGVkRtIdvYh+DefKYFryvQNWKfIr3SBv9DtkaiQzgwve/W6bv9f0DlE2BEA
 py+c+H1kSrVPT8v8hczoJINbD8fWBMDhiV4FryUqZ5EvJwvLfI9lfYH2WEukgxU2tShV
 b4ig/bQSl2I2CMwJuhiaMXUwp1uXSsxY5h68fGF8MeHIAoM6ctQvChRAsnxFhqBF4Eo3
 bI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m2LIEofa18e0nuYlpMhnJ2HO/g2bNMXpoqe8ALR0tSE=;
 fh=T7GZKU3pqGfZDaVHTkyCxWlgssTqcxXKF3+qSko7WPo=;
 b=c0U9JTS8EEWyfZBepqpEq/Ysxldu+ikeZPYOwPjN4kJGWsM+Zyrnd05D7mjxIU3KWe
 gfYG1Gc6AF99Ns//U3HsjsKnwNOJlXJxXMeTU/QUeFuBsca1NyDa+3t2aRTIoEazVo/m
 vzFbnwmVq3Ew5QJ+IZCWO6mhEh6F6Qeqq3zmzghT0lxzAFGsxSX2S3I/jlhJMnVWK9Cs
 R475ncWS/Gs28zmLfEwznymIGabUmLMyvsKSUo8nLCHVikx6vOSfkL5z/Oml3USv2FYr
 WeQrc7j398s02ERPlgRTToblPkUHQOwJ9MLQLp9sL9NhkM7+QbyKHRAaWwCo32gQe60p
 bYBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790793682; x=1791398482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m2LIEofa18e0nuYlpMhnJ2HO/g2bNMXpoqe8ALR0tSE=;
 b=SEdXCcrBAmzbenFYqZpuUr/Mn4PSbf5ddbpJzv1YZ04YxK11P4OFIGAxlC8dp8PHnh
 3wqrJVPpnu4o20i8S9joE82zvT6J41Gm7KON+8SySLOvfuwy3a0IB9baob/EhaBcovOP
 zaVdIGoBSPEcTQK9IlWW7Uwkgr36vgcSVHT9OOuQdiwK/w4Hi9H5mP8CIbqvOaHRnGmM
 HBgHLeYNfKMhZbGHqLvTMTh9Uwfeya0EMBCG5HIv0HJmMLwafLpQ5LdxyuKSSPhUyt+y
 seKSZgUUgXsB+5KGZqU3A+dPwF5mCpVGEHEqp3PPtAS3tcyFU2mqAp38P+lDlsVGzYi2
 T3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793682; x=1791398482;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2LIEofa18e0nuYlpMhnJ2HO/g2bNMXpoqe8ALR0tSE=;
 b=XeddN/jpPyn+NxVeynGDOox5lwUlhbdRWot5Y/Bswr708ixHiaD17BxUEGaU84ZX8I
 JYeMK3vtijMh7xSIZElxPas8kIbk6n9MsTfjgzzuOdqtniVGdtTLwBzrE8o1ZS6HhhSg
 T5nlwfz7k+vhqwA/seRdlR+uMRodDLYM1D7YOKQLuHd73kn33uPlqZhkw9Biz9VXtcyz
 w8aJIic3f5Xxra9D9vdgK/prJIBmz4PMwVi/SvrsHjJ4ojrxdQZOyAysjX13ce3t+GIO
 2LcsE33jGyVabFrZhdeXXR9ZpM+RPUpLSGSDLKT0lsie+iZtNvMyp7QuBag0kyw8TiIy
 mDeA==
X-Gm-Message-State: AFq9FYJ7no/mUGNlyTVPlQZ3Y4qgtuTEb5bkJjaeacbFNrlIXiAcL6xW
 /CacvZDM//e69aJeC7omfGseik659sgxjp0KlwDNGG0ndc1yFwKf/Gi1WL7GRA4JqI+ozH7NjRp
 HkAY9z0w9QfdcjsJOjNZyVApa70YRPPW/bHnSqvi+Dg==
X-Gm-Gg: AYBFou3KZIOqlL7Zfips+b94mw7N+7pFnjgkz8IweMb9JEesXnJEfOufIdQVoxs9sle
 kUcCv1aTyfui6b0v0uM+ZZQ/jz9x/hDvLjVF9X+POuZZ4QyOuCs/R5h6TonC2/KWGMVih2Gh8jp
 wb7KY6mRNnqMnhmhisOnYdVNw868tfXIfmPy/NEb3brd+eIsMs4u1IEdJCTzmTSng7bx/A3MmG0
 O95Int0znTP0jnMZNvja1xbK09pXGLFJQj+Y5QdqCDOLj8b0yuCP+91B7cz4Eq4AOFdOuF17WgK
 lhWtp+SX2JccgHQCRzINFlk98xZOBTRuY8mw6/XAT/sgi7dDXwKrgE6L7ocGAtS6RgJi5O+UCeo
 1OF5cYgTeRA==
X-Received: by 2002:a05:690c:39c:b0:8a8:e0c7:dc3f with SMTP id
 00721157ae682-8ac922869f9mr10134787b3.18.1790793681821; Wed, 30 Sep 2026
 11:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
 <20260904-atlantis_prcm-v3-1-8bf20795a381@oss.tenstorrent.com>
 <CACPK8Xdfq5_tTqCfQfwi3tLimbG5YNO8_H39TY67TArPV1Ls1w@mail.gmail.com>
In-Reply-To: <CACPK8Xdfq5_tTqCfQfwi3tLimbG5YNO8_H39TY67TArPV1Ls1w@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 30 Sep 2026 13:41:10 -0500
X-Gm-Features: AclHuK8Hco7PyBpljy-rP0UrYe4i4MkSAj5cvssdjSDmmTBO6sgYCPakPpH_5tU
Message-ID: <CAEev2e-m1JU6qFQ71xHLxGEo1ju4RTEHZG7zGOmB+EWZN3kQWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Joel Stanley <joel@jms.id.au>
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
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, Sep 30, 2026 at 1:59=E2=80=AFAM Joel Stanley <joel@jms.id.au> wrote=
:
>
> On Sat, 5 Sept 2026 at 00:18, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > This device present in Tenstorrent Atlantis has registers that control
> > clocks, reset and other misc functionality in the SoC. This commit adds
> > models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
> >
> > Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> > ---
> >  MAINTAINERS                        |   2 +
> >  hw/misc/meson.build                |   1 +
> >  hw/misc/trace-events               |   4 +
> >  hw/misc/tt_atlantis_prcm.c         | 446 +++++++++++++++++++++++++++++=
++++++++
> >  include/hw/misc/tt_atlantis_prcm.h |  51 +++++
> >  5 files changed, 504 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f524d90523..b6cc077602 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1830,7 +1830,9 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
> >  L: qemu-riscv@nongnu.org
> >  S: Supported
> >  F: docs/system/riscv/tt_*.rst
> > +F: hw/misc/tt_*.c
> >  F: hw/riscv/tt_*.c
> > +F: include/hw/misc/tt_*.h
> >  F: include/hw/riscv/tt_*.h
> >  F: tests/functional/riscv64/test_tt_*.py
> >
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 54e07aacda..11b9593e03 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -39,6 +39,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: f=
iles('sifive_e_aon.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_ot=
p.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_p=
rci.c'))
> >  system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_de=
comp_gzip.c'))
> > +system_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis_=
prcm.c'))
> >
> >  subdir('macio')
> >
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index 0b8be3d0f2..8b80b71107 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -452,3 +452,7 @@ launch_update_write(void) ""
> >  vmlaunch_reset_enter(void) ""
> >  vm_launchupdate_finalize(void) ""
> >  restore_host_x86_igvm(void) ""
> > +
> > +# tt_atlantis_prcm.c
> > +tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t data)=
 "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> > +tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data=
) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> > diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
> > new file mode 100644
> > index 0000000000..392d7da7f4
> > --- /dev/null
> > +++ b/hw/misc/tt_atlantis_prcm.c
> > @@ -0,0 +1,446 @@
> > +/*
> > + * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Copyright 2026 Tenstorrent
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/bitops.h"
> > +#include "qapi/error.h"
> > +#include "qemu/log.h"
> > +#include "hw/misc/tt_atlantis_prcm.h"
> > +#include "hw/core/qdev-properties.h"
> > +#include "hw/core/registerfields.h"
> > +#include "hw/core/irq.h"
>
> The three above are unused.
>
> > +#include "trace.h"
> > +
> > +#define TO_REG(offset) ((offset) >> 2)
> > +
> > +#define PLL_LOCK_BIT        31
> > +#define PLL_FBDIV_LSB       14
> > +#define PLL_POSTDIV2_LSB    11
> > +#define PLL_POSTDIV1_LSB    8
> > +#define PLL_REFDIV_LSB      2
> > +#define PLL_BYPASS_BIT      1
> > +
> > +#define PLL_RESET_VAL(BYPASS, REFDIV, POSTDIV1, POSTDIV2, FBDIV, LOCK)=
         \
> > +  ((LOCK << PLL_LOCK_BIT) | (FBDIV << PLL_FBDIV_LSB) |                =
         \
> > +   (POSTDIV2 << PLL_POSTDIV2_LSB) | (POSTDIV1 << PLL_POSTDIV1_LSB) |  =
         \
> > +   (REFDIV << PLL_REFDIV_LSB) | (BYPASS << PLL_BYPASS_BIT))
> > +
> > +#define RCPU_PLL_RCPU_CFG   TO_REG(0)
> > +#define RCPU_PLL_NOCC_CFG   TO_REG(0x4)
> > +#define RCPU_NOCC_CLK_CFG   TO_REG(0x8)
> > +#define RCPU_RCPU_DIV_CFG   TO_REG(0xc)
> > +#define RCPU_RCPU_BLK_CG    TO_REG(0x14)
> > +#define RCPU_LSIO_BLK_CG    TO_REG(0x18)
> > +#define RCPU_RCPU_BLK_RST   TO_REG(0x1c)
> > +#define RCPU_LSIO_BLK_RST   TO_REG(0x20)
> > +#define RCPU_PLL_RCPU_EN    TO_REG(0x11c)
> > +#define RCPU_PLL_NOCC_EN    TO_REG(0x120)
> > +#define RCPU_PLL_MM_EN      TO_REG(0x0124)
> > +#define RCPU_PLL1_MM_EN     TO_REG(0x0128)
> > +#define RCPU_PLL_HSIO_EN    TO_REG(0x12c)
> > +#define RCPU_PLL_PCIE_EN    TO_REG(0x138)
> > +#define RCPU_PLL_I2S_EN     TO_REG(0x13C)
>
> Nit: make the 0x case and leading zeros uniform.
>
> > +#define RCPU_PLL_MM_CFG     TO_REG(0x19c)
> > +#define RCPU_PLL_HSIO_CFG   TO_REG(0x1a0)
> > +#define RCPU_PLL_PCIE_CFG   TO_REG(0x1ac)
> > +#define RCPU_BOOT_MODE_CFG  TO_REG(0x1b0)
> > +#define RCPU_PLL_I2S_CFG    TO_REG(0x1f4)
> > +#define RCPU_I2S_DIV_CFG    TO_REG(0x1f8)
> > +#define RCPU_BUS_CFG        TO_REG(0x1fc)
> > +#define RCPU_PLL1_MM_CFG    TO_REG(0x2a4)
>
> > +
> > +static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
> > +                                   uint64_t data, unsigned size)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    if (offset >=3D c->regs_size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_P=
RIx "\n",
> > +                      __func__, offset);
> > +        return;
> > +    }
> > +
> > +    trace_tt_atlantis_prcm_write(c->domain, offset, data);
> > +
> > +    s->regs[TO_REG(offset)] =3D data;
>
> Are there any fields that should be read only? The PLL lock bits?

Yes, but our driver isn't gonna try writing to them. Not sure if it is
really worth modeling it to that extent.

>
> >
> > +    }
> > +
> > +    if (data & PLL_EN) {
> > +        s->regs[pll_reg_offset] |=3D BIT(PLL_LOCK_BIT);
> > +    } else {
> > +        s->regs[pll_reg_offset] &=3D ~BIT(PLL_LOCK_BIT);
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps tt_atlantis_prcm_ops =3D {
> > +    .read =3D tt_atlantis_prcm_read,
> > +    .write =3D tt_atlantis_prcm_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid.min_access_size =3D 4,
> > +    .valid.max_access_size =3D 4,
> > +};
> > +
> > +static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops =3D {
> > +    .read =3D tt_atlantis_prcm_read,
> > +    .write =3D tt_atlantis_prcm_rcpu_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid.min_access_size =3D 4,
>
> Are we sure? Do byte accesses trap on hardware?

The spec defines that all the registers are 32-bit wide and uses word
addressing. All software that's gonna be using this region also assume
so and do read words only. Don't think it's worth accounting for this
weird edge case.

>
> > +    .valid.max_access_size =3D 4,
> > +};
> > +
> > +static void tt_atlantis_prcm_realize(DeviceState *dev, Error **errp)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    if (c->domain >=3D PRCM_DOMAIN_COUNT) {
>
> This is set in this file, so it's not going to change at runtime. Do
> we make it an assert?

Ack.

>
> > +        error_setg(errp,
> > +                   "domain %d is larger than max number of possible do=
mains %d",
> > +                   c->domain, PRCM_DOMAIN_COUNT);
> > +        return;
> > +    }
> > +    s->regs =3D g_new0(uint32_t, TO_REG(c->regs_size));
> > +
> > +    memory_region_init_io(&s->mmio, OBJECT(s), c->ops, s,
> > +                          TYPE_TT_ATLANTIS_PRCM, c->regs_size);
> > +    sysbus_init_mmio(sbd, &s->mmio);
> > +}
> > +
> > +static void tt_atlantis_prcm_reset_hold(Object *obj, ResetType type)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    memset(s->regs, 0, c->regs_size);
> > +}
>
> > +static void tt_atlantis_prcm_class_init(ObjectClass *klass,
> > +                                        const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
> > +    dc->unrealize =3D tt_atlantis_prcm_unrealize;
> > +    dc->desc =3D "Tenstorrent Atlantis PRCM Controller";
> > +    rc->phases.hold =3D tt_atlantis_prcm_reset_hold;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_rcpu_class_init(ObjectClass *klass,
> > +                                             const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
>
> The parent has already set this, so I think you can drop it from all
> of the tt_atlantis_prcm_*_class_init

Ack

>
> > +    dc->desc =3D "Tenstorrent Atlantis RCPU PRCM Controller";
> > +    rc->phases.hold =3D tt_atlantis_prcm_rcpu_reset_hold;
> > +    c->domain =3D PRCM_DOMAIN_RCPU;
> > +    c->regs_size =3D RCPU_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_rcpu_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_hsio_class_init(ObjectClass *klass,
> > +                                             const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
>
> Same.
>
> > +    dc->desc =3D "Tenstorrent Atlantis HSIO PRCM Controller";
> > +    rc->phases.hold =3D tt_atlantis_prcm_hsio_reset_hold;
> > +    c->domain =3D PRCM_DOMAIN_HSIO;
> > +    c->regs_size =3D HSIO_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
>
> These are the same for all but the rpcu too. I wonder if we should set
> it in tt_atlantis_prcm_class_init and only override in
> tt_atlantis_prcm_rcpu_class_init?

Ack.

>
> > +}
> > +
> > +static void tt_atlantis_prcm_pcie_class_init(ObjectClass *klass,
> > +                                             const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
>
> Same.
>
> > +    dc->desc =3D "Tenstorrent Atlantis PCIE PRCM Controller";
> > +    rc->phases.hold =3D tt_atlantis_prcm_pcie_reset_hold;
> > +    c->domain =3D PRCM_DOMAIN_PCIE;
> > +    c->regs_size =3D PCIE_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_mm_class_init(ObjectClass *klass,
> > +                                           const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
>
> Same.
>
> > +    dc->desc =3D "Tenstorrent Atlantis MM PRCM Controller";
> > +    rc->phases.hold =3D tt_atlantis_prcm_mm_reset_hold;
> > +    c->domain =3D PRCM_DOMAIN_MM;
> > +    c->regs_size =3D MM_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_ddrc0_class_init(ObjectClass *klass,
> > +                                              const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
>
> Same.
>
> > +    dc->desc =3D "Tenstorrent Atlantis DDR Memory Controller 0 PRCM";
> > +    rc->phases.hold =3D tt_atlantis_prcm_ddrc_reset_hold;
> > +    c->domain =3D PRCM_DOMAIN_DDRC0;
> > +    c->regs_size =3D DDRC0_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_ddrc1_class_init(ObjectClass *klass,
> > +                                              const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
>
> Same.
>
> > +    dc->desc =3D "Tenstorrent Atlantis DDR Memory Controller 1 PRCM";
> > +    rc->phases.hold =3D tt_atlantis_prcm_ddrc_reset_hold;
> > +    c->domain =3D PRCM_DOMAIN_DDRC1;
> > +    c->regs_size =3D DDRC1_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
>
> > diff --git a/include/hw/misc/tt_atlantis_prcm.h b/include/hw/misc/tt_at=
lantis_prcm.h
> > new file mode 100644
> > index 0000000000..dc7938433a
> > --- /dev/null
> > +++ b/include/hw/misc/tt_atlantis_prcm.h
>
> > +
> > +enum {
> > +    PRCM_DOMAIN_RCPU =3D 0,
> > +    PRCM_DOMAIN_HSIO =3D 1,
> > +    PRCM_DOMAIN_PCIE =3D 2,
> > +    PRCM_DOMAIN_MM =3D 3,
> > +    PRCM_DOMAIN_DDRC0 =3D 4,
> > +    PRCM_DOMAIN_DDRC1 =3D 5,
> > +    PRCM_DOMAIN_COUNT =3D 6
> > +};
>
> Given these are in the "public" header, give them a prefix. TT_,
> TT_ATLANTIS_PRCM_, whatever you think is sensible.
>
> Or move them out. I think they are only used by the machine to index
> into it's array of devices, so they're not really part of the model,
> and could live in tt_atlantis.c.

These are used in both tt_atlantis.c and tt_atlantis_prcm.c Will add a
TT_ATLANTIS_ prefix to it.

>
>
>
> > +
> > +struct TTAtlantisPRCMState {
> > +    SysBusDevice parent;
> > +
> > +    MemoryRegion mmio;
> > +
> > +    uint32_t *regs;
> > +};
> > +
> > +struct TTAtlantisPRCMClass {
> > +    SysBusDeviceClass parent_class;
> > +
> > +    uint32_t domain;
> > +    uint32_t regs_size;
> > +    const MemoryRegionOps *ops;
> > +};
> > +
> > +#endif
> >
> > --
> > 2.43.0
> >

Regards

Anirudh Srinivasan

