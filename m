Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB771EFCE58
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 02:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxyeN-0002Sb-3I; Wed, 04 Mar 2026 21:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxyeL-0002S6-Cx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 21:41:17 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxyeJ-0002wZ-Fc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 21:41:16 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so1015126866b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 18:41:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772678474; cv=none;
 d=google.com; s=arc-20240605;
 b=X8JAeQzCGiucExTPkZiqkvZr7efm1xt0iWXTUT6csDlbt3OI0V/DgUrsldJsEmNP0Q
 61c93c+O0UO6aRZWd2OUa+aCtEYONO3lbYxK4V6ird5xceHzZ1OCLRuT5EU8A1ZMwM9K
 whcM2nyDl93W3JOk/8Ah4h0QcJYKX1yYLlyRl0KWtmkdyz3/xvhYlfvx3S4m7hS+D83W
 kiT5nxS2hvzN3A3LHAJ6J16EdqEq6DGgXqzUDezGmGdrDzMV9PKO2O+2r4Vlm50nJ0Ld
 rzFkM4GsSMtA0I5O6DEkdZoXh5DOiaDdTDGy1NeFHyy3QWOL0fKeChB6De1GFI1TS70U
 JQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oPCnUNPamZcgxCU3UgeL2btxdOGvdRqFjBQssDkSzXw=;
 fh=qVCHIBAmpZfRsxgXEvXh2s/XRWnqGWa8TXLczCTGhXs=;
 b=fjt88FHUGX3ieYOpNMvvL8k9nHHG57w/iYcVA9bzlP9h+f7rQFFFno41LYk2gNzTzK
 vgMARXaZR3dlCeSAk00uFep21oOfU0Z4vOq/t+mggBEh5cfdqHSJQFJyHIFPFzszGfI6
 ZX8ywCEIinbXERfCotBbhwr5OkoJHVD6ZwNiMjMbLCznTLyurDMFzcLPVLsZrtVPeLU4
 5J6+QcVl7/CV2PL9zU7uanOFMCZhUmb9EA0zDOn3mvREwOWSpv9ne2zDRKJukpqWZ1uB
 A82xwdA+4nAi2Em6dzUGx1CIkumRTxssGagMkLV3M5OzTG/Z00xAZ6v1e0rAmymE17ht
 9aYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772678474; x=1773283274; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPCnUNPamZcgxCU3UgeL2btxdOGvdRqFjBQssDkSzXw=;
 b=faL8tkWmswafW7Ed+3JW9gRNVVGhvcDmuRpXq0FRUBtbgYcVXPgzYIBx9LffOuf/P0
 yw1lJ/KcWB71nTrWyoOgN8dsTgw4jn0m0/ppCh5+HrwpnUz4Irul0mFEg8R9zauF5rNH
 0zDc+4gAeoYqhY6ErMPueeNyvYMW4B9eqLjxj8DfKKH8djPYvJJsuPC3FF7Evd6E/37m
 PYgeq9ObleILkGONMN+nEJkuZw9+rQedwITIbtnICKrUeWBcLMwJHCzsC/XCAfa/0JAA
 lBEeNNeJlEgYKwLDj21qps8bcQqz5EMBbdN3eAnNHFQTKpmpbYSAfszP+dW3qDv5HmL8
 dsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772678474; x=1773283274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oPCnUNPamZcgxCU3UgeL2btxdOGvdRqFjBQssDkSzXw=;
 b=WPdEQqsqAduRCNN3NlLYd3HKHtf+lFz72xSiRpewxiqXwo4sl5j640wLOb1InG3P2M
 jq2tMySLn3Zj05sCw1t+wC/WSwFn/BP5MvTUv033DdeGKD5j+rTaVQMiTDcVohmlxfsy
 cBgpZKtZYj8Zz/mHkFfrQX+Uw8th8R6ZrqdA+9+4KsEwYvxGewCMz0R9WGmMPJW7yA6k
 rUlzAwgRYsQL6AES6HVoh3VmIenPrbAJFtPbu/hgIS+vPqFC9uV6uXiBztS6t7nGCni8
 DADsp/uSPLS9vbSJ1PiuNANa8PyAlPj2aFKyQX8FJ1JsTzN1ulDGRvo8OxURkDA9ah66
 9fdQ==
X-Gm-Message-State: AOJu0Yyx91hwnNU1dbFTHXctu0SHwK5rs9/Mq/w/2bx2pl+mKLuh0xSb
 IMgsV0xjGZFoUN6H93bGkwN+2PRoTypLS/YgZNUWjV+Bav6g64poVkw/mDUoNppaAuQFXF6s+bv
 +u31Dq1RJSa4hNLx2vuM7C6AYdmBSNWc=
X-Gm-Gg: ATEYQzyztL+YHfydtwjMhf6fY0E8CqR0ECQzTIvXjqdA3HLeIB5TQqarQt+DSn1OqPc
 nR6cXtP0O5H9dVoWvTaYatnn8ZG5YCbt8YLUjQNlGm2AhltE0EwFYjx6nznxTZJWVbqib3Wdajl
 y/oa5WIP9cQO/NAIVRFKYT5+p35dKIRUWyO0DfuOOKa//5zGUIOmtP/HP0mUam7kCYdrI/aU24t
 aHLmKR5y8PK0IfeB80pI+RPYAMqR5NxoSipu3FLj1YseT1hYWEFrLkUWBcuoYTclxvg8VkM4uKz
 Qqw8uT+ZSLwIgR4tc6dymQL3Ds/UGEVKEBfhYfzjSGpkSKJc
X-Received: by 2002:a17:907:7285:b0:b8f:ab5f:3578 with SMTP id
 a640c23a62f3a-b93f14da7eemr227286566b.35.1772678473671; Wed, 04 Mar 2026
 18:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-4-max.chou@sifive.com>
In-Reply-To: <20260304134006.2908449-4-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 12:40:46 +1000
X-Gm-Features: AaiRm50LW5R7WC4QL7w55UAsD9qUKLGUUfEmGS-Wf4GrBkPbhMZZ2eTArrUOTMQ
Message-ID: <CAKmqyKP=oDVxYfc+JoJdVtkfHrny_CzkEaK-Ahoh61uTK0QLuQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] target/riscv: Add implied rules for Zvfofp8min
 extension
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Wed, Mar 4, 2026 at 11:42=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> Add implied rules to enable the implied extensions of Zvfofp8min
> extension recursively.
>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c3ddcefedc..1cd74f01b7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2508,6 +2508,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED =3D=
 {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvfofp8min),
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVKN_IMPLIED =3D {
>      .ext =3D CPU_CFG_OFFSET(ext_zvkn),
>      .implied_multi_exts =3D {
> @@ -2645,8 +2654,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_ru=
les[] =3D {
>      &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
>      &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
>      &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> -    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> -    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> +    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
> +    &ZVKN_IMPLIED, &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
>      &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
>      NULL
> --
> 2.52.0
>
>

