Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB3CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 03:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBLk-0001uL-11; Mon, 18 May 2026 23:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBLf-0001tf-FP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:42:27 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBLc-0007Jb-Ou
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:42:27 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd4f8260e4eso624659966b.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 20:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779162143; cv=none;
 d=google.com; s=arc-20240605;
 b=TDib8CaUQ73WF0rTxDcX33i4+UA0bjvRaxCyfAUk3+2fyQ/dm/QIFAbsG+aeXsK8nr
 OzXBz3OKzEgfALqSW23Fm+b430zRdCPQS7V2yk2EUxDlposR7xNWSOWt0jqkCZ9xoqbg
 jwGL0EVu9GdN2/jaadmoqtehX+46hCfeBQQ4F00DrNsSbv8ttVg77NY82bARW2pAynBx
 pcuX/y4BQ1KyIIrYv9UKaHrzKMcogxQh7cLAVc8TvPXxYN42X9QJsg3ovex2dTXgc3JK
 5xHm28kPOxXXEPJM4KsJjEhwzZkcIPy0ffPBLVvza6237GPE2ajurx/TWyHS10DlNK2b
 INSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wBnnn+8zuaMTYZxWULyxnn7YZIIPbbep8fYTo71qtDw=;
 fh=Givx3PoNS6L0IOAp1VDE/K7/OplMassiODP9NKu1QI4=;
 b=Or0trOVo9PBlKwdbKjpb1MhPfGHrNMKmibzSr/QQ+W5yDS69QdgMu0Cs3Q9ZWHGnN3
 3iVJCeL0Onq5hV+MEV5PJAJcWhY3AkVA9GzOF3Ox794k0obQKZAKvJyDNBABqgzcdGAS
 jjChSb+e4YSEVQjba3FxA1ZwQXAq4lu60C3p+MVH13SRdQkAa1ICQpycWhw5ZeIsThpn
 k5vq9ROadqxlkPupSSEa7Rb0mZMKfkUfgxi134mGf8j+2lXRux7E8DpJ+CjTaHQcaNJO
 L4OV2WbBetL5jE9wOhF0Zp83SWQ79b+ZWkbhVwTzA7UPgfQnLC5QuscBpTfAOnsfTYyD
 N11w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779162143; x=1779766943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBnnn+8zuaMTYZxWULyxnn7YZIIPbbep8fYTo71qtDw=;
 b=o68/7o+V4Aw3SAY9e/YHtKPCzEkHejxxwHVpO+YAPj2IBO71jC7oCLlRkOPFy6F4Ov
 54Q4YvnvmCC+xmweFmHefSuZ4XSzl+tQ79bpVaeVQfbLiR/cvWEiY4gqy7UiDM7fudG8
 k/icqR+geYTE0FESXNjoTkKKCXoYfY/AyJpAQ+w5xdIJAt72Pq4WA7VrgiGB0pB+iTuG
 Q5Kk4jOEC7oOwMg72B+bJVKt+RmqGLJTUpYDKbcCrKzvK5WEQQs8R/qSP7qa7z/J4mfA
 lN0YlOybmG6VIzpWIEOkrGAGIid5T7VPCTJB3/wU696Vi123kNyrl5BTWqJr5B9kjpLM
 sZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779162143; x=1779766943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBnnn+8zuaMTYZxWULyxnn7YZIIPbbep8fYTo71qtDw=;
 b=jhm3QdLbzGaqSzhYX+e8cquJHh0N9XvYS0QFQ4LH3tpHSoL/YlvWEI7sY7byDfz/23
 FdTEdydw4YV5LzMsj+KihDSGThqjSrc5QeAfAIaoIDcRuP1B0fa1AZP5Y/IOUlDEfvcO
 EPOX7GXU6Mqrw1FfOfD2appLQTJh0iJrTeFKTUOoAhLcblLllbZ65xm3D/qZT7M2ITAQ
 wcbooTdsvMC5GfZS10UkiuoTPnDtTEXsyq1B8N0ltrhtGDHTddpC0DqizcEvoQpgH5Se
 63WfjYrj4K7SVCaNgHt2bArXqpbWcAXqi0+XpSpY2tTp1Lq6YRP7R3kazEa81ISeW6Vy
 1wIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3pCAmouf4kl0I98LBBnnRPlnfmMFaxEHAylEiVOEn0dtVZOfxMrKmQMawmbTYXS/S9DpXnfRMKN7M@nongnu.org
X-Gm-Message-State: AOJu0YzRENV5X7QFE141bj7yjjdIcysMurmcRfcIXf0YbGP/n1JniyUR
 sjtAy2dPV3EVkLbxUKs9pCpMDUYVJ7v5XQVrcIp5KdYR4YKSArvYNwXIC79s/Kdrswb+gwPoUNv
 qEqZ47yGKo7uwDmlg5dxscoNq7cT0qew=
X-Gm-Gg: Acq92OGACzZZ8d69Pmfq+Uw+5qm7ltyncDngCiwTnFM8wdt6nLyWD8XUvo9xlOM6pPG
 LX++96n9HbBSNxvxllfStnhdg+CYhs7hglv6PAKUJQn9SSKFlE1OF1ZdMwHIePknbNSCZvM+36U
 O5gdZdXY24D9q8Zbj5SnoHadv5MXBUl0tDSudDEgeXvg+ek1VeoLyLlX4v1P9gmPVLvyc5qBhx9
 FwiGnyyhODE8roJFGQHDueK8JEhy/sx/F++jRI9pVXyi1t+lNFd30Xugn0XbBOqFYg+wBho4r6G
 mvO+6aVvlvqM8INMyw3Vkj7wmrS3sfZH7jRrPA==
X-Received: by 2002:a17:907:c247:b0:bd2:4aa6:1a9d with SMTP id
 a640c23a62f3a-bd5177c7b25mr1031591066b.16.1779162142738; Mon, 18 May 2026
 20:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-reference-overhand-749149e36a88@spud>
In-Reply-To: <20260514-reference-overhand-749149e36a88@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 13:41:55 +1000
X-Gm-Features: AVHnY4KuIGzagN5mjGnSULoDEdjRlScKarrxRwf5k1QdXdwqzJvZX6yUvN5j4Dw
Message-ID: <CAKmqyKMMsWWw8OsdtQ7J7uv5FXrbfsnQB4WRK274uyqxv0U4EQ@mail.gmail.com>
Subject: Re: [PATCH] hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg
 clock dividers
To: Conor Dooley <conor@kernel.org>
Cc: qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

