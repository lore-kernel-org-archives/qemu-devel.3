Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64928C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wejIv-0005cu-Tc; Tue, 30 Jun 2026 20:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wejIu-0005cd-GS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 20:59:52 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wejIq-0002OU-Q3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 20:59:52 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6987cd38a64so170782a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 17:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782867587; cv=none;
 d=google.com; s=arc-20260327;
 b=GAyXOIypQgI+EQ/dRC3bvqPyjiucB8MzPMv4nJtU+kBxV9cjxtXsvJVOOy5WczKjCf
 fLrByxuI6CgKHGjXZn/G33ar1qCDOrPJNq1Q+AP6hE26Dl+XVhR+/NdL0No2Ldtr14L8
 OLw54kfjfHkWj4OyuoLgfBIbyD7yfQkub7g0eVmPRJ2KIHYsiNL8Wm1j8NBqm0xLh1HW
 mSYNiMTRjbPSyBBg7NpqZs+D3tEIa2wCYdHos/6vz8lWa7agEoYZw6jHCtkz9RRvKExh
 dpnxRYo0ffIAyJRVrlulGNe+a+OPiQ1rh1rnnfV+YxgUEx2z4DxL9ZU8lSu2yD5cQdph
 0/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yPi7sjRxC8aI6WbbAQmWrpLh//91zd5uOd4YaMG7D2Y=;
 fh=rDldgJ/tC9a5Axyanvq+RWzTy/hqovJhdGbLTik4ogo=;
 b=GEYLPdKJVrtQPKtBSvOiFP20+f9sx+EWxb0isYurRPhDdDG81cqR3UuCZSCPmHTDOm
 wIGyeNGh6FaV1cUDbwdJcQyaOPx1KBJNNNC97gGG1wwbPzgJZ7N4SiAsifvOAzCvVJsD
 TQc84sBRwHGsAf9LJGUFxhlYiXkcxnna/CljXwVL9uQguf42G3RGEOkqm35c6z9behQC
 myIQUT2kpNkE/IcfxsZQT5SThwpTXKeEgA7MFVYRrKiL73kWtGADP7zhIcZQRa028IAm
 O33NRS2XyMLMzfUOiVMg4pA3K3LEI+M5jR9lXu2AHCWxujf3EtMl2Nr8FjjRPY9pY1iT
 DwMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782867587; x=1783472387; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPi7sjRxC8aI6WbbAQmWrpLh//91zd5uOd4YaMG7D2Y=;
 b=jXUmbX5JMegDwpzwns0Mwp8iSL5iaRPV5Y0e0v71NqkQ1UHpdNX+qucYaXH+F8xl6e
 gEsyNQ69x+B5FbaUEECbCBIqVYv8KEcRQvDE/xU90YdRU5Z/Uxrtodo1SPAcx6zInPQX
 urLkO19pd3kMTxVZgTwEtkeejOhVgRubf6/V5M/gXFY41gRUXfJ+1jqy85KYFiGKMQvp
 P6IPmrpB8BYLcMIuiMM8678oTp1n0Eo6ePNoQE5b6bLHwW7yYLlg6rqmi8v5LlUeSdKS
 RB7Du8DwwcVKyx3BQ7WNTQXR+SzCA6+YGMbip/bWWDdcV2z4m5zFyMMxK/agISE1bk2z
 HIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782867587; x=1783472387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPi7sjRxC8aI6WbbAQmWrpLh//91zd5uOd4YaMG7D2Y=;
 b=j3KtXdW/F4g/9t+B+EuDIWElrg2EwAsVRQcwTmSO8GzBe3a1jJUR911f7jDfg5U17e
 NjOmfURTGiI6zLeMbdtjeFsjMh4EZoGn79w6ExU/TB34MnoEAAejxm3Wz5l8X+lqClvf
 LJ1VUw1lS9HXyzA4ptUSNvCKP74EMGJFMLAhxm7PnhvmaLrIxvq2pDlcU6d9YxYla3PI
 ozqIcznq8EKJONSSe4DFd/L9H/noZ8rdzZwMs1Hd4PlNwrLm87+UhyEFAik24w9aA1+4
 fR/+o4meW82WCMHihiXP4RfGL1uj/1+D9P2QO36uG/0K0wS0oAbOHOPgUmgG0vb5IuUA
 6VJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLcKVSjVhZ1OFJUmqKyvssSjgQn8xdldV/VQNTsNHXMdOgENlQKMU+Ex5EkOP9auD/VEVMskpHlSf5@nongnu.org
X-Gm-Message-State: AOJu0Yz9f5SnhY0PrYL9A4yv7S9JF0hmMkMpReVRMBdhLYWeRgHM+Otr
 Nw+Hdsw5DTLEA5OM2eMnH9pD+SJ75I3qh0L7CFeK0NaDoZbScm3MLjZT1Sxllc+UJpH4bVJ339U
 y5yB9KN27056IVV+qVWcLYcPpVGybBUc=
X-Gm-Gg: AfdE7clKVNlO0R0UXtVBxjSvB2NIcacAIeuqAiPwbLKaMGP0o+ECPjoye0w7gDjAoyn
 +Tl+W4Jg10oKk1Me5jzo2tmBBWiim98qt/Mn/yz1CCfo6EkQksUhB8jcrFPGHKFqQPfzsyZ4NN8
 Nd0lPnm9x6j5WRd15rUMAetYJeJliTzlDtrJ+ZO5PlXwqLA1nepw6NNmaExnqQt2AEJA5rbruSP
 ZArDnIge5M4LS8gN+ujSHdlyNzIlXePSX2YQFjYaopeUNQjqZrTq+MWIpIgB849/lnJ300wuFGx
 66tsW+k+AhMRLsqYOEKrlo6Y+nQ=
X-Received: by 2002:a05:6402:510a:b0:698:3b7c:3b2e with SMTP id
 4fb4d7f45d1cf-698819e60ffmr1886087a12.16.1782867587132; Tue, 30 Jun 2026
 17:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260630024952.1520546-1-joel@jms.id.au>
 <20260630024952.1520546-8-joel@jms.id.au>
In-Reply-To: <20260630024952.1520546-8-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Jul 2026 10:59:20 +1000
X-Gm-Features: AVVi8Cdh5ZdychM076RBXBVarMqob1rxiLmKBAz4pxCuKC8CXLDU1C7YMitVv88
Message-ID: <CAKmqyKNCgV9Mgu6G0R7_5z0qzy8x26_dAVnr02buJ-HhLuh9Tg@mail.gmail.com>
Subject: Re: [PATCH v10 07/12] hw/riscv: Add Tenstorrent Atlantis machine
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Tue, Jun 30, 2026 at 12:52=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
> and CoreLab Technology. It is based on the Atlantis SoC, which includes
> the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
> RISC-V CPU.
>
> Add the tt-atlantis machine containing serial console, interrupt
> controllers, and device tree support.
>
> The Atlantis boot images loaded from include OpenSBI and an initial DTB
> that is passed to OpenSBI. This is approximated in the model by having
> QEMU build the device tree rather than load a DTB image directly.
> Subsequent stages may use the modified DTB provided by OpenSBI or opt to
> supply their own.
>
>   qemu-system-riscv64 -M tt-atlantis -m 512M \
>    -kernel Image -initrd rootfs.cpio -nographic
>
> Co-Developed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                       |  12 +
>  docs/system/riscv/tt_atlantis.rst |  41 +++
>  docs/system/target-riscv.rst      |   1 +
>  include/hw/riscv/tt_atlantis.h    |  50 +++
>  hw/riscv/tt_atlantis.c            | 523 ++++++++++++++++++++++++++++++
>  hw/riscv/Kconfig                  |  10 +
>  hw/riscv/meson.build              |   1 +
>  7 files changed, 638 insertions(+)
>  create mode 100644 docs/system/riscv/tt_atlantis.rst
>  create mode 100644 include/hw/riscv/tt_atlantis.h
>  create mode 100644 hw/riscv/tt_atlantis.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72357df7c4b7..0d7c7720d9f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1774,6 +1774,18 @@ F: hw/*/*sifive*.c
>  F: include/hw/*/*sifive*.h
>  F: tests/functional/riscv64/test_sifive_u.py
>
> +Tenstorrent Machines
> +M: Joel Stanley <joel@jms.id.au>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> +R: Michael Ellerman <mpe@kernel.org>
> +R: Portia Stephens <portias@oss.tenstorrent.com>
> +L: qemu-riscv@nongnu.org
> +S: Supported
> +F: docs/system/riscv/tt_*.rst
> +F: hw/riscv/tt_*.c
> +F: include/hw/riscv/tt_*.h
> +
>  AMD Microblaze-V Generic Board
>  M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
>  S: Maintained
> diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atl=
antis.rst
> new file mode 100644
> index 000000000000..1f2880d61773
> --- /dev/null
> +++ b/docs/system/riscv/tt_atlantis.rst
> @@ -0,0 +1,41 @@
> +Tenstorrent Atlantis (``tt-atlantis``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
> +and CoreLab Technology. It is based on the Atlantis SoC, which includes
> +the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> +
> +The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
> +RISC-V CPU.
> +
> +tt-atlantis QEMU model features
> +-------------------------------
> +
> +* 8-core Ascalon-X CPU Cluster
> +* RISC-V compliant Advanced Interrupt Architecture
> +* 16550A compatible UART
> +
> +Known limitations
> +-----------------
> +
> +The QEMU tt-atlantis machine does not yet model every device on the
> +real platform. Notably:
> +
> +* There is no PCI host bridge, so virtio-pci devices cannot be
> +  attached. Boots that need block storage must use ``-initrd`` with
> +  an initramfs.
> +* The DesignWare UART is modelled with QEMU's ns16550-compatible
> +  ``serial_mm`` device; DesignWare-specific registers beyond that
> +  set return 0.
> +
> +Supported software
> +------------------
> +
> +The Tenstorrent Ascalon CPUs avoid proprietary or non-standard
> +extensions, so compatibility with existing software is generally
> +good. The QEMU tt-atlantis machine works with upstream OpenSBI
> +and Linux with default configurations.
> +
> +The development board hardware will require some implementation
> +specific setup in firmware which is being developed and may
> +become a requirement or option for the tt-atlantis machine.
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 896f14e78bd0..2639866a3e8a 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -72,6 +72,7 @@ undocumented; you can get a complete list by running
>     riscv/mips
>     riscv/shakti-c
>     riscv/sifive_u
> +   riscv/tt_atlantis
>     riscv/virt
>     riscv/xiangshan-kunminghu
>
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlanti=
s.h
> new file mode 100644
> index 000000000000..a17732ce8114
> --- /dev/null
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -0,0 +1,50 @@
> +/*
> + * Tenstorrent Atlantis RISC-V System on Chip
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2025 Tenstorrent, Joel Stanley <joel@jms.id.au>
> + */
> +
> +#ifndef HW_RISCV_TT_ATLANTIS_H
> +#define HW_RISCV_TT_ATLANTIS_H
> +
> +#include "hw/core/boards.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "hw/riscv/riscv_hart.h"
> +
> +#define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
> +OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
> +
> +struct TTAtlantisState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +    Notifier machine_done;
> +    const MemMapEntry *memmap;
> +
> +    RISCVHartArrayState soc;
> +    DeviceState *irqchip;
> +
> +    int fdt_size;
> +};
> +
> +enum {
> +    TT_ATL_UART1_IRQ =3D 39,
> +};
> +
> +enum {
> +    TT_ATL_ACLINT,
> +    TT_ATL_BOOTROM,
> +    TT_ATL_DDR_LO,
> +    TT_ATL_DDR_HI,
> +    TT_ATL_MAPLIC,
> +    TT_ATL_MIMSIC,
> +    TT_ATL_SAPLIC,
> +    TT_ATL_SIMSIC,
> +    TT_ATL_UART1,
> +};
> +
> +#endif
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> new file mode 100644
> index 000000000000..1f0cd08ac959
> --- /dev/null
> +++ b/hw/riscv/tt_atlantis.c
> @@ -0,0 +1,523 @@
> +/*
> + * Tenstorrent Atlantis RISC-V System on Chip
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2025 Tenstorrent, Joel Stanley <joel@jms.id.au>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qemu/units.h"
> +
> +#include "hw/core/boards.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/sysbus.h"
> +
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/pmu.h"
> +
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/fdt-common.h"
> +#include "hw/riscv/machines-qom.h"
> +#include "hw/riscv/riscv_hart.h"
> +
> +#include "hw/char/serial-mm.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/misc/unimp.h"
> +
> +#include "system/system.h"
> +#include "system/device_tree.h"
> +
> +#include "hw/riscv/tt_atlantis.h"
> +
> +#include "aia.h"
> +
> +#define TT_IRQCHIP_NUM_MSIS       255
> +#define TT_IRQCHIP_NUM_SOURCES    128
> +#define TT_IRQCHIP_NUM_PRIO_BITS  3
> +#define TT_IRQCHIP_GUESTS         63 /* aia_guests, gives guest_index_bi=
ts=3D6 */
> +#define TT_IRQCHIP_MIMSIC_STRIDE  0x40000
> +
> +#define TT_ACLINT_MTIME_SIZE    0x8050
> +#define TT_ACLINT_MTIME         0x0
> +#define TT_ACLINT_MTIMECMP      0x8000
> +#define TT_ACLINT_TIMEBASE_FREQ 1000000000
> +
> +static const MemMapEntry tt_atlantis_memmap[] =3D {
> +    /* Keep sorted with :'<,'>!sort -g -k 4 */
> +    [TT_ATL_DDR_LO] =3D           { 0x00000000,    0x80000000 },
> +    [TT_ATL_BOOTROM] =3D          { 0x80000000,        0x2000 },
> +    [TT_ATL_MIMSIC] =3D           { 0xa0000000,      0x200000 },
> +    [TT_ATL_ACLINT] =3D           { 0xa2180000,       0x10000 },
> +    [TT_ATL_SIMSIC] =3D           { 0xa4000000,      0x200000 },
> +    [TT_ATL_MAPLIC] =3D           { 0xcc000000,     0x4000000 },
> +    [TT_ATL_UART1] =3D            { 0xd4110000,       0x10000 },
> +    [TT_ATL_SAPLIC] =3D           { 0xe8000000,     0x4000000 },
> +    [TT_ATL_DDR_HI] =3D          { 0x100000000,  0x1000000000 },
> +};
> +
> +static uint32_t fdt_phandle =3D 1;
> +static uint32_t next_phandle(void)
> +{
> +    return fdt_phandle++;
> +}
> +
> +static void create_fdt_memory(TTAtlantisState *s)
> +{
> +    void *fdt =3D MACHINE(s)->fdt;
> +    hwaddr size_lo =3D MACHINE(s)->ram_size;
> +    hwaddr size_hi =3D 0;
> +
> +    if (size_lo > s->memmap[TT_ATL_DDR_LO].size) {
> +        size_lo =3D s->memmap[TT_ATL_DDR_LO].size;
> +        size_hi =3D MACHINE(s)->ram_size - size_lo;
> +    }
> +
> +    create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base, size_lo=
,
> +                             0, false);
> +    if (size_hi) {
> +        /*
> +         * The first part of the HI address is aliased at the LO address
> +         * so do not include that as usable memory. Is there any way
> +         * (or good reason) to describe that aliasing 2GB with DT?
> +         */
> +        create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_HI].base + si=
ze_lo,
> +                                 size_hi, 0, false);
> +    }
> +}
> +
> +static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandle=
s)
> +{
> +    void *fdt =3D MACHINE(s)->fdt;
> +    g_autofree char *name =3D NULL;
> +    g_autofree uint32_t *aclint_mtimer_cells =3D NULL;
> +    uint32_t aclint_cells_size;
> +    hwaddr addr;
> +
> +    aclint_mtimer_cells =3D g_new0(uint32_t, s->soc.num_harts * 2);
> +
> +    for (int cpu =3D 0; cpu < s->soc.num_harts; cpu++) {
> +        aclint_mtimer_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[c=
pu]);
> +        aclint_mtimer_cells[cpu * 2 + 1] =3D cpu_to_be32(IRQ_M_TIMER);
> +    }
> +    aclint_cells_size =3D s->soc.num_harts * sizeof(uint32_t) * 2;
> +
> +    addr =3D s->memmap[TT_ATL_ACLINT].base;
> +
> +    name =3D g_strdup_printf("/soc/mtimer@%"HWADDR_PRIX, addr);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mtime=
r");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, addr + TT_ACLINT_MTIME,
> +                                 2, 0x1000,
> +                                 2, addr + TT_ACLINT_MTIMECMP,
> +                                 2, 0x1000);
> +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
> +                     aclint_mtimer_cells, aclint_cells_size);
> +}
> +
> +static void create_fdt_one_imsic(void *fdt, const MemMapEntry *mem, int =
cpus,
> +                                 uint32_t *intc_phandles, uint32_t msi_p=
handle,
> +                                 int irq_line, uint32_t imsic_guest_bits=
)
> +{
> +    g_autofree char *name =3D NULL;
> +    g_autofree uint32_t *imsic_cells =3D g_new0(uint32_t, cpus * 2);
> +
> +    for (int cpu =3D 0; cpu < cpus; cpu++) {
> +        imsic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> +        imsic_cells[cpu * 2 + 1] =3D cpu_to_be32(irq_line);
> +    }
> +
> +    name =3D g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIX, m=
em->base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,imsics");
> +
> +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
> +    qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop(fdt, name, "msi-controller", NULL, 0);
> +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
> +                     imsic_cells, sizeof(uint32_t) * cpus * 2);
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem-=
>size);
> +    qemu_fdt_setprop_cell(fdt, name, "riscv,num-ids", TT_IRQCHIP_NUM_MSI=
S);
> +
> +    if (imsic_guest_bits) {
> +        qemu_fdt_setprop_cell(fdt, name, "riscv,guest-index-bits",
> +                              imsic_guest_bits);
> +    }
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", msi_phandle);
> +}
> +
> +static void create_fdt_one_aplic(void *fdt,
> +                                 const MemMapEntry *mem,
> +                                 uint32_t msi_phandle,
> +                                 uint32_t *intc_phandles,
> +                                 uint32_t aplic_phandle,
> +                                 uint32_t aplic_child_phandle,
> +                                 int irq_line, int num_harts)
> +{
> +    g_autofree char *name =3D
> +        g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIX, mem->b=
ase);
> +    g_autofree uint32_t *aplic_cells =3D g_new0(uint32_t, num_harts * 2)=
;
> +
> +    for (int cpu =3D 0; cpu < num_harts; cpu++) {
> +        aplic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> +        aplic_cells[cpu * 2 + 1] =3D cpu_to_be32(irq_line);
> +    }
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aplic");
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 0);
> +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 2);
> +    qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
> +
> +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
> +                     aplic_cells, num_harts * sizeof(uint32_t) * 2);
> +    qemu_fdt_setprop_cell(fdt, name, "msi-parent", msi_phandle);
> +
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem-=
>size);
> +    qemu_fdt_setprop_cell(fdt, name, "riscv,num-sources",
> +                          TT_IRQCHIP_NUM_SOURCES);
> +
> +    if (aplic_child_phandle) {
> +        qemu_fdt_setprop_cell(fdt, name, "riscv,children",
> +                              aplic_child_phandle);
> +        qemu_fdt_setprop_cells(fdt, name, "riscv,delegation",
> +                               aplic_child_phandle, 1, TT_IRQCHIP_NUM_SO=
URCES);
> +    }
> +
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
> +}
> +
> +static void create_fdt_pmu(TTAtlantisState *s)
> +{
> +    char pmu_name[] =3D "/pmu";
> +    void *fdt =3D MACHINE(s)->fdt;
> +    RISCVCPU *hart =3D &s->soc.harts[0];
> +
> +    qemu_fdt_add_subnode(fdt, pmu_name);
> +    qemu_fdt_setprop_string(fdt, pmu_name, "compatible", "riscv,pmu");
> +    riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
> +}
> +
> +static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap=
,
> +                           uint32_t aplic_s_phandle,
> +                           uint32_t imsic_s_phandle)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +    void *fdt =3D MACHINE(s)->fdt;
> +    g_autofree uint32_t *intc_phandles =3D g_new0(uint32_t, ms->smp.cpus=
);
> +
> +    fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
> +
> +    create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
> +                           s->soc.hartid_base, &fdt_phandle, intc_phandl=
es,
> +                           false, false);
> +
> +    create_fdt_memory(s);
> +
> +    create_fdt_aclint(s, intc_phandles);
> +
> +    uint32_t imsic_guest_bits =3D imsic_num_bits(TT_IRQCHIP_GUESTS + 1);
> +
> +    /* M-level IMSIC node */
> +    uint32_t msi_m_phandle =3D next_phandle();
> +    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], ms->smp.cpus,
> +                         intc_phandles, msi_m_phandle,
> +                         IRQ_M_EXT, imsic_guest_bits);
> +
> +    /* S-level IMSIC node */
> +    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], ms->smp.cpus,
> +                         intc_phandles, imsic_s_phandle,
> +                         IRQ_S_EXT, imsic_guest_bits);
> +
> +    uint32_t aplic_m_phandle =3D next_phandle();
> +
> +    /* M-level APLIC node */
> +    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
> +                         msi_m_phandle, intc_phandles,
> +                         aplic_m_phandle, aplic_s_phandle,
> +                         IRQ_M_EXT, s->soc.num_harts);
> +
> +    /* S-level APLIC node */
> +    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
> +                         imsic_s_phandle, intc_phandles,
> +                         aplic_s_phandle, 0,
> +                         IRQ_S_EXT, s->soc.num_harts);
> +}
> +
> +static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
> +                            int irqchip_phandle)
> +{
> +    g_autofree char *name =3D g_strdup_printf("/soc/serial@%"HWADDR_PRIX=
,
> +                                            mem->base);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem-=
>size);
> +    qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
> +    qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
> +    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle=
);
> +    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
> +
> +    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
> +    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
> +}
> +
> +static void create_fdt_rng(void *fdt)
> +{
> +    uint8_t rng_seed[32];
> +
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> +    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_se=
ed));
> +}
> +
> +static void finalize_fdt(TTAtlantisState *s)
> +{
> +    uint32_t aplic_s_phandle =3D next_phandle();
> +    uint32_t imsic_s_phandle =3D next_phandle();
> +    void *fdt =3D MACHINE(s)->fdt;
> +
> +    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> +
> +    /*
> +     * We want to do this, but the Linux aplic driver was broken before =
v6.16
> +     *
> +     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt-parent"=
,
> +     *                       aplic_s_phandle);
> +     */
> +
> +    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
> +                    aplic_s_phandle);
> +}
> +
> +static void create_fdt(TTAtlantisState *s)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +
> +    ms->fdt =3D create_board_device_tree("Tenstorrent Atlantis RISC-V Ma=
chine",
> +                                       "tenstorrent,atlantis", &s->fdt_s=
ize);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/chosen");
> +
> +    create_fdt_rng(ms->fdt);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +
> +    create_fdt_pmu(s);
> +}
> +
> +static void load_fdt(TTAtlantisState *s)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +    char **node_path;
> +    Error *err =3D NULL;
> +
> +    ms->fdt =3D load_device_tree(ms->dtb, &s->fdt_size);
> +    if (!ms->fdt) {
> +        error_report("load_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    qemu_fdt_add_path(ms->fdt, "/chosen");
> +
> +    /* Clear memory nodes and update with the specified RAM size */
> +    node_path =3D qemu_fdt_node_unit_path(ms->fdt, "memory", &err);
> +    if (err) {
> +        warn_report_err(err);
> +    } else {
> +        for (int i =3D 0; node_path[i]; i++) {
> +            warn_report("Replacing device tree %s with the requested RAM=
 size",
> +                        node_path[i]);
> +            qemu_fdt_nop_node(ms->fdt, node_path[i]);
> +        }
> +        g_strfreev(node_path);
> +    }
> +
> +    create_fdt_memory(s);
> +}
> +
> +static void tt_atlantis_machine_done(Notifier *notifier, void *data)
> +{
> +    TTAtlantisState *s =3D container_of(notifier, TTAtlantisState, machi=
ne_done);
> +    MachineState *machine =3D MACHINE(s);
> +    hwaddr start_addr =3D s->memmap[TT_ATL_DDR_LO].base;
> +    hwaddr mem_size;
> +    target_ulong firmware_end_addr, kernel_start_addr;
> +    const char *firmware_name =3D riscv_default_firmware_name(&s->soc);
> +    uint64_t fdt_load_addr;
> +    uint64_t kernel_entry;
> +    RISCVBootInfo boot_info;
> +
> +    /*
> +     * A user provided dtb must include everything, including
> +     * dynamic sysbus devices. Our FDT needs to be finalized.
> +     */
> +    if (machine->dtb =3D=3D NULL) {
> +        finalize_fdt(s);
> +    }
> +
> +    mem_size =3D machine->ram_size;
> +    if (mem_size > s->memmap[TT_ATL_DDR_LO].size) {
> +        mem_size =3D s->memmap[TT_ATL_DDR_LO].size;
> +    }
> +    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc,
> +                                       s->memmap[TT_ATL_DDR_LO].base,
> +                                       mem_size);
> +
> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, &boot_in=
fo,
> +                                                     firmware_name,
> +                                                     &start_addr, NULL);
> +
> +    kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
> +                                                     firmware_end_addr);
> +    if (machine->kernel_filename) {
> +        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
> +                          true, NULL);
> +    }
> +    kernel_entry =3D boot_info.image_low_addr;
> +
> +    fdt_load_addr =3D riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].ba=
se,
> +                                           s->memmap[TT_ATL_DDR_LO].size=
,
> +                                           machine, &boot_info);
> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
> +
> +    /* load the reset vector */
> +    riscv_setup_rom_reset_vec(machine, &s->soc, start_addr,
> +                              s->memmap[TT_ATL_BOOTROM].base,
> +                              s->memmap[TT_ATL_BOOTROM].size,
> +                              kernel_entry,
> +                              fdt_load_addr);
> +}
> +
> +static void tt_atlantis_machine_init(MachineState *machine)
> +{
> +    TTAtlantisState *s =3D TT_ATLANTIS_MACHINE(machine);
> +
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    MemoryRegion *ram_hi =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *ram_lo =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *bootrom =3D g_new(MemoryRegion, 1);
> +    ram_addr_t lo_ram_size;
> +    int hart_count =3D machine->smp.cpus;
> +
> +    s->memmap =3D tt_atlantis_memmap;
> +
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_RISCV_HART_ARRAY);
> +    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_ty=
pe,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->soc), "hartid-base", 0,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->soc), "num-harts", hart_count,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->soc), "resetvec",
> +                            s->memmap[TT_ATL_BOOTROM].base,
> +                            &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> +
> +    s->irqchip =3D riscv_create_aia(true, TT_IRQCHIP_GUESTS,
> +                                  TT_IRQCHIP_MIMSIC_STRIDE,
> +                                  TT_IRQCHIP_NUM_SOURCES,
> +                                  &s->memmap[TT_ATL_MAPLIC],
> +                                  &s->memmap[TT_ATL_SAPLIC],
> +                                  &s->memmap[TT_ATL_MIMSIC],
> +                                  &s->memmap[TT_ATL_SIMSIC],
> +                                  0, 0, hart_count,
> +                                  TT_IRQCHIP_NUM_MSIS,
> +                                  TT_IRQCHIP_NUM_PRIO_BITS);
> +
> +    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
> +            TT_ACLINT_MTIME_SIZE,
> +            0, hart_count,
> +            TT_ACLINT_MTIMECMP,
> +            TT_ACLINT_MTIME,
> +            TT_ACLINT_TIMEBASE_FREQ, true);
> +
> +    /*
> +     * DDR
> +     *
> +     * The high address is where RAM lives. It is always present and may=
 be
> +     * up to 64GB. The low address is an alias of the first 2GB of that =
RAM.
> +     */
> +    if (machine->ram_size > s->memmap[TT_ATL_DDR_HI].size) {
> +        char *sz =3D size_to_str(s->memmap[TT_ATL_DDR_HI].size);
> +        error_report("RAM size is too large, maximum is %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machin=
e->ram,
> +                             0, machine->ram_size);
> +    memory_region_add_subregion(system_memory,
> +                                s->memmap[TT_ATL_DDR_HI].base, ram_hi);
> +
> +    lo_ram_size =3D MIN(machine->ram_size, s->memmap[TT_ATL_DDR_LO].size=
);
> +    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine=
->ram,
> +                             0, lo_ram_size);
> +    memory_region_add_subregion(system_memory,
> +                                s->memmap[TT_ATL_DDR_LO].base, ram_lo);
> +
> +    /* Boot ROM */
> +    memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
> +                           s->memmap[TT_ATL_BOOTROM].size, &error_fatal)=
;
> +    memory_region_add_subregion(system_memory, s->memmap[TT_ATL_BOOTROM]=
.base,
> +                                bootrom);
> +
> +    /* UART1, the soc console (UART0 is for the boot microcontroller) */
> +    serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
> +                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
> +                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +    /*
> +     * Atlantis contains a DesignWare uart while the QEMU machine
> +     * uses the serial_mm model with the base ns16550 register set.
> +     * Linux's dw driver writes outside of serial_mm's 0x20 sized
> +     * mapping and faults.
> +     *
> +     * Create an unimplemented device region so writes don't fault
> +     * and reads return zero, which keeps Linux happy.
> +     */
> +    create_unimplemented_device("tt-atlantis.uart0",
> +                                s->memmap[TT_ATL_UART1].base,
> +                                s->memmap[TT_ATL_UART1].size);
> +
> +    /* Load or create device tree */
> +    if (machine->dtb) {
> +        load_fdt(s);
> +    } else {
> +        create_fdt(s);
> +    }
> +
> +    s->machine_done.notify =3D tt_atlantis_machine_done;
> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> +}
> +
> +static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *=
data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "Tenstorrent Atlantis RISC-V SoC (Experimental)";
> +    mc->init =3D tt_atlantis_machine_init;
> +    mc->max_cpus =3D 8;
> +    mc->default_cpus =3D 8;
> +    mc->default_ram_size =3D 4 * GiB;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_TT_ASCALON;
> +    mc->block_default_type =3D IF_VIRTIO;
> +    mc->no_cdrom =3D 1;
> +    mc->default_ram_id =3D "tt_atlantis.ram";
> +}
> +
> +static const TypeInfo tt_atlantis_types[] =3D {
> +    {
> +        .name       =3D MACHINE_TYPE_NAME("tt-atlantis"),
> +        .parent     =3D TYPE_MACHINE,
> +        .class_init =3D tt_atlantis_machine_class_init,
> +        .instance_size =3D sizeof(TTAtlantisState),
> +        .interfaces =3D riscv64_machine_interfaces,
> +    },
> +};
> +
> +DEFINE_TYPES(tt_atlantis_types)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 54e41a6afc90..5033415440d4 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -120,6 +120,16 @@ config SPIKE
>      select RISCV_ACLINT
>      select SIFIVE_PLIC
>
> +config TENSTORRENT
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +    select SERIAL_MM
> +    select DEVICE_TREE
> +
>  config XIANGSHAN_KUNMINGHU
>      bool
>      default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 798477b7882a..0d82ceacc430 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -11,6 +11,7 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('s=
ifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
> +riscv_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis.c')=
)
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>         'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv=
-iommu-hpm.c'))
> --
> 2.47.3
>
>

