Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3197AD10F22
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 11:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vODqF-0000cN-Ij; Wed, 26 Nov 2025 06:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vODqD-0000bp-Oz
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 06:37:46 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vODqB-0005kU-LL
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 06:37:45 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-656b4881f55so2878967eaf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 03:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764157061; x=1764761861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Xn2iAdbO2rCRiDWuNwotHnOeDqIlaMcPUZnAtV6mvM=;
 b=iV4J3eG05gciYWh4xL6qPW+ryaXiJT5MoWlo9mKu1QwAm8bk41cTYPMY4qZstPPxoV
 lbcM5Q2lqVIUYonNXmFIG8GlIQD/GPzqlczbRe6Jo7xHvI//GjzODsoaVprncDUKHViT
 zcbq73p5zrI/Nf55w7gbjd2o6jDvH+IwqpFVczi4q2d83XCRnHezY8R0hcvF75VoFWor
 KFEFJcXKOCQvAcQTxiDb+hX98o0qL91cUcoPwA8tUhZ1N5ZKtJR3uRH7xsfXkT9aQEMe
 3RIWaw7AngeG15v8RlOOaJWp4zyv/X1euY1vUDOWFl2yfz/ANTfgbJxKU0AKfYuISbVT
 AUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764157061; x=1764761861;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Xn2iAdbO2rCRiDWuNwotHnOeDqIlaMcPUZnAtV6mvM=;
 b=WenJQ2pQOUe50lw8Q9Ho5uLmKLr6d+SK/O+MkXcB6lDx40cjl3p41dR3kkxGm50u31
 U68tH7m2VlKUn0TgyPfaBELgFOTIwNU7ovh1M1CK4WECH41GCgaU4gl7r4LFCiNdt3F2
 x/aO8+0sH+weZoRlLWt0cY8xLv4iYAfDmXSpcueNXqxYiYFziePI3sp61XZWXyT6this
 9uYynBiQPTeYjERQVAfsXT62Orfg741BiwSJy0ZWkf2A1OtHjPozyoIXRvJREYUuYZmh
 I8ahe8rHl8cRY5tNcIrJMGAd9lb//2UJQhemlNgOazW10XVA0NRg5EjnhzdsCFTrDaca
 UtQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYXNXKmxkL39TxPbE0i/eNsBa0pW2BETsdjqpw+8atlq52C/8ZzBX3E89W8EJ0hPaGE06X/KmAbDOL@nongnu.org
X-Gm-Message-State: AOJu0Yzg2m4gG+L13gOr18jqKhgtHfZGsaQwdmV0Sg8luzhW0dJ44yho
 6Ll69mmQFdncMj6XfvFcUZHG4tLPsOjUjo7xEIOUbLhEM/Ioqm2fbyje7j7C8S+1AS0=
X-Gm-Gg: ASbGncuQO7rKRGl5prF37HJXPYyYb5FbfZww7bdnBH9rj6C/ErptbttdThsVkQ+oYVT
 +LSCTXjZJHNUTNVF3qqC8qiLl9TVnmeCS3SCZcn841oAwBBwBWgGLVCr61y+llS7bfiNPJxRAX4
 msO461r7tfh0CDZcn5k5bHtURwB5Lo1yNRC8gcP75kW19lbm+wqvESrlH4FCGLYpAJyR+30Eef1
 Wzc18UVOS3ku/wiQZBVpnuZy+GxQQ+v6I9qFLSbrnQHG0VEgy6mZ0UlJFBgNbpg0l4Lxhfru3KN
 eRZ7D2fu0LAqe1Rt/TVOZ3kxigrG56ny/FgiPNls8Nl2vsAH5BkHpLNLcLs7flz43JTrJEc0maD
 AI+eyKsUkl5KUN4BMdHG5+2mcM6TyL1Wc+W8aPIBF1FvMrqugLdUGb5AdUic4mSX5tA99E31DUK
 qIHLxIEc6+/MBzZGCnm9AqJLDXjk7vlym2CPxfJUaS08nLj/1YEH3J1MZHqi2ktRlIUQ==
X-Google-Smtp-Source: AGHT+IFtN3dZeKwWEtrAYD+ZKQppl/PEVHxn2paWmI+yAWcEEar7qiebgF0BtUgwSFMrr/g0KxLJrw==
X-Received: by 2002:a05:6830:390c:b0:7c6:e92f:41df with SMTP id
 46e09a7af769-7c7c412cb9amr3711127a34.12.1764157061402; 
 Wed, 26 Nov 2025 03:37:41 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc3:6f02:ca20:22ba:5f61:66a8?
 ([2804:7f0:bcc3:6f02:ca20:22ba:5f61:66a8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d42803dsm7334940a34.26.2025.11.26.03.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 03:37:40 -0800 (PST)
Message-ID: <641f8940-968f-423e-86af-c0faed18ff43@ventanamicro.com>
Date: Wed, 26 Nov 2025 08:37:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Add 'debug_ver' to set version of debug
 specification
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, Yu-Ming Chang <yumin686@andestech.com>
References: <20251126071258.4132239-1-alvinga@andestech.com>
 <20251126071258.4132239-2-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251126071258.4132239-2-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc36.google.com
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

Hi,


There are 2 points I would like to bring here. First is the addition of a
new string property.

Although it's not forbidden, and in fact we have string properties in
RISC-V CPU code (which I'll be dealing with in the next QEMU cycle), we
would like to avoid adding new str props. The reason is that str props are
harder to work with in management layers (e.g. libvirt) and to expose in QMP.

I suggest using booleans instead. They are way easier to work with in
the upper layers and we don't have to maintain string parsing code as
well. Instead of adding a 'debug_ver' string prop and parse values,
add two bool properties: debug-0.13 and debug-1.0.

Second, we have a 'debug' flag that is set to default 'true'. From what I'm
reading in this patch the existing flag would be equivalent to 'debug-0.13'
I proposed above. In this case we can keep the existing flag and add a single
'debug-1.0' flag to indicate that the user wants to use v1.0 instead of v0.13.


Thanks,

Daniel



On 11/26/25 4:12 AM, Alvin Chang wrote:
> The similar control did in 'priv_spec' and 'vext_spec' now is available
> for version of debug specification. Currently we accept "v0.13" and
> "v1.0" versions. Users can provide 'debug_spec' into CPU option to set
> intended version of the debug specification.
> 
> For examples:
> 1. -cpu max,debug_spec=v0.13
> 2. -cpu max,debug_spec=v1.0
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
>   target/riscv/cpu.c         | 69 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.h         | 13 +++++++
>   target/riscv/machine.c     |  5 +--
>   target/riscv/tcg/tcg-cpu.c |  3 ++
>   4 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280..dbcdfcd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1123,6 +1123,7 @@ static void riscv_cpu_init(Object *obj)
>       cpu->cfg.pmp_regions = 16;
>       cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
>       cpu->env.vext_ver = VEXT_VERSION_1_00_0;
> +    cpu->env.debug_ver = DEBUG_VERSION_0_13_0;
>       cpu->cfg.max_satp_mode = -1;
>   
>       if (mcc->def->profile) {
> @@ -1138,6 +1139,9 @@ static void riscv_cpu_init(Object *obj)
>       if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
>           cpu->env.vext_ver = mcc->def->vext_spec;
>       }
> +    if (mcc->def->debug_spec != RISCV_PROFILE_ATTR_UNUSED) {
> +        cpu->env.debug_ver = mcc->def->debug_spec;
> +    }
>   #ifndef CONFIG_USER_ONLY
>       if (mcc->def->custom_csrs) {
>           riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
> @@ -1720,6 +1724,66 @@ static const PropertyInfo prop_priv_spec = {
>       .set = prop_priv_spec_set,
>   };
>   
> +static int debug_spec_from_str(const char *debug_spec_str)
> +{
> +    int debug_version = -1;
> +
> +    if (!g_strcmp0(debug_spec_str, DEBUG_VER_0_13_0_STR)) {
> +        debug_version = DEBUG_VERSION_0_13_0;
> +    } else if (!g_strcmp0(debug_spec_str, DEBUG_VER_1_00_0_STR)) {
> +        debug_version = DEBUG_VERSION_1_00_0;
> +    }
> +
> +    return debug_version;
> +}
> +
> +static const char *debug_spec_to_str(int debug_version)
> +{
> +    switch (debug_version) {
> +    case DEBUG_VERSION_0_13_0:
> +        return DEBUG_VER_0_13_0_STR;
> +    case DEBUG_VERSION_1_00_0:
> +        return DEBUG_VER_1_00_0_STR;
> +    default:
> +        return NULL;
> +    }
> +}
> +
> +static void prop_debug_spec_set(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    g_autofree char *value = NULL;
> +    int debug_version = -1;
> +
> +    visit_type_str(v, name, &value, errp);
> +
> +    debug_version = debug_spec_from_str(value);
> +    if (debug_version < 0) {
> +        error_setg(errp, "Unsupported debug spec version '%s'", value);
> +        return;
> +    }
> +
> +    cpu_option_add_user_setting(name, debug_version);
> +    cpu->env.debug_ver = debug_version;
> +}
> +
> +static void prop_debug_spec_get(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    const char *value = debug_spec_to_str(cpu->env.debug_ver);
> +
> +    visit_type_str(v, name, (char **)&value, errp);
> +}
> +
> +static const PropertyInfo prop_debug_spec = {
> +    .type = "str",
> +    .description = "debug_spec",
> +    .get = prop_debug_spec_get,
> +    .set = prop_debug_spec_set,
> +};
> +
>   static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
>                                  void *opaque, Error **errp)
>   {
> @@ -2648,6 +2712,7 @@ static const Property riscv_cpu_properties[] = {
>   
>       {.name = "priv_spec", .info = &prop_priv_spec},
>       {.name = "vext_spec", .info = &prop_vext_spec},
> +    {.name = "debug_spec", .info = &prop_debug_spec},
>   
>       {.name = "vlen", .info = &prop_vlen},
>       {.name = "elen", .info = &prop_elen},
> @@ -2818,6 +2883,10 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>               assert(def->vext_spec != 0);
>               mcc->def->vext_spec = def->vext_spec;
>           }
> +        if (def->debug_spec != RISCV_PROFILE_ATTR_UNUSED) {
> +            assert(def->debug_spec <= DEBUG_VERSION_LATEST);
> +            mcc->def->debug_spec = def->debug_spec;
> +        }
>           mcc->def->misa_ext |= def->misa_ext;
>   
>           riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 36e7f10..fc1ae7c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -100,6 +100,7 @@ typedef struct riscv_cpu_profile {
>       bool present;
>       bool user_set;
>       int priv_spec;
> +    int debug_spec;
>       int satp_mode;
>       const int32_t ext_offsets[];
>   } RISCVCPUProfile;
> @@ -123,6 +124,16 @@ enum {
>       PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
>   };
>   
> +/* Debug specification version */
> +#define DEBUG_VER_0_13_0_STR "v0.13"
> +#define DEBUG_VER_1_00_0_STR "v1.0"
> +enum {
> +    DEBUG_VERSION_0_13_0 = 0,
> +    DEBUG_VERSION_1_00_0,
> +
> +    DEBUG_VERSION_LATEST = DEBUG_VERSION_1_00_0,
> +};
> +
>   #define VEXT_VERSION_1_00_0 0x00010000
>   #define VEXT_VER_1_00_0_STR "v1.0"
>   
> @@ -245,6 +256,7 @@ struct CPUArchState {
>   
>       target_ulong priv_ver;
>       target_ulong vext_ver;
> +    target_ulong debug_ver;
>   
>       /* RISCVMXL, but uint32_t for vmstate migration */
>       uint32_t misa_mxl;      /* current mxl */
> @@ -563,6 +575,7 @@ typedef struct RISCVCPUDef {
>       uint32_t misa_ext;
>       int priv_spec;
>       int32_t vext_spec;
> +    int debug_spec;
>       RISCVCPUConfig cfg;
>       bool bare;
>       const RISCVCSR *custom_csrs;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 18d790a..8658f55 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -427,8 +427,8 @@ static const VMStateDescription vmstate_sstc = {
>   
>   const VMStateDescription vmstate_riscv_cpu = {
>       .name = "cpu",
> -    .version_id = 10,
> -    .minimum_version_id = 10,
> +    .version_id = 11,
> +    .minimum_version_id = 11,
>       .post_load = riscv_cpu_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -443,6 +443,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
>           VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
>           VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> +        VMSTATE_UINTTL(env.debug_ver, RISCVCPU),
>           VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
>           VMSTATE_UINT32(env.misa_ext, RISCVCPU),
>           VMSTATE_UNUSED(4),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index d396825..160fcf1 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1598,6 +1598,9 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>       /* set vector version */
>       env->vext_ver = VEXT_VERSION_1_00_0;
>   
> +    /* Set debug version */
> +    env->debug_ver = DEBUG_VERSION_0_13_0;
> +
>       /* Zfinx is not compatible with F. Disable it */
>       isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);
>       isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);


