Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6E606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=t9ZG9tHM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLpCK-0006Tu-3p; Tue, 27 Oct 2026 17:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xLpBx-0006Se-3X; Tue, 27 Oct 2026 17:58:51 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xLpBu-0000cF-LT; Tue, 27 Oct 2026 17:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=PhqQokH4yi1j+DYTamiBorU6dRzvOcTSnWKnhpdmm0Y=; b=t9ZG9tHMFlGuDu9SmBjom+lq3E
 GKksE092FnMgonN20ZxqvgDIazTi5QXknaN2fEnVsN/3+38Hn0mm0VLTI22PA16lebHkHEulNLxMh
 SssNEj+pKk/5WuXAdf4nPZGwcf9AkolTermmjR/q+WMjdITQGa+8z42+Okc0xtQRxOcUJtuzuNU+S
 356prjGULInavV8MjE81uaE3Rj/v2oQgXsRC2IeJaYRiM/2VkT6PSDBmv4ZjM/Hr9YgIeB5A1CTEz
 OOtB8PGHdZGiLZ2cZivruUYt8jvnC0WuY7YZfhACx10liNvskXVaZrphwd6T6i7atcRRN/FhHi1l7
 lWuFDFkg==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xLpBi-000000044Zx-3OW7;
 Tue, 27 Oct 2026 22:58:34 +0100
Date: Tue, 27 Oct 2026 22:58:33 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical
 ops
Message-ID: <auEeif_51q1K9XOz@aurel32.net>
References: <20261010174742.3552498-1-aurelien@aurel32.net>
 <9ca6f711-e886-46a5-80ea-a6c750696a93@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9ca6f711-e886-46a5-80ea-a6c750696a93@oss.qualcomm.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, GB_FAKE_RF=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe,

On 2026-10-24 19:00, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/10/26 19:46, Aurelien Jarno wrote:
> > For logical vector operations (in the case of the RISC-V backend that
> > corresponds to and_vec, or_vec and xor_vec), VECE is unused. However,
> > tcg_target_const_match() always treat it as an element size to extract
> > the corresponding constant element from the whole constant.
> >=20
> > This causes the following aarch64 instruction
> >    bic v4.8h, #0xf0
> > to be translated into the following op:
> >    ...
> >    and_vec v128,e8,tmp5,tmp4,v128$0xff0fff0fff0fff0f
> >    ...
> > which is then translated to the following RISC-V instruction:
> >    vand.vi v1,v1,15
> >=20
> > Fix that by, when VECE is 0 aka MO_8, only extracting the element if the
> > it can actually be represented as a duplicated constant.
> >=20
> > Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >   tcg/riscv64/tcg-target.c.inc | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > Changes v1 -> v2:
> > - Use dup_const() instead of open coding the constant duplication.
> >=20
> > diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> > index 14a397117a..1262b71a62 100644
> > --- a/tcg/riscv64/tcg-target.c.inc
> > +++ b/tcg/riscv64/tcg-target.c.inc
> > @@ -392,8 +392,15 @@ static bool tcg_target_const_match(int64_t val, in=
t ct,
> >           return 1;
> >       }
> >       if (type >=3D TCG_TYPE_V64) {
> > -        /* Val is replicated by VECE; extract the highest element. */
> > -        val >>=3D (-8 << vece) & 63;
> > +        /*
> > +         * For vector logical operations, VECE is unused and equals to=
 0, so
> > +         * we need to check that the constant can properly be represen=
ted after
> > +         * replication.
> > +         */
> > +        if ((vece !=3D MO_8) || (val =3D=3D dup_const(vece, val))) {
> > +            /* Val is replicated by VECE; extract the highest element.=
 */
> > +            val >>=3D (-8 << vece) & 63;
> > +        }
> >       }
>=20
> This fixes the BIC case, but I don't think it is sufficient.
>=20
> I tested with qemu-aarch64 built for a riscv64 host, run under
> qemu-riscv64 -cpu max, guest -cpu max,sve-default-vector-length=3D16.
>=20
> NEON bic v0.8h, #0xf0 // fail on master, now OK
>=20
> add z1.b; and z0.d, #0xf // FAIL
> add z1.d; and z0.b, #0xf // FAIL
> add z1.b; orr z0.d, #-16 // FAIL
> add z1.d; eor z0.b, #0xf // FAIL

This indeed doesn't work. The problem is that while the constant=20
matching is being passed VECE =3D 0 (as it is unused for logical ops), the=
=20
code generation is still being passed a 64-bit size. Therefore for the=20
eor, it emits:
  vsetivli                zero,2,e64,m1,ta,ma
  lui                     t6,3
  addiw                   t6,t6,-448
  add                     t6,t6,s0
  vle64.v                 v1,(t6)
  vxor.vi                 v1,v1,15

It would make more sense to use 16 e8 elements like in the original ARM=20
SVE code, but it seems that info is lost at this stage.

> Not accepting constants for and/or/xor_vec at all
> (using C_O1_I2(v, v, v) to get them loaded into registers)
> makes all five cases pass (I'm not sure we want to keep
> the .vi forms):
>=20
> -- >8 --
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -2779,15 +2779,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpco=
de
> opc,
>      case INDEX_op_and_vec:
>          set_vtype_len(s, type);
> -        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2);
>          break;
>      case INDEX_op_or_vec:
>          set_vtype_len(s, type);
> -        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2);
>          break;
>      case INDEX_op_xor_vec:
>          set_vtype_len(s, type);
> -        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2);
>          break;
>      case INDEX_op_not_vec:
>          set_vtype_len(s, type);
> @@ -2976,15 +2976,15 @@ tcg_target_op_def(TCGOpcode op, TCGType type,
> unsigned flags)
>      case INDEX_op_rotli_vec:
>          return C_O1_I1(v, v);
>      case INDEX_op_add_vec:
> -    case INDEX_op_and_vec:
> -    case INDEX_op_or_vec:
> -    case INDEX_op_xor_vec:
>      case INDEX_op_ssadd_vec:
>      case INDEX_op_sssub_vec:
>      case INDEX_op_usadd_vec:
>      case INDEX_op_ussub_vec:
>          return C_O1_I2(v, v, vK);
>      case INDEX_op_sub_vec:
>          return C_O1_I2(v, vK, v);
> +    case INDEX_op_and_vec:
> +    case INDEX_op_or_vec:
> +    case INDEX_op_xor_vec:
>      case INDEX_op_mul_vec:
>      case INDEX_op_shlv_vec:
>      case INDEX_op_shrv_vec:
>      case INDEX_op_sarv_vec:
>      case INDEX_op_rotlv_vec:
>      case INDEX_op_rotrv_vec:
>      case INDEX_op_smax_vec:
>      case INDEX_op_smin_vec:
>      case INDEX_op_umax_vec:
>      case INDEX_op_umin_vec:
>          return C_O1_I2(v, v, v);

I believe that until TCG is able to propagate VECE even for logical ops,=20
this is the thing to do. It generates suboptimal code, but correct one.=20
Therefore

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Cheers
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

