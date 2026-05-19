Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3728CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 03:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBYX-0005Jb-4O; Mon, 18 May 2026 23:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBYQ-0005JI-K0
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:55:38 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBYO-0006qw-Tu
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:55:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd8f9725b30so120534666b.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 20:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779162935; cv=none;
 d=google.com; s=arc-20240605;
 b=USlMaUywXyAeWNUIarNqHiBMLQOxNc7NuuV0QZhoKrLoRyNDAHuryHhSJlnrn7tGnQ
 U48b8Yi2wLHJhuuukbgZ7KWuZD5ziqjzlqz9L6wE+6RRvBUMYJCDPprdLWQAcE76gH+C
 1HXUiwe4fo9EpmLBQIZWJC+PjB0TR/CALbObaRMJh3KST5/4YCiDSAz3HkJHGxQ4qwnO
 DAAswuVjZvsbXuHMXbrvb1cxeBtyXZHrWvkDIRDf/bF/QuGYcNigSft8EBpeknRVKgVH
 mb/MlMm2qAMdVhaojSt0wV14EST/ynHWJZuLbHidzt48lxQ2WRqmpr5dxy2onHUCKOAM
 +d8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TEX291zrAjpuLnGFaC4H7UVQZQ13ikZilkN0qIAW4jk=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=GJo22lx3AFXDLgG3Exq8id7xc7uGgkM+wFtW5Kt/1FnAq8O1SP2YMKgehCGZ41qr+R
 qCjBkWa9iocQmpaRY/Ybt2hi//ACYb0ROaFjWqOnqgT6rinjTu3zBfiqGbgSSOlh0jHw
 lcGoBXDkvug41foOZH/MKB5UvrIkswote04tarSOyGt88tmYiwMDxU7xVtZywtIxRvdK
 REgU2DgXN4eQMedqzm5j+fmKOvN470hDZSOk7LbpgTa8pVNvO1ufZodkXIOoh8ZBj7TI
 XXSAOu50A654djzM6iSViMbL9KX4QgQQARUsZmlIV/0W4AOD9kZceVVEe/RkraFQ3MnS
 Motg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779162935; x=1779767735; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEX291zrAjpuLnGFaC4H7UVQZQ13ikZilkN0qIAW4jk=;
 b=dMHkcPYUB7GneI/8wefWFpvFUn/SC1pjs0IaZzw0WV/kjcdTOG0NMzYyCQrzRHxoXe
 mEir61C+ZcLOGzclrQUe4W9FGjzuW00JuISIuELRvqn2JylkqJzNrJ0yutgeCg3Tf+7V
 aeUjyQdYtIDtHfFA9RzEZOgNalZ6ZamT/lcc1TvwpJ9lluEYloUHAlXuGQFx8NSUZv8P
 dU/8XOBFvzsDkzhuUGSABe+J2CC3E5ijnqHzkSlzC62D2Bflrbzh5iTgk8rxMorLF/x4
 bc2Lze4lw2xon0CmiRiIE/5YIueuFH17VrdNh8EkISTWNH3XIQK2540F+nSXsFhvejD8
 6SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779162935; x=1779767735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TEX291zrAjpuLnGFaC4H7UVQZQ13ikZilkN0qIAW4jk=;
 b=KXOxuh3Pj6aS1HeLhppsUfNgiE3pjxlA9zPltI5Ub4vS82+X2ZQSyOeq/JSPui8umO
 4nCOD/5bTGjkHRzPrJYENcXCMyUsHMg/ZvWt2GL2Cuoyof8xqIkqFriwdIYpO3rULyPS
 EOKdI1Envif8JbvhEug8Cg6WmvCA9w6ZjVxwbf0J7dq20vZOa3mo7aENudMRVGct+DYT
 U34MpB0WPEDiaCKwqnIf3Dy3IpoQGJGnxasml1D2G3r4rlBjK/op85PZJstXeaY24kND
 3Q9Vm95QRYbsHsjz9OoCnge7QnUQBHaj98jT6iNBEvcXkT7wvTnAc7AkuZWPnTSQDSqe
 NhIA==
X-Gm-Message-State: AOJu0YySnBYAxpE+yw6U8iDYdMgvMngDKJYDVGf395Jp3oovBprknJDj
 LQG+9btdslhS1IaD0xAlhlvsQFRFq+jHr1UqvmSeE61k9t4HcvCuxipX1WzADOwGTvHiYgC9cOF
 9+7DH1GSO0gqfnS/cSTFSH4rtgGhEbtM=
X-Gm-Gg: Acq92OE060q1/cIr4UD+PRPsvGJ5jYZC6mTC+EtBtL95+TZ1VYj+fVgTBW1yYi/wzf1
 vK67BFRSk5tPwkPZE3tF813pBq1YTw1uSxwOir2m4TVoTekqSAvf/gROBkvQ7IS+CHjJAMroVZN
 gNqlxDMl1fbdBnuCy/D0/WmKj5TyUQJ4r6BkFHPCVpOuV7Nw1skPowy8bB90soivMVVre2CGF1g
 Lcsxv/b/jPt9QqS6VFclNT/0lo5ceTYeRBfRf0iyhLQurIfpxna0qcFkemmfLykOnP4g1TaUbjx
 dfWjm81nzkapFNrOMIyUbP0wduSOkJFYyfV+eg==
X-Received: by 2002:a17:906:6a21:b0:bd5:7a3:a593 with SMTP id
 a640c23a62f3a-bd517add181mr727528566b.46.1779162934972; Mon, 18 May 2026
 20:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-5-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 13:55:07 +1000
X-Gm-Features: AVHnY4JRpxWhNhtINs9Ab2Lq7wHe-QQgrTeUAuqSkQMhwngB80v-tA-jZmpfJBY
Message-ID: <CAKmqyKMe4hASxsvLFYEDa1exYGRh-ioK2dzz_=JvaKOcJg9mUw@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] target/riscv/tcg: treat all exts equally in
 cpu_disable_priv_spec_isa_exts
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Commit 7e4f75cadf ("target/riscv/tcg: hide warn for named feats when
> disabling via priv_ver") changed the design of
> disable_priv_spec_isa_exts to not warn when disabling what we were
> calling "named features" at that time.
>
> Back in that time we were adding RVA22 profile support and we were dealin=
g
> with a RVI innovation: named features.  These can be define as cute
> names for pre-existing behavior/parameters, e.g. 'zic64b' means all
> cache blocks must have 64 bytes.  They do get inserted in the riscv,isa
> but they are not "real" extensions because users shouldn't be setting
> them in the command line, or so we thought back then, and we attempted
> to model that by calling it "named features".
>
> This didn't age that well: ziccrse is a so called named feature as far as
> TCG goes, but then KVM had to treat it as a regular extension that can be
> user set and we made an exception: ziccrse is a named feature that is
> user set by KVM.
>
> "Named features" are regular extensions that might or might not be user
> set, and might or might not warrant special handling during realize()
> by setting other parameters.  And we'll being treating them as such,
> which will culminate in the end of riscv_cpu_named_features[] array in
> the end.
>
> This reverts commit 7e4f75cadf44ee67809c7ca82645a289a5268966.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a358d91ca5..92406bf41f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -484,15 +484,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RIS=
CVCPU *cpu)
>              }
>
>              isa_ext_update_enabled(cpu, edata->ext_enable_offset, false)=
;
> -
> -            /*
> -             * Do not show user warnings for named features that users
> -             * can't enable/disable in the command line. See commit
> -             * 68c9e54bea for more info.
> -             */
> -            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) =
{
> -                continue;
> -            }
>  #ifndef CONFIG_USER_ONLY
>              warn_report("disabling %s extension for hart 0x%" PRIx64
>                          " because privilege spec version does not match"=
,
> @@ -520,9 +511,11 @@ static void riscv_cpu_update_named_features(RISCVCPU=
 *cpu)
>          cpu->cfg.has_priv_1_13 =3D true;
>      }
>
> +    /* zic64b is 1.12 or later */
>      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
>                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
> -                          cpu->cfg.cboz_blocksize =3D=3D 64;
> +                          cpu->cfg.cboz_blocksize =3D=3D 64 &&
> +                          cpu->cfg.has_priv_1_12;
>
>      cpu->cfg.ext_ssstateen =3D cpu->cfg.ext_smstateen;
>
> --
> 2.43.0
>
>

