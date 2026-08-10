Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4226C5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVmy-0003GG-Fi; Mon, 10 Aug 2026 15:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wtVmx-0003Fy-0Q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:35:59 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wtVms-00010t-W8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:35:58 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66892c81725so3066332d50.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 12:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786390553; cv=none;
 d=google.com; s=arc-20260327;
 b=GAlKnrep+wSy4h71PBVtIbN3BTAj528Sa7aCQxbX0J4iOp+iQ5BF64Tr+a9gP4laQo
 eBG8/VyQxwdliKhJZ+yk84nJLQYgB/n8GVd9ny4NdIo632JNDrQ4flsvEvLmj9xfVtYz
 mH+3QJN0lMSkPVmLd3HZmbpW+GsggFKmv/9tU6xt9VwnFup0yA1b4e8HKFR68XueoKyk
 RzhxAdosZq61XVrc/bki634gRXABrADk2BpCNkk2wXYe/OKcNs/J4HNF5uJYs4nHcGMw
 3xFfBGRrA0j9cLmdjq+FrLpb6c6n8r4HhNZXFWy0+CvJddeks+r/OiTzLStXgLE+4glV
 Mwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lLwU4/8fDq6/cC71FNcMMHCInjN9nX76P4ZwdLe9KLc=;
 fh=9jSbO5mv5oQl/rh5OVrFoyeXofyJyoVY7s6pOP5R3PA=;
 b=aR/tNVl27+qpgJGLhFAFuCXzyKBy5afhUvz5QrRmbSC7kHuHKd1wtCd501faBrosIT
 TvDMcESL4chxGF0MFMdUiAo8Xxz3fOxe9BqgqJvp4s2zJ2ZNLRmKSovsciXB9XETm//T
 zdMhlGZIG/cPS4CkLzkacledlknfNPO9Ermja8NB8gbyRbzb3WLhmYOKZSDWWPxVVa61
 fUrkHHDebtMb32UzBSJZ34wJ0MRrTrANl71X1LLUHC75TyC1qSWkcJBbmj2EHH0KeGLh
 Lg9XsxEjU8o+FjXb8yWVR1ZNj9Z35zmG/MeYIKeeOdjgsCmUF4Fz4Fw3568Zuj2mbZl2
 g9FA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1786390553; x=1786995353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lLwU4/8fDq6/cC71FNcMMHCInjN9nX76P4ZwdLe9KLc=;
 b=FyGiHIuGVQddkNVsl69X9XXae2dtrydv68D55smFolR8djIwQJLpdncfqD6U5otgf/
 Gk+1OAMKMtjFNhoveaGYnVAh3Flk2xPdSwHylQTrLDHxkuweeyGEIJCGbLPiJYaTZ7jn
 xW/4Uquiz7Y32HaCdgvMcarOqpTm+V0wCrhAALpDzU6Wuhvplu4hfpfy3HKHxd75H8QC
 vGBpwHuQ7uZ5p9OX6GXp7RtcY3G5UmW8Y0VB6tMqK0n/LZHrSYZDTnZBtFSGxrfeVVqY
 i3xBdGa3qRni3UGHFvWmzE7q2yfBOuCI8CMccZ2Z5qNlkiaVZBnylWOp6gy/v0lGdJrU
 mjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786390553; x=1786995353;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lLwU4/8fDq6/cC71FNcMMHCInjN9nX76P4ZwdLe9KLc=;
 b=BIKkfcM78+oi1RYpLSNXb2qQEXfRBi0Ghm2pSjsWLw/dad6lPZ51ohb0rXaqMm9V6h
 +FAuEi1EW62pd/vx1GS6YZcxcadqzyhj7bsI6yX74tXwtfjRFk49NcdMLgmzgb/uORsL
 J/6YYW8VT9A++pU8ihQRdroyNAlJ82VPSgHmDbwLHrpWkaRuooxm/GgkMlJZgSHZ7+sq
 XfihjG0CZuOYtpKcPQF59qlNthbi7taOtZE6Mi4aaDJnom3+mGXd8DKvh7zIsHESPP0a
 BpY7T6CYPI7UYnPUYmh0E4o4gw5DhpeJ06pBdzK8uqZoSTqfM5ilioR5iCRqY0ervzow
 0+Zw==
X-Gm-Message-State: AOJu0Yw3l/GyMlx/G3vRMgzPKUVVoVnxApYmFdCvoAAGdktChn+cooHu
 RdGx+TdxzgaUmL0trWrtGpX/KwiGEGtJSN1wZcgpb202KjWmdUQhkc/fX/Z0UpR6iR0E0UalRg7
 7K2kkU8JG9Ug2Y9AE2xc9QOneyLMvw0w8SdUH0DcNhA==
X-Gm-Gg: AR+sD13OCiiSQswh6SwsV93Lb9yzecn/ORGT9QH9V+xa2mqeEuhz0H6EUFVOmSb8ciU
 gsuKduilfNIEtI2IBuM0pnbAj31EvdVV/CKOUwQ1EF2FiRVuy54DPKDQTVI24qgF61Haj4P0RPG
 OLkCvI24OEOTCQPaXr4Zd2tVeIWFhPSgQimV9RNxos2NpLiZmHkgHkDZ+/xnKM3xY46tCvtJub1
 EULQYoW3H+t3AFKc/Uc2YuvuX55tJMvD/gdmrGiOlHbczOqN60vrDz1HVluafmwJ/JPvTVdLDEg
 41cJiPizYCMZwtNCiQM2gK5S9RLwBy1/MdK49yBibjNpxMiu5FLYQfwRcjXLQy+J6fNqn54izrQ
 =
X-Received: by 2002:a05:690e:1913:b0:668:8b5b:75ab with SMTP id
 956f58d0204a3-6699ac6d3d6mr25662978d50.49.1786390553255; Mon, 10 Aug 2026
 12:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
 <20260729-atlantis_prcm-v1-1-502882933e51@oss.tenstorrent.com>
 <6e689892-7a9a-473e-aaa7-6d50c5c0c969@oss.qualcomm.com>
In-Reply-To: <6e689892-7a9a-473e-aaa7-6d50c5c0c969@oss.qualcomm.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 10 Aug 2026 14:35:41 -0500
X-Gm-Features: AUfX_mzap9GS-uDr7b6OjowegZlqVfV3SIZGjuwuHq2_pwOKoSRIlXVCKZJMYU0
Message-ID: <CAEev2e94WKz0=jG4u+L77_q2ES+Cie_kOTc0iqB00hzgfi6A0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Fri, Aug 7, 2026 at 8:38=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hello,
>
> On 7/29/2026 12:21 PM, Anirudh Srinivasan wrote:
> > This device present in Tenstorrent Atlantis has registers that control
> > clocks, reset and other misc functionality in the SoC. This commit adds
> > models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
> >
> > Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >   MAINTAINERS                        |   2 +
> >   hw/misc/meson.build                |   1 +
> >   hw/misc/trace-events               |   4 +
> >   hw/misc/tt_atlantis_prcm.c         | 436 ++++++++++++++++++++++++++++=
+++++++++
> >   include/hw/misc/tt_atlantis_prcm.h |  51 +++++
> >   5 files changed, 494 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e25df9493c..49c1a5ad76 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1802,7 +1802,9 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
> >   L: qemu-riscv@nongnu.org
> >   S: Supported
> >   F: docs/system/riscv/tt_*.rst
> > +F: hw/misc/tt_*.c
> >   F: hw/riscv/tt_*.c
> > +F: include/hw/misc/tt_*.h
> >   F: include/hw/riscv/tt_*.h
> >   F: tests/functional/riscv64/test_tt_*.py
> >

> > +}
> > +
> > +static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
> > +                                            uint64_t data, unsigned si=
ze) {
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    trace_tt_atlantis_prcm_write(c->domain, offset, data);
> > +
> > +    if (offset >=3D c->regs_size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_P=
RIx "\n",
> > +                      __func__, offset);
> > +        return;
> > +    }
>
> I'm a bit confused here: in tt_atlantis_prcm_read() we're doing a qemu_lo=
g_mask() and
> return, and then do a "trace_tt_atlantis...".  So in an error case you'll=
 have just
> the qemu_log_mask().   Here we're doing a trace at the start of prcm_writ=
e() and then
> a qemu_log_mask() if something wrong happens.
>
> There's no rule on how you use trace so there's nothing wrong with both a=
pproaches but
> would be nice if we could stick with one single approach: either do trace=
_tt_... during
> function start or in function success.  From what I can tell the most com=
mon pattern is
> the one used in prcm_read(), i.e. qemu_log_mask on errors and trace_ on s=
uccess.

I think I tried placing the trace for the write at the top of the
function and missed this bit. Will do it this way instead.

>
> > +
> > +    switch (TO_REG(offset)) {
> > +    default:
> > +        s->regs[TO_REG(offset)] =3D data;
> > +        break;
> > +    }
>
> This switch is doing nothing.  Just do s->regs[TO_REG(offset)] =3D data d=
irectly.

Yes, I think I left this in case I was expecting to handle writes to
specific registers here, but that doesn't seem to be needed. WIll
remove this.

>
>
> > +}
> > +
> > +static void tt_atlantis_prcm_rcpu_write(void *opaque, hwaddr offset,
> > +                                            uint64_t data, unsigned si=
ze) {
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> > +
> > +    tt_atlantis_prcm_write(opaque, offset, data, size);
> > +
> > +    bool pll_en_written =3D false;
> > +    uint32_t pll_reg_offset;
> > +    switch TO_REG(offset)
> > +    {
> > +        case RCPU_PLL_RCPU_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL_RCPU_CFG;
> > +            break;
> > +        case RCPU_PLL_NOCC_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL_NOCC_CFG;
> > +            break;
> > +        case RCPU_PLL_HSIO_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL_HSIO_CFG;
> > +            break;
> > +        case RCPU_PLL_PCIE_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL_PCIE_CFG;
> > +            break;
> > +        case RCPU_PLL_MM_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL_MM_CFG;
> > +            break;
> > +        case RCPU_PLL1_MM_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL1_MM_CFG;
> > +            break;
> > +        case RCPU_PLL_I2S_EN:
> > +            pll_en_written =3D true;
> > +            pll_reg_offset =3D RCPU_PLL_I2S_CFG;
> > +            break;
> > +    }
> > +    if (pll_en_written) {
> > +        if (data & PLL_EN) {
> > +            s->regs[pll_reg_offset] |=3D BIT(PLL_LOCK_BIT);
> > +        } else {
> > +            s->regs[pll_reg_offset] &=3D ~BIT(PLL_LOCK_BIT);
> > +        }
> > +    }
>
> Seems like you're using pll_en_written as a flag to detect if we have a m=
atch
> in the 'switch' and nothing else, since pll_en_written is always being se=
t to
> 'true'.  And if there's no match in the switch() the function just return=
s.
>
> I suggest removing pll_en_written and doing a return in a default label.
> Something like this:
>
> > +    uint32_t pll_reg_offset;
> > +    switch TO_REG(offset) {
> > +    case RCPU_PLL_RCPU_EN:
> > +        pll_reg_offset =3D RCPU_PLL_RCPU_CFG;
> > +        break;
> > +    case RCPU_PLL_NOCC_EN:
> > +        pll_reg_offset =3D RCPU_PLL_NOCC_CFG;
> > +        break;
> > +    case RCPU_PLL_HSIO_EN:
> > +        pll_reg_offset =3D RCPU_PLL_HSIO_CFG;
> > +        break;
> > +    case RCPU_PLL_PCIE_EN:
> > +        pll_reg_offset =3D RCPU_PLL_PCIE_CFG;
> > +        break;
> > +    case RCPU_PLL_MM_EN:
> > +        pll_reg_offset =3D RCPU_PLL_MM_CFG;
> > +        break;
> > +    case RCPU_PLL1_MM_EN:
> > +        pll_reg_offset =3D RCPU_PLL1_MM_CFG;
> > +        break;
> > +   case RCPU_PLL_I2S_EN:
> > +        pll_reg_offset =3D RCPU_PLL_I2S_CFG;
> > +        break;
>        default:
>             return;
> > +   }
>
> > +  if (data & PLL_EN) {
> > +      s->regs[pll_reg_offset] |=3D BIT(PLL_LOCK_BIT);
> > +  } else {
> > +     s->regs[pll_reg_offset] &=3D ~BIT(PLL_LOCK_BIT);
> > +  }

Yes, this looks simpler. Will change it to this.

>
> > +}
> > +
> > +static const MemoryRegionOps tt_atlantis_prcm_ops =3D {
> > +    .read =3D tt_atlantis_prcm_read,
> > +    .write =3D tt_atlantis_prcm_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid.min_access_size =3D 4,
> > +    .valid.max_access_size =3D 4,
> > +};
> > +
> > +static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops =3D {
> > +    .read =3D tt_atlantis_prcm_read,
> > +    .write =3D tt_atlantis_prcm_rcpu_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid.min_access_size =3D 4,
> > +    .valid.max_access_size =3D 4,
> > +};
> > +
> > +static void tt_atlantis_prcm_realize(DeviceState *dev, Error **errp)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    if (c->domain >=3D PRCM_DOMAIN_COUNT) {
> > +        error_setg(errp,
> > +                   "domain %d is larger than max number of possible do=
mains %d",
> > +                   c->domain, PRCM_DOMAIN_COUNT);
> > +        return;
> > +    }
> > +    s->regs =3D g_new0(uint32_t, TO_REG(c->regs_size));
> > +
> > +    memory_region_init_io(&s->mmio, OBJECT(s), c->ops, s,
> > +                          TYPE_TT_ATLANTIS_PRCM, c->regs_size);
> > +    sysbus_init_mmio(sbd, &s->mmio);
> > +}
> > +
> > +static void tt_atlantis_prcm_reset(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS(s);
> > +
> > +    memset(s->regs, 0, c->regs_size);
> > +}
> > +
> > +static void tt_atlantis_prcm_rcpu_reset(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    tt_atlantis_prcm_reset(dev);
> > +
> > +    s->regs[RCPU_PLL_RCPU_CFG] =3D PLL_RESET_VAL(1, 0, 4, 0, 100, 1);
> > +    s->regs[RCPU_PLL_NOCC_CFG] =3D PLL_RESET_VAL(0, 2, 2, 2, 267, 1);
> > +    s->regs[RCPU_NOCC_CLK_CFG] =3D (0x25f31 << 1) | BIT(0);
> > +    s->regs[RCPU_RCPU_DIV_CFG] =3D (0xb8c2 << 1);
>
> There's a lot of the so called 'magic numbers' around the code.  Please p=
ut
> them in macros and, preferrably, explain where they're coming from (a com=
bination
> of reg values, a hardcoded value that the manual/spec dictates, etc).

Most of the reset values are already covered by the PLL_RESET_VAL
macro, which is defined at the top of this file. For the remaining
few, some are all 0s or all Fs, and the remaining "magic" values come
from the datasheet, so I will add a comment to reflect that.

>
> One more thing:
>
> > +    s->regs[RCPU_RCPU_BLK_CG] =3D 0;
> > +    s->regs[RCPU_LSIO_BLK_CG] =3D 0;
> > +    s->regs[RCPU_RCPU_BLK_RST] =3D 0xffffffff;
> > +    s->regs[RCPU_LSIO_BLK_RST] =3D 0xffffffff;
> > +    s->regs[RCPU_PLL_RCPU_EN] =3D PLL_EN;
> > +    s->regs[RCPU_PLL_NOCC_EN] =3D PLL_EN;
> > +    s->regs[RCPU_PLL_HSIO_EN] =3D 0;
> > +    s->regs[RCPU_PLL_MM_EN] =3D 0;
> > +    s->regs[RCPU_PLL1_MM_EN] =3D 0;
> > +    s->regs[RCPU_PLL_I2S_EN] =3D 0;
> > +    s->regs[RCPU_PLL_PCIE_EN] =3D 0;
> > +    s->regs[RCPU_PLL_HSIO_CFG] =3D PLL_RESET_VAL(0, 1, 2, 1, 50, 0);
> > +    s->regs[RCPU_PLL_PCIE_CFG] =3D PLL_RESET_VAL(0, 2, 3, 1, 250, 0);
> > +    s->regs[RCPU_BOOT_MODE_CFG] =3D RCPU_BOOT_MODE_SD;
> > +    s->regs[RCPU_PLL_MM_CFG] =3D PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> > +    s->regs[RCPU_PLL1_MM_CFG] =3D PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> > +    s->regs[RCPU_PLL_I2S_CFG] =3D PLL_RESET_VAL(0, 1, 6, 6, 33, 0);
> > +    s->regs[RCPU_I2S_DIV_CFG] =3D 0xde69ad31;
> > +    s->regs[RCPU_BUS_CFG] =3D NOCC_PLL_BUS_CG_EN | HSIO_PLL_BUS_CG_EN;
> > +}
> > +
> > +static void tt_atlantis_prcm_ddrc_reset(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    tt_atlantis_prcm_reset(dev);
> > +
> > +    s->regs[DDRC_STAT] =3D 0x1;
> > +    s->regs[DDRC_DFISTAT] =3D 0x1;
> > +    s->regs[DDRC_SWSTAT] =3D 0x1;
> > +}
> > +
> > +static void tt_atlantis_prcm_hsio_reset(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    tt_atlantis_prcm_reset(dev);
> > +
> > +    s->regs[HSIO_HSIO_DIV_CFG] =3D 0x20821731;
> > +    s->regs[HSIO_HSIO_DIV_CFG1] =3D 0x8;
> > +    s->regs[HSIO_HSIO_BLK_CG] =3D 0;
> > +    s->regs[HSIO_HSIO_BLK_RST] =3D 0;
> > +    s->regs[HSIO_HSIO_GMAC_DIV_CFG] =3D 0;
> > +}
> > +
> > +static void tt_atlantis_prcm_pcie_reset(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    tt_atlantis_prcm_reset(dev);
> > +
> > +    s->regs[PCIE_SUBS_RST_CTL] =3D 0;
> > +    s->regs[PCIE_SUBS_CG_CTL] =3D 0;
> > +    s->regs[PCIE_SUBS_CK_CTL] =3D 0x44908;
> > +}
> > +
> > +static void tt_atlantis_prcm_mm_reset(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +    tt_atlantis_prcm_reset(dev);
> > +
> > +    s->regs[MM_MM_CLK_GATE_CFG] =3D 0;
> > +    s->regs[MM_MM_CLK_DIV_CFG] =3D 0xddc8312;
> > +    s->regs[MM_MM_CLK_SEL_CFG] =3D 0;
> > +    s->regs[MM_MM_RSTN] =3D 0;
> > +    s->regs[MM_MM_CLK_DIV_CFG1] =3D 0x333;
> > +}
> > +
> > +static void tt_atlantis_prcm_unrealize(DeviceState *dev)
> > +{
> > +    TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> > +
> > +    g_free(s->regs);
> > +}
> > +
> > +static void tt_atlantis_prcm_class_init(ObjectClass *klass,
> > +                                                 const void *data) {
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
> > +    dc->unrealize =3D tt_atlantis_prcm_unrealize;
> > +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_reset);
> > +    dc->desc =3D "Tenstorrent Atlantis PRCM Controller";
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_rcpu_class_init(ObjectClass *klass,
> > +                                                 const void *data) {
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
> > +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_rcpu_reset);
> > +    dc->desc =3D "Tenstorrent Atlantis RCPU PRCM Controller";
> > +    c->domain =3D PRCM_DOMAIN_RCPU;
> > +    c->regs_size =3D RCPU_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_rcpu_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_hsio_class_init(ObjectClass *klass,
> > +                                                 const void *data) {
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
> > +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_hsio_reset);
> > +    dc->desc =3D "Tenstorrent Atlantis HSIO PRCM Controller";
> > +    c->domain =3D PRCM_DOMAIN_HSIO;
> > +    c->regs_size =3D HSIO_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_pcie_class_init(ObjectClass *klass,
> > +                                                 const void *data) {
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
> > +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_pcie_reset);
> > +    dc->desc =3D "Tenstorrent Atlantis PCIE PRCM Controller";
> > +    c->domain =3D PRCM_DOMAIN_PCIE;
> > +    c->regs_size =3D PCIE_DOMAIN_SIZE;
> > +    c->ops =3D &tt_atlantis_prcm_ops;
> > +}
> > +
> > +static void tt_atlantis_prcm_mm_class_init(ObjectClass *klass,
> > +                                                 const void *data) {
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(klass);
> > +
> > +    dc->realize =3D tt_atlantis_prcm_realize;
> > +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_mm_reset);
>
> Let's not use the legacy reset interface for new devices - we should use =
the
> Resetabble interface instead.  Here's a straightforward example from
> riscv-iommu-sys.c:

Okay, will change over to this.

>
>
> static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
> {
>     // reset procedure
> }
>
> static void riscv_iommu_sys_class_init(ObjectClass *klass, const void *da=
ta)
> {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>
>      rc->phases.hold =3D riscv_iommu_sys_reset_hold;
>     (...)
>
>
> In this case you would do "rc->phases.hold =3D tt_atlantis_prcm_mm_reset"=
.  Same
>
> Note that if the device requires a more elaborated reset procedure you wo=
uld need
> to do more stuff, but from what I can tell this would be enough for this =
PRCM model.
> For more information on reset phases feel free to take a look here:
>
> https://www.qemu.org/docs/master/devel/reset.html
>
>
> Thanks,
> Daniel

I ended up getting 2 replies from you to this mail. Not sure if this
was a bug or not. I have replied to the 2nd one.

