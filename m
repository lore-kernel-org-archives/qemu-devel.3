Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37686FF8850
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 00:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGQej-0006GH-Kf; Fri, 24 Apr 2026 20:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wGQei-0006Fs-0l
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:13:56 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wGQeg-0003cD-4q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:13:55 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c01854477so370161766b.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 17:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777076032; cv=none;
 d=google.com; s=arc-20240605;
 b=ARhkwXFHhgN79oGKsz4pqS72rtODbOE3zmBGGbwoyoLwus3yuhbKKJdaOOpg4JoiK8
 MotZ7PKGBqCG4fEpMeeIELKymGQIhqndNnvNyBroj0/WF6XJd77YrAgST1H/T4s2stAG
 O0pN7TNADkqaRtElJjzzFbOD45pxO7GtsweCiWfU7ewK340eFGQm5iKZ2JMhJ5VFlOIu
 ChsafkYVJn/dsqc9a2csMtQbQa4m5iI3RP2T1LJ3waABYoJcccKNplPR6pLcVCFS2iKl
 IEPpitichkByzZILEe/dLUXSITu+Spb3pnqb8rcG1jBFCWRq1MpBdxP9Q6nL3JU1GhyF
 LG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m3wMEMa5c5ReChl1GLvrs3VS+RI2A4zI4ZRvGS0z4UY=;
 fh=ZOeTZOxeYk4TO1Nn5fwBbLfAz9daWBz/xhPajQ3q3HM=;
 b=hu70j+1GVv7TPsMJTBp13/GwK9XEdCP7RJKfyyuQD7INrdAEe+SKMDyOrs5b1C8wKc
 1/M2RAQjJEyuNVOy6Lxhs1Xg+u5Z9vT9x3ujrYFgGY3KZvFxSde74Ow5t5et869adsAM
 X+YN6GntQl2z+juEJR2SQXYvzXOPie4ZuTeY5/FENSYBX+y8E5LwX17595dBgivt8X2Y
 NmCdjVcyVsf0A+hMlVRtMP4mFbl56DNNysnEQgTMQOhQG8M/4fTD37EdnJaEs1y7MxVF
 y+ARCcSIpTkKbrR4TmmNG5sRa+jbKcTdJNAT2EVirh5tOqsdRzlozi4+Bbe7EjtTvdf4
 PiZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777076032; x=1777680832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3wMEMa5c5ReChl1GLvrs3VS+RI2A4zI4ZRvGS0z4UY=;
 b=WiBP7/0DfQAhDpjd86lRA3dI/jvhQoHjqSSgSngtY3GQ/44/wDhuF1uvQHNvful9u4
 1BQq4Oi3GZs5tES8rH4TTzRgd7wbkcZilkzSXcDwEtQV9pK0+42yT6qYafUhDfHvEZnW
 2KZLloDuslu3ybzxWqMUH70AdO5KRo2GqHBa2SruexlNmCfbtGG3o+tcd2hwbnCKAniq
 F710Ku3HU2yrhivgjNpwbAgwM8ISkqGtoAV3xB0kGxAwAWipbvXTIsQK7GrDi4eneGP6
 8NtytwAj6p5x9ILIOOmjMnBkdFI5EgPkE00l4aRicxZYcm0KF+9/l+frGoqybAI9Yp+f
 GbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777076032; x=1777680832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m3wMEMa5c5ReChl1GLvrs3VS+RI2A4zI4ZRvGS0z4UY=;
 b=GPrdpUTGCfRgnMeARbpPrQ/j+z6aqiGg/YruOJcL8cGWYBhhGghHqSCDLpC7D+FLgH
 PlfaJSQFEJ/+LJOKPFL5jTsJHF8b7SL3eRYgf6UPS1yEVix8Jg+wzrR5SHVBH1ZZIDxM
 vMFvOmkSjfUled9H22CLZc9ZmLuu61anDevztCiq0qU1IBwl7MAwwwdvgZCiFlAl+wkX
 ePZmwdTS1K/w0MjAGZPgs82W1FZKTigiZ791iCiIe17naz9zoHTZKRhDs9HH62Y8aZoW
 HRp9/Nc9F8+GTSyn0OQsAznCOnLU1c395uIsuu35NUVY06qNhIT8xsnGOA5VtsgqzaBQ
 Sd9g==
X-Gm-Message-State: AOJu0Yw0ZAurzLga1OQ65eQpEJTa925ZBgA3MXGX/y7xITcB4ZVpFmkn
 D1+/lTdYJO8Xs9YyUUHZ9kejC2FAUfxd0khmODp6xGC11RY/FcfgbcNaqfVG/WoydxKdsZD6EKU
 upuGQ/gsNn6yTBFzAitSDA0Uc1jVaTrU=
X-Gm-Gg: AeBDievIAt9lqXZFVGq4fAF2C2WN/NxCLecG5RWC7bGYXkKsyPHSfG8m0PDa2LhmBO5
 sYlMfX//dO1KZWVOSx526OWHr2AfCjiK/TdnWn9u9RvkI0ETlEAsaA03Dgj2NkCSMkSLHdeiV8C
 Nu53xcKB6EkwdjtcFcvDjWDDMuXXJJnvOltNOZh4nnFqaGgAoOA6SUS3bhh0z5Pfo5Hq7g134jI
 3Y+r6Qm8/z8Tm51hdjX/qvXN9PR7krLvfqre8+00HrRG6GQ8txQ0YAU+LvNxn4t6u1PTelLE3Lf
 xY0zElilpCDXplnUk8k=
X-Received: by 2002:a17:906:794a:b0:bae:642a:8712 with SMTP id
 a640c23a62f3a-bae642a8acamr191160166b.26.1777076031668; Fri, 24 Apr 2026
 17:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260424155646.533334-1-luc.michel@amd.com>
In-Reply-To: <20260424155646.533334-1-luc.michel@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 25 Apr 2026 10:13:23 +1000
X-Gm-Features: AQROBzAFJiI4nyra7qV9fRvrp2aQ5CV4VgAc0Nn9rNmV2XrktoEuooJ8d28RF1A
Message-ID: <CAKmqyKMCrzq0nsW1Sp79Cg6NbzKWuU5k++T5Z--Oc0SHqV9CbA@mail.gmail.com>
Subject: Re: [PATCH] hw/core/register: add register_array_get_owner
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Frederic Konrad <frederic.konrad@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
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

On Sat, Apr 25, 2026 at 1:59=E2=80=AFAM Luc Michel <luc.michel@amd.com> wro=
te:
>
> Add the register_array_get_owner function to the register API. This
> function can be used to retrieve the device owning the given
> RegisterInfoArray.
>
> This was previously done inline by some devices.
> 5c6367bc1c8850f74812eeaaf87cff9911be58de modified the way register
> blocks are created and parented to the device. Since this is an
> implementation detail of the register API, it makes sense to have a
> function for this.
>
> Use it in the Versal OSPI and Versal/ZynqMP eFuse models instead of
> tinkering with the API internals.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3421
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3422
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3423
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/core/register.h        | 11 +++++++++++
>  hw/core/register.c                |  5 +++++
>  hw/nvram/xlnx-versal-efuse-ctrl.c |  4 ++--
>  hw/nvram/xlnx-zynqmp-efuse.c      |  4 ++--
>  hw/ssi/xlnx-versal-ospi.c         | 10 +++-------
>  5 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/core/register.h b/include/hw/core/register.h
> index 1f265f4ed71..c6f648fe95e 100644
> --- a/include/hw/core/register.h
> +++ b/include/hw/core/register.h
> @@ -207,6 +207,17 @@ RegisterInfoArray *register_init_block64(DeviceState=
 *owner,
>                                           uint64_t *data,
>                                           const MemoryRegionOps *ops,
>                                           bool debug_enabled,
>                                           uint64_t memory_size);
>
> +/**
> + * register_array_get_owner
> + *
> + * Retrieve the device owning the register info array @reg_array.
> + *
> + * @reg_array The register info array to retrieve the owner from
> + *
> + * Returns: the device owning @reg_array
> + */
> +DeviceState *register_array_get_owner(const RegisterInfoArray *reg_array=
);
> +
>  #endif
> diff --git a/hw/core/register.c b/hw/core/register.c
> index c3f3c936e70..99ca5e17758 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -320,10 +320,15 @@ static void register_array_finalize(Object *obj)
>      RegisterInfoArray *r_array =3D REGISTER_ARRAY(obj);
>
>      g_free(r_array->r);
>  }
>
> +DeviceState *register_array_get_owner(const RegisterInfoArray *reg_array=
)
> +{
> +    return DEVICE(OBJECT(reg_array)->parent);
> +}
> +
>  static const TypeInfo register_array_info =3D {
>      .name  =3D TYPE_REGISTER_ARRAY,
>      .parent =3D TYPE_OBJECT,
>      .instance_size =3D sizeof(RegisterInfoArray),
>      .instance_finalize =3D register_array_finalize,
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efu=
se-ctrl.c
> index 69acdfa3047..f5d5587cb65 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -617,15 +617,15 @@ static const RegisterAccessInfo efuse_ctrl_regs_inf=
o[] =3D {
>  static void efuse_ctrl_reg_write(void *opaque, hwaddr addr,
>                                   uint64_t data, unsigned size)
>  {
>      RegisterInfoArray *reg_array =3D opaque;
>      XlnxVersalEFuseCtrl *s;
> -    Object *dev;
> +    DeviceState *dev;
>
>      assert(reg_array !=3D NULL);
>
> -    dev =3D reg_array->mem.owner;
> +    dev =3D register_array_get_owner(reg_array);
>      assert(dev);
>
>      s =3D XLNX_VERSAL_EFUSE_CTRL(dev);
>
>      if (addr !=3D A_WR_LOCK && s->regs[R_WR_LOCK]) {
> diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
> index e6bc54fc6bd..028120f824d 100644
> --- a/hw/nvram/xlnx-zynqmp-efuse.c
> +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> @@ -722,15 +722,15 @@ static RegisterAccessInfo zynqmp_efuse_regs_info[] =
=3D {
>  static void zynqmp_efuse_reg_write(void *opaque, hwaddr addr,
>                                     uint64_t data, unsigned size)
>  {
>      RegisterInfoArray *reg_array =3D opaque;
>      XlnxZynqMPEFuse *s;
> -    Object *dev;
> +    DeviceState *dev;
>
>      assert(reg_array !=3D NULL);
>
> -    dev =3D reg_array->mem.owner;
> +    dev =3D register_array_get_owner(reg_array);
>      assert(dev);
>
>      s =3D XLNX_ZYNQMP_EFUSE(dev);
>
>      if (addr !=3D A_WR_LOCK && s->regs[R_WR_LOCK]) {
> diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
> index 467f0ce7033..e25e4c26c2e 100644
> --- a/hw/ssi/xlnx-versal-ospi.c
> +++ b/hw/ssi/xlnx-versal-ospi.c
> @@ -1567,19 +1567,15 @@ static RegisterAccessInfo ospi_regs_info[] =3D {
>          .ro =3D 0xffffffff,
>      }
>  };
>
>  /* Return dev-obj from reg-region created by register_init_block32 */
> -static XlnxVersalOspi *xilinx_ospi_of_mr(void *mr_accessor)
> +static XlnxVersalOspi *xilinx_ospi_of_mr(void *opaque)
>  {
> -    RegisterInfoArray *reg_array =3D mr_accessor;
> -    Object *dev;
> +    RegisterInfoArray *reg_array =3D REGISTER_ARRAY(opaque);
>
> -    dev =3D reg_array->mem.owner;
> -    assert(dev);
> -
> -    return XILINX_VERSAL_OSPI(dev);
> +    return XILINX_VERSAL_OSPI(register_array_get_owner(reg_array));
>  }
>
>  static void ospi_write(void *opaque, hwaddr addr, uint64_t value,
>          unsigned int size)
>  {
> --
> 2.53.0
>
>

