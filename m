Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024CFD41178
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgM3Q-00066n-Em; Thu, 15 Jan 2026 07:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgM3P-00066L-7E
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:02:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgM3L-0005NK-Uo
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:02:18 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso1272805e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 04:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768478534; x=1769083334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4El7D47CmC5XbztDY0QZe9Hcym3g6S/7NVx2NKqRtE=;
 b=meo3WVMoK7jEJfRbviWqT6G2p+3+rMfuUZbzKwdLi1yDaWOsVjsbbckOS28tuElglW
 Ji/mtoMFcI2WViZM2YRzyd6oIwXq9e7tm5wGXbzX16POwq9Dz+8dhGpppw2KROpdDe2i
 aDetInJ9IYclz3H1HkgN5GljoOmYfrFzDRxiaUfM+Wb0AcUD6LugiIHP1r81daPaIXVI
 FxG3HNYZej3GWRjV+mO1UD33Op6ndh36s+bS1NYuBVXqaNQwAWo5fTvmUf3fduKE3+T7
 NQOB10ytPuxcY5diiRaX1HxqUvrkXkFN1W0R7V5sFwhmZdDlMO0GKHmxbfj9aKnLOayI
 ENyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768478534; x=1769083334;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4El7D47CmC5XbztDY0QZe9Hcym3g6S/7NVx2NKqRtE=;
 b=fJ1h/fjZKiAhjJOoLIg7G1nbd8djnz56LM2pKy1zk1IjHR5TkfghgXb9TfiqxjP0NN
 lb7aTzTRD14aCXlaruFtATvgzuecK3PBCVns3UNaqJaoW7v+VYDS+D6sizMEDZhnDyHZ
 3tf4/jybE5Qn5aNEED6JAfLnP3tkbLd9izjSdsKg9r2hY/Xp36uMwM7iibokAtlVTa4v
 3JbHOY6PNKa4GX7IWEBhlvLTvjZFg+q3AyD4qUpUr+zlfiCni0ORNyMZ+pNGSb0y+/4S
 y+6c0OYTtv4GasUXggnJYUsvbrL3QSmqexSrD2F5r3Vdla2kXf/SXgI0Gr7z/AYD8NTz
 1h4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9O/OCuBQ5prlzYfnMwgTGTdjU4789m9YjCDWNWBkgBRZPofuR1I4hIMkRtHbe3zhQN6P4Bd8rFxlv@nongnu.org
X-Gm-Message-State: AOJu0YyauMLzqGQwDdJHDqnn1CZcC54NQvt+ZxGZ/Xmh5LoPmoIOD+XM
 QiuMrgQZH15ssgGx7gSKcnneYVOT9LUPc/K8UHpD+Ahr/UWxlDiqEKj9lnjgo5DoJ6I=
X-Gm-Gg: AY/fxX7vVq/U6UW+d+BZ6RLHFHKnfyyI/gLwRnCmDKqbBY9onfaX2hRhWLfOnERQw5K
 ObA1mQ/exaIBj+jbZvT5wcv3jqrjKPUPzC56YZBs8CpPrKzlZcV9tRVkc+LwQ0YbdUILQ329/I9
 Kk7zg6tr5oIlz9+UwPzj6Fsgmx1df9fUi+L1hGzPX78cAxrKSvUb52maPsgMOaE9aGLaFX/E3Xe
 o1RsjkfcP4/+LE7rKTGbOaOgw1fNyF56g+qSPD72ddLLuUtH5nci1UqChr0+4fS5yR0s3iQn4Js
 euKCIyBK6RBuOnH+JVIV1UxhMyq8QWSl/kqAB0LpH6cfB7DcYOwY2fCQNAoFGcRXCTqCxVn/e4M
 JS83FMU9toApp3aFVf1tQd6gv2VSUo0DJ4UfUQRZaXdueVT8/MtueddpppFNJQ3yz2IczTE/gMg
 6a4sYfIRLcA6U=
X-Received: by 2002:a05:600c:35c3:b0:47d:264e:b371 with SMTP id
 5b1f17b1804b1-47ee334f554mr77360865e9.18.1768478534107; 
 Thu, 15 Jan 2026 04:02:14 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6d8ad2sm5674360f8f.32.2026.01.15.04.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 04:02:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8970D5F88E;
 Thu, 15 Jan 2026 12:02:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Sunil V L <sunilvl@ventanamicro.com>,
 qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Weiwei Li
 <liwei1518@gmail.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,  Joel Stanley
 <jms@oss.tenstorrent.com>,  Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 4/6] hw/riscv/atlantis: Integrate i2c buses
In-Reply-To: <20260114043433.1056021-5-joel@jms.id.au> (Joel Stanley's message
 of "Wed, 14 Jan 2026 15:04:26 +1030")
References: <20260114043433.1056021-1-joel@jms.id.au>
 <20260114043433.1056021-5-joel@jms.id.au>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Thu, 15 Jan 2026 12:02:12 +0000
Message-ID: <87o6mvhynv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Joel Stanley <joel@jms.id.au> writes:

> Now that we have the DesignWare model we can add buses to the
> tt-atlantis machine.

This is triggering a configure failure for me:

  Configuring aarch64-softmmu-config-devices.mak with command

  ../../meson.build:3448:25: ERROR: Command `/home/alex/lsrc/qemu.git/build=
s/all/pyvenv/bin/python3 /home/alex/lsrc/qemu.git/scripts/minikconf.py --de=
fconfig aarch64-softmmu-config-devices.mak /home/alex/lsrc/qemu.git/builds/=
all/meson-private/aarch64-softmmu-config-devices.mak.d /home/alex/lsrc/qemu=
.git/configs/devices/aarch64-softmmu/default.mak /home/alex/lsrc/qemu.git/K=
config CONFIG_TPM=3Dy CONFIG_PIXMAN=3Dy CONFIG_SPICE=3Dy CONFIG_IVSHMEM=3Dy=
 CONFIG_OPENGL=3Dy CONFIG_GNUTLS=3Dy CONFIG_X11=3Dy CONFIG_FDT=3Dy CONFIG_V=
HOST_USER=3Dy CONFIG_VHOST_VDPA=3Dy CONFIG_VHOST_KERNEL=3Dy CONFIG_VIRTFS=
=3Dy CONFIG_LINUX=3Dy CONFIG_MULTIPROCESS_ALLOWED=3Dy CONFIG_HV_BALLOON_POS=
SIBLE=3Dy CONFIG_TCG=3Dy CONFIG_AARCH64=3Dy CONFIG_TARGET_BIG_ENDIAN=3Dn` f=
ailed with status 1.

  A full log can be found at /home/alex/lsrc/qemu.git/builds/all/meson-logs=
/meson-log.txt
  FAILED: build.ninja=20
  /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson --internal regenerat=
e /home/alex/lsrc/qemu.git .
  ninja: error: rebuilding 'build.ninja': cannot make progress due to previ=
ous errors
  make: *** [Makefile:170: run-ninja] Error 1
  make: Target 'all' not remade because of errors.
  make: Leaving directory '/home/alex/lsrc/qemu.git/builds/all'

  Compilation exited abnormally with code 2 at Thu Jan 15 11:53:59, duratio=
n 3.23 s

Could it be an interaction with the prereq patches?

>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - Correct count from 4 to 5
>  - Fix headers location
> ---
>  include/hw/riscv/tt_atlantis.h | 13 ++++++++++++
>  hw/riscv/tt_atlantis.c         | 39 ++++++++++++++++++++++++++++++++++
>  hw/riscv/Kconfig               |  1 +
>  3 files changed, 53 insertions(+)
>
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlanti=
s.h
> index 10b06894aeca..1b4f61c95184 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -11,12 +11,15 @@
>=20=20
>  #include "hw/core/boards.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/i2c/designware_i2c.h"
>  #include "hw/intc/riscv_imsic.h"
>  #include "hw/riscv/riscv_hart.h"
>=20=20
>  #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
>  OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
>=20=20
> +#define TT_ATL_NUM_I2C 5
> +
>  struct TTAtlantisState {
>      /*< private >*/
>      MachineState parent;
> @@ -30,6 +33,7 @@ struct TTAtlantisState {
>      RISCVHartArrayState soc;
>      DeviceState *irqchip;
>      GPEXHost gpex_host;
> +    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>=20=20
>      int fdt_size;
>      int aia_guests; /* TODO: This should be hard coded once known */
> @@ -37,6 +41,11 @@ struct TTAtlantisState {
>=20=20
>  enum {
>      TT_ATL_SYSCON_IRQ =3D 10,
> +    TT_ATL_I2C0_IRQ =3D 33,
> +    TT_ATL_I2C1_IRQ =3D 34,
> +    TT_ATL_I2C2_IRQ =3D 35,
> +    TT_ATL_I2C3_IRQ =3D 36,
> +    TT_ATL_I2C4_IRQ =3D 37,
>      TT_ATL_UART0_IRQ =3D 38,
>      TT_ATL_UART1_IRQ =3D 39,
>      TT_ATL_UART2_IRQ =3D 40,
> @@ -52,6 +61,10 @@ enum {
>      TT_ATL_DDR_HI,
>      TT_ATL_FW_CFG,
>      TT_ATL_I2C0,
> +    TT_ATL_I2C1,
> +    TT_ATL_I2C2,
> +    TT_ATL_I2C3,
> +    TT_ATL_I2C4,
>      TT_ATL_MAPLIC,
>      TT_ATL_MIMSIC,
>      TT_ATL_PCIE_ECAM0,
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index fa6e4f42a12d..2d0add278c20 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -67,6 +67,11 @@ static const MemMapEntry tt_atlantis_memmap[] =3D {
>      [TT_ATL_TIMER] =3D            { 0xa8020000,       0x10000 },
>      [TT_ATL_WDT0] =3D             { 0xa8030000,       0x10000 },
>      [TT_ATL_UART0] =3D            { 0xb0100000,       0x10000 },
> +    [TT_ATL_I2C0] =3D             { 0xb0400000,       0x10000 },
> +    [TT_ATL_I2C1] =3D             { 0xb0500000,       0x10000 },
> +    [TT_ATL_I2C2] =3D             { 0xb0600000,       0x10000 },
> +    [TT_ATL_I2C3] =3D             { 0xb0700000,       0x10000 },
> +    [TT_ATL_I2C4] =3D             { 0xb0800000,       0x10000 },
>      [TT_ATL_MAPLIC] =3D           { 0xcc000000,     0x4000000 },
>      [TT_ATL_SAPLIC] =3D           { 0xe8000000,     0x4000000 },
>      [TT_ATL_DDR_HI] =3D          { 0x100000000,  0x1000000000 },
> @@ -478,6 +483,20 @@ static void create_fdt_fw_cfg(void *fdt, const MemMa=
pEntry *mem)
>      qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
>  }
>=20=20
> +static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t i=
rq,
> +                           int irqchip_phandle)
> +{
> +    g_autofree char *name =3D g_strdup_printf("/soc/i2c@%" PRIx64, mem->=
base);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "snps,designware-i2=
c");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem-=
>size);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle=
);
> +    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> +}
> +
>  static void finalize_fdt(TTAtlantisState *s)
>  {
>      uint32_t aplic_s_phandle =3D next_phandle();
> @@ -505,6 +524,13 @@ static void finalize_fdt(TTAtlantisState *s)
>=20=20
>      create_fdt_uart(fdt, &s->memmap[TT_ATL_UART0], TT_ATL_UART0_IRQ,
>                      aplic_s_phandle);
> +
> +    for (int i =3D 0; i < TT_ATL_NUM_I2C; i++) {
> +        create_fdt_i2c(fdt,
> +                       &s->memmap[TT_ATL_I2C0 + i],
> +                       TT_ATL_I2C0_IRQ + i,
> +                       aplic_s_phandle);
> +    }
>  }
>=20=20
>  static void create_fdt(TTAtlantisState *s)
> @@ -813,6 +839,19 @@ static void tt_atlantis_machine_init(MachineState *m=
achine)
>                     qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ),
>                     115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>=20=20
> +    /* I2C */
> +    for (int i =3D 0; i < TT_ATL_NUM_I2C; i++) {
> +        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
> +                                TYPE_DESIGNWARE_I2C);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &error_fatal);
> +        SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->i2c[i]);
> +        memory_region_add_subregion(system_memory,
> +                                    s->memmap[TT_ATL_I2C0 + i].base,
> +                                    sysbus_mmio_get_region(sbd, 0));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
> +                           qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ =
+ i));
> +    }
> +
>      /* Load or create device tree */
>      if (machine->dtb) {
>          machine->fdt =3D load_device_tree(machine->dtb, &s->fdt_size);
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 5317eccd06e7..ee876557ef15 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -137,6 +137,7 @@ config TENSTORRENT
>      select RISCV_IMSIC
>      select FW_CFG_DMA
>      select PLATFORM_BUS
> +    select DESIGNWARE_I2C
>=20=20
>  config XIANGSHAN_KUNMINGHU
>      bool

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

