Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FA7C369D8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Ml0-0003Om-TW; Mon, 28 Apr 2025 07:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Mkv-0003Ik-GI; Mon, 28 Apr 2025 07:34:38 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Mkt-00070R-KR; Mon, 28 Apr 2025 07:34:37 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86d3ac0fec0so4773240241.1; 
 Mon, 28 Apr 2025 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745840073; x=1746444873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czqLAWOYbO2YBPV8Q3OncAYsZIlCPhfdtUV561iOTus=;
 b=VBSlGpHskn6U/oF1XUoSmZOMqjM2KKvrkuhcwOblDPX273AuZr2HMZ/sA4ZL/khODF
 i7b9l7fxwQzNiEcuwwRWCz5EPSI1hN6y5imDF1fapaK8A0+V2TxzcgJRSvHyerD3CsUN
 NAQtoMHOUG4ubf8/OZR83fck7/OsRlxWcRiVb4P0W1dbHESHq0c4YMufXEhthvAqOwUh
 PbjU7m6qQRme7XtywsLi8GjTdwWs9GtNe34iYMzqw877WEzTH/EVStJd/XpOw0VPpAVz
 1+Xr7IgcXW5Yh10aaFs5uHc8C1+3g3vHmM1WWiBQbHTESb0WTDCKaawjyfTSeAwGhMGh
 hykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745840073; x=1746444873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czqLAWOYbO2YBPV8Q3OncAYsZIlCPhfdtUV561iOTus=;
 b=o4+ebOMxwMenuwOzfpD3ycXDHwtdvaB4zlWzolx4enqG27TfpDYGPMlm/KHYypuVso
 MUDs4gSHBGPgB6ExcwlQrMP/RO0N0RUyiUHX4aKncOJZwDYTMfR5QwVIXaLpHXji3k1L
 qjoHys2Zm44S5C/PjSq71aUu7LiZoxbXbtN3kL8IYggDCtJef8WgnUd4cpyy+ZsHGVi8
 YQzr9r3/5Jx5cSplovBd79Cf03zdEVeOQuKidviUl0LXhDHJUpOSEDwa+8Mn5k9fd7PL
 /KIgZkGcEyq8fRqA4lAetU0ICurbtwSybEvz/oFRFOzalRWJQy60T9uxJHgX01j9ibjC
 hm/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmtRUG50IjMybQkvhg7eBkJ2Crwkmdi+BEOE8MmwGS1XM1QMNwL/6XdGYWcK/byvSKAB2/gb3KCtuX@nongnu.org
X-Gm-Message-State: AOJu0YwECvcBE1eElzItqAVm37h+OnCCtMhsrqZhGKhbeHB6bkhpXzLQ
 01BgYL1XqSzvOqSaJzh5rsVScaacspBEigkI2yLmLMal9uPRa16RFwtFd0uRKrzxJLXRkCI41sZ
 XtcNwVd2JtLjNP3+zivt0A+hCbFY=
X-Gm-Gg: ASbGnctNUnC9KRqAclg6t1v7KHs2KQRheIX9c86iFAOzy6rR5ntxfJhpA3RFjIBEyZj
 zjIr4UfNVqgyIByTWslhVY/dG+Mf6uDMoHAeIy4j+yNMz1kfyQhYj3v0ZdNvxCNrUGTOP4TDigb
 VDpmoX9TqB0VoPetXaTGKp/3V3G48k/UXkVR04lXRBEW8NLUxmdUH5
X-Google-Smtp-Source: AGHT+IFU3uZ/RAXEBipifVwz8MQU21Yu5cSaqBhoyIAp7aQPIW+hLaZ4q1akrxGmnocH4XzALs90aBJpCMEydxCX72c=
X-Received: by 2002:a05:6102:80a1:b0:4c1:7c38:135 with SMTP id
 ada2fe7eead31-4d5407dec57mr7803397137.0.1745840072820; Mon, 28 Apr 2025
 04:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
 <20250425160203.2774835-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250425160203.2774835-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Apr 2025 21:34:06 +1000
X-Gm-Features: ATxdqUGGpCuGtr_68OUtXQIgA_JLgVXAzWBj4qYCezrucQwqEEyiRSmDwvcL8SA
Message-ID: <CAKmqyKOPLQ14Mq11PChv1vhWTLAUT6vpDk6jsWCxESDWDBgqcw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] target/riscv/kvm: minor fixes/tweaks
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Sat, Apr 26, 2025 at 2:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Remove an unused 'KVMScratchCPU' pointer argument in
> kvm_riscv_check_sbi_dbcn_support().
>
> Put kvm_riscv_reset_regs_csr() after kvm_riscv_put_regs_csr(). This will
> make a future patch diff easier to read, when changes in
> kvm_riscv_reset_regs_csr() and kvm_riscv_get_regs_csr() will be made.
>
> Fixes: a6b53378f5 ("target/riscv/kvm: implement SBI debug console (DBCN) =
calls")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 9214ce490c..accad4c28e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -613,19 +613,6 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>      return ret;
>  }
>
> -static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
> -{
> -    env->mstatus =3D 0;
> -    env->mie =3D 0;
> -    env->stvec =3D 0;
> -    env->sscratch =3D 0;
> -    env->sepc =3D 0;
> -    env->scause =3D 0;
> -    env->stval =3D 0;
> -    env->mip =3D 0;
> -    env->satp =3D 0;
> -}
> -
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> @@ -660,6 +647,19 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      return 0;
>  }
>
> +static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
> +{
> +    env->mstatus =3D 0;
> +    env->mie =3D 0;
> +    env->stvec =3D 0;
> +    env->sscratch =3D 0;
> +    env->sepc =3D 0;
> +    env->scause =3D 0;
> +    env->stval =3D 0;
> +    env->mip =3D 0;
> +    env->satp =3D 0;
> +}
> +
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
>  {
>      int ret =3D 0;
> @@ -1078,7 +1078,6 @@ static int uint64_cmp(const void *a, const void *b)
>  }
>
>  static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
> -                                             KVMScratchCPU *kvmcpu,
>                                               struct kvm_reg_list *reglis=
t)
>  {
>      struct kvm_reg_list *reg_search;
> @@ -1197,7 +1196,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>          kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
>      }
>
> -    kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
> +    kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
>  }
>
>  static void riscv_init_kvm_registers(Object *cpu_obj)
> --
> 2.49.0
>
>

