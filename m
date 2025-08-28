Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA1CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgE0-0005c8-Dc; Thu, 28 Aug 2025 13:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urba4-0005ct-Bg
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:18:18 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urba1-0000ff-UC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:18:16 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61cb4370e7bso1381004a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383491; x=1756988291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GPzimTqwEa24oqv/kYioM8KtTLlIhF5c5I5z2xJwoY=;
 b=x8Pzp2n6QRtl/Tn/0BK1MUNUOiFo5+8VWWSczsVvNvWoMdVA+YcrB0MTiYFaRLCTcV
 HbE/ofdUeITE6H1k5De1lvg2fSeLF9FKFfh+CIrJgZSfgT9Z4pAEjqeDZ+97raaK5SyA
 QYpWLTOk0KCs7UF+DcVNJaCVAJRa8VATMx0KUpQgjEyN7v5HRMVv6r5NVj9Vrq/KDEPx
 eU6r0QOL5o6GRm63lv98Fc/aO3Kq6ZPc4M2oQz7n20CzUJ9ZtM6SlQl1HqXUNHBM8kf/
 c35TpMmxDU0My66v7NFnQQu0asUn5rUb9nCmSqm1barh9xj5pQOLScp8B6FOPK5Obk6C
 5+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383491; x=1756988291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GPzimTqwEa24oqv/kYioM8KtTLlIhF5c5I5z2xJwoY=;
 b=IPq8o536LJPBjPb2gjqTnm62TGyjL3yyhfKh28ekgovwU/MSw6laUSp5tZyeLCkGeP
 5IepflV3OqBhu0/1GHRgA4oo7eUmuORXP/Ki9eKg4/CiksvAeVAY8rnb+vOUN2vFyiKY
 pYee1zd9GUf0umRAi1090u22y1mfX7DVn0swoLrLvgzeshxClYd6BY5DossLr59B7Ovc
 q3UJET7ii6jE5EjaoRKrcSEQliPbjrhzesIwYFkSbaK+/1TtbotrdyipEyQF+60z+ACE
 5AhtBQWqv+TIXg17GtGdgO6SMa6Yz5NnFJQitaBL953OuxPW2PKOhGiYnYaUQ3YjwCo7
 MoQA==
X-Gm-Message-State: AOJu0YxScFME/6sFpPtTpKRYZ4ilPh9qQk7mrlmBkFwF47qEX2Hix97N
 81VQwTxjmbyZCXf6UPqNNPo2aMYEEVPhz9oZijpQ9EQhbFOLuZlNr4rATxXyiwldCDA+Q2a/mVC
 4nYoyyGKkSdgomJCEoVsYn3zaXgJ2un2NAPKfXX2c7g==
X-Gm-Gg: ASbGncs4IQAlRbWhxuf6bDnVAlK/pRjCuNxhGApswIcRgH5rPm8uV/xnl5VfT5e7yU6
 hWavGFiEMKy4Osa8VhEXx2pb3we1qGdtqbXyCm/j6p+t8Ir0Omj1gJFrfMFnn47qbj/xUyHzUft
 VbVo2KeeQj8axuwOTdcynM3rqmYrFWG+Tg7P07NQEhznohRvygBEsaSN0nMeD/9hrazmPCCxSsz
 dRyOjDbFjGtqGZdbpI=
X-Google-Smtp-Source: AGHT+IHFBrGbrY6O11ccNmpnJD4dCkn+8IB38DGL8l2+IMFev10ZjCGx87YJ+eqlHkMAdtj6fnYZZsTw7xM0SeOsmvs=
X-Received: by 2002:a17:906:66c5:b0:afe:98cb:e624 with SMTP id
 a640c23a62f3a-afe98cbeaa7mr827087366b.51.1756383490849; Thu, 28 Aug 2025
 05:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-6-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-6-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 Aug 2025 15:17:44 +0300
X-Gm-Features: Ac12FXzz-CBq93IBOsEj5dMABK0wBWo0MIHThSd8k8d9CHkdH760Or68lJtKpAk
Message-ID: <CAAjaMXaQ=pQorbiMLUhGGsr4-bozAO8UkbNSnFdb1ka+2PsOYA@mail.gmail.com>
Subject: Re: [PATCH 04/61] target/arm/hvf: Reorder DEF_SYSREG arguments
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Wed, Aug 27, 2025 at 4:06=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The order of the parameters in the Arm ARM is
>
>   op0, op1, crn, crm, op2
>
> Reorder the arguments of DEF_SYSREG to match.
> Mechanical change to sysreg.c.inc using
>
>   sed 's/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\1,\4,\5,\2,\3=
/'
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/hvf/hvf.c        |   2 +-
>  target/arm/hvf/sysreg.c.inc | 224 ++++++++++++++++++------------------
>  2 files changed, 113 insertions(+), 113 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index f0e4b75e6a..7b0413093d 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -403,7 +403,7 @@ struct hvf_sreg_match {
>      uint32_t cp_idx;
>  };
>
> -#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
> +#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2) \
>      { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
>
>  static struct hvf_sreg_match hvf_sreg_match[] =3D {
> diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
> index 222698f1d1..f2276d534e 100644
> --- a/target/arm/hvf/sysreg.c.inc
> +++ b/target/arm/hvf/sysreg.c.inc
> @@ -1,146 +1,146 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 0, 0, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 0, 0, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 0, 0, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 0, 0, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 2, 0, 0, 0, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 2, 0, 0, 0, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 2, 0, 0, 0, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 2, 0, 0, 0, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 0, 1, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 0, 1, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 0, 1, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 0, 1, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 2, 0, 0, 1, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 2, 0, 0, 1, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 2, 0, 0, 1, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 2, 0, 0, 1, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 0, 2, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 0, 2, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 0, 2, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 0, 2, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 2, 0, 0, 2, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 2, 0, 0, 2, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 2, 0, 0, 2, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 2, 0, 0, 2, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 0, 3, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 0, 3, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 0, 3, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 0, 3, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 2, 0, 0, 3, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 2, 0, 0, 3, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 2, 0, 0, 3, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 2, 0, 0, 3, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 0, 4, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 0, 4, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 0, 4, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 0, 4, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 2, 0, 0, 4, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 2, 0, 0, 4, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 2, 0, 0, 4, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 2, 0, 0, 4, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 0, 5, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 0, 5, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 0, 5, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 0, 5, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 2, 0, 0, 5, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 2, 0, 0, 5, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 2, 0, 0, 5, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 2, 0, 0, 5, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 0, 6, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 0, 6, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 0, 6, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 0, 6, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 2, 0, 0, 6, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 2, 0, 0, 6, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 2, 0, 0, 6, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 2, 0, 0, 6, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 0, 7, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 0, 7, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 0, 7, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 0, 7, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 2, 0, 0, 7, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 2, 0, 0, 7, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 2, 0, 0, 7, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 2, 0, 0, 7, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 0, 8, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 0, 8, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 0, 8, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 0, 8, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 2, 0, 0, 8, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 2, 0, 0, 8, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 2, 0, 0, 8, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 2, 0, 0, 8, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 0, 9, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 0, 9, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 0, 9, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 0, 9, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 2, 0, 0, 9, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 2, 0, 0, 9, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 2, 0, 0, 9, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 2, 0, 0, 9, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 0, 10, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 0, 10, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 0, 10, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 0, 10, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 2, 0, 0, 10, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 2, 0, 0, 10, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 2, 0, 0, 10, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 2, 0, 0, 10, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 0, 11, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 0, 11, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 0, 11, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 0, 11, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 2, 0, 0, 11, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 2, 0, 0, 11, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 2, 0, 0, 11, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 2, 0, 0, 11, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 0, 12, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 0, 12, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 0, 12, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 0, 12, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 2, 0, 0, 12, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 2, 0, 0, 12, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 2, 0, 0, 12, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 2, 0, 0, 12, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 0, 13, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 0, 13, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 0, 13, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 0, 13, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 2, 0, 0, 13, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 2, 0, 0, 13, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 2, 0, 0, 13, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 2, 0, 0, 13, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 0, 14, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 0, 14, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 0, 14, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 0, 14, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 2, 0, 0, 14, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 2, 0, 0, 14, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 2, 0, 0, 14, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 2, 0, 0, 14, 7)
>
> -DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 0, 15, 2, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 0, 15, 2, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 0, 15, 2, 0, 6)
> -DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 0, 15, 2, 0, 7)
> +DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 2, 0, 0, 15, 4)
> +DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 2, 0, 0, 15, 5)
> +DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 2, 0, 0, 15, 6)
> +DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 2, 0, 0, 15, 7)
>
>  #ifdef SYNC_NO_RAW_REGS
>  /*
>   * The registers below are manually synced on init because they are
>   * marked as NO_RAW. We still list them to make number space sync easier=
.
>   */
> -DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 0, 2, 2, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 0, 0, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 0, 0, 3, 0, 5)
> -DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 0, 4, 3, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 2, 0, 0, 2, 0)
> +DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 3, 0, 0, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 3, 0, 0, 0, 5)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
>  #endif
>
> -DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 0, 4, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 0, 5, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 0, 5, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 0, 6, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 0, 6, 3, 0, 1)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
>
>  #ifdef SYNC_NO_MMFR0
>  /* We keep the hardware MMFR0 around. HW limits are there anyway */
> -DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 0, 7, 3, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>  #endif
>
> -DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 0, 7, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 0, 7, 3, 0, 2)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
> +DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
>  /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
>
> -DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 0, 2, 2, 0, 2)
> -DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 1, 0, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 1, 0, 3, 0, 2)
> -DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 2, 0, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 2, 0, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_TCR_EL1, 2, 0, 3, 0, 2)
> +DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 2, 0, 0, 2, 2)
> +DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 3, 0, 1, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 3, 0, 1, 0, 2)
> +DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 3, 0, 2, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 3, 0, 2, 0, 1)
> +DEF_SYSREG(HV_SYS_REG_TCR_EL1, 3, 0, 2, 0, 2)
>
> -DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 2, 1, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 2, 1, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 2, 1, 3, 0, 2)
> -DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 2, 1, 3, 0, 3)
> -DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 2, 2, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 2, 2, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 2, 2, 3, 0, 2)
> -DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 2, 2, 3, 0, 3)
> -DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 2, 3, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 2, 3, 3, 0, 1)
> +DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 3, 0, 2, 1, 0)
> +DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 3, 0, 2, 1, 1)
> +DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 3, 0, 2, 1, 2)
> +DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 3, 0, 2, 1, 3)
> +DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 3, 0, 2, 2, 0)
> +DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 3, 0, 2, 2, 1)
> +DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 3, 0, 2, 2, 2)
> +DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 3, 0, 2, 2, 3)
> +DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 3, 0, 2, 3, 0)
> +DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 3, 0, 2, 3, 1)
>
> -DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 4, 0, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_ELR_EL1, 4, 0, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_SP_EL0, 4, 1, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 5, 1, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 5, 1, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_ESR_EL1, 5, 2, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_FAR_EL1, 6, 0, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_PAR_EL1, 7, 4, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 10, 2, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 10, 3, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 12, 0, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 13, 0, 3, 0, 1)
> -DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 13, 0, 3, 0, 4)
> -DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 14, 1, 3, 0, 0)
> -DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 0, 0, 3, 2, 0)
> -DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 13, 0, 3, 3, 2)
> -DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 13, 0, 3, 3, 3)
> -DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 14, 3, 3, 3, 1)
> -DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 14, 3, 3, 3, 2)
> -DEF_SYSREG(HV_SYS_REG_SP_EL1, 4, 1, 3, 4, 0)
> +DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 3, 0, 4, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_ELR_EL1, 3, 0, 4, 0, 1)
> +DEF_SYSREG(HV_SYS_REG_SP_EL0, 3, 0, 4, 1, 0)
> +DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 3, 0, 5, 1, 0)
> +DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 3, 0, 5, 1, 1)
> +DEF_SYSREG(HV_SYS_REG_ESR_EL1, 3, 0, 5, 2, 0)
> +DEF_SYSREG(HV_SYS_REG_FAR_EL1, 3, 0, 6, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_PAR_EL1, 3, 0, 7, 4, 0)
> +DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 3, 0, 10, 2, 0)
> +DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 3, 0, 10, 3, 0)
> +DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 3, 0, 12, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 3, 0, 13, 0, 1)
> +DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 3, 0, 13, 0, 4)
> +DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 3, 0, 14, 1, 0)
> +DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 3, 2, 0, 0, 0)
> +DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 3, 3, 13, 0, 2)
> +DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
> +DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
> +DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
> +DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
> --
> 2.43.0
>
>

