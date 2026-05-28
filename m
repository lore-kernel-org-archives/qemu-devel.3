Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ECECD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaTp-0001w3-9J; Thu, 28 May 2026 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaTj-0001uO-SL
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:08:51 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaTh-0004FZ-P0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:08:51 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-660390a8999so1059683d50.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779973728; cv=none;
 d=google.com; s=arc-20240605;
 b=WGmpqjVUSxYlsUPAah9EekTvFgWqYFj4q70LwyQDZv1K3r463bSkeXDKas19PF5/eM
 5jLaIkJWhjFjvujjBV52nbPu5f49deR5cLJ3ycz96F785FNpb1/XSYKQVerrRLD0cjVJ
 6tqfYdrkUM1iCCJf3tlGTLwN+ad2drlsRahvVyyBu6KRbuliwRV2QuwY/3kzUVZp+sL0
 H+S9ElQSA567jPdkE5jc+iRI9VLzsnD78fzE+PMC4nsV3oVAfb6rF3Xe7j9yfgb6bpEq
 4UFHFsqalTrrOnteAhxLrrsYDTXwYVIFB/7eYkBSqSY7Xa7qOACVr7JMJo5xRbKNyR0j
 8ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r0UrrWt9sqzZeaAKebSEhrBk4jGafuU+EQPGwqeWzgE=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=I4WiT1yfLV3IdoszHkhr/Mjkog/PTFE5ShhaADK/remT2+vEAuMtwuGheqzyWxAwh6
 nCp3H656Nv56IFnQT8forM1/d8cXOvK7v+07xKsJYwLefYl3yOifxpbjQXBiiGd03OQt
 jgxk6o28i0w2/r6fwaHXCAfNtlcln/JHnVUVGkgMllg+0CJSa1vlmEYqazzvzvYdS0Hw
 7NWts4LvmotlOWBmaL24D0GrXkwnd7FQDMPQQyxsDlvO53LvPfdJd7+Ood865rrYQxgN
 7iK1pTlFTkBJPg5YPJ6aqAAjbFD+Q76VrsR21T8PEqcc2K/MXIre4nfjU0aY62hhsDTH
 0IwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779973728; x=1780578528; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0UrrWt9sqzZeaAKebSEhrBk4jGafuU+EQPGwqeWzgE=;
 b=pzsy4B396qIQxVCNcBvowt3nnu7dOx0EQfx3VtWLfmKPitqvzuaJ502kgJPWfqny2I
 RORpaJDe3NPNnlbJbeGkJsDw6n6PBfIUfKpCBSPNczXcwtPUZaG65Mms25G8n9KGnve1
 7mqO72sJun5R8dq6gSAGX+tEeQrFl9z9U1pgGtP8WBlNiyhh/++ZoqKiMkzyme+vLE5N
 BeCoe6KgKBuCzUdw3HhHuOEmaz+BOrhAScoCib90K2+QxSXUQ5J7v0gzh54ds2LhmJZP
 65zQUPCMazMF5kHBD2441/o6t9SKJ6BQK/YRlq/EQwcg4S6HgvxlwgAu69mv/w3k02JX
 Rd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779973728; x=1780578528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0UrrWt9sqzZeaAKebSEhrBk4jGafuU+EQPGwqeWzgE=;
 b=snMUJeyVRKgLWK8wYg4ws2TGgByFph4TmR26tnkss7aDCOSmFTxsXbDSZNIuwmcN8T
 D6McjZiJz/GItjTUJDB9WjFB/ocg4bsBrDRJu3tGbHi8YPHArU2biLyim1fzVlwHSbrT
 RE/0eSzGC5isjq1jfz/uW+EVUwPo39v9NuBS/dN0gAMuCrOQkxXChNpM/y9gti02EQCA
 chU9X+iSqNazErlp6fSElrmf01fBDR0u6gjegMfTBdCHYBMROlxe/yIHo/U8EskxCrTz
 1avgNdRIHwAYEfw1HKdvRzkGlix6bs6lAfD75X2e3NWLvjLzzSE1NusFd6cX4uK9alrG
 bogw==
X-Gm-Message-State: AOJu0YwgGN/a0XsYEO6QdmkP78INot+BPxc0hJ8epZnKG7mXDcmxD663
 6m4wkw8UkaBkeZAb8t6EJX7Y0TktegSI26lZqrGuaR6iPRMmD4V08SsnvLRfoIYJQGvimPKz+sb
 yLJunXwt/J8IZCOox1XeKVgNrfjROE25mAoDcrlkJxw==
X-Gm-Gg: Acq92OF6IL+O59dnQSbuYRbRH2i7YA967tJJLAA2hW7DakyHGGzfAzX1k13rYMA4MfF
 En1FtkBH9nbKdxazs7oLys+cPhzaaOeCXwgKIYY8nbV9mdO3Vtm/h0lsQ1NSfkCfEMq6A5OnZwR
 Sr6e5SVMvBj8/q9CeFCHOLasZCM57SJiJcLrpRfUhJTEaAiiVzmpZ6qErofTMvOO5iWkojdU9JX
 mqQtfOYUubemPcH1e5nsZHfZp6Njl8kpikz4T0F7YIcNjksDlHrLuwh9CzOGdM7beUn3SY64wqt
 PdMeZDLjoPUEgT6LcU1vmZL1EZRfLu5eFz1M9YxVPWW2mLDkR8OXzVZ7g12hPMovzSbMaPT3qi/
 yJw==
X-Received: by 2002:a53:acd0:0:10b0:659:3b0d:e280 with SMTP id
 956f58d0204a3-65ec963a48amr22003732d50.8.1779973727601; Thu, 28 May 2026
 06:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-9-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-9-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 14:08:33 +0100
X-Gm-Features: AVHnY4If9F4aPPU0qBmFzh52IHloDA0GI5cy3mPKftrifuICBmvNrrT48tbCdPc
Message-ID: <CAFEAcA8NaBF+Nmv0G-7HAqUez1qFE-hn9Uy_Gpz4ho61bnrzqA@mail.gmail.com>
Subject: Re: [PATCH v7 08/16] hw/misc: Add Beckhoff CCAT device
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
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
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>  hw/misc/Kconfig         |   3 +
>  hw/misc/beckhoff_ccat.c | 339 ++++++++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build     |   1 +
>  3 files changed, 343 insertions(+)
>  create mode 100644 hw/misc/beckhoff_ccat.c
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1543ee6653..2217b2005b 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
>  config XLNX_ZYNQ_DDRC
>      bool
>
> +config BECKHOFF_CCAT
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/beckhoff_ccat.c b/hw/misc/beckhoff_ccat.c
> new file mode 100644
> index 0000000000..a29e9f6166
> --- /dev/null
> +++ b/hw/misc/beckhoff_ccat.c
> @@ -0,0 +1,339 @@
> +/*
> + * Beckhoff Communication Controller Emulation
> + *
> + * Copyright (c) Beckhoff Automation GmbH. & Co. KG
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/sysbus.h"
> +#include "qemu/units.h"
> +#include "hw/core/register.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "system/block-backend.h"
> +#include "system/address-spaces.h"
> +#include "system/memory.h"
> +#include "system/dma.h"
> +#include "qemu/error-report.h"
> +#include "block/block.h"
> +#include "block/block_int.h"
> +#include "block/qdict.h"
> +#include "hw/block/block.h"
> +#include "migration/vmstate.h"
> +#include "qemu/bswap.h"
> +
> +#ifndef CCAT_ERR_DEBUG
> +#define CCAT_ERR_DEBUG 0
> +#endif
> +
> +#define TYPE_BECKHOFF_CCAT "beckhoff-ccat"
> +OBJECT_DECLARE_SIMPLE_TYPE(BeckhoffCcat, BECKHOFF_CCAT)
> +
> +#define MAX_NUM_SLOTS 32
> +#define CCAT_FUNCTION_BLOCK_SIZE 16
> +
> +#define CCAT_EEPROM_OFFSET 0x100
> +#define CCAT_DMA_OFFSET 0x8000
> +
> +#define CCAT_MEM_SIZE (64 * KiB)
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

"information block is"

> + * Address and size are therefor replaced by two identifiers.

"therefore"

> + * The Parameter give information about the maximal number of

"parameters give"

> + * function slots and the creation date (in this case 01.01.2001)
> + */
> +#define CCAT_ID_1 0x88a4
> +#define CCAT_ID_2 0x54414343
> +#define CCAT_INFO_BLOCK_PARAMS ((MAX_NUM_SLOTS << 0) | (0x1 << 8) | \
> +                              (0x1 << 16) | (0x1 << 24))
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
> +    uint32_t eeprom_size;
> +} BeckhoffCcat;
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
> +    return ldn_le_p(&s->mem[addr], size);
> +}
> +
> +static void beckhoff_ccat_eeprom_write(void *opaque, hwaddr addr, uint64=
_t val,
> +                              unsigned size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +    uint64_t eeprom_adr;
> +    uint64_t buf;
> +    uint32_t bytes_to_read;
> +
> +    switch (addr) {
> +    case EEPROM_CMD_OFFSET:
> +        eeprom_adr =3D ldl_le_p(&s->mem[EEPROM_ADR_OFFSET]);
> +        eeprom_adr =3D (eeprom_adr * 2) % s->eeprom_size;
> +        if (val & EEPROM_CMD_READ_MASK) {
> +            buf =3D 0;
> +            bytes_to_read =3D 8;
> +            if (eeprom_adr > s->eeprom_size - 8) {
> +                bytes_to_read =3D s->eeprom_size - eeprom_adr;
> +            }
> +            buf =3D ldn_le_p(s->eeprom_storage + eeprom_adr, bytes_to_re=
ad);
> +            stq_le_p(&s->mem[EEPROM_DATA_OFFSET], buf);
> +        } else if (val & EEPROM_CMD_WRITE_MASK) {
> +            buf =3D ldl_le_p(&s->mem[EEPROM_DATA_OFFSET]);
> +            stw_le_p((uint16_t *)(s->eeprom_storage + eeprom_adr), buf);

stw_le_p() takes a void* for the address, so you don't need the cast here.

> +            sync_eeprom(s);
> +        }
> +        break;
> +    default:
> +        stn_le_p(&s->mem[addr], size, val);
> +    }
> +}
> +
> +static uint64_t beckhoff_ccat_dma_read(void *opaque, hwaddr addr, unsign=
ed size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +
> +    switch (addr) {
> +    case DMA_TRANSFER_OFFSET:
> +        if (s->mem[DMA_TRANSFER_OFFSET] & 0x1) {
> +            s->mem[DMA_TRANSFER_OFFSET] =3D 0;

I'm guessing this is some kind of "read-to-clear" behaviour,
but it would be helpful to have a comment, especially as there
is no datasheet that readers can refer to.

> +        }
> +        break;
> +    }
> +    return ldn_le_p(&s->mem[addr], size);
> +}
> +
> +static void beckhoff_ccat_dma_write(void *opaque, hwaddr addr, uint64_t =
val,
> +                           unsigned size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +    dma_addr_t dmaAddr;

QEMU convention for variable names is lowercase, not camelCase.

> +    uint8_t len;
> +    uint8_t *mem_buf;

> +static void beckhoff_ccat_class_init(ObjectClass *klass, const void *dat=
a)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    dc->realize =3D beckhoff_ccat_realize;
> +    device_class_set_legacy_reset(dc, beckhoff_ccat_reset);
> +    dc->vmsd =3D &vmstate_beckhoff_ccat;
> +    device_class_set_props(dc, beckhoff_ccat_properties);
> +}

It would be preferable I think to use the newer reset API
rather than device_class_set_legacy_reset(), since this is
new code. Setting rc->phases.hold is the equivalent in the
new API to the old legacy reset.

thanks
-- PMM

