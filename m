Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD07CEEF303
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 05:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy1NY-00050R-JN; Thu, 05 Mar 2026 00:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vy1NV-0004z5-Vu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 00:36:06 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vy1NT-00055a-HV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 00:36:05 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6611e4aefdcso1900263a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 21:36:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772688961; cv=none;
 d=google.com; s=arc-20240605;
 b=OJJF7nmEDCNnIggttc9g09m5UO8UYcr0aDvEQp5iiyu2xadWnkTKVkppvTMxWaK2fg
 cg0FhMDw/jI4Bx1/3MUYu5P90ynAUAkWF/GgQIrwvTgwTquP24Ou7vcN5W/m3D/kM4ry
 GNyvIKGx8z84gDUWrqyGWyBiWHRYcq6ECknYvkMeB1C/O36+c0wkqpV41ZD0nidpUlWF
 VJvlMX22EX0hciJS27bXFFtZfpS4TeNw2E2ZXYWa2gIR6qdS0/mNxhdrbYwvBDC2yKqq
 mtP+pGPF6zL087iKRE72KxbjHVIZGvPli/ltkH0jZIQA632dhFk8Fc734JOc8Ut2siMY
 VA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+KOJvYaXjpPqVqqDCYG+PDKig9xM98iwt80vRBeoEfk=;
 fh=/Z0ezT8pYayt1koOmEqEykGjBH4RPQoopbcQoeQY7XA=;
 b=hLQKOT3ddxbIYaN8KJxAvi5Bd1PFByap6oi537jdlf+YvqjgW/WEx8KBiDXj98dFc4
 FsG9XMUlQERdFMaqc6YBL5IFTKioMdvwyq+Z5t92on3Oag1uz2F55C4zIQZyyoBK3eBc
 1CIvv+jdxi7ilPgrmDynaC5E0sA0YGlBF2UXZ1bLoI7XOSt2H78PRiXKcXXM+zRlmw+y
 0hKpuaSoxYexUfOwzvcuI5qWylVzr9OBILgwqdzYg05N67XqptFm01oZZUeggkxXJv4U
 nGTrnfoR98V7kSKReQBbX+rtraTAqm9hcv51knnPgnauG/L8AOfw+RzrsXJr0sr607lw
 +Teg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772688961; x=1773293761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KOJvYaXjpPqVqqDCYG+PDKig9xM98iwt80vRBeoEfk=;
 b=VhvxKzXH1zfDr8v9YePataQAtLWVRQUbJillmpKA/6BqNZ6yvMdWQiaqtjhZ4h+8tH
 hxKD07C7xHqRY5hE3BtBs1WljdBGHRgZIiwt+ggE9uNGCqaK1FAy5QodYvE10/9g6dY9
 N7Q0lWZCyUhsvqlIn5V0qqIyRXGlwdoFv/IggQWXD2EGFzzvC/aFuos24T28B58fyuP+
 RIZRwK8ni03vNCbl+v1n5P0v9E0Oc+lOy4V7ImZb9+8BGuYQEHiKo3ArITZo+wBTKNwE
 b/5wlxWw6MqJHmS0dVzW9Qp+j+wh9AKmIopxG86NPQJS0gxvIZ0kIJcDnBC+iiTNJ2Ll
 KYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772688961; x=1773293761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+KOJvYaXjpPqVqqDCYG+PDKig9xM98iwt80vRBeoEfk=;
 b=hfs4sHHVrSI3HvnD5drFR+C4AB3rUJB1qSrgH7JseqdTE0xOuOzdzqAeUBeZ7NF4To
 t2YVRSo1qv2IYvQnlmlm3oxexmI8uJeZ5I+wobh4GGRRyGmwa6oCwqFhs+q7R6uWI6SH
 CRKYUmOqwiDTW2QVVOaBcFi/+Fei4rxgD2+zj55di1tW+5s4E3ng/DkiCgUGJ4xrkXaV
 5V1FS93xHJ1JURhT4kvLTxfl0KQa7PBGn8agS284UVmFbNjbnHfn626moqVwY3PML48L
 /eNEryIxhdRZQaH9DXT03jwUouVT6419Ox+8nzBnceviSlRryKWu2THJ67eXoy7mHEhv
 tVtg==
X-Gm-Message-State: AOJu0Yxskbowz/5ToJkR3ANyAVAgivJhpTnI/WypS/JhJFeKiI1Tyy6Y
 5bA2JPCS1OC0beRfYv6oy2FnzVUSEHCtuAzFmxZfS7d/cIC5M81hTj2smcHbws/DMJnXJ7rEUJx
 hgDDYry6N/KdiYe51MqYfi0VnhEFE4ERbSa91xz4Wmg==
X-Gm-Gg: ATEYQzwBeHKActa2bhubkMlppRpjL4fhVtJO+JD0A77LLD2XRk1a2O6Ydn8ZfB1KUH2
 CWfD7merZjrgQnvd3Nj7+KLJWSGq1tLW7VUPGr6UcZwf1DKGu4aocYut4NfYJV5Mo4XE+aIU7vn
 ePxf2Lj73FP1IB0KyiAUiEql50sZPlsF4dpbhG3Q1LH6eN+qkLkMZvNI19ewyd9Z40Cl1YQDnC4
 gq3ZrCtMYR0K8Te4vEB4THImQ/XLmixCPZA3cgEJDH0RwYI3xTLGYC9GfsQYBNHNwiHtcUEsPp3
 a2S9YEw8bA==
X-Received: by 2002:a05:6402:4310:b0:65c:cda:4c27 with SMTP id
 4fb4d7f45d1cf-660ef779db0mr2374737a12.1.1772688961501; Wed, 04 Mar 2026
 21:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20260202075358.2137740-1-jim.shu@sifive.com>
 <20260202075358.2137740-3-jim.shu@sifive.com>
 <aaUkfa3DfURTV83t@ZEVORN-PC.localdomain>
In-Reply-To: <aaUkfa3DfURTV83t@ZEVORN-PC.localdomain>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 5 Mar 2026 13:35:51 +0800
X-Gm-Features: AaiRm5017GirfrdSOkvOOcmwpTMXxt8CJt5CKQsEHZf_KfZX14UPNFeddpl0pMg
Message-ID: <CALw707rZM3ObmC-ckeRtcAgww=1uONetrBP-VqAE4aij5G1mHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] accel/tcg: address_space_translate*() will pass the
 correct iommu_flags
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52a.google.com
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

Hi Chao,


On Mon, Mar 2, 2026 at 1:51=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.com>=
 wrote:
>
> Hi Jim,
>
> On Mon, Feb 02, 2026 at 03:53:58PM +0800, Jim Shu wrote:
> > Instead of IOMMU_NONE, address_space_translate_for_iotlb() now can pass
> > the correct iommu_flags to the IOMMU translate function from the
> > access_type.
> >
> > Since RISC-V wgChecker [1] could permit access in RO or WO permission
> > only, the IOMMUMemoryRegion could return different section for
> > read and write access. To support this kind of IOMMUMemoryRegion
> > in the path of CPU access, we should pass correct iommu_flags here.
> >
> > [1] RISC-V WG:
> > https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  accel/tcg/cputlb.c        |  3 ++-
> >  include/accel/tcg/iommu.h |  3 ++-
> >  system/physmem.c          | 16 +++++++++++-----
> >  3 files changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 2a0f4cfff62..404a8607b9b 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -1050,7 +1050,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx=
,
> >      prot =3D full->prot;
> >      asidx =3D cpu_asidx_from_attrs(cpu, full->attrs);
> >      section =3D address_space_translate_for_iotlb(cpu, asidx, paddr_pa=
ge,
> > -                                                &xlat, &sz, full->attr=
s, &prot);
> > +                                                &xlat, &sz, full->attr=
s, &prot,
> > +                                                access_type);
> >      assert(sz >=3D TARGET_PAGE_SIZE);
> >
> >      tlb_debug("vaddr=3D%016" VADDR_PRIx " paddr=3D0x" HWADDR_FMT_plx
> > diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> > index 547f8ea0ef0..2a79f859834 100644
> > --- a/include/accel/tcg/iommu.h
> > +++ b/include/accel/tcg/iommu.h
> > @@ -20,7 +20,8 @@ MemoryRegionSection *address_space_translate_for_iotl=
b(CPUState *cpu,
> >                                                         hwaddr *xlat,
> >                                                         hwaddr *plen,
> >                                                         MemTxAttrs attr=
s,
> > -                                                       int *prot);
> > +                                                       int *prot,
> > +                                                       MMUAccessType a=
ccess_type);
> >
> >  #endif
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 2fb0c25c93b..337137489de 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -683,12 +683,14 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
> >  MemoryRegionSection *
> >  address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr ori=
g_addr,
> >                                    hwaddr *xlat, hwaddr *plen,
> > -                                  MemTxAttrs attrs, int *prot)
> > +                                  MemTxAttrs attrs, int *prot,
> > +                                  MMUAccessType access_type)
> >  {
> >      MemoryRegionSection *section;
> >      IOMMUMemoryRegion *iommu_mr;
> >      IOMMUMemoryRegionClass *imrc;
> >      IOMMUTLBEntry iotlb;
> > +    IOMMUAccessFlags iommu_flags;
> >      int iommu_idx;
> >      hwaddr addr =3D orig_addr;
> >      AddressSpaceDispatch *d =3D address_space_to_dispatch(cpu->cpu_ase=
s[asidx].as);
> > @@ -705,10 +707,14 @@ address_space_translate_for_iotlb(CPUState *cpu, =
int asidx, hwaddr orig_addr,
> >
> >          iommu_idx =3D imrc->attrs_to_index(iommu_mr, attrs);
> >          tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
> > -        /* We need all the permissions, so pass IOMMU_NONE so the IOMM=
U
> > -         * doesn't short-cut its translation table walk.
> > -         */
> > -        iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_id=
x);
> > +
> > +        if (access_type =3D=3D MMU_DATA_STORE) {
> > +            iommu_flags =3D IOMMU_WO;
> > +        } else {
> > +            iommu_flags =3D IOMMU_RO;
> > +        }
> This maps both MMU_INST_FETCH and MMU_DATA_LOAD to IOMMU_RO. Is this inte=
ntional?
> Some IOMMU implementations might want to distinguish between instruction =
fetch and data read.

Thanks for pointing out it!
I don't know IOMMUAccessFlags enum now has IOMMU_EXEC.
I think mapping three access_types to IOMMU_RO/WO/EXEC is more
accurate. I will fix it in the v2 series.

>
> Or is the current mapping sufficient for your use case (RISC-V wgChecker)=
?
Yes, RW is enough for RISC-V wgChecker now. We don't distinguish EXEC
permission from READ permission.
But I think supporting RWX permissions in the generic code is better.
Perhaps future devices will distinguish RWX permissions.

>
> Thanks,
> Chao
> > +
> > +        iotlb =3D imrc->translate(iommu_mr, addr, iommu_flags, iommu_i=
dx);
> >          addr =3D ((iotlb.translated_addr & ~iotlb.addr_mask)
> >                  | (addr & iotlb.addr_mask));
> >          /* Update the caller's prot bits to remove permissions the IOM=
MU
> > --
> > 2.43.0
> >
> >

