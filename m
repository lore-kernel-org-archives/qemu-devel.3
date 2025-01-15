Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8269C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5GO-0007Xi-6Z; Wed, 15 Jan 2025 10:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY5GL-0007XF-VO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:24:58 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY5GJ-0006tK-9l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:24:57 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so13391202a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736954693; x=1737559493; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uoYTnK0PpxncAWVpUQa9skhgGj0av0eg98PVmyGpktc=;
 b=N1zsVgo/5XPA+HqowzK3iCpgyI3kTzRL9/AQAG3GxaSrc7fufcg7nDTkfHsTQCVo9a
 2DRssWVd7GgR5OWv3ATLFKQBv0frzifKOdLv5wVwv0Rdq7WTGsz7n1J/Ot+K5RVYurj7
 7vyUre2Dfoe2B9iXG/shuVmTeE0IemjQMJgNheq1YVr7505NlPl8KguzU0P9pExnv9C6
 2iJiMBSu7IjszFDytfHEl8OW1ZDKgG+SmWewjM/zGm9Wo32w0TqgVHId/5PwW0gr3IYh
 A+a5FGVIWb9HqtWv7ScAdyh+FxkwiDSIpSIQ4GBvsl/J/hc3ZLNU9LMcv8oYDW7/7kK1
 iydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736954693; x=1737559493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoYTnK0PpxncAWVpUQa9skhgGj0av0eg98PVmyGpktc=;
 b=t0fk0ITpdXW565s6VMOzjdD6+psmi1JGZ6XZQUU7CbyBezcMJ3UdMFiWeOgt4uS3Kd
 Ca4agfT/y/zej4+6qCqPPL4RLd05W1odS8WsB/+xsF6+UI9VAS2DUL0haiI2T5BKztN8
 R+CEn7dT9ubEWUbMZ8H7ADGb8b9H0rGNd08W2t0se+FsUgH8A2xcdLAk9nYJwve3O4kB
 wEcIlAED6sfu3t7iqi6PGj11pnPD1K1EcHMgQEJFXn5pl2BbAikcl7cTkqJRhbpq14+V
 9Fyj5K0AXdV0/YoBsstPYLXKCz9vtJWj4J4jCK0oPNKsw2Osul22DxdNRYkeay3hbcEU
 9B/Q==
X-Gm-Message-State: AOJu0YxccXylMH0jqYCyjiEJyAAXRPUbAowNoK1IaxpOHhfSSx21ZAGn
 RrdHWSiRzV/zmwacrftwIg/V90Sm4bgquQ8mXT2scbPic2xQTU0VTeGt1ek6i3s=
X-Gm-Gg: ASbGncuuhmh0wINJdktF/44IcqhFpA7COBKQ+DXgdah7PClL9x9hwkYEKalPPirwgG5
 gntqFCVCKVzD7fjq3R/ClSn67IUJKsbnmBtMRfXSVt3IcsTzr0hgITnzaWG5pfYTg8QtXBptKCl
 CskPVNY08YOZ1lvtcEJg3lL4lwtBvwPvPWJqY3OQhSLoXdsNymGyfbw7jbuKgE6eFXAhsugXl/R
 6lcrttikVD2wHLp0FvZNPj8ELNeVN6I5kaDIfoDCNYDrNv/k3QU/+MlMVDugDkMb1oAZuw08qfz
 aZ0GvRD/X+ar1zMFisBSN8+ob70I8QsmP0LXCBsdHA==
X-Google-Smtp-Source: AGHT+IGPoocRV0D7G3Nhg9rnZU1ENy58XhbWTH1PEy7vrpu626YyMo3FFiWyud+0h3/SDiVCakbaCw==
X-Received: by 2002:a17:907:97c6:b0:aaf:208:fd3f with SMTP id
 a640c23a62f3a-ab2ab558911mr2720111766b.13.1736954692863; 
 Wed, 15 Jan 2025 07:24:52 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c4b56sm7355654a12.32.2025.01.15.07.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:24:51 -0800 (PST)
Date: Wed, 15 Jan 2025 16:24:50 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv: add profile u_parent and s_parent
Message-ID: <20250115-3af3c8e00a967f0538bfd4b5@orel>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
 <20250115134957.2179085-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115134957.2179085-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 15, 2025 at 10:49:54AM -0300, Daniel Henrique Barboza wrote:
> The current 'parent' mechanic for profiles allows for one profile to be
> a child of a previous/older profile, enabling all its extensions (and
> the parent profile itself) and sparing us from tediously listing all
> extensions for every profile.
> 
> This works fine for u-mode profiles. For s-mode profiles this is not
> enough: a s-mode profile extends not only his equivalent u-mode profile
> but also the previous s-mode profile. This means, for example, that
> RVA23S64 extends both RVA23U64 and RVA22S64.
> 
> To fit this usage, rename the existing 'parent' to 'u_parent' and add a
> new 's_parent' attribute for profiles. Handle both like we're doing with
> the previous 'profile' attribute, i.e. if set, enable it. This change

...like we were doing with the previous 'parent'...

> does nothing for the existing profiles but will make RVA23S64 simpler.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         |  6 ++++--
>  target/riscv/cpu.h         |  3 ++-
>  target/riscv/tcg/tcg-cpu.c | 35 ++++++++++++++++++++++++++---------
>  3 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6fb4d5f374..e215b1004d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2349,7 +2349,8 @@ static const PropertyInfo prop_marchid = {
>   * doesn't need to be manually enabled by the profile.
>   */
>  static RISCVCPUProfile RVA22U64 = {
> -    .parent = NULL,
> +    .u_parent = NULL,
> +    .s_parent = NULL,
>      .name = "rva22u64",
>      .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
>      .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
> @@ -2381,7 +2382,8 @@ static RISCVCPUProfile RVA22U64 = {
>   * The remaining features/extensions comes from RVA22U64.
>   */
>  static RISCVCPUProfile RVA22S64 = {
> -    .parent = &RVA22U64,
> +    .u_parent = &RVA22U64,
> +    .s_parent = NULL,
>      .name = "rva22s64",
>      .misa_ext = RVS,
>      .priv_spec = PRIV_VERSION_1_12_0,
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 97713681cb..986131a191 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -81,7 +81,8 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
>  #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
>  
>  typedef struct riscv_cpu_profile {
> -    struct riscv_cpu_profile *parent;
> +    struct riscv_cpu_profile *u_parent;
> +    struct riscv_cpu_profile *s_parent;
>      const char *name;
>      uint32_t misa_ext;
>      bool enabled;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 48be24bbbe..c9e5a3b580 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -713,13 +713,29 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
>  }
>  #endif
>  
> +static void riscv_cpu_check_parent_profile(RISCVCPU *cpu,
> +                                           RISCVCPUProfile *profile,
> +                                           RISCVCPUProfile *parent)
> +{
> +    const char *parent_name;
> +    bool parent_enabled;
> +
> +    if (!profile->enabled || !parent) {
> +        return;
> +    }
> +
> +    parent_name = parent->name;
> +    parent_enabled = object_property_get_bool(OBJECT(cpu), parent_name, NULL);
> +    profile->enabled = profile->enabled && parent_enabled;

Could drop the 'profile->enabled &&' since we already know
profile->enabled is true from the test above.

> +}
> +
>  static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>                                         RISCVCPUProfile *profile)
>  {
>      CPURISCVState *env = &cpu->env;
>      const char *warn_msg = "Profile %s mandates disabled extension %s";
>      bool send_warn = profile->user_set && profile->enabled;
> -    bool parent_enabled, profile_impl = true;
> +    bool profile_impl = true;
>      int i;
>  
>  #ifndef CONFIG_USER_ONLY
> @@ -773,12 +789,8 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>  
>      profile->enabled = profile_impl;
>  
> -    if (profile->parent != NULL) {
> -        parent_enabled = object_property_get_bool(OBJECT(cpu),
> -                                                  profile->parent->name,
> -                                                  NULL);
> -        profile->enabled = profile->enabled && parent_enabled;
> -    }
> +    riscv_cpu_check_parent_profile(cpu, profile, profile->u_parent);
> +    riscv_cpu_check_parent_profile(cpu, profile, profile->s_parent);
>  }
>  
>  static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
> @@ -1181,8 +1193,13 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>      profile->user_set = true;
>      profile->enabled = value;
>  
> -    if (profile->parent != NULL) {
> -        object_property_set_bool(obj, profile->parent->name,
> +    if (profile->u_parent != NULL) {
> +        object_property_set_bool(obj, profile->u_parent->name,
> +                                 profile->enabled, NULL);
> +    }
> +
> +    if (profile->s_parent != NULL) {
> +        object_property_set_bool(obj, profile->s_parent->name,
>                                   profile->enabled, NULL);
>      }
>  
> -- 
> 2.47.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

