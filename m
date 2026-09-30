Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAEBCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBz5r-0006xq-Vn; Wed, 30 Sep 2026 14:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xBz5i-0006wr-2I
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:31:42 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xBz5f-0006D2-2R
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:31:40 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ac502960dcso8544687b3.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790793097; cv=none;
 d=google.com; s=arc-20260327;
 b=TB+xcmJySSszgW77WRqEJnoTXTm6QVU2y6ycLUUeGOasT3/nfqckhYnjmQ6+ImRbdO
 rccbn6VNkgClR2QxA7T732hrupE6xCyK7Iz86uDkBXK6yfzWoH6AULs75xEZBmP+jZZY
 LvUiwGz035iJCKtS9G/+fuQLzQVLlcIUGbBaQGVocxQSqrnj/YCRTGrUgKtzk91lU+92
 eycXCWhTROmQCx+mf80mS9wbRH0jZOi075N+/NEy2PPpnN1c6hMb14PIJiojdN4ASZ1/
 QK6vnUAQs+1hvQote9x65fmUmq30bRre+Y9IscbqzjnVSSf6dHzWoM2lVkwk9IllJUr4
 v2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eFYZCM3HBsAdfx585C8WrUMyZe1j/nCb+opKW7ZI5Vk=;
 fh=T7GZKU3pqGfZDaVHTkyCxWlgssTqcxXKF3+qSko7WPo=;
 b=SqjLBxNYAkktfWqhRpXZdMG9goYVUEkTYWyRrMFD5izgVV+J42CBjsvkm+9AlQVHDd
 QaAkvRp+fpf0a1J+D2EVLDpz9XNmWCZZ+Y3DUaXxtCgOJl/hCnt72M5fedjRla/VwUvM
 wPZhafUN9oneH9zN/SXu0F2RQizam7nNCV1vimAIggC6pv6wzvYIS9D3lzUoqPW3gTIn
 AnUWkTbieWLXR8IdiBhxN7/C8Umv+CW6prl0hR87cfiAHyDQLopMkfeiVzJi2Pm3Dn1J
 7qZ++SquCwF+NAYhbYy2IE8KfaqHMxWI93ya+nva2C6MrsOz4B4GbER6DMlBQdCNK76a
 SLlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790793097; x=1791397897; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eFYZCM3HBsAdfx585C8WrUMyZe1j/nCb+opKW7ZI5Vk=;
 b=SylUuxcgABALzaVr07J+MsrPRghxB87W6l18WJpvE5etEsxvLoEoxd5eKR6b4ZTbWY
 lX8GcLl0rIcVcd+oVvAau7p54Rbc++ojzZBbvLSLex+zLWNgXJHvafwCZJKmXtliVrpJ
 PaRcUXAiWwWDxpQOeENxkEgmSfgljm3FIvNcrxbSI+yjS4nJ1crzzQTwEeMVZtF10kGj
 LjvBP3c1nZL9Wn+WVYbFX/xNq7PDowDyDq+sbsJ4CMaNDHtxaPbrU6UknHC5ZwFdRXl9
 iXaYmaFYy5jr3PqtNlWjfdKucfaLOMc9uDoE2RLFKEpSSvoivwfRnto/ckRQ85ivO2TB
 6xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793097; x=1791397897;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eFYZCM3HBsAdfx585C8WrUMyZe1j/nCb+opKW7ZI5Vk=;
 b=Czd6NjMHyyasaRRppCDyrbVmYjr6sGER6eieWhyOioburxRQVyWWCXrzqGENilmEB1
 i9dSVeaNMVUNn4CTmi2/t5eRR1CjtoDB7yiHNLRBREXqDWMIyPEtpwXgV6+5m5kQ6jRB
 c/dEY5UjNjk50GWvBlBU+is9vV5hGYrwkG3ccx2nHIQ1+Pr95P6LCcseflW2oPDRigGw
 J8b9N6QlpLOFcrwNBtSxcjdiBvRtro4q09V9unR163bMfV7T0aGFeYWe3srlB5cPkjhu
 yGTZDPRVauMXp0CLuglQtxoQxZDbt3QywuWXFMGNOGGTtOYkmYC0RcsL37YOBUsCuLcR
 L2Vw==
X-Gm-Message-State: AFq9FYKDLi+vzYFL4nQLu5ZMJkz7odGSKwSwfD/VIVW0ouSfExEuKLWv
 y+gMWhc+kO0tzv92i7NXyYN9zuARADwjj+P9IuhUYHlVrvOOXCnBkDZMhi/77elXTE3TnchPW1Y
 pmQYiM3suhzp6hChIhycSPWjYfuwamZDe1AAg95KH5w==
X-Gm-Gg: AYBFou1gVLISMpPORYLNam3nkmUHD6ka5xl/x63SGvG5ooXAoOqQveNj9q1wwgRYcOt
 WpFY9rQgNz5bYA+po5o8UHQHoUJzqK77fTl7zmGJOhZxi+jnO+Vq3Pm+wrCFtLnxM5uj8blu2JC
 Ejqw0Q/i9Vb0RHEGwd7Bl01Ep2aOzgJIuTz5ShSc9TTQ5JKcm27r5oMxipzSFIQyGZ1MXAOeY9d
 jqix4Z2XRvRdI+LPrGU8WtoCsXNPqNda8J1AoL11ikUSh0vxnLO21/CmhH47DG+7+GMakLzmaS/
 QBdQ6f/h3UC/urm8oiOCigsRruPMTkil58Sjs7433sZ9ZwahuNeYeoiX1uR5IQmaOUXv0SvU1pQ
 uAabydvQHEA==
X-Received: by 2002:a05:690c:348a:b0:8a7:4207:64f3 with SMTP id
 00721157ae682-8ac94abcbb6mr9087667b3.64.1790793097432; Wed, 30 Sep 2026
 11:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
 <20260904-atlantis_prcm-v3-2-8bf20795a381@oss.tenstorrent.com>
 <CACPK8Xf2vW4MLPgNEzbL3YGSgQQmnBM6NyujwgQ8K+sF5aW9qA@mail.gmail.com>
In-Reply-To: <CACPK8Xf2vW4MLPgNEzbL3YGSgQQmnBM6NyujwgQ8K+sF5aW9qA@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 30 Sep 2026 13:31:26 -0500
X-Gm-Features: AclHuK8GbAojvK4rjZJMefyDnYTpui_A70hEWOcNwd2sowUrcJizM8pO73OahAA
Message-ID: <CAEev2e_t5njP8TB9i9FdF-610opP0HyB_ay3KAxDpZ=tYkzevQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis
 model
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, Sep 30, 2026 at 1:54=E2=80=AFAM Joel Stanley <joel@jms.id.au> wrote=
:
>
> On Sat, 5 Sept 2026 at 00:18, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
> > (RCPU, HSIO, PCIe and MM). The remaining 2 are only accessed by the
> > boot cpu which isn't modelled yet.
>
> Bonus points for adding them if you have a model ready.

Yes, they are part of this series. I was referring to the boot cpu not
being modelled.

>
> > This commit adds these 4 PRCM blocks to the tt-atlantis model, along
> > with necessary device tree nodes for them.
> >
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> Happy with this once the the sysbus_realize return code checked. A
> bunch of other minor things in here I found from checking the
> generated device tree with the linux tools, which I don't think is
> necessary but does neaten things up a bit.

Will make the style edits.

>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> >
> > diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_a=
tlantis.rst
> > index 1f2880d617..539c22354f 100644
>
> >  };
> > @@ -327,11 +332,36 @@ static void create_fdt_i2c_device(void *fdt, TTAt=
lantisSoCState *s, int bus,
> >      qemu_fdt_setprop_cell(fdt, name, "reg", addr);
> >  }
> >
> > +static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
> > +                             const char *prcm_name)
> > +{
> > +    hwaddr base =3D mem->base;
> > +    hwaddr size =3D mem->size;
> > +    char *name =3D g_strdup_printf("/soc/prcm_%s@%" PRIx64,
>
> clock-controller@ instead of prcm_foo to match the binding, and save
> ourselves the string formatting.
>
> > +                                 prcm_name, base);
> > +    g_autofree char *compatible =3D
> > +        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
> > +
> > +    qemu_fdt_add_subnode(fdt, name);
> > +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
> > +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
> > +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
>
> No children, so we don't need size and address cells.
>
> > +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());
> > +
> > +    return name;
> > +}
> > +
> >  static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
> >  {
> >      uint32_t aplic_s_phandle =3D next_phandle();
> >      uint32_t imsic_s_phandle =3D next_phandle();
> >      uint32_t periph_clk_phandle =3D next_phandle();
> > +    uint32_t osc_24m_phandle =3D next_phandle();
> > +    uint32_t prcm_rcpu_phandle;
> > +    g_autofree char *rcpu_name, *hsio_name, *pcie_name, *mm_name;
> >
> >      create_fdt_cpu(fdt, s, aplic_s_phandle, imsic_s_phandle);
> >
> > @@ -348,6 +378,30 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCS=
tate *s)
> >                      aplic_s_phandle);
> >
> >      create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
>
> Nothing uses this now, so it can be dropped?
>
> > +    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
>
> We're not Linux, but the Linux device tree checker will complain if
> you use _ instead of -.
>
> > +
> > +    rcpu_name =3D create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_RCPU], "=
rcpu");
> > +    prcm_rcpu_phandle =3D qemu_fdt_get_phandle(fdt, rcpu_name);
>
> I made a mistake the past review, as Daniel pointed out, confusing
> qemu_fdt_get_phandle for qemu_fdt_alloc_phandle. Sorry for the
> confusion.
>
> > @@ -587,6 +650,28 @@ static void tt_atlantis_soc_realize(DeviceState *d=
ev, Error **errp)
> >      serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
> >                     qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
> >                     115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> > +
> > +    /* 4 PRCM blocks */
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_RCPU]), errp);
> > +    memory_region_add_subregion(
> > +        s->memory, s->memmap[TT_ATL_PRCM_RCPU].base,
> > +        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_RCP=
U]), 0));
> > +
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_HSIO]), errp);
> > +    memory_region_add_subregion(
> > +        s->memory, s->memmap[TT_ATL_PRCM_HSIO].base,
> > +        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_HSI=
O]), 0));
> > +
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_PCIE]), errp);
> > +    memory_region_add_subregion(
> > +        s->memory, s->memmap[TT_ATL_PRCM_PCIE].base,
> > +        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_PCI=
E]), 0));
> > +
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_MM]), errp);
>
> Check for success and return, for all the sysbus_realize calls we pass er=
rp to.

Ack. Will do it similarly to the Boot ROM/I2C init.

>
> You could make these a loop with a {type, map} table, but no biggie.

