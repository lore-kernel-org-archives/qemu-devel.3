Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2CFCD3427
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKSih-00053X-H6; Tue, 05 May 2026 23:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKSif-000530-Nm
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:14:41 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKSid-0008Ey-Mk
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:14:41 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so921182166b.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778037278; cv=none;
 d=google.com; s=arc-20240605;
 b=SRR8SgTkRFOuZEaG71WotOjE7G3qa+yHpmDmSabyuqxi1I6wWLz00EsBDEhlmCJAZY
 6qGL9TeZz01L3mfQyqu7YUvsnltcskHcMGUJe8k8bJVrqZZezj86WVZqOBSr1kNNG7Y5
 UPe+Jm/KGcPw8uNSRyI0hMYQrDXWbKlxQJ3zZDfYx4zR7KUQ1ARQjjPzXB8eo6v9iMlo
 f1K3WrabftYaGg01LK7Ky2OJjFfdlfMG0fjM3X8EwZ51Oas7USGuzEc0/gjTZAKeB8vi
 zZr7Mz8fO1DKgeVe37pBE90CGeWBghBz3oiPXmDj1DeKzGys40cszXYEZF+tZPqP3wy6
 frDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T9IHJfJR6r8P5Mo9Q1YoxQfXMJ2RPaBEpcDXIAZSn0c=;
 fh=1cne10oFvJZzSDWs9hTPTozYvfDCwXr7cHTMf6dXI/0=;
 b=dxaO1JoZ4gxd8WpbxOA+qqg6x7Ab6jNJjLyOAwK+/rPG45+mWvMNzulmKXXdg23Tta
 rutvp6GBEjU3VPTS0qhuxoMeuLHpcRqqiL2/t0+jcy+AhwJO8CGAZoe6GBJqSDhbXAbu
 F2PXV7yz7QlWHoRLneSftxKFui+hbOHYkXzuTbwORI2Eh6r1eIdTJOMUxrJOsSce/Sfc
 Lxy1WUNIQYVHIGGdgL5cSvAGCz+OZFmbHHvFulTRws4le9QpJAfWenKr3nbMKVFDAo3S
 BGjPiW6/2KafUIb476jUIAOysR9R7K8WjtP76FIKjevTtXTWnj9P1iAHFDSccKXJ5OCY
 v5Jw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778037278; x=1778642078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9IHJfJR6r8P5Mo9Q1YoxQfXMJ2RPaBEpcDXIAZSn0c=;
 b=Q41pQxRs23xuNszHZ6cjZfEJ7J9neKCnVYf9LOCxQbgC2t9YBzQNT+5/pFuJiBO8tc
 pMUBc4LAt3PCijgFuKvZ+7gGR3dt2wYYkhZCG8HaDMvenLsqdDpTqRPgTi0JdwLByuo3
 e55mo+UAnHWdrIGCz2haZkdyD6jwLKqyxd1HV7A0eaxR1M2nkpehD86bX8I5+Y6RNOwN
 +Xr3uV5IV76Iyqxodh9kmNNs+swVFaBoB6TQf08yWIPDMOaWAUHGa4JynfxZn+SrAGqk
 WbFQqOPyTIJEZvXj32OREukwZS2EJZjvQTkMOk1yK9Wn+b0uZhS77v81OcAHEDpPrItP
 6WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778037278; x=1778642078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T9IHJfJR6r8P5Mo9Q1YoxQfXMJ2RPaBEpcDXIAZSn0c=;
 b=GUxiJSgAJzCr3zv8hUEAb2dOZT91cIE7s1dMXCMtUF8n6mZpqJ0FW9meT14b4+/Iy+
 HHeoZaJzbQuH/+YAsXdT7116BABMjnkgDw1SPq41P0FxsWRdK8hfP2/ydQ8+AoVH3vEP
 F8teUU0QmoHby519/7MGPTH0wB/zGAuthaJsok2+f41bp0NCjL6ZBZhhdSD7adx7bCyL
 8BH7gnMvY9ws8OW83qyKLdr+nLseIylv2fsj1XTtVw80pPQdyAIziJxnjyp1Hh6EQxDi
 Ha2+D9PSijjvrDPQn3gra6kyqem4zbJb4215rrMwqtS/F0l/EUGndcXp2OwFBADySQoO
 HCYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tNYFaNeTx4VxDjNodRTlqZU8aODQIzujMbWz7tuy4XWt/DYS70zmly0wFWpbRyZNTFBzOAmD0cOpa@nongnu.org
X-Gm-Message-State: AOJu0YxcLVisnNvtxFqhYaeWc6qjFTxoJObJxEOL3x3YTk5wjZZxXuS2
 1x2HDY2LDbhn8INbTu/mHQmlWsy/8UTAONg1a7C9Yo+Qq2KrHx2aP6X4wFeOwKfoghrg7+XYWMb
 Fmo0D2B1Ax7GfbHvB0f/UMnlnv5xsGvw=
X-Gm-Gg: AeBDieutFquknjaGFMIjCMKMZLLbRfqQyfI+qO8lWo3xm8i7P9oGXUENqeUyiagsosg
 MAcNb0i2jG8UioxiBoV/e679JMkej+n84x5BEjufwGgmkm+xuGYVj74aPpLutqDsIxr1Ge5pOrH
 TWalU8Wl26999a60T2IMWEZCemeA2K2+HI1hIHYehdgDY7SGM628JZOicrfB6eUBw0l/HdsDcKG
 XxYwcZlghHVkvCBDlGeiUjsdtG9cQk4YxfI2dcBPlLds/KyTGocyCJk1lejNqrhZJ1TYUEPaTKJ
 QqL9OCitwJs1jk52+dAQunSZQVbL8Av4xNs1zmtEmHdcmxPF
X-Received: by 2002:a17:907:7fa5:b0:bba:6ae8:5269 with SMTP id
 a640c23a62f3a-bc56ebf08damr52622266b.30.1778037277283; Tue, 05 May 2026
 20:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <afk0kVtQGz7OZ65_@lima-default>
 <CAKmqyKMbWXFBSuiKyp1uQ5TBhFAEex961Jzp4To5uyBzuUGMBQ@mail.gmail.com>
 <afl6x1CTIx2jvMH0@lima-default>
In-Reply-To: <afl6x1CTIx2jvMH0@lima-default>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 May 2026 13:14:09 +1000
X-Gm-Features: AVHnY4IT4nydaaNKaZDCtgqaoshHylaz5v6m9Rb1dytXsNGAUPgF7yMJ-Hr2lBY
Message-ID: <CAKmqyKOL9fsJcxmUK6SOMvcWqxtT69t8qj5Brmk0nnQO_ZQAkQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 5, 2026 at 4:00=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Tue, May 05, 2026 at 02:34:50PM +1000, Alistair Francis wrote:
> > On Tue, May 5, 2026 at 11:04=E2=80=AFAM Nicholas Piggin <npiggin@gmail.=
com> wrote:
> > >
> > > On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> > > > On Sat, Apr 25, 2026 at 11:20=E2=80=AFPM Joel Stanley <joel@jms.id.=
au> wrote:
> > > > >
> > > > > The Tenstorrent Atlantis platform is a collaboration between Tens=
torrent
> > > > > and CoreLab Technology. It is based on the Atlantis SoC, which in=
cludes
> > > > > the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Techn=
ology.
> > > >
> > > > Can you provide a link to documentation
> > >
> > > Also not presently.
> >
> > Hmmm... That's a bit annoying. Can we get some?
>
> That's the plan but I don't have a date I can give you for it, sorry.
>
> [...]
>
> > > > > +static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_p=
handles)
> > > >
> > > > So generally we only create a device tree for virtual boards, that =
is
> > > > boards that don't really exist and are just QEMU constructs.
> > > >
> > > > You said that this is based on the "Atlantis SoC" so I assume it's
> > > > real hardware. In the real hardware do you expect the device tree t=
o
> > > > be provided by the ROM? Usually for boards users supply the device
> > > > tree as part of the boot flow (via u-boot or something similar). In
> > > > which case should QEMU actually generate this or can users just sup=
ply
> > > > their own?
> > > >
> > > > Basically the question is, if you are trying to model the hardware,=
 is
> > > > generating the device tree here correct?
> > > >
> > > > Obviously the advantage of doing it here is then the device tree
> > > > describes what QEMU supports, which is great. But that can be harde=
r
> > > > to manage when the hardware doesn't do that, as then you have
> > > > divergence.
> > >
> > > We went around this same discussion internally and yeah it's a valid
> > > question, we could have explained this a bit better.
> > >
> > > In the real (unreleased) hardware and the DT will be loaded from ROM.
> >
> > Really? That usually doesn't go well
>
> Well not ROM but flash loaded by early firmware. The plan is to have an

Fair, when I say ROM I guess I mean ROM or rarely changed firmware,
not specifically only ROM.

> "M mode" dtb loaded for opensbi and then later stages supply their own
> dtb.

Ok, so the "hardware" will provide a DTB to OpenSBI. In which case
this is the right approach for QEMU.

Can you document that in the commit message?

>
> The opensbi dtb won't go away from the tt-atlantis model, whether its
> generated or we change it to use a dtb for the purpose of QEMU. I guess

You can ask the user to supply a DTB, which is passed to OpenSBI (and
then other layers).

But if you expect your hardware to provide a DTB we should match that.

> if the next stage does not have its own dtb it can use one supplied by
> opensbi.
>
> Does that sound right? I don't know if I have the details exactly right.

I don't know either! You don't have public documentation :)

>
> > > I think we should do that when the model and firmware and dt is more
> > > complete. At the moment it has been easier for development to use QEM=
U
> > > generated fdt.
> > >
> > > Is that acceptable to do that now and switch to a fdt ROM later...
> >
> > Obviously guest software can decide to use whatever it wants. But what
> > we don't want to do is break users. So removing the generated FDT
> > (which is the equivalent of ROM FDT on hardware) will cause breakages.
> > So we don't want to do that if we can avoid it. Also generating the
> > FDT is overhead for us, so we only want to if the guest software will
> > actually use it. Does that make sense?
> >
> > Adding the device tree later is fine though, as guests don't have to us=
e it.
> >
> > >
> > > [...]
> > >
> > > > > +static void finalize_fdt(TTAtlantisState *s)
> > > > > +{
> > > > > +    uint32_t aplic_s_phandle =3D next_phandle();
> > > > > +    uint32_t imsic_s_phandle =3D next_phandle();
> > > > > +    void *fdt =3D MACHINE(s)->fdt;
> > > > > +
> > > > > +    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandl=
e);
> > > > > +
> > > > > +    /*
> > > > > +     * We want to do this, but the Linux aplic driver was broken=
 before v6.16
> > > > > +     *
> > > > > +     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt=
-parent",
> > > > > +     *                       aplic_s_phandle);
> > > > > +     */
> > > >
> > > > And now we are stuck with hacks like this, which we really don't wa=
nt
> > > > to be dealing with. Maybe it's best to leave the device tree to the
> > > > kernel.
> > >
> > > ... Despite issues like this?
> >
> > If the kernel generates a device tree for it to use then we don't have
> > mismatched problems (like this one). Generating the DT in QEMU for
> > real boards proves to be a challenge and this is exactly why. Now we
> > have to choose between pre or post 6.16 support (I assume 6.16+ works
> > without this, but you get the point).
>
> Yeah I see do see why we'd want a Linux one, and we are currently
> upstreaming dts for Linux. At the moment we don't have it so using
> the firmware stage one fills the gap.
>
> It is a little bit hacky maybe but I guess I'm not seeing where a
> compatibility problem comes in versus other systems with their own
> firmware DTB (that I assume a next-stage could similarly use and be
> exposed to these issues if it did not supply its own).

The difference is I don't have to worry or maintain changing firmware :P

Basically QEMU providing an FDT increases the machine complexity and
maintenance overhead. Admittingly it has probably improved now that
RISC-V has stabalised a bit, but it used to be much more of a hassle
to deal with.

So we want a reason to do that, as once it's merged we are mostly
stuck with it. Adding it just to simplify development now isn't a good
reason. Adding it because that's what the real hardware does is a good
reason though.

Alistair

>
> Thanks,
> Nick

