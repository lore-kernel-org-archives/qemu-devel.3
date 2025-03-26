Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B447C28B30
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 04:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txIOb-0001vw-C3; Wed, 26 Mar 2025 00:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1txIOa-0001vd-In; Wed, 26 Mar 2025 00:29:40 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1txIOZ-0005q2-3g; Wed, 26 Mar 2025 00:29:40 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86d6ac4d5a9so2819744241.1; 
 Tue, 25 Mar 2025 21:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742963377; x=1743568177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVwLhSFwhHn9DNl7470PwKbuDEGkkBmwZ0Tjj4+9ZrA=;
 b=fR2Uqmu+YfwXCDFIDufQF7s5bl51mGkTjs9tPqKAMRKNtWINm4YhfMDCfeaefEhKgy
 6bHQu+AObDrcqCrTst+sQ4179Ih+L/NVnjAQ0XuJb4OUZ0Fv+kDOFVPwh4pA0m6s/1+b
 +16QcEbBfFCr2PXooAfUneA9MNBlUQPq2lxSlQrmsgfZmpt+lwvKiYMXBPDRDHS31eSO
 274cE1lLtNZuX0WQ2NPP993yi3RZbeUxW/zLqFl2n7SkHM8PZmVEqpyJAp7KhPgGqkRU
 n7a1FTphkji3/f0lb59SoZAXa75mFe60Ggv2oH5iwbJj3lkAcdyUK2SS7fj5//ezmJbe
 u24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742963377; x=1743568177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVwLhSFwhHn9DNl7470PwKbuDEGkkBmwZ0Tjj4+9ZrA=;
 b=Sr8XXxwwZT06LLlSUi9k8UlOzso/vRyuFWapI3CUekhFIgC32dpeWCLvYaeQJWKnfa
 x320OJsFtqZT+rtBvDuiKs14cngjUKKsNTOBlZKkOepPrB/QxSaqDE6o6aoP+k0QUI08
 74vaQrkRcFYx4IqQqJudhtXRBq7NOw4IdROCt1DWLeLwwSAZtT+MLxC6e9X2zInByCsN
 9N1RuDJFQj5hfOVLvdkSXcXz2wTwGUuu6qG72AnzBTm6PjS3lJJTYVrguWdyoReankyE
 5alHJMjQiDFK3oF+Cg/iRizShII2DCYWcUDl55CKD+lkD80UWcPcMdczwvKxIO3W4KcH
 qyaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2SQN55Yk6qs1zljU7U5Wpomo7p7vTozYAXqz6n8KNGbqgrY/SHcxnS46APrThDNhQhMXnVZ4r/uVc@nongnu.org
X-Gm-Message-State: AOJu0Yx24y3m2wfmfW4fRSLAtKjPoCcG/KMT+rt+P/g6YoYzK7gFPQU3
 PrdZMtMQBp+7TEpOAb//b07AYTHZc7YuVgmAwMaa8FAaybbb16EVLfeyNJvRraAZMoQA1huxjhc
 67euAlY0/0FOkDATjF0BVt0+85n4=
X-Gm-Gg: ASbGncsnpyyo7uesWTwtKVUwRh9C0oheXw7Cn0sKvPSVxH3i/ax5H72fjRKX3M3GkN1
 Jim6RPT7Oi/3YehdXbutHRiDXuKALDfGTYSdRdGkC6L5KgU/XRKw5jwYmJKSfe3f56Lvdwkr1GX
 MVCoUjoUlvoA6qzFBynRZkDxIXwfl1drN0vUEgsphRj6jvdH+/d2b/WS0N
X-Google-Smtp-Source: AGHT+IGZuQlE9pojuJGVu4qoVYdItNtvr8HPj1tdPMe+To3BDDX43A6moct7i1hhmMgh7eZWyMtDoZ/YrI9bai010dc=
X-Received: by 2002:a05:6102:330a:b0:4bb:eb4a:f9ef with SMTP id
 ada2fe7eead31-4c50d4803a0mr13539356137.4.1742963377099; Tue, 25 Mar 2025
 21:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250325154913.95283-1-philmd@linaro.org>
In-Reply-To: <20250325154913.95283-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Mar 2025 14:29:11 +1000
X-Gm-Features: AQ5f1JoQNC_nFX46iIL6A61mXgbHT4_ep3Hvr3sRHovO87uzmSl7E0I-REtELdY
Message-ID: <CAKmqyKP97-97+VcixXx6m66RTyy95UR2+AjFrWaRZRpRr1FmSg@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v2] target/riscv/gdbstub: Replace ldtul_p() ->
 ldn_p(sizeof(target_ulong))
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Wed, Mar 26, 2025 at 1:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Replace the few ldtul_p() calls by a generic ldn_p() ones.
> No logical change.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/gdbstub.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 18e88f416af..c1dc54e47d6 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -193,7 +193,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *m=
em_buf, int n)
>      CPURISCVState *env =3D &cpu->env;
>
>      if (n < CSR_TABLE_SIZE) {
> -        target_ulong val =3D ldtul_p(mem_buf);
> +        target_ulong val =3D ldn_p(mem_buf, sizeof(val));
>          int result;
>
>          result =3D riscv_csrrw_debug(env, n, NULL, val, -1);
> @@ -229,15 +229,17 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint=
8_t *mem_buf, int n)
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
>
> -        target_ulong new_priv =3D ldtul_p(mem_buf) & 0x3;
> +        target_ulong new_priv;
> +        size_t regsize =3D sizeof(new_priv);
>          bool new_virt =3D 0;
>
> +        new_priv =3D ldn_p(mem_buf, regsize) & 0x3;
>          if (new_priv =3D=3D PRV_RESERVED) {
>              new_priv =3D PRV_S;
>          }
>
>          if (new_priv !=3D PRV_M) {
> -            new_virt =3D (ldtul_p(mem_buf) & BIT(2)) >> 2;
> +            new_virt =3D (ldn_p(mem_buf, regsize) & BIT(2)) >> 2;
>          }
>
>          if (riscv_has_ext(env, RVH) && new_virt !=3D env->virt_enabled) =
{
> --
> 2.47.1
>
>

