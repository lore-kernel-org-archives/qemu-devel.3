Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546A2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRCy-0002I4-Bk; Thu, 15 May 2025 01:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRCv-0002Hb-HB
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:32:38 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRCt-0006oL-LC
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:32:37 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4ddb9d80bffso419783137.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287148; x=1747891948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVVmyUjkyge8c5rikKdn5k4ZcGLDDgfDbc7uMGGVFyc=;
 b=Lshs2MddGHKPou7pz+O/PF1PdMZREXYfObKluIvV4vILOfVONHvpnkBKoh6hgim6Tg
 QDGVe/6JTCW7aXQ4tAVE02KazVEKnltvLlTcWwAFXAxHBqvbFjHCUhvqObmJG34qGmWK
 VAG5GzLWO3xRKycbly2ESOk59Xsc9EezSwMrFJw4k4BZ3Ca/POda0fyRuZzwrax3M6RF
 SJ7Oi+MKWA8tug6g3XLdtseKR+DfsjgC+Gff+1Vv6w/CoIFkpUkO7Uprv2M8JhJCHxz1
 /4DDI8QwfMDZtIrhkIaPw5S7vexSC8dyFVupyPWoFNUr+BVEe+PS6olBLuecfDXwOojj
 tA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287148; x=1747891948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVVmyUjkyge8c5rikKdn5k4ZcGLDDgfDbc7uMGGVFyc=;
 b=wCnJ6zOqpyAnSxrpezQxY1XEVgh+vbcM+eXMFd/Nn+q7fznAwQSMUodJWNa1gSU5z1
 Q+2vgKQVzEXEaqwmsZxk0m/kJ5SPxxWTxmflVsTvr9u4QMVIzHSde7Byzena4zKaR5QD
 Pic9oqxLHa2TAKIPtGxFqMhLXnWeDXdw/CvGiojBKg/PuzQsBuz1WFORXwCLXQUFJAhZ
 vCtqh6TqgCjV4MgwMRLasv2gTRq5/2KCQEkPQ5t0v55l/PrDubNyqqUSdAPJHfYyrQu2
 fLtV+NMlUk1PwBXe0JR7w2HLwlTqAEOajPRSVOnW6AJeRYt8Onzqr78exs5TOvqmMRS5
 MFdg==
X-Gm-Message-State: AOJu0YwOFVKXgPYOKhgjqmNfPBl/vnfItJs+uoHWynu1YYftWcETVBkR
 bHVY0e8l3xjhRi0JfrzX4tCZAxjTjo6v1vXtSGnTe5kAzc8AsEYQJX7hWKwBbeqsCVecK+26YYd
 0wKkYcW9fIQ7FD7IrOhGjptO49no=
X-Gm-Gg: ASbGncuY9xCUjpsOGzvSEJibGodgnmYRQaSg+mKnQvVo0H2p8b+M3Z2+EGnGQ5CdzLq
 GjqzzKXm4vVwWt5CzyFdl4NSsBzMSOP+yAhEGhnAG1Zvai1+ibe6Dhwe1fYx9Qz10HmNT92j+IU
 kZqDZGPnvrIhe5fX1N2KttD6Lu3fAC5WIDBm5n5Nj8VIWrt4shNib30Lwo8M/hJX8=
X-Google-Smtp-Source: AGHT+IGQd9aeb0N7TbuMVNIo0+5kaiGQ8LpVR8xiFbNtWhs0UJkQeGtXuw/IaJb87d+49sdnaEa3IhzkccrOX5jkqIA=
X-Received: by 2002:a05:6102:2acd:b0:4df:48a4:776b with SMTP id
 ada2fe7eead31-4df8fda1e12mr1704992137.0.1747287147967; Wed, 14 May 2025
 22:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-17-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-17-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:32:01 +1000
X-Gm-Features: AX0GCFvlfSQkW7jKvKq-mhhHfrL1hdst3fr5lqgxqRqvwNXznshKueXFGmBrxpg
Message-ID: <CAKmqyKNG0ihjjX02BzoyZxqPBxwotM0nwk24i3_BdxHY=MK+rQ@mail.gmail.com>
Subject: Re: [PATCH 16/26] target/riscv: convert SiFive E CPU models to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 74 ++++++++++++------------------------------
>  2 files changed, 21 insertions(+), 54 deletions(-)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 4cfdb74891e..0f9be15e47b 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -44,6 +44,7 @@
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibe=
x")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
> +#define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51"=
)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b4f6e34eac7..aea5d7d197e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -503,23 +503,6 @@ static void rv64_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.pmp =3D true;
>  }
>
> -static void rv64_sifive_e_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
> -
>  static void rv64_thead_c906_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -708,23 +691,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.pmp =3D true;
>  }
>
> -static void rv32_sifive_e_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
> -
>  static void rv32_ibex_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -746,23 +712,6 @@ static void rv32_ibex_cpu_init(Object *obj)
>      cpu->cfg.ext_zbc =3D true;
>      cpu->cfg.ext_zbs =3D true;
>  }
> -
> -static void rv32_imafcu_nommu_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
>  #endif
>
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> @@ -3204,6 +3153,15 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
>
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR=
_CPU,
> +        .misa_ext =3D RVI | RVM | RVA | RVC | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_10_0,
> +        .cfg.max_satp_mode =3D VM_1_10_MBARE,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.pmp =3D true
> +    ),
> +
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> @@ -3212,8 +3170,14 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      ),
>
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_=
e_cpu_init),
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_=
nommu_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
> +        .misa_mxl_max =3D MXL_RV32
> +    ),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
> +        .misa_mxl_max =3D MXL_RV32,
> +        .misa_ext =3D RVF,  /* IMAFCU */
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_=
u_cpu_init),
>
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
> @@ -3239,7 +3203,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_mxl_max =3D MXL_RV64,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_=
e_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
> +        .misa_mxl_max =3D MXL_RV64
> +    ),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c=
906_cpu_init),
> --
> 2.49.0
>

