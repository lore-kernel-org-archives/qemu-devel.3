Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE9BD0E6FA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNuwA-0003FI-H4; Tue, 25 Nov 2025 10:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNuvx-0003DY-8m
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:26:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNuvv-0005YD-9m
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:26:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477c111929bso2669095e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764084381; x=1764689181; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7M0Pq/ySAVs8sOi+kM20HDWkPwzXkA29yhVbqXByVk=;
 b=H/eRatYUNaVuRqwfUvOoG5xFUfy0OEgfMkCbP91sZalcPVR4QVGMtzQYP11hCQ12q9
 2xsX/POEFgManKWRsxiRsmfKPn3ZprlZ78uAIsULogHUuIOuJzbYeEGJOFL+RNgM6SbK
 owxwHRvkTx9hBjWC4es61lVSv7IsG28DJf9d4p3MWKRZ2yiPv9sGfTVXFwm/7vEiGxBx
 GdWlGbWUUIoZ9X2aDIPv/Uojjzk5/2HQdECUWpPX4VE4NzKiEidInM3Xb0Z/aRa8lKsJ
 BKBC8eA5QhVYWolFHM4fnMuMy5YdShII2TKD1A8Bsy2qEqN5gwQ6bpMVwItR95INlkXD
 kuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084381; x=1764689181;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k7M0Pq/ySAVs8sOi+kM20HDWkPwzXkA29yhVbqXByVk=;
 b=proN3y/KAOvMjj/LvvdDORUlpcV4f6Cq2ubYqtoesjzhJb994LldcAlHGkQoF45mNd
 ZVlwoWJbvaVKdVQf1o98OEyqmhkVMYfRuk9ytVaDfhIvtgVFa12ebpSmV8nXknb7rtvC
 vtl2qCfKcE0UPY8GQKJkO+n+Pha7BZC+1jOOkDQYzkLVZgJfisPATFRFLAcJjykl066S
 frlwMg5LfUkj7pBO0xj7Z6ciWdeJazzPeRRunNejwEc9OdV8HlyJB5EIp3K4WZyxxe+g
 HzLU7WtvD3zKh9JAjWDsqT37K5NTLn/nBeVRLMQm9vFalcn+bWpwWd7uVdjDrujvIwRp
 VzhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFNZ6v4ochyWe6ZMQgzApqFEeAGZPmA/PnU0cTckCez5tLi6hZ20AuA51FkOmBBs/zbkykY2Zk3xXV@nongnu.org
X-Gm-Message-State: AOJu0YzUFWNu0rqwsCempFu9MIA5lIRZ0ITpo2BttLRpmx3rjgCu1W6S
 +B8qG9nAQm3MZ6UpwrQP7vWTuHIvfkgJIdXH/0jjihrC1+OOyQXsaX+vW0A3/qqol2Q=
X-Gm-Gg: ASbGncudG9GM8hq8tuHtA8ZjYHMTFesGcJB68sCtm/AYB7enmoz7dsEgHld6CerJ3pG
 b7tUHhyyTVMieneU/KEPkxdJoYdedOvHE2+968sgB6CKMZ+akImwMyfB8O09HzlKGTeOdKIvMsa
 EKWjsOGnghjzDcvUTUzDMSoTFP9bYsl/QbLl9JeiA3Be1xuDgES5GDKgTNbsL5lAr6obAwy8yeM
 elEa3uD+F/waF8iDgKJ5VG0L488ONx6TOxPCZ65iy+4pAyVQmSUqI0Ctg25VK+6ytUZDbSUyxTm
 kJSkh8bEjcAIA/RtrTKbtDRVwfOQJbnIqESZ3Suvya7jg/eLlnGggt3OkJf80SW4FHgZRGaXu4k
 owLnBOUjUsG+2qranp0H5aa9sFEo8xYPqpP3YO4snKl+zmpe37oJOpfX9xDvB
X-Google-Smtp-Source: AGHT+IHMkCJdKL2s26jA6MEEeNqBF9zYSkp4ZfhApP2d0TZbUb6M7+MgijA/HrwLMhtMFXNC/+aIgw==
X-Received: by 2002:a05:600c:4f51:b0:477:a977:b8a0 with SMTP id
 5b1f17b1804b1-477c01ba7d6mr105892375e9.3.1764084380916; 
 Tue, 25 Nov 2025 07:26:20 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-477bf1f365fsm258826945e9.8.2025.11.25.07.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:26:20 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 16:25:45 +0100
Message-Id: <DEHVPKNHJOPC.2TGKLMGEUF617@ventanamicro.com>
Subject: Re: [PATCH v2 3/6] target/riscv: Fix pointer masking PMM field
 selection logic
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "open list:RISC-V TCG CPUs"
 <qemu-riscv@nongnu.org>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: <frank.chang@sifive.com>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
 <20251121050413.3718427-4-frank.chang@sifive.com>
In-Reply-To: <20251121050413.3718427-4-frank.chang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-21T13:04:10+08:00, <frank.chang@sifive.com>:
> From: Frank Chang <frank.chang@sifive.com>
>
> mstatus.MPV only records the previous virtualization state, and does not
> affect pointer masking according to the Zjpm specification.
>
> This patch rewrites riscv_pm_get_pmm() to follow the architectural
> definition of Smmpm, Smnpm, and Ssnpm.
>
> The resulting PMM selection logic for each mode is summarized below:
>
>   * mstatus.MXR =3D 1: pointer masking disabled
>
>   * Smmpm + Smnpm + Ssnpm:
>       M-mode:  mseccfg.PMM
>       S-mode:  menvcfg.PMM
>       U-mode:  senvcfg.PMM
>       VS-mode: henvcfg.PMM
>       VU-mode: senvcfg.PMM
>
>   * Smmpm + Smnpm (RVS implemented):
>       M-mode:  mseccfg.PMM
>       S-mode:  menvcfg.PMM
>       U/VS/VU: disabled (Ssnpm not present)
>
>   * Smmpm + Smnpm (RVS not implemented):
>       M-mode:  mseccfg.PMM
>       U-mode:  menvcfg.PMM
>       S/VS/VU: disabled (no S-mode)
>
>   * Smmpm only:
>       M-mode:  mseccfg.PMM
>       Other existing modes: pointer masking disabled
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>  RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    int priv_mode =3D cpu_address_mode(env);
> +    int priv_mode;
> +    bool virt;
> =20
> -    if (get_field(env->mstatus, MSTATUS_MPRV) &&
> -        get_field(env->mstatus, MSTATUS_MXR)) {
> +    if (get_field(env->mstatus, MSTATUS_MXR)) {
>          return PMM_FIELD_DISABLED;
>      }

MSTATUS_MXR doesn't disable Pointer masking in M-mode, and we also need
to consider virt, where vsstatus.MXR is in effect as well.

> =20
> +    riscv_cpu_eff_priv(env, &priv_mode, &virt);

I think you could put something like this here:

      if ((mode !=3D PRV_M && get_field(env->mstatus, MSTATUS_MXR)) ||
          (virt && get_field(env->vsstatus, MSTATUS_MXR))) {
          return PMM_FIELD_DISABLED;
      }

>      /* Get current PMM field */
>      switch (priv_mode) {
>      case PRV_M:
> @@ -189,22 +222,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>      case PRV_U:
> -        if (riscv_has_ext(env, RVS)) {
> +        if (!virt) {
>              if (riscv_cpu_cfg(env)->ext_ssnpm) {
>                  return get_field(env->senvcfg, SENVCFG_PMM);
>              }
> -        } else {
> +
>              if (riscv_cpu_cfg(env)->ext_smnpm) {
> -                return get_field(env->menvcfg, MENVCFG_PMM);
> +                if (!riscv_has_ext(env, RVS)) {
> +                    return get_field(env->menvcfg, MENVCFG_PMM);
> +                }
> +            }
> +        } else {
> +            if (riscv_cpu_cfg(env)->ext_ssnpm) {
> +                return get_field(env->senvcfg, SENVCFG_PMM);
>              }
>          }

virt doesn't really matter, the original code was correct.

Thanks.

