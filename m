Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C574E103E2F6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 23:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0TQZ-0001nG-Cy; Wed, 11 Mar 2026 19:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TQX-0001my-U9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:57:21 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TQV-00067U-Si
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:57:21 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b96da7b2e2eso53086366b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 16:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773273438; cv=none;
 d=google.com; s=arc-20240605;
 b=LKxEgbOs6aK8lysdT2Ntt8wcdsM2pEZhPv0B5hMuBBNYa/ukVbsRi8dQvbfrIrKvyo
 PSL7IqmQt70kL2QP2ewl+2/h5sDw8Rm/GmJQ9PQH3uA9gZQQ40LEYWsVtLSmxIph96Uw
 R96QeJ59CVodALbeK5ndka7eQZ/vz27yZj8E+G/1jI5v66LSEfMKkV72nUrgVN1YU5DU
 +K8+PpCMsCnFrTNjcF/ss2HJ32OwCVEl5BlzS8KgtT7wkdYwlFWLM1a7gf1kjCb0VA+b
 shCr16x+1fNo/FMKm+y3FhPOZt/EXS6b7uAFveF8IAVnSFGVHrcBXo+UkuN2PQgObU7f
 mcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vbbaeWquURGd/TCaiqR/uieD2jHy7Ga5Bowl5tyZwZE=;
 fh=SeYVM7lauEYJ77G+L06ENmaw3xQzU5U1pWBGYcf8Luo=;
 b=BXE3AzzYdeU8fz0KDi8d1ycax9zXXboFNb8gQGGUFJEsWVOzjReFnGGSXb2pqfNjsQ
 9OP9+KbCZyq0sGpj/ZdMwc8U+OJRfqLcWDxvhM2H0U8hZOXMuHp/4oFaADUZagj9DrYp
 Gy/dpZGKUy3RjNR3c5dgO3hYr1/DFhQ5QvrQBfYGdbc2NUPaUyiMvHVmTwa1+twHuZQM
 9Sd2su3KYoVE9OP2mFwWvx+DWRJ6Jn1O5zZ91AYxMYOvg+Ug30ucU5lOAzJksqbd/y/u
 JdMr18sHUPjokJWUVtsoifRmOSzjG8X66j2UscFOwzctKNsUWrv2c480Iiy3FkouT1Tn
 /kBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773273438; x=1773878238; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbbaeWquURGd/TCaiqR/uieD2jHy7Ga5Bowl5tyZwZE=;
 b=VFywYzbPOwbK18wAC1OVrL0aIp8ngaLZeb6lFDx5zU9NhlVnpYcWF7ug0KgHLrBuMn
 DDZr+VXmnfSVNXeohOSnTVXIhFGjNgBQ0tJJFQ8UQpGfKiTomCYmDQpfYJoCS0DuQdW5
 tU/1tmmPKYgmJGYxoGjvjPfyXfClJA6MTbrrieikmh+yV90Yr7VyHojPwBUrCREVab9P
 sSAWWN9IbjWmjgiGQt944OWPKKblOyQ21LmQ4RCQBguR0jr8kENzrSjaMPht3Sbquo5G
 1aSUB3fHlkQU9+Sxsnxm2YoGY8SuXn0s41PabEvoGBXE6I8Xuf33xCoNHDXtPhlT2lOX
 EPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773273438; x=1773878238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vbbaeWquURGd/TCaiqR/uieD2jHy7Ga5Bowl5tyZwZE=;
 b=pJpnGZd+tebA0e6RYEDEr/PvYfc3px/6SFWDu7+3pCPvgM7WyD72+JP4juEfould7m
 eEt1hptG+XizhHcNMeErhILCPJL1izoKRfoT3U6ikxubpaXBrJZBE5kD9XOY9PQMVoWV
 auLGS1LzY+ZoRtHa4k8NQ+0qCXsSs//G903yGo8/MFu3aovXIJUjGbxj/3apL4fBnO0+
 K1FVlGini8sbwUoWLUZBBvsc/Zlp5l3mHHYpf0a5N0A5Demi/8tr8WIdJ3sFbCfnArpg
 RrXauLsg7ogeJLJ0Ln6VjVeZ9ZABjkxBAUpTZlupcZWDuVB+ooBconopfjrq1p/rHVB0
 cUXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSMGlRPnqrCeSzCwDD6XAllneE+sT617Bag1BaoBTNwMIFMJb2CYl1EY45CJ93NJxez2J3kDM5lgCe@nongnu.org
X-Gm-Message-State: AOJu0YzrFs4Izcb0B688DWJoFy0UDAp7zOng9uROGs3MR9MRe+VJV9fd
 RMcSI5eYAsM//bZn/WOBbl+zbZVw0Ecqft567LIBb9LuX40UruyPnpKNzzGGb8AJWKMG1H9oAhm
 4G4WNfDQJyYz7GSkC5+857ee+ZmKd0KU=
X-Gm-Gg: ATEYQzw2PHxjymbwET6fvo3Ei7iOIeJ5Kp11qOWU6vJy3jC1cD3423bZ8ZqWW4c5Eex
 MODA/yhqLjOOhF9mlijtubQUNPbK3LSNFDlUSdHUkVVUuGZQ3vbPHjTKfRIUf86jQBs+YuQNJCV
 9zmJgCSWSxlIRfpRuoeun63JBBO6hs9fwTGFhuMTR4pzIRjrju7PzjEirmSbjGKaXm6tVvwPe/z
 QS7OA03KLa4vL2CB9n0fDjj2c2Dbo1sDoaOKX59m2A6QvS/NPV/XTD11pagtL46k5QavaxkmSgJ
 EgAbcIlc9ReSKTdcapYZd84cEbGXDxUfi3cJ7a5BUhxTBom6
X-Received: by 2002:a17:907:3f96:b0:b97:3db:c7de with SMTP id
 a640c23a62f3a-b972e5a5313mr225059366b.45.1773273437325; Wed, 11 Mar 2026
 16:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260305171729291ZzfxmqZ48P2Tbz9TGCtST@zte.com.cn>
 <20260305172600336tzCExHGy8QY2jMA9e7S_g@zte.com.cn>
In-Reply-To: <20260305172600336tzCExHGy8QY2jMA9e7S_g@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 09:56:50 +1000
X-Gm-Features: AaiRm51fA5cjh8A86JjSyUZ0GpFbom6J_qnx_iapeMKS-NjkZCW69PEP7mqBYe8
Message-ID: <CAKmqyKOFm_jEfe=yjkUh=VNQy3wS60qBc6GT59GnSPZpZATBbg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/intc/imsic: Add in-kernel imsic save and
 restore function
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, peterx@redhat.com, 
 farosas@suse.de, chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Thu, Mar 5, 2026 at 7:28=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Add save and restore funtction if kvm_irqchip_in_kernel() return
> true, it is to get and set IMSIC irqchip state from KVM kernel.
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>  hw/intc/riscv_imsic.c         | 171 +++++++++++++++++++++++++++++++---
>  include/hw/intc/riscv_imsic.h |   3 +
>  include/qemu/bitops.h         |   9 +-
>  migration/vmstate-types.c     |   1 -
>  4 files changed, 165 insertions(+), 19 deletions(-)
>
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 7c9a012033..1c9c706b03 100644
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
> @@ -363,11 +364,16 @@ static void riscv_imsic_realize(DeviceState *dev, E=
rror **errp)
>          qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
>
>          imsic->num_eistate =3D imsic->num_pages * imsic->num_irqs;
> -        imsic->eidelivery =3D g_new0(uint32_t, imsic->num_pages);
> -        imsic->eithreshold =3D g_new0(uint32_t, imsic->num_pages);
>          imsic->eistate =3D g_new0(uint32_t, imsic->num_eistate);
> +    } else {
> +        imsic->nr_eix =3D 2 * BITS_TO_U64S(imsic->num_irqs);
> +        imsic->eie =3D g_new0(uint32_t, imsic->nr_eix);
> +        imsic->eip =3D g_new0(uint32_t, imsic->nr_eix);
>      }
>
> +    imsic->eidelivery =3D g_new0(uint32_t, imsic->num_pages);
> +    imsic->eithreshold =3D g_new0(uint32_t, imsic->num_pages);
> +
>      memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
>                            imsic, TYPE_RISCV_IMSIC,
>                            IMSIC_MMIO_SIZE(imsic->num_pages));
> @@ -398,23 +404,17 @@ static const Property riscv_imsic_properties[] =3D =
{
>      DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
>  };
>
> -static bool riscv_imsic_state_needed(void *opaque)
> +static bool riscv_imsic_emul_state_needed(void *opaque)
>  {
>      return !kvm_irqchip_in_kernel();
>  }
>
> -static const VMStateDescription vmstate_riscv_imsic =3D {
> -    .name =3D "riscv_imsic",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> -    .needed =3D riscv_imsic_state_needed,
> +static const VMStateDescription vmstate_riscv_imsic_emul =3D {
> +    .name =3D "riscv_imsic_emul",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D riscv_imsic_emul_state_needed,
>      .fields =3D (const VMStateField[]) {
> -            VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
> -                                  num_pages, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
> -                                  num_pages, 0,
> -                                  vmstate_info_uint32, uint32_t),
>              VMSTATE_VARRAY_UINT32(eistate, RISCVIMSICState,
>                                    num_eistate, 0,
>                                    vmstate_info_uint32, uint32_t),
> @@ -422,6 +422,149 @@ static const VMStateDescription vmstate_riscv_imsic=
 =3D {
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
> +    RISCVIMSICState *imsic =3D opaque;
> +    RISCVCPU *rcpu =3D RISCV_CPU(cpu_by_arch_id(imsic->hartid));
> +    bool is_32bit =3D riscv_cpu_is_32bit(rcpu);
> +    uint32_t inc =3D 2;
> +    uint64_t attr;
> +
> +    if (is_32bit) {
> +        inc =3D 1;
> +    }
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        for (uint32_t i =3D 0; i < imsic->nr_eix; i +=3D inc) {
> +            attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIE0 + i=
);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eie + i, false);
> +
> +            attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIP0 + i=
);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eip + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_imsic_in_kernel_post_load(void *opaque, int version_id)
> +{
> +    RISCVIMSICState *imsic =3D opaque;
> +    RISCVCPU *rcpu =3D RISCV_CPU(cpu_by_arch_id(imsic->hartid));
> +    bool is_32bit =3D riscv_cpu_is_32bit(rcpu);
> +    uint32_t inc =3D 2;
> +    uint64_t attr;
> +
> +    if (is_32bit) {
> +        inc =3D 1;
> +    }
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        for (uint32_t i =3D 0; i < imsic->nr_eix; i +=3D inc) {
> +            attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIE0 + i=
);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eie + i, true);
> +
> +            attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                                  ISELECT_IMSIC_EIP0 + i=
);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eip + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_riscv_imsic_in_kernel =3D {
> +    .name =3D "riscv_imsic_in_kernel",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D riscv_imsic_in_kernel_state_needed,
> +    .pre_save =3D riscv_imsic_in_kernel_pre_save,
> +    .post_load =3D riscv_imsic_in_kernel_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(eie, RISCVIMSICState,
> +                              nr_eix, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(eip, RISCVIMSICState,
> +                              nr_eix, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_imsic_pre_save(void *opaque)
> +{
> +    RISCVIMSICState *imsic =3D opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIDELIVERY);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eidelivery, false);
> +
> +        attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EITHRESHOLD)=
;
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eithreshold, false);
> +   }
> +
> +    return 0;
> +}
> +
> +static int riscv_imsic_post_load(void *opaque, int version_id)
> +{
> +    RISCVIMSICState *imsic =3D opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIDELIVERY);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eidelivery, true);
> +
> +        attr =3D KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EITHRESHOLD)=
;
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eithreshold, true);
> +   }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_riscv_imsic =3D {
> +    .name =3D "riscv_imsic",
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
> +    .pre_save =3D riscv_imsic_pre_save,
> +    .post_load =3D riscv_imsic_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
> +                              num_pages, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
> +                              num_pages, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription * const []) {
> +        &vmstate_riscv_imsic_emul,
> +        &vmstate_riscv_imsic_in_kernel,
> +        NULL
> +    }
> +};
> +
>  static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.=
h
> index fae999731d..2206d82e0c 100644
> --- a/include/hw/intc/riscv_imsic.h
> +++ b/include/hw/intc/riscv_imsic.h
> @@ -54,12 +54,15 @@ struct RISCVIMSICState {
>      uint32_t *eidelivery;
>      uint32_t *eithreshold;
>      uint32_t *eistate;
> +    uint32_t *eip;
> +    uint32_t *eie;
>
>      /* config */
>      bool mmode;
>      uint32_t hartid;
>      uint32_t num_pages;
>      uint32_t num_irqs;
> +    uint32_t nr_eix;
>  };
>
>  DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode=
,
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index c7b838a628..4b9b40f4c0 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -16,10 +16,11 @@
>  #include "host-utils.h"
>  #include "atomic.h"
>
> -#define BITS_PER_BYTE           CHAR_BIT
> -#define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
> -#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(=
long))
> -#define BITS_TO_U32S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(=
uint32_t))
> +#define BITS_PER_BYTE       CHAR_BIT
> +#define BITS_PER_LONG       (sizeof(unsigned long) * BITS_PER_BYTE)
> +#define BITS_TO_LONGS(nr)   DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long=
))
> +#define BITS_TO_U64S(nr)    DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint=
64_t))
> +#define BITS_TO_U32S(nr)    DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint=
32_t))

This shouldn't be changed

Alistair

>
>  #define BIT(nr)                 (1UL << (nr))
>  #define BIT_ULL(nr)             (1ULL << (nr))
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 89cb211472..368a2922aa 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -599,7 +599,6 @@ const VMStateInfo vmstate_info_tmp =3D {
>   * is an array of 'unsigned long', which may be either 32 or 64 bits.
>   */
>  /* This is the number of 64 bit words sent over the wire */
> -#define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
>  static int get_bitmap(QEMUFile *f, void *pv, size_t size,
>                        const VMStateField *field)
>  {
> --
> 2.27.0
>

