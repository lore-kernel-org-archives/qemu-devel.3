Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2DEC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 03:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq1jf-0005Rt-Sq; Wed, 05 Mar 2025 22:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1jb-0005RC-IJ; Wed, 05 Mar 2025 22:17:20 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1jV-0001HG-Qe; Wed, 05 Mar 2025 22:17:18 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86c29c0acdfso68425241.3; 
 Wed, 05 Mar 2025 19:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741231029; x=1741835829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKZ2QvL5KiQFOZV8IdtWKVhZGUtDHCL87UZXjoYtV8g=;
 b=E+fUCAbHN/Dcscjk8tXaTUO2GFpzg4kA1KplmFBsmd62oQpKCCl7DzCOW7csU3fPkS
 aXYbig5k4j4UxA/O86Zj7oVuCAZzRu8WRFckWJOr/OGO36HJeyxWSu3pcT6716G487oj
 p744zET/CTw8URW/I0SjNL7+skBo5Dmuk+pF2DlxD32Mi7dm9D5pABvKAu9uWVpel06Z
 1RvqFt7e2KzBLAahgbjucUGrAm59tFTRJJHxzCmpr/6hJ/tk7JNVI3L6FSxfmbn9s1Tg
 hVaUVdYMbpeu9Tmq1iQmGQjT77O9bmOlqCrvr8GRiqYNCcCt1e+LBeowelQuU0F/fh8w
 RkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741231029; x=1741835829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKZ2QvL5KiQFOZV8IdtWKVhZGUtDHCL87UZXjoYtV8g=;
 b=EJ2f79+fo2BmKSAsIROhbWQbH1APLSiGTtCd2r1j1u+NcENO5eTkOKPNwOyquNyOHA
 VcT65WK8hb0STyTGm564NO9AnbRuCImdVwxQiq8kv5QbVa3jUiZqUMe5oy3xafQVKhMY
 8Bzn5yi8o1GuLcRhZgcAF29850aRsKAUAebL2xhiGYXSDrD8c5fkAZ48M6e4RyjCmzc/
 YzzUyguKPO5+Q09v9wqHZNo6hB32gh/tvp/zbxCZtRoMU4wHUK9h28HOJeas2+/ngXZ/
 SjCJInRAiLzonUZyMp48HXPKkkkN9r/pEAONqv7uGAd191cgxdyRW9Ant1RG1FEMWqAa
 sfNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuM9AwjtU4LJ4/36UoXl8J2xmnHj1YyzAAKwawKkeLu0IwKqj7pRQndXz6FXkg1GYEUCPpgZJ/yM11@nongnu.org
X-Gm-Message-State: AOJu0Yzlbx2jVTWEWW4N1u6QOI3TeNMpLnBK2Zj70HS6mV19x9Qp4/8S
 gbWQ/Zdr0olMpXELrJJsiXErHrtT7VD182YtnKhXWo47TEpU1qfecmcWW1M+kZYbIM1zV016Qvk
 S1jASU7PHMk6iUKCtTNHPAB/IN6A=
X-Gm-Gg: ASbGncsf8E8QH9g/2lzszsSCukhy7L8z4wAgS12I3k7kUZFXwa1Bq90C5CsA3pesvI5
 QVIc+ZuylSE/gYyxCvEERiAqtzn+Ju1f77I6nkADnfouHRI8EP9Z8lqHvko6pV8uGGXrXfkEwn2
 vwWxdxxHCamyPB87k+yRGwUbEu/beRC3wty7gDlYC3kt1ghjHCOC2Iz8x9
X-Google-Smtp-Source: AGHT+IGT87Rjy8Cmr/JBMRjAgKq2wiYQc70CkzKh6L3aIXZz2UfqhL+/Cc9+fXA69XqVK7TYKEjVGSQO2uyly69VhAs=
X-Received: by 2002:a05:6102:e12:b0:4bd:3519:44be with SMTP id
 ada2fe7eead31-4c2e2804512mr3693325137.15.1741231029385; Wed, 05 Mar 2025
 19:17:09 -0800 (PST)
MIME-Version: 1.0
References: <174044811783.27139.4910941776283875756-0@git.sr.ht>
In-Reply-To: <174044811783.27139.4910941776283875756-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 13:16:43 +1000
X-Gm-Features: AQ5f1JrcLk9bNjkwTXcrQre9trYhwSSeRg7Y6laY8Mo9DN-eBJZOLu-ZYqC3jWE
Message-ID: <CAKmqyKMKHsLpn4ywyqu6r2rf9m1mrPm814JvxnRncem2MNQa2w@mail.gmail.com>
Subject: Re: [PATCH qemu] target/riscv: Only check ext_zca for 16-bit aligned
 PC.
To: "~yuming" <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Tue, Feb 25, 2025 at 11:49=E2=80=AFAM ~yuming <yuming@git.sr.ht> wrote:
>
> From: Yu-Ming Chang <yumin686@andestech.com>
>
> Since C always implies Zca, Zca is always enabled when 16-bit
> insructions are supported. we can only check ext_zca to allow
> 16-bit aligned PC addresses.

Urgh! Sorry about this

Zca is only in priv spec version 1.12 or newer. So although C does
always imply Zca, that's only true for 1.12 priv specs.

This patch as is breaks older CPUs (like the sifive_u).

That's my fault as I told you to use Zca, but unfortunately it doesn't work=
.

So, the best bet is probably a helper function that checks the priv
spec version then based on that checks either Zca or C. That way
when/if we drop versions before 1.12 we can update the code.

Alistair

>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
>  target/riscv/insn_trans/trans_rvi.c.inc | 5 ++---
>  target/riscv/op_helper.c                | 4 ++--
>  target/riscv/translate.c                | 2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 96c218a9d7..e5965201a7 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -106,7 +106,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a=
)
>          tcg_gen_ext32s_tl(target_pc, target_pc);
>      }
>
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
> +    if (!ctx->cfg_ptr->ext_zca) {
>          TCGv t0 =3D tcg_temp_new();
>
>          misaligned =3D gen_new_label();
> @@ -236,8 +236,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, T=
CGCond cond)
>
>      gen_set_label(l); /* branch taken */
>
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
> -        (a->imm & 0x3)) {
> +    if (!ctx->cfg_ptr->ext_zca && (a->imm & 0x3)) {
>          /* misaligned */
>          TCGv target_pc =3D tcg_temp_new();
>          gen_pc_plus_diff(target_pc, ctx, a->imm);
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index ce1256f439..68882136d7 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -276,7 +276,7 @@ target_ulong helper_sret(CPURISCVState *env)
>      }
>
>      target_ulong retpc =3D env->sepc;
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> +    if (!env_archcpu(env)->cfg.ext_zca && (retpc & 0x3)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> @@ -349,7 +349,7 @@ static void check_ret_from_m_mode(CPURISCVState *env,=
 target_ulong retpc,
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> +    if (!env_archcpu(env)->cfg.ext_zca && (retpc & 0x3)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 698b74f7a8..34eeed50be 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -566,7 +566,7 @@ static void gen_jal(DisasContext *ctx, int rd, target=
_ulong imm)
>      TCGv succ_pc =3D dest_gpr(ctx, rd);
>
>      /* check misaligned: */
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
> +    if (!ctx->cfg_ptr->ext_zca) {
>          if ((imm & 0x3) !=3D 0) {
>              TCGv target_pc =3D tcg_temp_new();
>              gen_pc_plus_diff(target_pc, ctx, imm);
> --
> 2.45.3
>

