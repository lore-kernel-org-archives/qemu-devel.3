Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D25CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 02:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSQIi-0001uS-0T; Wed, 27 May 2026 22:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wSQIf-0001uB-S9
 for qemu-devel@nongnu.org; Wed, 27 May 2026 22:16:46 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wSQId-0005WI-22
 for qemu-devel@nongnu.org; Wed, 27 May 2026 22:16:45 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd4f8260e4eso2181865066b.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 19:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779934601; cv=none;
 d=google.com; s=arc-20240605;
 b=LI45KX1xip4tl+wrx+H82eKjMp9n4OqF+b+gL7sgp0cL6rXgPBBCWprFKwg7FDv29n
 WxsYlvBp0l6cbKdp2Epkr/8Rx5WLxaCn2J57RLlXyaZjAz1e4PIzojCIe4KeS9IvrvSa
 LIdoTNxrs46JShca8Nr2uXu/SyS9GCMjK6jR0NpVtrXq5W8kJgzNsl7o6u/hwz4PPSWf
 m6duU7ODBfeiXVJfHnKVAMXkn6RfT4xh/a+o6yGI7+vT2QHN+GLF1AgxYBoaH4ardLXI
 JC5dDf3NW4YQ7KY8+w/WUqMuieMMRyDPl+Lmf2lNkqSgzYF7AViUQt4ltKrpdp3VsnDz
 6/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D+1jNgPoQ/8CqcBugYDb9rbTFG24edICrF01K/GTECM=;
 fh=PXPuV7OEAv9O71UZrR7IuLyyzvpqUNMv5bxK5fnkK7s=;
 b=JDUW5GpWn6IE7ZYnlBTk/jiSp2RMmvy2BQUc2uPrb+YOQq4lyL/xaftR/FCrMRGAY8
 yiBL1PMX0YoJrobWw57PtFtarfU7o8L3b6j2s+1iM0Ho+ihYiYqTLqe6l2k6HUA3z3zH
 bRyvtpaHJC6twAWwiSiZ3qXqkSERhz+UeePhD+iMOof9j54TKV+yvBZm8RnSxHK2EjqS
 gd9kjVMropj1QxwVyUrQTYizGCGzoxldYo1bsMlepJno4n/+2/DJR/brJEDWWNf2lFXe
 Kv9dhUz3koEu1IvFv9z6K/4h4LAqojjhQu2/OjPtSGx7j7gp04CrfDOl3fbnr5mL6jIX
 D/2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779934601; x=1780539401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+1jNgPoQ/8CqcBugYDb9rbTFG24edICrF01K/GTECM=;
 b=j3rCwx1/Ru1ZWyz4a6ctAP0b02r1vbr5V42yHliN3LY6bxKsdgHDYfsTgfK1hs+P0+
 jq1MISNtEkcDwGOaj8NKRdc0oqdTuSq0y68Zo8GPRmYvwYsXQXUeOFFPNLHy12dRD4Ok
 rJtnXgDJzQKCWupFgNptu+p7UP2+9yoASaH7dQ4CvwOUT2AUBb7MaMWi4BXcvvGYEy5P
 eyLK8rxG3Fy/lEcBpQF6m9GWFZ4OEDJ3eVBgtdjRbWaIfj9tUwuzKF+OSCFNjY6dtq4h
 lrXV9xnVfW6WFnJeyo08n0oHpuCGORkoADCR07vP9StI+684PmMJeYzyZZolcexd+dgY
 UZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779934601; x=1780539401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D+1jNgPoQ/8CqcBugYDb9rbTFG24edICrF01K/GTECM=;
 b=ZTvunq2ZKnXNC6CoRlgvp0kAtodxC1i/C1rg+M3+KXPA4YvxpitMEFLoV1VFhM4jN0
 6kbS/Nlfrg/+GPkoYQB0z1amFnqpCTRc4Q3LZ6K92hi4Df5JnUm36pOQajECiRZoMbAS
 sW5H444UYcI35SAW1qLJf6lVXB4PVRE4JqsS0vHQlxrl4mSRlHNQ3zkA37FWlVMlmTJ0
 vrX7rYCQ9oFE31jnjxMAxfKWi0zlOPcV3bgPfuttt5kuEtFQAP9OqYwMBY0JLtXOP3zZ
 j4OFX2HqzxLNAjWnA9P/i5u15NjSazI6dBUX5Jg5XzGXXLDWfQYF/MCuBi+HbwrhVt9c
 dDPQ==
X-Gm-Message-State: AOJu0Yzg0MNDsVhvfupFau3KH7mTs0SPl3ywIU3oaElPWes8UnxvdE2A
 wp2lM5JT7ghHuDVzYCJTxxk5gTdjzPKi6MXJ/80rsWcC7kIUdNCwd3divr6kEwR3NUjpf/KzZ1D
 EzTvDR7ZxhiPe5GpTz5iMPLq+Yk56qrg=
X-Gm-Gg: Acq92OFK8ogj5q4/+Wl37aDJqMcUwR8THvPCGzS3PMbFfTfrW8sUk7XvAZ5w+eyp/od
 WTFNwIMPbzL/EHlEYKuVJJzgHjIoJgn7KCHXgDhRvBv4aAvUJQsC67PKvdkbWqzNzN8/5NvCQ7s
 kFe0VpqbY3KWCOSB87pbEP+ZgIlvp6U+pL28BdkWFQG2wSqbrRdE8MyYwdgkxHixJC3NXL8Ty2s
 7FozqE4jdq09Q7giQdv56oddRuPy1YhyM0KT9sdY/uFsYz7hqGDqRhCgWsBo8jqfU9rpQCCbKl6
 P9hkULEN7tqfiWd54phg7rnlgzryaRnwwiLpcmwnT4e+RL/og33IovcFoDQ=
X-Received: by 2002:a17:907:1ca7:b0:ba6:8f34:b419 with SMTP id
 a640c23a62f3a-bdd23602369mr1607127766b.13.1779934600989; Wed, 27 May 2026
 19:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260527181822.1945644-1-daniel.barboza@oss.qualcomm.com>
 <20260527181822.1945644-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260527181822.1945644-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 May 2026 12:16:14 +1000
X-Gm-Features: AVHnY4IvdqRizTiIzadRmSD32qU-jXiODFzgACqj-x_lCHbLGx4-WL3qSLyb7S4
Message-ID: <CAKmqyKOM8AL_50vYv7mdU6Kt1-QGv2L784oxfvBXr40iu_9rkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv: deprecate 'debug' CPU property
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Thu, May 28, 2026 at 4:19=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
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
>
> [1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevo=
rn@gmail.com/
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  docs/about/deprecated.rst         |  6 ++++
>  target/riscv/cpu.c                | 50 ++++++++++++++++++++++++++++---
>  target/riscv/cpu_cfg_fields.h.inc |  2 +-
>  target/riscv/csr.c                |  2 +-
>  target/riscv/machine.c            | 24 +++++++--------
>  target/riscv/tcg/tcg-cpu.c        |  2 +-
>  6 files changed, 67 insertions(+), 19 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 97750f5edc..7014d706c1 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -417,6 +417,12 @@ ABI is long-obsolete. We are therefore deprecating b=
oth OABI support
>  and NWFPE emulation, and they will be removed in a future QEMU
>  release.
>
> +``debug=3Dtrue|false`` on RISC-V CPUs (since 11.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This option, since QEMU 10.1, has been a simple alias to the ``sdtrig``
> +extension. Users are advised to enable/disable ``sdtrig`` directly inste=
ad
> +of using ``debug``.

I think this should be explicit that we are deprecating support for
the ratified debug extension [1], not just the flag.

Anyone using the ratified spec will need to move to the new ratified
(but not backwards compatible) spec.

1: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote

Alistair

>
>  Backwards compatibility
>  -----------------------
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 862834b480..54e8f78a4d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -226,7 +226,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
>                                  has_priv_1_12),
>      ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
> @@ -807,7 +807,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTy=
pe type)
>      env->vill =3D true;
>
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_reset_hold(env);
>      }
>
> @@ -971,7 +971,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error=
 **errp)
>      riscv_cpu_register_gdb_regs_for_features(cs);
>
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_realize(&cpu->env);
>      }
>  #endif
> @@ -1150,6 +1150,14 @@ static void riscv_cpu_init(Object *obj)
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
> @@ -2514,8 +2522,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_r=
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
> index 5514e0f455..17992715ff 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -796,7 +796,7 @@ static RISCVException have_mseccfg(CPURISCVState *env=
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
> index 6776e7bf5a..4ca5c9c8d7 100644
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
> @@ -444,8 +444,8 @@ static const VMStateDescription vmstate_mseccfg =3D {
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
> @@ -511,7 +511,6 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_kvmtimer,
>  #endif
>          &vmstate_envcfg,
> -        &vmstate_debug,
>          &vmstate_smstateen,
>          &vmstate_jvt,
>          &vmstate_elp,
> @@ -519,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_ctr,
>          &vmstate_sstc,
>          &vmstate_mseccfg,
> +        &vmstate_sdtrig,
>          NULL
>      }
>  };
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 3e22e7ed53..a6dd864264 100644
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
> 2.43.0
>
>

