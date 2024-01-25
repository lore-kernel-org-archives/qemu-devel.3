Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387EBC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqQN-0004LB-CF; Wed, 24 Jan 2024 22:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqQK-0004Ih-Dq; Wed, 24 Jan 2024 22:29:04 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqQI-0001Kv-Oa; Wed, 24 Jan 2024 22:29:04 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5988e55ede0so2843035eaf.2; 
 Wed, 24 Jan 2024 19:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706153341; x=1706758141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3Ds87bzyhgOp6Yrd8tdiPZFrU7fBkowlbUAt5Jq324=;
 b=OBUigplPjGskJ0whNtsIhv7yr9voKZ+by0UkEx/3RrEeDY9Fn1jSXr4jhavWsKvKo7
 t1h+vpQfk72b1y5RyNvvrWTZKtUXKPare2rQcBGigKEE905/iOpLHyM1DsGf77oypn7r
 tp+ic/KtOxaq85JQZ4GQxFF/T93KePNnLPpHKZqTxcxgj0hJuHTle9eX2ULHZOfRwGWl
 1o5rngSQaMmWcAj8jFqnIb6/6YK0+krOxbCdsTKYbU+3FNZvwFC3iTxD2yk18gOPtShQ
 Uz0RPetgVnKKpUrnQ50+OZKsaVvMszAQZZt8CHsJqi4hisZ4lK4fkidoRxxkaJFQAWQ7
 7c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706153341; x=1706758141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3Ds87bzyhgOp6Yrd8tdiPZFrU7fBkowlbUAt5Jq324=;
 b=hqWShhnfvAn+DAJsBBCXkjhXLgZJV3YDwYfPLJIgU/3FYebLryGT0JeLlyBHS03qw6
 /dCVcdS/vz2g4yZvR+yLD6/su2e0jjDUTLFhMsJqcRpPsEhEyBBI320qO54c9JJldCcE
 Wb+sipht0OWUDGC0UxRpKv9tIVRqBqNUcGswzyZqEZFyWVJP+A0ZW6N5Ewp/Qhz9AUtX
 Sx/qBUCGdX4rfC8Cwnf/G96HJjIsWBabyUphloQ21BvVQTGVHsKs2ilxVtDMMpdG1QKI
 nbRVkAN+YCdjhE/1LEt2cKNG3eqevzx92DjujK+eI8AnUy/Z4IeCZuvkB3YXsvB1gJXb
 wdDg==
X-Gm-Message-State: AOJu0Yw2xpolz3BxYj9jNN61EVRXWUlHG+I4tExCXH4GqHNXgCnH40Dh
 uveNO46SDFcedKJKRin0tdELxrm7fh4f6OyZurJhNnddyFXfs3NzRL9b26ToVqdZ+MsXEeJ2jNh
 air1RFUnZ1JYsof3KExpWCV+jpQo=
X-Google-Smtp-Source: AGHT+IGLP1P4ytINv/zEzag+ieW8lZ5KL3Gn5ZbWcIk/lXJJTXZL8Wnr2l8xYj9GsnDr+FnOhKwvhR7aIgIjHxPhGkU=
X-Received: by 2002:a05:6358:9999:b0:176:6144:df9f with SMTP id
 j25-20020a056358999900b001766144df9fmr434209rwb.28.1706153340883; Wed, 24 Jan
 2024 19:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20240123161714.160149-1-dbarboza@ventanamicro.com>
 <20240123161714.160149-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240123161714.160149-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jan 2024 13:28:34 +1000
Message-ID: <CAKmqyKOPUCs5dNhi4192qWEcd_J96WDJzc911DACUbUVtoHEWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/riscv/kvm: get/set vector vregs[]
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2b.google.com
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

On Wed, Jan 24, 2024 at 2:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> vregs[] have variable size that depends on the current vlenb set by the
> host, meaning we can't use our regular kvm_riscv_reg_id() to retrieve
> it.
>
> Create a generic kvm_encode_reg_size_id() helper to encode any given
> size in bytes into a given kvm reg id. kvm_riscv_vector_reg_id() will
> use it to encode vlenb into a given vreg ID.
>
> kvm_riscv_(get|set)_vector() can then get/set all 32 vregs.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 57 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 3812481971..a7881de7f9 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -86,6 +86,27 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, ui=
nt64_t idx)
>      return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
>  }
>
> +static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
> +{
> +    uint64_t size_ctz =3D __builtin_ctz(size_b);
> +
> +    return id | (size_ctz << KVM_REG_SIZE_SHIFT);
> +}
> +
> +static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
> +                                        uint64_t idx)
> +{
> +    uint64_t id;
> +    size_t size_b;
> +
> +    g_assert(idx < 32);
> +
> +    id =3D KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_R=
EG(idx);
> +    size_b =3D cpu->cfg.vlenb;
> +
> +    return kvm_encode_reg_size_id(id, size_b);
> +}
> +
>  #define RISCV_CORE_REG(env, name) \
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
>                             KVM_REG_RISCV_CORE_REG(name))
> @@ -694,7 +715,8 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
>      target_ulong reg;
> -    int ret =3D 0;
> +    uint64_t vreg_id;
> +    int vreg_idx, ret =3D 0;
>
>      if (!riscv_has_ext(env, RVV)) {
>          return 0;
> @@ -724,6 +746,21 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
>              return ret;
>          }
>          cpu->cfg.vlenb =3D reg;
> +
> +        for (int i =3D 0; i < 32; i++) {
> +            /*
> +             * vreg[] is statically allocated using RV_VLEN_MAX.
> +             * Use it instead of vlenb to calculate vreg_idx for
> +             * simplicity.
> +             */
> +            vreg_idx =3D i * RV_VLEN_MAX / 64;
> +            vreg_id =3D kvm_riscv_vector_reg_id(cpu, i);
> +
> +            ret =3D kvm_get_one_reg(cs, vreg_id, &env->vreg[vreg_idx]);
> +            if (ret) {
> +                return ret;
> +            }
> +        }
>      }
>
>      return 0;
> @@ -734,7 +771,8 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
>      target_ulong reg;
> -    int ret =3D 0;
> +    uint64_t vreg_id;
> +    int vreg_idx, ret =3D 0;
>
>      if (!riscv_has_ext(env, RVV)) {
>          return 0;
> @@ -761,6 +799,21 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
>      if (kvm_v_vlenb.supported) {
>          reg =3D cpu->cfg.vlenb;
>          ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &r=
eg);
> +
> +        for (int i =3D 0; i < 32; i++) {
> +            /*
> +             * vreg[] is statically allocated using RV_VLEN_MAX.
> +             * Use it instead of vlenb to calculate vreg_idx for
> +             * simplicity.
> +             */
> +            vreg_idx =3D i * RV_VLEN_MAX / 64;
> +            vreg_id =3D kvm_riscv_vector_reg_id(cpu, i);
> +
> +            ret =3D kvm_set_one_reg(cs, vreg_id, &env->vreg[vreg_idx]);
> +            if (ret) {
> +                return ret;
> +            }
> +        }
>      }
>
>      return ret;
> --
> 2.43.0
>
>

