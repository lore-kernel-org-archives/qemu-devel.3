Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C318CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 04:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTttf-0001ju-0e; Mon, 01 Jun 2026 00:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wTttd-0001jL-FF
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 00:05:01 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wTttZ-0005H0-Vf
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 00:05:00 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-304d7f31215so3540900eec.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 21:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780286695; x=1780891495; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KwHe78JFZTLkHtRpzg9EXfast0UYxFZ4bqnWbkv/tD8=;
 b=JihbZoGawa+m4U3WO8mxTu/GiZXPUteBayXybqewFUo9p3Lq9Gj1VuEDhAzJOjH3Ks
 3tSax41CP9QZxrpAV35wQUnwPH4QKGATBq7LrmZXuNbDcduDDTOdQs2juY2CdlsjYTH3
 G9oe0k2qAXnKciRdWCmAeuWnVC07ZvOZ4OsEKbBbOK50mkqHc7E6ERBb8pI9aOGzgaMx
 vj4Axu4efpE3eyCd+SoIw+n6uBherBkI7Ss4RDRokfRlEpIJJO0pghWaSagx67o3XJ1g
 CNr+zcrVnIhfvxPKQRY9g4ORqsJs3IlOFTJqS6BC1MOOLAznSi8ULKoXLubV8xFUSzIe
 p8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780286695; x=1780891495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwHe78JFZTLkHtRpzg9EXfast0UYxFZ4bqnWbkv/tD8=;
 b=mtyGG3uXTxONHsN1bw9WCBrlpomsyerjk5kwnPxde7A6y2lPW6qB/gzDhZmqIN41hN
 83CP+1bDz0M8Pp1ce/cPBNIvy42Bi3DPHzxtDXcs/BEBmqyPOBUHGlY1RYbfdnrWyO0x
 V8lF4dwy3b/PsZTzFVpUjxqBDaKJFKaM7jW9DLodiqn1rhABrD9959Q/HEbyNxnKF1N8
 WGyiiq2WhIZp5DqVvSdwafIpTmpzwSA7X+8w5wuu2HQFDAfVGQuWDP3hWpsOjBMc44f3
 nX4B/8XzJe2EazOhV1KsE3HLadsV31cLFkUDgErntS2w9ORgYco4ZLFc3bxZmCfg1sZj
 GfZQ==
X-Gm-Message-State: AOJu0YwLCKrgSwZ6Q0WQoLWY2fmtWfMtZ0zW7GTDG7jVTJfYThhyUSY/
 1tPKDQfv+6AcNHhs7aGeCrK13heeXyzZS0Cb/1s/LoGklTOoJG/bK4MO
X-Gm-Gg: Acq92OEsVobRiQ+I2/KUp4kxlgRCaJ7ibYq2HP2jVQpiY44N+TQxOQTGizJnI+O9Vbt
 WDNXrshYknw/hnatsoROPL1Dl7tjCLMEgVzpMtM27gPP+QIGZgV6Qj3ykh4noZsi5+8ajA9OWIB
 CCNOXGWBg30gQlJWGlwrtQHhV03iSbgbt4L6qnGlG0OgqO4hblmAe3CLtikwJ0az3ih3SVIxij3
 AccP4/BkW19EksK6OQT/VqREFEDHP84MRjKSpTN95tbMTDisw6R6j1UUVxnc7PcoOC+h1ULbpxM
 f2+YhmtVr0FK+Ki+DIlhHq38YeIjzLi4WvmWsuVLRRKSm2/O9uHMyzdO7Mg5tCvwApy6eVP+Igh
 TB5awJ+OwubfHUpFUsGDV9O2Lg+PXJT9QddUIQsBn69IHgLOU5IuEhtiOSEJ2gS22fHDF1zrqfS
 s8/+a2FQapVFwoIyhRP+58XkL9zuwm0q2nwwtGNIxBwN1vRuqPMzbg/u1FatD/CVWUdJT38w==
X-Received: by 2002:a05:7300:e7ab:b0:304:54d6:20f3 with SMTP id
 5a478bee46e88-304fa4b716dmr3738330eec.4.1780286694949; 
 Sun, 31 May 2026 21:04:54 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed130dafsm7597861eec.0.2026.05.31.21.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 21:04:54 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:04:52 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [PATCH v3 1/1] target/riscv: deprecate 'debug' CPU property and
 Debug 0.13
Message-ID: <ahz7-1OomsZTMIz2@ChaodeMacBook-Pro.local>
References: <20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com>
 <20260528131214.2251075-2-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528131214.2251075-2-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Daniel,

On Thu, May 28, 2026 at 10:12:14AM +0800, Daniel Henrique Barboza wrote:
> Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
> riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig' that
> is, for now, compliant with Debug 0.13 that was ratified 8 years go.
> 
> We're going to add more debug trigger extensions, e.g. 'sdext' [1].
> Thing is that 'sdext' and all other extensions that will follow are now
> adherent to Debug 1.0, ratified Dec 2022.  And so it happens that Debug
> 1.0 and 0.13 are not compatible with each other.  This makes support new
> Debug 1.0 extensions like 'sdext' harder because we would need two
> independent code bases for each.
> 
> We consider that most of the RVI ecosystem already moved on to Debug
> 1.0 and is now going towards the extended Debug 1.0 extensions, and we
> should follow suit.  And the best way to do that is to leave Debug 0.13
> behind, by deprecating its 'debug' flag and making it an alias for
> 'sdtrig' that will eventually move on to Debug 1.0.
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
> Finally, deprecated.rst was updated to deprecate 'debug' and inform that
> it will be now interpreted as an alias of 'sdtrig', which is now going
> to be compliant with Debug 1.0.
> 

This patch conflicts with Alistair's riscv-to-apply.next branch.

f71708fedf target/riscv/tcg: disable svnapot if satp_mode < sv39

```
   <<<<<<< HEAD
   static const VMStateDescription vmstate_debug = {
       .name = "cpu/debug",
       .version_id = 3,
       .minimum_version_id = 3,
       .needed = debug_needed,
       .post_load = debug_post_load,
   =======
   static const VMStateDescription vmstate_sdtrig = {
       .name = "cpu/sdtrig",
       .version_id = 1,
       .minimum_version_id = 1,
       .needed = sdtrig_needed,
       .post_load = sdtrig_post_load,
   >>>>>>> target/riscv: deprecate 'debug' CPU property and Debug 0.13
```

You probably need to rebase onto and fix it.

Thanks,
Chao

> [1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  docs/about/deprecated.rst         | 19 ++++++++++++
>  target/riscv/cpu.c                | 50 ++++++++++++++++++++++++++++---
>  target/riscv/cpu_cfg_fields.h.inc |  2 +-
>  target/riscv/csr.c                |  2 +-
>  target/riscv/machine.c            | 24 +++++++--------
>  target/riscv/tcg/tcg-cpu.c        |  2 +-
>  6 files changed, 80 insertions(+), 19 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 97750f5edc..bc872e50ba 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -417,6 +417,25 @@ ABI is long-obsolete. We are therefore deprecating both OABI support
>  and NWFPE emulation, and they will be removed in a future QEMU
>  release.
>  
> +``debug=true|false`` on RISC-V CPUs (since 11.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +When first introduced this flag enabled/disabled support for the RISC-V
> +Debug spec version 0.13.  Then, since QEMU 10.1, it became instead an
> +alias to the ``sdtrig`` extension that still adheres to Debug 0.13.
> +
> +We're moving to the new ratified 1.0 Debug spec that will be maintained
> +long term by RISC-V International, but this new ratified version is not
> +backward compatible with 0.13.  This means that keeping both implementations
> +is a maintainership hurdle that impacts the development of new Debug 1.0
> +extensions like ``sdext``.  And most of the RISC-V ecosystem already
> +moved on to Debug 1.0.
> +
> +For all these reasons, starting on 11.1, QEMU is moving away from Debug
> +0.13 by deprecating the ``debug`` flag.  Setting it, from now on, will be
> +be the same as setting ``sdtrig`` version 1.0.  Users that are still using
> +Debug 0.13 will need to update their software to use Debug 1.0 or use QEMU
> +11.0 and older.
>  
>  Backwards compatibility
>  -----------------------
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 862834b480..54e8f78a4d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -226,7 +226,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
>                                  has_priv_1_12),
>      ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
> @@ -807,7 +807,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>      env->vill = true;
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_reset_hold(env);
>      }
>  
> @@ -971,7 +971,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      riscv_cpu_register_gdb_regs_for_features(cs);
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_realize(&cpu->env);
>      }
>  #endif
> @@ -1150,6 +1150,14 @@ static void riscv_cpu_init(Object *obj)
>      cpu->env.vext_ver = VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode = -1;
>  
> +    /*
> +     * 'debug' started being deprecated in 11.0, been just a proxy
> +     * to set ext_sdtrig ever since. It has been enabled by default
> +     * for a long time though, so we're stuck with setting set 'strig'
> +     * by default too. At least for now ...
> +     */
> +    cpu->cfg.ext_sdtrig = true;
> +
>      if (mcc->def->profile) {
>          mcc->def->profile->enabled = true;
>      }
> @@ -2514,8 +2522,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      NULL
>  };
>  
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static void prop_debug_get(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    bool value = RISCV_CPU(obj)->cfg.ext_sdtrig;
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
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    bool value;
> +
> +    visit_type_bool(v, name, &value, errp);
> +    cpu->cfg.ext_sdtrig = value;
> +}
> +
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static const PropertyInfo prop_debug = {
> +    .type = "bool",
> +    .description = "DEPRECATED: use 'sdtrig' instead.",
> +    .get = prop_debug_get,
> +    .set = prop_debug_set,
> +};
> +
>  static const Property riscv_cpu_properties[] = {
> -    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    {.name = "debug", .info = &prop_debug},
>  
>      {.name = "pmu-mask", .info = &prop_pmu_mask},
>      {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
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
> @@ -796,7 +796,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
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
> @@ -218,14 +218,14 @@ static const VMStateDescription vmstate_kvmtimer = {
>  };
>  #endif
>  
> -static bool debug_needed(void *opaque)
> +static bool sdtrig_needed(void *opaque)
>  {
>      RISCVCPU *cpu = opaque;
>  
> -    return cpu->cfg.debug;
> +    return cpu->cfg.ext_sdtrig;
>  }
>  
> -static int debug_post_load(void *opaque, int version_id)
> +static int sdtrig_post_load(void *opaque, int version_id)
>  {
>      RISCVCPU *cpu = opaque;
>      CPURISCVState *env = &cpu->env;
> @@ -237,12 +237,12 @@ static int debug_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> -static const VMStateDescription vmstate_debug = {
> -    .name = "cpu/debug",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .needed = debug_needed,
> -    .post_load = debug_post_load,
> +static const VMStateDescription vmstate_sdtrig = {
> +    .name = "cpu/sdtrig",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = sdtrig_needed,
> +    .post_load = sdtrig_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
>          VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> @@ -444,8 +444,8 @@ static const VMStateDescription vmstate_mseccfg = {
>  
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
> -    .version_id = 11,
> -    .minimum_version_id = 11,
> +    .version_id = 12,
> +    .minimum_version_id = 12,
>      .post_load = riscv_cpu_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -511,7 +511,6 @@ const VMStateDescription vmstate_riscv_cpu = {
>          &vmstate_kvmtimer,
>  #endif
>          &vmstate_envcfg,
> -        &vmstate_debug,
>          &vmstate_smstateen,
>          &vmstate_jvt,
>          &vmstate_elp,
> @@ -519,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
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
> @@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>               ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>      }
>  
> -    if (cpu->cfg.debug && !icount_enabled()) {
> +    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
>          flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>      }
>  #endif
> -- 
> 2.43.0
> 

