Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175BECCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 15:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI639-0008Ie-4q; Sat, 17 Oct 2026 11:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI637-0008Gf-7u
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:10:17 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI635-0008H3-BB
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:10:16 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ab395abf79so6494937b3.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 08:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792249814; cv=none;
 d=google.com; s=arc-20260327;
 b=K8yHGnDCiJHWFCXUIuCgTkxP+WpA2/U+g8lV7eIwfmKY82wXHminiM9i3qXVD7pjJ4
 1k9leLMoaPSzSD/aJhcb7xgnlW96vMyUA9uv43ngZ4EiVPOsDqimLoISmLHDJtyQf1ug
 /B/BVl2eF1QJ0a3Mcpa/9OuUq++tvXhJvYwt0ua8A9sjhtUUu9rWpP+lhxQKbcavIRMm
 kdph+Bv/CoN5338+48W3jNfcmBBHbaoqPvHldCvHMZlSxm2TayMgQS8EXcDxf7rrsDvp
 PrCZqCpzOdtBqkSWjuoFZmpmFPLc7VK7c+dYANSAeeiqKU77yKuObs6DTJ15Kw2ENYzj
 gJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pt+SArkaDsI2Ryo6Mc6L8DDlkKjMFRuH8nMTSTCp9zQ=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=Ei+DP3+8ekxapRxBGC+wllZb4sIp8J6B0nz655VjJw8zGpvBFVDRzMJfgD1ViiBYuJ
 wodB+dqo83HlRG5StvFO0RTpqx42kvbIk8mfAY+GSHf4zHLmei4xl3L+Gb8JBwNCii/n
 57YgIODE6cgdzh9YjV+409jRB6WtAQqY43iHhoWfZ/j2wDCXFAD9SeYCclqC/pBUmpaj
 p67bEks1nAvkPWCVKTaX4rslNWbKUZYmw3eBI3AbwRfDWBvz2bsYjlA0nKy7N/ocExZy
 lmRWdmuaLly2IpiHxduQKScXe0n638lF1dV+GnRyw2/TxSU/RoU/I4eLB+3+5wm5Ex0r
 eqcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792249814; x=1792854614; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pt+SArkaDsI2Ryo6Mc6L8DDlkKjMFRuH8nMTSTCp9zQ=;
 b=fJfwWETEn08+4opbJ/qkEi4j4Re0cIKsLILlWmWWKd3DAyH1+R4M7fmGt33V96Yf5E
 T9q9rUcmSPwLsdiAFOHDb3V8k8I87LR4pk1veASdcok9bRSo5JiKlrmZxADb0PCQ5AKC
 RSqw40a/T6AoNQY0imMwa9N+Z+QEtQAgOFxSzdBur+00NFt9hJnaAOhl/XH/oJuW2Y3q
 R5A8++/ZDoxRbRpVuX3ZH6fe5e15zGnx2oRBukau/cG4hEvDw+xWecOixrWnGF1aHTLC
 ug0F8Vdx2nijbimt7mSBdzLp5MkGY0TXjl/+wBS1xtu/xWpnXWm2dhl3bGXBjw1BVCdW
 c+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792249814; x=1792854614;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pt+SArkaDsI2Ryo6Mc6L8DDlkKjMFRuH8nMTSTCp9zQ=;
 b=RHSGilYqH8VsvG6Q3iSBtIHTT2USJTxZuSCaCwgxXIdotTE1AhQ1hyRk75zRvtMGUW
 dvWLDfnXwinknq9BT7UzEG4VQesF3eF2T8tcziEeqOmfVoBAoxJ0EcVBuTEfpfiaSr3x
 Efxjb0Y6zN+kMwjgb5cGrOryiMk6Ne/G3FtZgWXAr0mDVVJYrgfNmBvfhNuDMkRwLkea
 fnc+xwNikPxbWCE6YO0A9WrbWRSPQ0BOrmfACELpwZ7rJQEzUjswep7J1QvbZq+DMdKN
 tDRsEq1FQWifrTv81ZUZHMVJTiRlS3esPzpn0SfFgVZrsZVFxo/AB6QsgS6ZZOI9pdMt
 KCFA==
X-Gm-Message-State: AFq9FYIaQOd9cUaI+6k0Xw9qhrVltNzdEnv/gfwWQGTo+z7v6Ox5qJ/k
 UElBAzudBNBIiCVCxKBvNOw9m2N1hT1oO3wnFWnCIIdLVFCWUP9F3d2l+kOrQvvgT2V+HSUsGOa
 h2R4mR8qYc7B95CUdAjgJV0xw87I3BbQgNxZR+qKOLg==
X-Gm-Gg: AYBFou0Xuk75HhMWt0tv10nsKoMLQPON3DDFmvv+k7oYhV9VVBm91KpS+j6oOIlzei5
 vhS6UTOMSCzeIyCElrvPcE6UtD41iJoqNpMCIKq5ekzP84Qq5P1Z8ClF9m1UjKJSE8Awi1FhiKY
 988336ZWKRap24qrDCLsChlF4aMjGR52yhOetMopWBjPG3KuRaAIvaDawQHYmhsUlMnY59yJYmR
 Kn4O8wgrABea71jW1eQLzPBnqgI4/2L5oCpKj4s07KK23GZc/9yUO2hRv0GthHSwYnH/XCjodZf
 e3XFtjGcSDtgZ0R5XhVIrQGW/KXoepJSRMGjejIU3w/RQmWv3qEy1pipYkXnbOSr24U3Krghn8O
 e8NbxMN9frCRwBGadqSfcmY1l2jJ1f/ODL5ZY9UwNqBg9H91VOA==
X-Received: by 2002:a05:690c:e641:b0:8b0:ac82:afc3 with SMTP id
 00721157ae682-8b0f2170907mr8560797b3.21.1792249813806; Sat, 17 Oct 2026
 08:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-12-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-12-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 16:10:02 +0100
X-Gm-Features: AclHuK97aNdt-24ThOwA2Ew67A1b_KAw2OI5w4LKkbam5ey8FMzWpNJB9fkbP6o
Message-ID: <CAFEAcA8gZXznfO1Y9X+jvRyLekMf2omWRfyyjBewOKyAu5mi9g@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] hw/net/bcm2838_genet: implement GENET MDIO
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the MDIO command register handling used to read/write the
> BCM54213PE PHY's standard MII registers (BMCR, BMSR, LPA, ...) plus
> its vendor "shadow" register blocks reached through the AUX_CTL/
> EXP_SHD indirection scheme, and a simple link-state model (PHY
> starts down, comes up once BMCR is programmed and autonegotiation
> is (re)started).
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> While carrying this forward, fix the autonegotiation-restart handling
> in bcm2838_genet_mdio_cmd(): the guest PHY driver sets BMCR.ANRESTART
> and polls BMCR until it reads back as cleared, but the result of
> FIELD_DP16() (which returns a new value rather than modifying its
> argument) was discarded, so the bit never cleared and the guest
> spun forever at boot. Also refresh the link state once the restart
> has been handled.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  hw/net/bcm2838_genet.c         | 139 ++++++++++++++++++++++++++++++++-
>  include/hw/net/bcm2838_genet.h |   3 +-
>  2 files changed, 139 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
> index f3c5ca26c5..fe2a3cf890 100644
> --- a/hw/net/bcm2838_genet.c
> +++ b/hw/net/bcm2838_genet.c
> @@ -20,6 +20,8 @@
>  #include "hw/net/bcm2838_genet.h"
>  #include "trace.h"
>
> +static void bcm2838_genet_phy_update_link(BCM2838GenetState *s);
> +
>  /* GENET layouts */
>  REG32(GENET_SYS_REV_CTRL,              0)
>  FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
> @@ -216,6 +218,7 @@ FIELD(GENET_PHY_STAT_1000, LOCALRXOK, 13, 1)
>  FIELD(GENET_PHY_STAT_1000, MSRES,     14, 1)
>  FIELD(GENET_PHY_STAT_1000, MSFAIL,    15, 1)
>
> +/* There are two data representations for PHY_AUX_CTRL register */
>  REG16(GENET_PHY_AUX_CTRL_0,              0)
>  FIELD(GENET_PHY_AUX_CTRL_0, REG_ID_MASK, 0, 3)
>  FIELD(GENET_PHY_AUX_CTRL_0, RSVD_3,      3, 1)
> @@ -272,6 +275,134 @@ static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
>      qemu_set_irq(s->irq_prio, level);
>  }
>
> +static void bcm2838_genet_phy_aux_ctl_write(BCM2838GenetState *s,
> +                                            uint16_t value)
> +{
> +    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID);
> +    uint16_t reg_id_mask = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID_MASK);
> +    uint16_t misc_wren = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, MISC_WREN);
> +    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_DATA);
> +    uint16_t reg_data12 = FIELD_EX16(value, GENET_PHY_AUX_CTRL_1, REG_DATA);
> +
> +    uint16_t *phy_aux_ctl_shd_reg_id =
> +        (uint16_t *)&s->phy_aux_ctl_shd_regs + reg_id;
> +    uint16_t *phy_aux_ctl_shd_reg_id_mask =
> +        (uint16_t *)&s->phy_aux_ctl_shd_regs + reg_id_mask;

Here again we are taking a pointer to a struct and assuming we
can also treat it as effectively an array of uint16_t. In this
case BCM2838GenetPhyAuxShdRegs is all uint16_t, but it would be
clearer IMHO to define it as an array of uint16_t rather than
as a struct, as we do with BCM2838GenetPhyExpShdRegs.

> +
> +    if (reg_id_mask == BCM2838_GENET_PHY_AUX_CTL_MISC) {
> +        if (reg_id == BCM2838_GENET_PHY_AUX_CTL_MISC) {
> +            if (misc_wren == 0) {
> +                /* write for subsequent read (8-bit from AUX_CTL_MISC) */
> +                FIELD_DP16(value, GENET_PHY_AUX_CTRL_0, REG_DATA,
> +                          *phy_aux_ctl_shd_reg_id);
> +            } else {
> +                /* write 8 bits to AUX_CTL_MISC */
> +                *phy_aux_ctl_shd_reg_id_mask = reg_data;

8 bits? This pointer is a uint16_t *.

> +            }
> +        } else {
> +            /* write for subsequent read (12-bit) */
> +            FIELD_DP16(value, GENET_PHY_AUX_CTRL_1, REG_DATA,
> +                      *phy_aux_ctl_shd_reg_id);
> +        }
> +    } else {
> +        /* write 12 bits */
> +        *phy_aux_ctl_shd_reg_id_mask = reg_data12;
> +    }
> +
> +    s->phy_regs.aux_ctl = value;
> +}
> +
> +static void bcm2838_genet_phy_shadow_write(BCM2838GenetState *s,
> +                                           uint16_t value)
> +{
> +    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_SHADOW, REG_ID);
> +    uint16_t wr = FIELD_EX16(value, GENET_PHY_SHADOW, WR);
> +    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_SHADOW, REG_DATA);
> +
> +    uint16_t *phy_shd_reg = (uint16_t *)&s->phy_shd_regs + reg_id;
> +
> +    if (wr == 0) {
> +        FIELD_DP16(value, GENET_PHY_SHADOW, REG_DATA, *phy_shd_reg);
> +    } else {
> +        *phy_shd_reg = reg_data;
> +    }
> +
> +    s->phy_regs.shd = value;
> +}
> +
> +static void bcm2838_genet_phy_exp_shadow_write(BCM2838GenetState *s,
> +                                               uint16_t value)
> +{
> +    /*
> +     * TODO Stub implementation without side effect,
> +     * just storing registers values
> +     */
> +    uint16_t reg_id = FIELD_EX16(s->phy_regs.exp_ctrl,
> +                                 GENET_PHY_EXP_SEL, REG_ID);
> +    uint16_t block_id = FIELD_EX16(s->phy_regs.exp_ctrl,
> +                                   GENET_PHY_EXP_SEL, BLOCK_ID);
> +
> +    s->phy_exp_shd_regs.regs[block_id][reg_id] = value;

I think it would be nice to have some (preferably ARRAY_SIZE-based,
but maybe that's tricky for a 2D array) asserts here that the indexes
aren't out of range. In this case they can't be, because the fields
are both 8 bits and the arrays are 256 elements, but an assert()
guards against future danger and saves the reader having to go look up
the details.

thanks
-- PMM

