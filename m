Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64027C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQtP-0007Zg-HV; Sat, 01 Mar 2025 12:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1toQtN-0007ZG-Td
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:44:49 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1toQtM-00039A-3A
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:44:49 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e4dc3d22b8so3446105a12.0
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740851085; x=1741455885; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kE1n2MJe8GATZtjNaWBSJZ9UvZo3Bc3F8jzTnk29UGU=;
 b=XeZx3C0nJeZrJkwj8UlTPlXpUo47eEsOO9MLJuNGmY9Dvm1mPCkXhrOQS3o9HKEWOR
 SE0tXMF/DFetTA8Lvh+3YLGaeIeYx/ePmZL+ODRggeNeN/FiOV3Nu40dkXW1e5y1u6G1
 U/IkOLmrBhLkNec7rutps+jES21WmfWqR1pclfdVePSieaL15xAgFMvNA7QQfrOh25yl
 W8ec1ee0KxVTMTWw9CR4B5OhT0hLQ8vI2nrKXPlUGWQp0wOVBFKLsngROnjjyFfCAxFN
 Vl6j/3end2m+GtfeCdZ1krsPB0FzIVpcjRRntTQ01tQwByNeuXup8PgyJbL8OGf0wOJk
 anRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740851085; x=1741455885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kE1n2MJe8GATZtjNaWBSJZ9UvZo3Bc3F8jzTnk29UGU=;
 b=LOEYir9xGjfgCrvZYb9bEA2NaqhZQDK5VoWiyCO8USPAZ4xH/UGB16xJAb+2jyWD0P
 cizMn+BQJX0g/e1TtJXt+BFQ7PvmfKvlMXVa+JIHNBJnbs45Pf9ZxHZvdPypT6/BQ4XW
 kEE0o5gVW5UGAdVL1avxeZs7wD9f/JCbEKTcES3zYy8sdgFY8YFfT3Twe4eK5d03GOF4
 n7YZkx45EeS/qxtO0Hv5iHVUtyRf4IagC47bNalaDiK9BI14lGqJv2K/8mxq23H3u7d7
 PxaMoa5jWz9CVsnUWCVWC0JbquDoN9K6JRkOJ88dObI975zgzQMOYh+h/J2kPAP5AeU8
 sppQ==
X-Gm-Message-State: AOJu0Yy1tThFO/OrXn4q4VJhNn8xMlFGFF7FRAZ+rSJJeti3HDqos+/a
 y9iw9j6rO1hYSN+DX507X9oohB0vrbCTp9k/Z+gaHgFpf+Qhtni07bRAz+C5K9occMRwCHmSqGR
 EAu43P1uLQvjCSZdK1vBAwYZpF6xzdgi29cgUDg==
X-Gm-Gg: ASbGncskTkXm85fYbbtyVCMRXMH57fTpG69RR/mpSH4a9QkD43aBu7EG1UvVswUVyJn
 hmbI7PRjH4TESM8MJrQufnDVkKBjC2HjM7V++0tkUJmfHzbPkYs5s4+vvSGHJxok9LEhplznP7T
 os+fQFX+LgCo0meMAD8dU8zoOWIItqJMyyoDjyRO+ZAB8ZPIo5V2SxOQrlV2xE
X-Google-Smtp-Source: AGHT+IHdH/p30nWsN48uPqvX/0bLvqRO+Nz4hFAtoKCsZaULdlKfW7kI69dO67lAXAqgjUZfqmPcQJX3oGxGiAJTC80=
X-Received: by 2002:a17:907:970c:b0:ab7:d66f:c872 with SMTP id
 a640c23a62f3a-abf26850676mr828509866b.19.1740851085570; Sat, 01 Mar 2025
 09:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20250227073421.399-1-jason.chien@sifive.com>
 <c2164e32-5008-4dc9-bec3-5287f672a0e6@ventanamicro.com>
In-Reply-To: <c2164e32-5008-4dc9-bec3-5287f672a0e6@ventanamicro.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Sun, 2 Mar 2025 01:44:32 +0800
X-Gm-Features: AQ5f1JpblBlZXLhMRseZXinie2Zb08BtXdPgIVGb83saMAmIcsOTpvsJUupDm7k
Message-ID: <CADr__8rd4Bmxcv38LaKLX35BsnTyLeMRCXR_kGfqd0v4AaGCjA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix process directory table walk
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000009020f6062f4b7afa"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jason.chien@sifive.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000009020f6062f4b7afa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Danial,

I have rebased onto commit d1d54e60bcbfb9ef7804ec5376b84bb0a1e7148f and
submitted patch v2.

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2025=E5=B9=B4=
2=E6=9C=8828=E6=97=A5 =E9=80=B1=E4=BA=94
=E4=B8=8B=E5=8D=887:18=E5=AF=AB=E9=81=93=EF=BC=9A

> Hi Jason,
>
>
> Patch LGTM but it won't apply on top of alistair/riscv-to-apply.next. Can
> you please rebase?
>
>
> Thanks,
>
> Daniel
>
> On 2/27/25 4:34 AM, Jason Chien wrote:
> > The PPN field in a non-leaf PDT entry is positioned differently from th=
at
> > in a leaf PDT entry. The original implementation incorrectly used the
> leaf
> > entry's PPN mask to extract the PPN from a non-leaf entry, leading to a=
n
> > erroneous page table walk.
> >
> > This commit introduces new macros to properly define the fields for
> > non-leaf PDT entries and corrects the page table walk.
> >
> > Signed-off-by: Jason Chien <jason.chien@sifive.com>
> > ---
> >   hw/riscv/riscv-iommu-bits.h | 6 +++++-
> >   hw/riscv/riscv-iommu.c      | 4 ++--
> >   2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> > index de599b80d6..8d621c5b70 100644
> > --- a/hw/riscv/riscv-iommu-bits.h
> > +++ b/hw/riscv/riscv-iommu-bits.h
> > @@ -368,12 +368,16 @@ enum riscv_iommu_fq_causes {
> >   #define RISCV_IOMMU_DC_MSIPTP_MODE_OFF  0
> >   #define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT 1
> >
> > +/* 2.2 Process Directory Table */
> > +#define RISCV_IOMMU_PDTE_VALID          BIT_ULL(0)
> > +#define RISCV_IOMMU_PDTE_PPN            RISCV_IOMMU_PPN_FIELD
> > +
> >   /* Translation attributes fields */
> >   #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
> >   #define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
> >
> >   /* First stage context fields */
> > -#define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> > +#define RISCV_IOMMU_PC_FSC_PPN          RISCV_IOMMU_ATP_PPN_FIELD
> >   #define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
> >
> >   enum riscv_iommu_fq_ttypes {
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index e7568ca227..1abe981244 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -1043,10 +1043,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUStat=
e
> *s, RISCVIOMMUContext *ctx)
> >               return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> >           }
> >           le64_to_cpus(&de);
> > -        if (!(de & RISCV_IOMMU_PC_TA_V)) {
> > +        if (!(de & RISCV_IOMMU_PDTE_VALID)) {
> >               return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
> >           }
> > -        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
> > +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PDTE_PPN));
> >       }
> >
> >       /* Leaf entry in PDT */
>
>

--0000000000009020f6062f4b7afa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Danial,<br><br>I have rebased onto commit d1d54e60bcbfb=
9ef7804ec5376b84bb0a1e7148f and submitted patch v2.</div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Da=
niel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com">dbar=
boza@ventanamicro.com</a>&gt; =E6=96=BC 2025=E5=B9=B42=E6=9C=8828=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:18=E5=AF=AB=E9=81=93=EF=BC=9A<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Jason,<br>
<br>
<br>
Patch LGTM but it won&#39;t apply on top of alistair/riscv-to-apply.next. C=
an<br>
you please rebase?<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
On 2/27/25 4:34 AM, Jason Chien wrote:<br>
&gt; The PPN field in a non-leaf PDT entry is positioned differently from t=
hat<br>
&gt; in a leaf PDT entry. The original implementation incorrectly used the =
leaf<br>
&gt; entry&#39;s PPN mask to extract the PPN from a non-leaf entry, leading=
 to an<br>
&gt; erroneous page table walk.<br>
&gt; <br>
&gt; This commit introduces new macros to properly define the fields for<br=
>
&gt; non-leaf PDT entries and corrects the page table walk.<br>
&gt; <br>
&gt; Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.co=
m" target=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu-bits.h | 6 +++++-<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu.c=C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
&gt;=C2=A0 =C2=A02 files changed, 7 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h=
<br>
&gt; index de599b80d6..8d621c5b70 100644<br>
&gt; --- a/hw/riscv/riscv-iommu-bits.h<br>
&gt; +++ b/hw/riscv/riscv-iommu-bits.h<br>
&gt; @@ -368,12 +368,16 @@ enum riscv_iommu_fq_causes {<br>
&gt;=C2=A0 =C2=A0#define RISCV_IOMMU_DC_MSIPTP_MODE_OFF=C2=A0 0<br>
&gt;=C2=A0 =C2=A0#define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT 1<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* 2.2 Process Directory Table */<br>
&gt; +#define RISCV_IOMMU_PDTE_VALID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT_=
ULL(0)<br>
&gt; +#define RISCV_IOMMU_PDTE_PPN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 RISCV_IOMMU_PPN_FIELD<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* Translation attributes fields */<br>
&gt;=C2=A0 =C2=A0#define RISCV_IOMMU_PC_TA_V=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT_ULL(0)<br>
&gt;=C2=A0 =C2=A0#define RISCV_IOMMU_PC_TA_RESERVED=C2=A0 =C2=A0 =C2=A0 GEN=
MASK_ULL(63, 32)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* First stage context fields */<br>
&gt; -#define RISCV_IOMMU_PC_FSC_PPN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENM=
ASK_ULL(43, 0)<br>
&gt; +#define RISCV_IOMMU_PC_FSC_PPN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISC=
V_IOMMU_ATP_PPN_FIELD<br>
&gt;=C2=A0 =C2=A0#define RISCV_IOMMU_PC_FSC_RESERVED=C2=A0 =C2=A0 =C2=A0GEN=
MASK_ULL(59, 44)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0enum riscv_iommu_fq_ttypes {<br>
&gt; diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c<br>
&gt; index e7568ca227..1abe981244 100644<br>
&gt; --- a/hw/riscv/riscv-iommu.c<br>
&gt; +++ b/hw/riscv/riscv-iommu.c<br>
&gt; @@ -1043,10 +1043,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUSta=
te *s, RISCVIOMMUContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_IOM=
MU_FQ_CAUSE_PDT_LOAD_FAULT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le64_to_cpus(&amp;de);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(de &amp; RISCV_IOMMU_PC_TA_V)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(de &amp; RISCV_IOMMU_PDTE_VALID)) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_IOM=
MU_FQ_CAUSE_PDT_INVALID;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D PPN_PHYS(get_field(de, RISCV_IOM=
MU_PC_FSC_PPN));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D PPN_PHYS(get_field(de, RISCV_IOM=
MU_PDTE_PPN));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Leaf entry in PDT */<br>
<br>
</blockquote></div>

--0000000000009020f6062f4b7afa--

