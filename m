Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A48CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJlV-00023s-Qs; Mon, 15 Jun 2026 22:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZJlU-00023X-8I
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:43:00 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZJlS-0001KF-6F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:42:59 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68d23396ed3so6837103a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781577777; cv=none;
 d=google.com; s=arc-20240605;
 b=azU6RUwvrwxCj1wgc/1TrzvAlzwwGHE7vk8E3ZA1X1nzumj+FstSLSjpqp1fq7UVqA
 FXqZyc/ceXw/5d2emNOzr1SgM04zEARU7mTKyLiz1TqTYntj9czQZ9dK4IJCoL3wlQ3q
 Wy3adtaG44VToDX/POR6kiCiMDcIHFNaJ2sSabguTAE1OHMQYOP2eiXOh2km/CF8Bmjt
 /PeA10uG7UB4TpqOQ657NPx4RZMEHgtAzF+5fFwA3WBlF45FkQvmEZvyZYyOtzsZY/3F
 x2uVpIushaDOmI+ognLQM7IOwETcyIA6Ysy7cB4CpNa6BPTfq/o4KYFrLT63cmZRn3ZW
 /4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tr5s7Buxuq9f15DCOB5+a6BDYosGBWZk2lLo6oyVcwg=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=cL5GG6/AI971iY8JmAO0bBuJd8fwlckZbQH3vfqBuevFtSHm0WoZTEnq7t05+TzbIX
 pwqY4pyc2kmbpZUBopPLWRWee6WROwdf8hnLxz8qrgx4u/xurt0rijL6aTdDCJqVRqml
 q/JBroSsqBt2hg5y6XaktAMErX4aYbzVvKVFFcWudFgucmcVK9e3uo/wS32HIFNRlPlQ
 LR1DxcGtSF0EWz+XgG+DfCLE7YMr0qST1WhyTETI1ORSV1Pt5i//ZuDVZA6ifvTKFbZC
 rGhpFEzzr9ATjHtL5/rMl4XA2DvTIfmEaxFhOf7rpQrX9THrbBsoYFIZkxrnEQXj/0Mm
 spRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781577777; x=1782182577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr5s7Buxuq9f15DCOB5+a6BDYosGBWZk2lLo6oyVcwg=;
 b=SgwHF9S/Lr15LL0ZLBG8HaaXceLDEzDoEzcthhV447PiayZYrpLEPPPR6+2zHRHZZC
 JsLp4fKknmdEr28sOg/vmZpyzTFNgmnKE2lp+qHEKF/NGw3dflGUnD3y0x/WarapB3W3
 z1/4TRq+g0X5gK1w3bTgbdq1MUckRuUJArcpVxg48+i6ocXgGWMPCLl9LF3rtl8xM9PG
 i5rjYM2P6xUiX2Dgx6hjSBU0a6+sayfkXUS0UBow9+Mdz92/yVIKDC3r6wpQGseGC7Bs
 8SCeRFY6MEtFBTYNng5XQncbJyxESgmQE2W/DMednaOoYaIYU5R5M/HoqSSAMZRK3GEs
 tm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781577777; x=1782182577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tr5s7Buxuq9f15DCOB5+a6BDYosGBWZk2lLo6oyVcwg=;
 b=box1xIIKGqyRVWyVg3CnVjefZhsOub8IdG5uwT+hDUs703r3WTxDcuU62uUkA+EJot
 2YelY51YKCVqcPWI6otD3zybBbq2PmOORekYT5XxldMKrCj6I4RNLcHZW+icf7w9uBBS
 Nxd3tM4zLRU0rukUsQibV11zvr3Hfzh7RUm2Z1/qMl+kzcbMOp8gpqeWepdONNzJhfue
 A3H1BT/+IyrQ15tkjeQcYiYBC8h3jlVxRT523Ax8KrS6vE6mlJfHp/mouW+bltzkzU2b
 lpB0CdwSd6dcYuQ9UGZUFSJ1AvhR7NAlaROQ1lrFmAVe3PxhQa9KcR01SdAHObsF7YA9
 c+Hw==
X-Gm-Message-State: AOJu0Yyzr9D2MtdgxUieJXalh/V/CveTGlxpWsyNlnGsW2pUp+G3ZR9f
 Oe64SZrd+w+tjNe9+KqnPQPrlRFsvz981CKT8WQoUpI5rU5YFMqX66VDhKfisyjzWOxcnmWXYkd
 DGluCTdReSGE1DSNncZpf6ruAetYhyQs=
X-Gm-Gg: Acq92OFzWU7/4vG4ahkb5rcWUbwM87fXpktbwpCKnAJYB81siOZjGjoBnc+t3jp1Cq5
 OIWjOe4+LEh5QmrwJnl8XIPs0+mBx9IYEWJZqkBooGN07SX0NY33fdpLfiql+LubypCmrETR/iT
 8NzPdOk+Ep1+z0D5ZjpIM+ti9BNFC26umtZTfYwdmxjkYjTmdqYYnKuTAqXcOmij4dBoPCm4Zr6
 aZz2qy/ljhf+2frFmtNJmRKzJj8aiJQOYkM4YHsAB9XxHInoSrD845qKfHZz5zJuNI3uwduMuNV
 i7dQDb29U2QSZAM3FL1t4AYtMju0HzkuCImRTw==
X-Received: by 2002:a17:907:1ca1:b0:bd9:2b46:99b0 with SMTP id
 a640c23a62f3a-c04159d7bd7mr106747466b.49.1781577776357; Mon, 15 Jun 2026
 19:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 12:42:29 +1000
X-Gm-Features: AVVi8CddP2IdGmbQCnszS-UepCNSdQf-GoKdOGodSaNK5z-sml_hVlk_Olr-qoM
Message-ID: <CAKmqyKPNGT9yN83bKCAbrF9EM5_x3pTQA8N59w5sq6cmRrKCBA@mail.gmail.com>
Subject: Re: [PATCH 02/13] hw/riscv: add fdt-common helper
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Tue, Jun 16, 2026 at 6:39=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> There's too much duplication between RISC-V boards and one of the most
> common culprits is the FDT functions.
>
> Add a new file for board FDT helpers.  Start by creating a helper that
> initializes the FDT and init it with the common board boilerplate.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/fdt-common.c         | 37 +++++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build          |  1 +
>  hw/riscv/sifive_u.c           | 20 +++----------------
>  hw/riscv/spike.c              | 19 +++---------------
>  hw/riscv/virt.c               | 19 +++---------------
>  include/hw/riscv/fdt-common.h | 14 +++++++++++++
>  6 files changed, 61 insertions(+), 49 deletions(-)
>  create mode 100644 hw/riscv/fdt-common.c
>  create mode 100644 include/hw/riscv/fdt-common.h
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> new file mode 100644
> index 0000000000..b155246998
> --- /dev/null
> +++ b/hw/riscv/fdt-common.c
> @@ -0,0 +1,37 @@
> +/*
> + * RISC-V board helpers for FDT generation.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/error-report.h"
> +#include "system/device_tree.h"
> +#include "hw/riscv/fdt-common.h"
> +
> +void *create_board_device_tree(const char *model, const char *compatible=
,
> +                               int *fdt_size)
> +{
> +    void *fdt =3D create_device_tree(fdt_size);
> +
> +    if (!fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    qemu_fdt_setprop_string(fdt, "/", "model", model);
> +    qemu_fdt_setprop_string(fdt, "/", "compatible", compatible);
> +    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
> +
> +    qemu_fdt_add_subnode(fdt, "/soc");
> +    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> +    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
> +    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
> +
> +    return fdt;
> +}
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 533472e22a..f19db0dd7f 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -1,5 +1,6 @@
>  riscv_ss =3D ss.source_set()
>  riscv_ss.add(files('boot.c'))
> +riscv_ss.add(files('fdt-common.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>  riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 3abbd6c823..5d3b2751ad 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -52,6 +52,7 @@
>  #include "hw/riscv/sifive_u.h"
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/machines-qom.h"
> +#include "hw/riscv/fdt-common.h"
>  #include "hw/char/sifive_uart.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/sifive_plic.h"
> @@ -112,23 +113,8 @@ static void create_fdt(SiFiveUState *s, const MemMap=
Entry *memmap,
>          "sifive,plic-1.0.0", "riscv,plic0"
>      };
>
> -    fdt =3D ms->fdt =3D create_device_tree(&s->fdt_size);
> -    if (!fdt) {
> -        error_report("create_device_tree() failed");
> -        exit(1);
> -    }
> -
> -    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed =
A00");
> -    qemu_fdt_setprop_string(fdt, "/", "compatible",
> -                            "sifive,hifive-unleashed-a00");
> -    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
> -    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
> -
> -    qemu_fdt_add_subnode(fdt, "/soc");
> -    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> -    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
> -    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
> -    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
> +    fdt =3D ms->fdt =3D create_board_device_tree("SiFive HiFive Unleashe=
d A00",
> +        "sifive,hifive-unleashed-a00", &s->fdt_size);
>
>      hfclk_phandle =3D phandle++;
>      nodename =3D g_strdup_printf("/hfclk");
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index f9d00e0d5c..79c9bb041f 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -32,6 +32,7 @@
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/spike.h"
>  #include "hw/riscv/boot.h"
> +#include "hw/riscv/fdt-common.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/riscv/machines-qom.h"
>  #include "hw/char/riscv_htif.h"
> @@ -66,16 +67,8 @@ static void create_fdt(SpikeState *s, const MemMapEntr=
y *memmap,
>          "sifive,clint0", "riscv,clint0"
>      };
>
> -    fdt =3D ms->fdt =3D create_device_tree(&fdt_size);
> -    if (!fdt) {
> -        error_report("create_device_tree() failed");
> -        exit(1);
> -    }
> -
> -    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu")=
;
> -    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-d=
ev");
> -    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
> -    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
> +    fdt =3D ms->fdt =3D create_board_device_tree("ucbbar,spike-bare,qemu=
",
> +        "ucbbar,spike-bare-dev", &fdt_size);
>
>      qemu_fdt_add_subnode(fdt, "/htif");
>      qemu_fdt_setprop_string(fdt, "/htif", "compatible", "ucb,htif0");
> @@ -84,12 +77,6 @@ static void create_fdt(SpikeState *s, const MemMapEntr=
y *memmap,
>              0x0, memmap[SPIKE_HTIF].base, 0x0, memmap[SPIKE_HTIF].size);
>      }
>
> -    qemu_fdt_add_subnode(fdt, "/soc");
> -    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> -    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
> -    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
> -    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
> -
>      qemu_fdt_add_subnode(fdt, "/cpus");
>      qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
>          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 0c489bb412..cb1d83fd48 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -36,6 +36,7 @@
>  #include "hw/riscv/riscv-iommu-bits.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
> +#include "hw/riscv/fdt-common.h"
>  #include "hw/riscv/machines-qom.h"
>  #include "hw/riscv/numa.h"
>  #include "kvm/kvm_riscv.h"
> @@ -1150,22 +1151,8 @@ static void create_fdt(RISCVVirtState *s)
>      uint8_t rng_seed[32];
>      g_autofree char *name =3D NULL;
>
> -    ms->fdt =3D create_device_tree(&s->fdt_size);
> -    if (!ms->fdt) {
> -        error_report("create_device_tree() failed");
> -        exit(1);
> -    }
> -
> -    qemu_fdt_setprop_string(ms->fdt, "/", "model", "riscv-virtio,qemu");
> -    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-virtio");
> -    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
> -    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
> -
> -    qemu_fdt_add_subnode(ms->fdt, "/soc");
> -    qemu_fdt_setprop(ms->fdt, "/soc", "ranges", NULL, 0);
> -    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus")=
;
> -    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
> -    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
> +    ms->fdt =3D create_board_device_tree("riscv-virtio,qemu", "riscv-vir=
tio",
> +                                       &s->fdt_size);
>
>      /*
>       * The "/soc/pci@..." node is needed for PCIE hotplugs
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.=
h
> new file mode 100644
> index 0000000000..adf9b33dfd
> --- /dev/null
> +++ b/include/hw/riscv/fdt-common.h
> @@ -0,0 +1,14 @@
> +/*
> + * RISC-V board helpers for FDT generation.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_VIRT_FDT_H
> +#define RISCV_VIRT_FDT_H
> +
> +void *create_board_device_tree(const char *model, const char *compatible=
,
> +                               int *fdt_size);
> +#endif
> --
> 2.43.0
>
>

