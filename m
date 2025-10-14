Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB396CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XMe-0000OQ-1I; Tue, 14 Oct 2025 01:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XMc-0000OA-O8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:14:22 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XMa-0004jR-D5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:14:22 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso2576680a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760418858; x=1761023658; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wli1l3eHXxsaW9hMSSt0fxLTPKgNEVtro7RZ1sS0bKU=;
 b=A8kkYPdQoLlx7dHXvXNzeR0iUGmHkGUmiCRk/LfizEob7Gi7fR8qo5TkixHj9jWRyc
 VtsRUgYRAomADA8I8DNPX3DEwmqrXVv8JvjjWUdAhXuSuHJFdrQz7mvkRb9MkB63Wh/f
 Y2TXW2EYUGGlvy9qXfNov7SoAAitXtZeQyuoXqALnBCmQnu4elEyWJJ5xIWVABGNOwRn
 BFRjAa8GnayNEQOzaX8j30GGdl3dBBgxrRgs0BHBa6GXcRP0EAoQZxHGvmSLPyoRhFWw
 3GBEBuykjqWsdw3itpoSYaenjdoHFzdrRkjBcZoyvjrdGqNlA2x9/4gXv3VZRA+5B4Y3
 i0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760418858; x=1761023658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wli1l3eHXxsaW9hMSSt0fxLTPKgNEVtro7RZ1sS0bKU=;
 b=XPIfc3oavUaYoSJ4K+y4WiXs7zka7YSzLiGzwzsc6ECuhSNLJO7szVvqbDAQSnO1IF
 XB/6Pr+v2bhAoaZWStdaBedq1YYQWhiFIDzOXxjsY58b0QH6PVrZndVxViDGvYD3/iwE
 mFgDoNE6JfUF1juQDVZnB1Cg3BqsWERwjoujgjUWFbL5S9g1zc0F0RY8FTm+F8uUy6d0
 mxerI9PiusCN0WSWro9fJPO7L3rKiIQTwViiDU+sq2K+oFaWiekWUF2Nh5g6VhEAA1VD
 XCMYrn66Ssdyy7YwE5O9LYTDZrd5GUPaDZfg4l1r6kMST1/MyHW9XhMbDvJVoWA/6oYi
 b4yg==
X-Gm-Message-State: AOJu0YwIjSWzC1dFUNNynvdrpTTbWl5ZvnZ0TPOllpACM/4uF+iY5wA4
 /eGR3WIOLhR6Nd8exFM2IGHbzGx3KtMJBTMbszRgN/0a+qDkpoMZ3+Phxslk8KNv6/t+LYLZEli
 aYRXFNO/S/CjM1KmHQRMOiTk55WnFgog=
X-Gm-Gg: ASbGncvKcKyklbFGcNHfiwRLAHQBezxqy/YRLO8wiO5ek+tPqUBo+RBXVW99J0IOmy2
 Xbwio62KCpwCIJoUYSsZ9LZDGjV5wvNFz/+rTDEtZ4nDTA3rowfI0shq+Qn5k6uk7LTEORyiGz8
 PAAfQXXUwYzfe6WKir+Q/u/09hlsWurV+cS9nr0Gl03090X6RN1R/YrnL7quKlQ2beRukzpCxWy
 fLpuTISSTojoJNKTn7sclVjMJKJ2nILuWDxwRhrFznHYTZEITYCsi5leZJx+gJ/G3prZei7vlE8
 5Q==
X-Google-Smtp-Source: AGHT+IEutQa6qY4on97+jWAupav89i2wiSW8XYyU+Ercn/h52BChOZvyX+PAGBrbqrrhylHAlW34krnl9s3zBOoa6Sk=
X-Received: by 2002:a05:6402:42cb:b0:639:e5da:637e with SMTP id
 4fb4d7f45d1cf-639e5da69a0mr22443180a12.6.1760418858415; Mon, 13 Oct 2025
 22:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-13-philmd@linaro.org>
In-Reply-To: <20251010155045.78220-13-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Oct 2025 15:13:51 +1000
X-Gm-Features: AS18NWAcIZFe_EaAEGC3PJeYB9co56CzuFa17bYnwjsdUQnkyGI30ekkSbSwXk4
Message-ID: <CAKmqyKOXj7yt4WiRPYsyr-EMX1GK8h0ODuZVDmsR-Vxk5HWOEA@mail.gmail.com>
Subject: Re: [PATCH 12/13] target/riscv: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christoph Muellner <christoph.muellner@vrull.eu>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 11, 2025 at 1:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> mo_endian() returns the target endianness from DisasContext.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c                      | 18 +++++++++++++++---
>  target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvi.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
>  target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
>  target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++++--------
>  10 files changed, 39 insertions(+), 27 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2e6f39aa02d..e1f4dc5ffd0 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -126,6 +126,18 @@ static inline bool has_ext(DisasContext *ctx, uint32=
_t ext)
>      return ctx->misa_ext & ext;
>  }
>
> +static inline MemOp mo_endian(DisasContext *ctx)
> +{
> +    /*
> +     * A couple of bits in MSTATUS set the endianness:
> +     *  - MSTATUS_UBE (User-mode),
> +     *  - MSTATUS_SBE (Supervisor-mode),
> +     *  - MSTATUS_MBE (Machine-mode)
> +     * but we don't implement that yet.
> +     */
> +    return MO_TE;
> +}
> +
>  #ifdef TARGET_RISCV32
>  #define get_xl(ctx)    MXL_RV32
>  #elif defined(CONFIG_USER_ONLY)
> @@ -142,7 +154,7 @@ static inline bool has_ext(DisasContext *ctx, uint32_=
t ext)
>  #define get_address_xl(ctx)    ((ctx)->address_xl)
>  #endif
>
> -#define mxl_memop(ctx) ((get_xl(ctx) + 1) | MO_TE)
> +#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
>
>  /* The word size for this machine mode. */
>  static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
> @@ -1135,7 +1147,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *=
a,
>      TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
>      MemOp size =3D mop & MO_SIZE;
>
> -    mop |=3D MO_TE;
> +    mop |=3D mo_endian(ctx);
>      if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
>          mop |=3D MO_ATOM_WITHIN16;
>      } else {
> @@ -1156,7 +1168,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atom=
ic *a, MemOp mop)
>      TCGv src1 =3D get_address(ctx, a->rs1, 0);
>      TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
>
> -    mop |=3D MO_TE;
> +    mop |=3D mo_endian(ctx);
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop)=
;
>
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 8737e8d60d1..a7a3278d242 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>      TCGv src1;
>
>      mop |=3D MO_ALIGN;
> -    mop |=3D MO_TE;
> +    mop |=3D mo_endian(ctx);
>
>      decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
> @@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>      TCGLabel *l2 =3D gen_new_label();
>
>      mop |=3D MO_ALIGN;
> -    mop |=3D MO_TE;
> +    mop |=3D mo_endian(ctx);
>
>      decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index 62b75358158..ffea0c2a1f9 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>      } else {
>          memop |=3D MO_ATOM_IFALIGN;
>      }
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>
>      decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
> @@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>      } else {
>          memop |=3D MO_ATOM_IFALIGN;
>      }
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>
>      decode_save_opc(ctx, 0);
>      addr =3D get_address(ctx, a->rs1, a->imm);
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_=
trans/trans_rvf.c.inc
> index 878417eae92..89fb0f604ad 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> @@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 8db3e78baab..a6fe912b30c 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -404,7 +404,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>  {
>      bool out;
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> @@ -508,7 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb =
*a, MemOp memop)
>
>  static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>  {
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/i=
nsn_trans/trans_rvzacas.c.inc
> index 6458ac4f241..8d94b83ce94 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic=
 *a, MemOp mop)
>      TCGv src1 =3D get_address(ctx, a->rs1, 0);
>      TCGv_i64 src2 =3D get_gpr_pair(ctx, a->rs2);
>
> -    mop |=3D MO_TE;
> +    mop |=3D mo_endian(ctx);
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
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_concat_i64_i128(src2, src2l, src2h);
>      tcg_gen_concat_i64_i128(dest, destl, desth);
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/ins=
n_trans/trans_rvzce.c.inc
> index 172c2c19c17..0d3ba40e52a 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, b=
ool ret, bool ret_val)
>
>      tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      for (i =3D X_Sn + 11; i >=3D 0; i--) {
>          if (reg_bitmap & (1 << i)) {
>              TCGv dest =3D dest_gpr(ctx, i);
> @@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_p=
ush *a)
>
>      tcg_gen_subi_tl(addr, sp, reg_size);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      for (i =3D X_Sn + 11; i >=3D 0; i--) {
>          if (reg_bitmap & (1 << i)) {
>              TCGv val =3D get_gpr(ctx, i, EXT_NONE);
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/ins=
n_trans/trans_rvzfh.c.inc
> index 5355cd46c3d..791ee51f652 100644
> --- a/target/riscv/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
> @@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>      REQUIRE_FPU;
>      REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      decode_save_opc(ctx, 0);
>      t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      if (a->imm) {
> @@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>      REQUIRE_FPU;
>      REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      decode_save_opc(ctx, 0);
>      t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      if (a->imm) {
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index 89eed007587..0b6ad57965c 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_=
amoswap_w *a)
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      src1 =3D get_address(ctx, a->rs1, 0);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
> @@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_=
amoswap_w *a)
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      src1 =3D get_address(ctx, a->rs1, 0);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/in=
sn_trans/trans_xthead.c.inc
> index 2f31842791e..f8b95c6498b 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_m=
emidx *a, MemOp memop,
>      TCGv_i64 rd =3D cpu_fpr[a->rd];
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
>      if ((memop & MO_SIZE) =3D=3D MO_32) {
>          gen_nanbox_s(rd, rd);
> @@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_=
memidx *a, MemOp memop,
>      TCGv_i64 rd =3D cpu_fpr[a->rd];
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
>
>      return true;
> @@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_me=
minc *a, MemOp memop,
>      TCGv rd =3D dest_gpr(ctx, a->rd);
>      TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
>      tcg_gen_addi_tl(rs1, rs1, imm);
>      gen_set_gpr(ctx, a->rd, rd);
> @@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_m=
eminc *a, MemOp memop,
>      TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
>      TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>      tcg_gen_addi_tl(rs1, rs1, imm);
>      gen_set_gpr(ctx, a->rs1, rs1);
> @@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_me=
midx *a, MemOp memop,
>      TCGv rd =3D dest_gpr(ctx, a->rd);
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd, rd);
>
> @@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_m=
emidx *a, MemOp memop,
>      TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>
>      return true;
> @@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th=
_pair *a, MemOp memop,
>      addr1 =3D get_address(ctx, a->rs, imm);
>      addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
>      tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd1, t1);
> @@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_t=
h_pair *a, MemOp memop,
>      addr1 =3D get_address(ctx, a->rs, imm);
>      addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
>
> -    memop |=3D MO_TE;
> +    memop |=3D mo_endian(ctx);
>      tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
>      tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
>      return true;
> --
> 2.51.0
>
>

