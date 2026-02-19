Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2211E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 16:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt6WU-0000WW-U2; Thu, 19 Feb 2026 11:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt6WK-0000WA-Lo
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:04:54 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt6WI-0006VR-Vi
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:04:52 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso957874d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 08:04:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771517089; cv=none;
 d=google.com; s=arc-20240605;
 b=NSRVhXJxrgchhLIIutcetf5LkctkSlkePiOUaOAxQhVrW3nkNSOVdbQO/S1QJia7Gk
 VKphg55j5fKYHyy8ayex9Ogs2wcwdrliejcQA+sbASFszFbv46L2wkBUeRmDOg4T3ZqS
 loAI777ZdlfvDALkGbKSbGGOHLZpbS194h1VS1NiVSFy4LibrbO+r+RokGQwl6S8q+E9
 f1Tqt2a9yeiAIasOO+cGnTh0eOf9TrwmMEh2WJ+UyaIRoQb3K2QPV6zekuqetrDRKABQ
 +AZQQTept6itjfiyFrBToMOX2hFOyTp52veuASXDDV/2VHb+wnZ4VEyUlHpZgQc0ta+x
 84Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YmAycqLONF4rr8p+WORe1ZY88PsO6lYPBq9j6R31F24=;
 fh=QKWwYWnU74tEpagxyzKMxXfdzss8yZtT/YtRGw+kJm4=;
 b=XUhmMO5dnv4iBf2LHYLinixyPwSG6uzNNN51ykYGuulo+9U42EK3h3Ql64A1gtPWK1
 KjdDV7F+R3/rA31v5nsQRMifuhd9/mPJMHQFOim0aH2w8kbLMdgDmAXQ/ehFD+rm4dTm
 QVUo/PfJqfPS+H2Sqf/Z4Z4ywGhNQEwA8OONsB5K4oNy8YolMPG22VZ6jduLnEDgDi8l
 UCm71RDqOtsJE5yLiuStLEtoB6ao3RDDPTgxHNlAa9txpgqHbiWV4kRAOcgrbR1jV6z6
 5+MMeJDvSkeEHqZo4TriRP/lulT0VUiBh7EMw1oXkqzfZ1IgjWHE7+dHv0pYSAYSYI14
 K5JQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771517089; x=1772121889; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YmAycqLONF4rr8p+WORe1ZY88PsO6lYPBq9j6R31F24=;
 b=w0OgrYv+bojQqa7JJoSQ0nDjuTC5tRIaMM9aGMLKgh3VvV4kP4hsrnw6ALj7kt4n0m
 H2t6EzDrQybeegwODypmeVtogIeCdk/nVXoHiyz/Qpt6O2CUdYI+3CKo6rfAeHQd0Gja
 a3dXTyekWsq1bmdpdjln+9gaIEkpUJgFxtla2zNvbPxyLXRBZnOlS8IkS7ghkIv6k/L/
 O+k7RZcGcfD2t1jS+KT0ShNOIwxZJw3+Ke+TFzk2i4MiD0WSxW1xkFdGfSu+fJN6H0vz
 ZoBHN6WKust76DwnXI2Ba4YOQ1FcSeonhp7bKq8RP54BBDxjoaCy7qF6Egg6m9ezbarD
 Ge+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771517089; x=1772121889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmAycqLONF4rr8p+WORe1ZY88PsO6lYPBq9j6R31F24=;
 b=iJhFIDcY6wgw24GyhN5l4Iu7QVrZVIvKlLyCob7djXnxWWn9IMDFnIE73vjtAiP2xy
 nQU4yy011x/VUaZ6R7QNeN/RpDR25E2tavB6qq5DXxqcQKL966HXg3oX5Pp5OY/f94oJ
 wja2o7eULiZp0gRhX2wEtrmmihzuMlHFU/rec6D0r4POiqHmFS9PKJqn5pSZSwvvhuNO
 n0h9laxWhChqPSzFnQqqGTQKTlkDZ7PeR1HcTejxpM2WaGWbYCGlwD8IhRWk2MrnOUPH
 tfukvTj2+qb2+rvFNiYW7TOAewOpSlqrklwR+qJMm3oKFVAsQYu59NL9eGtiwgL9wVj0
 4MIg==
X-Gm-Message-State: AOJu0YzMDj8/bBYkPHJ5MrFDFsolIv1PPGrs4A6JxL8zb4SemJJnebiA
 T24LCjiK+i90CHJtgX5oEDfBiNh3WFX2xuYuDeWmBFfDsmhun5Mrfc9V1vjmLXY75r3wBQf4Mfw
 8Q7kQ4acVhpdvj2IWLWWV6QYaBGqTVtV3OsVwPadj1w==
X-Gm-Gg: AZuq6aKezd1oEFfCTf0ZUvuQmuNvUKRbOkxb9we+NGgpELqDNxm0sIfit3xKuGJaUAK
 PJa/c0d/Kz1k700CQWWE1XYShx5MU3FMcl/OBm7DYlu/Xt3NeDPvO+PcBZ/4ghjXGUNnPF/r8Cv
 VtaniXMiv9ielCTFL4Muci+/+6fv2K052h8cOgnd6V25JHYl0cPc9vrhxfx2dnqTAttqIXZSRWs
 4iY4qTX3FnT8L8F0u6tuEdmcVwJO1J7FJfKHkdnTyLklgg4oHEJ6afQ6wAs/+FZpCgxLvY8DaD1
 Ga94QfC7w13n/XmXI9r+U9MSYQWsEI4TSBjOChE1FUDZydJX36fM0P/BQuxqY/KCfjg=
X-Received: by 2002:a53:acd0:0:10b0:64a:e80c:8ab7 with SMTP id
 956f58d0204a3-64c61515b47mr1882420d50.92.1771517088680; Thu, 19 Feb 2026
 08:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo>
 <CAFEAcA-qaSRM9MJDk2nhDQKWoP7odcou2DXff-fuYPNEE=g6vg@mail.gmail.com>
 <20260219155538.6e0b5a4f@imammedo>
In-Reply-To: <20260219155538.6e0b5a4f@imammedo>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 16:04:37 +0000
X-Gm-Features: AZwV_QgClV84AbVFWNm687xH8KE9HblarBMYudZKKg3CpSokcZMsXbE1462mwT0
Message-ID: <CAFEAcA_v4Y5NEiYZsTyQPt=orc8gxGJ_PWu55T_0mAt+iY4OQA@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 19 Feb 2026 at 14:55, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 19 Feb 2026 13:00:13 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Thu, 19 Feb 2026 at 12:17, Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > On Wed, 18 Feb 2026 19:08:36 +0000
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > > > Please can you also add support for exposing this device
> > > > in the device tree ?
> > >
> > > It's possible,
> > > but we probably should not enable it if acpi variant was requested,
> > > to avoid confusion on guest side.
> >
> > Why? Almost every other device on this board we advertise
> > via DTB for device tree guests and via ACPI for ACPI guests.

> If we expose both guest may try to load both drivers causing conflict or misbehavior.

Huh? A guest will do one of:
 1 read the ACPI tables, and load the driver based on the ACPI data
 2 read the DTB, and load the driver based on the DTB

Nothing tries to read both at once, or it would get totally
confused.

> I can try and see what arm kernel would do in presence if both
> but that's not the point.

We know already that this works fine, because almost every
piece of hardware in the virt board is described in both
the dtb and the ACPI tables.

> One should consider plain GWDT whatchdog as a different device
> when compared to WDAT one.
> The later one is basically an synthetic watchdog with it's own driver.
> From guest pov they are different devices (using the same registers/irqs).

But there is only one piece of hardware here, right?
I don't have an opinion on what the best way to tell the
guest about that in the ACPI tables is. I just want us
to report the presence of the watchdog in both DTB and ACPI,
so that it is usable whichever the guest is using.

> > > > Can we have a command line option name that isn't ACPI
> > > > specific, please? There's nothing inherent to ACPI about
> > > > "I would like a watchdog device".
> > >
> > > that is specifically asking for ACPI flavor being used/configured.
> > > acpi specific option conflates 2 things:
> > >    1. watchdog device creation (of the board choice) with properties tuned for WDAT usage
> > >    2. how to expose it on firmware level (in this case ACPI WDAT table)
> >
> > Right, and I think that's the wrong way to approach this,
> > at least for the virt board. We should either always create
> > or allow the user to ask us to create a watchdog device.
> > And then we should do what we do for all the other devices,
> > which is expose it via both the mechanisms that we have
> > for telling the guest about hardware (ACPI and DTB).
>
> Looks like I wasn't clear, WDAT is not a description
> of the hardware watchdog. It's a 'abstract watchdog device',
> that uses a set IO/MMIO operations from WDAT table to manage
> whatever hardware watchdog board provides. Guest uses WDAT
> specific driver to manage it.

Does the user need to care about how we report the hardware in
the ACPI tables? Is there not a way we can report it that works
for all guests?

thanks
-- PMM

