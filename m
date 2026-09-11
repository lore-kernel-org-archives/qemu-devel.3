Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68681C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56pg-0006rJ-80; Fri, 11 Sep 2026 15:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1x56pd-0006qY-Fg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:22:42 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1x56pb-0004Pi-Gg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1789154553; x=1789413753;
 bh=nIRZKGPt4NK1v/TsWXZ2nOibPePiWtzKuyrnrSBgS+0=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HxwdDd8DszXzUzk5Vywivo+hIz05vJ5pRWHPoxKcVk2GQIm44+0igbTM94vYjC5UW
 YvShlidIBG4EvX3YnDyy6cVOoFLP+aUmqH0GPTyr6V5/qdwWwYCSshWJUMAeWPPZUD
 p77+/VwlV9QrSw2cAIukYsM+7URNqlSkRCmgSmCo5R+yFvb/vn2F3OGpIqZBdqX3Zt
 XtQQmw5J5ax4KyjILCwr9d7l7ms2TBu8/g5upOiRTrPVPLiJuwYJGZc3xLLjhKraT3
 9yyTvaTmiqzHCyx45r7zm+R/FH/ibfYedMS0+RG03vgS6Y/UhuvE5NXlDGNZacKFzr
 JADWSOIUuOb/w==
Date: Fri, 11 Sep 2026 19:22:29 +0000
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
From: Christian <christianslima@proton.me>
Subject: Re: [PATCH v2] target/riscv/tcg: svinval instructions raise virtual
 instruction
Message-ID: <UsHsyQAUZK5YOC-OaXZqSE8qAXWXiU7Vyc04UDwogGZTOENNyPKxg8yrg5xHGbHelQh2VV709xWz_gGU5WGBhYc7FcMthw4Od7m8oAhu3nE=@proton.me>
In-Reply-To: <20260911191436.23402-1-christianslima@proton.me>
References: <20260911191436.23402-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: ce8a0cd884029c4beb5ba82a796b030c8ee597ed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=christianslima@proton.me; helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Hi,

> The risc v privileged specification requires hinval.vvma, hinval.gvma,
> sfence.w.inval and sfence.inval.ir should raise a virtual instruction
> exception when executed in the vu-mode. This patch add the check to
> raise the virtual instruction exception when is in the vu-mode.
>=20
> changes in v2:
> - Remove the wrong `return true;` from macro
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621
>=20
> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> ---
>  target/riscv/tcg/insn_trans/trans_svinval.c.inc |  3 +++
>  target/riscv/tcg/insn_trans/trans_xthead.c.inc  | 12 +++++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/ris=
cv/tcg/insn_trans/trans_svinval.c.inc
> index 4614c1489c..5b1172672e 100644
> --- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> @@ -25,6 +25,9 @@
>  /* Test if priv level is M or S. */
>  #define REQUIRE_PRIV_MS(ctx) do {          \
>      if (ctx->priv =3D=3D PRV_U) {              \
> +        if (ctx->virt_enabled) {           \
> +            ctx->virt_inst_excp =3D true     \

I missed a `;` here and below, should I resend a v3?
> +        }                                  \
>          return false;                      \
>      }                                      \
>  } while (0)
> diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/risc=
v/tcg/insn_trans/trans_xthead.c.inc
> index f4e3051000..4bf6594747 100644
> --- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> @@ -267,11 +267,13 @@ static bool trans_th_tst(DisasContext *ctx, arg_th_=
tst *a)
>  #define REQUIRE_PRIV_MSU(ctx)
> =20
>  /* Test if priv level is M or S. */
> -#define REQUIRE_PRIV_MS(ctx)                                    \
> -do {                                                            \
> -    if (ctx->priv =3D=3D PRV_U) {                                   \
> -        return false;                                           \
> -    }                                                           \
> +#define REQUIRE_PRIV_MS(ctx) do {          \
> +    if (ctx->priv =3D=3D PRV_U) {              \
> +        if (ctx->virt_enabled) {           \
> +            ctx->virt_inst_excp =3D true     \
> +        }                                  \
> +        return false;                      \
> +    }                                      \
>  } while (0)
> =20
>  #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \
> --=20
> 2.55.0
>=20
>=20

Thanks,=20
Christian

