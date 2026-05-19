Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9469CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 03:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPB74-0000Pw-Nd; Mon, 18 May 2026 23:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPB73-0000Pf-5y
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:27:21 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPB71-0000ap-8f
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:27:20 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd8f9889a8cso148731866b.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 20:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779161235; cv=none;
 d=google.com; s=arc-20240605;
 b=Kw3wKKTB+64QhVCxXk3ukOz7kJMc/fAeGmLmUVVot+rR+Ae8LPxUNlhP56UvHqDgUP
 PRkqKId/URsJfRTdxu5BlfDGbJzTTNOvwzJpeRULOdHqv8vaoFcJPxvdsuIMBxrmXOgB
 zPgduKr850otcYn9X1Ak8VtkyiAbiLXp5esWMOd0ZlUgUEuD1QhJwb/x33FrzFzY3od4
 uJkfoB0Lb68GXEfzOmKUqf8PWgDpQ1hcGK0sJBzqADMGNDP60IL2YthGhwEEwfLTg1/q
 7DdQuxe/ArIvzGwrPV68rEG7dbOQBmWoXdOmUVqUVhP/1xbiYfqJJbEiGEHhZsFzoZQK
 omeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xVq7cONpUOrN02SfD7C02qthWt4NPeu7ujeaCHWiNNI=;
 fh=N1o2WEos/Oe5btMk48i4PHEl/iDr9ES/AKzaG+pDavs=;
 b=ZmxlH9WIcr8rYMOVPmaBijaMCHq7310UJmu14OtNw3qavbVgLyOKCdu8EnhOtsZZ4K
 oWIU1e4xvrqkPcupiQAuT6VNa0rX1C0EVPqS2pjYLTHNL2lp5ER4bPj0jQYJ7kVeiO/w
 65nMxOA8rkGB5Apfo0vmrf7P86xufAzLMK/oOey6AvW9XjlPsbCdCjp4sRbhatZAHW3e
 FDeMisluZM6OE5guXT44h5Z0b10rkTo5LSQt/h/DCpzwUmE1kfyoxDoKDY8SNU8BwfC8
 sKWjYZul9+OZE0+eO6T6WfwMflapurGm1sh8cfcKUF7IppBMb7TnW6A77hbeO7bbFMIi
 +vDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779161235; x=1779766035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVq7cONpUOrN02SfD7C02qthWt4NPeu7ujeaCHWiNNI=;
 b=fLCS/tleFLz8/wxSG/p8T1CK0Q5gYypfWCK6si8jqolPvr7ydcX7uJR82MRmUsJNqd
 +lUdbnDdzXuU5rJ99BkoOrGcZVnqt8d/Xrc2K3Xv7eXejbMT8s7zjmfjFkkhrIRIa6hw
 JBiVboAwCc3GYoFKEbp62Vlfq/kKXx7DgKfTZpCyHnzIy+u3U7yHkG5FhI8nqiLl1fGB
 2clXo/8fyVqOhu/gVtnZW7wbiWD18qn30wjdnLZKZRihY+jEXe+jmGcWetYN+vA/D18n
 EBpsWMIQYCD10eIdDpD14q2Hf1X9frtXejhrk/Z65OQjC68BxGvTSOb8pGIvaI/lUdgF
 YeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779161235; x=1779766035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xVq7cONpUOrN02SfD7C02qthWt4NPeu7ujeaCHWiNNI=;
 b=hCaZN2DbURMd3IlRcAdu2NTbaRE7N3yFfYZgTDDZc9NqNCzi0GbjiBx2OGqbA4rX9p
 nONvppNoJUFneiQDTNagPHwdfWnyYTapqoqDu9s43Gf40Wz0+E88el863gFSX/FnNzNl
 fu1qWMSn3IDjqv6Y+ErdwI8dit/8+s+8i6123/pF0MzrQRBvMdMkSvXJtSyZ5hl2Atwv
 ReaApYfvqqDa49x9fHeWW6mcI/up3UdF3UcHxqYA6qfat63x9CYIVJsMb2RpHd7/Xu2e
 dkrU5Q3T84/Qw7vAN3zhSLvDwK2pI/bKsOnCqUZiJPGkNpyZfAbTVPr260j0kzSajIVy
 xQaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zbx0zbkzQZCC1GW/PVxdcdVbm+oLI4hesQQeEkypItO2dSFWKMi/xvovnZhod5l/vIpce1fbqE7sL@nongnu.org
X-Gm-Message-State: AOJu0YxtRxBx1XIct9GOCcnapb5cQbTqfF61gC3V9pwhiqqmyRjLFGoL
 Rb5LN/Kid4PNN7/6WbTA15THwHkcZ8TJBzBpuquQN3uWJEU2dJJsDSzvPz6A+uMcfQLzOImnmYG
 dB+eTvCFX4n0YrSNwGcdW03ecfzfcxm4=
X-Gm-Gg: Acq92OHzgYuEIn1cU7kBPOLUd2ykxkBOpSarGukUdV6gQbUARr7DeljckPcSMOqT35r
 +5ESlyDG0HzFdEV2Vzj/XvMDrYqtH+2LW6odzHnz9qpfHQmC9AvtGYSVKd6/jZBYjQUMW1tLMMu
 Yj8v0LlxRe3rMiCfD9UtK7PCBUO0AU8WMw62KrVUYZKJ5g11l898/y8cp7kmBtdSL9u2bCZxx/5
 dZLBBC4VCgtGgQRWo1CtekHhprepV94jnGo5B4QrfvL7IhmwyZdquoW+I14HMV+Bv4RO305wd3d
 570g/irez5dE5bhwbMKijize0clPxWy7ZBxPzGac1zJHcSyr
X-Received: by 2002:a17:907:70a:b0:bcd:4858:22cf with SMTP id
 a640c23a62f3a-bd5177b1ec5mr976678366b.7.1779161235240; Mon, 18 May 2026
 20:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-reference-overhand-749149e36a88@spud>
In-Reply-To: <20260514-reference-overhand-749149e36a88@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 13:26:48 +1000
X-Gm-Features: AVHnY4IADXzg-cZck3MV9Cr892W1L0gh18hbT3xx6HhDdbk1FINR0MLmHZdqJVs
Message-ID: <CAKmqyKM741vxCQhkPV8RcmmiwMpxirSB2c-o9LWdHcgtOVxAgw@mail.gmail.com>
Subject: Re: [PATCH] hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg
 clock dividers
To: Conor Dooley <conor@kernel.org>
Cc: qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org
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

On Fri, May 15, 2026 at 1:26=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> From: Guenter Roeck <linux@roeck-us.net>
>
> Minimal clock register configuration required to boot Linux
> without backtraces in the clock code.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> I added two more cases to the switch in mchp_pfsoc_sysreg compared to
> Guenter's patch, cos I still saw 2 backtraces with his patch applied.
>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Guenter Roeck <linux@roeck-us.net>
> CC: Alistair Francis <alistair.francis@wdc.com>
> CC: Sebastian Huber <sebastian.huber@embedded-brains.de>
> CC: qemu-riscv@nongnu.org
> CC: qemu-devel@nongnu.org
> ---
>  hw/misc/mchp_pfsoc_ioscb.c         | 47 +++++++++++++++++++++++++++++-
>  hw/misc/mchp_pfsoc_sysreg.c        | 12 ++++++++
>  include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
>  3 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> index 05538d012a..1267d6ba4a 100644
> --- a/hw/misc/mchp_pfsoc_ioscb.c
> +++ b/hw/misc/mchp_pfsoc_ioscb.c
> @@ -53,6 +53,8 @@
>  #define IOSCB_MAILBOX_BASE          0x07020800
>  #define IOSCB_CFG_BASE              0x07080000
>  #define IOSCB_CCC_BASE              0x08000000
> +#define IOSCB_PLL_NW0_BASE          0x08100000
> +#define IOSCB_PLL_NW1_BASE          0x08200000
>  #define IOSCB_PLL_MSS_BASE          0x0E001000
>  #define IOSCB_CFM_MSS_BASE          0x0E002000
>  #define IOSCB_PLL_DDR_BASE          0x0E010000
> @@ -92,6 +94,16 @@ static const MemoryRegionOps mchp_pfsoc_dummy_ops =3D =
{
>  /* All PLL modules in IOSCB have the same register layout */
>
>  #define PLL_CTRL    0x04
> +#define PLL_REF_FB  0x08
> +#define PLL_DIV_0_1 0x10
> +#define PLL_DIV_2_3 0x14
> +#define PLL_CTRL2   0x18
> +#define PLL_CAL     0x1c
> +#define PLL_PHADJ   0x20
> +#define SSCG_REG_0  0x24
> +#define SSCG_REG_1  0x28
> +#define SSCG_REG_2  0x2c
> +#define SSCG_REG_3  0x30
>
>  static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
>                                      unsigned size)
> @@ -103,6 +115,22 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hw=
addr offset,
>          /* PLL is locked */
>          val =3D BIT(25);
>          break;
> +    case PLL_DIV_0_1:
> +    case PLL_DIV_2_3:
> +        val =3D 0x01000100; /* return valid post divider values */
> +        break;
> +    case PLL_CTRL2:
> +        val =3D 0x00001110;
> +       break;
> +    case PLL_REF_FB:
> +        val =3D 0x00000100; /* RFDIV :=3D 1 */
> +        break;
> +    case SSCG_REG_2:
> +        val =3D 0x00000001; /* INTIN :=3D 1 */
> +       break;
> +    case PLL_PHADJ:
> +        val =3D 0x00000401;
> +       break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
>                        "(size %d, offset 0x%" HWADDR_PRIx ")\n",
> @@ -113,9 +141,18 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hw=
addr offset,
>      return val;
>  }
>
> +static void mchp_pfsoc_pll_write(void *opaque, hwaddr offset,
> +                                 uint64_t value, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> +                       "(size %d, value 0x%" PRIx64
> +                       ", offset 0x%" HWADDR_PRIx ")\n",
> +                       __func__, size, value, offset);
> +}
> +
>  static const MemoryRegionOps mchp_pfsoc_pll_ops =3D {
>      .read =3D mchp_pfsoc_pll_read,
> -    .write =3D mchp_pfsoc_dummy_write,
> +    .write =3D mchp_pfsoc_pll_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
>
> @@ -240,6 +277,14 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *de=
v, Error **errp)
>                            "mchp.pfsoc.ioscb.ccc", IOSCB_CCC_REG_SIZE);
>      memory_region_add_subregion(&s->container, IOSCB_CCC_BASE, &s->ccc);
>
> +    memory_region_init_io(&s->pll_nw_0, OBJECT(s), &mchp_pfsoc_pll_ops, =
s,
> +                          "mchp.pfsoc.ioscb.pll_nw_0", IOSCB_SUBMOD_REG_=
SIZE);
> +    memory_region_add_subregion(&s->container, IOSCB_PLL_NW0_BASE, &s->p=
ll_nw_0);
> +
> +    memory_region_init_io(&s->pll_nw_1, OBJECT(s), &mchp_pfsoc_pll_ops, =
s,
> +                          "mchp.pfsoc.ioscb.pll_nw_1", IOSCB_SUBMOD_REG_=
SIZE);
> +    memory_region_add_subregion(&s->container, IOSCB_PLL_NW1_BASE, &s->p=
ll_nw_1);
> +
>      memory_region_init_io(&s->pll_mss, OBJECT(s), &mchp_pfsoc_pll_ops, s=
,
>                            "mchp.pfsoc.ioscb.pll_mss", IOSCB_SUBMOD_REG_S=
IZE);
>      memory_region_add_subregion(&s->container, IOSCB_PLL_MSS_BASE, &s->p=
ll_mss);
> diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> index f190ecc78e..09389d3b1f 100644
> --- a/hw/misc/mchp_pfsoc_sysreg.c
> +++ b/hw/misc/mchp_pfsoc_sysreg.c
> @@ -29,6 +29,8 @@
>  #include "hw/misc/mchp_pfsoc_sysreg.h"
>  #include "system/runstate.h"
>
> +#define CLOCK_CONFIG_CR 0x8
> +#define RTC_CLOCK_CR    0xc
>  #define MSS_RESET_CR    0x18
>  #define ENVM_CR         0xb8
>  #define MESSAGE_INT     0x118c
> @@ -39,6 +41,16 @@ static uint64_t mchp_pfsoc_sysreg_read(void *opaque, h=
waddr offset,
>      uint32_t val =3D 0;
>
>      switch (offset) {
> +    case CLOCK_CONFIG_CR:
> +        /* Icicle kit reference design cpu/axi/ahb divider setting */
> +        val =3D 0x24;
> +        break;
> +    case RTC_CLOCK_CR:
> +        /* Bit 16 enables the RTC clock, 0x7d is the required divider
> +         * setting for a 125 MHz reference.
> +         */
> +        val =3D BIT(16) | 0x7d;
> +        break;
>      case ENVM_CR:
>          /* Indicate the eNVM is running at the configured divider rate *=
/
>          val =3D BIT(6);
> diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pf=
soc_ioscb.h
> index eaaa2ac5d9..9687ea25b1 100644
> --- a/include/hw/misc/mchp_pfsoc_ioscb.h
> +++ b/include/hw/misc/mchp_pfsoc_ioscb.h
> @@ -35,6 +35,8 @@ typedef struct MchpPfSoCIoscbState {
>      MemoryRegion mailbox;
>      MemoryRegion cfg;
>      MemoryRegion ccc;
> +    MemoryRegion pll_nw_0;
> +    MemoryRegion pll_nw_1;
>      MemoryRegion pll_mss;
>      MemoryRegion cfm_mss;
>      MemoryRegion pll_ddr;
> --
> 2.53.0
>
>

