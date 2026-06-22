Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE31CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbmEN-0000yx-P2; Mon, 22 Jun 2026 17:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wbmEM-0000yi-Sm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:30:58 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wbmEK-0002pd-S5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:30:58 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-37cbcf49deaso2414831a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782163855; x=1782768655; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I/6BFAxRNl3Z/vvauvdEXivxOW526FMgoxmCi+Jb6HE=;
 b=LR1vk8PiAmynyBnPGu7baJRM/C7Q3FNpNUF1VcMlyV/tSgIKO5KPO2f0G0RvdzKkZG
 9jh/ZK6SCfvfK2jZ2OfM+d1TTvbrUuiSmzJ7giHs6KzuwnPwK9VwPxVu+ExTDJ3IYpbV
 DKLMWV5vrNs+i9uThmgZFH7cs9iJTTH14kM2eCkDCJNZhWlE+UOkFYRaBkk9705Xngau
 E6sdpXmJHBs9/MH4mYKBPd6WCte/yXVjVNcW5TzrJy8krL3qttoyTZBlTTIlC9BKKy0J
 gaKZkH/Mdx1ADMfc+SSkLKS5NB0vhYqsZGjnyB5q8K5OzABehJwYQPoRajYXnGPPK+C8
 gnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163855; x=1782768655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/6BFAxRNl3Z/vvauvdEXivxOW526FMgoxmCi+Jb6HE=;
 b=aTOYPuqr9zl8p5PyxKgxfbXkEythX6GVlR5Y23bEmuVX4U6a5BUoey4uLuc1JeI9U9
 j2tKqKz7ofAAfTwkc1205AaTugIS1nwqD/yEsUndy/7OdSr2/qFy4c4TssjEUDlVK3tq
 RD+6jUQ0myDXXaKPpl18DMqCWv0mFw/STcaRU9PaUh2QRwSOJLBPG273oPPcJptIsO0p
 My6Jw47bDR1k/q5Dh92fYDpJFTzQb9CDulL9d097nUi+DYzgwAaCFpBBmTvg9m7iBUDv
 4EcmhW1TbsScOoqcsTxc7bEiEe/lEKg1ThdkiaXSQb6GtHFE0gwcL1cO/PglG1WRqfsz
 oJMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqh8SCgAZlAFqswqRFazTVN0Q1vB1VXgwhTX/2SvXwEK1/MlEnEy2OCOYRRIqNF2yQMMnULFTnYQ2KY@nongnu.org
X-Gm-Message-State: AOJu0YxWWCd6oGt/y5OXiqglKtAze1CKefce9svFzmBXwVIyuu54f4I6
 nWxOhIojg229q8AJ2GvSrraYcA6kNNcKRU9pqaG2o8bQwZAMLS7gdD93
X-Gm-Gg: AfdE7ckNA9PLk1+dwGZ5HhXavn6Bi/ObOSKLsEU8VXB51eWbr0aKdcaQva+YtbvKPNL
 1zgkW2HedTBnRKCj5k3g/q9CqbmtkdPXvPgT7BenmUU5ZRGXcWpqxRz/rgzj8zHQvBqXTRiaBOA
 XvxwK4kcogTI6EEI6b1M1qKsNhCMFDNCuByqZ94I+xzORaRc58pT1L8MEjAD6o4YrxgVjk3d9Qp
 4QDn+BfBOHS61Uc56hNnnhilOR8GeHfKWXzwYBvzAU/drlZHcyxC1/rEiezZ0fSP3NDmrzHfEi4
 tTYC7nckryRgu74TaAEL0DTnyIq/G3LZr33HX7xX3zth/Tv206iAqfGNGp1Ucdl+3YeCHGMgZfc
 9uXqrGvktvJT193s6H+MBqUGiK5Q4510BqAO6DNcPLyCkWTz7FpNZK9RfJ7gyu3h1pVI/s965uZ
 Q1CLuGXlogp+iA
X-Received: by 2002:a17:90b:1d52:b0:36a:3176:ad08 with SMTP id
 98e67ed59e1d1-37d15e145b1mr17686559a91.25.1782163854756; 
 Mon, 22 Jun 2026 14:30:54 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4f2d2615sm7999909a91.10.2026.06.22.14.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 14:30:54 -0700 (PDT)
Date: Tue, 23 Jun 2026 05:30:48 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com,
 alistair.francis@wdc.com, farosas@suse.de, lvivier@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 2/5] hw/misc: Add Sophgo CV1800B clock controller
Message-ID: <ajmpiHKdpMaStfRu@google.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-3-visitorckw@gmail.com>
 <ajJBpOYxVfOw5Wr_@ChaodeMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJBpOYxVfOw5Wr_@ChaodeMacBook-Pro.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x102f.google.com
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

On Wed, Jun 17, 2026 at 02:46:38PM +0800, Chao Liu wrote:
> On Tue, Jun 16, 2026 at 07:01:44PM +0800, Kuan-Wei Chiu wrote:
> > Add a stub for the CV1800B clock controller. This is specifically
> > required for the SDHCI controller to function correctly under Linux.
> > 
> > The Linux 'sophgo,cv1800-clk' driver probes this device to determine
> > the clock tree configuration. This implementation sets the bypass
> > registers (CLK_BYP_0 and CLK_BYP_1) to 0xFFFFFFFF during reset,
> > matching the POR default state. This bypasses the PLLs and allows the
> > SDHCI and other peripherals to operate using the 25MHz reference clock.
> > 
> > Without this device, the SD card driver fails to initialize, preventing
> > the system from mounting the root filesystem from the SD card:
> > 
> > [    0.888739] Waiting for root device /dev/mmcblk0...
> > [   10.727739] mmc0: Timeout waiting for hardware cmd interrupt.
> > [   10.728042] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > [   10.728356] mmc0: sdhci: Sys addr:  0x00000002 | Version:  0x00002402
> > [   10.728618] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> > [   10.728919] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> > [   10.729271] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000001
> > [   10.729591] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > [   10.729903] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000000
> > [   10.730223] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> > [   10.730537] mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
> > [   10.730795] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > [   10.731005] mmc0: sdhci: Caps:      0x056900b9 | Caps_1:   0x00000000
> > [   10.731211] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
> > [   10.731415] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> > [   10.731636] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > [   10.731851] mmc0: sdhci: Host ctl2: 0x00000000
> > [   10.732018] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> > [   10.732229] mmc0: sdhci: ============================================
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  hw/misc/Kconfig               |  3 ++
> >  hw/misc/cv1800b_clk.c         | 90 +++++++++++++++++++++++++++++++++++
> >  hw/misc/meson.build           |  1 +
> >  include/hw/misc/cv1800b_clk.h | 24 ++++++++++
> >  4 files changed, 118 insertions(+)
> >  create mode 100644 hw/misc/cv1800b_clk.c
> >  create mode 100644 include/hw/misc/cv1800b_clk.h
> > 
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index 1543ee6653..fd56f0a4c5 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
> >  config XLNX_ZYNQ_DDRC
> >      bool
> >  
> > +config SOPHGO_CV1800B_CLK
> > +    bool
> > +
> >  source macio/Kconfig
> > diff --git a/hw/misc/cv1800b_clk.c b/hw/misc/cv1800b_clk.c
> > new file mode 100644
> > index 0000000000..db7e626158
> > --- /dev/null
> > +++ b/hw/misc/cv1800b_clk.c
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Sophgo CV1800B Clock Controller
> > + *
> > + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "hw/misc/cv1800b_clk.h"
> > +
> > +#define REG_BYTE_WIDTH    (4)
> > +#define REG_CLK_BYP_0     (0x030 / REG_BYTE_WIDTH)
> > +#define REG_CLK_BYP_1     (0x034 / REG_BYTE_WIDTH)
> > +
> > +static uint64_t cv1800b_clk_read(void *opaque, hwaddr addr, unsigned int size)
> > +{
> > +    CV1800BClkState *s = opaque;
> > +    uint32_t val = 0;
> > +
> > +    if ((addr / 4) < ARRAY_SIZE(s->regs)) {
> > +        val = s->regs[addr / 4];
> We can use REG_BYTE_WIDTH to replace the const number 4.
> 
> like:
> 
>     if ((addr / REG_BYTE_WIDTH) < ARRAY_SIZE(s->regs)) {
>         val = s->regs[addr / REG_BYTE_WIDTH];
>     }

Sorry about that, I should have addressed this as well.
I'll change it in the next version.

Regards,
Kuan-Wei

> > +    }
> > +
> > +    return val;
> > +}
> > +
> > +static void cv1800b_clk_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
> > +{
> > +    CV1800BClkState *s = opaque;
> > +
> > +    if ((addr / 4) < ARRAY_SIZE(s->regs)) {
> > +        s->regs[addr / 4] = val;
> This needs to be modified here as well.
> 
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps cv1800b_clk_ops = {
> > +    .read = cv1800b_clk_read,
> > +    .write = cv1800b_clk_write,
> > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > +    .valid = {
> > +        .min_access_size = 4,
> > +        .max_access_size = 4,
> > +    },
> > +};
> > +
> > +static void cv1800b_clk_reset_hold(Object *obj, ResetType type)
> > +{
> > +    CV1800BClkState *s = CV1800B_CLK(obj);
> > +
> > +    memset(s->regs, 0, sizeof(s->regs));
> > +
> > +    /*
> > +     * TODO: Implement proper PLL state machines.
> > +     * For now, use POR default to bypass PLLs and boot via 25MHz XTAL.
> > +     */
> > +    s->regs[REG_CLK_BYP_0] = 0xFFFFFFFF;
> > +    s->regs[REG_CLK_BYP_1] = 0xFFFFFFFF;
> > +}
> > +
> > +static void cv1800b_clk_init(Object *obj)
> > +{
> > +    CV1800BClkState *s = CV1800B_CLK(obj);
> > +
> > +    memory_region_init_io(&s->iomem, obj, &cv1800b_clk_ops, s,
> > +                            TYPE_CV1800B_CLK, 0x1000);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> > +}
> > +
> > +static void cv1800b_clk_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> > +
> > +    rc->phases.hold = cv1800b_clk_reset_hold;
> > +}
> > +
> > +static const TypeInfo cv1800b_clk_info = {
> > +    .name = TYPE_CV1800B_CLK,
> > +    .parent = TYPE_SYS_BUS_DEVICE,
> > +    .instance_size = sizeof(CV1800BClkState),
> > +    .instance_init = cv1800b_clk_init,
> > +    .class_init = cv1800b_clk_class_init,
> > +};
> > +
> > +static void cv1800b_clk_register_types(void)
> > +{
> > +    type_register_static(&cv1800b_clk_info);
> > +}
> > +
> > +type_init(cv1800b_clk_register_types)
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 23265f6035..692f290a87 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
> >  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> > +system_ss.add(when: 'CONFIG_SOPHGO_CV1800B_CLK', if_true: files('cv1800b_clk.c'))
> >  
> >  subdir('macio')
> >  
> > diff --git a/include/hw/misc/cv1800b_clk.h b/include/hw/misc/cv1800b_clk.h
> > new file mode 100644
> > index 0000000000..05c0d1ca1b
> > --- /dev/null
> > +++ b/include/hw/misc/cv1800b_clk.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Sophgo CV1800B Clock Controller
> > + *
> > + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> > + */
> > +
> > +#ifndef HW_MISC_CV1800B_CLK_H
> > +#define HW_MISC_CV1800B_CLK_H
> > +
> > +#include "hw/core/sysbus.h"
> > +#include "qom/object.h"
> > +
> > +#define TYPE_CV1800B_CLK "cv1800b-clk"
> > +OBJECT_DECLARE_SIMPLE_TYPE(CV1800BClkState, CV1800B_CLK)
> > +
> > +struct CV1800BClkState {
> > +    SysBusDevice parent_obj;
> > +
> > +    MemoryRegion iomem;
> > +    uint32_t regs[0x1000 / 4];
> Maybe we can move the struct types to the C source file.
> 
> It's easier to use macros to replace the constant values there.
> 
> Thanks,
> Chao
> > +};
> > +
> > +#endif
> > -- 
> > 2.54.0.1136.gdb2ca164c4-goog
> > 

