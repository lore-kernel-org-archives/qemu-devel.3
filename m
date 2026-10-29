Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D1606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=vbWFNvkJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUim-0000q1-3z; Thu, 29 Oct 2026 14:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUiL-0000ck-UP; Thu, 29 Oct 2026 14:19:04 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUiJ-0007cg-TR; Thu, 29 Oct 2026 14:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=PHZL/s0XzcAj5PIhf37hlZKc5KZI2gPGCxPqGHVaD/8=; b=vbWFNvkJ2NZW2Kmjl6FAT8+YY8
 jYMwFmhIBZ4quQEZbvaTgWptwAbYegqUOV7yvMH8kuoJkp48/mHq/AFDi5Wjjeg7GnpFK1JPqGWlm
 Xk5mTwuNOL1tYYE7Kg1GIlCE1Z1yGBm70x/ObA8q7QT1RWWOZXAH7sf2s+ft7pdy2D8KbI37wDVpx
 PVXQ66rJVJwS8hblnzcwcyt045Hy/CDHNPwLR5WLEhcVToaofVSPO+YNHqudIzXw557mGoc63CBSj
 52BabI/uk6RlZ/7PWIw0bjkBPBZpNsTvSIoAo7N+25fNJosMJ4ntONazoZf+4zxeORqN5P9UqX9UP
 rJZebGcw==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xMUiH-00000006t5e-0xsu;
 Thu, 29 Oct 2026 19:18:57 +0100
Date: Thu, 29 Oct 2026 19:18:56 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v3 3/6] tcg/riscv64: Extract elements for vector
 arithmetic immediates
Message-ID: <auOOEFFecNzz9mCG@aurel32.net>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-4-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261028143330.6518-4-philmd@oss.qualcomm.com>
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
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28 15:33, Philippe Mathieu-Daud=C3=A9 wrote:
> The .vi emitters for add, reverse sub and saturating ops pass the
> whole replicated constant (e.g. 0x0505050505050505) to encode_vi()
> instead of a single element. This aborts debug builds on common
> vectorized guest code and is undefined behaviour in release builds.
>=20
> Add vec_imm() to extract the VECE element, and use it.
>=20
> Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  tcg/riscv64/tcg-target.c.inc | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 0e749ae296b8..a3d995e290b7 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -735,6 +735,12 @@ static void tcg_out_opc_vi_u(TCGContext *s, RISCVIns=
n opc,
>      tcg_out32(s, encode_vi_u(opc, vd, imm, vs2, true));
>  }
> =20
> +/* Constants are replicated by VECE; extract one element for .vi forms. =
*/
> +static int64_t vec_imm(TCGArg arg, unsigned vece)
> +{
> +    return sextract64(arg, 0, 8 << vece);
> +}
> +
>  static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o=
_vi,
>                                TCGReg vd, TCGReg vs2, TCGArg vi1, int c_v=
i1)
>  {
> @@ -2788,12 +2794,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpco=
de opc,
>          break;
>      case INDEX_op_add_vec:
>          set_vtype_len_sew(s, type, vece);
> -        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1,
> +                          c2 ? vec_imm(a2, vece) : a2, c2);
>          break;
>      case INDEX_op_sub_vec:
>          set_vtype_len_sew(s, type, vece);
>          if (const_args[1]) {
> -            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, a1);
> +            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, vec_imm(a1, vece));
>          } else {
>              tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
>          }
> @@ -2824,19 +2831,23 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpco=
de opc,
>          break;
>      case INDEX_op_ssadd_vec:
>          set_vtype_len_sew(s, type, vece);
> -        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1,
> +                          c2 ? vec_imm(a2, vece) : a2, c2);
>          break;
>      case INDEX_op_sssub_vec:
>          set_vtype_len_sew(s, type, vece);
> -        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1,
> +                          c2 ? vec_imm(a2, vece) : a2, c2);
>          break;
>      case INDEX_op_usadd_vec:
>          set_vtype_len_sew(s, type, vece);
> -        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1, a2, c=
2);
> +        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1,
> +                          c2 ? vec_imm(a2, vece) : a2, c2);
>          break;
>      case INDEX_op_ussub_vec:
>          set_vtype_len_sew(s, type, vece);
> -        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1, a2, c=
2);
> +        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1,
> +                          c2 ? vec_imm(a2, vece) : a2, c2);
>          break;
>      case INDEX_op_smax_vec:
>          set_vtype_len_sew(s, type, vece);

This is technically correct. That said, the goal of all this extra code=20
is to satisfy the assert added in commit 006352d69f14 ("tcg/riscv64:=20
Assert immediate in range for {i,s,u,vi}-type insns") not to fix the=20
code generation which is correct as it only keeps the lower 5 bits of=20
the immediate.

At this stage we already know that the immediate can be represented as a=20
duplicated simm5 constant, so just dropping the assert could be a=20
simpler way to fix the issue.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

