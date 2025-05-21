Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21022C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjny-0004ez-S5; Wed, 21 May 2025 09:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHjnj-0004cV-LD
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:48:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHjng-0005wb-Uz
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:48:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso53244255e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747835283; x=1748440083; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5lB1QwMR7SISD/zyz/TtiJwCBsObjd2VAYRo1IONgBw=;
 b=ju8h3qI5CNhsclTKmxmpWvhlltQNjzGiconcS9HfqbBsRHNI9NJf5zZttlP/4d9bF+
 2FIjbIAv+xhi/HImcQ38LRU5mG7m9xIfp/exmH1ssE2U0MnIL+XTYbafVS5ywuJhPlCD
 cZ8JBb1Tg8D80cXYVtc50jYCHAW2LZrb9tn0ItXTJvbk3EAmgEGkUpREnTOY0fX/Z70X
 sB7yTvZkQn/zn6u8+geS1FtV4VMfn2l9QHzNoCXWNt946WyT1eVwf7x0UxNZUzVaz1mX
 C4p6oKphd7zhPZACcQErJNju+7ccSVW/thHOI0dXxNrCf72jeKl/3QS6sS9j1G47HX9t
 kCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747835283; x=1748440083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lB1QwMR7SISD/zyz/TtiJwCBsObjd2VAYRo1IONgBw=;
 b=tuFYKcs3XT2shtb444HYp/MVYOnHuHklJVlcrxNTJBmAMchXageyd7Qm7xxDVb0eq/
 guqHU8LSmBYLtOgRQGburdNXkJoiTFUPqOhnZgY3EfSdOyh29JYr5vUE0FcaxZUZzzVO
 Vh1T10FWCABsH5heOd8oS4Ln4RP2HogN20f+bz/HU6YDMvneEoBmfGlqeMAIqXVVcNPV
 yWvHGfT4NhCysUKVjrKEZQLeXw1zriLdP9uDtnmc1lHn9vGTOzrBfNFbnJKVil2a1BJ8
 9q7lsomjkrNacps9zy7coxsoTrNqQhA9BoIpZrs7t72zAE0wo0P6JQEFde+ucN5sqqD3
 XHxg==
X-Gm-Message-State: AOJu0Yy4hpTYrs6U2PiZciejzdN+og6yMHR7IWlu0WKYWXUzdoj8Ulq6
 9FTMd8lsBm2j2bYzEgtwhRQ54h5RSzAnuZnmY6tXlN1XlxtA5uLFa5bGAhAy4BEXMNQ=
X-Gm-Gg: ASbGncuCX289islwcEDEA7JDBkMJfwTDbIXvaY7Z6Pul+4p7XvKGODKHEnY2+avsmbF
 NbgZtc4RGcEIpl/ofGnJXMTbkEFUg5qPeR1YfWDdagZF90tmSjoC1jaZQcETygnH4xBfVU8rBqQ
 OmJCbOWHL7/IdYGTXaLEHlSIK2FFmo9SAVJbHcS7LVPDHyjcLbI1jEtTpQPj1+z0aS3zhm6xBxO
 YM1+s3sST0VwPJWwnsxbAtqdOoK91U+xd9LRKYgvCaWUWyG6oEOcZFRsbqxIpj2IRKSSY0vGx1k
 VKC/6IeXjORY4jJHlTdgVDhhvu2b/ansFDHxs7MEmx2mhSOzyQ==
X-Google-Smtp-Source: AGHT+IECOBBM4i/vbbiJygZT/Q3Wsh2nPDpdkuEh/tk8/2Qoq8FHETke/JwIgEhxNPqlrkMBrYp28g==
X-Received: by 2002:a05:600c:4713:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-442ff039657mr155155295e9.28.1747835282587; 
 Wed, 21 May 2025 06:48:02 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d3d6csm72066895e9.19.2025.05.21.06.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 06:48:02 -0700 (PDT)
Date: Wed, 21 May 2025 15:48:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 bjorn@kernel.org
Subject: Re: [PATCH 2/3] target/riscv/tcg: decouple profile enablement from
 user prop
Message-ID: <20250521-f09745e013db8105f4a6f5f0@orel>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520172336.759708-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x330.google.com
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

On Tue, May 20, 2025 at 02:23:35PM -0300, Daniel Henrique Barboza wrote:
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
> ---
>  target/riscv/tcg/tcg-cpu.c | 127 +++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 60 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 7f93414a76..af202c92a3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1139,6 +1139,70 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
>  }
>  
> +static void riscv_cpu_set_profile(RISCVCPU *cpu,
> +                                  RISCVCPUProfile *profile,
> +                                  bool enabled)
> +{
> +    int i, ext_offset;
> +
> +    if (profile->u_parent != NULL) {
> +        riscv_cpu_set_profile(cpu, profile->u_parent, enabled);
> +    }
> +
> +    if (profile->s_parent != NULL) {
> +        riscv_cpu_set_profile(cpu, profile->s_parent, enabled);
> +    }
> +
> +    profile->enabled = enabled;
> +
> +    if (profile->enabled) {
> +        cpu->env.priv_ver = profile->priv_spec;
> +
> +#ifndef CONFIG_USER_ONLY
> +        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
> +            object_property_set_bool(OBJECT(cpu), "mmu", true, NULL);
> +            const char *satp_prop = satp_mode_str(profile->satp_mode,
> +                                                  riscv_cpu_is_32bit(cpu));
> +            object_property_set_bool(OBJECT(cpu), satp_prop, true, NULL);
> +        }
> +#endif
> +    }
> +
> +    for (i = 0; misa_bits[i] != 0; i++) {
> +        uint32_t bit = misa_bits[i];
> +
> +        if  (!(profile->misa_ext & bit)) {
> +            continue;
> +        }
> +
> +        if (bit == RVI && !profile->enabled) {
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
> +    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
> +        ext_offset = profile->ext_offsets[i];
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
> @@ -1305,7 +1369,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>      RISCVCPUProfile *profile = opaque;
>      RISCVCPU *cpu = RISCV_CPU(obj);
>      bool value;
> -    int i, ext_offset;
>  
>      if (riscv_cpu_is_vendor(obj)) {
>          error_setg(errp, "Profile %s is not available for vendor CPUs",
> @@ -1324,64 +1387,8 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>      }
>  
>      profile->user_set = true;
> -    profile->enabled = value;
> -
> -    if (profile->u_parent != NULL) {
> -        object_property_set_bool(obj, profile->u_parent->name,
> -                                 profile->enabled, NULL);
> -    }
> -
> -    if (profile->s_parent != NULL) {
> -        object_property_set_bool(obj, profile->s_parent->name,
> -                                 profile->enabled, NULL);
> -    }
> -
> -    if (profile->enabled) {
> -        cpu->env.priv_ver = profile->priv_spec;
> -
> -#ifndef CONFIG_USER_ONLY
> -        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
> -            object_property_set_bool(obj, "mmu", true, NULL);
> -            const char *satp_prop = satp_mode_str(profile->satp_mode,
> -                                                  riscv_cpu_is_32bit(cpu));
> -            object_property_set_bool(obj, satp_prop, true, NULL);
> -        }
> -#endif
> -    }
> -
> -    for (i = 0; misa_bits[i] != 0; i++) {
> -        uint32_t bit = misa_bits[i];
> -
> -        if  (!(profile->misa_ext & bit)) {
> -            continue;
> -        }
>  
> -        if (bit == RVI && !profile->enabled) {
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
> -    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
> -        ext_offset = profile->ext_offsets[i];
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
> @@ -1396,7 +1403,7 @@ static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
>  static void riscv_cpu_add_profiles(Object *cpu_obj)
>  {
>      for (int i = 0; riscv_profiles[i] != NULL; i++) {
> -        const RISCVCPUProfile *profile = riscv_profiles[i];
> +        RISCVCPUProfile *profile = riscv_profiles[i];
>  
>          object_property_add(cpu_obj, profile->name, "bool",
>                              cpu_get_profile, cpu_set_profile,
> @@ -1408,7 +1415,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
>           * case.
>           */
>          if (profile->enabled) {
> -            object_property_set_bool(cpu_obj, profile->name, true, NULL);
> +            riscv_cpu_set_profile(RISCV_CPU(cpu_obj), profile, true);
>          }
>      }
>  }
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

