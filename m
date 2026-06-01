Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5C3CD6E4C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTtQf-00038h-NC; Sun, 31 May 2026 23:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtQe-00037x-2r
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:35:04 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtQb-0004gD-0Y
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:35:03 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-beb2a97cc9aso278477566b.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780284899; cv=none;
 d=google.com; s=arc-20240605;
 b=k4JRib4qHZ/k7PmZ59Dy897LaqeIolD70z1iOTOgErDNarZuctKO1Y/mAwlMBRaOWS
 nd7CTexlPSegmqT3Qcws4KXNXPU0/NYRN5yVHFddy4c2iBEQp6ikD+Pr0QqyedaK8dDY
 wk7To2NflCU2EJP0I9SutEDRzgA54rzwCR9eaGc6QdEDirz8Y8EO7QoQKQ8MzQBxi7q0
 4Hc7l6aGzPLmZEcDOYLr2BkkaV5MDekVtBL9q6qG/5UPz7IeTeoTtM5bQ5UX421rNhQj
 nGnAW2WmysOugiBeyuW9++WuMUcY5HBihSPNfv79wpjki+mnAT30TIoqTj4GktBee0j3
 JelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TJD7mvh1DzqaoDOtlclZJDPsGvHqLqODPJBk4hUmQ0g=;
 fh=oXbwLIQ6D7eZBIAfdMwTNx3JbGXBw4Kr6QcethzQnTk=;
 b=HhuSzC7F9MAXXRSlgVyXYo5ukPsBJHnoERdLjsImNboLhhrLt+LPedupO7V3ASeb7B
 TCHKEdXgI6m/3BNJS5Ma+QxHwBL+VRWVxXtpS4en5BVPFRkFgeAJfLLbM0kLGuQbPV18
 /GNp7sh5dsW1sW+xbN9RBJwJEoKAr4vX59B8layERQVyFlHEOe6dmFVpMRZVKK4NBAIY
 +3CcNMWbIeoNE3z2URn9EAegWid7p4BdoXbGjxFexEjjvC+OdFFRUn1uJy7Yii739s+T
 za+h11M90mVyQ8zka3uFDLeBUGE7V8qi9837f/oHjY2DjPXQE+QVGeLMizMIN230jMAw
 LpRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780284899; x=1780889699; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJD7mvh1DzqaoDOtlclZJDPsGvHqLqODPJBk4hUmQ0g=;
 b=jC4m7o7ltUhQICsh0V0i3XzLil/VnNappp8iM1YSaSoI/8XxfS9nFXkoo9CeK+XzjG
 U2PF5CNMQTKvaCRuNCaWqyQWSeh4jmVuW5aObqssg+BePmLBZBITpt/em0+0ZehnSnSe
 sEB6MkfUC666TZ9/uWWtpwWz4/63+yoPasE9bbl+y2UFarnjxc8RVEW5iJZQUVF/IlIX
 wpWkvtwD6xyAwJeGibXPlhRyZXEKzrupbNZ1Mlytx3Sdx8jfseZVOG1WwPR2sHN+ynlU
 OVgBDtWIT0j9woXwSLNOrKgTIKCuzts5E66q/mLK8aa706knEJWXcxEOeitdliSwagwH
 NxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780284899; x=1780889699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJD7mvh1DzqaoDOtlclZJDPsGvHqLqODPJBk4hUmQ0g=;
 b=cayClo3d6P3vBSuiUJoOTUaWM91LrTB66C0MT/K9UR2K1go9cp7+z2mTsJiEKCqq4v
 vNjO5BpHve4UCpAHjGriYsTyhSWQE9w75HN70yE2wqnTYunBcdh5d8VVtFPgxLmmFkuR
 bQc9Pdq3yc/qCGzgm6mBSud2lvMkHatC31v385kLo954ZiUBXpYTZqCbsQb5fgWBfF6S
 VhupflaupGlUrIKJDPtoKIxR5LkIew6nu8W00PI+FM1pTUk6yG36TIwZFj51+PKU8bvl
 EUpVlfOwLWuTnQ/pRaK0dluujVBO70A6eTEq9r9swliX2VAs+zdSgekDqx0K6ydPH8x9
 pbhA==
X-Gm-Message-State: AOJu0Yw41cMqfCnvarMNbMYy5aYjp1j66d1jHXuvwFdKpeuYPHWd9guD
 5aQX+cfMNLTA2CXt4bSwLChQs71v5bZm0iTcU4PjVIlT+COpHqMAF7C3RYVAoLOUfrIBcMyW1iC
 Xbc0lq5r1Si8xTXMVB+8DRcxaSlVxdcg=
X-Gm-Gg: Acq92OGNXET5NWKY7YVD2H4e7+//W5HJblkHt2tVvdhLdvLuRppwsbRNM6l+dEXrl06
 YW57/lo0mvpKDa9NAHZF6RQHLpFbbmn6gl3luxhHYYIDK7Etl0oX+NfS70Xj6xzXD5jFa/lKuDx
 gm9ommxe0eWi4BAKuqyrDqvfU4lSq8+dJZCx2Z/UUsECtl6qdjnnZxm3UPD+ZuKjjbicwEuhpAd
 wa+BLHj2Fk77aQj7/4EHoVU1BX713T2woabP/0in5Hd8xRDmAvews/UWv+s36Bj/ud+5gLrpvEO
 umlLWe5nUVepuQk1CUVfMP2xMNyvz8OtIscKGTvKj0tj/Q8y1JudRcTOOuM=
X-Received: by 2002:a17:907:3e87:b0:bd5:40d9:c6c9 with SMTP id
 a640c23a62f3a-beaacc3cabcmr474177966b.0.1780284898695; Sun, 31 May 2026
 20:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-2-philmd@linaro.org>
In-Reply-To: <20260527201348.29511-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:34:31 +1000
X-Gm-Features: AVHnY4ISgyksFFbLSvarGz8KP43kYh84LZi0ypjs-405h-AqAQJVUuP86hd588s
Message-ID: <CAKmqyKNYzr_=9q8=5tx4C-n6rzcXbYpXSqcrHqFz7FXp-dwnMg@mail.gmail.com>
Subject: Re: [PATCH v11 01/12] target/riscv: Initialize DisasContext::mo_endian
 once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, May 28, 2026 at 6:15=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The data access endianness is constant during a translation
> block; rather than calling the mo_endian() method each time,
> initialize the DisasContext::mo_endianness field once in
> TranslatorOps::init_disas_context().
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c                      |  9 ++++++---
>  target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvi.c.inc       |  8 ++++----
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
>  target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 ++--
>  target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
>  target/riscv/insn_trans/trans_xmips.c.inc     |  8 ++++----
>  target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++++--------
>  target/riscv/insn_trans/trans_zilsd.c.inc     |  4 ++--
>  13 files changed, 40 insertions(+), 37 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 1e4f3402569..9367f159f90 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -120,6 +120,8 @@ typedef struct DisasContext {
>      bool fcfi_lp_expected;
>      /* zicfiss extension, if shadow stack was enabled during TB gen */
>      bool bcfi_enabled;
> +    /* Data endianness from MSTATUS UBE/SBE/MBE */
> +    MemOp mo_endianness;
>  } DisasContext;
>
>  static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -155,7 +157,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
>  #define get_address_xl(ctx)    ((ctx)->address_xl)
>  #endif
>
> -#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
> +#define mxl_memop(ctx) ((get_xl(ctx) + 1) | (ctx)->mo_endianness)
>
>  /* The word size for this machine mode. */
>  static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
> @@ -1156,7 +1158,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *=
a,
>      TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
>      MemOp size =3D mop & MO_SIZE;
>
> -    mop |=3D mo_endian(ctx);
> +    mop |=3D ctx->mo_endianness;
>      if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
>          mop |=3D MO_ATOM_WITHIN16;
>      } else {
> @@ -1177,7 +1179,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atom=
ic *a, MemOp mop)
>      TCGv src1 =3D get_address(ctx, a->rs1, 0);
>      TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
>
> -    mop |=3D mo_endian(ctx);
> +    mop |=3D ctx->mo_endianness;
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop)=
;
>
> @@ -1360,6 +1362,7 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->zero =3D tcg_constant_tl(0);
>      ctx->virt_inst_excp =3D false;
>      ctx->decoders =3D cpu->decoders;
> +    ctx->mo_endianness =3D mo_endian(ctx);
>  }
>
>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 62c0fe673d7..44c1696fe4d 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>      TCGv src1;
>
>      mop |=3D MO_ALIGN;
> -    mop |=3D mo_endian(ctx);
> +    mop |=3D ctx->mo_endianness;
>
>      decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
> @@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>      TCGLabel *l2 =3D gen_new_label();
>
>      mop |=3D MO_ALIGN;
> -    mop |=3D mo_endian(ctx);
> +    mop |=3D ctx->mo_endianness;
>
>      decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index ffea0c2a1f9..3b9a745520a 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>      } else {
>          memop |=3D MO_ATOM_IFALIGN;
>      }
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>
>      decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
> @@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>      } else {
>          memop |=3D MO_ATOM_IFALIGN;
>      }
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>
>      decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_=
trans/trans_rvf.c.inc
> index 89fb0f604ad..e935523c93c 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> @@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 2c82ae41a77..2de74fac3a8 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -392,7 +392,7 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *=
a, MemOp memop)
>          }
>      } else {
>          tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
> -        if (mo_endian(ctx) =3D=3D MO_LE) {
> +        if (ctx->mo_endianness =3D=3D MO_LE) {
>              tcg_gen_extr_i128_i64(tl, th, t16);
>          } else {
>              tcg_gen_extr_i128_i64(th, tl, t16);
> @@ -409,7 +409,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>  {
>      bool out;
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> @@ -508,7 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb =
*a, MemOp memop)
>          tcg_gen_ext_tl_i64(tl, src2l);
>          tcg_gen_ext_tl_i64(th, src2h);
>
> -        if (mo_endian(ctx) =3D=3D MO_LE) {
> +        if (ctx->mo_endianness =3D=3D MO_LE) {
>              tcg_gen_concat_i64_i128(t16, tl, th);
>          } else {
>              tcg_gen_concat_i64_i128(t16, th, tl);
> @@ -520,7 +520,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb =
*a, MemOp memop)
>
>  static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>  {
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/i=
nsn_trans/trans_rvzacas.c.inc
> index 8d94b83ce94..79bca1e9572 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic=
 *a, MemOp mop)
>      TCGv src1 =3D get_address(ctx, a->rs1, 0);
>      TCGv_i64 src2 =3D get_gpr_pair(ctx, a->rs2);
>
> -    mop |=3D mo_endian(ctx);
> +    mop |=3D ctx->mo_endianness;
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop=
);
>
> @@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amo=
cas_q *a)
>      TCGv_i64 desth =3D get_gpr(ctx, a->rd =3D=3D 0 ? 0 : a->rd + 1, EXT_=
NONE);
>      MemOp memop =3D MO_ALIGN | MO_UO;
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_concat_i64_i128(src2, src2l, src2h);
>      tcg_gen_concat_i64_i128(dest, destl, desth);
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
insn_trans/trans_rvzalasr.c.inc
> index 0f307affecf..79b0b2c63b8 100644
> --- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_=
aqrl *a, MemOp memop)
>          return false;
>      }
>
> -    memop |=3D MO_ALIGN | mo_endian(ctx);
> +    memop |=3D MO_ALIGN | ctx->mo_endianness;
>      memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>
>      tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
> @@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb=
_aqrl *a, MemOp memop)
>          return false;
>      }
>
> -    memop |=3D MO_ALIGN | mo_endian(ctx);
> +    memop |=3D MO_ALIGN | ctx->mo_endianness;
>      memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>
>      /* Add a memory barrier implied by RL (mandatory) and AQ (optional) =
*/
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/ins=
n_trans/trans_rvzce.c.inc
> index 0d3ba40e52a..71b4ca5473c 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, b=
ool ret, bool ret_val)
>
>      tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      for (i =3D X_Sn + 11; i >=3D 0; i--) {
>          if (reg_bitmap & (1 << i)) {
>              TCGv dest =3D dest_gpr(ctx, i);
> @@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_p=
ush *a)
>
>      tcg_gen_subi_tl(addr, sp, reg_size);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      for (i =3D X_Sn + 11; i >=3D 0; i--) {
>          if (reg_bitmap & (1 << i)) {
>              TCGv val =3D get_gpr(ctx, i, EXT_NONE);
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/ins=
n_trans/trans_rvzfh.c.inc
> index 791ee51f652..f36b46c2118 100644
> --- a/target/riscv/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
> @@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>      REQUIRE_FPU;
>      REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      decode_save_opc(ctx, 0);
>      t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      if (a->imm) {
> @@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>      REQUIRE_FPU;
>      REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      decode_save_opc(ctx, 0);
>      t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      if (a->imm) {
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index 0b6ad57965c..43f586dce97 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_=
amoswap_w *a)
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      src1 =3D get_address(ctx, a->rs1, 0);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
> @@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_=
amoswap_w *a)
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      src1 =3D get_address(ctx, a->rs1, 0);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/ins=
n_trans/trans_xmips.c.inc
> index c1a30156d36..1b9993a9b07 100644
> --- a/target/riscv/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -47,7 +47,7 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a=
)
>  /* Load Doubleword Pair. */
>  static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
>  {
> -    MemOp memop =3D MO_SQ | mo_endian(ctx);
> +    MemOp memop =3D MO_SQ | ctx->mo_endianness;
>
>      REQUIRE_XMIPSLSP(ctx);
>      REQUIRE_64_OR_128BIT(ctx);
> @@ -71,7 +71,7 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
>  /* Load Word Pair. */
>  static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
>  {
> -    MemOp memop =3D MO_SL | mo_endian(ctx);
> +    MemOp memop =3D MO_SL | ctx->mo_endianness;
>
>      REQUIRE_XMIPSLSP(ctx);
>
> @@ -94,7 +94,7 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
>  /* Store Doubleword Pair. */
>  static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
>  {
> -    MemOp memop =3D MO_UQ | mo_endian(ctx);
> +    MemOp memop =3D MO_UQ | ctx->mo_endianness;
>
>      REQUIRE_XMIPSLSP(ctx);
>      REQUIRE_64_OR_128BIT(ctx);
> @@ -116,7 +116,7 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
>  /* Store Word Pair. */
>  static bool trans_swp(DisasContext *ctx, arg_swp *a)
>  {
> -    MemOp memop =3D MO_SL | mo_endian(ctx);
> +    MemOp memop =3D MO_SL | ctx->mo_endianness;
>
>      REQUIRE_XMIPSLSP(ctx);
>
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/in=
sn_trans/trans_xthead.c.inc
> index f8b95c6498b..f4e30510007 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_m=
emidx *a, MemOp memop,
>      TCGv_i64 rd =3D cpu_fpr[a->rd];
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
>      if ((memop & MO_SIZE) =3D=3D MO_32) {
>          gen_nanbox_s(rd, rd);
> @@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_=
memidx *a, MemOp memop,
>      TCGv_i64 rd =3D cpu_fpr[a->rd];
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
>
>      return true;
> @@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_me=
minc *a, MemOp memop,
>      TCGv rd =3D dest_gpr(ctx, a->rd);
>      TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
>      tcg_gen_addi_tl(rs1, rs1, imm);
>      gen_set_gpr(ctx, a->rd, rd);
> @@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_m=
eminc *a, MemOp memop,
>      TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
>      TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>      tcg_gen_addi_tl(rs1, rs1, imm);
>      gen_set_gpr(ctx, a->rs1, rs1);
> @@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_me=
midx *a, MemOp memop,
>      TCGv rd =3D dest_gpr(ctx, a->rd);
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd, rd);
>
> @@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_m=
emidx *a, MemOp memop,
>      TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>
>      return true;
> @@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th=
_pair *a, MemOp memop,
>      addr1 =3D get_address(ctx, a->rs, imm);
>      addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
>      tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd1, t1);
> @@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_t=
h_pair *a, MemOp memop,
>      addr1 =3D get_address(ctx, a->rs, imm);
>      addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
>
> -    memop |=3D mo_endian(ctx);
> +    memop |=3D ctx->mo_endianness;
>      tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
>      tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
>      return true;
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/ins=
n_trans/trans_zilsd.c.inc
> index f50c52f22c9..8068cc1aec4 100644
> --- a/target/riscv/insn_trans/trans_zilsd.c.inc
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
>      TCGv addr =3D get_address(ctx, a->rs1, a->imm);
>      TCGv_i64 tmp =3D tcg_temp_new_i64();
>
> -    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx))=
;
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiann=
ess);
>
>      if (a->rd =3D=3D 0) {
>          return true;
> @@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
>      } else {
>          tcg_gen_concat_tl_i64(tmp, data_low, data_high);
>      }
> -    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx))=
;
> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiann=
ess);
>
>      return true;
>  }
> --
> 2.53.0
>
>

