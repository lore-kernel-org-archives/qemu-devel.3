Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC28ACA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 16:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOoP-0006yC-AB; Tue, 19 Aug 2025 12:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoOoN-0006xA-Gi
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:03:47 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoOoJ-0006TK-O6
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:03:47 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e934641d4f3so2777563276.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755619422; x=1756224222; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1xbyq1QSyHZoy3HSmtJooeIxWyJCGg5ElkVhKHXdB0=;
 b=sEatQbZ6Qt6jgdo7gVbSI6+wJr2V0vvfRM8PvWbyRIzIt5apAtD7uUz6MFl9lZphpA
 efxLQsBfBB6CcAOujNrnYYsOz6zqMHhS/tvq/PRQ9eHiUD3lijotJuKkpzlNUz3VgS8x
 BrLFtw6XVLBM1v4vg0AQk5gExWYxgOkt+Sq/8yjbgYNZ1T8oIBSRVUM1wWEPB31X5eej
 YXGP5G2PNhIijT6YtAfkekasjS0U7C1y0+sNiE0v4+ED06/Hx7mfDf3unXl7blcBylZ6
 1R1u6KLbR328UpyEmFsvEvl+2CZdwcHo3IM8eBQQtsbR4LAI0pGUTaU85W+XIi6vnDDF
 naag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755619422; x=1756224222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1xbyq1QSyHZoy3HSmtJooeIxWyJCGg5ElkVhKHXdB0=;
 b=v41efzXtPZvIkWPvB0owRf0XoOgKGXq7wfmFLaTjxtG1fPSq0SmLbNubvXPmTC7vyL
 vOeE33wPtiT8dCWJjyuIyMzVi9cb5uSQAJLAIq29cEfoscD6cpqdS443hNrVQC583j3f
 CbTUWkESwnMQcvtionFA3b+Gbe9yjenqgx6nMxBtm1yv/XckBVauDbnBeciYU4y4fS9/
 qHjq9fB/RBTrYd3+YR6cikLggvUm+asZfoWRaGLvC9zjoXLkm8Z/xy2nkvcIlEk70V/n
 hrAggMNHQDrXvXrcEWGz2yX/M58ouFhTjrpa8A0DXTZt28ej7XoBR7+aUtVf6WBDy1at
 PlhA==
X-Gm-Message-State: AOJu0Yz7/jUs1xxX7djoAj5rN4MjmZgguCrGdYzlWi2sdKg1jRuWkwnV
 ZZnVzHr9Lolx9azmMDXI0rsaiw5j5QCPUViwNyW2hTX0onEP29TYSlRIVHqxnKwouUZHI5tWbbs
 KZDxSe39xETWPw+9EUJkXjWhUBv4RG3ZIKiFT7HEv+w==
X-Gm-Gg: ASbGncss/yEnpPb2576T+84qeOYp+Zk2GNycFr+r4jTEtDPKEdUZJg1nqZprRQF7P0a
 /fDuM3abS1rtDX4VUozRh2UzV6d4VQjoJruqJhimw++AB23PRU0OKoWKr094EEYgt40IsCCDirw
 AZhr/x4VuWuAgQg9e5HK7Zs2/KPJ2LiwWycvm3slN0jHVbzIHOtrHx3zd7NJenTsKhP2fLienD2
 dmaR39Q
X-Google-Smtp-Source: AGHT+IGuravNggVkhOYgSiB45n5rLUdOQBZfSlh8QUuzzmEogVEdP4cG9AsBy6QH/9NBYXOOq7rmvgAzOf/+xfnOLVs=
X-Received: by 2002:a05:6902:1382:b0:e8e:26bb:2452 with SMTP id
 3f1490d57ef6-e94e61779f1mr2815376276.8.1755619409138; Tue, 19 Aug 2025
 09:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-12-corvin.koehne@gmail.com>
In-Reply-To: <20250815090113.141641-12-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 17:03:16 +0100
X-Gm-Features: Ac12FXwrhT-Tw2l0sIPtK7xGaAehj83ko7knQbme-mgu1X9x_eRctqgIVPz9bnU
Message-ID: <CAFEAcA_VQgoym1_Nmw8iXyBS-ZQTvc+3FYQBTR7W0_Pxb3u=RQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] hw/misc: Add Beckhoff CCAT device
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Fri, 15 Aug 2025 at 10:01, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> This adds the Beckhoff Communication Controller (CCAT). The information
> block, EEPROM interface and DMA controller are currently  implemented.
>
> The EEPROM provides production information for Beckhoff Devices.
> An EEPORM binary must therefor be handed over. It should be aligned to
> a power of two. If no EEPROM binary is handed over an empty EEPROM of
> size 4096 is initialized.
>
> This device is needed for the Beckhoff CX7200 board emulation.
>
> Signed-off-by: Yannick Vo=C3=9Fen <y.vossen@beckhoff.com>
> ---
>  hw/misc/Kconfig         |   3 +
>  hw/misc/beckhoff_ccat.c | 365 ++++++++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build     |   1 +
>  3 files changed, 369 insertions(+)
>  create mode 100644 hw/misc/beckhoff_ccat.c
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 99548e146f..f3a2efa350 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -223,4 +223,7 @@ config XLNX_VERSAL_TRNG
>  config XLNX_ZYNQ_DDRC
>      bool
>
> +config BECKHOFF_CCAT
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/beckhoff_ccat.c b/hw/misc/beckhoff_ccat.c
> new file mode 100644
> index 0000000000..0e21962a98
> --- /dev/null
> +++ b/hw/misc/beckhoff_ccat.c
> @@ -0,0 +1,365 @@
> +/*
> + * Beckhoff Communication Controller Emulation
> + *
> + * Copyright (c) Beckhoff Automation GmbH. & Co. KG
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.

This needs an SPDX license identifier line. If you have that,
then you don't need the human-readable license blurb.

Is there a datasheet/manual for this device? The comment
at the top of the file is a good place to put the URL to it.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/register.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "system/block-backend.h"
> +#include "exec/address-spaces.h"
> +#include "exec/memory.h"
> +#include "system/dma.h"
> +#include "qemu/error-report.h"
> +#include "block/block.h"
> +#include "block/block_int.h"
> +#include "block/qdict.h"
> +#include "hw/block/block.h"
> +
> +#ifndef CCAT_ERR_DEBUG
> +#define CCAT_ERR_DEBUG 0
> +#endif
> +
> +#define DB_PRINT_L(level, ...) do { \
> +    if (CCAT_ERR_DEBUG > (level)) { \
> +        fprintf(stderr,  ": %s: ", __func__); \
> +        fprintf(stderr, ## __VA_ARGS__); \
> +    } \
> +} while (0)

No debug printf macros in new code, please. Use either:
 * tracepoints, for "this is information that might be
   interesting for somebody debugging the device or code
   that runs on the device"
 * qemu_log_mask(LOG_UNIMP, ...), for "the guest tried
   to use a feature that we don't implement"
 * qemu_log_mask(LOG_GUEST_ERROR, ...), for "the guest
   tried to do something that the datasheet says is
   undefined behaviour/reserved/unpredictable"

> +
> +#define DB_PRINT(...) DB_PRINT_L(0, ## __VA_ARGS__)
> +
> +#define TYPE_BECKHOFF_CCAT "beckhoff-ccat"
> +#define BECKHOFF_CCAT(obj) \
> +    OBJECT_CHECK(BeckhoffCcat, (obj), TYPE_BECKHOFF_CCAT)

Prefer the new-style OBJECT_DECLARE_SIMPLE_TYPE etc
macros, rather than defining the cast macro yourself.

> +
> +#define MAX_NUM_SLOTS 32
> +
> +#define CCAT_EEPROM_OFFSET 0x100
> +#define CCAT_DMA_OFFSET 0x8000
> +
> +#define CCAT_MEM_SIZE 0xFFFF
> +#define CCAT_DMA_SIZE 0x800
> +#define CCAT_EEPROM_SIZE 0x20
> +
> +#define EEPROM_MEMORY_SIZE 0x1000
> +
> +#define EEPROM_CMD_OFFSET (CCAT_EEPROM_OFFSET + 0x00)
> +    #define EEPROM_CMD_WRITE_MASK 0x2
> +    #define EEPROM_CMD_READ_MASK 0x1
> +#define EEPROM_ADR_OFFSET (CCAT_EEPROM_OFFSET + 0x04)
> +#define EEPROM_DATA_OFFSET (CCAT_EEPROM_OFFSET + 0x08)
> +
> +#define DMA_BUFFER_OFFSET (CCAT_DMA_OFFSET + 0x00)
> +#define DMA_DIRECTION_OFFSET (CCAT_DMA_OFFSET + 0x7c0)
> +    #define DMA_DIRECTION_MASK 1
> +#define DMA_TRANSFER_OFFSET (CCAT_DMA_OFFSET + 0x7c4)
> +#define DMA_HOST_ADR_OFFSET (CCAT_DMA_OFFSET + 0x7c8)
> +#define DMA_TRANSFER_LENGTH_OFFSET (CCAT_DMA_OFFSET + 0x7cc)
> +
> +/*
> + * The informationblock  is always located at address 0x0.
> + * Address and size are therefor replaced by two identifiers.
> + * The Parameter give information about the maximal number of
> + * function slots and the creation date (in this case 01.01.2001)
> + */
> +#define CCAT_ID_1 0x88a4
> +#define CCAT_ID_2 0x54414343
> +#define CCAT_INFO_BLOCK_PARAMS (MAX_NUM_SLOTS << 0) | (0x1 << 8) | \
> +                              (0x1 << 16) | (0x1 << 24)
> +
> +#define CCAT_FUN_TYPE_ENTRY 0x0001
> +#define CCAT_FUN_TYPE_EEPROM 0x0012
> +#define CCAT_FUN_TYPE_DMA 0x0013
> +
> +typedef struct BeckhoffCcat {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint8_t mem[CCAT_MEM_SIZE];
> +
> +    BlockBackend *eeprom_blk;
> +    uint8_t *eeprom_storage;
> +    int64_t eeprom_size;
> +} BeckhoffCcat;
> +
> +typedef struct __attribute__((packed)) CcatFunctionBlock {
> +    uint16_t type;
> +    uint16_t revision;
> +    uint32_t parameter;
> +    uint32_t address_offset;
> +    uint32_t size;
> +} CcatFunctionBlock;

"attribute((packed))" is a bit of a red flag of doing something
wrong. In this case, you use this in beckhoff_ccat_reset() to
set up a host C structure that you memcpy() into s->mem[].
That is not portable to big-endian systems.

> +
> +static void sync_eeprom(BeckhoffCcat *s)
> +{
> +    if (!s->eeprom_blk) {
> +        return;
> +    }
> +    blk_pwrite(s->eeprom_blk, 0, s->eeprom_size, s->eeprom_storage, 0);
> +}
> +
> +static uint64_t beckhoff_ccat_eeprom_read(void *opaque, hwaddr addr,
> +                                          unsigned size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +    uint64_t val =3D 0;
> +    memcpy(&val, &s->mem[addr], size);

What is this trying to do ? If you want to read
N bytes of data in little endian order from a host
address, use ldn_le_p(). (Also available in "big endian"
and "host endianness" flavours.)

> +    return val;
> +}
> +
> +static void beckhoff_ccat_eeprom_write(void *opaque, hwaddr addr, uint64=
_t val,
> +                              unsigned size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +    uint64_t eeprom_adr;
> +    switch (addr) {
> +    case EEPROM_CMD_OFFSET:
> +        eeprom_adr =3D *(uint32_t *)&s->mem[EEPROM_ADR_OFFSET];
> +        eeprom_adr =3D (eeprom_adr * 2) % s->eeprom_size;
> +        if (val & EEPROM_CMD_READ_MASK) {
> +            uint64_t buf =3D 0;
> +            uint32_t bytes_to_read =3D 8;
> +            if (eeprom_adr > s->eeprom_size - 8) {
> +                bytes_to_read =3D s->eeprom_size - eeprom_adr;
> +            }
> +            memcpy(&buf, s->eeprom_storage + eeprom_adr, bytes_to_read);
> +            *(uint64_t *)&s->mem[EEPROM_DATA_OFFSET] =3D buf;

All this code with casting to different pointer types and
using memcpy() looks very suspicious. Use the relevant
ld*_*_p() functions to load the right sized values at the
right endianness. (Casting from one pointer type to another
is usually an indication that you're going down a wrong path.)

> +
> +        } else if (val & EEPROM_CMD_WRITE_MASK) {
> +            uint32_t buf =3D *(uint32_t *)&s->mem[EEPROM_DATA_OFFSET];
> +            memcpy(s->eeprom_storage + eeprom_adr, &buf, 2);
> +            sync_eeprom(s);
> +        }
> +        break;
> +    default:
> +            memcpy(&s->mem[addr], &val, size);
> +    }
> +}
> +
> +static uint64_t beckhoff_ccat_dma_read(void *opaque, hwaddr addr, unsign=
ed size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +    uint64_t val =3D 0;
> +
> +    switch (addr) {
> +    case DMA_TRANSFER_OFFSET:
> +        if (s->mem[DMA_TRANSFER_OFFSET] & 0x1) {
> +            DB_PRINT("DMA transfer finished\n");
> +            s->mem[DMA_TRANSFER_OFFSET] =3D 0;
> +        }
> +        break;
> +    }
> +    memcpy(&val, &s->mem[addr], size);
> +    return val;
> +}
> +
> +static void beckhoff_ccat_dma_write(void *opaque, hwaddr addr, uint64_t =
val,
> +                           unsigned size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +    switch (addr) {
> +    case DMA_TRANSFER_OFFSET:
> +        uint8_t len =3D s->mem[DMA_TRANSFER_LENGTH_OFFSET];
> +        uint8_t *mem_buf =3D &s->mem[DMA_BUFFER_OFFSET];
> +
> +        if (s->mem[DMA_DIRECTION_OFFSET] & DMA_DIRECTION_MASK) {
> +            dma_addr_t dmaAddr =3D *(uint32_t *)&s->mem[DMA_HOST_ADR_OFF=
SET];

Should probably be ldl_le_p().

> +            dma_memory_read(&address_space_memory, dmaAddr,
> +                            mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED);
> +        } else {
> +            dma_addr_t dmaAddr =3D *(uint32_t *)&s->mem[DMA_HOST_ADR_OFF=
SET];
> +            dma_memory_write(&address_space_memory, dmaAddr + 8,
> +                                mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED=
);

Does this really use addr for reads and addr + 8 for writes ?

> +        }
> +        break;
> +    }
> +    memcpy(&s->mem[addr], &val, size);
> +}
> +static uint64_t beckhoff_ccat_read(void *opaque, hwaddr addr, unsigned s=
ize)
> +{
> +    DB_PRINT("CCAT_READ addr=3D0x%lx size=3D%u\n", addr, size);
> +
> +    BeckhoffCcat *s =3D opaque;
> +    uint64_t val =3D 0;
> +
> +    if (addr > CCAT_MEM_SIZE - size) {
> +        error_report("Overflow. Address or size is too large.\n");
> +        exit(1);

Don't error_report() and exit for things like this.
Either:
 (a) this is not possible unless there's a bug in QEMU:
     in that case, use assert()
 (b) this is possible if the guest does something silly:
     in that case use qemu_log_mask(LOG_GUEST_ERROR, ...)

In this case it looks like an assert() is appropriate, because
the memory_region_init_io() size argument should ensure that
you can't get here with an addr + size that is beyond the
end of the block.

> +    }
> +
> +    if (addr >=3D CCAT_EEPROM_OFFSET &&
> +                        addr <=3D CCAT_EEPROM_OFFSET + s->eeprom_size) {
> +        return beckhoff_ccat_eeprom_read(opaque, addr, size);
> +    } else if (addr >=3D CCAT_DMA_OFFSET &&
> +                        addr <=3D CCAT_DMA_OFFSET + CCAT_DMA_SIZE) {
> +        return beckhoff_ccat_dma_read(opaque, addr, size);
> +    } else {
> +        memcpy(&val, &s->mem[addr], size);
> +    }
> +
> +    return val;
> +}
> +
> +static void beckhoff_ccat_write(void *opaque, hwaddr addr, uint64_t val,
> +                                unsigned size)
> +{
> +    DB_PRINT("CCAT_WRITE addr=3D0x%lx size=3D%u val=3D0x%lx\n", addr, si=
ze, val);
> +
> +    BeckhoffCcat *s =3D opaque;
> +
> +    if (addr > CCAT_MEM_SIZE - size) {
> +        error_report("Overflow. Address or size is too large.\n");
> +        exit(1);
> +    }
> +
> +    if (addr >=3D CCAT_EEPROM_OFFSET &&
> +                        addr <=3D CCAT_EEPROM_OFFSET + s->eeprom_size) {
> +        beckhoff_ccat_eeprom_write(opaque, addr, val, size);
> +    } else if (addr >=3D CCAT_DMA_OFFSET &&
> +                        addr <=3D CCAT_DMA_OFFSET + CCAT_DMA_SIZE) {
> +        beckhoff_ccat_dma_write(opaque, addr, val, size);
> +    } else {
> +        memcpy(&s->mem[addr], &val, size);
> +    }
> +}
> +
> +static const MemoryRegionOps beckhoff_ccat_ops =3D {
> +    .read =3D beckhoff_ccat_read,
> +    .write =3D beckhoff_ccat_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
> +
> +static void beckhoff_ccat_reset(DeviceState *dev)
> +{
> +    BeckhoffCcat *s =3D BECKHOFF_CCAT(dev);
> +
> +    CcatFunctionBlock function_blocks[MAX_NUM_SLOTS] =3D {0};
> +
> +    CcatFunctionBlock info_block =3D {
> +        .type =3D CCAT_FUN_TYPE_ENTRY,
> +        .revision =3D 0x0001,
> +        .parameter =3D CCAT_INFO_BLOCK_PARAMS,
> +        .address_offset =3D CCAT_ID_1,
> +        .size =3D CCAT_ID_2
> +    };
> +    CcatFunctionBlock eeprom_block =3D {
> +        .type =3D CCAT_FUN_TYPE_EEPROM,
> +        .revision =3D 0x0001,
> +        .parameter =3D 0,
> +        .address_offset =3D CCAT_EEPROM_OFFSET,
> +        .size =3D CCAT_EEPROM_SIZE
> +    };
> +    CcatFunctionBlock dma_block =3D {
> +        .type =3D CCAT_FUN_TYPE_DMA,
> +        .revision =3D 0x0000,
> +        .parameter =3D 0,
> +        .address_offset =3D CCAT_DMA_OFFSET,
> +        .size =3D CCAT_DMA_SIZE
> +    };
> +
> +    /*
> +     * The EEPROM interface is usually at function slot 11.
> +     * The DMA controller is usually at function slot 15.
> +     */
> +    function_blocks[0] =3D info_block;
> +    function_blocks[11] =3D eeprom_block;
> +    function_blocks[15] =3D dma_block;
> +
> +    memcpy(&s->mem[0], function_blocks, sizeof(function_blocks));

This isn't going to work on big-endian hosts, as noted above.

> +}
> +
> +static void beckhoff_ccat_realize(DeviceState *dev, Error **errp)
> +{
> +    BeckhoffCcat *s =3D BECKHOFF_CCAT(dev);
> +    BlockBackend *blk;
> +
> +    blk =3D blk_by_name("ccat-eeprom");

No other device calls blk_by_name() to get its block backend:
you should not do so either. Use a qdev property and have
the SoC/board model set it.

> +
> +    if (blk) {
> +        uint64_t blk_size =3D blk_getlength(blk);
> +        if (!is_power_of_2(blk_size)) {
> +            error_report("Blockend size is not a power of two.");

In a realize function you have an Error** argument, so you
should report errors via error_setg() + return.

> +        }
> +
> +        if (blk_size < 512) {
> +            error_report("Blockend size is too small. Using backup.");
> +            s->eeprom_size =3D EEPROM_MEMORY_SIZE;
> +            s->eeprom_storage =3D blk_blockalign(NULL, s->eeprom_size);
> +            memset(s->eeprom_storage, 0x00, s->eeprom_size);

We don't try to fix things up like this in other block-backed
devices, I think, so we shouldn't do it here either.

> +        } else {
> +            DB_PRINT("EEPROM block backend found\n");
> +            blk_set_perm(blk, BLK_PERM_WRITE, BLK_PERM_ALL, errp);
> +
> +            s->eeprom_size =3D blk_size;
> +            s->eeprom_blk =3D blk;
> +            s->eeprom_storage =3D blk_blockalign(s->eeprom_blk, s->eepro=
m_size);
> +
> +            if (!blk_check_size_and_read_all(s->eeprom_blk, DEVICE(s),
> +                                             s->eeprom_storage, s->eepro=
m_size,
> +                                             errp)) {
> +                exit(1);

Don't silently exit(): use 'return', to report the error
to your caller.

> +            }
> +        }
> +    } else {
> +        s->eeprom_size =3D EEPROM_MEMORY_SIZE;
> +        s->eeprom_storage =3D blk_blockalign(NULL, s->eeprom_size);
> +        memset(s->eeprom_storage, 0x00, s->eeprom_size);
> +    }
> +
> +    beckhoff_ccat_reset(dev);
> +}
> +
> +static void beckhoff_ccat_init(Object *obj)
> +{
> +    BeckhoffCcat *s =3D BECKHOFF_CCAT(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &beckhoff_ccat_ops, s,
> +                          TYPE_BECKHOFF_CCAT, CCAT_MEM_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void beckhoff_ccat_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    dc->realize =3D beckhoff_ccat_realize;

The guest can read and write mem[], so I think you need
a reset handler, and also a VMState for migration.

> +}

thanks
-- PMM

