Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1119CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 20:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo6Me-0002qe-Pf; Mon, 18 Aug 2025 16:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uo6Ma-0002pt-9B
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 16:21:52 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uo6MX-0003nh-Gz
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 16:21:52 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3e57376f655so36165045ab.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1755548505; x=1756153305; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ba9jcnvxskEkzigBSXAYBxFSAdpkdVz6uZgBM2LEZ+g=;
 b=o7303TsHOGnY9s89g8Cbosclc9ZF1UvNET6PJghfivLIAdSssTYzid0XFzUO/Gd0Qs
 lrDlBbakwn3tMldgybyPyhrIzSyuSi2DJqSAjgQl5Z139PMHEvqTrnBFbC1mnrhGmVJd
 kKqElbyIeey6KGn7CM3LfjIffxtkDtrjLZuYlt0o89pHGhe6ZwUITcMY0aoi/HL/9wDe
 Q+1fKwTi1HNfqoYaDDnJrBXMplCot0srjUBDFHUIb/c2ojwpUFMGM8NZR21qb4Xdiwln
 ZvmarcF17/zxnGwKm1xNc/67l8UCHP/je4/l8uKtGjocPPvN31T7FYRirYHYI2kTTiOS
 GDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755548505; x=1756153305;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ba9jcnvxskEkzigBSXAYBxFSAdpkdVz6uZgBM2LEZ+g=;
 b=CLe8ut/FkfkVNUBk6O2HNwgYbzr/OHuwMENvUQE+OLRmua8Bz0HyjqaC3yj2EdscxC
 OQbQzPpY+NF6KBYaeGyZgthNz67QOJ7QB/lqECkICfMOGzTQ8hl6MZYK8Ee3GMQ5d+aA
 VrFznq34R31Nw1bJhdqufJsCWdl/pskXkSMH3wTShJE2KLU0dKxEt9aJucgG9QByTfak
 OAveLKp1B3ph4JLkBGLWvWNQIly/odorzjT52myaCTip7A07heQZ8Uk713ZX1Y82XzMU
 ih5yOVFxHVv84EWSeT90VUgTQqKSk+v9EiqJYE0wPdHXsfDJe+eZumah6m4m3ei2rcKU
 wnPQ==
X-Gm-Message-State: AOJu0YzfX5A7tqfIePyWP/V35LKVV7QobPeIFPYNrGvoph724EiWOHYU
 Q0inQW8NxqQiE1uYtYo5sLjZeF+KCq7+EhbxVvAZuIOydriwgJuspBPx7pspUwijgiA=
X-Gm-Gg: ASbGncvvyKpZVl8GluYMNJp0eObu2EUYhn4j1qo2w85cWQ8bYPqe6F/sYmdvUNsbT7E
 FBKk+Uw/791GHY1Sq4YZRcEJ8lwtJtiqOKujfw0OfEbFDjiXtVaT4PZFPjXSZYIa28vM8Ie1kYa
 kGnHrob1Sxw6YBa3ReWpzMjcAk4dE7G6Qp1tuoCdkOtSe0d97SL9Sp8QPKulR8FGkX/HjOAS/jq
 1xBvJ5TI2wBLnM9fVnEv5enxnVek/6Y63Nu3eF7mADVpzXXsSk40dzmo3ynHfUs/Eh9cc2hl3EE
 9mPsUE1WbXAXFN4snCemOMNJMpt1+yn7AIQIjoeqSTG5dAr7aYlSmdM/bliFpX2pW87f2M8WoFt
 1Yiqqjl0K03U/eaFx/KtSPjU+
X-Google-Smtp-Source: AGHT+IHveY6ltITd1gZT88JBhvfgxezzhcUPbVnCcv1CNEmc8O+Gfwpx7Ny1o+IwjyV/5JWJrFxoBA==
X-Received: by 2002:a05:6e02:1a09:b0:3e5:5937:e555 with SMTP id
 e9e14a558f8ab-3e6765e7b84mr1768545ab.6.1755548505243; 
 Mon, 18 Aug 2025 13:21:45 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50c94784397sm2790030173.20.2025.08.18.13.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 13:21:44 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:21:43 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?6LCi5rOi?= <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anup@brainfault.org, 
 anup.patel@wdc.com, alistair.francis@wdc.com, palmer@dabbelt.com, 
 zhiwei_liu@linux.alibaba.com, baxiantai@gmail.com, qemu-riscv@nongnu.org, 
 =?utf-8?B?5aSP6bij6L+c?= <xiamy@ultrarisc.com>,
 Radim Krcmar <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v4 for v10.0.0] target/riscv/kvm/kvm-cpu: Fixed the issue
 of resume after QEMU+KVM migration
Message-ID: <20250818-e7e56e26bbf62a23417c2567@orel>
References: <58a08318.d0.196e7eb9068.Coremail.xb@ultrarisc.com>
 <7a1f4eee.1a1.1970b8e1ccb.Coremail.xb@ultrarisc.com>
 <5d1fb28d.7df.197f8d04ed8.Coremail.xb@ultrarisc.com>
 <5cbf1f79.ad3.198650bfbea.Coremail.xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5cbf1f79.ad3.198650bfbea.Coremail.xb@ultrarisc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=ajones@ventanamicro.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Aug 01, 2025 at 05:52:20PM +0800, =E8=B0=A2=E6=B3=A2 wrote:
> This is v4 of this patch to add the function of saving and restoring the =
running status of vCPU during migration
>=20
> This patch fixes two critical bugs in QEMU with KVM:
> Post-Migration Failure in User Mode: When QEMU with KVM is running in use=
r mode, the guest may fail to function correctly after migration.
> Multi-Core Guest Inconsistency: After migration, only the first CPU (core=
 0) remains functional, while all other cores become unresponsive.
> This patch addresses both problems to ensure stable guest operation after=
 migration.
>=20
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  target/riscv/cpu.h           |  1 +
>  target/riscv/kvm/kvm-cpu.c   | 63 ++++++++++++++++++++++++++++++++----
>  target/riscv/kvm/kvm_riscv.h |  3 +-
>  target/riscv/machine.c       |  1 +
>  4 files changed, 61 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 51e49e03dec..1d7ad598faa 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -256,6 +256,7 @@ struct CPUArchState {
>  #endif
> =20
>      target_ulong priv;
> +    uint32_t mp_state;  /*current multiprocessor state of this vCPU*/

This patch has several formatting problems, such as missing spaces between
the '/*' and the text. Also please capitalize first letters of sentences
and use punctuation, such as periods, in comments.

Try running scripts/checkpatch.pl to find formatting issues.

>      /* CSRs for execution environment configuration */
>      uint64_t menvcfg;
>      target_ulong senvcfg;
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 0f4997a9186..c4c7c606a33 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -576,6 +576,15 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
>      }
>      env->pc =3D reg;
> =20
> +    /*Save the guest's privileged state before migration*/

This comment can be dropped since we know the purpose of get-regs.

> +    ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    if(reg !=3D PRV_M) {

Missing space between 'if' and '('. Hopefully checkpatch complains about
stuff like that. Also priv =3D=3D M should never be true for a KVM guest.

> +        env->priv =3D reg;
> +    }
> +
>      for (i =3D 1; i < 32; i++) {
>          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, =
i);
>          ret =3D kvm_get_one_reg(cs, id, &reg);
> @@ -601,6 +610,16 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>          return ret;
>      }
> =20
> +    /*Restore the guest's privileged state after migration*/

This comment can be dropped since we know the purpose of put-regs.

> +    reg =3D env->priv;
> +
> +    if(reg !=3D PRV_M) {

Should never be true.

> +        ret =3D kvm_set_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>      for (i =3D 1; i < 32; i++) {
>          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, =
i);
>          reg =3D env->gpr[i];
> @@ -1244,22 +1263,46 @@ int kvm_arch_get_registers(CPUState *cs, Error **=
errp)
>          return ret;
>      }
> =20
> +    ret =3D kvm_riscv_sync_mpstate_to_qemu(cs);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      return ret;
>  }
> =20
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
> +int kvm_riscv_sync_mpstate_to_kvm(CPUState *cs)
>  {
> +    CPURISCVState *env =3D &RISCV_CPU(cs)->env;

Need a blank line here.

>      if (cap_has_mp_state) {
>          struct kvm_mp_state mp_state =3D {
> -            .mp_state =3D state
> +            .mp_state =3D env->mp_state
>          };
> =20
> -        int ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state=
);
> +        int ret =3D kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);

Put 'int ret' at the top of the function.

> +        if (ret) {
> +            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",

We should add "to KVM" to this error message.

> +                    __func__, ret, strerror(-ret));
> +            return -1;

We should return 'ret' instead of -1. So just change this to

 if (ret) {
     fprintf(...);
 }

 return ret;

> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +int kvm_riscv_sync_mpstate_to_qemu(CPUState *cs)
> +{
> +    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> +    if (cap_has_mp_state) {
> +        struct kvm_mp_state mp_state;
> +
> +        int ret =3D kvm_vcpu_ioctl(cs, KVM_GET_MP_STATE, &mp_state);
>          if (ret) {
>              fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
>                      __func__, ret, strerror(-ret));
>              return -1;
>          }
> +        env->mp_state =3D mp_state.mp_state;
>      }

All the same comments as above for kvm_riscv_sync_mpstate_to_kvm.

> =20
>      return 0;
> @@ -1290,16 +1333,24 @@ int kvm_arch_put_registers(CPUState *cs, int leve=
l, Error **errp)
>      }
> =20
>      if (KVM_PUT_RESET_STATE =3D=3D level) {
> -        RISCVCPU *cpu =3D RISCV_CPU(cs);
> +        CPURISCVState *env =3D &RISCV_CPU(cs)->env;
>          if (cs->cpu_index =3D=3D 0) {
> -            ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNN=
ABLE);
> +            env->mp_state =3D KVM_MP_STATE_RUNNABLE;
> +            ret =3D kvm_riscv_sync_mpstate_to_kvm(cs);
>          } else {
> -            ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOP=
PED);
> +            env->mp_state =3D KVM_MP_STATE_STOPPED;
> +            ret =3D kvm_riscv_sync_mpstate_to_kvm(cs);
>          }
>          if (ret) {
>              return ret;
>          }
>      }
> +    else {

The else should be up after the '}'

> +        ret =3D kvm_riscv_sync_mpstate_to_kvm(cs);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> =20
>      return ret;
>  }
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index b2bcd1041f6..953db941605 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -28,7 +28,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64=
_t group_shift,
>                            uint64_t aplic_base, uint64_t imsic_base,
>                            uint64_t guest_num);
>  void riscv_kvm_aplic_request(void *opaque, int irq, int level);
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
> +int kvm_riscv_sync_mpstate_to_kvm(CPUState *cs);
> +int kvm_riscv_sync_mpstate_to_qemu(CPUState *cs);
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
> =20
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 889e2b65701..22edd2dd744 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -422,6 +422,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UNUSED(4),
>          VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
>          VMSTATE_UINTTL(env.priv, RISCVCPU),
> +        VMSTATE_UINT32(env.mp_state, RISCVCPU),
>          VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
>          VMSTATE_UINT64(env.resetvec, RISCVCPU),
>          VMSTATE_UINTTL(env.mhartid, RISCVCPU),

This requires a vmstate version bump.

None of the stuff below this point should be in the patch.

Thanks,
drew

> --
>=20
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: =E8=B0=A2=E6=B3=A2 <xb@ultrarisc.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2025-07-11 17:28:10 (=E6=98=9F=E6=
=9C=9F=E4=BA=94)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: qemu-devel@nongnu.org
> > =E6=8A=84=E9=80=81: alistair.francis@wdc.com, palmer@dabbelt.com, pbonz=
ini@redhat.com, anup@brainfault.org, anup.patel@wdc.com
> > =E4=B8=BB=E9=A2=98: [PATCH for v10.0.0] target/riscv/kvm/kvm-cpu: Fixed=
 the issue of resume after QEMU+KVM migration
> >=20
> > This is v3 of this patch to fix patch format
> >=20
> > This patch fixes two critical issues in QEMU with KVM:
> > 1. Post-Migration Failure in User Mode: When QEMU with KVM is running i=
n user mode, the guest may fail to function correctly after migration.
> > 2. Multi-Core Guest Inconsistency: After migration, only the first CPU =
(core 0) remains functional, while all other cores become unresponsive.
> >=20
> > Changes include:
> > - Properly restoring guest privileged state during register synchroniza=
tion.
> > - Correctly updating multi-core state after migration to ensure all cor=
es are active.
> >=20
> > Signed-off-by: Xie Bo <xb@ultrarisc.com>
> > ---
> >  target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >=20
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index 75724b6af4..a15caa20ce 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -576,6 +576,14 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
> >      }
> >      env->pc =3D reg;
> >=20
> > +    /*Restore the guest's privileged level after migration*/
> > +    ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +    if(reg !=3D 3) {
> > +        env->priv =3D reg;
> > +    }
> >      for (i =3D 1; i < 32; i++) {
> >          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE=
, i);
> >          ret =3D kvm_get_one_reg(cs, id, &reg);
> > @@ -601,6 +609,15 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
> >          return ret;
> >      }
> >=20
> > +    /*Save guest privilege level before migration*/
> > +    reg =3D env->priv;
> > +    if(reg !=3D 3) {
> > +        ret =3D kvm_set_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +
> >      for (i =3D 1; i < 32; i++) {
> >          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE=
, i);
> >          reg =3D env->gpr[i];
> > @@ -1289,6 +1306,12 @@ int kvm_arch_put_registers(CPUState *cs, int lev=
el, Error **errp)
> >          return ret;
> >      }
> >=20
> > +    /*Ensure all non-core 0 CPUs are runnable after migration*/
> > +    if((level =3D=3D KVM_PUT_FULL_STATE) && (cs->cpu_index !=3D 0)){
> > +        RISCVCPU *cpu =3D RISCV_CPU(cs);
> > +        ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNAB=
LE);
> > +    }
> > +
> >      if (KVM_PUT_RESET_STATE =3D=3D level) {
> >          RISCVCPU *cpu =3D RISCV_CPU(cs);
> >          if (cs->cpu_index =3D=3D 0) {
> > --
> > 2.34.1
> >=20
> >=20
> >=20
> >=20
> > > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > > =E5=8F=91=E4=BB=B6=E4=BA=BA: =E8=B0=A2=E6=B3=A2 <xb@ultrarisc.com>
> > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2025-05-26 15:45:52 (=E6=98=9F=
=E6=9C=9F=E4=B8=80)
> > > =E6=94=B6=E4=BB=B6=E4=BA=BA: qemu-devel@nongnu.org
> > > =E6=8A=84=E9=80=81: alistair.francis@wdc.com, palmer@dabbelt.com, pbo=
nzini@redhat.com, anup@brainfault.org, anup.patel@wdc.com
> > > =E4=B8=BB=E9=A2=98: Re: [PATCH V2] target/riscv/kvm/kvm-cpu: Fixed th=
e issue of resume after QEMU+KVM migration
> > >=20
> > > This is v2 of this patch with no functional changes; adding CC.
> > >=20
> > > ---
> > >  target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >=20
> > > --- a/target/riscv/kvm/kvm-cpu.c
> > > +++ b/target/riscv/kvm/kvm-cpu.c
> > > @@ -576,6 +576,14 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
> > >      }
> > >      env->pc =3D reg;
> > >=20
> > > +    /* Restore guest privilege level after migration */
> > > +    ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +    if (reg !=3D 3) {
> > > +        env->priv =3D reg;
> > > +    }
> > >=20
> > >      for (i =3D 1; i < 32; i++) {
> > >          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CO=
RE, i);
> > >          ret =3D kvm_get_one_reg(cs, id, &reg);
> > > @@ -601,6 +609,15 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
> > >          return ret;
> > >      }
> > >=20
> > > +    /* Save guest privilege level before migration */
> > > +    reg =3D env->priv;
> > > +    if (reg !=3D 3) {
> > > +        ret =3D kvm_set_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> > > +        if (ret) {
> > > +            return ret;
> > > +        }
> > > +    }
> > > +
> > >      for (i =3D 1; i < 32; i++) {
> > >          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CO=
RE, i);
> > >          reg =3D env->gpr[i];
> > > @@ -1289,6 +1306,12 @@ int kvm_arch_put_registers(CPUState *cs, int l=
evel, Error **errp)
> > >          return ret;
> > >      }
> > >=20
> > > +    /* Ensure all non-core 0 CPUs are runnable after migration */
> > > +    if ((level =3D=3D KVM_PUT_FULL_STATE) && (cs->cpu_index !=3D 0))=
 {
> > > +        RISCVCPU *cpu =3D RISCV_CPU(cs);
> > > +        ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNN=
ABLE);
> > > +        if (ret) {
> > > +            return ret;
> > > +        }
> > > +    }
> > >=20
> > >      if (KVM_PUT_RESET_STATE =3D=3D level) {
> > >          RISCVCPU *cpu =3D RISCV_CPU(cs);
> > >          if (cs->cpu_index =3D=3D 0) {
> > > --=20
> > > 2.34.1
> > >=20
> > >=20
> > >=20
> > >=20
> > > > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: =E8=B0=A2=E6=B3=A2 <xb@ultrarisc.com>
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2025-05-19 17:41:36 (=E6=98=9F=
=E6=9C=9F=E4=B8=80)
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: qemu-devel@nongnu.org
> > > > =E6=8A=84=E9=80=81: alistair.francis@wdc.com, palmer@dabbelt.com, p=
bonzini@redhat.com
> > > > =E4=B8=BB=E9=A2=98: [PATCH] target/riscv/kvm/kvm-cpu: Fixed the iss=
ue of resume after QEMU+KVM migration
> > > >=20
> > > > This patch fixes two critical issues in QEMU with KVM:
> > > >=20
> > > > 1. Post-Migration Failure in User Mode: When QEMU with KVM is runni=
ng in user mode, the guest may fail to function correctly after migration d=
ue to incorrect privilege state restoration.
> > > >=20
> > > > 2. Multi-Core Guest Inconsistency: After migration, only the first =
CPU (core 0) remains functional, while all other cores become unresponsive.=
 This patch ensures all cores are properly set to runnable state after migr=
ation.
> > > >=20
> > > > Changes include:
> > > > - Properly restoring guest privileged state during register synchro=
nization.
> > > > - Correctly updating multi-core state after migration to ensure all=
 cores are active.
> > > >=20
> > > > Signed-off-by: Xie Bo <xb@ultrarisc.com>
> > > >=20
> > > > ---
> > > >  target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >=20
> > > > --- a/target/riscv/kvm/kvm-cpu.c
> > > > +++ b/target/riscv/kvm/kvm-cpu.c
> > > > @@ -576,6 +576,14 @@ static int kvm_riscv_get_regs_core(CPUState *c=
s)
> > > >      }
> > > >      env->pc =3D reg;
> > > >=20
> > > > +    /* Restore guest privilege level after migration */
> > > > +    ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> > > > +    if (ret) {
> > > > +        return ret;
> > > > +    }
> > > > +    if (reg !=3D 3) {
> > > > +        env->priv =3D reg;
> > > > +    }
> > > >=20
> > > >      for (i =3D 1; i < 32; i++) {
> > > >          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_=
CORE, i);
> > > >          ret =3D kvm_get_one_reg(cs, id, &reg);
> > > > @@ -601,6 +609,15 @@ static int kvm_riscv_put_regs_core(CPUState *c=
s)
> > > >          return ret;
> > > >      }
> > > >=20
> > > > +    /* Save guest privilege level before migration */
> > > > +    reg =3D env->priv;
> > > > +    if (reg !=3D 3) {
> > > > +        ret =3D kvm_set_one_reg(cs, RISCV_CORE_REG(env, mode), &re=
g);
> > > > +        if (ret) {
> > > > +            return ret;
> > > > +        }
> > > > +    }
> > > > +
> > > >      for (i =3D 1; i < 32; i++) {
> > > >          uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_=
CORE, i);
> > > >          reg =3D env->gpr[i];
> > > > @@ -1289,6 +1306,12 @@ int kvm_arch_put_registers(CPUState *cs, int=
 level, Error **errp)
> > > >          return ret;
> > > >      }
> > > >=20
> > > > +    /* Ensure all non-core 0 CPUs are runnable after migration */
> > > > +    if ((level =3D=3D KVM_PUT_FULL_STATE) && (cs->cpu_index !=3D 0=
)) {
> > > > +        RISCVCPU *cpu =3D RISCV_CPU(cs);
> > > > +        ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RU=
NNABLE);
> > > > +        if (ret) {
> > > > +            return ret;
> > > > +        }
> > > > +    }
> > > >=20
> > > >      if (KVM_PUT_RESET_STATE =3D=3D level) {
> > > >          RISCVCPU *cpu =3D RISCV_CPU(cs);
> > > >          if (cs->cpu_index =3D=3D 0) {
> > > > --=20
> > > > 2.34.1
> > > >=20
> > > > ______________________www.ultrarisc.com
> > > > =E9=87=8D=E8=A6=81=E6=8F=90=E7=A4=BA=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=
=BB=B6=E5=8C=85=E6=8B=AC=E9=99=84=E4=BB=B6=E7=9A=84=E5=86=85=E5=AE=B9=E6=98=
=AF=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E6=8A=A4=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E6=98=AF=E6=
=8C=87=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E7=AB=8B=E5=8D=
=B3=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=88=A0=E9=99=A4=EF=BC=8C=E6=B3=95=
=E5=BE=8B=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E9=9D=9E=E6=B3=95=E7=9A=84=E6=
=8A=AB=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E4=BC=A0=E6=92=AD=E6=88=
=96=E4=BB=A5=E4=BB=BB=E4=BD=95=E6=96=B9=E5=BC=8F=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E3=80=82=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E5=8C=85=E5=
=90=AB=E7=9A=84=E6=84=8F=E8=A7=81=E3=80=81=E5=BB=BA=E8=AE=AE=E6=98=AF=E5=9F=
=BA=E4=BA=8E=E6=88=96=E5=8F=97=E5=88=B0=E6=88=91=E6=96=B9=E8=A1=A8=E8=BE=BE=
=E5=92=8C=E5=AE=9A=E4=B9=89=E7=9A=84=E6=9D=A1=E6=AC=BE=E5=8F=8A=E6=9D=A1=E4=
=BB=B6=E7=9A=84=E9=99=90=E5=AE=9A=EF=BC=8C=E5=A6=82=E6=97=A0=E6=88=91=E6=96=
=B9=E7=9A=84=E6=AD=A3=E5=BC=8F=E4=B9=A6=E9=9D=A2=E6=BE=84=E6=B8=85=E6=88=96=
=E6=8E=88=E6=9D=83=EF=BC=8C=E4=B8=8D=E5=8F=AF=E8=A2=AB=E5=8D=95=E7=8B=AC=E4=
=BD=9C=E4=B8=BA=E4=BB=BB=E4=BD=95=E6=83=85=E5=BD=A2=E4=B8=8B=E7=9A=84=E8=AF=
=81=E6=8D=AE=E6=88=96=E4=BE=9D=E6=8D=AE=E3=80=82=E6=84=9F=E8=B0=A2=E6=82=A8=
=E7=9A=84=E7=90=86=E8=A7=A3=E4=B8=8E=E9=85=8D=E5=90=88=E3=80=82=E7=89=88=E6=
=9D=83=E6=89=80=E6=9C=89=E3=80=82IMPORTANT NOTICE: This email, including it=
s attachment if any, is confidential. If you are not the intended recipient=
, please delete it from your computer immediately. Any disclosure, copying,=
 or distribution of this message, or taking of any action based on it is st=
rictly prohibited.  Any opinions and suggestions contained in this email ar=
e subject to the terms and conditions expressed and defined by us and shoul=
d not be relied upon unconditionally under any circumstances unless they ar=
e confirmed in official written clarification or authorization from us.  Th=
ank you for your understanding and cooperation.All rights reserved.
> > >=20
> > >=20
> > > ______________________www.ultrarisc.com
> > > =E9=87=8D=E8=A6=81=E6=8F=90=E7=A4=BA=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=
=B6=E5=8C=85=E6=8B=AC=E9=99=84=E4=BB=B6=E7=9A=84=E5=86=85=E5=AE=B9=E6=98=AF=
=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E6=8A=A4=E7=9A=84=E4=BF=9D=E5=AF=86=E4=
=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E6=98=AF=E6=8C=
=87=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=88=A0=E9=99=A4=EF=BC=8C=E6=B3=95=E5=
=BE=8B=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E9=9D=9E=E6=B3=95=E7=9A=84=E6=8A=
=AB=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E4=BC=A0=E6=92=AD=E6=88=96=
=E4=BB=A5=E4=BB=BB=E4=BD=95=E6=96=B9=E5=BC=8F=E4=BD=BF=E7=94=A8=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E3=80=82=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E5=8C=85=E5=90=
=AB=E7=9A=84=E6=84=8F=E8=A7=81=E3=80=81=E5=BB=BA=E8=AE=AE=E6=98=AF=E5=9F=BA=
=E4=BA=8E=E6=88=96=E5=8F=97=E5=88=B0=E6=88=91=E6=96=B9=E8=A1=A8=E8=BE=BE=E5=
=92=8C=E5=AE=9A=E4=B9=89=E7=9A=84=E6=9D=A1=E6=AC=BE=E5=8F=8A=E6=9D=A1=E4=BB=
=B6=E7=9A=84=E9=99=90=E5=AE=9A=EF=BC=8C=E5=A6=82=E6=97=A0=E6=88=91=E6=96=B9=
=E7=9A=84=E6=AD=A3=E5=BC=8F=E4=B9=A6=E9=9D=A2=E6=BE=84=E6=B8=85=E6=88=96=E6=
=8E=88=E6=9D=83=EF=BC=8C=E4=B8=8D=E5=8F=AF=E8=A2=AB=E5=8D=95=E7=8B=AC=E4=BD=
=9C=E4=B8=BA=E4=BB=BB=E4=BD=95=E6=83=85=E5=BD=A2=E4=B8=8B=E7=9A=84=E8=AF=81=
=E6=8D=AE=E6=88=96=E4=BE=9D=E6=8D=AE=E3=80=82=E6=84=9F=E8=B0=A2=E6=82=A8=E7=
=9A=84=E7=90=86=E8=A7=A3=E4=B8=8E=E9=85=8D=E5=90=88=E3=80=82=E7=89=88=E6=9D=
=83=E6=89=80=E6=9C=89=E3=80=82IMPORTANT NOTICE: This email, including its a=
ttachment if any, is confidential. If you are not the intended recipient, p=
lease delete it from your computer immediately. Any disclosure, copying, or=
 distribution of this message, or taking of any action based on it is stric=
tly prohibited.  Any opinions and suggestions contained in this email are s=
ubject to the terms and conditions expressed and defined by us and should n=
ot be relied upon unconditionally under any circumstances unless they are c=
onfirmed in official written clarification or authorization from us.  Thank=
 you for your understanding and cooperation.All rights reserved.
> >=20
> >=20
> > ______________________www.ultrarisc.com
> > =E9=87=8D=E8=A6=81=E6=8F=90=E7=A4=BA=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=
=B6=E5=8C=85=E6=8B=AC=E9=99=84=E4=BB=B6=E7=9A=84=E5=86=85=E5=AE=B9=E6=98=AF=
=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E6=8A=A4=E7=9A=84=E4=BF=9D=E5=AF=86=E4=
=BF=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E6=98=AF=E6=8C=
=87=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=88=A0=E9=99=A4=EF=BC=8C=E6=B3=95=E5=
=BE=8B=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E9=9D=9E=E6=B3=95=E7=9A=84=E6=8A=
=AB=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E4=BC=A0=E6=92=AD=E6=88=96=
=E4=BB=A5=E4=BB=BB=E4=BD=95=E6=96=B9=E5=BC=8F=E4=BD=BF=E7=94=A8=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E3=80=82=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E5=8C=85=E5=90=
=AB=E7=9A=84=E6=84=8F=E8=A7=81=E3=80=81=E5=BB=BA=E8=AE=AE=E6=98=AF=E5=9F=BA=
=E4=BA=8E=E6=88=96=E5=8F=97=E5=88=B0=E6=88=91=E6=96=B9=E8=A1=A8=E8=BE=BE=E5=
=92=8C=E5=AE=9A=E4=B9=89=E7=9A=84=E6=9D=A1=E6=AC=BE=E5=8F=8A=E6=9D=A1=E4=BB=
=B6=E7=9A=84=E9=99=90=E5=AE=9A=EF=BC=8C=E5=A6=82=E6=97=A0=E6=88=91=E6=96=B9=
=E7=9A=84=E6=AD=A3=E5=BC=8F=E4=B9=A6=E9=9D=A2=E6=BE=84=E6=B8=85=E6=88=96=E6=
=8E=88=E6=9D=83=EF=BC=8C=E4=B8=8D=E5=8F=AF=E8=A2=AB=E5=8D=95=E7=8B=AC=E4=BD=
=9C=E4=B8=BA=E4=BB=BB=E4=BD=95=E6=83=85=E5=BD=A2=E4=B8=8B=E7=9A=84=E8=AF=81=
=E6=8D=AE=E6=88=96=E4=BE=9D=E6=8D=AE=E3=80=82=E6=84=9F=E8=B0=A2=E6=82=A8=E7=
=9A=84=E7=90=86=E8=A7=A3=E4=B8=8E=E9=85=8D=E5=90=88=E3=80=82=E7=89=88=E6=9D=
=83=E6=89=80=E6=9C=89=E3=80=82IMPORTANT NOTICE: This email, including its a=
ttachment if any, is confidential. If you are not the intended recipient, p=
lease delete it from your computer immediately. Any disclosure, copying, or=
 distribution of this message, or taking of any action based on it is stric=
tly prohibited.  Any opinions and suggestions contained in this email are s=
ubject to the terms and conditions expressed and defined by us and should n=
ot be relied upon unconditionally under any circumstances unless they are c=
onfirmed in official written clarification or authorization from us.  Thank=
 you for your understanding and cooperation.All rights reserved.
>=20
>=20
> ______________________www.ultrarisc.com
> =E9=87=8D=E8=A6=81=E6=8F=90=E7=A4=BA=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=
=E5=8C=85=E6=8B=AC=E9=99=84=E4=BB=B6=E7=9A=84=E5=86=85=E5=AE=B9=E6=98=AF=E5=
=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E6=8A=A4=E7=9A=84=E4=BF=9D=E5=AF=86=E4=BF=
=A1=E6=81=AF=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E6=98=AF=E6=8C=87=
=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E7=AB=8B=E5=8D=B3=E5=
=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=88=A0=E9=99=A4=EF=BC=8C=E6=B3=95=E5=BE=
=8B=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E9=9D=9E=E6=B3=95=E7=9A=84=E6=8A=AB=
=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E4=BC=A0=E6=92=AD=E6=88=96=E4=
=BB=A5=E4=BB=BB=E4=BD=95=E6=96=B9=E5=BC=8F=E4=BD=BF=E7=94=A8=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E3=80=82=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E5=8C=85=E5=90=AB=
=E7=9A=84=E6=84=8F=E8=A7=81=E3=80=81=E5=BB=BA=E8=AE=AE=E6=98=AF=E5=9F=BA=E4=
=BA=8E=E6=88=96=E5=8F=97=E5=88=B0=E6=88=91=E6=96=B9=E8=A1=A8=E8=BE=BE=E5=92=
=8C=E5=AE=9A=E4=B9=89=E7=9A=84=E6=9D=A1=E6=AC=BE=E5=8F=8A=E6=9D=A1=E4=BB=B6=
=E7=9A=84=E9=99=90=E5=AE=9A=EF=BC=8C=E5=A6=82=E6=97=A0=E6=88=91=E6=96=B9=E7=
=9A=84=E6=AD=A3=E5=BC=8F=E4=B9=A6=E9=9D=A2=E6=BE=84=E6=B8=85=E6=88=96=E6=8E=
=88=E6=9D=83=EF=BC=8C=E4=B8=8D=E5=8F=AF=E8=A2=AB=E5=8D=95=E7=8B=AC=E4=BD=9C=
=E4=B8=BA=E4=BB=BB=E4=BD=95=E6=83=85=E5=BD=A2=E4=B8=8B=E7=9A=84=E8=AF=81=E6=
=8D=AE=E6=88=96=E4=BE=9D=E6=8D=AE=E3=80=82=E6=84=9F=E8=B0=A2=E6=82=A8=E7=9A=
=84=E7=90=86=E8=A7=A3=E4=B8=8E=E9=85=8D=E5=90=88=E3=80=82=E7=89=88=E6=9D=83=
=E6=89=80=E6=9C=89=E3=80=82IMPORTANT NOTICE: This email, including its atta=
chment if any, is confidential. If you are not the intended recipient, plea=
se delete it from your computer immediately. Any disclosure, copying, or di=
stribution of this message, or taking of any action based on it is strictly=
 prohibited.  Any opinions and suggestions contained in this email are subj=
ect to the terms and conditions expressed and defined by us and should not =
be relied upon unconditionally under any circumstances unless they are conf=
irmed in official written clarification or authorization from us.  Thank yo=
u for your understanding and cooperation.All rights reserved.

