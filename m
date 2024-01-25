Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E43C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqLr-0001Kp-PR; Wed, 24 Jan 2024 22:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqLp-0001A0-Kz; Wed, 24 Jan 2024 22:24:25 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqLk-0000gh-SI; Wed, 24 Jan 2024 22:24:25 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7833b6bb41bso522278885a.3; 
 Wed, 24 Jan 2024 19:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706153059; x=1706757859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NooOZ4nOLFTRQ22i2e1umk5KF3O7mXY614vSWu1T2tY=;
 b=OxatFpDfKhjfQa2T1YabrNWHKv5O4nPGPSJX9kjvm8yfn1oOiEGYytE799VasaBqgf
 QK8NI46dktu2DqfA1Guj4iWi+ySqDUPhLYhYLF8gJgaFC4imFIUvWAt5rInTNkdwosWE
 gAUnAbeNTeFOs7/bD20VdjgPMoPUxZ5LLtki8qcc4FzgPoefgIMug/qYL7mUQ8HrEL5q
 2yhx8o9qmnc+wfRnQ1CSmxxD3rWSUWtvy02TOef5HNi1Ny/tHHqzePWvQvRAx5QN0f4G
 DKGILnzM/lDcXmi9ePrLiulL7RCnZHK7mjSzA9Cc333LRawpvoZ+W6w17LTlvGcCSDOm
 KXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706153059; x=1706757859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NooOZ4nOLFTRQ22i2e1umk5KF3O7mXY614vSWu1T2tY=;
 b=hWJ+0h6W+MfV+BuyIvIOWIKe8NTqODAZWiprBJjsN6P8F4kbgBmArLBFeMiwu707qe
 pvd+9a87wTk8pR0/dCEP7QUBhPhksjKpykAO+B7JYwHJXYk6MfY0fi0ni/znrOyXWMwe
 r0/ojkpzpp6+xhmqqDcd1TRcf1roaKGGYzgm9XtYZ0ZdC8vvC4AnoNdHaLXjSzGrvTA9
 6muup+pe+VfICaobPfGUjtrM8Q9H0TQ2EvlFHtuImD4BpsXKEPrnz07D3vfHgKRCAj55
 V8jOqZuAtBP4aOnbpnpiNKn1HWPYUxp4tJa2//ktqXo+49uI/iuHXjQuSL+HPaVNksFP
 RlVQ==
X-Gm-Message-State: AOJu0YzlBD/npZX4xfPr3VVdfHrqZSIKGh/p1NwUJPWZg2KFCLUl0rzU
 ld1PpJ278fVdnz8ycypd2TNNiy8f0+4tie8ncoGCOrd4uonOu7KIi9pRHwh+MCbI6KGRbq/uOTq
 xJmkCfWoTccar4WJ3OnxDi5XCzA8=
X-Google-Smtp-Source: AGHT+IHu4ObJraP24b5Db/J35jm9KCFmNQ1Y8lPrrVGjDaDTDlHbXTALDqo4Lht8+iHzdTYOjY4oNFy+Ew7jzyln528=
X-Received: by 2002:a05:620a:51cc:b0:783:bcdc:e2d1 with SMTP id
 cx12-20020a05620a51cc00b00783bcdce2d1mr370655qkb.70.1706153058706; Wed, 24
 Jan 2024 19:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20240123161714.160149-1-dbarboza@ventanamicro.com>
 <20240123161714.160149-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240123161714.160149-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jan 2024 13:23:52 +1000
Message-ID: <CAKmqyKMhQtTyutd2WRA8jM0wqPo+4W6DwB5GSOTxqywZx6vJOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv/kvm: initialize 'vlenb' via get-reg-list
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x736.google.com
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
> KVM will check for the correct 'reg_size' when accessing the vector
> registers, erroring with EINVAL if we encode the wrong size in reg ID.
> Vector registers varies in size with the vector length in bytes, or
> 'vlenb'. This means that we need the current 'vlenb' being used by the
> host, otherwise we won't be able to fetch all vector regs.
>
> We'll deal with 'vlenb' first. Its support was added in Linux 6.8 as a
> get-reg-list register. We'll read 'vlenb' via get-reg-list and mark the
> register as 'supported'. All 'vlenb' ops via kvm_arch_get_registers()
> and kvm_arch_put_registers() will only be done if the reg is supported,
> i.e. we fetched it in get-reg-list during init.
>
> If the user sets a new vlenb value using the 'vlen' property, throw an
> error if the user value differs from the host.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 85 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 902180e8a5..3812481971 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -352,6 +352,13 @@ static KVMCPUConfig kvm_cboz_blocksize =3D {
>      .kvm_reg_id =3D KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
>  };
>
> +static KVMCPUConfig kvm_v_vlenb =3D {
> +    .name =3D "vlenb",
> +    .offset =3D CPU_CFG_OFFSET(vlenb),
> +    .kvm_reg_id =3D  KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_VE=
CTOR |
> +                   KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)
> +};
> +
>  static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs=
)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -684,7 +691,8 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>
>  static int kvm_riscv_get_regs_vector(CPUState *cs)
>  {
> -    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    CPURISCVState *env =3D &cpu->env;
>      target_ulong reg;
>      int ret =3D 0;
>
> @@ -710,12 +718,21 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
>      }
>      env->vtype =3D reg;
>
> +    if (kvm_v_vlenb.supported) {
> +        ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &r=
eg);
> +        if (ret) {
> +            return ret;
> +        }
> +        cpu->cfg.vlenb =3D reg;
> +    }
> +
>      return 0;
>  }
>
>  static int kvm_riscv_put_regs_vector(CPUState *cs)
>  {
> -    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    CPURISCVState *env =3D &cpu->env;
>      target_ulong reg;
>      int ret =3D 0;
>
> @@ -737,6 +754,14 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
>
>      reg =3D env->vtype;
>      ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (kvm_v_vlenb.supported) {
> +        reg =3D cpu->cfg.vlenb;
> +        ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &r=
eg);
> +    }
>
>      return ret;
>  }
> @@ -921,6 +946,33 @@ static int uint64_cmp(const void *a, const void *b)
>      return 0;
>  }
>
> +static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
> +                                 struct kvm_reg_list *reglist)
> +{
> +    struct kvm_one_reg reg;
> +    struct kvm_reg_list *reg_search;
> +    uint64_t val;
> +    int ret;
> +
> +    reg_search =3D bsearch(&kvm_v_vlenb.kvm_reg_id, reglist->reg, reglis=
t->n,
> +                         sizeof(uint64_t), uint64_cmp);
> +
> +    if (reg_search) {
> +        reg.id =3D kvm_v_vlenb.kvm_reg_id;
> +        reg.addr =3D (uint64_t)&val;
> +
> +        ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +        if (ret !=3D 0) {
> +            error_report("Unable to read vlenb register, error code: %s"=
,
> +                         strerrorname_np(errno));
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        kvm_v_vlenb.supported =3D true;
> +        cpu->cfg.vlenb =3D val;
> +    }
> +}
> +
>  static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kv=
mcpu)
>  {
>      KVMCPUConfig *multi_ext_cfg;
> @@ -995,6 +1047,10 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>      if (cpu->cfg.ext_zicboz) {
>          kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
>      }
> +
> +    if (riscv_has_ext(&cpu->env, RVV)) {
> +        kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
> +    }
>  }
>
>  static void riscv_init_kvm_registers(Object *cpu_obj)
> @@ -1566,7 +1622,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>      int ret;
>
>      /* short-circuit without spinning the scratch CPU */
> -    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz) {
> +    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz &&
> +        !riscv_has_ext(env, RVV)) {
>          return;
>      }
>
> @@ -1613,6 +1670,28 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu=
, Error **errp)
>          }
>      }
>
> +    /* Users are setting vlen, not vlenb */
> +    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
> +        if (!kvm_v_vlenb.supported) {
> +            error_setg(errp, "Unable to set 'vlenb': register not suppor=
ted");
> +            return;
> +        }
> +
> +        reg.id =3D kvm_v_vlenb.kvm_reg_id;
> +        reg.addr =3D (uint64_t)&val;
> +        ret =3D ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
> +        if (ret !=3D 0) {
> +            error_setg(errp, "Unable to read vlenb register, error %d", =
errno);
> +            return;
> +        }
> +
> +        if (cpu->cfg.vlenb !=3D val) {
> +            error_setg(errp, "Unable to set 'vlen' to a different "
> +                       "value than the host (%lu)", val * 8);
> +            return;
> +        }
> +    }
> +
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
>
> --
> 2.43.0
>
>

