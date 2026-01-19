Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6411D29C36
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqSe-0005Ws-3d; Mon, 19 Jan 2026 09:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vhqSc-0005Vr-Ia
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:42:30 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vhqSa-0006qy-WC
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:42:30 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-65f65538a90so3234406eaf.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768833747; x=1769438547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ktxP2x58t8JG46IbkJ87ZwF8mbFsBmeiWLSfF058hQ=;
 b=Bi+0UGwhAumOtQJY8wKQvNHU9SZDmV87gzP2SiOtWshEeIERAjjZoIo5uXxhVq3vu1
 SLDhBoiYV0VRKO7SPAOZfSYCOVB9WHVzhEFbmV0QY+qEJjc5g/GYL1OaCi1DZ3akgsq7
 PdsU2yvxtfJKQXdlD3M5MVkKkrVAnbjtWdeeRk2XA3Hp/0l+X73ZH7hvztx7FlrxSZo6
 LGkM3fwbZ4ykk0sHcSrBojd7VTmgC1+NnXBw2sPOZ4h+0Ob3/MtMzg0uyWTRSxa0ndQi
 Ugdt3XTb8CFHHIraEQ7/N1l+ToB25lT0+O/3brIBBaTiyn7DBDsU5jTRwqG3uFvVep81
 kguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768833747; x=1769438547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ktxP2x58t8JG46IbkJ87ZwF8mbFsBmeiWLSfF058hQ=;
 b=jE1SH0ldPlvff+Z0w7tno521wJrRAIn4eUey3Y9TMEeGam+U5briDtPMYjfdS9pvIt
 +JKeH0Lhf8PmA44YWxHrVpv6LW0yd2kMJi+iXErodBvMxwo2vzhrO4/+zO/j3ktwI4Y8
 hBh73EdUoNXE8kI4iZRAPK2bLxMOBLxDIbykNE1nyj8xcuopJXdJRc9332FOAZih0vQ9
 1ebKcUkn6vkYPGsHrJyQqsjjXpPwSdwjeENLEA5t/NpJt3+zIc/c7RMZywc3FcnVZATJ
 Bkb0NLDMn9xW7IBc2CXx1PdSdq/r38GLU2G7gsSVzxNkuJSrsFOOXE4rwYzUxiZMHbqS
 TrbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaSMi0LOI61ZHeVSV0CJp5R1PXbwDaW5fAkmxHn2mzC1/7ehNtG0vQ6dUe169dbfPN6mni1NS8YYGL@nongnu.org
X-Gm-Message-State: AOJu0YzU/Cak7HYx5ACzEFBXST/43A3FXmOytRsUv3va8LWeopy+GjlY
 EMxamrXnk/drsXh6UEeWFMYZgTuhM7Lm00bXEoCMbwqdvdWODBzcTGEZi/bih8GlYWzUV+QYmpq
 PGBb41teuzuxh/meyweIewUmgkcVG/rE=
X-Gm-Gg: AY/fxX4GV1l1IJQH1owB/lq2XXoO198x0P1FEdYzHLevj5E4ab0wqYNJZkO2fSVbSrv
 DZmt4/WceIB/dYqLnMTiF6i/EpERijBaqLiDU8xWwm/ZB9JB3kHPmJo9ceU1EtpdMi9k5Fi54aL
 L2e2E01YiA8osloLI/GcxLJxaLhHCk9fKTlLlSLgGxpBApZPUcZfP4iAqHd0ZNX20IW7WixjBSJ
 v6L1bfOXbJ1o37ZDpirzPJ/g9U5v4lIYvl1VKtO0KdtEMqMHZkX19jjpxhUuDQ2Ppiilt4=
X-Received: by 2002:a05:6820:1794:b0:661:14b1:7c66 with SMTP id
 006d021491bc7-661180e3be2mr5357633eaf.25.1768833747059; Mon, 19 Jan 2026
 06:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
 <CAFEAcA-VYhtvXK5tyVJWfskqqKFim43DsKfWrpaMxteWueR6aQ@mail.gmail.com>
 <CAN-aV1FsbAp3JrqoPgz+c4ORayBjsGxTLWOkDMc0WyE2nD-aZw@mail.gmail.com>
In-Reply-To: <CAN-aV1FsbAp3JrqoPgz+c4ORayBjsGxTLWOkDMc0WyE2nD-aZw@mail.gmail.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Mon, 19 Jan 2026 15:42:14 +0100
X-Gm-Features: AZwV_QilJ0BMQ498EN7J-LrY2MtIw0wxqNdgKXAPwRxPNj4sSNAvrtw10YHjXCU
Message-ID: <CAN-aV1ERa6uE9U8cPArmXCv+WOJhP7ZgGAF2VEDaAEbiebyawQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] hw/arm/smmuv3: Add SMMUv3 sysbus support
To: Peter Maydell <peter.maydell@linaro.org>
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jan 2, 2026 at 4:36=E2=80=AFPM Ruslan Ruslichenko
<ruslichenko.r@gmail.com> wrote:
>
> On Sun, Dec 28, 2025 at 5:59=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Fri, 19 Dec 2025 at 22:25, <ruslichenko.r@gmail.com> wrote:
> > >
> > > By SMMUv3 specification it can be attached either to PCIe Root
> > > Complex or regular IO bus devices. However, current
> > > implementation only allow to associate with PCI bus.
> > >
> > > This patch series add support to use SMMU for sysbus devices.
> > >
> > > One usage example implemented for virtio-mmio, which allow
> > > devices to perform DMA operations SMMUv3 with address translation
> > > and isolation.
> >
> > If you want virtio devices behind an SMMU, why not use
> > the PCI virtio?
> >
> > The only SMMU sysbus requirement I'm aware of is that for
> > RME we will want to have things like the GIC do GPT lookups,
> > which is most conveniently done by having them route through
> > the existing for-PCI SMMU, rather than by having an extra
> > SMMU just for them.
>
> There may be several reasons for supporting SMMU on sysbus:
>
> Some embedded platforms may not use and don't want to include a full
> PCI subsystem, but still want IOMMU isolation with virtio-mmio.
>
> The other reason is to emulate existing SoC platforms. The model may
> need to be closer to real-world HW and SMMU is widely used outside the
> PCI subsystem.
>
> One more reason is Remote-Port devices in our case, currently ongoing
> development here:
> https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg02121.html.
> Those are platform devices which are emulated by external services.
> These devices need to perform SMMU operations for DMA transactions
> when they are bus-masters.
>

A gentle ping on this series.

Hi Peter!

Do you think we can continue discussion on this topic?


> BR,
> Ruslan

