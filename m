Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BF8CF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 11:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssh7l-0006L5-Mg; Mon, 23 Sep 2024 07:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ssh7h-00068p-FH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 07:20:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ssh7f-0003xW-9r
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 07:20:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-208e0a021cfso17398755ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 04:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1727090453; x=1727695253; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItlCNbmYgjIL0vmhzovmL7VmC+nHf9DbGv1/zt/MYoI=;
 b=bXeLZnqmUWucIC7T9lJOF+7vihG/41qxNoa/yEUjS+9GJeoQ2s27eK0+6MKDhWafdi
 E6/Z3NpifliQiq2YoHe+RlEQX0Rctkjg2CeyrVgqK2sd7UasS8TkQRSia+hlzV5eFENv
 tX6TW13PHGFxagE2379tgHtyMtVUWJnT9RBSPNYLSSQlZuMmrPFPb0mGulgGidCqynR+
 S3txOStoSwJlDQNSHqB+/ShHAbCJ+BuzHU25dvQ8tbD46awT5wt6y6TSFqK3Ncwmts4g
 AanpeDQ+gsICtsnt09kfzF0q3N3ye5KCIeOYN1zSKYyO/d71rONRZ1OOm4WL0ho6hTjw
 Lfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727090453; x=1727695253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItlCNbmYgjIL0vmhzovmL7VmC+nHf9DbGv1/zt/MYoI=;
 b=mlU8Xn6ZTlKh5Riwfd2q6x2Dqgzru5DgA4Sy8pL6W0y+ajTDWz4zDhG2JRFo0ftFBA
 wZoFt3v7a6XjSLCcaKa0gdEEyop1uOr1ztsJZOux9Ey+DPwVfHCwM9sLjkLo0z//KRHj
 JQqYoVd23VbhgUIzx8x50GvuDK/Z6iAzTs7EJET5wxEyOvhU6nTwwGbpa06gWpIVZNqg
 eBMHp99mOOD5V+KMIjQYYfU4FzdGjTTRfY+HJTQKd/PHjO1K3dcN3Sf+WJRzZExY69nH
 qEWtkPLK1g113WBcOC6euq+VEGhqZRHIH3tPkxQOETy0U/zKuaRih2PfrOHVdrcmX1es
 hrMg==
X-Gm-Message-State: AOJu0YyE/tCSfOQhanIM87O6of0Uzq1rio0BqVjteJNB3ufymKusoLe3
 4RIYI8Abp4a4VytpdcUrGEQV6Pw0kQSbzvDtL9wGU+VZY2H/lg9F9ad3NLOTPHV7zDbGd4gjxo6
 f0d+HC85P90ND52cCdToiVOVbpGx/jKnZ4zsJ
X-Google-Smtp-Source: AGHT+IG6Cx09f3Ntg3up2QJXMz71OGy0KG+2zILt9gt9hUqwcDQVU/8ohEmFPDTiQvYk8O/U5CwHZFuT2JV6+ZnmlXA=
X-Received: by 2002:a17:90a:4d83:b0:2d8:8fe9:b00f with SMTP id
 98e67ed59e1d1-2dd7f3de50amr15180446a91.13.1727090452667; Mon, 23 Sep 2024
 04:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240921164322.1883-1-me@nikitashushura.com>
In-Reply-To: <20240921164322.1883-1-me@nikitashushura.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 23 Sep 2024 13:20:41 +0200
Message-ID: <CAJ307EjD=+gq3DdHCjC2vDQNWuDBh+kS3W4WJkMv83zQDz8YSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/intc/grlib_irqmp: add support for extended
 interrupts
To: me@nikitashushura.com
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=chigot@adacore.com; helo=mail-pl1-x62d.google.com
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

On Sat, Sep 21, 2024 at 6:43=E2=80=AFPM Nikita Shushura <me@nikitashushura.=
com> wrote:
>
> Signed-off-by: Nikita Shushura <me@nikitashushura.com>

Additionally to inlined comments:
 - there are a few "extended (not supported)" you can now remove.
 - I think the extended part in "grlib_irqmp_write" is still wrong,
the extended register being read-only.

> ---
>  hw/intc/grlib_irqmp.c | 69 +++++++++++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 19 deletions(-)
>
> diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
> index 37ac63fd80..e9414c054a 100644
> --- a/hw/intc/grlib_irqmp.c
> +++ b/hw/intc/grlib_irqmp.c
> @@ -1,8 +1,6 @@
>  /*
>   * QEMU GRLIB IRQMP Emulator
>   *
> - * (Extended interrupt not supported)
> - *
>   * SPDX-License-Identifier: MIT
>   *
>   * Copyright (c) 2010-2024 AdaCore
> @@ -38,25 +36,29 @@
>  #include "qemu/module.h"
>  #include "qom/object.h"
>
> -#define IRQMP_MAX_CPU 16
> -#define IRQMP_REG_SIZE 256      /* Size of memory mapped registers */
> +#define IRQMP_MAX_CPU (16)
> +#define IRQMP_REG_SIZE (256)    /* Size of memory mapped registers */
>
>  /* Memory mapped register offsets */
> -#define LEVEL_OFFSET     0x00
> -#define PENDING_OFFSET   0x04
> -#define FORCE0_OFFSET    0x08
> -#define CLEAR_OFFSET     0x0C
> -#define MP_STATUS_OFFSET 0x10
> -#define BROADCAST_OFFSET 0x14
> -#define MASK_OFFSET      0x40
> -#define FORCE_OFFSET     0x80
> -#define EXTENDED_OFFSET  0xC0
> +#define LEVEL_OFFSET     (0x00)
> +#define PENDING_OFFSET   (0x04)
> +#define FORCE0_OFFSET    (0x08)
> +#define CLEAR_OFFSET     (0x0C)
> +#define MP_STATUS_OFFSET (0x10)
> +#define BROADCAST_OFFSET (0x14)
> +#define MASK_OFFSET      (0x40)
> +#define FORCE_OFFSET     (0x80)
> +#define EXTENDED_OFFSET  (0xC0)
>
>  /* Multiprocessor Status Register  */
>  #define MP_STATUS_CPU_STATUS_MASK ((1 << IRQMP_MAX_CPU)-2)
> -#define MP_STATUS_NCPU_SHIFT      28
> +#define MP_STATUS_NCPU_SHIFT      (28)
> +#define MP_STATUS_EIRQ_OFFSET     (16)
> +
> +#define MAX_PILS_STD (16)
> +#define MAX_PILS_EXT (32)
>
> -#define MAX_PILS 16
> +#define DEFAULT_EIRQ (12)
>
>  OBJECT_DECLARE_SIMPLE_TYPE(IRQMP, GRLIB_IRQMP)
>
> @@ -68,6 +70,7 @@ struct IRQMP {
>      MemoryRegion iomem;
>
>      unsigned int ncpus;
> +    unsigned int eirq;
>      IRQMPState *state;
>      qemu_irq start_signal[IRQMP_MAX_CPU];
>      qemu_irq irq[IRQMP_MAX_CPU];
> @@ -89,13 +92,26 @@ struct IRQMPState {
>
>  static void grlib_irqmp_check_irqs(IRQMPState *state)
>  {
> -    int i;
> +    int i, j;
>
>      assert(state !=3D NULL);
>      assert(state->parent !=3D NULL);
>
>      for (i =3D 0; i < state->parent->ncpus; i++) {
>          uint32_t pend =3D (state->pending | state->force[i]) & state->ma=
sk[i];
> +
> +        /*
> +         * Checks is pending interrupt extended.

s/is/if

> +         * If so, sets pending to EIRQ and acknowledges
> +         * extended interrupt
> +         */
> +        for (j =3D MAX_PILS_STD; j < MAX_PILS_EXT; j++) {
> +            if ((pend & (1 << j)) !=3D 0) {
> +                pend =3D (1 << state->parent->eirq);
> +                state->extended[i] =3D (j & 0xffff);

You're writing 1 bit too far. It should be ((j>>1) & 0xf).
Moreover, what's happening when two extended interrupts are both
pending ? Here, only the last one is taken into account

> +            }
> +        }
> +
>          uint32_t level0 =3D pend & ~state->level;
>          uint32_t level1 =3D pend &  state->level;
>
> @@ -110,6 +126,10 @@ static void grlib_irqmp_check_irqs(IRQMPState *state=
)
>  static void grlib_irqmp_ack_mask(IRQMPState *state, unsigned int cpu,
>                                   uint32_t mask)
>  {
> +    if ((mask & (1 << state->parent->eirq)) !=3D 0) {
> +        mask |=3D (1 << state->extended[cpu]);
> +    }
> +
>      /* Clear registers */
>      state->pending  &=3D ~mask;
>      state->force[cpu] &=3D ~mask;
> @@ -144,7 +164,6 @@ static void grlib_irqmp_set_irq(void *opaque, int irq=
, int level)
>      assert(s         !=3D NULL);
>      assert(s->parent !=3D NULL);
>
> -
>      if (level) {
>          trace_grlib_irqmp_set_irq(irq);
>
> @@ -278,6 +297,9 @@ static void grlib_irqmp_write(void *opaque, hwaddr ad=
dr,
>                  state->mpstatus &=3D ~(1 << i);
>              }
>          }
> +
> +        /* Writing EIRQ number */
> +        state->mpstatus |=3D (state->parent->eirq << MP_STATUS_EIRQ_OFFS=
ET);
>          return;
>
>      case BROADCAST_OFFSET:
> @@ -345,7 +367,8 @@ static void grlib_irqmp_reset(DeviceState *d)
>      memset(irqmp->state, 0, sizeof *irqmp->state);
>      irqmp->state->parent =3D irqmp;
>      irqmp->state->mpstatus =3D ((irqmp->ncpus - 1) << MP_STATUS_NCPU_SHI=
FT) |
> -        ((1 << irqmp->ncpus) - 2);
> +        ((1 << irqmp->ncpus) - 2) |
> +        (irqmp->eirq << MP_STATUS_EIRQ_OFFSET);
>  }
>
>  static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
> @@ -359,7 +382,14 @@ static void grlib_irqmp_realize(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
>
> -    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
> +    if ((!irqmp->eirq) || (irqmp->eirq >=3D MAX_PILS_STD)) {
> +        error_setg(errp, "Invalid eirq properties: "
> +                   "%u, must be 0 < eirq < %u.", irqmp->eirq,
> +                   MAX_PILS_STD);
> +        return;
> +    }
> +
> +    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS_EXT);
>
>      /*
>       * Transitionning from 0 to 1 starts the CPUs. The opposite can't
> @@ -378,6 +408,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Err=
or **errp)
>
>  static Property grlib_irqmp_properties[] =3D {
>      DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
> +    DEFINE_PROP_UINT32("eirq", IRQMP, eirq, DEFAULT_EIRQ),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.46.1
>
>

