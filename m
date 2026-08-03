Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E643CC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wquia-00021Y-Oe; Mon, 03 Aug 2026 11:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wquiZ-000212-6i
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:36:43 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wquiW-0005Jb-Pg
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:36:42 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66899fe9077so4877710d50.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 08:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785771399; cv=none;
 d=google.com; s=arc-20260327;
 b=XTJv7X27bXQtb3mPs8KGMB11gmcU21wwOwnC1lMCAz4fbLl2PmxuewYHgMogYZXj9+
 8xHw2JSQNZHxyKK0I++jrJ+HJVpqFNJNqO+j5Z1zjOZN/yuOZyelh61sZptkC9YMAmbx
 igPbhEzuhpa/JqJ8fsaWO+3w4gVq+K1YtISWfKr8paSF6TDCmrQIRY3FT+qj2/F3N8Gh
 n9ZFTq++aRlHGysg35rfjYI24HB/2AGmRr0EO+DpEV9rw5rryA//PHt9OnxhmScvEFSr
 KAgY5ievO9F6OkV4bb3n8pOGCLfyxLfh88jfi79DKafBruK1Bus/S+wxvrXzN8nYmJB9
 M5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/61s61PnuLGlENAZQ+sgwsYvHw7dHcW1Z4x6tceh/eg=;
 fh=KbJM6/Akmqct5KIaKEA8hDba4OTZlQvLUQNOl4bj/PQ=;
 b=lQ+sLvITv/jLFlxcp8aaEeiylRutDo+JimtWg+POD1UARvHofHxeoqIOwO+TPYClyS
 KFlYpN85l77BqlwVxc32PcTyfUD7xnGxBxW0BXh46esuDSDyeZm6+oNJkkqL0hBUQTwR
 X3ppNvhDtI6AcuZecYioebNMzSi3Si79Fhv0O8eBCbW9pdkBUda5y+PMMHkflKhHuunh
 TBBcnbgyfF+MLJBXN+2HKcjVgDvHm+UW4WjPUBsl4UXKL3q3oY52mKHSnvLl4ZwxYNmv
 UbHz9vuCJjCYbK8rH9i7NGhTjApyM+dwrYP7Ffbkz1+8H4BbflggT9T8ZiEYuXV7sS/o
 Q2eQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785771399; x=1786376199; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/61s61PnuLGlENAZQ+sgwsYvHw7dHcW1Z4x6tceh/eg=;
 b=FGwxpOvRn95vT46oKgnCPOjemr/sE6vEIrUw0DOlM5n0SVZYowblmCx3Bftk5l08Qr
 H7DOfvmbeZrtqBRL2iqo5ebQ8wn1mcO07mE0i1Dnh/yyazsoHyjfw2TyI7szW/AaxC5w
 sH+QgOhTd5/VsUBvqhZx/6iZbjXT+U4nml1L5rmjtIklVUgk3uTk0J2UUJXTp2+BRdTV
 1u11DNpEjoj67TSh84TCrUXukxTwWgeMzFtRa6GWV8/SwFfU07C5pBpb6eA1qspHp6Tt
 Yc37NCZoYJ/ty7kuTn5ebWb2exstvvGISs5GND6mZEJ9vXdgWbPE7MUUugAOG6J22ASh
 yjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785771399; x=1786376199;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/61s61PnuLGlENAZQ+sgwsYvHw7dHcW1Z4x6tceh/eg=;
 b=h8kibZLx96UokVnjpzhmKxQtfCFZQPhfEqlcqIxTauI74E3Hjl2tCfNRdTKhP069Q1
 9mppVbO47trIvkAIfeFS/CsFO0M6JaUWmQI1KsY3/t1xRywfw+qYMD878TGNU4qIdjKY
 KN+KpuCgGiX+Axq6SFBZ0xkrltnfaZ9VKUMRi1rhE4A/ni3sgMLson9WvK37bKMBtd3u
 5m0g78ienvrlrhqfczsj5NjCFC0AET+Fefj8QRPGU19GtnKygenMNS1Qe4rH+CjGm3Gd
 aZEzR97w3hBov3j1yaNyFnn39UiJO9uo9XEitRmHMBFCpVNN3/LiilGq4c0wicTXFGC4
 iUFQ==
X-Gm-Message-State: AOJu0YySLh/fSPZI9963zPLR36WjJUPujkQQMfqklZ6sO88TecxTCplC
 Ji5qqGV18ibP6yBejZ4jRibBU9OGwvZlKvhnvDOjm5NwnVOm00i3nF4O9asc8kSrIS8tyV9EjNp
 S+dWauV1D0F+syDIyPqHR4WCY42v4r6z9B1UeZwHosA==
X-Gm-Gg: AR+sD118w6wWh+H1xSdqpLwfrMOnLzuUZDsT9jV1gBgV8dDTkih6Co2aJHr5TPBIcwa
 6JTe1DTO/91vx8tvcjj02qOUX4BXk3QIMfSjODpdv7E4YOU+3ref2K+d0za0OW5sXAB0xwt99OC
 R31cIvra34F6wB/WMCdWwxpPMH9afIXIqMbfw3WGIuWB8PmU1+hGpQw5SXn92gwr1q/TU64W0Io
 HtE+Fk5WO4wFgTmxWVSAm86En2Ovi4T7ZVKySlIlQ2SrfR2S93qbJ3TG9iWtcySuVYn/wYTmT5L
 pIhxQreZF/j1nO0pmkYGPQyyO0EnDwy4J37ca5dSqzQfOskud2qVuD/wMS4DLit//JZUiItEUig
 =
X-Received: by 2002:a05:690e:4883:10b0:664:77d8:ffc0 with SMTP id
 956f58d0204a3-6694f1bd2eemr9467981d50.39.1785771398720; Mon, 03 Aug 2026
 08:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
 <20260729-atlantis_prcm-v1-1-502882933e51@oss.tenstorrent.com>
 <am_5OAFG6L6ZnoXE@ChaodeMacBook-Pro.local>
In-Reply-To: <am_5OAFG6L6ZnoXE@ChaodeMacBook-Pro.local>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 3 Aug 2026 10:36:27 -0500
X-Gm-Features: AUfX_mzRMGqZ4V_WXBDEi27jodrvKBAYAsliLI3xxH6aT8RzlPB4HNJPSgMFYEk
Message-ID: <CAEev2e_Aj+8PJqH14gxYcn0Ni9qhvprW2Q04_ynu6FL0sPj9tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb133.google.com
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

Hi Chao,

On Sun, Aug 2, 2026 at 9:25=E2=80=AFPM Chao Liu <chao.liu@processmission.co=
m> wrote:
>
> On Wed, Jul 29, 2026 at 10:21:34AM +0800, Anirudh Srinivasan wrote:
> > This device present in Tenstorrent Atlantis has registers that control
> > clocks, reset and other misc functionality in the SoC. This commit adds
> > models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
> >
> > Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >  MAINTAINERS                        |   2 +
> >  hw/misc/meson.build                |   1 +
> >  hw/misc/trace-events               |   4 +
> >  hw/misc/tt_atlantis_prcm.c         | 436 +++++++++++++++++++++++++++++=
++++++++
> >  include/hw/misc/tt_atlantis_prcm.h |  51 +++++
> >  5 files changed, 494 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e25df9493c..49c1a5ad76 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1802,7 +1802,9 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
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
> > @@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: =
files('sifive_e_prci.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_ao=
n.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_ot=
p.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_p=
rci.c'))
> > +system_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis_=
prcm.c'))
> >
> >  subdir('macio')
> >
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index c9a868b3ef..9359a4e66d 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) =
"gva=3D0x%" PRIx64 " len=3D%u"
> >  iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=
=3D0x%x actual=3D0x%x"
> >  iommu_testdev_dma_result(uint32_t result) "DMA completed result=3D0x%x=
"
> >  iommu_testdev_dma_armed(bool armed) "armed=3D%d"
> > +
> > +# tt_atlantis_prcm.c
> > +tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t data)=
 "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> > +tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data=
) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> > diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
> > new file mode 100644
> > index 0000000000..d341e1a8c3
> > --- /dev/null
> > +++ b/hw/misc/tt_atlantis_prcm.c
> > @@ -0,0 +1,436 @@
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
> > +                                               unsigned size) {
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +    uint32_t data;
> > +
> > +    if (offset >=3D c->regs_size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PR=
Ix "\n",
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
> > +                                            uint64_t data, unsigned si=
ze) {
> Consider aligning the wrapped lines with the first parameter.
>
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    trace_tt_atlantis_prcm_write(c->domain, offset, data);
> > +
> > +    if (offset >=3D c->regs_size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_P=
RIx "\n",
> > +                      __func__, offset);
> > +        return;
> > +    }
> > +
> > +    switch (TO_REG(offset)) {
> > +    default:
> > +        s->regs[TO_REG(offset)] =3D data;
> > +        break;
> > +    }
> > +}
> > +
> > +static void tt_atlantis_prcm_rcpu_write(void *opaque, hwaddr offset,
> > +                                            uint64_t data, unsigned si=
ze) {
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +
> > +    tt_atlantis_prcm_write(opaque, offset, data, size);
> > +
> > +    bool pll_en_written =3D false;
> > +    uint32_t pll_reg_offset;
> > +    switch TO_REG(offset)
> > +    {
> > +        case RCPU_PLL_RCPU_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL_RCPU_CFG;
> > +            break;
> This should follow the QEMU coding style:
>
>     switch (TO_REG(offset)) {
>     case RCPU_PLL_RCPU_EN:
>         pll_en_written =3D true;
>         pll_reg_offset =3D RCPU_PLL_RCPU_CFG;
>         break;
>     ...
>     case RCPU_PLL_I2S_EN:
>         pll_en_written =3D true;
>         pll_reg_offset =3D RCPU_PLL_I2S_CFG;
>         break;
>     default:
>       g_assert_not_reached();
>     }

Thanks, checkpatch didn't seem to point these out. Will fix them up in V2.

Regards
Anirudh Srinivasan

> Thanks,
> Chao

