Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF60CC982F1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 04:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8VTM-0003Z8-EF; Mon, 21 Sep 2026 00:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1x8VTJ-0003Yl-W1
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:17:42 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1x8VTH-0003hZ-Nl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:17:41 -0400
Received: from yuno-loong.localnet (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 4E8CFDFC6;
 Mon, 21 Sep 2026 09:47:32 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 numpy1314 <xzj13@mail.ustc.edu.cn>
Subject: Re: [PATCH v2 RESEND] tcg/loongarch: strip flag bits in lddir/ldpte
 address calculation
Date: Mon, 21 Sep 2026 12:17:28 +0800
Message-ID: <MJ6h21vjTT6CIdZq9lG7Dg@krgm.moe>
In-Reply-To: <7c9246fb-3a0d-268c-1540-ddc05a71a927@loongson.cn>
References: <20260920024217.18116-1-prcups@krgm.moe>
 <7c9246fb-3a0d-268c-1540-ddc05a71a927@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

On 2026=E5=B9=B49=E6=9C=8820=E6=97=A5=E6=98=9F=E6=9C=9F=E6=97=A5 =E4=B8=AD=
=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 11:48:53=EF=BC=8CBibo Mao wro=
te=EF=BC=9A
>=20
> On 2026/9/20 =E4=B8=8A=E5=8D=8810:42, SignKirigami wrote:
> > helper_lddir and helper_ldpte used TARGET_PHYS_MASK (bits 0-47) when
> > extracting the base address from a directory entry.  This retained flag
> > bits (V, D, PLV, MAT, etc.) at positions 0-11, which were then OR'd
> For LoongArch, what is scenery with DIR/PTE entry where bit0-bit11 such=20
> as (V, D, PLV, MAT, etc.) is used, except Huge bit?
>=20
> Regards
> Bibo Mao
This patch is originally from rcore developers, and it seems to be hardware=
's=20
responsibility to clear 0-11 bits.
Regards
SignKirigami
> > with the next-level index, producing a wrong physical address whenever
> > the directory entry carried non-zero flags.
> >=20
> > Fix both helpers to extract only the PPN field (bits 12-47) before
> > computing the address of the next-level page table entry.
> >=20
> > Signed-off-by: numpy1314 <xzj13@mail.ustc.edu.cn>
> > Signed-off-by: SignKirigami <prcups@krgm.moe>
> > ---
> > This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
> >  =20
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05581.htm=
l.
> >  =20
> >   target/loongarch/tcg/tlb_helper.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/t=
lb_helper.c
> > index 40cc076424..529b22347d 100644
> > --- a/target/loongarch/tcg/tlb_helper.c
> > +++ b/target/loongarch/tcg/tlb_helper.c
> > @@ -750,7 +750,7 @@ target_ulong helper_lddir(CPULoongArchState *env, t=
arget_ulong base,
> >       }
> >  =20
> >       badvaddr =3D sys->CSR_TLBRBADV;
> > -    base =3D base & palen_mask;
> > +    base =3D base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
> >       get_dir_base_width(env, &dir_base, &dir_width, level);
> >       index =3D (badvaddr >> dir_base) & ((1 << dir_width) - 1);
> >       phys =3D base | index << 3;
> > @@ -773,7 +773,6 @@ void helper_ldpte(CPULoongArchState *env, target_ul=
ong base, target_ulong odd,
> >       uint64_t dir_base, dir_width;
> >       uint8_t  ps;
> >  =20
> > -
> >       /*
> >        * The parameter "base" has only two types,
> >        * one is the page table base address,
> > @@ -815,9 +814,7 @@ void helper_ldpte(CPULoongArchState *env, target_ul=
ong base, target_ulong odd,
> >           }
> >       } else {
> >           badv =3D sys->CSR_TLBRBADV;
> > -
> > -        base =3D base & palen_mask;
> > -
> > +        base =3D base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
> >           ptindex =3D (badv >> ptbase) & ((1 << ptwidth) - 1);
> >           ptindex =3D ptindex & ~0x1;   /* clear bit 0 */
> >           ptoffset0 =3D ptindex << 3;
> >=20
>=20
>=20





