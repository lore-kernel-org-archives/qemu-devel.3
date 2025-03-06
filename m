Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82984C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 03:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq1So-00013M-LG; Wed, 05 Mar 2025 21:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1Sj-0000zb-7d; Wed, 05 Mar 2025 21:59:54 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1Sg-0007XT-4m; Wed, 05 Mar 2025 21:59:52 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-51eb18130f9so81911e0c.3; 
 Wed, 05 Mar 2025 18:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741229987; x=1741834787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7+Xg3w7AAR07uAWdomT3Ya921CSzcZWjod6SEhzFJY=;
 b=JEgrPdLnfxObjZg4CyD7ds3xmIcg/VZXKZ+2ef49jqRqFFVvyerghjzF0WRim4itDI
 QnCoqNKFn0MymSn+ysKcHfhNArMgwfvfmDeM6pbhArJS10hnHiFp8ckFRRC4XTRdQEe2
 mH/BrJeDhkCnQptdN9CXsJQj9aNHZY2DpFG22UuN3ukHfKU/+OKCQxXcNF6lvFM69Ny5
 Y0qWb/caqR8QwoP4SmmitXpLh2Pu6c1Agms+BudHVQKumMFQ2MBStrAnvgKEwOj3gTFt
 HWfC8Pi6cojX5dDkWtjUAz8ucARmI1i6N1u7NzxFj3WoVt3xd58oPZNl9OSP6FRbJYvK
 R7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741229987; x=1741834787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7+Xg3w7AAR07uAWdomT3Ya921CSzcZWjod6SEhzFJY=;
 b=LzuO7ot/BsnjubTWoySC9DknC+rsE3LengxcTk8aixfs0/1GoM2k0i7BWU/uHzsRoI
 1n3g6ZFv3MIsW6T3sRs14EzSeI8i7Z70kkGu28VgYymT7Monu0ymsCZk41JlWqX0fpzf
 3p8HNX4AZ54QWm84Xn6LDZbCv1xqRAZCvBUw7123PwO4ZWLcTg4Tmxz38YBkv77RChGN
 Z3FBQ8yMTV0d5z8aZVxnpnL4BuqL2qDE544NDe6Oi2vDlJn2dOEgyCw4Z+dmvZbqm9Nf
 4Unsk6igvz8fh4l+vRbMfGEXsn1NtGojrCbvS/3xDwuZrOZSXz7naPNI3xWQ/rHyunPn
 jzlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzUrKKLm2iv39z4cmzqBRHPgH8mFSzf1P/VxtKPKFJ26mFzZvtXEl0KVwJgGe+lFsIJZdqSdLSiAn2@nongnu.org
X-Gm-Message-State: AOJu0YyIm1wn+xl/lUxChVMl/eedHTKbIrOIvpVJF9bjYf43tvpJIYVi
 3NER/osGke8gq/k5/8fOXTiFzHTbqJ3PDVSv5mwPih1FA+DAMlo3hSrMc6h0K8tAzuzrVCsNqfz
 BHYvdmmnDhaE3Q5L77d53qslceaY=
X-Gm-Gg: ASbGncu1I2ulMCsom0lDgEhk5+pq+FSl7l8n0h+A4PImdOKaH+FLrgryRNOyTHndwKZ
 JAS2b9gOoqd48RNN04bMGrm1rldZCE+/3EV3LrMu/1wFhdj1ofl2gfiggHscUQrgjzbU0qtP/DR
 V7Aek0JKm0uUmzaPCDxkEgeMfg0rNnrbKVw6rRayXLy4UpA/FVX9NuYfAN
X-Google-Smtp-Source: AGHT+IErSTaQ6CVU7db1Isb45I6BTkhs+cKiSvBrznw9I4MBPJbBCcQ6GVDPGvATpyx/tm6g2wFEhvAi2s+HX4vmBIw=
X-Received: by 2002:a05:6102:3c98:b0:4c1:9e65:f90b with SMTP id
 ada2fe7eead31-4c2e2910854mr4171878137.17.1741229986916; Wed, 05 Mar 2025
 18:59:46 -0800 (PST)
MIME-Version: 1.0
References: <174044811783.27139.4910941776283875756-0@git.sr.ht>
In-Reply-To: <174044811783.27139.4910941776283875756-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 12:59:20 +1000
X-Gm-Features: AQ5f1Jp730SsjRe5OL3LVaSMUEKoI8XFIJ5VtVaUzI-1DCr1GYGNWVxPj6t61nI
Message-ID: <CAKmqyKMOaGs4aTgHzgsfYTVxkawNG9xRrJac02PazJ8kWQWScQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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
>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

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

