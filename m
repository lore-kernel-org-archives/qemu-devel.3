Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0048C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 00:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGoG9-00020x-6e; Sun, 18 May 2025 20:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoG7-00020k-E3; Sun, 18 May 2025 20:21:35 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoG5-00088c-OJ; Sun, 18 May 2025 20:21:35 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86d6fd581f4so3127485241.1; 
 Sun, 18 May 2025 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747614092; x=1748218892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXRmqZaU8swm+EjBIXCvtfh6ZLXIGrqhYvCrfJyIEyk=;
 b=XEk0xcroa0yPUldSBSDCCbmwi+kq0eIz3MBzRJ5L55UWn8lb64ZKzIqSqrSyR+NPyM
 dIKj4wtEEghWO9taUZph2rjag54E12Drz7g0WImLDmkNRXEzSa3eczKXa+jck8EDR/yG
 El2izPExANvcNXRnWZJX6xr1P6tdmDxsGvWoBGPkIad+PvpcUP4WALJ8dtGeNPLMWXbe
 nAy7Yc/SLoPZnwu7zSsheVYMbUO87weFCVFpB7z7dhZYlftKPm20WvhW8qmFNTm6GHLl
 DURkP4Btwk44wU+shsVpIbV5gANk220k688v61O4HvdzrVYixpKB7OrEYH3cRwRkwSgL
 349Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747614092; x=1748218892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXRmqZaU8swm+EjBIXCvtfh6ZLXIGrqhYvCrfJyIEyk=;
 b=bsJEtg4q5T+sA9Ls0gqk+v3wMuP/LTt8kWIx87IkKMnnyoLvec5AicrI/Jgslc+VaO
 9cPak3iZgrgdclaZU8taQp5C7lZ3Pwcv7SRShHyXlaErKeafGeDJQ3kbWOu0496pwfHA
 a3GjIQgCsnJwsrVTP7iQ3DjtQMYhHZ1/Q9ohuEpahLwjninTydNpoXhtCJ1NuOqLOkuP
 AiC4bZordFT9x3p+cKTzjjg2dBzud+fr/bsDeNE7ytbDdLPsiC1cOZAAPJf+cvsJMEBR
 UMUYwP5FDc3w50LOI6X8nTiAm1jt4td7GtJGZSiGMgdbWOqF5cFuJzVqxEGddO4jBqyM
 ozeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeWMfGeJ5poR+GQjKcvH9LFyO08HgffEy7OFbDG/iGtiTmd+wZRT7HLLzPCCz7EO4EsRacREiaD6wh@nongnu.org
X-Gm-Message-State: AOJu0YwbcOtYQPEFk7bw7CJsJ1HgDO04RxcaBisCeyjG5SsiqJ+jh8IV
 Rs/FvKPZAWx1n9Tzz8n/xhyb+SFPD6NLj7UCGVN3TptM5nUq7s+1CpkdFpj81J+zKSaTECToA1n
 kIjcF1DP2xvqN2AnXt4h5CEBSIGVc3tg=
X-Gm-Gg: ASbGncv0sACRRD+kIH9kUSlvN/qNOCwUuGlxaHovRshdZJ+xf9r7uUWjCmwYlIF4ZgA
 36Eb4D4JAy3j6xjTrnpXNoFGwIVKG1WQxQ7LksPYrhnxaVH8qK/jy0dJ+41a00uHcwt64HqeQZN
 /dFSw7eTvsPj7Sv3Lt8gd7blWQwDnm1STkxP/S2av9AV5q1Gs2O/dPWJ4iyy0RCTRWWNysA6SLW
 Q==
X-Google-Smtp-Source: AGHT+IE2ASJkx6zx+1USOLMmAEacs5FFYvMum8ZaM3i3bTQdMquWPuvkewam8QuyytbFOhCg9i2uy+bMpneezuKI1fI=
X-Received: by 2002:a05:6102:6c4:b0:4e2:8b49:9fa6 with SMTP id
 ada2fe7eead31-4e28b49a2admr1604503137.4.1747614092197; Sun, 18 May 2025
 17:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250514041118.1614-1-frank.chang@sifive.com>
 <20250514041118.1614-2-frank.chang@sifive.com>
In-Reply-To: <20250514041118.1614-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 10:21:06 +1000
X-Gm-Features: AX0GCFukxkL7H8mPXm6gxiH_8dZa9YaDB1Y6u1gB8GNS4koJOjtyxr29dAclKEg
Message-ID: <CAKmqyKOJeU_qg2qk5ak+f6xDAdVBho9B7sjyKGSa+j_Ep_B5bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Add standard B extension implied rule
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, 
 Jim Shu <jim.shu@sifive.com>
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

On Wed, May 14, 2025 at 2:12=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add the missing implied rule for standard B extension.
> Standard B extension implies Zba, Zbb, Zbs extensions.
>
> RISC-V B spec: https://github.com/riscv/riscv-b
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 27edd5af62..f737b703da 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2532,6 +2532,17 @@ static RISCVCPUImpliedExtsRule RVG_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule RVB_IMPLIED =3D {
> +    .is_misa =3D true,
> +    .ext =3D RVB,
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
> +        CPU_CFG_OFFSET(ext_zbs),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZCB_IMPLIED =3D {
>      .ext =3D CPU_CFG_OFFSET(ext_zcb),
>      .implied_multi_exts =3D {
> @@ -2910,7 +2921,8 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED =3D {
>
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> -    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
> +    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
> +    &RVB_IMPLIED, NULL
>  };
>
>  RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] =3D {
> --
> 2.49.0
>
>

