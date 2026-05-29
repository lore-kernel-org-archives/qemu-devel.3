Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CDFCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1OM-00072Y-WC; Fri, 29 May 2026 13:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1OM-00072E-CH
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:53:06 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1OK-0003O4-OH
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:53:06 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7dbfebfbf50so34362837b3.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780077183; cv=none;
 d=google.com; s=arc-20240605;
 b=K+U0Ij+8ImFZ6bAoP+8xjcq7wC67JIjyS6uEoQIPpQcUdURQFQaFJFlGqes+ge/ys2
 gx/8P736z83CFGKS8UIqURCoRixI10aLcmW8NK8SuQV77AA1PNifNkAG0kxcRvY0vT8H
 M/myQ9cC2xdkr5DqU0RgCuyLjl5Mcbm/KBSNaay0Wbc8l7mMWIOHeUtbNy4llCu5pQ80
 XHpzVU6vIW6pmtCPBo6dj9O5CA1r0xmWVjpjWu+D1VwJnPXreE4Dgh/s3jcN7enSjK3l
 MXTsI2U2WoVxzXWh7wpg85U2atByAvxQDslEfyc8cCvunoUp76Vxp2n26iarrfF79R8p
 3VAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nQlP12RUuBBVpXDhZ5MFD4U7SV/VrxoBlSj6jpPr0zk=;
 fh=KrHbO6sOAZBJIm1jL3vWipkmYACGn1gRCgwFQrTxoFs=;
 b=GxazGKgwjhmPieQPSmsxNEkZmX7cFVX9UquNQETVC1Ga1V0qfg89Y7zvW0SDN6V9lO
 73X9d/95JprTf/0bu/AhhxzVTHFYHlqlA6ZhKfeZ72XIybP/jlYCSv/JPkQNOSojTqef
 yUEa3R+A/gl2OnnvpZz/gdx21byvL766i7sEOcORewXTfP9jHb6B8t7Ecu4NxcEYWrNB
 KPUeoA6TWIE0RXmHghG5X37khA30ipNYE9i5tvAhTd1hqHlouTGLN8tEQ0col0wXHR7E
 ojJCwTEe9Ld8QHhtWeGgP5Km1egFYUjvMORT4gCfi/pG6luliZLpD/5JP1C4jWQ6i9Tp
 XISg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780077183; x=1780681983; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nQlP12RUuBBVpXDhZ5MFD4U7SV/VrxoBlSj6jpPr0zk=;
 b=vGH8JvPLqRgCcyi/WcyyebsifNoPCCan/OETdJWO4YnFnWcNvuBb6f4u4F2HgvP6nJ
 k5bXMXcpBiYo8b/B8bm04rFwHTtFKgXsa9Pfx9GnRkWsnfJ/wVoW4a1DjD8wvPS83ibK
 8J5rpqge7Lh1LNz23THhXFub4S+EnIf3Uis0VAKAIyqo24WMleMn1ZyIotZQ1kwZjsLi
 P8OkMfG1/KS+CGIjyY+dTI7aScj3EiYLf6uKqY/BUOR272p9MspuuDDCeZYogI0ME9Nq
 sH2G5PfFArcIKvzqutq0QgifdgYqPSSyoWI8jkv4SVJMnV37WzEW+CDaCrFFFqvmSfMq
 2mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780077183; x=1780681983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQlP12RUuBBVpXDhZ5MFD4U7SV/VrxoBlSj6jpPr0zk=;
 b=XHaIDO0eWkWm6y0kzHeMDBxRkkKf0aK96sdVSrrbU6fPKMxiptOAs7RNreAknWitmB
 lj2wsSNfB+MJqdbHHzLZJ6orkfRgjZNjKqDmYGyDoUftygNFbdiZub83tKat6DRV+HGv
 +L/HO6ZH+zt+2p8F9YNQvTBg0iT1IFjX1XMTRgHDRWECeg2m+IFMcFpVzW8xwVwRGryo
 fu4sOdDy2dQPirBiKlOlS2+Wu6EAhGv/iGi2Kt0LVQe2U9fWk1ui/wq4TczxlBGeyly3
 zkGtOC2PcJwPoT1CiRDicn0uBM6xMq50a8hQlHzm5hrmt3uV7E5Yr1zBnmB7hEGywyGl
 iZVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+o1a9jEPQcc//3MF4E6Vl77jX/vK+esxjfzgVjfEYiE0JskajCNu9nZSaQLKbGuI21xOxHSS0VzvYM@nongnu.org
X-Gm-Message-State: AOJu0YyW1ZP3VHce7jA+1wprLSELFBX+fn5rt/H4eogMhbcLIrN2HpNa
 Mhjm0Bio0Na5dDqPGl6uxq5RD9x+NcmE379pK8wKx0iG7pcsShhpggEOzKIp0OH/KT7AYHLLhIG
 3QzBSpTfoRAOr83sAJF9cbWZlnXhglxVtwMsOxLZOmg==
X-Gm-Gg: Acq92OGoFmLn9uvkie+d/EYaIGNciaqebWRsh0jWXIM+1r5N50oD9rTjAnvhcUbwdg/
 st7wrZlJigW+UOvqL4UjdxllnGrXhmki0wzUpjAV80fR4RSlyy+00VcLd8YxJot0hyncb9INwuI
 vWUkV96pV7ra3r0C0bRt7+QQmaoENM1YPgJr9+vNc0PcEeuluilmaIQAT+HiH0JmTpPXTH2VLLK
 1PylGt/CY+dmweMs0kf7ZC1Mc9j+zghL8X7bX0zl1SM8ANSaSvMYrv9d4zD/OrEp1Slrqjh2mM3
 VwZM/MOEMWS/t2Pxm9a0ouDmnPPdLu6t1P94cAs3w8kFZWkvpAQiO76J+yNWjJAobo+UPUAcNLY
 f066GhWqcw3ik
X-Received: by 2002:a05:690c:4889:b0:7bd:696d:5125 with SMTP id
 00721157ae682-7e05e667c34mr3520927b3.45.1780077183450; Fri, 29 May 2026
 10:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260529140559.1775511-1-chenhuacai@loongson.cn>
 <CAFEAcA_Li+07XNfE+GpvZOzwJReqbG=x8nz=kMrQy5vqkReEUQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_Li+07XNfE+GpvZOzwJReqbG=x8nz=kMrQy5vqkReEUQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 18:52:52 +0100
X-Gm-Features: AVHnY4LS92s05pVvblpyq47ntUKCqZ2eUi8mm8_vtxMxBa2zzOB6BhKc8oo4aFg
Message-ID: <CAFEAcA9-RixpW9Br1_3vhSsBY8KTwpcCMPar39pNX+c_vAPgrw@mail.gmail.com>
Subject: Re: [PATCH] fw_cfg: Add support for LoongArch architecture
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Gabriel Somlo <somlo@cmu.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, 
 qemu-devel@nongnu.org, loongarch@lists.linux.dev, 
 Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 29 May 2026 at 16:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 29 May 2026 at 15:42, Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Qemu fw_cfg support was missing for LoongArch, which made some functions
> > unusable in virtual machines. So add the missing LoongArch defines.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/firmware/Kconfig       | 2 +-
> >  drivers/firmware/qemu_fw_cfg.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index bbd2155d8483..9ec747716389 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -121,7 +121,7 @@ config RASPBERRYPI_FIRMWARE
> >
> >  config FW_CFG_SYSFS
> >         tristate "QEMU fw_cfg device support in sysfs"
> > -       depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
> > +       depends on SYSFS && (ARM || ARM64 || LOONGARCH || PARISC || PPC_PMAC || RISCV || SPARC || X86)
> >         depends on HAS_IOPORT_MAP
> >         default n
> >         help
> > diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> > index 87a5421bc7d5..0c51a9df589f 100644
> > --- a/drivers/firmware/qemu_fw_cfg.c
> > +++ b/drivers/firmware/qemu_fw_cfg.c
> > @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
> >
> >  /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
> >  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> > -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
> > +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH) || defined(CONFIG_RISCV))
> >  #  define FW_CFG_CTRL_OFF 0x08
> >  #  define FW_CFG_DATA_OFF 0x00
> >  #  define FW_CFG_DMA_OFF 0x10
>
> On the QEMU specification side we could probably nail this down
> to "x86, sun, ppc, parisc have funny register layouts for
> legacy reasons and all others have the 8-bytes-apart layout",
> which might help to avoid having all this architecture-specific
> ifdeffery changing for each new architecture, if that's
> something people care about.

I sent this QEMU patchset proposing that (and cleaning
up some of the implementation to make it less likely that
we add fw_cfg to any new board types with different layouts
from the arm/riscv/loongarch "standard" one):

https://lore.kernel.org/qemu-devel/20260529174639.451353-1-peter.maydell@linaro.org/

-- PMM

