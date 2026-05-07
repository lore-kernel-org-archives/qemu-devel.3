Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11086CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKosb-0003eb-9W; Wed, 06 May 2026 22:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKosU-0003dv-O1
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:54:19 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKosS-00042d-Ms
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:54:18 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bc23bebd345so63699366b.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778122455; cv=none;
 d=google.com; s=arc-20240605;
 b=C2kskSPxVW05mPmANCOOMPZ4FgTxU84zzXWSC8t5cGqPe5PAu2Mqz9UrWY90O9bHiC
 sJgxTVaEOG579fRPxGEPc9slNhp8fAzpHOKVNh0ZmawiHg9ve5eqQJgnYXkLmnjDmd+T
 M4kM9l1o+3kYBn3VJX3Bu6DS+XONK078qgprMN1qhYovKW2SW7tu3K3iMh5Ag3KYyPda
 +8dmL7lr8RrmSHtuUlbtsQ88BmMfdNKJHc6SdGnc4jpdFeGWU4Q4E4NgNdgflcaeX+Ys
 DzbazDaoL3NZVveLLaA6EGHDPkSr8cx2fKfgwNpTYwzL7Td12hU4SCpnyXEDFNBLyMM0
 cOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B5YUVhLRRQ7q5asXI3X+gdY38RtLSahE++lM/Ut933M=;
 fh=ThXf13L7Ptoo4FK2h80LhA12RBpI+8/m/b5VtA11sFI=;
 b=HjJDAygomWzFlpHXESxnV7QlsB/MPlDmyFdiEatvMDvmB7MiuyX5f5muh5locHRvV8
 TdfrxfO3mnRZCE24ViQKzM7NLUQbFo2kUh3QmGRHMFm0TMKRrj+7ZHQK9jdvAsIvGKa9
 g5nD/h9MAgHDgvMiF2Zpe3Hv+VdL+KbkaVylJJ9JxW1A7ohfAWooU3MPPL6T/mmMWadc
 4R0UBSR5L6+hN1A/FUBegrII6SReiJuV3VLt3oFbA0YXJSd8so6BpbDdcqZEaZqNEvIv
 KsM+BTgyn5PDO2G93mv1jNzrMmrdjqa4HmuZTR5C2EfrTc5wuqZs1L/1a03/nn1EaVHW
 8HNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778122455; x=1778727255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5YUVhLRRQ7q5asXI3X+gdY38RtLSahE++lM/Ut933M=;
 b=Ys24+BbNgIJXlASBKOFOF0oOGuHPzcxZPgS7OoUGdC8BTfB5KuzqIkumSKPW22kQq0
 /nhr+8gq5xstIGPuDCwHF0sOaRysE4IQ+ksvb3/Iplcx5UjV9L/Er3VZ4uArywz7q5Pr
 w1uuQJqBfTeMDMZ0kBh5GOpib4eUB/MYbwKEwby/hbvnelkUqjrxBcFDI0o7yYAX/1c3
 CWK7i6s10IOd+01cQUG8vzKxLeNiAiegrQgmre8kR6Nzb1ZzbVt/fxFOEGXWPSX+VNBV
 8dpgkUguNSA8tKFHpOiyCh6XV7CT5y5GsP94M+9ndj5M2Tq+XnMx8LG52oHSQpN5uVED
 sbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778122455; x=1778727255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B5YUVhLRRQ7q5asXI3X+gdY38RtLSahE++lM/Ut933M=;
 b=QmvMt2rNSBggAIK3HOrQKP1cu0FTzWHcucz0hhF/L6mUX3BfEECfbMpwHX/ZK96ftW
 hS2ftFrBI1prpEboSkr/3Opty0mqwt/TJjYYdZj69L1n3wfK6zt3NvEM5YFYIRXvVvB2
 epZzT7lUXiNpEvLx70uGoT+PeqPOjlbvDCeczOxI3Qt1IMzO/jy3nAPmU7l21pSgat64
 ute4nkGhyyZQpXTwudCqIXeqvVY1Bmg5IBOj4Bc38d7LgiscktBuxDzWChLP/FeiMTcn
 wVu70Zo3T5l01MNlOowxdjUdfY7VP/A//XiMSmXOE4XJU5Z2cQ+J0FydIRXfWLGJhCAi
 /MEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mtbRSXW1nF+LSyUD4jWT5j6BRRVm6thAzhJAzBc2wsaEGJ0JrpKgHeNWkuxi1Y+RLVDYG9wClzpGn@nongnu.org
X-Gm-Message-State: AOJu0Yy6Yvpr3aIzEGcjufVfKZ9GZRazlui/3Jdnyr1qBeTvngPobrYF
 QvOP3uTTt7ZAAzt+oVVA7r2cJXYvVqXI7TzcZBc6dEM2xWCk2EnAPsWFpOca2Ti2ldyVBCVc/lF
 SOmOxikYnEmEFwsOxH7ziAfQVpb118KDI1P0TGp8=
X-Gm-Gg: AeBDieurXkt0DezQ5SU1Q+J2r7UH6JeeuEA4qkQP1Ao77DuTFhc4AnYhSOZ0W9W6juA
 3vlRIpuMXvg/NJpe3FKH7vSFnfxo18d8Xo7g0BPdnsd1JYD82w02NwKOvB2ugV0NIjg+QOEXBt1
 U6NwNiAjxxbR+H1cdnBPJ6FAYOzTt8HLgp5KI/QQAvJd8Wdnd3c/Oy7rxoR2k8Wm4J5eDFbbvm3
 yzpQXI5pBJSLefA1KUXsj0ByXa4FHHk+81a0T9KloP2eZYXnO8C5wXhHDiTlQ6I1fYsFQdALuor
 6hoAQ5EYTdNt38mjLWT1G+fLqQ69B9Ewu8YXBQuzP9yuFvlGJUsTJ5GCIyc=
X-Received: by 2002:a17:906:c141:b0:bc2:1dab:3eb8 with SMTP id
 a640c23a62f3a-bc85caaab05mr48390166b.17.1778122454702; Wed, 06 May 2026
 19:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <afk0kVtQGz7OZ65_@lima-default>
 <CAKmqyKMbWXFBSuiKyp1uQ5TBhFAEex961Jzp4To5uyBzuUGMBQ@mail.gmail.com>
 <afl6x1CTIx2jvMH0@lima-default>
 <CAKmqyKOL9fsJcxmUK6SOMvcWqxtT69t8qj5Brmk0nnQO_ZQAkQ@mail.gmail.com>
 <afvrfsOBbSC0IJQ1@lima-default>
In-Reply-To: <afvrfsOBbSC0IJQ1@lima-default>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 May 2026 12:53:48 +1000
X-Gm-Features: AVHnY4ItOWdBuPPFQYh2mzftmyxjzOH4u-JbSJVd3FGPxG13tFRkjjK_CZUNUYQ
Message-ID: <CAKmqyKOqWyqQ-OtcwQLpYw+fZyB4BD=sxftJUayu8wHNozRkUg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, May 7, 2026 at 11:50=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> On Wed, May 06, 2026 at 01:14:09PM +1000, Alistair Francis wrote:
> > On Tue, May 5, 2026 at 4:00=E2=80=AFPM Nicholas Piggin <npiggin@gmail.c=
om> wrote:
> > >
> > > On Tue, May 05, 2026 at 02:34:50PM +1000, Alistair Francis wrote:
> > > > On Tue, May 5, 2026 at 11:04=E2=80=AFAM Nicholas Piggin <npiggin@gm=
ail.com> wrote:
> > > > >
> > > > > On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> > > > > > On Sat, Apr 25, 2026 at 11:20=E2=80=AFPM Joel Stanley <joel@jms=
.id.au> wrote:
> > > > > > >
> > > > > > > The Tenstorrent Atlantis platform is a collaboration between =
Tenstorrent
> > > > > > > and CoreLab Technology. It is based on the Atlantis SoC, whic=
h includes
> > > > > > > the Ascalon-X CPU and other IP from Tenstorrent and CoreLab T=
echnology.
> > > > > >
> > > > > > Can you provide a link to documentation
> > > > >
> > > > > Also not presently.
> > > >
> > > > Hmmm... That's a bit annoying. Can we get some?
> > >
> > > That's the plan but I don't have a date I can give you for it, sorry.
> > >
> > > [...]
> > >
> > > > > > > +static void create_fdt_cpus(TTAtlantisState *s, uint32_t *in=
tc_phandles)
> > > > > >
> > > > > > So generally we only create a device tree for virtual boards, t=
hat is
> > > > > > boards that don't really exist and are just QEMU constructs.
> > > > > >
> > > > > > You said that this is based on the "Atlantis SoC" so I assume i=
t's
> > > > > > real hardware. In the real hardware do you expect the device tr=
ee to
> > > > > > be provided by the ROM? Usually for boards users supply the dev=
ice
> > > > > > tree as part of the boot flow (via u-boot or something similar)=
. In
> > > > > > which case should QEMU actually generate this or can users just=
 supply
> > > > > > their own?
> > > > > >
> > > > > > Basically the question is, if you are trying to model the hardw=
are, is
> > > > > > generating the device tree here correct?
> > > > > >
> > > > > > Obviously the advantage of doing it here is then the device tre=
e
> > > > > > describes what QEMU supports, which is great. But that can be h=
arder
> > > > > > to manage when the hardware doesn't do that, as then you have
> > > > > > divergence.
> > > > >
> > > > > We went around this same discussion internally and yeah it's a va=
lid
> > > > > question, we could have explained this a bit better.
> > > > >
> > > > > In the real (unreleased) hardware and the DT will be loaded from =
ROM.
> > > >
> > > > Really? That usually doesn't go well
> > >
> > > Well not ROM but flash loaded by early firmware. The plan is to have =
an
> >
> > Fair, when I say ROM I guess I mean ROM or rarely changed firmware,
> > not specifically only ROM.
> >
> > > "M mode" dtb loaded for opensbi and then later stages supply their ow=
n
> > > dtb.
> >
> > Ok, so the "hardware" will provide a DTB to OpenSBI. In which case
> > this is the right approach for QEMU.
> >
> > Can you document that in the commit message?
>
> Will do.
>
> > > The opensbi dtb won't go away from the tt-atlantis model, whether its
> > > generated or we change it to use a dtb for the purpose of QEMU. I gue=
ss
> >
> > You can ask the user to supply a DTB, which is passed to OpenSBI (and
> > then other layers).
> >
> > But if you expect your hardware to provide a DTB we should match that.
>
> That's what we are aiming for, we just don't have the DTB or enough of
> the machine modeled with QEMU yet.
>
> > > if the next stage does not have its own dtb it can use one supplied b=
y
> > > opensbi.
> > >
> > > Does that sound right? I don't know if I have the details exactly rig=
ht.
> >
> > I don't know either! You don't have public documentation :)
>
> Hah, touche. I meant, does that sound sane? Joel isn't around to correct

Generally software doesn't use the device tree from the "hardware".
The original SiFive Unleashed did, and everyone stopped using it as it
was a major headache.

Instead software usually provides a device tree, often just built from
the Linux source that is being run. That's why we support
`FW_FDT_PATH` in OpenSBI for example [1], to avoid having the
"hardware" provide something.

Which is why I flagged this originally and there is no documentation
to check. But if it matches the hardware (again hardware or early
firmware that you aren't running on QEMU) then that's fine.

1: https://github.com/riscv-software-src/opensbi/blob/2257e9957103aac7df808=
9a59b9d4bdda7c592ce/docs/platform/sifive_fu540.md?plain=3D1#L38

> me! We will ship a machine DTB for OpenSBI, I don't know about the
> mechanism u-boot or Linux use to supply their own DTB vs using the one
> from the previous stage. I suppose that's not the domain of the QEMU mode=
l.
>
> > >
> > > > > I think we should do that when the model and firmware and dt is m=
ore
> > > > > complete. At the moment it has been easier for development to use=
 QEMU
> > > > > generated fdt.
> > > > >
> > > > > Is that acceptable to do that now and switch to a fdt ROM later..=
.
> > > >
> > > > Obviously guest software can decide to use whatever it wants. But w=
hat
> > > > we don't want to do is break users. So removing the generated FDT
> > > > (which is the equivalent of ROM FDT on hardware) will cause breakag=
es.
> > > > So we don't want to do that if we can avoid it. Also generating the
> > > > FDT is overhead for us, so we only want to if the guest software wi=
ll
> > > > actually use it. Does that make sense?
> > > >
> > > > Adding the device tree later is fine though, as guests don't have t=
o use it.
> > > >
> > > > >
> > > > > [...]
> > > > >
> > > > > > > +static void finalize_fdt(TTAtlantisState *s)
> > > > > > > +{
> > > > > > > +    uint32_t aplic_s_phandle =3D next_phandle();
> > > > > > > +    uint32_t imsic_s_phandle =3D next_phandle();
> > > > > > > +    void *fdt =3D MACHINE(s)->fdt;
> > > > > > > +
> > > > > > > +    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_ph=
andle);
> > > > > > > +
> > > > > > > +    /*
> > > > > > > +     * We want to do this, but the Linux aplic driver was br=
oken before v6.16
> > > > > > > +     *
> > > > > > > +     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "inter=
rupt-parent",
> > > > > > > +     *                       aplic_s_phandle);
> > > > > > > +     */
> > > > > >
> > > > > > And now we are stuck with hacks like this, which we really don'=
t want
> > > > > > to be dealing with. Maybe it's best to leave the device tree to=
 the
> > > > > > kernel.
> > > > >
> > > > > ... Despite issues like this?
> > > >
> > > > If the kernel generates a device tree for it to use then we don't h=
ave
> > > > mismatched problems (like this one). Generating the DT in QEMU for
> > > > real boards proves to be a challenge and this is exactly why. Now w=
e
> > > > have to choose between pre or post 6.16 support (I assume 6.16+ wor=
ks
> > > > without this, but you get the point).
> > >
> > > Yeah I see do see why we'd want a Linux one, and we are currently
> > > upstreaming dts for Linux. At the moment we don't have it so using
> > > the firmware stage one fills the gap.
> > >
> > > It is a little bit hacky maybe but I guess I'm not seeing where a
> > > compatibility problem comes in versus other systems with their own
> > > firmware DTB (that I assume a next-stage could similarly use and be
> > > exposed to these issues if it did not supply its own).
> >
> > The difference is I don't have to worry or maintain changing firmware :=
P
> >
> > Basically QEMU providing an FDT increases the machine complexity and
> > maintenance overhead. Admittingly it has probably improved now that
> > RISC-V has stabalised a bit, but it used to be much more of a hassle
> > to deal with.
>
> That makes sense. My powerpc experience was after its teething problems
> so DT there was fairly mature, and the machines I worked on were virtual
> first so generating DT in QEMU is the normal thing to do. I see where
> you are coming from a bit better now.

Yeah, virt machines have to generate the DT.

In the early RISC-V days in order to support kernels 5.y we had to
break support for 5.x due to device tree issues. It was a huge pain.
It does seem a lot better now, but you also have compat issues here,
so it's not all fixed.

>
> > So we want a reason to do that, as once it's merged we are mostly
> > stuck with it. Adding it just to simplify development now isn't a good
> > reason. Adding it because that's what the real hardware does is a good
> > reason though.
>
> Makes sense. I guess adding to the device tree should be less
> problematic, so we're okay to upstream pieces that are pretty stable?

Adding stuff is fine, that won't break users. We just don't want to
take things away if we can avoid it.

Alistair

