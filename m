Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89DA109E53D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aIs-0001nV-Pe; Wed, 25 Mar 2026 22:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aIq-0001nA-BE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:18:32 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aIn-0000dn-Qo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:18:31 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-661b16ac011so730729a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491501; cv=none;
 d=google.com; s=arc-20240605;
 b=Kq8WTmYsf8pbir/h+5FUUkSQ0PVTxhzTr1+LqnB7cETUGHaMuHleuo/cRmm9ipYCeo
 LAqbb5zZJQXjOTLC/WGeqRoRq4a6byrjJ1VZIDzkuPqUEbYgzsRAwNh8puoQhyFe35YR
 7WMDlvMHGBTaC+KFvmPnuwzCU3eu5IqKY6twHxioJa4JZ6Bl32GJAXk3zvvokWeBO7Vx
 M7gffqzY/0P8MGgJWeWu0qjOgrxY5BpR6e6pCr/NmdVEzHXryM2os0YYA4NVfoIz6esS
 AOOlyjhzolCCzov+jfBAOexU9VAhzoFKgLlBlDsSw+Ugg853FmBSLYN9eO8CNX0cwVl4
 BjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8AXnvnR1paAU8tXsYJNXvabCFiZCrLESdxiiwzMYMd0=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=C7f8CU+i/fMh2pT5IqO0EwCqkHiaeyeOiDqxj0Uzrr8r3ex35BtX2ONMoFldEG9zQv
 jwzqid/ayDlxZeLM8RzB4dJBF6pIcbFcyX3Y0sCS5IpsBhj5yDehGy7towMVm2LIGRtH
 l6wmeoav8FNRW+T1awWKUn5zCc4ZwS2ExxatNuuMB/usJB3W/QVP7bJBxqbkFgTwiK7g
 QUjmqEQPPsqR7L/hs3kHbkPZAVb8h1eBrumRx01kA/C59RVPVBYXlXzD5AJIzJlGSZm/
 HNy8iz0J2ae1JEfAEsBuZV0ZlXbkI6/gqBUji+erKW5kvVx+VrSOonJHKazVzyR6n01Z
 RAAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491501; x=1775096301; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AXnvnR1paAU8tXsYJNXvabCFiZCrLESdxiiwzMYMd0=;
 b=Nd7clNFbT22dPAN0TYbulKjylrgB7yLeCnDXXKFHYVPRzr+u/WBJF+QEpvHqtI1ptU
 GcEX0mVipchKhIsw8H6jBGcmGnamgAUpW61wNRRnhqb4yb8C8YA/H+2AwyUtSpy5p9wU
 +5wa+iLrMvCEaio41SIxhCege93clDQZ6WWWiJUVYBQbSI4pEUd4B1uRnKZGWGqKkDea
 /G0SjqAH0HPnOWoIg4wgn6rz9TprfyT/zZdDlA0lNrr5YYVyrepBlzT5QNWkP0v81FY2
 EnjYstDa6l0YwyQi7OvUzYGX0LeavCRls9709dgDXYniwDhGfrAaA37TyfJjGJfRFa+O
 swHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491501; x=1775096301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8AXnvnR1paAU8tXsYJNXvabCFiZCrLESdxiiwzMYMd0=;
 b=eQCnSbF9EySQn+zDBWz6YtxoCiCBF8I6plVk+PynGnjuthNYn8ZtRhfiYI1PBdYkbh
 WlXyS5yPjYO5iWpMfDm5eLLKBWp3epzCP7dEIXjjqXS1chQVe2OcpfEW7WqggpGf4iUf
 cVs47S8rz3UFfE+KT+gRyu4NQAZIsOY4uYfxWnqZRsykNqk1U2DbuGuBMjSygwnna68u
 xk4AI5rUeeaj+kiSssstLjZP7XjsMZZOLcVZpF1VoCjzPsmH6RaIb8IKFeBbOvw5hY+0
 VmWHHgWmH+98uGYXHuMIZyJRbB+tfnd3exCAfeloDAoXUFKvsIYCf8j2tQuMDfphfxLM
 3REg==
X-Gm-Message-State: AOJu0YxIeQOxd6ICinKLwWTqtKmUMJ4qea/dhdj+0b0zRJACZNwx+/Zl
 NMUGR6u4AS4dLMyGqDIe0bcgaVsh/r3dS6907XvI2wt1qLeXm12tTffYRQm5SBrr57Nji6g1f6x
 ZPCKFVxdYfBWdLf9GzJPdTq/YdjMDOPc=
X-Gm-Gg: ATEYQzz4cT5l94gXwBWT2SYaNlif1da6dmiLJSSgF59XXAOCB1FmM5pyGkO7lWkcI2v
 QtyxEFzAxWdn7IZNkGvXF72pziXWH1B6RZ+V+bjOvn+fwAdrMXFp3rM8Ga++5j2+TPpceyeDLK3
 7PS0Gc8Pf/Vtn6/UGN0beZEquDQ2QDqvEUnrhYRryTEOkOtMiJySscqfWL6Qq91/7I7Ey07DfOu
 wamAZa9JEM5Z1JGb2uMPoLvnI7FnNwfVNDvFwADRb7R878I6nApt5bpSvbq59jEpwoDz1M2EbIj
 XdFFPnZq/BQxSu8czVZszpM6BdNjRpvQJoZK7w==
X-Received: by 2002:a17:906:c14d:b0:b97:aba7:1969 with SMTP id
 a640c23a62f3a-b9a5428e034mr403746866b.45.1774491501222; Wed, 25 Mar 2026
 19:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-12-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-12-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:17:54 +1000
X-Gm-Features: AQROBzABXc_aGSUa_C52C1KRzYu65Ok8kn25q_lcCPfVsZ_T1qf99cZHbBUi2n8
Message-ID: <CAKmqyKObn0jUY17TfYV8wu7-cxFPdkVY3H6eojoLaNBcpLAkrg@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 11/16] target/riscv: Replace MO_TE by mo_endian
 (MIPS extension)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, Mar 18, 2026 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Replace compile-time MO_TE evaluation by runtime mo_endian()
> one, which expand target endianness from DisasContext.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_xmips.c.inc | 24 +++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/ins=
n_trans/trans_xmips.c.inc
> index 37572563ae9..c1a30156d36 100644
> --- a/target/riscv/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -47,6 +47,8 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a=
)
>  /* Load Doubleword Pair. */
>  static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
>  {
> +    MemOp memop =3D MO_SQ | mo_endian(ctx);
> +
>      REQUIRE_XMIPSLSP(ctx);
>      REQUIRE_64_OR_128BIT(ctx);
>
> @@ -56,11 +58,11 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_y);
> -    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SQ);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd, dest0);
>
>      tcg_gen_addi_tl(addr, addr, 8);
> -    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SQ);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rs3, dest1);
>
>      return true;
> @@ -69,6 +71,8 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
>  /* Load Word Pair. */
>  static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
>  {
> +    MemOp memop =3D MO_SL | mo_endian(ctx);
> +
>      REQUIRE_XMIPSLSP(ctx);
>
>      TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> @@ -77,11 +81,11 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_x);
> -    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SL);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd, dest0);
>
>      tcg_gen_addi_tl(addr, addr, 4);
> -    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SL);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rs3, dest1);
>
>      return true;
> @@ -90,6 +94,8 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
>  /* Store Doubleword Pair. */
>  static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
>  {
> +    MemOp memop =3D MO_UQ | mo_endian(ctx);
> +
>      REQUIRE_XMIPSLSP(ctx);
>      REQUIRE_64_OR_128BIT(ctx);
>
> @@ -99,10 +105,10 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_w);
> -    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_UQ);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, memop);
>
>      tcg_gen_addi_tl(addr, addr, 8);
> -    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_UQ);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, memop);
>
>      return true;
>  }
> @@ -110,6 +116,8 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
>  /* Store Word Pair. */
>  static bool trans_swp(DisasContext *ctx, arg_swp *a)
>  {
> +    MemOp memop =3D MO_SL | mo_endian(ctx);
> +
>      REQUIRE_XMIPSLSP(ctx);
>
>      TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> @@ -118,10 +126,10 @@ static bool trans_swp(DisasContext *ctx, arg_swp *a=
)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_v);
> -    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_SL);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, memop);
>
>      tcg_gen_addi_tl(addr, addr, 4);
> -    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_SL);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, memop);
>
>      return true;
>  }
> --
> 2.53.0
>
>

