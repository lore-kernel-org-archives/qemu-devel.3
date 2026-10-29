Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF01606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=D+lJiEOH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUi4-0000VA-NF; Thu, 29 Oct 2026 14:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUhr-0000Tz-0B; Thu, 29 Oct 2026 14:18:31 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUho-0007Zr-Ns; Thu, 29 Oct 2026 14:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=K1795+BLaev0AqoUar6fhoLDa+AVEoEMtGQXA6Tb/j4=; b=D+lJiEOHjY8VMRZDkAdIpKfMa5
 WEU48rK+aTS3Dq2KHvCgfawerFu3F4fpU3Q5OStX78xgdaEI+INMN/vaxv2D6xHd2gJq72/8BTx/H
 veQpsQl5LxCj34pUsQuQEGSKZNzMKLDfpQFcKhOGh9w4TaRo0lYtEB/xCdk2YRA6zkkgXczYcnoIF
 CvMP8nFjIpZJI6sd9K8w4DrRfu4DfjNQaZU5EtJ5Vv9P5oyyLTTIwL3pKsZ4NHEedxdvPmFq/yTiY
 loOcHiNZLRLzLtOB1FqO8OP0XU9+MtBnAtUvEECW4GdTER0zuueexsmX56qaodeAHuK6FKUt/I/Ry
 yC+2q7ow==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xMUhb-00000006t3j-2cXv;
 Thu, 29 Oct 2026 19:18:15 +0100
Date: Thu, 29 Oct 2026 19:18:14 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v3 1/6] tcg/riscv64: Factor encode_vi_raw() out of
 encode_vi()
Message-ID: <auON5t2MX_QpkULZ@aurel32.net>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-2-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261028143330.6518-2-philmd@oss.qualcomm.com>
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
> Move the OPIVI field layout into encode_vi_raw(), keeping the
> simm5 check in encode_vi(). The next commit adds a uimm5 variant
> for the vector shift instructions. No functional change.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  tcg/riscv64/tcg-target.c.inc | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 03f32c5819f3..712170c1203e 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -534,12 +534,18 @@ static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg=
 rd, tcg_target_long imm)
> =20
>  /* Type-OPIVI */
> =20
> +static tcg_insn_unit encode_vi_raw(RISCVInsn opc, TCGReg rd, unsigned im=
m5,
> +                                   TCGReg vs2, bool vm)
> +{
> +    return opc | (rd & 0x1f) << 7 | (imm5 & 0x1f) << 15 |
> +           (vs2 & 0x1f) << 20 | (vm << 25);
> +}
> +
>  static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long=
 imm,
>                                 TCGReg vs2, bool vm)
>  {
>      tcg_debug_assert(imm =3D=3D sextract32(imm, 0, 5));
> -    return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
> -           (vs2 & 0x1f) << 20 | (vm << 25);
> +    return encode_vi_raw(opc, rd, imm, vs2, vm);
>  }
> =20
>  /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

