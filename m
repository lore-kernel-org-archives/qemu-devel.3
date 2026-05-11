Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A984CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 22:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMZJ2-0004g6-0S; Mon, 11 May 2026 18:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1wMZIx-0004fd-Ly
 for qemu-devel@nongnu.org; Mon, 11 May 2026 18:40:51 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1wMZIt-0006LK-Ss
 for qemu-devel@nongnu.org; Mon, 11 May 2026 18:40:50 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67e09232daeso2995901eaf.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 15:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778539246; cv=none;
 d=google.com; s=arc-20240605;
 b=cyzkjIHkuMyDT82N/4KAJw2ToP4Zo1bg3r04Ov+kAmsPAN+u3sECUnmOo8iVc4fkcj
 okum+MGv6k2vKDxlksnHmCMhGgKWjnWuGvSSzf+4zU5+XdLWJLbMwk7OdpSI/AtWVuCU
 OtlzVxKuchxyPrheIPbFFohIRLdz8CAYUc4j0buVHdlUP/hT7BvjD4XyChK6oE6yDo6w
 Q8yvnECq4nNP4/mvUCqBiQdq2jnWtldX4DyeliAH5peI6PHZ1G/OY7o4+10nWwtt3wLh
 DlkOkqlpgJKpFNEUqEqdCPX+g7IW04FBXQnkbhvgNlkbMPkb7B5ijl8wEMPqA1QRLG1E
 sP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GhkU8+5bs4UWXG1s/Vnd0z3uRl3AdpD6g12lLRO3vPk=;
 fh=yLs/y4iP22pet4+Mvy0an+/WS5ihRi3m5FupHY8sfOk=;
 b=FhOkfRmgT5Fw0HoAaFjngxwN2MCMilODqHS1IkAHlhQzoI+2GQmnKal2ez2rGKm9Xw
 EUn8uUv/NOD2BU52INAMM0tOJ43crrCs8iKc6WDzzAwyL41hihJmzfg4r2kCzuC8YaDJ
 PQoNHc6kxfChFZjuECBm3rXoKIKlmW1oiO2l/1m82/QYTt+SKgcwOtQc76CVi2f9S2pi
 reWLQ8mO9cURTuEvIRe/cXGVBu/84eQaMXnezbm8y6oXXAICpSDSfFuLIednrAcMDCbS
 mf3JTrAnT06VtLagruEMGg6PNuKAuuxwjVgzYHUkz5XCqCtr/E4Q41/ZrbvM7yxVjW3t
 We3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc.com; s=google; t=1778539246; x=1779144046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhkU8+5bs4UWXG1s/Vnd0z3uRl3AdpD6g12lLRO3vPk=;
 b=W33buQD8ZDqXS7BdWPB26XrzjggeiUKrVDuVNQy0Q9AO2mA2n7AOyws81N5gXoTV+y
 ptHHmBy/crth7s6nP8JMDkLV3ZH6ns6LwcGoTRj+gpgoGXcrVm9l9A5aSc+t2dO1YZm5
 EXgC6g19tTyHvFsU374VsI4G0S9SUZQ9zWBVMQFpiz7/znsFNmEPibb9yHoJ7F40MAfD
 KAFasJd7CeQugEFnNWdzS45BiUjrtVhivBa0tGHvX7fYam88q4PJF78kBmG2h/IG8rs/
 A33LS2BHYQWIa6MZDJbBBSsvE9rie7VWf9Mc8Hu+6qLTCwzCZhFDrIEw9x4+8+uwMRmW
 PDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778539246; x=1779144046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GhkU8+5bs4UWXG1s/Vnd0z3uRl3AdpD6g12lLRO3vPk=;
 b=jsmOhxuCpPR9NHqGHIJ37sY8sKlilcLcBSTqjfs1clFpO0OdfL4abgPGeXuMJg3/9k
 FcWi5oGgLEzey4erZbfWaH9kGD/UBx4P3weyDUkEbShUFdH6M4LBlkPpyQO7lJwjdxJ9
 ilJXVZcvpQVaUyPWGxTnrpoCuS0oX4h4GzJPV9z2DyRGs3L2/vPql/t3Z07XtKCH67Op
 V+ClknwfpGlE3DNONjASeDTNVkl4cdYNq11HSw1Ew8UA/NXDdAOTf4bqGUxEyw+G6GkY
 bicBw1mAvOdo7Kjqpo31Pv3xQb/nuwIGMOhQrLWJdr3wBvgUQ4C6mouXMp9iYjnLmRu3
 IEIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4AUYXAkIdWkcKDUSMVlp83rcQ606TihBBXFOYfaqu1EuY45ivRavepKN3hDR+eUD4ieRpYE9vxpjX@nongnu.org
X-Gm-Message-State: AOJu0YwJ1FlDVbgmQwwLDI2IN3UUjzKPKN248iugudgCA4JRPs6vpsWs
 SgpxhvZTigip1agy4FmmP1JoHK6+8IUmwABKUqnuuboU3tR5thqtx7BXPNKCtAiFQo3Zh/HS5aY
 SpwlIelOsPbC4gd6kWeuJ9EQZOtUg5ft740VmxutfQw==
X-Gm-Gg: Acq92OHTQdROnfiI7suLT7dwg7jV58AR5GJyxZymuXuHROHOEdDs3nfTeH4HGLZFsNf
 tJZYcp6E9KB76VveWlpDBSAdxKlxZlgNJOrP4D1Yd4yNkaObqyxc46LwGk1lDbGkxt9wk61wWrz
 SXD1VLg7yTBZhqWY3QfEFGX/expKL3vPqtK8QkfTR2Z1nnohlSukW27O5eET7gxFwLp1+8Saajq
 6QwgH6NJZUYj8/Bh5pe25kI7nU+SHHdk6IdLCPCEef3EbRLSNP4adCNkoqjk9oLC1G3blTMUZsb
 FkWX7RQ=
X-Received: by 2002:a05:6820:f010:b0:696:8ccc:55a0 with SMTP id
 006d021491bc7-69998d22f89mr15499646eaf.42.1778539246394; Mon, 11 May 2026
 15:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
 <h6bbn25obwet4wvv5u4pjtdsndqjsywzsh5kojpv34ow73p5b7@vqnlfxfwbaqv>
 <CAH2o1u6XGcfXrAqREzAFQfi7uX3vStEjWKUdutESPgJdzhbKdA@mail.gmail.com>
 <7srjvclfyeoh56ofulv74vajeb2xx6abtnupmsofjzooljw4jl@mifjgm6kzhfh>
In-Reply-To: <7srjvclfyeoh56ofulv74vajeb2xx6abtnupmsofjzooljw4jl@mifjgm6kzhfh>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 11 May 2026 15:40:34 -0700
X-Gm-Features: AVHnY4LbFM4bSHW12iNMEta8XmwkMmBGa16yIjNd_r3eC4HWkUWbkoo_zWXr6xQ
Message-ID: <CAH2o1u7U6MDOCfgGA0wrhdWFjLshJe=G888KVUvMPMHymmcqXA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=tjeznach@rivosinc.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Drew,

On Mon, May 11, 2026 at 2:07=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Mon, May 11, 2026 at 10:20:32AM -0700, Tomasz Jeznach wrote:
> > Hi Drew,
> >
> > On Fri, May 8, 2026 at 2:29=E2=80=AFPM Andrew Jones
> > <andrew.jones@oss.qualcomm.com> wrote:
> > >
> > > On Fri, May 08, 2026 at 03:51:29PM -0500, Andrew Jones wrote:
> > > > The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
> > > > storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
> > > > model wasn't checking PTE_N and therefore was using the raw (NAPOT-
> > > > encoded) PPN directly in the physical address, yielding an address
> > > > 32 KB above the correct base.
> > > >
> > > > Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
> > > > the Svnapot handling already present in target/riscv/cpu_helper.c:
> > > >
> > > >   napot_bits  =3D ctz64(ppn) + 1          /* 4 for 64KB */
> > > >   napot_mask  =3D (1 << napot_bits) - 1   /* 0xF */
> > > >   phys_base   =3D PPN_PHYS(ppn & ~napot_mask)
> > > >   page_offset =3D addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE =
- 1))
> > > >
> > > > The spec only defines napot_bits =3D=3D 4 (64KB); any other value i=
s
> > > > treated as a reserved encoding.
> > > >
> > > > This is a fix, rather than new feature support, because the spec
> > > > says "IOMMU implementations must support the Svnapot standard
> > > > extension for NAPOT Translation Contiguity."
> > > >
> > > > Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> > > > Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> > >
> > > I should have added
> > >
> > > Cc: qemu-stable@nongnu.org
> > >
> > > because as soon as [1] is merged into Linux Linux will no longer boot
> > > on any QEMU build without this patch.
> > >
> > > [1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@=
oss.qualcomm.com/
> > >
> > > Thanks,
> > > drew
> > >
> > > > ---
> > > >  hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++=
----
> > > >  1 file changed, 40 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > > > index 25a356d1d366..eb09cc974812 100644
> > > > --- a/hw/riscv/riscv-iommu.c
> > > > +++ b/hw/riscv/riscv-iommu.c
> > > > @@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUSt=
ate *s, RISCVIOMMUContext *ctx,
> > > >      return true;
> > > >  }
> > > >
> > > > +/* Returns the NAPOT page mask, or 0 for reserved encodings. */
> > > > +static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr,=
 hwaddr *out)
> > > > +{
> > > > +    int napot_bits =3D ctz64(ppn) + 1;
> > > > +    hwaddr napot_mask, page_mask;
> > > > +
> > > > +    /* The spec only defines 64KB (napot_bits =3D=3D 4) */
> > > > +    if (napot_bits !=3D 4) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    napot_mask =3D (1ULL << napot_bits) - 1;
> > > > +    page_mask =3D PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
> > > > +
> > > > +    *out =3D PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
> > > > +
> > > > +    return page_mask;
> > > > +}
> > > > +
> > > >  /*
> > > >   * RISCV IOMMU Address Translation Lookup - Page Table Walk
> > > >   *
> > > > @@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUSta=
te *s, RISCVIOMMUContext *ctx,
> > > >          } else {
> > > >              /* Leaf PTE, translation completed. */
> > > >              sc[pass].step =3D sc[pass].levels;
> > > > -            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - =
1));
> > > > -            /* Update address mask based on smallest translation g=
ranularity */
> > > > -            iotlb->addr_mask &=3D (1ULL << va_skip) - 1;
> > > > +
> > > > +            if (pte & PTE_N) {
> >
> > Would it be worth checking PTE_N only on the last level page table
> > entry (sc[pass].step =3D=3D sc[pass].levels at the start of the block)?
> >
>
> Hi Tomasz,
>
> I don't think we need it since we can't get here with non-zero napot bits
> on a superpage due to the "Misaligned PPN" check above. And, if we get
> past that and PTE_N is erroneously set, then we'll break from the loop
> when riscv_iommu_napot_page_mask() returns zero, allowing us to fault on
> the bad napot entry.
>
> Thanks,
> drew

Good point.

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Thanks,
- Tomasz

