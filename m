Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62332CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 01:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKnsU-0002Fg-40; Wed, 06 May 2026 21:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKnsR-0002EC-0R
 for qemu-devel@nongnu.org; Wed, 06 May 2026 21:50:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKnsO-0006gB-PC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 21:50:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso3727945ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 18:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778118606; x=1778723406; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nVeH3EMwULsmHoeBXlXCCZPmTte1bhFFbOkMZUiyosw=;
 b=imkaG860WDziBdlH2TvHzeNcwJOhkgCQUAqohZAsxEYTB2Qp+pGsgpPDinQHyKXU0g
 lRWNm1Uml38bqRSyhwHTrQ42aist9ZBu5rpxWaUMVshSfI52I1aR39vcLyKc6RtXYj98
 uye2pLxg2jO0W8BDccKcmsmhAu2TglqYfb7MgB92OdyBLr4uQ2ja+w94oIgWOUr0wI0n
 Ca+sDY0uermswbF+f8+z4GVyqWK9UkZ3QFYh6ASC1Y7/ZhHgALwFIBmCGui6Y4cMe1Fg
 k3KWrl0MUgRyufCnFFnD4lOzzAC35U5+WtAnxORDuZx8dsIMShHsiPmAEM7JdP2fQdbc
 zydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778118606; x=1778723406;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVeH3EMwULsmHoeBXlXCCZPmTte1bhFFbOkMZUiyosw=;
 b=Gwdyi4/zCehjsJuybhUc8yt2/rYWuIrgbnmPdVrfXrQFF6kmcFaVT+9GeWShkhn6yH
 Ed2S6bBCiezegv5fW71FjJDejW6dQB9A/ILjkGpFR/Kfv+S2dBXzImgwJHv5grsW1GAC
 O8xmxplrgr6PRFvVAINi9bBJoBs1lVqkoe/QLvqVzJJKEWYF+YiqEOwBYCcEaVjyNZ81
 iRLTgry+7uAcfBB2ZS8PUr21iSUytRnqRrQfjj+dXcW/BnzfJYsodPyejox97rpYJHwL
 XMt+NdHeohJKhvzwWeZOf+7kw5QILXHPFMf+bUVfAeV5O5XuiwHNuHpVY3jVIavY97KE
 8H/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+X+gRJRmbDROr8sPiYP9gjhazyPLYXyADzyc8wRjLWN87p9h0suPlpBS4JjkBrAmD2h0gMWsFRyFz4@nongnu.org
X-Gm-Message-State: AOJu0Yzr8wOzKjHl3qfamg0Ea6KsKBQirZxyc7W+U0P2x2EVkXwtU/Ac
 N/AHa8vZexPbKvRG0nPamsM/a3K/bhK0EaX7qQpOW4dpijgGWlELJIqP
X-Gm-Gg: AeBDietXzwa0Qu/P3inHciuyyFTnwoAgULigklJe3POlIvUHsiFgsFuiCgk2b45dBkz
 QQJhVKOzPgPYUG5EW2TgUokuWI63YMYruY+sLBbzoOEJgWDqdDjZZveEhwgodnw+1fWRETsnwjP
 7NePzWbmgWHuzbBU/iSc0u5GjH2hEztzTwW1l6wB5UutzbNkczbsEbZU3KkhjWj/S+fSePMqgLw
 9tMulQ+Lf6OjfkNxPlwvO/01U0MW/wW6sX+yjADT0ROIHTYDkjYseAhXgFDMR/cH9fb6ZMRo2/j
 2WCpQp/m0ubbqB1+OOCj+rqiZzwQEUAZvkT2EC4CoWGTwoZs2FbDFWQNj3AAEpcWQU4qn7dCAp3
 WzfcYCLsb8ZSA/UP7lSuj937KzqsCAMPbc8CoTl715Mp24FYVGBK49EeiPFmPzwuRra/v/BcONh
 fq2WRWLLaLKxlI4dNnAM7dr7YPdB/2wP8sueZcVy007PYc5NfouuEelzdUnXpMqlf0JiRCtead0
 poTyeJe
X-Received: by 2002:a17:903:2f07:b0:2b2:4fcc:2687 with SMTP id
 d9443c01a7336-2ba79bf5da9mr64634635ad.31.1778118605762; 
 Wed, 06 May 2026 18:50:05 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babaaf0319sm5522935ad.31.2026.05.06.18.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:50:04 -0700 (PDT)
Date: Thu, 7 May 2026 11:50:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
Message-ID: <afvrfsOBbSC0IJQ1@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <afk0kVtQGz7OZ65_@lima-default>
 <CAKmqyKMbWXFBSuiKyp1uQ5TBhFAEex961Jzp4To5uyBzuUGMBQ@mail.gmail.com>
 <afl6x1CTIx2jvMH0@lima-default>
 <CAKmqyKOL9fsJcxmUK6SOMvcWqxtT69t8qj5Brmk0nnQO_ZQAkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOL9fsJcxmUK6SOMvcWqxtT69t8qj5Brmk0nnQO_ZQAkQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, May 06, 2026 at 01:14:09PM +1000, Alistair Francis wrote:
> On Tue, May 5, 2026 at 4:00 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Tue, May 05, 2026 at 02:34:50PM +1000, Alistair Francis wrote:
> > > On Tue, May 5, 2026 at 11:04 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> > > > > On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
> > > > > >
> > > > > > The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
> > > > > > and CoreLab Technology. It is based on the Atlantis SoC, which includes
> > > > > > the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> > > > >
> > > > > Can you provide a link to documentation
> > > >
> > > > Also not presently.
> > >
> > > Hmmm... That's a bit annoying. Can we get some?
> >
> > That's the plan but I don't have a date I can give you for it, sorry.
> >
> > [...]
> >
> > > > > > +static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phandles)
> > > > >
> > > > > So generally we only create a device tree for virtual boards, that is
> > > > > boards that don't really exist and are just QEMU constructs.
> > > > >
> > > > > You said that this is based on the "Atlantis SoC" so I assume it's
> > > > > real hardware. In the real hardware do you expect the device tree to
> > > > > be provided by the ROM? Usually for boards users supply the device
> > > > > tree as part of the boot flow (via u-boot or something similar). In
> > > > > which case should QEMU actually generate this or can users just supply
> > > > > their own?
> > > > >
> > > > > Basically the question is, if you are trying to model the hardware, is
> > > > > generating the device tree here correct?
> > > > >
> > > > > Obviously the advantage of doing it here is then the device tree
> > > > > describes what QEMU supports, which is great. But that can be harder
> > > > > to manage when the hardware doesn't do that, as then you have
> > > > > divergence.
> > > >
> > > > We went around this same discussion internally and yeah it's a valid
> > > > question, we could have explained this a bit better.
> > > >
> > > > In the real (unreleased) hardware and the DT will be loaded from ROM.
> > >
> > > Really? That usually doesn't go well
> >
> > Well not ROM but flash loaded by early firmware. The plan is to have an
> 
> Fair, when I say ROM I guess I mean ROM or rarely changed firmware,
> not specifically only ROM.
> 
> > "M mode" dtb loaded for opensbi and then later stages supply their own
> > dtb.
> 
> Ok, so the "hardware" will provide a DTB to OpenSBI. In which case
> this is the right approach for QEMU.
> 
> Can you document that in the commit message?

Will do.

> > The opensbi dtb won't go away from the tt-atlantis model, whether its
> > generated or we change it to use a dtb for the purpose of QEMU. I guess
> 
> You can ask the user to supply a DTB, which is passed to OpenSBI (and
> then other layers).
> 
> But if you expect your hardware to provide a DTB we should match that.

That's what we are aiming for, we just don't have the DTB or enough of
the machine modeled with QEMU yet.

> > if the next stage does not have its own dtb it can use one supplied by
> > opensbi.
> >
> > Does that sound right? I don't know if I have the details exactly right.
> 
> I don't know either! You don't have public documentation :)

Hah, touche. I meant, does that sound sane? Joel isn't around to correct
me! We will ship a machine DTB for OpenSBI, I don't know about the
mechanism u-boot or Linux use to supply their own DTB vs using the one
from the previous stage. I suppose that's not the domain of the QEMU model.

> >
> > > > I think we should do that when the model and firmware and dt is more
> > > > complete. At the moment it has been easier for development to use QEMU
> > > > generated fdt.
> > > >
> > > > Is that acceptable to do that now and switch to a fdt ROM later...
> > >
> > > Obviously guest software can decide to use whatever it wants. But what
> > > we don't want to do is break users. So removing the generated FDT
> > > (which is the equivalent of ROM FDT on hardware) will cause breakages.
> > > So we don't want to do that if we can avoid it. Also generating the
> > > FDT is overhead for us, so we only want to if the guest software will
> > > actually use it. Does that make sense?
> > >
> > > Adding the device tree later is fine though, as guests don't have to use it.
> > >
> > > >
> > > > [...]
> > > >
> > > > > > +static void finalize_fdt(TTAtlantisState *s)
> > > > > > +{
> > > > > > +    uint32_t aplic_s_phandle = next_phandle();
> > > > > > +    uint32_t imsic_s_phandle = next_phandle();
> > > > > > +    void *fdt = MACHINE(s)->fdt;
> > > > > > +
> > > > > > +    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> > > > > > +
> > > > > > +    /*
> > > > > > +     * We want to do this, but the Linux aplic driver was broken before v6.16
> > > > > > +     *
> > > > > > +     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt-parent",
> > > > > > +     *                       aplic_s_phandle);
> > > > > > +     */
> > > > >
> > > > > And now we are stuck with hacks like this, which we really don't want
> > > > > to be dealing with. Maybe it's best to leave the device tree to the
> > > > > kernel.
> > > >
> > > > ... Despite issues like this?
> > >
> > > If the kernel generates a device tree for it to use then we don't have
> > > mismatched problems (like this one). Generating the DT in QEMU for
> > > real boards proves to be a challenge and this is exactly why. Now we
> > > have to choose between pre or post 6.16 support (I assume 6.16+ works
> > > without this, but you get the point).
> >
> > Yeah I see do see why we'd want a Linux one, and we are currently
> > upstreaming dts for Linux. At the moment we don't have it so using
> > the firmware stage one fills the gap.
> >
> > It is a little bit hacky maybe but I guess I'm not seeing where a
> > compatibility problem comes in versus other systems with their own
> > firmware DTB (that I assume a next-stage could similarly use and be
> > exposed to these issues if it did not supply its own).
> 
> The difference is I don't have to worry or maintain changing firmware :P
> 
> Basically QEMU providing an FDT increases the machine complexity and
> maintenance overhead. Admittingly it has probably improved now that
> RISC-V has stabalised a bit, but it used to be much more of a hassle
> to deal with.

That makes sense. My powerpc experience was after its teething problems
so DT there was fairly mature, and the machines I worked on were virtual
first so generating DT in QEMU is the normal thing to do. I see where
you are coming from a bit better now.

> So we want a reason to do that, as once it's merged we are mostly
> stuck with it. Adding it just to simplify development now isn't a good
> reason. Adding it because that's what the real hardware does is a good
> reason though.

Makes sense. I guess adding to the device tree should be less
problematic, so we're okay to upstream pieces that are pretty stable?

Thanks,
Nick

