Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3104BD29C3C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhry4-0006I0-DV; Mon, 19 Jan 2026 11:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vhrxu-0006Gw-4y
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:18:54 -0500
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vhrxs-0004BE-4X
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:18:53 -0500
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2b6a93d15ddso4153177eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 08:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768839530; cv=none;
 d=google.com; s=arc-20240605;
 b=dp6zXOnEBEqmyg+1AWwTJgO7rSZBWMdYeHFDYdAOoJLv/3PFwiGqJ+MgWByWbaA1a8
 VGEN2qyA2jUZPsvHdhSxw1QVevPrsI+Bujw+ucbKa5+RdegYiF/5Uu8dTvlBIOb9kb8h
 GSSE0bC0r43QELNRCbpsqaF+CZvoJm5NvLChBZccS/HYkiqItFztjRU7Z7rlC6P1G9iM
 FZ6QEr6xp9u8WuUhToGM/iw6y1B9Uk3vP4SFpvxHx2OuAJn/FUni+DNGb7+90b6uJISH
 hgA9BCeY7XQu0HXGlq756q06z/J6WHld++iNMQkcoQ6OYYkhU926lFfYTUHFy07CsQlh
 W1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kwcW/N2PB9gevNDalUT2JCmOXQ6WOQFA1+HTySw47DI=;
 fh=aA9kIxvQQEnvJmKIAoqVOSt/BWBdBIvFnKN5hTyAq4s=;
 b=XAWvARiUL6BWxbdw2XfBuakOsJ3MnHuBcPeqyyOujtXoNtrD+jojc+uSUErtPorED9
 T2VEmXSRbYkj/y7kduMMWH125lAdNubW1GySa1o/QZQR6VAs9Vye7zz2qn9xP3z70sOY
 brZQ6x1OS/S3R+5j1PCXzJHwhAu6q0ckH2TOZ8LgQHFm2sIbx9SXev9vvv57lcdZknBV
 s5wUMk6iMLz2caV03MpmsgBjg10xPA0oksi4kG01YQMhENgSsmrBPcYzlTm1MEgCY0ep
 yoD9/VV/31EAfvuuW/x3XZbKCybJ8+sQivyg+vlp0mql+2BKI7ohAJjpGdbjTCLUoZNe
 t1Uw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768839530; x=1769444330; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kwcW/N2PB9gevNDalUT2JCmOXQ6WOQFA1+HTySw47DI=;
 b=Dk1+MT60E1eHyQVvnk0ye6KaHjMbP6/BI6uYgUBKEGKoLkcLYLI3MqJITSJmB0dYd1
 sOJMRRZVU8awiLFD7boFVsqD90bD9GCQ5P5uNrnqA5QiU1zKzBhardFZGeCCHOG3ji60
 IZIblN28gWH/603zu5Yf4qp7mRxcAdoRbrV5rtMI1I+HPsT/rjLffVmNxvhowo81SgLW
 kBGpdRpjYiUOVx3Yr1I2cotq6utKOPZw4uD4QJckp9u9ovAJxSXtxh46c33lhFJqVyw0
 hTWDwlrawUcMtTQQF+xB4kMu4H0Ew73tB2J9phyPFVHpJOequUF70/2o9jP4VuqgbchJ
 dxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768839530; x=1769444330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwcW/N2PB9gevNDalUT2JCmOXQ6WOQFA1+HTySw47DI=;
 b=p4D48FARu9qMSVmYlfamtRogUGC3lErIlXgaMhTQc1+W/vto7VeNbL7qIFZhSDOWy8
 5camfm+sdBGMni9jssBKPz6qDrsF0PCdW//3xIoFOTuAZQHXmDUYSzhxwyAHEA/4wzN3
 O9dL6+V6wFdrcPk1zohGEtgNyECTEK9XbaMS+QppOvWDq+a0hKqMkwcEejBtcqve3Isk
 y/GsC0FmCJCv/QvWyGMCV0WNJlesexoes4b4I8nbYamq956mKlj0saFWDy56MLA2MQI/
 GSSw98xIOPUfsHC2lt5/vQZ7B7v6T4CjGTiJXtImBSAPMJ5jBkqpaHSjHnn0wcCiyHPG
 UZWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgoRHZ38vOT3bwP6COP5ulpATxdm3qLyGZ/qmD2pOwSd2cfjlXdXTHWL4fjwtCMPv40Y3dmggpvq3B@nongnu.org
X-Gm-Message-State: AOJu0YxkV1FlNtFL5LC2Jc9k29M6rTiR0+GaDIvQexTElVuLRNRKaNbP
 bb7wg0foTvSO3FNMAvdrnja/cVNv4rAHTDKEKo1jukWlXdF40/tTillC7OebOZnuVA4WkVF+tNC
 8GHbUk25UpQKwGLpsXi0rNwQTjmDPKN4=
X-Gm-Gg: AZuq6aILAfc8aYy2Y0knh583RzK62zoPG6oDCyEpJQi5HdpikCPgVZAUqF5rf8eYmu5
 ICLvV6kzGyRWHbqWoK+XwYtFV4BNkQWp88bJR1Ei/BFAsIdtebU2PODUhB5AjqGZamrEo3qC9Cr
 ZUGzqvy/XroCq6pg3LBZP/w7vfm5P7I1VtyrUnJoaC3AxGkvysyRmdIhLYDGlrUlGoOxb/OEr2F
 KKu+vIS2EMOybiYk1bHwci5/+3R3BlTiiVRxdmj5E6VV9OYwlkdq7cbubcRd+KM+mZIIw==
X-Received: by 2002:a05:693c:60d6:b0:2b6:c03d:9ff0 with SMTP id
 5a478bee46e88-2b6c03da307mr6475091eec.22.1768839526824; Mon, 19 Jan 2026
 08:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
 <CAFEAcA-VYhtvXK5tyVJWfskqqKFim43DsKfWrpaMxteWueR6aQ@mail.gmail.com>
 <CAN-aV1FsbAp3JrqoPgz+c4ORayBjsGxTLWOkDMc0WyE2nD-aZw@mail.gmail.com>
 <CAN-aV1ERa6uE9U8cPArmXCv+WOJhP7ZgGAF2VEDaAEbiebyawQ@mail.gmail.com>
 <CAFEAcA8D19toNxsLsRcSoLgBAGVnV8OXWLP41m7aTLsNSw++PA@mail.gmail.com>
In-Reply-To: <CAFEAcA8D19toNxsLsRcSoLgBAGVnV8OXWLP41m7aTLsNSw++PA@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 19 Jan 2026 17:18:34 +0100
X-Gm-Features: AZwV_QiwKbY4ew_OqFjf3WbMOw5aao5FB_Lkxjcx7WpCGmxYjqXvwlURHbSx5dc
Message-ID: <CAJy5ezqhrFiNbAKCpXThqh10g4EfT5Ec34Na1=imovtB1P9jqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] hw/arm/smmuv3: Add SMMUv3 sysbus support
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, ruslan_ruslichenko@epam.com, 
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a9409d0648c00b2b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a9409d0648c00b2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:57=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 19 Jan 2026 at 14:42, Ruslan Ruslichenko
> <ruslichenko.r@gmail.com> wrote:
> >
> > On Fri, Jan 2, 2026 at 4:36=E2=80=AFPM Ruslan Ruslichenko
> > <ruslichenko.r@gmail.com> wrote:
> > >
> > > On Sun, Dec 28, 2025 at 5:59=E2=80=AFPM Peter Maydell <
> peter.maydell@linaro.org> wrote:
> > > >
> > > > On Fri, 19 Dec 2025 at 22:25, <ruslichenko.r@gmail.com> wrote:
> > > > >
> > > > > By SMMUv3 specification it can be attached either to PCIe Root
> > > > > Complex or regular IO bus devices. However, current
> > > > > implementation only allow to associate with PCI bus.
> > > > >
> > > > > This patch series add support to use SMMU for sysbus devices.
> > > > >
> > > > > One usage example implemented for virtio-mmio, which allow
> > > > > devices to perform DMA operations SMMUv3 with address translation
> > > > > and isolation.
> > > >
> > > > If you want virtio devices behind an SMMU, why not use
> > > > the PCI virtio?
> > > >
> > > > The only SMMU sysbus requirement I'm aware of is that for
> > > > RME we will want to have things like the GIC do GPT lookups,
> > > > which is most conveniently done by having them route through
> > > > the existing for-PCI SMMU, rather than by having an extra
> > > > SMMU just for them.
> > >
> > > There may be several reasons for supporting SMMU on sysbus:
> > >
> > > Some embedded platforms may not use and don't want to include a full
> > > PCI subsystem, but still want IOMMU isolation with virtio-mmio.
> > >
> > > The other reason is to emulate existing SoC platforms. The model may
> > > need to be closer to real-world HW and SMMU is widely used outside th=
e
> > > PCI subsystem.
> > >
> > > One more reason is Remote-Port devices in our case, currently ongoing
> > > development here:
> > > https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg02121.htm=
l
> .
> > > Those are platform devices which are emulated by external services.
> > > These devices need to perform SMMU operations for DMA transactions
> > > when they are bus-masters.
> > >
> >
> > A gentle ping on this series.
> >
> > Hi Peter!
> >
> > Do you think we can continue discussion on this topic?
>
> We would want a reason that applied to upstream QEMU. If you
> have a platform that uses this that you're modelling upstream,
> we can think about the SMMU parts of that at that point.
> At the moment all this patchset does is let you put a
> virtio-mmio device behind an SMMU, which is something I
> don't want because it's a pile of extra complexity for
> a use case that is better handled by using PCI.
>
> thanks
> -- PMM
>


Hi,

Xilinx Versal boards have AMBA platform devices (non-PCI) that sit behind
an SMMU, this feature would be useful there.
I haven't looked carefully at this series, but the way we implemented it in
our Xilinx tree was by changing the SMMU code to use the Memory API rather
than use a parallel interface in both IOMMU and DMA devs. Instead, DMA
devices stay the same except that they need to be able to set their
Transaction ID when issuing memory accesses...

Best regards,
Edgar

--000000000000a9409d0648c00b2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 19, 202=
6 at 3:57=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lina=
ro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, 19 Jan 2026 at 14:42, Ruslan Rusli=
chenko<br>
&lt;<a href=3D"mailto:ruslichenko.r@gmail.com" target=3D"_blank">ruslichenk=
o.r@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Jan 2, 2026 at 4:36=E2=80=AFPM Ruslan Ruslichenko<br>
&gt; &lt;<a href=3D"mailto:ruslichenko.r@gmail.com" target=3D"_blank">rusli=
chenko.r@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Sun, Dec 28, 2025 at 5:59=E2=80=AFPM Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Fri, 19 Dec 2025 at 22:25, &lt;<a href=3D"mailto:rusliche=
nko.r@gmail.com" target=3D"_blank">ruslichenko.r@gmail.com</a>&gt; wrote:<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; By SMMUv3 specification it can be attached either to PC=
Ie Root<br>
&gt; &gt; &gt; &gt; Complex or regular IO bus devices. However, current<br>
&gt; &gt; &gt; &gt; implementation only allow to associate with PCI bus.<br=
>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This patch series add support to use SMMU for sysbus de=
vices.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; One usage example implemented for virtio-mmio, which al=
low<br>
&gt; &gt; &gt; &gt; devices to perform DMA operations SMMUv3 with address t=
ranslation<br>
&gt; &gt; &gt; &gt; and isolation.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; If you want virtio devices behind an SMMU, why not use<br>
&gt; &gt; &gt; the PCI virtio?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The only SMMU sysbus requirement I&#39;m aware of is that fo=
r<br>
&gt; &gt; &gt; RME we will want to have things like the GIC do GPT lookups,=
<br>
&gt; &gt; &gt; which is most conveniently done by having them route through=
<br>
&gt; &gt; &gt; the existing for-PCI SMMU, rather than by having an extra<br=
>
&gt; &gt; &gt; SMMU just for them.<br>
&gt; &gt;<br>
&gt; &gt; There may be several reasons for supporting SMMU on sysbus:<br>
&gt; &gt;<br>
&gt; &gt; Some embedded platforms may not use and don&#39;t want to include=
 a full<br>
&gt; &gt; PCI subsystem, but still want IOMMU isolation with virtio-mmio.<b=
r>
&gt; &gt;<br>
&gt; &gt; The other reason is to emulate existing SoC platforms. The model =
may<br>
&gt; &gt; need to be closer to real-world HW and SMMU is widely used outsid=
e the<br>
&gt; &gt; PCI subsystem.<br>
&gt; &gt;<br>
&gt; &gt; One more reason is Remote-Port devices in our case, currently ong=
oing<br>
&gt; &gt; development here:<br>
&gt; &gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2025-=
12/msg02121.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu=
.org/archive/html/qemu-devel/2025-12/msg02121.html</a>.<br>
&gt; &gt; Those are platform devices which are emulated by external service=
s.<br>
&gt; &gt; These devices need to perform SMMU operations for DMA transaction=
s<br>
&gt; &gt; when they are bus-masters.<br>
&gt; &gt;<br>
&gt;<br>
&gt; A gentle ping on this series.<br>
&gt;<br>
&gt; Hi Peter!<br>
&gt;<br>
&gt; Do you think we can continue discussion on this topic?<br>
<br>
We would want a reason that applied to upstream QEMU. If you<br>
have a platform that uses this that you&#39;re modelling upstream,<br>
we can think about the SMMU parts of that at that point.<br>
At the moment all this patchset does is let you put a<br>
virtio-mmio device behind an SMMU, which is something I<br>
don&#39;t want because it&#39;s a pile of extra complexity for<br>
a use case that is better handled by using PCI.<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div><br></div><div>Hi,</div><div><br=
></div><div>Xilinx Versal boards have AMBA platform devices (non-PCI) that =
sit behind an SMMU, this feature would be useful there.</div><div>I haven&#=
39;t looked carefully at this series, but the way we implemented it in our =
Xilinx tree was by changing=C2=A0the SMMU code to use the Memory API rather=
 than use a parallel interface in both IOMMU and DMA devs. Instead, DMA dev=
ices stay the same except that they need to be able to set their Transactio=
n ID when issuing memory accesses...</div><div><br></div><div>Best regards,=
</div><div>Edgar</div></div></div>

--000000000000a9409d0648c00b2b--

