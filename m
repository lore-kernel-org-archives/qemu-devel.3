Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBA606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=rfGkawOY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUiI-0000YF-2O; Thu, 29 Oct 2026 14:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUi1-0000VZ-Gg; Thu, 29 Oct 2026 14:18:44 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUhq-0007aF-KP; Thu, 29 Oct 2026 14:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=d88egsE4Flh1HrHMC+XEKWtEN2xFG8NYrPa9hP0IaFk=; b=rfGkawOYqvEVOP4brPhCpu2Ok9
 ORPmgDSg1Dx0Mc13jT9EjOoaCcoXyzy6/nhzMonEvZBWneoGTEA8tEuXolpqVREn20c42agjRJn4d
 w1Vh90VlEsBjxDgr0sXVTXYdtm9ujAsaat3RTyfGj08imi6/DYtGK51wAUFFBctK84Ajp3XOriEeX
 CJyuhTwRExHurTOE5QRuNUNhG5SyY1hTekRYgfBtmJWGq+vu9EonQj4ugR5Vwqo0UYNkCpfpMGa/2
 iK2SNb4oEsxuPw5X0RTRJ3oLnZWDVC4YwgIKy193AxnPkQK2qihp6HNeBHizKdfGtf6GY5qVL9Lvn
 cJtBRQkw==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xMUhj-00000006t4A-0grM;
 Thu, 29 Oct 2026 19:18:23 +0100
Date: Thu, 29 Oct 2026 19:18:22 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v3 2/6] tcg/riscv64: Use a uimm5 encoder for vector shift
 immediates
Message-ID: <auON7vRCYNPDXAk2@aurel32.net>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-3-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261028143330.6518-3-philmd@oss.qualcomm.com>
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
> RVV shift .vi forms take an unsigned 5-bit immediate, but
> encode_vi() checks for simm5, so shift counts 16..31 trip
> the debug assertion (and are undefined behaviour in release
> builds).
>=20
> Add encode_vi_u() and use it in tcg_out_vshifti().
>=20
> Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  tcg/riscv64/tcg-target.c.inc | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 712170c1203e..0e749ae296b8 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -541,6 +541,7 @@ static tcg_insn_unit encode_vi_raw(RISCVInsn opc, TCG=
Reg rd, unsigned imm5,
>             (vs2 & 0x1f) << 20 | (vm << 25);
>  }
> =20
> +/* OPIVI with a signed immediate (simm5). */
>  static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long=
 imm,
>                                 TCGReg vs2, bool vm)
>  {
> @@ -548,6 +549,14 @@ static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg=
 rd, tcg_target_long imm,
>      return encode_vi_raw(opc, rd, imm, vs2, vm);
>  }
> =20
> +/* OPIVI with an unsigned immediate (uimm5) */
> +static tcg_insn_unit encode_vi_u(RISCVInsn opc, TCGReg rd, unsigned imm,
> +                                 TCGReg vs2, bool vm)
> +{
> +    tcg_debug_assert(imm =3D=3D extract32(imm, 0, 5));
> +    return encode_vi_raw(opc, rd, imm, vs2, vm);
> +}
> +
>  /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
> =20
>  static tcg_insn_unit encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
> @@ -720,6 +729,12 @@ static void tcg_out_opc_vi(TCGContext *s, RISCVInsn =
opc,
>      tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
>  }
> =20
> +static void tcg_out_opc_vi_u(TCGContext *s, RISCVInsn opc,
> +                             TCGReg vd, TCGReg vs2, unsigned imm)
> +{
> +    tcg_out32(s, encode_vi_u(opc, vd, imm, vs2, true));
> +}
> +
>  static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o=
_vi,
>                                TCGReg vd, TCGReg vs2, TCGArg vi1, int c_v=
i1)
>  {
> @@ -1578,7 +1593,7 @@ static void tcg_out_vshifti(TCGContext *s, RISCVIns=
n opc_vi, RISCVInsn opc_vx,
>                               TCGReg dst, TCGReg src, unsigned imm)
>  {
>      if (imm < 32) {
> -        tcg_out_opc_vi(s, opc_vi, dst, src, imm);
> +        tcg_out_opc_vi_u(s, opc_vi, dst, src, imm);
>      } else {
>          tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP0, imm);
>          tcg_out_opc_vx(s, opc_vx, dst, src, TCG_REG_TMP0);

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

