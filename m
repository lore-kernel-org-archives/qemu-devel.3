Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D16EC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 02:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8qEC-0006Y4-N3; Mon, 21 Sep 2026 22:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1x8qEA-0006Xt-Nk
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 22:27:26 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1x8qE8-0007Bc-6D
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 22:27:26 -0400
Received: from yuno-loong.localnet (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 6738FDFDB;
 Tue, 22 Sep 2026 07:57:20 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 numpy1314 <xzj13@mail.ustc.edu.cn>
Subject: Re: [PATCH v2 RESEND] tcg/loongarch: strip flag bits in lddir/ldpte
 address calculation
Date: Tue, 22 Sep 2026 10:27:17 +0800
Message-ID: <NegrN_VbTWu2wbiZ-Ts7Mw@krgm.moe>
In-Reply-To: <e296151c-aa91-52fc-8594-594a159223db@loongson.cn>
References: <20260920024217.18116-1-prcups@krgm.moe>
 <MJ6h21vjTT6CIdZq9lG7Dg@krgm.moe>
 <e296151c-aa91-52fc-8594-594a159223db@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026=E5=B9=B49=E6=9C=8822=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C =E4=B8=AD=
=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 09:35:30=EF=BC=8CBibo Mao wro=
te=EF=BC=9A
>=20
> On 2026/9/21 =E4=B8=8B=E5=8D=8812:17, SignKirigami wrote:
> > On 2026=E5=B9=B49=E6=9C=8820=E6=97=A5=E6=98=9F=E6=9C=9F=E6=97=A5 =E4=B8=
=AD=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 11:48:53=EF=BC=8CBibo Mao =
wrote=EF=BC=9A
> >>
> >> On 2026/9/20 =E4=B8=8A=E5=8D=8810:42, SignKirigami wrote:
> >>> helper_lddir and helper_ldpte used TARGET_PHYS_MASK (bits 0-47) when
> >>> extracting the base address from a directory entry.  This retained fl=
ag
> >>> bits (V, D, PLV, MAT, etc.) at positions 0-11, which were then OR'd
> >> For LoongArch, what is scenery with DIR/PTE entry where bit0-bit11 such
> >> as (V, D, PLV, MAT, etc.) is used, except Huge bit?
> >>
> >> Regards
> >> Bibo Mao
> > This patch is originally from rcore developers, and it seems to be hard=
ware's
> > responsibility to clear 0-11 bits.
> Could you show me the web link how hardware clears 0-11 bits with=20
> LDDIR/LDPTE instruction?
>=20
> Regards
> Bibo Mao
Sorry I just read the documentation and find no such definition. I will wit=
hdraw
this patch.
Regards
SignKirigami
>=20
> > Regards
> > SignKirigami
> >>> with the next-level index, producing a wrong physical address whenever
> >>> the directory entry carried non-zero flags.
> >>>
> >>> Fix both helpers to extract only the PPN field (bits 12-47) before
> >>> computing the address of the next-level page table entry.
> >>>
> >>> Signed-off-by: numpy1314 <xzj13@mail.ustc.edu.cn>
> >>> Signed-off-by: SignKirigami <prcups@krgm.moe>
> >>> ---
> >>> This patch is a resend of [1], Sorry for wrongly handling Signed-off-=
by.
> >>>   =20
> >>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05581.h=
tml.
> >>>   =20
> >>>    target/loongarch/tcg/tlb_helper.c | 7 ++-----
> >>>    1 file changed, 2 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg=
/tlb_helper.c
> >>> index 40cc076424..529b22347d 100644
> >>> --- a/target/loongarch/tcg/tlb_helper.c
> >>> +++ b/target/loongarch/tcg/tlb_helper.c
> >>> @@ -750,7 +750,7 @@ target_ulong helper_lddir(CPULoongArchState *env,=
 target_ulong base,
> >>>        }
> >>>   =20
> >>>        badvaddr =3D sys->CSR_TLBRBADV;
> >>> -    base =3D base & palen_mask;
> >>> +    base =3D base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
> >>>        get_dir_base_width(env, &dir_base, &dir_width, level);
> >>>        index =3D (badvaddr >> dir_base) & ((1 << dir_width) - 1);
> >>>        phys =3D base | index << 3;
> >>> @@ -773,7 +773,6 @@ void helper_ldpte(CPULoongArchState *env, target_=
ulong base, target_ulong odd,
> >>>        uint64_t dir_base, dir_width;
> >>>        uint8_t  ps;
> >>>   =20
> >>> -
> >>>        /*
> >>>         * The parameter "base" has only two types,
> >>>         * one is the page table base address,
> >>> @@ -815,9 +814,7 @@ void helper_ldpte(CPULoongArchState *env, target_=
ulong base, target_ulong odd,
> >>>            }
> >>>        } else {
> >>>            badv =3D sys->CSR_TLBRBADV;
> >>> -
> >>> -        base =3D base & palen_mask;
> >>> -
> >>> +        base =3D base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
> >>>            ptindex =3D (badv >> ptbase) & ((1 << ptwidth) - 1);
> >>>            ptindex =3D ptindex & ~0x1;   /* clear bit 0 */
> >>>            ptoffset0 =3D ptindex << 3;
> >>>
> >>
> >>
> >=20
> >=20
> >=20
>=20
>=20





