Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA88606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=FugtIJRn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUwZ-0005fM-Nk; Thu, 29 Oct 2026 14:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUwR-0005cq-Lb; Thu, 29 Oct 2026 14:33:36 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xMUwP-0000YS-Gr; Thu, 29 Oct 2026 14:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=gmF+Jq301LEauedsOElIktogKLgoxrmSqzjhPdXHagM=; b=FugtIJRnA8SmmMimqwxU9RRp4w
 spDk4U5X0t8mw+mRVayfrMqu9jASQ1SYszep3Kx6w8FycQh6tc7wQ9TeHo335GnaY/TuonO/yS4O3
 dHibEAhzv8T2SNivDtZVZjXx0JIWmX/2HNBjD19T5eZriYHCViL7lYW+e7CyCZdDe3b1En3R4bwEF
 BV9kz9SufSC1Cu8Jho2UfGpf+x6zW7CcVn7eNy4pIiTDgL5cn4ZGAjh1y6Sf5XOzo6tCkWpAwA8zE
 hJypgPNkeqDfVCMQCIrsfUHG2Rjj4wzHaKDg5JIMc9HPyf0iDbhTUJ5KXISwmjoWiK6pcvEpw/0RL
 l9NkF8IQ==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xMUwL-00000006twJ-0Tu1;
 Thu, 29 Oct 2026 19:33:29 +0100
Date: Thu, 29 Oct 2026 19:33:28 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3 5/6] tcg/riscv64: Fix logical vector immediate
 matching and emission
Message-ID: <auOReLXT3EK7ITyf@aurel32.net>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-6-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261028143330.6518-6-philmd@oss.qualcomm.com>
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
> and/or/xor_vec always have VECE 0, yet their constant was matched
> as a byte element and applied at the stale SEW of the previous op:
> "bic v4.8h, #0xf0" became "vand.vi ..., 15".
>=20
> Add the 'N' constraint: use the smallest element size at which the
> constant replicates, if that element fits simm5, and switch SEW to
> it. A wider element can't fit when the smallest doesn't: its upper
> half repeats the smaller element, which would then be 0 or -1.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  tcg/riscv64/tcg-target-con-set.h |  1 +
>  tcg/riscv64/tcg-target-con-str.h |  1 +
>  tcg/riscv64/tcg-target.c.inc     | 53 +++++++++++++++++++++++++++-----
>  3 files changed, 48 insertions(+), 7 deletions(-)
>=20
> diff --git a/tcg/riscv64/tcg-target-con-set.h b/tcg/riscv64/tcg-target-co=
n-set.h
> index 0fc26d3f98b4..9b4e219fac16 100644
> --- a/tcg/riscv64/tcg-target-con-set.h
> +++ b/tcg/riscv64/tcg-target-con-set.h
> @@ -26,4 +26,5 @@ C_O1_I2(v, v, v)
>  C_O1_I2(v, vK, v)
>  C_O1_I2(v, v, vK)
>  C_O1_I2(v, v, vL)
> +C_O1_I2(v, v, vN)
>  C_O1_I4(v, v, vL, vK, vK)
> diff --git a/tcg/riscv64/tcg-target-con-str.h b/tcg/riscv64/tcg-target-co=
n-str.h
> index c04e15ddfa3c..d7e8b2ce4f2f 100644
> --- a/tcg/riscv64/tcg-target-con-str.h
> +++ b/tcg/riscv64/tcg-target-con-str.h
> @@ -19,3 +19,4 @@ CONST('I', TCG_CT_CONST_S12)
>  CONST('K', TCG_CT_CONST_S5)
>  CONST('L', TCG_CT_CONST_CMP_VI)
>  CONST('M', TCG_CT_CONST_M12)
> +CONST('N', TCG_CT_CONST_LOGICAL_VI)
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 168932711796..4faf7ff36e07 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -116,6 +116,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnK=
ind kind, int slot)
>  #define TCG_CT_CONST_M12     0x200
>  #define TCG_CT_CONST_S5      0x400
>  #define TCG_CT_CONST_CMP_VI  0x800
> +#define TCG_CT_CONST_LOGICAL_VI 0x1000
> =20
>  #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
>  #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
> @@ -384,6 +385,22 @@ static const struct {
>      [TCG_COND_GEU] =3D { OPC_VMSGTU_VI,   1, 16, true  },
>  };
> =20
> +/*
> + * Return the element size at which VAL is a replicated simm5,
> + * or -1 if there is none.  Used for vector logical ops, whose
> + * VECE is not meaningful.
> + */
> +static int vec_logical_immediate_vece(int64_t val)
> +{
> +    for (int e =3D MO_8; e <=3D MO_64; e++) {
> +        if (val =3D=3D dup_const(e, val)) {
> +            int64_t x =3D sextract64(val, 0, 8 << e);
> +            return x >=3D -0x10 && x <=3D 0x0f ? e : -1;
> +        }
> +    }
> +    g_assert_not_reached();
> +}
> +
>  /* test if a constant matches the constraint */
>  static bool tcg_target_const_match(int64_t val, int ct,
>                                     TCGType type, TCGCond cond, int vece)
> @@ -391,6 +408,10 @@ static bool tcg_target_const_match(int64_t val, int =
ct,
>      if (ct & TCG_CT_CONST) {
>          return 1;
>      }
> +    if ((ct & TCG_CT_CONST_LOGICAL_VI) &&
> +        vec_logical_immediate_vece(val) >=3D 0) {
> +        return true;
> +    }
>      if (type >=3D TCG_TYPE_V64) {
>          /* Val is replicated by VECE; extract the highest element. */
>          val >>=3D (-8 << vece) & 63;
> @@ -2769,6 +2790,23 @@ static const TCGOutOpStore outop_st =3D {
>  };
> =20
> =20
> +static void tcg_out_opc_vv_vi_logical(TCGContext *s, TCGType type,
> +                                      RISCVInsn o_vv, RISCVInsn o_vi,
> +                                      TCGReg vd, TCGReg vs2,
> +                                      TCGArg vi1, int c_vi1)
> +{
> +    if (c_vi1) {
> +        int vece =3D vec_logical_immediate_vece(vi1);
> +
> +        tcg_debug_assert(vece >=3D 0);
> +        set_vtype_len_sew(s, type, vece);
> +        tcg_out_opc_vi(s, o_vi, vd, vs2, vec_imm(vi1, vece));
> +    } else {
> +        set_vtype_len(s, type);
> +        tcg_out_opc_vv(s, o_vv, vd, vs2, vi1);
> +    }
> +}
> +
>  static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>                             unsigned vecl, unsigned vece,
>                             const TCGArg args[TCG_MAX_OP_ARGS],
> @@ -2807,16 +2845,16 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpco=
de opc,
>          }
>          break;
>      case INDEX_op_and_vec:
> -        set_vtype_len(s, type);
> -        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv_vi_logical(s, type, OPC_VAND_VV, OPC_VAND_VI,
> +                                  a0, a1, a2, c2);
>          break;
>      case INDEX_op_or_vec:
> -        set_vtype_len(s, type);
> -        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv_vi_logical(s, type, OPC_VOR_VV, OPC_VOR_VI,
> +                                  a0, a1, a2, c2);
>          break;
>      case INDEX_op_xor_vec:
> -        set_vtype_len(s, type);
> -        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2, c2);
> +        tcg_out_opc_vv_vi_logical(s, type, OPC_VXOR_VV, OPC_VXOR_VI,
> +                                  a0, a1, a2, c2);
>          break;
>      case INDEX_op_not_vec:
>          set_vtype_len(s, type);
> @@ -3008,10 +3046,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, uns=
igned flags)
>      case INDEX_op_sari_vec:
>      case INDEX_op_rotli_vec:
>          return C_O1_I1(v, v);
> -    case INDEX_op_add_vec:
>      case INDEX_op_and_vec:
>      case INDEX_op_or_vec:
>      case INDEX_op_xor_vec:
> +        return C_O1_I2(v, v, vN);
> +    case INDEX_op_add_vec:
>      case INDEX_op_ssadd_vec:
>      case INDEX_op_sssub_vec:
>      case INDEX_op_usadd_vec:

I am still wondering why not propagating VECE for logical ops at the TCG=20
level, instead of recomputing it at the TCG target level. But this is=20
how TCG is currently designed, so:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

