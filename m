Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF06C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYRG-0000KG-6Q; Thu, 27 Aug 2026 07:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzYR5-0000Jo-RM
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:38:24 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzYR3-0001XK-MC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:38:23 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66c7e3a2332so1694017d50.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787830700; cv=none;
 d=google.com; s=arc-20260327;
 b=Env7Ka8aYcCfUIlO7dgVAWrOTG+bwGj8nWbO5Wr5ffLWubsP5F/bymnOwdq5PH+5vU
 sc2phsmiibRQE3dW2+33HM+RGUldUpgdQLsw6JqnRSY1XFosndIOnfq1UU/KAr2bb/wU
 5hRrNfbfq2NuJwufN2teY1CSjZbYDw88A292muwogYTtK7mHNXMd7SgrarqORWZpjT1h
 4TJM6YvQPnB3eJDYqC/82nshvhAKs4X7Z+6444s6v40DIIgnqpGn0HcKKwh6X8g3g4m+
 nLlBs2u6mwpMo2MgnTT+u/buxI4CLdQuGTuSUA8XjqgjzS65MGn4Ob+SpFXqTBlH7CwF
 1j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=smE1oioKynN20kHMh+tO2twTO8YmnrAzbMbMtnZZ3+U=;
 fh=Y72/PNM1/YnyGuk84uFcAojFK0/yNC9ZUVnLHcG1CUM=;
 b=CpayvalONabjaRnh2RDEVwU019epPaShl0lEt/Qsptf+d+PmIxOOL/Zv57Bmt14Yrw
 Rn822AvfUVtVA6rDc2Vw9wBgpSLKFXXD+F1dBSRY40tt9AH749FJhtkmK/BdbMVo63S5
 A5zFg9eV+IlUfHQ0mQdYfaImolYqTJTcN3EaNndCJW1+ocDsu2dHKG9WTAd9MPqwgDwZ
 2u15hNVz9ACZsc4TsSgHM111ajJtVFs238SDiWRPLfAvTtHU/Z0/GmjX7SFdG8O+/xP6
 KYRbrQIgMMSuSJAADp9vGgCvvKQEEK/i+6zcWGSZzOIzXrR+ERqVGTf2v2aA3MZqTOnZ
 oHoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787830700; x=1788435500; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=smE1oioKynN20kHMh+tO2twTO8YmnrAzbMbMtnZZ3+U=;
 b=BzWRAHQD/02JTDcXjJGAFMWlgjyoX06mdL77yASa4NNSTe8RM9k8vOGgg/Nckld6Q9
 CZH24PbLK86/DjV/HW0RsD7shp7Agl7y9Y/FaxXWZ7EWKO+fHlg9U/g/G7jbITYLkLJY
 ARxPf3wEPen3zAHEWxykLTyAdkyhd04a62EBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787830700; x=1788435500;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=smE1oioKynN20kHMh+tO2twTO8YmnrAzbMbMtnZZ3+U=;
 b=UN+nmK3K/H5wOG0RO4O5/j8+5sdi3GbnLZM+jwB7QYC6lERoRG3ZuRObkeQ4DR4end
 qkWPILQ0SgzyIwQibh6DnlL2Gn2AJJ0B3E+5Ash3CtFyMxQ7kjRXJ8xYjvdUYyy8FVCi
 7xOiUtBHsPmX9/EZNOR5vjOdpyp7CRcMVmd2y+LaVIr5o2Oz5j0PSNjQN4xOZFYIpACB
 8/kPUORV1ArCz59tNoi0oz/ZURNg94Xd6Omoj/xqnm+xKWdl41Qnb8nnK5qKOX8bafwD
 RsCD3m7R6n9Zq3+42TM1m6x3HFvkIcaM+kpSr73iGRL+3ALCVuN2145YHTAb96D3nzEn
 T2AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJlTP1Uuf4CdWW8Tb2TPX7voiCSUJfXeXMb4KuAeuCdPPeF4lBdpB69i9eOF/z5/XfublLIRTJrrCS@nongnu.org
X-Gm-Message-State: AFuF++lBXzxtkHUFLGE/XAmaDzBbqSvLsvn8LhQqagqGzFiMpKFJyrxR
 VeMzYT+F1xnNupA1VemixgYJoiA/Yg1c8w1ma+iL8LOkI1+AFiCIzUs9X+IrWDQM3a8XcihXG9D
 Sw7SXC/my6xgQtJzydlSzBGii8cp9zDU=
X-Gm-Gg: AR+sD12FYuXj1vAlcKhpVGQoXbqtSDnFgj39MgHDvtAIKiW2j7Iylq+dPyfjEXW1Jd9
 /l+PqeHmf6AdZ7BhXIYAHYRlTaSsnkIxaBlCH0BmEOrvEdeyou8ulTNGmSbmoqFX//kvG3dFOcw
 3ddre+3+s+1z3tkJXkaDDlIq7fpd+NGraFYhBxNkTxp1px8rolB96fKieAltMQYB/mbhnP1Qmak
 135oDaWyFtLhbUyLYV4RflL8p2AjGhUJQfRBIghOS3RKwbfpjTl3G74DR/E+zYaDdwgeVCjdgYE
 8tvlFtr2nX3BDVTs/z/DXmxWJ/8AniYnNAWiK1fphkz/H8Gc0iOHqWHHwqS7LrgfiG8UWVG2ZVt
 rVLZYT9l7ba5U0LZLraBtW8Gf/6HHr5DZHltGS1F9VihBYEZDel62oaFlh+9HX8Zq+OeiZCoMfq
 1yaag4dkyJNAGSXD0s
X-Received: by 2002:a05:690e:bcd:b0:66c:e0ea:a25b with SMTP id
 956f58d0204a3-66d80541034mr2387599d50.1.1787830700314; Thu, 27 Aug 2026
 04:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826220528.54516-5-joel@jms.id.au>
 <53fe0bed-9694-44b0-a1ff-628e2983b0cb@oss.qualcomm.com>
In-Reply-To: <53fe0bed-9694-44b0-a1ff-628e2983b0cb@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Aug 2026 21:08:07 +0930
X-Gm-Features: AcwNN1WUFpBMG_leDaNXikIKmZ45jbz_LybxJAfCtsji0Vf2bUNrYQalH82vuK0
Message-ID: <CACPK8XcyTVkdeifw3bvVR-SqWDc+JRetYDHcjkVo7hO8KrtEjw@mail.gmail.com>
Subject: Re: [PATCH 04/16] hw/intc/riscv_aplic: Take a MemoryRegion for the
 created device
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 27 Aug 2026 at 20:38, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 8/26/2026 7:05 PM, Joel Stanley wrote:
> > riscv_aplic_create() maps the device it creates into system_memory,
> > which prevents its use by SoCs that map devices into their own memory
> > container.
> >
> > Add a MemoryRegion parameter and map the device into it instead of
> > calling sysbus_mmio_map(). The mapping still only happens when the
> > APLIC is emulated. All callers pass system_memory, so there is no
> > change in behaviour.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >   include/hw/intc/riscv_aplic.h | 2 +-
> >   hw/intc/riscv_aplic.c         | 5 +++--
> >   hw/riscv/aia.c                | 6 ++++--
> >   hw/riscv/cps.c                | 6 ++++--
> >   hw/riscv/xiangshan_kmh.c      | 6 ++++--
> >   5 files changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> > index c7a4d4ad0172..baeec76e4c3e 100644
> > --- a/include/hw/intc/riscv_aplic.h
> > +++ b/include/hw/intc/riscv_aplic.h
> > @@ -80,7 +80,7 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
> >   bool riscv_use_emulated_aplic(bool msimode);
> >   void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
> >
> > -DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
> > +DeviceState *riscv_aplic_create(MemoryRegion *mr, hwaddr addr, hwaddr size,
> >       uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
> >       uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent);
> >
> > diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> > index 84606e9f3d88..87d7d9e49cdd 100644
> > --- a/hw/intc/riscv_aplic.c
> > +++ b/hw/intc/riscv_aplic.c
> > @@ -1109,7 +1109,7 @@ void riscv_aplic_add_child(DeviceState *parent, DeviceState *child)
> >   /*
> >    * Create APLIC device.
> >    */
> > -DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
> > +DeviceState *riscv_aplic_create(MemoryRegion *mr, hwaddr addr, hwaddr size,
> >       uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
> >       uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent)
> >   {
> > @@ -1137,7 +1137,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
> >       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >
> >       if (riscv_use_emulated_aplic(msimode)) {
> > -        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> > +        memory_region_add_subregion(mr, addr,
> > +            sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> >
> >           if (!msimode) {
> >               for (i = 0; i < num_harts; i++) {
> > diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> > index 49cb14349f00..974806c425e2 100644
> > --- a/hw/riscv/aia.c
> > +++ b/hw/riscv/aia.c
> > @@ -71,7 +71,8 @@ DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
> >
> >       if (!kvm_enabled()) {
> >           /* Per-socket M-level APLIC */
> > -        aplic_m_dev = riscv_aplic_create(aplic_m->base +
> > +        aplic_m_dev = riscv_aplic_create(mr,
> > +                                     aplic_m->base +
> >                                        socket * aplic_m->size,
> >                                        aplic_m->size,
> >                                        (msimode) ? 0 : base_hartid,
>
> Not a problem with your patch but seems like we have a goofed indentation here
> and down below in the next riscv_aplic_create() instance.  Seems like we tried
> very hard to avoid breaking the 80 char line and we ended up doing this:
>
>
>          aplic_m_dev = riscv_aplic_create(aplic_m->base +
>                                       socket * aplic_m->size,
>                                       aplic_m->size,
>                                       (msimode) ? 0 : base_hartid,
>                                       (msimode) ? 0 : hart_count,
>                                       num_sources,
>                                       num_prio_bits,
>                                       msimode, true, NULL);
>
>
> i.e we moved the MULT to the next line, indented it, and all other parameters
> follow suit.  The result is not pleasant.
>
> If you could take the oppourtinity to also fix the indentation of these 2 instances
> that would be terrific.

Agreed, x1000.

> It will break 80+ char line soft rule and that's fine - the
> hard limit for checkpatch is 90 chars per line for 10+ years now.  It should be
> 120 char/line at this point but anyway ...

But I'll move this to the next line as to not pass comment on this can of worms.

