Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BDEB64DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snULi-0004n4-TM; Sun, 08 Sep 2024 22:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snULh-0004mL-MP; Sun, 08 Sep 2024 22:41:53 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snULg-000487-1z; Sun, 08 Sep 2024 22:41:53 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-49bd2b37fe9so1051125137.1; 
 Sun, 08 Sep 2024 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725849710; x=1726454510; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dekAywsmz0QxDkv5aiMdCboXNfTP72iK79Nqk365/+4=;
 b=VFzidogIOpwSmJbgpQjgi1k0jDKWOiaAkRDF3rjSp7R1FssZk/n4YVsSuXxKUFGVHJ
 NfiR1AM/U9XZgGhjkfyqn7fmhKSuasQYOCKEoomQHhfiNFPPkrChmra9S3Yy9wys2t+G
 y8hjstGFXadxtMBWP3IjgBEKPpjSVIr+Tb7y8EKrEiKc/ogrY7HKRLeC9HN9id6uEguX
 2A08MINMDl4jGu0PY08E9CVMchHLTwbw24ow2Xqmi2il2MNt9bdUhndUGqfZl36R8SIe
 aToUz2I51fYehsp0zQHjk5UAHyfWpFehgiJTEWhOtC8CmA1tqP5pTNtHleAAjmBH6VQy
 LI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725849710; x=1726454510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dekAywsmz0QxDkv5aiMdCboXNfTP72iK79Nqk365/+4=;
 b=GUOEdYDGbXwNp9tL6GpTHEF/96oxjBiKbgKuhjWHqmqrewx+U6lmZUvD2Rz/uju9o1
 gNr3FdJd7h3inPHIZoZn8QkI6jFzMooa1ltItknWCZixU/pqqjHXEr2MNWR0Rg8iycTN
 paSAbs3SUrI8rHbct/DYCNleiClM5K3OPZU6uv17FeiWXH0kBjQeKdk5X+UP2WdYd2Em
 gJWQHvaeL079H3DMOAYZ0IRNyv6kR326WvgtoccBk8ynkCGMetOYVpKTgIeXlPhzICoc
 jjG5Dol7dtKTrZ+ayRNoyM+kscbdl9e16apAbNpk54oxVzauCGqPSg6c1VlCvO5hdMQH
 Pb8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/t8Z7Lh7ZOcP3O0Jb2O3sHikyRojBkTIramNbK6PPyEcTNhtkZJXQMwrU0DcJ0fyJY6HSOTKcIE50@nongnu.org
X-Gm-Message-State: AOJu0YyVqJbji5sNAGgBnYtfNLiC/maD6ATIwFEfKEiYso0KEZkye4sr
 wELVelMSu12PrylMwkCgM8T4bZMWheNDJPedMqSEcjaeKRzxhd+5KrCfL2KJWgtwW1G95W2IkTq
 KiArzbJ51a6SrqXVoVeQNK+llTVw=
X-Google-Smtp-Source: AGHT+IFb+FYP4QjelpeJ9KfjgD+ph+AxtolbxntZ6VFIYrtJ/s2swiIX7GI2wFe6jhS3CXDgJFE2Kv6RzGPdfV9ZB0w=
X-Received: by 2002:a05:6102:c8d:b0:498:cbd8:288 with SMTP id
 ada2fe7eead31-49bde25dbbbmr7760829137.20.1725849709981; Sun, 08 Sep 2024
 19:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-6-ajones@ventanamicro.com>
 <CAKmqyKOXS+Fmb1Jxzwh3fAkeKi5eXQZ+JKkc3H77XjKrrKXe-Q@mail.gmail.com>
 <20240819-2773526929f81da7a462d10a@orel>
In-Reply-To: <20240819-2773526929f81da7a462d10a@orel>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 12:41:24 +1000
Message-ID: <CAKmqyKNKY3VmnQfwLcshFpDnnaw+1VwwWBSkpUWKiwDsaUM43w@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/virt: Introduce strict-dt
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Mon, Aug 19, 2024 at 5:50=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Aug 19, 2024 at 11:19:18AM GMT, Alistair Francis wrote:
> > On Sat, Aug 17, 2024 at 2:08=E2=80=AFAM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > Older firmwares and OS kernels which use deprecated device tree
> > > properties or are missing support for new properties may not be
> > > tolerant of fully compliant device trees. When divergence to the
> > > bindings specifications is harmless for new firmwares and OS kernels
> > > which are compliant, then it's probably better to also continue
> > > supporting the old firmwares and OS kernels by generating
> > > non-compliant device trees. The '#msi-cells=3D<0>' property of the
> > > imsic is one such property. Generating that property doesn't provide
> > > anything necessary (no '#msi-cells' property or an '#msi-cells'
> > > property with a value of zero mean the same thing) but it does
> > > cause PCI devices to fail to find the MSI controller on Linux and,
> > > for that reason, riscv virt doesn't currently generate it despite
> > > that putting the DT out of compliance. For users that want a
> > > compliant DT and know their software supports it, introduce a machine
> > > property 'strict-dt' to do so. We also drop the one redundant
> > > property that uses a deprecated name when strict-dt is enabled.
> > >
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  docs/system/riscv/virt.rst | 11 ++++++++++
> > >  hw/riscv/virt.c            | 43 ++++++++++++++++++++++++++++++------=
--
> > >  include/hw/riscv/virt.h    |  1 +
> > >  3 files changed, 46 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > > index 9a06f95a3444..f08d0a053051 100644
> > > --- a/docs/system/riscv/virt.rst
> > > +++ b/docs/system/riscv/virt.rst
> > > @@ -116,6 +116,17 @@ The following machine-specific options are suppo=
rted:
> > >    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not spe=
cified,
> > >    the default number of per-HART VS-level AIA IMSIC pages is 0.
> > >
> > > +- strict-dt=3D[on|off]
> >
> > Hmm... I don't love the idea of having yet another command line option.
> >
> > Does this really buy us a lot? Eventually we should deprecate the
> > invalid DT bindings anyway
>
> I agree we should deprecate the invalid DT usage, with the goal of only
> generating DTs that make the validator happy. I'm not sure how long that
> deprecation period should be, though. It may need to be a while since
> we'll need to decide when we've waited long enough to no longer care
> about older kernels. In the meantime, we won't be making the validator
> happy and may get bug reports due to that. With strct-dt we can just
> direct people in that direction. Also, I wouldn't be surprised if
> something else like this comes along some day, which is why I tried to
> make the option as generic as possible. Finally, the 'if (strict_dt)'
> self-documents to some extent. Otherwise we'll need to add comments
> around explaining why we're diverging from the specs. Although we should
> probably do that anyway, i.e. I should have put a comment on the
> 'if (strict-dt) then #msi-cells' explaining why it's under strict-dt.
> If we want strict-dt, then I'll send a v2 doing that. If we don't want
> strict-dt then I'll send a v2 with just a comment explaining why
> #msi-cells was left out.

I think go without strict-dt and add a comment.

In the future if we decide we really want to keep the validator happy
then we can version the virt machine and use the older machine for
backwards compatible kernels

Alistair

>
> Thanks,
> drew

