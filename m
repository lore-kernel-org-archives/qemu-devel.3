Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD62CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKlR-00012D-Fx; Mon, 15 Jun 2026 23:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKlL-00011a-KU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:46:56 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKlD-0001Qs-Kz
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:46:49 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6914a658115so5166594a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781581605; cv=none;
 d=google.com; s=arc-20240605;
 b=aI14PZxlslM453pWlLsbJh9lyPvUbJDI9g8R3BE3NZQqlXbGcIP79LJw3tZvHwKBJ5
 sSBDWdu4dslogkIpQi8MCa409zi+KirKPTY/AZwB4wTKB6VdR3czoO2KuaMbK54rH9qe
 gnlyOG1oFdHp2OeLg3MzraasZVGFNGC2Ounz8jlli9tyzrp/Ju6GGhGkfbI1K8ZWsmNN
 PkIZ5VgxqSAi1/WbPos+HS1HmUUlXz2SuHFbE5ltD1x7lhTkr01DObsR5vzzQJ5rRQUw
 +sE08M0xxjZQW7UU3Cm62vrJVV9ci05A84wXIJrpz48cIsJJdWDZiBBc3da/MVgN+MA9
 86ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=50TdmGslnRDhSWpr5PWbameAefXpuq2Lq7FlTskW8oA=;
 fh=ss/HGO4RwpwHFtzwgPsbC23QsemYg8f9BjqPHLpkgZI=;
 b=V1n4ZPraEqwzI+HgYOnLZPROFoHmN29yL6LiHoMRsWvsH8zEBtyqgwCum+sBHgHX3g
 07E3fLqzNkxbttEWfEzkBPMZJ+EJkvc4S4Wmzas57xcjgF99c0deW99xVG3VNbQG+hMR
 DhJlUdBqpZdulo7RMREuerqPxz5TwGtsN4SiL8wrnARUqL9+H9AoNHh3Crq4p5T057hT
 CvezqbTrBmtOEwdqsMTuQZcNT9nIF9qM4jmybsQ1xnVSEWxTlApismGXMnsRZ24bMIRs
 qYru24/QHW8AGvhKXI8DSAbMGTs+QkWQQjKH4Rt1D9JrY+DpwA7i5ZtJZeeMnV8q3i+B
 kS+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781581605; x=1782186405; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50TdmGslnRDhSWpr5PWbameAefXpuq2Lq7FlTskW8oA=;
 b=bfrjYQj19KS/5hXSEmld28M5qpLwEwf1DUZzFrP6WTAsEg33zJgRw6OIYGTcAf3AC8
 TjSMal0Q7I7iycFFrU13hQcbWUAmT/ljRoPEhyUfGchKFj49X0rdmqI/s1sIjAU+dmU8
 P3kvvtUkVtxSuasvbkIL+Q67vMSMtnaBk0v1rJDZHb/bHfcJmo8Di6WVwPACgQbxTk2X
 QFvkgaYmmw7fU5SDQKmrlBY7Tb+yWVM3Pfa8r07jrKrDrinQd+WjLKovpM3dCTQ4roWy
 f8Gcw2SZtvREXI0HIfrHA3ekE9gF0GcGbSPadTkyTx198kHy47KhRBtN7WwEmDS4lnot
 RLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781581605; x=1782186405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=50TdmGslnRDhSWpr5PWbameAefXpuq2Lq7FlTskW8oA=;
 b=U2jgyUhsfwmWjzf7CNIxYoABjXZLQoQ4pSHIdi0fWnDOGdcL0oDF8aMXXlA9YBSGzP
 mqMr6Fbsv2LkQJZAfwumC0Tz6L9oqWL7FC1b1K/RT7Nj7hrwDEdkLvNZv5zSqYm3uPKW
 pYrPjcLqZVjtn5EGgENLpTdAfBqyIluXjyTfqEb1ikEItO2OOYPbPEuvzcJE5cBA8wcW
 KEiKP4TEGOP3ytmAKLjiHWuUBxt+2eQ/2MZRYmIqbI8yaOvg02oxuYK4/HFrrEPnRTIH
 eZhnb3mWaZqSYumVNP2P4xh0kSwpjtEnjjcxDpZ9SrTAJ7/MHrYZvVkAEIgVAkUPNXBW
 q97g==
X-Gm-Message-State: AOJu0YzaOluYP4UE6Ql+npLGz5dWyyB6r+Wn33RVK+jxMgPc6M5zEA3z
 GycO0oboycTkGvkkZvmFvMn4CzbbS2i19MNaVdR0Ci220h+as45OC/UpvW4X20xyP8RDn6S/O0H
 bh6zfXVpLoWkp+pKrD99ZWkPfa8PI5y0kt1p4gYY=
X-Gm-Gg: Acq92OGXz0d5gqbYMxnssIbzt1tjU7NP5UEXXBfeRgcNHk8h280MJ8/rm3BlwsAI/Ff
 stZEaH1YZSwQTtWAqci/wJwOWo5Qls+bPyL4sj3WEiDzOGKunJHzFkJAMD2ZQBC1Fp9wx2AEHUW
 YMpkNcjWVwOx+ayxrMoka0N1RziaIOKOJHqIDKKwVFi9vqf0CjyfT1z6+datFa7Vi0CV2g9m44u
 1iM/ix6JnXf5kDgbVT2ZjmiTffCdf6ST/qFXP9cSAxA9S9AdrXWdtBgKThV9l2D4xhBHSfH0Ihv
 rQqI1g6X7mUdOMVmJ//KvtZbIoEJMlvGwF+sPA==
X-Received: by 2002:a05:6402:1ec5:b0:691:aeaf:42a7 with SMTP id
 4fb4d7f45d1cf-695086f24e0mr935488a12.10.1781581605401; Mon, 15 Jun 2026
 20:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
 <20260611123412.2135600-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260611123412.2135600-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:46:19 +1000
X-Gm-Features: AVVi8CclfttVgfJe659cZHioXj-08Ue6ChTvoKP_YtQwGdjzHEDBHCsmFbhJK2k
Message-ID: <CAKmqyKOVHsXggvoQxLh7M1shW-rtfLtt_m4uA9HrrOX_Sf2RiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv: dynamic alloc of debug trigger arrays
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 philmd@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Thu, Jun 11, 2026 at 10:35=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The debug trigger facility consists of a set of arrays: tdata1-3,
> cpu_breakpoint, cpu_watchpoint and itrigger_timer.  All of them are
> static allocated with RV_MAX_TRIGGERS (2).  This means that all RISC-V
> cpus will have 2 triggers per hart.
>
> The RISC-V Server Ref demands at least 11 triggers per hart, and several
> CPUs in the wild works with 4+ triggers.  We need more flexibility, ergo
> we need to parametrize the amount of triggers and make it configurable.
>
> Before doing that we need to handle a situation faced in a previous
> attempt [1].  We were unable to set the tdataN array length in
> vmstate_debug, meaning that we would always migrate RV_MAX_TRIGGERS
> regardless of the actual amount of triggers in play. To fix that we need
> to change the tdata arrays from static to dynamic, allowing us to use
> VMSTATE_VARRAY_UINT32().  This also means that, in contrast with [1], we
> have the opportunity to turn all trigger arrays into dynamic allocation
> and reduce the amount of stuff being carried by CPURISCVState, or in
> other words, we can carry just what we're using instead of a static max
> value.
>
> All the forementioned trigger facility arrays are now dynamic.  They are
> allocated and freed during realize/unrealize, and their size is
> expressed by env->num_triggers.  All relevant code is changed to use
> env->num_triggers instead of the RV_MAX_TRIGGERS to loop through each
> array.
>
> This will make it easier for the next patch to parametrize
> env->num_triggers.
>
> [1] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d=
45@oss.qualcomm.com/
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c     |  6 ++++++
>  target/riscv/cpu.h     | 18 +++++++++++------
>  target/riscv/csr.c     |  2 +-
>  target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
>  target/riscv/debug.h   |  1 +
>  target/riscv/machine.c | 16 ++++++++++-----
>  6 files changed, 69 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5b2133d811..b20271a220 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1015,7 +1015,13 @@ static void riscv_cpu_realize(DeviceState *dev, Er=
ror **errp)
>  static void riscv_cpu_unrealize(DeviceState *dev)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPU *cpu =3D RISCV_CPU(dev);
>
> +    if (cpu->cfg.debug) {
> +        riscv_trigger_unrealize(&cpu->env);
> +    }
> +#endif
>      mcc->parent_unrealize(dev);
>  }
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 11cd710990..ea92e2c68c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -467,12 +467,18 @@ struct CPUArchState {
>      /* trigger module */
>      uint16_t mcontext;
>      uint8_t trigger_cur;
> -    uint64_t tdata1[RV_MAX_TRIGGERS];
> -    uint64_t tdata2[RV_MAX_TRIGGERS];
> -    uint64_t tdata3[RV_MAX_TRIGGERS];
> -    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
> -    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
> -    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> +    /*
> +     * num_triggers is the length of tdata1, tdata2, tdata3,
> +     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
> +     * arrays.
> +     */
> +    uint32_t num_triggers;
> +    uint64_t *tdata1;
> +    uint64_t *tdata2;
> +    uint64_t *tdata3;
> +    struct CPUBreakpoint **cpu_breakpoint;
> +    struct CPUWatchpoint **cpu_watchpoint;
> +    QEMUTimer **itrigger_timer;
>      int64_t last_icount;
>      bool itrigger_enabled;
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ec931a8c3d..82afad82db 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5436,7 +5436,7 @@ static RISCVException read_tdata(CPURISCVState *env=
, int csrno,
>                                   target_ulong *val)
>  {
>      /* return 0 in tdata1 to end the trigger enumeration */
> -    if (env->trigger_cur >=3D RV_MAX_TRIGGERS && csrno =3D=3D CSR_TDATA1=
) {
> +    if (env->trigger_cur >=3D env->num_triggers && csrno =3D=3D CSR_TDAT=
A1) {
>          *val =3D 0;
>          return RISCV_EXCP_NONE;
>      }
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 30d39ee5cd..9a4910c431 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -172,7 +172,7 @@ target_ulong tselect_csr_read(CPURISCVState *env)
>
>  void tselect_csr_write(CPURISCVState *env, target_ulong val)
>  {
> -    if (val < RV_MAX_TRIGGERS) {
> +    if (val < env->num_triggers) {
>          env->trigger_cur =3D val;
>      }
>  }
> @@ -701,7 +701,7 @@ static bool check_itrigger_priv(CPURISCVState *env, i=
nt index)
>  bool riscv_itrigger_enabled(CPURISCVState *env)
>  {
>      int count;
> -    for (int i =3D 0; i < RV_MAX_TRIGGERS; i++) {
> +    for (int i =3D 0; i < env->num_triggers; i++) {
>          if (get_trigger_type(env, i) !=3D TRIGGER_TYPE_INST_CNT) {
>              continue;
>          }
> @@ -721,7 +721,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
>  void helper_itrigger_match(CPURISCVState *env)
>  {
>      int count;
> -    for (int i =3D 0; i < RV_MAX_TRIGGERS; i++) {
> +    for (int i =3D 0; i < env->num_triggers; i++) {
>          if (get_trigger_type(env, i) !=3D TRIGGER_TYPE_INST_CNT) {
>              continue;
>          }
> @@ -750,7 +750,7 @@ static void riscv_itrigger_update_count(CPURISCVState=
 *env)
>      int64_t last_icount =3D env->last_icount, current_icount;
>      current_icount =3D env->last_icount =3D icount_get_raw();
>
> -    for (int i =3D 0; i < RV_MAX_TRIGGERS; i++) {
> +    for (int i =3D 0; i < env->num_triggers; i++) {
>          if (get_trigger_type(env, i) !=3D TRIGGER_TYPE_INST_CNT) {
>              continue;
>          }
> @@ -950,7 +950,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>      int i;
>
>      QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
> -        for (i =3D 0; i < RV_MAX_TRIGGERS; i++) {
> +        for (i =3D 0; i < env->num_triggers; i++) {
>              trigger_type =3D get_trigger_type(env, i);
>
>              if (!trigger_common_match(env, trigger_type, i)) {
> @@ -996,7 +996,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, C=
PUWatchpoint *wp)
>      int flags;
>      int i;
>
> -    for (i =3D 0; i < RV_MAX_TRIGGERS; i++) {
> +    for (i =3D 0; i < env->num_triggers; i++) {
>          trigger_type =3D get_trigger_type(env, i);
>
>          if (!trigger_common_match(env, trigger_type, i)) {
> @@ -1049,19 +1049,49 @@ void riscv_trigger_realize(CPURISCVState *env)
>  {
>      int i;
>
> -    for (i =3D 0; i < RV_MAX_TRIGGERS; i++) {
> +    /*
> +     * Alloc env->tdata1/2/3, cpu_breakpoint, cpu_watchpoint and
> +     * itrigger_timer dynamically.  This is overkill now
> +     * given that they could be static arrays with RV_MAX_TRIGGERS
> +     * but we'll parametrize the trigger number later, i.e. the
> +     * array length won't be static.
> +     */
> +    env->num_triggers =3D RV_MAX_TRIGGERS;
> +    env->tdata1 =3D g_new0(uint64_t, env->num_triggers);
> +    env->tdata2 =3D g_new0(uint64_t, env->num_triggers);
> +    env->tdata3 =3D g_new0(uint64_t, env->num_triggers);
> +    env->cpu_breakpoint =3D g_new0(struct CPUBreakpoint *, env->num_trig=
gers);
> +    env->cpu_watchpoint =3D g_new0(struct CPUWatchpoint *, env->num_trig=
gers);
> +    env->itrigger_timer =3D g_new0(QEMUTimer *, env->num_triggers);
> +
> +    for (i =3D 0; i < env->num_triggers; i++) {
>          env->itrigger_timer[i] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                                riscv_itrigger_timer_cb, e=
nv);
>      }
>  }
>
> +void riscv_trigger_unrealize(CPURISCVState *env)
> +{
> +    g_free(env->tdata1);
> +    g_free(env->tdata2);
> +    g_free(env->tdata3);
> +
> +    g_free(env->cpu_breakpoint);
> +    g_free(env->cpu_watchpoint);
> +
> +    for (int i =3D 0; i < env->num_triggers; i++) {
> +        timer_del(env->itrigger_timer[i]);
> +    }
> +    g_free(env->itrigger_timer);
> +}
> +
>  void riscv_trigger_reset_hold(CPURISCVState *env)
>  {
>      target_ulong tdata1 =3D build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, =
0);
>      int i;
>
>      /* init to type 2 triggers */
> -    for (i =3D 0; i < RV_MAX_TRIGGERS; i++) {
> +    for (i =3D 0; i < env->num_triggers; i++) {
>          /*
>           * type =3D TRIGGER_TYPE_AD_MATCH
>           * dmode =3D 0 (both debug and M-mode can write tdata)
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index 55a3ac72e6..a25d099b37 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -148,6 +148,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
>  bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
>
>  void riscv_trigger_realize(CPURISCVState *env);
> +void riscv_trigger_unrealize(CPURISCVState *env);
>  void riscv_trigger_reset_hold(CPURISCVState *env);
>
>  bool riscv_itrigger_enabled(CPURISCVState *env);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 6e70b145a5..ba96ceceef 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -240,16 +240,22 @@ static int debug_post_load(void *opaque, int versio=
n_id)
>
>  static const VMStateDescription vmstate_debug =3D {
>      .name =3D "cpu/debug",
> -    .version_id =3D 3,
> -    .minimum_version_id =3D 3,
> +    .version_id =3D 4,
> +    .minimum_version_id =3D 4,
>      .needed =3D debug_needed,
>      .post_load =3D debug_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT16(env.mcontext, RISCVCPU),
>          VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
> -        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_VARRAY_UINT32(env.tdata1, RISCVCPU,
> +                              env.num_triggers, 0,
> +                              vmstate_info_uint64, uint64_t),
> +        VMSTATE_VARRAY_UINT32(env.tdata2, RISCVCPU,
> +                              env.num_triggers, 0,
> +                              vmstate_info_uint64, uint64_t),
> +        VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
> +                              env.num_triggers, 0,
> +                              vmstate_info_uint64, uint64_t),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> --
> 2.43.0
>
>

