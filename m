Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7AEE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 05:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNQWO-0003r3-50; Tue, 17 Dec 2024 00:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNQWM-0003qf-Ik; Tue, 17 Dec 2024 00:53:26 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNQWK-0001I9-OI; Tue, 17 Dec 2024 00:53:26 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-85c41442fdeso1082983241.1; 
 Mon, 16 Dec 2024 21:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734414803; x=1735019603; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27BK4sp41ulgsAu5DCYyH0ki8uLYaAJ3CMiG44/p1Fo=;
 b=mv6jnh9gfN88WB+abHaqvckiMxQFQyqcX0Qlq+21EfbBEPg1ifx++0ybG8cHM+N+Ya
 4OJVovt3OIJiegDry8x3+UQb1451NdyxLdSvKlCiw9TwPOVLtbVRXMqBYzx4jbwNwKcE
 gMrMEWEJTKGFUyVyU+UAbjfhgpmbR0hMn+Xb9lND++YULY6UOiC7Tq76mCe9imGipV5U
 EeD/HUUVmrUFcIGJA53/j/R0Ef5ApgpReKJDCIw1il9JNdGlM9xkeDb/Weg9Z3hYVHFX
 pNTly9lIBwW6CRCfoJ7gvwna22/fKlKrradHoivPsgrKYyoBLrxKGSXX3kQNbW7kvAHp
 D/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734414803; x=1735019603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27BK4sp41ulgsAu5DCYyH0ki8uLYaAJ3CMiG44/p1Fo=;
 b=kqlPjzlkZFu24Rm2bwJ/pPTLsGyOWlop1I0idF38P2qcu88JKlzNy4ZHZreFNmLnY3
 wt0DN35TuzMdvIRu5iJU6oV4ZdGvWpE5UYBiXkEDRk8ejSmx0uXrpSPQY3WgYs7ip4gZ
 yyJt/3tkMFtveS5tewmouqEu5mD2h3kvKp+pVw0kOC1NvzQ+WC69W1nt3rHS/yYY8St8
 jBgcE6zSz9/JTTrQszNACBIVauKGra7FmyhY2i5Ng/M2/lHjNCNYZsQ92lqEjQXlZbke
 Npf34VDvfpT/29hsvJetghQp1inC/o5tusuKiW92xR5B21QVfeFibOQu+ZOVEM0pMdkM
 fNmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk6+T6dcyLc5KH1HkW722C6Ngee/QMTYgE4Nsr7kDsiE8Zq2IhqW+pEUvMXkQr+jf3rqhCRRcJpt5GNQ==@nongnu.org,
 AJvYcCXOswrRNsjkka9mY7zyJXLM9gi3lmvU5cHaiH0/Hie8eaoHSQbao8rY8t5RVAGxX3NV0W/ybeJJoCWF@nongnu.org
X-Gm-Message-State: AOJu0Yy4da59Dvz9s555S2ES/zqwXlPfigfggM0EAk7P2XcrV5TG1z72
 YhApujOqVOoFyOcb03iyQ0fSN1gx2oHfnW2kQXjKzfi5D3SPbeH7rLAdM9fvrlOG3ZGTm9f0+BX
 m72GxqR4emvbIIHWjQQoGFpJDsHo=
X-Gm-Gg: ASbGnct0qzqAer9llnDTH1sA/Kgbmb8PXw7trFlj1iftL4UFfX5knKpCC8AN+ff2QgQ
 cMJanSqbPLxrRWqK4wYt81ojZcq2obZOcq5D9POh+hoAVr5e94FSekGI4CF1Zwb7sjc2S
X-Google-Smtp-Source: AGHT+IHOgvMKoIVtZvfNMKYVgOwLdanUuuzeDaA7NWLxUZZi6Em53GCAMYBn1+60KL+nfrAwWMMVRiP4+59jE81hNxA=
X-Received: by 2002:a05:6102:b:b0:4b2:73f7:5adf with SMTP id
 ada2fe7eead31-4b273f75d7bmr7660335137.9.1734414802800; Mon, 16 Dec 2024
 21:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
 <20241216121907.660504-4-baturo.alexey@gmail.com>
In-Reply-To: <20241216121907.660504-4-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Dec 2024 15:52:56 +1000
Message-ID: <CAKmqyKOE4S3AHFwiCjE=T4XnXoYvHfOZeut=HQpe9+zFuSWGWw@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Mon, Dec 16, 2024 at 10:19=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---
>  target/riscv/cpu.h        |  5 +++
>  target/riscv/cpu_helper.c | 73 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 417ff45544..e7f346ff6b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -768,8 +768,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr =
*pc,
>
>  bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> +uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
> +
>  RISCVException riscv_csrr(CPURISCVState *env, int csrno,
>                            target_ulong *ret_value);
> +
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
>                             target_ulong new_value, target_ulong write_ma=
sk);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dba04851d5..ed0d275e84 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -214,6 +214,79 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr =
*pc,
>      *pflags =3D flags;
>  }
>
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> +{
> +    RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;
> +#ifndef CONFIG_USER_ONLY
> +    if (get_field(env->mstatus, MSTATUS_MPRV) &&
> +        get_field(env->mstatus, MSTATUS_MXR)) {
> +        return pmm;
> +    }
> +    int priv_mode =3D cpu_address_mode(env);

QEMU style is to not mix code and declarations.

I think a clearer way would be

#ifndef CONFIG_USER_ONLY
    RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;
    int priv_mode =3D cpu_address_mode(env);

    if (get_field(env->mstatus, MSTATUS_MPRV) &&
        get_field(env->mstatus, MSTATUS_MXR)) {
        return pmm;
    }

    /* Get current PMM field */
...
    return pmm;
#else
    return PMM_FIELD_DISABLED;
#endif


> +    /* Get current PMM field */
> +    switch (priv_mode) {
> +    case PRV_M:
> +        if (riscv_cpu_cfg(env)->ext_smmpm) {
> +            pmm =3D get_field(env->mseccfg, MSECCFG_PMM);
> +        }
> +        break;
> +    case PRV_S:
> +        if (riscv_cpu_cfg(env)->ext_smnpm) {
> +            if (get_field(env->mstatus, MSTATUS_MPV)) {
> +                pmm =3D get_field(env->henvcfg, HENVCFG_PMM);
> +            } else {
> +                pmm =3D get_field(env->menvcfg, MENVCFG_PMM);
> +            }
> +        }
> +        break;
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            if (riscv_cpu_cfg(env)->ext_ssnpm) {
> +                pmm =3D get_field(env->senvcfg, SENVCFG_PMM);
> +            }
> +        } else {
> +            if (riscv_cpu_cfg(env)->ext_smnpm) {
> +                pmm =3D get_field(env->menvcfg, MENVCFG_PMM);
> +            }
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +#endif
> +    return pmm;
> +}
> +
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +{
> +    bool virt_mem_en =3D false;
> +#ifndef CONFIG_USER_ONLY
> +    int satp_mode =3D 0;
> +    int priv_mode =3D cpu_address_mode(env);

New line please :)

> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        satp_mode =3D get_field(env->satp, SATP32_MODE);
> +    } else {
> +        satp_mode =3D get_field(env->satp, SATP64_MODE);
> +    }
> +    virt_mem_en =3D ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=3D P=
RV_M));
> +#endif
> +    return virt_mem_en;

I think an #else is probably easier to read

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +}
> +
> +uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm)
> +{
> +    switch (pmm) {
> +    case PMM_FIELD_DISABLED:
> +        return 0;
> +    case PMM_FIELD_PMLEN7:
> +        return 7;
> +    case PMM_FIELD_PMLEN16:
> +        return 16;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>
>  /*
> --
> 2.39.5
>

