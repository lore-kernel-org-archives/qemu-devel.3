Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26D2C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 03:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKTdq-0008Qa-CU; Wed, 28 May 2025 23:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTdo-0008QG-Nw; Wed, 28 May 2025 23:09:12 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTdl-0000pB-IJ; Wed, 28 May 2025 23:09:12 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-52413efd0d3so129909e0c.2; 
 Wed, 28 May 2025 20:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748488145; x=1749092945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYdl7Ct8rFHu97ETM8Mtyv2xh0RE4VZ+anjF3qbqLdU=;
 b=by6J7oYnVUagsmK3ADXrf+C1h9fSGwnql+uTEdVXwfdlKmPxY4NN402i/JbLF811l2
 jf/YL7KGO4RuWyVz1e19tRATn9Blz9QFMqucoTRPi7zJjMoP4OlGYend6WnzULo2kB7R
 vGMzDGGuQ6aCajay7Exrxm3brexQkCjXnilnnDk9b2EcnjQTx3kiVxvrKWkHPhpfywh3
 beRSlIYRNEu0MUxZhYkh7dsJCxcS8ReXeSNAHvNn8oZ1lwmbhG7vTSsxnmYTTF1wMMtJ
 M0ONbztMkE9vmtWtI2kzU4RPfXYiEAjTp9qnSngNN5dDhWJB9PHenK0Elvy/2sKzrDdG
 RXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748488145; x=1749092945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYdl7Ct8rFHu97ETM8Mtyv2xh0RE4VZ+anjF3qbqLdU=;
 b=hpU/tZH9+g6U19lZNy6loACut/bV9T44OqzYv8EUejvy5THp50oZXmm3S4mYzwzkXl
 rwAja/z9K5+ghgqsGZLlStn1TOoYkKLuRIpCpYyxs/qvr6cVf4hbqQfgCnzNGbM501l+
 zKoEbEVD3DeHtyU7cKJoGgxXcrhRipe4d/zV+vhPjkBESyRoBGMzJlCU+KWX8OVldUJ8
 0u0jW/8nwbpR6oVEQ7J4dLhDgJi6M1x+/Bd14lIt0pXUKmaBBx/pFT8st/rOK2DUEjOt
 CQSe+rlFuXF+4iJ54TNHOjl1m6Ylm8xL8qdMkxQD62GdbjaKDqKNW5ydewWfTkYnUpBv
 vaPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAQOAEmi3rnQqgcr7jH0xgQGm9waE4ogBLMgY6GTBH+fqGl8TU/WVVuNn7f/VucdcsENib4p5aQVQz@nongnu.org
X-Gm-Message-State: AOJu0YweK39Gbh0dGQwCqMc/VrhwbevXhZy6SE7j9KsHliDukp3WVtZm
 xdMGUyMIiBjj+g8AkMmPau4jFtg81xL/41J1oZEvym92VTx19JWyW9D8Tw/6jCOrUJkIIhiGN83
 IdiPB+d9Vh0cPVSawDHYQ9ewBOji0YIQ=
X-Gm-Gg: ASbGncssrqxJoIOszgqGpw83bceKzHqRQVEaI3z6yxsPdVqGqGshtcbXiJaZBjiiy1I
 IbqiUqh+Q5OmS3gM7HyGC/3ndZQI14D/Lg04XaJUYKFKff/Br1ZwTXBXJrC8ANZVwaz6Zcp39Qa
 Kw0Pr9pqVXvzZkYEFuftJlEuPeWnIG4YwUZL1vMA3Jcdo0ZPjkyIAZmlpdw8SCUQQ=
X-Google-Smtp-Source: AGHT+IHZPJnPX7NH+Bs4CV1s5dUDbEpPK7FTO+qzsc4VmKdP7/wmzXnlZooU76H1EAZfFSf6HnKuE8tyh321R5T+3cE=
X-Received: by 2002:a05:6122:871a:b0:530:5fe5:7ea4 with SMTP id
 71dfb90a1353d-5305fe591d2mr4231111e0c.11.1748488145504; Wed, 28 May 2025
 20:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250520172336.759708-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 May 2025 13:08:39 +1000
X-Gm-Features: AX0GCFsBA5-1CH8WHwu7EpH5BI2Vw5C_VIN8a8pee2-BEiyWBuEqoIL1pImBnyo
Message-ID: <CAKmqyKNaq3OhQyTZu==U9VX7PAMjOe1vbyrAiJ=srsHB=Pgu8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv/tcg: decouple profile enablement from
 user prop
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, May 21, 2025 at 3:24=E2=80=AFAM Daniel Henrique Barboza
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 127 +++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 60 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 7f93414a76..af202c92a3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1139,6 +1139,70 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
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
> @@ -1305,7 +1369,6 @@ static void cpu_set_profile(Object *obj, Visitor *v=
, const char *name,
>      RISCVCPUProfile *profile =3D opaque;
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
>      bool value;
> -    int i, ext_offset;
>
>      if (riscv_cpu_is_vendor(obj)) {
>          error_setg(errp, "Profile %s is not available for vendor CPUs",
> @@ -1324,64 +1387,8 @@ static void cpu_set_profile(Object *obj, Visitor *=
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
> @@ -1396,7 +1403,7 @@ static void cpu_get_profile(Object *obj, Visitor *v=
, const char *name,
>  static void riscv_cpu_add_profiles(Object *cpu_obj)
>  {
>      for (int i =3D 0; riscv_profiles[i] !=3D NULL; i++) {
> -        const RISCVCPUProfile *profile =3D riscv_profiles[i];
> +        RISCVCPUProfile *profile =3D riscv_profiles[i];
>
>          object_property_add(cpu_obj, profile->name, "bool",
>                              cpu_get_profile, cpu_set_profile,
> @@ -1408,7 +1415,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
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

