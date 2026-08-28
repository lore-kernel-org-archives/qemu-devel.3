Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AAAC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzmMO-0005K2-FC; Thu, 27 Aug 2026 22:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzmME-0005IV-VU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 22:30:21 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzmMB-0004d9-SC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 22:30:18 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7dbcb505578so6373947b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 19:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787884214; cv=none;
 d=google.com; s=arc-20260327;
 b=V3XKEoXdsXeqUaroIDFVo6RZaHP3xxBxWD/cShqEhz6lDYfvJRwGHoFIgUSY2tU+n/
 IzS6+oTw5C2+3D+rHxZCpSg2JHirywBH7A63+9t71715iBgnSKSYZ3DgONMyKhjGG4OR
 w1aNOkz89W1VzQwsh4l4pE9l9BVimRSDXJM9vzgi44DhBgWs+UnQaSc0/lsCxST9RTsY
 57AS6RlD248CJwSo3ySFdHx8GsJoQ9aO1U+wgu07CwbaHaVjxXLcdObZyfPc2f4JSvtA
 kEK/COCeBOhGaLTo1JnsZvki3Zkfreur0QE5O+wAHDm7pxrMs49W7F66frRGNsbw+IMg
 b2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hJNSnNZklrJGp3c78mYTdDJHPCCOOrq1tloQ9PqPqO0=;
 fh=fi6EkmAcHre70J/1/Kpblsy6Abs9eQdzmlytBWwZ2V8=;
 b=C4iqsYeKdY+DXKeSNESnHwqTvd8/nQRZ1PiNFiZGOn7NCaU/ZixS0Z+seFw2LZSXND
 yiHCZhQgkvCXFA3mxnur0KLS++KM1OlOVTZo99pUGFD6YSSuBaxFV9LDiEj4wTdLsLIe
 +U+bS9kUEfpJkCjfvqPpjWDvfNMLrKt5eTkf9U2XGtUnqbiDILo88utD0D5zGOSkcxY5
 GAw8EhIXQ4hydJgRPSaBl36v+ukN6ZqwYJusoYev0dKCDUv2O0GtXKALUxGBDNbzDEJ9
 fxMyK8GZvtOw47/k1unFr0eyAUwkWCWHeumIqlvcEjONc/Lz0VDg0tn/UauWP6cFaTqI
 +0xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787884214; x=1788489014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hJNSnNZklrJGp3c78mYTdDJHPCCOOrq1tloQ9PqPqO0=;
 b=MGE9yfsjhqS0d6ZzvWQ6WAp1Xsnz6G35zJspEk+mFUQF/CTquJG29SBpwrE0Um0W+6
 ahbFSXknBhPjvPYDOHvWyLXGiSTA2rdtQ6cDqB/iqx6y9476Kvm3NK473THg1OrJ4Xkg
 GNWi3kO8CK2VXGSqcDcTnD7rdE1KcXQ05JfvtWsrEgrGQPQkijg1uKdw8UHfJ2ewbkAT
 066JPK2lwkcMklS9BM02m/iVAuJ/SZ1IIDXGYYBrwJNVnyoTrEiBMbQcOXkeIeUV7pw8
 aapHyudg/liI51tU60wfg35ZaeJU0WcV02mU5PEKkUhXEqneCLyaueBCWQAh66hKnjxZ
 sjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787884214; x=1788489014;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hJNSnNZklrJGp3c78mYTdDJHPCCOOrq1tloQ9PqPqO0=;
 b=JpqoMcIaj4PFvy4pYt0gCbjnqQSuaiTNcVyzo4bD05f+776+p1rFcHhkGeqJgJlkZy
 bvuf2q1Rm3RV1J0b5jytZwroPUmQtXZrgPDAU9klmuYSTlmAyUJXkVcultkhkRRkhDr4
 Uy57JJKOBifr7ZjYaHwllSMTrgtmAFfx/aEl1UgbNbKHtflD2vfkNc6Xn1Us+28NVFK2
 3oSkdzhzZdsEf/oRv8AVeofPRXngr1FzBv5tpdqszQ9wY95wmWxUQjNdx2a3Kw8NYFBM
 ODW5RRucdcoU5WtV8uYVJy6lghGbXTPX9Np1PaT5UI3eh+K5gsToZFTpqwNas1Q7e42G
 I/9A==
X-Gm-Message-State: AFuF++kQkHsKx9NlAiQse7dpCN6MtUEKXLYvX+YTADiSI6Xsf0bSBkfr
 4zxVtXnqeQHhaDt8jF7tFi6Mn68oUHGlIosU5GJmu2xbRvZay4wLCXTQPErEb5HMf0CVBmHYca0
 kEqEGg5J8OjDq7yP/APVLWOwXZMH+7wGy5VXjrstVXg==
X-Gm-Gg: AR+sD13tt58VxM8Ywi41/dN/lwjKusAmyFWHIkjS+FRPzK8evf2nTwwaEfC6oWjRHh8
 JdfvcBnSvlQqTYl1vFUN8PYEHpqgJZf9VhUoepFO93GUuZLn5UG6Dj6bZsMxjEujWiXQVNVy2eq
 3H/HfulC0+jqb3RCmiO5W14TsLEhbpAKyeBueTDRaLLCgqGdb3e8oXPdR1QlUDzfM+ZhpqHvfl8
 BTe0AdB0R/FDW2Zo+ow7gtLtp8dnjIaPnoeP/aMOckxjtzDwxZ6PjMbEFPMpCbzyAjeiws0ESjR
 41da6DI1gP31fMGKUP7ttR1jb1CXIxGm/+shpFkGdC0f+ipFFUFH852KJyqLOgQbERNHXVhkRMB
 J
X-Received: by 2002:a05:690e:4554:10b0:66c:7f92:1767 with SMTP id
 956f58d0204a3-66e4c643178mr845360d50.14.1787884213461; Thu, 27 Aug 2026
 19:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-atlantis_prcm-v2-0-ffba0b944419@oss.tenstorrent.com>
 <20260817-atlantis_prcm-v2-1-ffba0b944419@oss.tenstorrent.com>
 <1287b0f1687e31234fc3c92dd6da115af53f4e69.camel@wdc.com>
In-Reply-To: <1287b0f1687e31234fc3c92dd6da115af53f4e69.camel@wdc.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 27 Aug 2026 21:30:02 -0500
X-Gm-Features: AcwNN1Vqpw_rg6KLLsHtQXGmusF9SC_OovrOnNfZT6w2-h3VPHen_qEASZ0Z6ts
Message-ID: <CAEev2e-1fUo8hm_tn3oGARH0viXTF_rOq1KQOgR49NBxXixV-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "joel@jms.id.au" <joel@jms.id.au>, 
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "mpe@kernel.org" <mpe@kernel.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>, 
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alistair,

On Thu, Aug 27, 2026 at 8:58=E2=80=AFPM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Mon, 2026-08-17 at 09:42 -0500, Anirudh Srinivasan wrote:
> > This device present in Tenstorrent Atlantis has registers that
> > control
> > clocks, reset and other misc functionality in the SoC. This commit
> > adds
> > models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
> >
> > Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >  MAINTAINERS                        |   2 +
> >  hw/misc/meson.build                |   1 +
> >  hw/misc/trace-events               |   4 +
> >  hw/misc/tt_atlantis_prcm.c         | 442
> > +++++++++++++++++++++++++++++++++++++
> >  include/hw/misc/tt_atlantis_prcm.h |  51 +++++
> >  5 files changed, 500 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e25df9493c..49c1a5ad76 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1802,7 +1802,9 @@ R: Portia Stephens
> > <portias@oss.tenstorrent.com>
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
> > index 23265f6035..26627013f3 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI',
> > if_true: files('sifive_e_prci.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true:
> > files('sifive_e_aon.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true:
> > files('sifive_u_otp.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true:
> > files('sifive_u_prci.c'))
> > +system_ss.add(when: 'CONFIG_TENSTORRENT', if_true:
> > files('tt_atlantis_prcm.c'))
> >
> >  subdir('macio')
> >
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index c9a868b3ef..9359a4e66d 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t
> > len) "gva=3D0x%" PRIx64 " len=3D%u"
> >  iommu_testdev_dma_verify(uint32_t expected, uint32_t actual)
> > "expected=3D0x%x actual=3D0x%x"
> >  iommu_testdev_dma_result(uint32_t result) "DMA completed
> > result=3D0x%x"
> >  iommu_testdev_dma_armed(bool armed) "armed=3D%d"
> > +
> > +# tt_atlantis_prcm.c
> > +tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t
> > data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> > +tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t
> > data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> > diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
> > new file mode 100644
> > index 0000000000..571f2a08fe
> > --- /dev/null
> > +++ b/hw/misc/tt_atlantis_prcm.c
> > @@ -0,0 +1,442 @@
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
> > +#define PLL_RESET_VAL(BYPASS, REFDIV, POSTDIV1, POSTDIV2, FBDIV,
> > LOCK)         \
> > +  ((LOCK << PLL_LOCK_BIT) | (FBDIV << PLL_FBDIV_LSB)
> > |                         \
> > +   (POSTDIV2 << PLL_POSTDIV2_LSB) | (POSTDIV1 << PLL_POSTDIV1_LSB)
> > |           \
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
> > +#define RCPU_PLL_MM_CFG     TO_REG(0x19c)
> > +#define RCPU_PLL_HSIO_CFG   TO_REG(0x1a0)
> > +#define RCPU_PLL_PCIE_CFG   TO_REG(0x1ac)
> > +#define RCPU_BOOT_MODE_CFG  TO_REG(0x1b0)
> > +#define RCPU_PLL_I2S_CFG    TO_REG(0x1f4)
> > +#define RCPU_I2S_DIV_CFG    TO_REG(0x1f8)
> > +#define RCPU_BUS_CFG        TO_REG(0x1fc)
> > +#define RCPU_PLL1_MM_CFG    TO_REG(0x2a4)
> > +
> > +#define HSIO_HSIO_DIV_CFG       TO_REG(0x0)
> > +#define HSIO_HSIO_DIV_CFG1      TO_REG(0x4)
> > +#define HSIO_HSIO_BLK_CG        TO_REG(0x8)
> > +#define HSIO_HSIO_BLK_RST       TO_REG(0xc)
> > +#define HSIO_HSIO_GMAC_DIV_CFG  TO_REG(0x10)
> > +
> > +#define PCIE_SUBS_RST_CTL   TO_REG(0x0)
> > +#define PCIE_SUBS_CG_CTL    TO_REG(0x4)
> > +#define PCIE_SUBS_CK_CTL    TO_REG(0x8)
> > +
> > +#define MM_MM_CLK_GATE_CFG  TO_REG(0x8)
> > +#define MM_MM_CLK_DIV_CFG   TO_REG(0xC)
> > +#define MM_MM_CLK_SEL_CFG   TO_REG(0x10)
> > +#define MM_MM_RSTN          TO_REG(0x14)
> > +#define MM_MM_CLK_DIV_CFG1  TO_REG(0x130)
> > +
> > +#define DDRC_STAT           TO_REG(0x10014)
> > +#define DDRC_DFISTAT        TO_REG(0x10514)
> > +#define DDRC_SWSTAT         TO_REG(0x10c84)
> > +
> > +#define PLL_EN              BIT(0)
> > +#define RCPU_PLL_BUS_CG_EN  BIT(7)
> > +#define HSIO_PLL_BUS_CG_EN  BIT(3)
> > +#define PCIE_PLL_BUS_CG_EN  BIT(1)
> > +#define NOCC_PLL_BUS_CG_EN  BIT(0)
>
> You don't have to change this, but in future please try to use the
> REG32/FIELD API. It's a lot nicer :)

Ha, I came across that way of doing things after writing this model.
Will keep it in mind for the future.

>
> > +
> > +#define RCPU_BOOT_MODE_UART      (0x0 << 4)
> > +#define RCPU_BOOT_MODE_NOR       (0x1 << 4)
> > +#define RCPU_BOOT_MODE_SD        (0x2 << 4)
> > +
> > +#define RCPU_DOMAIN_SIZE   0x10000
> > +#define HSIO_DOMAIN_SIZE   0x510
> > +#define PCIE_DOMAIN_SIZE   0x100
> > +#define MM_DOMAIN_SIZE     0x1000
> > +#define DDRC0_DOMAIN_SIZE  0x101000
> > +#define DDRC1_DOMAIN_SIZE  0x101000
> > +
> > +static uint64_t tt_atlantis_prcm_read(void *opaque, hwaddr offset,
> > +                                      unsigned size)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +    uint32_t data;
> > +
> > +    if (offset >=3D c->regs_size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds read at offset 0x%"
> > HWADDR_PRIx "\n",
> > +                      __func__, offset);
> > +        return 0;
> > +    }
> > +    data =3D s->regs[TO_REG(offset)];
> > +
> > +    trace_tt_atlantis_prcm_read(c->domain, offset, data);
> > +    return data;
> > +}
> > +
> > +static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
> > +                                   uint64_t data, unsigned size)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    if (offset >=3D c->regs_size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds write at offset 0x%"
> > HWADDR_PRIx "\n",
> > +                      __func__, offset);
> > +        return;
> > +    }
> > +
> > +    trace_tt_atlantis_prcm_write(c->domain, offset, data);
> > +
> > +    s->regs[TO_REG(offset)] =3D data;
> > +}
> > +
> > +static void tt_atlantis_prcm_rcpu_write(void *opaque, hwaddr offset,
> > +                                        uint64_t data, unsigned
> > size)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +
> > +    tt_atlantis_prcm_write(opaque, offset, data, size);
>
> You probably don't need to log the size
>
> > +
> > +    uint32_t pll_reg_offset;
>
> Don't mix declarations and code please. This should be at the top of
> the function (checkpatch should catch this).

Yes, will fix.

>
> > +    switch (TO_REG(offset)) {
> > +    case RCPU_PLL_RCPU_EN:
> > +        pll_reg_offset =3D RCPU_PLL_RCPU_CFG;
> > +        break;
> > +    case RCPU_PLL_NOCC_EN:
> > +        pll_reg_offset =3D RCPU_PLL_NOCC_CFG;
> > +        break;
> > +    case RCPU_PLL_HSIO_EN:
> > +        pll_reg_offset =3D RCPU_PLL_HSIO_CFG;
> > +        break;
> > +    case RCPU_PLL_PCIE_EN:
> > +        pll_reg_offset =3D RCPU_PLL_PCIE_CFG;
> > +        break;
> > +    case RCPU_PLL_MM_EN:
> > +        pll_reg_offset =3D RCPU_PLL_MM_CFG;
> > +        break;
> > +    case RCPU_PLL1_MM_EN:
> > +        pll_reg_offset =3D RCPU_PLL1_MM_CFG;
> > +        break;
> > +    case RCPU_PLL_I2S_EN:
> > +        pll_reg_offset =3D RCPU_PLL_I2S_CFG;
> > +        break;
> > +    default:
> > +        return;
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
> > +        error_setg(errp,
> > +                   "domain %d is larger than max number of possible
> > domains %d",
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
> > +
> > +static void tt_atlantis_prcm_rcpu_reset_hold(Object *obj, ResetType
> > type)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> > +    tt_atlantis_prcm_reset_hold(obj, type);
> > +
> > +    s->regs[RCPU_PLL_RCPU_CFG] =3D PLL_RESET_VAL(1, 0, 4, 0, 100, 1);
> > +    s->regs[RCPU_PLL_NOCC_CFG] =3D PLL_RESET_VAL(0, 2, 2, 2, 267, 1);
> > +    s->regs[RCPU_NOCC_CLK_CFG] =3D
> > +        (0x25f31 << 1) | BIT(0); /* Value from Datasheet */
>
> I hope the value comes from the datasheet. Where else would it come
> from!

Another reviewer (Daniel) asked to mention where these come from, I'll
add a single comment at the top instead.

>
> > +    s->regs[RCPU_RCPU_DIV_CFG] =3D (0xb8c2 << 1); /* Value from
> > Datasheet */
> > +    s->regs[RCPU_RCPU_BLK_CG] =3D 0;
> > +    s->regs[RCPU_LSIO_BLK_CG] =3D 0;
> > +    s->regs[RCPU_RCPU_BLK_RST] =3D 0xffffffff;
> > +    s->regs[RCPU_LSIO_BLK_RST] =3D 0xffffffff;
> > +    s->regs[RCPU_PLL_RCPU_EN] =3D PLL_EN;
> > +    s->regs[RCPU_PLL_NOCC_EN] =3D PLL_EN;
> > +    s->regs[RCPU_PLL_HSIO_EN] =3D 0;
> > +    s->regs[RCPU_PLL_MM_EN] =3D 0;
> > +    s->regs[RCPU_PLL1_MM_EN] =3D 0;
> > +    s->regs[RCPU_PLL_I2S_EN] =3D 0;
> > +    s->regs[RCPU_PLL_PCIE_EN] =3D 0;
>
> You don't need to set the 0's, you have already memset(0)

I was experimenting with different reset values here to test if the
linux driver handles weird/unrealistic edge cases. So I've left them
in.

>
> > +    s->regs[RCPU_PLL_HSIO_CFG] =3D PLL_RESET_VAL(0, 1, 2, 1, 50, 0);
> > +    s->regs[RCPU_PLL_PCIE_CFG] =3D PLL_RESET_VAL(0, 2, 3, 1, 250, 0);
> > +    s->regs[RCPU_BOOT_MODE_CFG] =3D RCPU_BOOT_MODE_SD;
> > +    s->regs[RCPU_PLL_MM_CFG] =3D PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> > +    s->regs[RCPU_PLL1_MM_CFG] =3D PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> > +    s->regs[RCPU_PLL_I2S_CFG] =3D PLL_RESET_VAL(0, 1, 6, 6, 33, 0);
> > +    s->regs[RCPU_I2S_DIV_CFG] =3D 0xde69ad31; /* Value from Datasheet
> > */
> > +    s->regs[RCPU_BUS_CFG] =3D NOCC_PLL_BUS_CG_EN | HSIO_PLL_BUS_CG_EN;
> > +}
> > +
> > +static void tt_atlantis_prcm_ddrc_reset_hold(Object *obj, ResetType
> > type)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> > +    tt_atlantis_prcm_reset_hold(obj, type);
> > +
> > +    s->regs[DDRC_STAT] =3D 0x1;
> > +    s->regs[DDRC_DFISTAT] =3D 0x1;
> > +    s->regs[DDRC_SWSTAT] =3D 0x1;
> > +}
> > +
> > +static void tt_atlantis_prcm_hsio_reset_hold(Object *obj, ResetType
> > type)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> > +    tt_atlantis_prcm_reset_hold(obj, type);
> > +
> > +    s->regs[HSIO_HSIO_DIV_CFG] =3D 0x20821731; /* Value from Datasheet
> > */
> > +    s->regs[HSIO_HSIO_DIV_CFG1] =3D 0x8; /* Value from Datasheet */
> > +    s->regs[HSIO_HSIO_BLK_CG] =3D 0;
> > +    s->regs[HSIO_HSIO_BLK_RST] =3D 0;
> > +    s->regs[HSIO_HSIO_GMAC_DIV_CFG] =3D 0;
> > +}
> > +
> > +static void tt_atlantis_prcm_pcie_reset_hold(Object *obj, ResetType
> > type)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> > +    tt_atlantis_prcm_reset_hold(obj, type);
> > +
> > +    s->regs[PCIE_SUBS_RST_CTL] =3D 0;
> > +    s->regs[PCIE_SUBS_CG_CTL] =3D 0;
> > +    s->regs[PCIE_SUBS_CK_CTL] =3D 0x44908; /* Value from Datasheet */
> > +}
> > +
> > +static void tt_atlantis_prcm_mm_reset_hold(Object *obj, ResetType
> > type)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> > +    tt_atlantis_prcm_reset_hold(obj, type);
> > +
> > +    s->regs[MM_MM_CLK_GATE_CFG] =3D 0;
> > +    s->regs[MM_MM_CLK_DIV_CFG] =3D 0xddc8312; /* Value from Datasheet
> > */
> > +    s->regs[MM_MM_CLK_SEL_CFG] =3D 0;
> > +    s->regs[MM_MM_RSTN] =3D 0;
> > +    s->regs[MM_MM_CLK_DIV_CFG1] =3D 0x333; /* Value from Datasheet */
> > +}
> > +
> > +static void tt_atlantis_prcm_unrealize(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +
> > +    g_free(s->regs);
> > +}
> > +
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
> +    rc->phases.hold =3D tt_atlantis_prcm_reset_hold;
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
> > +    dc->desc =3D "Tenstorrent Atlantis RCPU PRCM Controller";
> > +    rc->phases.hold =3D tt_atlantis_prcm_rcpu_reset_hold;
>
> You could use a rc->phases.enter to call tt_atlantis_prcm_reset_hold()
> here instead. Not sure if that's better though

I was using legacy_reset previously. Another reviewer (Daniel)
suggested using reset_hold instead.

>
> Alistair

Regards
Anirudh Srinivasan

