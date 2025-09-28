Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA19CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30wA-0002p3-0Z; Sun, 28 Sep 2025 19:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30vy-0002jR-B3
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:36:02 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30vm-0006bH-Qo
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:35:58 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo189139566b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759102541; x=1759707341; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeK6BRgSn8A2iZ5HxE/X3LsVMXWmkjHuQcLSvM2jQ8w=;
 b=GtJbu729MSCd/qcdqAB3Mj1ufZyjxFDdcEDfFciNo1Ny1e9CFf2qW1KrAjNvlzqNe8
 we8W+FlNLM5z164q/p2oDxa6Z/20O3Xl2RIoLNQ7NtMphCbrYoY/4FTOwcdwbZwutSp/
 VvBs2HOC1MyIFp3nVQpXMz2zmPjrWc4WxbkUbyhB1gZaGOyrykHpOwCNQyP17242aZGj
 w6aH+4+9HuBnYOUpBZY5Vroy1ZU86/HUj+slqR91htevRmlmI8/Y2XjfHajvFjJLiWRR
 ENrwelHVi4DbxjXHUA7bkwGQitjJQmM0AdNtLTMq0pR7S+Huw9GbNqUQ3RIlKWTAoude
 hLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102541; x=1759707341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeK6BRgSn8A2iZ5HxE/X3LsVMXWmkjHuQcLSvM2jQ8w=;
 b=aYfvKGFl32irJ0NqCZCU1ieISBUviRnh3PAbyPxDGe5hJfxdCVLoDV6JMBGbNO64/M
 gHrH3bulaB3jEuZH6dprieFiBJOe/j7jJT0YWR2Q1w9q/KwIzAsrvgx44ssXnf6Z+O5h
 Ww65nv+owu2OFlNJdw6XKjU10EshHF8iVnZ7ZAqcgrK55hi5SiAtiLwd1pNdk22UA9O6
 N8t18hS9XzcCOpln3tjbVC/E2yrx1BaJRYMoJqwUS8GQab3bLcVRUoSaztwcrXXB9Qex
 hjWQnThm/WFkwmISfYIZRAlFgP6+vGPFosBwMPQtoOpHEdaRI27fFUeiVTYHqs0Q32s+
 5WmA==
X-Gm-Message-State: AOJu0Yy+UlkXxs2VusVy7G6TQRKn/0uSzjv4GsjzyGeKlaFpvo4g1+Se
 r3vh6rnlGySLviSU6kPn3V/szhxwNhNXyBnxHw8D/lRzQVNRAn5JCiA3eZuzQM0yGTkdtjb+JkT
 Y8YFiD1oN8P3WL7u/OOSd3PR4oyiraVg=
X-Gm-Gg: ASbGnctG4QPcg1mVutznjPsIyQxw0Eklu53w81vz5RJmJIkFh0qCiPcAjKNg8eE+LCW
 8khi88JfAReg6Xsy9rKsqSBydU6qgKvchfX4DwcDd4tovVlmy7BaQuUDTcjZoI1W18gKal9Yqut
 /LtCzP5zqY2H1GjLu8y1T2cG9o1xzm10+rxYr6M2DG2wtAUlznM4/rz3h2N21Q+nzkxaHR/4DCx
 /gBGNz8vB1mWpi4u2VwqDYQOT/aLzoBC67NfDwTCiHI2eHeB/ZjH2x+Kc4/izi2sab3+jYdPAGe
 QQ==
X-Google-Smtp-Source: AGHT+IHFRZFlcP7qS2nBD2sFtPdCbea/x6ipReHPHmjUSZbg1s7v06SYHlBsJk4yt8qaQRk66EyI6O36WWwN0DAPIps=
X-Received: by 2002:a17:907:9445:b0:b28:c29d:7b2d with SMTP id
 a640c23a62f3a-b34ba63990amr1588614066b.39.1759102540518; Sun, 28 Sep 2025
 16:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-4-luc.michel@amd.com>
In-Reply-To: <20250917114450.175892-4-luc.michel@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:35:13 +1000
X-Gm-Features: AS18NWD9qdLZy4WkklxjlBnzs8txlZ5eMUt6ZSyuD6J9W28S7MhGkse-NJSxXi8
Message-ID: <CAKmqyKOZ2BUYgxm+uR28rHnPMY=2msKui6vU2bPf9KyYoWg1fw@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/core/register: remove the calls to
 `register_finalize_block'
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 17, 2025 at 9:49=E2=80=AFPM Luc Michel <luc.michel@amd.com> wro=
te:
>
> This function is now a no-op. The register array is parented to the
> device and get finalized when the device is.
>
> Drop all the calls to `register_finalize_block'. Drop the
> RegisterInfoArray reference when it is not used elsewhere in the device.
>
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/misc/xlnx-versal-crl.h      |  1 -
>  include/hw/misc/xlnx-versal-xramc.h    |  1 -
>  include/hw/misc/xlnx-zynqmp-apu-ctrl.h |  1 -
>  include/hw/misc/xlnx-zynqmp-crf.h      |  1 -
>  include/hw/nvram/xlnx-bbram.h          |  1 -
>  hw/misc/xlnx-versal-crl.c              | 38 +++++++++++---------------
>  hw/misc/xlnx-versal-trng.c             |  1 -
>  hw/misc/xlnx-versal-xramc.c            | 12 ++------
>  hw/misc/xlnx-zynqmp-apu-ctrl.c         | 12 ++------
>  hw/misc/xlnx-zynqmp-crf.c              | 12 ++------
>  hw/nvram/xlnx-bbram.c                  | 13 ++-------
>  hw/nvram/xlnx-versal-efuse-ctrl.c      |  1 -
>  hw/nvram/xlnx-zynqmp-efuse.c           |  8 ------
>  13 files changed, 28 insertions(+), 74 deletions(-)
>
> diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-ver=
sal-crl.h
> index f6b8694ebea..49ed500acde 100644
> --- a/include/hw/misc/xlnx-versal-crl.h
> +++ b/include/hw/misc/xlnx-versal-crl.h
> @@ -531,11 +531,10 @@ REG32(VERSAL2_RST_OCM, 0x3d8)
>  #define VERSAL2_CRL_R_MAX (R_VERSAL2_RST_OCM + 1)
>
>  struct XlnxVersalCRLBase {
>      SysBusDevice parent_obj;
>
> -    RegisterInfoArray *reg_array;
>      uint32_t *regs;
>  };
>
>  struct XlnxVersalCRLBaseClass {
>      SysBusDeviceClass parent_class;
> diff --git a/include/hw/misc/xlnx-versal-xramc.h b/include/hw/misc/xlnx-v=
ersal-xramc.h
> index d3d1862676f..35e4e8b91dd 100644
> --- a/include/hw/misc/xlnx-versal-xramc.h
> +++ b/include/hw/misc/xlnx-versal-xramc.h
> @@ -88,10 +88,9 @@ typedef struct XlnxXramCtrl {
>      struct {
>          uint64_t size;
>          unsigned int encoded_size;
>      } cfg;
>
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[XRAM_CTRL_R_MAX];
>      RegisterInfo regs_info[XRAM_CTRL_R_MAX];
>  } XlnxXramCtrl;
>  #endif
> diff --git a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h b/include/hw/misc/xln=
x-zynqmp-apu-ctrl.h
> index c3bf3c1583b..fbfe34aa7e5 100644
> --- a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
> +++ b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
> @@ -83,11 +83,10 @@ struct XlnxZynqMPAPUCtrl {
>      qemu_irq irq_imr;
>
>      uint8_t cpu_pwrdwn_req;
>      uint8_t cpu_in_wfi;
>
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[APU_R_MAX];
>      RegisterInfo regs_info[APU_R_MAX];
>  };
>
>  #endif
> diff --git a/include/hw/misc/xlnx-zynqmp-crf.h b/include/hw/misc/xlnx-zyn=
qmp-crf.h
> index 02ef0bdeeee..c746ae10397 100644
> --- a/include/hw/misc/xlnx-zynqmp-crf.h
> +++ b/include/hw/misc/xlnx-zynqmp-crf.h
> @@ -201,11 +201,10 @@ REG32(RST_DDR_SS, 0x108)
>  struct XlnxZynqMPCRF {
>      SysBusDevice parent_obj;
>      MemoryRegion iomem;
>      qemu_irq irq_ir;
>
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[CRF_R_MAX];
>      RegisterInfo regs_info[CRF_R_MAX];
>  };
>
>  #endif
> diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.=
h
> index 58acbe9f51b..af90900bfc6 100644
> --- a/include/hw/nvram/xlnx-bbram.h
> +++ b/include/hw/nvram/xlnx-bbram.h
> @@ -45,11 +45,10 @@ struct XlnxBBRam {
>
>      uint32_t crc_zpads;
>      bool bbram8_wo;
>      bool blk_ro;
>
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[RMAX_XLNX_BBRAM];
>      RegisterInfo regs_info[RMAX_XLNX_BBRAM];
>  };
>
>  #endif
> diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
> index 10e6af002ba..5987f32c716 100644
> --- a/hw/misc/xlnx-versal-crl.c
> +++ b/hw/misc/xlnx-versal-crl.c
> @@ -632,21 +632,21 @@ static const MemoryRegionOps crl_ops =3D {
>  static void versal_crl_init(Object *obj)
>  {
>      XlnxVersalCRL *s =3D XLNX_VERSAL_CRL(obj);
>      XlnxVersalCRLBase *xvcb =3D XLNX_VERSAL_CRL_BASE(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>      int i;
>
> -    xvcb->reg_array =3D
> -        register_init_block32(DEVICE(obj), crl_regs_info,
> -                              ARRAY_SIZE(crl_regs_info),
> -                              s->regs_info, s->regs,
> -                              &crl_ops,
> -                              XLNX_VERSAL_CRL_ERR_DEBUG,
> -                              CRL_R_MAX * 4);
> +    reg_array =3D register_init_block32(DEVICE(obj), crl_regs_info,
> +                                      ARRAY_SIZE(crl_regs_info),
> +                                      s->regs_info, s->regs,
> +                                      &crl_ops,
> +                                      XLNX_VERSAL_CRL_ERR_DEBUG,
> +                                      CRL_R_MAX * 4);
>      xvcb->regs =3D s->regs;
> -    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>
>      for (i =3D 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
>          object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
>                                   (Object **)&s->cfg.rpu[i],
> @@ -686,21 +686,22 @@ static void versal_crl_init(Object *obj)
>  static void versal2_crl_init(Object *obj)
>  {
>      XlnxVersal2CRL *s =3D XLNX_VERSAL2_CRL(obj);
>      XlnxVersalCRLBase *xvcb =3D XLNX_VERSAL_CRL_BASE(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>      size_t i;
>
> -    xvcb->reg_array =3D register_init_block32(DEVICE(obj), versal2_crl_r=
egs_info,
> -                                            ARRAY_SIZE(versal2_crl_regs_=
info),
> -                                            s->regs_info, s->regs,
> -                                            &crl_ops,
> -                                            XLNX_VERSAL_CRL_ERR_DEBUG,
> -                                            VERSAL2_CRL_R_MAX * 4);
> +    reg_array =3D register_init_block32(DEVICE(obj), versal2_crl_regs_in=
fo,
> +                                      ARRAY_SIZE(versal2_crl_regs_info),
> +                                      s->regs_info, s->regs,
> +                                      &crl_ops,
> +                                      XLNX_VERSAL_CRL_ERR_DEBUG,
> +                                      VERSAL2_CRL_R_MAX * 4);
>      xvcb->regs =3D s->regs;
>
> -    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>
>      for (i =3D 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
>          object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
>                                   (Object **)&s->cfg.rpu[i],
>                                   qdev_prop_allow_set_link_before_realize=
,
> @@ -748,16 +749,10 @@ static void versal2_crl_init(Object *obj)
>                                   qdev_prop_allow_set_link_before_realize=
,
>                                   OBJ_PROP_LINK_STRONG);
>      }
>  }
>
> -static void crl_finalize(Object *obj)
> -{
> -    XlnxVersalCRLBase *s =3D XLNX_VERSAL_CRL_BASE(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_versal_crl =3D {
>      .name =3D TYPE_XLNX_VERSAL_CRL,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> @@ -802,11 +797,10 @@ static void versal2_crl_class_init(ObjectClass *kla=
ss, const void *data)
>  static const TypeInfo crl_base_info =3D {
>      .name          =3D TYPE_XLNX_VERSAL_CRL_BASE,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(XlnxVersalCRLBase),
>      .class_size    =3D sizeof(XlnxVersalCRLBaseClass),
> -    .instance_finalize =3D crl_finalize,
>      .abstract      =3D true,
>  };
>
>  static const TypeInfo versal_crl_info =3D {
>      .name          =3D TYPE_XLNX_VERSAL_CRL,
> diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> index f34dd3ef352..2b573a45bdb 100644
> --- a/hw/misc/xlnx-versal-trng.c
> +++ b/hw/misc/xlnx-versal-trng.c
> @@ -625,11 +625,10 @@ static void trng_init(Object *obj)
>
>  static void trng_finalize(Object *obj)
>  {
>      XlnxVersalTRng *s =3D XLNX_VERSAL_TRNG(obj);
>
> -    register_finalize_block(s->reg_array);
>      g_rand_free(s->prng);
>      s->prng =3D NULL;
>  }
>
>  static void trng_reset_hold(Object *obj, ResetType type)
> diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
> index 07370b80c0d..d90f3e87c74 100644
> --- a/hw/misc/xlnx-versal-xramc.c
> +++ b/hw/misc/xlnx-versal-xramc.c
> @@ -188,28 +188,23 @@ static void xram_ctrl_realize(DeviceState *dev, Err=
or **errp)
>
>  static void xram_ctrl_init(Object *obj)
>  {
>      XlnxXramCtrl *s =3D XLNX_XRAM_CTRL(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>
> -    s->reg_array =3D
> +    reg_array =3D
>          register_init_block32(DEVICE(obj), xram_ctrl_regs_info,
>                                ARRAY_SIZE(xram_ctrl_regs_info),
>                                s->regs_info, s->regs,
>                                &xram_ctrl_ops,
>                                XLNX_XRAM_CTRL_ERR_DEBUG,
>                                XRAM_CTRL_R_MAX * 4);
> -    sysbus_init_mmio(sbd, &s->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  }
>
> -static void xram_ctrl_finalize(Object *obj)
> -{
> -    XlnxXramCtrl *s =3D XLNX_XRAM_CTRL(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_xram_ctrl =3D {
>      .name =3D TYPE_XLNX_XRAM_CTRL,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> @@ -239,11 +234,10 @@ static const TypeInfo xram_ctrl_info =3D {
>      .name              =3D TYPE_XLNX_XRAM_CTRL,
>      .parent            =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size     =3D sizeof(XlnxXramCtrl),
>      .class_init        =3D xram_ctrl_class_init,
>      .instance_init     =3D xram_ctrl_init,
> -    .instance_finalize =3D xram_ctrl_finalize,
>  };
>
>  static void xram_ctrl_register_types(void)
>  {
>      type_register_static(&xram_ctrl_info);
> diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctr=
l.c
> index e85da32d99c..08777496d56 100644
> --- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
> +++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
> @@ -177,20 +177,21 @@ static void zynqmp_apu_handle_wfi(void *opaque, int=
 irq, int level)
>  }
>
>  static void zynqmp_apu_init(Object *obj)
>  {
>      XlnxZynqMPAPUCtrl *s =3D XLNX_ZYNQMP_APU_CTRL(obj);
> +    RegisterInfoArray *reg_array;
>      int i;
>
> -    s->reg_array =3D
> +    reg_array =3D
>          register_init_block32(DEVICE(obj), zynqmp_apu_regs_info,
>                                ARRAY_SIZE(zynqmp_apu_regs_info),
>                                s->regs_info, s->regs,
>                                &zynqmp_apu_ops,
>                                XILINX_ZYNQMP_APU_ERR_DEBUG,
>                                APU_R_MAX * 4);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->reg_array->mem);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_imr);
>
>      for (i =3D 0; i < APU_MAX_CPU; ++i) {
>          g_autofree gchar *prop_name =3D g_strdup_printf("cpu%d", i);
>          object_property_add_link(obj, prop_name, TYPE_ARM_CPU,
> @@ -206,16 +207,10 @@ static void zynqmp_apu_init(Object *obj)
>                               "CPU_POWER_STATUS", 4);
>      /* wfi_in is used as input from CPUs as wfi request. */
>      qdev_init_gpio_in_named(DEVICE(obj), zynqmp_apu_handle_wfi, "wfi_in"=
, 4);
>  }
>
> -static void zynqmp_apu_finalize(Object *obj)
> -{
> -    XlnxZynqMPAPUCtrl *s =3D XLNX_ZYNQMP_APU_CTRL(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_zynqmp_apu =3D {
>      .name =3D TYPE_XLNX_ZYNQMP_APU_CTRL,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> @@ -239,11 +234,10 @@ static const TypeInfo zynqmp_apu_info =3D {
>      .name              =3D TYPE_XLNX_ZYNQMP_APU_CTRL,
>      .parent            =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size     =3D sizeof(XlnxZynqMPAPUCtrl),
>      .class_init        =3D zynqmp_apu_class_init,
>      .instance_init     =3D zynqmp_apu_init,
> -    .instance_finalize =3D zynqmp_apu_finalize,
>  };
>
>  static void zynqmp_apu_register_types(void)
>  {
>      type_register_static(&zynqmp_apu_info);
> diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
> index cccca0e814e..d9c1bd50e4f 100644
> --- a/hw/misc/xlnx-zynqmp-crf.c
> +++ b/hw/misc/xlnx-zynqmp-crf.c
> @@ -209,28 +209,23 @@ static const MemoryRegionOps crf_ops =3D {
>
>  static void crf_init(Object *obj)
>  {
>      XlnxZynqMPCRF *s =3D XLNX_ZYNQMP_CRF(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>
> -    s->reg_array =3D
> +    reg_array =3D
>          register_init_block32(DEVICE(obj), crf_regs_info,
>                                ARRAY_SIZE(crf_regs_info),
>                                s->regs_info, s->regs,
>                                &crf_ops,
>                                XLNX_ZYNQMP_CRF_ERR_DEBUG,
>                                CRF_R_MAX * 4);
> -    sysbus_init_mmio(sbd, &s->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_ir);
>  }
>
> -static void crf_finalize(Object *obj)
> -{
> -    XlnxZynqMPCRF *s =3D XLNX_ZYNQMP_CRF(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_crf =3D {
>      .name =3D TYPE_XLNX_ZYNQMP_CRF,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> @@ -253,11 +248,10 @@ static const TypeInfo crf_info =3D {
>      .name              =3D TYPE_XLNX_ZYNQMP_CRF,
>      .parent            =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size     =3D sizeof(XlnxZynqMPCRF),
>      .class_init        =3D crf_class_init,
>      .instance_init     =3D crf_init,
> -    .instance_finalize =3D crf_finalize,
>  };
>
>  static void crf_register_types(void)
>  {
>      type_register_static(&crf_info);
> diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
> index 5702bb3f310..22aefbc240d 100644
> --- a/hw/nvram/xlnx-bbram.c
> +++ b/hw/nvram/xlnx-bbram.c
> @@ -454,30 +454,24 @@ static void bbram_ctrl_realize(DeviceState *dev, Er=
ror **errp)
>
>  static void bbram_ctrl_init(Object *obj)
>  {
>      XlnxBBRam *s =3D XLNX_BBRAM(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>
> -    s->reg_array =3D
> +    reg_array =3D
>          register_init_block32(DEVICE(obj), bbram_ctrl_regs_info,
>                                ARRAY_SIZE(bbram_ctrl_regs_info),
>                                s->regs_info, s->regs,
>                                &bbram_ctrl_ops,
>                                XLNX_BBRAM_ERR_DEBUG,
>                                R_MAX * 4);
>
> -    sysbus_init_mmio(sbd, &s->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_bbram);
>  }
>
> -static void bbram_ctrl_finalize(Object *obj)
> -{
> -    XlnxBBRam *s =3D XLNX_BBRAM(obj);
> -
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *na=
me,
>                                   void *opaque, Error **errp)
>  {
>      DeviceState *dev =3D DEVICE(obj);
>
> @@ -540,11 +534,10 @@ static const TypeInfo bbram_ctrl_info =3D {
>      .name          =3D TYPE_XLNX_BBRAM,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(XlnxBBRam),
>      .class_init    =3D bbram_ctrl_class_init,
>      .instance_init =3D bbram_ctrl_init,
> -    .instance_finalize =3D bbram_ctrl_finalize,
>  };
>
>  static void bbram_ctrl_register_types(void)
>  {
>      type_register_static(&bbram_ctrl_info);
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efu=
se-ctrl.c
> index 90962198008..6f17f32a0c3 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -726,11 +726,10 @@ static void efuse_ctrl_init(Object *obj)
>
>  static void efuse_ctrl_finalize(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s =3D XLNX_VERSAL_EFUSE_CTRL(obj);
>
> -    register_finalize_block(s->reg_array);
>      g_free(s->extra_pg0_lock_spec);
>  }
>
>  static const VMStateDescription vmstate_efuse_ctrl =3D {
>      .name =3D TYPE_XLNX_VERSAL_EFUSE_CTRL,
> diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
> index 5a218c32e84..ce35bb0cc1f 100644
> --- a/hw/nvram/xlnx-zynqmp-efuse.c
> +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> @@ -814,17 +814,10 @@ static void zynqmp_efuse_init(Object *obj)
>
>      sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  }
>
> -static void zynqmp_efuse_finalize(Object *obj)
> -{
> -    XlnxZynqMPEFuse *s =3D XLNX_ZYNQMP_EFUSE(obj);
> -
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_efuse =3D {
>      .name =3D TYPE_XLNX_ZYNQMP_EFUSE,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> @@ -855,11 +848,10 @@ static const TypeInfo efuse_info =3D {
>      .name          =3D TYPE_XLNX_ZYNQMP_EFUSE,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(XlnxZynqMPEFuse),
>      .class_init    =3D zynqmp_efuse_class_init,
>      .instance_init =3D zynqmp_efuse_init,
> -    .instance_finalize =3D zynqmp_efuse_finalize,
>  };
>
>  static void efuse_register_types(void)
>  {
>      type_register_static(&efuse_info);
> --
> 2.50.1
>
>

