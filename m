Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BBDC35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 04:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tukiP-0003C6-Fz; Wed, 19 Mar 2025 00:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tukiK-0003Be-1C; Wed, 19 Mar 2025 00:07:32 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tukiH-0001JJ-8K; Wed, 19 Mar 2025 00:07:30 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-86dddba7e0eso668088241.1; 
 Tue, 18 Mar 2025 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742357247; x=1742962047; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH7bSln7EqB6Dd63YdQvEooVgoD3ND8jMqVR9XYkyXE=;
 b=PKfkDHqMU1eouEHhemOYOf/zl8T2NFvJSuStfNDiezb9UVd6tRhwv1r7LvFVGcNhSG
 am/S0tbkmm1yyww1mlWQDe49iLyOY7UzmQEkq0/8z+VMLbGahtZAq0Qb7wQ69Vi32EWh
 pKCSdryxGkxiFZ+wJeSZ788IpjpGbQM3KCdBoMwQHFGsNiDkGbsezGZ39EDTeIhEEQAc
 XmyijKnUSS+3JsdmF4GSDMERaurkI1eRrL4Osis4gY4ReGhIWivcqRvTruFefrwYrIpj
 edOhyGhTe9sECneFb9k1SNuPLufqf0gEa0BdW0VVlrB36namQIprurkieWO8yki9axXq
 VBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742357247; x=1742962047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QH7bSln7EqB6Dd63YdQvEooVgoD3ND8jMqVR9XYkyXE=;
 b=lQ7Yd3OrGk0KfDDTaU8NKCyFpjgxMEN5ORPOCNtFCOIeR4L6iwj9OD224TsapTvwGZ
 Zha8jk9F774P5y5fpvpX4VmZjBt2BtL8gfe6RDf8Js+cOFwgm93il1mHdm4y2vtXiW5p
 vzHaZhrpCn9MKyEl7xgHpDbKM2a9Pc/QlzQpS65TDaoWhiTgA09e5oIVjJymwet7t+/i
 cr6s3h5Ad/yHZH/VcTnm2V4PAdQoTUAoQDD61zRwhP2rlut99lmYfYQOPOuQ1r54Rzqr
 ndjMX7JYPEt5GoNJqdgR4Izi7x1KRhRqFASNE9uu6p+txHDQszyUuS9ohtAFQKIxRQqg
 5EIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKXETkugHqBLgZw6o/6Bz/FHfIan31I1RaY42qon2vn/HOD4MI+S/d2calijmPbSdAhyily4i2YdDs@nongnu.org
X-Gm-Message-State: AOJu0YxkF3xw/ueBkUEBWpaRSS0b0GGd1UdWif7I9E1P+rc2B4qXIaj6
 9tussRXVLcFFV+ze56I9wLVCMM2RuZr1C7jBemhwVPxUm6ZYoA9RFmOX69CXNAAdc7QeWJTdwhy
 FrnYTTauneWr7f6BcQdEgH8D+6Bs=
X-Gm-Gg: ASbGncuOdym8yNArkUgRvaAlJPgIj8rjFIxLnBOiCQogmqS6aI7Kh7BqkB/3K7IL1Ao
 xWcldaSIZOM4JzUa8mJIvZkv+tr8ktYE/GCCHVb6fTMOZVrFMfrljAM71XUNKBUYmryAE4op2fo
 nIYwfOZ/gv0DLcFcn2CwSloWkGXO+IvvlB6a4smBYAfThDJoA1YzRRd6I=
X-Google-Smtp-Source: AGHT+IHNI3hjGuvdltk5lrhRewpVYQNKXBzIQjN0WtGgaJe7li2DWqdDPEq3fxWCGJxEKv85vGZcFq8biSPlsIgv3Ak=
X-Received: by 2002:a05:6102:549f:b0:4c1:8b8e:e9f7 with SMTP id
 ada2fe7eead31-4c4ec63a201mr864882137.8.1742357247307; Tue, 18 Mar 2025
 21:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <174184718265.10540.10120024221661781046-0@git.sr.ht>
In-Reply-To: <174184718265.10540.10120024221661781046-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Mar 2025 14:07:01 +1000
X-Gm-Features: AQ5f1JpNRUyY0OV_2H0lidP1DDVBIxJbbRJNcbTSApaNiKlEsz9PoLsq9T0A4Hk
Message-ID: <CAKmqyKN_NosmyOJG2jiH8uCCOk4+Lz+3+bLGD16hOpmypbeBLg@mail.gmail.com>
Subject: Re: [PATCH qemu] target/riscv: Add check for 16-bit aligned PC for
 different priv versions.
To: "~yuming" <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Thu, Mar 13, 2025 at 4:27=E2=80=AFPM ~yuming <yuming@git.sr.ht> wrote:
>
> From: Yu-Ming Chang <yumin686@andestech.com>
>
> For privilege version 1.12 or newer, C always implies Zca. We can only
> check ext_zca to allow 16-bit aligned PC addresses. For older privilege
> versions, we only check C.
>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.h                      | 12 ++++++++++++
>  target/riscv/insn_trans/trans_rvi.c.inc |  8 ++++++--
>  target/riscv/op_helper.c                |  8 ++++++--
>  target/riscv/translate.c                |  4 +++-
>  4 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7de19b4183..51e49e03de 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -765,6 +765,18 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *=
env)
>  }
>  #endif
>
> +static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
> +                                              target_long priv_ver,
> +                                              uint32_t misa_ext)
> +{
> +    /* In priv spec version 1.12 or newer, C always implies Zca */
> +    if (priv_ver >=3D PRIV_VERSION_1_12_0) {
> +        return cfg->ext_zca;
> +    } else {
> +        return misa_ext & RVC;
> +    }
> +}
> +
>  /*
>   * Encode LMUL to lmul as follows:
>   *     LMUL    vlmul    lmul
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index b55f56a5eb..b9c7160468 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -151,7 +151,9 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a=
)
>          tcg_gen_ext32s_tl(target_pc, target_pc);
>      }
>
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
> +    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
> +                                    ctx->priv_ver,
> +                                    ctx->misa_ext)) {
>          TCGv t0 =3D tcg_temp_new();
>
>          misaligned =3D gen_new_label();
> @@ -300,7 +302,9 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, T=
CGCond cond)
>
>      gen_set_label(l); /* branch taken */
>
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
> +    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
> +                                    ctx->priv_ver,
> +                                    ctx->misa_ext) &&
>          (a->imm & 0x3)) {
>          /* misaligned */
>          TCGv target_pc =3D tcg_temp_new();
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 0d4220ba93..72dc48e58d 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -279,7 +279,9 @@ target_ulong helper_sret(CPURISCVState *env)
>      }
>
>      target_ulong retpc =3D env->sepc;
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> +    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
> +                                    env->priv_ver,
> +                                    env->misa_ext) && (retpc & 0x3)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> @@ -357,7 +359,9 @@ static void check_ret_from_m_mode(CPURISCVState *env,=
 target_ulong retpc,
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> +    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
> +                                    env->priv_ver,
> +                                    env->misa_ext) && (retpc & 0x3)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index eaa5d86eae..d6651f244f 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -606,7 +606,9 @@ static void gen_jal(DisasContext *ctx, int rd, target=
_ulong imm)
>      TCGv succ_pc =3D dest_gpr(ctx, rd);
>
>      /* check misaligned: */
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
> +    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
> +                                    ctx->priv_ver,
> +                                    ctx->misa_ext)) {
>          if ((imm & 0x3) !=3D 0) {
>              TCGv target_pc =3D tcg_temp_new();
>              gen_pc_plus_diff(target_pc, ctx, imm);
> --
> 2.45.3
>

