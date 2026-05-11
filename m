Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D707CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUJI-0001Vn-ST; Mon, 11 May 2026 13:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1wMUJE-0001UO-12
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:20:48 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1wMUJC-0005Sh-5k
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:20:47 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6967080e6beso1432332eaf.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520044; cv=none;
 d=google.com; s=arc-20240605;
 b=iMqAf7giGHIGJGDSNJ0iaQhrmm5ScQOCSI5/WxkY/SLc0NjmkjyiqqEBY56vYbcGLB
 J/1TCLnqgslpa7ihm+Q4BFPm1gmFwt0o2ghWqNc2G0Siodwl1+dLMpyVPW5S6S1ubmxW
 f+fIMkmFQx6QixeM5cNSFGCfOagEol+uH8QBqIKm1BcjRbrvuqn187weS5pFfW/5hmZz
 B7KYmTlmLF0cJLioiefZPMSgAMZ/KHXZbZJSoXvsY9yxnQKp/aHVjeN2iMNnfLnKalEH
 faMsxxn3MBroHaeFIUwP2ujFMQ+iwxmCwdINsc0Hj4nl/4F+prnBFyGCm2UvYS8Q28ah
 WalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WAMVXQANelbzWtDP/ECxv1LF1MTAV5CGTKN4eisOzu0=;
 fh=Tv0yOfvP3dC60Tl49VG6FRW5Is+BNBClWSQDuzQNDsY=;
 b=B6S3BvTP8XJ5JKw5G6mNLUmJiC2PZHOL7mklZMOq0tjifW+WWwqNZ8HX+M+H02TgwS
 h31rpWWq8P0IjgHF+riv50YFvmp6cTLaShGox+0z07ab0OD4CgVAmSWknewlaD+LJdT9
 zKEh/uwPhgygFTcwGCNF1XtycS5k4tJWt1GVj2OGUXHxU1+37O5PZE2gchlpTV9XrvaC
 WrsIOcTPIlxM5anCgNqlv8MhpnzISvxAQwbHn+rm05HKQNLNK0Yi2uLCJ2Z5M5tfA76T
 rAyEmHhsh+pVy95DOm/WudB95n+MI42L+ngopwDGJ0NX0cxHBgH4iqeNEr4ABP+Sww/O
 tuug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc.com; s=google; t=1778520044; x=1779124844; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAMVXQANelbzWtDP/ECxv1LF1MTAV5CGTKN4eisOzu0=;
 b=JkOyCzrRZMAwcahAI+bWn0RaTCBm3kAZtBHqX5+6LMk0JKANNpClhZGOLi2xBzdXpv
 f/bjtf6CsZqQnHnKB4T6H8rrzEfewZH8cFIlVDcEZ+TjDtRSPvjT/UI0KC4v1K/mc/Tr
 cdR7Scs+ztby79kN0GBzD6LLlN+1KdkQatJcPdGnoDZU+D0hfdLaGQDnuzCEMHBS7bmb
 7tjAXg0vofKqIk+I4Lpp+HJtjEpuzzTqksiTBw3UWFK5Y1TjWNufi9AbuGRsuD+mSmE+
 806qpYYnccAysXR1sieAhexdc3sifVnBGFgzjD+xg/Twy5dbfi+aMBYPiJmf/txQDINi
 /DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778520044; x=1779124844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WAMVXQANelbzWtDP/ECxv1LF1MTAV5CGTKN4eisOzu0=;
 b=pzdDH2L+VoqByLDZX+oN1GuSPy6y0BAxrSNOS0FSYxx9Z8TpReiIj0Hm9c7xOvpr6U
 JqxrvdIs1cS7uhuc/R6jhL37YBe6CPRYUiWaOgVCBjKvpM67Dhwe5OAjWk/5vMMscxe9
 RC6f7vh/fqqcPDZltfUMKH/fLepMaoBajLDmuHodkiDSZuAwBhADJwdxKyGlGGnKmSNP
 Ki7VR2DioTiUpFZfUrwROSOyVjSOfuw774k7f1+038UIfQ34AEDuX6OUuIyu8s5mMRLM
 rXhr/jK6hu4r5onotDt8xTM0OJROfjE6VXhXbvFS3qfO/62eIvq57mNtv9DLgGDSaEr2
 v53g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2Lu+4ImI3nzJ6fRlYgShfATLMEWzmE3uFJVaqFHrcxT/abrjzJutChpAEvxssyXqxX97w2M35g+IC@nongnu.org
X-Gm-Message-State: AOJu0YxYxoU7OD1ROj/bqmRf7TLuB1DUkIyJUpfu9MYv1UOJG6pVE6Dp
 Pd+mZEJ+Ap1vVgUuHkc0QVlyLtSlhRY3NHVmeDs00SApBr5Z/K6sDKj3oCXZOoaSlYSZV5m6Mgp
 5YJusPWqQEQ2GjPvxtNRVIhqS+IBWy07ZXioWAHNrYw==
X-Gm-Gg: Acq92OHfN3/3xFcsvEyjrn6l7/KjQKlsKKz2VDRfr0xnIRlrRnLT4YQK2quc9a7lnjd
 rpv0CVuAg8CAzEnzNwGr9kGbRSzOtHknxEFm50gYTV/2ktp6etiB0DSL3Hqm3lEADfeclnuYJS2
 P31KldDo+wIj5XXT3kbGUGDDGoBJkHtwL4W8rRd8XK150TI+ItukImTZm21clo1BwEVCBadGP5s
 IM+wxOS0xe2xs6jcEs+ThwnmmwkNSrNFN4SjqBdCiuGSCeaO7Rff2CiXgWKpPvVwaVY5KV4gp/o
 hm1x8BtP/IGtQ0i3Iw==
X-Received: by 2002:a4a:e90d:0:b0:67e:f8c:6bcc with SMTP id
 006d021491bc7-69b36b3f181mr5501402eaf.19.1778520043854; Mon, 11 May 2026
 10:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
 <h6bbn25obwet4wvv5u4pjtdsndqjsywzsh5kojpv34ow73p5b7@vqnlfxfwbaqv>
In-Reply-To: <h6bbn25obwet4wvv5u4pjtdsndqjsywzsh5kojpv34ow73p5b7@vqnlfxfwbaqv>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 11 May 2026 10:20:32 -0700
X-Gm-Features: AVHnY4JqVuODKGdGYJ8pk6W0jFrEywXxqimqK68i234wqKJ9uvxEii54SYwti6c
Message-ID: <CAH2o1u6XGcfXrAqREzAFQfi7uX3vStEjWKUdutESPgJdzhbKdA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=tjeznach@rivosinc.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Drew,

On Fri, May 8, 2026 at 2:29=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Fri, May 08, 2026 at 03:51:29PM -0500, Andrew Jones wrote:
> > The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
> > storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
> > model wasn't checking PTE_N and therefore was using the raw (NAPOT-
> > encoded) PPN directly in the physical address, yielding an address
> > 32 KB above the correct base.
> >
> > Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
> > the Svnapot handling already present in target/riscv/cpu_helper.c:
> >
> >   napot_bits  =3D ctz64(ppn) + 1          /* 4 for 64KB */
> >   napot_mask  =3D (1 << napot_bits) - 1   /* 0xF */
> >   phys_base   =3D PPN_PHYS(ppn & ~napot_mask)
> >   page_offset =3D addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1)=
)
> >
> > The spec only defines napot_bits =3D=3D 4 (64KB); any other value is
> > treated as a reserved encoding.
> >
> > This is a fix, rather than new feature support, because the spec
> > says "IOMMU implementations must support the Svnapot standard
> > extension for NAPOT Translation Contiguity."
> >
> > Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> > Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>
> I should have added
>
> Cc: qemu-stable@nongnu.org
>
> because as soon as [1] is merged into Linux Linux will no longer boot
> on any QEMU build without this patch.
>
> [1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.=
qualcomm.com/
>
> Thanks,
> drew
>
> > ---
> >  hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index 25a356d1d366..eb09cc974812 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState =
*s, RISCVIOMMUContext *ctx,
> >      return true;
> >  }
> >
> > +/* Returns the NAPOT page mask, or 0 for reserved encodings. */
> > +static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwa=
ddr *out)
> > +{
> > +    int napot_bits =3D ctz64(ppn) + 1;
> > +    hwaddr napot_mask, page_mask;
> > +
> > +    /* The spec only defines 64KB (napot_bits =3D=3D 4) */
> > +    if (napot_bits !=3D 4) {
> > +        return 0;
> > +    }
> > +
> > +    napot_mask =3D (1ULL << napot_bits) - 1;
> > +    page_mask =3D PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
> > +
> > +    *out =3D PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
> > +
> > +    return page_mask;
> > +}
> > +
> >  /*
> >   * RISCV IOMMU Address Translation Lookup - Page Table Walk
> >   *
> > @@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx,
> >          } else {
> >              /* Leaf PTE, translation completed. */
> >              sc[pass].step =3D sc[pass].levels;
> > -            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> > -            /* Update address mask based on smallest translation granu=
larity */
> > -            iotlb->addr_mask &=3D (1ULL << va_skip) - 1;
> > +
> > +            if (pte & PTE_N) {

Would it be worth checking PTE_N only on the last level page table
entry (sc[pass].step =3D=3D sc[pass].levels at the start of the block)?

> > +                hwaddr mask =3D riscv_iommu_napot_page_mask(ppn, addr,=
 &base);
> > +
> > +                if (!mask) {
> > +                    break;
> > +                }
> > +                iotlb->addr_mask &=3D mask;
> > +            } else {
> > +                base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - =
1));
> > +                /* Update address mask based on smallest translation g=
ranularity */
> > +                iotlb->addr_mask &=3D (1ULL << va_skip) - 1;
> > +            }
> > +
> >              /* Continue with S-Stage translation? */
> >              if (pass && sc[0].step !=3D sc[0].levels) {
> >                  pass =3D S_STAGE;
> > @@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUStat=
e *s,
> >              return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
> >          } else {
> >              /* Leaf PTE, translation completed. */
> > -            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> > +            if (pte & PTE_N) {
> > +                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
> > +                    return MEMTX_ACCESS_ERROR;
> > +                }
> > +            } else {
> > +                base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - =
1));
> > +            }
> >              break;
> >          }
> >
> > --
> > 2.43.0
> >


Thanks for the fix otherwise.
- Tomasz

