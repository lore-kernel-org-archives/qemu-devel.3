Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2600F433D8
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 02:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDCXV-0004D8-21; Wed, 15 Apr 2026 22:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDCXS-0004Cf-HT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:33:06 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDCXP-0000RH-6S
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:33:06 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b941762394aso921289166b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 19:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776306781; cv=none;
 d=google.com; s=arc-20240605;
 b=OBwfhIF8IrnZpXz6LDvOwKvVB1tHfO5OGl48ozoAYhva5agCf+M0Tm10U60GMQmBvp
 1fKPLURsYEtCvRUhGQYWDUKxZHm7anxTZnQS6rPTjZZPPJ+qE0spj7Jl1hNGDB4dejlC
 Wz7y+odDegXsTcZXLWHWTdc9/TMvmRj+cBuS1jkL39jc46DoDOEu7HGJM0Jl5FYp2Rp6
 QRjV1uwZzu1wPKJJ39tn7hlBKRDUMDlDLQYi5Kvqy69QQXq5JoZj/BIhxdH6dvdNPT4k
 kjzBjmHo1xI8HnT6IAU7vees7vOdkAuk7uv4N+WhBraKsiFyjjX1JOql4JxsUpzTg5Pc
 Y0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hNeUL0RRyCaBcNDAZIwEJh7cy8Vc9WwMDFsxs/QKlFQ=;
 fh=l/37B2l1stgEcQyDKNmQGNelwDlJwHAxv51WLQBJRDY=;
 b=TaCjiMlpQcjzz2a4t7L/X9zhhJyxpyDRPnEUCeCId7cZ/1JA4bdz1qXHHi+j98BmpX
 alA4/sjmFySsMJWZB67G7+GidAMEY++2pVqgrDxxoAwLv/IoV8QYrFI6GQyKATi6tEhw
 YbtRH819zqlxIiuXYc0mRCBFKQH98haQrPVvzJbDJ4iOpPo6t3vGiPPcXAMdxKSTX5zn
 yFrAi6OFffQWVywbH1AX3GiMqAEinzxpIzYUIZ0EgWqJSlN5Sz2p9Z7KrNnYvPikZJTJ
 4HDy15kXu76Gj57t+rwlp8Bac9p/wM5egJ3Iz96+QjKKERf0OJmydZwrQ3tbZKZvxOr8
 HrNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776306781; x=1776911581; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNeUL0RRyCaBcNDAZIwEJh7cy8Vc9WwMDFsxs/QKlFQ=;
 b=eoM+M3MjNPNXHuZhmzs0LmsedakPr/Ipa4AxP9im0Dojh+RGcB3dxnIh5eseEhAa+Y
 k4S0gvNojPdaq1qEUrXFwAaQewiXIbWa+U6lulQn4B1Xd72AFaw6dAxnYyW5wEeprxj+
 84hgBl42GDIsGzuOODwdQzj60D/26UsHCih7M9NmVrjZk1LEV0BD6IAmh5wdfaBR2PBm
 sjgSATSOY4ZMlfg5Rf1P251DfFwpl+9dCVURd3p2lkSR/LCnVXK4j2blTq/QSzDPWrUB
 BblXvtTCCzkXA8p5kwyNlkMOwclGdqUT0vvN6nRIk05yDo5+4TyxYpR9zqtoQt/0m2Ch
 nJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776306781; x=1776911581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hNeUL0RRyCaBcNDAZIwEJh7cy8Vc9WwMDFsxs/QKlFQ=;
 b=RegedUdBt9F3JkPgtpB9rdqAp43Dfju3YX2178e4KM0gAfxvw4P1PfP2iIEdrjzfLR
 1Whbfh3AzNK169G9poyoQnKbtW4DvJBwB/xrSTCm7Eupf/O95MqltDplKI3a2z+BGEUT
 XqjOu4Mwayy49XLp4Kkm56KaAqQ2Rzc1UTk/eufiY1wzlLqI8iYVLRLISZUStnw0mfk4
 vunh4Q38PG/ELuK/nW6DNR8a/iKlgS08Hi439YSlmM2pxGP7zlaSVRIF4OR6c6LRw32v
 MPwXCrP7TprNVwjanfNSMBJDg9cCz96TsMefwERf6daoCnNyMCwMZJYiflDcV67kLdAx
 oVuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qCmXHdUSiwEGWJ0G4j79SWltZBG2EsrhCGp9Te5CtfrMx/pay+mJKnXSM1D19rk/XcmICehJ0Fhwd@nongnu.org
X-Gm-Message-State: AOJu0Yyq085XLefP3dxTtm+bXApTchL4xSZR7lIewv2r+HpyS/0ymPKL
 NAxg+PLZuzAnn6sdpyDpDwr4VpZvY4sWoIzNoQgjZ4e6O7Ip9quo0aTXVrzFsU2lEwkT3vnkmAt
 cxygX+YmyWUxTJjKjBMRYaXJ1yECUaCM=
X-Gm-Gg: AeBDievzN+2qagVkom5sKG/cktN+TCJVfRan+M04bOEcbJn4XDTAYpVXcrpRY+Z+B2i
 ycYscreZX6MX0fxyfzjg/zDFTVrFfMrsRpP+sovVOhfnLfEaNOeVGV+ageuM8HCYawwCJ3nGijs
 YVP2H0H2EqOBHcZFank2OYDXdvjxIplUVGD2e9/IlcBvtXJ2ONQiWh/ieevMmg9SglkRoY4CyCS
 b2nSy6jk4r+RWTmZp11AdYgibc0/+0TmCkd+TL26+gRQ9zMcBDCHcn5MHk6ZavJUdoxjLo2Xc9S
 5fBKa6eviphVfH5ZkNg4jEEaz/smSl95/FB89w==
X-Received: by 2002:a17:907:c0f:b0:ba2:e190:efd7 with SMTP id
 a640c23a62f3a-ba2e190f0e3mr16232366b.49.1776306780288; Wed, 15 Apr 2026
 19:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
 <99f0437cbb0169ffa318af4864ee48af22abeb17.1775959096.git.chao.liu.zevorn@gmail.com>
In-Reply-To: <99f0437cbb0169ffa318af4864ee48af22abeb17.1775959096.git.chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 12:32:32 +1000
X-Gm-Features: AQROBzD2-ADLNKyHe_BlMfFbpEY8bMjP5I3xyzCHHBBR_xpqU-KC-yPv4Ubi6nA
Message-ID: <CAKmqyKOMC-kvrxOMYx33m1W7zi1JY8gJoX-oRLDQo4pFRAyhfQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] target/riscv: deprecate 'debug' CPU property
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Apr 12, 2026 at 12:22=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.co=
m> wrote:
>
> From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>
> Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
> riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig'.
>
> We're going to add more debug trigger extensions, e.g. 'sdext' [1].  And
> all of a sudden the existence of this flag is now weird. Do we keep it
> as a 'sdtrig' only or do we add 'sdext'?
>
> The solution proposed here is to deprecate it. The flag was introduced a
> long time ago as a way to encapsulate support for all debug related
> CSRs.  Today we have specific debug trigger extensions and there's no

The flag was originally introduced to support the original debug spec:
https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote

There was no sdtrig back then, so debug was used.

> more use for a generic 'debug' flag. Users should be encouraged to
> enable/disable extensions directly instead of using "made-up" flags that
> exists only in a QEMU context.
>
> The following changes are made:
>
> - 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
>   cpu->cfg;
> - All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
> - Two explicit getters and setters for the 'debug' property were added.
>   The property will simply get/set ext_sdtrig;
> - vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
>   will impact migration between QEMU 10.2 to newer versions, but we're
>   still in a point where the migration break cost isn't big enough to
>   justify adding migration compatibility scaffolding.
>
> Finally, deprecated.rst was updated to deprecate 'debug' and encourage
> users to use 'ext_sdtrig' instead.

The problem (and this is always a problem with the debug spec) is
there are now two ratified versions and no easy way to support both.

AFAIK most hardware supports version 0.13, although at some point
(which might have already happened) that will no longer be true as
everyone updates to the latest version.

Generally QEMU tries to support all ratified specs, so we are
reluctant to remove 0.13. We might have to bite the bullet one day,
but ideally that would happen when 1.0 is much more commonly used then
0.13.

So, the question is. Do we actually want to depreciate 0.13?

Alistair

>
> [1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevo=
rn@gmail.com/
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  docs/about/deprecated.rst         |  7 +++++
>  target/riscv/cpu.c                | 51 ++++++++++++++++++++++++++++---
>  target/riscv/cpu_cfg_fields.h.inc |  2 +-
>  target/riscv/csr.c                |  2 +-
>  target/riscv/machine.c            | 24 +++++++--------
>  target/riscv/tcg/tcg-cpu.c        |  2 +-
>  6 files changed, 69 insertions(+), 19 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index a6d6a71326..cba050334b 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -452,6 +452,13 @@ It was implemented as a no-op instruction in TCG up =
to QEMU 9.0, but
>  only with ``-cpu max`` (which does not guarantee migration compatibility
>  across versions).
>
> +``debug=3Dtrue|false`` on RISC-V CPUs (since 11.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This option, since QEMU 10.1, has been a simple alias to the ``sdtrig``
> +extension. Users are advised to enable/disable ``sdtrig`` directly inste=
ad
> +of using ``debug``.
> +
>  Backwards compatibility
>  -----------------------
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 38286b6b40..6208201538 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -210,7 +210,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>      ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -783,7 +783,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTy=
pe type)
>      env->vill =3D true;
>
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_reset_hold(env);
>      }
>
> @@ -947,7 +947,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error=
 **errp)
>      riscv_cpu_register_gdb_regs_for_features(cs);
>
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_realize(&cpu->env);
>      }
>  #endif
> @@ -1126,6 +1126,14 @@ static void riscv_cpu_init(Object *obj)
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
>
> +    /*
> +     * 'debug' started being deprecated in 11.0, been just a proxy
> +     * to set ext_sdtrig ever since. It has been enabled by default
> +     * for a long time though, so we're stuck with setting set 'strig'
> +     * by default too. At least for now ...
> +     */
> +    cpu->cfg.ext_sdtrig =3D true;
> +
>      if (mcc->def->profile) {
>          mcc->def->profile->enabled =3D true;
>      }
> @@ -1240,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>      MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>      MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> +    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
>      MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
>      MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> @@ -2654,8 +2663,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_r=
ules[] =3D {
>      NULL
>  };
>
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static void prop_debug_get(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    bool value =3D RISCV_CPU(obj)->cfg.ext_sdtrig;
> +
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static void prop_debug_set(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +    bool value;
> +
> +    visit_type_bool(v, name, &value, errp);
> +    cpu->cfg.ext_sdtrig =3D value;
> +}
> +
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static const PropertyInfo prop_debug =3D {
> +    .type =3D "bool",
> +    .description =3D "DEPRECATED: use 'sdtrig' instead.",
> +    .get =3D prop_debug_get,
> +    .set =3D prop_debug_set,
> +};
> +
>  static const Property riscv_cpu_properties[] =3D {
> -    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    {.name =3D "debug", .info =3D &prop_debug},
>
>      {.name =3D "pmu-mask", .info =3D &prop_pmu_mask},
>      {.name =3D "pmu-num", .info =3D &prop_pmu_num}, /* Deprecated */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 734fa079f2..44235bfaa1 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
>  BOOL_FIELD(ext_zimop)
>  BOOL_FIELD(ext_zcmop)
>  BOOL_FIELD(ext_ztso)
> +BOOL_FIELD(ext_sdtrig)
>  BOOL_FIELD(ext_smstateen)
>  BOOL_FIELD(ext_sstc)
>  BOOL_FIELD(ext_smcdeleg)
> @@ -159,7 +160,6 @@ BOOL_FIELD(ext_xlrbr)
>
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
> -BOOL_FIELD(debug)
>  BOOL_FIELD(misa_w)
>
>  BOOL_FIELD(short_isa_string)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index cfd076b368..93b4864933 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -776,7 +776,7 @@ static RISCVException have_mseccfg(CPURISCVState *env=
, int csrno)
>
>  static RISCVException debug(CPURISCVState *env, int csrno)
>  {
> -    if (riscv_cpu_cfg(env)->debug) {
> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
>          return RISCV_EXCP_NONE;
>      }
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a879..62c51c8033 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -218,14 +218,14 @@ static const VMStateDescription vmstate_kvmtimer =
=3D {
>  };
>  #endif
>
> -static bool debug_needed(void *opaque)
> +static bool sdtrig_needed(void *opaque)
>  {
>      RISCVCPU *cpu =3D opaque;
>
> -    return cpu->cfg.debug;
> +    return cpu->cfg.ext_sdtrig;
>  }
>
> -static int debug_post_load(void *opaque, int version_id)
> +static int sdtrig_post_load(void *opaque, int version_id)
>  {
>      RISCVCPU *cpu =3D opaque;
>      CPURISCVState *env =3D &cpu->env;
> @@ -237,12 +237,12 @@ static int debug_post_load(void *opaque, int versio=
n_id)
>      return 0;
>  }
>
> -static const VMStateDescription vmstate_debug =3D {
> -    .name =3D "cpu/debug",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> -    .needed =3D debug_needed,
> -    .post_load =3D debug_post_load,
> +static const VMStateDescription vmstate_sdtrig =3D {
> +    .name =3D "cpu/sdtrig",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D sdtrig_needed,
> +    .post_load =3D sdtrig_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
>          VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> @@ -425,8 +425,8 @@ static const VMStateDescription vmstate_sstc =3D {
>
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 11,
> -    .minimum_version_id =3D 11,
> +    .version_id =3D 12,
> +    .minimum_version_id =3D 12,
>      .post_load =3D riscv_cpu_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -492,13 +492,13 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_kvmtimer,
>  #endif
>          &vmstate_envcfg,
> -        &vmstate_debug,
>          &vmstate_smstateen,
>          &vmstate_jvt,
>          &vmstate_elp,
>          &vmstate_ssp,
>          &vmstate_ctr,
>          &vmstate_sstc,
> +        &vmstate_sdtrig,
>          NULL
>      }
>  };
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f3f7808895..0613450691 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
>               ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>      }
>
> -    if (cpu->cfg.debug && !icount_enabled()) {
> +    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
>          flags =3D FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_en=
abled);
>      }
>  #endif
> --
> 2.53.0
>
>

