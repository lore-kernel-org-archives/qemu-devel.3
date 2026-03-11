Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B43DFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Acs-0001kh-AQ; Tue, 10 Mar 2026 23:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1w0Acq-0001k4-CA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:52:48 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1w0Aco-0007Ii-8I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:52:48 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79902e1f763so25160447b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773201164; cv=none;
 d=google.com; s=arc-20240605;
 b=cQcij8GxTvnY5dXrdZTQfknnx5pch4Bh3Rd9MqLbWSLJlLgO5jWK62mNFOtbZmfqG/
 tnvHpRDAdlu6atFg6aNPG/JFGWA19I0ynE0A2Sn95lhVq1/hhPK0+B91ByZuReuDnO+l
 D7IkokSSWX7InmP9psFd2u3qcf4fIaWrASp6VYIQCciqsJS2TwFiD7Zj1sXzu+A9pSbe
 XFJW/WzzogfAdBn7hc/WOzANr832PqYEBs8yKJ8qWTTgG/X2us5xa1S7/q1KMMxlkQ8f
 fa8RYL/ajVTXxkONv4CM6hrdQegF4zo13hODuvAWVMIvGyfxvTvx9s53hPhUNtBbAUSa
 6b6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4ByTPFQZf2dilx9lYx1JT/+hfZRkZSULPaRfyVXtDDk=;
 fh=l/XDxEKVWXigbf/pBL1atPO4VPUxqLZQ4v9QmlUI3L8=;
 b=GbgnqM9RFJoRlCGG4saIBoO9jVvPuo+l3tdqGv2l+k5gkBtMKuF3/TNDhT08WoQVM0
 dfhuWQ6vroe33tST1toEibvoSL46hjNPKrqWipE84tSX9Fn5Ji7C0ATelmMAx2HrO6oN
 vFAx9ZDH5P2YwDX5T1G7lUuyVACZgkJ3CsfDWwNVpbgVPg7KkLzKBX9SlFvxcbGI8rN4
 OdEPi3/9d8DpurE5Yg+yrS7aPDjLyECMOMUOWB82z0z2agjdvBYcxNa+wP01ePordy5o
 EiLKMrJSSLgUPSkwpYuzNsKPngJKaiKWdwoXKhHohq0hfjVnPIs9OFaFdKICn+/Y5ked
 dmrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1773201164; x=1773805964; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ByTPFQZf2dilx9lYx1JT/+hfZRkZSULPaRfyVXtDDk=;
 b=itE5DZyefa9XZ9yA3789lP9NMaUHdu0EnCWXsIz+Wsy/yaYHj/sEbMFK6YyzpjhxuS
 nCcsHhVn/jLY8MJw8KHsYMRCboKTKWkaz2djMBCcod3RO/BqvszCFxiEYgwpULfy7GHi
 u9/s6ccSsTiWDVLiVYxOJ+UyNKUTXACfGodnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201164; x=1773805964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ByTPFQZf2dilx9lYx1JT/+hfZRkZSULPaRfyVXtDDk=;
 b=kLbiS1hpMcFvHQJ8BgCjRlWIYGYkqHxljXNWL0Dd6MF3dw0XHXOl+cNOfFGIhpRZWJ
 VPTvhQ/TBlXPswyDeyCJjABaAUtk4BzhY2HE2XFRTavASlePGPHcQ+ZEl4S60i0Af9L2
 UeZKVGajwDM+sjLCG1EmIzAxbt37QbUbcCwfgLyZTAoi+ZUiQaJVeRqUZJJmamPbXHc5
 0L81lmVmerE/lcocn/X5f8+Z8mPIledbKlHcaGV2uH5PVaG/s6/erNitSGaWecFmHDvV
 WgEwWCebPKXNtp+EG1d065N237WJd8US72Gd9c53yMsNdDkL8uKWko5Ci8Tb0hGIgPmD
 maSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9RUgLOkfy03SOzObYYqO5lT83GV4iIzXOt5Ow6tJNbqT2WoMseEKrT5KZd1Z/J6p+OYWPU7XVvgFd@nongnu.org
X-Gm-Message-State: AOJu0YxX7nnNSbrQIH2xrV5AUs/4ASigX/7iqIA106JVCEbl71/hKXNA
 ZhubQhu8yi8IkK42tXiO3b12An4JrI2b/XQNtcTnDALBZqN7p/4xJOmWrQq9Am58jBeORbVZDFp
 fAIViLmLLm0se27TDqJEjM8ebmGMcNig=
X-Gm-Gg: ATEYQzzmShCbSxF6B2Q5HcBn9IHprV/l5ewc5YTo+Y1/gcw1VOI4LkAGeIB9HXbxb4v
 ZWN6e9tTQZqT0KwKtLAGMj+IJt/Rc8xfIuGWri3jCF0OXVoSjdqQ/GMilgbNK8Hs9HrtXw5x1Pz
 VbkBrnoFJ8lJxjMYNlGkF7pQwLZmbcze8yl7Q6MKJHztbuyR+YpNOAepdDCXm+/XPURoLfxQvYW
 iFCiaEcQFLxDSnzCN32r5bAFeuwY7P9h+tfZ2aTaNlYPjY/8c8d2BwxJ4XfvshIVkF2bzFcdepy
 nw4/8LReSW2Ii2c3PSC20aG71bwJj/6XA3RYW7YAVAtgjxMoBoHiQplaOq0V9mNrJ7qr
X-Received: by 2002:a05:690c:67c7:b0:798:6666:26bc with SMTP id
 00721157ae682-79917f91edbmr9726847b3.34.1773201164499; Tue, 10 Mar 2026
 20:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260114012846.981884-1-joel@jms.id.au>
 <20260114012846.981884-3-joel@jms.id.au>
 <KUZPR04MB9265651CB41E7D2CD7CD30C8F391A@KUZPR04MB9265.apcprd04.prod.outlook.com>
 <CAO_bN7K7=FJS8FxNm3F-5KTTDEHfxkAnE=zfLs4dyaQoSnQ9sw@mail.gmail.com>
In-Reply-To: <CAO_bN7K7=FJS8FxNm3F-5KTTDEHfxkAnE=zfLs4dyaQoSnQ9sw@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Mar 2026 14:22:33 +1030
X-Gm-Features: AaiRm50fZhzLuEsY5xUWjFwiAboHmQCUWQC9esDcK7bxX4--4OtLGQn-MlANJhE
Message-ID: <CACPK8XehACjsrc2U8cx8zqV6vQQydw=e1VQ0sJPANQbpmqfHkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/aia: Provide number of irq sources
To: Nicholas Piggin <npiggin@tenstorrent.com>
Cc: "Nutty.Liu" <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, 
 qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 29 Jan 2026 at 11:21, Nicholas Piggin <npiggin@tenstorrent.com> wro=
te:
>
> On Wed, Jan 28, 2026 at 2:35=E2=80=AFPM Nutty.Liu <nutty.liu@hotmail.com>=
 wrote:
> >
> >
> > On 1/14/2026 9:28 AM, Joel Stanley wrote:
> > > Instead of hard coding the number of IRQ sources used by the APLIC pa=
ss
> > > it in as a parameter. This allows other machines to configure this as
> > > required.
> > >
> > > The maximum number of sources is 1023.
> > >
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > > v2: Add assert for the number of irq sources
> > > ---
> > >   hw/riscv/aia.h             |  1 +
> > >   include/hw/riscv/virt.h    |  1 +
> > >   hw/riscv/aia.c             |  8 ++++++--
> > >   hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
> > >   hw/riscv/virt.c            |  2 ++
> > >   5 files changed, 26 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> > > index 50c48ea4d79c..a63a1ab293fe 100644
> > > --- a/hw/riscv/aia.h
> > > +++ b/hw/riscv/aia.h
> > > @@ -48,6 +48,7 @@
> > >   uint32_t imsic_num_bits(uint32_t count);
> > >
> > >   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> > > +                             uint16_t num_sources,
> > >                                const MemMapEntry *aplic_m,
> > >                                const MemMapEntry *aplic_s,
> > >                                const MemMapEntry *imsic_m,
> > > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > > index 25ec5c665780..fa7fe8d4f648 100644
> > > --- a/include/hw/riscv/virt.h
> > > +++ b/include/hw/riscv/virt.h
> > > @@ -64,6 +64,7 @@ struct RISCVVirtState {
> > >       struct GPEXHost *gpex_host;
> > >       OnOffAuto iommu_sys;
> > >       uint16_t pci_iommu_bdf;
> > > +    uint16_t num_sources;
> > >   };
> > >
> > >   enum {
> > > diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> > > index 0a89d7b49b7b..a9130896fba2 100644
> > > --- a/hw/riscv/aia.c
> > > +++ b/hw/riscv/aia.c
> > > @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
> > >   }
> > >
> > >   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> > > +                             uint16_t num_sources,
> > >                                const MemMapEntry *aplic_m,
> > >                                const MemMapEntry *aplic_s,
> > >                                const MemMapEntry *imsic_m,
> > > @@ -37,6 +38,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia=
_guests,
> > >       DeviceState *aplic_s_dev =3D NULL;
> > >       DeviceState *aplic_m_dev =3D NULL;
> > >
> > > +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limi=
ts */
> > > +    g_assert(num_sources <=3D 1023);
> > > +
> > How about the below check ?
> >
> >      g_assert(num_sources <=3D VIRT_IRQCHIP_NUM_SOURCES);
> >
> > And modify VIRT_IRQCHIP_NUM_SOURCES in "aia.h" as below ?
> >
> >      #define VIRT_IRQCHIP_NUM_SOURCES 1023

I didn't bump this as it changes the ACPI blob for the virt machine.
This was noticed by a test.

A follow up could change the virt machine to support the max number of
sources if someone was interested.

> The names should probably be changed as new code is added. AFAIKS VIRT
> only comes
> from the riscv virt machine which was the first to use it. E.g., use
> something like
>
> #define RISCV_APLIC_MAX_NR_SORUCES 1023

Yes, that would be more sensible if future users were added.

Cheers,

Joel

