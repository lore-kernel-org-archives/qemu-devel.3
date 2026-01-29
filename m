Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A748BD46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGli-0004aT-IL; Wed, 28 Jan 2026 20:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@tenstorrent.com>)
 id 1vlGG0-00015R-6p
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 19:51:36 -0500
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@tenstorrent.com>)
 id 1vlGFy-00071O-7Y
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 19:51:35 -0500
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-124b117776fso344919c88.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 16:51:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769647892; cv=none;
 d=google.com; s=arc-20240605;
 b=FfFHnMyI/uEGg+9KKT5VI959g2FiNuaNxaZRvcxErnenRET+SWIMzd4t+sUHFjLVNm
 sA/g94WanoeLAtIV9pKhWZ06eImpd7r/FUZ/E05QK31SA3fWsnnCtBr+TW4/uvVtPZjh
 Wc8Ov5rf6FPOt9MHT49Een4prYQsl3rFbk/2RlKufnp4Xbc1oZjh7uWiSIcDIK5+Lh+6
 4+On226F4yV1T1Y7yqm2iLp0vnRWXs4uZeztRiMAL6f0w8K45Q0iKhxNTBVs/8T7n/Xm
 OghyQAdWd6fjRPxULsjZ9vvxSflEgZY6DNt88sYfH4iMb9VhvouBB8I7lg8adlEGaHlk
 vpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=17Q1GaW/5E9WlOZkRpTbCovRmVaNp0Avlcf01CcoLLQ=;
 fh=l8pmnT1N717o/p85ZHBHYCkM/ZZRsvcUXtmE2DlEtpQ=;
 b=E0HpVct34KMSOHF53A5RWGuXj00D5eXioBi92nxIxo9ZLmL49TOwsFlcrGfnkd2wXI
 UEjLZtadb6/QQUwBz4yFHHUTzFQFUWIjIrdvnhaLUdqA9nhC2oaDSM5sVmOpsg5eHPnS
 UoJJ4OOg3NaDgZUhNwT00NM7I8ekWASvYJ+j/KCcHROh5G0C5TR+v55/QE7quNCvccmC
 s7nu7+5a1dlR7yNDUBuZwXZ3FEY8qREqngKZDIiV22uW/SkVrkVwHNih7rN6fnuwF2Me
 AVikCogOEb3cyr8u8bG4qs2t4ZgyByzIK8NKLmCKgNhmCBHZhJcYkMDsCTkh/eBgwswt
 7i8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1769647892; x=1770252692; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17Q1GaW/5E9WlOZkRpTbCovRmVaNp0Avlcf01CcoLLQ=;
 b=AyhQnSrv1jbd4pMHsyzhXau9DrO3dfEeIcJ9UHwtOVjXURQ+hfp4WpMZCx3SBwOvs4
 ufY5aXYaqS6Y2U7cchP9opyDE/7bVBiJiTuGFsVVmMtcPYVfYrJBykmghsek05wTC3GH
 iGrfVvykvZq0QiwrLiToDfroW2TZMmKuRI+v9faNEjJeb4/08jhydDJF4c20sNFJ/l39
 QLpIyMigwvvd/nLdfgO3H5IwvRK9tvMAJylcsZMOObJJje3DyCAjQjZgFm9yMmvZBoRG
 udyL5cbnNrzl5rwSPuz+eA1iNuii/A53xl+8EM++ub9kNaCTj1vM68s9pwcE58gld0Ef
 EoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769647892; x=1770252692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=17Q1GaW/5E9WlOZkRpTbCovRmVaNp0Avlcf01CcoLLQ=;
 b=BrkCOuy6BCCPpEvds9x8BNy+DpV6N93TDmdZRPWwU3meG15tPj6P1vohFDsy2xB/u/
 CqdXpkCXSoqGGnQ8qcN8EQ05hLe2fMgY8KN0dCkM8bxF3GyTW3sGaf6VeW/lDjjxR69D
 +jjnqjAMZv8IW5EfG5nMzDzdfAAqkTUaDcWq2g6QXhLt78BdNpLCQ3WbG8nl0+pZWVfp
 Mq/aK75cvE+NkDz9ODH8FdeDIhMuu0UKERPeQu7AZ7q0gNHn3OaNSIGhqvOBs7bm0Hjt
 fSjZdoF6ij+yebVeZ+RCikVzRKWkf/rrIuVK/Smyo69Ed3kXe5B+MLatOk72LcNWfhlV
 J/FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNmBMBHOHSyz45NtVhA1GMjQzRaih2arCEmEWkVqs4qUV0cz3feM16a3RWrY3e6BvPgtJYqK94i3FQ@nongnu.org
X-Gm-Message-State: AOJu0YzYT9NtaHAwFERNsMWIQGIYUviAWMCXuVJs7Qp/WiUvINxwNKPs
 9iRkXDhMIYVrwWBs/AAz2eJJb9/alrwa3Njka5oAq1o9YU8nk9W9pcwncrijZ9fDDrKryn/GbKh
 GJPLqpcHbh3QJ8qbgTb4k81g9GCYstrr3hFbOSEZSaw==
X-Gm-Gg: AZuq6aKIakOlVxDGSE0rMaFndeKTT2l3lRi4x5qnrZipr69/+6XGWGLrs0UUsGuOuNx
 ODbOsKj+thDMvoPLWfBQ0JCvsQUJeNFGpg2lCuBcT8UrbSYnhVG3dcoKB+7YrM0Omck4R2OUR0O
 1ulsQRRZq1vz2zGkuQlFtOxCVFLNc9r4HTBxQQ7eEx5iJ27/KcdV9HfdBrN6j4ToSTAkdjFYTrD
 7QfFPMW98cDs1UIgigSz/vbwNNxCDUPBZV8r0zloHG2bpb9MNG0WPyaiQmyF8k1wyp8YeP9AARt
 hr4OQqA=
X-Received: by 2002:a05:7022:458d:b0:11e:3e9:3e9e with SMTP id
 a92af1059eb24-124a00de475mr5686065c88.49.1769647891741; Wed, 28 Jan 2026
 16:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20260114012846.981884-1-joel@jms.id.au>
 <20260114012846.981884-3-joel@jms.id.au>
 <KUZPR04MB9265651CB41E7D2CD7CD30C8F391A@KUZPR04MB9265.apcprd04.prod.outlook.com>
In-Reply-To: <KUZPR04MB9265651CB41E7D2CD7CD30C8F391A@KUZPR04MB9265.apcprd04.prod.outlook.com>
From: Nicholas Piggin <npiggin@tenstorrent.com>
Date: Thu, 29 Jan 2026 10:51:21 +1000
X-Gm-Features: AZwV_QgJ8FzBV0DLicH2dQpU6fxxDQrwtg9mcN_hN9X8ron_iC0qL1_NWTKmjj0
Message-ID: <CAO_bN7K7=FJS8FxNm3F-5KTTDEHfxkAnE=zfLs4dyaQoSnQ9sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/aia: Provide number of irq sources
To: "Nutty.Liu" <nutty.liu@hotmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=npiggin@tenstorrent.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Jan 2026 20:24:21 -0500
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

On Wed, Jan 28, 2026 at 2:35=E2=80=AFPM Nutty.Liu <nutty.liu@hotmail.com> w=
rote:
>
>
> On 1/14/2026 9:28 AM, Joel Stanley wrote:
> > Instead of hard coding the number of IRQ sources used by the APLIC pass
> > it in as a parameter. This allows other machines to configure this as
> > required.
> >
> > The maximum number of sources is 1023.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v2: Add assert for the number of irq sources
> > ---
> >   hw/riscv/aia.h             |  1 +
> >   include/hw/riscv/virt.h    |  1 +
> >   hw/riscv/aia.c             |  8 ++++++--
> >   hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
> >   hw/riscv/virt.c            |  2 ++
> >   5 files changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> > index 50c48ea4d79c..a63a1ab293fe 100644
> > --- a/hw/riscv/aia.h
> > +++ b/hw/riscv/aia.h
> > @@ -48,6 +48,7 @@
> >   uint32_t imsic_num_bits(uint32_t count);
> >
> >   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> > +                             uint16_t num_sources,
> >                                const MemMapEntry *aplic_m,
> >                                const MemMapEntry *aplic_s,
> >                                const MemMapEntry *imsic_m,
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index 25ec5c665780..fa7fe8d4f648 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -64,6 +64,7 @@ struct RISCVVirtState {
> >       struct GPEXHost *gpex_host;
> >       OnOffAuto iommu_sys;
> >       uint16_t pci_iommu_bdf;
> > +    uint16_t num_sources;
> >   };
> >
> >   enum {
> > diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> > index 0a89d7b49b7b..a9130896fba2 100644
> > --- a/hw/riscv/aia.c
> > +++ b/hw/riscv/aia.c
> > @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
> >   }
> >
> >   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> > +                             uint16_t num_sources,
> >                                const MemMapEntry *aplic_m,
> >                                const MemMapEntry *aplic_s,
> >                                const MemMapEntry *imsic_m,
> > @@ -37,6 +38,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_g=
uests,
> >       DeviceState *aplic_s_dev =3D NULL;
> >       DeviceState *aplic_m_dev =3D NULL;
> >
> > +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits=
 */
> > +    g_assert(num_sources <=3D 1023);
> > +
> How about the below check ?
>
>      g_assert(num_sources <=3D VIRT_IRQCHIP_NUM_SOURCES);
>
> And modify VIRT_IRQCHIP_NUM_SOURCES in "aia.h" as below ?
>
>      #define VIRT_IRQCHIP_NUM_SOURCES 1023

The names should probably be changed as new code is added. AFAIKS VIRT
only comes
from the riscv virt machine which was the first to use it. E.g., use
something like

#define RISCV_APLIC_MAX_NR_SORUCES 1023

Thanks,
Nick

