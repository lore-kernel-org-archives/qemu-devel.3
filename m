Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED7CCD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 04:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK7VG-0002s9-Lb; Tue, 05 May 2026 00:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wK7VA-0002qo-Q2
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:35:20 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wK7V8-0005O1-Le
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:35:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so827147366b.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 21:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777955717; cv=none;
 d=google.com; s=arc-20240605;
 b=bXkoaVCArRqSNU6bt5Q4HXGMXICoZHBmo3LU2uZ/c54XdELXQ44YSF6WI8+H0N7yP7
 eiSvltNyyfhJJGnayasoS/FzVaDutRL2Rlz5WTlSqJHCi4rqx9JkqqHl9cXtBg7dejzq
 5uwRqTpSSux5xOPA2prBh63NTap/+imk3JPwcnx3pl36DBuDUgFQk6i/DSlEdxOdntpK
 liCUW6PTsJA/RBAOTliF9nUjn5DmoExGY/2DpMsi6RbWExv5t7biWqwrq5DcCbkz+OGS
 6ZANC4jVmpaAUeXs30Zi13hZDS74hDf1jkA8OVIoHGhWiHCDXnMVBbZjQRnVFx/NLtiv
 6XrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nvyVrmOLbZNO+Wty/kEkzr6WbOewsvpFCjCAUg7erDM=;
 fh=wsL/7cfQ8S0Vpt+Ip2GG5MxEahs3VUNWnylgnWGGHqI=;
 b=ZbXMLSpFnRM3nwZxXjiOFdh63NvpkSoZFfsXxMoycnnhu4L8V6XbdirGClHsrkJWGZ
 L0Ejg8P6rLJ5QOeHrF9RDQbuz3T6oS8XSiN4mW3MzWg1E6gYUCUrBREzRWoc99yon4mU
 6tRGwALwVyk3jOPEmmQ8jMnxC5GwZkmSidD2QlfiIwmSlkWPLMJug+96hgAHcHjyowAW
 QNd8UrU8gXxWrQKDkhqWHa2zezPXjhxSqJ/dDxCTS6KJQtDwi89VsU7ZPnfsNFUGQjIk
 m2Bu9VMPAHLThA495JVWX0dpReQaEF8vMX0BwXRHA3k3LcBdE2DynKkKhVDhwDYWXV1h
 3ypw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777955717; x=1778560517; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvyVrmOLbZNO+Wty/kEkzr6WbOewsvpFCjCAUg7erDM=;
 b=Kco5E5qfKZRc1gjN/kZR6ktUjdj+NupMDYk0Ygl45toTsLYkxQya7uarSvH8pajNd4
 9mwngPFfd200fkOC27M0QF03l3p4G3AjAAwUBpo30CiqprxKiuUl0a4uZHLOpklAEz7B
 AB+a0bp/fQ7Xv5KeDjq+Z58JGeY3H/Y/hY3ZvcKTab0Hn1xTjq7QuRgdDd2H0z7vnvUn
 TdKhWOf/V6wTKoK4yHOV8w020E+0uGu4yLj1owvrvqI9FYArFMcBpZL2Ild4YV1BhwQT
 2hHwozOmDOxSEjxUDH+/VfyRDY9W3D1WwDfqQ1vYXqd9EJhQEJBWx6MwUm/FNlrXjCh4
 sL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777955717; x=1778560517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nvyVrmOLbZNO+Wty/kEkzr6WbOewsvpFCjCAUg7erDM=;
 b=GBbaSD/9VWORy9kGfOxjGZKiKa14x0fmAWiXsEgEgetIPMTqI3aCT5rYo7NNt+iY21
 z4iIE3GpcHnpc0B3aIH6vBwF2ED5CFm4Foz/k/herz5DJAOvF4kNDnhUDM1tlNyvyD2L
 aYDThAZln92NjeepsFdv9YWpJ2YYYHX411q+iV6O39LpP7ijFXtR7ZlMhI3VNiHisLPx
 e+uoZxDKGg2AS07zPKZ7opWWkgH80IrIGZD0rEOisn0AriXJ4VS78IkqrKOP63pKieqv
 B0WHmwlZ4Me2pIuuhkoRflmqWxzzzIMumJszn9DfFZBLKBESr4SJiFx/o4SCcrfCSaYL
 PvCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XgsXRhhzVpV+uBwzb4MbZG+rgtxLdyDiv1oIubfBgkRLhnV51bPPd7EENdopk29phSyOu0+fqctlt@nongnu.org
X-Gm-Message-State: AOJu0YzgpJiX7B8JQMOFgONrQmDo7Hfnm2RlRNJK/43kQWEhr8xdpo3X
 VvKm+WnBYWnK4kGE3efKOvVKNZh9mnDoNRM81AbibJmYKU/w7doZ6gBL776N2wQJKDIWBaPS9XD
 P76oe2xapf3m1AxG0FTdseW4TPHxzDVo=
X-Gm-Gg: AeBDievByCvAGqHcZ4BD22MhTWEJc4+mEU7G6kaSqrQoCIZvWsst9pq9CP6RflrcEkH
 o5hWNv8UhLx4VXXH7muxsA4wOD4AiezlVUtJrK1WD8+jED4h/Nr0FEmFrqunuuHRE+NcMwgFimL
 7C6LKux13eFkhX/VkqsCYiMQxkWV7Py1+sOFHioFI04QPxMGCilI1f847BFuyZwfSYPYmTa4MOO
 Vi9eryLiIwmgpQ+rxOGlWtqjWltGiO/Ba/LHpzMlSDx9prR/tn8P+aRXIUFMR1T82OaTZMYMfVh
 xjxjia3v28nhIqtyn0m235d+0H25IUqUBPTidP/5crKn5UTRtmpRymxB/gU=
X-Received: by 2002:a17:906:7956:b0:bab:d8e9:53a7 with SMTP id
 a640c23a62f3a-bbffcd7ba36mr650734366b.29.1777955716521; Mon, 04 May 2026
 21:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <afk0kVtQGz7OZ65_@lima-default>
In-Reply-To: <afk0kVtQGz7OZ65_@lima-default>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2026 14:34:50 +1000
X-Gm-Features: AVHnY4IrLtZpviQlRf5vm52Fg8AkCr_zRnYhKpVIfq8uQ2N3ej551a-dQFkvjsU
Message-ID: <CAKmqyKMbWXFBSuiKyp1uQ5TBhFAEex961Jzp4To5uyBzuUGMBQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Tue, May 5, 2026 at 11:04=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> > On Sat, Apr 25, 2026 at 11:20=E2=80=AFPM Joel Stanley <joel@jms.id.au> =
wrote:
> > >
> > > The Tenstorrent Atlantis platform is a collaboration between Tenstorr=
ent
> > > and CoreLab Technology. It is based on the Atlantis SoC, which includ=
es
> > > the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technolog=
y.
> >
> > Can you provide a link to documentation
>
> Also not presently.

Hmmm... That's a bit annoying. Can we get some?

>
> [...]
>
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e1942a86eba5..635a380945fd 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1760,6 +1760,17 @@ F: hw/*/*sifive*.c
> > >  F: include/hw/*/*sifive*.h
> > >  F: tests/functional/test_riscv64_sifive_u.py
> > >
> > > +Tenstorrent Machines
> > > +M: Joel Stanley <joel@jms.id.au>
> > > +R: Nicholas Piggin <npiggin@gmail.com>
> > > +R: Michael Ellerman <mpe@kernel.org>
> > > +L: qemu-riscv@nongnu.org
> > > +S: Supported
> > > +F: docs/system/riscv/tt_*.rst
> > > +F: hw/riscv/tt_*.c
> > > +F: hw/riscv/aia.[ch]
> >
> > AIA?
>
> Not sure why that is there, there's no Tenstorrent implementation detail
> in there AFAIKS. Let's remove that line.
>
> >
> > > +F: include/hw/riscv/tt_*.h
> > > +
> > >  AMD Microblaze-V Generic Board
> > >  M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> > >  S: Maintained
> > > diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt=
_atlantis.rst
> > > new file mode 100644
> > > index 000000000000..640cabf7b046
> > > --- /dev/null
> > > +++ b/docs/system/riscv/tt_atlantis.rst
> > > @@ -0,0 +1,38 @@
> > > +Tenstorrent Atlantis (``tt-atlantis``)
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +The Tenstorrent Atlantis platform is a collaboration between Tenstor=
rent
> > > +and CoreLab Technology. It is based on the Atlantis SoC, which inclu=
des
> > > +the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technolo=
gy.
> > > +
> > > +The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 complia=
nt
> > > +RISC-V CPU.
> > > +
> > > +Features
> > > +--------
> > > +
> > > +* 8-core Ascalon-X CPU Cluster
> > > +* Dual x32 LPDDR5 @ 6400 MT/s
> > > +* RISC-V compliant Advanced Interrupt Architecture
> > > +* PCIe Gen4
> > > +* RISC-V compliant IOMMU
> >
> > IOMMU isn't supported (at least not in this patch), maybe this should
> > list things that are supported in QEMU (and can then be expanded).
> > Leave the features list to your official documentation (which is
> > missing a link here)
>
> Sounds reasonable.
>
> [...]
>
> > > +
> > > +static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phand=
les)
> >
> > So generally we only create a device tree for virtual boards, that is
> > boards that don't really exist and are just QEMU constructs.
> >
> > You said that this is based on the "Atlantis SoC" so I assume it's
> > real hardware. In the real hardware do you expect the device tree to
> > be provided by the ROM? Usually for boards users supply the device
> > tree as part of the boot flow (via u-boot or something similar). In
> > which case should QEMU actually generate this or can users just supply
> > their own?
> >
> > Basically the question is, if you are trying to model the hardware, is
> > generating the device tree here correct?
> >
> > Obviously the advantage of doing it here is then the device tree
> > describes what QEMU supports, which is great. But that can be harder
> > to manage when the hardware doesn't do that, as then you have
> > divergence.
>
> We went around this same discussion internally and yeah it's a valid
> question, we could have explained this a bit better.
>
> In the real (unreleased) hardware and the DT will be loaded from ROM.

Really? That usually doesn't go well

> I think we should do that when the model and firmware and dt is more
> complete. At the moment it has been easier for development to use QEMU
> generated fdt.
>
> Is that acceptable to do that now and switch to a fdt ROM later...

Obviously guest software can decide to use whatever it wants. But what
we don't want to do is break users. So removing the generated FDT
(which is the equivalent of ROM FDT on hardware) will cause breakages.
So we don't want to do that if we can avoid it. Also generating the
FDT is overhead for us, so we only want to if the guest software will
actually use it. Does that make sense?

Adding the device tree later is fine though, as guests don't have to use it=
.

>
> [...]
>
> > > +static void finalize_fdt(TTAtlantisState *s)
> > > +{
> > > +    uint32_t aplic_s_phandle =3D next_phandle();
> > > +    uint32_t imsic_s_phandle =3D next_phandle();
> > > +    void *fdt =3D MACHINE(s)->fdt;
> > > +
> > > +    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> > > +
> > > +    /*
> > > +     * We want to do this, but the Linux aplic driver was broken bef=
ore v6.16
> > > +     *
> > > +     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt-par=
ent",
> > > +     *                       aplic_s_phandle);
> > > +     */
> >
> > And now we are stuck with hacks like this, which we really don't want
> > to be dealing with. Maybe it's best to leave the device tree to the
> > kernel.
>
> ... Despite issues like this?

If the kernel generates a device tree for it to use then we don't have
mismatched problems (like this one). Generating the DT in QEMU for
real boards proves to be a challenge and this is exactly why. Now we
have to choose between pre or post 6.16 support (I assume 6.16+ works
without this, but you get the point).

Alistair

>
> [...]
>
> > > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > > index 0222c93f878b..0601ae1a7494 100644
> > > --- a/hw/riscv/Kconfig
> > > +++ b/hw/riscv/Kconfig
> > > @@ -120,6 +120,21 @@ config SPIKE
> > >      select RISCV_ACLINT
> > >      select SIFIVE_PLIC
> > >
> > > +config TENSTORRENT
> > > +    bool
> > > +    default y
> > > +    depends on RISCV64
> > > +    imply PCI_DEVICES
> > > +    imply TEST_DEVICES
> > > +    select DEVICE_TREE
> > > +    select RISCV_NUMA
> >
> > Do you actually need NUMA? You have a numa include as well which I
> > don't think is required.
>
> Hardware is not NUMA. It was probably just copied from the VIRT config.
>
> Thanks,
> Nick

