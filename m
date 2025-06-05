Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85282C5B549
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 03:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN1W2-0006lF-Sw; Wed, 04 Jun 2025 23:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN1W0-0006ky-5T; Wed, 04 Jun 2025 23:43:40 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN1Vx-0007uY-BD; Wed, 04 Jun 2025 23:43:39 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86f9c719d63so175610241.1; 
 Wed, 04 Jun 2025 20:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749095016; x=1749699816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfOWnqwSN+UytlPsXk5StsmaMt+ZIAO8qMxZqjRHflw=;
 b=W5z9l70xS3jiSwhnt5hwnuA898ysFlFEwvoD3DufLPTAguAuSR62QauahsOxEJSMKq
 RsSW7C+2trjEB4tjSDuoPDqutFXkZ/p7UG9Ec7VhIYczHd7iV557BHcsILvRwYx1Kw6B
 oL2rC9yakNAmz9qA0cwZ3OJYkCL3iOVoCy5i+VNFZXeU99UgbFCzJ/I22zEyQ8drLWuv
 4J0RyovLqt7YcUIgHKebdcR+0nJ0/dfVcBH6kJdGP5EzBMx+yNqjPXjuFhwYBgI/+02T
 gFLV035yROt5zVu9WripD5crIdrsAYESoZ4O8JwxKTmQ71Pq0ayycaPXqYR2o6nuOwsn
 ZC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749095016; x=1749699816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfOWnqwSN+UytlPsXk5StsmaMt+ZIAO8qMxZqjRHflw=;
 b=AKkjlVZDXVdovri0QsL8bLxqzdEyN+WoER92cVI0MvmzIa1WXJSF98/VL046Y4CM2w
 wtbZr3NHhZRqPZ1uPOZSxXh/UqseFI894gmpZ8bTZ7EzJy73PxBpQyY8RervgwnrF/1m
 5sRNH0HH1u/uKiIoY4OxOjMharLUAFnX74AZopwnXD6ETrOWnhg6m0SCDi3DgBWMITPD
 mPQ9TQmbsahTeqUQ5tsTyFwCtMrTtza+TPtrOcGYPosK/s04dbTHk2iBve53oLy7L77M
 wNT+pEMARR3UzMatARQHcTsgHzVOicU2r81Qugs/QlEfdvnxAMZsctleWyRgfbTeVbdH
 aQXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPla5DFTRIO1yB0GxY/5y8iuUO67XwBY4fVeydAZesufas5k4qJSDOXFxppRNSMo0xTnwCXgnMVbbF@nongnu.org
X-Gm-Message-State: AOJu0Yy6D222Q2zxCXjxShyBQ61G1UZNmnVXc93Qt7geWhjcYor5z3QZ
 0e1KuMejHRskNwIudeSHnhf6M7s7FeOvy8o8wkDqfoY+ek9IG9msM+WBCZpUILFXlL4A/J/Vxsh
 SyEiboD/REbjy+jb9u1mdmqxqrm0rdGQ=
X-Gm-Gg: ASbGncv8pLrwkQ4R6ef/PjV+ZRR6cg9M0RLUBTpuLYqzqn78Oyn1vXjOh2tEoqltqi9
 GEMc4S5oN6GOPACBMTBnaF9gGOtBI16AELirAKRwypvM/fA9v2SFos7ZqnGbkETqdKZNABgyB5E
 bMXWk9UhKTv4Ppd1SMIhhZCkJwsw+BesCkREBBU/BlSmPBb93/xmjBuHUSo4sKJUo=
X-Google-Smtp-Source: AGHT+IEQXyZxOx6zco0BPqi/OU8Ql2HtNAhcD633mmLX0qDJctjePopt+0F8C8PkWcVKQg/Yx3dP3lHrWsxODbmfO2M=
X-Received: by 2002:a05:6102:5091:b0:4e5:a567:8e57 with SMTP id
 ada2fe7eead31-4e746e4fef3mr4611575137.24.1749095015186; Wed, 04 Jun 2025
 20:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
 <20250604173800.1147364-5-dbarboza@ventanamicro.com>
In-Reply-To: <20250604173800.1147364-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Jun 2025 13:43:09 +1000
X-Gm-Features: AX0GCFuTMSzoe0FV88Z_K09GAMd-xjDYcY6alxitf2wzv2foDReFI1c6UQmi-wQ
Message-ID: <CAKmqyKPKE9O-fSWxbxC_hFEU4gBVROL7g9RmtBHGUm7dSJjhgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/riscv/tcg: decouple profile enablement from
 user prop
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Thu, Jun 5, 2025 at 3:40=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We have code in riscv_cpu_add_profiles() to enable a profile right away
> in case a CPU chose the profile during its cpu_init(). But we're using
> the user callback option to do so, setting profile->user_set.
>
> Create a new helper that does all the grunt work to enable/disable a
> given profile. Use this new helper in the cases where we want a CPU to
> be compatible to a certain profile, leaving the user callback to be used
> exclusively by users.
>
> Fixes: fba92a92e3 ("target/riscv: add 'rva22u64' CPU")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 127 +++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 60 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 857c625580..f8489d79d7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1140,6 +1140,70 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) !=3D NUL=
L;
>  }
>
> +static void riscv_cpu_set_profile(RISCVCPU *cpu,
> +                                  RISCVCPUProfile *profile,
> +                                  bool enabled)
> +{
> +    int i, ext_offset;
> +
> +    if (profile->u_parent !=3D NULL) {
> +        riscv_cpu_set_profile(cpu, profile->u_parent, enabled);
> +    }
> +
> +    if (profile->s_parent !=3D NULL) {
> +        riscv_cpu_set_profile(cpu, profile->s_parent, enabled);
> +    }
> +
> +    profile->enabled =3D enabled;
> +
> +    if (profile->enabled) {
> +        cpu->env.priv_ver =3D profile->priv_spec;
> +
> +#ifndef CONFIG_USER_ONLY
> +        if (profile->satp_mode !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +            object_property_set_bool(OBJECT(cpu), "mmu", true, NULL);
> +            const char *satp_prop =3D satp_mode_str(profile->satp_mode,
> +                                                  riscv_cpu_is_32bit(cpu=
));
> +            object_property_set_bool(OBJECT(cpu), satp_prop, true, NULL)=
;
> +        }
> +#endif
> +    }
> +
> +    for (i =3D 0; misa_bits[i] !=3D 0; i++) {
> +        uint32_t bit =3D misa_bits[i];
> +
> +        if  (!(profile->misa_ext & bit)) {
> +            continue;
> +        }
> +
> +        if (bit =3D=3D RVI && !profile->enabled) {
> +            /*
> +             * Disabling profiles will not disable the base
> +             * ISA RV64I.
> +             */
> +            continue;
> +        }
> +
> +        cpu_misa_ext_add_user_opt(bit, profile->enabled);
> +        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
> +    }
> +
> +    for (i =3D 0; profile->ext_offsets[i] !=3D RISCV_PROFILE_EXT_LIST_EN=
D; i++) {
> +        ext_offset =3D profile->ext_offsets[i];
> +
> +        if (profile->enabled) {
> +            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
> +                riscv_cpu_enable_named_feat(cpu, ext_offset);
> +            }
> +
> +            cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
> +        }
> +
> +        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
> +        isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
> +    }
> +}
> +
>  /*
>   * We'll get here via the following path:
>   *
> @@ -1306,7 +1370,6 @@ static void cpu_set_profile(Object *obj, Visitor *v=
, const char *name,
>      RISCVCPUProfile *profile =3D opaque;
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
>      bool value;
> -    int i, ext_offset;
>
>      if (riscv_cpu_is_vendor(obj)) {
>          error_setg(errp, "Profile %s is not available for vendor CPUs",
> @@ -1325,64 +1388,8 @@ static void cpu_set_profile(Object *obj, Visitor *=
v, const char *name,
>      }
>
>      profile->user_set =3D true;
> -    profile->enabled =3D value;
> -
> -    if (profile->u_parent !=3D NULL) {
> -        object_property_set_bool(obj, profile->u_parent->name,
> -                                 profile->enabled, NULL);
> -    }
> -
> -    if (profile->s_parent !=3D NULL) {
> -        object_property_set_bool(obj, profile->s_parent->name,
> -                                 profile->enabled, NULL);
> -    }
> -
> -    if (profile->enabled) {
> -        cpu->env.priv_ver =3D profile->priv_spec;
> -
> -#ifndef CONFIG_USER_ONLY
> -        if (profile->satp_mode !=3D RISCV_PROFILE_ATTR_UNUSED) {
> -            object_property_set_bool(obj, "mmu", true, NULL);
> -            const char *satp_prop =3D satp_mode_str(profile->satp_mode,
> -                                                  riscv_cpu_is_32bit(cpu=
));
> -            object_property_set_bool(obj, satp_prop, true, NULL);
> -        }
> -#endif
> -    }
> -
> -    for (i =3D 0; misa_bits[i] !=3D 0; i++) {
> -        uint32_t bit =3D misa_bits[i];
> -
> -        if  (!(profile->misa_ext & bit)) {
> -            continue;
> -        }
>
> -        if (bit =3D=3D RVI && !profile->enabled) {
> -            /*
> -             * Disabling profiles will not disable the base
> -             * ISA RV64I.
> -             */
> -            continue;
> -        }
> -
> -        cpu_misa_ext_add_user_opt(bit, profile->enabled);
> -        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
> -    }
> -
> -    for (i =3D 0; profile->ext_offsets[i] !=3D RISCV_PROFILE_EXT_LIST_EN=
D; i++) {
> -        ext_offset =3D profile->ext_offsets[i];
> -
> -        if (profile->enabled) {
> -            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
> -                riscv_cpu_enable_named_feat(cpu, ext_offset);
> -            }
> -
> -            cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
> -        }
> -
> -        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
> -        isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
> -    }
> +    riscv_cpu_set_profile(cpu, profile, value);
>  }
>
>  static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
> @@ -1397,7 +1404,7 @@ static void cpu_get_profile(Object *obj, Visitor *v=
, const char *name,
>  static void riscv_cpu_add_profiles(Object *cpu_obj)
>  {
>      for (int i =3D 0; riscv_profiles[i] !=3D NULL; i++) {
> -        const RISCVCPUProfile *profile =3D riscv_profiles[i];
> +        RISCVCPUProfile *profile =3D riscv_profiles[i];
>
>          object_property_add(cpu_obj, profile->name, "bool",
>                              cpu_get_profile, cpu_set_profile,
> @@ -1409,7 +1416,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
>           * case.
>           */
>          if (profile->enabled) {
> -            object_property_set_bool(cpu_obj, profile->name, true, NULL)=
;
> +            riscv_cpu_set_profile(RISCV_CPU(cpu_obj), profile, true);
>          }
>      }
>  }
> --
> 2.49.0
>
>

