Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB21C19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 01:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1touGs-0001lZ-7W; Sun, 02 Mar 2025 20:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1touGp-0001iO-3l; Sun, 02 Mar 2025 20:06:59 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1touGe-0004am-5F; Sun, 02 Mar 2025 20:06:50 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-868da0af0fcso1622873241.2; 
 Sun, 02 Mar 2025 17:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740964006; x=1741568806; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47cEr25zsmbdzDFpfBSWG/7VzvHGPS6DB4jB9DDB2gQ=;
 b=a4UKIP0auB9MCjVl7ikiBn5CK1BZWNNbZ3igQes76wI8Wdq0H7341m81huWbcRORAE
 A0A57HDxeeZkWT/LF3+QhHNws+eabdP83dK/Gy9LzefocikIQCnZZcGroCPu+QJmCguE
 VNqGCfvBJSX+TavO0qkG1anirw0NPBVYN2LYjtHtE6kMn9tH6Ccs/k5Av0LPkgq3wWtC
 dg6sBqgJlgVmNleSBp6AqZ4/K4JYsAj7/ktyWS2ooOlpp9XvYni61qpP4OHzsDpbk/HQ
 IZ32aht1KHphmuEZ8J4PQAEB9LQs9iQns0k2ycW/0U+5rbWZ8rahtae+bBvpjn9pi7Ca
 I2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740964006; x=1741568806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47cEr25zsmbdzDFpfBSWG/7VzvHGPS6DB4jB9DDB2gQ=;
 b=xMuLKotEcPrnS8uAOoEazmwE2JPOXNemooP+Om07C3F2KeAJ+qhq54JPNNU2ioMrJM
 2oOVtbfal/bSAJfoCnHIyguMwmvK1jzQbavokTpZrljT+nY4t0LlZpJfYZVAU+fPvmfd
 X2cqCEt3uO9AkxB/8TYHyQECg5cyNlJq5L7kPpuG7Gs4K3kgYDjBrI/6Fexb7OJS+dPh
 ozBnEiyhp4Q0vztFpZJxZBMCsrufXYffsgDHaOoEVKNiPgOGlFfU+r5Fn3hb1tH+uwNj
 thTzjD7x/a2Z8jqCyaXnpev3RoggfENER3SwOKbpp9xXypZaiYiNLf/K+2b4v6OySX1G
 0O3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfVf4Sonldo7FbfMZsNXKwI6dZFWCvLxJ5T967sD9wnKGgc0bE92K/wOZcN1Jt3ma1VZqTJqkuP70+@nongnu.org
X-Gm-Message-State: AOJu0YzgtCs2pOsdD+zlY3rcAS+VS9N8ZILDBsfmgs6DcyRgS5FX0/A8
 vjbJ+H1I3cxRM+LXNdaFr5uZJ0TYvoWCdtGiJmEJrh6QLjqyC+73k9nxj11/s4ejbT2ch48MWPr
 UiwpDvvTF/LgawZMoVNJBv6n0zvY=
X-Gm-Gg: ASbGncvmUTeANucW73I5JRSqKy9sWFrC3KRhcQl7rsqWHuksiS/wCMoDAMVsmPNarEy
 KzVjfjF2Lu2i2RByoPzUAMW9sc63AQK5WlgDnlhlnzxJn/ZVwo7/rKjO7ONMDoBxECWh2mLz3Qk
 GWmz0l73X7kUMFrmgJpsOf/MM9tOAKFyFNJxCYaQuQpwcrt/+R/WkgRAsk
X-Google-Smtp-Source: AGHT+IGS59xwph2vridcQejISorPz5B4fFvlEbRBaAX/birIlX3Y9HZQeZPOXB7XqYePR4VQlTQPLJXnJvz31Ok/L1g=
X-Received: by 2002:a05:6102:6e88:b0:4c1:8928:cefb with SMTP id
 ada2fe7eead31-4c18928d632mr1111937137.12.1740964006590; Sun, 02 Mar 2025
 17:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20250302130618.25688-2-hemanshu.khilari.foss@gmail.com>
 <CAKmqyKNFzHeVhWm4=fa_VEMaThR7hS1M4QK0wi2Vx4M4KGnwRQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNFzHeVhWm4=fa_VEMaThR7hS1M4QK0wi2Vx4M4KGnwRQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Mar 2025 11:06:19 +1000
X-Gm-Features: AQ5f1JrOrcdxoWbQZT_iTxCK8uRoD4_GepZBv_OF7J9LH4vcgH-WJlY1Jqtbh9c
Message-ID: <CAKmqyKO-dRpoqSa+2JOE9aFACzjQhhN+B-zskBz4Ur9g022vYQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/specs/riscv-iommu: Fixed broken link to external
 risv iommu document
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 3, 2025 at 10:46=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Sun, Mar 2, 2025 at 11:07=E2=80=AFPM hemanshu.khilari.foss
> <hemanshu.khilari.foss@gmail.com> wrote:
> >
> > The link to riscv iommu specification document is incorrect. This patch
> > updates the said link to point to correct location.
> >
> > Cc: qemu-riscv@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
> > Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
>
> Thanks!
>
> Applied to riscv-to-apply.next
>
> Alistair
>
> > ---
> >  docs/specs/riscv-iommu.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> > index b1538c9ead..772145e8d7 100644
> > --- a/docs/specs/riscv-iommu.rst
> > +++ b/docs/specs/riscv-iommu.rst
> > @@ -4,7 +4,7 @@ RISC-V IOMMU support for RISC-V machines
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spe=
c
> > -version 1.0 `iommu1.0`_.
> > +version 1.0 `iommu1.0.0`_.
> >
> >  The emulation includes a PCI reference device (riscv-iommu-pci) and a =
platform
> >  bus device (riscv-iommu-sys) that QEMU RISC-V boards can use.  The 'vi=
rt'
> > @@ -107,7 +107,7 @@ riscv-iommu options:
> >  - "s-stage": enabled
> >  - "g-stage": enabled
> >
> > -.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/do=
wnload/v1.0/riscv-iommu.pdf
> > +.. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/=
download/v1.0.0/riscv-iommu.pdf

This fails to build with the error:

qemu/docs/specs/riscv-iommu.rst:16:Unknown target name: "iommu1.0".

You missed a iommu1.0 update

Alistair

> >
> >  .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git=
.tjeznach@rivosinc.com/
> >
> > --
> > 2.42.0
> >
> >

