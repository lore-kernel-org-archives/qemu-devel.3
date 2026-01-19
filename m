Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71000D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqgM-0008Te-3K; Mon, 19 Jan 2026 09:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhqgK-0008Rm-AT
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:56:40 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhqgI-0001sV-9g
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:56:39 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-792815157f3so41040807b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768834596; cv=none;
 d=google.com; s=arc-20240605;
 b=bChvtaE1NY6qX/S6td4e5qXB3JAcc5baTkZe9C5x8ET0sUjE1JkeBU/g7ABGCeSCXr
 wBui25WvMdN8z/pD1JsHd7ljcILWloDrXGv1JYOQSDH3lMJ77+zvt5rE3ps6lNfu0Gj6
 O1BoaNXvc92kjq//7JFPxpDpZvRny68JC8WkrqsfOG9WqsNUxLQ9WOYHaiJXD/2WI32v
 DmHBiJRUccVfR3tnAIyu6LQCl13USaW/W8/vtFs2u5PxFuFV3I5wlrCD4xcqZUUVYGAq
 btMuefBwlaTH0ptad3iP9ADY10AY1HZUWwAlaJy4wkYOdlKDulvJiKWvqzm9JLymuVKx
 A/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PV3uDDHeBQqQAA+JqObzoR5c3i9CNy2IcPcrQh2YKDk=;
 fh=mxOK504LPUtl5SDPVtU9w8ujo9R0CRqtrceJ4RPCQrI=;
 b=OuAfYP6WoP1tWq7D01GywDFNgwQstzq67MIreJ+PWZgVuLfOTSXcZrHMFxHjkhGZHB
 gvfA+G8JbNiAegLyuPCzp7bVK/FJp0HZMSv2RgjtlOl+Hf9GHQBUzTm6hvlFgt+kYVwf
 +4U12zuLXzAQ+PCus6HftWmwMjVO/wRrup0uhDfXgzD14+K6+TKjGNIi7rjOZZ0Z9VQ7
 gikrG8Y26e/3Eqo8ubAsK6h//XoMqwWJg+yRlUeupZ7Z64euZS83q7iwFDrKcRVQG6KG
 J3dVWjXWYKd+3MbNa3YPtAbLk54L56f/+VxgCaqfo8Amg/XlDHPfHFq7VBCxFNTvZW3b
 DWHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768834596; x=1769439396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PV3uDDHeBQqQAA+JqObzoR5c3i9CNy2IcPcrQh2YKDk=;
 b=CZDRoI2b3ddzfpiPyRuSQwdJzv+Al2w4/7jx1WQpIFEVUSCXJd3MGmitRFDQVlr3Yp
 XNUodPQutlzSipPj/Qk3f4vRuO+TN524yKbX2oo+PWMmsKrrvVn8zO5OIH6nC7dWy95F
 DY3C5LxGZ78XUwnF8RLO5J1+DvH50uJ7sU5P6bLNCLJATt4CE4cBjtdWcq4jh9sC/SFQ
 QuJLNkjNwfT+Ki4n5IwCTLlqMBzt2vjag3yU6yxPucexh4t9zpBq1RSUPvJ9kF7SKoVG
 07fGuHHHMWFTn27ge/Z0cYhXdOLkHRxGlASyEyOXzmfW04H11uFJJdwP/gKnEoQUYAnx
 YMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768834596; x=1769439396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PV3uDDHeBQqQAA+JqObzoR5c3i9CNy2IcPcrQh2YKDk=;
 b=ClpHdjKAgLoJooEtBZkSpYU72I7c6HMRxV2LWZGuYm+P+EfD1/IPplBusHgQ66btXC
 M5SHWnDOqda7lSi2QaImeV5jgzvi44D5pkzvZ/O7+SHylc3RfKIgPyn+eU4mnRHvkSPc
 +JfsvUks7y/Lf+7esTU7hfj/GJl0G4EehtFFEZymADQHX/RkM7qq8s9MUakRoJCC/wHO
 IkX7ZvS69lqIb0G6UckvhcDVRDZ42IhD70GVvzt+d5M2/uHVUM2rtNPBTtNgx/UlYyFP
 Hy0excaOKSie4UtvDw3ibcqbVS5DUMho8qTUaQzftDuJsKkGRdMOk1CYux//mqeQCAfz
 TZFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdsf4cN9Q+gcvhzf/Y6KMTnfGorDkkWq6zvFC75IWgYw7BWQyABDE/AEF6M1UTea+wYUhkfblHoIDJ@nongnu.org
X-Gm-Message-State: AOJu0Yw4suO4IdY+JvwZBwj4Q+FXhgrTV+vMmD4ySOEUSrhpAwLylpfe
 /6wYrMZIm2AESqG4OJGp7wlGyD2IUW2QODdXauc/iHSpoB8YUnBGOLBOGbMeLH07KrFqIGu6sbC
 5TwdRnd50fXLSuWbcdbHbK+iTWETOG+bDxYr+hKpB2A==
X-Gm-Gg: AZuq6aJwXhZjpP1o4yg6cHqGJGpVX7g0ckE4nftXQVSrPj4237WOG8zKRU3jbC+J4ci
 ozmHpnm4xPsZESZR5/z9O8PNACd9ofGHBskJ8zOYQRXaUOlOIxqMlborPOo7oaj/tdozphy0+Tz
 XNj7RZ1vdFYPPSb/E4J6BWz+XuHkptTMaKSXiMp1gGFJs5bVrM7LTA9s9XkM1qE+dqkxEzoM7P7
 gs7y3adJoEVgicaPyUx6FV9zVzDEQJPirtax3TwTjCZmcDjLp0iwTJOiKdBkLQUdR9fHQ==
X-Received: by 2002:a05:690c:f8b:b0:793:b660:fbd0 with SMTP id
 00721157ae682-793c66ac1b9mr87298607b3.10.1768834595674; Mon, 19 Jan 2026
 06:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
 <CAFEAcA-VYhtvXK5tyVJWfskqqKFim43DsKfWrpaMxteWueR6aQ@mail.gmail.com>
 <CAN-aV1FsbAp3JrqoPgz+c4ORayBjsGxTLWOkDMc0WyE2nD-aZw@mail.gmail.com>
 <CAN-aV1ERa6uE9U8cPArmXCv+WOJhP7ZgGAF2VEDaAEbiebyawQ@mail.gmail.com>
In-Reply-To: <CAN-aV1ERa6uE9U8cPArmXCv+WOJhP7ZgGAF2VEDaAEbiebyawQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 14:56:23 +0000
X-Gm-Features: AZwV_Qh3V4FzOo6fHkjykc-p0iSV0FFIVF6w4bt92UQoQMe1xA08wc4CK13j6ec
Message-ID: <CAFEAcA8D19toNxsLsRcSoLgBAGVnV8OXWLP41m7aTLsNSw++PA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] hw/arm/smmuv3: Add SMMUv3 sysbus support
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 19 Jan 2026 at 14:42, Ruslan Ruslichenko
<ruslichenko.r@gmail.com> wrote:
>
> On Fri, Jan 2, 2026 at 4:36=E2=80=AFPM Ruslan Ruslichenko
> <ruslichenko.r@gmail.com> wrote:
> >
> > On Sun, Dec 28, 2025 at 5:59=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Fri, 19 Dec 2025 at 22:25, <ruslichenko.r@gmail.com> wrote:
> > > >
> > > > By SMMUv3 specification it can be attached either to PCIe Root
> > > > Complex or regular IO bus devices. However, current
> > > > implementation only allow to associate with PCI bus.
> > > >
> > > > This patch series add support to use SMMU for sysbus devices.
> > > >
> > > > One usage example implemented for virtio-mmio, which allow
> > > > devices to perform DMA operations SMMUv3 with address translation
> > > > and isolation.
> > >
> > > If you want virtio devices behind an SMMU, why not use
> > > the PCI virtio?
> > >
> > > The only SMMU sysbus requirement I'm aware of is that for
> > > RME we will want to have things like the GIC do GPT lookups,
> > > which is most conveniently done by having them route through
> > > the existing for-PCI SMMU, rather than by having an extra
> > > SMMU just for them.
> >
> > There may be several reasons for supporting SMMU on sysbus:
> >
> > Some embedded platforms may not use and don't want to include a full
> > PCI subsystem, but still want IOMMU isolation with virtio-mmio.
> >
> > The other reason is to emulate existing SoC platforms. The model may
> > need to be closer to real-world HW and SMMU is widely used outside the
> > PCI subsystem.
> >
> > One more reason is Remote-Port devices in our case, currently ongoing
> > development here:
> > https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg02121.html.
> > Those are platform devices which are emulated by external services.
> > These devices need to perform SMMU operations for DMA transactions
> > when they are bus-masters.
> >
>
> A gentle ping on this series.
>
> Hi Peter!
>
> Do you think we can continue discussion on this topic?

We would want a reason that applied to upstream QEMU. If you
have a platform that uses this that you're modelling upstream,
we can think about the SMMU parts of that at that point.
At the moment all this patchset does is let you put a
virtio-mmio device behind an SMMU, which is something I
don't want because it's a pile of extra complexity for
a use case that is better handled by using PCI.

thanks
-- PMM

