Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476E1CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOuzf-0000p1-55; Mon, 18 May 2026 06:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wOuzE-0000Vx-K9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:14:17 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wOuzA-0000AG-Oy
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:14:12 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso2327692eec.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779099241; x=1779704041; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b+FqxrOt1EZvur4OACsu4Xxr1aPG8cY1GhxEnFHgDro=;
 b=cDaG9vMpYicPY4TY8xfVCaNp3xW7K9iifntjKdXkIPSx/rzT0uub5hKlF2R1NxEsQ2
 P0TB5TW8AEu+TO7AyaBoPZYqIIW/QlKoAusjdBo2pDacOZSF4QR0+scQ2dYfjeQYCLqi
 9MyZJgnyUZaamRJ/8ea3T09YXpkeS67x9gA5bNJn4LzrmxYiaGCtCKQ/rnKs2gk+qC0O
 FCBY7ckfhtuJBBPT24rDoRPiC+XB+batW4bXmTLTbRuWYYtvRN9d/LMQGtzvL42sJoSL
 YLQWMvgAZ+J0oxNUeZcP7cJxmk77BmyInnilHsCcBx/gXrJjqydtR6ylDNk2kmrpPG8E
 wZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099241; x=1779704041;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+FqxrOt1EZvur4OACsu4Xxr1aPG8cY1GhxEnFHgDro=;
 b=mW+BZuEoXLHvm9vkbEWEP0g2nsEVNqShpfqdysCy0GJO1JemAiFrg8looSQGGcy63L
 rABOHVL0RlqDFn9l7qlz1fHrJf2tx+/Khx9hfmqWUzoyU1V3qzzNkcdwer6qoVZMwn2k
 mPGBXpBdqBqQlh6GuvIJqGv94sG2BnZBTL997FjXIDcn051QN75KYUjGxwYc4u/zfBQA
 IAwBvFxwl/Wl3bf0veEPbftjB4E1/RrMfJpVU/uppcHbkvnBEU4heoEdYx+G75/ceVuS
 cCypQUXTNi5XKCRZGbCvio4ZE7OvgRamdJJqSJM3aoh3geR0BttRVqrjdLYn2Pv756+7
 k5KQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X2v7SWx5bKEZWrTvgwUjhKoOvWYwgd47YoOyR2Kd+6yT8eZtfKxWiQ3rrQpzR1eZA3C/20zCCcQLV@nongnu.org
X-Gm-Message-State: AOJu0Yw6m3dCdXz7kchpqyPepVe06kP1yILnf3ZY1ZUKcJds+ecVef9P
 eXYdfTTaPFCpknAuinH1TV9qAX0RkLa+XF7HhccC7sftn9yC1m5qJeQe
X-Gm-Gg: Acq92OG8GK85Mgo14qf2Legj8zKxH4vbrz1B9c4GVChA1/MVkFG47xvT4XZYXtNivSO
 15cGGL0YoN1kQ/ge8ZCjI/UTjscrc2mLkE+/eN3fFDMM3MPPHAWgkUxNVwGZx2zaw1ZuYg3i6TI
 0VCnBACOaIftY37xOaIMwtFtyk/ysSuKcsXu4FGozCFZ61AwvqJXVWf/GgQ/yb5PBeTlOPTzMod
 Q/RmZTiJCjrNg8kNGzucRi+Rd3ZzrYhy8FYTZgkxbYWxemsgNTu3N0CGrROJauppXl1onglmN7A
 dzrpjjE1+O7HW5zGIjuu2uZBBHl0TtqNx3bgIKYzb6kV2m+Xs9nNrlemSWJmmtExCR8NDsvFiuM
 AjNuwAfnDuUmJvJ1nBNdFN1bXj+OoAExlj9OHLWSNVFt5ra4Zru4RJR30SEZl2t6P5DWBo8Gtt7
 BU1GfHLMp+fUSJ+6yyF2eTgqTCM3V3s3LoRY603FgwC2DZKEzkUCiZhiCb9+XncTGkoQeX6A==
X-Received: by 2002:a05:7300:cc15:b0:2f8:1f2b:bb5d with SMTP id
 5a478bee46e88-3039867e93emr5603197eec.25.1779099241373; 
 Mon, 18 May 2026 03:14:01 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6adsm14864157eec.15.2026.05.18.03.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 03:14:00 -0700 (PDT)
Date: Mon, 18 May 2026 18:13:58 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, farosas@suse.de,
 lvivier@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 3/6] hw/misc: Add Sophgo CV1800B clock controller
Message-ID: <agrjBBqnINoAOCYS@ChaodeMBP.bbrouter>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
 <20260514011528.1263665-4-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514011528.1263665-4-visitorckw@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 14, 2026 at 01:15:25AM +0800, Kuan-Wei Chiu wrote:
> Add a stub for the CV1800B clock controller. This is specifically
> required for the SDHCI controller to function correctly under Linux.
> 
> The Linux 'sophgo,cv1800-clk' driver probes this device to determine
> the clock tree configuration. This implementation sets the bypass
> registers (CLK_BYP_0 and CLK_BYP_1) to 0xFFFFFFFF during reset,
> matching the POR default state. This bypasses the PLLs and allows the
> SDHCI and other peripherals to operate using the 25MHz reference clock.
> 
> Without this device, the SD card driver fails to initialize, preventing
> the system from mounting the root filesystem from the SD card:
> 
> [    0.888739] Waiting for root device /dev/mmcblk0...
> [   10.727739] mmc0: Timeout waiting for hardware cmd interrupt.
> [   10.728042] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   10.728356] mmc0: sdhci: Sys addr:  0x00000002 | Version:  0x00002402
> [   10.728618] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> [   10.728919] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> [   10.729271] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000001
> [   10.729591] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [   10.729903] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000000
> [   10.730223] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> [   10.730537] mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
> [   10.730795] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [   10.731005] mmc0: sdhci: Caps:      0x056900b9 | Caps_1:   0x00000000
> [   10.731211] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
> [   10.731415] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> [   10.731636] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [   10.731851] mmc0: sdhci: Host ctl2: 0x00000000
> [   10.732018] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> [   10.732229] mmc0: sdhci: ============================================
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  hw/misc/Kconfig               |  3 ++
>  hw/misc/cv1800b_clk.c         | 89 +++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build           |  1 +
>  include/hw/misc/cv1800b_clk.h | 24 ++++++++++
>  4 files changed, 117 insertions(+)
>  create mode 100644 hw/misc/cv1800b_clk.c
>  create mode 100644 include/hw/misc/cv1800b_clk.h
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 99bdf09219..42cdf771a4 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -254,4 +254,7 @@ config IOSB
>  config XLNX_VERSAL_TRNG
>      bool
>  
> +config SOPHGO_CV1800B_CLK
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/cv1800b_clk.c b/hw/misc/cv1800b_clk.c
> new file mode 100644
> index 0000000000..738f0910db
> --- /dev/null
> +++ b/hw/misc/cv1800b_clk.c
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Sophgo CV1800B Clock Controller
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/misc/cv1800b_clk.h"
> +
> +#define REG_CLK_BYP_0  (0x030 / 4)
> +#define REG_CLK_BYP_1  (0x034 / 4)
I suggest using the REG_BYTE_WIDTH macro instead of the constant value 4
here and elsewhere.

#define REG_BYTE_WIDTH    (4)
#define REG_CLK_BYP_0     (0x030 / REG_BYTE_WIDTH)
#define REG_CLK_BYP_1     (0x034 / REG_BYTE_WIDTH)

You could also use `RegisterInfo` to define these register operations, so
we don’t have to manually define these helper macros. Since this hardware
is relatively simple, the current implementation is acceptable as well.

Thanks,
Chao
> +
> +static uint64_t cv1800b_clk_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    CV1800BClkState *s = opaque;
> +    uint32_t val = 0;
> +
> +    if ((addr / 4) < ARRAY_SIZE(s->regs)) {
> +        val = s->regs[addr / 4];
> +    }
> +
> +    return val;
> +}
> +
> +static void cv1800b_clk_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
> +{
> +    CV1800BClkState *s = opaque;
> +
> +    if ((addr / 4) < ARRAY_SIZE(s->regs)) {
> +        s->regs[addr / 4] = val;
> +    }
> +}
> +
> +static const MemoryRegionOps cv1800b_clk_ops = {
> +    .read = cv1800b_clk_read,
> +    .write = cv1800b_clk_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void cv1800b_clk_reset_hold(Object *obj, ResetType type)
> +{
> +    CV1800BClkState *s = CV1800B_CLK(obj);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +
> +    /*
> +     * TODO: Implement proper PLL state machines.
> +     * For now, use POR default to bypass PLLs and boot via 25MHz XTAL.
> +     */
> +    s->regs[REG_CLK_BYP_0] = 0xFFFFFFFF;
> +    s->regs[REG_CLK_BYP_1] = 0xFFFFFFFF;
> +}
> +
> +static void cv1800b_clk_init(Object *obj)
> +{
> +    CV1800BClkState *s = CV1800B_CLK(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &cv1800b_clk_ops, s,
> +                            TYPE_CV1800B_CLK, 0x1000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
> +
> +static void cv1800b_clk_class_init(ObjectClass *klass, const void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold = cv1800b_clk_reset_hold;
> +}
> +
> +static const TypeInfo cv1800b_clk_info = {
> +    .name = TYPE_CV1800B_CLK,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(CV1800BClkState),
> +    .instance_init = cv1800b_clk_init,
> +    .class_init = cv1800b_clk_class_init,
> +};
> +
> +static void cv1800b_clk_register_types(void)
> +{
> +    type_register_static(&cv1800b_clk_info);
> +}
> +
> +type_init(cv1800b_clk_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 245ab9b98c..a4c5f90cd8 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -35,6 +35,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> +system_ss.add(when: 'CONFIG_SOPHGO_CV1800B_CLK', if_true: files('cv1800b_clk.c'))
>  
>  subdir('macio')
>  
> diff --git a/include/hw/misc/cv1800b_clk.h b/include/hw/misc/cv1800b_clk.h
> new file mode 100644
> index 0000000000..05c0d1ca1b
> --- /dev/null
> +++ b/include/hw/misc/cv1800b_clk.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Sophgo CV1800B Clock Controller
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef HW_MISC_CV1800B_CLK_H
> +#define HW_MISC_CV1800B_CLK_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_CV1800B_CLK "cv1800b-clk"
> +OBJECT_DECLARE_SIMPLE_TYPE(CV1800BClkState, CV1800B_CLK)
> +
> +struct CV1800BClkState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    uint32_t regs[0x1000 / 4];
> +};
> +
> +#endif
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

