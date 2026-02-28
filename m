Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F259DFEE4ED
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 15:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwMNc-0004IN-Iv; Sat, 28 Feb 2026 10:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwMNb-0004I2-8a
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:37:19 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwMNZ-0001rj-2n
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:37:19 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1270adc5121so3920173c88.0
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 07:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772293036; x=1772897836; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GzOi2UqeQ2EFQmrzF5XhJc3AWPAjbauXhxTxIBrmKQs=;
 b=U5srvoBWv+bPWozg3MyRSLQcyPiFqzWUmjg4UX8tpdQu0JhgJugXf8LVRGUtr2ggqn
 YtgLoduiVX1InkUtZxJEqrtRRDYgnOwZNHt+jamhIW8Jpdp9N6FBCG3vGgQXwreYkRJN
 cnPJs5zvbqIanXagfI6OIAIdwcMK8T0fJm9g9+CILGjQeJIfisOXA47ZDwNT/Mvj7MhN
 ioCd3s5SES8GuLnvuTxZrq8MN/iwoGD5j+KuqVS1g5+joX2IWNObiUOcreCyqmdut0ku
 P1DgyHKceddCNUVj6xB9sNMS9U6iH7VO+5wb20jZD8RhPyD/TQrnGPH4SYfp7QPRG0Z7
 ZtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772293036; x=1772897836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzOi2UqeQ2EFQmrzF5XhJc3AWPAjbauXhxTxIBrmKQs=;
 b=CfhEyHTdPyogjzHtkEfi6Oz5ls0QksR/ItGqF6L1/+9aCjtEhf8FU7BkIlQY+wpQX6
 7pRl6RmH0T2l41mp3MTLSbatGeWHj0UabJfTMcB6PDdN4niVDu0UBo4yOlXvquC3+jDr
 0s5OXBo7bXEKPowsdSOViPUqH06myF4Ki65J84pAV62gbzt/VGuvRBjvWpixssenYff6
 3CkE8PZg82cKGFXIkmO9DVclZa2weroi3kd6xJcuGn+LNgeWzXHM0BifhDbAmvyMrc16
 lmTTjqp36EPZC0AChqKEBZFQee8GV1HlVqGpFyB/eCfafL5X9Lu3KlDNA6U0toB3flEw
 Ht8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7l0KqiWy+P4P5qsR9c4gXIlvvXpbZptXWzLnxeLV9wTb3hwXuP2R0/ewIJZjLBtWFVYWh7ram8TDz@nongnu.org
X-Gm-Message-State: AOJu0YxiyOnoINlCIk8OL54+p9HRCy5p6i7NoWOmmLU+7JIWo30YlUb9
 rMchvjGqzUW26eh/pIlmk4VDhS05SZXJZ/0u76Wg3GyNIitzPVL3KU7v
X-Gm-Gg: ATEYQzzQfd5Q2loVjYo3SL57zfK4QuMwsSxlYpiAT5c9Am5vfU1g94e6eSUwvWNGE9C
 aVraW31kuDMZVyBm/NQsEp/G4qlPWN9xiQbH3fC7dJvkLt7leLikf8Ln2qzeLYWxy5flTN7OjYu
 Bi9vp3dUF+QVDudldfMDslrMe3y6pcaD25faEvyXcxd8dJgKepmh21BZxAM4fWgXueBKAWLDm5M
 PDbNBgxAYl+hA4bYh1vt9hPtPVcyld1EHlxba3PoTM+VWkHcormEqgpM46GmB8Qiwk3Eu0dTc/x
 vF2QN7XbjTGF/QXXVZh0pyh1vdpYsHg1sne6eVPTiUNbryef4YigG9i3rC/L8p333gZmIXhG4v2
 5KdxPzAKbJLA4Igb2CHiSCwr/Y4GsmobeheOjyfMZNKprH8N506KKAAJUonIucUq5DcNHR5ATIo
 ChEr71bbYQPRWI6//7EBOAoHOmmmTPivXwc8ZhRjcwmO/5+snuENq3VjUjty+REqyXbkh4cxZot
 xLFziGC+QSkfXnoKPCglyLgppm+xYY=
X-Received: by 2002:a05:7022:608b:b0:119:e56b:989d with SMTP id
 a92af1059eb24-1278fbf26a3mr2454684c88.4.1772293035427; 
 Sat, 28 Feb 2026 07:37:15 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899dfc47sm8754795c88.6.2026.02.28.07.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 07:37:14 -0800 (PST)
Date: Sat, 28 Feb 2026 23:37:06 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] hw/intc/imsic: Add in-kernel imsic save and
 restore?? function
Message-ID: <aaMHFg_H11cul3mN@ZEVORN-PC.localdomain>
References: <20260227180104794YvW9Rb2I_kAGzUruZL11Q@zte.com.cn>
 <20260227180937387Xf5-8a9sUNkRZnzDB99ay@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227180937387Xf5-8a9sUNkRZnzDB99ay@zte.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

Hi Xuemei,

On Fri, Feb 27, 2026 at 06:09:37PM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Add save and store funtction if kvm_irqchip_in_kernel() return
Typo in commit message: "save and store funtction" should be "save and
restore function".

> true, it is to get and set IMSIC irqchip state from KVM kernel.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>  hw/intc/riscv_imsic.c         | 171 +++++++++++++++++++++++++++++++---
>  include/hw/intc/riscv_imsic.h |   2 +
>  2 files changed, 159 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 7c9a012033..c0b07de0fc 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -34,6 +34,7 @@
>  #include "system/system.h"
>  #include "system/kvm.h"
>  #include "migration/vmstate.h"
> +#include "kvm/kvm_riscv.h"
> 
>  #define IMSIC_MMIO_PAGE_LE             0x00
>  #define IMSIC_MMIO_PAGE_BE             0x04
> @@ -363,11 +364,12 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>          qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
> 
>          imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
> -        imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
> -        imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
>          imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
>      }
> 
> +    imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
> +    imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
> +
>      memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
>                            imsic, TYPE_RISCV_IMSIC,
>                            IMSIC_MMIO_SIZE(imsic->num_pages));
> @@ -398,23 +400,17 @@ static const Property riscv_imsic_properties[] = {
>      DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
>  };
> 
> -static bool riscv_imsic_state_needed(void *opaque)
> +static bool riscv_imsic_emul_state_needed(void *opaque)
>  {
>      return !kvm_irqchip_in_kernel();
>  }
> 
> -static const VMStateDescription vmstate_riscv_imsic = {
> -    .name = "riscv_imsic",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .needed = riscv_imsic_state_needed,
> +static const VMStateDescription vmstate_riscv_imsic_emul = {
> +    .name = "riscv_imsic_emul",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_imsic_emul_state_needed,
>      .fields = (const VMStateField[]) {
> -            VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
> -                                  num_pages, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
> -                                  num_pages, 0,
> -                                  vmstate_info_uint32, uint32_t),
>              VMSTATE_VARRAY_UINT32(eistate, RISCVIMSICState,
>                                    num_eistate, 0,
>                                    vmstate_info_uint32, uint32_t),
> @@ -422,6 +418,153 @@ static const VMStateDescription vmstate_riscv_imsic = {
>          }
>  };
> 
> +static bool riscv_imsic_in_kernel_state_needed(void *opaque)
> +{
> +    return kvm_irqchip_in_kernel();
> +}
> +
> +static int riscv_imsic_in_kernel_pre_save(void *opaque)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        for (uint32_t i = 0; i < BITS_TO_LONGS(imsic->num_irqs); i++) {
> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIE0 + i * 2);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eie + i * 2 , false);
> +
> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIP0 + i * 2);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eip + i * 2, false);
> +#ifdef CONFIG_32BIT
why use CONFIG_32BIT?

CONFIG_32BIT is a Linux kernel macro -- it is never defined in QEMU.
This means on RV32 builds the odd-indexed EIE/EIP iselect registers
(the upper 32 bits) are silently never saved or restored, causing data
loss during migration.

> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIE0 + i * 2 + 1);
Line exceeds 80 columns. Please fix.

> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eie + i * 2 + 1, false);
> +
> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIP0 + i * 2 + 1);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eip + i * 2 + 1, false);
> +#endif
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_imsic_in_kernel_post_load(void *opaque, int version_id)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        for (uint32_t i = 0; i < BITS_TO_LONGS(imsic->num_irqs); i++) {
> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIE0 + i * 2);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eie + i * 2, true);
> +
> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIP0 + i * 2);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eip + i * 2, true);
> +#ifdef CONFIG_32BIT
Ditto above.

> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIE0 + i * 2 + 1);
Line exceeds 80 columns too. Please fix.

> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eie + i * 2 + 1, true);
> +
> +            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIP0 + i * 2 + 1);
Ditto above.

> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eip + i * 2 + 1, true);
> +#endif
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_riscv_imsic_in_kernel = {
> +    .name = "riscv_imsic_in_kernel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_imsic_in_kernel_state_needed,
> +    .pre_save = riscv_imsic_in_kernel_pre_save,
> +    .post_load = riscv_imsic_in_kernel_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(eie, RISCVIMSICState, 64),
> +        VMSTATE_UINT64_ARRAY(eip, RISCVIMSICState, 64),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_imsic_pre_save(void *opaque)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIDELIVERY);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eidelivery, false);
> +
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EITHRESHOLD);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eithreshold, false);
> +   }
> +
> +    return 0;
> +}
> +
> +static int riscv_imsic_post_load(void *opaque, int version_id)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIDELIVERY);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eidelivery, true);
> +
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EITHRESHOLD);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eithreshold, true);
> +   }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_riscv_imsic = {
> +    .name = "riscv_imsic",
> +    .version_id = 3,
> +    .minimum_version_id = 3,
> +    .pre_save = riscv_imsic_pre_save,
> +    .post_load = riscv_imsic_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
> +                              num_pages, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
> +                              num_pages, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_riscv_imsic_emul,
> +        &vmstate_riscv_imsic_in_kernel,
> +        NULL
> +    }
> +};
> +
>  static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
> index fae999731d..af7a7ba4f1 100644
> --- a/include/hw/intc/riscv_imsic.h
> +++ b/include/hw/intc/riscv_imsic.h
> @@ -54,6 +54,8 @@ struct RISCVIMSICState {
>      uint32_t *eidelivery;
>      uint32_t *eithreshold;
>      uint32_t *eistate;
> +    uint64_t eip[64];
> +    uint64_t eie[64];
why hardcoded 64-element arrays?

Consider using dynamically allocated arrays with VMSTATE_VARRAY, or at
minimum add a comment explaining the sizing rationale.

Others look good to me.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
>      /* config */
>      bool mmode;
> -- 
> 2.27.0
> 

