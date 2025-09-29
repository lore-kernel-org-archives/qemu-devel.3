Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89491CAC5BB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 00:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v31me-0004TE-AR; Sun, 28 Sep 2025 20:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31mb-0004S1-Ff
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:30:25 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31mN-0006C0-1X
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:30:22 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b346142c74aso772915166b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759105804; x=1759710604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEhL83cXq6NCAs1MvLq9cWKQv/a9ASIBvF/6tyxOrHE=;
 b=e6y6+KMfen62hfl8JIAUPvUbhYQbmx6aEo+J9t7HMbedPWwyV8kFQAKTPRf01jtPlv
 IM6ZlYxPrALHOOdN35XWYQ5LjoVArdZwhniI0jUfucUyo0eJs8JnMsOow7kr7Qa86Q9I
 WbswWUtIGEPyzEn/CqQ67xVLPoOf82pjMfVS96+TRdVnlAkzJ/0slf1euLD1ITG2NwDK
 iNLPGFY3xq2e6tNxrw6NPu6BOFf1A2hOvhA+941/TmngRfe0khIMBatnbc9hqbjXmuGq
 GRxqZenbdV27yt/FVXOPgRygfMdQNaNU+aOnTTw9yHrTzqv7sDmTSbCBtEXUyKSJpAMv
 yg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759105804; x=1759710604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SEhL83cXq6NCAs1MvLq9cWKQv/a9ASIBvF/6tyxOrHE=;
 b=oXfqaSknNefzzWCHdb8TTLf5+ME6ZWOEVfUToFGghmxYdf8cSp3Nt422kiDKX2939r
 D/5kPVfTaMhfXDdNFhYVKYU4fGHcnBuSege3FdY/8emt+9ZTfRPI32iVN/7HsdwyIMiD
 nWBRhbIUE15bVBC/Swv7bqLgTbaBl54MPVZiXVKBOScNkJ6KDAajlwWJ+nLHpywOfJVq
 qGfN+K2oUowHxksaHvsJD4rdDF8k6f3ReNd2gFuzYxRKZckFRf2MTBbn+C67cNGIOi73
 tk3Sp5IKg0g/5r7Kg6BE/xU9jR6Jrx73ylztWdZMJV2Au8sp4mqAB8gcY1JslYFPMtvO
 bPfw==
X-Gm-Message-State: AOJu0Yzw8ony75VWtBafNM9gH4EmVlEasq9nrF77c5QuqNQwXdWQR0BX
 nWOiTnwoN784bWy6nU0WnFrvCJ/1RSKoWt/sXXjm9Wfeva9R9vIadMnl2A9RPlm3RUcl2bJXFRw
 J7FXceJedd7FIud2psY6qigNTF5ZOCU4=
X-Gm-Gg: ASbGnculMN2wMA7LbXw3pZKHYXG0wUxsDbJCcnnvls3ljxMhnk1My0eqirymHXXvj4V
 kG7xbm+E2W/3Tu151KCqJx5LYjmK4Y3OFd8ex4pOna+hQVCJDIRpCJ5VNn0Y+Nw8ocTPSxhkm2y
 z23D+Q2chFLF/iXQVOWMDoH6at4jLB/XmaX7S4YIecCX+dYgf1t4lKRQSNL0dS0oXoe7uRlfmEu
 /1Vs6DWH5TtOgb0ykc5JBoSiY+vs88f52S4Uu6CAq+vUuLh
X-Google-Smtp-Source: AGHT+IHFvVUuNuMUPYUtnunizj2zLGymVWAOzes7r7DXdsLck8114vXqcFrU/62l/1zeRt8I9MIRoxMvi4cxHk3CHag=
X-Received: by 2002:a17:907:7f0f:b0:b2b:a56f:5420 with SMTP id
 a640c23a62f3a-b34b6449c67mr1589647266b.2.1759105803074; Sun, 28 Sep 2025
 17:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <c20e4af47811456eaf5f185cd75fca7f@hightec-rt.com>
In-Reply-To: <c20e4af47811456eaf5f185cd75fca7f@hightec-rt.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:29:35 +1000
X-Gm-Features: AS18NWAhi5k98njLdzEx7eaeB6MhZpCKfMhQG0wBsW8IvVHffXgjs7GedujXy1A
Message-ID: <CAKmqyKNkubehzvdg+RkSXFVvshT+EXbHnak6siKzvuCmJu=0JQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: check registers for RV32E/RV64E
To: Gergely Futo <Gergely.Futo@hightec-rt.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 19, 2025 at 11:58=E2=80=AFPM Gergely Futo via <qemu-devel@nongn=
u.org> wrote:
>
> RV32E and RV64E reduce the integer register count to 16 general-purpose
> registers, (x0-x15), where x0 is a dedicated zero register.

So the problem today is that RV32E/64E can access all 32 registers?

>
> This patch checks the register usage if the `E` extension is active.
>
> The instructions from the following extensions are covered:
>    - Base Integer Instruction Set
>    - "M" for Integer Multiplication and Division
>    - "A" Extension for Atomic Instructions
>    - "B" Extension for Bit Manipulation
>    - "Zce" Extension for Code Size Reduction
>    - "Zicond" Extension for Integer Conditional Operations

Manually checking every single instruction doesn't seem like the right
way to do this. Can't we just limit the registers if using E instead
of I?

Alistair

>
> Signed-off-by: Gergely Futo <gergely.futo@hightec-rt.com>
> ---
>  target/riscv/insn_trans/trans_rva.c.inc      |  44 ++++++
>  target/riscv/insn_trans/trans_rvb.c.inc      |  96 +++++++++++++
>  target/riscv/insn_trans/trans_rvi.c.inc      | 134 +++++++++++++++++++
>  target/riscv/insn_trans/trans_rvm.c.inc      |  32 +++++
>  target/riscv/insn_trans/trans_rvzce.c.inc    |   3 +
>  target/riscv/insn_trans/trans_rvzicond.c.inc |   2 +
>  target/riscv/translate.c                     |  28 ++++
>  7 files changed, 339 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 9cf3ae8019..b87534b9aa 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -99,72 +99,96 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, =
MemOp mop)
>  static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>  {
>      REQUIRE_A_OR_ZALRSC(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
>  }
>
>  static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
>  {
>      REQUIRE_A_OR_ZALRSC(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
>  }
>
>  static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
>  }
>
>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESL);
>  }
>
>  static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESL);
>  }
>
>  static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESL);
>  }
>
>  static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESL);
>  }
>
>  static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESL);
>  }
>
>  static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESL);
>  }
>
>  static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESL);
>  }
>
>  static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESL);
>  }
>
>  static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
>  {
>      REQUIRE_64BIT(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      REQUIRE_A_OR_ZALRSC(ctx);
>      return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
>  }
> @@ -172,6 +196,8 @@ static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a=
)
>  static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
>  {
>      REQUIRE_64BIT(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      REQUIRE_A_OR_ZALRSC(ctx);
>      return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
>  }
> @@ -180,6 +206,8 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_am=
oswap_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
>  }
>
> @@ -187,6 +215,8 @@ static bool trans_amoadd_d(DisasContext *ctx, arg_amo=
add_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TEUQ);
>  }
>
> @@ -194,6 +224,8 @@ static bool trans_amoxor_d(DisasContext *ctx, arg_amo=
xor_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TEUQ);
>  }
>
> @@ -201,6 +233,8 @@ static bool trans_amoand_d(DisasContext *ctx, arg_amo=
and_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TEUQ);
>  }
>
> @@ -208,6 +242,8 @@ static bool trans_amoor_d(DisasContext *ctx, arg_amoo=
r_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TEUQ);
>  }
>
> @@ -215,6 +251,8 @@ static bool trans_amomin_d(DisasContext *ctx, arg_amo=
min_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TEUQ);
>  }
>
> @@ -222,6 +260,8 @@ static bool trans_amomax_d(DisasContext *ctx, arg_amo=
max_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TEUQ);
>  }
>
> @@ -229,6 +269,8 @@ static bool trans_amominu_d(DisasContext *ctx, arg_am=
ominu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TEUQ);
>  }
>
> @@ -236,5 +278,7 @@ static bool trans_amomaxu_d(DisasContext *ctx, arg_am=
omaxu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TEUQ);
>  }
> diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/insn_=
trans/trans_rvb.c.inc
> index e4dcc7c991..f8eae605ce 100644
> --- a/target/riscv/insn_trans/trans_rvb.c.inc
> +++ b/target/riscv/insn_trans/trans_rvb.c.inc
> @@ -69,6 +69,8 @@ static void gen_clzw(TCGv ret, TCGv arg1)
>  static bool trans_clz(DisasContext *ctx, arg_clz *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary_per_ol(ctx, a, EXT_NONE, gen_clz, gen_clzw);
>  }
>
> @@ -85,66 +87,88 @@ static void gen_ctzw(TCGv ret, TCGv arg1)
>  static bool trans_ctz(DisasContext *ctx, arg_ctz *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary_per_ol(ctx, a, EXT_ZERO, gen_ctz, gen_ctzw);
>  }
>
>  static bool trans_cpop(DisasContext *ctx, arg_cpop *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_ZERO, tcg_gen_ctpop_tl);
>  }
>
>  static bool trans_andn(DisasContext *ctx, arg_andn *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_logic(ctx, a, tcg_gen_andc_tl);
>  }
>
>  static bool trans_orn(DisasContext *ctx, arg_orn *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_logic(ctx, a, tcg_gen_orc_tl);
>  }
>
>  static bool trans_xnor(DisasContext *ctx, arg_xnor *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_logic(ctx, a, tcg_gen_eqv_tl);
>  }
>
>  static bool trans_min(DisasContext *ctx, arg_min *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, tcg_gen_smin_tl, NULL);
>  }
>
>  static bool trans_max(DisasContext *ctx, arg_max *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, tcg_gen_smax_tl, NULL);
>  }
>
>  static bool trans_minu(DisasContext *ctx, arg_minu *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, tcg_gen_umin_tl, NULL);
>  }
>
>  static bool trans_maxu(DisasContext *ctx, arg_maxu *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, tcg_gen_umax_tl, NULL);
>  }
>
>  static bool trans_sext_b(DisasContext *ctx, arg_sext_b *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext8s_tl);
>  }
>
>  static bool trans_sext_h(DisasContext *ctx, arg_sext_h *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext16s_tl);
>  }
>
> @@ -165,12 +189,16 @@ static void gen_bset(TCGv ret, TCGv arg1, TCGv sham=
t)
>  static bool trans_bset(DisasContext *ctx, arg_bset *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift(ctx, a, EXT_NONE, gen_bset, NULL);
>  }
>
>  static bool trans_bseti(DisasContext *ctx, arg_bseti *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_bset);
>  }
>
> @@ -185,12 +213,16 @@ static void gen_bclr(TCGv ret, TCGv arg1, TCGv sham=
t)
>  static bool trans_bclr(DisasContext *ctx, arg_bclr *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift(ctx, a, EXT_NONE, gen_bclr, NULL);
>  }
>
>  static bool trans_bclri(DisasContext *ctx, arg_bclri *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_bclr);
>  }
>
> @@ -205,12 +237,16 @@ static void gen_binv(TCGv ret, TCGv arg1, TCGv sham=
t)
>  static bool trans_binv(DisasContext *ctx, arg_binv *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift(ctx, a, EXT_NONE, gen_binv, NULL);
>  }
>
>  static bool trans_binvi(DisasContext *ctx, arg_binvi *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_binv);
>  }
>
> @@ -223,12 +259,16 @@ static void gen_bext(TCGv ret, TCGv arg1, TCGv sham=
t)
>  static bool trans_bext(DisasContext *ctx, arg_bext *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift(ctx, a, EXT_NONE, gen_bext, NULL);
>  }
>
>  static bool trans_bexti(DisasContext *ctx, arg_bexti *a)
>  {
>      REQUIRE_ZBS(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_bext);
>  }
>
> @@ -250,6 +290,8 @@ static void gen_rorw(TCGv ret, TCGv arg1, TCGv arg2)
>  static bool trans_ror(DisasContext *ctx, arg_ror *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift_per_ol(ctx, a, EXT_NONE, tcg_gen_rotr_tl, gen_rorw,=
 NULL);
>  }
>
> @@ -265,6 +307,8 @@ static void gen_roriw(TCGv ret, TCGv arg1, target_lon=
g shamt)
>  static bool trans_rori(DisasContext *ctx, arg_rori *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
>                                     tcg_gen_rotri_tl, gen_roriw, NULL);
>  }
> @@ -287,6 +331,8 @@ static void gen_rolw(TCGv ret, TCGv arg1, TCGv arg2)
>  static bool trans_rol(DisasContext *ctx, arg_rol *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift_per_ol(ctx, a, EXT_NONE, tcg_gen_rotl_tl, gen_rolw,=
 NULL);
>  }
>
> @@ -299,6 +345,8 @@ static bool trans_rev8_32(DisasContext *ctx, arg_rev8=
_32 *a)
>  {
>      REQUIRE_32BIT(ctx);
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, gen_rev8_32);
>  }
>
> @@ -306,6 +354,8 @@ static bool trans_rev8_64(DisasContext *ctx, arg_rev8=
_64 *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, tcg_gen_bswap_tl);
>  }
>
> @@ -330,6 +380,8 @@ static void gen_orc_b(TCGv ret, TCGv source1)
>  static bool trans_orc_b(DisasContext *ctx, arg_orc_b *a)
>  {
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_ZERO, gen_orc_b);
>  }
>
> @@ -350,6 +402,7 @@ GEN_SHADD(3)
>  static bool trans_sh##SHAMT##add(DisasContext *ctx, arg_sh##SHAMT##add *=
a) \
>  {                                                                       =
   \
>      REQUIRE_ZBA(ctx);                                                   =
   \
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);                                     =
   \
>      return gen_arith(ctx, a, EXT_NONE, gen_sh##SHAMT##add, NULL);       =
   \
>  }
>
> @@ -361,6 +414,8 @@ static bool trans_zext_h_32(DisasContext *ctx, arg_ze=
xt_h_32 *a)
>  {
>      REQUIRE_32BIT(ctx);
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext16u_tl);
>  }
>
> @@ -368,6 +423,8 @@ static bool trans_zext_h_64(DisasContext *ctx, arg_ze=
xt_h_64 *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext16u_tl);
>  }
>
> @@ -375,6 +432,8 @@ static bool trans_clzw(DisasContext *ctx, arg_clzw *a=
)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, gen_clzw);
>  }
>
> @@ -382,6 +441,8 @@ static bool trans_ctzw(DisasContext *ctx, arg_ctzw *a=
)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_unary(ctx, a, EXT_ZERO, gen_ctzw);
>  }
> @@ -390,6 +451,8 @@ static bool trans_cpopw(DisasContext *ctx, arg_cpopw =
*a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZBB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_unary(ctx, a, EXT_ZERO, tcg_gen_ctpop_tl);
>  }
> @@ -398,6 +461,8 @@ static bool trans_rorw(DisasContext *ctx, arg_rorw *a=
)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift(ctx, a, EXT_NONE, gen_rorw, NULL);
>  }
> @@ -406,6 +471,8 @@ static bool trans_roriw(DisasContext *ctx, arg_roriw =
*a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_roriw, NULL);
>  }
> @@ -414,6 +481,8 @@ static bool trans_rolw(DisasContext *ctx, arg_rolw *a=
)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift(ctx, a, EXT_NONE, gen_rolw, NULL);
>  }
> @@ -439,6 +508,7 @@ static bool trans_sh##SHAMT##add_uw(DisasContext *ctx=
,        \
>  {                                                             \
>      REQUIRE_64BIT(ctx);                                       \
>      REQUIRE_ZBA(ctx);                                         \
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);                           \
>      return gen_arith(ctx, a, EXT_NONE, gen_sh##SHAMT##add_uw, NULL); \
>  }
>
> @@ -457,6 +527,8 @@ static bool trans_add_uw(DisasContext *ctx, arg_add_u=
w *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZBA(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_add_uw, NULL);
>  }
>
> @@ -469,12 +541,16 @@ static bool trans_slli_uw(DisasContext *ctx, arg_sl=
li_uw *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZBA(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_slli_uw, NULL);
>  }
>
>  static bool trans_clmul(DisasContext *ctx, arg_clmul *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbc, zbkc);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_helper_clmul, NULL);
>  }
>
> @@ -487,12 +563,16 @@ static void gen_clmulh(TCGv dst, TCGv src1, TCGv sr=
c2)
>  static bool trans_clmulh(DisasContext *ctx, arg_clmulr *a)
>  {
>      REQUIRE_EITHER_EXT(ctx, zbc, zbkc);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_clmulh, NULL);
>  }
>
>  static bool trans_clmulr(DisasContext *ctx, arg_clmulh *a)
>  {
>      REQUIRE_ZBC(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_helper_clmulr, NULL);
>  }
>
> @@ -522,18 +602,24 @@ static void gen_packw(TCGv ret, TCGv src1, TCGv src=
2)
>  static bool trans_brev8(DisasContext *ctx, arg_brev8 *a)
>  {
>      REQUIRE_ZBKB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, gen_helper_brev8);
>  }
>
>  static bool trans_pack(DisasContext *ctx, arg_pack *a)
>  {
>      REQUIRE_ZBKB(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_pack, NULL);
>  }
>
>  static bool trans_packh(DisasContext *ctx, arg_packh *a)
>  {
>      REQUIRE_ZBKB(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_packh, NULL);
>  }
>
> @@ -541,6 +627,8 @@ static bool trans_packw(DisasContext *ctx, arg_packw =
*a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZBKB(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_packw, NULL);
>  }
>
> @@ -548,6 +636,8 @@ static bool trans_unzip(DisasContext *ctx, arg_unzip =
*a)
>  {
>      REQUIRE_32BIT(ctx);
>      REQUIRE_ZBKB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, gen_helper_unzip);
>  }
>
> @@ -555,17 +645,23 @@ static bool trans_zip(DisasContext *ctx, arg_zip *a=
)
>  {
>      REQUIRE_32BIT(ctx);
>      REQUIRE_ZBKB(ctx);
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_unary(ctx, a, EXT_NONE, gen_helper_zip);
>  }
>
>  static bool trans_xperm4(DisasContext *ctx, arg_xperm4 *a)
>  {
>      REQUIRE_ZBKX(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_helper_xperm4, NULL);
>  }
>
>  static bool trans_xperm8(DisasContext *ctx, arg_xperm8 *a)
>  {
>      REQUIRE_ZBKX(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, gen_helper_xperm8, NULL);
>  }
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index b9c7160468..c69a655ad6 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -32,6 +32,8 @@ static bool trans_c64_illegal(DisasContext *ctx, arg_em=
pty *a)
>
>  static bool trans_lui(DisasContext *ctx, arg_lui *a)
>  {
> +    CHECK_X_REG_RD(ctx, a);
> +
>      gen_set_gpri(ctx, a->rd, a->imm);
>      return true;
>  }
> @@ -81,6 +83,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>
>  static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
>  {
> +    CHECK_X_REG_RD(ctx, a);
> +
>      TCGv target_pc =3D dest_gpr(ctx, a->rd);
>      gen_pc_plus_diff(target_pc, ctx, a->imm);
>      gen_set_gpr(ctx, a->rd, target_pc);
> @@ -89,6 +93,8 @@ static bool trans_auipc(DisasContext *ctx, arg_auipc *a=
)
>
>  static bool trans_jal(DisasContext *ctx, arg_jal *a)
>  {
> +    CHECK_X_REG_RD(ctx, a);
> +
>      gen_jal(ctx, a->rd, a->imm);
>      return true;
>  }
> @@ -140,6 +146,8 @@ static void gen_ctr_jalr(DisasContext *ctx, arg_jalr =
*a, TCGv dest)
>
>  static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      TCGLabel *misaligned =3D NULL;
>      TCGv target_pc =3D tcg_temp_new();
>      TCGv succ_pc =3D dest_gpr(ctx, a->rd);
> @@ -332,31 +340,43 @@ static bool gen_branch(DisasContext *ctx, arg_b *a,=
 TCGCond cond)
>
>  static bool trans_beq(DisasContext *ctx, arg_beq *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_branch(ctx, a, TCG_COND_EQ);
>  }
>
>  static bool trans_bne(DisasContext *ctx, arg_bne *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_branch(ctx, a, TCG_COND_NE);
>  }
>
>  static bool trans_blt(DisasContext *ctx, arg_blt *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_branch(ctx, a, TCG_COND_LT);
>  }
>
>  static bool trans_bge(DisasContext *ctx, arg_bge *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_branch(ctx, a, TCG_COND_GE);
>  }
>
>  static bool trans_bltu(DisasContext *ctx, arg_bltu *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_branch(ctx, a, TCG_COND_LTU);
>  }
>
>  static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_branch(ctx, a, TCG_COND_GEU);
>  }
>
> @@ -421,22 +441,32 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, =
MemOp memop)
>
>  static bool trans_lb(DisasContext *ctx, arg_lb *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_load(ctx, a, MO_SB);
>  }
>
>  static bool trans_lh(DisasContext *ctx, arg_lh *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_load(ctx, a, MO_TESW);
>  }
>
>  static bool trans_lw(DisasContext *ctx, arg_lw *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_load(ctx, a, MO_TESL);
>  }
>
>  static bool trans_ld(DisasContext *ctx, arg_ld *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +    }
> +
>      return gen_load(ctx, a, MO_TESQ);
>  }
>
> @@ -448,17 +478,25 @@ static bool trans_lq(DisasContext *ctx, arg_lq *a)
>
>  static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_load(ctx, a, MO_UB);
>  }
>
>  static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_load(ctx, a, MO_TEUW);
>  }
>
>  static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +    }
> +
>      return gen_load(ctx, a, MO_TEUL);
>  }
>
> @@ -516,22 +554,32 @@ static bool gen_store(DisasContext *ctx, arg_sb *a,=
 MemOp memop)
>
>  static bool trans_sb(DisasContext *ctx, arg_sb *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_store(ctx, a, MO_SB);
>  }
>
>  static bool trans_sh(DisasContext *ctx, arg_sh *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_store(ctx, a, MO_TESW);
>  }
>
>  static bool trans_sw(DisasContext *ctx, arg_sw *a)
>  {
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      return gen_store(ctx, a, MO_TESL);
>  }
>
>  static bool trans_sd(DisasContext *ctx, arg_sd *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RS1_RS2(ctx, a);
> +    }
> +
>      return gen_store(ctx, a, MO_TEUQ);
>  }
>
> @@ -572,6 +620,8 @@ static void gen_addi2_i128(TCGv retl, TCGv reth,
>
>  static bool trans_addi(DisasContext *ctx, arg_addi *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_arith_imm_fn(ctx, a, EXT_NONE, tcg_gen_addi_tl, gen_addi2=
_i128);
>  }
>
> @@ -599,26 +649,36 @@ static void gen_sltu_i128(TCGv retl, TCGv reth,
>
>  static bool trans_slti(DisasContext *ctx, arg_slti *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_arith_imm_tl(ctx, a, EXT_SIGN, gen_slt, gen_slt_i128);
>  }
>
>  static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_arith_imm_tl(ctx, a, EXT_SIGN, gen_sltu, gen_sltu_i128);
>  }
>
>  static bool trans_xori(DisasContext *ctx, arg_xori *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_logic_imm_fn(ctx, a, tcg_gen_xori_tl);
>  }
>
>  static bool trans_ori(DisasContext *ctx, arg_ori *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_logic_imm_fn(ctx, a, tcg_gen_ori_tl);
>  }
>
>  static bool trans_andi(DisasContext *ctx, arg_andi *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_logic_imm_fn(ctx, a, tcg_gen_andi_tl);
>  }
>
> @@ -637,6 +697,8 @@ static void gen_slli_i128(TCGv retl, TCGv reth,
>
>  static bool trans_slli(DisasContext *ctx, arg_slli *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_fn(ctx, a, EXT_NONE, tcg_gen_shli_tl, gen_slli_=
i128);
>  }
>
> @@ -660,6 +722,8 @@ static void gen_srli_i128(TCGv retl, TCGv reth,
>
>  static bool trans_srli(DisasContext *ctx, arg_srli *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
>                                     tcg_gen_shri_tl, gen_srliw, gen_srli_=
i128);
>  }
> @@ -684,17 +748,23 @@ static void gen_srai_i128(TCGv retl, TCGv reth,
>
>  static bool trans_srai(DisasContext *ctx, arg_srai *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
>                                     tcg_gen_sari_tl, gen_sraiw, gen_srai_=
i128);
>  }
>
>  static bool trans_add(DisasContext *ctx, arg_add *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, tcg_gen_add_tl, tcg_gen_add2_tl);
>  }
>
>  static bool trans_sub(DisasContext *ctx, arg_sub *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, tcg_gen_sub_tl, tcg_gen_sub2_tl);
>  }
>
> @@ -727,16 +797,22 @@ static void gen_sll_i128(TCGv destl, TCGv desth,
>
>  static bool trans_sll(DisasContext *ctx, arg_sll *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift(ctx, a, EXT_NONE, tcg_gen_shl_tl, gen_sll_i128);
>  }
>
>  static bool trans_slt(DisasContext *ctx, arg_slt *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, gen_slt, gen_slt_i128);
>  }
>
>  static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, gen_sltu, gen_sltu_i128);
>  }
>
> @@ -769,6 +845,8 @@ static void gen_srl_i128(TCGv destl, TCGv desth,
>
>  static bool trans_srl(DisasContext *ctx, arg_srl *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift(ctx, a, EXT_ZERO, tcg_gen_shr_tl, gen_srl_i128);
>  }
>
> @@ -802,27 +880,39 @@ static void gen_sra_i128(TCGv destl, TCGv desth,
>
>  static bool trans_sra(DisasContext *ctx, arg_sra *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_shift(ctx, a, EXT_SIGN, tcg_gen_sar_tl, gen_sra_i128);
>  }
>
>  static bool trans_xor(DisasContext *ctx, arg_xor *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_logic(ctx, a, tcg_gen_xor_tl);
>  }
>
>  static bool trans_or(DisasContext *ctx, arg_or *a)
>  {
> +    CHECK_X_REG_RD_RS1(ctx, a);
> +
>      return gen_logic(ctx, a, tcg_gen_or_tl);
>  }
>
>  static bool trans_and(DisasContext *ctx, arg_and *a)
>  {
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_logic(ctx, a, tcg_gen_and_tl);
>  }
>
>  static bool trans_addiw(DisasContext *ctx, arg_addiw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_arith_imm_fn(ctx, a, EXT_NONE, tcg_gen_addi_tl, NULL);
>  }
> @@ -830,6 +920,10 @@ static bool trans_addiw(DisasContext *ctx, arg_addiw=
 *a)
>  static bool trans_slliw(DisasContext *ctx, arg_slliw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift_imm_fn(ctx, a, EXT_NONE, tcg_gen_shli_tl, NULL);
>  }
> @@ -837,6 +931,10 @@ static bool trans_slliw(DisasContext *ctx, arg_slliw=
 *a)
>  static bool trans_srliw(DisasContext *ctx, arg_srliw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_srliw, NULL);
>  }
> @@ -844,6 +942,10 @@ static bool trans_srliw(DisasContext *ctx, arg_srliw=
 *a)
>  static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_sraiw, NULL);
>  }
> @@ -872,6 +974,10 @@ static bool trans_sraid(DisasContext *ctx, arg_sraid=
 *a)
>  static bool trans_addw(DisasContext *ctx, arg_addw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_arith(ctx, a, EXT_NONE, tcg_gen_add_tl, NULL);
>  }
> @@ -879,6 +985,10 @@ static bool trans_addw(DisasContext *ctx, arg_addw *=
a)
>  static bool trans_subw(DisasContext *ctx, arg_subw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_arith(ctx, a, EXT_NONE, tcg_gen_sub_tl, NULL);
>  }
> @@ -886,6 +996,10 @@ static bool trans_subw(DisasContext *ctx, arg_subw *=
a)
>  static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift(ctx, a, EXT_NONE, tcg_gen_shl_tl, NULL);
>  }
> @@ -893,6 +1007,10 @@ static bool trans_sllw(DisasContext *ctx, arg_sllw =
*a)
>  static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift(ctx, a, EXT_ZERO, tcg_gen_shr_tl, NULL);
>  }
> @@ -900,6 +1018,10 @@ static bool trans_srlw(DisasContext *ctx, arg_srlw =
*a)
>  static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_shift(ctx, a, EXT_SIGN, tcg_gen_sar_tl, NULL);
>  }
> @@ -1047,6 +1169,8 @@ static bool trans_csrrw(DisasContext *ctx, arg_csrr=
w *a)
>  {
>      RISCVMXL xl =3D get_xl(ctx);
>      if (xl < MXL_RV128) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +
>          TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
>
>          /*
> @@ -1087,6 +1211,8 @@ static bool trans_csrrs(DisasContext *ctx, arg_csrr=
s *a)
>       * unmodified value back to the csr and will cause side effects.
>       */
>      if (get_xl(ctx) < MXL_RV128) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +
>          if (a->rs1 =3D=3D 0) {
>              return do_csrr(ctx, a->rd, a->csr);
>          }
> @@ -1116,6 +1242,8 @@ static bool trans_csrrc(DisasContext *ctx, arg_csrr=
c *a)
>       * unmodified value back to the csr and will cause side effects.
>       */
>      if (get_xl(ctx) < MXL_RV128) {
> +        CHECK_X_REG_RD_RS1(ctx, a);
> +
>          if (a->rs1 =3D=3D 0) {
>              return do_csrr(ctx, a->rd, a->csr);
>          }
> @@ -1138,6 +1266,8 @@ static bool trans_csrrwi(DisasContext *ctx, arg_csr=
rwi *a)
>  {
>      RISCVMXL xl =3D get_xl(ctx);
>      if (xl < MXL_RV128) {
> +        CHECK_X_REG_RD(ctx, a);
> +
>          TCGv src =3D tcg_constant_tl(a->rs1);
>
>          /*
> @@ -1177,6 +1307,8 @@ static bool trans_csrrsi(DisasContext *ctx, arg_csr=
rsi *a)
>       * unmodified value back to the csr and will cause side effects.
>       */
>      if (get_xl(ctx) < MXL_RV128) {
> +        CHECK_X_REG_RD(ctx, a);
> +
>          if (a->rs1 =3D=3D 0) {
>              return do_csrr(ctx, a->rd, a->csr);
>          }
> @@ -1205,6 +1337,8 @@ static bool trans_csrrci(DisasContext *ctx, arg_csr=
rci * a)
>       * unmodified value back to the csr and will cause side effects.
>       */
>      if (get_xl(ctx) < MXL_RV128) {
> +        CHECK_X_REG_RD(ctx, a);
> +
>          if (a->rs1 =3D=3D 0) {
>              return do_csrr(ctx, a->rd, a->csr);
>          }
> diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/insn_=
trans/trans_rvm.c.inc
> index 795f0ccf14..e72463a465 100644
> --- a/target/riscv/insn_trans/trans_rvm.c.inc
> +++ b/target/riscv/insn_trans/trans_rvm.c.inc
> @@ -65,6 +65,8 @@ static void gen_mul_i128(TCGv rl, TCGv rh,
>  static bool trans_mul(DisasContext *ctx, arg_mul *a)
>  {
>      REQUIRE_M_OR_ZMMUL(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_NONE, tcg_gen_mul_tl, gen_mul_i128);
>  }
>
> @@ -103,6 +105,8 @@ static void gen_mulh_w(TCGv ret, TCGv s1, TCGv s2)
>  static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
>  {
>      REQUIRE_M_OR_ZMMUL(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith_per_ol(ctx, a, EXT_SIGN, gen_mulh, gen_mulh_w,
>                              gen_mulh_i128);
>  }
> @@ -147,6 +151,8 @@ static void gen_mulhsu_w(TCGv ret, TCGv arg1, TCGv ar=
g2)
>  static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a)
>  {
>      REQUIRE_M_OR_ZMMUL(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith_per_ol(ctx, a, EXT_NONE, gen_mulhsu, gen_mulhsu_w,
>                              gen_mulhsu_i128);
>  }
> @@ -161,6 +167,8 @@ static void gen_mulhu(TCGv ret, TCGv s1, TCGv s2)
>  static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
>  {
>      REQUIRE_M_OR_ZMMUL(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      /* gen_mulh_w works for either sign as input. */
>      return gen_arith_per_ol(ctx, a, EXT_ZERO, gen_mulhu, gen_mulh_w,
>                              gen_mulhu_i128);
> @@ -206,6 +214,8 @@ static void gen_div(TCGv ret, TCGv source1, TCGv sour=
ce2)
>  static bool trans_div(DisasContext *ctx, arg_div *a)
>  {
>      REQUIRE_EXT(ctx, RVM);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, gen_div, gen_div_i128);
>  }
>
> @@ -238,6 +248,8 @@ static void gen_divu(TCGv ret, TCGv source1, TCGv sou=
rce2)
>  static bool trans_divu(DisasContext *ctx, arg_divu *a)
>  {
>      REQUIRE_EXT(ctx, RVM);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_ZERO, gen_divu, gen_divu_i128);
>  }
>
> @@ -283,6 +295,8 @@ static void gen_rem(TCGv ret, TCGv source1, TCGv sour=
ce2)
>  static bool trans_rem(DisasContext *ctx, arg_rem *a)
>  {
>      REQUIRE_EXT(ctx, RVM);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_SIGN, gen_rem, gen_rem_i128);
>  }
>
> @@ -316,6 +330,8 @@ static void gen_remu(TCGv ret, TCGv source1, TCGv sou=
rce2)
>  static bool trans_remu(DisasContext *ctx, arg_remu *a)
>  {
>      REQUIRE_EXT(ctx, RVM);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +
>      return gen_arith(ctx, a, EXT_ZERO, gen_remu, gen_remu_i128);
>  }
>
> @@ -323,6 +339,10 @@ static bool trans_mulw(DisasContext *ctx, arg_mulw *=
a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
>      REQUIRE_M_OR_ZMMUL(ctx);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_arith(ctx, a, EXT_NONE, tcg_gen_mul_tl, NULL);
>  }
> @@ -339,6 +359,10 @@ static bool trans_divuw(DisasContext *ctx, arg_divuw=
 *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
>      REQUIRE_EXT(ctx, RVM);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_arith(ctx, a, EXT_ZERO, gen_divu, NULL);
>  }
> @@ -347,6 +371,10 @@ static bool trans_remw(DisasContext *ctx, arg_remw *=
a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
>      REQUIRE_EXT(ctx, RVM);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_arith(ctx, a, EXT_SIGN, gen_rem, NULL);
>  }
> @@ -355,6 +383,10 @@ static bool trans_remuw(DisasContext *ctx, arg_remuw=
 *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
>      REQUIRE_EXT(ctx, RVM);
> +    if (get_xl(ctx) =3D=3D MXL_RV64) {
> +        CHECK_X_REG_RD_RS1_RS2(ctx, a);
> +    }
> +
>      ctx->ol =3D MXL_RV32;
>      return gen_arith(ctx, a, EXT_ZERO, gen_remu, NULL);
>  }
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/ins=
n_trans/trans_rvzce.c.inc
> index c77c2b927b..f0e9292632 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -270,6 +270,7 @@ static bool trans_cm_popretz(DisasContext *ctx, arg_c=
m_popret *a)
>  static bool trans_cm_mva01s(DisasContext *ctx, arg_cm_mva01s *a)
>  {
>      REQUIRE_ZCMP(ctx);
> +    CHECK_X_REG_RS1_RS2(ctx, a);
>
>      TCGv src1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> @@ -288,6 +289,8 @@ static bool trans_cm_mvsa01(DisasContext *ctx, arg_cm=
_mvsa01 *a)
>          return false;
>      }
>
> +    CHECK_X_REG_RS1_RS2(ctx, a);
> +
>      TCGv a0 =3D get_gpr(ctx, xA0, EXT_NONE);
>      TCGv a1 =3D get_gpr(ctx, xA1, EXT_NONE);
>
> diff --git a/target/riscv/insn_trans/trans_rvzicond.c.inc b/target/riscv/=
insn_trans/trans_rvzicond.c.inc
> index c8e43fa325..abca39f634 100644
> --- a/target/riscv/insn_trans/trans_rvzicond.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicond.c.inc
> @@ -43,6 +43,7 @@ static void gen_czero_nez(TCGv dest, TCGv src1, TCGv sr=
c2)
>  static bool trans_czero_eqz(DisasContext *ctx, arg_r *a)
>  {
>      REQUIRE_ZICOND(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
>
>      return gen_logic(ctx, a, gen_czero_eqz);
>  }
> @@ -50,6 +51,7 @@ static bool trans_czero_eqz(DisasContext *ctx, arg_r *a=
)
>  static bool trans_czero_nez(DisasContext *ctx, arg_r *a)
>  {
>      REQUIRE_ZICOND(ctx);
> +    CHECK_X_REG_RD_RS1_RS2(ctx, a);
>
>      return gen_logic(ctx, a, gen_czero_nez);
>  }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9ddef2d6e2..91568abfe6 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -812,6 +812,34 @@ EX_SH(12)
>      }                                            \
>  } while (0)
>
> +#define CHECK_X_REG_RD(ctx, arg) do { \
> +    if (has_ext(ctx, RVE) &&          \
> +        (arg->rd & 0x10)) {           \
> +        return false;                 \
> +    }                                 \
> +  } while (0)
> +
> +#define CHECK_X_REG_RD_RS1(ctx, arg) do {        \
> +    if (has_ext(ctx, RVE) &&                     \
> +        ((arg->rd | arg->rs1) & 0x10)) {         \
> +        return false;                            \
> +    }                                            \
> +  } while (0)
> +
> +#define CHECK_X_REG_RS1_RS2(ctx, arg) do { \
> +    if (has_ext(ctx, RVE) &&               \
> +        ((arg->rs1 | arg->rs2) & 0x10)) {  \
> +        return false;                      \
> +    }                                      \
> +  } while (0)
> +
> +#define CHECK_X_REG_RD_RS1_RS2(ctx, arg) do {       \
> +    if (has_ext(ctx, RVE) &&                        \
> +        ((arg->rd | arg->rs1 | arg->rs2) & 0x10)) { \
> +        return false;                               \
> +    }                                               \
> +  } while (0)
> +
>  static int ex_rvc_register(DisasContext *ctx, int reg)
>  {
>      return 8 + reg;
> --
>

