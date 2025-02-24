Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F7C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmO29-0003qd-E0; Sun, 23 Feb 2025 21:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmO1z-0003qF-SB; Sun, 23 Feb 2025 21:17:16 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmO1x-0006Gu-P7; Sun, 23 Feb 2025 21:17:15 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-521b3ebb0f3so984218e0c.3; 
 Sun, 23 Feb 2025 18:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740363432; x=1740968232; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoNRhkWIe2c4PxrCHg1n+Lhz2oEKBTfGl4udbIijOU4=;
 b=EBHrN5rT0jabFuvw3TqVcZVGKdbW7Rn2hBt+Z1ufX0wDtlNkDmRVkW1GdTTYGoLqbw
 uRB1tnyj9GLe38NCVp2N+zXJmKEeQUq1o9jVOmhXp0jRQipetG6AoQkzuenlHOM7A3Pp
 lyKxp7RgMomMSWK3FYl6e9hc6D37Rv7Y7CKKiTvCCUev0CGzMScK3/+BuncBiwGdN43L
 /I3L9th3WkiooLaChsnkPSzkfeuA7/L1ztfpfkw5gmG1j9IsuttY/P5qtlFW5BRMOcFR
 kzdkyHBOQSdFlSk0SZWqKEC6E0Ak0XUf4rcV6AugCbqt0ZvRh7Wazl9FqQb78UMnti1b
 UO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740363432; x=1740968232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoNRhkWIe2c4PxrCHg1n+Lhz2oEKBTfGl4udbIijOU4=;
 b=TAQavsfYM0iu5Dkkxwz9V3uS/D8Jb0wkQVXguN3VG3IVv/l8mWnwypAT/CKwgfnLi5
 PAd1lnm1oV4bhZUG3RrLCSnkNfXNa65kZd8d91guC1jgLKmaIn/QtwLlc8ZloBMD30tM
 fdNKw1QQZPUa/EaoRZTT4EO7GhaszfAUJ2UJ0eKvN9YW00Uf8MEf12rq744c4fY988Hh
 oHWYfJU9hFjrlB38CcJcXRr4d6eqgjYQcsTJaO0rxs0fYgEh8KlhJ1z/+xROCoMWNUf6
 B87LSY6yyAYyLUtwQ7aUqoUcA3GeUHCZomIlffT69vRdnGviLKF04NcU5t9yDkISVi6l
 QrRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Ku5gxEpHWBY+0PBGffsXfjpQ5M4S3/MTJlixbZ1zgWf1js6A6o6bW+CkEXXTJcx7MSlipwZS3qlT@nongnu.org
X-Gm-Message-State: AOJu0YyVFDW7t7k/q+IFcmsU0G1z0qfO1MSq9yLPIauCHLJjEhCRyoXF
 a9CqkZk7GMnnK2o2wT8ofGXreMWx4W90Sb1JDD0CbnuoIQC2Y6qNsWKVomOmyzmwXqpfz3ecP6E
 qBYYQpw+biEeXKDWH24tNc+ILfr8=
X-Gm-Gg: ASbGncsDelqr+HLav211tyql92G467tXiZGELhfiGl+t8fneUW9S6fmfXzNiXt5zKpK
 hNtkMNKALLpYWQCVHDYcwXWZQ4Lw8rEtvjFZfgYdL2blPCg2ftJInwr/7CxHte91TjKEFr2ZgVu
 2ZrQBRIV36FBb3fxdnuf/+OS19YVkodpps1yV5
X-Google-Smtp-Source: AGHT+IGOtUxRZtolneyV4M2vYfSxiW+URLOLjeDKmb3SNLdXPp9ZP68xjd0dAmgRMNisN7Skvbc3v6Wla8LxM0+msh0=
X-Received: by 2002:a05:6122:8c21:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-521ee46da2dmr5232067e0c.9.1740363432094; Sun, 23 Feb 2025
 18:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-4-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 12:16:46 +1000
X-Gm-Features: AWEUYZnW2heIhJQLts8O-tOU5vHyt8AzamAEXrmfdsGkUhl6wRc1xm8XAKSdfLM
Message-ID: <CAKmqyKMS5fOH23YMjurrV33C0u4xxFwVHeEuWsQBfwq2a+TkhA@mail.gmail.com>
Subject: Re: [PATCH for-10.0 03/11] hw/riscv/riscv-iommu: add riscv-iommu-hpm
 file
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Dec 5, 2024 at 11:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The HPM (Hardware Performance Monitor) support consists of almost 7
> hundred lines that would be put on top of the base riscv-iommu
> emulation.
>
> To avoid clogging riscv-iommu.c, add a separated riscv-iommu-hpm file
> that will contain HPM specific code.
>
> We'll start by adding riscv_iommu_hpmcycle_read(), a helper that will be
> called during the riscv_iommu_mmio_read() callback.
>
> This change will have no effect on the existing emulation since we're
> not declaring HPM feature support.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/meson.build       |  3 ++-
>  hw/riscv/riscv-iommu-hpm.c | 54 ++++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h | 27 +++++++++++++++++++
>  hw/riscv/riscv-iommu.c     | 24 ++++++++++++++++-
>  hw/riscv/riscv-iommu.h     |  4 +++
>  5 files changed, 110 insertions(+), 2 deletions(-)
>  create mode 100644 hw/riscv/riscv-iommu-hpm.c
>  create mode 100644 hw/riscv/riscv-iommu-hpm.h
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 3c7e083aca..c22f3a7216 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,7 +10,8 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('s=
ifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> -riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c',=
 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
> +       'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv=
-iommu-hpm.c'))
>  riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-g=
eneric.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> new file mode 100644
> index 0000000000..5833ab8956
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -0,0 +1,54 @@
> +/*
> + * RISC-V IOMMU - Hardware Performance Monitor (HPM) helpers
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "cpu_bits.h"
> +#include "riscv-iommu-hpm.h"
> +#include "riscv-iommu.h"
> +#include "riscv-iommu-bits.h"
> +#include "trace.h"
> +
> +/* For now we assume IOMMU HPM frequency to be 1GHz so 1-cycle is of 1-n=
s. */
> +static inline uint64_t get_cycles(void)
> +{
> +    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +}
> +
> +uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s)
> +{
> +    const uint64_t cycle =3D riscv_iommu_reg_get64(
> +        s, RISCV_IOMMU_REG_IOHPMCYCLES);
> +    const uint32_t inhibit =3D riscv_iommu_reg_get32(
> +        s, RISCV_IOMMU_REG_IOCOUNTINH);
> +    const uint64_t ctr_prev =3D s->hpmcycle_prev;
> +    const uint64_t ctr_val =3D s->hpmcycle_val;
> +
> +    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
> +        /*
> +         * Counter should not increment if inhibit bit is set. We can't =
really
> +         * stop the QEMU_CLOCK_VIRTUAL, so we just return the last updat=
ed
> +         * counter value to indicate that counter was not incremented.
> +         */
> +        return (ctr_val & RISCV_IOMMU_IOHPMCYCLES_COUNTER) |
> +               (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
> +    }
> +
> +    return (ctr_val + get_cycles() - ctr_prev) |
> +        (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
> +}
> diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
> new file mode 100644
> index 0000000000..231c110ff2
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-hpm.h
> @@ -0,0 +1,27 @@
> +/*
> + * RISC-V IOMMU - Hardware Performance Monitor (HPM) helpers
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_IOMMU_HPM_H
> +#define HW_RISCV_IOMMU_HPM_H
> +
> +#include "qom/object.h"
> +#include "hw/riscv/riscv-iommu.h"
> +
> +uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
> +
> +#endif
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index e9a0775d6e..01df25418c 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -29,6 +29,7 @@
>  #include "cpu_bits.h"
>  #include "riscv-iommu.h"
>  #include "riscv-iommu-bits.h"
> +#include "riscv-iommu-hpm.h"
>  #include "trace.h"
>
>  #define LIMIT_CACHE_CTX               (1U << 7)
> @@ -2052,7 +2053,28 @@ static MemTxResult riscv_iommu_mmio_read(void *opa=
que, hwaddr addr,
>          return MEMTX_ACCESS_ERROR;
>      }
>
> -    ptr =3D &s->regs_rw[addr];
> +    /* Compute cycle register value. */
> +    if ((addr & ~7) =3D=3D RISCV_IOMMU_REG_IOHPMCYCLES) {
> +        val =3D riscv_iommu_hpmcycle_read(s);
> +        ptr =3D (uint8_t *)&val + (addr & 7);
> +    } else if ((addr & ~3) =3D=3D RISCV_IOMMU_REG_IOCOUNTOVF) {
> +        /*
> +         * Software can read RISCV_IOMMU_REG_IOCOUNTOVF before timer
> +         * callback completes. In which case CY_OF bit in
> +         * RISCV_IOMMU_IOHPMCYCLES_OVF would be 0. Here we take the
> +         * CY_OF bit state from RISCV_IOMMU_REG_IOHPMCYCLES register as
> +         * it's not dependent over the timer callback and is computed
> +         * from cycle overflow.
> +         */
> +        val =3D ldq_le_p(&s->regs_rw[addr]);
> +        val |=3D (riscv_iommu_hpmcycle_read(s) & RISCV_IOMMU_IOHPMCYCLES=
_OVF)
> +                   ? RISCV_IOMMU_IOCOUNTOVF_CY
> +                   : 0;
> +        ptr =3D (uint8_t *)&val + (addr & 3);
> +    } else {
> +        ptr =3D &s->regs_rw[addr];
> +    }
> +
>      val =3D ldn_le_p(ptr, size);
>
>      *data =3D val;
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 2de0cdfc56..380f7e81d1 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -86,6 +86,10 @@ struct RISCVIOMMUState {
>
>      QLIST_ENTRY(RISCVIOMMUState) iommus;
>      QLIST_HEAD(, RISCVIOMMUSpace) spaces;
> +
> +    /* HPM cycle counter */
> +    uint64_t hpmcycle_val;      /* Current value of cycle register */
> +    uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clo=
ck */
>  };
>
>  void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> --
> 2.47.1
>
>

