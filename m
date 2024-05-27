Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28104C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBSiD-0005kC-Fc; Mon, 27 May 2024 01:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBShq-0005aO-4A; Mon, 27 May 2024 01:15:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBShl-0000L1-O3; Mon, 27 May 2024 01:15:33 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57883b25b50so1642355a12.2; 
 Sun, 26 May 2024 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716786926; x=1717391726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nxcVM8D1DT8U368m+v0DKL/dxKT6O5DO3NmdOd9QcM=;
 b=Gtz1wfxTSpCmdeBSFLFR/yZYnxxnmMq0lqCuKGDVSPGGZgGYyKxpH9KG+GL4DPRXEn
 sWPdfskIMXtQdM+jR2mvGGb+Qm98Kwflop1WBPQLFh6BWHOhoXasVlzVmRO/I+Un9XrF
 2H4gbm06BJmEfJuL+uGGB+zQcNNcDkI19rlb1+Ws9ZpmUeJBLz/N/wB0l0DvwUK69Fy2
 7w8iZBST7sRAUvbRguRnnGp+pFYuq+ackbJIcsBB+ICJPuUuFkhSE0AxRNydtl6y48hr
 ej4yE5jPmZE70Mtk02/l6gf3jkDwPweHs2Rd4yT7z9KKZ+NRHtLdOTXaJ9O/9fFHqce1
 aLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716786926; x=1717391726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nxcVM8D1DT8U368m+v0DKL/dxKT6O5DO3NmdOd9QcM=;
 b=ufHS7czivlxu64YleV+WrbcOrOr0EiTavqHqCPkg6TRZby5EbOQLBLz6qRDOqWe2a4
 5kO2uOLOqPC4WOSgbinph5nHrjHgEvs/Kx1mDOXzyzOOyh+BojUq7JAx3mjL+MmbE3sC
 wDWorc594vaEAS7ctYhKjG04sb7iGYRXvfNJtI44UV8c36v190NPoQL1v+wQymq84j9I
 SYpQQxPIO/50ISN0gYZ/GkaKbPYyI+SsmEdGb0UB2uyKzkfMm6Kupbv5TX1FHp1qpqUc
 Ai6w9iPvVkhpcZ0R/GCeIXjQ6deG44i+lzzp5fg6dXFkmLCTUu4KhzxE7qNo75JvIV8S
 bH5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3MnZm7pLHuVjJKh3XO4GtJh8H8SLS+mS0X4bKslqYZirh80hFgQ2yO/oWBs0e7r8ytvWM+B1wMGXbbi9GTnQHD7rHPkU=
X-Gm-Message-State: AOJu0Yx4UCLz+9BTEBYw7clfYtenSbD0JXoY5PuIP+RQexWTIuqntvJ6
 ihybLTcSxwsLx0gZPInSDLPPdeZAIn89PP2cwe/TQqxF4HfipYh2ogI3zF/E35RJtMUogCOC13z
 hnDMAZDlEMLt67A9I4pFvteU6oOE=
X-Google-Smtp-Source: AGHT+IHwvnBF7G84yh4bBF2FulZbMtD/WXoAAtuLncklgoNXDGv/ogYApMA6Y0TUjzdJPd8hs1j6xMmL4bLyFqlWPHg=
X-Received: by 2002:a50:ab5a:0:b0:578:6c19:4801 with SMTP id
 4fb4d7f45d1cf-5786c195f95mr3636906a12.22.1716786926352; Sun, 26 May 2024
 22:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240517203054.880861-1-dbarboza@ventanamicro.com>
 <20240517203054.880861-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240517203054.880861-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 May 2024 15:14:59 +1000
Message-ID: <CAKmqyKPWmQhG0sWAUDvyAR4DL1j=-Aaz6tfSUz=XQgA7PzQ3Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] riscv,
 gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, alex.bennee@linaro.org, akihiko.odaki@daynix.com, 
 Robin Dapp <rdapp.gcc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, May 18, 2024 at 6:32=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit 33a24910ae changed 'reg_width' to use 'vlenb', i.e. vector length
> in bytes, when in this context we want 'reg_width' as the length in
> bits.
>
> Fix 'reg_width' back to the value in bits like 7cb59921c05a
> ("target/riscv/gdbstub.c: use 'vlenb' instead of shifting 'vlen'") set
> beforehand.
>
> While we're at it, rename 'reg_width' to 'bitsize' to provide a bit more
> clarity about what the variable represents. 'bitsize' is also used in
> riscv_gen_dynamic_csr_feature() with the same purpose, i.e. as an input t=
o
> gdb_feature_builder_append_reg().
>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reported-by: Robin Dapp <rdapp.gcc@gmail.com>
> Fixes: 33a24910ae ("target/riscv: Use GDBFeature for dynamic XML")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/gdbstub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index d0cc5762c2..c07df972f1 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -288,7 +288,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUS=
tate *cs, int base_reg)
>  static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int ba=
se_reg)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    int reg_width =3D cpu->cfg.vlenb;
> +    int bitsize =3D cpu->cfg.vlenb << 3;
>      GDBFeatureBuilder builder;
>      int i;
>
> @@ -298,7 +298,7 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(C=
PUState *cs, int base_reg)
>
>      /* First define types and totals in a whole VL */
>      for (i =3D 0; i < ARRAY_SIZE(vec_lanes); i++) {
> -        int count =3D reg_width / vec_lanes[i].size;
> +        int count =3D bitsize / vec_lanes[i].size;
>          gdb_feature_builder_append_tag(
>              &builder, "<vector id=3D\"%s\" type=3D\"%s\" count=3D\"%d\"/=
>",
>              vec_lanes[i].id, vec_lanes[i].gdb_type, count);
> @@ -316,7 +316,7 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(C=
PUState *cs, int base_reg)
>      /* Define vector registers */
>      for (i =3D 0; i < 32; i++) {
>          gdb_feature_builder_append_reg(&builder, g_strdup_printf("v%d", =
i),
> -                                       reg_width, i, "riscv_vector", "ve=
ctor");
> +                                       bitsize, i, "riscv_vector", "vect=
or");
>      }
>
>      gdb_feature_builder_end(&builder);
> --
> 2.44.0
>
>

