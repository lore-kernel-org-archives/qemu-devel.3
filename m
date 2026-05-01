Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD19CD13DE
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 01:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wId90-0001oV-CG; Thu, 30 Apr 2026 21:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wId8y-0001nL-Sw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:58:16 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wId8x-0002za-60
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:58:16 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so253859066b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 18:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777600693; cv=none;
 d=google.com; s=arc-20240605;
 b=O4XetyJNH6P9KoQJMHEWnaVkPN2W0s+qetSRL6JCwDIxEgGOEz+qRLir7gHYkBn9LY
 Qoj7KiQWLB+3OI2vBzO7EG+IzjfUAltdhPr2hUvePbQ30GG1KXhTud51SqZ2BHIUtPXR
 2J0+3qEaamx2UykOyGbQNwoMj2/gyfqQxnHdo3MK3eDV4VrLuqvrfua36nRiGF9Zqdzv
 4XbgvLfR2TTV276atVKPKFeI9zDvrKP/dDjnMYr80G22F2Q8g6ZjPmteBHZMkgRcsL3H
 oiEQmPpcCYBsb6n8jYgenQKvDPJv7GR+Qmna40kvVw99wKjVOBhhg8yE5wlcjhvjjLq4
 JiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mE7yUuEmA2zoBkSEm5KGQz9lbMVFUTysWJJ65fNk9Dg=;
 fh=9ZBm7Jeorp9wSVPYF5AiPBCRDB4kcVwmpribd+uGcX8=;
 b=lEomnsMsoRFRmxvIHa80BNA86KOwyYg8zqdIujCXiJowQagQD9dtyjiwEs6FN/ETs6
 L/Sxt3P2fhFrz66gcx4Zg5iZDYuj26QBuhbSsYVWs0n43c9jH1DRZBrpMEc7efw3GFFB
 lsV5OIqwyJgxZi4qEgIhQ1FkBJNEwcV3rMNFX80b7q8mPX23iaOMjuwblmg+35X1yBmf
 vvIfrfp9XjH2QbkLqbmy2cNNz/cRVfe3b/Au+Mh8wmw71e/nXdt92ub4TahEquZAPllQ
 std/lExbfwIJCy4QCLHyXNRN4uIChXsUvbtbThCBCuMo+oA/9RnCYxmweg8GmWTNJRZe
 apDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777600693; x=1778205493; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mE7yUuEmA2zoBkSEm5KGQz9lbMVFUTysWJJ65fNk9Dg=;
 b=KTkL/RumqoDz7XVbuIGSM5Vm9vZw7vnh8U3LBRkrWVzIyqOXa55N8sp/9sRITnqThx
 4Dwv+f4rBCuJMmb9L0q2mIUax2yW6OSI7O2NY7G7GqcBCJn5k9PKMKl43yoz28XKibL1
 hXzUao1W1JnjyW6hVuLx5zAPjZugYzNPLOoI+WKwwJPLwrEYa0+6Qb+AcbbJzevUc4a4
 y6ybl5gDq4miDuP4rOR/y0y4CGzCqSQCvxKQQoNyN2cbDY1DcGdgL+HQjwF5p7+cl3c5
 FNTvXsMS+4VQtQrh8G++AIQSX8MJxo72ucUMgNBSjaj51u0vmM9TeYzxKnb88bWH3bSv
 LjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777600693; x=1778205493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mE7yUuEmA2zoBkSEm5KGQz9lbMVFUTysWJJ65fNk9Dg=;
 b=lfBuCb/oiZJ44obRK8vNglypaAre5xGtnMGpQkAm6KSbylXiH1gJ9y5vtuzxUB29ag
 5WJVjhA0nr/RIhmxmSw6qVyPo1fl32jP2up20QGkpEGzvX+qJ/N8EiRb6facqREyRwl4
 fQpTnghzsc7yTPAmFjwAM3e22C80wp1Gpe+g/HVmRcmCoIElRFeT6oVuLDd+wWWaOd8Q
 9gp/IclUT3EtmFMUWIy9gTN9i4FYW5yqIuJmDpG6xL9rOzRnZYmqc0e5hSjbKdBsTy2F
 ksioPNYhZzabD+YJhy9GEaIrQ5jCCGGEmealMgN0zZiwR73slnPqr0OTFGgex0pgUUu1
 3Rzw==
X-Gm-Message-State: AOJu0Yy2zw2Ae6ZBT0rJKGMTEILuRxP8rR1MxiCjnBmLHPu1V5wPpTZV
 im8mNfHxqhkcHSdtbgMqyTZskhOcWsZwIOf8Uc6QQ48h3mLYuj6wqNWwfNPFWxMJGvN8ipiHFwS
 bGv+dNryAav4O5I0JupcCs6VlHD3pBAFosw==
X-Gm-Gg: AeBDieuONkDjic73Sz38VxQDKX7dUTHlosapUu0aJHjJj/xIKt1b0pz3lb/awznJ90c
 n/pBm1oasM6deFXZYRhIyMEFRfcMmC9/6Gaesqv7GV/jaHUtSEbr87we24HCgJ1H0YK+e0eceW7
 zGsz7Pg90jsPEvo86d2sBvjFI82UjhPsXNAhQScCi/Lcfbm1FzV15biXUQFzaJpTzXCUbMXr3VJ
 +jpq5a4UZqbXUnS0u4fcxuYzsOxinRuu0+l7BtpddFmAyalIJtIBfosfiTYzsTo9ZNMN7pk9Nxh
 ji6CDN8QZHKy45bUHP5SZB3EmO4+CCRedSoUneLbpWEXWMWFMLeETTxuNlA=
X-Received: by 2002:a17:907:3e1e:b0:bbe:876e:87e3 with SMTP id
 a640c23a62f3a-bbe876e8ae6mr104028066b.5.1777600692874; Thu, 30 Apr 2026
 18:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260424050509.3935180-1-frank.chang@sifive.com>
 <20260424050509.3935180-2-frank.chang@sifive.com>
In-Reply-To: <20260424050509.3935180-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 11:57:46 +1000
X-Gm-Features: AVHnY4JLgm6tk9SMiyZ_T-jDUvQT94TBUkI-zdujIe4hBXkWidbcOjgJJs26KQs
Message-ID: <CAKmqyKMT8w+OqYXjHCwX-0VM=oXMphaCrCstQZAj1V0E8SeagA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/riscv: Update MISA.C for Zc* extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Fri, Apr 24, 2026 at 3:07=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> MISA.C is set if the following extensions are selected:
>   * Zca and not F.
>   * Zca, Zcf and F (but not D) is specified (RV32 only).
>   * Zca, Zcf and Zcd if D is specified (RV32 only).
>   * Zca, Zcd if D is specified (RV64 only).
>
> Therefore, MISA.C must be set according to the Zc* extension rules.
>
> Warn the user if RVC is explicitly disabled but MISA.C is required by
> the rules above.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f3f78088956..5db166c01e9 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1163,6 +1163,44 @@ static void riscv_cpu_enable_implied_rules(RISCVCP=
U *cpu)
>      }
>  }
>
> +/*
> + * MISA.C is set if the following extensions are selected:
> + *   - Zca and not F.
> + *   - Zca, Zcf and F (but not D) is specified on RV32.
> + *   - Zca, Zcf and Zcd if D is specified on RV32.
> + *   - Zca, Zcd if D is specified on RV64.
> + */
> +static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    bool set_misa_c =3D false;
> +
> +    if (riscv_has_ext(env, RVC)) {
> +        return;
> +    }
> +
> +    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
> +        set_misa_c =3D true;
> +    } else if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &&
> +               cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
> +               (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
> +                                          riscv_has_ext(env, RVF))) {
> +        set_misa_c =3D true;
> +    } else if (riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> +               cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
> +        set_misa_c =3D true;
> +    }
> +
> +    if (set_misa_c) {
> +        if (cpu_misa_ext_is_user_set(RVC)) {
> +            warn_report("RVC mandated by Zca/Zcf/Zcd extensions");
> +            return;
> +        }
> +
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +    }
> +}
> +
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1170,6 +1208,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>
>      riscv_cpu_init_implied_exts_rules();
>      riscv_cpu_enable_implied_rules(cpu);
> +    riscv_cpu_update_misa_c(cpu);
>
>      riscv_cpu_validate_misa_priv(env, &local_err);
>      if (local_err !=3D NULL) {
> --
> 2.43.0
>
>

