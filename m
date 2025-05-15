Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107C5C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRAL-0000MQ-TN; Thu, 15 May 2025 01:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRAH-0000Ly-Ua
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:29:54 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRAF-0006PK-Rs
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:29:53 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-52b2290e28eso143537e0c.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747286988; x=1747891788; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o60j7FeCq3nmY0xl4V4QJrYYUAM4klYE7XfEg1n9NeE=;
 b=eRjHrrpWECWWMKQonhPzQA5rnu0le8CtluF6J5G0rVf0fkGDS8utQnRYHGDeL8+7JW
 o1X8FcmcUPDBQ74D9FzTYQCoR6kSCULJK3Pll8zBn8l1lUw+IPXR8MS+qGcwFtk6VgfA
 o4H0EN+gabcf7mCa6sGGxMxkQpfvEbyUrJvTDOe3sfTQY3qyPROPZCji3C9exUoUF8bT
 5EWCCcqbRZ2n8EPt1En8qXxk2tj3BkFvyzuL+sKWL37EnSX7HXHl1klu4VWyvaAvvkWX
 c01GJiiKD1x6sVsJ2oywTdseRWmZK49HVFGLc22xhWN3UAF308YLBgwF5h89Kj7tEb4C
 U19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747286988; x=1747891788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o60j7FeCq3nmY0xl4V4QJrYYUAM4klYE7XfEg1n9NeE=;
 b=N9bkDc9wdT+ALsz2BHTSf7SzOetSbUBHFKZu6R57jpibbEcKtc4F9Bxwl4gm9AjoVj
 CjxInYAb7Bo7rj/m+atSOZKjUFDTlsLuTxjhKNLB5OgscCaW37XqrcAmVbFbVYXy2Ag7
 /wxQG4nD38zFsYMsNZhaS2U3zp83ilBrw5PyF/FFTmxxNHQ6Nn2/LjTyILeHLzlJ665f
 RLXVmUdEQ0vC/pDy9xNZipL9fmmppC1EQaLQgJ3Sjasr8wSQaaH1qagOe4kxqk/X82dr
 UwCyByhuGaZK8c8YRJVx7M63l/8KS3YF1kfvBQM/qe3N4npqPuoU3xgheKi4REnW4iXs
 a5nw==
X-Gm-Message-State: AOJu0YwT0T3ne10cAZvVK9LofkgHXOY+BOFmeQhj8VkHIhQHvk7taqYM
 PJmIKn+8oApwfqgEf3NLBmIKK1VtF60nJ6FU5Sh7TxjE0/Vbbp6IZ3ORdJnjQGytISbJezeRI4z
 FJXlWMUjoiTX/qFCrFSYvagcOgDc=
X-Gm-Gg: ASbGncu1r2sNI7NhJQJC3tUAF+N0d6kDobJqUMl0NvAD53PhW21YYkeFdq2gTKVhW3U
 E9I9rDUsEBQV8Tukr7fVXB3wrh38FU0zYxK0xiUSKvEqV0jkVIJBvWBfo3uKPYTq2ZsC450NhT2
 p+GghV71HHYFFNNn4mpXGW4hFPGrrd+qM/UXK1lPcEDXG1rguPw1W5XTTTnck3Ruk=
X-Google-Smtp-Source: AGHT+IGK7txuwQ1s/Z3NN806nyML2wKEBB04CPt/bg5DoGNlVN4kE9fiWvX3A1YgVhEDm+PfXZgXl67tidFTJF3c42s=
X-Received: by 2002:a05:6122:658f:b0:52a:78ab:12ad with SMTP id
 71dfb90a1353d-52d9c3b96admr5174627e0c.0.1747286988527; Wed, 14 May 2025
 22:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-14-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-14-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:29:21 +1000
X-Gm-Features: AX0GCFs-3wPKPNOBzVuqjYqS39PglXsyVNvX6Io0olxAak6hntAt-UNJHnaWELw
Message-ID: <CAKmqyKNqTP_tbU3cOL5y8CXYVM+vinUVCA_UPtOdWZA+Ezz3cA@mail.gmail.com>
Subject: Re: [PATCH 13/26] target/riscv: convert profile CPU models to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Mon, May 12, 2025 at 7:53=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Profile CPUs reuse the instance_init function for bare CPUs; make them
> proper subclasses instead.  Enabling a profile is now done based on the
> RISCVCPUDef struct: even though there is room for only one in RISCVCPUDef=
,
> subclasses check that the parent class's profile is enabled through the
> parent profile mechanism.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |  1 +
>  target/riscv/cpu.c | 85 +++++++++++++++++++++++++---------------------
>  2 files changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0330d74ab6b..8a8d61f8099 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -539,6 +539,7 @@ struct ArchCPU {
>
>  typedef struct RISCVCPUDef {
>      RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +    RISCVCPUProfile *profile;
>      uint32_t misa_ext;
>      int priv_spec;
>      int32_t vext_spec;
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f66560442a9..06c612afba7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1487,6 +1487,10 @@ static void riscv_cpu_init(Object *obj)
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
>
> +    if (mcc->def->profile) {
> +        mcc->def->profile->enabled =3D true;
> +    }
> +
>      env->misa_ext_mask =3D env->misa_ext =3D mcc->def->misa_ext;
>      riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
>
> @@ -2959,36 +2963,6 @@ static const Property riscv_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
>  };
>
> -#if defined(TARGET_RISCV64)
> -static void rva22u64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA22U64.enabled =3D true;
> -}
> -
> -static void rva22s64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA22S64.enabled =3D true;
> -}
> -
> -static void rva23u64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA23U64.enabled =3D true;
> -}
> -
> -static void rva23s64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA23S64.enabled =3D true;
> -}
> -#endif
> -
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> @@ -3057,6 +3031,32 @@ static void riscv_cpu_common_class_init(ObjectClas=
s *c, const void *data)
>      device_class_set_props(dc, riscv_cpu_properties);
>  }
>
> +static bool profile_extends(RISCVCPUProfile *trial, RISCVCPUProfile *par=
ent)
> +{
> +    RISCVCPUProfile *curr;
> +    if (!parent) {
> +        return true;
> +    }
> +
> +    curr =3D trial;
> +    while (curr) {
> +        if (curr =3D=3D parent) {
> +            return true;
> +        }
> +        curr =3D curr->u_parent;
> +    }
> +
> +    curr =3D trial;
> +    while (curr) {
> +        if (curr =3D=3D parent) {
> +            return true;
> +        }
> +        curr =3D curr->s_parent;
> +    }
> +
> +    return false;
> +}
> +
>  static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> @@ -3071,6 +3071,11 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, const void *data)
>      if (data) {
>          const RISCVCPUDef *def =3D data;
>          mcc->def->bare |=3D def->bare;
> +        if (def->profile) {
> +            assert(profile_extends(def->profile, mcc->def->profile));
> +            assert(mcc->def->bare);
> +            mcc->def->profile =3D def->profile;
> +        }
>          if (def->misa_mxl_max) {
>              assert(def->misa_mxl_max <=3D MXL_RV128);
>              mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> @@ -3237,19 +3242,22 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt=
, char *nodename)
>          }),                                                 \
>      }
>
> -#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
> +#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
>      {                                                       \
>          .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_BARE_CPU,                      \
> -        .instance_init =3D (initfn),                          \
> +        .parent =3D (parent_type_name),                       \
>          .class_data =3D &(const RISCVCPUDef) {                \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
>               .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
>               .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
>               .cfg.max_satp_mode =3D -1,                       \
> +             __VA_ARGS__                                    \
>          },                                                  \
>      }
>
> +#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
> +    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
> +        .profile =3D &(profile_))
> +
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
>      {
>          .name =3D TYPE_RISCV_CPU,
> @@ -3328,10 +3336,11 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
>  #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_c=
pu_init),
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_c=
pu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_pro=
file_cpu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_pro=
file_cpu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_pro=
file_cpu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_pro=
file_cpu_init),
> +
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  =
RVA22U64),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  =
RVA22S64),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  =
RVA23U64),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  =
RVA23S64),
>  #endif /* TARGET_RISCV64 */
>  };
>
> --
> 2.49.0
>

