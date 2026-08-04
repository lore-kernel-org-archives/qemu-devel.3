Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDA4C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrK2u-0000GO-Vw; Tue, 04 Aug 2026 14:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wrK2o-0000FN-2Q
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 14:39:18 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wrK2i-0006FN-D5
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 14:39:15 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ee4399c3abso161344a34.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785868750; x=1786473550; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9S1Or6J5d6w+G6TdMrXTpjfNSzXm21vs6J6CZKNQiMw=;
 b=H6SEKn12cgbdVoloW393JnLOQWWZTmueVlyvaiZoTDBCiS6PNtBCXdahhjyUM/XROb
 3fwFxWKnTuBtH6tnK6G9YiURAkQXJdFNNwrzbq8nrZKqiGqHkul12K8PVk4wZ5mTvBXJ
 OhWv0Os9w6Qkw/TLdM7+s/vORDDCJmZwxy5VRJZAGvGCgA+LXzKBCgC6uHJ2TUDNXVNQ
 jPtwJsezl3l+miQ68X0shUKOg1dXRFMooSrkGrvy6U9k9lmeXWQZJ0soS1XrCNpq4num
 q6qd+2ijkgCzqlg4vzNhskH7t4ZFiXhzOiW5kPaTcVlecHyUFoDCTClmPuEMzr9nbLPX
 xU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785868750; x=1786473550;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9S1Or6J5d6w+G6TdMrXTpjfNSzXm21vs6J6CZKNQiMw=;
 b=Pc28aJpDcIwrgPOXsl/wFRhetScPYdJ+jECnBC8t880YorX3KEmCvXY9m11f80uB35
 CJHbtXLpvGiTlSM3WMlRogIvsNbHW4toXxXVEmDG/2FeFxftA1gQFQUD/oWOg9Z75PqM
 x992bCOdKHPGeuiirVa8GRgBmTihXPWfsT33ei24d77pNhuEG0qu7g6WuluJzAxB3KMY
 rYiMPjHOsmlhlPaIn9flSsdD/x0ftJbQfZliNcnD44gvApw8VLafCcyUTIJW4IuJgHJm
 OVhO9iBAk2HFD9KJdig2Gqazwl+SOEmwJOe0XNJiRXX9JFbNggNjcVs7/LU18yCXdfUU
 ijfA==
X-Gm-Message-State: AOJu0YyPUDsNm+e7bsZkLe1EurHIUDOytYqBdQTUPt1p40R5JQKoncz9
 Y1IGRGXlb+NzSMKHi0HIH4u9kYlChk6iJtbrTGG7PNyxDk1SoXPvE4uTTKUWXi56Aps=
X-Gm-Gg: AR+sD136L3fpJx6vm7DLzncdc/CvjAszJWLnWLeCTv4ET1hJWeYCEPTtuvBVt8qMgXN
 dT1gFY7Ck/D/Yu5SrGew4YXv498NyEfyF1sLtr65b+g5M7sQLKmPrR/CehWaN8MirJST0gcyit4
 VvW2EGa2ArDE+yelimNu4oj9neFOyMxBep+5firl8e0IJmYG54Ia4yVkPVGXvaxREoF9TX1onq1
 s7yYFVyTPXg+BndwoWCDaw6fuuHmxgsuAPgqCvB64ZYemV0DuY3GQfdbz0HLiz1Jz/27HII89Xn
 ydX9UU2lwsnOOtMAX1NbEEDehEIQ/sXU1+NHhW8CTB/9x8WoKbtYo8jOwpQUoSOAh9gdBDLYdie
 VNsoxuMzaqkXbM9LeglpMiVoahCYq7JH5tP0dLpxJ///5aq7H0UCvQSI6SquiiYT9XYBbATtoH8
 Cp2pMLfrTBY1Gp4Z5lh1auCtcNsyrbg+TX9C8RmIk/evoV1M55JxDwCIiK/JeJZqdu4aM6vQQ7X
 mxvt2yzKovL5bo2Mr9+gFaaG75e
X-Received: by 2002:a05:6830:6d25:b0:7e9:e8ae:7049 with SMTP id
 46e09a7af769-7f1e5d2f8b8mr813867a34.7.1785868750170; 
 Tue, 04 Aug 2026 11:39:10 -0700 (PDT)
Received: from toolbox ([12.55.13.134]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df33da38sm1432132a34.7.2026.08.04.11.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 11:39:09 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:38:47 -0500
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/5] hw/ssi: Add Synopsys DesignWare SSI standard PIO
 controller
Message-ID: <itp7xmctqnac4c7kytqyrrs3xbfnbjprem6ezlltc6b5ncdpdn@6pypq3e7lbog>
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
 <20260801192848.30606-2-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801192848.30606-2-flamboyant.h.01@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Aug 02, 2026 at 03:28:44AM +0800, Kangjie Huang wrote:
> Add a reusable SysBus model for the Synopsys DesignWare SSI controller.
> 
> Implement the Standard SPI register subset, configurable chip-select and
> FIFO resources, the four Standard PIO transfer modes, reset handling,
> chip-select GPIOs, and RAZ/WI handling for unsupported enhanced, DMA,
> and XIP registers.
> 
> Add num-cs, fifo-depth, and imr-reset properties. Save only Standard PIO
> state in VMState and reject migration between devices with different
> resource profiles.
> 
> The controller is not instantiated by this patch.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>

<snip>

> ---
>  hw/ssi/Kconfig          |   4 +
>  hw/ssi/dw_ssi.c         | 956 ++++++++++++++++++++++++++++++++++++++++
>  hw/ssi/meson.build      |   1 +
>  include/hw/ssi/dw_ssi.h |  62 +++
>  4 files changed, 1023 insertions(+)
>  create mode 100644 hw/ssi/dw_ssi.c
>  create mode 100644 include/hw/ssi/dw_ssi.h
> 
> diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
> index 1bd56463c1..c48cd2ff6d 100644
> --- a/hw/ssi/Kconfig
> +++ b/hw/ssi/Kconfig
> @@ -6,6 +6,10 @@ config SIFIVE_SPI
>      bool
>      select SSI
>  
> +config DW_SSI
> +    bool
> +    select SSI
> +
>  config SSI
>      bool
>  
> diff --git a/hw/ssi/dw_ssi.c b/hw/ssi/dw_ssi.c
> new file mode 100644
> index 0000000000..f9f0e23730
> --- /dev/null
> +++ b/hw/ssi/dw_ssi.c
> @@ -0,0 +1,956 @@
> +/*
> + * Synopsys DesignWare SSI
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Emulates the DesignWare SSI controller in Standard SPI mode,
> + * covering the PIO/FIFO data path and chip selects.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/irq.h"
> +#include "hw/ssi/dw_ssi.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +/* DWC SSI 1.03 derivative (TRM v0.3.1 section 12.3). */
> +#define DW_SSI_CTRLR0_RESET            0x00004007
> +#define DW_SSI_SR_RESET                0x00000006
> +#define DW_SSI_IDR_RESET               0xa1b2c3d5
> +#define DW_SSI_VERSION                 0x3130332a
> +#define DW_SSI_PIO_TX_BATCH            64
> +
> +enum {
> +    DW_SSI_TMOD_TR,
> +    DW_SSI_TMOD_TO,
> +    DW_SSI_TMOD_RO,
> +    DW_SSI_TMOD_EEPROM_READ,
> +};
> +
> +REG32(CTRLR0, 0x000)
> +    FIELD(CTRLR0, DFS, 0, 5)
> +    FIELD(CTRLR0, FRF, 6, 2)
> +    FIELD(CTRLR0, SCPH, 8, 1)
> +    FIELD(CTRLR0, SCPOL, 9, 1)
> +    FIELD(CTRLR0, TMOD, 10, 2)

There are 2 variants of designware spi, one is called dw-apb-ssi and
another is called dwc-ssi. If you look at their u-boot drivers, you can
see that they differ in the location of the TMOD bits in the CTRLR0.
dw-apb-ssi has it at bits 8 and 9, while dwc-ssi has it at 10/11.
This implementation is for the dwc-ssi version (which is the newer one).

Would it be possible to have the naming be consistent (DWC_SSI,
dwc_ssi.c) everywhere? There are some places throught the series where
the file names/Kconfig symbols/function names are named dw_ssi.

One could argue that this model could retain the generic designware spi
name and support both versions, but I don't think that's necessary.

Regards
Anirudh Srinivasan

