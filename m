Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B78606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=U/IBZu73
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUud-0004re-10; Thu, 29 Oct 2026 14:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUua-0004pO-Lp; Thu, 29 Oct 2026 14:31:41 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUuY-0000Qa-E7; Thu, 29 Oct 2026 14:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=4Qha117QRS21OgQpYbDm0SzaGSZgnPFC6W+McltwsKA=; b=U/IBZu73hKKcryebE+nUx4SHJV
 sIZUu2Db5GTVA2wvWBetOLOH0Bwp2HTW7D8xv9hUPZ/VPALPBXq0xur+fN5/B6lePGRfuq69eaz9J
 QRxfRPyOb0Eiv0CUl1wM9O34DvrxmteRhGkD5JjtGiIA4ZZw3aDbz7QS/7WEUNNjwONN+Ea7y3ygp
 ghq8vJA4YDb9NevEeH7ja4R3Ctfx99dTAbYptz6oNAMNWseySHZEh9M9CLnIeB/a0w3CxdFw4Vmgb
 8L9LZxiAj3JUF7HQ338aG4M5yQbwApNJ5TcXNV2lx9feKAIY/o2hDWrInv2iw5rw9XPKG3hGUAXaC
 GyfQhZ+g==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xMUuR-00000006tsT-0sbT;
 Thu, 29 Oct 2026 19:31:31 +0100
Date: Thu, 29 Oct 2026 19:31:30 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v3 4/6] tcg/riscv64: Fix constant handling in vector
 comparisons and selects
Message-ID: <auORAhkbaN3lRIZU@aurel32.net>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-5-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261028143330.6518-5-philmd@oss.qualcomm.com>
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

On 2026-10-28 15:33, Philippe Mathieu-Daud=C3=A9 wrote:
> tcg_out_cmpsel() takes constants as TCGReg and passes them to the
> encoders unextracted. In a release build, "cmlt v0.8h, #0" emitted
> the illegal instruction 0xffffb057.
>=20
> Use TCGArg for these operands and extract the element with
> vec_imm() before encoding, including before the LT/GE adjustment.
>=20
> Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  tcg/riscv64/tcg-target.c.inc | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index a3d995e290b7..168932711796 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -1555,9 +1555,9 @@ static void tcg_out_cltz(TCGContext *s, TCGType typ=
e, RISCVInsn insn,
> =20
>  static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
>                             TCGCond cond, TCGReg ret,
> -                           TCGReg cmp1, TCGReg cmp2, bool c_cmp2,
> -                           TCGReg val1, bool c_val1,
> -                           TCGReg val2, bool c_val2)
> +                           TCGReg cmp1, TCGArg cmp2, bool c_cmp2,
> +                           TCGArg val1, bool c_val1,
> +                           TCGArg val2, bool c_val2)
>  {
>      set_vtype_len_sew(s, type, vece);
> =20
> @@ -1574,7 +1574,7 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType t=
ype, unsigned vece,
>      /* Perform the comparison into V0 mask. */
>      if (c_cmp2) {
>          tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op, TCG_REG_V0, cm=
p1,
> -                       cmp2 - tcg_cmpcond_to_rvv_vi[cond].adjust);
> +                       vec_imm(cmp2, vece) - tcg_cmpcond_to_rvv_vi[cond]=
=2Eadjust);
>      } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
>          tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
>                         TCG_REG_V0, cmp2, cmp1);
> @@ -1584,11 +1584,12 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType=
 type, unsigned vece,
>      }
>      if (c_val1) {
>          if (c_val2) {
> -            tcg_out_opc_vi(s, OPC_VMV_V_I, ret, 0, val2);
> +            tcg_out_opc_vi(s, OPC_VMV_V_I, ret, 0, vec_imm(val2, vece));
>              val2 =3D ret;
>          }
>          /* vd[i] =3D=3D v0.mask[i] ? imm : vs2[i] */
> -        tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, ret, val2, val1);
> +        tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, ret, val2,
> +                             vec_imm(val1, vece));
>      } else {
>          /* vd[i] =3D=3D v0.mask[i] ? vs1[i] : vs2[i] */
>          tcg_out_opc_vvm_mask(s, OPC_VMERGE_VVM, ret, val2, val1);

Similar to my previous comment. This is technically correct, but if such=20
an instruction is generated, it also means that a field is not properly=20
masked when generating the opcode.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

