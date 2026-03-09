Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA4EEA8553
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 05:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSnV-0003Bz-C1; Mon, 09 Mar 2026 01:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSnP-0003BZ-MY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:04:48 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSnN-0006wH-Bx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:04:46 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-661d929219bso1969833a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 22:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773032683; cv=none;
 d=google.com; s=arc-20240605;
 b=O8fK71DLsf65RucNchEeVAb+T9YNfbBhzTcPg3x4htVJ++9AuzDiTs1IUe80U7e99m
 OIOTvXanjjlp35IzWXIfO6MmMZqSypgwSleC9KTJ+WocMyurG2iN4P0ILUT9gGHpWebp
 OJZQVLEJaafokT/FppkgmLqvQbosLHl2Yo0QJMx5XfvKwB8xIqMq7liUDa72AuDTRvAy
 HVrjcVqtd/JBP99gWGZbR2b1kHsPKEjdC1GCGaqWNZwgnj/iQCF4Ly1scpWlhuKPwpO2
 E1KyghEorm1IknXP7am+kKTkl2wb6JJkf8r3QnE0jzsGijIZao8HIHAsECATCGA9edEN
 O7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wp0CVtIB59pRx/8rFgUVmdYVlM4s9UIl2QH3A23ntao=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=P0UTgq5fCsEd1K58TDESYp8ULjxDQ7+Q/HJN5xap0N+rQYoIdeGmpTDTnvlEdhr+OL
 VTRAXdruN0kWi0abxwghzRgfRXeOHWuW406t4oEdZ90hXS9Dt+JZHm2UTq6Qv5xqbgZD
 i8bFMtTbD6cMUo+a8tB28L0do2KcCeMSPlwY9LSBLHAJopRKtq+qWcqN7XbEXksHya/p
 wWYvE/MvedO4pHUCcTL0AN/npeAj+MzUY4Ob564cRj4+N4kNre0IxNyWN4cLK6S+VCJe
 9ktffaEf2o4iiyJgpcQaAxL2nQ97etxM1aQOw2BIbFN5EP87aDgBKbLf/LsuawyR94Tz
 0Lvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773032683; x=1773637483; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wp0CVtIB59pRx/8rFgUVmdYVlM4s9UIl2QH3A23ntao=;
 b=A4+XzHn/W8QrNhKgQJIJkWhMG/zhEo9CwF4bi/wSpAFqYpH0t4cP1NISKNSSkQoytf
 RAEWN5ORHz9WOt9XbTA+BSi+/EpdVS3LCSmLBp+Yr5p924uyY3Hktg3+EQMLeJorVE3B
 n7JOSTsbA3NPYy4yxUl2QUEiX+jPQSqBw4Ll/gfksSggihg7P8Pv3R4rcIM+8Dh6PpRQ
 4Qfs9CL5TX8DEWr0GJVefc6asEynfe38tdgHclcIblRMviDAu4Lw5i6RodvIknK/hUyB
 kBnmBoBuhaIuqrHI+A/zUHAWdV8I4W8WADaRXDww6viZGI0DxjIqIihnxoInXNu9tgLE
 YtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773032683; x=1773637483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wp0CVtIB59pRx/8rFgUVmdYVlM4s9UIl2QH3A23ntao=;
 b=nfUMR/TVYDf34qBs/8E3ND93E2jIYChgJ9PhjuLAf8CqQ44Neo8qrHVBUtjd+00ik6
 2ZYQv3vT1DNpDeY6jqUbx6ykOPfw/BwgeiYg7UTq5RcuzPahri7uk4m17EIyOhwJRShX
 8b2NYGOeiESFm6Dfmszs695a+PbwYcohfO2/my2FD20SfN98XEfA1VUHRXjQs67Q202j
 BLrKpQbUyp238AKPP78g5aYH3Tg6oNzmYgqw4EtFOsf1afr9HC62FB4W7aOwwA3a6dSI
 UTXaJXUOcCCLDCshYcTnnPC9fxLB23K2UXKyLnFj8tWiIUOewTdbY3pV9h6K2TALILud
 8ykw==
X-Gm-Message-State: AOJu0YxoGJaef3M15QxILKyI0fjAYUn4whyzsYgUb3BL00qSc3HH+gre
 QlANoA0S43zWG4seSqx3AgeChG4ZS61rtl2ZAqtZSo5u9hyp3NJ0EBlSUdItbQmGtyuz2QwOO/n
 8AUm1jLvPshqErKSoAJx+htvPjEdS6rwi+9O66OA=
X-Gm-Gg: ATEYQzxlskgRJOA0nRjSc70MfFruQLuUY49+p1lxfnHN9dzAM0zq8TE08ZGD9P0rWKC
 w2coC850Ii1qNPwp5mN/9xQALQTyuwDrrD+DjaRiWvb29VNf7xYo2ne3Yu37D4sNzw37KloF4dh
 pup3asJhSVJPnANnRIMRZUKrWxX3U1jYRfHk9Ly2gL4dol/99nn/biZ7rGc7ATO0l4FYncKHyl1
 mbP9ZBEIbyNlLzoAQc502xRz6mGj1hnN83g/TKBSC5GQRqNg2pxkH0xdfSPNUWTFOjzVcJr9DGB
 T8CoT6DkIzML6UpZE4X6riCD8SrZf+54X5gQnA==
X-Received: by 2002:a05:6402:51ce:b0:660:475:9403 with SMTP id
 4fb4d7f45d1cf-6619d51cb6fmr4458247a12.29.1773032682788; Sun, 08 Mar 2026
 22:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-8-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-8-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 15:04:16 +1000
X-Gm-Features: AaiRm52jFV6wyxYFfFf9qXB3HIJ9zm1z8PO1TcSdCsFLej-2djbawQF3TCR4vtA
Message-ID: <CAKmqyKP19b9t+txResQuKc7phiQ4CfFiwc=SmX=BbOyT8mZuyQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] target/riscv: Introduce BF16 canonical NaN for
 Zvfbfa extension
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
> f-register operands must substitute the BF16 canonical NaN instead of
> the FP16 canonical NaN for some vector floating-point instructions.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
>  target/riscv/translate.c                |  8 ++++++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 4df9a40b44..03ae85796a 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2319,17 +2319,17 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_=
wx)
>   */
>  static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
>  {
> -    switch (s->sew) {
> -    case 1:
> -        gen_check_nanbox_h(out, in);
> -        break;
> -    case 2:
> +    if (s->sew =3D=3D MO_16) {
> +        if (s->altfmt) {
> +            gen_check_nanbox_h_bf16(out, in);
> +        } else {
> +            gen_check_nanbox_h(out, in);
> +        }
> +    } else if (s->sew =3D=3D MO_32) {
>          gen_check_nanbox_s(out, in);
> -        break;
> -    case 3:
> +    } else if (s->sew =3D=3D MO_64) {
>          tcg_gen_mov_i64(out, in);
> -        break;
> -    default:
> +    } else {
>          g_assert_not_reached();
>      }
>  }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 89d4f6fe67..d9df6a35ca 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -214,6 +214,14 @@ static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i6=
4 in)
>      tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
>  }
>
> +static void gen_check_nanbox_h_bf16(TCGv_i64 out, TCGv_i64 in)
> +{
> +    TCGv_i64 t_max =3D tcg_constant_i64(0xffffffffffff0000ull);
> +    TCGv_i64 t_nan =3D tcg_constant_i64(0xffffffffffff7fc0ull);
> +
> +    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
> +}
> +
>  static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
>  {
>      TCGv_i64 t_max =3D tcg_constant_i64(0xffffffff00000000ull);
> --
> 2.52.0
>
>

